import { useEffect } from "react";

const IosRedirect = () => {
  useEffect(() => {
    window.location.assign(
      "https://apps.apple.com/us/app/acc-fuel-calculator/id1540153714?itsct=apps_box&amp;itscg=30200"
    );
  });
  return <></>;
};

export default IosRedirect;
