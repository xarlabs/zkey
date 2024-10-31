pragma circom 2.1.6;

include "../zk-email/circuits/lib/circomlib/circuits/comparators.circom";

/// Returns  1 if the two input values are not equal else 0
template NotEqual() {
  signal input in[2];
  signal output out;
  signal is_zero <== IsZero()(in[0] - in[1]);

  out <== -1 * is_zero + 1;
}
