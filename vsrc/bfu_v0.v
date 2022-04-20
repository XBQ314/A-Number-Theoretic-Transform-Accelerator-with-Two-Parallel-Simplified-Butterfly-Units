`include "ntt_define.vh"
module bfu_v0(
	input	clk,
	input	rstn,
	
	input	[`datawidth-1:0]in1,
	input	[`datawidth-1:0]in2,
	input	[`datawidth-1:0]gamma,	//required by BF
	input	[1:0]op,
	
	input	[`datawidth-1:0]p,
	input	[`datawidth-1:0]_p,
	input	[`datawidth-1:0]mu,		//required by mml
	
	output	[`datawidth-1:0]out1,
	output	[`datawidth-1:0]out2
);

wire	[`datawidth-1:0]ma1_out;
wire	[`datawidth-1:0]mux_ma1;
mod_add ma1(.in1(in1), .in2(in2), ._p(_p), .out(ma1_out));
assign	mux_ma1=op[0]?ma1_out:in1;
wire	[`datawidth-1:0]mux_ma1_Q;
wire	[`datawidth-1:0]mux_ma1_QQ;
wire	[`datawidth-1:0]mux_ma1_QQQ;
wire	[`datawidth-1:0]mux_ma1_QQQQ;
wire	[`datawidth-1:0]mux_ma1_QQQQQ;
wire	[`datawidth-1:0]mux_ma1_QQQQQQ;
wire	[`datawidth-1:0]mux_ma1_QQQQQQQ;
wire	[`datawidth-1:0]mux_ma1_QQQQQQQQ;
DFF #(.datawidth(`datawidth)) dff_muxma1_1(.clk(clk), .rstn(rstn), .D(mux_ma1), .Q(mux_ma1_Q));
DFF #(.datawidth(`datawidth)) dff_muxma1_2(.clk(clk), .rstn(rstn), .D(mux_ma1_Q), .Q(mux_ma1_QQ));
DFF #(.datawidth(`datawidth)) dff_muxma1_3(.clk(clk), .rstn(rstn), .D(mux_ma1_QQ), .Q(mux_ma1_QQQ));
DFF #(.datawidth(`datawidth)) dff_muxma1_4(.clk(clk), .rstn(rstn), .D(mux_ma1_QQQ), .Q(mux_ma1_QQQQ));
DFF #(.datawidth(`datawidth)) dff_muxma1_5(.clk(clk), .rstn(rstn), .D(mux_ma1_QQQQ), .Q(mux_ma1_QQQQQ));
DFF #(.datawidth(`datawidth)) dff_muxma1_6(.clk(clk), .rstn(rstn), .D(mux_ma1_QQQQQ), .Q(mux_ma1_QQQQQQ));
DFF #(.datawidth(`datawidth)) dff_muxma1_7(.clk(clk), .rstn(rstn), .D(mux_ma1_QQQQQQ), .Q(mux_ma1_QQQQQQQ));
DFF #(.datawidth(`datawidth)) dff_muxma1_8(.clk(clk), .rstn(rstn), .D(mux_ma1_QQQQQQQ), .Q(mux_ma1_QQQQQQQQ));


wire	[`datawidth-1:0]ms1_out;
wire	[`datawidth-1:0]mux_ms1;
mod_sub ms1(.in1(in2), .in2(in1), .p(p), .out(ms1_out));
assign	mux_ms1=op[1]?in2:(op[0]?ms1_out:in2);
wire	[`datawidth-1:0]mux_ms1_Q;
DFF #(.datawidth(`datawidth)) dff_muxms1_1(.clk(clk), .rstn(rstn), .D(mux_ms1), .Q(mux_ms1_Q));


wire	[`datawidth-1:0]mux_mm1;
assign	mux_mm1=op[1]?in1:(op[0]?gamma:gamma);
wire	[`datawidth-1:0]mux_mm1_Q;
DFF #(.datawidth(`datawidth)) dff_muxmm1_1(.clk(clk), .rstn(rstn), .D(mux_mm1), .Q(mux_mm1_Q));


wire	[`datawidth-1:0]mm1_out;
km_mm	mm1(.clk(clk), .rstn(rstn), .in1(mux_ms1_Q), .in2(mux_mm1_Q), .mu(mu), .p(p), ._p(_p), .out(mm1_out));
wire	[`datawidth-1:0]mm1_out_Q;
DFF #(.datawidth(`datawidth)) dff_mm1out_1(.clk(clk), .rstn(rstn), .D(mm1_out), .Q(mm1_out_Q));

