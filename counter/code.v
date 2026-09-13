module counter (
    input  logic clk,
    input  logic reset,
    input  logic enable,
    output logic [3:0] count
);

    always_ff @(posedge clk) begin
        if (reset)
            count <= 0;
        else if (enable)
            count <= count + 1;
    end

    // Assertion inside DUT
    always @(posedge clk) begin
        assert (count <= 15)
        else $error("Counter exceeded 15");
    end

endmodule
module tb;

    logic       clk;
    logic       reset;
    logic       enable;
    logic [3:0] count;

    counter dut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .count(count)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1;
        enable = 0;

        #10;

        reset = 0;
        enable = 1;

        #20;

        enable = 0;

        #20;

        $finish;
    end

endmodule
