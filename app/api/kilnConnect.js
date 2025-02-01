import { Kiln } from "@kilnfi/sdk";

const k = new Kiln({
  baseUrl: "https://api.kiln.fi",
  apiToken: "kiln_DBmNa8Y4Eu7O1ZCx9QMdTS4fQckBnWOEuwEqw9IM",
});

const tx = await k.client.GET(
  "/v1/defi/network-stats?vaults=matic_0x66431b90985212d3b09e27ff9b83cb32f6dd79dc"
);

console.log("tx ->", tx.data);
