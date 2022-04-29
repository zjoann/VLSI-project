module state_update(
input logic clk,
input logic rst,
input logic turn,
input logic put,
input logic right,
input logic left,
input logic win_a,
input logic win_b,
output logic [1:0]panel [0:5][0:6],
output logic play[0:6],
output logic invalid_move
);

int i,z,j,k,w;
int f,g,c,l,m,n,o,p;

always_ff@(posedge clk or negedge rst)
begin 
//if rst-> panel is empty, invalid_move=0 and 1rst rec is activated
  if(!rst) begin
	   for(z=0; z<=5; z++) begin
	     for(i=0; i<=6; i++) begin
		    panel[z][i]<=2'b00;
			 play[0]<=1;
       invalid_move<=0;
			end
	    end
       //when "put" is pressed and I check in which active column I am, then a check is taking place about which.. 
      //..square is available in the specific column and depending on the player I specify the panel color
   end else if(put) begin
     for(i=0; i<=6; i++) begin
       if(play[i]) begin
         if(panel[5][i]==2'b00 && turn==0) begin
            panel[5][i]<=2'b01;
          end else if(panel[5][i]==2'b00 && turn==1) begin
            panel[5][i]<=2'b10;
          end else if(panel[4][i]==2'b00 && turn==0) begin
            panel[4][i]<=2'b01;
          end else if(panel[4][i]==2'b00 && turn==1) begin
            panel[4][i]<=2'b10;       
          end else if(panel[3][i]==2'b00 && turn==0) begin
            panel[3][i]<=2'b01;
          end else if(panel[3][i]==2'b00 && turn==1) begin
            panel[3][i]<=2'b10;  
          end else if(panel[2][i]==2'b00 && turn==0) begin
            panel[2][i]<=2'b01;
          end else if(panel[2][i]==2'b00 && turn==1) begin
            panel[2][i]<=2'b10; 
          end else if(panel[1][i]==2'b00 && turn==0) begin
            panel[1][i]<=2'b01;
          end else if(panel[1][i]==2'b00 && turn==1) begin
            panel[1][i]<=2'b10;    
          end else if(panel[0][i]==2'b00 && turn==0) begin
            panel[0][i]<=2'b01;
          end else if(panel[0][i]==2'b00 && turn==1) begin
            panel[0][i]<=2'b10;
            //because wrap happens, invalid_move becomes "1" only in case no more squares can be put in the column
            // that way, if nothing from the above is true, we give the value "1"
          end else invalid_move<=1;
        end
      end
      //in "right" we disablw the active column in which we are in and we activate the right one
    end else if(right) begin
   for(j=0; j<=5; j++) begin
    if(play[j]) begin
       play[j]<=0;
       play[j+1]<=1;
    end else if (play[6]) begin //different case for the last active column because wrap happens
       play[6]<=0;
       play[0]<=1;
    end
  end
  //same logic with "right" for "left"
 end else if(left)begin
   for(k=1; k<=6; k++) begin
    if(play[k]) begin
       play[k]<=0;
       play[k-1]<=1;
    end else if(play[0]) begin
       play[0]<=0;
       play[6]<=1;
    end
   end
  end else begin
 for(f=0; f<=5; f++) begin          //bonus: the winning squares becomes blue
        for(g=0; g<=3; g++) begin
                if(panel[f][g]==2'b01 && panel[f][g+1]==2'b01 && panel[f][g+2]==2'b01 && panel[f][g+3]==2'b01 && win_a) begin 
                //after check is done for the winning row and at the same time "win_a" is activated, we put 2'b11 to the correspondent squares 
                               panel[f][g]<=2'b11;
                               panel[f][g+1]<=2'b11; 
                               panel[f][g+2]<=2'b11; 
                               panel[f][g+3]<=2'b11;                  
                 end else if(panel[f][g]==2'b10 && panel[f][g+1]==2'b10 && panel[f][g+2]==2'b10 && panel[f][g+3]==2'b10 && win_b) begin 
                 //the same if player b wins
                               panel[f][g]<=2'b11;
                               panel[f][g+1]<=2'b11; 
                               panel[f][g+2]<=2'b11; 
                               panel[f][g+3]<=2'b11; 
                 end
            end
end
        for(c=0; c<=2; c++) begin
        for(l=0; l<=3; l++) begin     
        // the same for the column
                if(panel[c][l]==2'b01 && panel[c+1][l]==2'b01 && panel[c+2][l]==2'b01 && panel[c+3][l]==2'b01 && win_a) begin
                          panel[c][l]<=2'b11;
                          panel[c+1][l]<=2'b11;
                          panel[c+2][l]<=2'b11;
                          panel[c+3][l]<=2'b11;
                 end else if(panel[c][l]==2'b10 && panel[c][l+1]==2'b10 && panel[c][l+2]==2'b10 && panel[c][l+3]==2'b10 && win_b) begin 
                          panel[c][l]<=2'b11;
                          panel[c+1][l]<=2'b11;
                          panel[c+2][l]<=2'b11;
                          panel[c+3][l]<=2'b11;
                 end
            end
end 
       //win -> upstream, from left to right
   for(m=0; m<=2; m++) begin
        for(n=0; n<=3; n++) begin   
                if(panel[m+3][n]==2'b01 && panel[m+2][n+1]==2'b01 && panel[m+1][n+2]==2'b01 && panel[m][n+3]==2'b01 && win_a ) begin
                          panel[m+3][n]<=2'b11; 
                          panel[m+2][n+1]<=2'b11;
                          panel[m+1][n+2]<=2'b11;
                          panel[m][n+3]<=2'b11;
                 end else if(panel[m+3][n]==2'b10 && panel[m+2][n+1]==2'b10 && panel[m+1][n+2]==2'b10 && panel[m][n+3]==2'b10 && win_b) begin 
                          panel[m+3][n]<=2'b11; 
                          panel[m+2][n+1]<=2'b11;
                          panel[m+1][n+2]<=2'b11;
                          panel[m][n+3]<=2'b11;
                 end
            end
end 
         //win -> downstream, from left to right
        for(o=0; o<=2; o++) begin
        for(p=0; p<=3; p++) begin 
                if(panel[o][p]==2'b01 && panel[o+1][p+1]==2'b01 && panel[o+2][p+2]==2'b01 && panel[o+3][p+3]==2'b01 && win_a) begin
                          panel[o][p]<=2'b11;
                          panel[o+1][p+1]<=2'b11;
                          panel[o+2][p+2]<=2'b11;
                          panel[o+3][p+3]<=2'b11;
                 end else if(panel[o][p]==2'b10 && panel[o+1][p+1]==2'b10 && panel[o+2][p+2]==2'b10 && panel[o+3][p+3]==2'b10 && win_b) begin 
                          panel[o][p]<=2'b11;
                          panel[o+1][p+1]<=2'b11;
                          panel[o+2][p+2]<=2'b11;
                          panel[o+3][p+3]<=2'b11;
                 end
            end
end 
end
end
endmodule