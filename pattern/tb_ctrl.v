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

initial 
begin
    repeat(5) @(posedge clk) #2;
    rstn=1;repeat(2) @(posedge clk) #2;

    set_state=3'b001;start=1;repeat(3) @(posedge clk) #2;
    start=0;repeat(50) @(posedge clk) #2;

    // set_state=3'b010;start=1;repeat(3) @(posedge clk) #2;
    // start=0;repeat(5) @(posedge clk) #2;

    set_state=3'b011;start=1;repeat(3) @(posedge clk) #2;
    start=0;repeat(50) @(posedge clk) #2;

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

endmodule