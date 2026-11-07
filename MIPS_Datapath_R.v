// Módulo Top-Level que conecta las partes separadas
// Exclusivo para Tipo R, estructural y puramente combinacional
module MIPS_Datapath_R(
    input [31:0] Instruction,
    input [31:0] ReadData1, 
    input [31:0] ReadData2,
    output [31:0] ALUResult,
    output [4:0] WriteRegister,
    output [31:0] RegWriteData,
    output RegWrite
);
    // Extracción de campos
    wire [5:0] opcode = Instruction[31:26];
    wire [4:0] rt     = Instruction[20:16];
    wire [4:0] rd     = Instruction[15:11];
    wire [5:0] funct  = Instruction[5:0];

    // Cables internos para interconexión
    wire RegDst, ALUSrc, MemtoReg;
    wire [1:0] ALUOp;
    wire [3:0] ALUCtrl;
    wire [31:0] ALU_B_In;

    // 1. Instanciación Unidad de Control
    Control_Unit cu (
        .opcode(opcode),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .ALUOp(ALUOp)
    );

    // 2. Instanciación Mux RegDst
    Mux2x1_5bit mux_regdst (
        .d0(rt),
        .d1(rd),
        .sel(RegDst),
        .y(WriteRegister)
    );

    // 3. Instanciación Mux ALUSrc
    Mux2x1_32bit mux_alusrc (
        .d0(ReadData2),
        .d1(32'd0), // Valor extendido iría aquí, fijado a 0 en este caso aislado
        .sel(ALUSrc),
        .y(ALU_B_In)
    );

    // 4. Instanciación Control de ALU
    ALU_Control alu_ctrl (
        .ALUOp(ALUOp),
        .funct(funct),
        .ALUCtrl(ALUCtrl)
    );

    // 5. Instanciación de la ALU
    ALU alu_main (
        .A(ReadData1),
        .B(ALU_B_In),
        .ALUCtrl(ALUCtrl),
        .ALUResult(ALUResult)
    );

    // 6. Instanciación Mux MemtoReg
    Mux2x1_32bit mux_memtoreg (
        .d0(ALUResult),
        .d1(32'd0), // Dato de lectura de memoria iría aquí
        .sel(MemtoReg),
        .y(RegWriteData)
    );

endmodule
