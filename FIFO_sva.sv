module FIFO_sva (FIFO_if fifoif);

parameter FIFO_DEPTH = 8;


// RESET CHECK 

property reset_p;
  @(posedge fifoif.clk)
  !fifoif.rst_n |=> 
    (fifoif.wr_ack == 0 &&
     fifoif.overflow == 0 &&
     fifoif.underflow == 0);
endproperty

reset_ap: assert property (reset_p);
reset_cp: cover property (reset_p);



// WRITE ACK CHECK

property wr_ack_p;
  @(posedge fifoif.clk) disable iff (!fifoif.rst_n)
  (!fifoif.full && fifoif.wr_en) |=> fifoif.wr_ack;
endproperty

wr_ack_ap: assert property (wr_ack_p);
wr_ack_cp: cover property (wr_ack_p);



// OVERFLOW CHECK

property overflow_p;
  @(posedge fifoif.clk) disable iff (!fifoif.rst_n)
  (fifoif.full && fifoif.wr_en) |=> fifoif.overflow;
endproperty

overflow_ap: assert property (overflow_p);
overflow_cp: cover property (overflow_p);



// UNDERFLOW CHECK

property underflow_p;
  @(posedge fifoif.clk) disable iff (!fifoif.rst_n)
  (fifoif.empty && fifoif.rd_en) |=> fifoif.underflow;
endproperty

underflow_ap: assert property (underflow_p);
underflow_cp: cover property (underflow_p);



// FULL FLAG CHECK 

property full_flag_p;
  @(posedge fifoif.clk) disable iff (!fifoif.rst_n)
  fifoif.full |-> fifoif.full;
endproperty

full_flag_ap: assert property (full_flag_p);



// EMPTY FLAG CHECK

property empty_flag_p;
  @(posedge fifoif.clk) disable iff (!fifoif.rst_n)
  fifoif.empty |-> fifoif.empty;
endproperty

empty_flag_ap: assert property (empty_flag_p);



// ALMOST FULL CHECK

property almostfull_p;
  @(posedge fifoif.clk) disable iff (!fifoif.rst_n)
  fifoif.almostfull |-> fifoif.almostfull;
endproperty

almostfull_ap: assert property (almostfull_p);



// ALMOST EMPTY CHECK

property almostempty_p;
  @(posedge fifoif.clk) disable iff (!fifoif.rst_n)
  fifoif.almostempty |-> fifoif.almostempty;
endproperty

almostempty_ap: assert property (almostempty_p);



// VALID READ DATA CHECK

property read_valid_p;
  @(posedge fifoif.clk) disable iff (!fifoif.rst_n)
  (fifoif.rd_en && !fifoif.empty) |=> !$isunknown(fifoif.data_out);
endproperty

read_valid_ap: assert property (read_valid_p);



// VALID WRITE CHECK

property write_valid_p;
  @(posedge fifoif.clk) disable iff (!fifoif.rst_n)
  (fifoif.wr_en && !fifoif.full) |=> fifoif.wr_ack;
endproperty

write_valid_ap: assert property (write_valid_p);


endmodule