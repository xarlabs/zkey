const fs = require('fs');
const atob = require('atob');

// JWT Token
const jwtToken = "";

// spilt JWT: header, payload, signature
const [header, payload, signature] = jwtToken.split('.');

// decode payload
const decodedPayload = JSON.parse(atob(payload));

// extract claims
const data = {
  jwt: `${header}.${payload}`,
  sig: signature,
  iss: decodedPayload.iss,
  sub: decodedPayload.sub,
  aud: decodedPayload.aud,
  nonce: decodedPayload.nonce,
  // exp: decodedPayload.exp.toString(),
};

// write into data.json
fs.writeFileSync(`${__dirname}/data.json`, JSON.stringify(data, null, 2));

console.log("data.json Done!");