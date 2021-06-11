`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2021 08:29:47 PM
// Design Name: 
// Module Name: simple_calc
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


module simple_calc(
    input [3:0]x, [3:0]y, [1:0]op_sel,
    output [7:0]result, 
    output carry_out, 
    output overflow
    );
    wire [3:0]sum;
    wire [7:0]prod;
    
    adder_subtractor AS0(
        .x(x), 
        .y(y), 
        .add_n(op_sel[0]), 
        .s(sum) , 
        .c_out(carry_out), 
        .overflow(overflow)
    );
    csa_multiplier MU0(
        .m(x), 
        .q(y), 
        .p(prod)
    );
    mux_2x1_8bit MUX0(
        .a({4'b0000, sum}), 
        .b(prod), 
        .s(op_sel[1]), 
        .c(-result)
    );
        
endmodule
