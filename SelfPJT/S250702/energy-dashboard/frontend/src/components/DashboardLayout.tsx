import { Box, Grid, GridItem, Heading, Text, VStack } from "@chakra-ui/react";
import React from "react";

interface DashboardLayoutProps {
  children: React.ReactNode;
}

const DashboardLayout: React.FC<DashboardLayoutProps> = ({ children }) => {
  return (
    <Box p={{ base: 4, md: 8 }} maxW="full" mx="auto" minH="100vh" bg="gray.50">
      <VStack spacing={8} align="stretch">
        <Heading as="h1" size="xl" textAlign="center" color="brand.700" mb={4}>
          스마트 에너지 모니터링 대시보드
        </Heading>

        <Grid
          templateColumns={{
            base: "1fr",
            md: "repeat(2, 1fr)",
            lg: "repeat(3, 1fr)",
          }}
          gap={6}
        >
          {children}
        </Grid>
      </VStack>
    </Box>
  );
};

export default DashboardLayout;
