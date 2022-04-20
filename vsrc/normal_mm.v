`include "ntt_define.vh"

module normal_mm(
	input	[`datawidth-1:0]in1,
	input	[`datawidth-1:0]in2,
	
	input	[`datawidth-1:0]mu,
	input	[`datawidth-1:0]p,
	input	[`datawidth-1:0]_p,
	
	output	[`datawidth-1:0]out
);

wire	[`datawidth-1:0]	T_H;
wire	[`datawidth-1:0]	T_L;
assign	{T_H, T_L} = in1 * in2;

wire	T_L_flag;
assign	T_L_flag = (|T_L);

wire	[`datawidth-1:0]	c;
assign	c = T_L * mu;

wire	[`datawidth-1:0]	tmp_H;
wire	[`datawidth-1:0]	tmp_L;
assign	{tmp_H, tmp_L} = c*p;

mod_add ma0(
	.in1(T_H),
	.in2(T_L_flag+tmp_H),
	._p(_p),
	
	.out(out));
endmodule