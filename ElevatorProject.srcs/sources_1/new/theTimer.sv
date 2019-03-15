`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/17/2018 06:04:46 PM
// Design Name: 
// Module Name: theTimer
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


module theTimer(input clk, resetTimer, load,
                output [3:0] t1, t2, t3);
    
    
    logic theSecPulse;
    logic [3:0] tt1, tt2, tt3;
    assign t1 = tt1;
    assign t2 = tt2;
    assign t3 = tt3;
    
    clkToSec secPulseProvider(clk, resetTimer, load, theSecPulse);
    

    always_ff@(posedge clk, posedge resetTimer)
        begin
            if(resetTimer) 
                begin
                      tt1 <= 0;
                      tt2 <= 0;
                      tt3 <= 0;
                end
            else
                begin
                    if (load)
                        begin
                            tt1 = tt1 + theSecPulse;
                            if (tt1 > 4'd9)
                             begin
                                tt1 <= 0;
                                tt2 <= tt2 + 1;
                             end
                            if (tt2 > 4'd9)
                                begin
                                    tt1 <= 0;
                                    tt2 <= 0;
                                    tt3 <= tt3 +1;
                                end
                            if (tt3 > 4'd9)
                                begin
                                    tt1 <= 0;
                                    tt2 <= 0;
                                    tt3 <= 0;
                                end
                        end
                end 
        end
           
endmodule
