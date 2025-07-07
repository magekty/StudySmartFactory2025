import ChartCard from "./ChartCard";
import "./DashBoard.css";

const DashBoard = () => {
  const labels_month = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"];
  const labels_categoty = ["Electronis", "Clothing", "Groceries"];
  const lineData = {
    labels: labels_month,
    datasets: [
      {
        label: "매출",
        data: [120, 1900, 3000, 5000, 2000, 3000],
        backgroundColor: "rgba(144,166,190,0.2)",
        borderColor: "#007bff",
        borderWidth: 2,
        fill: true,
      },
    ],
  };
  const barData = {
    labels: labels_month,
    datasets: [
      {
        label: "주문",
        data: [30, 45, 60, 40, 80, 55],
        backgroundColor: "rgba(144,166,190,0.2)",
        borderColor: "#007bff",
        fill: true,
      },
    ],
  };
  const doughnutData = {
    labels_categoty,
    datasets: [
      {
        label: "부문별 판매",
        data: [300, 450, 600],
        backgroundColor: ["#ffc107", "#dc3545", "#17a2b8"],
        borderColor: "#007bff",
        fill: true,
      },
    ],
  };
  const commonOptions = {
    responsive: true,
    plugins: {
      legend: {
        position: "top",
      },
    },
  };
  return (
    <div className="DashBoard">
      <ChartCard
        type="line"
        title="월별 매출"
        chartData={lineData}
        chartOptions={commonOptions}
      />
      <ChartCard
        type="bar"
        title="월별 주문"
        chartData={barData}
        chartOptions={commonOptions}
      />
      <ChartCard
        type="doughnut"
        title="종류별 판매"
        chartData={doughnutData}
        chartOptions={commonOptions}
      />
    </div>
  );
};

export default DashBoard;
