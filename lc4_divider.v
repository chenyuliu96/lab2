/* TODO: liucy  */

`timescale 1ns / 1ps
`default_nettype none

module lc4_divider(input  wire [15:0] i_dividend,
                   input  wire [15:0] i_divisor,
                   output wire wire [15:0] o_remainder,
                   output wire wire [15:0] o_quotient);

      /*** YOUR CODE HERE ***/

endmodule // lc4_divider

module lc4_divider_one_iter(input  wire [15:0] i_dividend,
                            input  wire [15:0] i_divisor,
                            input  wire [15:0] i_remainder,
                            input  wire [15:0] i_quotient,
                            output wire wire [15:0] o_dividend,
                            output wire wire [15:0] o_remainder,
                            output wire wire [15:0] o_quotient);

                            wire remainder_tmp, dividend_tmp, Alarger,Blarger,Equal
                            ,q_temp;

                            assign dividend_tmp = (i_dividend >> 15) & 1;
                            $display("testeestestsetset")
                            assign remainder_tmp = (i_remainder << 1) | dividend_tmp;
                            Compare16 cp(remainder_tmp, i_divisor, Alarger, Blarger, Equal);
                            assign q_temp = 1 & ~Blarger;
                            assign o_quotient = q_temp | (i_quotient<<1);
                            assign o_remainder = remainder_tmp - (i_divisor & Blarger);
                            assign o_dividend = i_dividend << 1;



endmodule

module Compare1 (input wire A,input wire B,output wire Equal,output wire Alarger,output wire Blarger);
  assign Equal = (A & B) | (~A & ~B);
  assign Alarger = (A & ~B);
  assign Blarger = (~A & B);
endmodule

module Compare4(input wire [3:0] A4, input wire [3:0] B4, output wire Equal, output wire Alarger,output wire Blarger);

  wire e0, e1, e2, e3, Al0, Al1, Al2, Al3, Bl0, Bl1, Bl2, Bl3;
  Compare1 cp0(A4[0], B4[0], e0, Al0, Bl0);
  Compare1 cp1(A4[1], B4[1], e1, Al1, Bl1);
  Compare1 cp2(A4[2], B4[2], e2, Al2, Bl2);
  Compare1 cp3(A4[3], B4[3], e3, Al3, Bl3);
  assign Equal = (e0 & e1 & e2 & e3);
  assign Alarger = (Al3 | (Al2 & e3) |(Al1 & e3 & e2) |
(Al0 & e3 & e2 & e1));
  assign Blarger = (~Alarger & ~Equal);
endmodule

module Compare16(input wire [15:0] A16,input wire [15:0] B16,output wire Equal,output wire Alarger,output wire Blarger);
 wire e0, e1, e2, e3, Al0, Al1, Al2, Al3, Bl0, Bl1, Bl2, Bl3;
 Compare4 cp0(A16[3:0], B16[3:0], e0, Al0, Bl0);
 Compare4 cp1(A16[7:4], B16[7:4], e1, Al1, Bl1);
 Compare4 cp2(A16[11:8], B16[11:8], e2, Al2, Bl2);
 Compare4 cp3(A16[15:12], B16[15:12], e3, Al3, Bl3);
 assign Equal = (e0 & e1 & e2 & e3);
 assign Alarger = (Al3 | (Al2 & e3) |
 (Al1 & e3 & e2) |
(Al0 & e3 & e2 & e1));
 assign Blarger = (~Alarger & ~Equal);
endmodule
