import React from "react";
import styled from "styled-components";
import { Firestore } from "../../pages/_app";
import { ChangelogListView } from "./ListView";

export const AppUpdate = () => {
  const [version, setVersion] = React.useState("");
  const [currentChange, setCurrentChange] = React.useState("");
  const [changes, setChanges] = React.useState<Array<String>>([]);

  const addUpdate = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const collection = Firestore.collection("changelog");
    if (changes.length > 0) {
      collection.add({
        update: version,
        changes: changes,
      });
      setVersion("");
      setChanges([]);
    }
  };

  const addChange = () => {
    const newChanges = changes;
    newChanges.push(currentChange);
    setChanges(newChanges);
    setCurrentChange("");
  };

  return (
    <div>
      <h1>Changelog</h1>
      <StyledForm onSubmit={addUpdate}>
        <input
          name="version"
          id="version"
          placeholder="Version"
          value={version}
          onChange={(e) => setVersion(e.target.value)}
          required
        />
        <input
          name="change"
          id="change"
          placeholder="Change"
          value={currentChange}
          onChange={(e) => setCurrentChange(e.target.value)}
        />
        <button type="button" onClick={addChange}>
          Add Change
        </button>
        <button type="submit">Submit</button>
      </StyledForm>
      <LowerSection>
        <div>
          <ChangelogListView />
        </div>
        <div>
          <h1>Changes to add</h1>
          {changes.map((change, i) => {
            return <p key={i}>- {change}</p>;
          })}
        </div>
      </LowerSection>
    </div>
  );
};

const StyledForm = styled.form`
  display: flex;
  flex-direction: column;
  max-width: 400px;
  margin: auto;
  input,
  button {
    padding: 5px 0;
    margin: 10px 0;
  }
`;

const LowerSection = styled.div`
  display: flex;
  width: 100%;
  justify-content: space-evenly;
`;
