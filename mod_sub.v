`include "ntt_define.vh"

module mod_sub(
	in1,
	in2,
	p,
	
	out
);

input	wire	[`datawidth-1:0]	in1;
input	wire	[`datawidth-1:0]	in2;
input	wire	[`datawidth-1:0]	p;

output	wire	[`datawidth-1:0]	out;

//in1-in2=s1
wire	[`datawidth:0]	s1;

assign	s1={1'b0,in1}-{1'b0,in2};

//s1+p=s2
wire	[`datawidth:0]	s2;

assign	s2={1'b0,p}+s1;

//select out depend on the s1[`datawidth]
assign	out=s1[`datawidth]?s2[0+:`datawidth]:s1[0+:`datawidth];

endmodule