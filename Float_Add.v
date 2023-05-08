//2023/04/19 kerong
module Float_Add(floatA, floatB, ans);
	input[31:0] floatA;
	input[31:0] floatB;
	output reg[31:0] ans;
	
	reg sign;
	reg [7:0] exp;
	reg [7:0] expA;
	reg [7:0] expB;
	reg [23:0] fractionA;
	reg [23:0] fractionB;
	reg [23:0] fraction;
	reg [7:0] shift;
	reg carry;
	
	always@(*)begin
		
		expA = floatA[30:23];
		expB = floatB[30:23];
		fractionA = {1'b1, floatA[22:0]};
		fractionB = {1'b1, floatB[22:0]};
		shift 	= 8'd0;
		exp 		= 8'd0;
		fraction = 8'd0;
		carry 	= 1'd0;
		sign 		= 1'd0;
		// one input is 0 or both of them are 0
		if(!floatA || !floatB)begin
			ans = floatA + floatB;
		end
		else begin
			
			//exp shift
			if(expB > expA)begin
				shift = expB - expA;
				fractionA = fractionA >> shift;
				exp = expB;
			end
			else begin
				shift = expA - expB;
				fractionB = fractionB >> shift;
				exp = expA;
			end
			
			
			//same sign
			if(floatA[31] == floatB[31])begin
				{carry, fraction} = fractionA + fractionB;
				if(carry)begin
					{carry,fraction} = {carry,fraction} >> 1;
					exp = exp + 8'd1;
				end
				sign = floatA[31];
			end
			//not same sign
			else begin
				if(floatA[31])begin
					{carry,fraction} = fractionB - fractionA;
				end
				else begin
					{carry,fraction} = fractionA - fractionB;
				end
				
				
				sign = carry;
				if(carry)begin
					fraction = -fraction;
				end
				
				if(!fraction[23])begin
					if(fraction[22] == 1'b1) begin
						fraction = fraction << 1;
						exp = exp - 8'd1;
					end 
					else if(fraction[21] == 1'b1) begin
						fraction = fraction << 2;
						exp = exp - 8'd2;
					end 
					else if(fraction[20] == 1'b1) begin
						fraction = fraction << 3;
						exp = exp - 8'd3;
					end 
					else if(fraction[19] == 1'b1) begin
						fraction = fraction << 4;
						exp = exp - 8'd4;
					end 
					else if(fraction[18] == 1'b1) begin
						fraction = fraction << 5;
						exp = exp - 8'd5;
					end 
					else if(fraction[17] == 1'b1) begin
						fraction = fraction << 6;
						exp = exp - 8'd6;
					end 
					else if(fraction[16] == 1'b1) begin
						fraction = fraction << 7;
						exp = exp - 8'd7;
					end 
					else if(fraction[15] == 1'b1) begin
						fraction = fraction << 8;
						exp = exp - 8'd8;
					end 
					else if(fraction[14] == 1'b1) begin
						fraction = fraction << 9;
						exp = exp - 8'd9;
					end 
					else if(fraction[13] == 1'b1) begin
						fraction = fraction << 10;
						exp = exp - 8'd10;
					end 
					else if(fraction[12] == 1'b1) begin
						fraction = fraction << 11;
						exp = exp - 8'd11;
					end 
					else if(fraction[11] == 1'b1) begin
						fraction = fraction << 12;
						exp = exp - 8'd12;
					end 
					else if(fraction[10] == 1'b1) begin
						fraction = fraction << 13;
						exp = exp - 8'd13;
					end 
					else if(fraction[9] == 1'b1) begin
						fraction = fraction << 14;
						exp = exp - 8'd14;
					end 
					else if(fraction[8] == 1'b1) begin
						fraction = fraction << 15;
						exp = exp - 8'd15;
					end 
					else if(fraction[7] == 1'b1) begin
						fraction = fraction << 16;
						exp = exp - 8'd16;
					end 
					else if(fraction[6] == 1'b1) begin
						fraction = fraction << 17;
						exp = exp - 8'd17;
					end 
					else if(fraction[5] == 1'b1) begin
						fraction = fraction << 18;
						exp = exp - 8'd18;
					end 
					else if(fraction[4] == 1'b1) begin
						fraction = fraction << 19;
						exp = exp - 8'd19;
					end 
					else if(fraction[3] == 1'b1) begin
						fraction = fraction << 20;
						exp = exp - 8'd20;
					end 
					else if(fraction[2] == 1'b1) begin
						fraction = fraction << 21;
						exp = exp - 8'd21;
					end 
					else if(fraction[1] == 1'b1) begin
						fraction = fraction << 22;
						exp = exp - 8'd22;
					end 
					else if(fraction[0] == 1'b1) begin
						fraction = fraction << 23;
						exp = exp - 8'd23;
					end
				end
			end
			
			ans = {sign, exp , fraction[22:0]};
		end
	end

endmodule