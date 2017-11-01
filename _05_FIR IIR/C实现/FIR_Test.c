#include <stdio.h>
#include <math.h>
#define	 PI	3.1415926f
#include "StrToFiles.c"
#include "FIR_100_LowPass.h"

#define Nt				8//采集Nt个周期
#define Nn				64//每个周期Nn个点
#define Freq			50//频率
#define NUM_LENTH		(Nt*Nn) //数据长度
#define Fs				(Freq*Nn) //采样频率 

int Matlab_Data(float *num,unsigned Lenth)
{
	char Str[10000] = {0};
	char temp[100] = {0}; 
	int i = 0;
	
	for(i = 0;i < Lenth-1;i ++)
	{ 
		sprintf(temp,"%f\t",num[i]); 
		strcat(Str,temp); 
	} 
	StrToFiles("Data.txt",Str);
	
	return 0;	
}

int max(int x1,int x2)
{
	if(x1 > x2)
		return x1;
	else x2;
}

int min(int x1,int x2)
{
	if(x1 < x2)
		return x1;
	else x2;
}


void convs(float u[],float v[],float w[], int m, int n)
{
   int i, j;
        
   int k = m+n-1;
	
   for(i=0; i<k; i++)
   {
      for(j=max(0,i+1-n); j<=min(i,m-1); j++)
      {     
     	  w[i] += u[j]*v[i-j];
      } 
   }
}

int FIR(float *input,float *h,unsigned int InputLenth,unsigned int hLenth)
{	
	float temp[NUM_LENTH+NUM_LENTH+1] = {0};
	int i = 0;
	
	convs(input,h,temp,InputLenth,hLenth); 
	
	
	for(i = 0;i < NUM_LENTH;i ++) 
		input[i] = temp[i];	 
		
	return 0;
}


int main()
{
	float result[NUM_LENTH] = {0}; 
	int i = 0;
	
	for(i = 0;i < NUM_LENTH;i ++)
	{
		result[i] = (sin(2*PI*i*Nt/NUM_LENTH)/2+0.5) + (sin(2*PI*i*30/NUM_LENTH)/2+0.5)*0.1 - (sin(2*PI*i*60/NUM_LENTH)/2+0.5)*0.2;  
	}
	FIR(result,B,NUM_LENTH,NUM_LENTH);
	
	Matlab_Data(result,NUM_LENTH); 
	
	return 0;	
}







 


