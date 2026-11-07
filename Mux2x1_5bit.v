// Multiplexor 2 a 1 de 5 bits (usado para RegDst)
module Mux2x1_5bit(
    input [4:0] d0, d1,
    input sel,
    output [4:0] y
);
    assign y = sel ? d1 : d0;
endmodule
