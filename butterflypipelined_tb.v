`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:38:03 02/11/2017
// Design Name:   t1
// Module Name:   D:/IIIT_H/Xilinx projects/myradix2fft_pipeline/butterflypipelined_tb.v
// Project Name:  myradix2fft_pipeline
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: t1
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module butterflypipelined_tb;

	// Inputs
	reg [7:0] x0;
	reg [7:0] x1;
	reg [7:0] x2;
	reg [7:0] x3;
	reg [7:0] x4;
	reg [7:0] x5;
	reg [7:0] x6;
	reg [7:0] x7;
	reg [7:0] clk;
	reg [7:0] reset;

	// Outputs
	wire [7:0] X0;
	wire [7:0] X1;
	wire [7:0] X2;
	wire [7:0] X3;
	wire [7:0] X4;
	wire [7:0] X5;
	wire [7:0] X6;
	wire [7:0] X7;
	wire [7:0] Xi1;
	wire [7:0] Xi2;
	wire [7:0] Xi3;
	wire [7:0] Xi5;
	wire [7:0] Xi6;
	wire [7:0] Xi7;

	// Instantiate the Unit Under Test (UUT)
	t1 uut (
		.x0(x0), 
		.x1(x1), 
		.x2(x2), 
		.x3(x3), 
		.x4(x4), 
		.x5(x5), 
		.x6(x6), 
		.x7(x7), 
		.clk(clk), 
		.reset(reset), 
		.X0(X0), 
		.X1(X1), 
		.X2(X2), 
		.X3(X3), 
		.X4(X4), 
		.X5(X5), 
		.X6(X6), 
		.X7(X7), 
		.Xi1(Xi1), 
		.Xi2(Xi2), 
		.Xi3(Xi3), 
		.Xi5(Xi5), 
		.Xi6(Xi6), 
		.Xi7(Xi7)
	);

	initial begin
		// Initialize Inputs
		x0 = 0;
		x1 = 0;
		x2 = 0;
		x3 = 0;
		x4 = 0;
		x5 = 0;
		x6 = 0;
		x7 = 0;
		clk = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		x0 = 82;
		x1 = 44;
		x2 = 62;
		x3 = 79;
		x4 = 92;
		x5 = 74;
		x6 = 18;
		x7 = 41;
		clk = 1;
		reset = 0;
        
		// Add stimulus here

	end
      
endmodule

