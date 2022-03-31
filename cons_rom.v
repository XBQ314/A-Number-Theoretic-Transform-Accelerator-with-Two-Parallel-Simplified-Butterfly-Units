`include "ntt_define.vh"

module cons_rom
(
    input clk,
    input rstn,
    input ren,
    input wen,
    input [1:0]newadd0_idx,
    input [8:0]newadd0,
    input [1:0]newadd1_idx,
    input [8:0]newadd1,
    input [1:0]newadd2_idx,
    input [8:0]newadd2,
    input [1:0]newadd3_idx,
    input [8:0]newadd3,
    input [`datawidth-1:0] in1,
    input [`datawidth-1:0] in2,
    input [`datawidth-1:0] in3,
    input [`datawidth-1:0] in4,

    output [`datawidth-1:0] out1,
    output [`datawidth-1:0] out2,
    output [`datawidth-1:0] out3,
    output [`datawidth-1:0] out4
);

wire [1:0]newadd0_idx_Q;
wire [1:0]newadd1_idx_Q;
wire [1:0]newadd2_idx_Q;
wire [1:0]newadd3_idx_Q;
wire [1:0]newadd0_idx_9Q;
wire [1:0]newadd1_idx_9Q;
wire [1:0]newadd2_idx_9Q;
wire [1:0]newadd3_idx_9Q;
wire [8:0]bank0_addrb;
wire [8:0]bank1_addrb;
wire [8:0]bank2_addrb;
wire [8:0]bank3_addrb;
wire [`datawidth-1:0]bank0_doutb;
wire [`datawidth-1:0]bank1_doutb;
wire [`datawidth-1:0]bank2_doutb;
wire [`datawidth-1:0]bank3_doutb;
assign bank0_addrb = (newadd0_idx == 2'b00) ? newadd0 ://assign bank0_addrb = (9{newadd0_idx == 2'b00} & newadd0) 
                     (newadd1_idx == 2'b00) ? newadd1 ://                    |(9{newadd1_idx == 2'b00} & newadd1) 
                     (newadd2_idx == 2'b00) ? newadd2 ://                    |(9{newadd2_idx == 2'b00} & newadd2) 
                     (newadd3_idx == 2'b00) ? newadd3 ://                    |(9{newadd3_idx == 2'b00} & newadd3);
                                             'd0;
assign bank1_addrb = (newadd0_idx == 2'b01) ? newadd0 ://assign bank1_addrb = (9{newadd0_idx == 2'b01} & newadd0) 
                     (newadd1_idx == 2'b01) ? newadd1 ://                    |(9{newadd1_idx == 2'b01} & newadd1) 
                     (newadd2_idx == 2'b01) ? newadd2 ://                    |(9{newadd2_idx == 2'b01} & newadd2) 
                     (newadd3_idx == 2'b01) ? newadd3 ://                    |(9{newadd3_idx == 2'b01} & newadd3);
                                             'd0;
assign bank2_addrb = (newadd0_idx == 2'b10) ? newadd0 ://assign bank2_addrb = (9{newadd0_idx == 2'b10} & newadd0) 
                     (newadd1_idx == 2'b10) ? newadd1 ://                    |(9{newadd1_idx == 2'b10} & newadd1) 
                     (newadd2_idx == 2'b10) ? newadd2 ://                    |(9{newadd2_idx == 2'b10} & newadd2) 
                     (newadd3_idx == 2'b10) ? newadd3 ://                    |(9{newadd3_idx == 2'b10} & newadd3);
                                             'd0;
assign bank3_addrb = (newadd0_idx == 2'b11) ? newadd0 ://assign bank3_addrb = (9{newadd0_idx == 2'b11} & newadd0) 
                     (newadd1_idx == 2'b11) ? newadd1 ://                    |(9{newadd1_idx == 2'b11} & newadd1) 
                     (newadd2_idx == 2'b11) ? newadd2 ://                    |(9{newadd2_idx == 2'b11} & newadd2) 
                     (newadd3_idx == 2'b11) ? newadd3 ://                    |(9{newadd3_idx == 2'b11} & newadd3);
                                             'd0;

DFF #(.datawidth(2)) dff_newadd0_idx_1(.clk(clk), .rstn(rstn), .D(newadd0_idx), .Q(newadd0_idx_Q));
DFF #(.datawidth(2)) dff_newadd1_idx_1(.clk(clk), .rstn(rstn), .D(newadd1_idx), .Q(newadd1_idx_Q));
DFF #(.datawidth(2)) dff_newadd2_idx_1(.clk(clk), .rstn(rstn), .D(newadd2_idx), .Q(newadd2_idx_Q));
DFF #(.datawidth(2)) dff_newadd3_idx_1(.clk(clk), .rstn(rstn), .D(newadd3_idx), .Q(newadd3_idx_Q));
assign out1 = (newadd0_idx_Q == 2'b00) ? bank0_doutb :
              (newadd0_idx_Q == 2'b01) ? bank1_doutb :
              (newadd0_idx_Q == 2'b10) ? bank2_doutb :
              (newadd0_idx_Q == 2'b11) ? bank3_doutb :
                                       'd0;
assign out2 = (newadd1_idx_Q == 2'b00) ? bank0_doutb :
              (newadd1_idx_Q == 2'b01) ? bank1_doutb :
              (newadd1_idx_Q == 2'b10) ? bank2_doutb :
              (newadd1_idx_Q == 2'b11) ? bank3_doutb :
                                       'd0;
assign out3 = (newadd2_idx_Q == 2'b00) ? bank0_doutb :
              (newadd2_idx_Q == 2'b01) ? bank1_doutb :
              (newadd2_idx_Q == 2'b10) ? bank2_doutb :
              (newadd2_idx_Q == 2'b11) ? bank3_doutb :
                                       'd0;
assign out4 = (newadd3_idx_Q == 2'b00) ? bank0_doutb :
              (newadd3_idx_Q == 2'b01) ? bank1_doutb :
              (newadd3_idx_Q == 2'b10) ? bank2_doutb :
              (newadd3_idx_Q == 2'b11) ? bank3_doutb :
                                       'd0;
wire wen_9Q;
wire [8:0]bank0_addrb_9Q;
wire [8:0]bank1_addrb_9Q;
wire [8:0]bank2_addrb_9Q;
wire [8:0]bank3_addrb_9Q;
wire [`datawidth-1:0] bank0_dina;
wire [`datawidth-1:0] bank1_dina;
wire [`datawidth-1:0] bank2_dina;
wire [`datawidth-1:0] bank3_dina;
shift_9 #(.data_width(1)) s9_wen (.clk(clk),.rstn(rstn),.din(wen),.dout(wen_9Q));
shift_9 #(.data_width(9)) s9_bank0_addrb (.clk(clk),.rstn(rstn),.din(bank0_addrb),.dout(bank0_addrb_9Q));
shift_9 #(.data_width(9)) s9_bank1_addrb (.clk(clk),.rstn(rstn),.din(bank1_addrb),.dout(bank1_addrb_9Q));
shift_9 #(.data_width(9)) s9_bank2_addrb (.clk(clk),.rstn(rstn),.din(bank2_addrb),.dout(bank2_addrb_9Q));
shift_9 #(.data_width(9)) s9_bank3_addrb (.clk(clk),.rstn(rstn),.din(bank3_addrb),.dout(bank3_addrb_9Q));
shift_9 #(.data_width(9)) s9_newadd0_idx (.clk(clk),.rstn(rstn),.din(newadd0_idx),.dout(newadd0_idx_9Q));
shift_9 #(.data_width(9)) s9_newadd1_idx (.clk(clk),.rstn(rstn),.din(newadd1_idx),.dout(newadd1_idx_9Q));
shift_9 #(.data_width(9)) s9_newadd2_idx (.clk(clk),.rstn(rstn),.din(newadd2_idx),.dout(newadd2_idx_9Q));
shift_9 #(.data_width(9)) s9_newadd3_idx (.clk(clk),.rstn(rstn),.din(newadd3_idx),.dout(newadd3_idx_9Q));
assign bank0_dina = (newadd0_idx_9Q == 2'b00) ? in1 :
                     (newadd1_idx_9Q == 2'b00) ? in2 :
                     (newadd2_idx_9Q == 2'b00) ? in3 :
                     (newadd3_idx_9Q == 2'b00) ? in4 :
                                             'd0;
assign bank1_dina = (newadd0_idx_9Q == 2'b01) ? in1 :
                     (newadd1_idx_9Q == 2'b01) ? in2 :
                     (newadd2_idx_9Q == 2'b01) ? in3 :
                     (newadd3_idx_9Q == 2'b01) ? in4 :
                                             'd0;
assign bank2_dina = (newadd0_idx_9Q == 2'b10) ? in1 :
                     (newadd1_idx_9Q == 2'b10) ? in2 :
                     (newadd2_idx_9Q == 2'b10) ? in3 :
                     (newadd3_idx_9Q == 2'b10) ? in4 :
                                             'd0;
assign bank3_dina = (newadd0_idx_9Q == 2'b11) ? in1 :
                     (newadd1_idx_9Q == 2'b11) ? in2 :
                     (newadd2_idx_9Q == 2'b11) ? in3 :
                     (newadd3_idx_9Q == 2'b11) ? in4 :
                                             'd0;
bank0 bank0(.clka(clk), .ena(1'b1), .wea(wen_9Q), .addra(bank0_addrb_9Q), .dina(bank0_dina), .clkb(clk), .enb(ren), .addrb(bank0_addrb), .doutb(bank0_doutb));//a口写 b口读
bank1 bank1(.clka(clk), .ena(1'b1), .wea(wen_9Q), .addra(bank1_addrb_9Q), .dina(bank1_dina), .clkb(clk), .enb(ren), .addrb(bank1_addrb), .doutb(bank1_doutb));//a口写 b口读
bank2 bank2(.clka(clk), .ena(1'b1), .wea(wen_9Q), .addra(bank2_addrb_9Q), .dina(bank2_dina), .clkb(clk), .enb(ren), .addrb(bank2_addrb), .doutb(bank2_doutb));//a口写 b口读
bank3 bank3(.clka(clk), .ena(1'b1), .wea(wen_9Q), .addra(bank3_addrb_9Q), .dina(bank3_dina), .clkb(clk), .enb(ren), .addrb(bank3_addrb), .doutb(bank3_doutb));//a口写 b口读                               

endmodule