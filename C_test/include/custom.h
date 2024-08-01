
void L_MODE(int type, int num, int bias, int model){
	int null;
	int op1 = type + num*2 + model*16; //type 0 is CNN model 0 is traditional
	int op2 = bias; 
	__asm__ __volatile__(
		"addi zero,zero,0\n"
		".insn r 0x77, 2, 4, %[null], %[op1], %[op2]"
		:[null] "=r"(null)
		:[op1]"r"(op1),[op2]"r"(op2)
	);
}

void L_SCNN(int K, int M, int N, int Vth){
	int null;
	int op2 = (M<<16) + N; 
	int op1 = (Vth<<16) + K; //default shift num 2,shift num is in the Vth[1:0] 
	__asm__ __volatile__(
		"addi zero,zero,0\n"
		".insn r 0x77, 0, 0, %[null], %[op1], %[op2]"
		:[null] "=r"(null)
		:[op1]"r"(op1),[op2]"r"(op2)
	);
}

void SCNN4x4(int8_t *addr_A, int8_t *addr_B){
	int null;
	__asm__ __volatile__(
		"addi zero,zero,0\n"
		".insn r 0x77, 0, 1, %[null], %[addr_A], %[addr_B]"
		:[null] "=r"(null)
		:[addr_A]"r"(addr_A),[addr_B]"r"(addr_B)
	);
}

void __attribute__((optimize("O0"))) SCNN_WB(int8_t *addr){
	int n1;
	int n2;
	__asm__ __volatile__(
		"addi zero,zero,0\n"
		".insn r 0x77, 0, 2, %[n1], %[addr], %[n2]"
		:[n1] "=r"(n1)
		:[addr]"r"(addr),[n2]"r"(n2)
		:"memory"
	);
}

void __attribute__((optimize("O0"))) SCNN_WB_INT(int *addr){ //different pointer(int or int8)
	int n1;
	int n2;
	__asm__ __volatile__(
		"addi zero,zero,0\n"
		".insn r 0x77, 0, 2, %[n1], %[addr], %[n2]"
		:[n1] "=r"(n1)
		:[addr]"r"(addr),[n2]"r"(n2)
		:"memory"
	);
}

void POOL_RI(int8_t *addr){
	int n1;
	int n2;
	__asm__ __volatile__(
		"addi zero,zero,0\n"
		".insn r 0x77, 2, 0, %[n1], %[addr], %[n2]"
		:[n1] "=r"(n1)
		:[addr]"r"(addr),[n2]"r"(n2)
		:"memory"
	);
}

void POOL(int model){
	int n1;
	int n2=0;
	__asm__ __volatile__(
		"addi zero,zero,0\n"
		".insn r 0x77, 2, 1, %[n1], %[model], %[n2]"
		:[n1] "=r"(n1)
		:[model]"r"(model),[n2]"r"(n2)
		:"memory"
	);
}

void __attribute__((optimize("O0"))) POOL_WB(int8_t *addr){
	int n1;
	int mode = 0;
	__asm__ __volatile__(
		"addi zero,zero,0\n"
		".insn r 0x77, 2, 2, %[n1], %[addr], %[mode]"
		:[n1] "=r"(n1)
		:[addr]"r"(addr),[mode]"r"(mode)
		:"memory"
	);
}

void __attribute__((optimize("O0"))) POOL_WB_INT(int *addr, int mode){
	int n1;
	__asm__ __volatile__(
		"addi zero,zero,0\n"
		".insn r 0x77, 2, 2, %[n1], %[addr], %[mode]"
		:[n1] "=r"(n1)
		:[addr]"r"(addr),[mode]"r"(mode)
		:"memory"
	);
}

int record(){
	int t1;
	__asm__ __volatile__(
		"rdcycle %[rdcycle]"
		:[rdcycle] "=r"(t1)
	);
	return t1;
}