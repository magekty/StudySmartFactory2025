
-- 통합 조회 쿼리로 결과 확인 (실무 관점)
SELECT
    -- 생산 계획(TB_PRODUCTION_PLAN) 정보
    TP.plan_id AS production_plan_id,
    TP.plan_name AS production_plan_name,
    TP.plan_date AS production_plan_date,
    TP.plan_quantity AS production_plan_quantity,

    -- 작업 지시(TB_WORK_ORDER) 정보
    TWO.work_order_id AS work_order_id,
    TWO.quantity AS work_order_quantity,
    TCC_WO_STATUS.code_name AS work_order_status_name,

    -- 생산 지시(TB_PRODUCTION_ORDER) 정보
    TPO.production_order_id,
    TPO.order_quantity,
    TCC_PO_STATUS.code_name AS production_order_status_name,

    -- 품목(TB_ITEM) 정보
    TI.item_id,
    TI.item_name,
    TI.unit,

    -- 생산 이력(TB_PRODUCTION_HISTORY) 정보
    TPH.history_id,
    TPH.work_start_time,
    TPH.work_end_time,
    TCC_OP.code_name AS operation_name,
    TPH.equip_id,
    TPH.work_user_id,

    -- 생산 실적(TB_PRODUCTION_PERFORMANCE) 정보
    TPP.perf_quantity AS performance_quantity,
    TPP.good_quantity,
    TPP.defect_quantity,
    TPP.perf_date

FROM
    `TB_PRODUCTION_ORDER` TPO
JOIN
    `TB_WORK_ORDER` TWO ON TPO.work_order_id = TWO.work_order_id
JOIN
    `TB_PRODUCTION_PLAN` TP ON TWO.production_plan_id = TP.plan_id
JOIN
    `TB_ITEM` TI ON TP.item_id = TI.item_id
LEFT JOIN
    `TB_PRODUCTION_HISTORY` TPH ON TPO.production_order_id = TPH.production_order_id
LEFT JOIN
    `TB_PRODUCTION_PERFORMANCE` TPP ON TPO.production_order_id = TPP.production_order_id
LEFT JOIN
    `TB_COMMON_CODE` TCC_WO_STATUS ON TWO.work_order_status_group_code = TCC_WO_STATUS.group_code AND TWO.work_order_status = TCC_WO_STATUS.code_value
LEFT JOIN
    `TB_COMMON_CODE` TCC_PO_STATUS ON TPO.order_status_group_code = TCC_PO_STATUS.group_code AND TPO.order_status = TCC_PO_STATUS.code_value
LEFT JOIN
    `TB_COMMON_CODE` TCC_OP ON TPH.operation_group_code = TCC_OP.group_code AND TPH.operation_code = TCC_OP.code_value
WHERE
    TPO.production_order_id = 'PO-20250801162623';