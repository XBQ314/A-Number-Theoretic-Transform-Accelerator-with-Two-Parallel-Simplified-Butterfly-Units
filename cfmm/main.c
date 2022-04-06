#include <stdio.h>
#include <stdlib.h>
#include "cfmm.h"
#include "oldadd.h"
#include "macro.h"

int main()
{
    // printf("this is cfmm\n");
    // for(int i = 0;i < N;i++)
    // {
    //     cfmm(i);
    // }

    // DIF();
    // printf("2d oldadd native\n");
    // DIF_2d_native();
    // printf("2d oldadd spec\n");
    DIF_2d_spec();
    return 0;
}