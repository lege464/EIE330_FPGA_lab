`timescale 1ns/1ns
module key_ctrl_tb();

reg vga_clk;
reg sys_rst_n;
reg key_in;
wire [1:0] state;

initial begin
    $dumpfile("key_ctrl_tb.vcd");
    $dumpvars(0,key_ctrl_tb);
    vga_clk=1'b1;
    sys_rst_n<=1'b0;
    key_in<=1'b1;
    #80
    sys_rst_n<=1'b1;
    #1000

    
    repeat (4) begin
        key_in<=1'b0; #2000;
        key_in<=1'b1; #2000;
    end
    key_in<=1'b0;
   
    #2000;
    $dumpoff;
    #19980000; 
    $dumpon;
    #40000;   
    $dumpoff;

    #1000000;
    key_in<=1'b1;
    #19980000; 
    $dumpon;
    #20000;    
    $dumpoff;

    
    key_in<=1'b0;
    #19980000;
    $dumpon;
    #40000;   
    $dumpoff;
    #20000000; 
    key_in<=1'b1;
    #20000000;

   
    key_in<=1'b0;
    #19980000;
    $dumpon;
    #40000;   
    sys_rst_n<=1'b0;
    #200;
    sys_rst_n<=1'b1;
    #2000;
    $dumpoff;
    key_in<=1'b1;
    #1000;
    $finish;
end

always #20 vga_clk=~vga_clk;

key_ctrl key_ctrl_inst(
    .vga_clk(vga_clk),
    .sys_rst_n(sys_rst_n),
    .key_in(key_in),
    .state(state)
);

endmodule
