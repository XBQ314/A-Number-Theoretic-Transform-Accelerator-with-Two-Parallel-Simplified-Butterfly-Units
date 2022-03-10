module km_sub(
	input	clk,
	input	rstn,
	//input	select,
	input	[`datawidth/2-1:0]	in1,
	input	[`datawidth/2-1:0]	in2,
	input	[`datawidth/2-1:0]	in3,
	input	[`datawidth/2-1:0]	in4,
	
	output	[`datawidth-1:0]	out1,
	output	[`datawidth-1:0]	out2
);
wire	[`datawidth-1:0]	mul_out;
assign	mul_out = (clk?in1:in2)*(clk?in3:in4);

wire	[`datawidth-1:0]	dff1_q;
DFF #(.datawidth(`datawidth))	dff1(.clk(clk), .rstn(rstn), .D(mul_out), .Q(dff1_q));
DFF #(.datawidth(`datawidth))	dff2(.clk(clk), .rstn(rstn), .D(dff1_q), .Q(out1));
DFF #(.datawidth(`datawidth))	dff3(.clk(clk), .rstn(rstn), .D(mul_out), .Q(out2));

endmodule