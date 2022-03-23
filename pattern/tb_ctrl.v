module tb_ctrl();

reg clk=0;
always #5 clk=~clk;
reg rstn=0;
reg start=0;
reg [2:0]set_state=3'b000;
reg [3:0]p_max='d4;

wire    op;
wire    [3:0] p;
wire    [8:0] k; 
wire    [8:0] i; 
wire    [10:0]gamma0;
wire    [10:0]gamma1;
wire    [2:0] cur_state;
wire    wen;
wire    ren;
wire    special_add;

wire [10:0]oldadd0;
wire [10:0]oldadd1;
wire [10:0]oldadd2;
wire [10:0]oldadd3;

wire [1:0]newadd0_idx;
wire [8:0]newadd0;
wire [1:0]newadd1_idx;
wire [8:0]newadd1;
wire [1:0]newadd2_idx;
wire [8:0]newadd2;
wire [1:0]newadd3_idx;
wire [8:0]newadd3;

initial 
begin
    repeat(5) @(posedge clk) #2;
    rstn=1;repeat(2) @(posedge clk) #2;

    set_state=3'b001;start=1;repeat(3) @(posedge clk) #2;
    start=0;repeat(100) @(posedge clk) #2;

    // set_state=3'b010;start=1;repeat(3) @(posedge clk) #2;
    // start=0;repeat(5) @(posedge clk) #2;

    set_state=3'b011;start=1;repeat(3) @(posedge clk) #2;
    start=0;repeat(100) @(posedge clk) #2;

    // set_state=3'b100;start=1;repeat(3) @(posedge clk) #2;
    // start=0;repeat(5) @(posedge clk) #2;

    // set_state=3'b000;start=1;repeat(3) @(posedge clk) #2;
    // start=0;repeat(5) @(posedge clk) #2;

    $stop();
end


ctrl ctrl1
(
  .clk(clk),
  .rstn(rstn),
  .start(start),
  .set_state(set_state),
  .p_max(p_max),

  .op(op),
  .p(p), //max = 15
  .k(k), //max = 511
  .i(i), //max = 511
  .gamma0(gamma0),
  .gamma1(gamma1),
  .cur_state(cur_state),
  .wen(wen),
  .ren(ren),
  .special_add(special_add)
);

gen_oldadd gen_oldadd1
(
    // .clk(clk),
    // .rstn(rstn),
    .special_add(special_add),
    .p(p), //max = 15
    .k(k), //max = 511
    .i(i), //max = 511

    .oldadd0(oldadd0), // max=2047
    .oldadd1(oldadd1),
    .oldadd2(oldadd2),
    .oldadd3(oldadd3)
);

cfmm cfmm1
(
    // .clk(clk),
    // .rstn(rstn),
    .oldadd0(oldadd0),
    .oldadd1(oldadd1),
    .oldadd2(oldadd2),
    .oldadd3(oldadd3),

    .newadd0_idx(newadd0_idx),
    .newadd0(newadd0),
    .newadd1_idx(newadd1_idx),
    .newadd1(newadd1),
    .newadd2_idx(newadd2_idx),
    .newadd2(newadd2),
    .newadd3_idx(newadd3_idx),
    .newadd3(newadd3)
);
endmodule