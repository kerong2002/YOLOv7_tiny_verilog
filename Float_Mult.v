//2023/04/18 kerong
module Float_Mult(floatA, floatB, ans);
	input [31:0] floatA;
	input [31:0] floatB;
	output reg[31:0] ans;
	
	reg sign;
	reg [7:0] exp;
	reg [23:0] fractionA;
	reg [23:0] fractionB;
	reg [47:0] fraction;
	
	always@(*)begin
		if(!floatA || !floatB)begin
			ans = 32'd0;
			sign = 1'd0;
			fractionA = 24'd0;
			fractionB = 24'd0;
			fraction  = 48'd0;
			exp = 8'd0;
			ans = 32'd0;
		end
		else begin
			/*
				sign
				(-) * (-) = (+)
				(+) * (-) = (-)
				(-) * (+) = (-)
				(+) * (+) = (+)
			*/
			sign = floatA[31] ^ floatB[31];
			
			/*
				127 + 2^(x)
				8'd2 = bias
			*/
			exp = floatA[30:23] + floatB[30:23] - 8'd127 + 8'd2;
			
			/*
				fraction bias
				we need to add one (1.10110)
			*/
			fractionA = {1'b1, floatA[22:0]};
			fractionB = {1'b1, floatB[22:0]};
			fraction = fractionA * fractionB;
			
			//shift
			if(fraction[47]) begin
				fraction = fraction << 1;
				exp = exp - 8'd1;
			end
			else if(fraction[46]) begin
				fraction = fraction << 2;
				exp = exp - 8'd2;
			end
			else if(fraction[45]) begin
				fraction = fraction << 3;
				exp = exp - 8'd3;
			end
			else if(fraction[44]) begin
				fraction = fraction << 4;
				exp = exp - 8'd4;
			end
			else if(fraction[43]) begin
				fraction = fraction << 5;
				exp = exp - 8'd5;
			end
			else if(fraction[42]) begin
				fraction = fraction << 6;
				exp = exp - 8'd6;
			end
			else if(fraction[41]) begin
				fraction = fraction << 7;
				exp = exp - 8'd7;
			end
			else if(fraction[40]) begin
				fraction = fraction << 8;
				exp = exp - 8'd8;
			end
			else if(fraction[39]) begin
				fraction = fraction << 9;
				exp = exp - 8'd9;
			end
			else if(fraction[38]) begin
				fraction = fraction << 10;
				exp = exp - 8'd10;
			end
			else if(fraction[37]) begin
				fraction = fraction << 11;
				exp = exp - 8'd11;
			end
			else if(fraction[36]) begin
				fraction = fraction << 12;
				exp = exp - 8'd12;
			end
			else if(fraction[35]) begin
				fraction = fraction << 13;
				exp = exp - 8'd13;
			end
			else if(fraction[34]) begin
				fraction = fraction << 14;
				exp = exp - 8'd14;
			end
			else if(fraction[33]) begin
				fraction = fraction << 15;
				exp = exp - 8'd15;
			end
			else if(fraction[32]) begin
				fraction = fraction << 16;
				exp = exp - 8'd16;
			end
			else if(fraction[31]) begin
				fraction = fraction << 17;
				exp = exp - 8'd17;
			end
			else if(fraction[30]) begin
				fraction = fraction << 18;
				exp = exp - 8'd18;
			end
			else if(fraction[29]) begin
				fraction = fraction << 19;
				exp = exp - 8'd19;
			end
			else if(fraction[28]) begin
				fraction = fraction << 20;
				exp = exp - 8'd20;
			end
			else if(fraction[27]) begin
				fraction = fraction << 21;
				exp = exp - 8'd21;
			end
			else if(fraction[26]) begin
				fraction = fraction << 22;
				exp = exp - 8'd22;
			end
			else if(fraction[25]) begin
				fraction = fraction << 23;
				exp = exp - 8'd23;
			end
			ans = {sign, exp, fraction[47:25]};
		end
	end
	
endmodule