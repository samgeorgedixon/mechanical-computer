`ifndef CORE_SVH
`define CORE_SVH

`include "src/indexes.svh"

interface ControlSignals_if;

// Memory
    logic memoryL2_we;              // Layer 2 (I/O...Display)
    logic memoryL1_oe;              // Layer 1 (ROM)
    logic memoryL0_we, memoryL0_oe; // Layer 0 (RAM)
    logic byte_low_high_e;          // [0: low, 1: high]

// Bus Write Enables / Output Enables (bwe, boe)
    logic acc_bwe, acc_boe;
    logic t1_bwe, t1_boe;
    logic mar_bwe;
    logic ip_bwe;
    logic ir_bwe;

    logic flags_we;

// ALU
    logic[3:0] alu_options; // [0: add, 1: 2s compliment for sub, 2: and, 3: xor]

// Ports
    modport control (
        output memoryL2_we,
        output memoryL1_oe,
        output memoryL0_we, memoryL0_oe
        output byte_low_high_e,

        output acc_bwe, acc_boe,
        output mar_bwe, mar_boe,
        output ip_bwe,
        output ir_bwe,

        output flags_we,

        output alu_options
    );

    modport register (
        input acc_bwe, acc_boe
        input mar_bwe, mar_boe

        input ip_bwe
        input ir_bwe

        input flags_we
    );

    modport memory (
        input memoryL2_we,
        input memoryL1_oe,
        input memoryL0_we, memoryL0_oe

        input byte_low_high_e
    );

endinterface

`endif
