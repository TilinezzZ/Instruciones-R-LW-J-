module Control_Unit(
    input [5:0] opcode,
    output RegDst, ALUSrc, MemtoReg, RegWrite,
    output [1:0] ALUOp
);
    assign RegDst   = (opcode == 6'b000000) ? 1'b1 : 1'b0;
    assign ALUSrc   = (opcode == 6'b000000) ? 1'b0 : 1'bx;
    assign MemtoReg = (opcode == 6'b000000) ? 1'b0 : 1'bx;
    assign RegWrite = (opcode == 6'b000000) ? 1'b1 : 1'b0;
    assign ALUOp    = (opcode == 6'b000000) ? 2'b10 : 2'b00; 
endmodule
