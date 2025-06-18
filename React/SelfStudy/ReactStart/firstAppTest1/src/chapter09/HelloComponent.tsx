import React from "react";
import { HelloProps } from "./typeScript/HelloProps";

// function HelloComponent({ name, age }: HelloProps) {
//   return (
//     <>
//       Hello {name}, you are {age} years old!
//     </>
//   );
// }
const HelloComponent: React.FC<HelloProps> = ({ name, age }) => {
  return (
    <>
      Hello {name}, you are {age} years old!
    </>
  );
};

export default HelloComponent;
