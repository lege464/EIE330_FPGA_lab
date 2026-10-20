`timescale 1ns/1ns
module running_light(
    input wire sys_clk,
    input wire sys_rst_n,
    output wire led0,
    output wire led1,
    output wire led2,
    output wire led3
);

    reg [24:0] cnt;
    localparam HALF_SEC=25'd24999999;
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n)
            cnt<=25'd0;
        else if(cnt==HALF_SEC)
            cnt<=25'd0;
        else
            cnt<=cnt+1'b1;
    end

    reg [3:0] led_on=4'b0001;
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n)
            led_on<=4'b0001;
        else if(cnt==HALF_SEC) begin
            if(led_on==4'b1000)
                led_on<=4'b0001;
            else
                led_on<=led_on<<1;
        end
    end

    assign led0=~led_on[0];
    assign led1=~led_on[1];
    assign led2=~led_on[2];
    assign led3=~led_on[3];

endmodule