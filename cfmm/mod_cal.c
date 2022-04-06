#include <stdio.h>
#include "macro.h"
#include "mod_cal.h"

ll postive_mod(ll a, ll b)
{
	return((a%b + b) % b);
}


ll Mod_add(ll a, ll b, ll c)
{
	ll z = (a + b)%c;
	return z;
}

ll Mod_sub(ll a, ll b, ll c)
{
	ll z = postive_mod(a - b, c);
	return z;
}

ll Montgomery(ll x, ll y)
{
	ll T = x * y;
	ll T_H = T >> K;
	ll T_L = (T & (Mon_R - 1));
	ll c = ((T_L * Mon_mu) & (Mon_R - 1));
	ll tmp = (c*P) >> K;
	ll z = 0;
	if (T_L) z = Mod_add(tmp, T_H + 1, P);
	else z = Mod_add(tmp, T_H, P);
	return z;
}