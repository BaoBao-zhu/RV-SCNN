#include<stdio.h>
#include<stdlib.h>
#include<stdint.h>
#include "../include/custom.h"

int* Base_conv_mp(int inside, int c_in, int c_out, int8_t *pInputs, int8_t *pFilters){
    int oside = (inside - 2)/2;//after maxpool
	int *poutputs = (int *)calloc(oside*oside*c_out,sizeof(int));
    
    int num = oside;
    for(int x=0;x<c_out;x++){
        //cal the current layer(c_in) out
        for(int i=0;i<num;i++){
            for(int j=0;j<num;j++){
                int a[4] = {0,0,0,0};
                for(int m=0;m<c_in;m++){//add
                    for(int my=0;my<2;my++){
                        for(int mx=0;mx<2;mx++){
                            a[mx+my*2]+=(pFilters[x + m*9*c_out + 0*c_out]*pInputs[m*inside*inside+2*j+2*i*inside+mx+my*inside]);
                            a[mx+my*2]+=(pFilters[x + m*9*c_out + 1*c_out]*pInputs[m*inside*inside+2*j+2*i*inside+1+mx+my*inside]);
                            a[mx+my*2]+=(pFilters[x + m*9*c_out + 2*c_out]*pInputs[m*inside*inside+2*j+2*i*inside+2+mx+my*inside]);

                            a[mx+my*2]+=(pFilters[x + m*9*c_out + 3*c_out]*pInputs[m*inside*inside+2*j+2*i*inside+inside+mx+my*inside]);
                            a[mx+my*2]+=(pFilters[x + m*9*c_out + 4*c_out]*pInputs[m*inside*inside+2*j+2*i*inside+inside+1+mx+my*inside]);
                            a[mx+my*2]+=(pFilters[x + m*9*c_out + 5*c_out]*pInputs[m*inside*inside+2*j+2*i*inside+inside+2+mx+my*inside]);

                            a[mx+my*2]+=(pFilters[x + m*9*c_out + 6*c_out]*pInputs[m*inside*inside+2*j+2*i*inside+2*inside+mx+my*inside]);
                            a[mx+my*2]+=(pFilters[x + m*9*c_out + 7*c_out]*pInputs[m*inside*inside+2*j+2*i*inside+2*inside+1+mx+my*inside]);
                            a[mx+my*2]+=(pFilters[x + m*9*c_out + 8*c_out]*pInputs[m*inside*inside+2*j+2*i*inside+2*inside+2+mx+my*inside]);
                        }
                    }
                }
                int b = 0;
                if(a[0]<a[1]) b=a[1];
                else b=a[0];
                if(b<a[2]) b=a[2];
                if(b<a[3]) b=a[3];

                poutputs[x*oside*oside + j + i*num] = b;
            }
        }
    }
	
	return poutputs;
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
    int inside = 4;
    int c_out = 4;
    int c_in = 1024; //16 32 64 128 256 ......


    int8_t *input_matrix = (int8_t *)malloc(inside*inside*c_in*sizeof(int8_t));
    int8_t *filter_matrix = (int8_t *)malloc(3*3*c_in*c_out*sizeof(int8_t));

    for(int i=0;i<inside*inside*c_in;i++){
        input_matrix[i] = 1 + i%36;  //random input
    }


    for(int i=0;i<3*3*c_in*c_out;i++){
        filter_matrix[i] = -5 + i%7;   //random input
    }

    //set
    int oside = (inside - 2)/2;//after maxpool
    int *out1 = (int *)calloc(oside*oside*c_out,sizeof(int));
    int chn_num =  c_out>>2;
    int tile = 1 + (inside-4)/2;
    int a=0;

    /////////////////////////////////////////////////////////////////////////////////////////
    //fast conv_mp
    int t1 = record();
    L_SCNN(c_in,inside,oside*oside,0);
	for(int i=0;i<chn_num;i++){
		L_MODE(0,1,0,1);
		L_MODE(0,2,0,1);
		L_MODE(0,3,0,1);
		L_MODE(0,4,0,1);

		for(int m=0;m<tile;m++){
			for(int n=0;n<tile;n++){
				SCNN4x4(filter_matrix+36*c_in*i,input_matrix+n*2+m*2*inside);
                POOL(2);//cnn maxpool

                POOL_WB_INT(&a,1);
				out1[n + m*oside + 4*i*oside*oside] = a;
                POOL_WB_INT(&a,2);
                out1[oside*oside + n + m*oside + 4*i*oside*oside] = a;
                POOL_WB_INT(&a,3);
                out1[2*oside*oside + n + m*oside + 4*i*oside*oside] = a;
                POOL_WB_INT(&a,4);
                out1[3*oside*oside + n + m*oside + 4*i*oside*oside] = a;
			}
		}
	}
    int t2 = record();
    /////////////////////////////////////////////////////////////////////////////////////////

    //error check: whether the result is same with RV32IM ?
    int *base_out = Base_conv_mp(inside,c_in,c_out,input_matrix,filter_matrix);
    int error = error_check(out1, base_out, oside*oside*c_out);
    
    //Fast GOPS Calculation
    float GOPS = (((c_out*(inside-2)*(inside-2)*(c_in*3*3))*1.0/(t2-t1))) * 0.3; //1 OP = 1 MAC //300MHz

    printf("inside:%d c_in:%d c_out:%d\n",inside,c_in,c_out);
    printf("error:%d\n",error);
    printf("cycle count::%d\n",t2-t1);
    printf("GOPS:%.4f\n",GOPS);
        
    return 0;
}

//GOPS
//inside=4 c_out=4
//c_in=1024  GOPS:3.2949
//c_in=512   GOPS:3.2671
//c_in=256   GOPS:3.2130
//c_in=128   GOPS:3.1100
//c_in=64    GOPS:2.9226
//c_in=32    GOPS:2.6083
//c_in=16    GOPS:2.5246