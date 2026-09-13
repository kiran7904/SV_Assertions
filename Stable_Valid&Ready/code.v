module design (
    input  logic       clk,
    input  logic       valid,
    input  logic       ready,
    input  logic [7:0] data
);

    // If valid is high and ready is low,
    // data must remain the same in the next cycle.
    assert property (
        @(posedge clk)
        (valid && !ready) |=> $stable(data)
    );

endmodule


module tb;

    logic       clk;
    logic       valid;
    logic       ready;
    logic [7:0] data;

    design dut (
        .clk   (clk),
        .valid (valid),
        .ready (ready),
        .data  (data)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        valid = 0;
        ready = 0;
        data  = 0;

        #10;

        valid = 1;
        ready = 0;
        data  = 8'h55;

        #10;

        // Still waiting → data must remain 55
        data = 8'h55;       // PASS

        #10;

        // Ready becomes 1 → transfer can happen
        ready = 1;

        #10;

        valid = 0;

        #10;
        $finish;
    end

endmodule
