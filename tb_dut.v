 `timescale 1ns / 1ps


module rndrbn_tb;
 reg clk,rst,prior;
  reg [3:0] req;
  wire [3:0] grant;
  rndrbn r1(clk,rst,prior,req,grant);
  always begin
  clk<=1'b1; #10;
  clk<=1'b0; #10; end
  
  initial begin
    clk <= 1'b0;  rst <= 1'b0; prior<=1'b0; req <= 4'b0000; #20;
    rst <= 1'b1; #100;
    rst <= 1'b0; #40;      
    @(posedge clk) begin #5; 
     prior<=1'b1;    req <= 4'b1000; #20;       
     req <= 4'b1110;  #20;    
     req <= 4'b0110;  #20;     
     req <= 4'b1111;  #20;  
     req <= 4'b0010;  #20;
     req <= 4'b1111;  #20;    
     req <= 4'b0100;  #20;      
     req <= 4'b0000;  #40;       
     prior<=1'b0;    req <= 4'b1000; #20;       
     req <= 4'b1110;  #20;    
     req <= 4'b0110;  #20;     
     req <= 4'b1111;  #20;  
     req <= 4'b0010;  #20;
     req <= 4'b1111;  #20;    
     req <= 4'b0100;  #20;      
     req <= 4'b0000;  #40;     end             
  end
endmodule
