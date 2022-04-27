`timescale 1ns / 1ps

module enable_ramping_slice(
    input [1:0] enable_ramping,
    input [1:0] start_ramp_down,
    output enable_ramping_0,
    output enable_ramping_1,
    output start_ramp_down_0,    
    output start_ramp_down_1
);

assign enable_ramping_ = enable_ramping[0];
assign enable_ramping_ = enable_ramping[1];
assign start_ramp_down_ = start_ramp_down[0];
assign start_ramp_down_ = start_ramp_down[1];


endmodule
