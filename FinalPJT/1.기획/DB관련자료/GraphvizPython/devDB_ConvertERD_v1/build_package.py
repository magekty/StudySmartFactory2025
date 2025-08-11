# build_package.py
# 목적: v1 상세 설계 패키지(버전 B)를 한 번에 생성하여 zip으로 압축
# 사용: python build_package.py  → GlobalMedMES_v0.2-detailed.zip 생성
# 요구: Python 3.9+, 표준 라이브러리만 사용

import os, zipfile, re
from datetime import datetime, timezone

PKG_NAME = "GlobalMedMES_v0.2-detailed"
NOW = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%S UTC")

# ---------- 문서 콘텐츠 ----------
USE_CASES = f"""# UseCases_v1 (v1 버전 B, 상세)

## UC-01 로그인/메뉴 권한
- Actor: 사용자(ROLE_OP/QA/ADMIN)
- Trigger: 로그인 화면에서 ID/비밀번호 입력
- Pre: 계정 is_active=1, locked_until 과거
- Main:
  1) /auth/login에 자격 제출 → 서버 검증(비번 해시 비교)
  2) JWT(Access 30m) + 세션(2h) 발급, 실패 카운트 리셋
  3) /menus/my로 권한 기반 메뉴 트리 로드
  4) 네비게이션 렌더 및 대시보드 이동
  5) 감사로그 AUTH_LOGIN 기록
- Alt:
  - 비번 오류: 401 + 실패 카운트+1(정책 임계 도달 시 locked_until 설정)
- Post: traceId 포함 표준 로그 기록

## UC-02 작업지시 발행/조회/상태(P→R→C)
- Actor: 작업자(ROLE_OP), 관리자(ROLE_ADMIN)
- Trigger: "지시 생성" 클릭
- Pre: ITEM/PROCESS/EQUIPMENT 존재, WO 번호 중복 없음
- Main(발행):
  1) itemId/processId/equipmentId/orderQty 입력
  2) 검증(orderQty≥0, FK 존재)
  3) TB_WORK_ORDER insert(status=P)
  4) 목록/상세 갱신
  5) 감사로그 WO_CREATE
- Main(상태변경):
  1) 상세→ "R" 또는 "C" 선택
  2) 전이표 검증(P→R, R→C만 허용)
  3) 상태 갱신 및 감사로그 WO_STATUS_CHANGE
- Alt:
  - 전이 위반: 400 WO_STATUS_INVALID
- Post: WO 상태/감사 일치

## UC-03 설비 상태 RUN 등록(교대 표시)
- Actor: 작업자(ROLE_OP)
- Trigger: "RUN 시작" 버튼
- Pre: 교대 캘린더(설비 or 작업장) 존재, XOR 충족
- Main:
  1) equipmentId, startTimeUtc 제출
  2) TB_EQUIPMENT_STATUS_LOG insert(status=RUN)
  3) 교대 뱃지 표시 및 최근 상태 카드 갱신
  4) 감사로그 EQP_STATUS_CREATE
- Alt:
  - 시간 역전 요청(end<start): 400 TIME_ORDER_INVALID
- Post: 설비×시간 인덱스 경로로 즉시 조회 가능

## UC-04 실적 등록(양품/불량, 시간)
- Actor: 작업자(ROLE_OP)
- Trigger: "실적 등록" 버튼
- Pre: 대상 WO 상태=R
- Main:
  1) produced/defect/start/end 입력
  2) 검증(defect≤produced, end≥start, FK 존재)
  3) PERF insert → 같은 Tx로 WO 누적 생산/불량 갱신
  4) 토스트/상세 반영
  5) 감사로그 PERF_CREATE
- Alt:
  - 검증 실패: 400 VALIDATION_ERROR/TIME_ORDER_INVALID
- Post: KPI 집계에 즉시 반영 가능

## UC-05 KPI(목표 vs 생산량·수율) 확인
- Actor: OP/QA/ADMIN
- Trigger: KPI 보드 진입
- Pre: KPI_TARGET 존재
- Main:
  1) kpiDate, equipmentId 필터
  2) 목표/실적 집계 조회
  3) 카드 3종(목표·실제 생산량/수율) + 색상 규칙 적용(초록/노랑/빨강)
- Alt:
  - 데이터 없음: 빈 상태 UI
- Post: EXPLAIN range 확인, SLA<500ms 충족
(Generated: {NOW})
"""

