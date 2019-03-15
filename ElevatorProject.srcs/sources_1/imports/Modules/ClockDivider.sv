`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2018 03:26:27 PM
// Design Name: 
// Module Name: ClockDivider
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ClockDivider(input logic clk_in,
                    output logic clk_out);
                    
    logic [27:0] count = {28{1'b0}};
    logic clk_NoBuf;
    
    always@ (posedge clk_in) begin
        count <= count + 1;
    end
    // you can modify 25 to have different clock rate
    assign clk_NoBuf = count[27];
    
    BUFG BUFG_inst (.I(clk_NoBuf), // 1-bit input: Clock input
                    .O(clk_out) // 1-bit output: Clock output
                                  );
    
endmodule