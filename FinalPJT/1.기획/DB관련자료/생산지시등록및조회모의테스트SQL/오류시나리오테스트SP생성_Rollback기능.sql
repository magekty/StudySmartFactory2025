DELIMITER //

DROP PROCEDURE IF EXISTS `SP_CREATE_PRODUCTION_FLOW_FAIL_TEST` //

CREATE PROCEDURE `SP_CREATE_PRODUCTION_FLOW_FAIL_TEST`(
    IN `p_plan_name` VARCHAR(100),
    IN `p_plan_date` DATE,
    IN `p_item_id` VARCHAR(50),
    IN `p_plan_quantity` DECIMAL(10,4),
    IN `p_created_by` VARCHAR(50)
)
BEGIN
    DECLARE `v_plan_id` VARCHAR(50);
    
    -- 트랜잭션 시작 (오류 발생 시 롤백을 보장)
    START TRANSACTION;
    
    -- 의도적인 오류 유발: TB_ITEM에 존재하지 않는 item_id로 INSERT 시도
    SET `v_plan_id` = CONCAT('PLAN-', DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'));
    INSERT INTO `TB_PRODUCTION_PLAN` (
        `plan_id`, `plan_name`, `plan_date`, `item_id`, `plan_quantity`, `created_by`, `last_modified_by`
    ) VALUES (
        `v_plan_id`, `p_plan_name`, `p_plan_date`, `p_item_id`, `p_plan_quantity`, `p_created_by`, `p_created_by`
    );

    -- 아래 INSERT 문들은 실행되지 않음 (트랜잭션 롤백 예정)
    -- ... 생략 ...

    -- 모든 작업이 성공해야만 커밋됨
    COMMIT;
        
END //

DELIMITER ;