STATE_MACHINE = """# StateMachine (작업지시/설비 상태)

## 작업지시 상태 전이
| From | To | 허용 | 규칙 |
|---|---|---|---|
| P | R | 예 | 최초 시작 시 |
| R | C | 예 | 누적 생산>0 권장(옵션) |
| C | R/P | 아니오 | WO_STATUS_INVALID |

- 위반 시: 400 WO_STATUS_INVALID
- 권한: ROLE_OP+

## 설비 상태 이벤트 규칙
- 상태코드: RUN/IDLE/DOWN
- 시간: start_time ≤ end_time(null 허용)
- 교대: XOR(설비 또는 작업장) + 부분 유니크(중복 차단)
- 겹침: 허용(시뮬/현장 차이); 린트에서 겹침 탐지 보고
"""

API_VALIDATION = """# API_Validation_v1 (엔드포인트별 검증/오류/성능)

## 공통
- 시간 포맷: ISO8601 UTC("2025-08-10T09:00:00Z")
- 에러 포맷:
{
  "code":"...", "message":"...", "details":{...},
  "traceId":"...", "timestamp":"...", "path":"/...", "method":"POST"
}

## POST /work-orders (지시 생성)
- 권한: ROLE_OP+
- 필드 검증
  - workOrderNumber: 필수, UK
  - itemId/processId/equipmentId: FK 존재
  - orderQty: number, ≥0
- 오류: VALIDATION_ERROR(400), DUPLICATE_KEY(409), FORBIDDEN(403)

## PUT /work-orders/{id}/status (상태 전이)
- 권한: ROLE_OP+
- 필드 검증
  - toStatus ∈ {R,C}
  - 전이표 준수(P→R, R→C)
- 오류: WO_STATUS_INVALID(400), FORBIDDEN(403)

## POST /equip-status (RUN 등록)
- 권한: ROLE_OP+
- 필드 검증
  - equipmentId: FK
  - statusCode ∈ {RUN,IDLE,DOWN}
  - startTimeUtc: 필수
  - endTimeUtc: 선택, 있으면 end≥start
- 오류: TIME_ORDER_INVALID(400), VALIDATION_ERROR(400), CODE_INACTIVE(400)

## POST /performances (실적 등록)
- 권한: ROLE_OP+
- 필드 검증
  - workOrderId: FK, WO 상태=R
  - producedQty: number, ≥0
  - defectQty: number, 0≤defect≤produced
  - startTime/endTime: end≥start
- Tx: PERF insert → WO 누적 생산/불량 합산 갱신(한 Tx)
- 오류: VALIDATION_ERROR(400), TIME_ORDER_INVALID(400), FORBIDDEN(403)

## GET /kpi/actuals (목표 vs 실적)
- 권한: ROLE_OP/QA/ADMIN
- 파라미터: kpiDate, equipmentId (필수)
- 성능: SLA P95<500ms, EXPLAIN range 사용
"""

ERROR_CODES = """# ErrorCodes (표준 사전)
| 코드 | HTTP | 설명 |
|---|---|---|
| AUTH_REQUIRED | 401 | 인증 필요 |
| FORBIDDEN | 403 | 권한 부족 |
| VALIDATION_ERROR | 400 | 필드 검증 실패 |
| DUPLICATE_KEY | 409 | 고유키 충돌 |
| WO_STATUS_INVALID | 400 | 지시 상태 전이 불가 |
| CODE_INACTIVE | 400 | 비활성 코드 참조 |
| TIME_ORDER_INVALID | 400 | 시간 역전(또는 동일 시각 금지) |
| SERVER_ERROR | 500 | 내부 오류 |
"""

