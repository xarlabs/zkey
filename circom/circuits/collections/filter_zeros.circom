pragma circom 2.1.6;

include "../zk-email/circuits/lib/circomlib/circuits/comparators.circom";
include "./Find.circom";

/// Filters all zeros from the given array. It moves them to the back of the out array. Similar to Filter but more
/// more specific version where match is every other value except for 0s
template FilterZeros(N) {
  signal input in[N];
  signal output out[N];

  signal index_check[N];
  component find_non_zero[N];
  component nullify[N];

  for (var i = 0; i < N; i++) {
    find_non_zero[i] = FindNonZero(N);

    if (i == 0) {
      find_non_zero[i].in <== in;
    } else {
      find_non_zero[i].in <== nullify[i - 1].out;
    }

    index_check[i] <== LessThan(8)([find_non_zero[i].index, N]);
    out[i] <== find_non_zero[i].value * index_check[i];

    // exclude found element by nullifyeamenting its value
    nullify[i] = NullifyElementAtIndex(N);

    // same logic like what we did above with find
    if (i == 0) {		
      nullify[i].in <== in;
    } else {
      nullify[i].in <== nullify[i - 1].out;			
    }

    // if nothing found then find[i].index will be N so nullify will simply run it's tuple and do nothin i.e. noop
    nullify[i].index <== find_non_zero[i].index;
  }
}
