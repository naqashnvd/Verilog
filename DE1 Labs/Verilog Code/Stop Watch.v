module toplevel(input CLOCK_50,input [1:1]KEY,output [6:0]HEX0,output [6:0]HEX1,output [6:0]HEX2,output [6:0]HEX3);

wire Q;
downClock dc
(	.clk(CLOCK_50),
	.Q(Q)
);

wire [3:0]count0,count1,count2,count3;
stopWatch sw(
	.clk(Q) , .rstn(KEY[1]) , .enable(1),
	.count0(count0),
	.count1(count1),
	.count2(count2),
	.count3(count3)
) ;

ssDecoder d0(count0,HEX0);
ssDecoder d1(count1,HEX1);
ssDecoder d2(count2,HEX2);
ssDecoder d3(count3,HEX3);

endmodule

module stopWatch(
input clk , rstn , enable,
output reg [3:0]count0,
output reg [3:0]count1,
output reg [3:0]count2,
output reg [3:0]count3
) ;

always @ ( posedge clk or negedge rstn)  begin
  if (!rstn) begin
     count0 <= 4'b0000;
	  count1 <= 4'b0000;
	  count2 <= 4'b0000;
	  count3 <= 4'b0000;
  end 
  else if ( enable ) begin
     if(count0==4'b1001)begin
	  count0<=4'b0000;
	  count1 <= count1 +4'b0001;
			if (count1==4'b0101) begin
				count1 <= 4'b0000;
				count2 <= count2+4'b0001;
				if(count2==4'b1001)
					begin
					count2<=4'b0000;
					count3<=count3+4'b0001;
					if(count3==4'b0101)
							count3<=4'b0000;
               end		
	      end
	 end	
	  else
	   count0<=count0+4'b0001;
   end
end
endmodule

module downClock
#(parameter WIDTH=26)
(	input clk,
	output reg Q
);
	initial begin 
	Q = 0;
	end
	reg [WIDTH-1:0] count;
	always@(posedge clk)
	begin
		count <= count + 1;
			if(count==25000000)begin
				Q <= ~Q;
				count <= 0;
			end
	end
endmodule


module ssDecoder (
	input		[3:0] num,
	output	[6:0] ss
);
	// paste your hexadecimal ssDecoder here
	reg [6:0] _ss;
	always @ (num) begin 
		case (num)
		0: _ss = 7'h3f;
		1: _ss = 7'h06;
		2: _ss = 7'h5b;
		3: _ss = 7'h4f;
		4: _ss = 7'h66;
		5: _ss = 7'h6d;
		6: _ss = 7'h7d;
		7: _ss = 7'h07;
		8: _ss = 7'h7f;
		9: _ss = 7'h67;
		default: _ss = 7'h00;
		endcase
	end
	assign ss = ~_ss;
endmodule 




module topleveltb;
reg clk;
reg rstn;
wire [6:0]HEX0,HEX1,HEX2,HEX3;
toplevel tl(clk,{rstn,clk},HEX0,HEX1,HEX2,HEX3);

integer i;
initial begin 
#0 clk=0;rstn=0;#1 rstn=1;
for(i=0;i<10000;i=i+1)
	#1 clk=~clk ; #1 clk =~clk;

end

endmodule
