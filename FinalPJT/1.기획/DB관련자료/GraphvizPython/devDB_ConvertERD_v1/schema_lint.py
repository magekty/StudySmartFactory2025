
# 2. 스키마 린트
# 인덱스 누락, CHECK 제약, FK 제약 누락 등을 자동 탐지
# → 구조적으로 성능·무결성 문제를 일으킬 가능성이 있는 부분을 조기 발견

# 예시

# FK 없는 관계 → 데이터 불일치 허용

# 인덱스 없는 FK/검색 칼럼 → 조회 지연

# NOT NULL인데 기본값 미설정 → Insert 오류

# 📌 역할: 설계 레벨의 "결함 신호"를 초기에 잡아, 성능/무결성 이슈 예방

from sqlalchemy import create_engine, inspect, text

engine = create_engine("mysql+mysqlconnector://root:1121@127.0.0.1:3306/mes_pjt_test?charset=utf8mb4")
insp = inspect(engine)

with engine.connect() as c:
    # FK 인덱스 누락 탐지
    q_fk_idx = """
    SELECT rc.CONSTRAINT_NAME, rc.TABLE_NAME, kcu.COLUMN_NAME
    FROM information_schema.REFERENTIAL_CONSTRAINTS rc
    JOIN information_schema.KEY_COLUMN_USAGE kcu
      ON rc.CONSTRAINT_SCHEMA = kcu.CONSTRAINT_SCHEMA
     AND rc.TABLE_NAME = kcu.TABLE_NAME
     AND rc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
    LEFT JOIN information_schema.STATISTICS s
      ON s.TABLE_SCHEMA = kcu.TABLE_SCHEMA
     AND s.TABLE_NAME = kcu.TABLE_NAME
     AND s.COLUMN_NAME = kcu.COLUMN_NAME
    WHERE rc.CONSTRAINT_SCHEMA = DATABASE()
      AND s.COLUMN_NAME IS NULL;
    """
    fk_idx_missing = c.execute(text(q_fk_idx)).fetchall()

    # CHECK 목록(버전/논리 확인)
    q_check = """
    SELECT tc.TABLE_NAME, tc.CONSTRAINT_NAME, cc.CHECK_CLAUSE
    FROM information_schema.TABLE_CONSTRAINTS tc
    JOIN information_schema.CHECK_CONSTRAINTS cc
      ON tc.CONSTRAINT_SCHEMA = cc.CONSTRAINT_SCHEMA
     AND tc.CONSTRAINT_NAME = cc.CONSTRAINT_NAME
    WHERE tc.CONSTRAINT_SCHEMA = DATABASE()
      AND tc.CONSTRAINT_TYPE = 'CHECK';
    """
    checks = c.execute(text(q_check)).fetchall()

    # NULL 포함 유니크 착시 후보 (UNIQUE에 NULL 열이 섞여 있는 경우)
    q_uk_null = """
    SELECT s.TABLE_NAME, s.INDEX_NAME,
           GROUP_CONCAT(s.COLUMN_NAME ORDER BY s.SEQ_IN_INDEX) AS cols
    FROM information_schema.STATISTICS s
    JOIN information_schema.COLUMNS c
      ON c.TABLE_SCHEMA = s.TABLE_SCHEMA
     AND c.TABLE_NAME = s.TABLE_NAME
     AND c.COLUMN_NAME = s.COLUMN_NAME
    WHERE s.TABLE_SCHEMA = DATABASE()
      AND s.NON_UNIQUE = 0
    GROUP BY s.TABLE_NAME, s.INDEX_NAME
    HAVING SUM(IF(c.IS_NULLABLE='YES', 1, 0)) > 0;
    """
    uk_with_nulls = c.execute(text(q_uk_null)).fetchall()

print("FK 인덱스 누락:", fk_idx_missing)
print("CHECK 목록:", checks)
print("NULL 포함 유니크(착시 후보):", uk_with_nulls)
