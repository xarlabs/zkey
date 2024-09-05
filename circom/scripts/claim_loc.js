const assert = require("assert");

const toByteArray = (str) => {
  let utf8Encode = new TextEncoder();
  return utf8Encode.encode(str)
}

const findClaimLocation = (jwt, claim, max) => {
  const jwtBytes = toByteArray(jwt);

  let clean_test = btoa(claim).replaceAll("=", "");//0
  let quote_at_0_index = btoa(`"${claim}`).replaceAll("=", "");//1
  let colon_at_0_index = btoa(`:${claim}`).replaceAll("=", "");//1
  let quote_and_colon_at_start = btoa(`":${claim}`).replaceAll("=", "");//2
  let colon_and_quote_at_start = btoa(`:"${claim}`).replaceAll("=", "");//2
  let comma_at_the_end = btoa(`${claim},`).replaceAll("=", "");//0
  let quote_at_start_and_end = btoa(`"${claim}"`).replaceAll("=", "");//1
  let quote_and_comma_at_end = btoa(`${claim}",`).replaceAll("=", "");//0
  let comma_and_quote_at_end = btoa(`${claim},"`).replaceAll("=", "");//0
  let colon_at_start_and_comma_at_end =  btoa(`:${claim},`).replaceAll("=", "");//1
  let colon_and_quote_at_start_quote_at_end = btoa(`:"${claim}"`).replaceAll("=", "");//2
  const versions = [
    clean_test, quote_at_0_index, colon_at_0_index, quote_and_colon_at_start, colon_and_quote_at_start, comma_at_the_end,
    quote_at_start_and_end, quote_and_comma_at_end, comma_and_quote_at_end, colon_at_start_and_comma_at_end, colon_and_quote_at_start_quote_at_end,
  ];

  let claimLocation;
  let version = 0;
  
  for (let i = 0; i < versions.length; i++) {
    if(jwt.indexOf(versions[i]) !== -1) {
      claimLocation = jwt.indexOf(versions[i]);
      version = versions[i];
      console.log("i:",i);
      console.log("claim",claim);
      break;
    }
  }

  let claimBytes = toByteArray(version);
  console.log("version:",version);
  console.log("claimBytes:",claimBytes);
  for (let i = claimLocation, j = 0; i < claimLocation + claimBytes.length; i++, j++) {
    assert(jwtBytes[i] === claimBytes[j]);
  }

  const len = claimBytes.length;
  if (len <= max) {
    claimBytes = [...claimBytes, ...new Array(Math.max(max - len, 0)).fill(0)];

  }else{
    claimBytes = Array.from(claimBytes.slice(0, max));
  }

  return [claimBytes.map(v => v.toString()), claimLocation]
}

module.exports = {findClaimLocation};
