import { Scatter } from "react-chartjs-2";

import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  BarElement,
  ArcElement,
  Tooltip,
  Legend,
  scales,
} from "chart.js";
import { useState } from "react";
ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  BarElement,
  ArcElement,
  Tooltip,
  Legend
);

const dataPoints = [
  { x: 10, y: 12 },
  { x: 20, y: 22 },
  { x: 30, y: 33 },
  { x: 40, y: 42 },
  { x: 50, y: 49 },
  { x: 60, y: 61 },
];
const linearRegression = (points) => {
  const n = points.length;
  const sumX = points.reduce((acc, p) => acc + p.x, 0);
  const sumY = points.reduce((acc, p) => acc + p.y, 0);
  const sumXY = points.reduce((acc, p) => acc + p.x * p.y, 0);
  const sumXX = points.reduce((acc, p) => acc + p.x * p.x, 0);
  const slope = (n * sumXY - sumX * sumY) / (n * sumXX - sumX * sumX);
  const intercept = (sumY - slope * sumX) / n;
  return { slope, intercept };
};
const { slope, intercept } = linearRegression(dataPoints);
const App = () => {
  const [investment, setInvestment] = useState("");
  const predictedProfit = investment
    ? slope * Number(investment) + intercept
    : null;
  const xMin = Math.min(...dataPoints.map((p) => p.x));
  const xMax = Math.max(...dataPoints.map((p) => p.x));
  const regressionLine = [
    { x: xMin, y: slope * xMin + intercept },
    { x: xMax, y: slope * xMax + intercept },
  ];
  const chartData = {
    datasets: [
      {
        label: "투자금 vs 수익금",
        data: dataPoints,
        backgroundColor: "blue",
      },
      {
        label: "회귀 직선",
        data: regressionLine,
        type: "line",
        backgroundColor: "red",
        borderWidth: 2,
        fill: false,
        showLine: true,
        pointRadius: 0,
      },
    ],
  };
  if (predictedProfit) {
    chartData.datasets.push({
      label: "예측 수익값",
      data: [{ x: Number(investment), y: predictedProfit }],
      backgroundColor: "green",
      pointRadius: 6,
    });
  }
  const options = {
    scales: {
      x: {
        title: {
          display: true,
          text: "투자금",
        },
      },
      y: {
        title: {
          display: true,
          text: "수익금",
        },
      },
    },
  };
  return (
    <div className="App">
      <h2>투자금 vs 수익금 회귀선</h2>
      <Scatter data={chartData} options={options} />
      <div>
        <label>
          새로운 투자금
          <input
            type="number"
            value={investment}
            onChange={(event) => {
              setInvestment(event.target.value);
            }}
          />
        </label>
      </div>
      {predictedProfit && <p>예상 수익금: {predictedProfit.toFixed(2)}</p>}
    </div>
  );
};

export default App;
