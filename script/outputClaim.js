const path = require("path");
const fs = require('fs');


const utils = require("./../src/js/utils");

(async () => {

  const outWidth = 248;

  fs.readFile('./../build/testJWT_verify/public.json', 'utf8', (err, data) => {
    if (err) {
      console.error('Error reading the file', err);
      return;
    }

    try {
      const parsedData = JSON.parse(data);
      console.log('Parsed Data:', parsedData);
      const bigintArray = parsedData.map(str => BigInt(str));
      const masked = utils.bigIntArray2Buffer(bigintArray, outWidth).toString();
      console.log("masked", masked);
      const claims = masked.split(/\x00+/).filter(e => e !== '').map(e => Buffer.from(e, 'base64').toString());
      console.log("claims", claims);
    }
    catch (parseErr) {
      console.error('Error parsing JSON', parseErr);
    }
  });
})();

