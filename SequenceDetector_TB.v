// ***************Program starts here*************************

module melfsmolp(din, reset, clk, y);
	output reg y;
	input din;
	input clk;
	input reset;
	reg [1:0] cst, nst;
	parameter	S0 = 2'b00,
				S1 = 2'b01,
				S2 = 2'b10,
				S3 = 2'b11;
			  
always @(cst or din)
	begin
		case (cst)
			S0: if (din == 1'b1)
				begin
					nst = S1;
					y=1'b0;
				end
				else
					begin
						nst = cst;
						y=1'b0;
					end
			S1: if (din == 1'b1)
				begin
					nst = S2;
					y=1'b0;
				end
				else	
					begin
						nst = S0;
						y=1'b0;
					end
			S2: if (din == 1'b0)
				begin
					nst = S3;
					y=1'b0;
				end    
				else
					begin
					nst = S2;
					y=1'b0;
				end
			S3: if (din == 1'b1)
				begin
					nst = S1;
					y=1'b1;
				end
				else
				begin
					nst = S0;
					y=1'b0;
				end
		default:nst = S0;
		endcase
	end
	
always@(posedge clk)
	begin
		if (reset)
			cst <= S0;
		else
			cst <= nst;
	end
endmodule 
// ***************Program ends here*************************


module melfsmolp_tb;
	reg y;
	wire din, clk, reset;
	
	melfsmolp m1(din, reset, clk, y);
	
	always #1 clock= ~clock;
	
	initial begin
		reset = 1'b0;
		
		din = 1'b1;
		#50;
		
		din = 1'b1;
		#50;
		
		din = 1'b1;
		#50;
		
		din = 1'b0;
		#50;
	end	
endmodule 