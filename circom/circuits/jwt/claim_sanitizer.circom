pragma circom 2.1.6;

include "../zk-email/circuits/lib/circomlib/circuits/comparators.circom";
include "../utils/constants.circom";
include "../collections/filter_zeros.circom";

/// A claim when decoded might include some characters either at the start or end (or both).
/// The set includes the following characters: [:, ", ','] and they can be located at the following positions
/// 1. two at the front i.e. indexes 0, 1 i.e. :"
/// 2. two at the end i.e. indexes len - 1, len - 2. For example ," or ",
/// 3. one at the beginning 0 and one at the end len - 1. For example " and " or : and , at the end
/// 4. only one comma at the end
/// 5. only one colon at the start
///
/// This template will remove those character from the given claim but it will make sure that it removes
/// the characters only if they are located at the aforementioned positions.
template ClaimSanitizer(max_claim_json_bytes) {
  signal input claim[max_claim_json_bytes];
  signal output out[max_claim_json_bytes];

  signal colon_at_0_index <== IsEqual()([claim[0], colon_ascii()]);
  signal quote_at_0_index <== IsEqual()([claim[0], quote_ascii()]);
  signal quote_at_1_index <== IsEqual()([claim[1], quote_ascii()]);
  signal comma_at_last_index <== IsEqual()([claim[max_claim_json_bytes - 1], comma_ascii()]);
  signal quote_at_last_index <== IsEqual()([claim[max_claim_json_bytes - 1], quote_ascii()]);
  signal comma_before_last_index <== IsEqual()([claim[max_claim_json_bytes - 2], comma_ascii()]);
  signal quote_before_last_index <== IsEqual()([claim[max_claim_json_bytes - 2], quote_ascii()]);

  // the sum below will be result at most to a value of 1 because the operands are mutually exlusive
  // e.g. we cannot have two different characters at the start
  signal remove_first_index <== colon_at_0_index + quote_at_0_index;
  signal remove_last_index <== comma_at_last_index + quote_at_last_index;
  signal remote_before_last_index <== comma_before_last_index + quote_before_last_index;
  

  /// add 1 to the indexes we want to keep and 0 to those we want to remove
  signal mask[max_claim_json_bytes];

  // here we basically revert the 1 to 0 and 0 to 1. For example if we have to remove the first index
  // then remove_first_index will be 1 but in the mask we want that index to be 0.
  mask[0] <== IsEqual()([remove_first_index, 0]);
  mask[1] <== IsEqual()([quote_at_1_index, 0]);
  mask[max_claim_json_bytes - 2] <== IsEqual()([remote_before_last_index, 0]);
  mask[max_claim_json_bytes - 1] <== IsEqual()([remove_last_index, 0]);

  // the rest of the items we want to keep
  for(var i = 2; i < max_claim_json_bytes - 2; i++) {
    mask[i] <== 1;
  }

  // below we're basically zeroing the indexes we want to remove
  signal final_claim[max_claim_json_bytes];
  for(var i = 0; i < max_claim_json_bytes; i++) {
    final_claim[i] <== claim[i] * mask[i];
  }

  // shifts all 0s to the end 
  out <== FilterZeros(max_claim_json_bytes)(final_claim);
}
