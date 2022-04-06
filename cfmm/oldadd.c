#include <stdio.h>
#include <math.h>
#include "oldadd.h"
#include "macro.h"
#include "cfmm.h"
#include "mod_cal.h"

REALadd p1, p2, p3, p4;

ll test_data[256] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29,
         30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57,
         58, 59, 60, 61, 62, 63,
         64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91,
         92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115,
         116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127,
         128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149,
         150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171,
         172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184,
         185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206,
         207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228,
         229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250,
         251, 252, 253, 254, 255};
ll gamma_256[256] = {6421, 2655, 6554, 723, 174, 1693, 9280, 7535, 10431, 426, 3315, 9364, 11942, 3757, 1975, 11026, 12240, 6374, 1483, 1583, 6347, 2500, 10800, 9087, 7796, 5369, 2057, 10474, 6906, 1512, 11939, 9928, 10446, 9259, 4115, 9381, 218, 8760, 3434, 1954, 2051, 1805, 2882, 3963, 11713, 2447, 6147, 4774, 6860, 4737, 1293, 11871, 8517, 6381, 11836, 5876, 2281, 10258, 6956, 8320, 3991, 9522, 12133, 1958, 7967, 10211, 11177, 8210, 1058, 11848, 11367, 8243, 709, 1319, 9139, 11454, 6224, 8719, 4240, 10542, 9166, 9235, 5486, 3834, 5257, 7856, 5919, 11606, 9830, 8633, 12225, 2948, 9786, 1566, 5782, 8527, 2919, 8273, 8212, 5766, 11637, 295, 6190, 1146, 11341, 11964, 10885, 6299, 1159, 8240, 8561, 11089, 7105, 9734, 6167, 3956, 1360, 6170, 6992, 9597, 168, 7991, 8960, 5106, 6328, 1962, 1594, 6427, 6136, 6874, 3643, 400, 1728, 4948, 6137, 8724, 11635, 10587, 1987, 9090, 12233, 5529, 5206, 6950, 5446, 6093, 3710, 11907, 316, 8301, 468, 1254, 11316, 5435, 1359, 10367, 8410, 3998, 2033, 9606, 1190, 8471, 6118, 5445, 3860, 7753, 1050, 7540, 5537, 4789, 4467, 5456, 7840, 147, 8500, 10120, 11767, 7210, 9027, 4324, 4916, 5315, 8214, 8775, 1041, 1018, 6364, 11011, 2344, 5574, 10316, 8851, 2844, 975, 4212, 5681, 8812, 12147, 11184, 7280, 1956, 11404, 6008, 12048, 12231, 3532, 1003, 8076, 11785, 605, 9987, 9260, 5594, 6403, 7507, 421, 8209, 6068, 3602, 7665, 6077, 3263, 8689, 2049, 7377, 10968, 192, 3445, 7509, 7591, 7232, 787, 8807, 1010, 6821, 9162, 8120, 9369, 7048, 12237, 9115, 1323, 2766, 6234, 3336, 677, 5874, 2505, 5906, 10710, 11858, 8332, 9450, 10162, 151};

void DIF() //stage:p, group:k, round j
{
    int r = 0;
    //for(int p = 0; p <=(int) (log(N-1)/log(2)); p++)
    for(int p = (int) (log(N-1)/log(2)); p >=0; p--)
    {
        int J = 1 << p;
        for(int k = 0; k<=(int) (N / (2*J) - 1); k++)
        {
            printf("gamma:%d\n", r);
            r++;
            for(int j = 0; j <= J-1; j++)
            {
                printf("Stage:%d, Group:%d, Round:%d; ", p, k, j);
                printf("idx1:%d, idx2:%d\n", 2*k*J+j, 2*k*J+j+J);
            }
        }
    }
    return;
}

void DIF_2d_native() //stage:p, group:k, round j
{
    for(int p = (int) (log(N-1)/log(2)); p >=0; p--)
    {
        int J = 1 << p;
        if(J < PAR_D)
        {
            printf("J < d\n");
            for(int k = 0; k<=(int) (N / (R*PAR_D) - 1); k++)
            {
                for(int i = 0; i <= (int) (PAR_D / J - 1); i++)
                {
                    for(int j = 0; j <= J-1; j++)
                    {
                        // printf("Stage:%d, Group:%d, Round:%d; ", p, k, j);
                        // printf("idx:%d,\tidx:%d\t", k*R*PAR_D+i*R*J+j, k*R*PAR_D+i*R*J+j+J);
                        printf("idx:%d,\t", k*R*PAR_D+i*R+j);
                        printf("idx:%d\t",  k*R*PAR_D+i*R+j+J);
                    }
                }
                printf("\n");
            }
        }
        else
        {
            for(int k = 0; k<=(int) (N / (R*J) - 1); k++)
            {
                for(int i = 0; i <= (int) (J / PAR_D - 1); i++)
                {
                    for(int j = 0; j <= PAR_D-1; j++)
                    {
                        // printf("Stage:%d, Group:%d, Round:%d; ", p, k, j);
                        printf("idx:%d,\t", k*R*J+i*PAR_D+j);
                        printf("idx:%d\t",  k*R*J+i*PAR_D+j+J);
                    }
                    printf("\n");
                }
            }
        }
    }
    return;
}

