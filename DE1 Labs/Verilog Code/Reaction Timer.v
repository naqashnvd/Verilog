
//lab5_task3 REACTION TIMER
module Lab5(input [3:1]KEY,input [7:0]SW,input CLOCK_50,output [6:0]HEX0,output[6:0]HEX1,output [6:0]HEX2,output [0:0]LEDR  );
			wire secClk;
			wire msClk;
			wire [7:0] count1;
			wire [9:0] count2;
			wire rFlag;
			wire sFlag;
			
			downClock#(50000000,25000000) dc(CLOCK_50, secClk );
			counter#(8) c1(KEY[1],~rFlag&secClk,count1);
			//display(count1,1,HEX0,HEX1,HEX2);
			compare#(8) cc1(count1,SW,rFlag);
			assign LEDR[0] = rFlag;
			
			p2s(KEY[3],KEY[1],sFlag);
			
			downClock#(50000,25000) dc1(CLOCK_50, msClk );
			counter#(10) c2(KEY[1],~sFlag&rFlag&msClk,count2);
			display#(10)(count2,sFlag,HEX0,HEX1,HEX2);
			
			
			
			

				
	
endmodule

module p2s(key,clear,flag);
input key,clear;
output reg flag;
	always@(posedge key or negedge clear)begin
		if(~clear)begin
		flag <=0;
		end
		else begin
		flag <=1;
		end
	end

endmodule

module compare(in1,in2,flag);
	parameter width = 0;
	input [width-1:0] in1,in2;
	output reg flag;
	always@(*)begin
	if(in1 == in2)begin
				flag <=1;
				end
				else begin
				flag <=0;
				end
	end
endmodule

module display(i,enable,seg0,seg1,seg2);
	parameter width = 0;
	input [width-1:0]i;
	input enable;
	output[6:0]seg0,seg1,seg2;
	
	wire [3:0]fD; 
	wire [3:0]sD;
	wire [3:0]tD;
	
	wire [width-1:0]r;
	wire [width-1:0]temp;
	assign temp = i * enable;
	assign tD = temp/100;
	assign r = temp%100;
	assign sD = r/10;
	assign fD = r%10;
	
	sevSegDec SD0(fD,seg0);
	sevSegDec SD1(sD,seg1);
	sevSegDec SD2(tD,seg2);
	
endmodule






module counter(clear,clk,count);
parameter width = 0;
input clear,clk;
output reg [width-1:0]count;
	always@(posedge clk , negedge clear)begin		
				if(~clear)begin
				count <= 0;
				end
				else begin
				count <= count + 1 ;
				end
	end
endmodule




module downClock(input clk,output reg downClk);
   
	parameter ref1 = 0;
	parameter ref2 = 0;
	integer count = 0;
	
	always@(posedge clk) begin 
		count <= count + 1 ; 
		if(count == ref1) begin
		count <= 0;
		end
		if(count < ref2 )begin
			downClk <= 0;
		end
		else begin
		downClk <= 1;
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



