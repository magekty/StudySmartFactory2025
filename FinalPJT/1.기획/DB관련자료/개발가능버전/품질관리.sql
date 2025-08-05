-- -----------------------------------------------------
-- Table `TB_INSPECTION` (검사 기준)
-- 설명: 품목 및 공정별 검사 기준을 정의합니다.
-- -----------------------------------------------------
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
-- Table `TB_INSPECTION_RESULT` (검사 결과)
-- 설명: 특정 작업 지시에 대한 검사 결과를 기록합니다.
-- -----------------------------------------------------
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

-- -----------------------------------------------------
-- Table `TB_DEFECT` (불량 정보)
-- 설명: 검사 결과에서 발생한 불량 상세 정보를 기록합니다.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TB_DEFECT` (
  `defect_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '불량 ID',
  `result_id` BIGINT NOT NULL COMMENT '검사 결과 ID (FK: TB_INSPECTION_RESULT)',
  `defect_type` VARCHAR(50) NULL COMMENT '불량 유형',
  `action_taken` TEXT NULL COMMENT '조치 내용',
  PRIMARY KEY (`defect_id`),
  CONSTRAINT `fk_defect_result` FOREIGN KEY (`result_id`) REFERENCES `TB_INSPECTION_RESULT` (`result_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='불량 정보';

-- -----------------------------------------------------
-- Table `TB_CAPA_ACTION` (시정 및 예방 조치 - CAPA)
-- 설명: 불량에 대한 시정 및 예방 조치(Corrective and Preventive Action) 이력을 기록합니다.
-- -----------------------------------------------------
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