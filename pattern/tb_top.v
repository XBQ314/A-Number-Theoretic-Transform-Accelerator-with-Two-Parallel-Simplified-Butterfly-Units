module tb_top();

reg clk=0;
always #5 clk=~clk;
reg rstn=0;
reg start=0;
reg [2:0]set_state='d0;

initial 
begin
    repeat(5) @(posedge clk) #2;
    rstn=1;repeat(2) @(posedge clk) #2;

    set_state=3'b001;start=1;repeat(3) @(posedge clk) #2;
    start=0;repeat(700) @(posedge clk) #2;

    // set_state=3'b010;start=1;repeat(3) @(posedge clk) #2;
    // start=0;repeat(5) @(posedge clk) #2;

    // set_state=3'b011;start=1;repeat(3) @(posedge clk) #2;
    // start=0;repeat(100) @(posedge clk) #2;

    // set_state=3'b100;start=1;repeat(3) @(posedge clk) #2;
    // start=0;repeat(5) @(posedge clk) #2;

    // set_state=3'b000;start=1;repeat(3) @(posedge clk) #2;
    // start=0;repeat(5) @(posedge clk) #2;

    $stop();
end

top top1
(
    .clk(clk),
    .rstn(rstn),
    .start(start),
    .set_state(set_state)
);

endmodule