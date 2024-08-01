	.file	"conv_snn.c"
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
	.globl	Base_SNN_conv
	.type	Base_SNN_conv, @function
Base_SNN_conv:
	addi	sp,sp,-352
	sw	s4,332(sp)
	addi	s4,a1,-2
	sw	s1,344(sp)
	mul	s1,s4,s4
	sw	s2,340(sp)
	sw	a2,176(sp)
	mv	s2,a2
	sw	a0,288(sp)
	sw	a1,12(sp)
	li	a1,1
	sw	s3,336(sp)
	sw	a5,296(sp)
	sw	ra,348(sp)
	mul	a2,s1,a2
	sw	s5,328(sp)
	sw	s6,324(sp)
	sw	s7,320(sp)
	sw	s8,316(sp)
	sw	s9,312(sp)
	sw	s10,308(sp)
	sw	s11,304(sp)
	sw	s1,284(sp)
	sw	a3,292(sp)
	slli	a0,a2,3
	add	a0,a0,a2
	mv	s3,a4
	sw	a4,168(sp)
	sw	a6,300(sp)
	call	calloc
	lw	t5,12(sp)
	sw	a0,172(sp)
	mul	a5,t5,t5
	sw	a5,180(sp)
	ble	s2,zero,.L47
	ble	s4,zero,.L47
	slli	a4,s1,1
	add	a2,a4,s1
	slli	a5,s1,3
	sub	t4,a5,s1
	slli	t6,a2,1
	mv	t1,a5
	sw	a5,36(sp)
	add	a5,a5,s1
	sw	a5,184(sp)
	add	a5,t6,t5
	slli	a3,s1,2
	sw	a5,128(sp)
	add	a5,t4,t5
	add	t3,a3,s1
	mv	ra,a3
	sw	a3,52(sp)
	add	a1,a3,t5
	sw	a5,132(sp)
	slli	a3,t5,1
	add	a5,t1,t5
	mv	a7,a0
	sw	a5,136(sp)
	add	a5,a3,s3
	add	a6,a4,t5
	sw	a5,216(sp)
	add	a5,a7,s1
	add	a0,a2,t5
	add	a3,a7,t1
	sw	a5,244(sp)
	addi	a5,a6,-2
	sw	a3,188(sp)
	sw	a5,228(sp)
	add	a3,t4,a7
	addi	a5,a0,-2
	mv	t2,a2
	sw	a2,56(sp)
	sw	a3,192(sp)
	sw	a5,232(sp)
	add	a3,a7,t6
	addi	a5,a1,-2
	add	a2,t3,t5
	sw	a3,196(sp)
	sw	a5,236(sp)
	add	a3,t3,a7
	addi	a5,a2,-2
	sw	a3,200(sp)
	sw	a5,240(sp)
	add	a3,a7,ra
	add	a5,s3,t5
	mv	t0,a4
	sw	a4,60(sp)
	sw	a3,204(sp)
	sw	a5,224(sp)
	add	a3,a7,t2
	add	a5,s4,s1
	addi	a4,t5,-5
	sw	a3,208(sp)
	sw	a5,220(sp)
	add	a3,a7,t0
	andi	a5,a4,-2
	sw	t3,48(sp)
	sw	t4,40(sp)
	sw	t6,44(sp)
	sw	a3,212(sp)
	sw	s1,64(sp)
	sw	zero,124(sp)
	sw	zero,116(sp)
	sw	zero,120(sp)
	sw	zero,140(sp)
	sw	a5,248(sp)
	sw	t5,24(sp)
	mv	s5,s4
