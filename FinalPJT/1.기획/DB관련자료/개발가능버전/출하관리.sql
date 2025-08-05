-- -----------------------------------------------------
-- Table `TB_CUSTOMER` (고객 정보)
-- 설명: 출하 관리 시 필요한 고객 정보를 관리하는 테이블입니다.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TB_CUSTOMER` (
  `customer_id`         VARCHAR(50)   NOT NULL COMMENT '고객 ID',
  `customer_name`       VARCHAR(100)  NOT NULL COMMENT '고객사 명',
  `contact_person`      VARCHAR(50)   Y COMMENT '담당자',
  `phone_number`        VARCHAR(20)   Y COMMENT '연락처',
  `email`               VARCHAR(100)  Y COMMENT '이메일',
  `address`             VARCHAR(255)  Y COMMENT '주소',
  `created_by`          VARCHAR(50)   NOT NULL COMMENT '생성자',
  `created_date`        DATETIME      NOT NULL COMMENT '생성 일시',
  `is_deleted`          TINYINT(1)    NOT NULL DEFAULT 0 COMMENT '삭제 여부 (0:N, 1:Y)',
  `last_modified_by`    VARCHAR(50)   NOT NULL COMMENT '최종 수정자',
  `last_modified_date`  DATETIME      NOT NULL COMMENT '최종 수정 일시',
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='고객 정보';

-- -----------------------------------------------------
-- Table `TB_SHIPPING_ORDER` (출하 지시)
-- 설명: 완제품 출하를 위한 지시 정보를 관리하는 테이블입니다.
--       어떤 고객에게, 언제, 어떤 제품을 출하할지 기록합니다.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TB_SHIPPING_ORDER` (
  `shipping_order_id`   VARCHAR(50)   NOT NULL COMMENT '출하 지시 ID',
  `customer_id`         VARCHAR(50)   NOT NULL COMMENT '고객 ID (FK: TB_CUSTOMER)',
  `shipping_status`     VARCHAR(20)   NOT NULL DEFAULT 'PENDING' COMMENT '출하 상태 (PENDING, IN_PROGRESS, SHIPPED, CANCELED)',
  `order_date`          DATETIME      NOT NULL COMMENT '주문 일자',
  `shipping_date`       DATETIME      Y COMMENT '실제 출하 일자',
  `delivery_address`    VARCHAR(255)  Y COMMENT '배송 주소',
  `created_by`          VARCHAR(50)   NOT NULL COMMENT '생성자',
  `created_date`        DATETIME      NOT NULL COMMENT '생성 일시',
  `is_deleted`          TINYINT(1)    NOT NULL DEFAULT 0 COMMENT '삭제 여부 (0:N, 1:Y)',
  `last_modified_by`    VARCHAR(50)   NOT NULL COMMENT '최종 수정자',
  `last_modified_date`  DATETIME      NOT NULL COMMENT '최종 수정 일시',
  PRIMARY KEY (`shipping_order_id`),
  CONSTRAINT `fk_shipping_order_customer` FOREIGN KEY (`customer_id`) REFERENCES `TB_CUSTOMER` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='출하 지시';

-- -----------------------------------------------------
-- Table `TB_SHIPPING_ORDER_ITEM` (출하 지시 품목)
-- 설명: 개별 출하 지시에 포함된 품목 Lot의 상세 정보를 관리하는 테이블입니다.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TB_SHIPPING_ORDER_ITEM` (
  `shipping_item_id`    BIGINT         NOT NULL AUTO_INCREMENT COMMENT '출하 품목 ID',
  `shipping_order_id`   VARCHAR(50)    NOT NULL COMMENT '출하 지시 ID (FK: TB_SHIPPING_ORDER)',
  `item_id`             VARCHAR(50)    NOT NULL COMMENT '품목 ID (FK: TB_ITEM)',
  `lot_number`          VARCHAR(100)   NOT NULL COMMENT '출하 Lot 번호 (FK: TB_LOT_MASTER)',
  `quantity`            DECIMAL(10,4)  NOT NULL COMMENT '출하 수량',
  `created_by`          VARCHAR(50)    NOT NULL COMMENT '생성자',
  `created_date`        DATETIME       NOT NULL COMMENT '생성 일시',
  `is_deleted`          TINYINT(1)     NOT NULL DEFAULT 0 COMMENT '삭제 여부 (0:N, 1:Y)',
  `last_modified_by`    VARCHAR(50)    NOT NULL COMMENT '최종 수정자',
  `last_modified_date`  DATETIME       NOT NULL COMMENT '최종 수정 일시',
  PRIMARY KEY (`shipping_item_id`),
  CONSTRAINT `fk_shipping_item_order` FOREIGN KEY (`shipping_order_id`) REFERENCES `TB_SHIPPING_ORDER` (`shipping_order_id`),
  CONSTRAINT `fk_shipping_item_lot` FOREIGN KEY (`lot_number`) REFERENCES `TB_LOT_MASTER` (`lot_number`),
  CONSTRAINT `fk_shipping_item_item` FOREIGN KEY (`item_id`) REFERENCES `TB_ITEM` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='출하 지시 품목';