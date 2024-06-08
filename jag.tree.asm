interpreterLoop:
   beq s1, x0, doneInterpreting
   1b a0, 0(s0)
   ja1 ra, interpretChar
   addi s0, s0, 1
   addi s1, s1, -1
   jal x0, interpreterLoop
   ld	t0, zp_gpiaBase(x0)
   ori	t3, x0, 8