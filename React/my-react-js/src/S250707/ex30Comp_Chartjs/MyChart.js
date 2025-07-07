import { Line, Bar, Pie } from "react-chartjs-2";

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
} from "chart.js";
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

const MyChart = ({ type }) => {
  const labels = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"];
  const data = {
    labels,
    datasets: [
      {
        label: "Sales",
        data: [12, 19, 3, 5, 2, 3],
        backgroundColor: [
          "#007bff",
          "#28a745",
          "#ffc107",
          "#dc3545",
          "#6610f2",
          "#6c757d",
        ],
        borderColor: "#007bff",
        borderWidth: 2,
        fill: false,
      },
    ],
  };
  const options = {
    responsive: true,
    plugins: {
      legend: {
        position: "top",
      },
    },
  };

  switch (type) {
    case "line":
      return <Line data={data} options={options} />;
    case "bar":
      return <Bar data={data} options={options} />;
    case "pie":
      return <Pie data={data} options={options} />;
    default:
      return <Line data={data} options={options} />;
  }
};

export default MyChart;
