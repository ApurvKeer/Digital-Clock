module clock_1sec(clk_og,clk_1hz);
	input clk_og;
	output reg clk_1hz=0;
	
	reg[25:0] count = 0;
	
	always@(posedge clk_og)
	begin
		if(count<250000)
		begin	
			count<=count+1;
		end
		else
		begin
			count<=0;
			clk_1hz<=~clk_1hz;
		end
	end	

endmodule

module clock_4Hz(clk_og,clk_4hz);
	input clk_og;
	output reg clk_4hz=0;
	
	reg[25:0] count = 0;
	
	always@(posedge clk_og)
	begin
		if(count<6250000)
		begin	
			count<=count+1;
		end
		else
		begin
			count<=0;
			clk_4hz<=~clk_4hz;
		end
	end	

endmodule