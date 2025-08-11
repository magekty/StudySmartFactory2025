/* ==========================================
   GlobalMed MES • dev_seed_full_ordered.sql
   목적: v1 시나리오(로그인→지시→RUN→실적→KPI) 데모/개발용 최소·완전 시드
   전제: MySQL 8.0+, 스키마 v1(UTC/CHECK/RESTRICT/JPA 친화) 반영
   특성: 멱등 일부 보장(ON DUPLICATE / IGNORE 사용)
   ========================================== */

SET NAMES utf8mb4;
SET time_zone = '+00:00';

/* 0) 안전: 트랜잭션 아님(각 INSERT 독립), FK 체크 유지 */
-- SET FOREIGN_KEY_CHECKS = 1;

/* 1) 코드 그룹/코드 (WO_STATUS, EQP_STATUS) */
INSERT INTO TB_CODE_GROUP (group_code, group_name, created_by)
VALUES ('WO_STATUS','작업지시 상태','seed')
ON DUPLICATE KEY UPDATE group_name=VALUES(group_name);

INSERT INTO TB_CODE_GROUP (group_code, group_name, created_by)
VALUES ('EQP_STATUS','설비 상태','seed')
ON DUPLICATE KEY UPDATE group_name=VALUES(group_name);

INSERT INTO TB_CODE (group_code, code, name, use_yn, sort_order, created_by) VALUES
('WO_STATUS','P','Planned','Y',1,'seed'),
('WO_STATUS','R','Released','Y',2,'seed'),
('WO_STATUS','C','Completed','Y',3,'seed')
ON DUPLICATE KEY UPDATE name=VALUES(name), use_yn=VALUES(use_yn), sort_order=VALUES(sort_order);

INSERT INTO TB_CODE (group_code, code, name, use_yn, sort_order, created_by) VALUES
('EQP_STATUS','RUN','가동','Y',1,'seed'),
('EQP_STATUS','IDLE','유휴','Y',2,'seed'),
('EQP_STATUS','DOWN','정지','Y',3,'seed')
ON DUPLICATE KEY UPDATE name=VALUES(name), use_yn=VALUES(use_yn), sort_order=VALUES(sort_order);

SET @WO_P := (SELECT code_id FROM TB_CODE WHERE group_code='WO_STATUS' AND code='P');
SET @WO_R := (SELECT code_id FROM TB_CODE WHERE group_code='WO_STATUS' AND code='R');
SET @WO_C := (SELECT code_id FROM TB_CODE WHERE group_code='WO_STATUS' AND code='C');
SET @EQ_RUN := (SELECT code_id FROM TB_CODE WHERE group_code='EQP_STATUS' AND code='RUN');

/* 2) 역할/사용자(데모) — 해시는 교체 권장 */
INSERT INTO TB_ROLE (role_code, role_name, created_by) VALUES
('ROLE_OP','운영자','seed'),
('ROLE_QA','품질','seed'),
('ROLE_ADMIN','관리자','seed')
ON DUPLICATE KEY UPDATE role_name=VALUES(role_name);

-- demo hash placeholder(반드시 실제 해시로 교체) 비밀번호: gmmes1121
INSERT INTO TB_USER (user_id, username, password_hash, password_algo, is_active, display_name, created_by, email)
VALUES
('00000000-0000-0000-0000-0000000000AD','admin','$2a$10$1CRPepUcsXEBY/r..LUbjObOrb7k8PpTV8D4LBwbME6oUC6tSfdI2','bcrypt',1,'Admin','seed','admin@example.com'),
('00000000-0000-0000-0000-0000000000OP','op','$2a$10$1CRPepUcsXEBY/r..LUbjObOrb7k8PpTV8D4LBwbME6oUC6tSfdI2','bcrypt',1,'Operator','seed',NULL),
('00000000-0000-0000-0000-0000000000QA','qa','$2a$10$1CRPepUcsXEBY/r..LUbjObOrb7k8PpTV8D4LBwbME6oUC6tSfdI2','bcrypt',1,'QA','seed',NULL)
ON DUPLICATE KEY UPDATE is_active=VALUES(is_active), display_name=VALUES(display_name);

