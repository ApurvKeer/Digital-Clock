module button_input (clk, clk1_in, clk2_in, clk3_in, clk4_in, min_unit, min_tens, hrs_unit,
		 hrs_tens);
	input clk1_in, clk2_in, clk3_in, clk4_in, clk;
	wire clk1, clk2, clk3, clk4;
	output reg [3:0] min_unit, hrs_unit = 4'd0;
	output reg [2:0] min_tens = 3'd0;
	output reg [1:0] hrs_tens = 2'd0;
	
	debouncer A (
		.clk(clk),
		.button(clk1_in),
		.signal(clk1)
	);
	
	debouncer B (
		.clk(clk),
		.button(clk2_in),
		.signal(clk2)
	);
	
	debouncer C (
		.clk(clk),
		.button(clk3_in),
		.signal(clk3)
	);
	
	debouncer D (
		.clk(clk),
		.button(clk4_in),
		.signal(clk4)
	);
	
	always@ (negedge clk1) begin
		if (min_unit == 9) begin
			min_unit = 4'd0;
		end
		else begin
			min_unit = min_unit + 4'd1;
		end
	end
	
	always@ (negedge clk2) begin
		if (min_tens == 5) begin
			min_tens = 3'd0;
		end
		else begin
			min_tens = min_tens + 3'd1;
		end
	end
	
	always@ (negedge clk3) begin
		if (hrs_unit == 9) begin
			hrs_unit = 4'd0;
		end
		else begin
			hrs_unit = hrs_unit + 4'd1;
		end
	end
	
	always@ (negedge clk4) begin
		if (hrs_tens == 2) begin
			hrs_tens = 4'd0;
		end
		else begin
			hrs_tens = hrs_tens + 4'd1;
		end
	end
	
endmodule

module debouncer(clk, button, signal);

	input button, clk;
	wire clk_4hz;
	reg d1, d2, d3;
	output signal;
	
	clock_4Hz (
		.clk_og(clk),
		.clk_4hz(clk_4hz)
	);
	
	always@ (posedge clk_4hz) begin
		d1 <= button;
		d2 <= ~d1;
		d3 <= (d1 & d2);
	end
	
	assign signal = d3;
	
endmodule	
	