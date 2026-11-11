`timescale 1ns/1ns
module vga_colorbar_tb();

reg sys_clk;
reg sys_rst_n;
reg key_in;
wire hsync;
wire vsync;
wire [15:0] rgb;

initial begin
    $dumpfile("vga_colorbar_tb.vcd");
    $dumpvars(0,vga_colorbar_tb);
    sys_clk=1'b1;
    sys_rst_n<=1'b0;
    key_in<=1'b1;
    #40
    sys_rst_n<=1'b1;

  
    #64000
    $dumpoff;
    #7712000
    $dumpon;
    #32000
    $dumpoff;

    key_in<=1'b0;
    #19990000
    $dumpon;
    #50000
    $dumpoff;
    key_in<=1'b1;
    #25000000

 
    key_in<=1'b0;
    #19990000
    $dumpon;
    #50000
    sys_rst_n<=1'b0;
    #200
    sys_rst_n<=1'b1;
    key_in<=1'b1;
    #1000
    $finish;
end

always #10 sys_clk=~sys_clk;

vga_colorbar vga_colorbar_inst(
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .key_in(key_in),
    .hsync(hsync),
    .vsync(vsync),
    .rgb(rgb)
);

endmodule
