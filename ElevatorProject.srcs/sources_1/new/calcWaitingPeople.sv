`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/17/2018 06:29:30 PM
// Design Name: 
// Module Name: calcWaitingPeople
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


module calcWaitingPeople(input clk, sec2Load, peopleLoad, resetPeople,
                         input [1:0] currPositionElev,
                         input [1:0] but0, but1, but2, but3,
                         input [3:0] pFloor0, pFloor1, pFloor2, pFloor3,
                         input [2:0] pOnElev,
                         output [2:0] peOnElev,
                         output [3:0] waitFloor0, waitFloor1, waitFloor2, waitFloor3);
    
    logic [3:0] theWait0, theWait1, theWait2, theWait3;
    assign waitFloor0 = theWait0;
    assign waitFloor1 = theWait1;
    assign waitFloor2 = theWait2;
    assign waitFloor3 = theWait3;
    
    logic [2:0] ridingP;
    assign peOnElev = ridingP;
    //logic [2:0] peoOnEle;
    //assign peOnElev = peoOnEle;
    //logic [3:0] peopFloor0, peopFloor1, peopFloor2, peopFloor3;
    
    logic [2:0] emptySpace;
    assign emptySpace = 3'd4 - pOnElev;
    
    reg ell = 1;
    //assign ell = 1;
    
    
    always_ff @(posedge clk, posedge resetPeople)
        begin
            if (sec2Load & ell == 1 & !resetPeople)
                begin
                    ell <=1;
                    if (currPositionElev == 0) ridingP = 4'b0;
                    else if(currPositionElev == 1)
                        begin
                            if (emptySpace > pFloor1)
                                begin
                                    ridingP <= pFloor1;
                                    theWait1 <= 0;
                                    
                                end
                            else
                                begin
                                    ridingP <= 3'd4;
                                    theWait1 <= pFloor1 - 3'd4;
                                    
                                end
                        end
                    else if(currPositionElev == 2)
                        begin
                            if (emptySpace > pFloor2)
                                begin
                                    ridingP <= pFloor2;
                                    theWait2 <= 0;
                                    
                                end
                            else
                                begin
                                    ridingP <= 3'd4;
                                    theWait2 <= pFloor2 - 3'd4;
                                    
                                end
                        end
                    else if(currPositionElev == 3)
                        begin
                            if (emptySpace > pFloor3)
                                begin
                                    ridingP <= pFloor3;
                                    theWait3 <= 0;
                                    
                                end
                            else
                                begin
                                    ridingP <= 3'd4;
                                    theWait3 <= pFloor3 - 3'd4;
                                    
                                end
                        end
                end
            if (peopleLoad & !resetPeople)
                begin
                    if (but0[0] & theWait0 > 4'd0 ) theWait0 = theWait0 - 1;
                    if (but0[1] & theWait0 < 4'd12) theWait0 = theWait0 + 1;
                    if (but1[0] & theWait1 > 4'd0 ) theWait1 = theWait1 - 1;
                    if (but1[1] & theWait1 < 4'd12) theWait1 = theWait1 + 1;
                    if (but2[0] & theWait2 > 4'd0 ) theWait2 = theWait2 - 1;
                    if (but2[1] & theWait2 < 4'd12) theWait2 = theWait2 + 1;
                    if (but3[0] & theWait3 > 4'd0 ) theWait3 = theWait3 - 1;
                    if (but3[1] & theWait3 < 4'd12) theWait3 = theWait3 + 1;
                end
            if (resetPeople)
                begin
                    theWait0 = 4'b0;
                    theWait1 = 4'b0;
                    theWait2 = 4'b0;
                    theWait3 = 4'b0;
                    ridingP = 4'b0;
                end
        end
    
    
endmodule
