#ifndef PARAM_H_
#define PARAM_H

#define ll long long

#define BITMASK(bits) ((1ull << (bits)) - 1)
#define BITS(x, hi, lo) (((x) >> (lo)) & BITMASK((hi) - (lo) + 1)) // similar to x[hi:lo] in verilog

#define N (ll) 32
#define R 2
#define PAR_D 2
#define P (ll) 12289

#define g (ll) 11
#define K (ll) 30
#define Mon_R (ll) (1<<K)
#define Mon_R_1 (ll) 10561 //R的模逆元是相对于P来说的
#define Mon_mu (ll) 922759167 //mu计算时取的模逆元是相对于R来说的。mu=-P_1 mod R

#endif
