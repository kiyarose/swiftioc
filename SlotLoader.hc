U0 cia(I64* array, I64 s, I64 m) {
    I64 i = 0;
    I64 j = m;

    I64 *glow = MAlloc(8 * s);
    for (I64 n = 0; n < s; n += 1) {
        if (j ==s) {
            glow[n] = array[i];
            i += 1;
        } else if (i == m) {
            glow[n] = array[j];
        }
    }
}