# erd_gen.py
from eralchemy2 import render_er

# DSN 예시: mysql+mysqlconnector://user:pwd@host:3306/db?charset=utf8mb4
render_er(
    "mysql+mysqlconnector://root:1121@HOST:3306/DB?charset=utf8mb4",
    "output/erd_v1.svg"  # PNG도 가능
)