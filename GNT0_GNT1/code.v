module arbiter (
    input  logic clk,
    input  logic gnt1,
    input  logic gnt0
);

    always @(posedge clk) begin
        assert (!(gnt1 && gnt0))
        else $error("gnt1 and gnt0 cannot be high together");
    end

endmodule


module tb;

    logic clk;
    logic gnt1;
    logic gnt0;

    arbiter dut (
        .clk  (clk),
        .gnt1 (gnt1),
        .gnt0 (gnt0)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        gnt1 = 0;
        gnt0 = 0;

        #10;
        gnt1 = 1;
        gnt0 = 0;       // PASS

        #10;
        gnt1 = 0;
        gnt0 = 1;       // PASS

        #10;
        gnt1 = 1;
        gnt0 = 1;       // FAIL

        #10;
        $finish;
    end

endmodule
