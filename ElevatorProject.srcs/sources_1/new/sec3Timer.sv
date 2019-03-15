`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/17/2018 09:01:09 PM
// Design Name: 
// Module Name: sec3Timer
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


module sec3Timer(input clk, sec3Load, sec3Load1, ressett,
                 input [1:0] currPosElev, directionElevator, 
                 output [1:0] newCurrPosELev,
                 output goBack);
                 
    logic secondPulse; 
    logic [1:0] thisPulse;
                
    logic gooBack;
    assign goBack = gooBack;
    logic [1:0] nep;
    assign newCurrPosELev = nep;
    
    clkToSec secPulseProviderr(clk, ressett, sec3Load, secondPulse);
        
    always_ff @(posedge clk, posedge ressett)
        begin
            gooBack <= 0;
            if (ressett) 
                begin
                    nep <= 0;
                    thisPulse <= 0;
                    gooBack <=0;
                end
            else
                begin
                    if(sec3Load) 
                        begin 
                            thisPulse <= thisPulse + secondPulse;
                            
                        end
                    else if(sec3Load1)
                        begin
                            if (directionElevator == 2'b01) nep <= currPosElev - 1;
                            else if (directionElevator == 2'b10) nep <= currPosElev + 1;
                        end
                    if (thisPulse >= 2'd3) 
                        begin
                            thisPulse <= 0;
                            gooBack <= 1;
                        end  
                end
        end        
       
endmodule
