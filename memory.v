// Quartus II Verilog Template
// Single port RAM with single read/write address

module memory
#(parameter DATA_WIDTH=8, parameter ADDR_WIDTH=6)
(
	input [(DATA_WIDTH-1):0] data_in,
	input [(ADDR_WIDTH-1):0] addr_in,
	input we, clk,
	output [(DATA_WIDTH-1):0] data_out
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

	// Variable to hold the registered read address
	reg [ADDR_WIDTH-1:0] addr_reg;

	always @ (posedge clk)
	begin
		// Write
		if (we)
			ram[addr_in] <= data_in;

		addr_reg <= addr_in;
	end

	// Continuous assignment implies read returns NEW data.
	// This is the natural behavior of the TriMatrix memory
	// blocks in Single Port mode.
	assign data_out = ram[addr_reg];

endmodule
