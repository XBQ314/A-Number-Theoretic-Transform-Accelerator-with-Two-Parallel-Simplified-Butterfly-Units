`include "ntt_define.vh"
`timescale 1ns/100ps

module tb_km();

//parameter P = 12289;
parameter P = 343576577;

reg		[`datawidth-1:0]	in1;
reg		[`datawidth-1:0]	in2;


wire	[`datawidth-1:0]	out_L;
wire	[`datawidth-1:0]	out_H;

wire	[2*`datawidth-1:0]	out_golden;
integer	t;

reg	clk = 0;
always #5	clk=~clk;
reg	rstn = 0;

initial
begin
	repeat(5)@(posedge clk)	#2	rstn = 0;
	rstn = 1;
	in1=0;
	in2=0;
	repeat(5)@(posedge clk)#2;
		
	//random test
	for(t=0;t<1000;t=t+1)
	begin
		in1={$random()}%P;
		in2={$random()}%P;
		#5;
		repeat(1)@(posedge clk)#2;
	end
	$display("karatsuba mul test pass!");
	$stop();
end

assign	out_golden=(in1*in2);
//new_km new_km1(
//	.clk(clk),
//	.rstn(rstn),
//	.in1(in1),
//	.in2(in2),
//	
//	.out_L(out_L),
//	.out_H(out_H)
//);
old_km old_km1(
	.clk(clk),
	.rstn(rstn),
	.in1(in1),
	.in2(in2),
	
	.out_L(out_L),
	.out_H(out_H)
);
wire	[2*`datawidth-1:0] out;
assign	out = {out_H, out_L};
//check result
//always@(*)
//begin
//	if({out_H,out_L}!==out_golden)
//	begin
//		$display("karatsuba mul test failed!");
//		$stop();
//	end
//end
endmodule