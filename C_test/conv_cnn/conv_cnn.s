	.file	"conv_cnn.c"
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
	.globl	Base_conv_mp
	.type	Base_conv_mp, @function
Base_conv_mp:
	addi	sp,sp,-224
	sw	s3,208(sp)
	sw	a0,136(sp)
	mv	s3,a0
	addi	a0,a0,-2
	srli	a5,a0,31
	add	a5,a5,a0
	srai	a5,a5,1
	mul	a0,a5,a5
	sw	a5,128(sp)
	mv	a5,a1
	li	a1,4
	sw	s1,216(sp)
	sw	s2,212(sp)
	sw	ra,220(sp)
	sw	s4,204(sp)
	sw	s5,200(sp)
	sw	s6,196(sp)
	sw	a0,172(sp)
	mul	a0,a0,a2
	sw	s7,192(sp)
	sw	s8,188(sp)
	sw	s9,184(sp)
	sw	s10,180(sp)
	sw	s11,176(sp)
	mv	s2,a2
	sw	a2,76(sp)
	sw	a5,72(sp)
	mv	s1,a3
	sw	a4,140(sp)
	call	calloc
	sw	a0,164(sp)
	ble	s2,zero,.L12
	slli	a5,s2,1
	add	a2,a5,s2
	sw	a2,92(sp)
	slli	a2,a2,1
	slli	a1,s2,2
	slli	a3,s2,3
	sw	a2,108(sp)
	slli	a2,s3,1
	sw	a1,96(sp)
	sw	a2,24(sp)
	add	a1,a1,s2
	sub	a2,a3,s2
	sw	a5,88(sp)
	sw	a3,112(sp)
	li	a5,3
	sw	a1,100(sp)
	sw	a2,104(sp)
	ble	s3,a5,.L12
	mul	a5,s3,s3
	sw	zero,156(sp)
	sw	zero,132(sp)
	sw	a5,80(sp)
	add	a5,a3,s2
	sw	a5,84(sp)
	add	a5,s1,s3
	sw	a5,168(sp)
.L14:
	lw	a5,156(sp)
	lw	a4,164(sp)
	sw	zero,148(sp)
	slli	a5,a5,2
	add	a5,a4,a5
	sw	a5,160(sp)
	sw	zero,144(sp)
	sw	zero,152(sp)
.L21:
	lw	a5,144(sp)
	lw	a4,160(sp)
	sw	zero,120(sp)
	slli	a5,a5,2
	add	a5,a5,a4
	sw	a5,124(sp)
	lw	a4,148(sp)
	lw	a5,168(sp)
	add	a5,a5,a4
	sw	a5,116(sp)
.L20:
	lw	a5,72(sp)
	ble	a5,zero,.L22
	lw	s9,116(sp)
	lw	a5,136(sp)
	lw	a4,132(sp)
	lw	a7,24(sp)
	sub	s1,s9,a5
	lw	a5,24(sp)
	sw	zero,16(sp)
	sw	zero,12(sp)
	add	t2,a5,s1
	lw	a5,140(sp)
	li	t4,0
	sw	zero,20(sp)
	add	s5,a5,a4
	sw	zero,8(sp)
	mv	s11,s9
	mv	s4,t2
	mv	s10,s1
	j	.L16
.L28:
	lw	a7,24(sp)
	add	t2,a7,s10
