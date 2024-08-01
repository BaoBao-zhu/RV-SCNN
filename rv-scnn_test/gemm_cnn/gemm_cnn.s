	.file	"gemm_cnn.c"
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
	slli	a3,a3,18
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
	.globl	Base_GEMM
	.type	Base_GEMM, @function
Base_GEMM:
	addi	sp,sp,-32
	sw	s3,16(sp)
	mv	s3,a0
	mul	a0,a0,a1
	sw	s1,24(sp)
	mv	s1,a1
	li	a1,4
	sw	s2,20(sp)
	sw	s4,12(sp)
	sw	s5,8(sp)
	sw	ra,28(sp)
	mv	s2,a2
	mv	s5,a3
	mv	s4,a4
	call	calloc
	ble	s3,zero,.L12
	ble	s1,zero,.L12
	mv	t3,s5
	li	t5,0
	li	t4,0
.L15:
	slli	a7,t5,2
	add	a7,a0,a7
	li	t1,0
.L20:
	ble	s2,zero,.L19
	lw	a1,0(a7)
	add	a2,s4,t1
	mv	a3,t3
	li	a4,0
.L16:
	lb	a5,0(a3)
	lb	a6,0(a2)
	addi	a4,a4,1
	add	a3,a3,s3
	mul	a5,a5,a6
	add	a2,a2,s1
	add	a1,a1,a5
	bne	s2,a4,.L16
	sw	a1,0(a7)
.L19:
	addi	t1,t1,1
	addi	a7,a7,4
	bne	s1,t1,.L20
	addi	t4,t4,1
	addi	t3,t3,1
	add	t5,t5,s1
	bne	s3,t4,.L15
.L12:
	lw	ra,28(sp)
	lw	s1,24(sp)
	lw	s2,20(sp)
	lw	s3,16(sp)
	lw	s4,12(sp)
	lw	s5,8(sp)
	addi	sp,sp,32
	jr	ra
	.size	Base_GEMM, .-Base_GEMM
	.align	1
	.globl	error_check
	.type	error_check, @function
error_check:
	ble	a2,zero,.L27
	slli	a2,a2,2
	mv	a4,a0
	add	a2,a0,a2
	li	a0,0
.L26:
	lw	a3,0(a1)
	lw	a5,0(a4)
	addi	a4,a4,4
	addi	a1,a1,4
	sub	a5,a5,a3
	srai	a3,a5,31
	xor	a5,a3,a5
	sub	a5,a5,a3
	add	a0,a0,a5
	bne	a2,a4,.L26
	ret
.L27:
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
	addi	sp,sp,-48
	li	a0,128
	sw	ra,44(sp)
	sw	s1,40(sp)
	sw	s2,36(sp)
	sw	s3,32(sp)
	sw	s4,28(sp)
	sw	s5,24(sp)
	sw	s6,20(sp)
	sw	s7,16(sp)
	sw	s8,12(sp)
	call	malloc
	mv	s2,a0
	li	a0,128
	call	malloc
	mv	s1,a0
	li	a5,0
	li	a1,20
	li	a4,128
.L30:
	rem	a3,a5,a1
	add	a2,s2,a5
	addi	a5,a5,1
	addi	a3,a3,-7
	sb	a3,0(a2)
	bne	a5,a4,.L30
	li	a5,0
	li	a1,67
	li	a4,128
.L31:
	rem	a3,a5,a1
	add	a2,s1,a5
	addi	a5,a5,1
	addi	a3,a3,-5
	sb	a3,0(a2)
	bne	a5,a4,.L31
	li	a0,64
	call	malloc
	mv	s4,a0
 #APP
# 109 "../include/custom.h" 1
	rdcycle s7
# 0 "" 2
 #NO_APP
	li	a5,262144
	li	a4,32
	addi	a5,a5,4
 #APP
# 18 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 0, 0, a4, a4, a5
# 0 "" 2
 #NO_APP
	li	a5,2
	li	a4,0
 #APP
