-- -----------------------------------------------------
-- Database 생성
-- -----------------------------------------------------
CREATE DATABASE IF NOT EXISTS `mes_pjt_test` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `mes_pjt_test`;

-- 외래 키 제약 조건으로 인해 자식 테이블부터 삭제해야 합니다.
DROP TABLE IF EXISTS `TB_PRODUCTION_TRACEABILITY`;
DROP TABLE IF EXISTS `TB_AUDIT_LOG`;
DROP TABLE IF EXISTS `TB_NON_CONFORMANCE`;
DROP TABLE IF EXISTS `TB_INSPECTION_SPEC`;
DROP TABLE IF EXISTS `TB_DOCUMENT_MANAGEMENT`;
DROP TABLE IF EXISTS `TB_WORK_ORDER_MATERIAL`;
DROP TABLE IF EXISTS `TB_PRODUCTION_PERFORMANCE`;
DROP TABLE IF EXISTS `TB_INSPECTION_RESULT`;
DROP TABLE IF EXISTS `TB_DEFECT_ITEM`;
DROP TABLE IF EXISTS `TB_DEFECT`;
DROP TABLE IF EXISTS `TB_EQUIPMENT_CHECK`;
DROP TABLE IF EXISTS `TB_USER_ROLE`;
DROP TABLE IF EXISTS `TB_WORK_ORDER`;
DROP TABLE IF EXISTS `TB_PRODUCTION_PLAN`;
DROP TABLE IF EXISTS `TB_BOM`;
DROP TABLE IF EXISTS `TB_INVENTORY`;
DROP TABLE IF EXISTS `TB_STOCK`;
DROP TABLE IF EXISTS `TB_WAREHOUSE_STOCK`;
DROP TABLE IF EXISTS `TB_MATERIAL_LOT`;
DROP TABLE IF EXISTS `TB_INSPECTION`;
DROP TABLE IF EXISTS `TB_EQUIPMENT`;
DROP TABLE IF EXISTS `TB_WORKCENTER`;
DROP TABLE IF EXISTS `TB_PROCESS`;
DROP TABLE IF EXISTS `TB_WAREHOUSE`;
DROP TABLE IF EXISTS `TB_WORKSHOP`;
DROP TABLE IF EXISTS `TB_ITEM`;
DROP TABLE IF EXISTS `TB_USER`;
DROP TABLE IF EXISTS `TB_ROLE`;
DROP TABLE IF EXISTS `TB_MENU`;
DROP TABLE IF EXISTS `TB_CODE`;
DROP TABLE IF EXISTS `TB_CODE_GROUP`;
DROP TABLE IF EXISTS `TB_LOG`;
DROP TABLE IF EXISTS `TB_EMPLOYEE`;

-- -----------------------------------------------------
-- 1. 외래 키를 참조하지 않는 기본 테이블
-- -----------------------------------------------------

-- 1. Table `TB_CODE_GROUP` (공통 코드 그룹)
CREATE TABLE `TB_CODE_GROUP` (
  `code_group_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '공통 코드 그룹 ID',
  `group_code` VARCHAR(50) NOT NULL UNIQUE COMMENT '그룹 코드 (예: STATUS, ITEM_TYPE)',
  `group_name` VARCHAR(100) NOT NULL COMMENT '그룹명',
  `description` VARCHAR(255) NULL COMMENT '설명',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시간',
  PRIMARY KEY (`code_group_id`)
) ENGINE=InnoDB COMMENT='공통 코드 그룹';


-- 2. Table `TB_EMPLOYEE` (직원 정보)
CREATE TABLE `TB_EMPLOYEE` (
  `employee_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '직원 ID',
  `employee_name` VARCHAR(50) NOT NULL COMMENT '직원명',
  `department` VARCHAR(100) NULL COMMENT '부서',
  `phone_number` VARCHAR(20) NULL COMMENT '전화번호',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시간',
  PRIMARY KEY (`employee_id`)
) ENGINE=InnoDB COMMENT='직원 정보';


