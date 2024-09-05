pragma circom 2.1.6;

/// This is the character that will be used to fill the remaining characters of the byte array we want to encode/decode
/// This is a value that we know does not exist in ASCII not in base64 look up tables.
/// Base64 uses 7 bits thus the largest ascii code is 127.
function null_char() {
  return 128;
}

function colon_ascii() {
  return 58;
}

function quote_ascii() {
  return 34;
}

function comma_ascii() {
  return 44;
}
