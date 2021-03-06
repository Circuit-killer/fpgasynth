module fpadd_tb ();

reg [31:0] dataa[9:0];
reg [31:0] datab[9:0];
wire [31:0] result;

reg clk = 1;
reg reset;
wire done;

reg [3:0] ind;

reg [31:0] expected[9:0];

fpadd add (
	.clk (clk),
	.reset (reset),
	.dataa (dataa[ind]),
	.datab (datab[ind]),
	.result (result),
	.done (done)
);

always #10000 clk = !clk;

initial begin
	dataa[0] = 32'h3fc00000; // 1.5
	dataa[1] = 32'h3fc00000; // 1.5
	dataa[2] = 32'h3d800000; // .0625
	dataa[3] = 32'h3d800000; // .0625
	dataa[4] = 32'h3fa00000; // 1.25
	dataa[5] = 32'hbfc00000; // -1.5
	dataa[6] = 32'hbf800000; // -1
	dataa[7] = 32'h3f800000; // 1
	dataa[8] = 32'h00000000; // 0
	dataa[9] = 32'h3f851eb8; // 1.04
	datab[0] = 32'h3fa00000; // 1.25
	datab[1] = 32'hbfa00000; // -1.25
	datab[2] = 32'h3f800000; // 1
	datab[3] = 32'h3d800000; // .0625
	datab[4] = 32'hbfc00000; // -1.5
	datab[5] = 32'hbfc00000; // -1.5
	datab[6] = 32'h3f800000; // 1
	datab[7] = 32'hbe000000; // -.125
	datab[8] = 32'h00000000; // 0
	datab[9] = 32'hc048f5c3; // -3.14
	expected[0] = 32'h40300000;
	expected[1] = 32'h3e800000;
	expected[2] = 32'h3f880000;
	expected[3] = 32'h3e000000;
	expected[4] = 32'hbe800000;
	expected[5] = 32'hc0400000;
	expected[6] = 32'h00000000;
	expected[7] = 32'h3f600000;
	expected[8] = 32'h00000000;
	expected[9] = 32'hc0066667;

	for (ind = 0; ind < 10; ind++) begin
		reset = 1;
		#20000 reset = 0;
		#120000 assert(done == 1);
		assert(result == expected[ind]);
	end
end

endmodule
