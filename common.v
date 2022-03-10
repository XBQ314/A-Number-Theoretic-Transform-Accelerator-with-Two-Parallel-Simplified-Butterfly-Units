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
