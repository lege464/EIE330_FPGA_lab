`timescale 1ns / 1ns
module tb_full_adder;


reg a;
reg b;
reg cin;
wire s;
wire cout;


wire A= ~a;
wire B= ~b;
wire Cin= ~cin;
wire S= ~s;       
wire Cout= ~cout; 


full_adder dut (
    .a(a),
    .b(b),
    .cin(cin),
    .s(s),
    .cout(cout)
);


initial begin
    $dumpfile("full_adder.vcd"); 
    $dumpvars(0, tb_full_adder);

    {a, b, cin}= 3'b111; #10;
    {a, b, cin}= 3'b110; #10;
    {a, b, cin}= 3'b101; #10;
    {a, b, cin}= 3'b100; #10;
    {a, b, cin}= 3'b011; #10;
    {a, b, cin}= 3'b010; #10;
    {a, b, cin}= 3'b001; #10;
    {a, b, cin}= 3'b000; #10;

    
    $finish;
end
endmodule