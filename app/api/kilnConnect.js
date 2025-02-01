import { Kiln } from "@kilnfi/sdk";
import "../scss/Markets4626.scss";

const k = new Kiln({
  baseUrl: "https://api.kiln.fi",
  apiToken: "kiln_DBmNa8Y4Eu7O1ZCx9QMdTS4fQckBnWOEuwEqw9IM",
  //testnet defi vault
  //apiToken: "kiln_hnQNjKOhEhFfLOEcOUJrgrtc2LGcgqUj4a6MoyAt",
});
export const getDataVaults = async () => {
  const options = {
    method: "GET",
  };

  return await k.client.GET("/v1/defi/stakes", options);
};

export const getDataEachVault = async () => {
  return await k.client.GET(
    "/v1/defi/network-stats?vaults=matic_0x66431b90985212d3b09e27ff9b83cb32f6dd79dc"
  );
};