.L48:
	lw	a4,116(sp)
	lw	a5,216(sp)
	lw	a3,220(sp)
	lw	s10,124(sp)
	add	s11,a4,a5
	lw	a5,120(sp)
	sw	s11,148(sp)
	sw	zero,28(sp)
	add	s2,a3,a5
	lw	a3,228(sp)
	sw	zero,20(sp)
	add	s3,s5,s10
	add	s4,a3,a5
	lw	a3,232(sp)
	li	s9,0
	add	s6,a3,a5
	lw	a3,236(sp)
	add	s7,a3,a5
	lw	a3,240(sp)
	add	s8,a3,a5
	lw	a3,168(sp)
	add	a3,a3,a4
	sw	a3,12(sp)
	lw	a3,224(sp)
	add	a4,a3,a4
	sw	a4,16(sp)
	lw	a4,188(sp)
	add	a4,a5,a4
	sw	a4,88(sp)
	lw	a4,192(sp)
	add	a4,a5,a4
	sw	a4,92(sp)
	lw	a4,196(sp)
	add	a4,a5,a4
	sw	a4,96(sp)
	lw	a4,200(sp)
	add	a4,a5,a4
	sw	a4,100(sp)
	lw	a4,204(sp)
	add	a4,a5,a4
	sw	a4,104(sp)
	lw	a4,208(sp)
	add	a4,a5,a4
	sw	a4,108(sp)
	lw	a4,212(sp)
	add	a4,a5,a4
	sw	a4,112(sp)
	lw	a4,24(sp)
	sw	a4,32(sp)
	lw	a4,128(sp)
	addi	a4,a4,-2
	sw	a4,72(sp)
	lw	a4,132(sp)
	addi	a4,a4,-2
	sw	a4,76(sp)
	lw	a4,136(sp)
	addi	a4,a4,-2
	sw	a4,80(sp)
	lw	a4,172(sp)
	add	a4,a4,a5
	sw	a4,68(sp)
	lw	a4,244(sp)
	add	a5,a4,a5
	sw	a5,84(sp)
