module ALU(
    input [31:0] A, B, input [3:0] ALUCtrl, output reg [31:0] ALUResult, output Zero
);
    always @(*) begin
        case(ALUCtrl)
            4'b0000: ALUResult = A & B;
            4'b0001: ALUResult = A | B;
            4'b0010: ALUResult = A + B;
            4'b0110: ALUResult = A - B;
            4'b0111: ALUResult = (A < B) ? 32'd1 : 32'd0;
            default: ALUResult = 32'd0;
        endcase
    end
    assign Zero = (ALUResult == 32'd0) ? 1'b1 : 1'b0;
endmodule
