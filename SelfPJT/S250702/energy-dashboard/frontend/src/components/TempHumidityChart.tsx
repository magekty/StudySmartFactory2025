import React from "react";
import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
  Legend,
} from "recharts";
import { Box, Heading, Text, Flex } from "@chakra-ui/react";
import useAppStore from "../store";

const TempHumidityChart: React.FC = () => {
  const energyData = useAppStore((state) => state.energyData);

  if (energyData.length === 0) {
    return (
      <Box
        p={4}
        bg="white"
        borderRadius="lg"
        shadow="md"
        textAlign="center"
        height="400px"
        display="flex"
        alignItems="center"
        justifyContent="center"
      >
        <Text fontSize="lg" color="gray.500">
          데이터를 수신 중입니다...
        </Text>
      </Box>
    );
  }

  const formatXAxis = (timestamp: number) => {
    return new Date(timestamp).toLocaleTimeString("ko-KR", {
      hour: "2-digit",
      minute: "2-digit",
      second: "2-digit",
    });
  };

  return (
    <Box p={4} bg="white" borderRadius="lg" shadow="md" height="400px">
      <Heading as="h3" size="md" mb={4} color="brand.600">
        실시간 환경 데이터
      </Heading>
      <ResponsiveContainer width="100%" height="calc(100% - 40px)">
        <LineChart
          data={energyData}
          margin={{ top: 10, right: 30, left: 0, bottom: 0 }}
        >
          <CartesianGrid strokeDasharray="3 3" stroke="gray.200" />
          <XAxis
            dataKey="timestamp"
            tickFormatter={formatXAxis}
            minTickGap={30}
          />
          <YAxis yAxisId="left" orientation="left" stroke="#8884d8" />
          <YAxis yAxisId="right" orientation="right" stroke="#82ca9d" />
          <Tooltip
            labelFormatter={formatXAxis}
            formatter={(value: number, name: string) => [
              `${value.toFixed(1)} ${
                name === "currentTemperature" ? "°C" : "%"
              }`,
              name === "currentTemperature" ? "온도" : "습도",
            ]}
            labelStyle={{ color: "#000" }}
            itemStyle={{ color: "#000" }}
          />
          <Legend />
          <Line
            yAxisId="left"
            type="monotone"
            dataKey="currentTemperature"
            stroke="#8884d8"
            name="온도"
            activeDot={{ r: 8 }}
          />
          <Line
            yAxisId="right"
            type="monotone"
            dataKey="humidity"
            stroke="#82ca9d"
            name="습도"
            activeDot={{ r: 8 }}
          />
        </LineChart>
      </ResponsiveContainer>
    </Box>
  );
};

export default TempHumidityChart;