WIREFRAMES_NOTES = """# Wireframes_Notes (화면 요구/컴포넌트)

## 로그인
- 입력: username, password
- 제출 → JWT+세션 저장 → /menus/my → 대시보드
- 오류: 401 메시지, 실패 카운트/락 표시

## 메뉴 대시보드
- 좌측 트리: /menus/my 응답 기반 렌더(권한 필터)
- 상단: 사용자명/역할, TZ 배지(KST 표시)
- 본문: 오늘 KPI 카드 요약(선택)

## 작업지시 목록/상세
- 목록: 필터(상태/설비/기간), 컬럼(번호/품목/설비/상태/지시/누적)
- 상세: 기본 카드 + 누적 카드 + 상태 변경(P/R/C) 버튼

## 상태 RUN 등록(팝업)
- 필드: 설비 선택, 시작시각(UTC)
- 제출 → 최근 상태 카드 “RUN @09:00” 업데이트, 교대 뱃지 표시

## 실적 입력
- 필드: 지시/설비 자동완성, produced/defect, start/end
- 즉시 검증: defect≤produced, end≥start
- 저장 → 누적 카드 갱신

## KPI 보드
- 카드 3종: 목표 vs 실제(생산량/수율)
- 색상 규칙: 초록(≥목표)/노랑(목표-5% 이내)/빨강(그 아래)
"""

PERF_TEST = """# Perf_Test (측정 계획/절차)

## 대상·SLA
- GET /performances?equipmentId&from&to → P95 < 300ms
- GET /kpi/actuals?kpiDate&equipmentId → P95 < 500ms

## 방법
- JMeter: VU 50/100, 1분 샘플, think time 200~500ms
- DB: EXPLAIN 캡처(인덱스 키: (equipment_id,start_time), (work_order_id,start_time))

## 예시 SQL
EXPLAIN SELECT * FROM TB_PRODUCTION_PERFORMANCE
WHERE equipment_id=:eqp AND start_time BETWEEN :from AND :to
ORDER BY start_time;
"""

SEC_SCAN = """# Sec_Scan_Runbook (간단 취약점 점검)

## 의존성 취약점
- 도구: OWASP Dependency Check 또는 Snyk
- 정책: 중급↑ 발견 시 파이프라인 Fail

## 정적 분석(라이트)
- 룰: 하드코딩 시크릿 탐지, 위험 API 패턴 금지
- 결과: 리포트 저장(경미는 경고)

## 시크릿/세션
- .env(gitignore), 배포는 OS Secret/Vault
- 세션 쿠키: HttpOnly, Secure, SameSite=Lax
- CSRF: 세션 경로 보호(토큰), JWT GET 예외
"""

SEEDS_KEYMAP = """# Seeds_KeyMap (샘플 키/코드)

| 도메인 | 키 | 샘플 |
|---|---|---|
| EQUIPMENT | E-0001 | STENT_LINE_01 |
| PROCESS | P-0001 | STENT_PROC |
| ITEM | I-0001 | STENT_01 |
| WORK_ORDER | WO-0001 | 데모 지시(발행 후 R→C 시나리오) |

## 코드 시드(발췌)
INSERT INTO TB_CODE_GROUP (group_code, group_name, created_by)
VALUES ('WO_STATUS','작업지시 상태','seed')
ON DUPLICATE KEY UPDATE group_name=VALUES(group_name);

INSERT INTO TB_CODE (group_code, code, name, use_yn, sort_order, created_by)
VALUES ('WO_STATUS','P','Planned','Y',1,'seed'),
       ('WO_STATUS','R','Released','Y',2,'seed'),
       ('WO_STATUS','C','Completed','Y',3,'seed')
ON DUPLICATE KEY UPDATE name=VALUES(name), use_yn=VALUES(use_yn);
"""

ONEPAGER = f"""# GlobalMed MES — MESA-11 기반 스텐트 제조 스마트 MES 플랫폼

## 비전
“스텐트 의료기기 제조의 핵심 공정을 효율적이고 신뢰성 있게 관리하는 스마트 MES”

## v1 시나리오(버전 B, 강화형)
로그인/권한 → 작업지시 → 설비 상태 로그 RUN(교대 일부 표시) → 실적 등록 → KPI(목표 vs 생산량·수율)
- OEE의 Availability는 후속 확장 예정

## 범위
- Must: Auth/RBAC, WO, EQP RUN, PERF, KPI(3카드)
- Should: 상태 타임라인(최근 3건), ERP 링크 뱃지(자리표시)
- Non-goals: 가동률 실집계·보전·외부 연동 실제 동작

## 성공 기준 / 일정
- 데모 100% 완주, SLA: 실적<300ms, KPI(7일)<500ms, db_lint critical=0
- 40일: W1 인증/RBAC/시드/린트 → W2 지시/상태/실적 → W3 KPI → W4~W5 안정화/PPT → W6 리허설
(Generated: {NOW})
"""

