// Control de la ALU
module ALU_Control(
    input [1:0] ALUOp,
    input [5:0] funct,
    output reg [3:0] ALUCtrl
);
    always @(*) begin
        if (ALUOp == 2'b10) begin
            case(funct)
                6'b100000: ALUCtrl = 4'b0010; // add
                6'b100010: ALUCtrl = 4'b0110; // subtract
                6'b100100: ALUCtrl = 4'b0000; // AND
                6'b100101: ALUCtrl = 4'b0001; // OR
                6'b101010: ALUCtrl = 4'b0111; // slt
                default:   ALUCtrl = 4'b0000;
            endcase
        end else begin
            ALUCtrl = 4'b0000;
        end
    end
endmodule