-- USER_ROLE 매핑(멱등)
INSERT INTO TB_USER_ROLE (user_id, role_id, created_by)
SELECT '00000000-0000-0000-0000-0000000000AD', r.role_id, 'seed' FROM TB_ROLE r WHERE r.role_code='ROLE_ADMIN'
ON DUPLICATE KEY UPDATE user_id=user_id;
INSERT INTO TB_USER_ROLE (user_id, role_id, created_by)
SELECT '00000000-0000-0000-0000-0000000000OP', r.role_id, 'seed' FROM TB_ROLE r WHERE r.role_code='ROLE_OP'
ON DUPLICATE KEY UPDATE user_id=user_id;
INSERT INTO TB_USER_ROLE (user_id, role_id, created_by)
SELECT '00000000-0000-0000-0000-0000000000QA', r.role_id, 'seed' FROM TB_ROLE r WHERE r.role_code='ROLE_QA'
ON DUPLICATE KEY UPDATE user_id=user_id;

/* 3) 마스터(워크숍→작업장→공정/품목/창고→설비) — FK 순서 준수 */
INSERT INTO TB_WORKSHOP (workshop_id, workshop_name, created_by)
VALUES ('WS-0001','MAIN_WORKSHOP','seed')
ON DUPLICATE KEY UPDATE workshop_name=VALUES(workshop_name);

INSERT INTO TB_WORKCENTER (workcenter_id, workcenter_name, workshop_id, created_by)
VALUES ('WC-0001','LINE_A','WS-0001','seed')
ON DUPLICATE KEY UPDATE workcenter_name=VALUES(workcenter_name), workshop_id=VALUES(workshop_id);

INSERT INTO TB_PROCESS (process_id, process_name, created_by)
VALUES ('P-0001','STENT_PROC','seed')
ON DUPLICATE KEY UPDATE process_name=VALUES(process_name);

INSERT INTO TB_ITEM (item_id, item_code, item_name, item_type, unit, created_by)
VALUES ('I-0001','STENT-01','STENT_01','F','EA','seed')
ON DUPLICATE KEY UPDATE item_name=VALUES(item_name), item_type=VALUES(item_type), unit=VALUES(unit);

INSERT INTO TB_WAREHOUSE (warehouse_id, warehouse_name, created_by)
VALUES ('W-0001','MAIN_WH','seed')
ON DUPLICATE KEY UPDATE warehouse_name=VALUES(warehouse_name);

INSERT INTO TB_EQUIPMENT (equipment_id, equipment_name, workcenter_id, process_id, status_code_id, created_by)
VALUES ('E-0001','STENT_LINE_01','WC-0001','P-0001', @EQ_RUN, 'seed')
ON DUPLICATE KEY UPDATE equipment_name=VALUES(equipment_name), workcenter_id=VALUES(workcenter_id),
                        process_id=VALUES(process_id), status_code_id=@EQ_RUN;

/* 4) 교대/캘린더/배치 — SHIFT 먼저, 그 다음 CALENDAR(설비 스코프) */
INSERT INTO TB_SHIFT (shift_id, shift_code, shift_name, start_time, end_time, created_by)
VALUES (1,'A','주간조','08:00:00','17:00:00','seed')
ON DUPLICATE KEY UPDATE shift_name=VALUES(shift_name), start_time=VALUES(start_time), end_time=VALUES(end_time);

-- 설비 스코프 캘린더(유니크: shift_date+shift_id+equipment_id)
INSERT INTO TB_SHIFT_CALENDAR (shift_date, shift_id, equipment_id, workcenter_id, start_ts, end_ts, created_by)
VALUES (CURRENT_DATE(),1,'E-0001',NULL, CONCAT(CURRENT_DATE(),' 08:00:00'), CONCAT(CURRENT_DATE(),' 17:00:00'),'seed')
ON DUPLICATE KEY UPDATE start_ts=VALUES(start_ts), end_ts=VALUES(end_ts);

