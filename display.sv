
module display(
input logic clk,
input logic rst, 
input logic [1:0]panel [0:5][0:6],
input logic play[0:6],
input logic turn,
output logic hsync,
output logic vsync,
output logic [3:0]red,
output logic [3:0]green,
output logic [3:0]blue
);

logic [9:0] x;                   //counter of pixels
logic [9:0] y;                  // counter of rows

logic enable;

//enable 
always_ff @(posedge clk or negedge rst) 
begin
  if(~rst)begin       //changed the rst in testbench
   enable<=0;
  end else enable<= ~enable;
end

  assign vsync = (y>=491 && y<=492) ? 1'b0 : 1'b1;          //each time I change frame vsync=0
  assign hsync = (x>=656 && x<=751) ? 1'b0 : 1'b1;         // each time I change line  hsync=0
  
//pixel counter
always_ff@(posedge clk or negedge rst)
    begin 
      if(~rst)
     begin
      x <= 0;
      y <= 0;
       end else begin
      if(enable) begin 
        if(x==799) begin    //end of a row
        if(y==523) begin   // end of a frame
          x<=0;
          y<=0;
        end else begin 
          y <= y+1;
          x <= 0; 
            end          
        end else begin 
          y <= y;
          x <= x+1; end
        end 
      end 
  end


int i;  //counter of panel rows
int j;  //counter of panel columns


//square and color logic
always_ff@(posedge clk or negedge rst)
begin
  if(~rst)begin  //black screen when rst is enabled
     red <= 0;
     green <= 0;
     blue <= 0;
  end else if(x<640 && y<480) begin   //out of 6x7panel everything is black
       red <= 0;
       green <= 0;
       blue <= 0;
//creation of squares and the conditions for their coloring 
/* (0,0)....(0,6)
   .          .
   .          . 
   .          .
   .          .
   (5,0)....(5,6) */

       for(i=0; i<=5; i++)begin
        for(j=0; j<=6; j++)begin
          if(panel[i][j]==2'b01 && x>=185+40*j && x<=215+40*j && y>=125+40*i && y<=155+40*i) begin  
               red <= 4'b1111;
               green <= 0;
               blue <= 0;
          end else if(panel[i][j]==2'b10 && x>=185+40*j && x<=215+40*j && y>=125+40*i && y<=155+40*i) begin
               red <= 0;
               green <= 4'b1111;
               blue <= 0;
          end else if(panel[i][j]==2'b11 && x>=185+40*j && x<=215+40*j && y>=125+40*i && y<=155+40*i) begin
               red <= 0;
               green <= 0;
               blue <= 4'b1111;
          end else if(play[j] && turn==0 && x>=185+40*j && x<=215+40*j && y>=400 && y<=420) begin
               red <= 4'b1111;
               green <= 0;
               blue <= 0;
          end else if(play[j] && turn==1 && x>=185+40*j && x<=215+40*j && y>=400 && y<=420) begin
               red <= 0;
               green <= 4'b1111;
               blue <= 0;
          end
        end
      end
    end
  
end

endmodule
