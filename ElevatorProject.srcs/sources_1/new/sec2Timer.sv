`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/17/2018 10:30:06 PM
// Design Name: 
// Module Name: sec2Timer
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


module sec2Timer(input clk, sec2Load, resettttt,
                 output goBackkk);
    
    logic seconddPulse; 
    logic [1:0] thissPulse;
    
                
    logic gooBackk;
    assign goBackkk = gooBackk;

     clkToSec sec2PulseProviderr(clk, resettttt, sec2Load, seconddPulse);
     
    always_ff @(posedge clk, posedge resettttt)
        begin
            gooBackk <= 0;
            if (resettttt)
                begin
                    gooBackk <= 0;
                    thissPulse <= 0;
                end
            else
                begin
                    if(sec2Load) 
                        begin 
                            thissPulse <= thissPulse + seconddPulse;
                        end
                    if (thissPulse >= 2'd2)
                        begin
                            gooBackk <= 1;
                            thissPulse <= 0;
                        end
                end    
            
             
        end
    
endmodule
