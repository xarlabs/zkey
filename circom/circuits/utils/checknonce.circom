pragma circom 2.1.6;
include "./ascii.circom";

template Ascii2Num_CheckNonce() {
    signal input nonce[76];
    signal input hash;
    signal output out;//If out is 1, the nonce is equal to the first 76 characters of the hash

    component Ascii2Num = AsciiToNum(76);
      Ascii2Num.in <== nonce;
 
    log(hash);
    log(Ascii2Num.out);
    //The first 76 numbers of hash and Ascii2Num.out are equal, but we don’t know how many digits the hash has, so we can only judge by looping
    component equal[11];
    
    signal isEqual[11];
    equal[10] = IsEqual(); //1 means equal, 0 means unequal
    equal[10].in[0] <== hash;
    equal[10].in[1] <== Ascii2Num.out;
    isEqual[0] <== equal[10].out;
    for(var i = 0; i < 10; i++) {
      equal[i] = IsEqual(); //1 means equal, 0 means unequal
      equal[i].in[0] <== hash;
      equal[i].in[1] <== Ascii2Num.out*10+i;
      isEqual[i+1] <== isEqual[i] + equal[i].out;
    }
    out <== isEqual[10];
}