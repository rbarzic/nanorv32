module cpuctrl (/*AUTOARG*/
   // Outputs
   cpuctrl_apb_prdata, cpuctrl_apb_pready, cpuctrl_apb_pslverr,
   cpuctrl_out_r,
   // Inputs
   apb_cpuctrl_psel, apb_cpuctrl_paddr, apb_cpuctrl_penable,
   apb_cpuctrl_pwrite, apb_cpuctrl_pwdata, clk_apb, rst_apb_n
   );

   parameter CPUCTRL_NUMBER = 16;
   localparam CPUCTRL_MSB = CPUCTRL_NUMBER-1;

   input  wire        apb_cpuctrl_psel;     // Peripheral select

   input  wire [11:0] apb_cpuctrl_paddr;    // Address
   input  wire        apb_cpuctrl_penable;  // Transfer control
   input  wire        apb_cpuctrl_pwrite;   // Write control
   input  wire [31:0] apb_cpuctrl_pwdata;   // Write data

   output wire [31:0] cpuctrl_apb_prdata;   // Read data
   output wire        cpuctrl_apb_pready;   // Device ready
   output wire        cpuctrl_apb_pslverr;  // Device error response


   output [CPUCTRL_MSB:0] cpuctrl_out_r;


   input              clk_apb;
   input              rst_apb_n;



   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/

   reg             [31:0]     read_mux;

   reg [CPUCTRL_MSB:0]        cpuctrl_out_r;


   wire                       read_enable;
   wire                       write_enable;


   assign  read_enable  = apb_cpuctrl_psel & (~apb_cpuctrl_pwrite); // assert for whole APB read transfer
   assign  write_enable = apb_cpuctrl_psel & (~apb_cpuctrl_penable) & apb_cpuctrl_pwrite; // assert for 1st cycle of write transfer


   // Register Read
   always@* begin
      read_mux = 0;
      case(apb_cpuctrl_paddr[3:2])
        2'h0: begin
           read_mux = cpuctrl_out_r;
        end

        default: begin
           read_mux = 0;
        end
      endcase
   end

   // Output read data to APB
   assign cpuctrl_apb_prdata[31: 0] = (read_enable) ? read_mux : {32{1'b0}};
   assign cpuctrl_apb_pready  = 1'b1; //  always ready
   assign cpuctrl_apb_pslverr = 1'b0; //  always okay

   // register write
   always @(posedge clk_apb or negedge rst_apb_n) begin
      if(rst_apb_n == 1'b0) begin
         /*AUTORESET*/
         // Beginning of autoreset for uninitialized flops
         cpuctrl_out_r <= {(1+(CPUCTRL_MSB)){1'b0}};
         // End of automatics
      end
      else begin
         if(write_enable) begin
            case(apb_cpuctrl_paddr[3:2])
              2'h0: begin
                 cpuctrl_out_r <= apb_cpuctrl_pwdata;
              end
              default: begin
              end
            endcase
         end
      end
   end




endmodule // cpuctrl

/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
