module cfmm
(
    // input clk,
    // input rstn,
    input [10:0]oldadd0,
    input [10:0]oldadd1,
    input [10:0]oldadd2,
    input [10:0]oldadd3,

    output [1:0]newadd0_idx,
    output [8:0]newadd0,
    output [1:0]newadd1_idx,
    output [8:0]newadd1,
    output [1:0]newadd2_idx,
    output [8:0]newadd2,
    output [1:0]newadd3_idx,
    output [8:0]newadd3
);

assign newadd0 = oldadd0[10:2];
assign newadd1 = oldadd1[10:2];
assign newadd2 = oldadd2[10:2];
assign newadd3 = oldadd3[10:2];

assign newadd0_idx = (oldadd0[1:0] + (^newadd0 << 1));
assign newadd1_idx = (oldadd1[1:0] + (^newadd1 << 1));
assign newadd2_idx = (oldadd2[1:0] + (^newadd2 << 1));
assign newadd3_idx = (oldadd3[1:0] + (^newadd3 << 1));

endmodule