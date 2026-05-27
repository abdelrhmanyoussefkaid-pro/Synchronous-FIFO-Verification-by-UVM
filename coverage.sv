package fifo_coverage_pkg;

import fifo_seq_item_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class fifo_coverage extends uvm_component;
`uvm_component_utils(fifo_coverage);

uvm_analysis_export #(fifo_seq_item) cov_export;
uvm_tlm_analysis_fifo #(fifo_seq_item) cov_fifo;
fifo_seq_item seq_item_cov;


//coverage group 

covergroup FIFOcg ; 
 
 wr_en_cp: coverpoint seq_item_cov.wr_en;   
 rd_en_cp: coverpoint seq_item_cov.rd_en; 
 full_cp: coverpoint seq_item_cov.full; 
 almostfull_cp: coverpoint seq_item_cov.almostfull; 
 empty_cp: coverpoint seq_item_cov.empty; 
 almostempty_cp: coverpoint seq_item_cov.almostempty; 
 overflow_cp: coverpoint seq_item_cov.overflow; 
 underflow_cp: coverpoint seq_item_cov.underflow; 
 wr_ack_cp: coverpoint seq_item_cov.wr_ack; 
 
//ignored when rd_en =1 with full not important 
full_cross: cross wr_en_cp, rd_en_cp, full_cp{ 
    ignore_bins rd_full = binsof(rd_en_cp)intersect{1} && 
binsof(full_cp)intersect{1}  
;} 
almostfull_cross: cross wr_en_cp, rd_en_cp, almostfull_cp; 
empty_cross: cross wr_en_cp, rd_en_cp, empty_cp; 
almostempty_cross: cross wr_en_cp, rd_en_cp, almostempty_cp; 
 
//ignored when wr_en =0 and overflow =1 not important 
overflow_cross: cross wr_en_cp, rd_en_cp, overflow_cp{ 
    ignore_bins not_wr_overflow = binsof(wr_en_cp)intersect{0} && 
binsof(overflow_cp)intersect{1} 
;} 
 
//ignored when rd_en =0 and underflow =1 not important 
underflow_cross: cross wr_en_cp, rd_en_cp, underflow_cp{ 
    ignore_bins not_rd_overflow = binsof(rd_en_cp)intersect{0} && 
binsof(underflow_cp)intersect{1} 
;} 
 
//ignored when wr_en=0 with wr_ack =1 not important 
wr_ack_cross: cross wr_en_cp, rd_en_cp, wr_ack_cp{ 
    ignore_bins not_wren_wrack = binsof(wr_en_cp)intersect{0} && 
binsof(wr_ack_cp)intersect{1} 
;} 
 
endgroup     
 
function new(string name="fifo_coverage", uvm_component parent);
    super.new(name, parent);
    FIFOcg = new(); 
endfunction
 
function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    cov_export = new("cov_export", this);
    cov_fifo = new("cov_fifo", this);
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    cov_export.connect(cov_fifo.analysis_export);
endfunction

task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
        cov_fifo.get(seq_item_cov);
        FIFOcg.sample();
    end
endtask


endclass


endpackage