CREATE TABLE `TB_COMMON_CODE_GROUP` (
    `group_code` VARCHAR(50) NOT NULL COMMENT '공통 코드 그룹 코드',
    `group_name` VARCHAR(100) NOT NULL COMMENT '공통 코드 그룹명',
    `description` VARCHAR(255) NULL COMMENT '설명',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`group_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='공통 코드 그룹';

CREATE TABLE `TB_COMMON_CODE` (
    `code_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '코드 ID',
    `group_code` VARCHAR(50) NOT NULL COMMENT '공통 코드 그룹 코드',
    `code_value` VARCHAR(50) NOT NULL COMMENT '코드 값',
    `code_name` VARCHAR(100) NOT NULL COMMENT '코드명',
    `description` VARCHAR(255) NULL COMMENT '설명',
    `sort_order` INT NULL DEFAULT 0 COMMENT '정렬 순서',
    `use_yn` CHAR(1) NOT NULL DEFAULT 'Y' COMMENT '사용 여부 (Y/N)',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`code_id`),
    UNIQUE KEY `uk_group_code_value` (`group_code`, `code_value`),
    FOREIGN KEY (`group_code`) REFERENCES `TB_COMMON_CODE_GROUP` (`group_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='공통 코드';

CREATE TABLE `TB_USER` (
    `user_id` VARCHAR(50) NOT NULL COMMENT '사용자 ID',
    `password` VARCHAR(255) NOT NULL COMMENT '비밀번호',
    `user_name` VARCHAR(100) NOT NULL COMMENT '사용자명',
    `email` VARCHAR(100) NULL COMMENT '이메일',
    `phone_number` VARCHAR(20) NULL COMMENT '연락처',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='사용자 정보';

CREATE TABLE `TB_ROLE` (
    `role_id` VARCHAR(50) NOT NULL COMMENT '역할 ID',
    `role_name` VARCHAR(100) NOT NULL COMMENT '역할명',
    `description` VARCHAR(255) NULL COMMENT '설명',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='역할/권한';

CREATE TABLE `TB_ORGANIZATION` (
    `org_id` VARCHAR(50) NOT NULL COMMENT '조직 ID',
    `org_name` VARCHAR(100) NOT NULL COMMENT '조직명',
    `parent_org_id` VARCHAR(50) NULL COMMENT '상위 조직 ID',
    `org_type` VARCHAR(50) NULL COMMENT '조직 유형 (예: 부서, 팀, 공장 등)',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`org_id`),
    CONSTRAINT `fk_org_parent` FOREIGN KEY (`parent_org_id`) REFERENCES `TB_ORGANIZATION` (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='조직 정보';

CREATE TABLE `TB_SYSTEM_MENU` (
    `menu_id` VARCHAR(50) NOT NULL COMMENT '메뉴 ID',
    `menu_name` VARCHAR(100) NOT NULL COMMENT '메뉴명',
    `parent_menu_id` VARCHAR(50) NULL COMMENT '상위 메뉴 ID',
    `menu_url` VARCHAR(255) NULL COMMENT '메뉴 URL',
    `menu_order` INT NULL DEFAULT 0 COMMENT '메뉴 순서',
    `icon` VARCHAR(50) NULL COMMENT '아이콘',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`menu_id`),
    CONSTRAINT `fk_menu_parent` FOREIGN KEY (`parent_menu_id`) REFERENCES `TB_SYSTEM_MENU` (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='시스템 메뉴';

CREATE TABLE `TB_MENU_ROLE_MAPPING` (
    `mapping_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '매핑 ID',
	`user_id` VARCHAR(50) NOT NULL COMMENT '사용자 ID',
    `menu_id` VARCHAR(50) NOT NULL COMMENT '메뉴 ID',
    `role_id` VARCHAR(50) NOT NULL COMMENT '역할 ID',
    `can_view` TINYINT NOT NULL DEFAULT 1 COMMENT '조회 가능 여부',
    `can_edit` TINYINT NOT NULL DEFAULT 0 COMMENT '편집 가능 여부',
    `can_delete` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 가능 여부',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`mapping_id`),
    UNIQUE KEY `uk_menu_role` (`menu_id`, `role_id`),
    CONSTRAINT `fk_mapping_menu` FOREIGN KEY (`menu_id`) REFERENCES `TB_SYSTEM_MENU` (`menu_id`),
    CONSTRAINT `fk_user_role_user` FOREIGN KEY (`user_id`) REFERENCES `TB_USER` (`user_id`),
    CONSTRAINT `fk_mapping_role` FOREIGN KEY (`role_id`) REFERENCES `TB_ROLE` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='메뉴 역할 매핑';

CREATE TABLE `TB_ITEM` (
    `item_id` VARCHAR(50) NOT NULL COMMENT '품목 ID',
    `item_name` VARCHAR(200) NOT NULL COMMENT '품목명',
    `item_type` VARCHAR(50) NOT NULL COMMENT '품목 유형 (제품, 반제품, 원자재, 부자재)',
    `unit` VARCHAR(10) NOT NULL COMMENT '기본 단위',
    `specification` VARCHAR(255) NULL COMMENT '규격',
    `description` VARCHAR(500) NULL COMMENT '설명',
    `safety_stock_qty` DECIMAL(10,4) NULL DEFAULT 0 COMMENT '안전 재고 수량',
    `lead_time_days` INT NULL DEFAULT 0 COMMENT '리드 타임 (일)',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='품목 마스터';

CREATE TABLE `TB_WORKPLACE` (
    `workplace_id` VARCHAR(50) NOT NULL COMMENT '작업장 ID',
    `workplace_name` VARCHAR(100) NOT NULL COMMENT '작업장명',
    `description` VARCHAR(255) NULL COMMENT '설명',
    `location` VARCHAR(100) NULL COMMENT '위치',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`workplace_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='작업장 마스터';

CREATE TABLE `TB_WAREHOUSE` (
    `warehouse_id` VARCHAR(50) NOT NULL COMMENT '창고 ID',
    `warehouse_name` VARCHAR(100) NOT NULL COMMENT '창고명',
    `location` VARCHAR(255) NULL COMMENT '위치',
    `description` VARCHAR(255) NULL COMMENT '설명',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`warehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='창고 마스터';

CREATE TABLE `TB_DOCUMENT_MANAGEMENT` (
    `document_id` VARCHAR(50) NOT NULL COMMENT '문서 ID',
    `document_type` VARCHAR(50) NOT NULL COMMENT '문서 유형 (예: SOP, 사양서, 작업 표준서)',
    `document_name` VARCHAR(255) NOT NULL COMMENT '문서명',
    `version` VARCHAR(20) NOT NULL COMMENT '버전',
    `file_path` VARCHAR(500) NOT NULL COMMENT '파일 경로',
    `effective_date` DATE NOT NULL COMMENT '적용 일자',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`document_id`),
    UNIQUE KEY `uk_doc_type_name_version` (`document_type`, `document_name`, `version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='문서 관리';


CREATE TABLE `TB_MES_BOM` (
    `bom_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT 'BOM ID',
    `parent_item_id` VARCHAR(50) NOT NULL COMMENT '상위 품목 ID',
    `child_item_id` VARCHAR(50) NOT NULL COMMENT '하위 품목 ID',
    `quantity` DECIMAL(10,4) NOT NULL COMMENT '소요 수량',
    `unit` VARCHAR(10) NOT NULL COMMENT '단위',
    `start_date` DATE NULL COMMENT '유효 시작일',
    `end_date` DATE NULL COMMENT '유효 종료일',
    `description` VARCHAR(255) NULL COMMENT '설명',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`bom_id`),
    UNIQUE KEY `uk_parent_child` (`parent_item_id`, `child_item_id`),
    CONSTRAINT `fk_bom_parent_item` FOREIGN KEY (`parent_item_id`) REFERENCES `TB_ITEM` (`item_id`),
    CONSTRAINT `fk_bom_child_item` FOREIGN KEY (`child_item_id`) REFERENCES `TB_ITEM` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='BOM 마스터';

CREATE TABLE `TB_COMPONENT_PRODUCT_MAPPING` (
    `mapping_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '매핑 ID',
    `component_item_id` VARCHAR(50) NOT NULL COMMENT '원자재 품목 ID',
    `product_item_id` VARCHAR(50) NOT NULL COMMENT '제품 품목 ID',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`mapping_id`),
    UNIQUE KEY `uk_component_product` (`component_item_id`, `product_item_id`),
    CONSTRAINT `fk_comp_prod_component` FOREIGN KEY (`component_item_id`) REFERENCES `TB_ITEM` (`item_id`),
    CONSTRAINT `fk_comp_prod_product` FOREIGN KEY (`product_item_id`) REFERENCES `TB_ITEM` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='원자재-제품 매핑';

CREATE TABLE `TB_ROUTE` (
    `route_id` VARCHAR(50) NOT NULL COMMENT '라우팅 ID',
    `item_id` VARCHAR(50) NOT NULL COMMENT '품목 ID',
    `route_name` VARCHAR(100) NOT NULL COMMENT '라우팅명',
    `description` VARCHAR(255) NULL COMMENT '설명',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`route_id`),
    UNIQUE KEY `uk_item_id` (`item_id`),
    CONSTRAINT `fk_route_item` FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='공정 라우팅';

CREATE TABLE `TB_LINE` (
    `line_id` VARCHAR(50) NOT NULL COMMENT '라인 ID',
    `line_name` VARCHAR(100) NOT NULL COMMENT '라인명',
    `workplace_id` VARCHAR(50) NOT NULL COMMENT '속한 작업장 ID',
    `description` VARCHAR(255) NULL COMMENT '설명',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`line_id`),
    CONSTRAINT `fk_line_workplace` FOREIGN KEY (`workplace_id`) REFERENCES `TB_WORKPLACE` (`workplace_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='생산 라인';

CREATE TABLE `TB_EQUIPMENT` (
    `equip_id` VARCHAR(50) NOT NULL COMMENT '설비 ID',
    `equip_name` VARCHAR(100) NOT NULL COMMENT '설비명',
    `line_id` VARCHAR(50) NOT NULL COMMENT '속한 라인 ID',
    `equip_group_code` VARCHAR(50) NOT NULL COMMENT '설비 공통 코드 그룹',
    `equip_type` VARCHAR(50) NOT NULL COMMENT '설비 유형',
    `model_no` VARCHAR(100) NULL COMMENT '모델 번호',
    `serial_no` VARCHAR(100) NULL COMMENT '시리얼 번호',
    `install_date` DATE NULL COMMENT '설치 일자',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`equip_id`),
    CONSTRAINT `fk_equip_line` FOREIGN KEY (`line_id`) REFERENCES `TB_LINE` (`line_id`),
    CONSTRAINT `fk_equip_common_code` FOREIGN KEY (`equip_group_code`, `equip_type`) REFERENCES `TB_COMMON_CODE` (`group_code`, `code_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='설비 마스터';

CREATE TABLE `TB_PRODUCTION_PLAN` (
    `plan_id` VARCHAR(50) NOT NULL COMMENT '계획 ID',
    `plan_name` VARCHAR(100) NOT NULL COMMENT '계획명',
    `plan_date` DATE NOT NULL COMMENT '계획 일자',
    `item_id` VARCHAR(50) NOT NULL COMMENT '품목 ID',
    `plan_quantity` DECIMAL(10,4) NOT NULL COMMENT '계획 수량',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`plan_id`),
    UNIQUE KEY `uk_plan_date_item` (`plan_date`, `item_id`),
    FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='생산 계획';

CREATE TABLE `TB_INSPECTION_PLAN` (
    `inspection_plan_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '검사 계획 ID',
    `item_id` VARCHAR(50) NOT NULL COMMENT '품목 ID',
    `inspection_type` VARCHAR(50) NOT NULL COMMENT '검사 유형 (예: 수입, 공정, 출하)',
    `sampling_rate` DECIMAL(5,2) NOT NULL DEFAULT 0 COMMENT '샘플링 비율 (%)',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`inspection_plan_id`),
    UNIQUE KEY `uk_item_insp_type` (`item_id`, `inspection_type`),
    FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='검사 계획';

CREATE TABLE `TB_QUALITY_CHECKLIST` (
    `checklist_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '점검표 ID',
    `item_id` VARCHAR(50) NOT NULL COMMENT '품목 ID',
    `checklist_name` VARCHAR(100) NOT NULL COMMENT '점검표명',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`checklist_id`),
    UNIQUE KEY `uk_checklist_item` (`item_id`),
    FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='품질 점검표';


CREATE TABLE `TB_ROUTE_OPERATION` (
    `operation_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '공정 ID',
    `route_id` VARCHAR(50) NOT NULL COMMENT '라우팅 ID',
    `operation_group_code` VARCHAR(50) NOT NULL COMMENT '공정 공통 코드 그룹',
    `operation_code` VARCHAR(50) NOT NULL COMMENT '공정 코드',
    `operation_name` VARCHAR(100) NOT NULL COMMENT '공정명',
    `workplace_id` VARCHAR(50) NOT NULL COMMENT '작업장 ID',
    `sequence` INT NOT NULL COMMENT '공정 순서',
    `standard_time_per_unit` DECIMAL(10,4) NULL COMMENT '단위당 표준 시간',
    `description` VARCHAR(255) NULL COMMENT '설명',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`operation_id`),
    UNIQUE KEY `uk_route_sequence` (`route_id`, `sequence`),
    CONSTRAINT `fk_rout_oper_route` FOREIGN KEY (`route_id`) REFERENCES `TB_ROUTE` (`route_id`),
    CONSTRAINT `fk_rout_oper_workplace` FOREIGN KEY (`workplace_id`) REFERENCES `TB_WORKPLACE` (`workplace_id`),
    CONSTRAINT `fk_rout_oper_common_code` FOREIGN KEY (`operation_group_code`, `operation_code`) REFERENCES `TB_COMMON_CODE` (`group_code`, `code_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='라우팅 공정';

CREATE TABLE `TB_PARAMETER_MANAGEMENT` (
    `parameter_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '파라미터 ID',
    `equip_id` VARCHAR(50) NOT NULL COMMENT '설비 ID',
    `parameter_name` VARCHAR(100) NOT NULL COMMENT '파라미터명',
    `standard_value` VARCHAR(255) NULL COMMENT '표준 값',
    `upper_limit` VARCHAR(255) NULL COMMENT '상한선',
    `lower_limit` VARCHAR(255) NULL COMMENT '하한선',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`parameter_id`),
    UNIQUE KEY `uk_equip_param_name` (`equip_id`, `parameter_name`),
    FOREIGN KEY (`equip_id`) REFERENCES `TB_EQUIPMENT` (`equip_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='설비 파라미터';

CREATE TABLE `TB_WORK_ORDER` (
    `work_order_id` VARCHAR(50) NOT NULL COMMENT '작업 지시 ID',
    `production_plan_id` VARCHAR(50) NULL COMMENT '생산 계획 ID',
    `item_id` VARCHAR(50) NOT NULL COMMENT '품목 ID',
    `quantity` DECIMAL(10,4) NOT NULL COMMENT '지시 수량',
    `work_order_status_group_code` VARCHAR(50) NOT NULL COMMENT '작업 지시 상태 공통 코드 그룹',
    `work_order_status` VARCHAR(50) NOT NULL COMMENT '작업 지시 상태',
    `start_date` DATE NOT NULL COMMENT '시작 예정일',
    `due_date` DATE NOT NULL COMMENT '완료 예정일',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`work_order_id`),
    FOREIGN KEY (`production_plan_id`) REFERENCES `TB_PRODUCTION_PLAN` (`plan_id`),
    FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM` (`item_id`),
    CONSTRAINT `fk_wo_status_common_code` FOREIGN KEY (`work_order_status_group_code`, `work_order_status`) REFERENCES `TB_COMMON_CODE` (`group_code`, `code_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='작업 지시';

CREATE TABLE `TB_QUALITY_CHECKLIST_ITEM` (
    `checklist_item_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '점검 항목 ID',
    `checklist_id` BIGINT NOT NULL COMMENT '점검표 ID',
    `check_item_name` VARCHAR(100) NOT NULL COMMENT '점검 항목명',
    `check_specification` VARCHAR(255) NULL COMMENT '점검 기준',
    `check_type_group_code` VARCHAR(50) NOT NULL COMMENT '점검 유형 공통 코드 그룹',
    `check_type` VARCHAR(50) NOT NULL COMMENT '점검 유형 (측정, 육안 등)',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`checklist_item_id`),
    FOREIGN KEY (`checklist_id`) REFERENCES `TB_QUALITY_CHECKLIST` (`checklist_id`),
    CONSTRAINT `fk_chk_item_type_common_code` FOREIGN KEY (`check_type_group_code`, `check_type`) REFERENCES `TB_COMMON_CODE` (`group_code`, `code_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='품질 점검 항목';

CREATE TABLE `TB_LOT_MASTER` (
    `lot_number` VARCHAR(50) NOT NULL COMMENT 'LOT 번호',
    `item_id` VARCHAR(50) NOT NULL COMMENT '품목 ID',
    `production_date` DATE NOT NULL COMMENT '생산 일자',
    `expiry_date` DATE NULL COMMENT '유효 기간',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`lot_number`),
    FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='LOT 마스터';

CREATE TABLE `TB_INVENTORY` (
    `inventory_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '재고 ID',
    `item_id` VARCHAR(50) NOT NULL COMMENT '품목 ID',
    `location_code` VARCHAR(50) NOT NULL COMMENT '창고 위치 코드',
    `lot_number` VARCHAR(50) NULL COMMENT 'LOT 번호',
    `quantity` DECIMAL(10,4) NOT NULL COMMENT '재고 수량',
    `unit` VARCHAR(10) NOT NULL COMMENT '단위',
    `expiry_date` DATE NULL COMMENT '유효 기간',
    `last_update_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 업데이트 일시',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`inventory_id`),
    UNIQUE KEY `uk_item_lot_location` (`item_id`, `lot_number`, `location_code`),
    FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='재고 정보';



CREATE TABLE `TB_PRODUCTION_ORDER` (
    `production_order_id` VARCHAR(50) NOT NULL COMMENT '생산 지시 ID',
    `work_order_id` VARCHAR(50) NOT NULL COMMENT '작업 지시 ID',
    `route_id` VARCHAR(50) NOT NULL COMMENT '라우팅 ID',
    `order_quantity` DECIMAL(10,4) NOT NULL COMMENT '생산 지시 수량',
    `order_status_group_code` VARCHAR(50) NOT NULL COMMENT '공통 코드 그룹 코드 (예: 생산 지시 상태)',
    `order_status` VARCHAR(50) NOT NULL COMMENT '생산 지시 상태 (code_value)',
    `start_date` DATETIME NULL COMMENT '실제 시작 일시',
    `end_date` DATETIME NULL COMMENT '실제 완료 일시',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`production_order_id`),
    FOREIGN KEY (`work_order_id`) REFERENCES `TB_WORK_ORDER` (`work_order_id`),
    FOREIGN KEY (`route_id`) REFERENCES `TB_ROUTE` (`route_id`),
    CONSTRAINT `fk_po_status_common_code` FOREIGN KEY (`order_status_group_code`, `order_status`)
        REFERENCES `TB_COMMON_CODE` (`group_code`, `code_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='생산 지시';


CREATE TABLE `TB_STOCK_MOVEMENT` (
    `movement_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '이동 ID',
    `item_id` VARCHAR(50) NOT NULL COMMENT '품목 ID',
    `lot_number` VARCHAR(50) NULL COMMENT 'LOT 번호',
    `from_location_code` VARCHAR(50) NULL COMMENT '출발 창고 위치',
    `to_location_code` VARCHAR(50) NOT NULL COMMENT '도착 창고 위치',
    `movement_quantity` DECIMAL(10,4) NOT NULL COMMENT '이동 수량',
    `movement_type_group_code` VARCHAR(50) NOT NULL COMMENT '이동 유형 공통 코드 그룹',
    `movement_type` VARCHAR(50) NOT NULL COMMENT '이동 유형 (입고, 출고, 이동)',
    `movement_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '이동 일시',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`movement_id`),
    FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM` (`item_id`),
    CONSTRAINT `fk_stock_move_type_common_code` FOREIGN KEY (`movement_type_group_code`, `movement_type`) REFERENCES `TB_COMMON_CODE` (`group_code`, `code_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='재고 이동 이력';

CREATE TABLE `TB_INSPECTION_RESULT` (
    `inspection_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '검사 ID',
    `inspection_plan_id` BIGINT NOT NULL COMMENT '검사 계획 ID',
    `lot_number` VARCHAR(50) NOT NULL COMMENT 'LOT 번호',
    `inspection_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '검사 일시',
    `inspection_result_group_code` VARCHAR(50) NOT NULL COMMENT '검사 결과 공통 코드 그룹',
    `inspection_result` VARCHAR(50) NOT NULL COMMENT '검사 결과 (합격, 불합격)',
    `inspector_id` VARCHAR(50) NOT NULL COMMENT '검사자 ID',
    `notes` VARCHAR(500) NULL COMMENT '비고',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`inspection_id`),
    UNIQUE KEY `uk_lot_insp` (`lot_number`, `inspection_plan_id`),
    FOREIGN KEY (`inspection_plan_id`) REFERENCES `TB_INSPECTION_PLAN` (`inspection_plan_id`),
    FOREIGN KEY (`inspector_id`) REFERENCES `TB_USER` (`user_id`),
    CONSTRAINT `fk_insp_res_common_code` FOREIGN KEY (`inspection_result_group_code`, `inspection_result`) REFERENCES `TB_COMMON_CODE` (`group_code`, `code_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='검사 결과';

CREATE TABLE `TB_SHIFT_PLAN` (
    `plan_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '계획 ID',
    `plan_date` DATE NOT NULL COMMENT '계획 일자',
    `shift_group_code` VARCHAR(50) NOT NULL COMMENT '교대조 공통 코드 그룹',
    `shift_code` VARCHAR(50) NOT NULL COMMENT '교대조 코드',
    `line_id` VARCHAR(50) NOT NULL COMMENT '생산 라인 ID',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`plan_id`),
    UNIQUE KEY `uk_plan_date_shift_line` (`plan_date`, `shift_group_code`, `shift_code`, `line_id`),
    FOREIGN KEY (`line_id`) REFERENCES `TB_LINE` (`line_id`),
    CONSTRAINT `fk_shift_plan_common_code` FOREIGN KEY (`shift_group_code`, `shift_code`) REFERENCES `TB_COMMON_CODE` (`group_code`, `code_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='교대 계획';

CREATE TABLE `TB_REPORT_MANAGEMENT` (
    `report_id` VARCHAR(50) NOT NULL COMMENT '리포트 ID',
    `report_name` VARCHAR(100) NOT NULL COMMENT '리포트명',
    `report_type_group_code` VARCHAR(50) NOT NULL COMMENT '리포트 유형 공통 코드 그룹',
    `report_type` VARCHAR(50) NOT NULL COMMENT '리포트 유형 (일간, 주간, 월간)',
    `generation_criteria` JSON NULL COMMENT '생성 기준 (JSON 형식)',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`report_id`),
    CONSTRAINT `fk_report_type_common_code` FOREIGN KEY (`report_type_group_code`, `report_type`) REFERENCES `TB_COMMON_CODE` (`group_code`, `code_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='리포트 관리';


CREATE TABLE `TB_PRODUCTION_PERFORMANCE` (
    `perf_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '실적 ID',
    `production_order_id` VARCHAR(50) NOT NULL COMMENT '생산 지시 ID',
    `equip_id` VARCHAR(50) NOT NULL COMMENT '설비 ID',
    `perf_date` DATE NOT NULL COMMENT '실적 일자',
    `perf_quantity` DECIMAL(10,4) NOT NULL COMMENT '생산 수량',
    `good_quantity` DECIMAL(10,4) NOT NULL COMMENT '양품 수량',
    `defect_quantity` DECIMAL(10,4) NOT NULL COMMENT '불량 수량',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`perf_id`),
    FOREIGN KEY (`production_order_id`) REFERENCES `TB_PRODUCTION_ORDER` (`production_order_id`),
    FOREIGN KEY (`equip_id`) REFERENCES `TB_EQUIPMENT` (`equip_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='생산 실적';

CREATE TABLE `TB_PRODUCTION_HISTORY` (
    `history_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '이력 ID',
    `production_order_id` VARCHAR(50) NOT NULL COMMENT '생산 지시 ID',
    `equip_id` VARCHAR(50) NOT NULL COMMENT '설비 ID',
    `operation_group_code` VARCHAR(50) NOT NULL COMMENT '공정 공통 코드 그룹',
    `operation_code` VARCHAR(50) NOT NULL COMMENT '공정 코드',
    `work_start_time` DATETIME NOT NULL COMMENT '작업 시작 시간',
    `work_end_time` DATETIME NULL COMMENT '작업 종료 시간',
    `work_user_id` VARCHAR(50) NULL COMMENT '작업자 ID',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`history_id`),
    FOREIGN KEY (`production_order_id`) REFERENCES `TB_PRODUCTION_ORDER` (`production_order_id`),
    FOREIGN KEY (`equip_id`) REFERENCES `TB_EQUIPMENT` (`equip_id`),
    FOREIGN KEY (`work_user_id`) REFERENCES `TB_USER` (`user_id`),
    CONSTRAINT `fk_prod_hist_op_common_code` FOREIGN KEY (`operation_group_code`, `operation_code`) REFERENCES `TB_COMMON_CODE` (`group_code`, `code_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='생산 이력';

CREATE TABLE `TB_DEFECT_ITEM` (
    `defect_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '불량 ID',
    `perf_id` BIGINT NOT NULL COMMENT '생산 실적 ID',
    `item_id` VARCHAR(50) NOT NULL COMMENT '불량 품목 ID',
    `defect_group_code` VARCHAR(50) NOT NULL COMMENT '불량 공통 코드 그룹',
    `defect_code` VARCHAR(50) NOT NULL COMMENT '불량 코드',
    `defect_quantity` DECIMAL(10,4) NOT NULL COMMENT '불량 수량',
    `defect_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '불량 발생 일시',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`defect_id`),
    FOREIGN KEY (`perf_id`) REFERENCES `TB_PRODUCTION_PERFORMANCE` (`perf_id`),
    FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM` (`item_id`),
    CONSTRAINT `fk_defect_common_code` FOREIGN KEY (`defect_group_code`, `defect_code`) REFERENCES `TB_COMMON_CODE` (`group_code`, `code_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='불량 품목';

CREATE TABLE `TB_INSPECTION_DEFECT` (
    `inspection_defect_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '검사 불량 ID',
    `inspection_id` BIGINT NOT NULL COMMENT '검사 ID',
    `defect_group_code` VARCHAR(50) NOT NULL COMMENT '불량 공통 코드 그룹',
    `defect_code` VARCHAR(50) NOT NULL COMMENT '불량 코드',
    `defect_quantity` DECIMAL(10,4) NOT NULL COMMENT '불량 수량',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`inspection_defect_id`),
    FOREIGN KEY (`inspection_id`) REFERENCES `TB_INSPECTION_RESULT` (`inspection_id`),
    CONSTRAINT `fk_insp_defect_common_code` FOREIGN KEY (`defect_group_code`, `defect_code`) REFERENCES `TB_COMMON_CODE` (`group_code`, `code_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='검사 불량';

CREATE TABLE `TB_QUALITY_CHECK_RESULT` (
    `result_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '결과 ID',
    `checklist_item_id` BIGINT NOT NULL COMMENT '점검 항목 ID',
    `inspection_id` BIGINT NOT NULL COMMENT '검사 ID',
    `check_result_value` VARCHAR(255) NULL COMMENT '점검 결과 값',
    `check_result_group_code` VARCHAR(50) NOT NULL COMMENT '점검 결과 공통 코드 그룹',
    `check_result_code` VARCHAR(50) NOT NULL COMMENT '점검 결과 코드 (정상, 불량, 측정값)',
    `inspector_id` VARCHAR(50) NOT NULL COMMENT '점검자 ID',
    `check_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '점검 일시',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`result_id`),
    UNIQUE KEY `uk_chklist_insp` (`checklist_item_id`, `inspection_id`),
    FOREIGN KEY (`checklist_item_id`) REFERENCES `TB_QUALITY_CHECKLIST_ITEM` (`checklist_item_id`),
    FOREIGN KEY (`inspection_id`) REFERENCES `TB_INSPECTION_RESULT` (`inspection_id`),
    FOREIGN KEY (`inspector_id`) REFERENCES `TB_USER` (`user_id`),
    CONSTRAINT `fk_chk_res_code_common_code` FOREIGN KEY (`check_result_group_code`, `check_result_code`) REFERENCES `TB_COMMON_CODE` (`group_code`, `code_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='품질 점검 결과';

CREATE TABLE `TB_EQUIPMENT_MAINTENANCE` (
    `maintenance_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '보전 ID',
    `equip_id` VARCHAR(50) NOT NULL COMMENT '설비 ID',
    `maintenance_type_group_code` VARCHAR(50) NOT NULL COMMENT '보전 유형 공통 코드 그룹',
    `maintenance_type` VARCHAR(50) NOT NULL COMMENT '보전 유형 (예: 예방, 사후, 예측)',
    `maintenance_date` DATE NOT NULL COMMENT '보전 일자',
    `maintenance_description` VARCHAR(500) NULL COMMENT '보전 내용',
    `maintenance_cost` DECIMAL(10,2) NULL DEFAULT 0 COMMENT '보전 비용',
    `maintenance_user_id` VARCHAR(50) NOT NULL COMMENT '보전 담당자 ID',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`maintenance_id`),
    FOREIGN KEY (`equip_id`) REFERENCES `TB_EQUIPMENT` (`equip_id`),
    FOREIGN KEY (`maintenance_user_id`) REFERENCES `TB_USER` (`user_id`),
    CONSTRAINT `fk_maint_type_common_code` FOREIGN KEY (`maintenance_type_group_code`, `maintenance_type`) REFERENCES `TB_COMMON_CODE` (`group_code`, `code_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='설비 보전';

CREATE TABLE `TB_EQUIPMENT_DOWNTIME` (
    `downtime_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '비가동 ID',
    `equip_id` VARCHAR(50) NOT NULL COMMENT '설비 ID',
    `downtime_group_code` VARCHAR(50) NOT NULL COMMENT '비가동 공통 코드 그룹',
    `downtime_code` VARCHAR(50) NOT NULL COMMENT '비가동 사유 코드',
    `start_time` DATETIME NOT NULL COMMENT '비가동 시작 시간',
    `end_time` DATETIME NULL COMMENT '비가동 종료 시간',
    `description` VARCHAR(500) NULL COMMENT '비고',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`downtime_id`),
    FOREIGN KEY (`equip_id`) REFERENCES `TB_EQUIPMENT` (`equip_id`),
    CONSTRAINT `fk_downtime_common_code` FOREIGN KEY (`downtime_group_code`, `downtime_code`) REFERENCES `TB_COMMON_CODE` (`group_code`, `code_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='설비 비가동';

CREATE TABLE `TB_SHIFT_ASSIGNMENT` (
    `assignment_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '배정 ID',
    `plan_id` BIGINT NOT NULL COMMENT '교대 계획 ID',
    `user_id` VARCHAR(50) NOT NULL COMMENT '사용자 ID',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`assignment_id`),
    UNIQUE KEY `uk_plan_user` (`plan_id`, `user_id`),
    FOREIGN KEY (`plan_id`) REFERENCES `TB_SHIFT_PLAN` (`plan_id`),
    FOREIGN KEY (`user_id`) REFERENCES `TB_USER` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='교대조 배정';

CREATE TABLE `TB_SPC_DATA` (
    `data_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '데이터 ID',
    `item_id` VARCHAR(50) NOT NULL COMMENT '품목 ID',
    `equip_id` VARCHAR(50) NOT NULL COMMENT '설비 ID',
    `measurement_value` DECIMAL(18,4) NOT NULL COMMENT '측정 값',
    `measurement_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '측정 일시',
    `control_chart_group_code` VARCHAR(50) NOT NULL COMMENT '관리도 유형 공통 코드 그룹',
    `control_chart_type` VARCHAR(50) NOT NULL COMMENT '관리도 유형 (X-bar, R, P 등)',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`data_id`),
    FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM` (`item_id`),
    FOREIGN KEY (`equip_id`) REFERENCES `TB_EQUIPMENT` (`equip_id`),
    CONSTRAINT `fk_spc_chart_type_common_code` FOREIGN KEY (`control_chart_group_code`, `control_chart_type`) REFERENCES `TB_COMMON_CODE` (`group_code`, `code_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='SPC 데이터';

CREATE TABLE `TB_ALARM_LOG` (
    `alarm_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '알람 ID',
    `equip_id` VARCHAR(50) NOT NULL COMMENT '설비 ID',
    `alarm_group_code` VARCHAR(50) NOT NULL COMMENT '알람 공통 코드 그룹',
    `alarm_code` VARCHAR(50) NOT NULL COMMENT '알람 코드',
    `alarm_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '알람 발생 일시',
    `alarm_status` VARCHAR(50) NOT NULL COMMENT '알람 상태 (발생, 확인, 해제)',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`alarm_id`),
    FOREIGN KEY (`equip_id`) REFERENCES `TB_EQUIPMENT` (`equip_id`),
    CONSTRAINT `fk_alarm_common_code` FOREIGN KEY (`alarm_group_code`, `alarm_code`) REFERENCES `TB_COMMON_CODE` (`group_code`, `code_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='알람 로그';

CREATE TABLE `TB_RAW_DATA_LOG` (
    `log_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '로그 ID',
    `equip_id` VARCHAR(50) NOT NULL COMMENT '설비 ID',
    `data_json` JSON NOT NULL COMMENT '수집된 원시 데이터 (JSON 형식)',
    `collection_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수집 일시',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`log_id`),
    FOREIGN KEY (`equip_id`) REFERENCES `TB_EQUIPMENT` (`equip_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='원시 데이터 로그';

CREATE TABLE `TB_ANALYSIS_YIELD` (
    `analysis_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '분석 ID',
    `analysis_date` DATE NOT NULL COMMENT '분석 일자',
    `item_id` VARCHAR(50) NOT NULL COMMENT '품목 ID',
    `total_production` DECIMAL(10,2) NOT NULL COMMENT '총 생산량',
    `good_quantity` DECIMAL(10,2) NOT NULL COMMENT '양품 수량',
    `defect_quantity` DECIMAL(10,2) NOT NULL COMMENT '불량 수량',
    `yield_rate` DECIMAL(5,2) NOT NULL COMMENT '수율 (%)',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`analysis_id`),
    UNIQUE KEY `uk_analysis_date_item` (`analysis_date`, `item_id`),
    FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='수율 분석';

CREATE TABLE `TB_ANALYSIS_DEFECT` (
    `analysis_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '분석 ID',
    `analysis_date` DATE NOT NULL COMMENT '분석 일자',
    `item_id` VARCHAR(50) NOT NULL COMMENT '품목 ID',
    `defect_group_code` VARCHAR(50) NOT NULL COMMENT '불량 공통 코드 그룹',
    `defect_code` VARCHAR(50) NOT NULL COMMENT '불량 코드',
    `defect_quantity` DECIMAL(10,2) NOT NULL COMMENT '불량 수량',
    `defect_rate` DECIMAL(5,2) NOT NULL COMMENT '불량률 (%)',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`analysis_id`),
    UNIQUE KEY `uk_analysis_date_item` (`analysis_date`, `item_id`),
    FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM` (`item_id`),
    CONSTRAINT `fk_analysis_defect_common_code` FOREIGN KEY (`defect_group_code`, `defect_code`) REFERENCES `TB_COMMON_CODE` (`group_code`, `code_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='불량률 분석';

CREATE TABLE `TB_ANALYSIS_DOWNTIME` (
    `analysis_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '분석 ID',
    `analysis_date` DATE NOT NULL COMMENT '분석 일자',
    `equip_id` VARCHAR(50) NOT NULL COMMENT '설비 ID',
    `total_downtime_hours` DECIMAL(10,2) NOT NULL COMMENT '총 비가동 시간 (시간)',
    `downtime_count` INT NOT NULL COMMENT '비가동 발생 건수',
    `main_downtime_group_code` VARCHAR(50) NOT NULL COMMENT '주요 비가동 사유 공통 코드 그룹',
    `main_downtime_code` VARCHAR(50) NULL COMMENT '주요 비가동 사유 코드',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`analysis_id`),
    FOREIGN KEY (`equip_id`) REFERENCES `TB_EQUIPMENT` (`equip_id`),
    CONSTRAINT `fk_analysis_downtime_common_code` FOREIGN KEY (`main_downtime_group_code`, `main_downtime_code`) REFERENCES `TB_COMMON_CODE` (`group_code`, `code_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='비가동 분석';


CREATE TABLE `TB_USER_LOGIN_LOG` (
    `log_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '로그 ID',
    `user_id` VARCHAR(50) NOT NULL COMMENT '사용자 ID',
    `login_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '로그인 일시',
    `logout_time` DATETIME NULL COMMENT '로그아웃 일시',
    `ip_address` VARCHAR(50) NULL COMMENT 'IP 주소',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`log_id`),
    FOREIGN KEY (`user_id`) REFERENCES `TB_USER` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='사용자 로그인 로그';

CREATE TABLE `TB_SYSTEM_AUDIT_LOG` (
    `log_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '로그 ID',
    `user_id` VARCHAR(50) NULL COMMENT '작업자 ID',
    `action_type` VARCHAR(50) NOT NULL COMMENT '행동 유형 (예: 생성, 수정, 삭제)',
    `target_table` VARCHAR(100) NOT NULL COMMENT '대상 테이블',
    `target_id` VARCHAR(50) NULL COMMENT '대상 ID',
    `action_details` TEXT NULL COMMENT '행동 상세',
    `action_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '행동 일시',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`log_id`),
    CONSTRAINT `fk_audit_user` FOREIGN KEY (`user_id`) REFERENCES `TB_USER` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='시스템 감사 로그';

CREATE TABLE `TB_EQUIPMENT_SENSOR_DATA` (
    `data_id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '데이터 ID',
    `equip_id` VARCHAR(50) NOT NULL COMMENT '설비 ID',
    `sensor_type` VARCHAR(50) NOT NULL COMMENT '센서 유형 (온도, 압력, 진동 등)',
    `sensor_value` DECIMAL(18,4) NOT NULL COMMENT '센서 값',
    `unit` VARCHAR(10) NULL COMMENT '단위',
    `collection_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '데이터 수집 시간',
    `created_by` VARCHAR(50) NOT NULL COMMENT '생성자',
    `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `last_modified_by` VARCHAR(50) NOT NULL COMMENT '최종 수정자',
    `last_modified_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 일시',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '삭제 여부',
    PRIMARY KEY (`data_id`),
    FOREIGN KEY (`equip_id`) REFERENCES `TB_EQUIPMENT` (`equip_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='설비 센서 데이터';