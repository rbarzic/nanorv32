module primitive_clock_start (/*AUTOARG*/
   // Outputs
   Z,
   // Inputs
   A
   );

    input A;
    output Z;

   parameter LIB = "";
   parameter NOT_IMPLEMENTED_IN_FPGA=0;
   

    /*AUTOINPUT*/
    /*AUTOOUTPUT*/

    /*AUTOREG*/
    /*AUTOWIRE*/
    generate // Needed by CVC
        if(LIB == "RTL") begin:rtl
        
            assign Z = A;

        end

        else if(LIB == "NANGATE45") begin:nangate45

        CLKBUF_X2 U_PRIM(
                    .Z(Z),
                    .A(A));
        end
        else if(LIB == "LIB_XILINX7") begin:xilinx7
	   if(NOT_IMPLEMENTED_IN_FPGA) begin
	      assign Z = A;
	   end
	   else begin
              BUFG U_PRIM(
			  .O(Z),
			  .I(A));

	   end
        end      
`ifndef SYNTHESIS      
    else begin
`ifdef DEBUG_PRIMITIVE_LIB_PARAMETER
        initial begin
            #1;	 
            $display("-E- incorrect parameter <%s> for LIB in module ", LIB);
            $finish;
        end
       
`else
        the_LIB_parameter_is_not_correct U_FAIL();

      
`endif      
    end // else: !if(LIB == "GSCLIB045")
`endif //  `ifndef SYNTHESIS


    endgenerate // Needed by CVC

endmodule // primitive_clock_start

/*
Local Variables:
verilog-library-directories:(
"."
)
End:
*/
