`timescale 1ns / 1ns

module tb_counter;

reg sys_clk;
reg sys_rst_n;
wire led_out;

counter dut(
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .led_out(led_out)
);

always #10 sys_clk=~sys_clk;

initial begin
    $dumpfile("counter.vcd");
    $dumpvars(0,tb_counter);
    
    sys_clk=1'b0;
    sys_rst_n=1'b0;
    
    #20 sys_rst_n=1'b1;
    
    #3000 sys_rst_n=1'b0;
    #20  sys_rst_n=1'b1;
    #3000 $finish;
end

endmodule