-- 배치(작업자→설비)
INSERT INTO TB_SHIFT_ASSIGNMENT (shift_date, shift_id, worker_id, equipment_id, start_ts, end_ts, created_by)
VALUES (CURRENT_DATE(),1,'00000000-0000-0000-0000-0000000000OP','E-0001',
        CONCAT(CURRENT_DATE(),' 08:00:00'), CONCAT(CURRENT_DATE(),' 17:00:00'),'seed')
ON DUPLICATE KEY UPDATE end_ts=VALUES(end_ts);

/* 5) 계획/지시 — 지시 2건(P/R) */
INSERT INTO TB_PRODUCTION_PLAN (plan_id, plan_number, item_id, target_qty, start_date, end_date, status, created_by)
VALUES ('PL-0001','PL-0001','I-0001', 200, CURRENT_DATE(), CURRENT_DATE(), 'P','seed')
ON DUPLICATE KEY UPDATE target_qty=VALUES(target_qty);

INSERT INTO TB_WORK_ORDER (work_order_id, work_order_number, item_id, process_id, equipment_id,
                           order_qty, produced_qty, status_code_id, created_by)
VALUES 
('WO-0001','WO-0001','I-0001','P-0001','E-0001', 100, 0, @WO_R,'seed'),
('WO-0002','WO-0002','I-0001','P-0001','E-0001',  80, 0, @WO_P,'seed')
ON DUPLICATE KEY UPDATE order_qty=VALUES(order_qty), status_code_id=VALUES(status_code_id);

/* 6) 설비 상태 로그 — RUN 1건(오늘 09:00) */
INSERT INTO TB_EQUIPMENT_STATUS_LOG (equipment_id,status_code_id,start_time,end_time,created_by)
VALUES ('E-0001', @EQ_RUN, CONCAT(CURRENT_DATE(),' 09:00:00'), NULL, 'seed');

/* 7) 실적 2건(100/5, 60/0) — 지시 누적 계산 시나리오 */
INSERT INTO TB_PRODUCTION_PERFORMANCE (work_order_id,item_id,process_id,equipment_id,produced_qty,defect_qty,start_time,end_time,created_by)
VALUES 
('WO-0001','I-0001','P-0001','E-0001', 100, 5, CONCAT(CURRENT_DATE(),' 09:00:00'), CONCAT(CURRENT_DATE(),' 09:30:00'),'seed'),
('WO-0001','I-0001','P-0001','E-0001',  60, 0, CONCAT(CURRENT_DATE(),' 10:00:00'), CONCAT(CURRENT_DATE(),' 10:30:00'),'seed');

/* 8) KPI 타깃 — 오늘 1건 */
INSERT INTO TB_KPI_TARGET (kpi_date,equipment_id,process_id,item_id,target_oee,target_yield,target_productivity,created_by)
VALUES (CURRENT_DATE(),'E-0001','P-0001','I-0001',75.00,98.00,120.0000,'seed')
ON DUPLICATE KEY UPDATE target_oee=VALUES(target_oee), target_yield=VALUES(target_yield), target_productivity=VALUES(target_productivity);

/* (옵션) 품질 라이트 — 필요 시만 사용 */
INSERT INTO TB_INSPECTION (inspection_id, work_order_id, material_lot_id, item_id, inspection_type_code_id, inspection_time, worker_id, process_id, equipment_id, created_by)
VALUES (1001,'WO-0001', NULL, 'I-0001',
        (SELECT code_id FROM TB_CODE WHERE group_code='WO_STATUS' AND code='P'),
        CONCAT(CURRENT_DATE(),' 11:00:00'), '00000000-0000-0000-0000-0000000000OP', 'P-0001','E-0001','seed')
ON DUPLICATE KEY UPDATE inspection_time=VALUES(inspection_time);

-- 끝.