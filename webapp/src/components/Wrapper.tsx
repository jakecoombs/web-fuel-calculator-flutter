import styled from "styled-components";

export const Wrapper = ({ children }: { children: any }) => {
  return (
    <>
      <AppTitle>
        <h1>ACC Fuel Calculator</h1>
      </AppTitle>
      <WrapperStyle>{children}</WrapperStyle>
    </>
  );
};

const WrapperStyle = styled.div`
  h1 {
    text-align: center;
  }

  padding: 0 200px;
`;

const AppTitle = styled.div`
  background: #d32f2f;
  width: 100%;
  margin-top: -25px;

  h1 {
    text-align: center;
    padding: 10px 0;
  }
`;
