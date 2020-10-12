module servant_qf
  (
   output wire/*reg*/ o_uart_tx);

   wire [31:0] dat;
   wire        we;
   wire        stb;
   reg 	       ack;

   reg 	       rst_r;

   wire        i_clk;
   wire        i_rst;
   wire        clk;
   wire        rst;

   parameter memfile = "zephyr_hello.hex";
   parameter memsize = 2048;

   qlal4s3b_cell_macro u_qlal4s3b_cell_macro
     (
      .Sys_Clk0     (i_clk),
      .Sys_Clk0_Rst (i_rst),
      .Sys_Clk1     (),
      .Sys_Clk1_Rst ());

   gclkbuff u_gclkbuff_clock0 (.A(i_clk), .Z(clk));
   gclkbuff u_gclkbuff_reset0 (.A(i_rst), .Z(rst));

   wire        o_uart_tx = q;

   servant
     #(.memfile (memfile),
       .memsize (memsize))
   servant
     (.wb_clk (clk),
      .wb_rst (rst),
      .q      (q));
   /*
   serving
     #(
       .memfile  (memfile),
       .memsize  (memsize),
       .WITH_CSR (0))
   serving
     (
      .i_clk (clk),
      .i_rst (rst_r),
      .i_timer_irq (1'b0),
      .o_wb_adr (),
      .o_wb_dat (dat),
      .o_wb_sel (),
      .o_wb_we  (we),
      .o_wb_stb (stb),
      .i_wb_rdt (32'd0),
      .i_wb_ack (ack));

   always @(posedge clk) begin
      rst_r <= rst;
      ack <= stb & !ack;
      if (we & stb)
	o_uart_tx <= dat[0];
   end
    */
endmodule
