module Avalon_PMW (
input csi_clk, 
input rsi_rst_n, 
input avs_s0_read, 
input avs_s0_write, 
input avs_s0_chip_select, 
input wire [3:0] avs_s0_byteenable, 
input wire [31:0] avs_s0_writedata, 
input wire [1:0] avs_s0_address,
output wire [31:0] avs_s0_readdata,
output coe_pwm_out
);
reg [31:0] pulse_width, period;
reg [7:0]enable;
reg read_data;
wire load_pulse_width, load_enable, load_period;
wire read_pulse_width, read_period, read_enable;
wire pwm_out;

assign coe_pwm_out = pwm_out & enable;
assign avs_s0_readdata = read_data;

PWM_counter PWM0(
	.clk (csi_clk), .rst_n (rsi_rst_n), .pulse_period (period),
	.pulse_width (pulse_width), .pwm (pwm_out)
	);
	
assign load_pulse_width = avs_s0_chip_select & avs_s0_write & (avs_s0_address == 0);
assign load_period = avs_s0_chip_select & avs_s0_write & (avs_s0_address == 1);
assign load_enable = avs_s0_chip_select & avs_s0_write & (avs_s0_address == 2);

assign read_pulse_width = avs_s0_chip_select & avs_s0_read & (avs_s0_address == 0);
assign read_period = avs_s0_chip_select & avs_s0_read & (avs_s0_address == 1);
assign read_enable = avs_s0_chip_select & avs_s0_read & (avs_s0_address == 2);

always @ (posedge csi_clk) begin
if (rsi_rst_n == 0) begin
	pulse_width <= 250000; 
	period <= 500000; 
	enable <= 1;
end
else
 if (load_pulse_width == 1) begin
	if  (avs_s0_byteenable[0] == 1) begin
		pulse_width[7:0] <=avs_s0_writedata[7:0];
		end 
	if  (avs_s0_byteenable[1] == 1) begin
		pulse_width[15:8] <=avs_s0_writedata[15:8];
		end 
	if  (avs_s0_byteenable[2] == 1) begin
		pulse_width[23:16] <=avs_s0_writedata[23:16];
		end 
	if  (avs_s0_byteenable[3] == 1) begin
		pulse_width[31:24] <=avs_s0_writedata[31:24];
		end 
	end
if (read_pulse_width ==1) begin
	read_data <=pulse_width;
end

if (load_period == 1) begin
	if  (avs_s0_byteenable[0] == 1) begin
		period[7:0] <=avs_s0_writedata[7:0];
		end 
	if  (avs_s0_byteenable[1] == 1) begin
		period[15:8] <=avs_s0_writedata[15:8];
		end 
	if  (avs_s0_byteenable[2] == 1) begin
		period[23:16] <=avs_s0_writedata[23:16];
		end 
	if  (avs_s0_byteenable[3] == 1) begin
		period[31:24] <=avs_s0_writedata[31:24];
		end 
end
if (read_period ==1) begin
	read_data <=period;
end
if (load_enable== 1) begin
	if  (avs_s0_byteenable[0] == 1) begin
		enable[7:0] <=avs_s0_writedata[7:0];
	end 
end
if (enable ==1) begin
	read_data <=enable;
end
end
endmodule
