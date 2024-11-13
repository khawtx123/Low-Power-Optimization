mescale 1ns/1ns
import UPF::*;
module adc_tester;

	int status;
	int CLK_PD1 =12;
	
	// Inputs
	reg clk, reset, window;
	wire clk_window, clr, Compare, Start; 
	
	// Outputs
	wire [7:0] B;
	wire LoadReg, DataMark, SerialOutput; 
	
	reg ADC_PWR_low, ADC_PWR_moderate, ADC_PWR_high, OUT_PWR;
	reg OUT_RET;
	reg OUT_RET_PWR; 

	rtl_top dut (
		.clr(clr),
		.clk(clk_window),
		.Compare(Compare),
		.Start(Start),
		.LoadReg(LoadReg),
		.DataMark(DataMark),
		.SerialOutput(SerialOutput),
		.B(B);
		.ADC_PWR_low(ADC_PWR_low),
		.ADC_PWR_moderate(ADC_PWR_moderate),
		.ADC_PWR_high(ADC_PWR_high),
		.OUT_PWR(OUT_PWR),
		.OUT_RET_PWR(OUT_RET_PWR), 
		.OUT_RET(OUT_RET));

	// CLOCK GENERATOR #1
	initial begin 
		clk <= '0;
		forever #(CLK_PD1/2) clk = ~clk;
	end

	assign clk_window = clk & window;


endmodule  
