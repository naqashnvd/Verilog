//Simple Proc
module lab9(input [9:0]SW,input [3:0]KEY , output [0:0]LEDR ,output [6:0]HEX0);
proc proc_0 (SW[8:0],KEY[2],KEY[3],SW[9],LEDR[0],HEX0);
endmodule


module proc (DIN, Resetn, Clock, Run, Done, BusWires);
	input [15:0] DIN;
	input Resetn, Clock, Run;
	output Done;
	output [15:0] BusWires;
	
	wire [8:0]IR;
	wire [15:0]addSubOut; 
	
	wire [15:0]A,G,R0,R1,R2,R3,R4,R5,R6,R7;
	
	wire [7:0]Rin,Rout;
	wire IRin,Gin,Gout,DINout,Ain,addSub;
	wire [1:0]Tstep_Q;
	wire clear;

	upcount Tstep (Resetn, Clock, Tstep_Q);
	controlUnit cu_0(Run,Resetn,Tstep_Q,IR,IRin,Ain,Gin,DINout,Gout,Rin,Rout,Done,clear,addSub);
	
	regn reg_0 (BusWires, Rin[7], Clock, R0);
	regn reg_1 (BusWires, Rin[6], Clock, R1);
	regn reg_2 (BusWires, Rin[5], Clock, R2);
	regn reg_3 (BusWires, Rin[4], Clock, R3);
	regn reg_4 (BusWires, Rin[3], Clock, R4);
	regn reg_5 (BusWires, Rin[2], Clock, R5);
	regn reg_6 (BusWires, Rin[1], Clock, R6);
	regn reg_7 (BusWires, Rin[0], Clock, R7);
	
	AddSub Addsub_0(addSub,A,BusWires,addSubOut);
	
	regn reg_A (BusWires, Ain, Clock, A);
	regn reg_G (addSubOut, Gin, Clock, G);
	regn#(9) reg_IR (DIN[8:0], IRin, Clock, IR);
	MUX1 mux_0(BusWires,Rout,R0,R1,R2,R3,R4,R5,R6,R7,DINout,DIN,G,Gout);
	
	
endmodule

module controlUnit(Run,Resetn,Tstep_Q,IR,IRin,Ain,Gin,DINout,Gout,Rin,Rout,Done,clear,addSub);
input Run,Resetn;
input [1:0]Tstep_Q;
input [8:0]IR;
output reg IRin,Ain,Gin,DINout,Gout,Done,clear,addSub;
output reg [7:0]Rin,Rout;
wire [2:0]I;

wire [7:0]Xreg,Yreg;

