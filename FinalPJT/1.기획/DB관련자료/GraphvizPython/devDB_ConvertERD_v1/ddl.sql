CREATE TABLE `TB_CODE_GROUP` (
  `group_code` VARCHAR(50) NOT NULL PRIMARY KEY,
  `group_name` VARCHAR(100) NOT NULL UNIQUE,
  `description` VARCHAR(255) NULL,
  `is_deleted` TINYINT DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `created_by` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(50) NULL,
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;


CREATE TABLE `TB_CODE` (
  `code_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `group_code` VARCHAR(50) NOT NULL,
  `code` VARCHAR(50) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(255) NULL,
  `use_yn` CHAR(1) NOT NULL DEFAULT 'Y',
  `sort_order` INT NULL,
  `is_deleted` TINYINT DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `created_by` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(50) NULL,
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `fk_code_group_code` FOREIGN KEY (`group_code`) REFERENCES `TB_CODE_GROUP`(`group_code`) 
) ENGINE=InnoDB;


CREATE TABLE `TB_SHIFT` (
  `shift_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `shift_code` VARCHAR(10) NOT NULL UNIQUE,
  `shift_name` VARCHAR(50) NOT NULL,
  `start_time` TIME NOT NULL,
  `end_time` TIME NOT NULL,
  `is_deleted` TINYINT DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `created_by` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(50) NULL,
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;


CREATE TABLE `TB_WORKSHOP` (
  `workshop_id` VARCHAR(36) NOT NULL PRIMARY KEY,
  `workshop_name` VARCHAR(255) NOT NULL UNIQUE,
  `description` VARCHAR(255) NULL,
  `is_deleted` TINYINT DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `created_by` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(50) NULL,
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;


CREATE TABLE `TB_WORKCENTER` (
  `workcenter_id` VARCHAR(36) NOT NULL PRIMARY KEY,
  `workcenter_name` VARCHAR(255) NOT NULL UNIQUE,
  `workshop_id` VARCHAR(36) NOT NULL,
  `description` VARCHAR(255) NULL,
  `is_deleted` TINYINT DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `created_by` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(50) NULL,
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `fk_workcenter_workshop` FOREIGN KEY (`workshop_id`) REFERENCES `TB_WORKSHOP`(`workshop_id`) 
) ENGINE=InnoDB;


CREATE TABLE `TB_PROCESS` (
  `process_id` VARCHAR(36) NOT NULL PRIMARY KEY,
  `process_name` VARCHAR(255) NOT NULL UNIQUE,
  `description` VARCHAR(255) NULL,
  `is_deleted` TINYINT DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `created_by` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(50) NULL,
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;


CREATE TABLE `TB_EQUIPMENT` (
  `equipment_id` VARCHAR(36) NOT NULL PRIMARY KEY,
  `equipment_name` VARCHAR(255) NOT NULL UNIQUE,
  `workcenter_id` VARCHAR(36) NOT NULL,
  `process_id` VARCHAR(36) NOT NULL,
  `status_code_id` BIGINT NOT NULL,
  `is_deleted` TINYINT DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `created_by` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(50) NULL,
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `fk_eqp_wc` FOREIGN KEY (`workcenter_id`) REFERENCES `TB_WORKCENTER`(`workcenter_id`) ,
  CONSTRAINT `fk_eqp_proc` FOREIGN KEY (`process_id`) REFERENCES `TB_PROCESS`(`process_id`) ,
  CONSTRAINT `fk_eqp_status` FOREIGN KEY (`status_code_id`) REFERENCES `TB_CODE`(`code_id`) 
) ENGINE=InnoDB;


CREATE TABLE `TB_SHIFT_CALENDAR` (
  `calendar_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `shift_date` DATE NOT NULL,
  `shift_id` BIGINT NOT NULL,
  `equipment_id` VARCHAR(36) NULL,
  `workcenter_id` VARCHAR(36) NULL,
  `start_ts` DATETIME NOT NULL,
  `end_ts` DATETIME NOT NULL,
  `is_deleted` TINYINT DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `created_by` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(50) NULL,
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `fk_shiftcal_shift` FOREIGN KEY (`shift_id`) REFERENCES `TB_SHIFT`(`shift_id`) ,
  CONSTRAINT `fk_shiftcal_eqp` FOREIGN KEY (`equipment_id`) REFERENCES `TB_EQUIPMENT`(`equipment_id`) ,
  CONSTRAINT `fk_shiftcal_wc` FOREIGN KEY (`workcenter_id`) REFERENCES `TB_WORKCENTER`(`workcenter_id`) 
) ENGINE=InnoDB;


CREATE TABLE `TB_ROLE` (
  `role_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `role_code` VARCHAR(50) NOT NULL UNIQUE,
  `role_name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(255) NULL,
  `is_deleted` TINYINT DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `created_by` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(50) NULL,
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;


CREATE TABLE `TB_USER` (
  `user_id` VARCHAR(36) NOT NULL PRIMARY KEY,
  `username` VARCHAR(50) NOT NULL UNIQUE,
  `email` VARCHAR(255) NULL UNIQUE,
  `password_hash` VARCHAR(100) NOT NULL,
  `password_algo` VARCHAR(20) NOT NULL DEFAULT 'bcrypt',
  `is_active` TINYINT NOT NULL DEFAULT 1,
  `failed_login_count` INT NOT NULL DEFAULT 0,
  `locked_until` DATETIME NULL,
  `last_login_at` DATETIME NULL,
  `phone` VARCHAR(30) NULL,
  `display_name` VARCHAR(100) NULL,
  `is_deleted` TINYINT DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `created_by` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(50) NULL,
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;


CREATE TABLE `TB_USER_ROLE` (
  `user_role_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` VARCHAR(36) NOT NULL,
  `role_id` BIGINT NOT NULL,
  `is_deleted` TINYINT DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `created_by` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(50) NULL,
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `fk_userrole_user` FOREIGN KEY (`user_id`) REFERENCES `TB_USER`(`user_id`) ,
  CONSTRAINT `fk_userrole_role` FOREIGN KEY (`role_id`) REFERENCES `TB_ROLE`(`role_id`) 
) ENGINE=InnoDB;


CREATE TABLE `TB_MENU` (
  `menu_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `parent_id` BIGINT NULL,
  `menu_code` VARCHAR(100) NOT NULL UNIQUE,
  `menu_name` VARCHAR(150) NOT NULL,
  `path` VARCHAR(255) NOT NULL,
  `component` VARCHAR(255) NULL,
  `icon` VARCHAR(100) NULL,
  `sort_order` INT NOT NULL DEFAULT 0,
  `is_public` TINYINT NOT NULL DEFAULT 0,
  `is_active` TINYINT NOT NULL DEFAULT 1,
  `is_deleted` TINYINT DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `created_by` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(50) NULL,
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `fk_menu_parent` FOREIGN KEY (`parent_id`) REFERENCES `TB_MENU`(`menu_id`) 
) ENGINE=InnoDB;


CREATE TABLE `TB_ROLE_MENU` (
  `role_menu_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `role_id` BIGINT NOT NULL,
  `menu_id` BIGINT NOT NULL,
  `allow_read` TINYINT NOT NULL DEFAULT 1,
  `allow_write` TINYINT NOT NULL DEFAULT 0,
  `allow_exec` TINYINT NOT NULL DEFAULT 0,
  `is_deleted` TINYINT DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `created_by` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(50) NULL,
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `fk_rm_role` FOREIGN KEY (`role_id`) REFERENCES `TB_ROLE`(`role_id`) ,
  CONSTRAINT `fk_rm_menu` FOREIGN KEY (`menu_id`) REFERENCES `TB_MENU`(`menu_id`) 
) ENGINE=InnoDB;


CREATE TABLE `TB_SHIFT_ASSIGNMENT` (
  `assignment_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `shift_date` DATE NOT NULL,
  `shift_id` BIGINT NOT NULL,
  `worker_id` VARCHAR(36) NOT NULL,
  `equipment_id` VARCHAR(36) NULL,
  `workcenter_id` VARCHAR(36) NULL,
  `start_ts` DATETIME NOT NULL,
  `end_ts` DATETIME NOT NULL,
  `is_deleted` TINYINT DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `created_by` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(50) NULL,
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `fk_assign_shift` FOREIGN KEY (`shift_id`) REFERENCES `TB_SHIFT`(`shift_id`) ,
  CONSTRAINT `fk_assign_user` FOREIGN KEY (`worker_id`) REFERENCES `TB_USER`(`user_id`) ,
  CONSTRAINT `fk_assign_eqp` FOREIGN KEY (`equipment_id`) REFERENCES `TB_EQUIPMENT`(`equipment_id`) ,
  CONSTRAINT `fk_assign_wc` FOREIGN KEY (`workcenter_id`) REFERENCES `TB_WORKCENTER`(`workcenter_id`) 
) ENGINE=InnoDB;


CREATE TABLE `TB_ITEM` (
  `item_id` VARCHAR(36) NOT NULL PRIMARY KEY,
  `item_code` VARCHAR(50) NOT NULL UNIQUE,
  `item_name` VARCHAR(255) NOT NULL,
  `item_type` CHAR(1) NOT NULL,
  `unit` VARCHAR(10) NOT NULL,
  `description` VARCHAR(255) NULL,
  `is_deleted` TINYINT DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `created_by` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(50) NULL,
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;


CREATE TABLE `TB_WAREHOUSE` (
  `warehouse_id` VARCHAR(36) NOT NULL PRIMARY KEY,
  `warehouse_name` VARCHAR(255) NOT NULL UNIQUE,
  `location` VARCHAR(255) NULL,
  `description` VARCHAR(255) NULL,
  `is_deleted` TINYINT DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `created_by` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(50) NULL,
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;


CREATE TABLE `TB_PRODUCTION_PLAN` (
  `plan_id` VARCHAR(36) NOT NULL PRIMARY KEY,
  `plan_number` VARCHAR(50) NOT NULL UNIQUE,
  `item_id` VARCHAR(36) NOT NULL,
  `target_qty` DECIMAL(10,4) NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `status` CHAR(1) NOT NULL,
  `is_deleted` TINYINT DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `created_by` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(50) NULL,
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `fk_plan_item` FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM`(`item_id`) 
) ENGINE=InnoDB;


CREATE TABLE `TB_WORK_ORDER` (
  `work_order_id` VARCHAR(36) NOT NULL PRIMARY KEY,
  `plan_id` VARCHAR(36) NULL,
  `work_order_number` VARCHAR(50) NOT NULL UNIQUE,
  `item_id` VARCHAR(36) NOT NULL,
  `process_id` VARCHAR(36) NOT NULL,
  `equipment_id` VARCHAR(36) NOT NULL,
  `order_qty` DECIMAL(10,4) NOT NULL,
  `produced_qty` DECIMAL(10,4) NOT NULL DEFAULT 0,
  `start_ts` DATETIME NULL,
  `end_ts` DATETIME NULL,
  `status_code_id` BIGINT NOT NULL,
  `is_deleted` TINYINT DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `created_by` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(50) NULL,
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `fk_wo_plan` FOREIGN KEY (`plan_id`) REFERENCES `TB_PRODUCTION_PLAN`(`plan_id`) ,
  CONSTRAINT `fk_wo_item` FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM`(`item_id`) ,
  CONSTRAINT `fk_wo_process` FOREIGN KEY (`process_id`) REFERENCES `TB_PROCESS`(`process_id`) ,
  CONSTRAINT `fk_wo_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `TB_EQUIPMENT`(`equipment_id`) ,
  CONSTRAINT `fk_wo_status_code` FOREIGN KEY (`status_code_id`) REFERENCES `TB_CODE`(`code_id`) 
) ENGINE=InnoDB;


CREATE TABLE `TB_BOM` (
  `bom_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `parent_item_id` VARCHAR(36) NOT NULL,
  `child_item_id` VARCHAR(36) NOT NULL,
  `quantity` DECIMAL(10,4) NOT NULL,
  `line_no` INT NOT NULL,
  `is_deleted` TINYINT DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `created_by` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(50) NULL,
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `fk_bom_parent` FOREIGN KEY (`parent_item_id`) REFERENCES `TB_ITEM`(`item_id`) ,
  CONSTRAINT `fk_bom_child` FOREIGN KEY (`child_item_id`) REFERENCES `TB_ITEM`(`item_id`) 
) ENGINE=InnoDB;


CREATE TABLE `TB_MATERIAL_LOT` (
  `material_lot_id` VARCHAR(36) NOT NULL PRIMARY KEY,
  `lot_number` VARCHAR(50) NOT NULL UNIQUE,
  `item_id` VARCHAR(36) NOT NULL,
  `warehouse_id` VARCHAR(36) NOT NULL,
  `quantity` DECIMAL(10,4) NOT NULL,
  `is_deleted` TINYINT DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `created_by` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(50) NULL,
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `fk_material_lot_item` FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM`(`item_id`) ,
  CONSTRAINT `fk_material_lot_warehouse` FOREIGN KEY (`warehouse_id`) REFERENCES `TB_WAREHOUSE`(`warehouse_id`) 
) ENGINE=InnoDB;


CREATE TABLE `TB_PRODUCTION_PERFORMANCE` (
  `performance_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `work_order_id` VARCHAR(36) NOT NULL,
  `item_id` VARCHAR(36) NOT NULL,
  `process_id` VARCHAR(36) NOT NULL,
  `equipment_id` VARCHAR(36) NOT NULL,
  `produced_qty` DECIMAL(10,4) NOT NULL,
  `defect_qty` DECIMAL(10,4) NOT NULL DEFAULT 0,
  `start_time` DATETIME NOT NULL,
  `end_time` DATETIME NOT NULL,
  `worker_id` VARCHAR(36) NULL,
  `is_deleted` TINYINT DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `created_by` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(50) NULL,
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `fk_perf_wo` FOREIGN KEY (`work_order_id`) REFERENCES `TB_WORK_ORDER`(`work_order_id`) ,
  CONSTRAINT `fk_perf_item` FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM`(`item_id`) ,
  CONSTRAINT `fk_perf_process` FOREIGN KEY (`process_id`) REFERENCES `TB_PROCESS`(`process_id`) ,
  CONSTRAINT `fk_perf_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `TB_EQUIPMENT`(`equipment_id`) ,
  CONSTRAINT `fk_perf_user` FOREIGN KEY (`worker_id`) REFERENCES `TB_USER`(`user_id`) 
) ENGINE=InnoDB;


CREATE TABLE `TB_EQUIPMENT_STATUS_LOG` (
  `log_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `equipment_id` VARCHAR(36) NOT NULL,
  `status_code_id` BIGINT NOT NULL,
  `reason_code_id` BIGINT NULL,
  `work_order_id` VARCHAR(36) NULL,
  `shift_id` BIGINT NULL,
  `start_time` DATETIME NOT NULL,
  `end_time` DATETIME NULL,
  `is_deleted` TINYINT DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `created_by` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(50) NULL,
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `fk_log_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `TB_EQUIPMENT`(`equipment_id`) ,
  CONSTRAINT `fk_log_status_code` FOREIGN KEY (`status_code_id`) REFERENCES `TB_CODE`(`code_id`) ,
  CONSTRAINT `fk_log_reason_code` FOREIGN KEY (`reason_code_id`) REFERENCES `TB_CODE`(`code_id`) ,
  CONSTRAINT `fk_log_wo` FOREIGN KEY (`work_order_id`) REFERENCES `TB_WORK_ORDER`(`work_order_id`) ,
  CONSTRAINT `fk_log_shift` FOREIGN KEY (`shift_id`) REFERENCES `TB_SHIFT`(`shift_id`) 
) ENGINE=InnoDB;


CREATE TABLE `TB_INSPECTION` (
  `inspection_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `work_order_id` VARCHAR(36) NULL,
  `material_lot_id` VARCHAR(36) NULL,
  `item_id` VARCHAR(36) NOT NULL,
  `inspection_type_code_id` BIGINT NOT NULL,
  `inspection_time` DATETIME NOT NULL,
  `worker_id` VARCHAR(36) NOT NULL,
  `process_id` VARCHAR(36) NULL,
  `equipment_id` VARCHAR(36) NULL,
  `is_deleted` TINYINT DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `created_by` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(50) NULL,
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `fk_insp_wo` FOREIGN KEY (`work_order_id`) REFERENCES `TB_WORK_ORDER`(`work_order_id`) ,
  CONSTRAINT `fk_insp_lot` FOREIGN KEY (`material_lot_id`) REFERENCES `TB_MATERIAL_LOT`(`material_lot_id`) ,
  CONSTRAINT `fk_insp_item` FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM`(`item_id`) ,
  CONSTRAINT `fk_insp_type` FOREIGN KEY (`inspection_type_code_id`) REFERENCES `TB_CODE`(`code_id`) ,
  CONSTRAINT `fk_insp_user` FOREIGN KEY (`worker_id`) REFERENCES `TB_USER`(`user_id`) ,
  CONSTRAINT `fk_insp_proc` FOREIGN KEY (`process_id`) REFERENCES `TB_PROCESS`(`process_id`) ,
  CONSTRAINT `fk_insp_eqp` FOREIGN KEY (`equipment_id`) REFERENCES `TB_EQUIPMENT`(`equipment_id`) 
) ENGINE=InnoDB;


CREATE TABLE `TB_INSPECTION_RESULT` (
  `result_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `inspection_id` BIGINT NOT NULL,
  `item_id` VARCHAR(36) NOT NULL,
  `result_value` VARCHAR(255) NOT NULL,
  `is_deleted` TINYINT DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `created_by` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(50) NULL,
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `fk_result_inspection` FOREIGN KEY (`inspection_id`) REFERENCES `TB_INSPECTION`(`inspection_id`) ,
  CONSTRAINT `fk_result_item` FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM`(`item_id`) 
) ENGINE=InnoDB;


CREATE TABLE `TB_DEFECT` (
  `defect_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `inspection_id` BIGINT NOT NULL,
  `defect_type_code_id` BIGINT NOT NULL,
  `defect_qty` DECIMAL(10,4) NOT NULL DEFAULT 0,
  `is_deleted` TINYINT DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `created_by` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(50) NULL,
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `fk_defect_inspection` FOREIGN KEY (`inspection_id`) REFERENCES `TB_INSPECTION`(`inspection_id`) ,
  CONSTRAINT `fk_defect_type_code` FOREIGN KEY (`defect_type_code_id`) REFERENCES `TB_CODE`(`code_id`) 
) ENGINE=InnoDB;


CREATE TABLE `TB_NON_CONFORMANCE` (
  `non_conformance_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `defect_id` BIGINT NOT NULL UNIQUE,
  `cause` TEXT NULL,
  `corrective_action` TEXT NULL,
  `preventive_action` TEXT NULL,
  `report_date` DATETIME NOT NULL,
  `worker_id` VARCHAR(36) NOT NULL,
  `is_deleted` TINYINT DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `created_by` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(50) NULL,
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `fk_nc_defect` FOREIGN KEY (`defect_id`) REFERENCES `TB_DEFECT`(`defect_id`) ,
  CONSTRAINT `fk_nc_user` FOREIGN KEY (`worker_id`) REFERENCES `TB_USER`(`user_id`) 
) ENGINE=InnoDB;


CREATE TABLE `TB_KPI_TARGET` (
  `target_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `kpi_date` DATE NOT NULL,
  `equipment_id` VARCHAR(36) NOT NULL,
  `process_id` VARCHAR(36) NOT NULL,
  `item_id` VARCHAR(36) NOT NULL,
  `target_oee` DECIMAL(5,2) NOT NULL DEFAULT 0,
  `target_productivity` DECIMAL(10,4) NOT NULL DEFAULT 0,
  `target_yield` DECIMAL(5,2) NOT NULL DEFAULT 0,
  `is_deleted` TINYINT DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `created_by` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(50) NULL,
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `fk_kpi_target_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `TB_EQUIPMENT`(`equipment_id`) ,
  CONSTRAINT `fk_kpi_target_process` FOREIGN KEY (`process_id`) REFERENCES `TB_PROCESS`(`process_id`) ,
  CONSTRAINT `fk_kpi_target_item` FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM`(`item_id`) 
) ENGINE=InnoDB;


CREATE TABLE `TB_AUDIT_LOG` (
  `log_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` VARCHAR(36) NULL,
  `log_type` VARCHAR(50) NOT NULL,
  `message` TEXT NOT NULL,
  `resource_table` VARCHAR(100) NULL,
  `resource_id` VARCHAR(255) NULL,
  `is_deleted` TINYINT DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `created_by` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(50) NULL,
  `modified_at` DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `fk_audit_user` FOREIGN KEY (`user_id`) REFERENCES `TB_USER`(`user_id`) 
) ENGINE=InnoDB;