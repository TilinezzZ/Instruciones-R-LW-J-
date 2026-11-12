module MIPS_Datapath_R(
    input clk, input reset, // <- AHORA ES SÍNCRONO
    input [31:0] Instruction, input [31:0] ReadData1, input [31:0] ReadData2,
    output [31:0] PC_Current, // Exponemos el PC para el testbench
    output [31:0] ALUResult, output [4:0] WriteRegister, output [31:0] RegWriteData, output RegWrite
);
    wire [31:0] PC_Next;
    assign PC_Next = PC_Current + 32'd4; // Para Tipo R, el PC solo avanza de 4 en 4
    
    // Instancia del Registro PC (Actualiza en posedge)
    PC_Register pc_reg (.clk(clk), .reset(reset), .PC_Next(PC_Next), .PC_Current(PC_Current));

    wire [5:0] opcode = Instruction[31:26];
    wire [4:0] rt = Instruction[20:16], rd = Instruction[15:11];
    wire [5:0] funct = Instruction[5:0];
    wire RegDst, ALUSrc, MemtoReg; wire [1:0] ALUOp; wire [3:0] ALUCtrl; wire [31:0] ALU_B_In;
    wire Zero;

    Control_Unit cu (.opcode(opcode), .RegDst(RegDst), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), .RegWrite(RegWrite), .ALUOp(ALUOp));
    Mux2x1_5bit mux_regdst (.d0(rt), .d1(rd), .sel(RegDst), .y(WriteRegister));
    Mux2x1_32bit mux_alusrc (.d0(ReadData2), .d1(32'd0), .sel(ALUSrc), .y(ALU_B_In));
    ALU_Control alu_ctrl (.ALUOp(ALUOp), .funct(funct), .ALUCtrl(ALUCtrl));
    ALU alu_main (.A(ReadData1), .B(ALU_B_In), .ALUCtrl(ALUCtrl), .ALUResult(ALUResult), .Zero(Zero));
    Mux2x1_32bit mux_memtoreg (.d0(ALUResult), .d1(32'd0), .sel(MemtoReg), .y(RegWriteData));
endmodule
