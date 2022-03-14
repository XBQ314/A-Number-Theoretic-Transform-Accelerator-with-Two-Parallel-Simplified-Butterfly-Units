`include "ntt_define.vh"

module km_mm(
	input	clk,
	input	rstn,
	input	[`datawidth-1:0]in1,
	input	[`datawidth-1:0]in2,
	
	input	[`datawidth-1:0]mu,
	input	[`datawidth-1:0]p,
	input	[`datawidth-1:0]_p,
	
	output	[`datawidth-1:0]out
);
wire	[`datawidth-1:0]	mu_Q;
wire	[`datawidth-1:0]	mu_QQ;
DFF #(.datawidth(`datawidth)) dff_mu1(.clk(clk), .rstn(rstn), .D(mu), .Q(mu_Q));
DFF #(.datawidth(`datawidth)) dff_mu2(.clk(clk), .rstn(rstn), .D(mu_Q), .Q(mu_QQ));

wire	[`datawidth-1:0]	p_Q;
wire	[`datawidth-1:0]	p_QQ;
wire	[`datawidth-1:0]	p_QQQ;
wire	[`datawidth-1:0]	p_QQQQ;
DFF #(.datawidth(`datawidth)) dff_p1(.clk(clk), .rstn(rstn), .D(p), .Q(p_Q));
DFF #(.datawidth(`datawidth)) dff_p2(.clk(clk), .rstn(rstn), .D(p_Q), .Q(p_QQ));
DFF #(.datawidth(`datawidth)) dff_p3(.clk(clk), .rstn(rstn), .D(p_QQ), .Q(p_QQQ));
DFF #(.datawidth(`datawidth)) dff_p4(.clk(clk), .rstn(rstn), .D(p_QQQ), .Q(p_QQQQ));

wire	[`datawidth-1:0]	_p_Q;
wire	[`datawidth-1:0]	_p_QQ;
wire	[`datawidth-1:0]	_p_QQQ;
wire	[`datawidth-1:0]	_p_QQQQ;
wire	[`datawidth-1:0]	_p_QQQQQ;
wire	[`datawidth-1:0]	_p_QQQQQQ;
DFF #(.datawidth(`datawidth)) dff__p1(.clk(clk), .rstn(rstn), .D(_p), .Q(_p_Q));
DFF #(.datawidth(`datawidth)) dff__p2(.clk(clk), .rstn(rstn), .D(_p_Q), .Q(_p_QQ));
DFF #(.datawidth(`datawidth)) dff__p3(.clk(clk), .rstn(rstn), .D(_p_QQ), .Q(_p_QQQ));
DFF #(.datawidth(`datawidth)) dff__p4(.clk(clk), .rstn(rstn), .D(_p_QQQ), .Q(_p_QQQQ));
DFF #(.datawidth(`datawidth)) dff__p5(.clk(clk), .rstn(rstn), .D(_p_QQQQ), .Q(_p_QQQQQ));
DFF #(.datawidth(`datawidth)) dff__p6(.clk(clk), .rstn(rstn), .D(_p_QQQQQ), .Q(_p_QQQQQQ));
	
wire	[`datawidth-1:0]	T_L;
wire	[`datawidth-1:0]	T_H_D;
wire	[`datawidth-1:0]	T_H_Q;
wire	[`datawidth-1:0]	T_H_QQ;
wire	[`datawidth-1:0]	T_H_QQQ;
wire	[`datawidth-1:0]	T_H_QQQQ;
DFF #(.datawidth(`datawidth)) dff_T_H1(.clk(clk), .rstn(rstn), .D(T_H_D), .Q(T_H_Q));
DFF #(.datawidth(`datawidth)) dff_T_H2(.clk(clk), .rstn(rstn), .D(T_H_Q), .Q(T_H_QQ));
DFF #(.datawidth(`datawidth)) dff_T_H3(.clk(clk), .rstn(rstn), .D(T_H_QQ), .Q(T_H_QQQ));
DFF #(.datawidth(`datawidth)) dff_T_H4(.clk(clk), .rstn(rstn), .D(T_H_QQQ), .Q(T_H_QQQQ));

wire	[`datawidth-1:0]	c;

wire	[`datawidth-1:0]	tmp;

wire	carry_D;
wire	carry_Q;
wire	carry_QQ;
wire	carry_QQQ;
wire	carry_QQQQ;
assign	carry_D=(|T_L);
DFF #(.datawidth(`datawidth)) dff_carry1(.clk(clk), .rstn(rstn), .D(carry_D), .Q(carry_Q));
DFF #(.datawidth(`datawidth)) dff_carry2(.clk(clk), .rstn(rstn), .D(carry_Q), .Q(carry_QQ));
DFF #(.datawidth(`datawidth)) dff_carry3(.clk(clk), .rstn(rstn), .D(carry_QQ), .Q(carry_QQQ));DFF #(.datawidth(`datawidth)) dff_carry4(.clk(clk), .rstn(rstn), .D(carry_QQQ), .Q(carry_QQQQ));

old_km old_km1(
	.clk(clk),
	.rstn(rstn),
	.in1(in1),
	.in2(in2),
	
	.out_L(T_L),
	.out_H(T_H_D)
);

old_km old_km2(
	.clk(clk),
	.rstn(rstn),
	.in1(T_L),
	.in2(mu_QQ),
	
	.out_L(c),
	.out_H()
);

old_km old_km3(
	.clk(clk),
	.rstn(rstn),
	.in1(c),
	.in2(p_QQQQ),
	
	.out_L(),
	.out_H(tmp)
);

mod_add ma(
	.in1(T_H_QQQQ+carry_QQQQ),
	.in2(tmp),
	._p(_p_QQQQQQ),
	
	.out(out)
);
endmodule