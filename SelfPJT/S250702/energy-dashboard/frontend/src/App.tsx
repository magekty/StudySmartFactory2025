import { Box, Text, VStack, Heading } from "@chakra-ui/react";
import useAppStore from "./store";
import useWebSocket from "./hooks/useWebSocket";

function App() {
  const latestData = useAppStore((state) => state.latestData);
  const addLatestData = useAppStore((state) => state.addLatestData);

  useWebSocket({
    url: "ws://localhost:3001", // 백엔드 서버 포트 3001로 연결
    onMessage: (data) => {
      // 백엔드에서 받은 데이터가 유효한지 확인하고 스토어에 저장
      if (
        data &&
        typeof data === "object" &&
        "timestamp" in data &&
        "value" in data
      ) {
        addLatestData(data);
        console.log("Received data:", data); // 콘솔에도 출력하여 확인
      }
    },
    reconnectInterval: 3000,
    reconnectAttempts: 10,
  });

  return (
    <Box p={8} minH="100vh" bg="gray.50">
      <VStack spacing={4} align="center">
        <Heading as="h1" size="xl" color="brand.700">
          실시간 데이터 모니터링 (기본)
        </Heading>
        {latestData ? (
          <VStack>
            <Text fontSize="lg">
              **연결 상태:**{" "}
              <Text as="span" color="green.500" fontWeight="bold">
                연결됨
              </Text>
            </Text>
            <Text fontSize="md">
              **마지막 수신 시간:**{" "}
              {new Date(latestData.timestamp).toLocaleString()}
            </Text>
            <Text fontSize="md">**값:** {latestData.value.toFixed(2)}</Text>
            <Text fontSize="md">**메시지:** {latestData.message}</Text>
          </VStack>
        ) : (
          <Text fontSize="lg" color="gray.500">
            데이터를 수신 중입니다...
          </Text>
        )}
        <Text fontSize="sm" color="gray.400" mt={4}>
          (브라우저 개발자 도구의 콘솔에서도 수신 데이터를 확인할 수 있습니다.)
        </Text>
      </VStack>
    </Box>
  );
}

export default App;
