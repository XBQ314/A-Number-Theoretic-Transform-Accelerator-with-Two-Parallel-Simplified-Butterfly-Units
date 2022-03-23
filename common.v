module	DFF(
	clk,
	rstn,
	
	D,
	Q
);

parameter	datawidth=14;

input	wire	clk;
input	wire	rstn;

input	wire[datawidth-1:0]	D;
output	reg[datawidth-1:0]	Q;

always@(posedge clk or negedge rstn)
begin
	if(~rstn)	Q<='d0;
	else	Q<=D;
end

endmodule

module posedge_detection (
   input  clk,
   input  rstn,
   input  in,
   output out
);

reg r_data_in0;
reg r_data_in1;

assign out = ~r_data_in0 & r_data_in1;

always@(posedge clk or negedge rstn)
begin
	if (!rstn)
	begin
		r_data_in0 <= 0;
		r_data_in1 <= 0;
	end
	else
	begin
		r_data_in0 <= r_data_in1;
		r_data_in1 <= in;
	end
end

endmodule

module shift_8 #(parameter data_width = 14)(
    input [data_width-1:0] din,
	input rstn,clk,
	output wire [data_width-1:0] dout
	);
	
	reg [data_width-1:0] t0,t1,t2,t3,t4,t5,t6;
	reg [data_width-1:0] t7;
	
	always@(posedge clk or negedge rstn)
	begin
	  if(~rstn) begin
	    t0 <= 0; t1 <= 0; t2 <= 0; t3 <= 0; t4 <= 0;
	    t5 <= 0; t6 <= 0; t7 <= 0; end
	  else begin
	    t0 <= din;
	    t1 <= t0; t2 <= t1; t3 <= t2; t4 <= t3;
	    t5 <= t4; t6 <= t5; t7 <= t6; 
	  end
	end
	
	assign dout = t7;
endmodule
