`timescale 1ns/1ns

`celldefine
module register
	#(parameter N = 8) (
		input clk ,
		input reset, 
		input [N-1 : 0] d,
		output reg [N-1 : 0] q
	);
	
	always @ (posedge(clk),posedge(reset))
	begin
	if (reset)
		q <= 0;
	else
		q <= d;
	end
endmodule
`endcelldefine
