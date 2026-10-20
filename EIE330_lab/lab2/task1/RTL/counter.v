`timescale 1ns / 1ns

module counter(
    input wire sys_clk,
    input wire sys_rst_n,
    output reg led_out
);

reg [24:0] cnt= 25'd0;



always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        cnt<=25'd0;
        led_out<=1'b0;
    end
    else if(cnt==25'd24999999) begin
        cnt<=25'd0;
        led_out<=~led_out;
    end
    else begin
        cnt<=cnt+1'b1;
    end
end

endmodule