ADRS = """# ADRs(핵심 결정)
1) 시간대: 모든 DATETIME UTC, 화면 로컬표시
2) 키/삭제: 단일 PK/FK(JPA), ON DELETE RESTRICT(보수형), 실삭제는 비즈 로직
3) 코드 일원화: TB_CODE_GROUP/TB_CODE, 참조는 code_id
4) 교대/배치: XOR(설비 또는 작업장) + 부분 유니크
5) 신원: worker_id = TB_USER.user_id(FK)
6) 에러 포맷: {code,message,details,traceId,timestamp,path,method}
7) 품질 게이트: db_lint critical=0, major=화이트리스트(캘린더/배치/email)
"""

SECURITY_RBAC = """# Security_RBAC
- roles: ROLE_OP / ROLE_QA / ROLE_ADMIN
- 메뉴 권한: ROLE_MENU.allow_read/write/exec
- 인증: JWT(30m)+세션(2h 비활성 만료) 병행, 세션 CSRF 보호
"""

API_LIST = """# API_List (요약)
- POST /auth/login (공개)
- GET  /menus/my (로그인)
- POST /work-orders (ROLE_OP+)
- GET  /work-orders (ROLE_OP+)
- GET  /work-orders/{id} (ROLE_OP+)
- PUT  /work-orders/{id}/status (ROLE_OP+)
- POST /equip-status (ROLE_OP+)
- POST /performances (ROLE_OP+)
- GET  /performances (ROLE_OP+)
- GET  /kpi-targets (ROLE_OP/QA/ADMIN)
- GET  /kpi/actuals (ROLE_OP/QA/ADMIN)
"""

SWAGGER = """openapi: 3.0.0
info: { title: GlobalMed MES API, version: v1 }
paths:
  /auth/login:
    post: { summary: 로그인, responses: { '200': { description: OK } } }
  /menus/my:
    get:  { summary: 내 메뉴 트리, security: [ { bearerAuth: [] } ] }
  /work-orders:
    get:  { summary: 지시 목록, security: [ { bearerAuth: [] } ] }
    post: { summary: 지시 생성, security: [ { bearerAuth: [] } ] }
  /work-orders/{id}:
    get:  { summary: 지시 상세, security: [ { bearerAuth: [] } ] }
  /work-orders/{id}/status:
    put:  { summary: 지시 상태 변경, security: [ { bearerAuth: [] } ] }
  /equip-status:
    post: { summary: 설비 상태 RUN 등록, security: [ { bearerAuth: [] } ] }
  /performances:
    get:  { summary: 실적 목록, security: [ { bearerAuth: [] } ] }
    post: { summary: 실적 등록, security: [ { bearerAuth: [] } ] }
  /kpi-targets:
    get:  { summary: KPI 목표 조회, security: [ { bearerAuth: [] } ] }
  /kpi/actuals:
    get:  { summary: KPI 목표 vs 실적, security: [ { bearerAuth: [] } ] }
components:
  securitySchemes:
    bearerAuth: { type: http, scheme: bearer, bearerFormat: JWT }
"""

ERROR_SPEC = """# ErrorSpec (표준 포맷 샘플)
{
  "code":"WO_STATUS_INVALID","message":"허용되지 않는 상태 전이입니다.",
  "details":{"from":"C","to":"R"},"traceId":"3f7a1d07e6a2",
  "timestamp":"2025-08-10T06:30:00Z","path":"/work-orders/WO-0001/status","method":"PUT"
}
"""

USER_FLOWS = """# UserFlows (요약)
1) 로그인(op) → 메뉴 권한 표시
2) 지시 생성 → 상태 R → 상세 누적(0)
3) RUN 등록(10초) → 최근 상태 카드·교대 뱃지
4) 실적 등록(100/5, 09:00~09:30) → 누적 갱신
5) KPI 보드: 목표 vs 생산량·수율(95%)
- KPI 색상: 초록(≥목표)/노랑(목표-5% 이내)/빨강(그 아래)
"""

MENU_MATRIX = """# MenuMatrix
- ROLE_OP: WO/Status/Perf/KPI 읽기·쓰기(관리자 제외)
- ROLE_QA: KPI 읽기(후속 품질 읽기), 쓰기 제한
- ROLE_ADMIN: 전 메뉴 읽기·쓰기
"""

