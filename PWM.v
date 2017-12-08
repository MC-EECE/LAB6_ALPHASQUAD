module PWM  #(parameter WIDTH = 32)(input wire [WIDTH - 1:0] pulse_width, input wire [WIDTH - 1:0] pulse_period, input wire clk, input wire rst_n, output wire pwm );
reg d,q; 
reg [WIDTH-1:0] count_q,count_d;
assign rst = ~rst_n;

always @ (*)
begin
	count_d = count_q + 1'b1; 
if (count_q > pulse_period)
	count_d = 0;
	d = (count_d < pulse_width)?1'b1:1'b0;
end

always @ (posedge clk )
begin
	if (rst) 
		begin
		count_q <= 32'b0;
		end 
	else 
		begin
		count_q <= count_d;	
	end
	q <= d;
end
assign pwm = q;
endmodule
