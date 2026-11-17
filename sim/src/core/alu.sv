`include "src/core.svh"

module ALU_4b(

    input r,

    input wire [3:0] acc_get, acc_set, // Only 4b so 2 passes to complete 8b...
    input wire [3:0] b,

    output logic [2:0] flags,

    input logic [2:0] operation

    );

    logic [3:0] res;
    logic [4:0] res_ext;

    assign acc_set = operation != 4'd0 ? res[3:0] : 4'b0;

    always_comb begin

        res = 4'd0;
        res_ext = 5'd0;

        flags[`F_CARRY] = 1'd0;

        /* verilator lint_off CASEINCOMPLETE */
        unique case (operation)
            4'd0: res = 4'd0;
            `ALU_ADD: begin
                res_ext = {1'd0, acc_get} + {1'd0, b};
                res = res_ext[3:0];

                flags[`F_CARRY] = res_ext[4];
            end
            `ALU_SUB: begin
                res_ext = {1'd0, acc_get} - {1'd0, b};
                res = res_ext[3:0];

                flags[`F_CARRY] = res_ext[4]; // 1 -> no borrow, 0 -> borrow
            end
            `ALU_AND:    res = acc_get & b;
            `ALU_XOR:    res = acc_get ^ b;
        endcase
        /* verilator lint_on CASEINCOMPLETE */

        flags[`F_ZERO] = (res == 4'd0);
        flags[`F_SIGN] = res[3];

    end

endmodule
