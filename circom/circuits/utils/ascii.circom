pragma circom 2.1.6;


// template AsciiToNum (max_input) {//Wrong
//   signal input in[max_input];
//   signal output out;

//   signal temp[max_input][2];
//   signal multiplier <== 10;
//   temp[0][0] <== in[0] - 48;

//   for (var i = 1; i < max_input; i++) {
//     temp[i][0] <== temp[i - 1][0] * 10;
//     temp[i][1] <== temp[i][0] + in[i] - 48;
//   }

//   out <== temp[max_input - 1][1];
// }

// only converts ascii to numbers from 0-9
// for now, this circuit seems don't need to handle negative numbers
// Out-of-range values are not considered, as the witness cannot pass.
template AsciiToNum (max_input) {
  signal input in[max_input];
  signal output out;

  signal temp[max_input];
  temp[0] <== in[0] - 48;

  for (var i = 1; i < max_input; i++) {
    temp[i] <== temp[i - 1] * 10 + in[i] - 48;
  }

  out <== temp[max_input - 1];
}
