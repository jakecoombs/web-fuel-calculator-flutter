import styled from "styled-components";

export const Wrapper = ({ children }: { children: any }) => {
  return (
    <>
      <AppTitle>
        <a href="/">
          <h1>ACC Fuel Calculator</h1>
        </a>
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

  h1,
  a {
    text-align: center;
    padding: 10px 0;
    text-decoration: none;
    color: white;
  }
`;
