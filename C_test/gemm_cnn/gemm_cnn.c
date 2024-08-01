#include<stdio.h>
#include<stdlib.h>
#include<stdint.h>
#include "../include/custom.h"

int* Base_GEMM(int M,int N, int K, int8_t *A, int8_t *B){
	int *C = (int *)calloc(M*N,sizeof(int));
	for(int i=0;i<M;i++){
		for(int j=0;j<N;j++){
            for(int m=0;m<K;m++){
                C[i*N+j] += A[i+m*M]*B[j+m*N]; 
            }
		}
	}

	return C;
}

int error_check(int* test1, int* test2, int num){
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
    int K = 32;

    int8_t *A_matrix = (int8_t *)malloc(M*K*sizeof(int8_t));
    int8_t *B_matrix = (int8_t *)malloc(N*K*sizeof(int8_t));

    for(int i=0;i<M*K;i++){
        A_matrix[i] = -7 + i%20;  //random input A
    }

    for(int i=0;i<N*K;i++){
        B_matrix[i] = -5 + i%67;  //random input B
    }

	int M_num = M>>2;
	int N_num = N>>2;
	//M,N is the multiple of 4
	int *out1 = (int *)malloc(M*N*sizeof(int));
	
	//Fast GEMM Record
	///////////////////////////////////////////////////////////////////////
	int t1 = record();
    L_SCNN(K,M,N,0);
    L_MODE(0,1,0,0);
	for(int i=0;i<M_num;i++){
		for(int j=0;j<N_num;j++){
			SCNN4x4(A_matrix+4*i,B_matrix+4*j);
			SCNN_WB_INT(out1+j*4+i*4*N);
		}
	}
    int t2 = record();
	//////////////////////////////////////////////////////////////////////

	//error check: whether the result is same with RV32IM ?
    int *base_out = Base_GEMM(M,N,K,A_matrix,B_matrix);
    int error = error_check(out1, base_out, M*N);
    
	//Fast GOPS Calculation
    float GOPS = (M*N*K*1.0/(t2-t1)) * 0.3; //1 OP = 1 MAC, clock = 300Mhz

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
//K=1024  GOPS:2.3450
//K=512   GOPS:2.2947
//K=256   GOPS:2.1943
//K=128   GOPS:2.0211
//K=64    GOPS:1.7455
//K=32    GOPS:1.3714
//K=16    GOPS:0.9481