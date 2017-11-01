#include <stdio.h>
#include "StrToFiles.c"
#include "FIR_100_LowPass.h"

int Matlab_Data(float *num,unsigned num_N)
{
	char Str[1000] = {0};
	char temp[100] = {0}; 
	int i = 0;
	
	for(i = 0;i < num_N;i ++)
	{
		sprintf(temp,"%f\t",num[i]);	
		strcat(Str,temp);
	}
	StrToFiles("Data.txt",Str);
}



#define Nt				8//采集Nt个周期
#define Nn				64//每个周期Nn个点
#define Freq			50//频率
#define NUM_LENTH		(Nt*Nn) //数据长度
#define Fs				(Freq*Nn) //采样频率 
int main()
{
	float result[NUM_LENTH] = {0};
	float input[NUM_LENTH] = {0}; 
	
	/* 输入信号 */ 
	for(i = 0;i < NUM_LENTH;i ++)
		input[i] = (sin(2*pi*i*Nt/Lenth)/2+0.5) 
		+ (sin(2*pi*i*30/Lenth)/2+0.5)*0.1 
		- (sin(2*pi*i*60/Lenth)/2+0.5)*0.2;
	
	
	
	
	Matlab_Data(result,NUM_LENTH); 
	return 0;	
}







 


