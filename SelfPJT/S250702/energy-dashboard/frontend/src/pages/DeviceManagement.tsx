// frontend/src/pages/DeviceManagement.tsx
import React, { useState, useEffect } from "react";
import {
  Box,
  Heading,
  Button,
  VStack,
  HStack,
  Text,
  useDisclosure,
  Modal,
  ModalOverlay,
  ModalContent,
  ModalHeader,
  ModalFooter,
  ModalBody,
  ModalCloseButton,
  FormControl,
  FormLabel,
  Input,
  Select,
  useToast,
  Table,
  Thead,
  Tbody,
  Tr,
  Th,
  Td,
  TableContainer,
  Badge,
  IconButton,
  useColorModeValue,
} from "@chakra-ui/react";
import { AddIcon, EditIcon, DeleteIcon } from "@chakra-ui/icons";
import { Device } from "../types";
import {
  getDevices,
  addDevice,
  updateDevice,
  deleteDevice,
} from "../utils/localStorage";
import { v4 as uuidv4 } from "uuid";

const DeviceManagement: React.FC = () => {
  const [devices, setDevices] = useState<Device[]>([]);
  const [selectedDevice, setSelectedDevice] = useState<Device | null>(null);
  const { isOpen, onOpen, onClose } = useDisclosure();
  const toast = useToast();

  const [name, setName] = useState("");
  const [type, setType] = useState("");
  const [location, setLocation] = useState("");
  const [status, setStatus] = useState<"active" | "inactive">("active");

  const pageBg = useColorModeValue("gray.50", "gray.800");
  const headingColor = useColorModeValue("brand.700", "brand.200");
  const cardBg = useColorModeValue("white", "gray.700");
  const textColor = useColorModeValue("gray.800", "whiteAlpha.900");
  const inputBorderColor = useColorModeValue("gray.200", "gray.600");
  const inputFocusBorderColor = useColorModeValue("brand.500", "brand.300");

  useEffect(() => {
    setDevices(getDevices());
  }, []);

  const handleOpenModal = (device?: Device) => {
    if (device) {
      setSelectedDevice(device);
      setName(device.name);
      setType(device.type);
      setLocation(device.location);
      setStatus(device.status);
    } else {
      setSelectedDevice(null);
      setName("");
      setType("");
      setLocation("");
      setStatus("active");
    }
    onOpen();
  };

  const handleSaveDevice = () => {
    if (!name || !type || !location) {
      toast({
        title: "입력 오류",
        description: "모든 필드를 채워주세요.",
        status: "error",
        duration: 3000,
        isClosable: true,
      });
      return;
    }

    const newOrUpdatedDevice: Device = selectedDevice
      ? { ...selectedDevice, name, type, location, status }
      : { id: uuidv4(), name, type, location, status, createdAt: Date.now() };

    if (selectedDevice) {
      updateDevice(newOrUpdatedDevice);
      toast({
        title: "장치 수정 완료",
        description: `${newOrUpdatedDevice.name} 장치가 수정되었습니다.`,
        status: "success",
        duration: 3000,
        isClosable: true,
      });
    } else {
      addDevice(newOrUpdatedDevice);
      toast({
        title: "장치 추가 완료",
        description: `${newOrUpdatedDevice.name} 장치가 추가되었습니다.`,
        status: "success",
        duration: 3000,
        isClosable: true,
      });
    }
    setDevices(getDevices());
    onClose();
  };

  const handleDeleteDevice = (id: string) => {
    if (window.confirm("정말로 이 장치를 삭제하시겠습니까?")) {
      const success = deleteDevice(id);
      if (success) {
        setDevices(getDevices());
        toast({
          title: "장치 삭제 완료",
          description: "장치가 성공적으로 삭제되었습니다.",
          status: "info",
          duration: 3000,
          isClosable: true,
        });
      } else {
        toast({
          title: "삭제 실패",
          description: "장치를 찾을 수 없거나 삭제에 실패했습니다.",
          status: "error",
          duration: 3000,
          isClosable: true,
        });
      }
    }
  };

  return (
    <Box p={{ base: 4, md: 8 }} maxW="full" mx="auto" minH="100vh" bg={pageBg}>
      <VStack spacing={8} align="stretch">
        <Heading
          as="h1"
          size="xl"
          textAlign="center"
          color={headingColor}
          mb={4}
        >
          장치 관리
        </Heading>

        <HStack justifyContent="flex-end">
          <Button
            leftIcon={<AddIcon />}
            colorScheme="teal"
            onClick={() => handleOpenModal()}
          >
            새 장치 추가
          </Button>
        </HStack>

        <Box bg={cardBg} p={6} borderRadius="lg" shadow="md">
          <Heading as="h2" size="lg" mb={4} color={headingColor}>
            등록된 장치 목록
          </Heading>
          {devices.length === 0 ? (
            <Text textAlign="center" py={10} color={textColor}>
              등록된 장치가 없습니다. 새로운 장치를 추가해주세요.
            </Text>
          ) : (
            <TableContainer>
              <Table variant="simple">
                <Thead>
                  <Tr>
                    <Th>이름</Th>
                    <Th>타입</Th>
                    <Th>위치</Th>
                    <Th>상태</Th>
                    <Th>생성일</Th>
                    <Th>액션</Th>
                  </Tr>
                </Thead>
                <Tbody>
                  {devices.map((device) => (
                    <Tr key={device.id}>
                      <Td>{device.name}</Td>
                      <Td>{device.type}</Td>
                      <Td>{device.location}</Td>
                      <Td>
                        <Badge
                          colorScheme={
                            device.status === "active" ? "green" : "red"
                          }
                          color={useColorModeValue("white", "black")}
                        >
                          {device.status === "active" ? "활성" : "비활성"}
                        </Badge>
                      </Td>
                      <Td>
                        {new Date(device.createdAt).toLocaleDateString("ko-KR")}
                      </Td>
                      <Td>
                        <HStack spacing={2}>
                          <IconButton
                            aria-label="Edit device"
                            icon={<EditIcon />}
                            size="sm"
                            onClick={() => handleOpenModal(device)}
                            color={useColorModeValue("gray.700", "gray.300")}
                          />
                          <IconButton
                            aria-label="Delete device"
                            icon={<DeleteIcon />}
                            size="sm"
                            colorScheme="red"
                            onClick={() => handleDeleteDevice(device.id)}
                            color={useColorModeValue("red.700", "red.300")}
                          />
                        </HStack>
                      </Td>
                    </Tr>
                  ))}
                </Tbody>
              </Table>
            </TableContainer>
          )}
        </Box>
      </VStack>

      <Modal isOpen={isOpen} onClose={onClose}>
        <ModalOverlay />
        <ModalContent bg={cardBg} color={textColor}>
          <ModalHeader
            borderBottomWidth="1px"
            borderColor={useColorModeValue("gray.200", "gray.600")}
            color={headingColor}
          >
            {selectedDevice ? "장치 수정" : "새 장치 추가"}
          </ModalHeader>
          <ModalCloseButton color={textColor} />
          <ModalBody>
            <VStack spacing={4}>
              <FormControl isRequired>
                <FormLabel color={textColor}>장치 이름</FormLabel>
                <Input
                  value={name}
                  onChange={(e) => setName(e.target.value)}
                  color={textColor}
                  borderColor={inputBorderColor}
                  _focus={{ borderColor: inputFocusBorderColor }}
                />
              </FormControl>
              <FormControl isRequired>
                <FormLabel color={textColor}>장치 타입</FormLabel>
                <Input
                  value={type}
                  onChange={(e) => setType(e.target.value)}
                  color={textColor}
                  borderColor={inputBorderColor}
                  _focus={{ borderColor: inputFocusBorderColor }}
                />
              </FormControl>
              <FormControl isRequired>
                <FormLabel color={textColor}>설치 위치</FormLabel>
                <Input
                  value={location}
                  onChange={(e) => setLocation(e.target.value)}
                  color={textColor}
                  borderColor={inputBorderColor}
                  _focus={{ borderColor: inputFocusBorderColor }}
                />
              </FormControl>
              <FormControl>
                <FormLabel color={textColor}>상태</FormLabel>
                <Select
                  value={status}
                  onChange={(e) =>
                    setStatus(e.target.value as "active" | "inactive")
                  }
                  color={textColor}
                  borderColor={inputBorderColor}
                  _focus={{ borderColor: inputFocusBorderColor }}
                >
                  <option
                    value="active"
                    style={{
                      color: useColorModeValue("black", "white"),
                      backgroundColor: useColorModeValue("white", "gray.700"),
                    }}
                  >
                    활성
                  </option>
                  <option
                    value="inactive"
                    style={{
                      color: useColorModeValue("black", "white"),
                      backgroundColor: useColorModeValue("white", "gray.700"),
                    }}
                  >
                    비활성
                  </option>
                </Select>
              </FormControl>
            </VStack>
          </ModalBody>
          <ModalFooter
            borderTopWidth="1px"
            borderColor={useColorModeValue("gray.200", "gray.600")}
          >
            <Button variant="ghost" mr={3} onClick={onClose}>
              취소
            </Button>
            <Button colorScheme="teal" onClick={handleSaveDevice}>
              저장
            </Button>
          </ModalFooter>
        </ModalContent>
      </Modal>
    </Box>
  );
};

export default DeviceManagement;
