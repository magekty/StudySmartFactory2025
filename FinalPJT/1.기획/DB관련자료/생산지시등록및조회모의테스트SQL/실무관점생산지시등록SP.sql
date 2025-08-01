DELIMITER //

DROP PROCEDURE IF EXISTS `SP_CREATE_PRODUCTION_FLOW` //
-- SP_CREATE_PRODUCTION_FLOW(생산 계획 명, 생산 계획 날짜, 생산 계획 품목, 생산 계획 수량, 로그인한 직원ID-생산지시입력자)
CREATE PROCEDURE `SP_CREATE_PRODUCTION_FLOW`(
    IN `p_plan_name` VARCHAR(100),
    IN `p_plan_date` DATE,
    IN `p_item_id` VARCHAR(50),
    IN `p_plan_quantity` DECIMAL(10,4),
    IN `p_created_by` VARCHAR(50)
)
BEGIN
    DECLARE `v_plan_id` VARCHAR(50);
    DECLARE `v_work_order_id` VARCHAR(50);
    DECLARE `v_production_order_id` VARCHAR(50);
    DECLARE `v_route_id` VARCHAR(50);
    
    START TRANSACTION;

    -- 1. 생산 계획(TB_PRODUCTION_PLAN) 생성
    SET `v_plan_id` = CONCAT('PLAN-', DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'));
    INSERT INTO `TB_PRODUCTION_PLAN` (
        `plan_id`, `plan_name`, `plan_date`, `item_id`, `plan_quantity`, `created_by`, `last_modified_by`
    ) VALUES (
        `v_plan_id`, `p_plan_name`, `p_plan_date`, `p_item_id`, `p_plan_quantity`, `p_created_by`, `p_created_by`
    );

    -- 2. 작업 지시(TB_WORK_ORDER) 생성
    SET `v_work_order_id` = CONCAT('WO-', DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'));
    INSERT INTO `TB_WORK_ORDER` (
        `work_order_id`, `production_plan_id`, `item_id`, `quantity`, `work_order_status_group_code`, `work_order_status`, `start_date`, `due_date`, `created_by`, `last_modified_by`
    ) VALUES (
        `v_work_order_id`, `v_plan_id`, `p_item_id`, `p_plan_quantity`, 'WORK_STATUS', '대기', `p_plan_date`, `p_plan_date`, `p_created_by`, `p_created_by`
    );

    -- 3. 생산 지시(TB_PRODUCTION_ORDER) 생성
    SET `v_route_id` = (SELECT `route_id` FROM `TB_ROUTE` WHERE `item_id` = `p_item_id` AND `is_deleted`=0 LIMIT 1);
    SET `v_production_order_id` = CONCAT('PO-', DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'));
    INSERT INTO `TB_PRODUCTION_ORDER` (
        `production_order_id`, `work_order_id`, `route_id`, `order_quantity`, `order_status_group_code`, `order_status`, `created_by`, `last_modified_by`
    ) VALUES (
        `v_production_order_id`, `v_work_order_id`, `v_route_id`, `p_plan_quantity`, 'WORK_STATUS', '진행', `p_created_by`, `p_created_by`
    );
    
    -- 4. 생산 이력(TB_PRODUCTION_HISTORY) 기록
    INSERT INTO `TB_PRODUCTION_HISTORY` (
        `production_order_id`, `equip_id`, `operation_group_code`, `operation_code`, `work_start_time`, `work_end_time`, `work_user_id`, `created_by`, `last_modified_by`
    ) VALUES (
        `v_production_order_id`, 'EQP-001', 'ROUTE_STATUS', 'OP001', NOW(), NOW() + INTERVAL 1 HOUR, `p_created_by`, `p_created_by`, `p_created_by`
    );
    
    -- 5. 생산 실적(TB_PRODUCTION_PERFORMANCE) 기록
    INSERT INTO `TB_PRODUCTION_PERFORMANCE` (
        `production_order_id`, `equip_id`, `perf_quantity`, `good_quantity`, `defect_quantity`, `perf_date`, `created_by`, `last_modified_by`
    ) VALUES (
        `v_production_order_id`, 'EQP-001', `p_plan_quantity`, `p_plan_quantity` * 0.98, `p_plan_quantity` * 0.02, CURDATE(), `p_created_by`, `p_created_by`
    );

    COMMIT;
    
    SELECT 'Production flow created successfully!' AS `status`, `v_production_order_id` AS `production_order_id`;
        
END //

DELIMITER ;

-- SP 실행 (생산 흐름 시뮬레이션)
-- SP_CREATE_PRODUCTION_FLOW(생산 계획 명, 생산 계획 날짜, 생산 계획 품목, 생산 계획 수량, 로그인한 직원ID-생산지시입력자)
CALL `SP_CREATE_PRODUCTION_FLOW`(
    '2025년 8월 생산 계획',
    '2025-08-01',
    'ITEM-001',
    100.00,
    'admin'
);