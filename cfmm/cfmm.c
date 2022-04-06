#include <stdio.h>
#include <math.h>
#include <assert.h>
#include "cfmm.h"
#include "macro.h"

REALadd cfmm(int old_add)
{
    REALadd p_ans;
    ll B = R * PAR_D; //number of banks
    // ll T = (int) (log(N) / log(R)); // total digit width of old address
    ll T = 30; // total digit width of old address
    ll M = (int) (log(B) / log(R)); // digit width of bank number
    ll C = T - M; // digit width of step size
    //printf("B:%lld, T:%lld, M:%lld, C:%lld", B, T, M, C);
    ll lower_part = BITS(old_add, M-1, 0);
    ll higher_part = BITS(old_add, T-1, T-C);

    ll SN =  BITS(higher_part, 0, 0);
    for(ll i = 1;i <= C-1;i++)
    {
        SN = SN ^ BITS(higher_part, i, i); // SN = herigher part在R进制下各位和mod R。当R = 2时，就是位缩减异或
    }
    ll BI = (lower_part + SN * PAR_D) % B;
    ll BA = old_add >> M;
    // printf("%lld% lld% lld\n", SN, BI, BA);
    // printf("BA:%lld,  BI:%lld; \n", BA, BI);

    p_ans.BA = BA;
    p_ans.BI = BI;
    return p_ans;
}

void checkidx(REALadd p1, REALadd p2, REALadd p3, REALadd p4)
{
    assert(p1.BI != p2.BI); 
    assert(p1.BI != p3.BI);
    assert(p1.BI != p4.BI);
    assert(p2.BI != p3.BI);
    assert(p2.BI != p4.BI);
    assert(p3.BI != p4.BI);
    return;
}
