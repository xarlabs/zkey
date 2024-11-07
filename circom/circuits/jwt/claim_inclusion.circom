pragma circom 2.1.6;

include "./claim_verifier.circom";
include "./jwt_slice.circom";

template ClaimInclusion(
  max_claim_bytes,
  max_claim_json_bytes,
  jwt_chunk_size,
  chunk_count
) {
  signal input jwt_segments[chunk_count][jwt_chunk_size];
  signal input claim[max_claim_bytes];
  signal input claim_loc;
  signal output out[max_claim_json_bytes];

  var claim_slice_len = jwt_chunk_size * 8;
  signal claim_slice[claim_slice_len];
  signal claim_first_segment;
  (claim_slice, claim_first_segment) <== JwtSlice(chunk_count, jwt_chunk_size)(jwt_segments, claim_loc, claim_loc + jwt_chunk_size);
  component claim_verifier = ClaimVerifier(max_claim_bytes, max_claim_json_bytes, claim_slice_len);
  claim_verifier.jwt <== claim_slice;
  claim_verifier.claim <== claim;
  claim_verifier.claim_loc <== claim_loc - (claim_first_segment * jwt_chunk_size); 

  out <== claim_verifier.out;
}
