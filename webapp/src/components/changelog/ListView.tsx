import React from "react";
import firebase from "firebase/app";
import "firebase/firestore";

export interface Change {
  update: String;
  changes: Array<String>;
}

export const ChangelogListView = () => {
  const [changes, setChanges] = React.useState<Array<Change>>([]);
  const [loaded, setLoaded] = React.useState(false);

  React.useEffect(() => {
    if (!loaded) {
      const collection = firebase
        .firestore()
        .collection("changelog")
        .orderBy("update", "desc");
      const decodedData: Array<Change> = [];
      collection
        .get()
        .then((data) =>
          data.docs.forEach((doc) => {
            decodedData.push(doc.data() as Change);
          })
        )
        .then(() => {
          setChanges(decodedData);
          setLoaded(true);
        });
    }
  });

  return (
    <div>
      <h1>Changelog</h1>
      {changes.map((update, i) => {
        return (
          <div key={i}>
            <h2>{update.update}</h2>
            {update.changes.map((change, i) => {
              return <p key={i}>{change}</p>;
            })}
          </div>
        );
      })}
    </div>
  );
};
