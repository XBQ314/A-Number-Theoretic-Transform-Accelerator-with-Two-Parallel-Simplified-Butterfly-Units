`include "ntt_define.vh"

module mod_add(
	in1,
	in2,
	_p,
	
	out
);

input	wire	[`datawidth-1:0]	in1;
input	wire	[`datawidth-1:0]	in2;
input	wire	[`datawidth-1:0]	_p;

output	wire	[`datawidth-1:0]	out;

//in1+in2=s1
wire	[`datawidth:0]	s1;

assign 	s1={1'b0,in1}+{1'b0,in2};

//s1+_p=s2
wire	[`datawidth:0]	s2;

assign	s2=s1+{1'b0,_p};

//select out depend on the s2[`datawidth]
assign	out=s2[`datawidth]?s2[0+:`datawidth]:s1[0+:`datawidth];

endmodule