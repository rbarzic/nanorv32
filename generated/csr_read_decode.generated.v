
        NANORV32_CSR_ADDR_CYCLEH: begin
            csr_core_rdata = cycle_cnt_high;
        end
        NANORV32_CSR_ADDR_INSTRETH: begin
            csr_core_rdata = instret_cnt_high;
        end
        NANORV32_CSR_ADDR_TIMEH: begin
            csr_core_rdata = time_cnt_high;
        end
        NANORV32_CSR_ADDR_TIME: begin
            csr_core_rdata = time_cnt_low;
        end
        NANORV32_CSR_ADDR_INSTRET: begin
            csr_core_rdata = instret_cnt_low;
        end
        NANORV32_CSR_ADDR_CYCLE: begin
            csr_core_rdata = cycle_cnt_low;
        end