assign I = IR[8:6];
dec3to8 decX (IR[5:3], 1'b1, Xreg);
dec3to8 decY (IR[2:0], 1'b1, Yreg);


always @(*)begin
		case (Tstep_Q)
		2'b00:begin // store DIN in IR in time step 0
		IRin <= 1'b1;
		end
		2'b01: begin //define signals in time step 1
		IRin <= 0;
		case (I)
					3'b000:begin
					Rout <= Yreg;
					Rin <= Xreg;
					Done <= 1;
					Ain <=0;
					Gin <=0;
					DINout <=0;
					Gout <=0;
					addSub <=0;
					end
					3'b001:begin
					DINout <= 1;
					Rin <=Xreg;
					Done <= 1;
					Rout <=8'b0;
					Ain <=0;
					Gin <=0;
					Gout <=0;
					addSub <=0;
					end
					3'b010:begin
					Ain <= 1 ; 
					Rout <=Xreg;
					Done <= 0;
					DINout <= 0;
					Rin <=8'b0;
					Gin <=0;
					Gout <=0;
					addSub <=0;
					end
					3'b011:begin
					Ain <= 1 ; 
					Rout <=Xreg;
					Done <= 0;
					DINout <= 0;
					Rin <=8'b0;
					Gin <=0;
					Gout <=0;
					addSub <=0;
					end
					default:begin 
					Ain <= 0 ; 
					Rout <=8'b0;
					Done <= 0;
					DINout <= 0;
					Rin <=8'b0;
					Gin <=0;
					Gout <=0;
					addSub <=0;
					end
		endcase
		end
		2'b10: begin //define signals in time step 2
		IRin <= 0;
		case (I)
					3'b000: begin 
					Ain <= 0 ; 
					Rout <=8'b0;
					Done <= 0;
					DINout <= 0;
					Rin <=8'b0;
					Gin <=0;
					Gout <=0;
					addSub <=0;
					end
					3'b001: begin 
					Ain <= 0 ; 
					Rout <=8'b0;
					Done <= 0;
					DINout <= 0;
					Rin <=8'b0;
					Gin <=0;
					Gout <=0;
					addSub <=0;
					end
					3'b010: begin
					Gin <=1;
					addSub<=1;
					Done <= 0;
					Ain <= 0 ; 
					Rout <=Yreg;
					DINout <= 0;
					Rin <=8'b0;
					Gout <=0;
					end
					3'b011: begin
					Gin <=1;
					addSub<=0;
					Done <= 0;
					Ain <= 0 ; 
					Rout <=Yreg;
					DINout <= 0;
					Rin <=8'b0;
					Gout <=0;
					end
					default:begin 
					Ain <= 0 ; 
					Rout <=8'b0;
					Done <= 0;
					DINout <= 0;
					Rin <=8'b0;
					Gin <=0;
					Gout <=0;
					addSub <=0;
					end
		endcase
		end
		2'b11: begin //define signals in time step 3
		IRin <= 0;
		case (I)
					3'b000: begin 
					Ain <= 0 ; 
					Rout <=8'b0;
					Done <= 0;
					DINout <= 0;
					Rin <=8'b0;
					Gin <=0;
					Gout <=0;
					addSub <=0;
					end
					3'b001: begin 
					Ain <= 0 ; 
					Rout <=8'b0;
					Done <= 0;
					DINout <= 0;
					Rin <=8'b0;
					Gin <=0;
					Gout <=0;
					addSub <=0;
					end
					3'b010: begin
					Gout <=1;
					Rin<= Xreg;
					Done <=1;
					Ain <= 0 ; 
					Rout <=8'b0;
					DINout <= 0;
					Gin <=0;
					addSub <=0;
					end	
					3'b011: begin
					Gout <=1;
					Rin<= Xreg;
					Done <=1;
					Ain <= 0 ; 
					Rout <=8'b0;
					DINout <= 0;
					Gin <=0;
					addSub <=0;
					end
					default:begin 
					Ain <= 0 ; 
					Rout <=8'b0;
					Done <= 0;
					DINout <= 0;
					Rin <=8'b0;
					Gin <=0;
					Gout <=0;
					addSub <=0;
					end
		endcase
		end
		default:begin
					Ain <= 0 ; 
					Rout <=8'b0;
					Done <= 0;
					DINout <= 0;
					Rin <=8'b0;
					Gin <=0;
					Gout <=0;
					addSub <=0;
		end
		endcase
	
end
endmodule



module MUX1(BusWires,Rout,R0,R1,R2,R3,R4,R5,R6,R7,DINout,DIN,G,Gout);
output reg [15:0]BusWires;
input [15:0]R0,R1,R2,R3,R4,R5,R6,R7,DIN,G;
input [7:0]Rout;
input DINout,Gout;

always@(*)begin
case(Rout)
	8'b10000000: BusWires <=R0;
	8'b01000000: BusWires <=R1;
	8'b00100000: BusWires <=R2;
	8'b00010000: BusWires <=R3;
	8'b00001000: BusWires <=R4;
	8'b00000100: BusWires <=R5;
	8'b00000010: BusWires <=R6;
	8'b00000001: BusWires <=R7;
	default: BusWires <= 16'b0;
	endcase
if(DINout)begin
BusWires <=DIN;
end
else if(Gout)begin
BusWires <=G;
end
else BusWires <= 16'b0;
end
endmodule



module upcount(Clear, Clock, Q);
	input Clear, Clock;
	output reg [1:0]Q;
	always @(posedge Clock or negedge Clear)begin
		if (~Clear)begin
			Q <= 2'b0;
			end
		else begin
			Q <= Q+2'b1;
			end
	end
endmodule


module dec3to8(W, En, Y);
	input [2:0]W;
	input En;
	output [0:7] Y;
	reg [0:7] Y;
	always@(W or En)
	begin
		if (En == 1)
			case (W)
			3'b000: Y = 8'b10000000;
			3'b001: Y = 8'b01000000;
			3'b010: Y = 8'b00100000;
			3'b011: Y = 8'b00010000;
			3'b100: Y = 8'b00001000;
			3'b101: Y = 8'b00000100;
			3'b110: Y = 8'b00000010;
			3'b111: Y = 8'b00000001;
			endcase
		else
		Y = 8'b00000000;
	end
endmodule

module regn(R, Rin, Clock, Q);
	parameter n = 16;
	input [n-1:0] R;
	input Rin, Clock;
	output [n-1:0] Q;
	reg [n-1:0] Q;
	always @(posedge Clock)
		if (Rin)
			Q <= R;
endmodule

module AddSub(select,in1,in2,out);
parameter width = 16;
input select;
input [width-1:0] in1;
input [width-1:0] in2;
output reg [width-1:0] out;

always@(*)begin
	if(select)begin
	out = in1 + in2;
	end
	else begin
	out = in1 - in2;
	end
end



endmodule

module sevSegDec(input [3:0]bcd,output reg [6:0] seg);
	always@(bcd) begin
		case (bcd) //case statement
					0 : seg = 7'b1000000;
					1 : seg = 7'b1111001;
					2 : seg = 7'b0100100;
					3 : seg = 7'b0110000;
					4 : seg = 7'b0011001;
					5 : seg = 7'b0010010;
					6 : seg = 7'b0000010;
					7 : seg = 7'b1111000;
					8 : seg = 7'b0000000;
					9 : seg = 7'b0011000;
					default : seg = 7'b1111111; 
		endcase
	end
endmodule



module tb;
 reg [15:0]DIN;
 reg Resetn;
 reg clock;
 reg Run;
 wire Done;
 wire BusWires;
proc proc_1 (DIN, Resetn, clock, Run, Done, BusWires);
//upcount cont (Resetn,clock,Q);
initial begin
	$dumpfile("test.vcd");
	$dumpvars(0, tb);
	#1 DIN = 16'b010111000;Run = 1;Resetn=0;
	#1 clock = 1;Resetn=1;
	#1 clock = 0;
	#1 clock = 1;
	#1 clock = 0;
	#1 clock = 1;
	#1 clock = 0;
	#1 clock = 1;
	#1 clock = 0;
end
endmodule




