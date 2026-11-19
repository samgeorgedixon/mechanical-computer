module Register #(
    
    parameter WIDTH = 8,
    parameter SEGMENTS = 1, // MAX 2: [1, 2]
    parameter DIRECT_WIDTH = 8, // 0: data out segmented so 4, 1: data out direct width so 8
    parameter INITIAL_STATE = 0

    )(

    input logic clk, r,

    input logic byte_low_high_e,
    input logic bus_we, bus_oe,

    inout wire [WIDTH/SEGMENTS-1:0] bus,
    output logic [DIRECT_WIDTH-1:0] data_direct

    );

    logic [WIDTH-1:0] data;

    assign data_direct = (DIRECT_WIDTH = WIDTH) ? data[WIDTH-1:0] : (!byte_low_high_e ? data[DIRECT_WIDTH-1:0] : data[WIDTH-1:DIRECT_WIDTH-1]);

    assign bus = bus_oe ? (!byte_low_high_e ? { data[3:0] } : data[7:4]) : WIDTH/SEGMENTS'd0;
    
    always @(posedge clk) begin
        
        if (r) begin
            data <= INITIAL_STATE;
        end else if (bus_we) begin
            data <= !byte_low_high_e ? { data[3:0] } : data[7:4];
        end

    end

endmodule
