import React from "react";
import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
  AreaChart,
  Area,
} from "recharts";
import { Box, Heading, Text, Flex } from "@chakra-ui/react";
import useAppStore from "../store";

const RealtimeEnergyChart: React.FC = () => {
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
        실시간 에너지 소비량 (kWh)
      </Heading>
      <ResponsiveContainer width="100%" height="calc(100% - 40px)">
        <AreaChart
          data={energyData}
          margin={{ top: 10, right: 30, left: 0, bottom: 0 }}
        >
          <CartesianGrid strokeDasharray="3 3" stroke="gray.200" />
          <XAxis
            dataKey="timestamp"
            tickFormatter={formatXAxis}
            minTickGap={30}
          />
          <YAxis domain={["auto", "auto"]} />
          <Tooltip
            labelFormatter={formatXAxis}
            formatter={(value: number) => `${value.toFixed(2)} kWh`}
            labelStyle={{ color: "#000" }}
            itemStyle={{ color: "#000" }}
          />
          <Area
            type="monotone"
            dataKey="energyConsumption"
            stroke="#319795"
            fill="#81E6D9"
            activeDot={{ r: 8 }}
          />
        </AreaChart>
      </ResponsiveContainer>
    </Box>
  );
};

export default RealtimeEnergyChart;
