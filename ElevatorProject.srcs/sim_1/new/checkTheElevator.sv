`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2018 12:33:13 AM
// Design Name: 
// Module Name: checkTheElevator
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


module checkTheElevator();
    logic es, reset, resetTimer;
    logic[1:0] buttons0, buttons1, buttons2, buttons3;
    logic [9:0] timer;
    logic [1:0] dirElevator;
    logic [2:0] onElevator;
    logic [1:0] posElevator;
    logic [3:0] waitFloor0, waitFloor1, waitFloor2, waitFloor3;
    logic [2:0] cS, nS;
    logic sclk;
    logic a,b,c,d,e,f,g,dp;
    logic [3:0] an;
    
                       
     logic [3:0]keyb_col;
      logic [1:0] desiredElPOOS;                 
    
    
    
    always
        begin 
            sclk = 1; #5; sclk = 0; #5;
        end
    //topModule myElevator(sclk, es, reset, resetTimer,buttons0, buttons1, buttons2, buttons3, keyb_col,a,b,c,d,e,f,g,dp,posElevator,an,cS, waitFloor1, waitFloor2);
    theElevator thisEl(sclk, es, reset, resetTimer, buttons0, buttons1, buttons2, buttons3,timer,dirElevator,onElevator,posElevator,waitFloor0, waitFloor1, waitFloor2, waitFloor3,cS, nS);  
        
     initial 
        begin
            es = 0;
            reset = 1;
            //buttons0 = 2'b10;
            //buttons1 = 2'b10;
            #7 reset = 0;
            #7 buttons1 = 2'b10;
            #7 buttons1 = 2'b00; 
            #7 buttons1 = 2'b10;
            #7 buttons1 = 2'b00;
            #7 buttons1 = 2'b10;
            #7 buttons1 = 2'b00;
            #7 buttons2 = 2'b10;
            #7 buttons2 = 2'b00;
            #7 buttons3 = 2'b10;
            #7 buttons3 = 2'b00; 
            #7 buttons3 = 2'b10;
            #7 buttons3 = 2'b00;
            #7 buttons3 = 2'b10;
            #7 buttons3 = 2'b00;
            #15
            buttons1 = 2'b00;
            #15 es = 1;
            #30 es = 0;
            //buttons1 = 2'b10;
            
        end   
    
endmodule
