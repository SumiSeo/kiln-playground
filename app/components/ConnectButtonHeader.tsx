"use client";

import { ConnectButton } from "web3uikit";

export default function ConnectButtonHeader() {
  return (
    <div>
      <ConnectButton moralisAuth={false} />
    </div>
  );
}
