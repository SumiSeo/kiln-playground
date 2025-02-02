"use client";

import { useEffect } from "react";
import { useWeb3Contract } from "react-moralis";
import { abi, contractAddress } from "../constants";
import { useMoralis } from "react-moralis";

export default function Entrance() {
  const { chainId: chainIdHex, isWeb3Enabled } = useMoralis();
  const chainId = parseInt(chainIdHex);
  const raffleAddress =
    chainId in contractAddress ? contractAddress[chainId][0] : null;
  // const { data, error, runContractFunction } = useWeb3Contract({
  //   abi: abi,
  //   contractAddress: raffleAddress,
  //   functionName: "acceptAggrement",
  //   params:{},
  //   msgValue:
  // });

  const { runContractFunction: createAgreement } = useWeb3Contract({
    abi: abi,
    contractAddress: raffleAddress,
    functionName: "createAgreement",
    params: {},
  });

  useEffect(() => {
    console.log("abi", abi);
    console.log("contract", raffleAddress);
    if (isWeb3Enabled) {
      async function updateUI() {
        const something = await createAgreement();
        console.log("something", something);
      }
      updateUI();
    }
  }, [isWeb3Enabled]);

  return (
    <div>
      <button
        onClick={async function () {
          await createAgreement();
        }}
      >
        Enter raffle
      </button>
    </div>
  );
}
