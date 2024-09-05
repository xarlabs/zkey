pragma circom 2.1.6;

// The component will get a array of N elements where all elements will be 0 except for one.
// It will then run a Sum over all elements, essentially returning the value of that non-zero element.
template Sum(N) {
  signal input in[N];
  signal output out;

  signal outs[N];
  outs[0] <== in[0];

  for (var i = 1; i < N; i++) {
    outs[i] <== outs[i - 1] + in[i];
  }

  out <== outs[N - 1];
}
