-- -----------------------------------------------------
-- Table `TB_WAREHOUSE` (창고 마스터)
-- 설명: 자재 및 제품을 보관하는 창고 정보를 관리합니다.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TB_WAREHOUSE` (
  `warehouse_id` VARCHAR(50) NOT NULL COMMENT '창고 ID',
  `warehouse_name` VARCHAR(100) NOT NULL COMMENT '창고명',
  `location` VARCHAR(100) NULL COMMENT '위치',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
  PRIMARY KEY (`warehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='창고 마스터';

-- -----------------------------------------------------
-- Table `TB_MATERIAL` (자재 마스터)
-- 설명: 생산에 사용되는 원자재 정보를 관리합니다.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TB_MATERIAL` (
  `material_id` VARCHAR(50) NOT NULL COMMENT '자재 ID',
  `material_name` VARCHAR(100) NOT NULL COMMENT '자재명',
  `unit` VARCHAR(20) NULL COMMENT '단위 (EA, kg 등)',
  `supplier_id` VARCHAR(50) NULL COMMENT '공급처 ID (FK: TB_SUPPLIER)',
  PRIMARY KEY (`material_id`),
  CONSTRAINT `fk_material_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `TB_SUPPLIER` (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='자재 마스터';

-- -----------------------------------------------------
-- Table `TB_STOCK` (자재 재고)
-- 설명: 창고별 자재 재고 수량을 관리합니다.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TB_STOCK` (
  `material_id` VARCHAR(50) NOT NULL COMMENT '자재 ID (FK: TB_MATERIAL)',
  `warehouse_id` VARCHAR(50) NOT NULL COMMENT '창고 ID (FK: TB_WAREHOUSE)',
  `quantity` INT NOT NULL DEFAULT 0 COMMENT '재고 수량',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 일시',
  PRIMARY KEY (`material_id`, `warehouse_id`),
  CONSTRAINT `fk_stock_material` FOREIGN KEY (`material_id`) REFERENCES `TB_MATERIAL` (`material_id`),
  CONSTRAINT `fk_stock_warehouse` FOREIGN KEY (`warehouse_id`) REFERENCES `TB_WAREHOUSE` (`warehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='자재 재고';

-- -----------------------------------------------------
-- Table `TB_MATERIAL_INPUT` (자재 입고 이력)
-- 설명: 자재의 입고 이력을 기록합니다.
-- -----------------------------------------------------
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

-- -----------------------------------------------------
-- Table `TB_MATERIAL_OUTPUT` (자재 출고 이력)
-- 설명: 생산을 위한 자재 출고 이력을 기록합니다.
-- -----------------------------------------------------
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

-- -----------------------------------------------------
-- Table `TB_MATERIAL_LOT` (자재 LOT 정보)
-- 설명: 자재를 LOT 단위로 관리하기 위한 정보를 기록합니다.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TB_MATERIAL_LOT` (
  `lot_id` VARCHAR(50) NOT NULL COMMENT '자재 LOT 번호',
  `material_id` VARCHAR(50) NOT NULL COMMENT '자재 ID (FK: TB_MATERIAL)',
  `quantity` INT NOT NULL DEFAULT 0 COMMENT 'LOT 보유 수량',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
  PRIMARY KEY (`lot_id`),
  CONSTRAINT `fk_lot_material` FOREIGN KEY (`material_id`) REFERENCES `TB_MATERIAL` (`material_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='자재 LOT 정보';

-- -----------------------------------------------------
-- Table `TB_MATERIAL_MOVEMENT` (자재 이동 이력)
-- 설명: 창고 간 자재 이동 이력을 기록합니다.
-- -----------------------------------------------------
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