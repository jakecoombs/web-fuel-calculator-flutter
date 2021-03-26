import { LatestUpdate } from "../../components/changelog/Latest";
import { ChangelogListView } from "../../components/changelog/ListView";
import { Wrapper } from "../../components/Wrapper";

const Changelog = () => {
  return (
    <Wrapper>
      <LatestUpdate />
      <ChangelogListView />
    </Wrapper>
  );
};

export default Changelog;
