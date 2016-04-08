
module nanorv32_vic_apbif (/*AUTOARG*/
   // Outputs
   dbgctrl_stepping_r, dbgctrl_bkp0_r, bkpt0_addr_r, bkpt1_addr_r,
   nanorv32_vic_apb_prdata, nanorv32_vic_apb_pready,
   nanorv32_vic_apb_pslverr,
   // Inputs
   apb_nanorv32_vic_psel, apb_nanorv32_vic_paddr,
   apb_nanorv32_vic_penable, apb_nanorv32_vic_pwrite,
   apb_nanorv32_vic_pwdata, clk_apb, rst_apb_n
   );

`include "nanorv32_vic_params.v"
     output dbgctrl_stepping_r; // CPU will stop after each instruction 
  output dbgctrl_bkp0_r; // Breakpoint unit 0 is enabled
  output [31:0]bkpt0_addr_r; // no descprition provided
  output [31:0]bkpt1_addr_r; // no descprition provided


   input  wire        apb_nanorv32_vic_psel;     // Peripheral select

   input  wire [11:0] apb_nanorv32_vic_paddr;    // Address
   input  wire        apb_nanorv32_vic_penable;  // Transfer control
   input  wire        apb_nanorv32_vic_pwrite;   // Write control
   input  wire [31:0] apb_nanorv32_vic_pwdata;   // Write data

   output reg  [31:0] nanorv32_vic_apb_prdata;   // Read data
   output wire        nanorv32_vic_apb_pready;   // Device ready
   output wire        nanorv32_vic_apb_pslverr;  // Device error response

   input clk_apb;
   input rst_apb_n;



   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/

     reg dbgctrl_stepping_r; // CPU will stop after each instruction 
  reg dbgctrl_bkp0_r; // Breakpoint unit 0 is enabled
  reg [31:0]bkpt0_addr_r; // no description provided
  reg [31:0]bkpt1_addr_r; // no description provided



   wire               read_enable;
   wire               write_enable;


   assign  read_enable  = apb_nanorv32_vic_psel & (~apb_nanorv32_vic_pwrite); // assert for whole APB read transfer
   assign  write_enable = apb_nanorv32_vic_psel & (~apb_nanorv32_vic_penable) & apb_nanorv32_vic_pwrite; // assert for 1st cycle of write transfer


   // Register Read
   always@* begin
      nanorv32_vic_apb_prdata = 0;
      case(apb_nanorv32_vic_paddr[10:2])
        
              NRV32_VIC_DBGCTRL_ADDR[11:2]: begin
                nanorv32_vic_apb_prdata[0 +: 1] = dbgctrl_stepping_r;
                nanorv32_vic_apb_prdata[8 +: 1] = dbgctrl_bkp0_r;
              end

              NRV32_VIC_BKPT0_ADDR[11:2]: begin
                nanorv32_vic_apb_prdata[0 +: 32] = bkpt0_addr_r;
              end

              NRV32_VIC_BKPT1_ADDR[11:2]: begin
                nanorv32_vic_apb_prdata[0 +: 32] = bkpt1_addr_r;
              end

        default: begin
           nanorv32_vic_apb_prdata = 0;
        end
      endcase
   end

   assign nanorv32_vic_apb_pready  = 1'b1; //  always ready
   assign nanorv32_vic_apb_pslverr = 1'b0; //  always okay

   // register write
   always @(posedge clk_apb or negedge rst_apb_n) begin
      if(rst_apb_n == 1'b0) begin
                        dbgctrl_stepping_r <=  1'h0;
               dbgctrl_bkp0_r <=  1'h0;
               bkpt0_addr_r <=  32'h0;
               bkpt1_addr_r <=  32'h0;

         /*AUTORESET*/
      end
      else begin
         if(write_enable) begin
            case(apb_nanorv32_vic_paddr[10:2])
              
              NRV32_VIC_DBGCTRL_ADDR[11:2]: begin
               dbgctrl_stepping_r <=  apb_nanorv32_vic_pwdata[0 +: 1];
               dbgctrl_bkp0_r <=  apb_nanorv32_vic_pwdata[8 +: 1];
              end

              NRV32_VIC_BKPT0_ADDR[11:2]: begin
               bkpt0_addr_r <=  apb_nanorv32_vic_pwdata[0 +: 32];
              end

              NRV32_VIC_BKPT1_ADDR[11:2]: begin
               bkpt1_addr_r <=  apb_nanorv32_vic_pwdata[0 +: 32];
              end

            endcase
         end
      end
   end

endmodule // nanorv32_vic_apb
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
