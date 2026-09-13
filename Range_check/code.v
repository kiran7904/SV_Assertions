module design (
    input logic clk,
    input logic signed [7:0] data
);

    // Assertion
    always @(posedge clk) begin
        assert (data >= -44 && data <= 120)
        else $error("data is outside the allowed range");
    end

endmodule


module tb;

    logic clk;
    logic signed [7:0] data;

    design dut (
        .clk(clk),
        .data(data)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        data = 0;

        #10 data = 50;     // PASS
        #10 data = 120;    // PASS
        #10 data = -44;    // PASS
        #10 data = -45;    // FAIL
        #10 data = 121;    // FAIL

        #10 $finish;
    end

endmodule
