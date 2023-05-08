//2023/05/08 kerong
module Leaky_ReLu(
					in_float,
					coefficient,
					out_float,
				  );

	input[31:0] 	in_float;			//input float number
	input[31:0] 	coefficient;		//aplha
	output reg [31:0]	out_float;		//output float number
	
	
	wire [31:0] product_sum;			//take product_sum
	
	Float_Mult fm1(in_float, coefficient, product_sum);	//product_sum
	
	always@(*)begin
		case(in_float[31])
			1'b0 : out_float = in_float;		//if input float is positive
			1'b1 : out_float = product_sum;		//if input float is negative
		endcase
	end
	
endmodule