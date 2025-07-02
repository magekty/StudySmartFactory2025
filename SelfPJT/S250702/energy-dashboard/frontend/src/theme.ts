// frontend/src/theme.ts
import { extendTheme } from "@chakra-ui/react";
import { mode } from "@chakra-ui/theme-tools";

const theme = extendTheme({
  config: {
    initialColorMode: "light",
    useSystemColorMode: false,
  },
  colors: {
    brand: {
      50: "#E6FFFA",
      100: "#B2F5EA",
      200: "#81E6D9",
      300: "#4FD1C5",
      400: "#38B2AC",
      500: "#319795",
      600: "#2C7A7B",
      700: "#285E61",
      800: "#234E52",
      900: "#1D4044",
    },
  },
  styles: {
    global: (props: any) => ({
      body: {
        bg: mode("gray.50", "gray.800")(props),
        color: mode("gray.800", "whiteAlpha.900")(props),
      },
    }),
  },
  components: {
    Table: {
      baseStyle: (props: any) => ({
        th: { color: mode("gray.600", "gray.300")(props) },
        td: { color: mode("gray.700", "whiteAlpha.800")(props) },
      }),
    },
    Input: {
      baseStyle: (props: any) => ({
        field: {
          color: mode("gray.800", "whiteAlpha.900")(props),
          _placeholder: { color: mode("gray.500", "gray.400")(props) },
        },
      }),
    },
    Select: {
      baseStyle: (props: any) => ({
        field: {
          color: mode("gray.800", "whiteAlpha.900")(props),
          option: {
            backgroundColor: mode("white", "gray.700")(props),
            color: mode("gray.800", "whiteAlpha.900")(props),
          },
        },
      }),
    },
  },
});

export default theme;
