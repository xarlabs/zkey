pragma circom 2.1.5;

include "./string.circom";
include "./sha256.circom";
include "./rsa.circom";
include "./snark-jwt-verify/bitify.circom";

/*
The circuit will verify a provided JWT. 
It will check the signature of the JWT using an RSA public key, and will output the masked claims of JWT.
(For now, the target output of this circuit is claim `exp` and `jti` of the JWT)
    
    Construction Parameters:
    - inCount:         Multiples of 512 to facilitate sha256 hashing
    - n:               The number of bits per RSA block
    - k:               The number of RSA blocks
    - outWidth:        Bit width of masked claim outputs
    - inWidth:         Bit width of payload inputs

    Inputs:
    - jwt[inCount]:  JWT's header and payload, padding with 0s to fit the inCount
    - signature[k]:    JWT's RSA signature
    - pubkey[k]:       JWT's RSA public key
    
    Outputs:
    - out[outCount]:   Masked claim(`exp` and `jti`)
*/
template JWTVerify(inCount, n, k, outWidth, inWidth) {
    assert(n * k > 2048); // constraints for 2048 bit RSA
    assert(n < (255 \ 2)); // we want a multiplication to fit into a circom signal

    assert((inCount * inWidth) % 512 == 0);
    assert(inWidth <= 512);
    assert(512 % inWidth == 0);
    
    var inBits = inCount * inWidth; // The total number of bits entered
    var outExtra = inBits % outWidth; // The number of extra bits in the output
    var outCount = (inBits - outExtra) / outWidth; // The number of output blocks needed
    if(outExtra > 0) {
        outCount += 1; // If there are extra bits, we need an additional output block
    }
    
    assert(inWidth <= outWidth);
    assert(outCount * outWidth >= inCount * inWidth);

    // Inputs
    signal input jwt[inCount];
    signal input signature[k];
    signal input pubkey[k];
    signal input mask[inCount];   
    // Outputs
    signal output out[outCount];


    // JWT hash
    signal sha[256] <== Sha256String(inCount)(jwt);

    var msg_len = (256 + n) \ n;

    component base_msg[msg_len];
    for (var i = 0; i < msg_len; i++) {
        base_msg[i] = Bits2Num(n);
    }
    for (var i = 0; i < 256; i++) {
        base_msg[i \ n].in[i % n] <== sha[255 - i];
    }
    for (var i = 256; i < n * msg_len; i++) {
        base_msg[i \ n].in[i % n] <== 0;
    }

    // Verify RSA signature
    component rsa = RSAVerify65537(n, k);
    for (var i = 0; i < msg_len; i++) {
        rsa.base_message[i] <== base_msg[i].out;
    }
    for (var i = msg_len; i < k; i++) {
        rsa.base_message[i] <== 0;
    }

    rsa.signature <== signature;
    rsa.modulus <== pubkey;


    // Output masked claims
    component masked[inCount];
    for(var i = 0; i < inCount; i++) {
        masked[i] = Num2BitsLE(inWidth);
        masked[i].in <== jwt[i] * mask[i];
    }
    
    component out_packer[outCount];
    for(var i = 0; i < outCount; i++) {
        out_packer[i] = Bits2NumLE(outWidth);
    }
    
    for(var i = 0; i < inBits; i++) {
        var oB = i % outWidth;        // Calculates the bit offset of the current bit in the output
        var o = (i - oB) / outWidth;  // Calculates which output block the current bit belongs to
        var m = (i - (i % inWidth)) / inWidth; // Calculates which masked component the current bit belongs to
        var mB = i % inWidth;        // Calculates the bit offset of the current bit in the masked component
        
        out_packer[o].in[oB] <== masked[m].out[mB];
    }
    
    for(var i = outExtra; i < outWidth; i++) {
        out_packer[outCount - 1].in[i] <== 0;
    }
    
    for(var i = 0; i < outCount; i++) {
        out[i] <== out_packer[i].out;
    }
}

component main  = JWTVerify(1024, 121, 17, 248, 8);