module stdiocell (/*AUTOARG*/
   // Outputs
   di,
   // Inouts
   PAD,
   // Inputs
   dout, oe, ie, puen, rst
   );

   
   output di;
   input  dout;
   input  oe;
   input  ie;
   input  puen;   
   inout  PAD;
   input  rst;
   

   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/

   assign PAD = oe ? dout : 1'bz;
   assign di = ie ? PAD : 1'b0;


endmodule // stdiocell
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
