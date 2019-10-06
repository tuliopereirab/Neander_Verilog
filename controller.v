module controller (clk, reset, incrementaPc_ctrl, mux_sel, cargaRi_in, regPc_ctrl, regRem_ctrl, regAc_ctrl, regRi_ctrl, regNz_ctrl, memWrite_ctrl, regRdm_ctrl, ula_sel, regNz_signal_in);
input [1:0] regNz_signal_in;
input [3:0] cargaRi_in;
input clk, reset;
output mux_sel, regPc_ctrl, regRem_ctrl, regAc_ctrl, regRi_ctrl, regNz_ctrl, memWrite_ctrl, incrementaPc_ctrl;
output [1:0] regRdm_ctrl;
output [2:0] ula_sel;

reg a = 1;
// states
parameter s0 = 0, s1 = 1, s2 = 2, s3 = 3, s4 = 4;
parameter s5 = 5, s6 = 6, s7 = 7, s8 = 8, s9 = 9;
parameter s10 = 10, s11 = 11, s12 = 12, s13 = 13, s14 = 14;
parameter s15 = 15, s16 = 16, s17 = 17, sHLT = 18, sAUX = 19;
reg [4:0] state;

reg mux_sel, regPc_ctrl, regRem_ctrl, regAc_ctrl, regRi_ctrl, regNz_ctrl, memWrite_ctrl, incrementaPc_ctrl;
reg [1:0] regRdm_ctrl;
reg [2:0] ula_sel;

