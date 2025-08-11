# data_lint.py

# 1. 데이터 무결성 린트
# 겹침(중복), 역전(순서 위반), 음수(비합리적 값) 같은 문제는
# → 실제 서비스 전 데이터 품질에 직접 영향을 주는 결함
# → 초기에 걸러야 나중에 ETL·분석·서비스 로직에서 오류 안 남

# 예시

# 주문일이 배송일보다 늦음 (역전)

# 가격이 음수

# 고객 ID 중복

# 📌 역할: 데이터 품질의 "연기"를 감지 → 서비스가 불타기 전에 끄는 용도

from sqlalchemy import create_engine, text
engine = create_engine("mysql+mysqlconnector://root:1121@127.0.0.1:3306/mes_pjt_test?charset=utf8mb4")

with engine.connect() as c:
    # 시간 역전(대표 3종)
    for tbl, start, end in [
        ("TB_PRODUCTION_PERFORMANCE", "start_time", "end_time"),
        ("TB_EQUIPMENT_STATUS_LOG", "start_time", "end_time"),
        ("TB_SHIFT_ASSIGNMENT", "start_ts", "end_ts"),
    ]:
        bad = c.execute(text(f"SELECT COUNT(*) FROM {tbl} WHERE {end} IS NOT NULL AND {end} < {start}")).scalar()
        print(tbl, "시간 역전:", bad)

    # 수량 음수/관계 위반
    perf_bad = c.execute(text("""
      SELECT COUNT(*) FROM TB_PRODUCTION_PERFORMANCE
      WHERE produced_qty < 0 OR defect_qty < 0 OR defect_qty > produced_qty
    """)).scalar()
    print("PERF 수량 위반:", perf_bad)

    # 교대 배치 겹침(같은 교대/날짜/작업자/스코프 내에서 시간이 겹치는 케이스)
    overlap = c.execute(text("""
      SELECT COUNT(*) FROM (
        SELECT a1.assignment_id
        FROM TB_SHIFT_ASSIGNMENT a1
        JOIN TB_SHIFT_ASSIGNMENT a2
          ON a1.shift_date=a2.shift_date AND a1.shift_id=a2.shift_id
         AND a1.worker_id=a2.worker_id
         AND COALESCE(a1.equipment_id, a1.workcenter_id)
             = COALESCE(a2.equipment_id, a2.workcenter_id)
         AND a1.assignment_id < a2.assignment_id
         AND a1.start_ts < a2.end_ts AND a2.start_ts < a1.end_ts
      ) t
    """)).scalar()
    print("배치 겹침 수:", overlap)