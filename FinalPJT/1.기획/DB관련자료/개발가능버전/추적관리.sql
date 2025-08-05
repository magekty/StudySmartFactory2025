-- -----------------------------------------------------
-- Table `TB_TRACEABILITY_LOG` (추적 이력)
-- 설명: 제품 Lot의 생산 과정 투입 및 산출 이력을 기록하여, 원자재부터 완제품까지의 추적성을 확보합니다.
--       어떤 Lot이 어떤 작업 지시와 공정에서 다른 Lot으로 전환되었는지 상세히 관리합니다.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TB_TRACEABILITY_LOG` (
  `trace_log_id`          BIGINT         NOT NULL AUTO_INCREMENT COMMENT '추적 이력 ID',
  `work_order_id`         VARCHAR(50)    NOT NULL COMMENT '작업 지시 ID (FK: TB_WORK_ORDER)',
  `production_order_id`   VARCHAR(50)    NOT NULL COMMENT '생산 지시 ID (FK: TB_PRODUCTION_ORDER)',
  `operation_code_group`  VARCHAR(50)    NOT NULL COMMENT '공정 공통 코드 그룹',
  `operation_code`        VARCHAR(50)    NOT NULL COMMENT '공정 코드 (FK: TB_COMMON_CODE)',
  `parent_lot_no`         VARCHAR(100)   NOT NULL COMMENT '상위(투입) Lot 번호 (FK: TB_LOT_MASTER)',
  `child_lot_no`          VARCHAR(100)   NOT NULL COMMENT '하위(산출) Lot 번호 (FK: TB_LOT_MASTER)',
  `quantity`              DECIMAL(10,4)  NOT NULL COMMENT '산출 수량',
  `created_by`            VARCHAR(50)    NOT NULL COMMENT '생성자',
  `created_date`          DATETIME       NOT NULL COMMENT '생성 일시',
  `is_deleted`            TINYINT(1)     NOT NULL DEFAULT 0 COMMENT '삭제 여부 (0:N, 1:Y)',
  `last_modified_by`      VARCHAR(50)    NOT NULL COMMENT '최종 수정자',
  `last_modified_date`    DATETIME       NOT NULL COMMENT '최종 수정 일시',
  PRIMARY KEY (`trace_log_id`),
  CONSTRAINT `fk_trace_log_work_order` FOREIGN KEY (`work_order_id`) REFERENCES `TB_WORK_ORDER` (`work_order_id`),
  CONSTRAINT `fk_trace_log_prod_order` FOREIGN KEY (`production_order_id`) REFERENCES `TB_PRODUCTION_ORDER` (`production_order_id`),
  CONSTRAINT `fk_trace_log_op_code` FOREIGN KEY (`operation_code_group`, `operation_code`) REFERENCES `TB_COMMON_CODE` (`group_code`, `code_value`),
  CONSTRAINT `fk_trace_log_parent_lot` FOREIGN KEY (`parent_lot_no`) REFERENCES `TB_LOT_MASTER` (`lot_number`),
  CONSTRAINT `fk_trace_log_child_lot` FOREIGN KEY (`child_lot_no`) REFERENCES `TB_LOT_MASTER` (`lot_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='추적 이력';