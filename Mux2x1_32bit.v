// Multiplexor 2 a 1 de 32 bits (usado para ALUSrc y MemtoReg)
module Mux2x1_32bit(
    input [31:0] d0, d1,
    input sel,
    output [31:0] y
);
    assign y = sel ? d1 : d0;
endmodule
