pragma circom 2.1.6;

include "../zk-email/circuits/lib/circomlib/circuits/bitify.circom";
include "../zk-email/circuits/lib/circomlib/circuits/comparators.circom";
include "../zk-email/circuits/lib/circomlib/circuits/mux1.circom";

template IntegerDivision(n) {
    // require max(a, b) < 2**n
    signal input a;
    signal input b;
    signal output c;
    assert (n < 253);
    assert (a < 2**n);
    assert (b < 2**n);

    var r = a;
    var d = b * 2**n;
    component b2n = Bits2Num(n);
    component lt[n];
    component mux[n];
    component mux1[n];

    for (var i = n - 1; i >= 0; i--) {
        lt[i] = LessThan(2*n);
        mux[i] = Mux1();
        mux1[i] = Mux1();
    }

    for (var i = n-1; i >= 0; i--) {
        lt[i].in[0] <== 2 * r;
        lt[i].in[1] <== d;

        mux[i].s <== lt[i].out;
        mux[i].c[0] <== 1;
        mux[i].c[1] <== 0;

        mux1[i].s <== lt[i].out;
        mux1[i].c[0] <== 2 * r - d;
        mux1[i].c[1] <== 2 * r;

        b2n.in[i] <== mux[i].out;
        r =  mux1[i].out;
    }
    c <== b2n.out;
}
