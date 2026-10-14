`timescale 1ns / 1ns  

module compare(
    input wire a,   
    input wire b,   
    output wire led1,    
    output wire led2,    
    output wire led3     
);

    
    wire A= ~a;
    wire B= ~b;

   
    wire Led1, Led2, Led3;
    
    assign Led1=(A<B);  
    assign Led2=(A==B); 
    assign Led3=(A>B);  

   
    assign led1= ~Led1;
    assign led2= ~Led2;
    assign led3= ~Led3;

endmodule