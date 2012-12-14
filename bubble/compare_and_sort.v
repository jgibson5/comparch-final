module compare_and_sort(outHigh, outLow, in1, in0);

  parameter WID = 32;
  input [WID - 1:0] in1, in0;
  output[WID - 1:0] outHigh, outLow;
  wire greater10;
  assign greater10 = in1 > in0;
  assign outHigh = (greater10) ? (in1) : (in0);
  assign outLow = (greater10) ? (in0) : (in1);

endmodule
