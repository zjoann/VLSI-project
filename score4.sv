module score4(
input logic clk,
input logic rst,

input logic left,
input logic right,
input logic put,

output logic player,
output logic invalid_move,
output logic win_a,
output logic win_b,
output logic full_panel,


output logic hsync,
output logic vsync,
output logic [3:0] red,  
output logic [3:0] green,
output logic [3:0] blue
);

logic [1:0]panel[0:5][0:6];
logic play[0:6];
logic signal_in;
logic falling_edge;

synchronizer synched(clk, rst, signal_in, falling_edge);

fsm playing(clk, rst, put, right, left, invalid_move, player);

win winner(clk, rst, player, panel, win_a, win_b);

state_update up(clk, rst, player, put ,right, left, win_a, win_b, panel, play, invalid_move);

fullpanel fully(clk, rst, panel, full_panel);

display disp(clk, rst, panel, play, player, hsync, vsync, red, green, blue); 

endmodule