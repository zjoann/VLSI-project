//win//
module win(
input logic clk,
input logic rst,
input logic turn,
input logic [1:0] panel [0:5][0:6],
output logic win_a,
output logic win_b
);


int i,j,k,l,m,n,o,p;

always_ff@(posedge clk or negedge rst)
begin 
  
if(!rst) begin
  win_a <= 0;
  win_b <= 0;
end else begin
 for(i=0; i<=5; i++) begin          //row win
   for(j=0; j<=3; j++) begin   
      if(panel[i][j]==2'b01 && panel[i][j+1]==2'b01 && panel[i][j+2]==2'b01 && panel[i][j+3]==2'b01) begin
              win_a <= 1'b1;
              win_b <= 1'b0;
      end else if(panel[i][j]==2'b10 && panel[i][j+1]==2'b10 && panel[i][j+2]==2'b10 && panel[i][j+3]==2'b10) begin 
              win_a <= 1'b0;
              win_b <= 1'b1;
      end
   end
 end
  
 //column win
 for(k=0; k<=2; k++) begin
   for(l=0; l<=3; l++) begin     
      if(panel[k][l]==2'b01 && panel[k+1][l]==2'b01 && panel[k+2][l]==2'b01 && panel[k+3][l]==2'b01) begin
                win_a <= 1'b1;
                win_b <= 1'b0;
      end else if(panel[k][l]==2'b10 && panel[k][l+1]==2'b10 && panel[k][l+2]==2'b10 && panel[k][l+3]==2'b10) begin 
                win_a <= 1'b0;
                win_b <= 1'b1;
      end
   end
 end 
  
 //diagonal win (upstream, for left to right) 
 for(m=0; m<=2; m++) begin
   for(n=0; n<=3; n++) begin   
       if(panel[m+3][n]==2'b01 && panel[m+2][n+1]==2'b01 && panel[m+1][n+2]==2'b01 && panel[m][n+3]==2'b01) begin
                   win_a <= 1'b1;
                   win_b <= 1'b0;
       end else if(panel[m+3][n]==2'b10 && panel[m+2][n+1]==2'b10 && panel[m+1][n+2]==2'b10 && panel[m][n+3]==2'b10) begin 
                   win_a <= 1'b0;
                   win_b <= 1'b1;
       end
   end
 end 
  
 //diagonal win (downstream, for left to right) 
 for(o=0; o<=2; o++) begin
   for(p=0; p<=3; p++) begin 
      if(panel[o][p]==2'b01 && panel[o+1][p+1]==2'b01 && panel[o+2][p+2]==2'b01 && panel[o+3][p+3]==2'b01) begin
                win_a <= 1'b1;
                win_b <= 1'b0;
      end else if(panel[o][p]==2'b10 && panel[o+1][p+1]==2'b10 && panel[o+2][p+2]==2'b10 && panel[o+3][p+3]==2'b10) begin 
                win_a <= 1'b0;
                win_b <= 1'b1;
   end
 end
   
end 
end
end
endmodule
