"use client";
import { useEffect, useState } from "react";
import { getDataVault1 } from "../api/kilnConnect";
import "../scss/Markets4626.scss";
import { DataGrid, GridColDef } from "@mui/x-data-grid";
import Paper from "@mui/material/Paper";

export default function Markets4626() {
  const [data1, setData1] = useState();
  const [rows, setRows] = useState();
  const columns: GridColDef[] = [
    { field: "vaultSymbol", headerName: "vault", width: 100 },
    { field: "vaultName", headerName: "vault name", width: 230 },
    {
      field: "vaultPriceUSD",
      headerName: "vault price usd",
      width: 230,
    },
  ];
  useEffect(() => {
    const fetchData = async () => {
      try {
        const res = await getDataVault1();
        const rawData = res?.data;
        const { data } = rawData;
        setData1(data[0]);
        // setRows.push(data[0]);
        console.log("data", data[0]);
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    };

    fetchData();
  }, []);
  return (
    <div className="markets">
      <div className="markets__title">Markets4626</div>
      <div className="markets__table">
        <Paper sx={{ height: 400, width: "70%" }}>
          <DataGrid
            rows={rows}
            columns={columns}
            pageSizeOptions={[5, 10]}
            sx={{ border: 0 }}
          />
        </Paper>
      </div>
    </div>
  );
}
