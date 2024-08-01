#include<stdio.h>
#include<stdlib.h>
#include<stdint.h>
#include "../include/custom.h"
#define ithBit(num,i) ( (num & (1 << i) ) ? 1 : 0 )

uint8_t* Base_SNN_gemm (int M,int N, int K, int8_t *A, int8_t *B, int *bias, int Vth){
	uint8_t *C = (uint8_t *)calloc(M*N,sizeof(uint8_t));

	short *buffer0 = (short *)calloc(M*N,sizeof(short));
	short *buffer1 = (short *)calloc(M*N,sizeof(short));
	short *buffer2 = (short *)calloc(M*N,sizeof(short));
	short *buffer3 = (short *)calloc(M*N,sizeof(short));
	short *buffer4 = (short *)calloc(M*N,sizeof(short));
	short *buffer5 = (short *)calloc(M*N,sizeof(short));
	short *buffer6 = (short *)calloc(M*N,sizeof(short));
	short *buffer7 = (short *)calloc(M*N,sizeof(short));

	for(int j=0;j<M;j++){
		for(int i=0;i<N;i++){
			buffer0[i+j*N] = bias[j];
			buffer1[i+j*N] = bias[j];
			buffer2[i+j*N] = bias[j];
			buffer3[i+j*N] = bias[j];
			buffer4[i+j*N] = bias[j];
			buffer5[i+j*N] = bias[j];
			buffer6[i+j*N] = bias[j];
			buffer7[i+j*N] = bias[j];
		}
	}

	for(int x=0;x<K;x++){
		for(int i=0;i<M;i++){
			for(int j=0;j<N;j++){
				buffer0[j+i*N] += ithBit(B[j+x*N],0)*A[i+x*M];
				buffer1[j+i*N] += ithBit(B[j+x*N],1)*A[i+x*M];
				buffer2[j+i*N] += ithBit(B[j+x*N],2)*A[i+x*M];
				buffer3[j+i*N] += ithBit(B[j+x*N],3)*A[i+x*M];
				buffer4[j+i*N] += ithBit(B[j+x*N],4)*A[i+x*M];
				buffer5[j+i*N] += ithBit(B[j+x*N],5)*A[i+x*M];
				buffer6[j+i*N] += ithBit(B[j+x*N],6)*A[i+x*M];
				buffer7[j+i*N] += ithBit(B[j+x*N],7)*A[i+x*M];
				// C[j+i*N] += A[i+x*M]*B[j+x*N];
			}
		}
	}

	for(int i=0;i<M*N;i++){
		//0
		if(buffer0[i] > Vth){
			C[i] += 1;
		}else{
			buffer1[i] += (buffer0[i]>>2);
		}
		//1
		if(buffer1[i] > Vth){
			C[i] += 2;
		}else{
			buffer2[i] += (buffer1[i]>>2);
		}
        //2
		if(buffer2[i] > Vth){
			C[i] += 4;
		}else{
			buffer3[i] += (buffer2[i]>>2);
		}
		//3
		if(buffer3[i] > Vth){
			C[i] += 8;
		}else{
			buffer4[i] += (buffer3[i]>>2);
		}
		//4
		if(buffer4[i] > Vth){
			C[i] += 16;
		}else{
			buffer5[i] += (buffer4[i]>>2);
		}
		//5
		if(buffer5[i] > Vth){
			C[i] += 32;
		}else{
			buffer6[i] += (buffer5[i]>>2);
		}
		//6
		if(buffer6[i] > Vth){
			C[i] += 64;
		}else{
			buffer7[i] += (buffer6[i]>>2);
		}
		//7
		if(buffer7[i] > Vth){
			C[i] += 128;
		}else{}
	}

	free(buffer0);
	free(buffer1);
	free(buffer2);
	free(buffer3);
	free(buffer4);
	free(buffer5);
	free(buffer6);
	free(buffer7);

	return C;
}

int error_check_int8(int8_t* test1, int8_t* test2, int num){
    int error = 0;
    for(int i=0;i<num;i++){
        error += abs(test1[i] - test2[i]);
    }

    return error;
}

int main(){
    //////////////////////////////////////////////gemm
    int M = 4;
    int N = 4;
    int K = 16;

    int8_t *A_matrix = (int8_t *)malloc(M*K*sizeof(int8_t));
    int8_t *B_matrix = (int8_t *)malloc(N*K*sizeof(int8_t));
    int *bias = (int *)malloc(N*sizeof(int));

    int Vth = 200;
    for(int i=0;i<M*K;i++){
        A_matrix[i] = -7 + i%20;  //random input A
    }

    for(int i=0;i<N*K;i++){
        B_matrix[i] = -5 + i%67;  //random input B
    }

    for(int i=0;i<M;i++){
        bias[i] = -30 + i%207;          //random bias
    }

	int M_num = M>>2;
	int N_num = N>>2;
	//M,N is the multiple of 4
	int8_t *out1 = (int8_t *)malloc(M*N*sizeof(int8_t));
	
	//Fast GEMM Record
	///////////////////////////////////////////////////////////////////////
	int shiftnum = 2;//default
	int Vth_new = Vth<<2 + shiftnum; //Vth_new[1:0] is the shiftnum
	int t1 = record();
	L_SCNN(K,M,N,Vth_new);
	for(int i=0;i<M_num;i++){
        L_MODE(1,1,bias[4*i],0);
		L_MODE(1,2,bias[4*i+1],0);
		L_MODE(1,3,bias[4*i+2],0);
		L_MODE(1,4,bias[4*i+3],0);
		for(int j=0;j<N_num;j++){
			SCNN4x4(A_matrix+4*i,B_matrix+4*j);
			SCNN_WB(out1+j*4+i*4*N);
		}
	}
    int t2 = record();
	//////////////////////////////////////////////////////////////////////

	//error check: whether the result is same with RV32IM ?
    int8_t *base_out = Base_SNN_gemm(M,N,K,A_matrix,B_matrix,bias,Vth);
    int error = error_check_int8(out1, base_out, M*N);
    
	//Fast GOPS Calculation
    float GOPS = ((8*M*N*K*1.0+7)/(t2-t1)) * 0.3; //1 OP = 1 &AND + 1 ADD //300MHz

	//Messege Print
    printf("M:%d N:%d K:%d\n",M,N,K);
    printf("error:%d\n",error);
    printf("cycle count:%d\n",t2-t1);
    printf("GOPS:%.4f\n",GOPS);


	free(A_matrix);
	free(B_matrix);
	free(out1);
	free(base_out);
        
    return 0;
}

//GOPS
//M=4 N=4
//K=1024  GOPS:18.7256
//K=512   GOPS:18.2911
//K=256   GOPS:17.4335
//K=128   GOPS:15.9653
//K=64    GOPS:13.6650
//K=32    GOPS:10.6112
//K=16    GOPS:7.4277