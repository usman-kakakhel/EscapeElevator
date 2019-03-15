`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2018 07:02:32 PM
// Design Name: 
// Module Name: topModule
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


module topModule(  input clk, es, reset, resetTimer, 
                   //input [1:0] buttons0, buttons1, buttons2, buttons3,
                   input [3:0]keyb_col,
                   output a, b, c, d, e, f, g, dp,
                   //output [1:0] posElevator,
                   output [3:0] an,
                   //output [2:0] css,
                   //output [3:0]  waitFloor1, waitFloor2,
                   output reset_out,
                   output OE,
                   output SH_CP,
                   output ST_CP,
                   output DS,
                   output [7:0]col_select,
                   output [3:0]keyb_row);
    
   
    logic [1:0] dirElevator;
    logic [2:0] onElevator; 
    
    logic [1:0] posElevator;
    
    logic [2:0] cS, nS;
    //assign css = cS; 
    logic [3:0] waitFloor0;
    logic [3:0] waitFloor1;
    logic [3:0] waitFloor2;
    logic [3:0] waitFloor3; 
    
    logic [1:0] buttons0, buttons1, buttons2, buttons3;  
    
    logic [3:0] sig1, sig2, sig3;
       
    theElevator thisEl(clk, es, reset, resetTimer, buttons0, buttons1, buttons2, buttons3,sig1, sig2, sig3,dirElevator,onElevator,posElevator,waitFloor0, waitFloor1, waitFloor2, waitFloor3,cS, nS);
    
    
    
    
        
     SevSeg_4digit mySeg(clk, sig1, sig2, sig3, dirElevator, a, b, c, d, e, f, g, dp, an );
     
     logic col_data_capture;
     logic [2:0]col_num;
     logic [7:0] blue_vect_in, red_vect_in, green_vect_in;
     logic [1:0] fs0,fs1,fs2,fs3;
     assign green_vect_in = 8'b00000000;
     
     always_comb
        begin
            fs0 = 2'b00;
            fs1 = 2'b00;
            fs2 = 2'b00;
            fs3 = 2'b00;
            red_vect_in = 8'b00000000;
            blue_vect_in = 8'b00000000;
            case(col_num)
                3'd0: case(onElevator)
                        3'd0: case(posElevator)
                                2'd0: blue_vect_in = 8'b00000011;
                                2'd1: blue_vect_in = 8'b00001100;
                                2'd2: blue_vect_in = 8'b00110000;
                                2'd3: blue_vect_in = 8'b11000000;
                              endcase
                        3'd1: case(posElevator)
                                  2'd0: begin blue_vect_in = 8'b00000001; red_vect_in = 8'b00000010; end 
                                  2'd1: begin blue_vect_in = 8'b00000100; red_vect_in = 8'b00001000; end
                                  2'd2: begin blue_vect_in = 8'b00010000; red_vect_in = 8'b00100000; end
                                  2'd3: begin blue_vect_in = 8'b01000000; red_vect_in = 8'b10000000; end
                                endcase
                        3'd2: case(posElevator)
                               2'd0: begin blue_vect_in = 8'b00000001; red_vect_in = 8'b00000010; end 
                               2'd1: begin blue_vect_in = 8'b00000100; red_vect_in = 8'b00001000; end
                               2'd2: begin blue_vect_in = 8'b00010000; red_vect_in = 8'b00100000; end
                               2'd3: begin blue_vect_in = 8'b01000000; red_vect_in = 8'b10000000; end
                              endcase
                        3'd3: case(posElevator)
                                  2'd0: begin red_vect_in = 8'b00000011; end 
                                  2'd1: begin  red_vect_in = 8'b00001100; end
                                  2'd2: begin  red_vect_in = 8'b00110000; end
                                  2'd3: begin  red_vect_in = 8'b11000000; end
                                endcase
                        3'd4: case(posElevator)
                                2'd0: begin red_vect_in = 8'b00000011; end 
                                2'd1: begin  red_vect_in = 8'b00001100; end
                                2'd2: begin  red_vect_in = 8'b00110000; end
                                2'd3: begin  red_vect_in = 8'b11000000; end
                              endcase
                      endcase
                3'd1: case(onElevator)
                      3'd0: case(posElevator)
                              2'd0: blue_vect_in = 8'b00000011;
                              2'd1: blue_vect_in = 8'b00001100;
                              2'd2: blue_vect_in = 8'b00110000;
                              2'd3: blue_vect_in = 8'b11000000;
                            endcase
                      3'd1: case(posElevator)
                                2'd0: blue_vect_in = 8'b00000011;
                                2'd1: blue_vect_in = 8'b00001100;
                                2'd2: blue_vect_in = 8'b00110000;
                                2'd3: blue_vect_in = 8'b11000000;
                              endcase
                      3'd2: case(posElevator)
                             2'd0: begin blue_vect_in = 8'b00000001; red_vect_in = 8'b00000010; end 
                             2'd1: begin blue_vect_in = 8'b00000100; red_vect_in = 8'b00001000; end
                             2'd2: begin blue_vect_in = 8'b00010000; red_vect_in = 8'b00100000; end
                             2'd3: begin blue_vect_in = 8'b01000000; red_vect_in = 8'b10000000; end
                            endcase
                      3'd3: case(posElevator)
                                2'd0: begin blue_vect_in = 8'b00000001; red_vect_in = 8'b00000010; end 
                                2'd1: begin blue_vect_in = 8'b00000100; red_vect_in = 8'b00001000; end
                                2'd2: begin blue_vect_in = 8'b00010000; red_vect_in = 8'b00100000; end
                                2'd3: begin blue_vect_in = 8'b01000000; red_vect_in = 8'b10000000; end
                              endcase
                      3'd4: case(posElevator)
                              2'd0: begin red_vect_in = 8'b00000011; end 
                              2'd1: begin  red_vect_in = 8'b00001100; end
                              2'd2: begin  red_vect_in = 8'b00110000; end
                              2'd3: begin  red_vect_in = 8'b11000000; end
                            endcase
                    endcase
                3'd2: begin
                        if (waitFloor0 < 4'd1) fs0 = 2'b00;
                        else if (waitFloor0 ==  4'd1) fs0 = 2'b10;
                        else if (waitFloor0 > 4'd1) fs0 = 2'b11;
                        if (waitFloor1 < 4'd1) fs1 = 2'b00;
                        else if (waitFloor1 ==  4'd1) fs1 = 2'b10;
                        else if (waitFloor1 > 4'd1) fs1 = 2'b11;
                        if (waitFloor2 < 4'd1) fs2 = 2'b00;
                        else if (waitFloor2 ==  4'd1) fs2 = 2'b10;
                        else if (waitFloor2 > 4'd1) fs2 = 2'b11;
                        if (waitFloor3 < 4'd1) fs3 = 2'b00;
                        else if (waitFloor3 ==  4'd1) fs3 = 2'b10;
                        else if (waitFloor3 > 4'd1) fs3 = 2'b11;
                      end
                3'd3: begin
                      if (waitFloor0 < 4'd3) fs0 = 2'b00;
                      else if (waitFloor0 ==  4'd3) fs0 = 2'b10;
                      else if (waitFloor0 > 4'd3) fs0 = 2'b11;
                      if (waitFloor1 < 4'd3) fs1 = 2'b00;
                      else if (waitFloor1 ==  4'd3) fs1 = 2'b10;
                      else if (waitFloor1 > 4'd3) fs1 = 2'b11;
                      if (waitFloor2 < 4'd3) fs2 = 2'b00;
                      else if (waitFloor2 ==  4'd3) fs2 = 2'b10;
                      else if (waitFloor2 > 4'd3) fs2 = 2'b11;
                      if (waitFloor3 < 4'd3) fs3 = 2'b00;
                      else if (waitFloor3 ==  4'd3) fs3 = 2'b10;
                      else if (waitFloor3 > 4'd3) fs3 = 2'b11;
                    end
                3'd4: begin
                    if (waitFloor0 < 4'd5) fs0 = 2'b00;
                    else if (waitFloor0 ==  4'd5) fs0 = 2'b10;
                    else if (waitFloor0 > 4'd5) fs0 = 2'b11;
                    if (waitFloor1 < 4'd5) fs1 = 2'b00;
                    else if (waitFloor1 ==  4'd5) fs1 = 2'b10;
                    else if (waitFloor1 > 4'd5) fs1 = 2'b11;
                    if (waitFloor2 < 4'd5) fs2 = 2'b00;
                    else if (waitFloor2 ==  4'd5) fs2 = 2'b10;
                    else if (waitFloor2 > 4'd5) fs2 = 2'b11;
                    if (waitFloor3 < 4'd5) fs3 = 2'b00;
                    else if (waitFloor3 ==  4'd5) fs3 = 2'b10;
                    else if (waitFloor3 > 4'd5) fs3 = 2'b11;
                  end
                3'd5: begin
                      if (waitFloor0 < 4'd7) fs0 = 2'b00;
                      else if (waitFloor0 ==  4'd7) fs0 = 2'b10;
                      else if (waitFloor0 > 4'd7) fs0 = 2'b11;
                      if (waitFloor1 < 4'd7) fs1 = 2'b00;
                      else if (waitFloor1 ==  4'd7) fs1 = 2'b10;
                      else if (waitFloor1 > 4'd7) fs1 = 2'b11;
                      if (waitFloor2 < 4'd7) fs2 = 2'b00;
                      else if (waitFloor2 ==  4'd7) fs2 = 2'b10;
                      else if (waitFloor2 > 4'd7) fs2 = 2'b11;
                      if (waitFloor3 < 4'd7) fs3 = 2'b00;
                      else if (waitFloor3 ==  4'd7) fs3 = 2'b10;
                      else if (waitFloor3 > 4'd7) fs3 = 2'b11;
                end
                3'd6: begin
                        if (waitFloor0 < 4'd9) fs0 = 2'b00;
                        else if (waitFloor0 ==  4'd9) fs0 = 2'b10;
                        else if (waitFloor0 > 4'd9) fs0 = 2'b11;
                        if (waitFloor1 < 4'd9) fs1 = 2'b00;
                        else if (waitFloor1 ==  4'd9) fs1 = 2'b10;
                        else if (waitFloor1 > 4'd9) fs1 = 2'b11;
                        if (waitFloor2 < 4'd9) fs2 = 2'b00;
                        else if (waitFloor2 ==  4'd9) fs2 = 2'b10;
                        else if (waitFloor2 > 4'd9) fs2 = 2'b11;
                        if (waitFloor3 < 4'd9) fs3 = 2'b00;
                        else if (waitFloor3 ==  4'd9) fs3 = 2'b10;
                        else if (waitFloor3 > 4'd9) fs3 = 2'b11;
                      end
                3'd7: begin
                      if (waitFloor0 < 4'd11) fs0 = 2'b00;
                      else if (waitFloor0 ==  4'd11) fs0 = 2'b10;
                      else if (waitFloor0 > 4'd11) fs0 = 2'b11;
                      if (waitFloor1 < 4'd11) fs1 = 2'b00;
                      else if (waitFloor1 ==  4'd11) fs1 = 2'b10;
                      else if (waitFloor1 > 4'd11) fs1 = 2'b11;
                      if (waitFloor2 < 4'd11) fs2 = 2'b00;
                      else if (waitFloor2 ==  4'd11) fs2 = 2'b10;
                      else if (waitFloor2 > 4'd11) fs2 = 2'b11;
                      if (waitFloor3 < 4'd11) fs3 = 2'b00;
                      else if (waitFloor3 ==  4'd11) fs3 = 2'b10;
                      else if (waitFloor3 > 4'd11) fs3 = 2'b11;
                    end
                
            endcase
            if (col_num > 3'd1) 
            begin 
                red_vect_in[0] = fs0[0];
                red_vect_in[1] = fs0[1];
                red_vect_in[2] = fs1[0];
                red_vect_in[3] = fs1[1];
                red_vect_in[4] = fs2[0];
                red_vect_in[5] = fs2[1];
                red_vect_in[6] = fs3[0];
                red_vect_in[7] = fs3[1];
                blue_vect_in = 8'b00000000;
            end               
        end
     
     display_8x8 myDisp(clk, red_vect_in, green_vect_in, blue_vect_in, col_data_capture, // a single pulse, showing the moment of capturing the data (Frequency is about 480 columns per second, or 60 full images per second ).
         col_num,    // showing the current column to be captured next, rotating from 0 to 7.
         // just connect below ports to FPGA pins.    
         reset_out,  //shift register's reset
         OE, //output enable, active low
         SH_CP, //shift register's clock pulse
         ST_CP, //store register's clock pulse
         DS, //shift register's serial input data
         col_select);
         
         
         
         logic [3:0]key_value;
         logic key_valid;
         
         keypad4X4 mykey4(clk, keyb_row, keyb_col, key_value, key_valid);
         
        always_ff@(posedge clk)
            begin
                buttons0 <= 2'b00;
                buttons1 <= 2'b00;
                buttons2 <= 2'b00;
                buttons3 <= 2'b00;
                if (key_valid == 1'b1)
                    begin
                        if (key_value == 4'b01_01) buttons1[0] <= 1'b1;
                        else if (key_value == 4'b01_00) buttons1[1] <= 1'b1;
                        else if (key_value == 4'b10_01) buttons2[0] <= 1'b1;
                        else if (key_value == 4'b10_00) buttons2[1] <= 1'b1;
                        else if (key_value == 4'b11_01) buttons3[0] <= 1'b1;
                        else if (key_value == 4'b11_00) buttons3[1] <= 1'b1;
                    end
            end
endmodule
