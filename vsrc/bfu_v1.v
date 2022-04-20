`include "ntt_define.vh"
module bfu_v1(	
    input	clk,
	input	rstn,
	
	input	[`datawidth-1:0]in1,
	input	[`datawidth-1:0]in2,
	input	[`datawidth-1:0]gamma,	//required by BF
	input	op,
	
	input	[`datawidth-1:0]p,
	input	[`datawidth-1:0]_p,
	input	[`datawidth-1:0]mu,		//required by mml
	
	output	[`datawidth-1:0]out1,
	output	[`datawidth-1:0]out2
);

wire    [`datawidth-1:0]mux_mm1_in1_D;
wire    [`datawidth-1:0]mux_mm1_in1_Q;
wire    [`datawidth-1:0]mm1_out_D;
wire    [`datawidth-1:0]mm1_out_Q;
wire    [`datawidth-1:0]ms1_out;
assign  mux_mm1_in1_D = op?ms1_out:in2;
DFF #(.datawidth(`datawidth)) dff_muxmm1in1_1(.clk(clk), .rstn(rstn), .D(mux_mm1_in1_D), .Q(mux_mm1_in1_Q));
wire    [`datawidth-1:0]gamma_Q;
DFF #(.datawidth(`datawidth)) dff_gamma_1(.clk(clk), .rstn(rstn), .D(gamma), .Q(gamma_Q));
km_mm	mm1(.clk(clk), .rstn(rstn), .in1(mux_mm1_in1_Q), .in2(gamma_Q), .mu(mu), .p(p), ._p(_p), .out(mm1_out_D));
DFF #(.datawidth(`datawidth)) dff_mm1out_1(.clk(clk), .rstn(rstn), .D(mm1_out_D), .Q(mm1_out_Q));



wire    [`datawidth-1:0]in1_Q;
wire    [`datawidth-1:0]in1_QQ;
wire    [`datawidth-1:0]in1_QQQ;
wire    [`datawidth-1:0]in1_QQQQ;
wire    [`datawidth-1:0]in1_QQQQQ;
wire    [`datawidth-1:0]in1_QQQQQQ;
wire    [`datawidth-1:0]in1_QQQQQQQ;
wire    [`datawidth-1:0]in1_QQQQQQQQ;
DFF #(.datawidth(`datawidth)) dff_in1_1(.clk(clk), .rstn(rstn), .D(in1),            .Q(in1_Q));
DFF #(.datawidth(`datawidth)) dff_in1_2(.clk(clk), .rstn(rstn), .D(in1_Q),          .Q(in1_QQ));
DFF #(.datawidth(`datawidth)) dff_in1_3(.clk(clk), .rstn(rstn), .D(in1_QQ),         .Q(in1_QQQ));
DFF #(.datawidth(`datawidth)) dff_in1_4(.clk(clk), .rstn(rstn), .D(in1_QQQ),        .Q(in1_QQQQ));
DFF #(.datawidth(`datawidth)) dff_in1_5(.clk(clk), .rstn(rstn), .D(in1_QQQQ),       .Q(in1_QQQQQ));
DFF #(.datawidth(`datawidth)) dff_in1_6(.clk(clk), .rstn(rstn), .D(in1_QQQQQ),      .Q(in1_QQQQQQ));
DFF #(.datawidth(`datawidth)) dff_in1_7(.clk(clk), .rstn(rstn), .D(in1_QQQQQQ),     .Q(in1_QQQQQQQ));
DFF #(.datawidth(`datawidth)) dff_in1_8(.clk(clk), .rstn(rstn), .D(in1_QQQQQQQ),    .Q(in1_QQQQQQQQ));
wire    [`datawidth-1:0]in2_Q;
wire    [`datawidth-1:0]in2_QQ;
wire    [`datawidth-1:0]in2_QQQ;
wire    [`datawidth-1:0]in2_QQQQ;
wire    [`datawidth-1:0]in2_QQQQQ;
wire    [`datawidth-1:0]in2_QQQQQQ;
wire    [`datawidth-1:0]in2_QQQQQQQ;
wire    [`datawidth-1:0]in2_QQQQQQQQ;
DFF #(.datawidth(`datawidth)) dff_in2_1(.clk(clk), .rstn(rstn), .D(in2),            .Q(in2_Q));
DFF #(.datawidth(`datawidth)) dff_in2_2(.clk(clk), .rstn(rstn), .D(in2_Q),          .Q(in2_QQ));
DFF #(.datawidth(`datawidth)) dff_in2_3(.clk(clk), .rstn(rstn), .D(in2_QQ),         .Q(in2_QQQ));
DFF #(.datawidth(`datawidth)) dff_in2_4(.clk(clk), .rstn(rstn), .D(in2_QQQ),        .Q(in2_QQQQ));
DFF #(.datawidth(`datawidth)) dff_in2_5(.clk(clk), .rstn(rstn), .D(in2_QQQQ),       .Q(in2_QQQQQ));
DFF #(.datawidth(`datawidth)) dff_in2_6(.clk(clk), .rstn(rstn), .D(in2_QQQQQ),      .Q(in2_QQQQQQ));
DFF #(.datawidth(`datawidth)) dff_in2_7(.clk(clk), .rstn(rstn), .D(in2_QQQQQQ),     .Q(in2_QQQQQQQ));
DFF #(.datawidth(`datawidth)) dff_in2_8(.clk(clk), .rstn(rstn), .D(in2_QQQQQQQ),    .Q(in2_QQQQQQQQ));
wire    [`datawidth-1:0]mux_ma1_in2;
wire    [`datawidth-1:0]ma1_out;
assign  mux_ma1_in2 = op?in2_QQQQQQQQ:mm1_out_Q;
mod_add ma1(.in1(in1_QQQQQQQQ), .in2(mux_ma1_in2), ._p(_p), .out(ma1_out));



wire    [`datawidth-1:0]mux_ms1_in1;
wire    [`datawidth-1:0]mux_ms1_in2;
assign  mux_ms1_in1 = op?in2:in1_QQQQQQQQ;
assign  mux_ms1_in2 = op?in1:mm1_out_Q;
mod_sub ms1(.in1(mux_ms1_in1), .in2(mux_ms1_in2), .p(p), .out(ms1_out));



assign  out1 = ma1_out;
assign  out2 = op?mm1_out_Q:ms1_out;

endmodule
