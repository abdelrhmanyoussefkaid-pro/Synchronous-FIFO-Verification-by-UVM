import uvm_pkg::*;
`include "uvm_macros.svh"
import fifo_test_pkg::*;

module top();

  bit clk;
  initial begin
    forever 
      #1 clk = ~clk;
  end
  FIFO_if fifoif (clk);

  FIFO DUT  (fifoif);
  
bind FIFO FIFO_sva svas (.fifoif(fifoif));

  initial begin
    uvm_config_db #(virtual FIFO_if)::set (null, "uvm_test_top", "FIFO_if", fifoif);
    run_test("fifo_test");
  end

endmodule
