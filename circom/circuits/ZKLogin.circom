pragma circom 2.1.6;

include "./crypto/rsa_sha256.circom";
include "./jwt/claim_inclusion.circom";
include "./utils/concat.circom";
include "./utils/checknonce.circom";
include "./zk-email/circuits/lib/circomlib/circuits/poseidon.circom";


/// 1. This circuit verifies the JWT signature (RSA256) by given modulus.
/// 2. Ensure the encoded `iss`, `sub`, `aud`(the top 46 in plaintext), `nonce` is included in the JWT token.
/// 3. Base64 decode the `iss`, `sub`, `aud`, `nonce` fields into ascii numbers.
/// 4. Check `nonce` == Poseidon([pubkey, randomness, exp]).
/// 5. Output `iss`(top 32 characters), `aud`(top 44 characters)
/// 6. Compute and output the hash of `sub`(top 21 valid characters) and `salt`.
/// 7. Output the public input `pubkey`, `exp`.
///
/// Inputs:
/// - `jwt_segments`: Pad the JWT and split it into multiple segments to boost efficiency.
/// - `jwt_padded_bytes`: The length of the JWT after padding, currently defaulting to 1024.
/// - `iss`: Extract the base64 byte array of the `iss` field from the JWT and pad it to `MAX_ISS_BYTES`(48).
/// - `sub`: Extract the base64 byte array of the `sub` field from the JWT and pad it to `MAX_SUB_BYTES`(36)
/// - `aud`: Extract the base64 byte array of the `aud` field from the JWT, taking only the first `MAX_SUB_BYTES bytes`(64) in the array
/// - `nonce`: Extract the base64 byte array of the `nonce` field from the JWT and pad it to `MAX_NONCE_BYTES`(108).
/// - `exp`: Custom public input as a preimage of the `nonce`.
/// - `iss_loc`: The position of `iss` in the JWT.
/// - `sub_loc`: The position of `sub` in the JWT.
/// - `aud_loc`: The position of `aud` in the JWT.
/// - `nonce_loc`: The position of `nonce` in the JWT.
/// - `salt`: A custom salt, required to be a numeric string. Will be hashed with `sub`.
/// - `modulus`: Extract the JWT `kid` field in the header to apply to the Google API (https://www.googleapis.com/oauth2/v3/certs) for the public key to verify the JWT signature.
/// - `signature`: Convert the Base64-encoded JWT signature string to a BigInt array that can be processed by the Circom circuit.
/// - `pubkey`: Custom starknet public key of Bigint type. Will be hashed with `randomness` to verify `nonce`.
/// - `randomness`: Custom randomness, required to be a numeric string. Will be hashed with `pubkey` to verify `nonce`.
///
/// Outputs:
/// - `iss_out_ascii`: The ASCII code of the first 32 characters of the `iss` field. Except for the first three digits "200", each three digits represents an ASCII code.
/// - `aud_out_ascii`: The ASCII code of the first 44 characters of the `aud` field. Except for the first three digits "200", each three digits represents an ASCII code.
/// - `sub_salt_hash`: The Poseidon hash of the ascii code of the `sub`(top 21 valid characters) and the `salt`. The hash formula is: `sub_salt_hash` = Poseidon([sub_ascii[top 21 valid characters], salt, exp]).

