module sevSegDec(input c2,c1,c0,output [6:0] y);
	assign y[0] = ~c2&c0;
	assign y[1] = ~c2&~c1&~c0 | ~c2&c1&c0;
	assign y[2] = ~c2&~c1&~c0 | ~c2&c1&c0;
	assign y[3] = ~c2&c0 | ~c2&c1;
	assign y[4] = ~c2;
	assign y[5] = ~c2;
	assign y[6] = ~c2&~c1;
endmodule

module task4(input [2:0] SW, output [6:0] HEX0);
	wire [6:0] invHEX;
	assign HEX0 = ~invHEX;
	sevSegDec SD0(SW[2], SW[1], SW[0], invHEX);
endmodule 