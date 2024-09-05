pragma circom 2.1.6;

include "../zk-email/circuits/lib/circomlib/circuits/comparators.circom";
include "../utils/not_equal.circom";

// Find will return the exact same index for the same array. If we want to search for multiple occurences of the same item
// then we would need to change that value slightly so it doesn't get caught by the Find circuit
template IncrementValue(N) {
  signal input in[N];
  signal input index;
  signal output out[N];

  signal eq[N];

  for (var i = 0; i < N; i++) {
		eq[i] = IsEqual()([i, index]);

    // increment the value at Index if i == index
		out[i] <== in[i] + eq[i];
	}
}

/// Returns the index of the first item found in this array
template Find(N) {
  signal input in[N];
  signal input match;
  
  signal match_index[N + 1];
  match_index[0] <== N;

  signal eq[N];

  for (var i = 0; i < N; i++) {
    var rev_index = N - i - 1;

    eq[i] <== IsEqual()([in[i], match]);
    match_index[i + 1] <== match_index[i] + eq[i] * (rev_index - match_index[i]);
  }

  signal output index <== match_index[N];
}

/// Same purpose as IncrementValue but we don't increment rather we set the element to value 0
template NullifyElementAtIndex(N) {
  signal input in[N];
  signal input index;
  signal output out[N];

  signal eq[N];

  for (var i = 0; i < N; i++) {
		eq[i] <== IsEqual()([i, index]);

    // set value to 0 at index
		out[i] <== (1 - eq[i]) * in[i];
	}
}

/// Similar to Find but match is any value except for 0s
template FindNonZero(N) {
  signal input in[N];
  
  signal match_index[N + 1];
  signal match_value[N + 1];

  match_index[0] <== N;
  match_value[0] <== 0;

  signal eq[N];

  for (var i = 0; i < N; i++) {
    var rev_index = N - i - 1;

    eq[i] <== NotEqual()([in[rev_index], 0]);
    match_index[i + 1] <== match_index[i] + eq[i] * (rev_index - match_index[i]);
    match_value[i + 1] <== match_value[i] + eq[i] * (in[rev_index] - match_value[i]);
  }

  signal output value <== match_value[N];
  signal output index <== match_index[N];
}

