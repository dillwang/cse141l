// program counter
// supports both relative and absolute jumps
// use either or both, as desired
module PC #(parameter D=10)(
  input reset,					// synchronous reset
        clk,
        // reljump_en,             // rel. jump enable
        absjump_en,				// abs. jump enable
        jmp_en,
  input       [D-1:0] target,	// how far/where to jump
  output logic[D-1:0] prog_ctr
);

  // LUT with some predefined mappings (example)
  logic [D-1:0] lut [0:15];
  logic [D-1:0] target_modified;

  initial begin
    // Initialize LUT with some example values
    lut[0]  = 10'b0000000001;
    lut[1]  = 10'b0000000010;
    lut[2]  = 10'b0000000100;
    lut[3]  = 10'b0000001000;
    lut[4]  = 10'b0000010000;
    lut[5]  = 10'b0000100000;
    lut[6]  = 10'b0001000000;
    lut[7]  = 10'b0010000000;
    lut[8]  = 10'b0100000000;
    lut[9]  = 10'b1000000000;
    lut[10] = 10'b0000000001;
    lut[11] = 10'b0000000010;
    lut[12] = 10'b0000000100;
    lut[13] = 10'b0000001000;
    lut[14] = 10'b0000010000;
    lut[15] = 10'b0000100000;
  end

  always_ff @(posedge clk) begin
    if(reset)
      prog_ctr <= 'b0;
    else if(absjump_en) begin
      target_modified = lut[target[D-1:D-4]];  // Modify target using LUT
      prog_ctr <= target_modified;
    end else
      prog_ctr <= prog_ctr + 'b1;
  end

endmodule