from sklearn.datasets import load_iris
from sklearn.linear_model import LogisticRegression
from sklearn.preprocessing import StandardScaler
# iris = load_iris()
# lr = LogisticRegression(max_iter=1000) # lin = LinearRegression()
# lr.fit(iris.data, iris.target) # petal, sepal // setasa, versicolor
# weights = lr.coef_[0]
# print(weights)
# w1, w2 = lr.coef_[0]
# b = lr.intercept_[0]
# slope = -w1/w2
# intercept = -b/w2 
# print(slope)
# print(intercept)
# lr.predict([[5.1+0.1, 3.5-0.1]]) # 0: setosa
# 1. 데이터 불러오기 (특성 2개만 선택)
iris = load_iris()
X = iris.data[:, :2]  # 꽃받침 길이와 너비만 사용
y = iris.target

# 2. 데이터 스케일링 (수렴 문제 완화용)
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

# 3. 모델 생성 및 학습 (max_iter 증가)
lr = LogisticRegression(max_iter=1000)
lr.fit(X_scaled, y)
b = lr.intercept_[0]
# 4. 가중치 출력 (특성이 2개이므로 unpack 가능)
w1, w2 = lr.coef_[0]
print(f"slope : {-w1/w2}")
print(f"intercept: {-b/w2 }")

# 5. 절편 출력
print(f"절편 b: {lr.intercept_[0]}")