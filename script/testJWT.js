(async () => {
  const { padString, toCircomBigIntBytes } = require('./../src/index.js');
  const fs = require('fs');
  const jwksClient = require('jwks-rsa');
  const jwt = require('jsonwebtoken');
  const { pki } = require('node-forge');
  const circuit = require("./../src/js/circuit");

  // your test JWT
  const token = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjY3NGRiYmE4ZmFlZTY5YWNhZTFiYzFiZTE5MDQ1MzY3OGY0NzI4MDMiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIzMjQ0NzgwMDI5MjYtcGg4bG8wMWpvZjQzZGNyczNyazYyNnBtajl1bzQ4ODMuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIzMjQ0NzgwMDI5MjYtcGg4bG8wMWpvZjQzZGNyczNyazYyNnBtajl1bzQ4ODMuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTE2MTkwMDY1NTQzNTg5NzE2ODYiLCJlbWFpbCI6InZhcG9yc2hhd25uQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYmYiOjE3MTczOTg2NjUsIm5hbWUiOiLkuJbmvYciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSkIwdWlzLVEtRklPazFabl83eHNRS25mVkROaHpzc2NDU1R5Q1Z6T2EwVm5BRHZ2az1zOTYtYyIsImdpdmVuX25hbWUiOiLkuJbmvYciLCJpYXQiOjE3MTczOTg5NjUsImV4cCI6MTcxNzQwMjU2NSwianRpIjoiYTA5NGEzMjY0ZmJmMTJmZDk2ZTFkZjZkODFiZmFlZjg3NDY5NWVmYyJ9.Cj0NnR_DMCKLyn7-HrhRMm08f9J8mSBkVvdD8U0KYg8e793p71ACJo3oYyZtG-CIpm0ceW3474_Kge86yXiqs550hjb-UPQM9yrn_RcJxpIR4ogGnuC-DwIo3x4q6HDX3S9G-m4aAvZS6EUopKa6gOECyJRCZ8XMmEqWoqFNknfNfXnDhcPhFJxwUMTjlm1imYyjIx1x9GJpZ3a34VrtM26XuZWXscIRCKPC-ismhvHLfGe44ydYa2JgAsyv6Cw9KEfL9hazpxfMmTkF_c5xXumB-V2LBknElKOXKU7mp2j6QgJ3ZMjc2kU1e5i6v1qOLRnmmSs62snutKYABnoCrQ";
  const inCount = 1024;

  const client = jwksClient({
    rateLimit: true,
    jwksRequestsPerMinute: 10, // Default value
    jwksUri: 'https://www.googleapis.com/oauth2/v3/certs'
  });


  //Get the public key in jwks
  function getKey(header, callback) {
    client.getSigningKey(header.kid, (err, key) => {
      if (err) {
        callback(err, null);
      } else {
        const signingKey = key.getPublicKey();
        callback(null, signingKey);
      }
    });
  }

  // Construct circuit input
  function construct_Input(token) {
    let signingKeyUsed = null;

    jwt.verify(token, (header, callback) => {
      getKey(header, (err, signingKey) => {
        if (!err) {
          signingKeyUsed = signingKey;
        }
        callback(err, signingKey);
      });
    }, { algorithms: ['RS256'] }, (err, decoded) => {
      if (err) {
        console.log('Token verification failed:', err);
      } else {
        console.log('Token is valid:', decoded);
        console.log('Signing key used:', signingKeyUsed);
        // signature
        const jwtSignature = token.split('.')[2];
        const signatureBigInt = BigInt('0x' + Buffer.from(jwtSignature, 'base64').toString('hex'))
        // public key
        const publicKeyPem = signingKeyUsed;

        const pubKeyData = pki.publicKeyFromPem(publicKeyPem.toString())
        const pubkeyBigInt = BigInt(pubKeyData.n.toString())


        const lastDotIndex = token.lastIndexOf(".");

        // Extract all characters from the beginning of the string to the last "."
        const JWT_header_payload = token.substring(0, lastDotIndex);
        console.log("JWT_header_payload", JWT_header_payload);
        const input = {
          jwt: padString(
            JWT_header_payload, inCount
          ).map(num => num.toString()),
          signature: toCircomBigIntBytes(signatureBigInt),
          pubkey: toCircomBigIntBytes(pubkeyBigInt),
          mask: circuit.genJwtMask(JWT_header_payload, ["exp", "jti"]).concat(Array(inCount - JWT_header_payload.length).fill(0)).map(num => num.toString())
        }
        console.log("input", input);

        const jsonString = JSON.stringify(input, null, 2);

        fs.writeFile('./../shell/testJWT_verify.json', jsonString, 'utf8', (err) => {
          if (err) {
            console.error('Error writing to file', err);
          } else {
            console.log('Successfully wrote to output.json');
          }
        });
      }
    });
  }

  construct_Input(token);
})();
