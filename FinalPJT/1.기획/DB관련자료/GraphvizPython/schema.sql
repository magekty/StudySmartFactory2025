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
