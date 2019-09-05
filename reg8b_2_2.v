module reg8b_2_2 (clk, enable, data_in_1, data_in_2, data_out_1, data_out_2);
parameter DATA_WIDTH = 8;
input clk;
input [1:0] enable;
input [(DATA_WIDTH-1):0] data_in_1, data_in_2;
output reg [(DATA_WIDTH-1):0] data_out_1, data_out_2;

    always @ (posedge clk)
    begin
        if(enable == 2'b01) begin
            data_out_1 = data_in_1;
        end else if(enable == 2'b10) begin
            data_out_2 = data_in_2;
        end
    end
endmodule   // reg 8 bits duplo
