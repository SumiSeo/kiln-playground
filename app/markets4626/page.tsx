"use client";
import { useEffect, useState } from "react";
import { getDataVault1, getDataVault2 } from "../api/kilnConnect";
import "../scss/Markets4626.scss";
import { DataGrid, GridColDef } from "@mui/x-data-grid";
import Paper from "@mui/material/Paper";

export default function Markets4626() {
  const [data1, setData1] = useState();
  const [rows, setRows] = useState([]);
  const columns: GridColDef[] = [
    { field: "asset_symbol", headerName: "vault", width: 100 },
    { field: "protocol_display_name", headerName: "vault name", width: 230 },
    {
      field: "asset_price_usd",
      headerName: "vault price usd",
      width: 230,
    },
    {
      field: "chain",
      headerName: "chain",
      width: 230,
    },
    {
      field: "updated_at_block",
      headerName: "updated date",
      width: 230,
    },
  ];
  useEffect(() => {
    const fetchData = async () => {
      try {
        const res = await getDataVault1();
        const res2 = await getDataVault2();
        const rawData = res?.data;
        const rawData2 = res2?.data;
        const { data } = rawData;
        if (data?.length > 0) {
          const formattedData = { id: Date.now(), ...data[0] }; // Add a unique ID
          setData1(formattedData);
          setRows([{ id: Date.now(), ...data[0] }, ...rows]); // Ensure all rows have an ID
        }
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    };

    fetchData();
  }, []);
  return (
    <div className="markets">
      <div className="markets__title">Markets 4626</div>
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
