module RegisterUnit #(
    
    parameter INITIAL_STATE = 0

    )(

    input logic clk, r,

    ControlSignals_if.registers cs,

    inout wire [3:0] bus,

    output logic [3:0] acc_out, acc_in,
    output logic [3:0] t1_out,

    output logic [7:0] mar_out,
    output logic [3:0] mar_in,

    output logic [3:0] ip_out,
    output logic [3:0] ir_out,

    output logic [3:0] flags_alu, flags_out

    );

    logic L = 0;

    Register #(8, 2, 4, INITIAL_STATE) acc     (clk, r, cs.byte_low_high_e, cs.acc_bwe, cs.acc_boe, bus, acc_out); // Accumulator
    Register #(8, 2, 4, INITIAL_STATE) t1      (clk, r, cs.byte_low_high_e, cs.t1_bwe, cs.t1_boe, bus, t1_out);    // Temporary 1
    Register #(8, 2, 8, INITIAL_STATE) mar     (clk, r, cs.byte_low_high_e, cs.mar_bwe, L, mar_in, mar_out);       // Memory Address Register
    Register #(8, 2, 4, INITIAL_STATE) ip      (clk, r, cs.byte_low_high_e, cs.ip_bwe, L, bus, ip_out);            // Instruction Pointer
    Register #(8, 2, 4, INITIAL_STATE) ir      (clk, r, cs.byte_low_high_e, cs.ir_bwe, L, bus, ir_out);            // Instruction Register
    Register #(3, 1, 3, INITIAL_STATE) flags   (clk, r, cs.byte_low_high_e, flags_we, L, flags_alu, flags_out);    // Flags (0: ZERO, 1: CARRY, 2: SIGN?, 3: OVERFLOW?)

endmodules
