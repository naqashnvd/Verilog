//module Lab4(input [3:0] SW, output [6:0] HEX0);
//	wire [6:0] invHEX;
//	assign HEX0 = ~invHEX;
//	sevSegDec SD0(SW[2], SW[1], SW[0], invHEX);
//endmodule 



module Lab5_Task1(input [3:1]KEY,input CLOCK_50,output [6:0]HEX0  );
			
			wire [3:0]Q ;
			wire dclk ;
			downClock dc(CLOCK_50 , dclk );
			counter(.clear(KEY[2]),.clk(dclk),.Q(Q));
			
			sevSegDec SD0(Q,HEX0);
			
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

module counter( input clear,clk, output reg [3:0]Q );
			always@(posedge clk or negedge clear)begin
				if(~clear)begin
				Q <= 4'd0;
				end
				else begin
				Q <= Q + 4'd1 ;
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