.L16:
	lw	a5,76(sp)
	lw	a2,96(sp)
	add	s9,s11,a7
	add	a5,s5,a5
	lb	a4,0(a5)
	lw	a5,88(sp)
	lw	t1,108(sp)
	lb	a6,0(s5)
	add	a5,s5,a5
	lb	t0,0(a5)
	lw	a5,92(sp)
	lb	t5,0(s11)
	lb	t3,1(s4)
	add	a5,s5,a5
	lb	t6,0(a5)
	lb	a5,0(s4)
	lb	s2,1(s9)
	lb	a3,0(s10)
	sw	a5,60(sp)
	add	a5,s5,a2
	lb	a2,2(s4)
	sw	t3,32(sp)
	mul	t3,a6,t5
	sw	a2,36(sp)
	lw	a2,100(sp)
	lb	a0,1(s11)
	lb	a1,2(s11)
	add	a2,s5,a2
	lb	a7,0(a2)
	lb	a2,3(s4)
	lb	a5,0(a5)
	lb	s8,1(s10)
	sw	a2,68(sp)
	add	a2,s5,t1
	lb	t1,0(a2)
	lb	a2,1(t2)
	lb	s7,2(s10)
	lb	s6,3(s11)
	sw	a2,28(sp)
	lb	s1,3(s10)
	sw	s2,40(sp)
	lw	s3,104(sp)
	mul	a3,a3,a6
	sw	t3,56(sp)
	add	a2,s5,s3
	lb	s3,0(t2)
	lb	t3,3(t2)
	lb	s2,2(s9)
	sw	s3,48(sp)
	lb	s3,0(s9)
	sw	t3,52(sp)
	sw	s2,44(sp)
	sw	s3,64(sp)
	lb	s3,2(t2)
	lw	t2,20(sp)
	lw	s2,112(sp)
	mul	s1,s1,t0
	add	a3,a3,t2
	add	s2,s5,s2
	lb	a2,0(a2)
	lb	s2,0(s2)
	lb	s9,3(s9)
	mul	t2,a6,s8
	add	t2,t2,t4
	mv	t3,t2
	lw	t2,8(sp)
	mul	s8,a4,s8
	lw	t4,12(sp)
	addi	t2,t2,1
	sw	t2,8(sp)
	lw	t2,84(sp)
	add	s5,s5,t2
	lw	t2,80(sp)
	mul	a6,a6,a0
	add	s10,s10,t2
	add	s11,s11,t2
	add	s4,s4,t2
	lw	t2,56(sp)
	add	a3,a3,s8
	add	t2,t2,t4
	sw	t2,12(sp)
	lw	t4,16(sp)
	mul	t2,a4,s7
	add	a6,a6,t4
	mul	s8,a4,a0
	add	t2,t3,t2
	lw	t3,12(sp)
	add	s1,t2,s1
	mul	a4,a4,a1
	add	s8,t3,s8
	lw	t3,32(sp)
	mul	s7,t0,s7
	add	a4,a6,a4
	mul	t5,t6,t5
	add	a3,a3,s7
	mul	a6,t0,a1
	add	t5,a3,t5
	lw	a3,60(sp)
	mul	t0,t0,s6
	add	a6,s8,a6
	add	a4,a4,t0
	mul	t0,t6,a0
	mul	a3,a3,t6
	add	t0,s1,t0
	lw	s1,36(sp)
	mul	t4,a5,t3
	add	a3,a6,a3
	mul	t6,t6,t3
	add	t4,a3,t4
	lw	a3,68(sp)
	mul	a6,a5,a1
	add	a4,a4,t6
	mul	a0,a5,a0
	add	a6,t0,a6
	mul	a5,a5,s1
	add	a0,t5,a0
	mul	a1,a7,a1
	add	a5,a4,a5
	mul	a4,a3,a7
	lw	a3,48(sp)
	add	a1,a0,a1
	lw	a0,28(sp)
	mul	a3,a3,t1
	add	a5,a5,a4
	mul	s6,a7,s6
	add	a3,a1,a3
	lw	a1,64(sp)
	mul	a4,t1,a0
	add	a6,a6,s6
	mul	t3,a7,s1
	add	a4,a6,a4
	lw	s1,40(sp)
	lw	t2,8(sp)
	mul	a7,a2,a0
	add	t3,t4,t3
	mul	a0,a2,s3
	add	a7,a3,a7
	mul	a1,a1,t1
	add	a0,a4,a0
	lw	a4,44(sp)
	mul	t1,t1,s1
	add	a1,t3,a1
	lw	t3,52(sp)
	mul	a3,a2,s1
	add	a5,a5,t1
	mul	a2,a2,a4
	add	a1,a1,a3
	add	a2,a5,a2
	mul	a5,t3,s2
	mul	a4,s2,a4
	add	a5,a0,a5
	mv	t4,a5
	mul	s9,s9,s2
	add	a5,a1,a4
	sw	a5,12(sp)
	mul	s3,s2,s3
	add	a5,a2,s9
	sw	a5,16(sp)
	lw	a5,72(sp)
	add	a3,a7,s3
	sw	a3,20(sp)
	bne	a5,t2,.L28
	mv	a5,a3
	bge	a3,t4,.L17
	mv	a5,t4
.L17:
	lw	a4,12(sp)
	bge	a5,a4,.L18
	mv	a5,a4
.L18:
	lw	a4,16(sp)
	bge	a5,a4,.L15
	mv	a5,a4
.L15:
	lw	a4,124(sp)
	sw	a5,0(a4)
	addi	a4,a4,4
	sw	a4,124(sp)
	lw	a4,116(sp)
	lw	a5,120(sp)
	addi	a4,a4,2
	sw	a4,116(sp)
	lw	a4,128(sp)
	addi	a5,a5,1
	sw	a5,120(sp)
	bgt	a4,a5,.L20
	lw	a3,144(sp)
	lw	a5,152(sp)
	lw	a2,24(sp)
	add	a3,a3,a4
	sw	a3,144(sp)
	lw	a3,148(sp)
	addi	a5,a5,1
	sw	a5,152(sp)
	add	a3,a3,a2
	sw	a3,148(sp)
	bgt	a4,a5,.L21
	lw	a4,156(sp)
	lw	a3,172(sp)
	lw	a5,132(sp)
	add	a4,a4,a3
	sw	a4,156(sp)
	lw	a4,76(sp)
	addi	a5,a5,1
	sw	a5,132(sp)
	bne	a4,a5,.L14
