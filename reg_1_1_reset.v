module reg_1_1_reset (clk, reset, enable, data_in, data_out);
parameter DATA_WIDTH = 8;
input reset;
input clk;
input enable;
input [(DATA_WIDTH-1):0] data_in;
output reg [(DATA_WIDTH-1):0] data_out;

    always @ (posedge clk, posedge reset, posedge enable)
    begin
        if(reset)
        begin
            data_out <= 0;
        end
        else if(enable)
        begin
            data_out <= data_in;
        end
    end
endmodule       // reg 8 com reset
