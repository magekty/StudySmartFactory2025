-- -----------------------------------------------------
-- Table `TB_ITEM` (품목 마스터)
-- 설명: 생산 제품 및 자재에 대한 기본 정보를 관리합니다.
-- -----------------------------------------------------
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

-- -----------------------------------------------------
-- Table `TB_PROCESS` (공정 마스터)
-- 설명: 제품 생산에 필요한 공정 정보를 관리합니다.
-- -----------------------------------------------------
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

-- -----------------------------------------------------
-- Table `TB_WORKCENTER` (작업장 마스터)
-- 설명: 생산 공정이 이루어지는 작업장 정보를 관리합니다.
-- -----------------------------------------------------
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

-- -----------------------------------------------------
-- Table `TB_SUPPLIER` (공급처 마스터)
-- 설명: 자재를 공급하는 업체 정보를 관리합니다.
-- -----------------------------------------------------
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

-- -----------------------------------------------------
-- Table `TB_USER` (사용자 마스터)
-- 설명: MES 시스템 사용자의 기본 정보를 관리합니다.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TB_USER` (
  `user_id` VARCHAR(50) NOT NULL COMMENT '사용자 ID',
  `user_name` VARCHAR(100) NULL COMMENT '사용자명',
  `email` VARCHAR(100) NULL COMMENT '이메일',
  `password` VARCHAR(255) NULL COMMENT '비밀번호',
  `role_id` VARCHAR(50) NULL COMMENT '역할 ID (FK)',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
  `modified_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 일시',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='사용자 마스터';

-- -----------------------------------------------------
-- Table `TB_ROLE` (역할 마스터)
-- 설명: 사용자에게 부여할 수 있는 역할 정보를 관리합니다.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TB_ROLE` (
  `role_id` VARCHAR(50) NOT NULL COMMENT '역할 ID',
  `role_name` VARCHAR(50) NULL COMMENT '역할명',
  `description` TEXT NULL COMMENT '설명',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='역할 마스터';

-- -----------------------------------------------------
-- Table `TB_USER_ROLE` (사용자-역할 관계)
-- 설명: 사용자와 역할 간의 다대다(N:M) 관계를 관리합니다.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TB_USER_ROLE` (
  `user_id` VARCHAR(50) NOT NULL COMMENT '사용자 ID (FK: TB_USER)',
  `role_id` VARCHAR(50) NOT NULL COMMENT '역할 ID (FK: TB_ROLE)',
  PRIMARY KEY (`user_id`, `role_id`),
  CONSTRAINT `fk_user_role_user` FOREIGN KEY (`user_id`) REFERENCES `TB_USER` (`user_id`),
  CONSTRAINT `fk_user_role_role` FOREIGN KEY (`role_id`) REFERENCES `TB_ROLE` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='사용자-역할 관계';

-- -----------------------------------------------------
-- Table `TB_CODE_GROUP` (코드 그룹)
-- 설명: 공통 코드의 그룹 정보를 관리합니다.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TB_CODE_GROUP` (
  `code_group_id` VARCHAR(50) NOT NULL COMMENT '코드 그룹 ID',
  `group_name` VARCHAR(100) NULL COMMENT '그룹명',
  PRIMARY KEY (`code_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='코드 그룹';

-- -----------------------------------------------------
-- Table `TB_CODE` (공통 코드)
-- 설명: 시스템 전반에서 사용되는 공통 코드 정보를 관리합니다.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TB_CODE` (
  `code_id` VARCHAR(50) NOT NULL COMMENT '코드 ID',
  `code_group_id` VARCHAR(50) NULL COMMENT '코드 그룹 ID (FK: TB_CODE_GROUP)',
  `code_name` VARCHAR(100) NULL COMMENT '코드명',
  PRIMARY KEY (`code_id`),
  CONSTRAINT `fk_code_group` FOREIGN KEY (`code_group_id`) REFERENCES `TB_CODE_GROUP` (`code_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='공통 코드';