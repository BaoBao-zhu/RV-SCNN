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

uint8_t* Base_SNN_conv(int Vth, int inside, int c_in, int c_out, uint8_t *pinputs, int8_t *pfilters, int *bias){
    //reshape the input to gemm
    int oside = inside -2;
    uint8_t *inCache = (uint8_t *)calloc(oside*oside*9*c_in,sizeof(uint8_t));

	int a = oside*oside;
	int b = inside*inside;

    for(int m=0;m<c_in;m++){
        for(int i=0;i<oside;i++){
            for(int j=0;j<oside;j++){
                inCache[j+i*oside+m*9*a] = pinputs[i*inside+j+m*b];
                inCache[j+i*oside+(m*9+1)*a] = pinputs[i*inside+j+m*b+1];
                inCache[j+i*oside+(m*9+2)*a] = pinputs[i*inside+j+m*b+2];

                inCache[j+i*oside+(m*9+3)*a] = pinputs[(i+1)*inside+j+m*b];
                inCache[j+i*oside+(m*9+4)*a] = pinputs[(i+1)*inside+j+m*b+1];
                inCache[j+i*oside+(m*9+5)*a] = pinputs[(i+1)*inside+j+m*b+2];

                inCache[j+i*oside+(m*9+6)*a] = pinputs[(i+2)*inside+j+m*b];
                inCache[j+i*oside+(m*9+7)*a] = pinputs[(i+2)*inside+j+m*b+1];
                inCache[j+i*oside+(m*9+8)*a] = pinputs[(i+2)*inside+j+m*b+2];
            }
        }
    }
    //use GEMM to cal
	uint8_t *poutputs;
	poutputs = Base_SNN_gemm(c_out,oside*oside,9*c_in,pfilters,inCache,bias,Vth);

    free(inCache);
    return poutputs;
}

uint8_t* Base_SNN_pool(int inside, int c_in, uint8_t *pinputs){
    int oside = inside/2;
    uint8_t * poutputs = (uint8_t*)calloc(oside*oside*c_in,sizeof(uint8_t));
    for(int m=0;m<c_in;m++){
        for(int i=0;i<oside;i++){
            for(int j=0;j<oside;j++){
                poutputs[j+i*oside+m*oside*oside] = pinputs[i*2*inside+j*2+m*inside*inside] | pinputs[i*2*inside+j*2+m*inside*inside+1] | pinputs[i*2*inside+j*2+m*inside*inside+inside] |pinputs[i*2*inside+j*2+m*inside*inside + inside+1];
            }
        }
    }

    return poutputs;
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
    int inside = 4;
    int c_out = 4;
    int c_in = 1024; //16 32 64 128 256 ......


    int Vth = 20;
    int8_t *input_matrix = (int8_t *)malloc(inside*inside*c_in*sizeof(int8_t));
    int8_t *filter_matrix = (int8_t *)malloc(3*3*c_in*c_out*sizeof(int8_t));
    int * bias = (int *)malloc(c_out*sizeof(int));

    for(int i=0;i<inside*inside*c_in;i++){
        input_matrix[i] = -13 + i%9;     //random input
    }

    for(int i=0;i<3*3*c_in*c_out;i++){
        filter_matrix[i] = -5 + i%7;    //random input
    }

    for(int i=0;i<c_out;i++){
        bias[i] = -50 + i%207;          //random bias
    }

    //set
    int oside = inside-2;
	int c_out_num = c_out>>2;
	int tile = 1 + (inside-4)/2;	

	uint8_t *poutputs = (uint8_t *)malloc(tile*tile*c_out*sizeof(uint8_t));
	uint8_t *oCache = (uint8_t*)malloc(4*sizeof(uint8_t));

    /////////////////////////////////////////////////////////////////////////////////////////
	int shiftnum = 2;
	int Vth_new = Vth<<2 + shiftnum; 
    //fast snn_conv_pool
    int t1 = record();
    L_SCNN(c_in,inside,oside*oside,Vth_new);
	for(int i=0;i<c_out_num;i++){
		L_MODE(1,1,bias[4*i],1);
		L_MODE(1,2,bias[4*i+1],1);
		L_MODE(1,3,bias[4*i+2],1);
		L_MODE(1,4,bias[4*i+3],1);

		for(int m=0;m<tile;m++){
			for(int n=0;n<tile;n++){
				SCNN4x4(filter_matrix+36*c_in*i,input_matrix+n*2+m*2*inside);
				POOL(3);
				POOL_WB(oCache);
				poutputs[n+m*tile+4*i*tile*tile] = oCache[0];
				poutputs[n+m*tile+(4*i+1)*tile*tile] = oCache[1];
				poutputs[n+m*tile+(4*i+2)*tile*tile] = oCache[2];
				poutputs[n+m*tile+(4*i+3)*tile*tile] = oCache[3];
			}
		}
	}
    int t2 = record();
    free(oCache);
    /////////////////////////////////////////////////////////////////////////////////////////

    //error check: whether the result is same with RV32IM ?
    int8_t *base_out0 = Base_SNN_conv(Vth, inside, c_in, c_out, input_matrix, filter_matrix, bias);
    int8_t *base_out = Base_SNN_pool(inside-2, c_out, base_out0);
    free(base_out0);
    int error = error_check_int8(poutputs, base_out, tile*tile*c_out);
    
    //Fast GOPS Calculation
    float GOPS = (((c_out*2*2*(c_in*3*3)*8 + 7)*1.0/(t2-t1))) * 0.3; //1 OP = 1 &AND + 1 ADD //300MHz

    printf("inside:%d c_in:%d c_out:%d\n",inside,c_in,c_out);
    printf("error:%d\n",error);
    printf("cycle count::%d\n",t2-t1);
    printf("GOPS:%.4f\n",GOPS);
        
    return 0;
}

//GOPS
//inside=4 c_out=4
//c_in=1024  GOPS:26.46
//c_in=512   GOPS:26.35
//c_in=256   GOPS:26.12
//c_in=128   GOPS:25.66
//c_in=64    GOPS:24.82
//c_in=32    GOPS:23.28
//c_in=16    GOPS:20.64