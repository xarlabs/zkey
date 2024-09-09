"use client";
import React from "react";
import { IZkState } from "./types";

export const ZkStateContext = React.createContext<IZkState | null>(null);
export const ZkDispatcherContext = React.createContext(null);

export function useZkState() {
  const context = React.useContext(ZkStateContext);

  if (context === undefined) {
    throw new Error("useZkState must be used within a ZkStateContext");
  }
  return context;
}

export function useZkDispatcher() {
  const context = React.useContext(ZkDispatcherContext);
  if (context === undefined) {
    throw new Error("useZkyDispatcher must be used within a ZkDispatcherContext");
  }
  return context;
}

export function useZkContext() {
  return [useZkState(), useZkDispatcher()];
}