//对于gamma，前N/2 - 2个在一个bank中，后N/2个的奇数也在那个bank中，偶数在另一个bank中
void DIF_2d_spec() //stage:p, group:k, round j
{
    int r = 0;
    int p = 0;int k = 0;int i = 0;
    // for(p = 0; p <=(int) (log(N-1)/log(2)); p++)
    for(p = (int) (log(N-1)/log(2)); p >=0; p--)
    {
        int J = 1 << p;
        if(p == 0)
        {
            printf("Last Stage!\n");
            for(k = 0; k <= (N / 4) - 1; k++)
            {
                p1 = cfmm((k<<2));
                p2 = cfmm((k<<2)+1);
                p3 = cfmm((k<<2)+2);
                p4 = cfmm((k<<2)+3);
                printf("Stage:%d, Group:%d, Round:%d ", p, k, i);
                printf("idx1:%4d, ", (k << 2));
                printf("idx2:%4d, ", (k << 2) + 1);
                printf("gamma:%4d ", r);
                ll gamma1 = gamma_256[r];
                printf("idx3:%4d, ", (k << 2) + 2);
                printf("idx4:%4d, ", (k << 2) + 3);
                printf("gamma:%4d;\n", r+1);
                ll gamma2 = gamma_256[r+1];
                ll in1 = test_data[(k<<2)];
                ll in2 = test_data[(k<<2)+1];
                ll in3 = test_data[(k<<2)+2];
                ll in4 = test_data[(k<<2)+3];
                ll out1 = Mod_add(in1, Montgomery(in2, gamma_256[r]), P);
                ll out2 = Mod_sub(in1, Montgomery(in2, gamma_256[r++]), P);
                ll out3 = Mod_add(in3, Montgomery(in4, gamma_256[r]), P);
                ll out4 = Mod_sub(in3, Montgomery(in4, gamma_256[r++]), P);
                printf("%lld %lld %lld %lld ---> %lld %lld %lld %lld use gamma1:%lld gamma2:%lld\n", in1, in2, in3, in4, out1, out2, out3, out4, gamma1, gamma2);
                test_data[(k<<2)]=out1;
                test_data[(k<<2)+1]=out2;
                test_data[(k<<2)+2]=out3;
                test_data[(k<<2)+3]=out4;
                // printf("idx1~4:%lld%lld%lld%lld\n", p1.BI, p2.BI, p3.BI, p4.BI);
                checkidx(p1, p2, p3, p4);
            }
        }
        else
        {
            for(k = 0; k<=(int) (N / (R*J) - 1); k++)
            {
                for(i = 0; i <= (int) (J / PAR_D - 1); i++)
                {
                    p1 = cfmm(k*R*J+i*PAR_D+0);
                    p2 = cfmm(k*R*J+i*PAR_D+0+J);
                    p3 = cfmm(k*R*J+i*PAR_D+1);
                    p4 = cfmm(k*R*J+i*PAR_D+1+J);
                    printf("Stage:%d, Group:%d, Round:%d; ", p, k, i);
                    printf("idx1:%4d, ", k*R*J+i*PAR_D+0);
                    printf("idx2:%4d, ", k*R*J+i*PAR_D+0+J);
                    printf("idx3:%4d, ", k*R*J+i*PAR_D+1);
                    printf("idx4:%4d, ", k*R*J+i*PAR_D+1+J);
                    printf("gamma:%4d;\n",  r);
                    ll in1 = test_data[k*R*J+i*PAR_D+0];
                    ll in2 = test_data[k*R*J+i*PAR_D+0+J];
                    ll in3 = test_data[k*R*J+i*PAR_D+1];
                    ll in4 = test_data[k*R*J+i*PAR_D+1+J];
                    ll out1 = Mod_add(in1, Montgomery(in2, gamma_256[r]), P);
                    ll out2 = Mod_sub(in1, Montgomery(in2, gamma_256[r]), P);
                    ll out3 = Mod_add(in3, Montgomery(in4, gamma_256[r]), P);
                    ll out4 = Mod_sub(in3, Montgomery(in4, gamma_256[r]), P);
                    printf("%lld %lld %lld %lld ---> %lld %lld %lld %lld use gamma: %lld\n", in1, in2, in3, in4, out1, out2, out3, out4, gamma_256[r]);
                    test_data[k*R*J+i*PAR_D+0]=out1;
                    test_data[k*R*J+i*PAR_D+0+J]=out2;
                    test_data[k*R*J+i*PAR_D+1]=out3;
                    test_data[k*R*J+i*PAR_D+1+J]=out4;
                    // printf("idx1~4:%lld%lld%lld%lld\n", p1.BI, p2.BI, p3.BI, p4.BI);
                    checkidx(p1, p2, p3, p4);
                }
                r++;
            }
        }
    }
    return;
}