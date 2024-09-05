pragma circom 2.1.6;

include "../zk-email/circuits/lib/circomlib/circuits/comparators.circom";
include "../math/integer_div.circom";
include "../math/aggregation.circom";

template SegmentSearch(chunk_count, jwt_chunk_size) {
  signal input jwt_segments[chunk_count][jwt_chunk_size];
  signal input segment_index;
  signal output out[jwt_chunk_size];

  signal is_eq[chunk_count];
  for(var i = 0; i < chunk_count; i++) {
    is_eq[i] <== IsEqual()([segment_index, i]);
  }

  signal sum[jwt_chunk_size][chunk_count];
  for(var i = 0; i < jwt_chunk_size; i++) {
    for(var j = 0; j < chunk_count; j++) {
      sum[i][j] <== is_eq[j] * jwt_segments[j][i];
    }

    out[i] <== Sum(chunk_count)(sum[i]);
  }
}

template ConcatJwtSegments(jwt_chunk_size) {
  signal input segment_1[jwt_chunk_size];
  signal input segment_2[jwt_chunk_size];

  signal output out[jwt_chunk_size * 2];

  // Note that the two segments might be the same a thus the concated output will essentially have the same slice twice
  // Our output has to have jwt_chunk_size * 2 length since we can have values that might span two such segments. And since
  // the final length must be a fixed value we have to copy the same values twice if start_index_segment == end_index_segment
  for(var i = 0; i < jwt_chunk_size; i++) {
    out[i] <== segment_1[i];
    out[i + jwt_chunk_size] <== segment_2[i];
  }
}

/// For optimization reasons we split the jwt into 10 smaller parts each having one segment of. These
/// parts are in the order as the bytes appear in the origin JWT byte array.
/// This circuit will accept all jwt segments, as well as, the start index and end index that correspons to the
/// original single JWT byte array. It will then decide which two segments to merge into one. Our circuits works with
/// base64 encoded values of max length `jwt_chunk_size` which most likely be 100. So we know that the encoded value
/// will at most span across 2 of the below segments.
template JwtSlice(chunk_count, jwt_chunk_size) {
  signal input jwt_segments[chunk_count][jwt_chunk_size];
  signal input start;
  signal input end;

  signal output out[jwt_chunk_size * 8];
  signal output first_segment_index;

  first_segment_index <== IntegerDivision(10)(start, jwt_chunk_size);

  /// Find the two segments
  signal segment_1[jwt_chunk_size] <== SegmentSearch(chunk_count, jwt_chunk_size)(jwt_segments, first_segment_index);
  signal segment_2[jwt_chunk_size] <== SegmentSearch(chunk_count, jwt_chunk_size)(jwt_segments, first_segment_index + 1);
  signal segment_3[jwt_chunk_size] <== SegmentSearch(chunk_count, jwt_chunk_size)(jwt_segments, first_segment_index + 2);
  signal segment_4[jwt_chunk_size] <== SegmentSearch(chunk_count, jwt_chunk_size)(jwt_segments, first_segment_index + 3);
  signal segment_5[jwt_chunk_size] <== SegmentSearch(chunk_count, jwt_chunk_size)(jwt_segments, first_segment_index + 4);
  signal segment_6[jwt_chunk_size] <== SegmentSearch(chunk_count, jwt_chunk_size)(jwt_segments, first_segment_index + 5);
  signal segment_7[jwt_chunk_size] <== SegmentSearch(chunk_count, jwt_chunk_size)(jwt_segments, first_segment_index + 6);
  signal segment_8[jwt_chunk_size] <== SegmentSearch(chunk_count, jwt_chunk_size)(jwt_segments, first_segment_index + 7);

  signal seg_1_2[jwt_chunk_size * 2] <== ConcatJwtSegments(jwt_chunk_size)(segment_1, segment_2);
  signal seg_3_4[jwt_chunk_size * 2] <== ConcatJwtSegments(jwt_chunk_size)(segment_3, segment_4);
  signal seg_5_6[jwt_chunk_size * 2] <== ConcatJwtSegments(jwt_chunk_size)(segment_5, segment_6);
  signal seg_7_8[jwt_chunk_size * 2] <== ConcatJwtSegments(jwt_chunk_size)(segment_7, segment_8);
  signal seg_1_2_3_4[jwt_chunk_size * 4] <== ConcatJwtSegments(jwt_chunk_size * 2)(seg_1_2, seg_3_4);
  signal seg_5_6_7_8[jwt_chunk_size * 4] <== ConcatJwtSegments(jwt_chunk_size * 2)(seg_5_6, seg_7_8);

  out <== ConcatJwtSegments(jwt_chunk_size * 4)(seg_1_2_3_4, seg_5_6_7_8);
}
