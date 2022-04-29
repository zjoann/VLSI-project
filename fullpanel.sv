
module fullpanel(
input logic clk,
input logic rst,
input logic [1:0]panel[0:5][0:6],
output logic full_panel
);


// sto rst to full_panel 0 
always_ff @(posedge clk or negedge rst)
begin
  if(!rst) begin
     full_panel <= 0;
  end else begin
  //check if top row is full (squares: 01-02-03-03-04-05-06)
     if(panel[0][0]!=2'b00 && panel[0][1]!=2'b00 && panel[0][2]!=2'b00 && panel[0][3]!=2'b00 && panel[0][4]!=2'b00 && panel[0][5]!=2'b00 && panel[0][6]!=2'b00) 
     begin
     full_panel <= 1;
  end else full_panel <= 0;
 end
end

endmodule     