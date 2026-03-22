module rfoutiocell (/*AUTOARG*/
   // Inouts
   PAD,
   // Inputs
   rfout
   );


   inout wire  PAD;
   input wire  rfout;


   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/

   assign PAD = rfout;
   
   
endmodule // rfoutiocell
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
