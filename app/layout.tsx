"use client";
import type { Metadata } from "next";
import { Inter } from "next/font/google";
import { MoralisProvider } from "react-moralis";
import AppNavbar from "./components/AppNavbar";
import "./scss/layout.scss";
import "./scss/home.scss";
import "./scss/_base.scss";
import "./scss/_reset.scss";
const inter = Inter({ subsets: ["latin"] });

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className="layout">
      <body className={inter.className}>
        <MoralisProvider initializeOnMount={false}>
          <AppNavbar />
          {children}
        </MoralisProvider>
      </body>
    </html>
  );
}
