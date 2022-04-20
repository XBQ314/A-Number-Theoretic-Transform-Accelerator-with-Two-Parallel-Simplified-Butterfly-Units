`include "ntt_define.vh"

module new_km(
	input	clk,
	input	rstn,
	input	[`datawidth-1:0]in1,
	input	[`datawidth-1:0]in2,
	
	output	[`datawidth-1:0]out_L,
	output	[`datawidth-1:0]out_H
);
//wire	select;
//DFF #(.datawidth(1)) dff_select(.clk(clk), .rstn(rstn), .D(~select), .Q(select));

wire	[`datawidth/2-1:0]	in1_H;
wire	[`datawidth/2-1:0]	in1_L;
assign	in1_H = in1[`datawidth/2+:`datawidth/2];
assign	in1_L = in1[0+:`datawidth/2];

wire	[`datawidth/2-1:0]	in2_H;
wire	[`datawidth/2-1:0]	in2_L;
assign	in2_H = in2[`datawidth/2+:`datawidth/2];
assign	in2_L = in2[0+:`datawidth/2];

wire	[`datawidth-1:0]	km_sub1_out1;
wire	[`datawidth-1:0]	km_sub1_out2;
new_km_sub km_sub1(
	.clk(clk),
	.rstn(rstn),
	//.select(select),
	.in1(in1_H),
	.in2(in1_L),
	.in3(in2_H),
	.in4(in2_L),

	.out1(km_sub1_out1),
	.out2(km_sub1_out2)
);

wire	[2*`datawidth-1:0]add_in1;
assign	add_in1 = {clk?km_sub1_out2:km_sub1_out1, clk?km_sub1_out1:km_sub1_out2};

wire	[`datawidth-1:0]	km_sub2_out1;
wire	[`datawidth-1:0]	km_sub2_out2;
new_km_sub km_sub2(
	.clk(clk),
	.rstn(rstn),
	//.select(select),
	.in1(in1_H),
	.in2(in1_L),
	.in3(in2_L),
	.in4(in2_H),

	.out1(km_sub2_out1),
	.out2(km_sub2_out2)
);
wire	[2*`datawidth-1:0]add_in2;
assign	add_in2 = (km_sub2_out1 * km_sub2_out2)<<(`datawidth/2);

assign	{out_H, out_L} = add_in1 + add_in2;
endmodule