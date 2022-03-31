`include "ntt_define.vh"

module top
(
    input clk,
    input rstn,
    input start,
    input [2:0]set_state,
    output[2:0]cur_state
);


wire op;
wire [3:0] p; //max = 15
wire [8:0] k; //max = 511
wire [8:0] i; //max = 511
wire [10:0]gamma0_add;
wire [10:0]gamma1_add;
//wire [2:0] cur_state;
wire wen;
wire ren;
wire special_add;
ctrl ctrl1
(.clk(clk), .rstn(rstn), .start(start), .set_state(set_state), .p_max('d7), .op(op), 
 .p(p), .k(k), .i(i), .gamma0(gamma0_add), .gamma1(gamma1_add), .cur_state(cur_state), .wen(wen), .ren(ren), .special_add(special_add));


wire [10:0]oldadd0;
wire [10:0]oldadd1;
wire [10:0]oldadd2;
wire [10:0]oldadd3;
gen_oldadd gen_oldadd1
(.special_add(special_add), .p(p), .k(k), .i(i), .oldadd0(oldadd0), .oldadd1(oldadd1), .oldadd2(oldadd2), .oldadd3(oldadd3));

wire [1:0]newadd0_idx;
wire [8:0]newadd0;
wire [1:0]newadd1_idx;
wire [8:0]newadd1;
wire [1:0]newadd2_idx;
wire [8:0]newadd2;
wire [1:0]newadd3_idx;
wire [8:0]newadd3;
cfmm cfmm1
(.oldadd0(oldadd0), .oldadd1(oldadd1), .oldadd2(oldadd2), .oldadd3(oldadd3),
.newadd0_idx(newadd0_idx),.newadd0(newadd0), .newadd1_idx(newadd1_idx), .newadd1(newadd1), 
.newadd2_idx(newadd2_idx),.newadd2(newadd2), .newadd3_idx(newadd3_idx), .newadd3(newadd3));

wire[`datawidth-1:0]bf_out1;
wire[`datawidth-1:0]bf_out2;
wire[`datawidth-1:0]bf_out3;
wire[`datawidth-1:0]bf_out4;
wire[`datawidth-1:0]bf_in1;
wire[`datawidth-1:0]bf_in2;
wire[`datawidth-1:0]bf_in3;
wire[`datawidth-1:0]bf_in4;
cons_rom cons_rom1
(.clk(clk), .rstn(rstn), .ren(ren), .wen(wen), 
.newadd0_idx(newadd0_idx),.newadd0(newadd0), .newadd1_idx(newadd1_idx), .newadd1(newadd1),
.newadd2_idx(newadd2_idx),.newadd2(newadd2), .newadd3_idx(newadd3_idx), .newadd3(newadd3),
.in1(bf_out1), .in2(bf_out2), .in3(bf_out3), .in4(bf_out4),
.out1(bf_in1), .out2(bf_in2), .out3(bf_in3), .out4(bf_in4));

wire[`datawidth-1:0]gamma1;
wire[`datawidth-1:0]gamma2;
tf_rom tf_rom1
(.clk(clk), .rstn(rstn), .special_add(special_add), .op(op), 
.gamma1_add(gamma0_add), .gamma2_add(gamma1_add), .gamma1(gamma1), .gamma2(gamma2));

bfu_v1 bfu1(.clk(clk), .rstn(rstn), .in1(bf_in1), .in2(bf_in2),
            .gamma(gamma1), .op(op), .p('d12289), ._p('d1073729535), .mu('d922759167), 
            .out1(bf_out1),.out2(bf_out2));
bfu_v1 bfu2(.clk(clk), .rstn(rstn), .in1(bf_in3), .in2(bf_in4),
            .gamma(gamma2), .op(op), .p('d12289), ._p('d1073729535), .mu('d922759167), 
            .out1(bf_out3),.out2(bf_out4));

endmodule