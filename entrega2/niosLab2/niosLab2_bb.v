
module niosLab2 (
	clk_clk,
	leds_export,
	motors_export,
	reset_reset_n,
	switchs_export);	

	input		clk_clk;
	output	[7:0]	leds_export;
	output	[3:0]	motors_export;
	input		reset_reset_n;
	input	[3:0]	switchs_export;
endmodule
