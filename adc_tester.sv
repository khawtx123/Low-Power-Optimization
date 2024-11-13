`timescale 1ns/1ns
import UPF::*;
module adc_tester;

	int status;
	int CLK_PD1 =12;
	
	// Inputs
	reg clr, clk, reset, Compare, Start, window;
	wire clk_window; 
	
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
		.B(B),
		.ADC_PWR_low(ADC_PWR_low),
		.ADC_PWR_moderate(ADC_PWR_moderate),
		.ADC_PWR_high(ADC_PWR_high),
		.OUT_PWR(OUT_PWR),
		.OUT_RET_PWR(OUT_RET_PWR), 
		.OUT_RET(OUT_RET)
	);
	// CLOCK GENERATOR #1
	initial begin 
		clk <= '0;
		forever #(CLK_PD1/2) clk = ~clk;
	end

	assign clk_window = clk & window;
	
	initial begin
                $timeformat(-9,0," ns", 8);
                window = 1'b1;
                reset = 1'b0;
                ADC_PWR_low = 1'b1;
                ADC_PWR_moderate = 1'b0;
                ADC_PWR_high = 1'b0;
                OUT_PWR = 1'b0;
                OUT_RET = 1'b0;
                OUT_RET_PWR = 1'b1;
                $messagelog("%:S Initializing Supplies @%t", "note", $realtime);
                status = supply_on("/adc_tester/dut/MAIN_PWR_high", 7.0);
                status = supply_on("/adc_tester/dut/MAIN_PWR_moderate", 5.0);
                status = supply_on("/adc_tester/dut/MAIN_PWR_low", 3.0);
                status = supply_on("/adc_tester/dut/MAIN_GND", 0.0);
                $messagelog("%:S Doing reset @%t", "note", $realtime);
		
		#100
		reset = 1'b1; 

		#100;
		Start = 1'b1;

		#100;
		reset = 1'b0;
		
		#100 shut_down_PD_ADC;  
	end
	
	task shut_down_PD_ADC;
                $messagelog("%:S Starting shutting down PD_ADC power domain @%t", "note",$realtime);
                ADC_PWR_low = 1'b0;
                ADC_PWR_high = 1'b0;
                ADC_PWR_moderate = 1'b0;
                #100;
                ADC_PWR_low = 1'b1;
                ADC_PWR_high = 1'b0;
                ADC_PWR_moderate = 1'b0;
                $messagelog("%:S Primary power restored @%t", "note", $realtime);
        endtask

endmodule 
