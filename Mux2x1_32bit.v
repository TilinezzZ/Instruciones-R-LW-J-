module Mux2x1_32bit(
    input [31:0] d0, d1, input sel, output [31:0] y
);
    assign y = sel ? d1 : d0;
endmodule
