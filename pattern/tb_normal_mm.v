`include "ntt_define.vh"
`timescale 1ns/100ps

module tb_normal_mm();

parameter	P = 12289;
//parameter	P = 343576577;

parameter	Mon_R=(1<<`datawidth); //2^`datawidth

reg		[`datawidth-1:0]	in1;
reg		[`datawidth-1:0]	in2;


wire	[`datawidth-1:0]	out;

reg		[63:0]	out_golden;
reg		[`datawidth-1:0]	mu=0;
reg		[`datawidth-1:0]	R_1=0; //R_1*R mod P = 1
reg		[`datawidth-1:0]	P_1=0; //P_1*P mod R = 1
reg		[63:0]			sol='d0;
integer	t;

initial
begin
	in1=0;
	in2=0;
	//enumerate	the	R_1 and mu
	if(`datawidth==14)
	begin
		if(P==12289)
		begin
			R_1 = 9216;
			P_1 = 4097;
		end
	end
	else if(`datawidth==30)
	begin
		if(P==12289)
		begin
			R_1 = 10561;
			P_1 = 150982657;
		end
		else if(P==343576577)
		begin
			R_1 = 18675318;
			P_1 = 1015377921;
		end
	end
	
	//calculate mu=-q^(-1)mod R;
	sol=P_1*P;
	while((sol%Mon_R)!==1)
	begin
		P_1=P_1+1'b1;
		sol=P_1*P;
	end
	mu=Mon_R-P_1;
	$display("mu: ",mu);
	
	//calculate R^(-1);R*R^(-1) mod P == 1;
	sol=R_1*Mon_R;
	while((sol%P)!==1)
	begin
		R_1=R_1+1'b1;
		sol=R_1*Mon_R;
	end
	$display("R^(-1): ",R_1);
	
	repeat(5)#2;
	
	//bound test
	in1=P-1;
	in2=P-1;
	#5;
	in1=0;
	in2=0;
	#5;
	
	//random test
	for(t=0;t<1000;t=t+1)
	begin
		in1={$random()}%P;
		in2={$random()}%P;
		#5;
	end
	$display("mod mul mon test pass!");
	$stop();
end

normal_mm ins1(
	.in1(in1),
	.in2(in2),
	
	.mu(mu),
	.p(P),
	._p(~P+1'b1),
	
	.out(out)
);

//check result
always@(*)
begin
	out_golden=(in1*in2)%P;
	out_golden=(out_golden*R_1)%P;
	if(out!==out_golden)
	begin
		$display("mod mul mon test failed!");
		$stop();
	end
end
endmodule