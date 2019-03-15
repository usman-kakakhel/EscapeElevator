`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/17/2018 02:36:39 AM
// Design Name: 
// Module Name: theElevator
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


module theElevator(input clk, es, reset, resetTimer, 
                   input [1:0] buttons0, buttons1, buttons2, buttons3,
                   output [3:0] t1,t2, t3,
                   output [1:0] dirElevator,
                   output [2:0] onElevator,
                   output [1:0] posElevator,
                   output [3:0] waitFloor0, waitFloor1, waitFloor2, waitFloor3,
                   output [2:0] cS, nS);
                   //output [1:0] des);
                   
    
    logic timerload;
    logic theTimerReset;
    logic in_Dec_PeopleLoad;
    logic calcDesFloor;
    
    assign theTimerReset = reset | resetTimer;
    
    logic set3SecLoad;
    logic set3SecLoad1;
    logic goToDirCalc;
    logic calcDiir;
    logic set2SecLoad;
    logic set2SecLoad1;
    logic goToDirCalc1;
    
    logic [2:0] peopleOnElevator;
    logic [1:0] desiredElPos, currElPos, dirEl;
    
    //assign des = desiredElPos;
    
    assign dirElevator = dirEl;
    assign onElevator = peopleOnElevator;
    assign posElevator = currElPos;
    
    logic [3:0] waitingPeople0, waitingPeople1, waitingPeople2, waitingPeople3;
    assign waitFloor0 = waitingPeople0;
    assign waitFloor1 = waitingPeople1;
    assign waitFloor2 = waitingPeople2;
    assign waitFloor3 = waitingPeople3;
    
    
    theTimer myTimer(clk, theTimerReset, timerload, t1, t2, t3);
    calcPositioningPeople myCalcPeople(clk, set2SecLoad, set2SecLoad1, in_Dec_PeopleLoad, reset,currElPos, buttons0, buttons1, buttons2, buttons3, peopleOnElevator, waitingPeople0, waitingPeople1, waitingPeople2, waitingPeople3, peopleOnElevator, waitingPeople0, waitingPeople1, waitingPeople2, waitingPeople3);
    calcDesiredFloor myDesFloor(clk, calcDesFloor,calcDiir,reset, currElPos, peopleOnElevator, waitingPeople0, waitingPeople1, waitingPeople2, waitingPeople3, dirEl, desiredElPos);
    sec3Timer my3Timer(clk, set3SecLoad, set3SecLoad1, reset, currElPos, dirEl, currElPos, goToDirCalc);
    sec2Timer my2TImer(clk, set2SecLoad, reset, goToDirCalc1);
    
    
    logic [2:0] state, nextState;
    assign cS = state;
    assign nS = nextState;
    
    always_ff @(posedge clk, posedge reset)
        begin
            if (reset) state = 3'b000;
            else state = nextState;
        end
    
    
    
    always_comb
        begin
            if (state == 3'b000) nextState = 3'b001;
            else if (state == 3'b001)
                begin
                    if(es == 0) nextState = 3'b001;
                    else if (es == 1) nextState = 3'b010;
                    //else nextState = 3'b001;
                end
            else if (state == 3'b010)
                begin
                    if (desiredElPos == 0 & peopleOnElevator == 0) nextState = 3'b001;
                    else if (desiredElPos != currElPos) nextState = 3'b011;
                    else if (desiredElPos == currElPos & ~(desiredElPos == 0 & peopleOnElevator == 0)) nextState = 3'b110;
                    //else nextState = 3'b010;
                end
            else if (state == 3'b011)
                begin
                    if (goToDirCalc) nextState = 3'b101;
                    else nextState = 3'b011;
                end
            else if (state == 3'b100)
                begin
                    if (goToDirCalc1) nextState = 3'b010;
                    else nextState = 3'b100;
                end
            else if (state == 3'b101) nextState = 3'b010;
            else if (state == 3'b110) nextState = 3'b100;
            else nextState = 3'b000;
        end
        
    always_comb
        begin
            if (state == 3'b000)
                begin
                    timerload = 0;
                    in_Dec_PeopleLoad = 0;
                    calcDesFloor = 0;
                    set3SecLoad = 0;
                    set2SecLoad = 0;
                    set3SecLoad1 = 0;
                    set2SecLoad1 = 0;
                    calcDiir = 0;
                end
            else if (state == 3'b001)
                begin
                    timerload = 0;
                    in_Dec_PeopleLoad = 1;
                    calcDesFloor = 0;
                    set3SecLoad = 0;
                    set2SecLoad = 0;
                    set3SecLoad1 = 0;
                    set2SecLoad1 = 0;
                    calcDiir = 0;
                end
            else if (state == 3'b010)
                begin
                    timerload = 1;
                    in_Dec_PeopleLoad = 0;
                    calcDesFloor = 1;
                    set3SecLoad = 0;
                    set2SecLoad = 0;
                    set3SecLoad1 = 0;
                    set2SecLoad1 = 0;
                    calcDiir = 1;
                end
            else if (state == 3'b011)
                begin
                    timerload = 1;
                    in_Dec_PeopleLoad = 0;
                    calcDesFloor = 0;
                    set3SecLoad = 1;
                    set2SecLoad = 0;
                    set3SecLoad1 = 0;
                    set2SecLoad1 = 0;
                    calcDiir = 0;
                end
            else if (state == 3'b100)
                begin
                    timerload = 1;
                    in_Dec_PeopleLoad = 0;
                    calcDesFloor = 1;
                    set3SecLoad = 0;
                    set2SecLoad = 1;
                    set3SecLoad1 = 0;
                    set2SecLoad1 = 0;
                    calcDiir = 0;
                end
            else if(state == 3'b101)
                begin
                    timerload = 1;
                    in_Dec_PeopleLoad = 0;
                    calcDesFloor = 0;
                    set3SecLoad = 0;
                    set2SecLoad = 0;
                    set3SecLoad1 = 1;
                    set2SecLoad1 = 0;
                    calcDiir = 0; 
                end
            else if(state == 3'b110)
                begin
                    timerload = 1;
                    in_Dec_PeopleLoad = 0;
                    calcDesFloor = 0;
                    set3SecLoad = 0;
                    set2SecLoad = 0;
                    set3SecLoad1 = 0;
                    set2SecLoad1 = 1;
                    calcDiir = 0; 
                end
        end
    
endmodule