template ZKLogin(
  iss_claim_bytes,
  sub_claim_bytes,
  aud_claim_bytes,
  nonce_claim_bytes,
  iss_bytes,
  sub_bytes,
  aud_bytes,
  nonce_bytes,
  jwt_chunk_size,
  chunk_count,
  n, k
){  
    // input signals
    signal input jwt_segments[chunk_count][jwt_chunk_size]; // split jwt into chunk_count chunks of jwt_chunk_size
    signal input jwt_padded_bytes; // length of the jwt including the padding

    signal input iss[iss_claim_bytes];//Iss(issuer), the plaintext length is tentatively set to 34
    signal input sub[sub_claim_bytes];//Sub(subject), the plaintext length is tentatively set to 25
    signal input aud[aud_claim_bytes];//Aud (audience), only reads the first 46 bits of the plaintext length
    signal input nonce[nonce_claim_bytes];//Nonce, the plaintext length is tentatively set to 79
    signal input exp;//exp(expiration time), custom inputs, public input
    signal input iss_loc;
    signal input sub_loc;
    signal input aud_loc;
    signal input nonce_loc;
    signal input salt;
    signal input modulus[k]; // jwt provider rsa pubkey
    signal input signature[k];

    signal input pubkey; // public input
    signal input randomness;

    // output signals
    signal output iss_out_ascii[2];//Output iss ascii
    signal output aud_out_ascii[2];//Temporarily output only the first 44 bits of aud ascii splicing to save constraints
    signal output sub_salt_hash;// sub_salt_hash = Poseidon([sub_ascii[top 21 valid characters], salt, exp])

    // 1. verify the signature
    component rsa_sha256 = RsaSha256(chunk_count, jwt_chunk_size, n, k);
    rsa_sha256.msg_padded_bytes <== jwt_padded_bytes;
    rsa_sha256.msg_segments <== jwt_segments;
    rsa_sha256.modulus <== modulus;
    rsa_sha256.signature <== signature;

    // 2. prove claims inclusions
    //-------------------------------------------
    // 2.1.1 iss_out has "iss_bytes" ascii numbers 
    signal iss_out[iss_bytes] <== ClaimInclusion(
      iss_claim_bytes, iss_bytes, jwt_chunk_size, chunk_count
    )(jwt_segments, iss, iss_loc);

    signal move_temp_iss[33];
    signal iss_num[32];
    signal isColon_iss_0 <== IsEqual()([iss_out[0],58]); //1 means equal, 0 means unequal
    signal isColon_iss_1 <== IsEqual()([iss_out[1],58]); //1 means equal, 0 means unequal
    signal isQuote_iss_0 <== IsEqual()([iss_out[0],34]); //1 means equal, 0 means unequal
    signal isQuote_iss_1 <== IsEqual()([iss_out[1],34]); //1 means equal, 0 means unequal

    component mux1_iss[33];
    component mux2_iss[32];
    for(var i = 0; i < 33; i++ ){
        mux1_iss[i] = Mux1(); 
        mux1_iss[i].c[0] <== iss_out[i];
        mux1_iss[i].c[1] <== iss_out[i+1];
        mux1_iss[i].s <== isColon_iss_0 + isQuote_iss_0; 
        move_temp_iss[i] <== mux1_iss[i].out;
    }
    for(var i = 0; i < 32; i++ ){
        mux2_iss[i] = Mux1(); 
        mux2_iss[i].c[0] <== move_temp_iss[i];
        mux2_iss[i].c[1] <== move_temp_iss[i+1];
        mux2_iss[i].s <== isColon_iss_1 + isQuote_iss_1; 
        iss_num[i] <== mux2_iss[i].out;
    }
    // At this time, `iss_num` stores the first 32 valid characters in `iss_out`.
    
    // 2.1.2 concat iss_out into two bignumber
    component concat_iss[2];
    concat_iss[0] = ConcatDigits(3, 17); //Set each ASCII to 3 bits and splice them together. So the first number must be three digits, manually set to 200
    concat_iss[1] = ConcatDigits(3, 17); 
    concat_iss[0].digits[0] <== 200;
    concat_iss[1].digits[0] <== 200;
    for (var i = 1; i < 17; i++) {
        concat_iss[0].digits[i] <== iss_num[i-1];//iss_out[0:16]
        concat_iss[1].digits[i] <== iss_num[i+15];//iss_out[16:32]
    }
    iss_out_ascii[0] <== concat_iss[0].result;
    iss_out_ascii[1] <== concat_iss[1].result;

    //-------------------------------------------
    // 2.2.1 sub_ascii has "sub_bytes" ascii numbers 
    signal sub_ascii[sub_bytes] <== ClaimInclusion(
      sub_claim_bytes, sub_bytes, jwt_chunk_size, chunk_count
    )(jwt_segments, sub, sub_loc);

    // 2.2.2 concat sub_ascii into bignumber, then hash them with salt
    // Since the same user needs to get the same sub, but cannot determine whether the first two digits of sub_ascii are numbers, we divide sub_ascii into the following three situations:
    // sub000               There are 0 useless characters in front of the text of sub
    // :sub00, "sub00       There are 1 useless characters in front of the text of sub
    // :"sub0               There are 2 useless characters in front of the text of sub
    // And construct the `move_temp_sub` and `sub_num` arrays through the logical judgment of `Mux1`. Among them, `move_temp_sub` is the array that can be moved forward at most once, and `sub_num` is the array that can be moved forward at most twice.
    // You can see that the lengths of move_temp_sub and sub_num are less than sub_bytes. This is to prevent out-of-bounds access when the array is moved forward.
    // The length of sub_num is move_temp_sub-1, which is also to prevent array out-of-bounds access when moving forward.
    signal move_temp_sub[22];
    signal sub_num[21];
    signal isColon_sub_0 <== IsEqual()([sub_ascii[0],58]); //1 means equal, 0 means unequal
    signal isColon_sub_1 <== IsEqual()([sub_ascii[1],58]); //1 means equal, 0 means unequal
    signal isQuote_sub_0 <== IsEqual()([sub_ascii[0],34]); //1 means equal, 0 means unequal
    signal isQuote_sub_1 <== IsEqual()([sub_ascii[1],34]); //1 means equal, 0 means unequal

    component mux1_sub[22];
    component mux2_sub[21];
    for(var i = 0; i < 22; i++ ){
        mux1_sub[i] = Mux1(); 
        mux1_sub[i].c[0] <== sub_ascii[i];
        mux1_sub[i].c[1] <== sub_ascii[i+1];
        mux1_sub[i].s <== isColon_sub_0 + isQuote_sub_0; 
        move_temp_sub[i] <== mux1_sub[i].out;
    }
    for(var i = 0; i < 21; i++ ){
        mux2_sub[i] = Mux1(); 
        mux2_sub[i].c[0] <== move_temp_sub[i];
        mux2_sub[i].c[1] <== move_temp_sub[i+1];
        mux2_sub[i].s <== isColon_sub_1 + isQuote_sub_1; 
        sub_num[i] <== mux2_sub[i].out;
    }
    // At this time, `sub_num` stores the first 21 valid characters in `sub_ascii`.
    signal concat_sub <== ConcatDigits(2, 21)(sub_num);
    // hash sub and salt
    component hash_2 = Poseidon(2);
    hash_2.inputs[0] <== concat_sub;
    hash_2.inputs[1] <== salt;
    sub_salt_hash <== hash_2.out;

    //-------------------------------------------
    // 2.3.1 aud_out has "aud_bytes" ascii numbers 
    signal aud_out[aud_bytes] <== ClaimInclusion(aud_claim_bytes, aud_bytes, jwt_chunk_size, chunk_count)(jwt_segments, aud, aud_loc);

    signal move_temp_aud[45];
    signal aud_num[44];
    signal isColon_aud_0 <== IsEqual()([aud_out[0],58]); //1 means equal, 0 means unequal
    signal isColon_aud_1 <== IsEqual()([aud_out[1],58]); //1 means equal, 0 means unequal
    signal isQuote_aud_0 <== IsEqual()([aud_out[0],34]); //1 means equal, 0 means unequal
    signal isQuote_aud_1 <== IsEqual()([aud_out[1],34]); //1 means equal, 0 means unequal

    component mux1_aud[45];
    component mux2_aud[44];
    for(var i = 0; i < 45; i++ ){
        mux1_aud[i] = Mux1(); 
        mux1_aud[i].c[0] <== aud_out[i];
        mux1_aud[i].c[1] <== aud_out[i+1];
        mux1_aud[i].s <== isColon_aud_0 + isQuote_aud_0; 
        move_temp_aud[i] <== mux1_aud[i].out;
    }
    for(var i = 0; i < 44; i++ ){
        mux2_aud[i] = Mux1(); 
        mux2_aud[i].c[0] <== move_temp_aud[i];
        mux2_aud[i].c[1] <== move_temp_aud[i+1];
        mux2_aud[i].s <== isColon_aud_1 + isQuote_aud_1; 
        aud_num[i] <== mux2_aud[i].out;
    }
    // At this time, `aud_num` stores the first 44 valid characters in `aud_out`.
    
    // 2.3.2 concat aud_out into two bignumber
    // for now, only the first 46 characters of aud ascii (which may include quotation marks and colons) is output to save constraints
    component concat_aud[2];
    concat_aud[0] = ConcatDigits(3, 23); //Set each ASCII to 3 bits and splice them together. So the first number must be three digits, manually set to 200
    concat_aud[1] = ConcatDigits(3, 23); 
    concat_aud[0].digits[0] <== 200;
    concat_aud[1].digits[0] <== 200;
    for (var i = 1; i < 23; i++) {
        concat_aud[0].digits[i] <== aud_num[i-1];//aud_out[0:22]
        concat_aud[1].digits[i] <== aud_num[i+21];//aud_out[22:44]
    }
    aud_out_ascii[0] <== concat_aud[0].result;
    aud_out_ascii[1] <== concat_aud[1].result;

    //-------------------------------------------
    // 2.4.1 nonce_out has "nonce_bytes" ascii numbers 
    signal nonce_out[nonce_bytes] <== ClaimInclusion(nonce_claim_bytes, nonce_bytes, jwt_chunk_size, chunk_count)(jwt_segments, nonce, nonce_loc);

    //2.4.2 verify nonce=H(pubkey, randomness)
    //1) Since it is impossible to determine whether the length of the nonce text is 76 or 77, only the first 76 character of the nonce text are taken for comparison, and then 10 77-digit numbers are obtained through algebraic operations for comparison.
    //2) Since it is impossible to determine whether there are colon or quotes in the first two characters, the nonce can be divided into the following three situations:
    // :"nonce            There are two useless characters in front of the text of nonce
    // :nonce, "nonce     There is a useless character in front of the text of nonce
    // nonce              There are no useless characters in front of the nonce text.
    component hash = Poseidon(3);
    hash.inputs[0] <== pubkey;
    hash.inputs[1] <== randomness;
    hash.inputs[2] <== exp;

    component checknonce[3];
    checknonce[0] = Ascii2Num_CheckNonce();
    checknonce[0].hash <== hash.out;
    for (var j = 0; j < 76; j++) {
        checknonce[0].nonce[j] <== nonce_out[j+2];
    }
    checknonce[1] = Ascii2Num_CheckNonce();
    checknonce[1].hash <== hash.out;
    for (var j = 0; j < 76; j++) {
        checknonce[1].nonce[j] <== nonce_out[j+1];
    }
    checknonce[2] = Ascii2Num_CheckNonce();
    checknonce[2].hash <== hash.out;
    for (var j = 0; j < 76; j++) {
        checknonce[2].nonce[j] <== nonce_out[j];
    }
    checknonce[0].out + checknonce[1].out + checknonce[2].out === 1;
}


component main{ public [pubkey, exp]} = ZKLogin(48, 36, 64, 108, 34, 25, 46, 79, 16, 64, 121, 17);