DOD = """# DoD_Acceptance
| 구분 | 수용 기준(DoD) 내용 | 비고 |
|---|---|---|
| 기능 | 명세 100%·단위/통합 테스트 통과 | 기능 누락 방지 |
| 코드 | 리뷰·스타일 가이드 | 유지보수성 |
| 문서 | API/실행/설계 포함 | 발표·유지보수 |
| 배포 | 빌드 정상·산출물 준비 | 운영 대비 |
| UI/UX | 주요 화면 완성·반응성 | 사용자 경험 |
| 보안 | 인증/인가 기본·취약점 체크 | 기업 요구 |
| 성능 | 실적<300ms, KPI7일<500ms | 안정성 |
| 린트 | db_lint critical=0 | major=화이트리스트 |
"""

TEST_CASES = """# TestCases (발췌)
- AUTH_001: 잘못된 비번 → 401, 실패 카운트 증가
- MENU_001: ROLE_OP 계정 /admin 접근 → 403
- WO_001: 지시 생성 번호 중복 → 409
- WO_002: 상태 전이 C→R → 400 WO_STATUS_INVALID
- STATUS_001: RUN 등록 → 최근 상태 카드 갱신
- PERF_001: defect>produced → 400 VALIDATION_ERROR
- PERF_002: end<start → 400 TIME_ORDER_INVALID
- KPI_001: 수율 반올림 2자리
- KPI_002: KPI 최근 7일 P95<500ms
- LINT_001: db_lint critical=0
"""

DB_LINT_REPORT = f"""# DB Lint Report (자리표시)
- 최신 실행 결과 붙여넣기
- Generated: {NOW}
"""

SEEDS_RESET = """-- Seeds_Reset.sql (샘플 발췌, 실제 해시/ID로 교체)
INSERT INTO TB_CODE_GROUP (group_code, group_name, created_by)
VALUES ('WO_STATUS','작업지시 상태','seed')
ON DUPLICATE KEY UPDATE group_name=VALUES(group_name);

INSERT INTO TB_CODE (group_code, code, name, use_yn, sort_order, created_by)
VALUES ('WO_STATUS','P','Planned','Y',1,'seed'),
       ('WO_STATUS','R','Released','Y',2,'seed'),
       ('WO_STATUS','C','Completed','Y',3,'seed')
ON DUPLICATE KEY UPDATE name=VALUES(name);

INSERT INTO TB_ROLE (role_code, role_name, created_by)
VALUES ('ROLE_OP','운영자','seed')
ON DUPLICATE KEY UPDATE role_name=VALUES(role_name);

-- 비밀번호 해시 교체 필수
INSERT INTO TB_USER (user_id, username, password_hash, password_algo, is_active, created_by)
VALUES ('00000000-0000-0000-0000-0000000000OP','op','$2a$10$<bcrypt>','bcrypt',1,'seed')
ON DUPLICATE KEY UPDATE is_active=1;
"""

RUNBOOK = """# Runbook
- ENV: DB_URL, JWT_SECRET, SESSION_SECRET
- JWT 만료 30분, 세션 2시간(비활성 만료)
- 시간: 요청/응답 UTC, UI는 KST 렌더
- 데모 리셋: Seeds_Reset.sql 실행(관리자 전용 버튼/메뉴)
- 로깅: traceId 포함, 표준 에러 포맷 유지
"""

PERF_NOTES = """# PerformanceNotes
- 핵심 인덱스: (equipment_id,start_time), (work_order_id,start_time), KPI 유니크(일×설비×공정×품목)
- KPI 7일 쿼리: range scan, EXPLAIN 확인
- 슬로우쿼리: 500ms 이상 기록
"""

DEMO_SCRIPT = """# DemoScript (3~5분)
1) 로그인(op) → 메뉴 권한 표시
2) 지시 생성 → 상태 R → 상세 누적(0)
3) RUN 등록(10초) → 최근 상태 카드·교대 뱃지
4) 실적 등록(100/5, 09:00~09:30) → 누적 갱신
5) KPI 보드: 목표 vs 생산량·수율(95%)
6) 슬라이드: OEE Availability 후속 확장 예정
"""

