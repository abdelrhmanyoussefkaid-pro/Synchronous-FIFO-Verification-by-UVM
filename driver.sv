package fifo_driver_pkg;
import uvm_pkg::*;
import fifo_seq_item_pkg::*;
import fifo_cfg_pkg::*;
`include "uvm_macros.svh"


class fifo_driver extends uvm_driver #(fifo_seq_item);
`uvm_component_utils(fifo_driver)

virtual FIFO_if FIFO_vif;
fifo_seq_item stim_seq_item ;
fifo_config fifo_cfg ;

function new(string name="fifo_driver", uvm_component parent=null);
    super.new(name, parent);
endfunction


function void build_phase (uvm_phase phase ) ;
super.build_phase(phase ) ;
if(!uvm_config_db #(fifo_config):: get(this, "" ,"CFG",fifo_cfg)) begin
`uvm_fatal("build_phase" , "unable to get config")
end
endfunction
function void connect_phase (uvm_phase phase);
super.connect_phase (phase);

FIFO_vif = fifo_cfg.FIFO_vif ;
endfunction


task run_phase(uvm_phase phase);
    super.run_phase(phase);

    forever begin
        stim_seq_item = fifo_seq_item::type_id::create("fifo_seq_item");

        seq_item_port.get_next_item(stim_seq_item);

        FIFO_vif.data_in    = stim_seq_item.data_in;
        FIFO_vif.rst_n      = stim_seq_item.rst_n;
        FIFO_vif.wr_en      = stim_seq_item.wr_en;
        FIFO_vif.rd_en      = stim_seq_item.rd_en;
        @(negedge FIFO_vif.clk);
        seq_item_port.item_done();
       
    end
endtask


endclass


endpackage




 