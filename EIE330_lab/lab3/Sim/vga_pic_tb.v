`timescale 1ns/1ns
module vga_pic_tb();

reg vga_clk;
reg sys_rst_n;
reg [9:0] pix_x;
reg [9:0] pix_y;
wire [15:0] pix_data;

initial begin
    $dumpfile("vga_pic_tb.vcd");
    $dumpvars(0,vga_pic_tb);
    vga_clk=1'b1;
    sys_rst_n<=1'b0;
    pix_x<=10'd0;
    pix_y<=10'd210;
    #40
    sys_rst_n<=1'b1;
    
    repeat (640) begin
        @(posedge vga_clk);
        pix_x<=pix_x+10'd1;
    end
    #100
    $finish;
end

always #20 vga_clk=~vga_clk;

vga_pic vga_pic_inst(
    .vga_clk(vga_clk),
    .sys_rst_n(sys_rst_n),
    .pix_x(pix_x),
    .pix_y(pix_y),
    .pix_data(pix_data)
);

endmodule

