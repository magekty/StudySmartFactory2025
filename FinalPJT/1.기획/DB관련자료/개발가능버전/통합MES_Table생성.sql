-- -----------------------------------------------------
-- Database 생성
-- -----------------------------------------------------
CREATE DATABASE IF NOT EXISTS `mes_pjt_test` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `mes_pjt_test`;


-- -----------------------------------------------------
-- 1단계: 기준 정보 (가장 의존성이 낮은 테이블)
-- -----------------------------------------------------
-- Table `TB_ROLE` (역할 마스터)
CREATE TABLE IF NOT EXISTS `TB_ROLE` (
  `role_id` VARCHAR(50) NOT NULL COMMENT '역할 ID',
  `role_name` VARCHAR(50) NULL COMMENT '역할명',
  `description` TEXT NULL COMMENT '설명',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='역할 마스터';

-- Table `TB_CODE_GROUP` (코드 그룹)
CREATE TABLE IF NOT EXISTS `TB_CODE_GROUP` (
  `code_group_id` VARCHAR(50) NOT NULL COMMENT '코드 그룹 ID',
  `group_name` VARCHAR(100) NULL COMMENT '그룹명',
  PRIMARY KEY (`code_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='코드 그룹';

-- Table `TB_ITEM` (품목 마스터)
CREATE TABLE IF NOT EXISTS `TB_ITEM` (
  `item_id` VARCHAR(50) NOT NULL COMMENT '품목 ID',
  `item_name` VARCHAR(100) NOT NULL COMMENT '품목명',
  `item_type` VARCHAR(20) NULL COMMENT '품목 유형',
  `unit` VARCHAR(10) NULL COMMENT '단위',
  `description` TEXT NULL COMMENT '설명',
  `created_by` VARCHAR(50) NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 일시',
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='품목 마스터';

-- Table `TB_SUPPLIER` (공급처 마스터)
CREATE TABLE IF NOT EXISTS `TB_SUPPLIER` (
  `supplier_id` VARCHAR(50) NOT NULL COMMENT '공급처 ID',
  `supplier_name` VARCHAR(100) NULL COMMENT '공급처명',
  `contact_info` TEXT NULL COMMENT '연락처 정보',
  `created_by` VARCHAR(50) NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 일시',
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='공급처 마스터';

-- Table `TB_PROCESS` (공정 마스터)
CREATE TABLE IF NOT EXISTS `TB_PROCESS` (
  `process_id` VARCHAR(50) NOT NULL COMMENT '공정 ID',
  `process_name` VARCHAR(100) NULL COMMENT '공정명',
  `description` TEXT NULL COMMENT '설명',
  `created_by` VARCHAR(50) NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 일시',
  PRIMARY KEY (`process_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='공정 마스터';

-- Table `TB_WORKCENTER` (작업장 마스터)
CREATE TABLE IF NOT EXISTS `TB_WORKCENTER` (
  `workcenter_id` VARCHAR(50) NOT NULL COMMENT '작업장 ID',
  `workcenter_name` VARCHAR(100) NULL COMMENT '작업장명',
  `location` VARCHAR(100) NULL COMMENT '위치',
  `created_by` VARCHAR(50) NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 일시',
  PRIMARY KEY (`workcenter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='작업장 마스터';

-- Table `TB_WAREHOUSE` (창고 마스터)
CREATE TABLE IF NOT EXISTS `TB_WAREHOUSE` (
  `warehouse_id` VARCHAR(50) NOT NULL COMMENT '창고 ID',
  `warehouse_name` VARCHAR(100) NOT NULL COMMENT '창고명',
  `location` VARCHAR(100) NULL COMMENT '위치',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
  PRIMARY KEY (`warehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='창고 마스터';

-- Table `TB_LINE` (생산 라인)
CREATE TABLE IF NOT EXISTS `TB_LINE` (
  `line_id` VARCHAR(50) NOT NULL COMMENT '라인 ID',
  `line_name` VARCHAR(100) NOT NULL COMMENT '라인명',
  `description` TEXT NULL COMMENT '설명',
  `created_by` VARCHAR(50) NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 일시',
  PRIMARY KEY (`line_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='생산 라인';

-- Table `TB_CUSTOMER` (고객 정보)
CREATE TABLE IF NOT EXISTS `TB_CUSTOMER` (
  `customer_id` VARCHAR(50) NOT NULL COMMENT '고객 ID',
  `customer_name` VARCHAR(100) NOT NULL COMMENT '고객사 명',
  `contact_person` VARCHAR(50) NULL COMMENT '담당자',
  `phone_number` VARCHAR(20) NULL COMMENT '연락처',
  `email` VARCHAR(100) NULL COMMENT '이메일',
  `address` VARCHAR(255) NULL COMMENT '주소',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_date` DATETIME NOT NULL COMMENT '생성 일시',
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '삭제 여부 (0:N, 1:Y)',
  `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
  `last_modified_date` DATETIME NOT NULL COMMENT '최종 수정 일시',
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='고객 정보';

-- -----------------------------------------------------
-- 2단계: 1단계 테이블을 참조하는 테이블
-- -----------------------------------------------------
-- Table `TB_CODE` (공통 코드)
CREATE TABLE IF NOT EXISTS `TB_CODE` (
  `code_id` VARCHAR(50) NOT NULL COMMENT '코드 ID',
  `code_group_id` VARCHAR(50) NULL COMMENT '코드 그룹 ID (FK: TB_CODE_GROUP)',
  `code_name` VARCHAR(100) NULL COMMENT '코드명',
  PRIMARY KEY (`code_id`),
  CONSTRAINT `fk_code_group` FOREIGN KEY (`code_group_id`) REFERENCES `TB_CODE_GROUP` (`code_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='공통 코드';

-- Table `TB_USER` (사용자 마스터)
CREATE TABLE IF NOT EXISTS `TB_USER` (
  `user_id` VARCHAR(50) NOT NULL COMMENT '사용자 ID',
  `user_name` VARCHAR(100) NULL COMMENT '사용자명',
  `email` VARCHAR(100) NULL COMMENT '이메일',
  `password` VARCHAR(255) NULL COMMENT '비밀번호',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
  `modified_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 일시',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='사용자 마스터';

-- Table `TB_USER_ROLE` (사용자-역할 관계)
CREATE TABLE IF NOT EXISTS `TB_USER_ROLE` (
  `user_id` VARCHAR(50) NOT NULL COMMENT '사용자 ID (FK: TB_USER)',
  `role_id` VARCHAR(50) NOT NULL COMMENT '역할 ID (FK: TB_ROLE)',
  PRIMARY KEY (`user_id`, `role_id`),
  CONSTRAINT `fk_user_role_user` FOREIGN KEY (`user_id`) REFERENCES `TB_USER` (`user_id`),
  CONSTRAINT `fk_user_role_role` FOREIGN KEY (`role_id`) REFERENCES `TB_ROLE` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='사용자-역할 관계';

-- Table `TB_MATERIAL` (자재 마스터)
CREATE TABLE IF NOT EXISTS `TB_MATERIAL` (
  `material_id` VARCHAR(50) NOT NULL COMMENT '자재 ID',
  `material_name` VARCHAR(100) NOT NULL COMMENT '자재명',
  `unit` VARCHAR(20) NULL COMMENT '단위 (EA, kg 등)',
  `supplier_id` VARCHAR(50) NULL COMMENT '공급처 ID (FK: TB_SUPPLIER)',
  PRIMARY KEY (`material_id`),
  CONSTRAINT `fk_material_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `TB_SUPPLIER` (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='자재 마스터';

-- Table `TB_PRODUCTION_PLAN` (생산 계획)
CREATE TABLE IF NOT EXISTS `TB_PRODUCTION_PLAN` (
  `plan_id` VARCHAR(50) NOT NULL COMMENT '계획 ID',
  `item_id` VARCHAR(50) NULL COMMENT '품목 ID (FK: TB_ITEM)',
  `plan_date` DATE NULL COMMENT '계획 일자',
  `quantity` INT NULL COMMENT '계획 수량',
  `status` VARCHAR(20) NULL COMMENT '계획 상태',
  `created_by` VARCHAR(50) NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 일시',
  PRIMARY KEY (`plan_id`),
  CONSTRAINT `fk_plan_item` FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='생산 계획';

-- Table `TB_PROCESS_ROUTE` (공정 라우팅)
CREATE TABLE IF NOT EXISTS `TB_PROCESS_ROUTE` (
  `route_id` VARCHAR(50) NOT NULL COMMENT '라우트 ID',
  `item_id` VARCHAR(50) NULL COMMENT '품목 ID (FK: TB_ITEM)',
  `process_seq` INT NULL COMMENT '공정 순서',
  `process_id` VARCHAR(50) NULL COMMENT '공정 ID (FK: TB_PROCESS)',
  `workcenter_id` VARCHAR(50) NULL COMMENT '작업장 ID (FK: TB_WORKCENTER)',
  PRIMARY KEY (`route_id`),
  CONSTRAINT `fk_route_item` FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM` (`item_id`),
  CONSTRAINT `fk_route_process` FOREIGN KEY (`process_id`) REFERENCES `TB_PROCESS` (`process_id`),
  CONSTRAINT `fk_route_workcenter` FOREIGN KEY (`workcenter_id`) REFERENCES `TB_WORKCENTER` (`workcenter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='공정 라우팅';

-- Table `TB_EQUIPMENT` (설비 마스터)
CREATE TABLE IF NOT EXISTS `TB_EQUIPMENT` (
  `equipment_id` VARCHAR(50) NOT NULL COMMENT '설비 ID',
  `equipment_name` VARCHAR(100) NULL COMMENT '설비명',
  `line_id` VARCHAR(50) NULL COMMENT '라인 ID (FK: TB_LINE)',
  `workcenter_id` VARCHAR(50) NULL COMMENT '작업장 ID (FK: TB_WORKCENTER)',
  `created_by` VARCHAR(50) NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
  PRIMARY KEY (`equipment_id`),
  CONSTRAINT `fk_equip_line` FOREIGN KEY (`line_id`) REFERENCES `TB_LINE` (`line_id`),
  CONSTRAINT `fk_equip_workcenter` FOREIGN KEY (`workcenter_id`) REFERENCES `TB_WORKCENTER` (`workcenter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='설비 마스터';

-- Table `TB_SHIPPING_ORDER` (출하 지시)
CREATE TABLE IF NOT EXISTS `TB_SHIPPING_ORDER` (
  `shipping_order_id` VARCHAR(50) NOT NULL COMMENT '출하 지시 ID',
  `customer_id` VARCHAR(50) NOT NULL COMMENT '고객 ID (FK: TB_CUSTOMER)',
  `shipping_status` VARCHAR(20) NOT NULL DEFAULT 'PENDING' COMMENT '출하 상태 (PENDING, IN_PROGRESS, SHIPPED, CANCELED)',
  `order_date` DATETIME NOT NULL COMMENT '주문 일자',
  `shipping_date` DATETIME NULL COMMENT '실제 출하 일자',
  `delivery_address` VARCHAR(255) NULL COMMENT '배송 주소',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_date` DATETIME NOT NULL COMMENT '생성 일시',
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '삭제 여부 (0:N, 1:Y)',
  `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
  `last_modified_date` DATETIME NOT NULL COMMENT '최종 수정 일시',
  PRIMARY KEY (`shipping_order_id`),
  CONSTRAINT `fk_shipping_order_customer` FOREIGN KEY (`customer_id`) REFERENCES `TB_CUSTOMER` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='출하 지시';

-- Table `TB_INSPECTION` (검사 기준)
CREATE TABLE IF NOT EXISTS `TB_INSPECTION` (
  `inspection_id` VARCHAR(50) NOT NULL COMMENT '검사 ID',
  `process_id` VARCHAR(50) NOT NULL COMMENT '공정 ID (FK: TB_PROCESS)',
  `item_id` VARCHAR(50) NOT NULL COMMENT '품목 ID (FK: TB_ITEM)',
  `inspection_type` VARCHAR(50) NOT NULL COMMENT '검사 유형 (예: 초중종검)',
  `criteria` TEXT NULL COMMENT '검사 기준',
  `created_by` VARCHAR(50) NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
  PRIMARY KEY (`inspection_id`),
  CONSTRAINT `fk_inspection_process` FOREIGN KEY (`process_id`) REFERENCES `TB_PROCESS` (`process_id`),
  CONSTRAINT `fk_inspection_item` FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='검사 기준';


-- -----------------------------------------------------
-- 3단계: 2단계 테이블을 참조하는 테이블
-- -----------------------------------------------------
-- Table `TB_WORK_ORDER` (작업 지시)
CREATE TABLE IF NOT EXISTS `TB_WORK_ORDER` (
  `work_order_id` VARCHAR(50) NOT NULL COMMENT '작업 지시 ID',
  `plan_id` VARCHAR(50) NULL COMMENT '계획 ID (FK: TB_PRODUCTION_PLAN)',
  `process_id` VARCHAR(50) NULL COMMENT '공정 ID (FK: TB_PROCESS)',
  `workcenter_id` VARCHAR(50) NULL COMMENT '작업장 ID (FK: TB_WORKCENTER)',
  `quantity` INT NULL COMMENT '지시 수량',
  `start_date` DATETIME NULL COMMENT '시작 예정일',
  `end_date` DATETIME NULL COMMENT '완료 예정일',
  `status` VARCHAR(20) NULL COMMENT '지시 상태',
  `created_by` VARCHAR(50) NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 일시',
  PRIMARY KEY (`work_order_id`),
  CONSTRAINT `fk_work_order_plan` FOREIGN KEY (`plan_id`) REFERENCES `TB_PRODUCTION_PLAN` (`plan_id`),
  CONSTRAINT `fk_work_order_process` FOREIGN KEY (`process_id`) REFERENCES `TB_PROCESS` (`process_id`),
  CONSTRAINT `fk_work_order_workcenter` FOREIGN KEY (`workcenter_id`) REFERENCES `TB_WORKCENTER` (`workcenter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='작업 지시';

-- Table `TB_PRODUCTION_ORDER` (생산 지시)
CREATE TABLE IF NOT EXISTS `TB_PRODUCTION_ORDER` (
  `production_order_id` VARCHAR(50) NOT NULL COMMENT '생산 지시 ID',
  `work_order_id` VARCHAR(50) NOT NULL COMMENT '작업 지시 ID (FK: TB_WORK_ORDER)',
  `route_id` VARCHAR(50) NULL COMMENT '공정 라우팅 ID (FK: TB_PROCESS_ROUTE)',
  `order_quantity` INT NULL COMMENT '지시 수량',
  `order_status` VARCHAR(20) NULL COMMENT '지시 상태',
  `created_by` VARCHAR(50) NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 일시',
  PRIMARY KEY (`production_order_id`),
  CONSTRAINT `fk_prod_order_work_order` FOREIGN KEY (`work_order_id`) REFERENCES `TB_WORK_ORDER` (`work_order_id`),
  CONSTRAINT `fk_prod_order_route` FOREIGN KEY (`route_id`) REFERENCES `TB_PROCESS_ROUTE` (`route_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='생산 지시';

-- Table `TB_INVENTORY` (자재 재고)
CREATE TABLE IF NOT EXISTS `TB_INVENTORY` (
  `item_id` VARCHAR(50) NOT NULL COMMENT '자재 ID (FK: TB_ITEM)',
  `lot_number` VARCHAR(100) NOT NULL COMMENT 'LOT 번호',
  `location_code` VARCHAR(50) NOT NULL COMMENT '창고 위치 코드 (FK: TB_WAREHOUSE)',
  `quantity` DECIMAL(10,4) NOT NULL DEFAULT 0 COMMENT '재고 수량',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_date` DATETIME NOT NULL COMMENT '생성 일시',
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '삭제 여부 (0:N, 1:Y)',
  `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
  `last_modified_date` DATETIME NOT NULL COMMENT '최종 수정 일시',
  PRIMARY KEY (`item_id`, `lot_number`),
  CONSTRAINT `fk_inventory_item` FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM` (`item_id`),
  CONSTRAINT `fk_inventory_location` FOREIGN KEY (`location_code`) REFERENCES `TB_WAREHOUSE` (`warehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='자재 재고';

-- Table `TB_EQUIPMENT_STATUS` (설비 상태)
CREATE TABLE IF NOT EXISTS `TB_EQUIPMENT_STATUS` (
  `equipment_id` VARCHAR(50) NOT NULL COMMENT '설비 ID (FK: TB_EQUIPMENT)',
  `status` VARCHAR(20) NULL COMMENT '설비 상태',
  `last_checked` DATETIME NULL COMMENT '최종 확인 일시',
  PRIMARY KEY (`equipment_id`),
  CONSTRAINT `fk_status_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `TB_EQUIPMENT` (`equipment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='설비 상태';


-- -----------------------------------------------------
-- 4단계: 3단계 테이블을 참조하는 테이블
-- -----------------------------------------------------
-- Table `TB_OPERATION_LOG` (작업 이력)
CREATE TABLE IF NOT EXISTS `TB_OPERATION_LOG` (
  `log_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '로그 ID',
  `work_order_id` VARCHAR(50) NULL COMMENT '작업 지시 ID (FK: TB_WORK_ORDER)',
  `user_id` VARCHAR(50) NULL COMMENT '사용자 ID (FK: TB_USER)',
  `start_time` DATETIME NULL COMMENT '작업 시작 시간',
  `end_time` DATETIME NULL COMMENT '작업 종료 시간',
  `result_quantity` INT NULL COMMENT '생산 수량',
  `defect_quantity` INT NULL COMMENT '불량 수량',
  `note` TEXT NULL COMMENT '비고',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
  PRIMARY KEY (`log_id`),
  CONSTRAINT `fk_log_work_order` FOREIGN KEY (`work_order_id`) REFERENCES `TB_WORK_ORDER` (`work_order_id`),
  CONSTRAINT `fk_log_user` FOREIGN KEY (`user_id`) REFERENCES `TB_USER` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='작업 이력';

-- Table `TB_PRODUCTION_PERFORMANCE` (생산 실적)
CREATE TABLE IF NOT EXISTS `TB_PRODUCTION_PERFORMANCE` (
  `performance_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '실적 ID',
  `production_order_id` VARCHAR(50) NOT NULL COMMENT '생산 지시 ID (FK: TB_PRODUCTION_ORDER)',
  `item_id` VARCHAR(50) NOT NULL COMMENT '품목 ID (FK: TB_ITEM)',
  `operation_code_group` VARCHAR(50) NOT NULL COMMENT '공정 공통 코드 그룹',
  `operation_code` VARCHAR(50) NOT NULL COMMENT '공정 코드',
  `prod_qty` DECIMAL(10,4) NOT NULL COMMENT '생산 수량 (양품)',
  `defect_qty` DECIMAL(10,4) NOT NULL DEFAULT 0 COMMENT '불량 수량',
  `worker_id` VARCHAR(50) NOT NULL COMMENT '작업자 ID (FK: TB_USER)',
  `start_time` DATETIME NOT NULL COMMENT '작업 시작 일시',
  `end_time` DATETIME NOT NULL COMMENT '작업 종료 일시',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_date` DATETIME NOT NULL COMMENT '생성 일시',
  `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
  `last_modified_date` DATETIME NOT NULL COMMENT '최종 수정 일시',
  PRIMARY KEY (`performance_id`),
  CONSTRAINT `fk_perf_prod_order` FOREIGN KEY (`production_order_id`) REFERENCES `TB_PRODUCTION_ORDER` (`production_order_id`),
  CONSTRAINT `fk_perf_item` FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM` (`item_id`),
  CONSTRAINT `fk_perf_worker` FOREIGN KEY (`worker_id`) REFERENCES `TB_USER` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='생산 실적';

-- Table `TB_DAILY_WORK_REPORT` (작업 일보)
CREATE TABLE IF NOT EXISTS `TB_DAILY_WORK_REPORT` (
  `report_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '보고서 ID',
  `report_date` DATE NOT NULL COMMENT '보고서 날짜',
  `line_id` VARCHAR(50) NOT NULL COMMENT '라인 ID (FK: TB_LINE)',
  `workplace_id` VARCHAR(50) NULL COMMENT '작업장 ID (FK: TB_WORKPLACE)',
  `total_prod_qty` DECIMAL(10,4) NOT NULL COMMENT '총 생산 수량',
  `total_defect_qty` DECIMAL(10,4) NOT NULL COMMENT '총 불량 수량',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_date` DATETIME NOT NULL COMMENT '생성 일시',
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '삭제 여부 (0:N, 1:Y)',
  `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
  `last_modified_date` DATETIME NOT NULL COMMENT '최종 수정 일시',
  PRIMARY KEY (`report_id`),
  CONSTRAINT `fk_report_line` FOREIGN KEY (`line_id`) REFERENCES `TB_LINE` (`line_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='작업 일보';

-- Table `TB_INSPECTION_RESULT` (검사 결과)
CREATE TABLE IF NOT EXISTS `TB_INSPECTION_RESULT` (
  `result_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '검사 결과 ID',
  `inspection_id` VARCHAR(50) NOT NULL COMMENT '검사 기준 ID (FK: TB_INSPECTION)',
  `work_order_id` VARCHAR(50) NOT NULL COMMENT '작업지시 ID (FK: TB_WORK_ORDER)',
  `result` VARCHAR(50) NOT NULL COMMENT '검사 결과 (합격/불합격 등)',
  `defect_desc` TEXT NULL COMMENT '결함 설명',
  `inspected_by` VARCHAR(50) NULL COMMENT '검사자',
  `inspected_at` DATETIME NULL COMMENT '검사 일시',
  PRIMARY KEY (`result_id`),
  CONSTRAINT `fk_result_inspection` FOREIGN KEY (`inspection_id`) REFERENCES `TB_INSPECTION` (`inspection_id`),
  CONSTRAINT `fk_result_work_order` FOREIGN KEY (`work_order_id`) REFERENCES `TB_WORK_ORDER` (`work_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='검사 결과';

-- Table `TB_EQUIPMENT_CHECK` (설비 점검 이력)
CREATE TABLE IF NOT EXISTS `TB_EQUIPMENT_CHECK` (
  `check_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '점검 ID',
  `equipment_id` VARCHAR(50) NULL COMMENT '설비 ID (FK: TB_EQUIPMENT)',
  `check_date` DATE NULL COMMENT '점검 날짜',
  `check_result` VARCHAR(20) NULL COMMENT '점검 결과',
  `note` TEXT NULL COMMENT '비고',
  `checked_by` VARCHAR(50) NULL COMMENT '점검자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
  PRIMARY KEY (`check_id`),
  CONSTRAINT `fk_check_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `TB_EQUIPMENT` (`equipment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='설비 점검 이력';

-- Table `TB_EQUIPMENT_MAINTENANCE_LOG` (설비 보전 이력)
CREATE TABLE IF NOT EXISTS `TB_EQUIPMENT_MAINTENANCE_LOG` (
  `maintenance_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '보전 ID',
  `equipment_id` VARCHAR(50) NULL COMMENT '설비 ID (FK: TB_EQUIPMENT)',
  `maintenance_date` DATETIME NULL COMMENT '보전 일시',
  `type` VARCHAR(50) NULL COMMENT '보전 유형',
  `note` TEXT NULL COMMENT '비고',
  `maintained_by` VARCHAR(50) NULL COMMENT '보전 담당자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
  PRIMARY KEY (`maintenance_id`),
  CONSTRAINT `fk_maintenance_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `TB_EQUIPMENT` (`equipment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='설비 보전 이력';

-- Table `TB_EQUIPMENT_SENSOR_LOG` (설비 센서 로그)
CREATE TABLE IF NOT EXISTS `TB_EQUIPMENT_SENSOR_LOG` (
  `log_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '로그 ID',
  `equipment_id` VARCHAR(50) NULL COMMENT '설비 ID (FK: TB_EQUIPMENT)',
  `sensor_type` VARCHAR(50) NULL COMMENT '센서 유형',
  `value` DECIMAL(10, 2) NULL COMMENT '센서 값',
  `logged_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '로그 기록 일시',
  PRIMARY KEY (`log_id`),
  CONSTRAINT `fk_sensor_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `TB_EQUIPMENT` (`equipment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='설비 센서 로그';

-- Table `TB_MATERIAL_INPUT` (자재 입고 이력)
CREATE TABLE IF NOT EXISTS `TB_MATERIAL_INPUT` (
  `input_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '입고 ID',
  `material_id` VARCHAR(50) NOT NULL COMMENT '자재 ID (FK: TB_MATERIAL)',
  `warehouse_id` VARCHAR(50) NOT NULL COMMENT '입고 창고 ID (FK: TB_WAREHOUSE)',
  `quantity` INT NOT NULL COMMENT '입고 수량',
  `input_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '입고 일시',
  PRIMARY KEY (`input_id`),
  CONSTRAINT `fk_input_material` FOREIGN KEY (`material_id`) REFERENCES `TB_MATERIAL` (`material_id`),
  CONSTRAINT `fk_input_warehouse` FOREIGN KEY (`warehouse_id`) REFERENCES `TB_WAREHOUSE` (`warehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='자재 입고 이력';

-- Table `TB_MATERIAL_OUTPUT` (자재 출고 이력)
CREATE TABLE IF NOT EXISTS `TB_MATERIAL_OUTPUT` (
  `output_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '출고 ID',
  `material_id` VARCHAR(50) NOT NULL COMMENT '자재 ID (FK: TB_MATERIAL)',
  `warehouse_id` VARCHAR(50) NOT NULL COMMENT '출고 창고 ID (FK: TB_WAREHOUSE)',
  `quantity` INT NOT NULL COMMENT '출고 수량',
  `output_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '출고 일시',
  PRIMARY KEY (`output_id`),
  CONSTRAINT `fk_output_material` FOREIGN KEY (`material_id`) REFERENCES `TB_MATERIAL` (`material_id`),
  CONSTRAINT `fk_output_warehouse` FOREIGN KEY (`warehouse_id`) REFERENCES `TB_WAREHOUSE` (`warehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='자재 출고 이력';

-- Table `TB_MATERIAL_LOT` (자재 LOT 정보)
CREATE TABLE IF NOT EXISTS `TB_MATERIAL_LOT` (
  `lot_id` VARCHAR(50) NOT NULL COMMENT '자재 LOT 번호',
  `material_id` VARCHAR(50) NOT NULL COMMENT '자재 ID (FK: TB_MATERIAL)',
  `quantity` INT NOT NULL DEFAULT 0 COMMENT 'LOT 보유 수량',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
  PRIMARY KEY (`lot_id`),
  CONSTRAINT `fk_lot_material` FOREIGN KEY (`material_id`) REFERENCES `TB_MATERIAL` (`material_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='자재 LOT 정보';

-- -----------------------------------------------------
-- 5단계: 최종 단계 (가장 의존성이 높은 테이블)
-- -----------------------------------------------------
-- Table `TB_DEFECT` (불량 정보)
CREATE TABLE IF NOT EXISTS `TB_DEFECT` (
  `defect_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '불량 ID',
  `result_id` BIGINT NOT NULL COMMENT '검사 결과 ID (FK: TB_INSPECTION_RESULT)',
  `defect_type` VARCHAR(50) NULL COMMENT '불량 유형',
  `action_taken` TEXT NULL COMMENT '조치 내용',
  PRIMARY KEY (`defect_id`),
  CONSTRAINT `fk_defect_result` FOREIGN KEY (`result_id`) REFERENCES `TB_INSPECTION_RESULT` (`result_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='불량 정보';

-- Table `TB_TRACEABILITY_LOG` (추적 이력)
CREATE TABLE IF NOT EXISTS `TB_TRACEABILITY_LOG` (
  `trace_log_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '추적 이력 ID',
  `work_order_id` VARCHAR(50) NOT NULL COMMENT '작업 지시 ID (FK: TB_WORK_ORDER)',
  `production_order_id` VARCHAR(50) NOT NULL COMMENT '생산 지시 ID (FK: TB_PRODUCTION_ORDER)',
  `operation_code_group` VARCHAR(50) NOT NULL COMMENT '공정 공통 코드 그룹',
  `operation_code` VARCHAR(50) NOT NULL COMMENT '공정 코드 (FK: TB_COMMON_CODE)',
  `parent_lot_no` VARCHAR(100) NOT NULL COMMENT '상위(투입) Lot 번호 (FK: TB_LOT_MASTER)',
  `child_lot_no` VARCHAR(100) NOT NULL COMMENT '하위(산출) Lot 번호 (FK: TB_LOT_MASTER)',
  `quantity` DECIMAL(10,4) NOT NULL COMMENT '산출 수량',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_date` DATETIME NOT NULL COMMENT '생성 일시',
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '삭제 여부 (0:N, 1:Y)',
  `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
  `last_modified_date` DATETIME NOT NULL COMMENT '최종 수정 일시',
  PRIMARY KEY (`trace_log_id`),
  CONSTRAINT `fk_trace_log_work_order` FOREIGN KEY (`work_order_id`) REFERENCES `TB_WORK_ORDER` (`work_order_id`),
  CONSTRAINT `fk_trace_log_prod_order` FOREIGN KEY (`production_order_id`) REFERENCES `TB_PRODUCTION_ORDER` (`production_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='추적 이력';

-- Table `TB_SHIPPING_ORDER_ITEM` (출하 지시 품목)
CREATE TABLE IF NOT EXISTS `TB_SHIPPING_ORDER_ITEM` (
  `shipping_item_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '출하 품목 ID',
  `shipping_order_id` VARCHAR(50) NOT NULL COMMENT '출하 지시 ID (FK: TB_SHIPPING_ORDER)',
  `item_id` VARCHAR(50) NOT NULL COMMENT '품목 ID (FK: TB_ITEM)',
  `lot_number` VARCHAR(100) NOT NULL COMMENT '출하 Lot 번호 (FK: TB_LOT_MASTER)',
  `quantity` DECIMAL(10,4) NOT NULL COMMENT '출하 수량',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_date` DATETIME NOT NULL COMMENT '생성 일시',
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '삭제 여부 (0:N, 1:Y)',
  `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
  `last_modified_date` DATETIME NOT NULL COMMENT '최종 수정 일시',
  PRIMARY KEY (`shipping_item_id`),
  CONSTRAINT `fk_shipping_item_order` FOREIGN KEY (`shipping_order_id`) REFERENCES `TB_SHIPPING_ORDER` (`shipping_order_id`),
  CONSTRAINT `fk_shipping_item_item` FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='출하 지시 품목';

-- Table `TB_MATERIAL_MOVEMENT` (자재 이동 이력)
CREATE TABLE IF NOT EXISTS `TB_MATERIAL_MOVEMENT` (
  `movement_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '이동 ID',
  `material_id` VARCHAR(50) NOT NULL COMMENT '자재 ID (FK: TB_MATERIAL)',
  `lot_id` VARCHAR(50) NULL COMMENT 'LOT ID (FK: TB_MATERIAL_LOT)',
  `from_warehouse_id` VARCHAR(50) NULL COMMENT '출발 창고',
  `to_warehouse_id` VARCHAR(50) NULL COMMENT '도착 창고',
  `moved_quantity` INT NOT NULL COMMENT '이동 수량',
  `moved_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '이동 시각',
  PRIMARY KEY (`movement_id`),
  CONSTRAINT `fk_movement_material` FOREIGN KEY (`material_id`) REFERENCES `TB_MATERIAL` (`material_id`),
  CONSTRAINT `fk_movement_lot` FOREIGN KEY (`lot_id`) REFERENCES `TB_MATERIAL_LOT` (`lot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='자재 이동 이력';

-- Table `TB_CAPA_ACTION` (시정 및 예방 조치 - CAPA)
CREATE TABLE IF NOT EXISTS `TB_CAPA_ACTION` (
  `capa_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT 'CAPA ID',
  `defect_id` BIGINT NOT NULL COMMENT '불량 ID (FK: TB_DEFECT)',
  `action_type` VARCHAR(50) NULL COMMENT '조치 유형 (시정/예방)',
  `action_detail` TEXT NULL COMMENT '조치 상세 내용',
  `action_date` DATETIME NULL COMMENT '조치 일시',
  `action_by` VARCHAR(50) NULL COMMENT '조치자',
  PRIMARY KEY (`capa_id`),
  CONSTRAINT `fk_capa_defect` FOREIGN KEY (`defect_id`) REFERENCES `TB_DEFECT` (`defect_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='시정 및 예방 조치 (CAPA)';