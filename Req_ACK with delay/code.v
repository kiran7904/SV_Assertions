module handshake (
    input  logic clk,
    input  logic req,
    output logic ack
);

    always_ff @(posedge clk) begin
        ack <= req;
    end

    // Assertion
    assert property (
        @(posedge clk)
        req |-> ##3 ack
    );

endmodule


module tb;

    logic clk;
    logic req;
    logic ack;

    handshake dut (
        .clk(clk),
        .req(req),
        .ack(ack)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        req = 0;

        #10;
        req = 1;

        #10;
        req = 0;

        #20;
        $finish;
    end

endmodule
