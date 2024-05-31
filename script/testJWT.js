(async () => {
  const  {padString,toCircomBigIntBytes}  =require( './../src/index.js');
const fs =require ('fs');
  const jwksClient = require('jwks-rsa');
const jwt = require('jsonwebtoken');
const path =require( 'path');
const { pki }= require( 'node-forge');

// your test JWT
const token="eyJhbGciOiJSUzI1NiIsImtpZCI6IjY3MTk2NzgzNTFhNWZhZWRjMmU3MDI3NGJiZWE2MmRhMmE4YzRhMTIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIzMjQ0NzgwMDI5MjYtcGg4bG8wMWpvZjQzZGNyczNyazYyNnBtajl1bzQ4ODMuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIzMjQ0NzgwMDI5MjYtcGg4bG8wMWpvZjQzZGNyczNyazYyNnBtajl1bzQ4ODMuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTE2MTkwMDY1NTQzNTg5NzE2ODYiLCJlbWFpbCI6InZhcG9yc2hhd25uQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYmYiOjE3MTcwNDkzNTcsIm5hbWUiOiLkuJbmvYciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSkIwdWlzLVEtRklPazFabl83eHNRS25mVkROaHpzc2NDU1R5Q1Z6T2EwVm5BRHZ2az1zOTYtYyIsImdpdmVuX25hbWUiOiLkuJbmvYciLCJpYXQiOjE3MTcwNDk2NTcsImV4cCI6MTcxNzA1MzI1NywianRpIjoiNDJiYmUxMDRhNjFiMGY4NTM0NDMzZDYyMDdlMjM4MzVhMzcyZTFlOCJ9.FpjpQAo3_WhIo0TrkEFGVG3mTGEgB1Nqs_sMIm8XORu_H6212yfVohZjbkl9WDjpOHFi6Q-XFXXWHkYq9CRAG9nMvowSa7VYMkB8tP7b61zawElp_RAkPIm4hrhH97snZ3Fr8wapZd0TbIeQjgq8BJ3wx7xOhg6NkSR4jLzPyr_ffRvtBe5yhJP4Zt-Y2QikNN4suBp3obG89a9Rrk4P8IpZLzF8U73IPPy7xYFqRZXXjITExA1Rd7vohsRRfK_VkkVr3XKKS7RTW5rwJym3gkGlawTir5C-4E3zcnwmp2QLuZPde0HpXHlbWJUPAUDjY69aY8ojSTGj6N7MLUfk7w";

const client = jwksClient({
  rateLimit: true,
  jwksRequestsPerMinute: 10, // Default value
  jwksUri: 'https://www.googleapis.com/oauth2/v3/certs'
});


// 获取JWKS中的公钥
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

// 验证JWT
function verifyToken(token) {
  let signingKeyUsed = null; // 用于存储使用的签名密钥

  jwt.verify(token, (header, callback) => {
    getKey(header, (err, signingKey) => {
      if (!err) {
        signingKeyUsed = signingKey; // 存储签名密钥
      }
      callback(err, signingKey);
    });
  }, { algorithms: ['RS256'] }, (err, decoded) => {
    if (err) {
      console.log('Token verification failed:', err);
    } else {
      console.log('Token is valid:', decoded);
      console.log('Signing key used:', signingKeyUsed); // 在这里访问签名密钥

       // signature
       const jwtSignature =token.split('.')[2];
       const signatureBigInt = BigInt('0x' + Buffer.from(jwtSignature, 'base64').toString('hex'))
       // public key
       const publicKeyPem = signingKeyUsed;
 
       const pubKeyData = pki.publicKeyFromPem(publicKeyPem.toString())
       const pubkeyBigInt = BigInt(pubKeyData.n.toString())
      

       const lastDotIndex = token.lastIndexOf(".");

      // 提取从字符串开头到最后一个 "." 之前的所有字符
      const JWT_header_payload = token.substring(0, lastDotIndex);
       console.log("JWT_header_payload",JWT_header_payload);
       const input={
       jwt: padString(
        JWT_header_payload,1024
       ),
       jwt_header_payload_bytes: JWT_header_payload.length
       ,
       signature: toCircomBigIntBytes(signatureBigInt),
       pubkey: toCircomBigIntBytes(pubkeyBigInt),
       }
       console.log("input",input);


      //JSON序列化部分
      // 将对象转换为 JSON 字符串
      const jsonString = JSON.stringify(input, null, 2);

      // 将 JSON 字符串写入文件
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

verifyToken(token);
})();
