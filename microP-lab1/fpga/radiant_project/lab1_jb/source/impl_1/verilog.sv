module led_control (
    input logic [3:0] s,
	input logic reset,
    output logic [2:0] led
);

	logic int_osc;		//initializing variables
    logic [24:0] counter;
	
	

    always_comb begin
         //Determine LED 0 based on the combination of s[0] and s[1]
        case({s[0], s[1]})
            2'b00: led[0] = 0;
            2'b01: led[0] = 1;
            2'b10: led[0] = 1;
            2'b11: led[0] = 0;
            default: led[0] = 0; // Ensure that led[0] is defined in all cases
        endcase

         //Determine LED 1 based on the combination of s[2] and s[3]
        case({s[2], s[3]})
            2'b00: led[1] = 0;
            2'b01: led[1] = 0;
            2'b10: led[1] = 0;
            2'b11: led[1] = 1;
            default: led[1] = 0; // Ensure that led[1] is defined in all cases
        endcase
    end
	
   // Internal high-speed oscillator
   HSOSC #(.CLKHF_DIV(2'b01)) 
         hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
  
   // Counter
   always_ff @(posedge int_osc) begin
     if(reset == 0)  counter <= 0;
     else            counter <= counter + 1;
   end
  
   // Assign LED output
   assign led[2] = counter[24];

endmodule
