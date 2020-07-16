module std_pad (/*AUTOARG*/
   // Outputs
   din,
   // Inouts
   pad,
   // Inputs
   dout, oe, ie
   );

   output wire din;
   input  wire dout;
   input  wire oe;
   input  wire ie;

   inout  wire pad;


   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/
`ifdef FPGA
   assign pad = oe ? dout : 1'bz;
   assign din = ie ? pad : 1'b0;


 `else
    /* stdiocell AUTO_TEMPLATE(
		    .di			(din),
		    .PAD		(pad),
		    .dout		(dout),
		    .oe			(oe),
		    .ie			(ie),
		    .puen		(1'b0),
		    .rst		(1'b0),
     ); */
   stdiocell U_PAD (
			   /*AUTOINST*/
		    // Outputs
		    .di			(din),			 // Templated
		    // Inouts
		    .PAD		(pad),			 // Templated
		    // Inputs
		    .dout		(dout),			 // Templated
		    .oe			(oe),			 // Templated
		    .ie			(ie),			 // Templated
		    .puen		(1'b0),			 // Templated
		    .rst		(1'b0));			 // Templated
   
 `endif  

endmodule // std_pad
/*
 Local Variables:
 verilog-library-directories:(
 "."
  "../../libraries/local/stdiocell/v"
 )
 End:
 */
