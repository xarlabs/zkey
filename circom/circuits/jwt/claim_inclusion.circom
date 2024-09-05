pragma circom 2.1.6;

include "./claim_verifier.circom";
include "./jwt_slice.circom";

template ClaimInclusion(
  max_claim_bytes,
  max_claim_json_bytes,
  jwt_chunk_size,
  chunk_count
) {
  signal input jwt_segments[chunk_count][jwt_chunk_size];//整个JWT
  signal input claim[max_claim_bytes];//需要验证的claim的 Base64 编码值的ascii
  signal input claim_loc;//声明在 JWT 中的起始位置
  signal output out[max_claim_json_bytes];//解码后的声明值

  var claim_slice_len = jwt_chunk_size * 8;
  signal claim_slice[claim_slice_len];
  signal claim_first_segment;
  // JwtSlice 提取包含claim的 JWT 段，并返回该段，以及claim的第一个段的索引
  (claim_slice, claim_first_segment) <== JwtSlice(chunk_count, jwt_chunk_size)(jwt_segments, claim_loc, claim_loc + jwt_chunk_size);

  // ClaimVerifier 验证claim是否包含在 JWT 切片中，并解码该claim
  component claim_verifier = ClaimVerifier(max_claim_bytes, max_claim_json_bytes, claim_slice_len);
  claim_verifier.jwt <== claim_slice;
  claim_verifier.claim <== claim;
  claim_verifier.claim_loc <== claim_loc - (claim_first_segment * jwt_chunk_size); // i.e. claim_loc % jwt_chunk_size

  out <== claim_verifier.out;
}
