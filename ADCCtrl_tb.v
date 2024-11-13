`timescale 1ps/1ps

module ADCCtrl_tb();

reg clr, clk, Compare, Start;
wire LoadReg, DataMark, SerialOutput;
wire [7:0] B;

initial
begin
   clk = 0;
   forever #5 clk = !clk;
end

initial
begin
   clr = 1; 
   Compare = 0;
   Start = 0;
   #20;
   clr = 0;
   #50;
   clr = 1;
   #200;
   Start = 1;
   #200;
   Compare = 1;
   #200;
   Compare  = 0;
   #200;
   Start = 0;
   #200;
end

ADCCtrl ADCCtrl_inst (
.clr(clr),
.clk(clk),
.Compare(Compare),
.Start(Start),
.DataMark(DataMark),
.B(B),
.LoadReg(LoadReg),
.SerialOutput(SerialOutput));

endmodule

