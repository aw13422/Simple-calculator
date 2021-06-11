`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/09/2021 09:57:01 PM
// Design Name: 
// Module Name: csa_multiplier
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


module csa_multiplier(
    input [3:0]m, [3:0]q,
    output [7:0]p
    );
    wire [3:0]mq0;
    wire [3:0]mq1;
    wire [3:0]mq2;
    wire [3:0]mq3;
    wire [10:0]c;
    wire [5:0]s;
    
    mq_4bit MQ0(.m(m), .q(q[0]), .mq(mq0));
    mq_4bit MQ1(.m(m), .q(q[1]), .mq(mq1));
    mq_4bit MQ2(.m(m), .q(q[2]), .mq(mq2));
    mq_4bit MQ3(.m(m), .q(q[3]), .mq(mq3));
    
    //row 1
    assign p[0] = mq0[0];
    full_adder FA0(.x(mq0[1]), .y(mq1[0]), .c_in(0)     , .s(p[1]), .c_out(c[0]));
    full_adder FA1(.x(mq0[2]), .y(mq1[1]), .c_in(mq2[0]), .s(s[0]), .c_out(c[1]));
    full_adder FA2(.x(mq0[3]), .y(mq1[2]), .c_in(mq2[1]), .s(s[1]), .c_out(c[2]));
    full_adder FA3(.x(0)     , .y(mq1[3]), .c_in(mq2[2]), .s(s[2]), .c_out(c[3]));
    
    //row 2
    full_adder FA4(.x(s[0])  , .y(0)     , .c_in(c[0]), .s(p[2]), .c_out(c[4]));
    full_adder FA5(.x(s[1])  , .y(mq3[0]), .c_in(c[1]), .s(s[3]), .c_out(c[5]));
    full_adder FA6(.x(s[2])  , .y(mq3[1]), .c_in(c[2]), .s(s[4]), .c_out(c[6]));
    full_adder FA7(.x(mq2[3]), .y(mq3[2]), .c_in(c[3]), .s(s[5]), .c_out(c[7]));
    
    //row 3
    full_adder FA8 (.x(s[3])  , .y(c[4]), .c_in(0)    , .s(p[3]), .c_out(c[8]));
    full_adder FA9 (.x(s[4])  , .y(c[5]), .c_in(c[8]) , .s(p[4]), .c_out(c[9]));
    full_adder FA10(.x(s[5])  , .y(c[6]), .c_in(c[9]) , .s(p[5]), .c_out(c[10]));
    full_adder FA11(.x(mq3[3]), .y(c[7]), .c_in(c[10]), .s(p[6]), .c_out(p[7]));
    
endmodule