always @ (posedge clk, posedge reset) begin
    if(reset == 1'b1)
        state <= s0;
    else
        case (state)
            s0: if(a)
                    state <= s1;
                else
                    state <= s1;
            s1: if(a)
                        state <= sAUX;
                    else
                        state <= s1;
            sAUX: if(a)
                    state <= s2;
                else
                    state <= s1;
            s2:
                if(cargaRi_in == 4'b0000)
                    state <= s0;
                else if(cargaRi_in == 4'b1010)
                    if(regNz_signal_in == 2'b01)
                        state <= s3;
                    else
                        state <= s6;
                else if(cargaRi_in == 4'b1001)
                    if(regNz_signal_in == 2'b10)
                        state <= s3;
                    else
                        state <= s5;
                else if(cargaRi_in == 4'b0110)
                    state <= s4;
                else if(cargaRi_in == 4'b1111)
                    state <= sHLT;
                else
                    state <= s3;
            s3:
                if(cargaRi_in == 4'b1000)
                    state <= s8;
                else if(cargaRi_in == 4'b1001)
                    state <= s8;
                else if(cargaRi_in == 4'b1010)
                    state <= s8;
                else
                    state <= s7;
            s4: if(a)
                    state <= s0;
                else
                    state <= s1;
            s5:
                if(regNz_signal_in == 2'b10)
                    state <= s8;
                else
                    state <= s0;
            s6:
                if(regNz_signal_in == 2'b01)
                    state <= s8;
                else
                    state <= s0;
            s7: if(a)
                    state <= s9;
                else
                    state <= s1;
            s8: if(a)
                    state <= s10;
                else
                    state <= s1;
            s9: if(a)
                if(cargaRi_in == 4'b0001)
                    state <= s11;
                else
                    state <= s12;
            s10: if(a)
                    state <= s0;
                else
                    state <= s1;
            s11: if(a)
                    state <= s13;
                else
                    state <= s1;
            s12:
                if(cargaRi_in == 4'b0010)
                    state <= s14;
                else if(cargaRi_in == 4'b0011)
                    state <= s15;
                else if(cargaRi_in == 4'b0100)
                    state <= s16;
                else if(cargaRi_in == 4'b0101)
                    state <= s17;
            s13: if(a)
                    state <= s0;
                else
                    state <= s1;
            s14: if(a)
                    state <= s0;
                else
                    state <= s1;
            s15: if(a)
                    state <= s0;
                else
                    state <= s1;
            s16: if(a)
                    state <= s0;
                else
                    state <= s1;
            s17: if(a)
                    state <= s0;
                else
                    state <= s1;
            sHLT: if(a)
                    state<=state;
                else
                    state <= s1;
        endcase
end

always @ (*) begin
    case (state)
        s0: begin
            regAc_ctrl <= 1'b0;
            regNz_ctrl <= 1'b0;
            regPc_ctrl <= 1'b0;
            regRdm_ctrl <= 1'b0;
            regRi_ctrl <= 1'b0;
            incrementaPc_ctrl <= 1'b0;
            ula_sel <=3'b000;
            memWrite_ctrl <= 1'b0;

            mux_sel <= 1'b0;
            regRem_ctrl <= 1'b1;
        end
        s1: begin
            mux_sel <= 1'b0;
            regRem_ctrl <= 1'b0;

            incrementaPc_ctrl <= 1'b1;
            // --
            regAc_ctrl <= 1'b0;
            regNz_ctrl <= 1'b0;
            regPc_ctrl <= 1'b0;
            regRdm_ctrl <= 1'b0;
            regRi_ctrl <= 1'b0;
            ula_sel <=3'b000;
            memWrite_ctrl <= 1'b0;
        end
        s2: begin

            incrementaPc_ctrl <= 1'b0;
            regRi_ctrl <= 1'b0;
            // --
            regAc_ctrl <= 1'b0;
            regNz_ctrl <= 1'b0;
            regPc_ctrl <= 1'b0;
            regRdm_ctrl <= 1'b0;
            ula_sel <=3'b000;
            memWrite_ctrl <= 1'b0;
            mux_sel <= 1'b0;
            regRem_ctrl <= 1'b0;
        end
        s3: begin
            regRi_ctrl <= 1'b0;
            mux_sel <= 1'b0;
            regRem_ctrl <= 1'b1;
            // --
            regAc_ctrl <= 1'b0;
            regNz_ctrl <= 1'b0;
            regPc_ctrl <= 1'b0;
            regRdm_ctrl <= 1'b0;
            incrementaPc_ctrl <= 1'b0;
            ula_sel <=3'b000;
            memWrite_ctrl <= 1'b0;

        end
        s4: begin
            regRi_ctrl <= 1'b0;
            ula_sel <=3'b011;
            regAc_ctrl <= 1'b1;
            regNz_ctrl <= 1'b1;
            // --

            incrementaPc_ctrl <= 1'b0;
            regPc_ctrl <= 1'b0;
            regRdm_ctrl <= 1'b0;
            memWrite_ctrl <= 1'b0;
            mux_sel <= 1'b0;
            regRem_ctrl <= 1'b0;
        end
        s5: begin
            regRi_ctrl <= 1'b0;
            incrementaPc_ctrl <= 1'b1;
            // --

            regAc_ctrl <= 1'b0;
            regNz_ctrl <= 1'b0;
            regPc_ctrl <= 1'b0;
            regRdm_ctrl <= 1'b0;
            ula_sel <=3'b000;
            memWrite_ctrl <= 1'b0;
            mux_sel <= 1'b0;
            regRem_ctrl <= 1'b0;
        end
        s6: begin
            regRi_ctrl <= 1'b0;
            incrementaPc_ctrl <= 1'b1;
            // --

            regAc_ctrl <= 1'b0;
            regNz_ctrl <= 1'b0;
            regPc_ctrl <= 1'b0;
            regRdm_ctrl <= 1'b0;
            ula_sel <=3'b000;
            memWrite_ctrl <= 1'b0;
            mux_sel <= 1'b0;
            regRem_ctrl <= 1'b0;
        end
        s7: begin
            regRem_ctrl <= 1'b0;

            incrementaPc_ctrl <= 1'b1;
            // --
            regRi_ctrl <= 1'b0;
            regAc_ctrl <= 1'b0;
            regNz_ctrl <= 1'b0;
            regPc_ctrl <= 1'b0;
            regRdm_ctrl <= 1'b0;
            ula_sel <=3'b000;
            memWrite_ctrl <= 1'b0;
            mux_sel <= 1'b0;
        end
        s8: begin
            regRem_ctrl <= 1'b0;
            regAc_ctrl <= 1'b0;
            regNz_ctrl <= 1'b0;
            memWrite_ctrl <= 1'b0;
            regPc_ctrl <= 1'b0;

            // --
            incrementaPc_ctrl <= 1'b0;
            regRi_ctrl <= 1'b0;
            regRdm_ctrl <= 1'b0;
            ula_sel <=3'b000;
            mux_sel <= 1'b0;
        end
        s9: begin

            incrementaPc_ctrl <= 1'b0;
            mux_sel <= 1'b1;
            regRem_ctrl <= 1'b1;
            // --
            regRi_ctrl <= 1'b0;
            regAc_ctrl <= 1'b0;
            regNz_ctrl <= 1'b0;
            regPc_ctrl <= 1'b0;
            regRdm_ctrl <= 1'b0;
            ula_sel <=3'b000;
            memWrite_ctrl <= 1'b0;
        end
        s10: begin

            regPc_ctrl <= 1'b1;
            // --
            incrementaPc_ctrl <= 1'b0;
            regRi_ctrl <= 1'b0;
            regAc_ctrl <= 1'b0;
            regNz_ctrl <= 1'b0;
            regRdm_ctrl <= 1'b0;
            ula_sel <=3'b000;
            memWrite_ctrl <= 1'b0;
            mux_sel <= 1'b0;
            regRem_ctrl <= 1'b0;
        end
        s11: begin
            regRem_ctrl <= 1'b0;
            regRdm_ctrl <= 1'b1;
            // --

            incrementaPc_ctrl <= 1'b0;
            regRi_ctrl <= 1'b0;
            regAc_ctrl <= 1'b0;
            regNz_ctrl <= 1'b0;
            regPc_ctrl <= 1'b0;
            ula_sel <= 3'b000;
            memWrite_ctrl <= 1'b0;
            mux_sel <= 1'b0;
        end
        s12: begin
            regRem_ctrl <= 1'b0;

            // --
            incrementaPc_ctrl <= 1'b0;
            regRi_ctrl <= 1'b0;
            regAc_ctrl <= 1'b0;
            regNz_ctrl <= 1'b0;
            regPc_ctrl <= 1'b0;
            regRdm_ctrl <= 1'b0;
            ula_sel <= 3'b000;
            memWrite_ctrl <= 1'b0;
            mux_sel <= 1'b0;
        end
        s13: begin
            regRdm_ctrl <= 1'b0;
            memWrite_ctrl <= 1'b1;
            // --

            incrementaPc_ctrl <= 1'b0;
            regRi_ctrl <= 1'b0;
            regAc_ctrl <= 1'b0;
            regNz_ctrl <= 1'b0;
            regPc_ctrl <= 1'b0;
            ula_sel <=3'b000;
            mux_sel <= 1'b0;
            regRem_ctrl <= 1'b0;
        end
        s14: begin

            ula_sel <= 3'b100;
            regAc_ctrl <= 1'b1;
            regNz_ctrl <= 1'b1;
            // --
            incrementaPc_ctrl <= 1'b0;
            regRi_ctrl <= 1'b0;
            regPc_ctrl <= 1'b0;
            regRdm_ctrl <= 1'b0;
            memWrite_ctrl <= 1'b0;
            mux_sel <= 1'b0;
            regRem_ctrl <= 1'b0;
        end
        s15: begin

            ula_sel <=3'b000;
            regAc_ctrl <= 1'b1;
            regNz_ctrl <= 1'b1;
            // --
            incrementaPc_ctrl <= 1'b0;
            regRi_ctrl <= 1'b0;
            regPc_ctrl <= 1'b0;
            regRdm_ctrl <= 1'b0;
            memWrite_ctrl <= 1'b0;
            mux_sel <= 1'b0;
            regRem_ctrl <= 1'b0;
        end
        s16: begin

            ula_sel <=3'b010;
            regAc_ctrl <= 1'b1;
            regNz_ctrl <= 1'b1;
            // --
            incrementaPc_ctrl <= 1'b0;
            regRi_ctrl <= 1'b0;
            regPc_ctrl <= 1'b0;
            regRdm_ctrl <= 1'b0;
            memWrite_ctrl <= 1'b0;
            mux_sel <= 1'b0;
            regRem_ctrl <= 1'b0;
        end
        s17: begin

            ula_sel <=3'b001;
            regAc_ctrl <= 1'b1;
            regNz_ctrl <= 1'b1;
            // --
            incrementaPc_ctrl <= 1'b0;
            regRi_ctrl <= 1'b0;
            regPc_ctrl <= 1'b0;
            regRdm_ctrl <= 1'b0;
            memWrite_ctrl <= 1'b0;
            mux_sel <= 1'b0;
            regRem_ctrl <= 1'b0;
        end
        sHLT: begin

            regAc_ctrl <= 1'b0;
            regRi_ctrl <= 1'b0;
            // --
            incrementaPc_ctrl <= 1'b0;
            regNz_ctrl <= 1'b0;
            regPc_ctrl <= 1'b0;
            regRdm_ctrl <= 1'b0;
            ula_sel <=3'b000;
            memWrite_ctrl <= 1'b0;
            mux_sel <= 1'b0;
            regRem_ctrl <= 1'b0;
        end
        sAUX: begin

            incrementaPc_ctrl <= 1'b0;
            regRi_ctrl <= 1'b1;
            // --
            regAc_ctrl <= 1'b0;
            regNz_ctrl <= 1'b0;
            regPc_ctrl <= 1'b0;
            regRdm_ctrl <= 1'b0;
            ula_sel <=3'b000;
            memWrite_ctrl <= 1'b0;
            mux_sel <= 1'b0;
            regRem_ctrl <= 1'b0;
        end
    endcase
end

endmodule
