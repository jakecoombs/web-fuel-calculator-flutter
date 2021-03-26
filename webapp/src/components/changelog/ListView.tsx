import React from "react";
import { Firestore } from "../../pages/_app";

export interface Change {
  update: String;
  changes: Array<String>;
}

export const ChangelogListView = () => {
  const [changes, setChanges] = React.useState<Array<Change>>([]);
  const [loaded, setLoaded] = React.useState(false);
  const collection = Firestore.collection("changelog").orderBy(
    "update",
    "desc"
  );

  React.useEffect(() => {
    if (!loaded) {
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
            {update.changes.map((change) => {
              return <p>{change}</p>;
            })}
          </div>
        );
      })}
    </div>
  );
};
