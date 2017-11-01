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
 	FILE *fp1;//定义文件流指针，用于打开读取的文件  
	fp1 = fopen(Dir,"wb");//只读方式打开文件Dir.txt   
	fputs(Str,fp1);  
	fclose(fp1);//关闭文件a.txt，有打开就要有关闭 
 	return 0;
}






#endif

 