SLIDES_OUTLINE = """# Slides_Outline (10장)
1 배경/문제 → 2 비전/목표 → 3 MESA-11 맵핑 → 4 아키텍처/ADR
5 데이터 모델 → 6 시나리오 → 7 화면 캡처 → 8 품질 게이트
9 확장(ERP/HMI, Availability) → 10 결론/로드맵
"""

ENV_EXAMPLE = """# .env.example
DB_URL=mysql+mysqlconnector://user:pwd@localhost:3306/globalmed?charset=utf8mb4
JWT_SECRET=change-me
SESSION_SECRET=change-me
TZ=UTC
LOG_LEVEL=INFO
"""

SCHEMA_PLACEHOLDER = """-- Schema_v1.sql (자리표시)
-- 실제 확정 스키마를 이 파일에 붙여넣어 사용하세요.
"""

# db_lint.py는 길어 간소화 동작본(정규화/화이트리스트/COALESCE 처리)는 자리표시 안내로 포함
DB_LINT_PLACEHOLDER = """# db_lint.py (자리표시)
# 최신 동작본을 여기에 붙여넣으세요. (정규화/화이트리스트/COALESCE/UTC 헤더 반영)
# 대화에서 사용하던 최신본 그대로 사용 권장.
"""

# ---------- 파일 맵 ----------
files = {
  "docs/00_Overview/OnePager.md": ONEPAGER,
  "docs/10_Architecture/ADRs.md": ADRS,
  "docs/10_Architecture/Security_RBAC.md": SECURITY_RBAC,
  "docs/20_DataModel/ERD_v1.png": None,  # 자리표시(나중 교체)
  "docs/20_DataModel/Architecture_v1.png": None,  # 자리표시
  "docs/20_DataModel/Schema_v1.sql": SCHEMA_PLACEHOLDER,
  "docs/20_DataModel/CodeDictionary.md": "WO_STATUS: P/R/C\nEQP_STATUS: RUN/IDLE/DOWN\n",
  "docs/30_API/API_List.md": API_LIST,
  "docs/30_API/Swagger.yaml": SWAGGER,
  "docs/30_API/ErrorSpec.md": ERROR_SPEC,
  "docs/40_UIUX/UserFlows.md": USER_FLOWS,
  "docs/40_UIUX/Wireframes_Notes.md": WIREFRAMES_NOTES,
  "docs/40_UIUX/MenuMatrix.md": MENU_MATRIX,
  "docs/50_QA/DoD_Acceptance.md": DOD,
  "docs/50_QA/TestCases.md": TEST_CASES,
  "docs/50_QA/db_lint_report.md": DB_LINT_REPORT,
  "docs/60_Operations/Seeds_Reset.sql": SEEDS_RESET,
  "docs/60_Operations/Runbook.md": RUNBOOK,
  "docs/60_Operations/PerformanceNotes.md": PERF_NOTES,
  "docs/70_Demo/DemoScript.md": DEMO_SCRIPT,
  "docs/70_Demo/Slides_Outline.md": SLIDES_OUTLINE,
  "docs/90_Design/UseCases_v1.md": USE_CASES,
  "docs/90_Design/StateMachine.md": STATE_MACHINE,
  "docs/90_Design/API_Validation_v1.md": API_VALIDATION,
  "docs/90_Design/ErrorCodes.md": ERROR_CODES,
  "docs/90_Design/Perf_Test.md": PERF_TEST,
  "docs/90_Design/Sec_Scan_Runbook.md": SEC_SCAN,
  "docs/90_Design/Seeds_KeyMap.md": SEEDS_KEYMAP,
  ".env.example": ENV_EXAMPLE,
  "tools/db_lint.py": DB_LINT_PLACEHOLDER,
}

def build_zip():
    zip_path = f"{PKG_NAME}.zip"
    with zipfile.ZipFile(zip_path, "w", compression=zipfile.ZIP_DEFLATED) as zf:
        for path, content in files.items():
            data = b"" if content is None else content.encode("utf-8")
            zf.writestr(f"{PKG_NAME}/{path}", data)
    return zip_path

if __name__ == "__main__":
    out = build_zip()
    print(f"[DONE] {out} created at {datetime.now(timezone.utc).strftime('%Y-%m-%d %H:%M:%S UTC')}")