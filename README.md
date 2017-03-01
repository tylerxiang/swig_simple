# swig_simple
swig(Simplified Wrapper and Interface Generator) very simple demo  

从http://prdownloads.sourceforge.net/swig/swigwin-3.0.12.zip 地址，下载windows版本的swig 3.0.12，解压到C:\，查看版本
C:\swig>swig -version

##建立文本文件pjsua.i ，有枚举、结构、函数等内容，如下：
%module pjsua

%{
\#include "pjsua.h"
%}

enum pj_tyler_t {PJ_XING = 0x01,PJ_MING=0x02};

typedef struct pj_tyler_struct
{
  short freq1;
  int freq2;
  char name[11];
} pj_tyler_struct;

extern int add(int a,int b);
extern int sub(int a1,int b1);

###上述文件中，%module pjsua，表示用pjsua模块名生成C#文件和C文件以此命名。%{ %}之间部分(#include test.h)直接输出到C文件。
##命令行运行swig生成C#文件
#c:\swig\swig -csharp pjsua.i

##以模块名pjsua命名，生成了C#的类文件和C语言的包装文件pjsua_wrap.c。 pjsua.i文件中声明的枚举、结构、函数，要在C语言中相关文件（新建pjsua.h、pjsua.c）实现：定义的枚举pjtyler_t和结构pj_tyler_struct存放在pjsua.h中，两个函数add、sub存放在pjsua.c。

##pjsua.h文件内容如下：
enum pj_tyler_t {PJ_XING = 0x01,PJ_MING=0x02};

typedef struct pj_tyler_struct
{
  short freq1;
  int freq2;
  char name[11];
} pj_tyler_struct;

##pjsua.c文件内容如下：
int add(int a,int b)
{
	return a+b;
}
int sub(int a,int b)
{
	return a-b;
}

##进入VS2015的命令行方式
##运行cl.exe命令，编译pjsua.c、pjsua_wrap.c，生成pjsua.dll
#D:\>cl /LD pjsua.c pjsua_wrap.c

##编写测试类，test.cs
public class test{
	public static void Main(string[] args){
		int ii=pjsua.add(2,3);
		System.Console.WriteLine("2+3={0}",ii);
	}
}
##编译test.cs与生成的其它cs。因为cl命令编译c文件生成的dll为32位，需要在csc命令中加入平台相关参数，否则test.dll调用pjsua.dll时会出错。
#D:\>csc *.cs /platform:x86
#D:\>test.exe
