`timescale 1us/100ns

`include "src/core/alu.sv"
`include "src/core/memory-layer.sv"
`include "src/core/register.sv"
`include "src/core/control-unit.sv"


/*

Memory Layer 2? (W, display?)
Memory Layer 1? (R, program)
Memory Layer 0  (R-W, general)

REGS
    ACC, T1
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

    ControlSignals_if controlSignals();

// Register Interface
    logic [3:0] acc_out, acc_in?;
    logic [3:0] t1_out;

    logic [7:0] mar_out;
    logic [3:0] mar_in;

    logic [3:0] ip_out;
    logic [3:0] ir_out;

    logic [3:0] flags_alu, flags_out;

// Modules
    Memory3L8W #(0) memory(clk, r, controlSignals, bus, mar_out);
    
    RegisterUnit #(0) registers(clk, r, controlSignals, bus, 
                                acc_out, acc_in?, t1_out, mar_out, mar_in, ip_out, ir_out, flags_alu, flags_out);

    ControlUnit (clk, r, controlSignals);
    ALU_4b      (r, controlSignals, acc_out, acc_in, bus, flags_alu);

endmodule
