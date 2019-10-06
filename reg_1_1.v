module reg_1_1 (clk, enable, data_in, data_out);
input clk;
input enable;
parameter DATA_WIDTH = 8;
input [(DATA_WIDTH-1):0] data_in;
output reg [(DATA_WIDTH-1):0] data_out;

    always @ (posedge clk or posedge enable)
    begin
        if(enable)
            data_out <= data_in;
    end
endmodule       // reg 8 bits sem reset
