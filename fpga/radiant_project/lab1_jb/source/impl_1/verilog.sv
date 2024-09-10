// Jason Bowman
// jbowman@g.hmc.edu
// 9-2-2024
// Micro Ps Lab 1. This code oscillates an on board LED, demostrates XOR & AND gate logic with on board LEDs, and performs bit wise hexidecimal displays on a 7-segment display.



// top module controlling both onboard and offboard LEDs
module top (
	input logic [3:0] s,
	input logic reset,
	output logic [2:0] led,
	output logic [6:0] seg
);

ONboard_led_control MOD1 (reset, s, led[2:0]);

seven_segment MOD2 (reset, s, seg[6:0]);

endmodule
///////////////////////////////


// MOD1 controlling the on board LEDs to create XOR & AND gates, and oscillation
module ONboard_led_control (
	input logic reset,
	input logic [3:0] s,
    output logic [2:0] led
);
	// initializing variable
	logic int_osc;		
    logic [24:0] counter;
	
	// XOR & AND gate logic based on 's' input
    always_comb begin
		// XOR
        case({s[0], s[1]})
            2'b00: led[0] = 0;
            2'b01: led[0] = 1;
            2'b10: led[0] = 1;
            2'b11: led[0] = 0;
            default: led[0] = 0; // Ensure that led[0] is defined in all cases
        endcase

		// AND
        case({s[2], s[3]})
            2'b00: led[1] = 0;
            2'b01: led[1] = 0;
            2'b10: led[1] = 0;
            2'b11: led[1] = 1;
            default: led[1] = 0; // Ensure that led[1] is defined in all cases
        endcase
    end
	
   // Internal high-speed oscillator for led[2]
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
//////////////////////////////////////


// MOD2 conbtrolling the off board 7 segment display
module seven_segment(
	input logic reset,
	input logic [3:0] s,
	output logic  [6:0] seg
);

	always_comb begin
		// Hexidecimal display based on 4'b 's' input
		case(s)
			4'h0: seg = 7'b0000001;
			4'h1: seg = 7'b1100111;
			4'h2: seg = 7'b0010010;
			4'h3: seg = 7'b1000010;
			4'h4: seg = 7'b1100100;
			4'h5: seg = 7'b1001000;
			4'h6: seg = 7'b0001000;
			4'h7: seg = 7'b1100011;
			4'h8: seg = 7'b0000000;
			4'h9: seg = 7'b1100000;
			4'hA: seg = 7'b0100000;
			4'hB: seg = 7'b0001100;
			4'hC: seg = 7'b0011001;
			4'hD: seg = 7'b0000110;
			4'hE: seg = 7'b0011000;
			4'hF: seg = 7'b0111000;
		
			default: seg = 7'b1111111;
		endcase
		
	end
	
endmodule
