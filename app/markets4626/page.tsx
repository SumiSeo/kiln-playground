"use client";
import { useEffect } from "react";
import { getDataVaults } from "../api/kilnConnect";
import "../scss/Markets4626.scss";

export default function Markets4626() {
  useEffect(() => {
    const fetchData = async () => {
      try {
        const res = await getDataVaults();
        console.log("res", res);
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    };

    fetchData(); // Call the async function
  }, []); // Empty dependency array → runs once when component mounts;
  return (
    <div className="markets">
      <div>Markets4626</div>
    </div>
  );
}
