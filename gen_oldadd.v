module gen_oldadd
(
    // input clk,
    // input rstn,
    input special_add,
    input [3:0] p, //max = 15
    input [8:0] k, //max = 511
    input [8:0] i, //max = 511

    output [10:0]oldadd0, // max=2047
    output [10:0]oldadd1,
    output [10:0]oldadd2,
    output [10:0]oldadd3
);

// k*R*J+i*PAR_D
wire[10:0]J;assign J=1<<p;
wire [10:0]kRJ_PLUS_iD;assign kRJ_PLUS_iD= ((k << 1) << p) + (i<<1); 

assign oldadd0 = special_add?(k << 2):kRJ_PLUS_iD;
reg [10:0]oldadd1_tmp;assign oldadd1 = special_add?{oldadd0[10:1], 1'b1}:oldadd1_tmp;
assign oldadd2 = special_add?{oldadd0[10:2], 2'b10}:{oldadd0[10:1], 1'b1};
// reg [10:0]oldadd3_tmp;assign oldadd3 = special_add?{oldadd0[10:2], 2'b11}:oldadd3_tmp;
assign oldadd3 = special_add?{oldadd0[10:2], 2'b11}:{oldadd1[10:1], 1'b1};

always@(*)
begin
    case(p)
    10:begin oldadd1_tmp={1'b1, oldadd0[9:0]};end
    9: begin oldadd1_tmp={oldadd0[10], 1'b1, oldadd0[8:0]};end
    8: begin oldadd1_tmp={oldadd0[10:9], 1'b1, oldadd0[7:0]};end
    7: begin oldadd1_tmp={oldadd0[10:8], 1'b1, oldadd0[6:0]};end
    6: begin oldadd1_tmp={oldadd0[10:7], 1'b1, oldadd0[5:0]};end
    5: begin oldadd1_tmp={oldadd0[10:6], 1'b1, oldadd0[4:0]};end
    4: begin oldadd1_tmp={oldadd0[10:5], 1'b1, oldadd0[3:0]};end
    3: begin oldadd1_tmp={oldadd0[10:4], 1'b1, oldadd0[2:0]};end
    2: begin oldadd1_tmp={oldadd0[10:3], 1'b1, oldadd0[1:0]};end
    1: begin oldadd1_tmp={oldadd0[10:2], 1'b1, oldadd0[0]};end
    default: begin oldadd1_tmp='d0;end
    endcase
end

endmodule

/*
module gen_oldadd
(
    input clk,
    input rstn,
    input special_add,
    input [3:0] p, //max = 15
    input [8:0] k, //max = 511
    input [8:0] i, //max = 511

    output [10:0]oldadd0, // max=2047
    output [10:0]oldadd1,
    output [10:0]oldadd2,
    output [10:0]oldadd3
);

reg [10:0]oldadd0_tmp;assign oldadd0 = special_add?(k << 2):oldadd0_tmp;
reg [10:0]oldadd1_tmp;assign oldadd1 = special_add?{oldadd0[10:1], 1'b1}:oldadd1_tmp;
reg [10:0]oldadd2_tmp;assign oldadd2 = special_add?{oldadd0[10:2], 2'b10}:oldadd2_tmp;
reg [10:0]oldadd3_tmp;assign oldadd3 = special_add?{oldadd0[10:2], 2'b11}:oldadd3_tmp;

// k*R*J+i*PAR_D
wire[10:0]J;assign J=1<<p;
wire [10:0]kRJ_PLUS_iD;assign kRJ_PLUS_iD= ((k << 1) << p) + (i<<1); 

always@(*)
begin
    oldadd0_tmp=kRJ_PLUS_iD;
    oldadd1_tmp=oldadd0_tmp+J;
    oldadd2_tmp=oldadd0_tmp+1;
    oldadd3_tmp=oldadd2_tmp+J;
end

endmodule
*/

/*
module gen_oldadd
(
    input clk,
    input rstn,
    input special_add,
    input [3:0] p, //max = 15
    input [8:0] k, //max = 511
    input [8:0] i, //max = 511

    output [10:0]oldadd0, // max=2047
    output [10:0]oldadd1,
    output [10:0]oldadd2,
    output [10:0]oldadd3
);

// k*R*J+i*PAR_D
wire[10:0]J;assign J=1<<p;
wire [10:0]kRJ_PLUS_iD;assign kRJ_PLUS_iD= ((k << 1) << p) + (i<<1); 

assign oldadd0 = special_add?(k << 2):kRJ_PLUS_iD;
reg [10:0]oldadd1_tmp;assign oldadd1 = special_add?{oldadd0[10:1], 1'b1}:oldadd1_tmp;
assign oldadd2 = special_add?{oldadd0[10:2], 2'b10}:{oldadd0[10:1], 1'b1};
reg [10:0]oldadd3_tmp;assign oldadd3 = special_add?{oldadd0[10:2], 2'b11}:oldadd3_tmp;

always@(*)
begin
    oldadd1_tmp=oldadd0+J;
    oldadd3_tmp=oldadd2+J;
end

endmodule
*/