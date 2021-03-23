import { ReactChild } from "react";
import styled from "styled-components";

export const Wrapper = ({ children }: { children: ReactChild }) => {
  return <WrapperStyle>{children}</WrapperStyle>;
};

const WrapperStyle = styled.div`
  h1 {
    text-align: center;
  }

  padding: 0 50px;
`;
