`include "ntt_define.vh"

module old_km(
	input	clk,
	input	rstn,
	input	[`datawidth-1:0]in1,
	input	[`datawidth-1:0]in2,
	
	output	[`datawidth-1:0]out_L,
	output	[`datawidth-1:0]out_H
);
//pre-calculate
wire	[`datawidth/2-1:0]	in1_H;
wire	[`datawidth/2-1:0]	in1_L;
assign	in1_H = in1[`datawidth/2+:`datawidth/2];
assign	in1_L = in1[0+:`datawidth/2];

wire	[`datawidth/2-1:0]	in2_H;
wire	[`datawidth/2-1:0]	in2_L;
assign	in2_H = in2[`datawidth/2+:`datawidth/2];
assign	in2_L = in2[0+:`datawidth/2];

wire	[`datawidth-1:0]	p0_D;	//p0=a0b0
wire	[`datawidth-1:0]	p1_D;	//p1=a1b1
wire	[`datawidth-1:0]	p0_Q;	//p0=a0b0
wire	[`datawidth-1:0]	p1_Q;	//p1=a1b1
assign	p0_D=in1_L*in2_L;
assign	p1_D=in1_H*in2_H;
DFF #(.datawidth(`datawidth)) dff_p0(.clk(clk), .rstn(rstn), .D(p0_D), .Q(p0_Q));
DFF #(.datawidth(`datawidth)) dff_p1(.clk(clk), .rstn(rstn), .D(p1_D), .Q(p1_Q));

wire	[2*`datawidth-1:0]	p01_D;	//p01=(a0+a1)(b0+b1)
wire	[2*`datawidth-1:0]	p01_Q;	//p01=(a0+a1)(b0+b1)
assign	p01_D=(in1_L+in1_H)*(in2_L+in2_H);
DFF #(.datawidth(2*`datawidth)) dff_p01(.clk(clk), .rstn(rstn), .D(p01_D), .Q(p01_Q));

//calculate more
wire	[2*`datawidth-1:0]	s1_D;	//s1=p1*2^(2m)+p0
wire	[2*`datawidth-1:0]	s2_D;	//s2=(p01-p0-p1)*2^m
wire	[2*`datawidth-1:0]	s1_Q;	//s1=p1*2^(2m)+p0
wire	[2*`datawidth-1:0]	s2_Q;	//s2=(p01-p0-p1)*2^m
wire	[2*`datawidth-1:0]	out;
assign	s1_D={p1_Q,p0_Q};
assign	s2_D=(p01_Q+(~p1_Q+1'b1)+(~p0_Q+1'b1))<<(`datawidth/2);
DFF #(.datawidth(2*`datawidth)) dff_s1(.clk(clk), .rstn(rstn), .D(s1_D), .Q(s1_Q));
DFF #(.datawidth(2*`datawidth)) dff_s2(.clk(clk), .rstn(rstn), .D(s2_D), .Q(s2_Q));

assign	out=s1_Q+s2_Q;
assign	out_L=out[0+:`datawidth];
assign	out_H=out[`datawidth+:`datawidth];

endmodule