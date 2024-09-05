pragma circom 2.1.6;

//If isin_range is 1, it means that the input value is in the range [48, 57]
//If isin_range is 0, it means that the input value is not in the range [48, 57]
template IsInRange() {
    signal input in;
    signal output isin_range;

    //Check value >= 48
    component ge = GreaterEqThan(8);//Output 1 proves that in[0] is greater than or equal to in[1]
    ge.in[0] <== in;
    ge.in[1] <== 48;

    //Check value <= 57
    component le = LessEqThan(8);//Output 1 proves that in[0] is less than or equal to in[1]
    le.in[0] <== in;
    le.in[1] <== 57;

    //isin_range is the logical AND of ge.out and le.out
    isin_range <== ge.out * le.out;
}