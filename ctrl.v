module ctrl
(
  input clk,
  input rstn,
  input start,
  input [2:0]set_state,
  input [3:0]p_max,

  output reg op,
  output reg [3:0] p, //max = 15
  output reg [8:0] k, //max = 511
  output reg [8:0] i, //max = 511
  output reg [10:0]gamma0,
  output     [10:0]gamma1,
  output reg [2:0] cur_state,
  output reg wen,
  output reg ren,
  output special_add
);

parameter IDLE = 3'b000;
parameter NTT = 3'b001;
parameter PWP = 3'b010; // Point Wise Product
parameter INTT = 3'b011;
parameter MAO = 3'b100; // Multiplication and Addition Operation
parameter EPL_NTT = 3'b101; // Emptying pipline
parameter EPL_INTT = 3'b110; // Emptying pipline

// reg [2:0] cur_state;
reg [2:0] nxt_state;

wire[3:0] begin_stage;
wire[3:0] end_stage;
wire[10:0] begin_gamma0;
wire[10:0] gamma0_inc;assign gamma0_inc = gamma0 + 1;
wire[10:0] gamma0_dec;assign gamma0_dec = gamma0 - 1;
assign end_stage = (set_state == NTT) ? 0 : p_max;
assign begin_stage = (set_state == NTT) ? p_max : 0;
assign begin_gamma0 = (set_state == NTT)?'d0:((1 << (p_max+1))-2);
assign gamma1 = special_add?((set_state == NTT)?gamma0_inc:gamma0_dec):'d0;

wire flag_fin;
reg [2:0]bubble_cnt;
wire [8:0]k_equ;
wire [8:0]i_equ;
assign k_equ = ((1 << (p_max - 1)) - 1);
assign i_equ = (1 << (p-1)) - 1;
assign flag_fin = ((cur_state == NTT) && (p == end_stage) && (k == k_equ)) || ((cur_state == INTT) && (p == end_stage) && (i == i_equ));
assign special_add = ((cur_state == NTT) && (p == end_stage) || ((cur_state == INTT) && (p == begin_stage)));

always@(posedge	clk or negedge rstn)
begin
	if(~rstn) cur_state<=IDLE;
	else
    begin
        if(start) cur_state<=set_state;
        else cur_state<=nxt_state;
    end
end

always@(*)
begin
    case(cur_state) //synopsys full_case parallel_case
        IDLE:begin nxt_state<=IDLE;end
        NTT:begin if(flag_fin==1'b1)nxt_state=EPL_NTT;else nxt_state=NTT;end
        PWP:begin if(flag_fin==1'b1)nxt_state=IDLE;else nxt_state=PWP;end
        INTT:begin if(flag_fin==1'b1)nxt_state=EPL_INTT;else nxt_state=INTT;end
        MAO:begin if(flag_fin==1'b1)nxt_state=IDLE;else nxt_state=MAO;end
        EPL_NTT:begin if(bubble_cnt == 3'b111)nxt_state=IDLE;else nxt_state=EPL_NTT;end 
        EPL_INTT:begin if(bubble_cnt == 3'b111)nxt_state=IDLE;else nxt_state=EPL_INTT;end 
    endcase
end

always@(*)
begin
    case(cur_state)	//synopsys full_case parallel_case
        IDLE:begin op=1'b0;wen=1'b0;ren=1'b0;end
        NTT:begin op=1'b0;wen=1'b1;ren=1'b1;end
        PWP:begin op=1'b0;wen=1'b1;ren=1'b1;end
        INTT:begin op=1'b1;wen=1'b1;ren=1'b1;end
        MAO:begin op=1'b0;wen=1'b1;ren=1'b1;end
        EPL_NTT:begin op=1'b0;wen=1'b0;ren=1'b0;end
        EPL_INTT:begin op=1'b1;wen=1'b0;ren=1'b0;end
    endcase
end

always@(posedge clk or posedge rstn)
begin 
    if(~rstn)
    begin
        p <= begin_stage;
        k <= 0;
        i <= 0;

        gamma0 <= begin_gamma0;
    end
    else if(((cur_state == NTT) && (p != end_stage)) || ((cur_state == INTT) && (p != begin_stage)))
    begin
        if(i == i_equ)
        begin
            if(cur_state == NTT) gamma0 <= gamma0_inc;
            else if(cur_state == INTT) gamma0 <= gamma0_dec;
            i <= 0;
            if(k == (1 << (p_max-p)) - 1)
            begin
                k <= 0;
                if(cur_state == INTT) p <= p + 1;
                else p <= p - 1;
            end
            else
            begin
                k <= k + 1;
            end
        end
        else
        begin
            i <= i + 1;
        end
    end
    else if((cur_state == NTT) && (p == end_stage))
    begin
        k<=k+1;
        gamma0<=gamma0+'d2;
        if(k == k_equ)
        begin
            k<=0;
            p<=begin_stage;
        end
    end
    else if((cur_state == INTT) && (p == begin_stage))
    begin
        k<=k+1;
        gamma0<=gamma0-'d2;
        if(k == k_equ)
        begin
            k<=0;
            p<=p+1;
        end
    end
    else
    begin
        p <= begin_stage;
        k <= 0;
        i <= 0;

        gamma0 <= begin_gamma0;
    end
end

always@(posedge clk or negedge rstn)
begin
    if(~rstn) bubble_cnt <= 'd0;
    else if((cur_state == EPL_NTT) || (cur_state == EPL_INTT)) bubble_cnt <= bubble_cnt +1'b1;
end

endmodule