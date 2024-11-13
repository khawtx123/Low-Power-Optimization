`timescale 1ps/1ps

module ADCCtrl (clr,clk,Compare,Start,DataMark,B,LoadReg,SerialOutput);
input clr,clk,Compare,Start;
output LoadReg,DataMark,SerialOutput;
output [7:0] B;

reg LoadReg,DataMark,SerialOutput;
reg [7:0] B;
reg [3:0] counter;

always @ (posedge clk or negedge clr)
begin
	if(clr==0) begin
	   LoadReg <= 0;
	   DataMark <= 0;
		counter <= 0;
		B <= 0;
		SerialOutput <= 0;
	end else begin
		LoadReg <= 0;
		DataMark <= 0;		
		SerialOutput <= Compare;
		if (counter == 0) begin
		 	DataMark <= 1;
 			counter <= counter + 1;
 		end else	if (counter == 1) begin
			B <= 0;
			if (Start==1) begin
				B[7]<=1;
				counter <= counter + 1;
			end
		end else if (counter == 9) begin
			counter<=0;
			LoadReg<=1;
		   $display("Conversion result: %d (0x%h)",B,B);		   
		end else begin
			counter <= counter + 1;
			B[9-counter]<= Compare;
			B[9-counter-1]<= 1;
		end
	end
end
endmodule

