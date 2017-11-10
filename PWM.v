module PWM_counter #(parameter pulse_width = 100 ) (input clk, input rst, output reg[3:0] count);
always @ (posedge clk)
begin 
if (count < pulse_width)
count=count+1'b1;
else
count= 4'b0;
end

always @ (negedge rst)
begin
if (rst = 1)
count= 4'b0;
end

endmodule
