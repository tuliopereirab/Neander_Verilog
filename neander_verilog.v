module neander_verilog (clk_geral, reset_geral);
parameter DATA_WIDTH_GERAL = 8;
input clk_geral;
input reset_geral;

wire sel_mux, ctrl_regPc, ctrl_regRem, ctrl_regAc, ctrl_regRi, ctrl_regNz, ctrl_memWrite;
wire [1:0] ctrl_regRdm;
wire [2:0] sel_ula;
wire [1:0] regNz_signal_in;

wire [(DATA_WIDTH_GERAL-1):0] regPc_out;
wire [(DATA_WIDTH_GERAL-1):0] regRdm_in_1, regRdm_in_2, regRdm_out_1, regRdm_out_2;
wire [(DATA_WIDTH_GERAL-1):0] regRem_in, regRem_out;
wire [(DATA_WIDTH_GERAL-1):0] regAc_in, regAc_out;
wire [(DATA_WIDTH_GERAL-1):0] regRi_in, regRi_out;
wire [1:0] regNz_in;
wire [(DATA_WIDTH_GERAL-1):0] ula_in_1, ula_in_2, ula_out;


reg_1_1_reset #(.DATA_WIDTH (DATA_WIDTH_GERAL)) regPC  (.clk (clk_geral), .reset (reset_geral), .enable (ctrl_regPc), .data_in (regRdm_out_1), .data_out (regPc_out));
reg_1_1_reset #(.DATA_WIDTH (DATA_WIDTH_GERAL)) regAc (.clk (clk_geral), .reset (reset_geral), .enable (ctrl_regAc), .data_in (regAc_in), .data_out (regAc_out));

reg_1_1 #(.DATA_WIDTH (DATA_WIDTH_GERAL)) regRem (.clk (clk_geral), .enable (ctrl_regRem), .data_in (regRem_in), .data_out (regRem_out));
reg_1_1 #(.DATA_WIDTH (DATA_WIDTH_GERAL)) regRi (.clk (clk_geral), .enable (ctrl_regRi), .data_in (regRi_in), .data_out (regRi_out));
reg_1_1 #(.DATA_WIDTH (2)) regNz (.clk (clk_geral), .enable (ctrl_regNz), .data_in (regNz_in), .data_out (regNz_signal_in));

reg8b_2_2 #(.DATA_WIDTH (DATA_WIDTH_GERAL)) regRdm (.clk (clk_geral), .enable (ctrl_regRdm), .data_in_1 (regRdm_in_1), .data_in_2 (regRdm_in_2), .data_out_1 (regRdm_out_1), .data_out_2 (regRdm_out_2));

ula #(.DATA_WIDTH (DATA_WIDTH_GERAL)) ULA (.sel (sel_ula), .data_in_1 (regAc_out), .data_in_2 (regRdm_out_1), .data_out (regAc_in), .nz_out (regNz_in));
mux_2_1 #(.DATA_WIDTH (DATA_WIDTH_GERAL)) mux (.sel (sel_mux), .data_in_1 (regPc_out), .data_in_2 (regRdm_out_1), .data_out (regRem_in));

memory #(.DATA_WIDTH (DATA_WIDTH_GERAL), .ADDR_WIDTH (DATA_WIDTH_GERAL)) mem (.clk (clk_geral), .we (ctrl_memWrite), .data_in (regRdm_out_2), .data_out (regRdm_in_1), .addr_in (regRem_out));
controller control (.clk (clk_geral), .mux_sel (sel_mux), .regPc_ctrl(ctrl_regPc), .regRem_ctrl(ctrl_regRem), .regAc_ctrl(ctrl_regAc), .regRi_ctrl(ctrl_regRi), .memWrite_ctrl (ctrl_memWrite), .regRdm_ctrl (ctrl_regRdm), .ula_sel (sel_ula), .regNz_ctrl (ctrl_regNz));

endmodule
