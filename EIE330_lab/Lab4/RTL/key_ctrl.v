`timescale 1ns/1ns
module key_ctrl(
    input wire vga_clk,
    input wire sys_rst_n,
    input wire key_in,
    output reg [1:0] state
);

parameter CNT_MAX=20'd500000;
parameter S_BAR=2'd0;
parameter S_MUST=2'd1;
parameter S_END=2'd2;

reg [19:0] cnt_press;
reg [19:0] cnt_rel;
reg key_flag;
reg key_prev;
wire key_pulse;


always @(posedge vga_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        cnt_press<=20'd0;
    else if (key_in)
        cnt_press<=20'd0;
    else if (cnt_press==CNT_MAX&&!key_in)
        cnt_press<=cnt_press;
    else
        cnt_press<=cnt_press+1'b1;
end


always @(posedge vga_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        cnt_rel<=20'd0;
    else if (!key_in)
        cnt_rel<=20'd0;
    else if (cnt_rel==CNT_MAX&&key_in)
        cnt_rel<=cnt_rel;
    else
        cnt_rel<=cnt_rel+1'd1;
end

always @(posedge vga_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        key_flag<=1'b1;
    else if (cnt_press>=CNT_MAX-1'd1)
        key_flag<=1'b0;
    else if (cnt_rel>=CNT_MAX-1'd1)
        key_flag<=1'b1;
    else
        key_flag<=key_flag;
end

always @(posedge vga_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        key_prev<=1'b1;
    else
        key_prev<=key_flag;
end


assign key_pulse=(key_prev==1'b1&&key_flag==1'b0);


always @(posedge vga_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        state<=S_BAR;
    else if (key_pulse) begin
        case (state)
            S_BAR: state<=S_MUST;
            S_MUST: state<=S_END;
            S_END: state<=S_BAR;
            default: state<=S_BAR;
        endcase
    end
    else
        state<=state;
end

endmodule
