`timescale 1ns/1ns
module rtl_top (
	input clr, clk, Compare, Start,
	output LoadReg, DataMark, SerialOutput,
	output [7:0] B, 	
	input ADC_PWR_low,ADC_PWR_moderate,ADC_PWR_high,OUT_PWR, OUT_RET_PWR, OUT_RET
);

	wire clr_c, clk_c, Compare_c, Start_c;
	wire LoadReg_i, DataMark_i, SerialOutput_i; 
	wire [7:0] B_i;
	wire [7:0] B_ADCCtrl;

	// single bit inputs
	PAD_IN pi0 (.PAD(clr), .C(clr_c));
	PAD_IN pi1 (.PAD(clk), .C(clk_c));
	PAD_IN pi2 (.PAD(Compare), .C(Compare_c));
	PAD_IN pi3 (.PAD(Start), .C(Start_c)); 

	//single bit outputs
	PAD_OUT po0 (.I(LoadReg_i), .PAD(LoadReg));
	PAD_OUT p01 (.I(DataMark_i), .PAD(DataMark));
	PAD_OUT p02 (.I(SerialOutput_i), .PAD(SerialOutput));
	
	// Multiple bit outputs
	PAD_OUT p0_10(.I(B_i[0]), .PAD(B[0]));
	PAD_OUT p0_11(.I(B_i[1]), .PAD(B[1]));
	PAD_OUT p0_12(.I(B_i[2]), .PAD(B[2]));
	PAD_OUT p0_13(.I(B_i[3]), .PAD(B[3]));

	PAD_OUT p0_14(.I(B_i[4]), .PAD(B[4]));
	PAD_OUT p0_15(.I(B_i[5]), .PAD(B[5]));
	PAD_OUT p0_16(.I(B_i[6]), .PAD(B[6]));
	PAD_OUT p0_17(.I(B_i[7]), .PAD(B[7]));

	// Insert RTL components
	//
	// Intermediate signals for instances 

	 // ADCCtrl inst
	 ADCCtrl ADCCtrl_inst (
		.clr(clr_c), 
		.clk(clk_c),
		.Compare(Compare_c), 
		.Start(Start_c),
		.DataMark(DataMark_i), 
		.B(B_ADCCtrl), 
		.LoadReg(LoadReg_i),
		.SerialOutput(SerialOutput_i)
	);
    	
	//register for B	
	register #(.N(8)) B_reg (
		.clk(clk_c),
		.reset(clr_c),
		.d(B_ADCCtrl),
		.q(B_i)
	);


endmodule
