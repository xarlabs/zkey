import React from "react";

export const WalletStateContext = React.createContext(null);
export const WalletDispatcherContext = React.createContext(null);

export function useWalletState() {
  const context = React.useContext(WalletStateContext);

  if (context === undefined) {
    throw new Error("useWalletState must be used within a WalletStateContext");
  }
  return context;
}

export function useWalletDispatcher() {
  const context = React.useContext(WalletDispatcherContext);
  if (context === undefined) {
    throw new Error("useWalletDispatcher must be used within a WalletDispatcherContext");
  }
  return context;
}

export function useWalletContext() {
  return [useWalletState(), useWalletDispatcher()];
}
