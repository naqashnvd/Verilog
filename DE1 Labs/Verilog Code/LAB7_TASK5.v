//LAB 7 Task V
module Lab7(input [0:0]SW,input [3:2]KEY,output[6:0]HEX0,output[6:0]HEX1,output[6:0]HEX2,output[6:0]HEX3);
wire [6:0]in;
FSM(KEY[2],KEY[3],HEX3,in);
//register#(7)(in,KEY[2],KEY[3],HEX0);
//register#(7)(HEX0,KEY[2],KEY[3],HEX1);
//register#(7)(HEX1,KEY[2],KEY[3],HEX2);
//register#(7)(HEX2,KEY[2],KEY[3],HEX3);
wire right = 1;
shiftReg(in[0],right,KEY[2],HEX0[0]);
shiftReg(in[1],right,KEY[2],HEX0[1]);
shiftReg(in[2],right,KEY[2],HEX0[2]);
shiftReg(in[3],right,KEY[2],HEX0[3]);
shiftReg(in[4],right,KEY[2],HEX0[4]);
shiftReg(in[5],right,KEY[2],HEX0[5]);
shiftReg(in[6],right,KEY[2],HEX0[6]);

shiftReg(HEX0[0],right,KEY[2],HEX1[0]);
shiftReg(HEX0[1],right,KEY[2],HEX1[1]);
shiftReg(HEX0[2],right,KEY[2],HEX1[2]);
shiftReg(HEX0[3],right,KEY[2],HEX1[3]);
shiftReg(HEX0[4],right,KEY[2],HEX1[4]);
shiftReg(HEX0[5],right,KEY[2],HEX1[5]);
shiftReg(HEX0[6],right,KEY[2],HEX1[6]);

shiftReg(HEX1[0],right,KEY[2],HEX2[0]);
shiftReg(HEX1[1],right,KEY[2],HEX2[1]);
shiftReg(HEX1[2],right,KEY[2],HEX2[2]);
shiftReg(HEX1[3],right,KEY[2],HEX2[3]);
shiftReg(HEX1[4],right,KEY[2],HEX2[4]);
shiftReg(HEX1[5],right,KEY[2],HEX2[5]);
shiftReg(HEX1[6],right,KEY[2],HEX2[6]);

shiftReg(HEX2[0],right,KEY[2],HEX3[0]);
shiftReg(HEX2[1],right,KEY[2],HEX3[1]);
shiftReg(HEX2[2],right,KEY[2],HEX3[2]);
shiftReg(HEX2[3],right,KEY[2],HEX3[3]);
shiftReg(HEX2[4],right,KEY[2],HEX3[4]);
shiftReg(HEX2[5],right,KEY[2],HEX3[5]);
shiftReg(HEX2[6],right,KEY[2],HEX3[6]);




endmodule


module shiftReg(in,right,clock,Q);
parameter length = 4;
input in;
input clock;
input right;
output reg [0:length-1]Q;

integer i;
always@(posedge clock)begin
if(right)begin
	Q[length-1]<=in;
	for(i=0;i<length-1;i=i+1)begin
		Q[i]<=Q[i+1];
	end
end
else begin
	Q[0]<=in;
	for(i=length-1;i>0;i=i-1)begin
		Q[i]<=Q[i-1];
	end
end
end 
endmodule


module FSM(clock,clear,lastStage,nState);
parameter width = 7;
parameter O =7'b1000000;
parameter A =7'b1111001;
parameter B =7'b0100100;
parameter C =7'b0110000;
parameter D =7'b0011001;
input clock,clear;
input [width-1:0]lastStage;
output reg [width-1:0]nState;
reg [width-1:0]pState = O ;

always@(pState)begin
case(pState)
	O: nState=A;
	A: nState=B;
	B: nState=C;
	C: nState=D;
	D: nState=lastStage;
	
	endcase
end
	
always@(posedge clock,negedge clear)begin
	if(~clear)begin
	pState <= O;
	end
	else begin
	pState <=nState;
	end
end

endmodule


module register(D,clock,clear,Q);
parameter width = 0;
input [width-1:0]D;
input clock;
input clear;
output reg [width-1:0]Q;
always@(posedge clock,negedge clear)begin
	if(~clear)begin
	Q <= 0;
	end
	else begin
	Q <=D;
	end
end
endmodule