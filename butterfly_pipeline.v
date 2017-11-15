`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:31:17 02/11/2017 
// Design Name: 
// Module Name:    butterfly_pipeline 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module t1(
input[7:0] x0,x1,x2,x3,x4,x5,x6,x7,clk,reset,                                      // port declaration      
//output[7:0] 
output[7:0] X0,X1,X2,X3,X4,X5,X6,X7,Xi1,Xi2,Xi3,Xi5,Xi6,Xi7
);   


          // wire ynf1,ynf3,ynf5,ynf7;																						
			  wire [7:0] yp0,yp1,yp2,yp3,yp4,yp5,yp6,yp7,yn0,yn1,yn2,yn3,yn4,yn5,yn6,yn7;		                    // wire declaration									
			  wire [7:0] ypi0,ypi1,ypi2,ypi3,ypi4,ypi5,ypi6,ypi7,yni0,yni1,yni2,yni3,yni4,yni5,yni6,yni7;
			

				parameter wo = 3'b000;
				parameter w1 = 3'b001;
				parameter w2 = 3'b010;
				parameter w3 = 3'b011;
				parameter w4 = 3'b100;
				parameter w5 = 3'b101;
				parameter w6 = 3'b110;
				parameter w7 = 3'b111;


				parameter wi0 = 3'b000;
				parameter wi1 = 3'b001;
				parameter wi2 = 3'b010;
				parameter wi3 = 3'b011;
				parameter wi4 = 3'b100;
				parameter wi5 = 3'b101;
				parameter wi6 = 3'b110;
				parameter wi7 = 3'b111;


// stage 1 fft

 
				assign yp0=add(x0 , x4);
				assign yp1=sub(x0 , x4);
				assign yp2=add(x2 , x6);
				assign yp3=sub(x2 , x6);
				assign yp4=add(x1 , x5);
				assign yp5=sub(x1 , x5);
				assign yp6=add(x3 , x7);
				assign yp7=sub(x3 , x7);

reg [8:0] Qp0,Qp1,Qp2,Qp3,Qp4,Qp5,Qp6,Qp7;
wire [8:0] Dp0,Dp1,Dp2,dp3,Dp4,Dp5,Dp6,Dp7;

assign Dp0=yp0,
       Dp1=yp1,
		 Dp2=yp2,
		 Dp3=yp3,
		 Dp4=yp4,
		 Dp5=yp5,
		 Dp6=yp6,
		 Dp7=yp7;

always @(posedge clk)
  
 if(reset)
   begin
  	   Qp0 = 1'b0;
	   Qp1 = 1'b0;
	   Qp2 = 1'b0;
	   Qp3 = 1'b0;
	   Qp4 = 1'b0;
	   Qp5 = 1'b0;
	   Qp6 = 1'b0;
	   Qp7 = 1'b0;
   end
 else
   begin
      Qp0 = Dp0;
      Qp1 = Dp1;
      Qp2 = Dp2;
      Qp3 = Dp3;
      Qp4 = Dp4;
      Qp5 = Dp5;
      Qp6 = Dp6;
      Qp7 = Dp7;
   end
// satge 2 fft

						assign yn0=add(yp0 , yp2);
						
						assign yn1=add(yp1 , mul(yp3,w2));
						assign yni1=add(yp1 , mul(yp3,wi2));
						
						
						assign yn2=sub(yp0 , yp2);
						
						assign yn3=sub(yp1 , mul(yp3,w2));
						assign yni3=sub(yp1 , mul(yp3,wi2));
						
						assign yn4=add(yp4 , yp6);
						
						assign yn5=add(yp5 , mul(yp7,w2));
						assign yni5=add(yp5 , mul(yp7,wi2));	
						
						
						assign yn6=sub(yp4 , yp6);
						
						assign yn7=sub(yp5 , mul(yp7,w2));
						assign yni7=sub(yp5 , mul(yp7,wi2));		
						

// stage 3 fft

                  assign X0 = add(yn0 , yn4);
						//assign Xf0=X0;
						
						assign X1 = add(yn1 , mul(w1,yn5));
						assign Xi1= add(yni1 , mul(wi1,yni5));
						//assign Xf1=add(X1,Xi1);
						
						assign X2 = add(yn2 , mul(yn6,w2));
						assign Xi2= add(yni2 , mul(yni6,wi2));
						//assign Xf2=add(X2,Xi2);
						
						assign X3 = add(yn3 , mul(w3,yn7));
						assign Xi3= add(yni3 , mul(wi3,yni7));
						//assign Xf3=add(X3,Xi3);
						
						assign X4 = sub(yn0,yn4);
						//assign Xf4=X4;
						
						assign X5 = sub(yn1 , mul(w1,yn5));
						assign Xi5= sub(yni1 , mul(wi1,yni5));
						//assign Xf5=add(X5,Xi5);
						
						assign X6 = sub(yn2 , mul(w2,yn6));
						assign Xi6= sub(yn2 , mul(wi2,yn6));
						//assign Xf6=add(X6,Xi6);
						
						assign X7 = sub(yn3 , mul(w3, yn7));
						assign Xi7= sub(yni3, mul(wi3,yni7));
						//assign Xf7=add(X7,Xi7);


function [7:0] mul;
    input [7:0] in1;
    input [7:0] in2;
     
    reg[3:0] m; //m+jn format
    reg [3:0] n;
    reg [3:0] a, b, c, d;
    
    begin
    
    a = in1[3:0];
    b = in1[7:4];
    c = in2[3:0];
    d = in2[7:4];
    
    m = a*c - b*d; // m = ac-bd
    n  = a*d + b*c; //n = ad+bc
    
    mul = {n, m};
    
    end
endfunction

function [7:0] add;
    input [7:0] in1;
    input [7:0] in2;
     
    reg[3:0] m;
    reg [3:0] n;
    reg [3:0] a, b, c, d;
    
    begin   
    a = in1[3:0];
    b = in1[7:4];
    c = in2[3:0];
    d = in2[7:4];
    
    m = a + c;
    n  = b + d;
    
    add = {n, m};
    
    end
endfunction

function [7:0] sub; // subtraction is realised as 2's complement addition
    input [7:0] in1;
    input [7:0] in2;
    
    reg[3:0] m;
    reg [3:0] n;
    reg [3:0] a, b, c, d;
    reg[3:0] cbar, dbar;    //represents 2's complement of c and d
    
    begin
    a = in1[3:0];
    b = in1[7:4];
    c = in2[3:0];
    d = in2[7:4];
    
    cbar = ~c + 1;
    dbar = ~d + 1;
    
    m = a + cbar;
    n  = b + dbar;
    
    sub = {n, m};
    
			end 
			endfunction
		
    endmodule
/*
module DFF(
output [8:0]Qp0,Qp1,Qp2,Qp3,Qp4,Qp5,Qp6,Qp7,Qn0,Qn1,Qn2,Qn3,Qn4,Qn5,Qn6,Qn7;
input clk,Dp0,Dp1,Dp2,dp3,Dp4,Dp5,Dp6,Dp7,Dn0,Dn1,Dn2,Dn3,Dn4,Dn5,Dn6,Dn7,reset;
reg Q);	 

assign Dp0=yp0,
       Dp1=yp1,
		 Dp2=yp2,
		 Dp3=yp3,
		 Dp4=yp4,
		 Dp5=yp5,
		 Dp6=yp6,
		 Dp7=yp7;
always @(posedge clk)
 if(reset)
	  Qp0,Qp1,Qp2,Qp3,Qp4,Qp5,Qp6,Qp7<=1'b0;
 else
     Qp0<=Dp0;
     Qp1<=Dp1;
     Qp2<=Dp2;
     Qp3<=Dp3;
     Qp4<=Dp4;
     Qp5<=Dp5;
     Qp6<=Dp6;
     Qp7<=Dp7;	
endmodule	  
	  */