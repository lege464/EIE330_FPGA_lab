`timescale 1ns / 1ns
module full_adder (
    input wire a,
    input wire b, 
    input wire cin,
    output wire s, 
    output wire cout 
);

wire A= ~a;
wire B= ~b;
wire Cin= ~cin;

wire sum;
wire Cout;
assign {Cout, sum}= A+B+Cin;

assign s= ~sum;
assign cout= ~Cout;
endmodule
 







 















































