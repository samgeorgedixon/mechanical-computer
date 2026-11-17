module MemoryLayer #(
    
    parameter ADDRESS_WIDTH = 8,
    parameter INITIAL_STATE = 0

    )(

    input logic clk, r,

    input logic we, oe,

    inout wire [7:0] bus,
    input logic [ADDRESS_WIDTH:0] addr,
    input logic low_high_e // 0: low, 1: high

    );

    logic [7:0] memory [0:(2**ADDRESS_WIDTH) - 1];

    assign bus = oe ? (!low_high_e ? { memory[addr][3:0] } : memory[addr][7:4]) : 8'd0;

    always @(posedge clk) begin

        if (r) begin
            integer i;
            for (i = 0; i < 2**ADDRESS_WIDTH; i = i + 1) begin
                memory[i] = INITIAL_STATE;
            end
        end else if (we) begin
            if (!low_high_e) begin
                memory[addr][3:0] <= bus;
            end else begin
                memory[addr][7:4] <= bus;
            end
        end

    end

endmodule
