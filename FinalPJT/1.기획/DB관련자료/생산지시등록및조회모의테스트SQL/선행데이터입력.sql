-- --------------------------------------------------
-- MES 프로그램 테스트용 최종 더미 데이터 삽입 스크립트
-- --------------------------------------------------

-- 1. 최상위(Root) 테이블
INSERT INTO `TB_COMMON_CODE_GROUP` (`group_code`, `group_name`, `created_by`, `last_modified_by`) VALUES
('STATUS', '상태', 'system', 'system'),
('ITEM_TYPE', '품목 유형', 'system', 'system'),
('WORK_STATUS', '작업 지시 상태', 'system', 'system'),
('EQP_TYPE', '설비 유형', 'system', 'system'),
('ROUTE_STATUS', '공정 상태', 'system', 'system');

INSERT INTO `TB_USER` (`user_id`, `password`, `user_name`, `created_by`, `last_modified_by`) VALUES
('admin', 'password123', '관리자', 'system', 'system'),
('worker1', 'password123', '작업자1', 'system', 'system');

INSERT INTO `TB_ROLE` (`role_id`, `role_name`, `created_by`, `last_modified_by`) VALUES
('ADMIN', '관리자', 'system', 'system'),
('WORKER', '작업자', 'system', 'system');

INSERT INTO `TB_WORKPLACE` (`workplace_id`, `workplace_name`, `created_by`, `last_modified_by`) VALUES
('WP-001', '1공장', 'system', 'system');

INSERT INTO `TB_ITEM` (`item_id`, `item_name`, `item_type`, `unit`, `created_by`, `last_modified_by`) VALUES
('ITEM-001', '완제품-A', '완제품', 'EA', 'system', 'system'),
('ITEM-002', '원자재-X', '원자재', 'KG', 'system', 'system');

-- 2. 1단계 테이블을 참조하는 테이블
INSERT INTO `TB_COMMON_CODE` (`code_id`, `group_code`, `code_value`, `code_name`, `use_yn`, `created_by`, `last_modified_by`) VALUES
(1, 'WORK_STATUS', '계획', '계획', 'Y', 'system', 'system'),
(2, 'WORK_STATUS', '대기', '대기', 'Y', 'system', 'system'),
(3, 'WORK_STATUS', '진행', '진행', 'Y', 'system', 'system'),
(4, 'WORK_STATUS', '완료', '완료', 'Y', 'system', 'system'),
(5, 'WORK_STATUS', '취소', '취소', 'Y', 'system', 'system'),
(6, 'ITEM_TYPE', '완제품', '완제품', 'Y', 'system', 'system'),
(7, 'ITEM_TYPE', '반제품', '반제품', 'Y', 'system', 'system'),
(8, 'ITEM_TYPE', '원자재', '원자재', 'Y', 'system', 'system'),
(9, 'EQP_TYPE', '가공기', '가공기', 'Y', 'system', 'system'),
(10, 'EQP_TYPE', '포장기', '포장기', 'Y', 'system', 'system'),
(11, 'ROUTE_STATUS', 'OP001', '가공_공정', 'Y', 'system', 'system'),
(12, 'ROUTE_STATUS', 'OP002', '포장_공정', 'Y', 'system', 'system');

INSERT INTO `TB_LINE` (`line_id`, `line_name`, `workplace_id`, `created_by`, `last_modified_by`) VALUES
('LINE-001', 'A-라인', 'WP-001', 'system', 'system');

INSERT INTO `TB_ROUTE` (`route_id`, `item_id`, `route_name`, `created_by`, `last_modified_by`) VALUES
('ROUTE-A', 'ITEM-001', '완제품A 공정', 'system', 'system');

INSERT INTO `TB_WAREHOUSE` (`warehouse_id`, `warehouse_name`, `created_by`, `last_modified_by`) VALUES
('WH-001', '원자재 창고', 'system', 'system');

-- 3. 2단계 테이블을 참조하는 테이블
INSERT INTO `TB_EQUIPMENT` (`equip_id`, `equip_name`, `line_id`, `equip_group_code`, `equip_type`, `created_by`, `last_modified_by`) VALUES
('EQP-001', '가공기-01', 'LINE-001', 'EQP_TYPE', '가공기', 'system', 'system'),
('EQP-002', '포장기-01', 'LINE-001', 'EQP_TYPE', '포장기', 'system', 'system');

INSERT INTO `TB_ROUTE_OPERATION` (`route_id`, `operation_group_code`, `operation_code`, `operation_name`, `workplace_id`, `sequence`, `created_by`, `last_modified_by`) VALUES
('ROUTE-A', 'ROUTE_STATUS', 'OP001', '가공', 'WP-001', 1, 'system', 'system'),
('ROUTE-A', 'ROUTE_STATUS', 'OP002', '포장', 'WP-001', 2, 'system', 'system');