.L54:
	lw	a5,64(sp)
	lw	a3,52(sp)
	lw	a2,48(sp)
	add	a6,s9,a5
	lw	a5,60(sp)
	slt	a4,a6,s3
	slt	a7,s10,s2
	add	a0,s9,a5
	lw	a5,56(sp)
	sgt	t3,s3,a0
	add	a3,s9,a3
	add	a1,s9,a5
	slt	a5,s10,s4
	xori	t3,t3,1
	xori	a4,a4,1
	sgt	t1,s3,a1
	xori	a5,a5,1
	xori	a7,a7,1
	slt	t4,s10,s6
	add	a2,s9,a2
	or	a7,a7,a4
	or	a5,a5,t3
	xori	t1,t1,1
	sgt	a4,s3,a3
	xori	t4,t4,1
	slt	t3,s10,s7
	or	t4,t4,t1
	and	a5,a5,a7
	xori	a4,a4,1
	sgt	a7,s3,a2
	xori	t3,t3,1
	slt	t1,s10,s8
	or	t3,t3,a4
	and	a5,a5,t4
	xori	a7,a7,1
	slt	t4,a6,s4
	sgt	a4,s2,a0
	xori	t1,t1,1
	or	t1,t1,a7
	and	a5,a5,t3
	xori	a4,a4,1
	slt	t3,a6,s6
	sgt	a7,s2,a1
	xori	t4,t4,1
	or	t4,t4,a4
	and	a5,a5,t1
	xori	a7,a7,1
	slt	t1,a6,s7
	sgt	a4,s2,a3
	xori	t3,t3,1
	or	t3,t3,a7
	and	a5,a5,t4
	xori	a4,a4,1
	slt	t4,a6,s8
	sgt	a7,s2,a2
	xori	t1,t1,1
	or	t1,t1,a4
	and	a5,a5,t3
	xori	a7,a7,1
	sgt	t3,s4,a1
	slt	a4,a0,s6
	xori	t4,t4,1
	or	t4,t4,a7
	and	a5,a5,t1
	xori	a4,a4,1
	sgt	a7,s4,a3
	slt	t1,a0,s7
	xori	t3,t3,1
	or	t3,t3,a4
	and	a5,a5,t4
	xori	t1,t1,1
	sgt	t4,s4,a2
	slt	a4,a0,s8
	xori	a7,a7,1
	or	a7,a7,t1
	xori	a4,a4,1
	sgt	t5,s6,a3
	slt	t1,a1,s7
	xori	t4,t4,1
	or	t4,t4,a4
	and	a5,a5,t3
	lw	a4,44(sp)
	xori	t1,t1,1
	sgt	s1,s6,a2
	slt	t3,a1,s8
	xori	t5,t5,1
	or	t5,t5,t1
	xori	t3,t3,1
	lw	t1,40(sp)
	xori	s1,s1,1
	or	s1,s1,t3
	lw	t3,36(sp)
	and	a5,a5,a7
	add	a7,s9,a4
	lw	a4,72(sp)
	and	a5,a5,t4
	add	t4,s9,t1
	lw	t1,76(sp)
	and	a5,a5,t5
	add	t5,s9,t3
	lw	t3,80(sp)
	add	a4,a4,s9
	sgt	ra,s7,a2
	slt	t0,a3,s8
	add	t1,t1,s9
	xori	t0,t0,1
	slt	t2,s10,a4
	sgt	t6,s3,a7
	xori	ra,ra,1
	add	t3,t3,s9
	or	ra,ra,t0
	and	a5,a5,s1
	xori	t6,t6,1
	xori	t2,t2,1
	slt	s1,s10,t1
	sgt	t0,s3,t4
	or	t2,t2,t6
	and	a5,a5,ra
	xori	t0,t0,1
	xori	s1,s1,1
	slt	ra,s10,t3
	sgt	t6,s3,t5
	or	s1,s1,t0
	and	a5,a5,t2
	slt	t0,a6,a4
	xori	t6,t6,1
	sgt	t2,s2,a7
	xori	ra,ra,1
	and	a5,a5,s1
	or	ra,ra,t6
	xori	t2,t2,1
	slt	t6,a6,t1
	xori	t0,t0,1
	sgt	s1,s2,t4
	and	ra,a5,ra
	or	t0,t2,t0
	sgt	a5,s2,t5
	xori	s1,s1,1
	xori	t6,t6,1
	slt	a6,a6,t3
	and	t0,ra,t0
	xori	t2,a5,1
	sgt	ra,s4,a7
	slt	a5,a0,a4
	or	t6,s1,t6
	xori	a6,a6,1
	and	t6,t0,t6
	or	a6,t2,a6
	xori	ra,ra,1
	xori	t0,a5,1
	sgt	t2,s4,t4
	slt	a5,a0,t1
	and	a6,t6,a6
	or	t0,ra,t0
	xori	t2,t2,1
	xori	t6,a5,1
	sgt	ra,s4,t5
	slt	a0,a0,t3
	and	t0,a6,t0
	or	a5,t2,t6
	sgt	a6,s6,a7
	slt	t6,a1,a4
	xori	ra,ra,1
	xori	a0,a0,1
	and	a5,t0,a5
	or	a0,ra,a0
	xori	t0,a6,1
	xori	t6,t6,1
	slt	a6,a1,t1
	sgt	t2,s6,t4
	and	a0,a5,a0
	or	t6,t0,t6
	sgt	a5,s6,t5
	xori	t2,t2,1
	xori	a6,a6,1
	slt	a1,a1,t3
	and	t6,a0,t6
	sgt	t0,s7,a7
	xori	a0,a5,1
	or	a6,t2,a6
	slt	a5,a3,a4
	xori	a1,a1,1
	and	a6,t6,a6
	or	a1,a0,a1
	xori	t0,t0,1
	xori	a0,a5,1
	sgt	t6,s7,t4
	slt	a5,a3,t1
	and	a1,a6,a1
	or	a0,t0,a0
	xori	t6,t6,1
	xori	a6,a5,1
	sgt	t0,s7,t5
	slt	a3,a3,t3
	and	a0,a1,a0
	or	a5,t6,a6
	slt	a1,a2,a4
	sgt	t6,s8,a7
	xori	t0,t0,1
	xori	a3,a3,1
	and	a5,a0,a5
	or	a3,t0,a3
	slt	a0,a2,t1
	xori	t6,t6,1
	xori	a1,a1,1
	sgt	a6,s8,t4
	and	a3,a5,a3
	xori	a6,a6,1
	or	a1,t6,a1
	xori	a0,a0,1
	sgt	a5,s8,t5
	slt	a2,a2,t3
	and	a1,a3,a1
	or	a0,a6,a0
	xori	a5,a5,1
	sgt	a6,a4,t4
	slt	a3,a7,t1
	xori	a2,a2,1
	or	a2,a5,a2
	and	a1,a1,a0
	xori	a6,a6,1
	xori	a3,a3,1
	and	a1,a1,a2
	or	a3,a6,a3
	and	a1,a1,a3
	lw	a3,20(sp)
	sgt	a4,a4,t5
	slt	a7,a7,t3
	addi	a3,a3,1
	lw	a2,24(sp)
	xori	a4,a4,1
	xori	a7,a7,1
	sw	a3,20(sp)
	lw	a3,32(sp)
	or	a4,a4,a7
	and	a1,a1,a4
	lw	a4,28(sp)
	sw	a3,28(sp)
	add	a3,a3,a2
	sw	a3,32(sp)
	mv	a5,a4
	beq	a1,zero,.L49
	sgt	t1,t1,t5
	slt	t3,t4,t3
	xori	t1,t1,1
	xori	t3,t3,1
	or	t1,t1,t3
	beq	t1,zero,.L49
	lw	a5,68(sp)
	lw	a1,12(sp)
	mv	a2,s5
	add	a0,a5,s9
	call	memcpy
	lw	a5,88(sp)
	mv	a2,s5
	addi	a1,s11,2
	add	a0,s9,a5
	call	memcpy
	lw	a5,92(sp)
	mv	a2,s5
	addi	a1,s11,1
	add	a0,s9,a5
	call	memcpy
	lw	a5,96(sp)
	mv	a2,s5
	mv	a1,s11
	add	a0,s9,a5
	call	memcpy
	lw	a5,100(sp)
	lw	s1,16(sp)
	mv	a2,s5
	add	a0,s9,a5
	addi	a1,s1,2
	call	memcpy
	lw	a5,104(sp)
	addi	a1,s1,1
	mv	a2,s5
	add	a0,s9,a5
	call	memcpy
	lw	a5,108(sp)
	mv	a1,s1
	mv	a2,s5
	add	a0,s9,a5
	call	memcpy
	lw	a5,112(sp)
	lw	s1,12(sp)
	mv	a2,s5
	add	a0,s9,a5
	addi	a1,s1,2
	call	memcpy
	lw	a5,84(sp)
	mv	a2,s5
	addi	a1,s1,1
	add	a0,a5,s9
	call	memcpy
