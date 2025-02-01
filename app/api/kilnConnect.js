import { Kiln } from "@kilnfi/sdk";
import "../scss/Markets4626.scss";

const k = new Kiln({
  baseUrl: "https://api.kiln.fi",
  apiToken: "kiln_DBmNa8Y4Eu7O1ZCx9QMdTS4fQckBnWOEuwEqw9IM",
  //testnet defi vault
  // apiToken: "kiln_hnQNjKOhEhFfLOEcOUJrgrtc2LGcgqUj4a6MoyAt",
});
export const getDataVaults = async () => {
  return await k.client.GET(
    "/v1/defi/stakes?vaults=matic_0x66431b90985212d3b09e27ff9b83cb32f6dd79dc"
  );
};

export const getDataVault1 = async () => {
  return await k.client.GET(
    "/v1/defi/network-stats?vaults=matic_0x66431b90985212d3b09e27ff9b83cb32f6dd79dc"
  );
};

export const getDataVault2 = async () => {
  return await k.client.GET(
    "/v1/defi/network-stats?vaults=matic_0x290f5566a5269a52ad70d01ac860456b3b964f01"
  );
};
export const getDataVault3 = async () => {
  return await k.client.GET(
    "/v1/defi/network-stats?vaults=matic_0x15dcc1978f68c5e0d7a298a65fcc879e2d673d43"
  );
};
export const getDataVault4 = async () => {
  return await k.client.GET(
    "/v1/defi/network-stats?vaults=matic_0xab3ac228cac84a8a1c855c3e08f869b65836c962"
  );
};
export const getDataVault5 = async () => {
  return await k.client.GET(
    "/v1/defi/network-stats?vaults=matic_0xdb8c962e8a39d3e82d3eaa8f477be90984c6dfe8"
  );
};