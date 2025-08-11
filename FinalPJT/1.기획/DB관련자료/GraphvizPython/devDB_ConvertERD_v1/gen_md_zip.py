# build_package.py
# 목적: v1 기획 초안 문서/샘플/구조를 한 번에 생성하고 zip으로 압축
# 사용법: python build_package.py   (동일 폴더에 GlobalMedMES_v0.1-frozen.zip 생성)
import os, io, zipfile
from datetime import datetime

PKG_NAME = "GlobalMedMES_v0.1-frozen"
NOW = datetime.utcnow().strftime("%Y-%m-%d %H:%M:%S UTC")

files = {
  "docs/00_Overview/OnePager.md": f"""# GlobalMed MES — MESA-11 기반 스텐트 제조 스마트 MES 플랫폼

## 비전
“스텐트 의료기기 제조의 핵심 공정을 효율적이고 신뢰성 있게 관리하는 스마트 MES”

## v1 시나리오(버전 B, 강화형)
로그인/권한 → 작업지시 → 설비 상태 로그 RUN(교대 일부 표시) → 실적 등록 → KPI(목표 vs 생산량·수율)
- OEE의 Availability는 후속 확장 예정

## 범위
- Must: Auth/RBAC, WO, EQP RUN, PERF, KPI(3카드)
- Should: 상태 타임라인(최근 3건), ERP 링크 뱃지(자리표시)
- Non-goals: 가동률 실집계·보전·외부 연동 실제 동작

## 성공 기준
- 데모 100% 완주, SLA: 실적<300ms, KPI(7일)<500ms
- db_lint critical=0(major는 화이트리스트만)

## 일정(40일)
W1 인증/RBAC/시드/린트 → W2 지시/상태/실적 → W3 KPI 보드 → W4~5 안정화/PPT → W6 리허설
(Generated: {NOW})
""",

  "docs/10_Architecture/ADRs.md": """# ADRs(핵심 결정)
1) 시간대: 모든 DATETIME UTC 저장, 화면 로컬표시
2) 키/삭제: 단일 PK/FK(JPA), ON DELETE RESTRICT(보수형), 실삭제는 비즈 로직
3) 코드 일원화: TB_CODE_GROUP/TB_CODE, 참조는 code_id
4) 교대/배치: XOR(설비/작업장) + 부분 유니크(2개)
5) 신원: worker_id = TB_USER.user_id(FK) 단일 신원 원칙
6) 에러 포맷: {code,message,details,traceId,timestamp,path,method}
7) 품질 게이트: db_lint critical=0, major는 화이트리스트(캘린더/배치/email)
""",

  "docs/10_Architecture/Security_RBAC.md": """# Security & RBAC
- 역할: ROLE_OP / ROLE_QA / ROLE_ADMIN
- 메뉴 권한: ROLE_MENU.allow_read/write/exec 플래그
- 인증: JWT(Access 30분) + 세션(2시간, 비활성 시 만료) 병행
- CSRF: 세션 경로 보호, JWT 경로는 GET 예외 허용(정책)
""",

  "docs/20_DataModel/CodeDictionary.md": """# Code Dictionary
- WO_STATUS: P/R/C
- EQP_STATUS: RUN/IDLE/DOWN
- (후속) INSPECTION_TYPE, DEFECT_TYPE
- 단위(unit): 자유 텍스트(추후 코드화 가능)
""",

  "docs/20_DataModel/Schema_v1.sql": """-- Schema_v1.sql
-- 주: 현재 저장소의 확정 스키마를 붙여넣어 사용하십시오(UTC/RESTRICT/JPA친화/체크/인덱스 반영).
-- 여기 파일은 자리표시용입니다.
""",

  "docs/20_DataModel/ERD_v1.png": None,  # 빈 파일(자리표시)
  
  "docs/30_API/API_List.md": """# API 목록(v1)
공통: Authorization: Bearer <jwt> 또는 세션 쿠키, 시간=ISO8601 UTC("2025-08-10T09:00:00Z")

- POST   /auth/login               (공개)
- GET    /menus/my                 (로그인)
- POST   /work-orders              (ROLE_OP+)
- GET    /work-orders              (ROLE_OP+)
- GET    /work-orders/{id}         (ROLE_OP+)
- PUT    /work-orders/{id}/status  (ROLE_OP+)
- POST   /equip-status             (ROLE_OP+)     # RUN 등록
- POST   /performances             (ROLE_OP+)
- GET    /performances             (ROLE_OP+)
- GET    /kpi-targets              (ROLE_OP/QA/ADMIN)
- GET    /kpi/actuals              (ROLE_OP/QA/ADMIN)

예시 요청 - 실적 등록
{
  "workOrderId":"WO-UUID",
  "itemId":"I-UUID","processId":"P-UUID","equipmentId":"E-UUID",
  "producedQty":100.0,"defectQty":5.0,
  "startTime":"2025-08-10T09:00:00Z","endTime":"2025-08-10T09:30:00Z"
}
""",

  "docs/30_API/Swagger.yaml": """openapi: 3.0.0
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
""",

  "docs/30_API/ErrorSpec.md": """# Error Spec(표준)
{
  "code": "WO_STATUS_INVALID",
  "message": "허용되지 않는 상태 전이입니다.",
  "details": {"from":"C","to":"R"},
  "traceId": "3f7a1d07e6a2",
  "timestamp": "2025-08-10T06:30:00Z",
  "path": "/work-orders/WO-0001/status",
  "method": "PUT"
}
-- HTTP 매핑: 400/401/403/404/409/500
""",

  "docs/40_UIUX/UserFlows.md": """# User Flows(v1)
1) 로그인(op) → 내 메뉴만 표시
2) 작업지시 생성 → 상태 R → 상세 누적(0)
3) RUN 등록(1클릭) → 최근 상태 카드/교대 뱃지
4) 실적 등록(100/5, 09:00~09:30) → 누적 갱신
5) KPI 보드: 목표 vs 생산량·수율(95%)

- KPI 색상 규칙:
  초록: 실제 ≥ 목표 / 노랑: 목표 대비 -5% 이내 / 빨강: -5% 초과 하회
- 표시: 수율 % 소수 2자리(half up), 생산량 정수, 시간은 UTC 저장·KST 표시
""",

  "docs/40_UIUX/MenuMatrix.md": """# Menu Matrix(권한)
ROLE_OP: WO/Status/Perf/KPI 읽기·쓰기, Admin 메뉴 비표시
ROLE_QA: KPI 읽기, 품질 화면(후속) 읽기, 쓰기는 제한
ROLE_ADMIN: 전 메뉴 읽기·쓰기
""",

  "docs/50_QA/DoD_Acceptance.md": """# DoD & 수용 기준
| 구분 | 수용 기준(DoD) 내용 | 비고 |
|---|---|---|
| 기능 완성 | 명세 100%·단위/통합 테스트 통과 | 기능 누락 방지 |
| 코드 품질 | 코드 리뷰·스타일 가이드 | 유지보수성 |
| 문서화 | API/실행/설계 문서 포함 | 발표·유지보수 |
| 배포 | 빌드 정상·산출물 준비 | 운영 대비 |
| UI/UX | 주요 화면 완성·반응성 | 사용자 경험 |
| 보안 | 인증/인가 기본·취약점 체크 | 기업 요구 |
| 성능 | 실적<300ms, KPI7일<500ms | 안정성 |
| 린트 | db_lint critical=0 | major=화이트리스트 |
""",

  "docs/50_QA/TestCases.md": """# Test Cases(발췌)
- AUTH_001: 잘못된 비번 → 401, 실패 카운트 증가
- MENU_001: ROLE_OP 계정 /admin 메뉴 접근 → 403
- WO_001: 지시 생성(번호 중복) → 409
- WO_002: 상태 전이(C→R) → 400 WO_STATUS_INVALID
- STATUS_001: RUN 등록 → 최근 상태 카드 즉시 갱신
- PERF_001: defect>produced → 400 VALIDATION
- PERF_002: end<start → 400 VALIDATION
- KPI_001: 수율 계산 반올림 정책 확인(소수 2자리)
- KPI_002: KPI actuals 최근 7일 응답시간 < 500ms
- LINT_001: db_lint 실행 결과 critical=0
""",

  "docs/50_QA/db_lint_report.md": f"""# DB Lint Report (자리표시)
- 마지막 실행 결과 요약 붙여넣기
- Generated: {NOW}
""",

  "docs/60_Operations/Seeds_Reset.sql": """-- Seeds & Reset (샘플/발췌)
INSERT INTO TB_CODE_GROUP (group_code, group_name, created_by)
VALUES ('WO_STATUS','작업지시 상태','seed')
ON DUPLICATE KEY UPDATE group_name=VALUES(group_name);

INSERT INTO TB_CODE (group_code, code, name, use_yn, sort_order, created_by)
VALUES ('WO_STATUS','P','Planned','Y',1,'seed'),
       ('WO_STATUS','R','Released','Y',2,'seed'),
       ('WO_STATUS','C','Completed','Y',3,'seed')
ON DUPLICATE KEY UPDATE name=VALUES(name), use_yn=VALUES(use_yn);

-- 역할/사용자(비번 해시 교체 필요)
INSERT INTO TB_ROLE (role_code, role_name, created_by)
VALUES ('ROLE_OP','운영자','seed')
ON DUPLICATE KEY UPDATE role_name=VALUES(role_name);

INSERT INTO TB_USER (user_id, username, password_hash, password_algo, is_active, created_by)
VALUES ('00000000-0000-0000-0000-0000000000OP','op','$2a$10$<bcrypt>','bcrypt',1,'seed')
ON DUPLICATE KEY UPDATE is_active=1;
""",

  "docs/60_Operations/Runbook.md": """# Runbook
- ENV: DB_URL, JWT_SECRET, SESSION_SECRET
- JWT 만료 30분, 세션 2시간(비활성 만료)
- 시간: 요청/응답 UTC, UI는 KST 렌더
- 데모 리셋: Seeds_Reset.sql 실행(관리자 전용)
- 로깅: traceId 포함, 에러 포맷 표준 유지
""",

  "docs/60_Operations/PerformanceNotes.md": """# Performance Notes
- 핵심 인덱스: (equipment_id,start_time), (work_order_id,start_time), KPI 유니크(일×설비×공정×품목)
- KPI 7일 쿼리: range scan, EXPLAIN 점검
- 슬로우쿼리: 500ms 이상 캡처
""",

  "docs/70_Demo/DemoScript.md": """# Demo Script(3~5분)
1) 로그인(op) → 메뉴 권한 표시
2) 지시 생성 → 상태 R → 상세 누적(0)
3) RUN 등록(10초) → 최근 상태 카드·교대 뱃지
4) 실적 등록(100/5, 09:00~09:30) → 누적 갱신
5) KPI 보드: 목표 vs 생산량·수율(95%)
6) 슬라이드: OEE Availability 후속 확장 예정
""",

  "docs/70_Demo/Slides_Outline.md": """# Slides Outline(10장)
1 배경/문제 → 2 비전/목표 → 3 MESA-11 맵핑 → 4 아키텍처/ADR
5 데이터 모델 → 6 시나리오 → 7 화면 캡처 → 8 품질 게이트
9 확장(ERP/HMI, Availability) → 10 결론/로드맵
""",

  "tools/db_lint.py": """# db_lint.py 자리표시
# 최신 작동본을 이 위치에 저장하세요. (정규화/화이트리스트/COALESCE 처리/UTC 헤더 반영)
"""
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
    print(f"[DONE] {out} created.")