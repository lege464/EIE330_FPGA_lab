`timescale 1ns/1ns
module pll_tb();

reg sys_clk;
reg sys_rst_n;
wire vga_clk;

initial begin
    $dumpfile("pll_tb.vcd");
    $dumpvars(0,pll_tb);
    sys_clk=1'b1;
    sys_rst_n<=1'b0;
    #20
    sys_rst_n<=1'b1;
    #200
    $finish;
end

always #10 sys_clk=~sys_clk;

pll pll_inst(
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .vga_clk(vga_clk)
);

endmodule

