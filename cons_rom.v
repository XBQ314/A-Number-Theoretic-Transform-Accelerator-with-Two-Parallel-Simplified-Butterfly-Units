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
assign out1 = (newadd0_idx == 2'b00) ? bank0_doutb :
              (newadd0_idx == 2'b01) ? bank1_doutb :
              (newadd0_idx == 2'b10) ? bank2_doutb :
              (newadd0_idx == 2'b11) ? bank3_doutb :
                                       'd0;
assign out2 = (newadd1_idx == 2'b00) ? bank0_doutb :
              (newadd1_idx == 2'b01) ? bank1_doutb :
              (newadd1_idx == 2'b10) ? bank2_doutb :
              (newadd1_idx == 2'b11) ? bank3_doutb :
                                       'd0;
assign out3 = (newadd3_idx == 2'b00) ? bank0_doutb :
              (newadd3_idx == 2'b01) ? bank1_doutb :
              (newadd3_idx == 2'b10) ? bank2_doutb :
              (newadd3_idx == 2'b11) ? bank3_doutb :
                                       'd0;
assign out4 = (newadd4_idx == 2'b00) ? bank0_doutb :
              (newadd4_idx == 2'b01) ? bank1_doutb :
              (newadd4_idx == 2'b10) ? bank2_doutb :
              (newadd4_idx == 2'b11) ? bank3_doutb :
                                       'd0;
wire wen_8Q;
wire [8:0]bank0_addrb_8Q;
wire [8:0]bank1_addrb_8Q;
wire [8:0]bank2_addrb_8Q;
wire [8:0]bank3_addrb_8Q;
shift_8 #(.data_width(`datawidth)) s8_wen (.clk(clk),.rstn(rstn),.din(wen),.dout(wen_8Q));
shift_8 #(.data_width(9)) s8_bank0_addrb (.clk(clk),.rstn(rstn),.din(bank0_addrb),.dout(bank0_addrb_8Q));
shift_8 #(.data_width(9)) s8_bank1_addrb (.clk(clk),.rstn(rstn),.din(bank1_addrb),.dout(bank1_addrb_8Q));
shift_8 #(.data_width(9)) s8_bank2_addrb (.clk(clk),.rstn(rstn),.din(bank2_addrb),.dout(bank2_addrb_8Q));
shift_8 #(.data_width(9)) s8_bank3_addrb (.clk(clk),.rstn(rstn),.din(bank3_addrb),.dout(bank3_addrb_8Q));
bank0 bank0(.clka(clk), .ena(1'b1), .wea(wen_8Q), .addra(bank0_addrb_8Q), .dina(in1), .clkb(clk), .enb(ren), .addrb(bank0_addrb), .doutb(bank0_doutb));//a口写 b口读
bank1 bank1(.clka(clk), .ena(1'b1), .wea(wen_8Q), .addra(bank1_addrb_8Q), .dina(in2), .clkb(clk), .enb(ren), .addrb(bank1_addrb), .doutb(bank1_doutb));//a口写 b口读
bank2 bank2(.clka(clk), .ena(1'b1), .wea(wen_8Q), .addra(bank2_addrb_8Q), .dina(in3), .clkb(clk), .enb(ren), .addrb(bank2_addrb), .doutb(bank2_doutb));//a口写 b口读
bank3 bank3(.clka(clk), .ena(1'b1), .wea(wen_8Q), .addra(bank3_addrb_8Q), .dina(in4), .clkb(clk), .enb(ren), .addrb(bank3_addrb), .doutb(bank3_doutb));//a口写 b口读                               

endmodule