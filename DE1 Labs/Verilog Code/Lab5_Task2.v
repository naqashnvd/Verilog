//module Lab4(input [3:0] SW, output [6:0] HEX0);
//	wire [6:0] invHEX;
//	assign HEX0 = ~invHEX;
//	sevSegDec SD0(SW[2], SW[1], SW[0], invHEX);
//endmodule 



module Lab5_task2(input [3:1]KEY,input CLOCK_50,output [6:0]HEX0,output[6:0]HEX1,output [6:0]HEX2,output[6:0]HEX3  );
			wire [3:0]sFirst;
			wire [3:0]sSecond;
			wire [3:0]mFirst;
			wire [3:0]mSecond;
			wire dclk;
			wire sFlag;
			wire mFlag;
			downClock dc(CLOCK_50 , dclk );
			seconds(KEY[2],dclk,sFirst,sSecond,sFlag);
			sevSegDec SD0(sFirst,HEX0);
			sevSegDec SD1(sSecond,HEX1);
				
			minutes(KEY[2],sFlag,mFirst,mSecond,mFlag);
			sevSegDec SD2(mFirst,HEX2);
			sevSegDec SD3(mSecond,HEX3);	


	
endmodule

module downClock(input clk,output reg downClk);
   integer count = 0;
	always@(posedge clk) begin
		count <= count + 1 ; 
		if(count == 50000000) begin
		count <= 0;
		end
		if(count < 25000000 )begin
			downClk <= 0;
		end
		else begin
		downClk <= 1;
		end
	end
endmodule


module minutes(input clear,clk, output  [3:0]first ,output [3:0]second,output flag);
	
	counter ct1(~flag&clear,clk,first,second);
	compare cp1(first,second,4'd0,4'd6,flag);
	
endmodule


module seconds(input clear,clk, output  [3:0]first ,output [3:0]second,output flag);
	
	
	counter ct1(~flag&clear,clk,first,second);
	compare cp1(first,second,4'd0,4'd6,flag);
	
endmodule


module compare(input [3:0]first,second,firstParm,secondParm,output reg flag);
	always@(first,second)begin
		if(second == secondParm)begin
			if(first == firstParm)begin
				flag <= 1; 
			end
			else
			flag <=0;
		end
		else
		flag <=0;
	end
endmodule



module counter( input clear,clk, output reg [3:0]first ,output reg [3:0]second );
parameter N = 60;
			always@(posedge clk or negedge clear)begin
				if(~clear)begin
				first <= 4'd0;
				second <= 4'd0;
				end
				else begin
				first <= first + 4'd1 ;
					if(first == 4'd9)begin
					second <= second + 4'd1 ;
					first <= 4'd0;
					end
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



