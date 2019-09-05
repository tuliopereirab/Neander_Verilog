module mux_2_1 (sel, data_in_1, data_in_2, data_out);
parameter DATA_WIDTH = 8;
input sel;
input [(DATA_WIDTH-1):0] data_in_1, data_in_2;
output [(DATA_WIDTH-1):0] data_out;

assign data_out = sel ?     data_in_1:
                            data_in_2;
endmodule
