module Register #(
    
    parameter WIDTH = 8,
    parameter INITIAL_STATE = 0

    )(

    input logic clk, r,

    input logic bus_we, bus_oe,

    inout wire [15:0] bus,
    output logic [15:0] data

    );

    assign bus = bus_oe ? data : WIDTH'd0;
    
    always @(posedge clk) begin
        
        if (r) begin
            data <= INITIAL_STATE;
        end else if (bus_we) begin
            data <= bus;
        end

    end

endmodule
