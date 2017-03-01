%module pjsua

%{
#include "pjsua.h"
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
