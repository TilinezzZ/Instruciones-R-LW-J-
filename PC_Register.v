module PC_Register(
    input clk,
    input reset,
    input [31:0] PC_Next,
    output reg [31:0] PC_Current
);
    // Actualiza SOLO en el flanco de subida o al presionar reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            PC_Current <= 32'd0;
        else
            PC_Current <= PC_Next;
    end
endmodule
