`timescale 1 ps / 1 ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Hamzeh Ahangari
// 
// Create Date: 
// Design Name: 
// Module Name: 
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

// This module shows 4 decimal numbers on 4-digit 7-Segment.  
// 4 digits are scanned with high speed, then you do not notice that every time 
// only one of them is ON. dp is always off.

// LED positions inside 7-segment
//    A 
//  F   B
//    G
//  E   C
//    D      DP

// digit positions on Basys3 :
// in3(left), in2, in1, in0(right)

(* keep_hierarchy = "yes" *) 
module SevSeg_4digit(
 input clk,
 input [3:0] in0, in1, in2, in3, //user inputs for each digit (hexadecimal value)
 output logic a, b, c, d, e, f, g, dp, // just connect them to FPGA pins (individual LEDs).
 output [3:0] an   // just connect them to FPGA pins (enable vector for 4 digits, active low)
 );
 
// divide system clock (100Mhz for Basys3) by 2^N using a counter, which allows us to multiplex at lower speed
localparam N = 18;
logic [N-1:0] count = {N{1'b0}}; //initial value
always@ (posedge clk)
	count <= count + 1;

 
logic [3:0]digit_val; // multiplexer of digits
logic [3:0]digit_en;  // decoder of enable bits
 
always_comb
 begin
 digit_en = 4'b1111; 
 digit_val = in0; 
 
  case(count[N-1:N-2]) //using only the 2 MSB's of the counter 
    
   2'b00 :  //select first 7Seg.
    begin
     digit_val = in0;
     digit_en = 4'b1110;
    end
    
   2'b01:  //select second 7Seg.
    begin
     digit_val = in1;
     digit_en = 4'b1101;
    end
    
   2'b10:  //select third 7Seg.
    begin
     digit_val = in2;
     digit_en = 4'b1011;
    end
     
   2'b11:  //select forth 7Seg.
    begin
     digit_val = in3;
     digit_en = 4'b0111;
    end
  endcase
 end
 

//Convert digit value to LED vector. LEDs are active low.
logic [6:0] sseg_LEDs;
logic [6:0] ssR; 

logic [27:0] ctrr = 28'd0;
//logic en1;
logic [6:0] prevr;
always_ff@(posedge clk)
    begin
             prevr <= ssR;
             sseg_LEDs = 7'b1111111; //default
             
            if (ctrr < 27'd25000000) begin ctrr <= ctrr + 1; end
            else begin
                    if (in3 == 4'b0000) begin ssR <= 7'b1111110; prevr <= 7'b1111110;  ctrr <= 0; end
                    else if (in3 == 4'b0010) 
                    begin
                         if (prevr == 7'b1111110) ssR <= 7'b1111101;
                         else if (prevr == 7'b1111101) ssR <= 7'b1111011;
                         else if (prevr == 7'b1111011) ssR <= 7'b1110111;
                         else if (prevr == 7'b1110111) ssR <= 7'b1101111;
                         else if (prevr == 7'b1101111) ssR <= 7'b1011111;
                         else if (prevr == 7'b1011111) ssR <= 7'b1111110;
                         ctrr <= 0;
                    end
                    else if (in3 == 4'b0001)
                        begin
                            if (prevr == 7'b1111110) ssR <= 7'b1011111;
                            else if (prevr == 7'b1011111) ssR <= 7'b1101111;
                            else if (prevr == 7'b1101111) ssR <= 7'b1110111;
                            else if (prevr == 7'b1110111) ssR <= 7'b1111011;
                            else if (prevr == 7'b1111011) ssR <= 7'b1111101;
                            else if (prevr == 7'b1111101) ssR <= 7'b1111110;
                            ctrr <= 0;
                        end
                    
                 end
            
  
           if (digit_en != 4'b0111)
            case(digit_val)
                 4'd0 : sseg_LEDs <= 7'b1000000;    
                 4'd2 : sseg_LEDs <= 7'b0100100;
                 4'd1 : sseg_LEDs <= 7'b1111001;
                 4'd3 : sseg_LEDs <= 7'b0110000;
                 4'd4 : sseg_LEDs <= 7'b0011001;
                 4'd5 : sseg_LEDs <= 7'b0010010;
                 4'd6 : sseg_LEDs <= 7'b0000010;
                 4'd7 : sseg_LEDs <= 7'b1111000;
                 4'd8 : sseg_LEDs <= 7'b0000000;
                 4'd9 : sseg_LEDs <= 7'b0010000;
                
                 default : sseg_LEDs <= 7'b0111111; //dash
                endcase
                
                
             
    end


assign an = digit_en; 

always_comb
    begin
        if (digit_en != 4'b0111) {g, f, e, d, c, b, a} = sseg_LEDs; 
        else {g, f, e, d, c, b, a} = ssR; 
    end
     
assign dp = 1'b1; //turn dp off
 
 
endmodule