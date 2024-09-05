pragma circom 2.1.6;

include "../zk-email/circuits/lib/circomlib/circuits/comparators.circom";
include "../math/aggregation.circom";

// Given an array of N elements return the value at `index`
template AtIndex(N) {
  signal input array[N];
  signal input index;
  signal output out;

  component sum = Sum(N);

  for (var i = 0; i < N; i++) {
    var isEqual = IsEqual()([i, index]);
    sum.in[i] <== isEqual * array[i];
  }

  out <== sum.out;
}

template Slice(N, pad) {
  signal input arr[N];
  signal input start;
  signal input end;
  signal output out[N];

  // Require that start >= 0
  signal start_cond <== GreaterEqThan(10)([start, 0]);
  start_cond === 1;

  // Require that end < N
  signal end_cond <== LessThan(10)([end, N]);
  end_cond === 1;

  // Select the elements at the indexes between start and end, and 0-pad the rest
  signal selections[N];
  signal rangeChecks[N];
  signal pads[N];

  for(var i = 0; i < N; i++) {
    // Check that start + i < diff
    rangeChecks[i] <== LessThan(10)([start + i, end]);
    // Get the element at index: start + i
    selections[i] <== AtIndex(N)(arr, start + i);

    pads[i] <== (1 - rangeChecks[i]) * pad;

    // Set 0 to indexes outside the range. If inside the set the value at index taken from selections[i]
    out[i] <== selections[i] * rangeChecks[i] + pads[i];
  }
}

// Another version of slice where the input and output lens are not necesserily of the same length
template SliceWithVariableLen(inSize, outSize, pad) {
  signal input in[inSize];
  signal input offset;
  signal input length;
  
  signal output out[outSize];
  
  component selector[outSize];
  signal eqs[inSize][outSize];
  signal lt[outSize];
  signal mask[inSize][outSize];
  signal eqs_0[outSize];

  for(var i = 0; i < outSize; i++) {
    selector[i] = Sum(inSize);
    
    lt[i] <== LessThan(8)([i, length]);
    
    for(var j = 0; j < inSize; j++) {
      eqs[j][i] <== IsEqual()([j, offset + i]);
      mask[j][i] <== eqs[j][i] * lt[i];
      selector[i].in[j] <== mask[j][i] * in[j];
    }

    eqs_0[i] <== IsEqual()([selector[i].out, 0]);
    out[i] <== eqs_0[i] * pad + (1 - eqs_0[i]) * selector[i].out;
  }
}


template SliceFromStart(N, M) {
  signal input arr[N];
  signal output out[M];

  for(var i = 0; i < M; i++) {
    out[i] <== arr[i];
  }
}
