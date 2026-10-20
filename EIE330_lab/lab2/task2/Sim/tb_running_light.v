`timescale 1ns/1ps
module tb_running_light;
    reg sys_clk;
    reg sys_rst_n;
    wire led0;
    wire led1;
    wire led2;
    wire led3;

    running_light u_running_light(
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .led0(led0),
        .led1(led1),
        .led2(led2),
        .led3(led3)
    );

    initial sys_clk=1'b0;
    always #10 sys_clk=~sys_clk;

    initial begin
        $dumpfile("running_light.vcd");
        $dumpvars(0,tb_running_light);
    end

    initial begin
        sys_rst_n=1'b0;
        #50;
        sys_rst_n=1'b1;
        #2800;
        sys_rst_n=1'b0;
        #30;
        sys_rst_n=1'b1;
        #1300;
        $finish;
    end

endmodule