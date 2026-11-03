`timescale 1ns/1ns
module vga_colorbar_tb();

reg sys_clk;
reg sys_rst_n;
wire hsync;
wire vsync;
wire [15:0] rgb;

initial begin
    $dumpfile("vga_colorbar_tb.vcd");
    $dumpvars(0,vga_colorbar_tb);
    sys_clk=1'b1;
    sys_rst_n<=1'b0;
    #40
    sys_rst_n<=1'b1;
    // 记录前2行同步波形后暂停，待扫描到字符所在行(cnt_v=243)再开启记录
    #64000
    $dumpoff;
    #7712000
    $dumpon;
    #128000
    $dumpoff;
    #9000000
    $finish;
end

always #10 sys_clk=~sys_clk;

vga_colorbar vga_colorbar_inst(
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .hsync(hsync),
    .vsync(vsync),
    .rgb(rgb)
);

endmodule

