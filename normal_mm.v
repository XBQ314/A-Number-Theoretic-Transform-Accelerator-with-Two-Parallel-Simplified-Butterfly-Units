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

wire	[`datawidth-1:0]	cp_H;
wire	[`datawidth-1:0]	cp_L;
assign	{cp_H, cp_L} = c*p;

wire	[`datawidth-1:0]	tmp;
assign	tmp = T_H + cp_H;

assign	out = T_L_flag?tmp+1:tmp;
endmodule