import React from "react";
import firebase from "firebase/app";
import "firebase/firestore";
import { Change } from "./ListView";

export const LatestUpdate = () => {
  const [loaded, setLoaded] = React.useState(false);
  const [latest, setLatest] = React.useState<Change>();

  React.useEffect(() => {
    if (!loaded) {
      firebase
        .firestore()
        .collection("changelog")
        .orderBy("update", "desc")
        .limit(1)
        .get()
        .then((data) => {
          setLatest(data.docs[0].data() as Change);
          setLoaded(true);
        });
    }
  });

  return (
    <div>
      <h1>Latest Update</h1>
      {latest && (
        <>
          <h2>{latest.update}</h2>
          {latest.changes.map((change, i) => {
            return <p key={i}>{change}</p>;
          })}
        </>
      )}
    </div>
  );
};
