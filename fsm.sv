module fsm(
input logic clk,
input logic rst,
input logic put,
input logic right,
input logic left,
input logic invalid_move,
output logic turn
);

enum logic[2:0] {rec0=3'b000, rec1=3'b001, rec2=3'b010, rec3=3'b011, rec4=3'b100, rec5=3'b101, rec6=3'b110} state;
// each state is the active column 
always_ff@(posedge clk or negedge rst) begin
//in rst I activate the first so that the game begins and the red player is playing
 if(!rst) begin
     turn<=0;
     state<=rec0;
  end else begin

  case (state)

   rec0: begin
   //after we've checked if the "put" is pressed and if "invalid move" is zero, the player is chaing turn and the state is the same
    if (put) begin
     if(invalid_move==0)begin
     if(turn)begin
       turn<=0;
     end else if(!turn) begin 
     turn<=1;
	  end
     end else if(invalid_move==1)begin
       turn<=turn;
     end 
       state<=rec0;
       //if "right" is pressed then we go to "rec1" which is the active column on the right
    end else if(right) begin
     state<=rec1;
    end else if (left) begin
    //with "left" I go left (here I go to the column 6)
     state<=rec6;
    end
   end//rec0

   rec1: begin
     if (put) begin
      if(invalid_move==0)begin
       if(turn)begin
        turn<=0;
       end else if(!turn) begin 
        turn<=1;
		  end
      end else if(invalid_move==1)begin
       turn<=turn;
     end 
      state<=rec1;
    end else if(right) begin
     state<=rec2;
    end else if (left) begin
     state<=rec0;
    end
   end//rec1

   rec2: begin
   if (put) begin
     if(invalid_move==0)begin
     if(turn)begin
       turn<=0;
     end else if(!turn) begin 
     turn<=1;
	  end
     end else if(invalid_move==1)begin
       turn<=turn;
     end 
     state<=rec2;
    end else if(right) begin
     state<=rec2;
    end else if (left) begin
     state<=rec1;
    end
   end//rec2


   rec3: begin
    if (put) begin
  if(invalid_move==0)begin
     if(turn)begin
       turn<=0;
     end else if(!turn) begin 
     turn<=1;
	  end
     end else if(invalid_move==1)begin
       turn<=turn;
     end 
        state<=rec3;
    end else if(right) begin
     state<=rec4;
    end else if (left) begin
     state<=rec2;
    end
   end//rec3


   rec4: begin
    if (put) begin
 if(invalid_move==0)begin
     if(turn)begin
       turn<=0;
     end else if(!turn) begin 
     turn<=1;
	  end
     end else if(invalid_move==1)begin
       turn<=turn;
     end 
     state<=rec4;
    end else if(right) begin
     state<=rec5;
    end else if (left) begin
     state<=rec3;
    end
   end//rec4


   rec5: begin
    if (put) begin
 if(invalid_move==0)begin
     if(turn)begin
       turn<=0;
     end else if(!turn) begin 
     turn<=1;
	  end
     end else if(invalid_move==1)begin
       turn<=turn;
     end 
        state<=rec5;
    end else if(right) begin
     state<=rec6;
    end else if (left) begin
     state<=rec4;
    end
   end//rec5

   rec6: begin
    if (put) begin
  if(invalid_move==0)begin
     if(turn)begin
       turn<=0;
     end else if(!turn) begin 
     turn<=1;
	  end
     end else if(invalid_move==1)begin
       turn<=turn;
     end 
     state<=rec6;
    end else if(right) begin
     state<=rec0;
    end else if (left) begin
     state<=rec5;
    end
   end//rec6
endcase
end
end
endmodule