-- 3. Table `TB_ROLE` (권한)
CREATE TABLE `TB_ROLE` (
  `role_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '권한 ID',
  `role_name` VARCHAR(50) NOT NULL UNIQUE COMMENT '권한명 (예: ADMIN, USER)',
  `description` VARCHAR(255) NULL COMMENT '설명',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시간',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB COMMENT='권한';


-- 4. Table `TB_MENU` (메뉴)
CREATE TABLE `TB_MENU` (
  `menu_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '메뉴 ID',
  `parent_menu_id` BIGINT NULL COMMENT '상위 메뉴 ID',
  `menu_name` VARCHAR(100) NOT NULL COMMENT '메뉴명',
  `url` VARCHAR(255) NOT NULL COMMENT 'URL',
  `order_number` INT NOT NULL COMMENT '정렬 순서',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시간',
  PRIMARY KEY (`menu_id`),
  FOREIGN KEY (`parent_menu_id`) REFERENCES `TB_MENU`(`menu_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='메뉴';


-- 5. Table `TB_ITEM` (품목 마스터 - 제품/반제품/원자재 통합)
CREATE TABLE `TB_ITEM` (
  `item_id` VARCHAR(36) NOT NULL COMMENT '품목 ID (UUID)',
  `item_name` VARCHAR(255) NOT NULL COMMENT '품목명',
  `item_type` CHAR(1) NOT NULL COMMENT '품목 유형 (P:제품, S:반제품, R:원자재)',
  `unit` VARCHAR(50) NOT NULL COMMENT '단위 (EA, KG, L 등)',
  `spec` VARCHAR(255) NULL COMMENT '규격',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시간',
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB COMMENT='품목 마스터';


-- 6. Table `TB_PROCESS` (공정 마스터)
CREATE TABLE `TB_PROCESS` (
  `process_id` VARCHAR(36) NOT NULL COMMENT '공정 ID (UUID)',
  `process_name` VARCHAR(255) NOT NULL UNIQUE COMMENT '공정명',
  `description` TEXT NULL COMMENT '설명',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시간',
  PRIMARY KEY (`process_id`)
) ENGINE=InnoDB COMMENT='공정 마스터';


-- 7. Table `TB_WORKCENTER` (작업장 마스터)
CREATE TABLE `TB_WORKCENTER` (
  `workcenter_id` VARCHAR(36) NOT NULL COMMENT '작업장 ID (UUID)',
  `workcenter_name` VARCHAR(255) NOT NULL UNIQUE COMMENT '작업장명',
  `location` VARCHAR(255) NULL COMMENT '위치',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시간',
  PRIMARY KEY (`workcenter_id`)
) ENGINE=InnoDB COMMENT='작업장 마스터';


-- 8. Table `TB_WAREHOUSE` (창고 마스터)
CREATE TABLE `TB_WAREHOUSE` (
  `warehouse_id` VARCHAR(36) NOT NULL COMMENT '창고 ID (UUID)',
  `warehouse_name` VARCHAR(255) NOT NULL UNIQUE COMMENT '창고명',
  `location` VARCHAR(255) NULL COMMENT '위치',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시간',
  PRIMARY KEY (`warehouse_id`)
) ENGINE=InnoDB COMMENT='창고 마스터';


-- 9. Table `TB_WORKSHOP` (워크샵 마스터)
CREATE TABLE `TB_WORKSHOP` (
  `workshop_id` VARCHAR(36) NOT NULL COMMENT '워크샵 ID (UUID)',
  `workshop_name` VARCHAR(255) NOT NULL UNIQUE COMMENT '워크샵명',
  `location` VARCHAR(255) NULL COMMENT '위치',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시간',
  PRIMARY KEY (`workshop_id`)
) ENGINE=InnoDB COMMENT='워크샵 마스터';


-- -----------------------------------------------------
-- 2. 위에서 생성된 테이블을 참조하는 테이블
-- -----------------------------------------------------

-- 10. Table `TB_CODE` (공통 코드)
CREATE TABLE `TB_CODE` (
  `code_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '공통 코드 ID',
  `group_code` VARCHAR(50) NOT NULL COMMENT '그룹 코드 (FK)',
  `code_value` VARCHAR(50) NOT NULL COMMENT '코드 값',
  `code_name` VARCHAR(100) NOT NULL COMMENT '코드명',
  `description` VARCHAR(255) NULL COMMENT '설명',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시간',
  PRIMARY KEY (`code_id`),
  FOREIGN KEY (`group_code`) REFERENCES `TB_CODE_GROUP`(`group_code`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='공통 코드';
CREATE INDEX `idx_code_group_code` ON `TB_CODE` (`group_code`);


-- 11. Table `TB_USER` (사용자)
CREATE TABLE `TB_USER` (
  `user_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '사용자 ID',
  `username` VARCHAR(50) NOT NULL UNIQUE COMMENT '사용자명',
  `password` VARCHAR(255) NOT NULL COMMENT '비밀번호',
  `employee_id` BIGINT NULL COMMENT '직원 ID',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시간',
  PRIMARY KEY (`user_id`),
  FOREIGN KEY (`employee_id`) REFERENCES `TB_EMPLOYEE`(`employee_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='사용자';
CREATE INDEX `idx_user_employee_id` ON `TB_USER` (`employee_id`);


-- 12. Table `TB_USER_ROLE` (사용자-권한 매핑)
CREATE TABLE `TB_USER_ROLE` (
  `user_role_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '사용자-권한 ID',
  `user_id` BIGINT NOT NULL COMMENT '사용자 ID (FK)',
  `role_id` BIGINT NOT NULL COMMENT '권한 ID (FK)',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  PRIMARY KEY (`user_role_id`),
  UNIQUE KEY `uk_user_role_unique` (`user_id`, `role_id`),
  FOREIGN KEY (`user_id`) REFERENCES `TB_USER`(`user_id`) ON DELETE RESTRICT,
  FOREIGN KEY (`role_id`) REFERENCES `TB_ROLE`(`role_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='사용자-권한 매핑';


-- 13. Table `TB_LOG` (시스템 로그)
CREATE TABLE `TB_LOG` (
  `log_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '로그 ID',
  `user_id` BIGINT NULL COMMENT '사용자 ID (FK)',
  `log_type` VARCHAR(50) NOT NULL COMMENT '로그 유형 (예: LOGIN, CRUD)',
  `log_message` TEXT NOT NULL COMMENT '로그 메시지',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시간',
  PRIMARY KEY (`log_id`),
  FOREIGN KEY (`user_id`) REFERENCES `TB_USER`(`user_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='시스템 로그';


-- 14. Table `TB_PRODUCTION_PLAN` (생산 계획)
CREATE TABLE `TB_PRODUCTION_PLAN` (
  `plan_id` VARCHAR(36) NOT NULL COMMENT '생산 계획 ID (UUID)',
  `plan_name` VARCHAR(255) NULL COMMENT '계획명',
  `item_id` VARCHAR(36) NOT NULL COMMENT '품목 ID (FK)',
  `planned_qty` DECIMAL(10,4) NOT NULL COMMENT '계획 수량',
  `start_date` DATE NOT NULL COMMENT '계획 시작일',
  `end_date` DATE NOT NULL COMMENT '계획 완료일',
  `status` CHAR(1) NOT NULL DEFAULT 'P' COMMENT '상태 (P:계획, R:진행, C:완료)',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시간',
  PRIMARY KEY (`plan_id`),
  FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM`(`item_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='생산 계획';
CREATE INDEX `idx_plan_item_id` ON `TB_PRODUCTION_PLAN` (`item_id`);
CREATE INDEX `idx_plan_status` ON `TB_PRODUCTION_PLAN` (`status`);


-- 15. Table `TB_BOM` (자재 명세서 - BOM)
CREATE TABLE `TB_BOM` (
  `bom_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT 'BOM ID',
  `parent_item_id` VARCHAR(36) NOT NULL COMMENT '상위 품목 ID (제품/반제품)',
  `child_item_id` VARCHAR(36) NOT NULL COMMENT '하위 품목 ID (반제품/원자재)',
  `quantity` DECIMAL(10,4) NOT NULL COMMENT '소요 수량',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시간',
  PRIMARY KEY (`bom_id`),
  FOREIGN KEY (`parent_item_id`) REFERENCES `TB_ITEM`(`item_id`) ON DELETE RESTRICT,
  FOREIGN KEY (`child_item_id`) REFERENCES `TB_ITEM`(`item_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='자재 명세서';


-- 16. Table `TB_MATERIAL_LOT` (자재 LOT)
CREATE TABLE `TB_MATERIAL_LOT` (
  `material_lot_id` VARCHAR(36) NOT NULL COMMENT '자재 LOT ID (UUID)',
  `item_id` VARCHAR(36) NOT NULL COMMENT '품목 ID (FK)',
  `lot_number` VARCHAR(100) NOT NULL UNIQUE COMMENT 'LOT 번호',
  `quantity` DECIMAL(10,4) NOT NULL COMMENT '입고 수량',
  `warehouse_id` VARCHAR(36) NOT NULL COMMENT '입고 창고 ID (FK)',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시간',
  PRIMARY KEY (`material_lot_id`),
  FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM`(`item_id`) ON DELETE RESTRICT,
  FOREIGN KEY (`warehouse_id`) REFERENCES `TB_WAREHOUSE`(`warehouse_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='자재 LOT';
CREATE INDEX `idx_material_lot_item_id` ON `TB_MATERIAL_LOT` (`item_id`);
CREATE INDEX `idx_material_lot_warehouse_id` ON `TB_MATERIAL_LOT` (`warehouse_id`);


-- 17. Table `TB_EQUIPMENT` (설비 마스터)
CREATE TABLE `TB_EQUIPMENT` (
  `equipment_id` VARCHAR(36) NOT NULL COMMENT '설비 ID (UUID)',
  `equipment_name` VARCHAR(255) NOT NULL UNIQUE COMMENT '설비명',
  `workcenter_id` VARCHAR(36) NOT NULL COMMENT '작업장 ID (FK)',
  `process_id` VARCHAR(36) NOT NULL COMMENT '공정 ID (FK)',
  `status` VARCHAR(50) NOT NULL COMMENT '상태 (예: Running, Stopped, Maintenance)',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시간',
  PRIMARY KEY (`equipment_id`),
  FOREIGN KEY (`workcenter_id`) REFERENCES `TB_WORKCENTER`(`workcenter_id`) ON DELETE RESTRICT,
  FOREIGN KEY (`process_id`) REFERENCES `TB_PROCESS`(`process_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='설비 마스터';
CREATE INDEX `idx_equipment_workcenter_id` ON `TB_EQUIPMENT` (`workcenter_id`);
CREATE INDEX `idx_equipment_process_id` ON `TB_EQUIPMENT` (`process_id`);


-- 18. Table `TB_WORK_ORDER` (작업 지시)
CREATE TABLE `TB_WORK_ORDER` (
  `work_order_id` VARCHAR(36) NOT NULL COMMENT '작업 지시 ID (UUID)',
  `plan_id` VARCHAR(36) NOT NULL COMMENT '생산 계획 ID (FK)',
  `item_id` VARCHAR(36) NOT NULL COMMENT '품목 ID (FK)',
  `process_id` VARCHAR(36) NOT NULL COMMENT '공정 ID (FK)',
  `equipment_id` VARCHAR(36) NOT NULL COMMENT '설비 ID (FK)',
  `workcenter_id` VARCHAR(36) NOT NULL COMMENT '작업장 ID (FK)',
  `planned_qty` DECIMAL(10,4) NOT NULL COMMENT '계획 수량',
  `start_date` DATETIME NOT NULL COMMENT '지시 시작 시간',
  `end_date` DATETIME NOT NULL COMMENT '지시 완료 시간',
  `status` CHAR(1) NOT NULL DEFAULT 'P' COMMENT '상태 (P:계획, R:진행, H:중단, C:완료)',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시간',
  PRIMARY KEY (`work_order_id`),
  FOREIGN KEY (`plan_id`) REFERENCES `TB_PRODUCTION_PLAN`(`plan_id`) ON DELETE RESTRICT,
  FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM`(`item_id`) ON DELETE RESTRICT,
  FOREIGN KEY (`process_id`) REFERENCES `TB_PROCESS`(`process_id`) ON DELETE RESTRICT,
  FOREIGN KEY (`equipment_id`) REFERENCES `TB_EQUIPMENT`(`equipment_id`) ON DELETE RESTRICT,
  FOREIGN KEY (`workcenter_id`) REFERENCES `TB_WORKCENTER`(`workcenter_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='작업 지시';
CREATE INDEX `idx_work_order_plan_id` ON `TB_WORK_ORDER` (`plan_id`);
CREATE INDEX `idx_work_order_item_id` ON `TB_WORK_ORDER` (`item_id`);
CREATE INDEX `idx_work_order_process_id` ON `TB_WORK_ORDER` (`process_id`);
CREATE INDEX `idx_work_order_equipment_id` ON `TB_WORK_ORDER` (`equipment_id`);
CREATE INDEX `idx_work_order_workcenter_id` ON `TB_WORK_ORDER` (`workcenter_id`);


-- 19. Table `TB_STOCK` (실시간 재고)
CREATE TABLE `TB_STOCK` (
  `stock_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '재고 ID',
  `item_id` VARCHAR(36) NOT NULL COMMENT '품목 ID (FK)',
  `warehouse_id` VARCHAR(36) NOT NULL COMMENT '창고 ID (FK)',
  `quantity` DECIMAL(10,4) NOT NULL COMMENT '수량',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시간',
  PRIMARY KEY (`stock_id`),
  UNIQUE KEY `uk_item_warehouse_unique` (`item_id`, `warehouse_id`),
  FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM`(`item_id`) ON DELETE RESTRICT,
  FOREIGN KEY (`warehouse_id`) REFERENCES `TB_WAREHOUSE`(`warehouse_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='실시간 재고';
CREATE INDEX `idx_stock_item_id` ON `TB_STOCK` (`item_id`);
CREATE INDEX `idx_stock_warehouse_id` ON `TB_STOCK` (`warehouse_id`);


-- 20. Table `TB_WAREHOUSE_STOCK` (창고별 재고)
CREATE TABLE `TB_WAREHOUSE_STOCK` (
  `warehouse_stock_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '창고별 재고 ID',
  `item_id` VARCHAR(36) NOT NULL COMMENT '품목 ID (FK)',
  `warehouse_id` VARCHAR(36) NOT NULL COMMENT '창고 ID (FK)',
  `quantity` DECIMAL(10,4) NOT NULL COMMENT '수량',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시간',
  PRIMARY KEY (`warehouse_stock_id`),
  FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM`(`item_id`) ON DELETE RESTRICT,
  FOREIGN KEY (`warehouse_id`) REFERENCES `TB_WAREHOUSE`(`warehouse_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='창고별 재고';
CREATE INDEX `idx_warehouse_stock_item_id` ON `TB_WAREHOUSE_STOCK` (`item_id`);
CREATE INDEX `idx_warehouse_stock_warehouse_id` ON `TB_WAREHOUSE_STOCK` (`warehouse_id`);


-- 21. Table `TB_INVENTORY` (재고)
CREATE TABLE `TB_INVENTORY` (
  `inventory_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '재고 ID',
  `item_id` VARCHAR(36) NOT NULL COMMENT '품목 ID (FK)',
  `warehouse_id` VARCHAR(36) NOT NULL COMMENT '창고 ID (FK)',
  `quantity` DECIMAL(10,4) NOT NULL COMMENT '수량',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시간',
  PRIMARY KEY (`inventory_id`),
  FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM`(`item_id`) ON DELETE RESTRICT,
  FOREIGN KEY (`warehouse_id`) REFERENCES `TB_WAREHOUSE`(`warehouse_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='재고';
CREATE INDEX `idx_inventory_item_id` ON `TB_INVENTORY` (`item_id`);
CREATE INDEX `idx_inventory_warehouse_id` ON `TB_INVENTORY` (`warehouse_id`);


-- 22. Table `TB_INSPECTION` (검사)
CREATE TABLE `TB_INSPECTION` (
  `inspection_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '검사 ID',
  `item_id` VARCHAR(36) NOT NULL COMMENT '품목 ID (FK)',
  `inspection_type` VARCHAR(50) NOT NULL COMMENT '검사 유형 (예: 입고검사, 공정검사, 출하검사)',
  `inspection_date` DATETIME NOT NULL COMMENT '검사 일시',
  `worker_id` BIGINT NOT NULL COMMENT '작업자 ID (FK)',
  `result` CHAR(1) NOT NULL COMMENT '판정 결과 (P:Pass, F:Fail)',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시간',
  PRIMARY KEY (`inspection_id`),
  FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM`(`item_id`) ON DELETE RESTRICT,
  FOREIGN KEY (`worker_id`) REFERENCES `TB_USER`(`user_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='검사';
CREATE INDEX `idx_inspection_item_id` ON `TB_INSPECTION` (`item_id`);
CREATE INDEX `idx_inspection_worker_id` ON `TB_INSPECTION` (`worker_id`);


-- 23. Table `TB_DEFECT` (불량)
CREATE TABLE `TB_DEFECT` (
  `defect_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '불량 ID',
  `inspection_id` BIGINT NOT NULL COMMENT '검사 ID (FK)',
  `defect_type` VARCHAR(50) NOT NULL COMMENT '불량 유형',
  `defect_date` DATETIME NOT NULL COMMENT '불량 발생 일시',
  `worker_id` BIGINT NOT NULL COMMENT '작업자 ID (FK)',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시간',
  PRIMARY KEY (`defect_id`),
  FOREIGN KEY (`inspection_id`) REFERENCES `TB_INSPECTION`(`inspection_id`) ON DELETE RESTRICT,
  FOREIGN KEY (`worker_id`) REFERENCES `TB_USER`(`user_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='불량';
CREATE INDEX `idx_defect_inspection_id` ON `TB_DEFECT` (`inspection_id`);
CREATE INDEX `idx_defect_worker_id` ON `TB_DEFECT` (`worker_id`);


-- 24. Table `TB_EQUIPMENT_CHECK` (설비 점검)
CREATE TABLE `TB_EQUIPMENT_CHECK` (
  `check_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '점검 ID',
  `equipment_id` VARCHAR(36) NOT NULL COMMENT '설비 ID (FK)',
  `worker_id` BIGINT NOT NULL COMMENT '작업자 ID (FK)',
  `check_date` DATETIME NOT NULL COMMENT '점검 일시',
  `result` CHAR(1) NOT NULL COMMENT '점검 결과 (P:Pass, F:Fail)',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시간',
  PRIMARY KEY (`check_id`),
  FOREIGN KEY (`equipment_id`) REFERENCES `TB_EQUIPMENT`(`equipment_id`) ON DELETE RESTRICT,
  FOREIGN KEY (`worker_id`) REFERENCES `TB_USER`(`user_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='설비 점검';
CREATE INDEX `idx_check_equipment_id` ON `TB_EQUIPMENT_CHECK` (`equipment_id`);
CREATE INDEX `idx_check_worker_id` ON `TB_EQUIPMENT_CHECK` (`worker_id`);


-- 25. Table `TB_DEFECT_ITEM` (불량 품목)
CREATE TABLE `TB_DEFECT_ITEM` (
  `defect_item_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '불량 품목 ID',
  `defect_id` BIGINT NOT NULL COMMENT '불량 ID (FK)',
  `item_id` VARCHAR(36) NOT NULL COMMENT '품목 ID (FK)',
  `quantity` DECIMAL(10,4) NOT NULL COMMENT '불량 수량',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  PRIMARY KEY (`defect_item_id`),
  FOREIGN KEY (`defect_id`) REFERENCES `TB_DEFECT`(`defect_id`) ON DELETE RESTRICT,
  FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM`(`item_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='불량 품목';
CREATE INDEX `idx_defect_item_defect_id` ON `TB_DEFECT_ITEM` (`defect_id`);
CREATE INDEX `idx_defect_item_item_id` ON `TB_DEFECT_ITEM` (`item_id`);


-- 26. Table `TB_INSPECTION_RESULT` (검사 결과)
CREATE TABLE `TB_INSPECTION_RESULT` (
  `inspection_result_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '검사 결과 ID',
  `inspection_id` BIGINT NOT NULL COMMENT '검사 ID (FK)',
  `item_id` VARCHAR(36) NOT NULL COMMENT '품목 ID (FK)',
  `result_value` VARCHAR(255) NULL COMMENT '결과 값',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  PRIMARY KEY (`inspection_result_id`),
  FOREIGN KEY (`inspection_id`) REFERENCES `TB_INSPECTION`(`inspection_id`) ON DELETE RESTRICT,
  FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM`(`item_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='검사 결과';
CREATE INDEX `idx_inspection_result_inspection_id` ON `TB_INSPECTION_RESULT` (`inspection_id`);
CREATE INDEX `idx_inspection_result_item_id` ON `TB_INSPECTION_RESULT` (`item_id`);


-- 27. Table `TB_PRODUCTION_PERFORMANCE` (생산 실적)
CREATE TABLE `TB_PRODUCTION_PERFORMANCE` (
  `performance_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '생산 실적 ID',
  `work_order_id` VARCHAR(36) NOT NULL COMMENT '작업 지시 ID (FK)',
  `item_id` VARCHAR(36) NOT NULL COMMENT '품목 ID (FK)',
  `process_id` VARCHAR(36) NOT NULL COMMENT '공정 ID (FK)',
  `equipment_id` VARCHAR(36) NOT NULL COMMENT '설비 ID (FK)',
  `produced_qty` DECIMAL(10,4) NOT NULL COMMENT '생산 수량',
  `start_time` DATETIME NOT NULL COMMENT '실적 시작 시간',
  `end_time` DATETIME NOT NULL COMMENT '실적 완료 시간',
  `worker_id` BIGINT NOT NULL COMMENT '작업자 ID (FK)',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시간',
  PRIMARY KEY (`performance_id`),
  FOREIGN KEY (`work_order_id`) REFERENCES `TB_WORK_ORDER`(`work_order_id`) ON DELETE RESTRICT,
  FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM`(`item_id`) ON DELETE RESTRICT,
  FOREIGN KEY (`process_id`) REFERENCES `TB_PROCESS`(`process_id`) ON DELETE RESTRICT,
  FOREIGN KEY (`equipment_id`) REFERENCES `TB_EQUIPMENT`(`equipment_id`) ON DELETE RESTRICT,
  FOREIGN KEY (`worker_id`) REFERENCES `TB_USER`(`user_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='생산 실적';
CREATE INDEX `idx_performance_work_order_id` ON `TB_PRODUCTION_PERFORMANCE` (`work_order_id`);
CREATE INDEX `idx_performance_item_id` ON `TB_PRODUCTION_PERFORMANCE` (`item_id`);
CREATE INDEX `idx_performance_process_id` ON `TB_PRODUCTION_PERFORMANCE` (`process_id`);
CREATE INDEX `idx_performance_equipment_id` ON `TB_PRODUCTION_PERFORMANCE` (`equipment_id`);
CREATE INDEX `idx_performance_worker_id` ON `TB_PRODUCTION_PERFORMANCE` (`worker_id`);


-- -----------------------------------------------------
-- 3. 의료기기 특화 추가 테이블
-- -----------------------------------------------------

-- 28. Table `TB_WORK_ORDER_MATERIAL` (작업 지시 자재 사용 이력)
CREATE TABLE `TB_WORK_ORDER_MATERIAL` (
  `wom_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '작업 지시 자재 ID',
  `work_order_id` VARCHAR(36) NOT NULL COMMENT '작업 지시 ID (FK)',
  `material_lot_id` VARCHAR(36) NOT NULL COMMENT '자재 LOT ID (FK)',
  `consumed_qty` DECIMAL(10,4) NOT NULL COMMENT '소모 수량',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  PRIMARY KEY (`wom_id`),
  FOREIGN KEY (`work_order_id`) REFERENCES `TB_WORK_ORDER`(`work_order_id`) ON DELETE RESTRICT,
  FOREIGN KEY (`material_lot_id`) REFERENCES `TB_MATERIAL_LOT`(`material_lot_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='작업 지시 자재 사용 이력';


-- 29. Table `TB_AUDIT_LOG` (감사 로그)
CREATE TABLE `TB_AUDIT_LOG` (
  `audit_log_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '감사 로그 ID',
  `user_id` BIGINT NOT NULL COMMENT '사용자 ID (FK)',
  `action_type` VARCHAR(50) NOT NULL COMMENT '행위 유형 (예: CREATE, UPDATE, DELETE, LOGIN)',
  `table_name` VARCHAR(50) NOT NULL COMMENT '영향받은 테이블명',
  `record_id` VARCHAR(50) NOT NULL COMMENT '영향받은 레코드 ID',
  `old_value` TEXT NULL COMMENT '이전 값 (JSON)',
  `new_value` TEXT NULL COMMENT '새로운 값 (JSON)',
  `action_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '행위 발생 시간',
  PRIMARY KEY (`audit_log_id`),
  FOREIGN KEY (`user_id`) REFERENCES `TB_USER`(`user_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='감사 로그';


-- 30. Table `TB_INSPECTION_SPEC` (검사 규격)
CREATE TABLE `TB_INSPECTION_SPEC` (
  `spec_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '규격 ID',
  `item_id` VARCHAR(36) NOT NULL COMMENT '품목 ID (FK)',
  `inspection_type` VARCHAR(50) NOT NULL COMMENT '검사 유형 (예: 입고검사, 공정검사)',
  `spec_name` VARCHAR(255) NOT NULL COMMENT '규격명',
  `criteria` VARCHAR(255) NOT NULL COMMENT '합격 기준',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시간',
  PRIMARY KEY (`spec_id`),
  FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM`(`item_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='검사 규격';


-- 31. Table `TB_NON_CONFORMANCE` (부적합 보고서)
CREATE TABLE `TB_NON_CONFORMANCE` (
  `nc_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '부적합 ID',
  `defect_id` BIGINT NOT NULL COMMENT '불량 ID (FK)',
  `cause` TEXT NULL COMMENT '원인 분석',
  `corrective_action` TEXT NULL COMMENT '시정 조치',
  `preventive_action` TEXT NULL COMMENT '예방 조치',
  `report_date` DATETIME NOT NULL COMMENT '보고 일시',
  `worker_id` BIGINT NOT NULL COMMENT '작성자 ID (FK)',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시간',
  PRIMARY KEY (`nc_id`),
  FOREIGN KEY (`defect_id`) REFERENCES `TB_DEFECT`(`defect_id`) ON DELETE RESTRICT,
  FOREIGN KEY (`worker_id`) REFERENCES `TB_USER`(`user_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='부적합 보고서';


-- 32. Table `TB_DOCUMENT_MANAGEMENT` (문서 관리)
CREATE TABLE `TB_DOCUMENT_MANAGEMENT` (
  `doc_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '문서 ID',
  `doc_type` VARCHAR(50) NOT NULL COMMENT '문서 유형 (예: SOP, Drawing)',
  `doc_name` VARCHAR(255) NOT NULL COMMENT '문서명',
  `file_path` VARCHAR(255) NOT NULL COMMENT '파일 경로',
  `version` VARCHAR(20) NOT NULL COMMENT '버전',
  `approval_status` VARCHAR(50) NOT NULL COMMENT '승인 상태',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  `modified_by` VARCHAR(50) NULL COMMENT '수정자',
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시간',
  PRIMARY KEY (`doc_id`)
) ENGINE=InnoDB COMMENT='문서 관리';


-- 33. Table `TB_PRODUCTION_TRACEABILITY` (생산 추적성)
-- 이 테이블은 실제 데이터를 저장하기보다는, 추적성 기능을 위한 뷰(View)로 사용될 수 있는 데이터를 저장합니다.
-- 작업 지시, 자재, 설비, 작업자 정보를 모두 연결하여 최종 제품의 이력을 추적하는 핵심 테이블입니다.
CREATE TABLE `TB_PRODUCTION_TRACEABILITY` (
  `trace_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '추적 ID',
  `work_order_id` VARCHAR(36) NOT NULL COMMENT '작업 지시 ID (FK)',
  `item_id` VARCHAR(36) NOT NULL COMMENT '품목 ID (FK)',
  `material_lot_id` VARCHAR(36) NOT NULL COMMENT '자재 LOT ID (FK)',
  `equipment_id` VARCHAR(36) NOT NULL COMMENT '설비 ID (FK)',
  `worker_id` BIGINT NOT NULL COMMENT '작업자 ID (FK)',
  `production_time` DATETIME NOT NULL COMMENT '생산 시점',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '삭제 여부 (0:false, 1:true)',
  `deleted_at` DATETIME NULL COMMENT '삭제 시간',
  `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  PRIMARY KEY (`trace_id`),
  FOREIGN KEY (`work_order_id`) REFERENCES `TB_WORK_ORDER`(`work_order_id`) ON DELETE RESTRICT,
  FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM`(`item_id`) ON DELETE RESTRICT,
  FOREIGN KEY (`material_lot_id`) REFERENCES `TB_MATERIAL_LOT`(`material_lot_id`) ON DELETE RESTRICT,
  FOREIGN KEY (`equipment_id`) REFERENCES `TB_EQUIPMENT`(`equipment_id`) ON DELETE RESTRICT,
  FOREIGN KEY (`worker_id`) REFERENCES `TB_USER`(`user_id`) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='생산 추적성';