wire	[1:0]op_Q;
wire	[1:0]op_QQ;
wire	[1:0]op_QQQ;
wire	[1:0]op_QQQQ;
wire	[1:0]op_QQQQQ;
wire	[1:0]op_QQQQQQ;
wire	[1:0]op_QQQQQQQ;
wire	[1:0]op_QQQQQQQQ;
DFF #(.datawidth(2)) dff_op1(.clk(clk), .rstn(rstn), .D(op), .Q(op_Q));
DFF #(.datawidth(2)) dff_op2(.clk(clk), .rstn(rstn), .D(op_Q), .Q(op_QQ));
DFF #(.datawidth(2)) dff_op3(.clk(clk), .rstn(rstn), .D(op_QQ), .Q(op_QQQ));
DFF #(.datawidth(2)) dff_op4(.clk(clk), .rstn(rstn), .D(op_QQQ), .Q(op_QQQQ));
DFF #(.datawidth(2)) dff_op5(.clk(clk), .rstn(rstn), .D(op_QQQQ), .Q(op_QQQQQ));
DFF #(.datawidth(2)) dff_op6(.clk(clk), .rstn(rstn), .D(op_QQQQQ), .Q(op_QQQQQQ));
DFF #(.datawidth(2)) dff_op7(.clk(clk), .rstn(rstn), .D(op_QQQQQQ), .Q(op_QQQQQQQ));
DFF #(.datawidth(2)) dff_op8(.clk(clk), .rstn(rstn), .D(op_QQQQQQQ), .Q(op_QQQQQQQQ));


wire	[`datawidth-1:0]ma2_out;
wire	[`datawidth-1:0]_p_Q;
wire	[`datawidth-1:0]_p_QQ;
wire	[`datawidth-1:0]_p_QQQ;
wire	[`datawidth-1:0]_p_QQQQ;
wire	[`datawidth-1:0]_p_QQQQQ;
wire	[`datawidth-1:0]_p_QQQQQQ;
wire	[`datawidth-1:0]_p_QQQQQQQ;
wire	[`datawidth-1:0]_p_QQQQQQQQ;
DFF #(.datawidth(`datawidth)) dff__p1(.clk(clk), .rstn(rstn), .D(_p), .Q(_p_Q));
DFF #(.datawidth(`datawidth)) dff__p2(.clk(clk), .rstn(rstn), .D(_p_Q), .Q(_p_QQ));
DFF #(.datawidth(`datawidth)) dff__p3(.clk(clk), .rstn(rstn), .D(_p_QQ), .Q(_p_QQQ));
DFF #(.datawidth(`datawidth)) dff__p4(.clk(clk), .rstn(rstn), .D(_p_QQQ), .Q(_p_QQQQ));
DFF #(.datawidth(`datawidth)) dff__p5(.clk(clk), .rstn(rstn), .D(_p_QQQQ), .Q(_p_QQQQQ));
DFF #(.datawidth(`datawidth)) dff__p6(.clk(clk), .rstn(rstn), .D(_p_QQQQQ), .Q(_p_QQQQQQ));
DFF #(.datawidth(`datawidth)) dff__p7(.clk(clk), .rstn(rstn), .D(_p_QQQQQQ), .Q(_p_QQQQQQQ));
DFF #(.datawidth(`datawidth)) dff__p8(.clk(clk), .rstn(rstn), .D(_p_QQQQQQQ), .Q(_p_QQQQQQQQ));
mod_add ma2(.in1(mux_ma1_QQQQQQQQ), .in2(mm1_out_Q), ._p(_p_QQQQQQQQ), .out(ma2_out));
assign	out1=op_QQQQQQQQ[1]?mm1_out_Q:(op_QQQQQQQQ[0]?mux_ma1_QQQQQQQQ:ma2_out);


wire	[`datawidth-1:0]ms2_out;
wire	[`datawidth-1:0]p_Q;
wire	[`datawidth-1:0]p_QQ;
wire	[`datawidth-1:0]p_QQQ;
wire	[`datawidth-1:0]p_QQQQ;
wire	[`datawidth-1:0]p_QQQQQ;
wire	[`datawidth-1:0]p_QQQQQQ;
wire	[`datawidth-1:0]p_QQQQQQQ;
wire	[`datawidth-1:0]p_QQQQQQQQ;
DFF #(.datawidth(`datawidth)) dff_p1(.clk(clk), .rstn(rstn), .D(p), .Q(p_Q));
DFF #(.datawidth(`datawidth)) dff_p2(.clk(clk), .rstn(rstn), .D(p_Q), .Q(p_QQ));
DFF #(.datawidth(`datawidth)) dff_p3(.clk(clk), .rstn(rstn), .D(p_QQ), .Q(p_QQQ));
DFF #(.datawidth(`datawidth)) dff_p4(.clk(clk), .rstn(rstn), .D(p_QQQ), .Q(p_QQQQ));
DFF #(.datawidth(`datawidth)) dff_p5(.clk(clk), .rstn(rstn), .D(p_QQQQ), .Q(p_QQQQQ));
DFF #(.datawidth(`datawidth)) dff_p6(.clk(clk), .rstn(rstn), .D(p_QQQQQ), .Q(p_QQQQQQ));
DFF #(.datawidth(`datawidth)) dff_p7(.clk(clk), .rstn(rstn), .D(p_QQQQQQ), .Q(p_QQQQQQQ));
DFF #(.datawidth(`datawidth)) dff_p8(.clk(clk), .rstn(rstn), .D(p_QQQQQQQ), .Q(p_QQQQQQQQ));
mod_sub ms2(.in1(mux_ma1_QQQQQQQQ), .in2(mm1_out_Q), .p(p_QQQQQQQQ), .out(ms2_out));
assign	out2=op_QQQQQQQQ[1]?'d0:(op_QQQQQQQQ[0]?mm1_out_Q:ms2_out);

endmodule