`timescale 1ns / 1ps  

module tb_compare();

    
    reg a;
    reg b;
    wire led1;
    wire led2;
    wire led3;

    
    compare dut (
        .a(a),
        .b(b),
        .led1(led1),
        .led2(led2),
        .led3(led3)
    );

    
    initial begin
        $dumpfile("compare.vcd"); 
        $dumpvars(0, tb_compare); 

        
        a = 1'b0; b = 1'b0;
        #10;
        
        
        a = 1'b0; b = 1'b1;
        #10;
        

        
        a = 1'b1; b = 1'b0;
        #10;
       
        
        a = 1'b1; b = 1'b1;
        #10;
        

        
        #10;
        $finish;
    end

endmodule