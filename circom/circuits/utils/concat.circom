pragma circom 2.0.0;

template ConcatDigits(maxLength, numDigits) {
    signal input digits[numDigits];  // Enter multiple numbers
    signal output result;            // The result after splicing

    var power[numDigits];
    signal sum[numDigits+1];

    power[0] = 1;
    for (var i = 1; i < numDigits; i++) {
        power[i] = power[i - 1] * (10 ** maxLength);
    }

    sum[0] <== 0;
    for (var i = 0; i < numDigits; i++) {
        sum[i+1] <== sum[i] + digits[i] * power[numDigits - 1 - i];
    }

    result <== sum[numDigits];
}