.L50:
	lw	a5,24(sp)
	lw	a4,12(sp)
	add	s3,s3,s5
	add	s11,s11,a5
	add	a4,a4,a5
	sw	a4,12(sp)
	lw	a4,16(sp)
	add	s10,s10,s5
	add	s2,s2,s5
	add	a5,a4,a5
	sw	a5,16(sp)
	lw	a5,20(sp)
	add	s4,s4,s5
	add	s6,s6,s5
	add	s7,s7,s5
	add	s8,s8,s5
	add	s9,s9,s5
	bne	a5,s5,.L54
	lw	a5,140(sp)
	lw	a3,120(sp)
	lw	a2,180(sp)
	addi	a4,a5,1
	lw	a5,184(sp)
	sw	a4,140(sp)
	add	a3,a3,a5
	sw	a3,120(sp)
	lw	a3,116(sp)
	add	a3,a3,a2
	sw	a3,116(sp)
	lw	a3,36(sp)
	add	a3,a3,a5
	sw	a3,36(sp)
	lw	a3,40(sp)
	add	a3,a3,a5
	sw	a3,40(sp)
	lw	a3,44(sp)
	add	a3,a3,a5
	sw	a3,44(sp)
	lw	a3,48(sp)
	add	a3,a3,a5
	sw	a3,48(sp)
	lw	a3,52(sp)
	add	a3,a3,a5
	sw	a3,52(sp)
	lw	a3,56(sp)
	add	a3,a3,a5
	sw	a3,56(sp)
	lw	a3,60(sp)
	add	a3,a3,a5
	sw	a3,60(sp)
	lw	a3,64(sp)
	add	a3,a3,a5
	sw	a3,64(sp)
	lw	a3,124(sp)
	add	a3,a3,a5
	sw	a3,124(sp)
	lw	a3,128(sp)
	add	a3,a3,a5
	sw	a3,128(sp)
	lw	a3,132(sp)
	add	a3,a3,a5
	sw	a3,132(sp)
	lw	a3,136(sp)
	add	a5,a3,a5
	sw	a5,136(sp)
	lw	a5,176(sp)
	bne	a5,a4,.L48
