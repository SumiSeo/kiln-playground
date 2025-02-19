"use client";

import { useMoralis } from "react-moralis";
import { useEffect } from "react";

export default function Header() {
  const {
    enableWeb3,
    account,
    isWeb3Enabled,
    Moralis,
    deactivateWeb3,
    isWeb3EnableLoading,
  } = useMoralis();
  useEffect(() => {
    if (account != null) console.log(account);
    if (isWeb3Enabled) return;
    if (typeof window !== "undefined")
      if (window.localStorage.getItem("connected")) {
        enableWeb3();
      }
  }, [isWeb3Enabled]);

  useEffect(() => {
    Moralis.onAccountChanged(() => {
      console.log("account changed");
      if (account != null) console.log(account);

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
          disabled={isWeb3EnableLoading}
        >
          connect
        </button>
      )}
    </div>
  );
}
