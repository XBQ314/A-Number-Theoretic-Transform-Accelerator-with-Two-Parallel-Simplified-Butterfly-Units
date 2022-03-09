`include "ntt_define.vh"
`timescale 1ns/100ps

module tb_ma();

parameter P = 12289;
//parameter P = 343576577;

reg		[`datawidth-1:0]	in1;
reg		[`datawidth-1:0]	in2;
reg		[`datawidth-1:0]	_p=~P+1'b1;

wire	[`datawidth-1:0]	out;

reg		[`datawidth-1:0]	rand_val;
integer	t;
wire	[`datawidth-1:0]	out_golden;

initial
begin
	in1=0;
	in2=0;
	repeat(5)#2;
	
	//bound test
	in1=P-1;
	in2=P-1;
	#5;
	in1=0;
	in2=0;
	#5;
	
	//random test
	for(t=0;t<100;t=t+1)
	begin
		in1={$random()}%P;
		in2={$random()}%P;
		#5;
	end
	$display("mod add pass!");
	$stop();
end

assign	out_golden=((in1+in2)%P);
mod_add ins1(
	.in1(in1),
	.in2(in2),
	._p(_p),
	
	.out(out)
);

//check result
always@(*)
begin
	if(out!==out_golden)
	begin
		$display("mod add test failed!");
		$stop();
	end
end
endmodule