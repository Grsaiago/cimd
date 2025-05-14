%include "src/x86inc.asm"

SECTION .text

;static void add_values(uint8_t *src, const uint8_t *src2)
INIT_XMM sse2
cglobal add_values, 2, 2, 2, src, src2
    movu  m0, [srcq]
    movu  m1, [src2q]

    paddb m0, m1

    movu  [srcq], m0

    RET
