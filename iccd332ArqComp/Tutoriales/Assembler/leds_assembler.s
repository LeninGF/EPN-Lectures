.global _start
_start:
    /* r1 = LED register base address */
    LDR     r1, =0xFF200000

    /* r2 = mask for low 10 bits (0x3FF) */
    LDR     r2, =0x3FF

    /* r0 = 32-bit counter */
    MOV     r0, #0

loop:
    /* mask off high bits so only 10 LEDs ever change */
    AND     r3, r0, r2

    /* write masked value to LEDs */
    STR     r3, [r1]

    /* increment counter */
    ADD     r0, r0, #1

    /* infinite loop */
    B       loop
