-- -----------------------------------------------------
-- Table `TB_PRODUCTION_PLAN` (생산 계획)
-- 설명: MES의 생산 계획 정보를 관리합니다.
-- -----------------------------------------------------
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

-- -----------------------------------------------------
-- Table `TB_WORK_ORDER` (작업 지시)
-- 설명: 생산 계획을 바탕으로 현장에 내려진 작업 지시 정보를 관리합니다.
-- -----------------------------------------------------
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

-- -----------------------------------------------------
-- Table `TB_OPERATION_LOG` (작업 이력)
-- 설명: 작업 지시에 대한 생산 실적 및 이력 정보를 기록합니다.
-- -----------------------------------------------------
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

-- -----------------------------------------------------
-- Table `TB_PROCESS_ROUTE` (공정 라우팅)
-- 설명: 품목별로 거쳐야 할 공정 순서를 정의합니다.
-- -----------------------------------------------------
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

-- -----------------------------------------------------
-- Table `TB_EQUIPMENT_CHECK` (설비 점검 이력)
-- 설명: 설비의 정기/비정기 점검 이력을 기록합니다.
-- -----------------------------------------------------
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

-- -----------------------------------------------------
-- Table `TB_EQUIPMENT_MAINTENANCE_LOG` (설비 보전 이력)
-- 설명: 설비의 유지보수 및 보전 활동 이력을 기록합니다.
-- -----------------------------------------------------
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

-- -----------------------------------------------------
-- Table `TB_EQUIPMENT_STATUS` (설비 상태)
-- 설명: 설비의 현재 상태를 관리합니다.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TB_EQUIPMENT_STATUS` (
  `equipment_id` VARCHAR(50) NOT NULL COMMENT '설비 ID (FK: TB_EQUIPMENT)',
  `status` VARCHAR(20) NULL COMMENT '설비 상태',
  `last_checked` DATETIME NULL COMMENT '최종 확인 일시',
  PRIMARY KEY (`equipment_id`),
  CONSTRAINT `fk_status_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `TB_EQUIPMENT` (`equipment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='설비 상태';

-- -----------------------------------------------------
-- Table `TB_EQUIPMENT_SENSOR_LOG` (설비 센서 로그)
-- 설명: 설비의 센서 데이터를 실시간으로 기록합니다.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TB_EQUIPMENT_SENSOR_LOG` (
  `log_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '로그 ID',
  `equipment_id` VARCHAR(50) NULL COMMENT '설비 ID (FK: TB_EQUIPMENT)',
  `sensor_type` VARCHAR(50) NULL COMMENT '센서 유형',
  `value` DECIMAL(10, 2) NULL COMMENT '센서 값',
  `logged_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '로그 기록 일시',
  PRIMARY KEY (`log_id`),
  CONSTRAINT `fk_sensor_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `TB_EQUIPMENT` (`equipment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='설비 센서 로그';