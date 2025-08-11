--
-- MES(의료기기 스텐트 제조) 시스템 통합 DDL 스크립트
--
-- JPA 친화적인 단일 PK(BIGINT AI 또는 UUID), 풍부한 주석,
-- 모든 제약/인덱스 인라인 정의를 포함합니다.
--

CREATE DATABASE IF NOT EXISTS `mes_pjt_test` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `mes_pjt_test`;

--
-- TB_CODE_GROUP (코드 그룹 마스터)
-- 역할: 공통으로 사용되는 상태, 사유, 유형 코드들을 묶는 그룹 정의.
-- 사용 시나리오: TB_CODE와 함께 사용해 시스템 전반의 드롭다운 메뉴, 상태 관리를 일원화.
-- 주요 조인 키: group_code (TB_CODE의 FK).
-- 삭제 정책: 하드 딜리트. (TB_CODE와 종속성 고려)
--

CREATE TABLE `TB_CODE_GROUP` (
  `group_code` VARCHAR(50) NOT NULL COMMENT '코드 그룹 ID (PK) 예: EQP_STATUS, WO_STATUS',
  `group_name` VARCHAR(100) NOT NULL COMMENT '코드 그룹명 예: 설비 상태, 작업 지시 상태',
  `description` VARCHAR(255) NULL COMMENT '그룹에 대한 상세 설명',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '소프트삭제 플래그(운영상 편의)',
  `deleted_at` DATETIME NULL COMMENT 'UTC',
  `created_by` VARCHAR(50) NOT NULL COMMENT '최초 생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초 생성 시점 (UTC)',
  `modified_by` VARCHAR(50) NULL COMMENT '최종 수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 시점 (UTC)',
  PRIMARY KEY (`group_code`),
  UNIQUE KEY `uk_code_group_name` (`group_name`)
) ENGINE=InnoDB COMMENT='코드 그룹 마스터: 시스템 전체 코드 관리의 최상위 그룹 (UTC)';

--
-- TB_CODE (상태, 사유, 유형 코드 마스터)
-- 역할: TB_CODE_GROUP에 속하는 개별 코드(상태, 사유, 유형) 정의.
-- 사용 시나리오: 설비 상태(TB_EQUIPMENT), 작업지시 상태(TB_WORK_ORDER) 등 다양한 테이블에서 공통으로 참조.
-- 주요 조인 키: code_id (다른 테이블의 FK), group_code.
-- 삭제 정책: 하드 딜리트. (시스템 전반에 영향을 주므로 신중한 관리 필요)
--
CREATE TABLE `TB_CODE` (
  `code_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '코드 ID (PK, JPA 친화용 서로게이트 키)',
  `group_code` VARCHAR(50) NOT NULL COMMENT '코드 그룹 ID (FK)',
  `code` VARCHAR(50) NOT NULL COMMENT '코드 값 (그룹 내 유일) 예: RUN, IDLE',
  `name` VARCHAR(100) NOT NULL COMMENT '코드 명칭 예: 가동, 유휴',
  `description` VARCHAR(255) NULL COMMENT '코드에 대한 상세 설명',
  `use_yn` CHAR(1) NOT NULL DEFAULT 'Y' COMMENT '사용 여부',
  `sort_order` INT NULL COMMENT '정렬 순서',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '소프트삭제 플래그 (운영상 편의)',
  `deleted_at` DATETIME NULL COMMENT 'UTC',
  `created_by` VARCHAR(50) NOT NULL COMMENT '최초 생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초 생성 시점 (UTC)',
  `modified_by` VARCHAR(50) NULL COMMENT '최종 수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 시점 (UTC)',
  PRIMARY KEY (`code_id`),
  UNIQUE KEY `uk_code_group_code` (`group_code`, `code`),
  KEY `idx_code_group_sort` (`group_code`, `sort_order`),
  CONSTRAINT `fk_code_group_code` FOREIGN KEY (`group_code`) REFERENCES `TB_CODE_GROUP`(`group_code`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='코드 마스터: 상태, 사유, 유형 등 시스템 공통 코드 (UTC)';

--
-- TB_SHIFT (교대 마스터)
-- 역할: 제조 공장의 교대 근무 스케줄(A/B/C) 정의.
-- 사용 시나리오: 일일 생산 달력(TB_SHIFT_CALENDAR) 및 생산 실적(TB_PRODUCTION_PERFORMANCE)과 연계.
-- 주요 조인 키: shift_id.
-- 삭제 정책: 하드 딜리트. (고정된 마스터 데이터)
--
CREATE TABLE `TB_SHIFT` (
  `shift_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '교대 ID (PK, 서로게이트 키)',
  `shift_code` VARCHAR(10) NOT NULL COMMENT '교대 코드 (A, B, C 등) 예: A',
  `shift_name` VARCHAR(50) NOT NULL COMMENT '교대 명칭 예: 주간조',
  `start_time` TIME NOT NULL COMMENT '교대 시작 시간 (예: 08:00:00)',
  `end_time` TIME NOT NULL COMMENT '교대 종료 시간 (예: 17:00:00)',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '소프트삭제 플래그',
  `deleted_at` DATETIME NULL COMMENT 'UTC',
  `created_by` VARCHAR(50) NOT NULL COMMENT '최초 생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초 생성 시점 (UTC)',
  `modified_by` VARCHAR(50) NULL COMMENT '최종 수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 시점 (UTC)',
  PRIMARY KEY (`shift_id`),
  UNIQUE KEY `uk_shift_code` (`shift_code`)
) ENGINE=InnoDB COMMENT='교대 마스터: A, B, C와 같은 교대 근무 정보 (UTC)';

--
-- TB_WORKSHOP (작업장 그룹 마스터)
-- 역할: 공장을 논리적으로 묶는 최상위 그룹 (예: 1공장, 2공장).
-- 사용 시나리오: 생산 계획 및 지시의 상위 단위.
-- 주요 조인 키: workshop_id.
-- 삭제 정책: 소프트 딜리트. (계층 구조 보존을 위함)
--
CREATE TABLE `TB_WORKSHOP` (
  `workshop_id` VARCHAR(36) NOT NULL COMMENT '작업장 그룹 ID (PK, UUID)',
  `workshop_name` VARCHAR(255) NOT NULL COMMENT '작업장 그룹명 (유일)',
  `description` VARCHAR(255) NULL COMMENT '설명',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '소프트삭제 플래그',
  `deleted_at` DATETIME NULL COMMENT 'UTC',
  `created_by` VARCHAR(50) NOT NULL COMMENT '최초 생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초 생성 시점 (UTC)',
  `modified_by` VARCHAR(50) NULL COMMENT '최종 수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 시점 (UTC)',
  PRIMARY KEY (`workshop_id`),
  UNIQUE KEY `uk_workshop_name` (`workshop_name`)
) ENGINE=InnoDB COMMENT='작업장 그룹 마스터: 생산 라인의 상위 그룹 (UTC)';

