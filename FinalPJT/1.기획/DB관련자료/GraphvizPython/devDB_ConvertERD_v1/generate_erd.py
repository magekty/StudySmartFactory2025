import sqlparse
import re
from graphviz import Digraph

def parse_sql_to_erd(sql_text: str):
    tables = {}
    foreign_keys = []

    statements = sqlparse.split(sql_text)

    for stmt in statements:
        token_str = stmt.strip()
        table_match = re.search(r'CREATE TABLE `?(\w+)`?\s*\((.*)\)', token_str, re.IGNORECASE | re.DOTALL)
        
        if not table_match:
            continue

        table_name = table_match.group(1)
        column_block = table_match.group(2)
        tables[table_name] = {'columns': [], 'pk': [], 'uk': [], 'fk': []}

        # 1차 파싱: 컬럼 정의와 제약 조건 분리
        definitions = [item.strip() for item in column_block.split(',')]

        for definition in definitions:
            # FOREIGN KEY 제약 조건 처리
            fk_match = re.search(r'FOREIGN KEY\s*\(`?(\w+)`?\)\s+REFERENCES\s+`?(\w+)`?\s*\(`?(\w+)`?\)', definition, re.IGNORECASE)
            if fk_match:
                src_col, ref_table, ref_col = fk_match.groups()
                foreign_keys.append((table_name, src_col, ref_table, ref_col))
                tables[table_name]['fk'].append(src_col)
                continue

            # PRIMARY KEY 제약 조건 처리 (테이블 레벨)
            pk_match = re.search(r'PRIMARY KEY\s*\(`?(\w+)`?\)', definition, re.IGNORECASE)
            if pk_match:
                pk_col = pk_match.group(1)
                if pk_col not in tables[table_name]['pk']:
                    tables[table_name]['pk'].append(pk_col)
                continue

            # UNIQUE KEY 제약 조건 처리 (테이블 레벨)
            uk_match = re.search(r'UNIQUE KEY\s+`?\w+`?\s*\(`?(\w+)`?\)', definition, re.IGNORECASE)
            if uk_match:
                uk_col = uk_match.group(1)
                if uk_col not in tables[table_name]['uk']:
                    tables[table_name]['uk'].append(uk_col)
                continue
            
            # 일반 컬럼 정의 처리
            col_match = re.match(r'`?(\w+)`?\s+([\w\(\)]+)(.*)', definition, re.IGNORECASE | re.DOTALL)
            if col_match:
                col, dtype, attrs = col_match.groups()
                
                attr_info = ''
                if 'PRIMARY KEY' in attrs.upper():
                    tables[table_name]['pk'].append(col)
                    attr_info += ' [PK]'
                if 'UNIQUE' in attrs.upper():
                    tables[table_name]['uk'].append(col)
                    attr_info += ' [UK]'
                if 'NOT NULL' in attrs.upper():
                    attr_info += ' [NN]'
                if 'AUTO_INCREMENT' in attrs.upper():
                    attr_info += ' [AI]'
                
                tables[table_name]['columns'].append(f"{col}: {dtype}{attr_info}")

    # PK/UK가 컬럼 정의에 포함되지 않은 경우 속성 추가
    for table_name in tables:
        pk_cols = set(tables[table_name]['pk'])
        uk_cols = set(tables[table_name]['uk'])
        new_cols = []
        for col_str in tables[table_name]['columns']:
            col_name = col_str.split(':')[0].strip()
            updated = col_str
            if col_name in pk_cols and '[PK]' not in updated:
                updated += ' [PK]'
            if col_name in uk_cols and '[UK]' not in updated:
                updated += ' [UK]'
            new_cols.append(updated)
        tables[table_name]['columns'] = new_cols

    return tables, foreign_keys

def draw_erd(tables: dict, foreign_keys: list, filename='full_erd_diagram'):
    dot = Digraph(comment='Full ERD')
    dot.attr(rankdir='LR', fontsize='10', fontname='Helvetica')

    for table, meta in tables.items():
        label = f'<<TABLE BORDER="1" CELLBORDER="1" CELLSPACING="0">'
        label += f'<TR><TD BGCOLOR="lightblue"><B>{table}</B></TD></TR>'

        # PK 먼저, 그 다음 UK, 그 다음 일반 컬럼
        sorted_columns = sorted(meta['columns'], key=lambda x: ('[PK]' not in x, '[UK]' not in x))
        
        for col in sorted_columns:
            label += f'<TR><TD ALIGN="LEFT">{col}</TD></TR>'

        label += '</TABLE>>'
        dot.node(table, label=label, shape='plain')

    # 외래 키 관계 생성
    for src_table, src_col, ref_table, ref_col in foreign_keys:
        dot.edge(src_table, ref_table, label=f"{src_col} -> {ref_col}", fontsize='10')

    dot.render(filename, format='png', cleanup=True)
    print(f"ERD 이미지 생성 완료: {filename}.png")

if __name__ == '__main__':
    with open("ddl.sql", "r", encoding="utf-8") as f:
        sql_input = f.read()
    
    tables, fks = parse_sql_to_erd(sql_input)
    draw_erd(tables, fks, filename='smart_erd')
