import sqlparse
from graphviz import Digraph
import re

# SQL 파일 로드
with open("ddl.sql", "r", encoding="utf-8") as file:
    ddl_text = file.read()

# SQL 파싱
parsed = sqlparse.parse(ddl_text)

tables = {}
relationships = []

for stmt in parsed:
    stmt_str = str(stmt).strip()
    if not stmt_str.lower().startswith("create table"):
        continue

    # 테이블 이름 추출
    table_name_match = re.search(r'CREATE TABLE `?(\w+)`?', stmt_str, re.IGNORECASE)
    if not table_name_match:
        continue
    table_name = table_name_match.group(1)

    # 컬럼들 추출
    column_lines = re.findall(r'`(\w+)` [^\n,]*', stmt_str)
    tables[table_name] = column_lines

    # FK 관계 추출
    fk_matches = re.findall(
        r'FOREIGN KEY \(`(\w+)`\) REFERENCES `(\w+)` \(`(\w+)`\)',
        stmt_str,
        re.IGNORECASE
    )
    for fk_col, ref_table, ref_col in fk_matches:
        relationships.append((table_name, ref_table, fk_col, ref_col))

# 디버깅 출력
print("table len:", len(tables))
for t, cols in tables.items():
    print(f" - {t}: {len(cols)}개 컬럼")

print(" FK rel:", len(relationships))
for rel in relationships:
    print(f" - {rel[0]}.{rel[2]} → {rel[1]}.{rel[3]}")

# ERD 시각화
dot = Digraph(comment="ERD")
for table_name, columns in tables.items():
    label = f"<<TABLE BORDER='1' CELLBORDER='1' CELLSPACING='0'>"
    label += f"<TR><TD COLSPAN='1'><B>{table_name}</B></TD></TR>"
    for col in columns:
        label += f"<TR><TD ALIGN='LEFT'>{col}</TD></TR>"
    label += "</TABLE>>"
    dot.node(table_name, label=label, shape="plaintext")

for from_table, to_table, from_col, to_col in relationships:
    dot.edge(from_table, to_table, label=f"{from_col} → {to_col}")

dot.render("erd_output", format="png", cleanup=True)
print("ERD done: erd_output.png")
