`include "ntt_define.vh"
`timescale 1ns/100ps

module tb_bfu_v0();

//parameter	P = 12289;
parameter	P = 343576577;

parameter	Mon_R=(1<<`datawidth); //2^`datawidth
parameter	_P=(~P+1'b1);

reg							clk=0;
reg							clk_div2=0;
reg							rstn=1;
reg		[`datawidth-1:0]	in1;
reg		[`datawidth-1:0]	in2;
reg		[`datawidth-1:0]	gamma;
reg		[1:0]			op;

wire	[`datawidth-1:0]	out1;
wire	[`datawidth-1:0]	out2;

wire	[127:0]	out1_golden;
wire	[127:0]	out2_golden;
wire	[127:0]	mm_out_golden;
wire	[127:0]	ms_out_golden;
wire	[127:0]	ma_out_golden;
reg		[`datawidth-1:0]	mu=0;
reg		[`datawidth-1:0]	R_1=0; //R_1*R mod P = 1
reg		[`datawidth-1:0]	P_1=0; //P_1*P mod R = 1
reg		[63:0]			sol='d0;
integer	i,t;
integer	cnt;
integer	signal_last=1;

always #5	clk=~clk;
always #10	clk_div2=~clk_div2;

initial
begin
	in1=0;
	in2=0;
	gamma=0;
	op=0;
	cnt=0;
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
	$display("mu:",mu);
	
	//calculate R^(-1);R*R^(-1) mod P == 1;
	sol=R_1*Mon_R;
	while((sol%P)!==1)
	begin
		R_1=R_1+1'b1;
		sol=R_1*Mon_R;
	end
	$display("R^(-1):",R_1);
	
	repeat(5)@(posedge clk) #2;
	
	//random test
	for(i=0;i<3;i=i+1)
	begin
		op=i;
		for(t=0;t<100;t=t+1)
		begin
			in1={$random()}%P;
			in2={$random()}%P;
			gamma={$random()}%P;
			
			if((out1!==out1_golden)||(out2!==out2_golden))
			begin
				//$display("MAU test failed!");
				$display("error: ", cnt, ";", op);
				//$stop();
			end
			cnt=cnt+1'b1;
			repeat(1)@(posedge clk) #2;
		end
		//repeat(3)@(posedge clk) #2;
	end
	
	for(t=0;t<100;t=t+1)
	begin
		op=0;
		//repeat(3)@(posedge clk) #2;
		in1={$random()}%P;
		in2={$random()}%P;
		gamma={$random()}%P;
		
		if((out1!==out1_golden)||(out2!==out2_golden))
		begin
			//$display("MAU test failed!");
			$display("error: ", cnt, ";", op);
			//$stop();
		end
		cnt=cnt+1'b1;
		repeat(signal_last)@(posedge clk) #2;
	end
	
	for(t=0;t<100;t=t+1)
	begin
		op=2;
		//repeat(3)@(posedge clk) #2;
		in1={$random()}%P;
		in2={$random()}%P;
		gamma={$random()}%P;
		
		if((out1!==out1_golden)||(out2!==out2_golden))
		begin
			//$display("MAU test failed!");
			$display("error: ", cnt, ";", op);
			//$stop();
		end
		cnt=cnt+1'b1;
		repeat(signal_last)@(posedge clk) #2;
	end
	
	for(t=0;t<100;t=t+1)
	begin
		op=1;
		//repeat(3)@(posedge clk) #2;
		in1={$random()}%P;
		in2={$random()}%P;
		gamma={$random()}%P;
		
		if((out1!==out1_golden)||(out2!==out2_golden))
		begin
			//$display("MAU test failed!");
			$display("error: ", cnt, ";", op);
			//$stop();
		end
		cnt=cnt+1'b1;
		repeat(signal_last)@(posedge clk) #2;
	end
	
	for(t=0;t<100;t=t+1)
	begin
		op=0;
		//repeat(3)@(posedge clk) #2;
		in1={$random()}%P;
		in2={$random()}%P;
		gamma={$random()}%P;
		
		if((out1!==out1_golden)||(out2!==out2_golden))
		begin
			//$display("MAU test failed!");
			$display("error: ", cnt, ";", op);
			//$stop();
		end
		cnt=cnt+1'b1;
		repeat(signal_last)@(posedge clk) #2;
	end
	
	for(t=0;t<100;t=t+1)
	begin
		op={$random()}%3;
		//repeat(3)@(posedge clk) #2;
		in1={$random()}%P;
		in2={$random()}%P;
		gamma={$random()}%P;
		
		if((out1!==out1_golden)||(out2!==out2_golden))
		begin
			//$display("MAU test failed!");
			$display("error: ", cnt, ";", op);
			//$stop();
		end
		cnt=cnt+1'b1;
		repeat(1)@(posedge clk) #2;
	end
	$display("MAU test pass!");
	$stop();
end

bfu_v0 bfu_v0_1(
	.clk(clk),
	.rstn(rstn),
	
	.in1(in1),
	.in2(in2),
	.gamma(gamma),	//required by BF
	.op(op),
	
	.p(P),
	._p(_P),
	.mu(mu),		//required by mod_mul
	
	.out1(out1),
	.out2(out2)
);

bfu_model bfu_model1(
	.clk(clk),
	.rstn(rstn),
	
	.in1(in1),
	.in2(in2),
	.gamma(gamma),
	.op(op),
	
	.p(P),
	.R_1(R_1),
	
	.mm_out_golden(mm_out_golden),
	.ms_out_golden(ms_out_golden),
	.ma_out_golden(ma_out_golden),
	.out1_golden(out1_golden),
	.out2_golden(out2_golden)
);

endmodule