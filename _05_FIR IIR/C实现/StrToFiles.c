#include <stdio.h>  
#ifndef		__StrToFiles_C
#define 	__StrToFiles_C

//int main()
//{ 
//	StrToFiles("hello.txt","hello");
//	
//	return 0;
//}

int StrToFiles(char *Dir,char *Str)
{ 
 	FILE *fp1;//�����ļ���ָ�룬���ڴ򿪶�ȡ���ļ�  
	fp1 = fopen(Dir,"wb");//ֻ����ʽ���ļ�Dir.txt   
	fputs(Str,fp1);  
	fclose(fp1);//�ر��ļ�a.txt���д򿪾�Ҫ�йر� 
 	return 0;
}






#endif

 
