module MemoryLayer #(
    
    parameter ADDRESS_WIDTH = 8,
    parameter INITIAL_STATE = 0

    )(

    input logic clk, r,

    logic we, oe;
    logic byte_low_high_e;

    inout wire [3:0] bus,
    input logic [ADDRESS_WIDTH-1:0] addr,

    );

    logic [7:0] memory [0:(2**ADDRESS_WIDTH) - 1];

    assign bus = oe ? (!byte_low_high_e ? { memory[addr][3:0] } : memory[addr][7:4]) : 8'd0;

    always @(posedge clk) begin

        if (r) begin
            integer i;
            for (i = 0; i < 2**ADDRESS_WIDTH; i = i + 1) begin
                memory[i] = INITIAL_STATE;
            end
        end else if (we) begin
            if (!byte_low_high_e) begin
                memory[addr][3:0] <= bus;
            end else begin
                memory[addr][7:4] <= bus;
            end
        end

    end

endmodule

module Memory3L8W #(
    
    parameter INITIAL_STATE = 0

    )(

    input logic clk, r,

    ControlSignals_if.memory controlSignals,

    inout wire [3:0] bus,
    input logic [7:0] addr,

    );

    logic L = 0;

    MemoryLayer #(8, INITIAL_STATE) io  (clk, r, controlSignals.byte_low_high_e, controlSignals.memoryL2_we, L, bus, addr);                          // Layer 2 (I/O...Display)
    MemoryLayer #(8, INITIAL_STATE) rom (clk, r, controlSignals.byte_low_high_e, L, controlSignals.memoryL1_oe, bus, addr);                          // Layer 1 (ROM)
    MemoryLayer #(8, INITIAL_STATE) ram (clk, r, controlSignals.byte_low_high_e, controlSignals.memoryL0_we, controlSignals.memoryL0_oe, bus, addr); // Layer 0 (RAM)

endmodules