.L47:
	lw	a1,176(sp)
	lw	s2,172(sp)
	lw	a6,288(sp)
	slli	a2,a1,3
	lw	a5,300(sp)
	lw	a3,296(sp)
	add	a2,a2,a1
	lw	a0,292(sp)
	lw	a1,284(sp)
	mv	a4,s2
	call	Base_SNN_gemm
	mv	s1,a0
	mv	a0,s2
	call	free
	lw	ra,348(sp)
	lw	s2,340(sp)
	lw	s3,336(sp)
	lw	s4,332(sp)
	lw	s5,328(sp)
	lw	s6,324(sp)
	lw	s7,320(sp)
	lw	s8,316(sp)
	lw	s9,312(sp)
	lw	s10,308(sp)
	lw	s11,304(sp)
	mv	a0,s1
	lw	s1,344(sp)
	addi	sp,sp,352
	jr	ra
.L49:
	lw	a3,24(sp)
	li	a2,4
	ble	a3,a2,.L55
	lw	a2,112(sp)
	lw	a3,148(sp)
	lw	t0,84(sp)
	add	t5,s9,a2
	lw	a2,108(sp)
	add	a5,a3,a5
	lbu	t6,1(a5)
	add	t4,s9,a2
	lw	a2,104(sp)
	lw	a5,16(sp)
	lbu	a3,0(s11)
	add	t3,s9,a2
	lw	a2,100(sp)
	lbu	a7,0(a5)
	lbu	a6,1(a5)
	add	t1,s9,a2
	lw	a2,96(sp)
	lw	a5,248(sp)
	sw	a3,152(sp)
	add	t2,s9,a2
	lw	a2,92(sp)
	addi	a5,a5,2
	sw	a5,144(sp)
	lw	a5,16(sp)
	add	ra,s9,a2
	lw	a2,88(sp)
	sw	a5,160(sp)
	lw	a5,12(sp)
	add	s1,s9,a2
	lw	a3,12(sp)
	lw	a2,68(sp)
	sw	s11,164(sp)
	sw	a5,156(sp)
	sw	a4,252(sp)
	sw	s10,256(sp)
	lw	a4,152(sp)
	sw	s2,260(sp)
	sw	s3,152(sp)
	lbu	a0,0(a3)
	lbu	a1,1(a3)
	lw	a5,144(sp)
	add	a3,t0,s9
	sw	s4,264(sp)
	add	a2,a2,s9
	mv	s10,s1
	sw	s9,280(sp)
	lw	s9,164(sp)
	sw	s1,164(sp)
	lw	s1,156(sp)
	lw	s4,160(sp)
	sw	s7,268(sp)
	sw	s6,160(sp)
	sw	s8,272(sp)
	sw	s11,276(sp)
	mv	t0,t3
	mv	s3,t4
	mv	s2,t5
	mv	s6,t1
	mv	s7,t2
	mv	s8,ra
	li	s11,0
