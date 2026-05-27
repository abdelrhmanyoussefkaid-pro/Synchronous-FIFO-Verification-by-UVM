package fifo_scoreboard_pkg; 

import uvm_pkg::*; 
`include "uvm_macros.svh" 
import fifo_seq_item_pkg::*; 


class fifo_scoreboard extends uvm_scoreboard; 

    `uvm_component_utils(fifo_scoreboard) 

    uvm_analysis_export #(fifo_seq_item) sb_export; 
    uvm_tlm_analysis_fifo #(fifo_seq_item) sb_fifo; 

    fifo_seq_item tr; 

    bit [FIFO_WIDTH-1:0] ref_data_out; 
    bit ref_wr_ack, ref_overflow; 
    bit ref_full, ref_empty, ref_almostfull, ref_almostempty, ref_underflow; 

    bit [FIFO_WIDTH-1:0] ref_mem [$]; 

    int error_cnt = 0; 
    int correct_cnt = 0; 


    function new(string name="fifo_scoreboard", uvm_component parent=null); 
        super.new(name,parent); 
    endfunction 


    function void build_phase(uvm_phase phase); 
        super.build_phase(phase); 
        sb_export = new("sb_export", this); 
        sb_fifo   = new("sb_fifo", this); 
    endfunction 
    

    function void connect_phase(uvm_phase phase); 
        super.connect_phase(phase); 
        sb_export.connect(sb_fifo.analysis_export); 
    endfunction 


    task run_phase(uvm_phase phase); 
        super.run_phase(phase); 

        forever begin 
            sb_fifo.get(tr); 
            ref_model(tr); 
    
            if(tr.data_out != ref_data_out) begin 
                error_cnt++;              
                `uvm_info("run_phase", $sformatf(
                    "error %s , out_ref:%0h , wr_ack_ref:%0b, overflow_ref:%0b, underflow_ref:%0b, full_ref:%0b, empty_ref:%0b, almostfull_ref:%0b, almostempty_ref:%0b", 
                    tr.convert2string(), ref_data_out, ref_wr_ack, ref_overflow, ref_underflow, ref_full, ref_empty, ref_almostfull, ref_almostempty
                ), UVM_MEDIUM); 
            end 
            else begin 
                correct_cnt++; 
            end 
        end 
    endtask 


    task ref_model(fifo_seq_item tr); 

        if(!tr.rst_n) begin 
            ref_wr_ack = 0; 
            ref_overflow = 0; 
            ref_underflow = 0; 
            ref_full = 0; 
            ref_empty = 1; 
            ref_almostempty = 0; 
            ref_almostfull = 0; 
            ref_mem.delete(); 
        end 
        else begin 

            if(tr.wr_en && tr.rd_en && (ref_mem.size()==0 || ref_mem.size()==8)) begin 

                if(ref_mem.size()==0) begin 
                    ref_mem.push_back(tr.data_in); 
                    ref_wr_ack = 1; 
                    ref_overflow = 0; 
                    ref_underflow = 0; 
                end 
                else if(ref_mem.size()==8) begin 
                    ref_data_out = ref_mem.pop_front(); 
                    ref_underflow = 0; 
                    ref_underflow = 0; 
                end 

            end 
            else begin 

                if(tr.wr_en) begin 
                    ref_underflow = 0; 
                    if(ref_mem.size() < 8) begin 
                        ref_mem.push_back(tr.data_in); 
                        ref_wr_ack = 1; 
                        ref_overflow = 0; 
                    end 
                    else begin 
                        ref_wr_ack = 0; 
                        ref_overflow = 1; 
                    end 
                end  

                if(tr.rd_en) begin 
                    ref_overflow = 0; 
                    if(ref_mem.size() != 0) begin 
                        ref_data_out = ref_mem.pop_front(); 
                        ref_underflow = 0; 
                    end 
                    else begin 
                        ref_underflow = 1; 
                    end 
                end 

            end  
        end 


        if(ref_mem.size() == FIFO_DEPTH) 
            ref_full = 1; 
        else 
            ref_full = 0; 


        if(ref_mem.size() == 0) 
            ref_empty = 1; 
        else 
            ref_empty = 0; 


        if(ref_mem.size() == FIFO_DEPTH-1) 
            ref_almostfull = 1; 
        else 
            ref_almostfull = 0; 


        if(ref_mem.size() == 1) 
            ref_almostempty = 1; 
        else 
            ref_almostempty = 0; 

    endtask 


    function void report_phase(uvm_phase phase); 
        super.report_phase(phase); 

        `uvm_info("report_phase", $sformatf("correct: %0d", correct_cnt), UVM_MEDIUM); 
        `uvm_info("report_phase", $sformatf("error: %0d", error_cnt), UVM_MEDIUM); 
    endfunction 

endclass 

endpackage