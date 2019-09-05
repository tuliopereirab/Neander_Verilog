module controller (clk, mux_sel, regPc_ctrl, regRem_ctrl, regAc_ctrl, regRi_ctrl, regNz_ctrl, memWrite_ctrl, regRdm_ctrl, ula_sel, regNz_signal_in);
input [1:0] regNz_signal_in;
output clk, mux_sel, regPc_ctrl, regRem_ctrl, regAc_ctrl, regRi_ctrl, regNz_ctrl, memWrite_ctrl;
output [1:0] regRdm_ctrl;
output [2:0] ula_sel;

endmodule
