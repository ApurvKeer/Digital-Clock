module led_output(sec_u, sec_t, min_u, min_t, hrs_u, hrs_t, clk, time_ow, clk1_in, clk2_in,
		 clk3_in, clk4_in, switch);
	input clk, clk1_in, clk2_in, clk3_in, clk4_in, time_ow, switch;
	wire [19:0] time_out;
	wire [19:0] time_in;
	reg [19:0] option;
	output reg [7:0] sec_u, sec_t, min_u, min_t, hrs_u, hrs_t = 8'b0;
	
	digital_clock A (.clk(clk), .time_ow(time_ow), .time_out(time_out), .clk1_in(clk1_in),
					.clk2_in(clk2_in), .clk3_in(clk3_in), .clk4_in(clk4_in), .time_in(time_in));
	
	always @(posedge clk) begin
	
		if (switch) begin
			option <= time_out;
		end
		else begin
			option <= time_in;
		end
	
      case (option[19:18])
        2'b00 : hrs_t <= 8'b00000010;
        2'b01 : hrs_t <= 8'b10001111;
        2'b10 : hrs_t <= 8'b00010001;
      endcase
		
		case (option[17:14])
        4'b0000 : hrs_u <= 8'b00000010;
        4'b0001 : hrs_u <= 8'b10001111;
        4'b0010 : hrs_u <= 8'b00010001;
        4'b0011 : hrs_u <= 8'b00000101;
        4'b0100 : hrs_u <= 8'b10001100;          
        4'b0101 : hrs_u <= 8'b01000100;
        4'b0110 : hrs_u <= 8'b01000000;
        4'b0111 : hrs_u <= 8'b00001111;
        4'b1000 : hrs_u <= 8'b00000000;
        4'b1001 : hrs_u <= 8'b00000100;
      endcase
		
		case (option[13:11])
        3'b000 : min_t <= 8'b00000010;
        3'b001 : min_t <= 8'b10001111;
        3'b010 : min_t <= 8'b00010001;
        3'b011 : min_t <= 8'b00000101;
        3'b100 : min_t <= 8'b10001100;          
        3'b101 : min_t <= 8'b01000100;
      endcase
		
		case (option[10:7])
        4'b0000 : min_u <= 8'b00000010;
        4'b0001 : min_u <= 8'b10001111;
        4'b0010 : min_u <= 8'b00010001;
        4'b0011 : min_u <= 8'b00000101;
        4'b0100 : min_u <= 8'b10001100;          
        4'b0101 : min_u <= 8'b01000100;
        4'b0110 : min_u <= 8'b01000000;
        4'b0111 : min_u <= 8'b00001111;
        4'b1000 : min_u <= 8'b00000000;
        4'b1001 : min_u <= 8'b00000100;
      endcase
		
		
    end // always @ (posedge clk)
	

endmodule