.L12:
	lw	ra,220(sp)
	lw	a0,164(sp)
	lw	s1,216(sp)
	lw	s2,212(sp)
	lw	s3,208(sp)
	lw	s4,204(sp)
	lw	s5,200(sp)
	lw	s6,196(sp)
	lw	s7,192(sp)
	lw	s8,188(sp)
	lw	s9,184(sp)
	lw	s10,180(sp)
	lw	s11,176(sp)
	addi	sp,sp,224
	jr	ra
.L22:
	li	a5,0
	j	.L15
	.size	Base_conv_mp, .-Base_conv_mp
	.align	1
	.globl	error_check
	.type	error_check, @function
error_check:
	ble	a2,zero,.L32
	slli	a2,a2,2
	mv	a4,a0
	add	a2,a0,a2
	li	a0,0
.L31:
	lw	a3,0(a1)
	lw	a5,0(a4)
	addi	a4,a4,4
	addi	a1,a1,4
	sub	a5,a5,a3
	srai	a3,a5,31
	xor	a5,a3,a5
	sub	a5,a5,a3
	add	a0,a0,a5
	bne	a2,a4,.L31
	ret
.L32:
	li	a0,0
	ret
	.size	error_check, .-error_check
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
	addi	sp,sp,-64
	li	a0,16384
	sw	ra,60(sp)
	sw	s1,56(sp)
	sw	s2,52(sp)
	sw	s3,48(sp)
	sw	s4,44(sp)
	sw	s5,40(sp)
	sw	s6,36(sp)
	sw	s7,32(sp)
	sw	s8,28(sp)
	call	malloc
	mv	s1,a0
	li	a0,36864
	call	malloc
	mv	s2,a0
	li	a5,0
	li	a3,36
	li	a4,16384
.L35:
	rem	a2,a5,a3
	add	a1,s1,a5
	addi	a5,a5,1
	addi	a2,a2,1
	sb	a2,0(a1)
	bne	a5,a4,.L35
	li	a5,0
	li	a3,7
	li	a4,36864
.L36:
	rem	a2,a5,a3
	add	a1,s2,a5
	addi	a5,a5,1
	addi	a2,a2,-5
	sb	a2,0(a1)
	bne	a5,a4,.L36
	sw	zero,12(sp)
 #APP
# 109 "../include/custom.h" 1
	rdcycle s7
# 0 "" 2
 #NO_APP
	li	a5,262144
	li	a4,1024
	addi	a5,a5,1
 #APP
# 18 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 0, 0, a4, a4, a5
# 0 "" 2
 #NO_APP
	li	a5,0
	li	a4,18
 #APP
# 6 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 2, 4, a4, a4, a5
# 0 "" 2
 #NO_APP
	li	a4,20
 #APP
# 6 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 2, 4, a4, a4, a5
# 0 "" 2
 #NO_APP
	li	a4,22
 #APP
# 6 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 2, 4, a4, a4, a5
# 0 "" 2
 #NO_APP
	li	a4,24
 #APP
# 6 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 2, 4, a4, a4, a5
# 0 "" 2
# 28 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 0, 1, a4, s2, s1
# 0 "" 2
 #NO_APP
	li	a4,2
 #APP
# 75 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 2, 1, a4, a4, a5
# 0 "" 2
 #NO_APP
	li	a1,1
	addi	a0,sp,12
	call	POOL_WB_INT
	addi	a0,sp,12
	li	a1,2
	lw	s8,12(sp)
	call	POOL_WB_INT
	addi	a0,sp,12
	li	a1,3
	lw	s5,12(sp)
	call	POOL_WB_INT
	li	a1,4
	addi	a0,sp,12
	lw	s4,12(sp)
	call	POOL_WB_INT
	lw	s3,12(sp)
 #APP
# 109 "../include/custom.h" 1
	rdcycle s6
# 0 "" 2
 #NO_APP
	li	a2,4
	mv	a4,s2
	mv	a3,s1
	li	a1,1024
	li	a0,4
	call	Base_conv_mp
	lw	a3,4(a0)
	lw	a2,0(a0)
	lw	a4,8(a0)
	lw	a5,12(a0)
	sub	a3,s5,a3
	sub	a2,s8,a2
	srai	a7,a3,31
	srai	a6,a2,31
	sub	a4,s4,a4
	xor	a3,a7,a3
	xor	a2,a6,a2
	sub	a5,s3,a5
	srai	a0,a4,31
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
	lw	ra,60(sp)
	lw	s1,56(sp)
	lw	s2,52(sp)
	lw	s3,48(sp)
	lw	s4,44(sp)
	lw	s5,40(sp)
	lw	s6,36(sp)
	lw	s7,32(sp)
	lw	s8,28(sp)
	li	a0,0
	addi	sp,sp,64
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
	.word	1090650112
.LC4:
	.word	858993459
	.word	1070805811
.LC5:
	.string	"GOPS:%.4f\n"
	.ident	"GCC: (GNU) 11.1.0"