# 6 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 2, 4, a5, a5, a4
# 0 "" 2
# 28 "../include/custom.h" 1
	addi zero,zero,0
.insn r 0x77, 0, 1, a5, s2, s1
# 0 "" 2
 #NO_APP
	call	SCNN_WB
 #APP
# 109 "../include/custom.h" 1
	rdcycle s6
# 0 "" 2
 #NO_APP
	li	a2,32
	mv	a4,s1
	mv	a3,s2
	li	a1,4
	li	a0,4
	call	Base_GEMM
	lw	a6,4(a0)
	lw	a2,0(a0)
	lw	a4,4(s4)
	lw	a7,0(s4)
	lw	a3,8(a0)
	lw	a1,8(s4)
	mv	s3,a0
	lw	a5,12(s4)
	lw	a0,12(a0)
	lw	t0,16(s3)
	sub	a4,a4,a6
	sub	a7,a7,a2
	lw	a2,16(s4)
	lw	t6,20(s3)
	srai	t3,a4,31
	sub	a1,a1,a3
	srai	t1,a7,31
	lw	a3,20(s4)
	lw	t5,24(s3)
	srai	t4,a1,31
	sub	a5,a5,a0
	xor	a6,t3,a4
	lw	a0,24(s4)
	xor	a7,t1,a7
	srai	t2,a5,31
	sub	a2,a2,t0
	lw	a4,28(s4)
	lw	t0,28(s3)
	sub	a7,a7,t1
	sub	a6,a6,t3
	xor	t3,t4,a1
	srai	t1,a2,31
	sub	a3,a3,t6
	lw	a1,32(s4)
	lw	t6,32(s3)
	sub	t3,t3,t4
	add	a6,a6,a7
	xor	a7,t2,a5
	srai	t4,a3,31
	sub	a0,a0,t5
	lw	a5,36(s4)
	lw	t5,36(s3)
	add	a6,t3,a6
	sub	a7,a7,t2
	xor	t3,t1,a2
	srai	t2,a0,31
	sub	a4,a4,t0
	lw	a2,40(s4)
	lw	t0,40(s3)
	add	a7,a7,a6
	sub	t3,t3,t1
	xor	a6,t4,a3
	srai	t1,a4,31
	sub	a1,a1,t6
	lw	a3,44(s4)
	lw	t6,44(s3)
	add	t3,t3,a7
	sub	a6,a6,t4
	xor	a7,t2,a0
	lw	s5,48(s4)
	srai	t4,a1,31
	sub	a5,a5,t5
	add	a0,a6,t3
	lw	t5,48(s3)
	xor	a6,t1,a4
	sub	a7,a7,t2
	srai	t3,a5,31
	lw	t2,52(s3)
	lw	a4,52(s4)
	sub	a2,a2,t0
	add	a7,a7,a0
	sub	a6,a6,t1
	xor	t1,t4,a1
	srai	t0,a2,31
	lw	a0,56(s3)
	sub	a3,a3,t6
	add	a6,a6,a7
	lw	t6,56(s4)
	xor	a7,t3,a5
	sub	t1,t1,t4
	sub	a1,s5,t5
	srai	t4,a3,31
	lw	t5,60(s3)
	lw	a5,60(s4)
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
	xor	s5,a6,a5
	sub	a4,a4,t1
	add	a3,a3,a2
	lui	s8,%hi(.LANCHOR0)
	add	a5,a4,a3
	sub	s5,s5,a6
	li	a3,32
	li	a2,4
	li	a1,4
	addi	a0,s8,%lo(.LANCHOR0)
	add	s5,s5,a5
	addi	s8,s8,%lo(.LANCHOR0)
	call	printf
	mv	a1,s5
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
	mv	a0,s2
	call	free
	mv	a0,s1
	call	free
	mv	a0,s4
	call	free
	mv	a0,s3
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
	.word	1082130432
.LC4:
	.word	858993459
	.word	1070805811
.LC5:
	.string	"GOPS:%.4f\n"
	.ident	"GCC: (GNU) 11.1.0"
