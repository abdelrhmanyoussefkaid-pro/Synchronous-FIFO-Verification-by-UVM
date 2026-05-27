package fifo_test_pkg ;

import fifo_cfg_pkg::*;
import fifo_env_pkg::*;
import uvm_pkg::*;
import fifo_write_seq_pkg::*;
import fifo_read_seq_pkg::*;
import fifo_write_read_seq_pkg::*;
import fifo_reset_seq_pkg::*;
`include "uvm_macros.svh"


class fifo_test extends uvm_test;
`uvm_component_utils(fifo_test)

fifo_env env;
fifo_config fifo_cfg;
fifo_reset_seq reset_seq;
fifo_write_seq write_seq;
fifo_read_seq read_seq;
fifo_write_read_seq write_read_seq;
 virtual FIFO_if FIFO_vif;
function new (string name = "fifo_test", uvm_component parent = null);
  super.new(name, parent);
endfunction

  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    env = fifo_env::type_id::create("env", this);
    fifo_cfg = fifo_config::type_id::create("fifo_cfg");
    reset_seq = fifo_reset_seq::type_id::create("fifo_reset_seq");
    write_seq = fifo_write_seq::type_id::create("fifo_write_seq");
    read_seq = fifo_read_seq::type_id::create("fifo_read_seq");
    write_read_seq = fifo_write_read_seq::type_id::create("fifo_write_read_seq");

    if(!uvm_config_db #(virtual FIFO_if)::get(this, "", "FIFO_if", fifo_cfg.FIFO_vif))
      `uvm_fatal("build phase", "Cannot get the virtual interface");
  
    uvm_config_db #(fifo_config) :: set (this, "*", "CFG", fifo_cfg);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);

    phase.raise_objection(this);
      `uvm_info("run_phase", "reset_seq Asserted", UVM_MEDIUM)
      reset_seq.start(env.agt.sqr);
      `uvm_info("run_phase", "reset_seq deAsserted", UVM_MEDIUM)

      
      `uvm_info("run_phase", "write_seq Asserted", UVM_MEDIUM)
      write_seq.start(env.agt.sqr);
      `uvm_info("run_phase", "write_seq deAsserted", UVM_MEDIUM)

      `uvm_info("run_phase", "read_seq Asserted", UVM_MEDIUM)
      read_seq.start(env.agt.sqr);
      `uvm_info("run_phase", "read_seq deAsserted", UVM_MEDIUM)

      `uvm_info("run_phase", "write_read_seq Asserted", UVM_MEDIUM)
      write_read_seq.start(env.agt.sqr);
      `uvm_info("run_phase", "write_read_seq deAsserted", UVM_MEDIUM)

    phase.drop_objection(this);
  endtask

endclass
  
endpackage