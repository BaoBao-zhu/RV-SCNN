	.file	"gemm_snn.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	SCNN_WB
	.type	SCNN_WB, @function
SCNN_WB:
	addi	sp,sp,-48
	sw	s0,44(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	lw	a5,-36(s0)
	lw	a4,-20(s0)
 #APP
# 39 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 0, 2, a5, a5, a4
# 0 "" 2
 #NO_APP
	sw	a5,-24(s0)
	nop
	lw	s0,44(sp)
	addi	sp,sp,48
	jr	ra
	.size	SCNN_WB, .-SCNN_WB
	.align	1
	.globl	SCNN_WB_INT
	.type	SCNN_WB_INT, @function
SCNN_WB_INT:
	addi	sp,sp,-16
	sw	s0,12(sp)
	addi	s0,sp,16
	mv	a5,a0
	mv	a0,a5
	lw	s0,12(sp)
	addi	sp,sp,16
	tail	SCNN_WB
	.size	SCNN_WB_INT, .-SCNN_WB_INT
	.align	1
	.globl	POOL_WB
	.type	POOL_WB, @function
POOL_WB:
	addi	sp,sp,-48
	sw	s0,44(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	zero,-20(s0)
	lw	a5,-36(s0)
	lw	a4,-20(s0)
 #APP
# 87 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 2, 2, a5, a5, a4
# 0 "" 2
 #NO_APP
	sw	a5,-24(s0)
	nop
	lw	s0,44(sp)
	addi	sp,sp,48
	jr	ra
	.size	POOL_WB, .-POOL_WB
	.align	1
	.globl	POOL_WB_INT
	.type	POOL_WB_INT, @function
POOL_WB_INT:
	addi	sp,sp,-48
	sw	s0,44(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	lw	a5,-36(s0)
	lw	a4,-40(s0)
 #APP
# 98 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 2, 2, a5, a5, a4
# 0 "" 2
 #NO_APP
	sw	a5,-20(s0)
	nop
	lw	s0,44(sp)
	addi	sp,sp,48
	jr	ra
	.size	POOL_WB_INT, .-POOL_WB_INT
	.align	1
	.globl	L_MODE
	.type	L_MODE, @function
L_MODE:
	slli	a1,a1,1
	add	a1,a1,a0
	slli	a3,a3,4
	add	a1,a1,a3
 #APP
# 6 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 2, 4, a1, a1, a2
# 0 "" 2
 #NO_APP
	ret
	.size	L_MODE, .-L_MODE
	.align	1
	.globl	L_SCNN
	.type	L_SCNN, @function
L_SCNN:
	slli	a3,a3,16
	slli	a1,a1,16
	add	a3,a3,a0
	add	a1,a1,a2
 #APP
# 18 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 0, 0, a3, a3, a1
# 0 "" 2
 #NO_APP
	ret
	.size	L_SCNN, .-L_SCNN
	.align	1
	.globl	SCNN4x4
	.type	SCNN4x4, @function
SCNN4x4:
 #APP
# 28 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 0, 1, a0, a0, a1
# 0 "" 2
 #NO_APP
	ret
	.size	SCNN4x4, .-SCNN4x4
	.align	1
	.globl	POOL_RI
	.type	POOL_RI, @function
POOL_RI:
	li	a5,0
 #APP
# 63 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 2, 0, a0, a0, a5
# 0 "" 2
 #NO_APP
	ret
	.size	POOL_RI, .-POOL_RI
	.align	1
	.globl	POOL
	.type	POOL, @function
POOL:
	li	a5,0
 #APP
# 75 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 2, 1, a0, a0, a5
# 0 "" 2
 #NO_APP
	ret
	.size	POOL, .-POOL
	.align	1
	.globl	record
	.type	record, @function
record:
 #APP
# 109 "../include/custom.h" 1
	rdcycle a0
# 0 "" 2
 #NO_APP
	ret
	.size	record, .-record
	.align	1
	.globl	Base_SNN_gemm
	.type	Base_SNN_gemm, @function
Base_SNN_gemm:
	addi	sp,sp,-176
	sw	s9,136(sp)
	sw	a0,100(sp)
	mv	s9,a0
	mul	a0,a0,a1
	sw	s8,140(sp)
	sw	a1,104(sp)
	mv	s8,a1
	li	a1,1
	sw	ra,172(sp)
	sw	a2,108(sp)
	sw	a3,112(sp)
	sw	a6,124(sp)
	sw	s1,168(sp)
	sw	s2,164(sp)
	mv	s1,a4
	sw	s3,160(sp)
	sw	s4,156(sp)
	sw	s5,152(sp)
	sw	s6,148(sp)
	sw	s7,144(sp)
	mv	s6,a0
	sw	s10,132(sp)
	sw	s11,128(sp)
	mv	s2,a5
	sw	a0,116(sp)
	call	calloc
	mv	a5,a0
	li	a1,2
	mv	a0,s6
	sw	a5,120(sp)
	call	calloc
	mv	a5,a0
	li	a1,2
	mv	a0,s6
	mv	s3,a5
	sw	a5,68(sp)
	call	calloc
	mv	a5,a0
	li	a1,2
	mv	a0,s6
	mv	s11,a5
	sw	a5,72(sp)
	call	calloc
	mv	a5,a0
	li	a1,2
	mv	a0,s6
	mv	s10,a5
	sw	a5,76(sp)
	call	calloc
	mv	a5,a0
	li	a1,2
	mv	a0,s6
	mv	s7,a5
	sw	a5,80(sp)
	call	calloc
	mv	a5,a0
	li	a1,2
	mv	a0,s6
	mv	s4,a5
	sw	a5,84(sp)
	call	calloc
	mv	a5,a0
	li	a1,2
	mv	a0,s6
	mv	s5,a5
	sw	a5,88(sp)
	call	calloc
	mv	a5,a0
	li	a1,2
	mv	a0,s6
	sw	a5,92(sp)
	mv	s6,a5
	call	calloc
	sw	a0,96(sp)
	ble	s9,zero,.L13
	ble	s8,zero,.L13
	slli	a4,s8,1
	slli	t0,s9,2
	mv	t5,s2
	add	t0,s2,t0
	mv	t2,s3
	sw	a4,56(sp)
	mv	s3,s7
	mv	t4,a4
	li	t6,0
	mv	ra,s11
	mv	s2,s10
	mv	s7,a0
	mv	s9,a4
.L14:
	lh	a4,0(t5)
	slli	a5,t6,1
.L15:
	add	t3,t2,a5
	add	t1,ra,a5
	add	a7,s2,a5
	add	a6,s3,a5
	add	a0,s4,a5
	add	a1,s5,a5
	add	a2,s6,a5
	add	a3,s7,a5
	sh	a4,0(t3)
	sh	a4,0(t1)
	sh	a4,0(a7)
	sh	a4,0(a6)
	sh	a4,0(a0)
	sh	a4,0(a1)
	sh	a4,0(a2)
	sh	a4,0(a3)
	addi	a5,a5,2
	bne	t4,a5,.L15
	addi	t5,t5,4
	add	t6,t6,s8
	add	t4,t4,s9
	bne	t0,t5,.L14
	lw	a5,108(sp)
	ble	a5,zero,.L13
	lw	a5,112(sp)
	lw	a4,100(sp)
	sw	s1,48(sp)
	sw	zero,60(sp)
	add	a5,a5,a4
	sw	a5,52(sp)
	lw	a5,104(sp)
	sw	zero,64(sp)
	add	s11,s1,a5
.L17:
	lw	a5,112(sp)
	lw	a4,60(sp)
	add	a5,a5,a4
	sw	a5,44(sp)
	lw	a5,68(sp)
	sw	a5,40(sp)
	lw	a5,72(sp)
	sw	a5,36(sp)
	lw	a5,76(sp)
	sw	a5,32(sp)
	lw	a5,80(sp)
	sw	a5,28(sp)
	lw	a5,84(sp)
	sw	a5,24(sp)
	lw	a5,88(sp)
	sw	a5,20(sp)
	lw	a5,92(sp)
	sw	a5,16(sp)
	lw	a5,96(sp)
	sw	a5,12(sp)
.L20:
	lw	a5,44(sp)
	lw	s2,12(sp)
	lw	s1,16(sp)
	lb	a4,0(a5)
	lw	ra,20(sp)
	lw	t2,24(sp)
	lw	t0,28(sp)
	lw	t6,32(sp)
	lw	t5,36(sp)
	lw	t4,48(sp)
	lw	t3,40(sp)
	slli	a4,a4,16
	srli	a4,a4,16
.L18:
	lbu	a5,0(t4)
	lhu	s9,0(t3)
	lhu	s8,0(t5)
	srai	s4,a5,1
	srai	a6,a5,2
	srai	a0,a5,3
	srai	a1,a5,4
	srai	a2,a5,5
	srai	a3,a5,6
	andi	s10,a5,1
	andi	s4,s4,1
	andi	a6,a6,1
	andi	a0,a0,1
	andi	a1,a1,1
	andi	a2,a2,1
	andi	a3,a3,1
	srli	a5,a5,7
	mul	s10,a4,s10
	lhu	s7,0(t6)
	lhu	s6,0(t0)
	lhu	s5,0(t2)
	lhu	s3,0(ra)
	lhu	t1,0(s1)
	lhu	a7,0(s2)
	addi	t3,t3,2
	addi	t5,t5,2
	addi	t6,t6,2
	mul	s4,a4,s4
	add	s10,s10,s9
	addi	t0,t0,2
	addi	t2,t2,2
	addi	ra,ra,2
	addi	s1,s1,2
	addi	s2,s2,2
	addi	t4,t4,1
	sh	s10,-2(t3)
	mul	a6,a4,a6
	add	s4,s4,s8
	sh	s4,-2(t5)
	mul	a0,a4,a0
	add	a6,a6,s7
	sh	a6,-2(t6)
	mul	a1,a4,a1
	add	a0,a0,s6
	sh	a0,-2(t0)
	mul	a2,a4,a2
	add	a1,a1,s5
	sh	a1,-2(t2)
	mul	a3,a4,a3
	add	a2,a2,s3
	sh	a2,-2(ra)
	mul	a5,a4,a5
	add	a3,a3,t1
	sh	a3,-2(s1)
	add	a5,a5,a7
	sh	a5,-2(s2)
	bne	s11,t4,.L18
	lw	a5,44(sp)
	lw	a3,40(sp)
	addi	a4,a5,1
	lw	a5,56(sp)
	sw	a4,44(sp)
	add	a3,a3,a5
	sw	a3,40(sp)
	lw	a3,36(sp)
	add	a3,a3,a5
	sw	a3,36(sp)
	lw	a3,32(sp)
	add	a3,a3,a5
	sw	a3,32(sp)
	lw	a3,28(sp)
	add	a3,a3,a5
	sw	a3,28(sp)
	lw	a3,24(sp)
	add	a3,a3,a5
	sw	a3,24(sp)
	lw	a3,20(sp)
	add	a3,a3,a5
	sw	a3,20(sp)
	lw	a3,16(sp)
	add	a3,a3,a5
	sw	a3,16(sp)
	lw	a3,12(sp)
	add	a5,a3,a5
	sw	a5,12(sp)
	lw	a5,52(sp)
	bne	a5,a4,.L20
	lw	a4,100(sp)
	mv	a3,a5
	lw	a2,48(sp)
	add	a3,a3,a4
	sw	a3,52(sp)
	lw	a3,104(sp)
	lw	a5,64(sp)
	add	a2,a2,a3
	add	s11,s11,a3
	lw	a3,60(sp)
	addi	a5,a5,1
	sw	a5,64(sp)
	add	a4,a3,a4
	sw	a4,60(sp)
	lw	a4,108(sp)
	sw	a2,48(sp)
	bne	a4,a5,.L17
.L13:
	lw	a5,116(sp)
	ble	a5,zero,.L38
	lw	a4,120(sp)
	mv	a3,a5
	lw	t4,68(sp)
	mv	a5,a4
	add	t5,a4,a3
	lw	t3,72(sp)
	lw	t1,96(sp)
	lw	a7,92(sp)
	lw	a6,88(sp)
	lw	a0,84(sp)
	lw	a1,80(sp)
	lw	a2,76(sp)
	lw	a4,124(sp)
.L37:
	lh	a3,0(t4)
	lh	t6,0(t3)
	ble	a3,a4,.L22
	lbu	a3,0(a5)
	addi	a3,a3,1
	sb	a3,0(a5)
	lh	a3,0(a2)
	ble	t6,a4,.L24
.L45:
	lbu	t6,0(a5)
	addi	t6,t6,2
	sb	t6,0(a5)
.L25:
	lh	t6,0(a1)
	ble	a3,a4,.L26
	lbu	a3,0(a5)
	addi	a3,a3,4
	sb	a3,0(a5)
.L27:
	lh	a3,0(a0)
	ble	t6,a4,.L28
	lbu	t6,0(a5)
	addi	t6,t6,8
	sb	t6,0(a5)
.L29:
	lh	t6,0(a6)
	ble	a3,a4,.L30
	lbu	a3,0(a5)
	addi	a3,a3,16
	sb	a3,0(a5)
.L31:
	lh	a3,0(a7)
	ble	t6,a4,.L32
	lbu	t6,0(a5)
	addi	t6,t6,32
	sb	t6,0(a5)
.L33:
	lh	t6,0(t1)
	ble	a3,a4,.L34
	lbu	a3,0(a5)
	addi	a3,a3,64
	sb	a3,0(a5)
.L35:
	ble	t6,a4,.L36
	lbu	a3,0(a5)
	addi	a3,a3,-128
	sb	a3,0(a5)
.L36:
	addi	a5,a5,1
	addi	t4,t4,2
	addi	t3,t3,2
	addi	t1,t1,2
	addi	a7,a7,2
	addi	a6,a6,2
	addi	a0,a0,2
	addi	a1,a1,2
	addi	a2,a2,2
	bne	a5,t5,.L37
.L38:
	lw	a0,68(sp)
	call	free
	lw	a0,72(sp)
	call	free
	lw	a0,76(sp)
	call	free
	lw	a0,80(sp)
	call	free
	lw	a0,84(sp)
	call	free
	lw	a0,88(sp)
	call	free
	lw	a0,92(sp)
	call	free
	lw	a0,96(sp)
	call	free
	lw	ra,172(sp)
	lw	a0,120(sp)
	lw	s1,168(sp)
	lw	s2,164(sp)
	lw	s3,160(sp)
	lw	s4,156(sp)
	lw	s5,152(sp)
	lw	s6,148(sp)
	lw	s7,144(sp)
	lw	s8,140(sp)
	lw	s9,136(sp)
	lw	s10,132(sp)
	lw	s11,128(sp)
	addi	sp,sp,176
	jr	ra
.L34:
	srai	a3,a3,2
	add	t6,a3,t6
	slli	t6,t6,16
	srai	t6,t6,16
	sh	t6,0(t1)
	j	.L35
.L32:
	srai	t6,t6,2
	add	a3,t6,a3
	slli	a3,a3,16
	srai	a3,a3,16
	sh	a3,0(a7)
	j	.L33
.L30:
	srai	a3,a3,2
	add	t6,a3,t6
	slli	t6,t6,16
	srai	t6,t6,16
	sh	t6,0(a6)
	j	.L31
.L28:
	srai	t6,t6,2
	add	a3,t6,a3
	slli	a3,a3,16
	srai	a3,a3,16
	sh	a3,0(a0)
	j	.L29
.L26:
	srai	a3,a3,2
	add	t6,a3,t6
	slli	t6,t6,16
	srai	t6,t6,16
	sh	t6,0(a1)
	j	.L27
.L22:
	srai	a3,a3,2
	add	t6,a3,t6
	slli	t6,t6,16
	srai	t6,t6,16
	sh	t6,0(t3)
	lh	a3,0(a2)
	bgt	t6,a4,.L45
.L24:
	srai	t6,t6,2
	add	a3,t6,a3
	slli	a3,a3,16
	srai	a3,a3,16
	sh	a3,0(a2)
	j	.L25
	.size	Base_SNN_gemm, .-Base_SNN_gemm
	.align	1
	.globl	error_check_int8
	.type	error_check_int8, @function
error_check_int8:
	ble	a2,zero,.L49
	mv	a4,a0
	add	a2,a0,a2
	li	a0,0
.L48:
	lb	a3,0(a1)
	lb	a5,0(a4)
	addi	a4,a4,1
	addi	a1,a1,1
	sub	a5,a5,a3
	srai	a3,a5,31
	xor	a5,a3,a5
	sub	a5,a5,a3
	add	a0,a0,a5
	bne	a4,a2,.L48
	ret
.L49:
	li	a0,0
	ret
	.size	error_check_int8, .-error_check_int8
	.globl	__floatsidf
	.globl	__divdf3
	.globl	__muldf3
	.globl	__truncdfsf2
	.globl	__extendsfdf2
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-48
	li	a0,64
	sw	ra,44(sp)
	sw	s1,40(sp)
	sw	s2,36(sp)
	sw	s5,24(sp)
	sw	s3,32(sp)
	sw	s4,28(sp)
	sw	s6,20(sp)
	sw	s7,16(sp)
	sw	s8,12(sp)
	sw	s9,8(sp)
	call	malloc
	mv	s1,a0
	li	a0,64
	call	malloc
	mv	s5,a0
	li	a0,16
	call	malloc
	mv	s2,a0
	li	a3,0
	li	a7,20
	li	a6,64
.L52:
	rem	a2,a3,a7
	add	a1,s1,a3
	addi	a3,a3,1
	addi	a2,a2,-7
	sb	a2,0(a1)
	bne	a3,a6,.L52
	li	a1,-5
	addi	a6,s5,64
	mv	a3,s5
	sub	a1,a1,s5
.L53:
	add	a2,a1,a3
	sb	a2,0(a3)
	addi	a3,a3,1
	bne	a6,a3,.L53
	li	s9,-30
	li	s8,-29
	li	s6,-28
	li	s4,-27
	sw	s9,0(s2)
	sw	s8,4(s2)
	sw	s6,8(s2)
	sw	s4,12(s2)
	li	a0,16
	call	malloc
	mv	s3,a0
 #APP
# 109 "../include/custom.h" 1
	rdcycle s7
# 0 "" 2
 #NO_APP
	li	a4,209715200
	li	a3,262144
	addi	a4,a4,16
	addi	a3,a3,4
 #APP
# 18 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 0, 0, a4, a4, a3
# 0 "" 2
 #NO_APP
	li	a5,3
 #APP
# 6 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 2, 4, a5, a5, s9
# 0 "" 2
 #NO_APP
	li	a5,5
 #APP
# 6 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 2, 4, a5, a5, s8
# 0 "" 2
 #NO_APP
	li	a5,7
 #APP
# 6 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 2, 4, a5, a5, s6
# 0 "" 2
 #NO_APP
	li	a5,9
 #APP
# 6 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 2, 4, a5, a5, s4
# 0 "" 2
# 28 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 0, 1, a5, s1, s5
# 0 "" 2
 #NO_APP
	call	SCNN_WB
 #APP
# 109 "../include/custom.h" 1
	rdcycle s6
# 0 "" 2
 #NO_APP
	li	a6,200
	mv	a5,s2
	mv	a4,s5
	mv	a3,s1
	li	a2,16
	li	a1,4
	li	a0,4
	call	Base_SNN_gemm
	lb	a6,1(a0)
	lb	a2,0(a0)
	lb	a4,1(s3)
	lb	a7,0(s3)
	lb	a3,2(a0)
	lb	a1,2(s3)
	mv	s2,a0
	lb	a5,3(s3)
	lb	a0,3(a0)
	lb	t0,4(s2)
	sub	a4,a4,a6
	sub	a7,a7,a2
	lb	a2,4(s3)
	lb	t6,5(s2)
	srai	t3,a4,31
	sub	a1,a1,a3
	srai	t1,a7,31
	lb	a3,5(s3)
	lb	t5,6(s2)
	srai	t4,a1,31
	sub	a5,a5,a0
	xor	a6,t3,a4
	lb	a0,6(s3)
	xor	a7,t1,a7
	srai	t2,a5,31
	sub	a2,a2,t0
	lb	a4,7(s3)
	lb	t0,7(s2)
	sub	a7,a7,t1
	sub	a6,a6,t3
	xor	t3,t4,a1
	srai	t1,a2,31
	sub	a3,a3,t6
	lb	a1,8(s3)
	lb	t6,8(s2)
	sub	t3,t3,t4
	add	a6,a6,a7
	xor	a7,t2,a5
	srai	t4,a3,31
	sub	a0,a0,t5
	lb	a5,9(s3)
	lb	t5,9(s2)
	add	a6,t3,a6
	sub	a7,a7,t2
	xor	t3,t1,a2
	srai	t2,a0,31
	sub	a4,a4,t0
	lb	a2,10(s3)
	lb	t0,10(s2)
	add	a7,a7,a6
	sub	t3,t3,t1
	xor	a6,t4,a3
	srai	t1,a4,31
	sub	a1,a1,t6
	lb	a3,11(s3)
	lb	t6,11(s2)
	add	t3,t3,a7
	sub	a6,a6,t4
	xor	a7,t2,a0
	lb	s4,12(s3)
	srai	t4,a1,31
	sub	a5,a5,t5
	add	a0,a6,t3
	lb	t5,12(s2)
	xor	a6,t1,a4
	sub	a7,a7,t2
	srai	t3,a5,31
	lb	t2,13(s2)
	lb	a4,13(s3)
	sub	a2,a2,t0
	add	a7,a7,a0
	sub	a6,a6,t1
	xor	t1,t4,a1
	srai	t0,a2,31
	lb	a0,14(s2)
	sub	a3,a3,t6
	add	a6,a6,a7
	lb	t6,14(s3)
	xor	a7,t3,a5
	sub	t1,t1,t4
	sub	a1,s4,t5
	srai	t4,a3,31
	lb	t5,15(s2)
	lb	a5,15(s3)
	add	t1,t1,a6
	sub	a7,a7,t3
	xor	a6,t0,a2
	srai	t3,a1,31
	sub	a4,a4,t2
	sub	a6,a6,t0
	xor	a3,t4,a3
	add	a2,a7,t1
	sub	a0,t6,a0
	srai	a7,a4,31
	sub	a3,a3,t4
	add	a6,a6,a2
	xor	a2,t3,a1
	srai	t1,a0,31
	sub	a5,a5,t5
	sub	a2,a2,t3
	add	a1,a3,a6
	xor	a3,a7,a4
	srai	a6,a5,31
	xor	a4,t1,a0
	sub	a3,a3,a7
	add	a2,a2,a1
	xor	s4,a6,a5
	sub	a4,a4,t1
	add	a3,a3,a2
	lui	s8,%hi(.LANCHOR0)
	add	a5,a4,a3
	sub	s4,s4,a6
	li	a3,16
	li	a2,4
	li	a1,4
	addi	a0,s8,%lo(.LANCHOR0)
	add	s4,s4,a5
	addi	s8,s8,%lo(.LANCHOR0)
	call	printf
	mv	a1,s4
	addi	a0,s8,16
	call	printf
	sub	s6,s6,s7
	mv	a1,s6
	addi	a0,s8,28
	call	printf
	mv	a0,s6
	call	__floatsidf
	mv	a2,a0
	mv	a3,a1
	lw	a0,48(s8)
	lw	a1,52(s8)
	call	__divdf3
	lw	a2,56(s8)
	lw	a3,60(s8)
	call	__muldf3
	call	__truncdfsf2
	call	__extendsfdf2
	mv	a2,a0
	mv	a3,a1
	addi	a0,s8,64
	call	printf
	mv	a0,s1
	call	free
	mv	a0,s5
	call	free
	mv	a0,s3
	call	free
	mv	a0,s2
	call	free
	lw	ra,44(sp)
	lw	s1,40(sp)
	lw	s2,36(sp)
	lw	s3,32(sp)
	lw	s4,28(sp)
	lw	s5,24(sp)
	lw	s6,20(sp)
	lw	s7,16(sp)
	lw	s8,12(sp)
	lw	s9,8(sp)
	li	a0,0
	addi	sp,sp,48
	jr	ra
	.size	main, .-main
	.section	.rodata
	.align	3
	.set	.LANCHOR0,. + 0
.LC0:
	.string	"M:%d N:%d K:%d\n"
.LC1:
	.string	"error:%d\n"
	.zero	2
.LC2:
	.string	"cycle count:%d\n"
	.zero	4
.LC3:
	.word	0
	.word	1084231168
.LC4:
	.word	858993459
	.word	1070805811
.LC5:
	.string	"GOPS:%.4f\n"
	.ident	"GCC: (GNU) 11.1.0"
