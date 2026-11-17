`timescale 1us/100ns

`include "src/core/register.sv"
`include "src/core/control-unit.sv"

/*

Memory Layer 2? (W, display?)
Memory Layer 1? (R, program)
Memory Layer 0  (R-W, general)

REGS
    ACC/R0, R1
    Instruction Pointer (+ inc mechanism)
    Instruction Register
    Flags (minimal)

Units
    Control Unit / IDecoder (mixed with clock mechanism layer)
    ALU
    - ADD, SUB...
    Memory Interface

*/

module Computer(

    input logic clk,
    input logic r

    );

    wire [3:0] bus; // 2/4b

    lgoic [3:0] acc_out, acc_in?;
    lgoic [3:0] ip_out;
    lgoic [3:0] ir_out;
    lgoic [3:0] flags_out;

    logic L = 0; // Tied Low

    MemoryLayer #(8, 0) io(clk, r, we, L, bus, addr?, low_high_e?);    // Layer 2 (I/O...Display)
    MemoryLayer #(8, 0) rom(clk, r, L, oe, bus, addr?, low_high_e?);   // Layer 1 (ROM)
    MemoryLayer #(8, 0) ram(clk, r, we, oe, bus, addr?, low_high_e?);   // Layer 0 (RAM)
    
    Register #(8, 0) acc(clk, r, we?, oe?, bus, acc_out);    // Accumulator
    Register #(8, 0) ip(clk, r, we?, oe?, bus, ip_out);     // Instruction Pointer
    Register #(8, 0) ir(clk, r, we?, oe?, bus, ir_out);     // Instruction Register
    Register #(3, 0) flags(clk, r, we?, oe?, bus, flags_out);  // Flags (0: ZERO, 1: CARRY, 2: SIGN?, 3: OVERFLOW?)

    ControlUnit();
    ALU_4b(r, acc_out, acc_in, bus, flags?, operation?);

endmodule
