module ula (sel, data_in_1, data_in_2, data_out, nz_out);
    parameter DATA_WIDTH;
    input [2:0] sel;
    input [(DATA_WIDTH-1):0] data_in_1, data_in_2;
    output [(DATA_WIDTH-1):0] data_out;
    output [1:0] nz_out;

    wire [(DATA_WIDTH-1):0] add, e, ou, negar;
    wire [(DATA_WIDTH-1):0] aux_data;

    assign add = data_in_1 + data_in_2;
    assign e = data_in_1 & data_in_2;
    assign ou = data_in_1 | data_in_2;
    assign negar = ~data_in_1;

    assign aux_data = (sel == 3'b000) ? add :
                      (sel == 3'b001) ? e :
                      (sel == 3'b010) ? ou :
                      (sel == 3'b011) ? negar :
                      data_in_2;
    assign nz_out = (aux_data < 8'b0000_0000) ? 2'b10:
                    (aux_data == 8'b0000_0000) ? 2'b01:
                    2'b00;

    assign data_out = aux_data;
endmodule // ula
