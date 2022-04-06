#ifndef CFMM_H_
#define CFMM_H_

typedef struct 
{
    long long BA;
    long long BI;
} REALadd;

//extern REALadd p1, p2, p3, p4;

REALadd cfmm(int old_add);

void checkidx(REALadd p1, REALadd p2, REALadd p3, REALadd p4);

#endif