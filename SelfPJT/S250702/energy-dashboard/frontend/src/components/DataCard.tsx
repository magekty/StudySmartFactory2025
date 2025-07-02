import React from "react";
import {
  Box,
  Text,
  Stat,
  StatLabel,
  StatNumber,
  StatHelpText,
  StatArrow,
  Flex,
  Icon,
} from "@chakra-ui/react";
import {
  IoFlashOutline,
  IoThermometerOutline,
  IoWaterOutline,
} from "react-icons/io5";

interface DataCardProps {
  title: string;
  value: number;
  unit: string;
  description: string;
  icon: React.ElementType;
  colorScheme?: string;
}

const DataCard: React.FC<DataCardProps> = ({
  title,
  value,
  unit,
  description,
  icon,
  colorScheme = "blue",
}) => {
  return (
    <Box
      p={4}
      bg="white"
      borderRadius="lg"
      shadow="md"
      transition="all 0.2s"
      _hover={{ transform: "translateY(-2px)", shadow: "lg" }}
      height="100%"
    >
      <Flex alignItems="center" mb={2}>
        <Icon as={icon} w={6} h={6} color={`${colorScheme}.500`} mr={3} />
        <Stat>
          <StatLabel fontSize="sm" color="gray.600">
            {title}
          </StatLabel>
          <StatNumber
            fontSize="3xl"
            fontWeight="bold"
            color={`${colorScheme}.600`}
          >
            {value.toFixed(2)}
            <Text as="span" fontSize="lg" ml={1} color="gray.500">
              {unit}
            </Text>
          </StatNumber>
          <StatHelpText>
            <StatArrow type="increase" />
            {description}
          </StatHelpText>
        </Stat>
      </Flex>
    </Box>
  );
};

export default DataCard;