--
-- TB_WORKCENTER (작업장 마스터)
-- 역할: 공정/설비를 포함하는 논리적 생산 단위 (예: 1호 라인, 2호 라인).
-- 사용 시나리오: 생산 계획, 실적의 집계 단위.
-- 주요 조인 키: workcenter_id.
-- 삭제 정책: 소프트 딜리트. (설비 및 공정 종속성)
--
CREATE TABLE `TB_WORKCENTER` (
  `workcenter_id` VARCHAR(36) NOT NULL COMMENT '작업장 ID (PK, UUID)',
  `workcenter_name` VARCHAR(255) NOT NULL COMMENT '작업장명 (유일)',
  `workshop_id` VARCHAR(36) NOT NULL COMMENT '작업장 그룹 ID (FK)',
  `description` VARCHAR(255) NULL COMMENT '설명',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '소프트삭제 플래그',
  `deleted_at` DATETIME NULL COMMENT 'UTC',
  `created_by` VARCHAR(50) NOT NULL COMMENT '최초 생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초 생성 시점 (UTC)',
  `modified_by` VARCHAR(50) NULL COMMENT '최종 수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 시점 (UTC)',
  PRIMARY KEY (`workcenter_id`),
  UNIQUE KEY `uk_workcenter_name` (`workcenter_name`),
  KEY `idx_workcenter_workshop_id` (`workshop_id`),
  CONSTRAINT `fk_workcenter_workshop` FOREIGN KEY (`workshop_id`) REFERENCES `TB_WORKSHOP`(`workshop_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='작업장 마스터: 설비 및 공정의 상위 그룹 (UTC)';

--
-- TB_PROCESS (공정 마스터)
-- 역할: 제품을 생산하는 데 필요한 작업 단계 (예: 재단, 성형, 세척, 코팅).
-- 사용 시나리오: 라우팅, 작업 지시, 실적 등 모든 생산 활동의 기준.
-- 주요 조인 키: process_id.
-- 삭제 정책: 소프트 딜리트. (라우팅, 실적 등 데이터 종속성)
--
CREATE TABLE `TB_PROCESS` (
  `process_id` VARCHAR(36) NOT NULL COMMENT '공정 ID (PK, UUID)',
  `process_name` VARCHAR(255) NOT NULL COMMENT '공정명 (유일)',
  `description` VARCHAR(255) NULL COMMENT '설명',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '소프트삭제 플래그',
  `deleted_at` DATETIME NULL COMMENT 'UTC',
  `created_by` VARCHAR(50) NOT NULL COMMENT '최초 생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초 생성 시점 (UTC)',
  `modified_by` VARCHAR(50) NULL COMMENT '최종 수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 시점 (UTC)',
  PRIMARY KEY (`process_id`),
  UNIQUE KEY `uk_process_name` (`process_name`)
) ENGINE=InnoDB COMMENT='공정 마스터: 생산 라우팅의 작업 단계 (UTC)';

--
-- TB_ITEM (품목 마스터)
-- 역할: 생산 대상 품목(재료, 반제품, 완제품) 정보.
-- 사용 시나리오: BOM, 작업 지시, 생산 실적, 재고 관리의 핵심 마스터.
-- 주요 조인 키: item_id.
-- 삭제 정책: 소프트 딜리트. (BOM, LOT, 실적 등 종속성)
--
CREATE TABLE `TB_ITEM` (
  `item_id` VARCHAR(36) NOT NULL COMMENT '품목 ID (PK, UUID)',
  `item_code` VARCHAR(50) NOT NULL COMMENT '품목 코드 (유일) 예: STENT-001',
  `item_name` VARCHAR(255) NOT NULL COMMENT '품목명',
  `item_type` CHAR(1) NOT NULL COMMENT '품목 유형 (R:원자재, P:반제품, F:완제품)',
  `unit` VARCHAR(10) NOT NULL COMMENT '단위 예: EA, KG',
  `description` VARCHAR(255) NULL COMMENT '설명',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '소프트삭제 플래그',
  `deleted_at` DATETIME NULL COMMENT 'UTC',
  `created_by` VARCHAR(50) NOT NULL COMMENT '최초 생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초 생성 시점 (UTC)',
  `modified_by` VARCHAR(50) NULL COMMENT '최종 수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 시점 (UTC)',
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `uk_item_code` (`item_code`)
) ENGINE=InnoDB COMMENT='품목 마스터: 생산, 재고 관리의 대상 품목 정보 (UTC)';

--
-- TB_WAREHOUSE (창고 마스터)
-- 역할: 자재가 보관되는 물리적 공간.
-- 사용 시나리오: 재고 LOT의 위치 관리.
-- 주요 조인 키: warehouse_id.
-- 삭제 정책: 소프트 딜리트. (LOT 데이터 종속성)
--
CREATE TABLE `TB_WAREHOUSE` (
  `warehouse_id` VARCHAR(36) NOT NULL COMMENT '창고 ID (PK, UUID)',
  `warehouse_name` VARCHAR(255) NOT NULL COMMENT '창고명 (유일)',
  `location` VARCHAR(255) NULL COMMENT '위치 정보',
  `description` VARCHAR(255) NULL COMMENT '설명',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '소프트삭제 플래그',
  `deleted_at` DATETIME NULL COMMENT 'UTC',
  `created_by` VARCHAR(50) NOT NULL COMMENT '최초 생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초 생성 시점 (UTC)',
  `modified_by` VARCHAR(50) NULL COMMENT '최종 수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 시점 (UTC)',
  PRIMARY KEY (`warehouse_id`),
  UNIQUE KEY `uk_warehouse_name` (`warehouse_name`)
) ENGINE=InnoDB COMMENT='창고 마스터: 자재 및 제품의 보관 장소 (UTC)';

--
-- TB_EQUIPMENT (설비 마스터)
-- 역할: 라우팅/교대/상태와 결합되는 핵심 마스터.
-- 사용 시나리오: 작업 지시, 생산 실적, 설비 상태 로그의 주체.
-- 주요 조인 키: equipment_id.
-- 삭제 정책: 소프트 딜리트. (실적, 로그 등 핵심 데이터 종속성)
--
CREATE TABLE `TB_EQUIPMENT` (
  `equipment_id` VARCHAR(36) NOT NULL COMMENT '설비 ID (PK, UUID)',
  `equipment_name` VARCHAR(255) NOT NULL COMMENT '설비명 (유일) 예: STENT_LINE_01',
  `workcenter_id` VARCHAR(36) NOT NULL COMMENT '작업장 ID (FK)',
  `process_id` VARCHAR(36) NOT NULL COMMENT '공정 ID (FK)',
  `status_code_id` BIGINT NOT NULL COMMENT '설비 상태 코드 ID (FK→TB_CODE, 예: RUN/IDLE/DOWN)',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '소프트삭제 플래그',
  `deleted_at` DATETIME NULL COMMENT 'UTC',
  `created_by` VARCHAR(50) NOT NULL COMMENT '최초 생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초 생성 시점 (UTC)',
  `modified_by` VARCHAR(50) NULL COMMENT '최종 수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 시점 (UTC)',
  PRIMARY KEY (`equipment_id`),
  UNIQUE KEY `uk_equipment_name` (`equipment_name`),
  KEY `idx_equipment_workcenter_id` (`workcenter_id`),
  KEY `idx_equipment_process_id` (`process_id`),
  KEY `idx_equipment_status_code_id` (`status_code_id`),
  CONSTRAINT `fk_equipment_workcenter` FOREIGN KEY (`workcenter_id`) REFERENCES `TB_WORKCENTER`(`workcenter_id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_equipment_process` FOREIGN KEY (`process_id`) REFERENCES `TB_PROCESS`(`process_id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_equipment_status_code` FOREIGN KEY (`status_code_id`) REFERENCES `TB_CODE`(`code_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='설비 마스터: 라우팅/교대/상태와 결합되는 핵심 마스터 (UTC)';

--
-- TB_SHIFT_CALENDAR (교대 달력)
-- 역할: 특정 날짜에 어떤 교대가 배정되었는지 기록. 설비/작업장 단위로도 관리 가능.
-- 사용 시나리오: 생산 계획 및 실적 분석 시 특정 교대조의 데이터를 필터링하는 데 활용.
-- 주요 조인 키: shift_id, shift_date.
-- 삭제 정책: 소프트 딜리트. (이미 생성된 데이터는 로그 보존 필요)
--
CREATE TABLE `TB_SHIFT_CALENDAR` (
  `calendar_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '교대 달력 ID (PK)',
  `shift_date` DATE NOT NULL COMMENT '근무 날짜 (YYYY-MM-DD)',
  `shift_id` BIGINT NOT NULL COMMENT '교대 ID (FK)',
  `equipment_id` VARCHAR(36) NULL COMMENT '설비 ID (FK) - 선택',
  `workcenter_id` VARCHAR(36) NULL COMMENT '작업장 ID (FK) - 선택',
  `start_ts` DATETIME NOT NULL COMMENT '교대 시작 (UTC)',
  `end_ts` DATETIME NOT NULL COMMENT '교대 종료 (UTC)',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '소프트삭제',
  `deleted_at` DATETIME NULL COMMENT 'UTC',
  `created_by` VARCHAR(50) NOT NULL COMMENT '최초 생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초 생성 시점 (UTC)',
  `modified_by` VARCHAR(50) NULL COMMENT '최종 수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'UTC',
  PRIMARY KEY (`calendar_id`),
  UNIQUE KEY `uk_shiftcal_date_shift_scope` (`shift_date`, `shift_id`, `equipment_id`, `workcenter_id`),
  KEY `idx_shiftcal_shift_id` (`shift_id`),
  KEY `idx_shiftcal_equipment_id` (`equipment_id`),
  KEY `idx_shiftcal_workcenter_id` (`workcenter_id`),
  KEY `idx_shiftcal_date_shift_eqp` (`shift_date`, `shift_id`, `equipment_id`),
  KEY `idx_shiftcal_date_shift_wc` (`shift_date`, `shift_id`, `workcenter_id`),
  CONSTRAINT `fk_shiftcal_shift` FOREIGN KEY (`shift_id`) REFERENCES `TB_SHIFT`(`shift_id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_shiftcal_eqp` FOREIGN KEY (`equipment_id`) REFERENCES `TB_EQUIPMENT`(`equipment_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_shiftcal_wc` FOREIGN KEY (`workcenter_id`) REFERENCES `TB_WORKCENTER`(`workcenter_id`) ON DELETE SET NULL,
  CONSTRAINT `ck_shiftcal_scope_exclusive`
    CHECK (
      (`equipment_id` IS NOT NULL AND `workcenter_id` IS NULL)
      OR
      (`equipment_id` IS NULL AND `workcenter_id` IS NOT NULL)
      OR
      (`equipment_id` IS NULL AND `workcenter_id` IS NULL)
    )
) ENGINE=InnoDB COMMENT='교대 달력: 날짜/교대/설비 또는 작업장 단위 관리(UTC)';

--
-- TB_PRODUCTION_PLAN (생산 계획)
-- 역할: 특정 기간 동안 생산할 품목과 수량을 정의하는 최상위 계획.
-- 사용 시나리오: 작업 지시 생성의 근거가 되며, 일정 및 상태를 관리.
-- 주요 조인 키: plan_id.
-- 삭제 정책: 소프트 딜리트. (관련 작업 지시 보존을 위해)
--
CREATE TABLE `TB_PRODUCTION_PLAN` (
  `plan_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '생산 계획 ID (PK)',
  `plan_number` VARCHAR(50) NOT NULL COMMENT '계획 번호 (유일)',
  `item_id` VARCHAR(36) NOT NULL COMMENT '계획 품목 ID (FK)',
  `target_qty` DECIMAL(10,4) NOT NULL COMMENT '계획 수량',
  `start_date` DATE NOT NULL COMMENT '계획 시작일',
  `end_date` DATE NOT NULL COMMENT '계획 종료일',
  `status_code_id` BIGINT NOT NULL COMMENT '계획 상태 코드 ID (FK→TB_CODE, 예: DRAFT/APPROVED/COMPLETED)',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '소프트삭제 플래그',
  `deleted_at` DATETIME NULL COMMENT 'UTC',
  `created_by` VARCHAR(50) NOT NULL COMMENT '최초 생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초 생성 시점 (UTC)',
  `modified_by` VARCHAR(50) NULL COMMENT '최종 수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 시점 (UTC)',
  PRIMARY KEY (`plan_id`),
  UNIQUE KEY `uk_plan_number` (`plan_number`),
  KEY `idx_plan_item_id` (`item_id`),
  KEY `idx_plan_status_code_id` (`status_code_id`),
  CONSTRAINT `fk_plan_item` FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM`(`item_id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_plan_status_code` FOREIGN KEY (`status_code_id`) REFERENCES `TB_CODE`(`code_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='생산 계획: 생산 목표 및 기간 정의 (UTC)';

--
-- TB_WORK_ORDER (작업 지시)
-- 역할: 생산 계획에 따라 특정 품목을 특정 공정/설비에서 생산하도록 지시.
-- 사용 시나리오: 생산 현장의 작업자에게 할당되는 실제 작업 단위.
-- 주요 조인 키: work_order_id.
-- 삭제 정책: 소프트 딜리트. (실적, 로그, 품질 데이터 종속성)
--
CREATE TABLE `TB_WORK_ORDER` (
  `work_order_id` VARCHAR(36) NOT NULL COMMENT '작업 지시 ID (PK, UUID)',
  `plan_id` BIGINT NULL COMMENT '생산 계획 ID (FK) - 선택',
  `work_order_number` VARCHAR(50) NOT NULL COMMENT '작업 지시 번호 (유일)',
  `item_id` VARCHAR(36) NOT NULL COMMENT '생산 품목 ID (FK)',
  `process_id` VARCHAR(36) NOT NULL COMMENT '지시 공정 ID (FK)',
  `equipment_id` VARCHAR(36) NOT NULL COMMENT '지시 설비 ID (FK)',
  `order_qty` DECIMAL(10,4) NOT NULL COMMENT '지시 수량',
  `produced_qty` DECIMAL(10,4) DEFAULT 0 COMMENT '생산 완료 수량',
  `start_ts` DATETIME NULL COMMENT '지시 시작 타임스탬프 (UTC)',
  `end_ts` DATETIME NULL COMMENT '지시 종료 타임스탬프 (UTC)',
  `status_code_id` BIGINT NOT NULL COMMENT '작업 지시 상태 코드 ID (FK→TB_CODE, 예: P/R/C)',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '소프트삭제 플래그',
  `deleted_at` DATETIME NULL COMMENT 'UTC',
  `created_by` VARCHAR(50) NOT NULL COMMENT '최초 생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초 생성 시점 (UTC)',
  `modified_by` VARCHAR(50) NULL COMMENT '최종 수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 시점 (UTC)',
  PRIMARY KEY (`work_order_id`),
  UNIQUE KEY `uk_wo_number` (`work_order_number`),
  KEY `idx_wo_plan_id` (`plan_id`),
  KEY `idx_wo_item_id` (`item_id`),
  KEY `idx_wo_process_id` (`process_id`),
  KEY `idx_wo_equipment_id` (`equipment_id`),
  KEY `idx_wo_status_code_id` (`status_code_id`),
  CONSTRAINT `fk_wo_plan` FOREIGN KEY (`plan_id`) REFERENCES `TB_PRODUCTION_PLAN`(`plan_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_wo_item` FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM`(`item_id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_wo_process` FOREIGN KEY (`process_id`) REFERENCES `TB_PROCESS`(`process_id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_wo_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `TB_EQUIPMENT`(`equipment_id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_wo_status_code` FOREIGN KEY (`status_code_id`) REFERENCES `TB_CODE`(`code_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='작업 지시: 생산 현장의 실제 작업 단위 (UTC)';

--
-- TB_BOM (BOM 마스터)
-- 역할: 특정 품목(parent)을 만들기 위한 구성 품목(child)과 수량 정의.
-- 사용 시나리오: 자재 소요량 계획(MRP), 자재 LOT 사용 추적.
-- 주요 조인 키: parent_item_id, child_item_id.
-- 삭제 정책: 하드 딜리트. (마스터 데이터 변경 시 신규 생성)
--
CREATE TABLE `TB_BOM` (
  `parent_item_id` VARCHAR(36) NOT NULL COMMENT '상위 품목 ID (FK)',
  `child_item_id` VARCHAR(36) NOT NULL COMMENT '하위 품목 ID (FK)',
  `quantity` DECIMAL(10,4) NOT NULL COMMENT '소요 수량',
  `line_no` INT NOT NULL COMMENT 'BOM 라인 번호',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '소프트삭제 플래그',
  `deleted_at` DATETIME NULL COMMENT 'UTC',
  `created_by` VARCHAR(50) NOT NULL COMMENT '최초 생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초 생성 시점 (UTC)',
  `modified_by` VARCHAR(50) NULL COMMENT '최종 수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 시점 (UTC)',
  PRIMARY KEY (`parent_item_id`, `child_item_id`, `line_no`),
  KEY `idx_bom_parent_item_id` (`parent_item_id`),
  KEY `idx_bom_child_item_id` (`child_item_id`),
  CONSTRAINT `fk_bom_parent` FOREIGN KEY (`parent_item_id`) REFERENCES `TB_ITEM`(`item_id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_bom_child` FOREIGN KEY (`child_item_id`) REFERENCES `TB_ITEM`(`item_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='BOM 마스터: 자재 소요량, 제품 구성 정보 (UTC)';

--
-- TB_MATERIAL_LOT (자재 LOT 마스터)
-- 역할: 입고된 자재의 LOT 단위 재고 정보.
-- 사용 시나리오: 생산 공정에서 사용된 자재 LOT 추적, 재고 관리.
-- 주요 조인 키: material_lot_id.
-- 삭제 정책: 소프트 딜리트. (추적성 데이터 종속성)
--
CREATE TABLE `TB_MATERIAL_LOT` (
  `material_lot_id` VARCHAR(36) NOT NULL COMMENT '자재 LOT ID (PK, UUID)',
  `lot_number` VARCHAR(50) NOT NULL COMMENT 'LOT 번호 (유일)',
  `item_id` VARCHAR(36) NOT NULL COMMENT '품목 ID (FK)',
  `warehouse_id` VARCHAR(36) NOT NULL COMMENT '현재 창고 ID (FK)',
  `quantity` DECIMAL(10,4) NOT NULL COMMENT 'LOT 수량',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '소프트삭제 플래그',
  `deleted_at` DATETIME NULL COMMENT 'UTC',
  `created_by` VARCHAR(50) NOT NULL COMMENT '최초 생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초 생성 시점 (UTC)',
  `modified_by` VARCHAR(50) NULL COMMENT '최종 수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 시점 (UTC)',
  PRIMARY KEY (`material_lot_id`),
  UNIQUE KEY `uk_lot_number` (`lot_number`),
  KEY `idx_material_lot_item_id` (`item_id`),
  KEY `idx_material_lot_warehouse_id` (`warehouse_id`),
  CONSTRAINT `fk_material_lot_item` FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM`(`item_id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_material_lot_warehouse` FOREIGN KEY (`warehouse_id`) REFERENCES `TB_WAREHOUSE`(`warehouse_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='자재 LOT 마스터: 입고된 자재의 추적 단위 (UTC)';

--
-- TB_PRODUCTION_PERFORMANCE (생산 실적)
-- 역할: 작업 지시에 대한 실제 생산 결과.
-- 사용 시나리오: 생산량, 가동 시간, 불량률 등 핵심 KPI 계산의 기초 데이터.
-- 주요 조인 키: performance_id.
-- 삭제 정책: 소프트 딜리트. (로그성 데이터 보존을 위해)
--
CREATE TABLE `TB_PRODUCTION_PERFORMANCE` (
  `performance_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '생산 실적 ID (PK)',
  `work_order_id` VARCHAR(36) NOT NULL COMMENT '작업 지시 ID (FK)',
  `item_id` VARCHAR(36) NOT NULL COMMENT '생산 품목 ID (FK)',
  `process_id` VARCHAR(36) NOT NULL COMMENT '실적 공정 ID (FK)',
  `equipment_id` VARCHAR(36) NOT NULL COMMENT '실적 설비 ID (FK)',
  `produced_qty` DECIMAL(10,4) NOT NULL COMMENT '생산 수량',
  `defect_qty` DECIMAL(10,4) DEFAULT 0 COMMENT '불량 수량',
  `start_time` DATETIME NOT NULL COMMENT '작업 시작 시점 (UTC)',
  `end_time` DATETIME NOT NULL COMMENT '작업 종료 시점 (UTC)',
  `worker_id` VARCHAR(50) NULL COMMENT '작업자 ID',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '소프트삭제 플래그',
  `deleted_at` DATETIME NULL COMMENT 'UTC',
  `created_by` VARCHAR(50) NOT NULL COMMENT '최초 생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초 생성 시점 (UTC)',
  `modified_by` VARCHAR(50) NULL COMMENT '최종 수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 시점 (UTC)',
  PRIMARY KEY (`performance_id`),
  KEY `idx_perf_wo_id` (`work_order_id`),
  KEY `idx_perf_item_id` (`item_id`),
  KEY `idx_perf_process_id` (`process_id`),
  KEY `idx_perf_equipment_id` (`equipment_id`),
  KEY `idx_perf_equipment_start_time` (`equipment_id`, `start_time`), -- 조회 패턴: 특정 설비의 기간별 실적 조회
  CONSTRAINT `fk_perf_wo` FOREIGN KEY (`work_order_id`) REFERENCES `TB_WORK_ORDER`(`work_order_id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_perf_item` FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM`(`item_id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_perf_process` FOREIGN KEY (`process_id`) REFERENCES `TB_PROCESS`(`process_id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_perf_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `TB_EQUIPMENT`(`equipment_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='생산 실적: 작업 지시에 대한 생산 결과 및 시간 정보 (UTC)';

--
-- TB_EQUIPMENT_STATUS_LOG (설비 상태 로그)
-- 역할: 설비의 상태 변경 이력.
-- 사용 시나리오: 설비 가동률(OEE) 계산, 비가동 사유 분석.
-- 주요 조인 키: log_id.
-- 삭제 정책: 소프트 딜리트. (로그성 데이터 보존을 위해)
--
CREATE TABLE `TB_EQUIPMENT_STATUS_LOG` (
  `log_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '로그 ID (PK)',
  `equipment_id` VARCHAR(36) NOT NULL COMMENT '설비 ID (FK)',
  `status_code_id` BIGINT NOT NULL COMMENT '설비 상태 코드 ID (FK→TB_CODE)',
  `reason_code_id` BIGINT NULL COMMENT '비가동 사유 코드 ID (FK→TB_CODE) - 상태가 DOWN일 때만 유효',
  `work_order_id` VARCHAR(36) NULL COMMENT '관련 작업 지시 ID (FK) - 선택',
  `shift_id` BIGINT NULL COMMENT '관련 교대 ID (FK) - 선택',
  `start_time` DATETIME NOT NULL COMMENT '상태 시작 시점 (UTC)',
  `end_time` DATETIME NULL COMMENT '상태 종료 시점 (UTC)',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '소프트삭제 플래그',
  `deleted_at` DATETIME NULL COMMENT 'UTC',
  `created_by` VARCHAR(50) NOT NULL COMMENT '최초 생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초 생성 시점 (UTC)',
  `modified_by` VARCHAR(50) NULL COMMENT '최종 수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 시점 (UTC)',
  PRIMARY KEY (`log_id`),
  KEY `idx_log_equipment_id` (`equipment_id`),
  KEY `idx_log_status_code_id` (`status_code_id`),
  KEY `idx_log_reason_code_id` (`reason_code_id`),
  KEY `idx_log_wo_id` (`work_order_id`),
  KEY `idx_log_shift_id` (`shift_id`),
  KEY `idx_log_equipment_start_time` (`equipment_id`, `start_time`), -- 조회 패턴: 특정 설비의 기간별 상태 로그 조회
  CONSTRAINT `fk_log_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `TB_EQUIPMENT`(`equipment_id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_log_status_code` FOREIGN KEY (`status_code_id`) REFERENCES `TB_CODE`(`code_id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_log_reason_code` FOREIGN KEY (`reason_code_id`) REFERENCES `TB_CODE`(`code_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_log_wo` FOREIGN KEY (`work_order_id`) REFERENCES `TB_WORK_ORDER`(`work_order_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_log_shift` FOREIGN KEY (`shift_id`) REFERENCES `TB_SHIFT`(`shift_id`) ON DELETE SET NULL
) ENGINE=InnoDB COMMENT='설비 상태 로그: 설비의 상태 변경 이력 및 비가동 사유 (UTC)';

--
-- TB_INSPECTION (검사)
-- 역할: 품질 검사 활동의 주체.
-- 사용 시나리오: 특정 대상(작업 지시, LOT, 품목)에 대한 검사 이력 관리.
-- 주요 조인 키: inspection_id.
-- 삭제 정책: 소프트 딜리트. (관련 결과/불량 데이터 보존을 위해)
--
CREATE TABLE `TB_INSPECTION` (
  `inspection_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '검사 ID (PK)',
  `work_order_id` VARCHAR(36) NULL COMMENT '검사 대상 작업 지시 ID (FK) - 선택',
  `material_lot_id` VARCHAR(36) NULL COMMENT '검사 대상 자재 LOT ID (FK) - 선택',
  `item_id` VARCHAR(36) NOT NULL COMMENT '검사 대상 품목 ID (FK)',
  `inspection_type_code_id` BIGINT NOT NULL COMMENT '검사 유형 코드 ID (FK→TB_CODE, 예: IN_PROCESS/FINAL)',
  `inspection_time` DATETIME NOT NULL COMMENT '검사 시점 (UTC)',
  `worker_id` VARCHAR(50) NOT NULL COMMENT '검사자 ID',
  `process_id` VARCHAR(36) NULL COMMENT '검사 공정 ID (FK) - 선택',
  `equipment_id` VARCHAR(36) NULL COMMENT '검사 설비 ID (FK) - 선택',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '소프트삭제 플래그',
  `deleted_at` DATETIME NULL COMMENT 'UTC',
  `created_by` VARCHAR(50) NOT NULL COMMENT '최초 생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초 생성 시점 (UTC)',
  `modified_by` VARCHAR(50) NULL COMMENT '최종 수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 시점 (UTC)',
  PRIMARY KEY (`inspection_id`),
  KEY `idx_inspection_wo_id` (`work_order_id`),
  KEY `idx_inspection_lot_id` (`material_lot_id`),
  KEY `idx_inspection_item_id` (`item_id`),
  KEY `idx_inspection_type_code_id` (`inspection_type_code_id`),
  KEY `idx_inspection_process_id` (`process_id`),
  KEY `idx_inspection_equipment_id` (`equipment_id`),
  CONSTRAINT `fk_inspection_wo` FOREIGN KEY (`work_order_id`) REFERENCES `TB_WORK_ORDER`(`work_order_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_inspection_lot` FOREIGN KEY (`material_lot_id`) REFERENCES `TB_MATERIAL_LOT`(`material_lot_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_inspection_item` FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM`(`item_id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_inspection_type_code` FOREIGN KEY (`inspection_type_code_id`) REFERENCES `TB_CODE`(`code_id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_inspection_process` FOREIGN KEY (`process_id`) REFERENCES `TB_PROCESS`(`process_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_inspection_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `TB_EQUIPMENT`(`equipment_id`) ON DELETE SET NULL
) ENGINE=InnoDB COMMENT='품질 검사 활동의 주체 (UTC)';

--
-- TB_INSPECTION_RESULT (검사 결과)
-- 역할: 검사 항목별 측정값.
-- 사용 시나리오: TB_INSPECTION에 종속되며, 검사 항목의 실제 측정값을 기록.
-- 주요 조인 키: result_id.
-- 삭제 정책: 소프트 딜리트. (검사 데이터의 로그성 보존을 위해)
--
CREATE TABLE `TB_INSPECTION_RESULT` (
  `result_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '검사 결과 ID (PK)',
  `inspection_id` BIGINT NOT NULL COMMENT '검사 ID (FK)',
  `item_id` VARCHAR(36) NOT NULL COMMENT '검사 항목 품목 ID (FK)',
  `result_value` VARCHAR(255) NOT NULL COMMENT '측정값 (문자열로 유연하게 처리) 예: 25.43, OK',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '소프트삭제 플래그',
  `deleted_at` DATETIME NULL COMMENT 'UTC',
  `created_by` VARCHAR(50) NOT NULL COMMENT '최초 생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초 생성 시점 (UTC)',
  `modified_by` VARCHAR(50) NULL COMMENT '최종 수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 시점 (UTC)',
  PRIMARY KEY (`result_id`),
  KEY `idx_result_inspection_id` (`inspection_id`),
  KEY `idx_result_item_id` (`item_id`),
  CONSTRAINT `fk_result_inspection` FOREIGN KEY (`inspection_id`) REFERENCES `TB_INSPECTION`(`inspection_id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_result_item` FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM`(`item_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='검사 결과: 검사 항목별 측정값 기록 (UTC)';

--
-- TB_DEFECT (불량)
-- 역할: 검사 시 발생한 불량 기록.
-- 사용 시나리오: 불량률 계산 및 추적, 불량 유형별 분석.
-- 주요 조인 키: defect_id.
-- 삭제 정책: 소프트 딜리트. (불량 데이터의 로그성 보존을 위해)
--
CREATE TABLE `TB_DEFECT` (
  `defect_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '불량 ID (PK)',
  `inspection_id` BIGINT NOT NULL COMMENT '검사 ID (FK)',
  `defect_type_code_id` BIGINT NOT NULL COMMENT '불량 유형 코드 ID (FK→TB_CODE, 예: SCRATCH/DIMENSIONAL)',
  `defect_qty` DECIMAL(10,4) DEFAULT 0 COMMENT '불량 수량',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '소프트삭제 플래그',
  `deleted_at` DATETIME NULL COMMENT 'UTC',
  `created_by` VARCHAR(50) NOT NULL COMMENT '최초 생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초 생성 시점 (UTC)',
  `modified_by` VARCHAR(50) NULL COMMENT '최종 수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 시점 (UTC)',
  PRIMARY KEY (`defect_id`),
  KEY `idx_defect_inspection_id` (`inspection_id`),
  KEY `idx_defect_type_code_id` (`defect_type_code_id`),
  CONSTRAINT `fk_defect_inspection` FOREIGN KEY (`inspection_id`) REFERENCES `TB_INSPECTION`(`inspection_id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_defect_type_code` FOREIGN KEY (`defect_type_code_id`) REFERENCES `TB_CODE`(`code_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='불량 기록: 검사에서 발견된 불량 정보 (UTC)';

--
-- TB_NON_CONFORMANCE (부적합 처리)
-- 역할: 불량에 대한 원인 분석 및 개선 조치 기록.
-- 사용 시나리오: 8D Report 등 품질 개선 활동의 근거 자료.
-- 주요 조인 키: non_conformance_id.
-- 삭제 정책: 소프트 딜리트. (품질 개선 로그 보존)
--
CREATE TABLE `TB_NON_CONFORMANCE` (
  `non_conformance_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '부적합 ID (PK)',
  `defect_id` BIGINT NOT NULL COMMENT '불량 ID (FK)',
  `cause` TEXT NULL COMMENT '부적합 원인',
  `corrective_action` TEXT NULL COMMENT '시정 조치',
  `preventive_action` TEXT NULL COMMENT '예방 조치',
  `report_date` DATETIME NOT NULL COMMENT '보고 일시 (UTC)',
  `worker_id` VARCHAR(50) NOT NULL COMMENT '보고자/담당자 ID',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '소프트삭제 플래그',
  `deleted_at` DATETIME NULL COMMENT 'UTC',
  `created_by` VARCHAR(50) NOT NULL COMMENT '최초 생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초 생성 시점 (UTC)',
  `modified_by` VARCHAR(50) NULL COMMENT '최종 수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 시점 (UTC)',
  PRIMARY KEY (`non_conformance_id`),
  UNIQUE KEY `uk_non_conformance_defect` (`defect_id`),
  KEY `idx_non_conformance_defect_id` (`defect_id`),
  CONSTRAINT `fk_nc_defect` FOREIGN KEY (`defect_id`) REFERENCES `TB_DEFECT`(`defect_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='부적합 처리: 불량의 원인 분석 및 개선 조치 (UTC)';

--
-- TB_KPI_TARGET (KPI 목표)
-- 역할: 설비, 공정, 품목별 핵심 성과 지표(KPI) 목표치.
-- 사용 시나리오: 생산 실적과 비교하여 성과를 측정.
-- 주요 조인 키: target_id.
-- 삭제 정책: 하드 딜리트. (이력 관리 불필요, 변경 시 신규 생성)
--
CREATE TABLE `TB_KPI_TARGET` (
  `target_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '목표 ID (PK)',
  `kpi_date` DATE NOT NULL COMMENT 'KPI 기준 날짜',
  `equipment_id` VARCHAR(36) NOT NULL COMMENT '설비 ID (FK)',
  `process_id` VARCHAR(36) NOT NULL COMMENT '공정 ID (FK)',
  `item_id` VARCHAR(36) NOT NULL COMMENT '품목 ID (FK)',
  `target_oee` DECIMAL(5,2) DEFAULT 0 COMMENT 'OEE 목표치 (%)',
  `target_productivity` DECIMAL(10,4) DEFAULT 0 COMMENT '생산성 목표치 (단위/시간)',
  `target_yield` DECIMAL(5,2) DEFAULT 0 COMMENT '수율 목표치 (%)',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '소프트삭제 플래그',
  `deleted_at` DATETIME NULL COMMENT 'UTC',
  `created_by` VARCHAR(50) NOT NULL COMMENT '최초 생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초 생성 시점 (UTC)',
  `modified_by` VARCHAR(50) NULL COMMENT '최종 수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 시점 (UTC)',
  PRIMARY KEY (`target_id`),
  UNIQUE KEY `uk_kpi_target_kpi_date_eqp_proc_item` (`kpi_date`, `equipment_id`, `process_id`, `item_id`),
  KEY `idx_kpi_target_equipment_id` (`equipment_id`),
  KEY `idx_kpi_target_process_id` (`process_id`),
  KEY `idx_kpi_target_item_id` (`item_id`),
  CONSTRAINT `fk_kpi_target_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `TB_EQUIPMENT`(`equipment_id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_kpi_target_process` FOREIGN KEY (`process_id`) REFERENCES `TB_PROCESS`(`process_id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_kpi_target_item` FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM`(`item_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='KPI 목표: 설비, 공정, 품목별 OEE 등 목표치 (UTC)';

--
-- TB_PRODUCTION_TRACEABILITY (생산 추적성)
-- 역할: 생산에 사용된 모든 자재, 설비, 작업자 정보 추적.
-- 사용 시나리오: 제품에 문제가 생겼을 때, 원인 분석을 위한 역추적. 물리 테이블로 유지.
-- 동기화 전략: 실적(TB_PRODUCTION_PERFORMANCE) 생성 시점 또는 작업 지시 완료 시점에 데이터를 취합하여 동기화.
-- 주요 조인 키: traceability_id.
-- 삭제 정책: 하드 딜리트. (로그성 데이터로, 마스터 데이터 삭제에 영향을 받지 않음)
--
CREATE TABLE `TB_PRODUCTION_TRACEABILITY` (
  `traceability_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '추적성 ID (PK)',
  `work_order_id` VARCHAR(36) NOT NULL COMMENT '작업 지시 ID (FK)',
  `item_id` VARCHAR(36) NOT NULL COMMENT '생산된 품목 ID (FK)',
  `material_lot_id` VARCHAR(36) NULL COMMENT '사용된 자재 LOT ID (FK) - 선택',
  `equipment_id` VARCHAR(36) NOT NULL COMMENT '생산 설비 ID (FK)',
  `worker_id` VARCHAR(50) NOT NULL COMMENT '작업자 ID',
  `production_time` DATETIME NOT NULL COMMENT '생산 완료 시점 (UTC)',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '소프트삭제 플래그',
  `deleted_at` DATETIME NULL COMMENT 'UTC',
  `created_by` VARCHAR(50) NOT NULL COMMENT '최초 생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초 생성 시점 (UTC)',
  `modified_by` VARCHAR(50) NULL COMMENT '최종 수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 시점 (UTC)',
  PRIMARY KEY (`traceability_id`),
  KEY `idx_trace_wo_id` (`work_order_id`),
  KEY `idx_trace_item_id` (`item_id`),
  KEY `idx_trace_lot_id` (`material_lot_id`),
  KEY `idx_trace_equipment_id` (`equipment_id`),
  CONSTRAINT `fk_trace_wo` FOREIGN KEY (`work_order_id`) REFERENCES `TB_WORK_ORDER`(`work_order_id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_trace_item` FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM`(`item_id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_trace_lot` FOREIGN KEY (`material_lot_id`) REFERENCES `TB_MATERIAL_LOT`(`material_lot_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_trace_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `TB_EQUIPMENT`(`equipment_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='생산 추적성: 생산에 투입된 모든 요소의 조합 (UTC)';

--
-- TB_DOCUMENT_MANAGEMENT (문서 관리)
-- 역할: 시스템 내에서 사용되는 문서(예: 작업 표준, 검사 규정) 정보.
-- 사용 시나리오: 작업 지시 등과 연계하여 문서 버전 관리.
-- 주요 조인 키: document_id.
-- 삭제 정책: 소프트 딜리트. (문서 이력 보존)
--
CREATE TABLE `TB_DOCUMENT_MANAGEMENT` (
  `document_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '문서 ID (PK)',
  `doc_type` VARCHAR(50) NOT NULL COMMENT '문서 유형 (예: SOP, WI, QA_SPEC)',
  `doc_name` VARCHAR(255) NOT NULL COMMENT '문서명',
  `file_path` VARCHAR(255) NOT NULL COMMENT '파일 저장 경로',
  `version` VARCHAR(20) NOT NULL COMMENT '버전 정보',
  `approval_status` VARCHAR(20) NOT NULL COMMENT '승인 상태 (예: DRAFT, APPROVED, OBSOLETE)',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '소프트삭제 플래그',
  `deleted_at` DATETIME NULL COMMENT 'UTC',
  `created_by` VARCHAR(50) NOT NULL COMMENT '최초 생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초 생성 시점 (UTC)',
  `modified_by` VARCHAR(50) NULL COMMENT '최종 수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 시점 (UTC)',
  PRIMARY KEY (`document_id`)
) ENGINE=InnoDB COMMENT='문서 관리: 작업 지시, 품질 검사 등에 사용되는 문서 정보 (UTC)';

--
-- TB_LOG (시스템 로그)
-- 역할: 시스템의 주요 이벤트 및 작업 이력.
-- 사용 시나리오: 문제 발생 시 원인 분석, 감사 추적.
-- 주요 조인 키: log_id.
-- 삭제 정책: 하드 딜리트. (정기적 데이터 이관/파기)
--
CREATE TABLE `TB_LOG` (
  `log_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '로그 ID (PK)',
  `log_type` VARCHAR(50) NOT NULL COMMENT '로그 유형 (예: ERROR, INFO, AUDIT)',
  `message` TEXT NOT NULL COMMENT '로그 메시지 내용',
  `user_id` VARCHAR(50) NULL COMMENT '관련 사용자 ID - 선택',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '소프트삭제 플래그',
  `deleted_at` DATETIME NULL COMMENT 'UTC',
  `created_by` VARCHAR(50) NOT NULL COMMENT '최초 생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초 생성 시점 (UTC)',
  `modified_by` VARCHAR(50) NULL COMMENT '최종 수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 시점 (UTC)',
  PRIMARY KEY (`log_id`),
  KEY `idx_log_user_id` (`user_id`)
) ENGINE=InnoDB COMMENT='시스템 로그: 주요 시스템 이벤트 및 감사 기록 (UTC)';

--
-- 시드 데이터 (Seed Data)
--
-- 아래는 시스템 가동에 필요한 최소한의 초기 데이터입니다.
-- DDL 스크립트 실행 후 별도로 실행하여 데이터를 채워 넣을 수 있습니다.
--

-- TB_CODE_GROUP 시드 데이터
INSERT INTO `TB_CODE_GROUP` (`group_code`, `group_name`, `created_by`) VALUES
('EQP_STATUS', '설비 상태', 'system'),
('DOWNTIME_REASON', '비가동 사유', 'system'),
('INSPECTION_TYPE', '검사 유형', 'system'),
('WO_STATUS', '작업지시 상태', 'system'),
('PLAN_STATUS', '생산 계획 상태', 'system'),
('DEFECT_TYPE', '불량 유형', 'system');

-- TB_CODE 시드 데이터 (EQP_STATUS)
INSERT INTO `TB_CODE` (`group_code`, `code`, `name`, `use_yn`, `created_by`) VALUES
('EQP_STATUS', 'RUN', '가동', 'Y', 'system'),
('EQP_STATUS', 'IDLE', '유휴', 'Y', 'system'),
('EQP_STATUS', 'DOWN', '비가동', 'Y', 'system');

-- TB_CODE 시드 데이터 (DOWNTIME_REASON)
INSERT INTO `TB_CODE` (`group_code`, `code`, `name`, `use_yn`, `created_by`) VALUES
('DOWNTIME_REASON', 'PLANNED', '계획 비가동', 'Y', 'system'),
('DOWNTIME_REASON', 'UNPLANNED', '계획 외 비가동', 'Y', 'system'),
('DOWNTIME_REASON', 'SETUP', '셋업', 'Y', 'system');

-- TB_CODE 시드 데이터 (INSPECTION_TYPE)
INSERT INTO `TB_CODE` (`group_code`, `code`, `name`, `use_yn`, `created_by`) VALUES
('INSPECTION_TYPE', 'FIRST_ARTICLE', '초도품 검사', 'Y', 'system'),
('INSPECTION_TYPE', 'IN_PROCESS', '공정 중 검사', 'Y', 'system'),
('INSPECTION_TYPE', 'FINAL', '최종 검사', 'Y', 'system');

-- TB_CODE 시드 데이터 (WO_STATUS)
INSERT INTO `TB_CODE` (`group_code`, `code`, `name`, `use_yn`, `created_by`) VALUES
('WO_STATUS', 'P', '계획', 'Y', 'system'),
('WO_STATUS', 'R', '실행 중', 'Y', 'system'),
('WO_STATUS', 'C', '완료', 'Y', 'system');

-- TB_CODE 시드 데이터 (PLAN_STATUS)
INSERT INTO `TB_CODE` (`group_code`, `code`, `name`, `use_yn`, `created_by`) VALUES
('PLAN_STATUS', 'DRAFT', '초안', 'Y', 'system'),
('PLAN_STATUS', 'APPROVED', '승인', 'Y', 'system'),
('PLAN_STATUS', 'COMPLETED', '완료', 'Y', 'system');

-- TB_CODE 시드 데이터 (DEFECT_TYPE)
INSERT INTO `TB_CODE` (`group_code`, `code`, `name`, `use_yn`, `created_by`) VALUES
('DEFECT_TYPE', 'SCRATCH', '스크래치', 'Y', 'system'),
('DEFECT_TYPE', 'DIMENSIONAL', '치수 불량', 'Y', 'system'),
('DEFECT_TYPE', 'COLOR', '색상 불량', 'Y', 'system');

-- TB_SHIFT 시드 데이터
INSERT INTO `TB_SHIFT` (`shift_code`, `shift_name`, `start_time`, `end_time`, `created_by`) VALUES
('A', '주간조', '06:00:00', '14:00:00', 'system'),
('B', '오후조', '14:00:00', '22:00:00', 'system'),
('C', '야간조', '22:00:00', '06:00:00', 'system');

-- TB_WORKSHOP 시드 데이터 (TB_WORKCENTER의 FK를 위한 사전 데이터)
INSERT INTO `TB_WORKSHOP` (`workshop_id`, `workshop_name`, `created_by`) VALUES
('9670081d-e07e-4b8f-8c34-7a9a3f3b97b0', '제1작업장', 'system');

-- TB_WORKCENTER 시드 데이터 (TB_EQUIPMENT의 FK를 위한 사전 데이터)
INSERT INTO `TB_WORKCENTER` (`workcenter_id`, `workcenter_name`, `workshop_id`, `created_by`) VALUES
('7b0d7718-052b-4d4b-9706-e7e1f9a1f11a', '스텐트 제조라인', '9670081d-e07e-4b8f-8c34-7a9a3f3b97b0', 'system');

-- TB_PROCESS 시드 데이터 (TB_EQUIPMENT의 FK를 위한 사전 데이터)
INSERT INTO `TB_PROCESS` (`process_id`, `process_name`, `created_by`) VALUES
('a9254c46-9d21-432a-928d-192a0e2a2205', '성형 공정', 'system'),
('d5d0824b-3d60-4e41-a987-9b2f2c8a14b5', '코팅 공정', 'system');

-- TB_ITEM 시드 데이터 (TB_EQUIPMENT의 FK를 위한 사전 데이터)
INSERT INTO `TB_ITEM` (`item_id`, `item_code`, `item_name`, `item_type`, `unit`, `created_by`) VALUES
('f8d9c225-b1a7-471a-969c-6a1b2e2d0f5e', 'ITEM-001', '의료용 스텐트', 'F', 'EA', 'system');

-- TB_WAREHOUSE 시드 데이터
INSERT INTO `TB_WAREHOUSE` (`warehouse_id`, `warehouse_name`, `created_by`) VALUES
('e8c9b13c-5e4a-4a2f-98c4-1a9c3d4a2b9f', '원자재 창고', 'system');

-- TB_EQUIPMENT 시드 데이터 (TB_SHIFT_CALENDAR의 FK를 위한 사전 데이터)
INSERT INTO `TB_EQUIPMENT` (`equipment_id`, `equipment_name`, `workcenter_id`, `process_id`, `status_code_id`, `created_by`) VALUES
('c2d5349e-f0b3-4f93-b247-5a1e2f3d9c7a', 'STENT_LINE_01', '7b0d7718-052b-4d4b-9706-e7e1f9a1f11a', 'a9254c46-9d21-432a-928d-192a0e2a2205', 1, 'system');

-- TB_SHIFT_CALENDAR 시드 데이터
INSERT INTO `TB_SHIFT_CALENDAR` (`shift_date`, `shift_id`, `equipment_id`, `workcenter_id`, `start_ts`, `end_ts`, `created_by`) VALUES
('2025-08-08', 1, 'c2d5349e-f0b3-4f93-b247-5a1e2f3d9c7a', NULL, '2025-08-08 06:00:00', '2025-08-08 14:00:00', 'system'),
('2025-08-08', 2, 'c2d5349e-f0b3-4f93-b247-5a1e2f3d9c7a', NULL, '2025-08-08 14:00:00', '2025-08-08 22:00:00', 'system'),
('2025-08-08', 3, 'c2d5349e-f0b3-4f93-b247-5a1e2f3d9c7a', NULL, '2025-08-08 22:00:00', '2025-08-09 06:00:00', 'system');
