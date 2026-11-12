`timescale 1ns / 1ps
module tb_MIPS_Datapath_R();
    reg clk, reset;
    reg [31:0] Instruction, ReadData1, ReadData2;
    wire [31:0] PC_Current, ALUResult, RegWriteData; 
    wire [4:0] WriteRegister; wire RegWrite;

    MIPS_Datapath_R uut (
        .clk(clk), .reset(reset),
        .Instruction(Instruction), .ReadData1(ReadData1), .ReadData2(ReadData2),
        .PC_Current(PC_Current), .ALUResult(ALUResult), .WriteRegister(WriteRegister), 
        .RegWriteData(RegWriteData), .RegWrite(RegWrite)
    );

    // Generador de Reloj
    always #5 clk = ~clk; 

    initial begin
        $monitor("Tiempo=%0t | Reloj=%b | PC=%d | Opcode=%b | ALURes=%d", $time, clk, PC_Current, Instruction[31:26], ALUResult);
        
        // 1. Resetear sistema
        clk = 0; reset = 1; Instruction = 0; ReadData1 = 0; ReadData2 = 0;
        #10 reset = 0; 
        
        // Inyectamos datos en flanco de BAJADA para que esten listos en el flanco de SUBIDA
        @(negedge clk);
        Instruction = 32'b000000_01000_01001_01010_00000_100000; ReadData1 = 32'd15; ReadData2 = 32'd10; // ADD
        
        @(negedge clk);
        Instruction = 32'b000000_01000_01001_01011_00000_100010; ReadData1 = 32'd25; ReadData2 = 32'd5; // SUB
        
        @(negedge clk);
        $finish;
    end
endmodule
