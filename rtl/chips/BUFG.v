module BUFG (/*AUTOARG*/
   // Outputs
   O,
   // Inputs
   I
   );

   output O;
   input  I;


   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/
   wire   O;

   buf B(O,I);


endmodule // BUFG
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
