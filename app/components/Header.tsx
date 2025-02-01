"use client";

import { useMoralis } from "react-moralis";
import { useEffect } from "react";

export default function Header() {
  const { enableWeb3, account, isWeb3Enabled, Moralis, deactivateWeb3 } =
    useMoralis();
  useEffect(() => {
    if (isWeb3Enabled) return;
    if (typeof window !== "undefined")
      if (window.localStorage.getItem("connected")) {
        enableWeb3();
      }
  }, [isWeb3Enabled]);

  useEffect(() => {
    Moralis.onAccountChanged(() => {
      console.log("account changed");
      if (account == null) {
        window.localStorage.removeItem("connected");
        deactivateWeb3();
      }
    });
  }, []);
  return (
    <div>
      {account ? (
        <div>Connected to {account}! </div>
      ) : (
        <button
          onClick={async () => {
            await enableWeb3();
            if (typeof window !== "undefined")
              window.localStorage.setItem("connected", "inject");
          }}
        >
          connect
        </button>
      )}
    </div>
  );
}