.L52:
	sb	a0,0(a2)
	lbu	a0,2(s1)
	sb	a1,0(a3)
	addi	a2,a2,2
	sb	a0,0(s2)
	sb	a7,0(s3)
	lbu	a7,2(s4)
	sb	a6,0(t0)
	addi	a3,a3,2
	sb	a7,0(s6)
	sb	a4,0(s7)
	lbu	a4,2(s9)
	sb	t6,0(s8)
	addi	s11,s11,2
	sb	a4,0(s10)
	sb	a1,-1(a2)
	lbu	a1,3(s1)
	sb	a0,-1(a3)
	addi	s1,s1,2
	sb	a1,1(s2)
	sb	a6,1(s3)
	lbu	a6,3(s4)
	sb	a7,1(t0)
	addi	s2,s2,2
	sb	a6,1(s6)
	sb	t6,1(s7)
	lbu	t6,3(s9)
	sb	a4,1(s8)
	addi	s3,s3,2
	sb	t6,1(s10)
	addi	t0,t0,2
	addi	s4,s4,2
	addi	s6,s6,2
	addi	s7,s7,2
	addi	s8,s8,2
	addi	s9,s9,2
	addi	s10,s10,2
	bne	s11,a5,.L52
	lw	a4,252(sp)
	lw	s3,152(sp)
	lw	s10,256(sp)
	lw	s2,260(sp)
	lw	s4,264(sp)
	lw	s6,160(sp)
	lw	s7,268(sp)
	lw	s8,272(sp)
	lw	s11,276(sp)
	lw	s9,280(sp)
	lw	s1,164(sp)
	sw	a5,144(sp)
.L51:
	lw	a1,144(sp)
	lw	a5,28(sp)
	add	a4,a4,a1
	add	a2,a1,a5
	lw	a5,32(sp)
	add	a3,a1,a5
	lw	a5,116(sp)
	add	a4,a4,a5
	add	a2,a2,a5
	add	a3,a3,a5
	lw	a5,168(sp)
	add	a4,a5,a4
	add	a2,a5,a2
	add	a3,a5,a3
	lw	a5,68(sp)
	add	t0,a5,s9
	lw	a5,84(sp)
	add	t6,a5,s9
	mv	a5,a1
.L53:
	lbu	a6,0(a4)
	lbu	a7,1(a4)
	lbu	a0,2(a4)
	add	a1,t0,a5
	sb	a6,0(a1)
	lbu	a6,0(a2)
	add	a1,t6,a5
	sb	a7,0(a1)
	lbu	a7,1(a2)
	add	a1,t5,a5
	sb	a0,0(a1)
	lbu	a0,2(a2)
	add	a1,t4,a5
	sb	a6,0(a1)
	lbu	a6,0(a3)
	add	a1,t3,a5
	sb	a7,0(a1)
	add	a1,t1,a5
	lbu	a7,1(a3)
	sb	a0,0(a1)
	add	a1,t2,a5
	lbu	a0,2(a3)
	sb	a6,0(a1)
	add	a6,ra,a5
	add	a1,s1,a5
	sb	a7,0(a6)
	sb	a0,0(a1)
	addi	a5,a5,1
	addi	a4,a4,1
	addi	a2,a2,1
	addi	a3,a3,1
	bgt	s5,a5,.L53
	j	.L50
.L55:
	lw	a5,88(sp)
	sw	zero,144(sp)
	add	s1,s9,a5
	lw	a5,92(sp)
	add	ra,s9,a5
	lw	a5,96(sp)
	add	t2,s9,a5
	lw	a5,100(sp)
	add	t1,s9,a5
	lw	a5,104(sp)
	add	t3,s9,a5
	lw	a5,108(sp)
	add	t4,s9,a5
	lw	a5,112(sp)
	add	t5,s9,a5
	j	.L51
	.size	Base_SNN_conv, .-Base_SNN_conv
	.align	1
	.globl	Base_SNN_pool
	.type	Base_SNN_pool, @function
