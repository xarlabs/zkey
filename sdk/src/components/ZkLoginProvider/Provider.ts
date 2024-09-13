"use client";
import React from "react";
import { IZkPrivate, IZkState, IZkDispatcher } from "./types";

export const ZkPrivateContext = React.createContext<IZkPrivate | null>(null);
export const ZkStateContext = React.createContext<IZkState | null>(null);
export const ZkDispatcherContext = React.createContext<IZkDispatcher | null>(null);

export function useZkPrivate() {
  const context = React.useContext(ZkPrivateContext);

  if (context === undefined) {
    throw new Error("useZkPrivate must be used within a ZkPrivateContext");
  }
  return context as IZkPrivate;
}

export function useZkState() {
  const context = React.useContext(ZkStateContext);

  if (context === undefined) {
    throw new Error("useZkState must be used within a ZkStateContext");
  }
  return context as IZkState;
}

export function useZkDispatcher() {
  const context = React.useContext(ZkDispatcherContext);
  if (context === undefined) {
    throw new Error("useZkyDispatcher must be used within a ZkDispatcherContext");
  }
  return context as IZkDispatcher;
}

export function useZkContext() {
  return [useZkState(), useZkDispatcher()];
}
