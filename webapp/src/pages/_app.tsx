import GlobalStyle from "../globalStyles";
import firebase from "firebase/app";
import "firebase/auth";
import "firebase/firestore";

const Firebase = () => {
  if (firebase.apps.length === 0) {
    firebase.initializeApp({
      apiKey: "AIzaSyDIHQ9Th14hk8HoO5E8mBOx5_r6dmAx8z0",
      authDomain: "acc-fuel-calculator-f55cb.firebaseapp.com",
      databaseURL: "https://acc-fuel-calculator-f55cb.firebaseio.com",
      projectId: "acc-fuel-calculator-f55cb",
      storageBucket: "acc-fuel-calculator-f55cb.appspot.com",
      messagingSenderId: "890632571547",
      appId: "1:890632571547:web:31e79d9f7bcce760e3143e",
      measurementId: "G-42VX0F6TNC",
    });
  }
};

Firebase();

export const Firestore = firebase.firestore();

function MyApp({ Component, pageProps }: any) {
  return (
    <>
      <GlobalStyle />
      <Component {...pageProps} />
    </>
  );
}

export default MyApp;
