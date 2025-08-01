-- 오류 테스트 SP 실행
CALL `SP_CREATE_PRODUCTION_FLOW_FAIL_TEST`(
    '오류 시나리오 테스트', -- p_plan_name
    '2025-08-01',             -- p_plan_date
    'ITEM-ERROR',             -- p_item_id (존재하지 않는 값)
    100.00,                   -- p_plan_quantity
    'admin'                   -- p_created_by
);

-- 롤백 확인: 어떤 데이터도 새로 생성되지 않았는지 검증
-- (SP 실행 전후의 데이터 개수가 동일해야 함)
SELECT 'TB_PRODUCTION_PLAN' AS TableName, COUNT(*) AS RowCount FROM `TB_PRODUCTION_PLAN` UNION ALL
SELECT 'TB_WORK_ORDER' AS TableName, COUNT(*) AS RowCount FROM `TB_WORK_ORDER` UNION ALL
SELECT 'TB_PRODUCTION_ORDER' AS TableName, COUNT(*) AS RowCount FROM `TB_PRODUCTION_ORDER` UNION ALL
SELECT 'TB_PRODUCTION_HISTORY' AS TableName, COUNT(*) AS RowCount FROM `TB_PRODUCTION_HISTORY` UNION ALL
SELECT 'TB_PRODUCTION_PERFORMANCE' AS TableName, COUNT(*) AS RowCount FROM `TB_PRODUCTION_PERFORMANCE`;