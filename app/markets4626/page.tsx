"use client";
import { useEffect } from "react";
import { getData } from "../api/kilnConnect";

export default function Markets4626() {
  useEffect(() => {
    const fetchData = async () => {
      try {
        const res = await getData();
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