Base_SNN_pool:
	addi	sp,sp,-32
	sw	s1,24(sp)
	srli	s1,a0,31
	add	s1,s1,a0
	srai	s1,s1,1
	sw	s4,12(sp)
	mul	s4,s1,s1
	sw	s3,16(sp)
	mv	s3,a1
	sw	s2,20(sp)
	mv	s2,a0
	li	a1,1
	sw	s5,8(sp)
	sw	ra,28(sp)
	mv	s5,a2
	mul	a0,s4,s3
	call	calloc
	ble	s3,zero,.L66
	li	a5,1
	ble	s2,a5,.L66
	mul	t2,s2,s2
	li	t0,0
	li	t6,0
	li	t5,0
.L68:
	add	a4,s5,t6
	add	t1,a0,t0
	li	t3,0
.L70:
	add	t4,s2,a4
	mv	a2,t4
	li	a3,0
.L69:
	lbu	a5,0(a4)
	lbu	a7,1(a4)
	lbu	a1,0(a2)
	lbu	a6,1(a2)
	or	a5,a5,a7
	or	a5,a5,a1
	or	a5,a5,a6
	add	a1,t1,a3
	sb	a5,0(a1)
	addi	a3,a3,1
	addi	a4,a4,2
	addi	a2,a2,2
	bgt	s1,a3,.L69
	addi	t3,t3,1
	add	a4,t4,s2
	add	t1,t1,s1
	bgt	s1,t3,.L70
	addi	t5,t5,1
	add	t6,t6,t2
	add	t0,t0,s4
	bne	s3,t5,.L68
.L66:
	lw	ra,28(sp)
	lw	s1,24(sp)
	lw	s2,20(sp)
	lw	s3,16(sp)
	lw	s4,12(sp)
	lw	s5,8(sp)
	addi	sp,sp,32
	jr	ra
	.size	Base_SNN_pool, .-Base_SNN_pool
	.align	1
	.globl	error_check_int8
	.type	error_check_int8, @function
error_check_int8:
	ble	a2,zero,.L77
	mv	a4,a0
	add	a2,a0,a2
	li	a0,0
.L76:
	lb	a3,0(a1)
	lb	a5,0(a4)
	addi	a4,a4,1
	addi	a1,a1,1
	sub	a5,a5,a3
	srai	a3,a5,31
	xor	a5,a3,a5
	sub	a5,a5,a3
	add	a0,a0,a5
	bne	a4,a2,.L76
	ret
.L77:
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
	li	a0,16384
	sw	ra,44(sp)
	sw	s1,40(sp)
	sw	s2,36(sp)
	sw	s9,8(sp)
	sw	s3,32(sp)
	sw	s4,28(sp)
	sw	s5,24(sp)
	sw	s6,20(sp)
	sw	s7,16(sp)
	sw	s8,12(sp)
	sw	s10,4(sp)
	call	malloc
	mv	s1,a0
	li	a0,36864
	call	malloc
	mv	s2,a0
	li	a0,16
	call	malloc
	mv	s9,a0
	li	a3,0
	li	a4,9
	li	a5,16384
.L80:
	rem	a2,a3,a4
	add	a1,s1,a3
	addi	a3,a3,1
	addi	a2,a2,-13
	sb	a2,0(a1)
	bne	a3,a5,.L80
	li	a3,0
	li	a4,7
	li	a5,36864
.L81:
	rem	a2,a3,a4
	add	a1,s2,a3
	addi	a3,a3,1
	addi	a2,a2,-5
	sb	a2,0(a1)
	bne	a3,a5,.L81
	li	s6,-50
	li	s5,-49
	li	s4,-48
	li	s3,-47
	li	a0,4
	sw	s6,0(s9)
	sw	s5,4(s9)
	sw	s4,8(s9)
	sw	s3,12(s9)
	call	malloc
	mv	s10,a0
 #APP
# 109 "../include/custom.h" 1
	rdcycle s7
# 0 "" 2
 #NO_APP
	li	a5,1310720
	li	a4,262144
	addi	a5,a5,1024
	addi	a4,a4,4
 #APP
