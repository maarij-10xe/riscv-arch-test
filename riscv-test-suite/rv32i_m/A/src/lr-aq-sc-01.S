//
// This assembly file tests the lr.r.aq and sc.w instruction of the RISC-V RV32A extension for the lr-aq-sc covergroup.
// 
#include "model_test.h"
#include "arch_test.h"
RVTEST_ISA("RV32IA_Zicsr")

.section .text.init
.globl rvtest_entry_point
rvtest_entry_point:
RVMODEL_BOOT
RVTEST_CODE_BEGIN

#ifdef TEST_CASE_1

RVTEST_CASE(0,"//check ISA:=regex(.*32.*);check ISA:=regex(.*I.*A.*Zicsr.*); def rvtest_mtrap_routine=True; def TEST_CASE_1=True;",lr-aq-sc)

RVTEST_SIGBASE(x1,signature_x1_1)

LA (x31, rvtest_data)

inst_0:
lr.w.aq x30, (x31)
sc.w x29, x30, (x31)

inst_1:
addi x31, x31, 4
lr.w.aq x30, (x31)
sc.w x29, x30, (x31)

inst_2:
addi x31, x31, 4
lr.w.aq x30, (x31)
sc.w x29, x30, (x31)

inst_3:
addi x31, x31, 4
lr.w.aq x30, (x31)
sc.w x29, x30, (x31)

#endif


RVTEST_CODE_END
RVMODEL_HALT

RVTEST_DATA_BEGIN
.align 4
rvtest_data:
.word 0xbabecafe
.word 0xabecafeb
.word 0xbecafeba
.word 0xecafebab
RVTEST_DATA_END

RVMODEL_DATA_BEGIN
rvtest_sig_begin:
sig_begin_canary:
CANARY;



signature_x1_0:
    .fill 0*((XLEN/8)/4),4,0xdeadbeef


signature_x1_1:
    .fill 50*((XLEN/8)/4),4,0xdeadbeef


signature_x8_0:
    .fill 88*((XLEN/8)/4),4,0xdeadbeef

#ifdef rvtest_mtrap_routine
tsig_begin_canary:
CANARY;

mtrap_sigptr:
    .fill 64*XLEN/32,4,0xdeadbeef

tsig_end_canary:
CANARY;
#endif

#ifdef rvtest_gpr_save

gpr_save:
    .fill 32*XLEN/32,4,0xdeadbeef

#endif


sig_end_canary:
CANARY;
rvtest_sig_end:
RVMODEL_DATA_END
