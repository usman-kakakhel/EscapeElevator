`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/17/2018 07:31:13 PM
// Design Name: 
// Module Name: calcDesiredFloor
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


module calcDesiredFloor(input clk, calcDesFloor, calcDirec, resettt,
                        input [1:0] currPos,
                        input [2:0] peopleOnEL,
                        input [3:0] myCust0, myCust1, myCust2, myCust3,
                        output [1:0] elDir,
                        output [1:0] desPos);
                        
    logic [1:0] desElePos;
    logic [1:0] elDirr;
    assign desPos = desElePos;
    assign elDir = elDirr;
    
    
    always_ff@(posedge clk, posedge resettt)
        begin
            if (resettt)
                begin
                    elDirr <= 0;
                    desElePos <= 0;
                end
            else 
                begin
                    if (peopleOnEL == 3'd4 & calcDesFloor) desElePos <= 0;
                    else if(calcDesFloor & peopleOnEL <= 3'd4 & myCust1 == 0 & myCust2 == 0 & myCust3 == 0) desElePos <= 0;
                    else if(calcDesFloor) 
                        begin
                            if (currPos == 0)
                                begin
                                    if (myCust1 > 0) desElePos <= 1;
                                    else if(myCust2 > 0) desElePos <= 2;
                                    else if(myCust3 > 0) desElePos <= 3;
                                end
                            else if (currPos == 1)
                                begin
                                    if (myCust1 > 0) desElePos <= 1;
                                    else if(myCust2 > 0) desElePos <= 2;
                                    else if(myCust3 > 0) desElePos <= 3;
                                end
                            else if (currPos == 2)
                                begin
                                    if (myCust2 > 0) desElePos <= 2;
                                    else if(myCust3 > 0) desElePos <= 3;
                                    else if(myCust1 > 0) desElePos <= 1;
                                end
                            else if (currPos == 3)
                                begin
                                    if (myCust3 > 0) desElePos <= 3;
                                    else if(myCust2 > 0) desElePos <= 2;
                                    else if(myCust1 > 0) desElePos <= 1;
                                end
                        end
                    if (calcDirec)
                        begin
                            if (currPos == desElePos & calcDesFloor & !resettt) elDirr <= 2'b00;
                            else if (currPos >= desElePos & calcDesFloor & !resettt) elDirr <= 2'b01;
                            else if (currPos <= desElePos & calcDesFloor & !resettt) elDirr <= 2'b10;
                        end
                    
                end 
            
        end    
endmodule
