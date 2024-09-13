"use client";

import React, { useMemo } from "react";
import { GoogleOAuthProvider, GoogleLogin, CredentialResponse } from "@react-oauth/google";
import { useZkPrivate, useZkState } from "@/components/ZkLoginProvider/Provider";

import { IUserInfo } from "@/components/ZkLoginProvider/types";
import { IGoogleLoginProps } from "./types";

const GoogleLoginButton = (props: IGoogleLoginProps) => {
  const { clientId, userContent, loadingContent } = props;

  const { nonce, handleLogIn } = useZkPrivate();

  const { userInfo, globalAccount } = useZkState();
  const loginSuccess = async (res: CredentialResponse) => {
    handleLogIn(res.credential as string);
  };

  const userInfoNode: React.ReactNode = useMemo(() => {
    let node: React.ReactNode = null;
    if (typeof userContent === "function" || typeof userContent === "undefined") {
      node = <div>username : {userInfo?.name}</div>;
      if (typeof userContent === "function") {
        node = userContent(userInfo as IUserInfo);
      }
    } else {
      node = userContent;
    }
    return node;
  }, [userInfo, userContent]);

  const loadingNode: React.ReactNode = useMemo(() => {
    let node: React.ReactNode = null;
    if (typeof loadingContent === "function" || typeof loadingContent === "undefined") {
      node = <div>loading</div>;
      if (typeof loadingContent === "function") {
        node = loadingContent();
      }
    } else {
      node = loadingContent;
    }
    return node;
  }, [loadingContent]);

  return (
    <>
      {globalAccount && userInfo ? (
        <> {userInfoNode}</>
      ) : nonce ? (
        <GoogleOAuthProvider clientId={clientId}>
          <GoogleLogin
            onSuccess={(credentialResponse: CredentialResponse) => loginSuccess(credentialResponse)}
            logo_alignment='center'
            shape='circle'
            width='100%'
            onError={() => {
              console.log("Login Failed");
            }}
            nonce={nonce}
          />
        </GoogleOAuthProvider>
      ) : (
        <> {loadingNode}</>
      )}
    </>
  );
};

export default GoogleLoginButton;
