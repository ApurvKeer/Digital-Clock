module digital_clock(clk, time_ow, time_out, clk1_in, clk2_in, clk3_in, clk4_in, time_in);
	input clk, time_ow; //1 Hz clock (clock), Time overwrite (asynchronous reset)
	input clk1_in, clk2_in, clk3_in, clk4_in;
   //Time signal format: hh_hhhh:mmm_mmmm:sss_ssss only decimal values
   output [19:0] time_out; //main output
   wire clk_1hz;
	output [19:0] time_in;
	wire [3:0] min_unit, hrs_unit;
	wire [2:0] min_tens;
	wire [1:0] hrs_tens;
	reg [3:0] sec_unit = 4'b0;
	reg [2:0] sec_tens = 3'b0;
	
	assign time_in = {hrs_tens, hrs_unit, min_tens, min_unit, sec_tens, sec_unit};
	
   clock_1sec A (
		.clk_og(clk),
		.clk_1hz(clk_1hz)
	);
	
   clockWorkDec C (
		.clk_1hz(clk_1hz),
		.time_ow(time_ow),
		.time_in(time_in),
		.time_out(time_out)
   );
	
	button_input B (
		.clk(clk),
		.clk1_in(clk1_in),
		.clk2_in(clk2_in),
		.clk3_in(clk3_in),
		.clk4_in(clk4_in),
		.min_unit(min_unit),
		.min_tens(min_tens),
		.hrs_tens(hrs_tens),
		.hrs_unit(hrs_unit)
	);
	
	
endmodule


