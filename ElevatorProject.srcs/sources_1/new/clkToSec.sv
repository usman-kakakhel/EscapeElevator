`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/17/2018 03:48:23 AM
// Design Name: 
// Module Name: clkToSec
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


module clkToSec(input clk, reset, load,
                output secClk);
    
    logic [27:0] ctr;
    logic outtt;
    assign secClk = outtt;
    
    always_ff @(posedge clk, posedge reset)
        begin
            outtt <= 0;
            if(reset) 
                begin
                    ctr <= 0;
                    outtt <= 0;
                end
            else if ((ctr < 27'd100000000) & (load == 1))
                begin 
                    ctr <= ctr + 1; 
                end
            else if (load == 1)
                begin
                    ctr <= 0; 
                    outtt <= 1;
                end
        
            
        end
endmodule
