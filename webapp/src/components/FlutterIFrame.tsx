import React from "react";
import styled from "styled-components";

export const FlutterIFrame = () => {
  return (
    <FullScreen>
      <iframe
        src="https://acc-fuel-calculator-f55cb.web.app/#/"
        title="ACC Fuel Calculator"
        width="100%"
        height="100%"
        frameBorder="0"
      />
    </FullScreen>
  );
};

const FullScreen = styled.div`
  width: 100vw;
  height: 100vh;
`;
