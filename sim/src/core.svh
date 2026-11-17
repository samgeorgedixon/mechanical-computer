`ifndef CORE_SVH
`define CORE_SVH

// Instruction Opcodes
`define INSTR_NOP   0
`define INSTR_MOV   1
`define INSTR_MOVI  2
`define INSTR_LEA   3

// Registers (1 - 15), Expansion Units (16 - 31), 0 (Nothing)
`define R_ZERO  0

`define R_R1    1
`define R_R2    2
`define R_R3    3
`define R_R4    4

`define R_SP    5
`define R_BP    6

`define R_CS    7
`define R_DS    8
`define R_SS    9
`define R_ES    10

`define R_IP    11
`define R_IR    12
`define R_AR    13

`define R_IRQ   14

`define R_XU1   16 // Memory
`define R_XU2   17 // Drive
`define R_XU3   18
`define R_XU4   19

// Flags (flags[index])
`define F_ZERO          0 // Z
`define F_CARRY         1 // C
`define F_SIGN          2 // S

`endif
