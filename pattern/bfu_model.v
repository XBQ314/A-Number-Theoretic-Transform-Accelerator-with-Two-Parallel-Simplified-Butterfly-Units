`include "ntt_define.vh"

module bfu_model(
	clk,
	rstn,
	
	in1,
	in2,
	gamma,
	op,
	
	p,
	R_1,
	
	mm_out_golden,
	ms_out_golden,
	ma_out_golden,
	
	out1_golden,
	out2_golden
);
input	wire						clk;
input	wire						rstn;

input	wire	[`datawidth-1:0]	in1;
input	wire	[`datawidth-1:0]	in2;
input	wire	[`datawidth-1:0]	gamma;
input	wire	[1:0]			op;

input	wire	[`datawidth-1:0]	p;
input	wire	[`datawidth-1:0]	R_1;

/* output	wire	[127:0]	mm_out_golden;
output	wire	[127:0]	ms_out_golden;
output	wire	[127:0]	ma_out_golden; */
output	reg		[127:0]	mm_out_golden;
output	reg		[127:0]	ms_out_golden;
output	reg		[127:0]	ma_out_golden;
output	wire	[127:0]	out1_golden;
output	wire	[127:0]	out2_golden;


//reg		[127:0]		mm_out_golden_;
//reg		[127:0]		ms_out_golden_;
//reg		[127:0]		ma_out_golden_;
reg		[127:0]		out1_golden_tmp;
reg		[127:0]		out2_golden_tmp;

always@(*)
begin
	if(op==2'b00)
	begin
		mm_out_golden=(in2*gamma*R_1)%p;
		ms_out_golden=(in1-(in2*gamma*R_1)%p+p)%p;
		ma_out_golden=(in1+(in2*gamma*R_1)%p)%p;
		
		out1_golden_tmp=(in1+(in2*gamma*R_1)%p)%p;
		out2_golden_tmp=(in1-(in2*gamma*R_1)%p+p)%p;
	end
	else if(op==2'b01)
	begin
		mm_out_golden=(((in2-in1+p)%p)*gamma*R_1)%p;
		ms_out_golden=((in2-in1+p)%p);
		ma_out_golden=(in1+in2)%p;
		
		out1_golden_tmp=(in1+in2)%p;
		out2_golden_tmp=(((in2-in1+p)%p)*gamma*R_1)%p;
	end
	else if(op==2'b10)
	begin
		mm_out_golden=(in1*in2*R_1)%p;
		ms_out_golden='d0;
		ma_out_golden='d0;
		
		out1_golden_tmp=(in1*in2*R_1)%p;
		out2_golden_tmp='d0;
	end
	else if(op==2'b11)
	begin
		mm_out_golden='d0;
		ms_out_golden=(in2-in1+p)%p;
		ma_out_golden=(in1+in2)%p;

		out1_golden_tmp=(in1+in2)%p;
		out2_golden_tmp=(in2-in1+p)%p;
	end
end

parameter	PIPE_STAGE = 8;

reg	[127:0]out1_golden_pipe[0:PIPE_STAGE-1];
reg	[127:0]out2_golden_pipe[0:PIPE_STAGE-1];
generate
genvar cnt;
for(cnt=0; cnt<PIPE_STAGE; cnt=cnt+1) 
begin: gen_bcd_pipe 
	if(cnt == 0) 
	begin
		always @(posedge clk or negedge rstn)
		if(~rstn)
		begin
			out1_golden_pipe[cnt]<= 'd0;
			out2_golden_pipe[cnt]<= 'd0;
		end
		else
		begin
			out1_golden_pipe[cnt]<= out1_golden_tmp; 
			out2_golden_pipe[cnt]<= out2_golden_tmp;
		end
	end 
	else 
	begin
		always @(posedge clk or negedge rstn)
		if(~rstn)
		begin
			out1_golden_pipe[cnt]<= 'd0;
			out2_golden_pipe[cnt]<= 'd0;
		end 
		else 
		begin
			out1_golden_pipe[cnt]<= out1_golden_pipe[cnt-1] ;
			out2_golden_pipe[cnt]<= out2_golden_pipe[cnt-1];
		end
	end
end
endgenerate

assign	out1_golden = out1_golden_pipe[PIPE_STAGE-1];
assign	out2_golden = out2_golden_pipe[PIPE_STAGE-1];

endmodule