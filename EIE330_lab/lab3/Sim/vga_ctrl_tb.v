`timescale 1ns/1ns
module vga_ctrl_tb();

reg vga_clk;
reg sys_rst_n;
reg [15:0] pix_data;
wire [9:0] pix_x;
wire [9:0] pix_y;
wire hsync;
wire vsync;
wire [15:0] rgb;

initial begin
    $dumpfile("vga_ctrl_tb.vcd");
    $dumpvars(0,vga_ctrl_tb);
    vga_clk=1'b1;
    sys_rst_n<=1'b0;
    pix_data<=16'hffff;
    #40
    sys_rst_n<=1'b1;
    #17000000
    $finish;
end

always #20 vga_clk=~vga_clk;

vga_ctrl vga_ctrl_inst(
    .vga_clk(vga_clk),
    .sys_rst_n(sys_rst_n),
    .pix_data(pix_data),
    .pix_x(pix_x),
    .pix_y(pix_y),
    .hsync(hsync),
    .vsync(vsync),
    .rgb(rgb)
);

endmodule

