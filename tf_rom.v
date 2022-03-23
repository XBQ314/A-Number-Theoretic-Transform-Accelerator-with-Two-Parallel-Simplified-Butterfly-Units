`include "ntt_define.vh"

module tf_rom
(
    input clk,
    input rstn,
    input special_add,
    input op,
    input [10:0]gamma1_add,
    input [10:0]gamma2_add,

    output [`datawidth-1:0]gamma1,
    output [`datawidth-1:0]gamma2
);

wire [`datawidth-1:0] gamma_bank1_douta;
wire [`datawidth-1:0] gamma_bank2_douta;
// assign gamma1 = (~op & ~special_add)?:
//                 (~op &  special_add)?:
//                 ( op &  special_add)?:
//                 ( op & ~special_add)?:'d0;
assign gamma1 = gamma_bank1_douta;
// assign gamma2 = (~op & ~special_add)?gamma_bank1_douta:
//                 (~op &  special_add)?gamma_bank2_douta:
//                 ( op &  special_add)?gamma_bank2_douta:
//                 ( op & ~special_add)?gamma_bank1_douta:'d0;
assign gamma2 = ( special_add)?gamma_bank2_douta:
                (~special_add)?gamma_bank1_douta:'d0;
gamma_bank gamma_bank1 (.clka(clk), .ena('d1), .wea('d0), .addra(gamma1_add), .dina('d0), .douta(gamma_bank1_douta));
gamma_bank gamma_bank2 (.clka(clk), .ena('d1), .wea('d0), .addra(gamma2_add), .dina('d0), .douta(gamma_bank2_douta));
// input wire clka
// input wire ena
// input wire [0 : 0] wea
// input wire [10 : 0] addra
// input wire [13 : 0] dina
// output wire [13 : 0] douta
endmodule