# 18 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 0, 0, a5, a5, a4
# 0 "" 2
 #NO_APP
	li	a5,19
 #APP
# 6 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 2, 4, a5, a5, s6
# 0 "" 2
 #NO_APP
	li	a5,21
 #APP
# 6 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 2, 4, a5, a5, s5
# 0 "" 2
 #NO_APP
	li	a5,23
 #APP
# 6 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 2, 4, a5, a5, s4
# 0 "" 2
 #NO_APP
	li	a5,25
 #APP
# 6 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 2, 4, a5, a5, s3
# 0 "" 2
# 28 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 0, 1, a5, s2, s1
# 0 "" 2
 #NO_APP
	li	a5,3
	li	a4,0
 #APP
# 75 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 2, 1, a5, a5, a4
# 0 "" 2
 #NO_APP
	call	POOL_WB
	lbu	s5,0(s10)
	lbu	s8,1(s10)
	lbu	s4,2(s10)
	lbu	s3,3(s10)
 #APP
# 109 "../include/custom.h" 1
	rdcycle s6
# 0 "" 2
 #NO_APP
	mv	a0,s10
	call	free
	mv	a6,s9
	mv	a5,s2
	mv	a4,s1
	li	a3,4
	li	a2,1024
	li	a1,4
	li	a0,20
	call	Base_SNN_conv
	mv	a2,a0
	mv	s2,a0
	li	a1,4
	li	a0,2
	call	Base_SNN_pool
	mv	s1,a0
	mv	a0,s2
	call	free
	lb	a4,1(s1)
	slli	a2,s8,24
	lb	a0,0(s1)
	lb	a5,2(s1)
	srai	a2,a2,24
	sub	a2,a2,a4
	slli	a3,s5,24
	slli	a4,s4,24
	lb	a1,3(s1)
	srai	a3,a3,24
	srai	a4,a4,24
	sub	a3,a3,a0
	sub	a4,a4,a5
	slli	a5,s3,24
	srai	a7,a3,31
	srai	a6,a2,31
	srai	a5,a5,24
	xor	a3,a7,a3
	xor	a2,a6,a2
	srai	a0,a4,31
	sub	a5,a5,a1
	sub	a2,a2,a6
	sub	a3,a3,a7
	srai	a1,a5,31
	xor	a4,a0,a4
	sub	a4,a4,a0
	add	a3,a3,a2
	xor	s1,a1,a5
	lui	s2,%hi(.LANCHOR0)
	add	a5,a4,a3
	li	a2,1024
	li	a3,4
	sub	s1,s1,a1
	addi	a0,s2,%lo(.LANCHOR0)
	li	a1,4
	add	s1,s1,a5
	addi	s2,s2,%lo(.LANCHOR0)
	call	printf
	mv	a1,s1
	addi	a0,s2,28
	call	printf
	sub	s6,s6,s7
	mv	a1,s6
	addi	a0,s2,40
	call	printf
	mv	a0,s6
	call	__floatsidf
	mv	a2,a0
	mv	a3,a1
	lw	a0,64(s2)
	lw	a1,68(s2)
	call	__divdf3
	lw	a2,72(s2)
	lw	a3,76(s2)
	call	__muldf3
	call	__truncdfsf2
	call	__extendsfdf2
	mv	a2,a0
	mv	a3,a1
	addi	a0,s2,80
	call	printf
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
	lw	s10,4(sp)
	li	a0,0
	addi	sp,sp,48
	jr	ra
	.size	main, .-main
	.section	.rodata
	.align	3
	.set	.LANCHOR0,. + 0
.LC0:
	.string	"inside:%d c_in:%d c_out:%d\n"
.LC1:
	.string	"error:%d\n"
	.zero	2
.LC2:
	.string	"cycle count::%d\n"
	.zero	7
.LC3:
	.word	0
	.word	1093795847
.LC4:
	.word	858993459
	.word	1070805811
.LC5:
	.string	"GOPS:%.4f\n"
	.ident	"GCC: (GNU) 11.1.0"
