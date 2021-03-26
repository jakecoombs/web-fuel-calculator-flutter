import React from "react";
import { Firestore } from "../../pages/_app";
import { Change } from "./ListView";

export const LatestUpdate = () => {
  const [latest, setLatest] = React.useState<Change>();

  React.useEffect(() => {
    Firestore.collection("changelog")
      .orderBy("update", "desc")
      .get()
      .then((data) => setLatest(data.docs[0].data() as Change));
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
