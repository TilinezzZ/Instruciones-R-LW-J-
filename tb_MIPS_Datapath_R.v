`timescale 1ns / 1ps

module tb_MIPS_Datapath_R();

    // 1. Declaración de señales (reg para entradas, wire para salidas)
    reg [31:0] Instruction;
    reg [31:0] ReadData1;
    reg [31:0] ReadData2;

    wire [31:0] ALUResult;
    wire [4:0] WriteRegister;
    wire [31:0] RegWriteData;
    wire RegWrite;

    // 2. Instanciación del módulo Top-Level (Unit Under Test)
    MIPS_Datapath_R uut (
        .Instruction(Instruction),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
        .ALUResult(ALUResult),
        .WriteRegister(WriteRegister),
        .RegWriteData(RegWriteData),
        .RegWrite(RegWrite)
    );

    // 3. Bloque inicial para inyectar los estímulos (valores)
    initial begin
        // $monitor imprime automáticamente en la consola cada vez que una señal cambia
        $monitor("Tiempo=%0t | Instr=%b | R1=%d | R2=%d | ALURes=%d | RegDest=%d", 
                 $time, Instruction, ReadData1, ReadData2, ALUResult, WriteRegister);

        // --- TEST 1: Instrucción ADD (Suma) ---
        // opcode=0, rs=8, rt=9, rd=10, shamt=0, funct=32 (100000 binario)
        Instruction = 32'b000000_01000_01001_01010_00000_100000;
        ReadData1 = 32'd15; // Inyectamos un 15 en el registro 1
        ReadData2 = 32'd10; // Inyectamos un 10 en el registro 2
        #10; // Esperamos 10 nanosegundos para que la circuitería se propague
        
        // --- TEST 2: Instrucción SUB (Resta) ---
        // opcode=0, rs=8, rt=9, rd=11, shamt=0, funct=34 (100010 binario)
        Instruction = 32'b000000_01000_01001_01011_00000_100010;
        ReadData1 = 32'd25;
        ReadData2 = 32'd5;
        #10;
        
        // --- TEST 3: Instrucción AND ---
        // opcode=0, rs=8, rt=9, rd=12, shamt=0, funct=36 (100100 binario)
        Instruction = 32'b000000_01000_01001_01100_00000_100100;
        ReadData1 = 32'b1100; // 12 en decimal
        ReadData2 = 32'b1010; // 10 en decimal
        #10;

        // Finalizar la simulación
        $finish;
    end

endmodule
