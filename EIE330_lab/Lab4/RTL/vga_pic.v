`timescale 1ns/1ns
module vga_pic(
    input wire vga_clk,
    input wire sys_rst_n,
    input wire [9:0] pix_x,
    input wire [9:0] pix_y,
    input wire [1:0] state,
    output reg [15:0] pix_data
);

parameter H_VALID=10'd640;

parameter RED=16'hF800;
parameter ORANGE=16'hFC00;
parameter YELLOW=16'hFFE0;
parameter GREEN=16'h07E0;
parameter CYAN=16'h07FF;
parameter BLUE=16'h001F;
parameter PURPLE=16'hF81F;
parameter BLACK=16'h0000;
parameter WHITE=16'hFFFF;
parameter GRAY=16'hD69A;

parameter S_BAR=2'd0;
parameter S_MUST=2'd1;
parameter S_END=2'd2;

parameter [7:0] M_ROW_0=8'b1100_0011;
parameter [7:0] M_ROW_1=8'b1110_0111;
parameter [7:0] M_ROW_2=8'b1111_1111;
parameter [7:0] M_ROW_3=8'b1101_1011;
parameter [7:0] M_ROW_4=8'b1100_0011;
parameter [7:0] M_ROW_5=8'b1100_0011;
parameter [7:0] M_ROW_6=8'b1100_0011;
parameter [7:0] M_ROW_7=8'b1100_0011;

parameter [7:0] U_ROW_0=8'b1100_0011;
parameter [7:0] U_ROW_1=8'b1100_0011;
parameter [7:0] U_ROW_2=8'b1100_0011;
parameter [7:0] U_ROW_3=8'b1100_0011;
parameter [7:0] U_ROW_4=8'b1100_0011;
parameter [7:0] U_ROW_5=8'b1100_0011;
parameter [7:0] U_ROW_6=8'b1111_1111;
parameter [7:0] U_ROW_7=8'b0111_1110;

parameter [7:0] S_ROW_0=8'b0111_1110;
parameter [7:0] S_ROW_1=8'b1100_0011;
parameter [7:0] S_ROW_2=8'b1100_0000;
parameter [7:0] S_ROW_3=8'b0111_1100;
parameter [7:0] S_ROW_4=8'b0000_1110;
parameter [7:0] S_ROW_5=8'b0000_0011;
parameter [7:0] S_ROW_6=8'b1100_0011;
parameter [7:0] S_ROW_7=8'b0111_1110;

parameter [7:0] T_ROW_0=8'b1111_1111;
parameter [7:0] T_ROW_1=8'b1111_1111;
parameter [7:0] T_ROW_2=8'b0001_1000;
parameter [7:0] T_ROW_3=8'b0001_1000;
parameter [7:0] T_ROW_4=8'b0001_1000;
parameter [7:0] T_ROW_5=8'b0001_1000;
parameter [7:0] T_ROW_6=8'b0001_1000;
parameter [7:0] T_ROW_7=8'b0001_1000;

parameter [7:0] E_ROW_0=8'b1111_1111;
parameter [7:0] E_ROW_1=8'b1100_0000;
parameter [7:0] E_ROW_2=8'b1100_0000;
parameter [7:0] E_ROW_3=8'b1111_1100;
parameter [7:0] E_ROW_4=8'b1111_1100;
parameter [7:0] E_ROW_5=8'b1100_0000;
parameter [7:0] E_ROW_6=8'b1100_0000;
parameter [7:0] E_ROW_7=8'b1111_1111;

parameter [7:0] N_ROW_0=8'b1100_0011;
parameter [7:0] N_ROW_1=8'b1110_0011;
parameter [7:0] N_ROW_2=8'b1111_0011;
parameter [7:0] N_ROW_3=8'b1101_1011;
parameter [7:0] N_ROW_4=8'b1100_1111;
parameter [7:0] N_ROW_5=8'b1100_0111;
parameter [7:0] N_ROW_6=8'b1100_0011;
parameter [7:0] N_ROW_7=8'b1100_0011;

parameter [7:0] D_ROW_0=8'b1111_1100;
parameter [7:0] D_ROW_1=8'b1100_0110;
parameter [7:0] D_ROW_2=8'b1100_0011;
parameter [7:0] D_ROW_3=8'b1100_0011;
parameter [7:0] D_ROW_4=8'b1100_0011;
parameter [7:0] D_ROW_5=8'b1100_0011;
parameter [7:0] D_ROW_6=8'b1100_0110;
parameter [7:0] D_ROW_7=8'b1111_1100;

wire in_y;
wire in_m_box;
wire in_u_box;
wire in_s_box;
wire in_t_box;
wire in_e_box;
wire in_n_box;
wire in_d_box;

wire [2:0] char_y;
wire [2:0] m_x;
wire [2:0] u_x;
wire [2:0] s_x;
wire [2:0] t_x;
wire [2:0] e_x;
wire [2:0] n_x;
wire [2:0] d_x;

assign in_y=(pix_y>=10'd208)&&(pix_y<10'd272);
assign in_m_box=in_y&&(pix_x>=10'd144)&&(pix_x<10'd208);
assign in_u_box=in_y&&(pix_x>=10'd240)&&(pix_x<10'd304);
assign in_s_box=in_y&&(pix_x>=10'd336)&&(pix_x<10'd400);
assign in_t_box=in_y&&(pix_x>=10'd432)&&(pix_x<10'd496);

assign in_e_box=in_y&&(pix_x>=10'd192)&&(pix_x<10'd256);
assign in_n_box=in_y&&(pix_x>=10'd288)&&(pix_x<10'd352);
assign in_d_box=in_y&&(pix_x>=10'd384)&&(pix_x<10'd448);


assign char_y=(pix_y-10'd208)>>3;
assign m_x=(pix_x-10'd144)>>3;
assign u_x=(pix_x-10'd240)>>3;
assign s_x=(pix_x-10'd336)>>3;
assign t_x=(pix_x-10'd432)>>3;
assign e_x=(pix_x-10'd192)>>3;
assign n_x=(pix_x-10'd288)>>3;
assign d_x=(pix_x-10'd384)>>3;

always @(posedge vga_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        pix_data<=BLACK;
    else if (state==S_BAR) begin
        if (pix_x>=10'd0&&pix_x<H_VALID/10*1)
            pix_data<=RED;
        else if (pix_x>=H_VALID/10*1&&pix_x<H_VALID/10*2)
            pix_data<=ORANGE;
        else if (pix_x>=H_VALID/10*2&&pix_x<H_VALID/10*3)
            pix_data<=YELLOW;
        else if (pix_x>=H_VALID/10*3&&pix_x<H_VALID/10*4)
            pix_data<=GREEN;
        else if (pix_x>=H_VALID/10*4&&pix_x<H_VALID/10*5)
            pix_data<=CYAN;
        else if (pix_x>=H_VALID/10*5&&pix_x<H_VALID/10*6)
            pix_data<=BLUE;
        else if (pix_x>=H_VALID/10*6&&pix_x<H_VALID/10*7)
            pix_data<=PURPLE;
        else if (pix_x>=H_VALID/10*7&&pix_x<H_VALID/10*8)
            pix_data<=BLACK;
        else if (pix_x>=H_VALID/10*8&&pix_x<H_VALID/10*9)
            pix_data<=WHITE;
        else if (pix_x>=H_VALID/10*9&&pix_x<H_VALID)
            pix_data<=GRAY;
        else
            pix_data<=BLACK;
    end
    else if (state==S_MUST) begin
      
        if (in_m_box) begin
            case (char_y)
                3'd0: pix_data<=M_ROW_0[3'd7-m_x]?RED:BLACK;
                3'd1: pix_data<=M_ROW_1[3'd7-m_x]?RED:BLACK;
                3'd2: pix_data<=M_ROW_2[3'd7-m_x]?RED:BLACK;
                3'd3: pix_data<=M_ROW_3[3'd7-m_x]?RED:BLACK;
                3'd4: pix_data<=M_ROW_4[3'd7-m_x]?RED:BLACK;
                3'd5: pix_data<=M_ROW_5[3'd7-m_x]?RED:BLACK;
                3'd6: pix_data<=M_ROW_6[3'd7-m_x]?RED:BLACK;
                3'd7: pix_data<=M_ROW_7[3'd7-m_x]?RED:BLACK;
                default: pix_data<=BLACK;
            endcase
        end
        else if (in_u_box) begin
            case (char_y)
                3'd0: pix_data<=U_ROW_0[3'd7-u_x]?YELLOW:BLACK;
                3'd1: pix_data<=U_ROW_1[3'd7-u_x]?YELLOW:BLACK;
                3'd2: pix_data<=U_ROW_2[3'd7-u_x]?YELLOW:BLACK;
                3'd3: pix_data<=U_ROW_3[3'd7-u_x]?YELLOW:BLACK;
                3'd4: pix_data<=U_ROW_4[3'd7-u_x]?YELLOW:BLACK;
                3'd5: pix_data<=U_ROW_5[3'd7-u_x]?YELLOW:BLACK;
                3'd6: pix_data<=U_ROW_6[3'd7-u_x]?YELLOW:BLACK;
                3'd7: pix_data<=U_ROW_7[3'd7-u_x]?YELLOW:BLACK;
                default: pix_data<=BLACK;
            endcase
        end
        else if (in_s_box) begin
            case (char_y)
                3'd0: pix_data<=S_ROW_0[3'd7-s_x]?GREEN:BLACK;
                3'd1: pix_data<=S_ROW_1[3'd7-s_x]?GREEN:BLACK;
                3'd2: pix_data<=S_ROW_2[3'd7-s_x]?GREEN:BLACK;
                3'd3: pix_data<=S_ROW_3[3'd7-s_x]?GREEN:BLACK;
                3'd4: pix_data<=S_ROW_4[3'd7-s_x]?GREEN:BLACK;
                3'd5: pix_data<=S_ROW_5[3'd7-s_x]?GREEN:BLACK;
                3'd6: pix_data<=S_ROW_6[3'd7-s_x]?GREEN:BLACK;
                3'd7: pix_data<=S_ROW_7[3'd7-s_x]?GREEN:BLACK;
                default: pix_data<=BLACK;
            endcase
        end
        else if (in_t_box) begin
            case (char_y)
                3'd0: pix_data<=T_ROW_0[3'd7-t_x]?CYAN:BLACK;
                3'd1: pix_data<=T_ROW_1[3'd7-t_x]?CYAN:BLACK;
                3'd2: pix_data<=T_ROW_2[3'd7-t_x]?CYAN:BLACK;
                3'd3: pix_data<=T_ROW_3[3'd7-t_x]?CYAN:BLACK;
                3'd4: pix_data<=T_ROW_4[3'd7-t_x]?CYAN:BLACK;
                3'd5: pix_data<=T_ROW_5[3'd7-t_x]?CYAN:BLACK;
                3'd6: pix_data<=T_ROW_6[3'd7-t_x]?CYAN:BLACK;
                3'd7: pix_data<=T_ROW_7[3'd7-t_x]?CYAN:BLACK;
                default: pix_data<=BLACK;
            endcase
        end
        else
            pix_data<=BLACK;
    end
    else if (state==S_END) begin
      
        if (in_e_box) begin
            case (char_y)
                3'd0: pix_data<=E_ROW_0[3'd7-e_x]?WHITE:BLACK;
                3'd1: pix_data<=E_ROW_1[3'd7-e_x]?WHITE:BLACK;
                3'd2: pix_data<=E_ROW_2[3'd7-e_x]?WHITE:BLACK;
                3'd3: pix_data<=E_ROW_3[3'd7-e_x]?WHITE:BLACK;
                3'd4: pix_data<=E_ROW_4[3'd7-e_x]?WHITE:BLACK;
                3'd5: pix_data<=E_ROW_5[3'd7-e_x]?WHITE:BLACK;
                3'd6: pix_data<=E_ROW_6[3'd7-e_x]?WHITE:BLACK;
                3'd7: pix_data<=E_ROW_7[3'd7-e_x]?WHITE:BLACK;
                default: pix_data<=BLACK;
            endcase
        end
        else if (in_n_box) begin
            case (char_y)
                3'd0: pix_data<=N_ROW_0[3'd7-n_x]?WHITE:BLACK;
                3'd1: pix_data<=N_ROW_1[3'd7-n_x]?WHITE:BLACK;
                3'd2: pix_data<=N_ROW_2[3'd7-n_x]?WHITE:BLACK;
                3'd3: pix_data<=N_ROW_3[3'd7-n_x]?WHITE:BLACK;
                3'd4: pix_data<=N_ROW_4[3'd7-n_x]?WHITE:BLACK;
                3'd5: pix_data<=N_ROW_5[3'd7-n_x]?WHITE:BLACK;
                3'd6: pix_data<=N_ROW_6[3'd7-n_x]?WHITE:BLACK;
                3'd7: pix_data<=N_ROW_7[3'd7-n_x]?WHITE:BLACK;
                default: pix_data<=BLACK;
            endcase
        end
        else if (in_d_box) begin
            case (char_y)
                3'd0: pix_data<=D_ROW_0[3'd7-d_x]?WHITE:BLACK;
                3'd1: pix_data<=D_ROW_1[3'd7-d_x]?WHITE:BLACK;
                3'd2: pix_data<=D_ROW_2[3'd7-d_x]?WHITE:BLACK;
                3'd3: pix_data<=D_ROW_3[3'd7-d_x]?WHITE:BLACK;
                3'd4: pix_data<=D_ROW_4[3'd7-d_x]?WHITE:BLACK;
                3'd5: pix_data<=D_ROW_5[3'd7-d_x]?WHITE:BLACK;
                3'd6: pix_data<=D_ROW_6[3'd7-d_x]?WHITE:BLACK;
                3'd7: pix_data<=D_ROW_7[3'd7-d_x]?WHITE:BLACK;
                default: pix_data<=BLACK;
            endcase
        end
        else
            pix_data<=BLACK;
    end
    else
        pix_data<=BLACK;
end

endmodule
