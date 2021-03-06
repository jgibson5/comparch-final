module bubble (clk);
 
  parameter WID = 32;
  parameter NUM = 32;
  
  reg [WID-1:0] outArray [NUM -1:0]; 
  
  input clk;
  integer i;
  
  initial begin
  outArray[0] = 1000;
  outArray[1] = 999;
  outArray[2] = 998;
  outArray[3] = 997;
  outArray[4] = 996;
  outArray[5] = 995;
  outArray[6] = 994;
  outArray[7] = 993;
  outArray[8] = 992;
  outArray[9] = 991;
  outArray[10] = 990;
  outArray[11] = 989;
  outArray[12] = 988;
  outArray[13] = 987;
  outArray[14] = 986;
  outArray[15] = 985;
  outArray[16] = 984;
  outArray[17] = 983;
  outArray[18] = 982;
  outArray[19] = 981;
  outArray[20] = 980;
  outArray[21] = 979;
  outArray[22] = 978;
  outArray[23] = 977;
  outArray[24] = 976;
  outArray[25] = 975;
  outArray[26] = 974;
  outArray[27] = 973;
  outArray[28] = 972;
  outArray[29] = 971;
  outArray[30] = 970;
  outArray[31] = 969;
end 

  always @(posedge clk) begin
  outArray[1] <= (outArray[1] > outArray[0])?(outArray[1]):(outArray[0]);
  outArray[0] <= (outArray[1] > outArray[0])?(outArray[0]):(outArray[1]);
  outArray[3] <= (outArray[3] > outArray[2])?(outArray[3]):(outArray[2]);
  outArray[2] <= (outArray[3] > outArray[2])?(outArray[2]):(outArray[3]);
  outArray[5] <= (outArray[5] > outArray[4])?(outArray[5]):(outArray[4]);
  outArray[4] <= (outArray[5] > outArray[4])?(outArray[4]):(outArray[5]);
  outArray[7] <= (outArray[7] > outArray[6])?(outArray[7]):(outArray[6]);
  outArray[6] <= (outArray[7] > outArray[6])?(outArray[6]):(outArray[7]);
  outArray[9] <= (outArray[9] > outArray[8])?(outArray[9]):(outArray[8]);
  outArray[8] <= (outArray[9] > outArray[8])?(outArray[8]):(outArray[9]);
  outArray[11] <= (outArray[11] > outArray[10])?(outArray[11]):(outArray[10]);
  outArray[10] <= (outArray[11] > outArray[10])?(outArray[10]):(outArray[11]);
  outArray[13] <= (outArray[13] > outArray[12])?(outArray[13]):(outArray[12]);
  outArray[12] <= (outArray[13] > outArray[12])?(outArray[12]):(outArray[13]);
  outArray[15] <= (outArray[15] > outArray[14])?(outArray[15]):(outArray[14]);
  outArray[14] <= (outArray[15] > outArray[14])?(outArray[14]):(outArray[15]);
  outArray[17] <= (outArray[17] > outArray[16])?(outArray[17]):(outArray[16]);
  outArray[16] <= (outArray[17] > outArray[16])?(outArray[16]):(outArray[17]);
  outArray[19] <= (outArray[19] > outArray[18])?(outArray[19]):(outArray[18]);
  outArray[18] <= (outArray[19] > outArray[18])?(outArray[18]):(outArray[19]);
  outArray[21] <= (outArray[21] > outArray[20])?(outArray[21]):(outArray[20]);
  outArray[20] <= (outArray[21] > outArray[20])?(outArray[20]):(outArray[21]);
  outArray[23] <= (outArray[23] > outArray[22])?(outArray[23]):(outArray[22]);
  outArray[22] <= (outArray[23] > outArray[22])?(outArray[22]):(outArray[23]);
  outArray[25] <= (outArray[25] > outArray[24])?(outArray[25]):(outArray[24]);
  outArray[24] <= (outArray[25] > outArray[24])?(outArray[24]):(outArray[25]);
  outArray[27] <= (outArray[27] > outArray[26])?(outArray[27]):(outArray[26]);
  outArray[26] <= (outArray[27] > outArray[26])?(outArray[26]):(outArray[27]);
  outArray[29] <= (outArray[29] > outArray[28])?(outArray[29]):(outArray[28]);
  outArray[28] <= (outArray[29] > outArray[28])?(outArray[28]):(outArray[29]);
  outArray[31] <= (outArray[31] > outArray[30])?(outArray[31]):(outArray[30]);
  outArray[30] <= (outArray[31] > outArray[30])?(outArray[30]):(outArray[31]);
  end
  
  always @(negedge clk) begin
  outArray[2] <= (outArray[2] > outArray[1])?(outArray[2]):(outArray[1]);
  outArray[1] <= (outArray[2] > outArray[1])?(outArray[1]):(outArray[2]);
  outArray[4] <= (outArray[4] > outArray[3])?(outArray[4]):(outArray[3]);
  outArray[3] <= (outArray[4] > outArray[3])?(outArray[3]):(outArray[4]);
  outArray[6] <= (outArray[6] > outArray[5])?(outArray[6]):(outArray[5]);
  outArray[5] <= (outArray[6] > outArray[5])?(outArray[5]):(outArray[6]);
  outArray[8] <= (outArray[8] > outArray[7])?(outArray[8]):(outArray[7]);
  outArray[7] <= (outArray[8] > outArray[7])?(outArray[7]):(outArray[8]);
  outArray[10] <= (outArray[10] > outArray[9])?(outArray[10]):(outArray[9]);
  outArray[9] <= (outArray[10] > outArray[9])?(outArray[9]):(outArray[10]);
  outArray[12] <= (outArray[12] > outArray[11])?(outArray[12]):(outArray[11]);
  outArray[11] <= (outArray[12] > outArray[11])?(outArray[11]):(outArray[12]);
  outArray[14] <= (outArray[14] > outArray[13])?(outArray[14]):(outArray[13]);
  outArray[13] <= (outArray[14] > outArray[13])?(outArray[13]):(outArray[14]);
  outArray[16] <= (outArray[16] > outArray[15])?(outArray[16]):(outArray[15]);
  outArray[15] <= (outArray[16] > outArray[15])?(outArray[15]):(outArray[16]);
  outArray[18] <= (outArray[18] > outArray[17])?(outArray[18]):(outArray[17]);
  outArray[17] <= (outArray[18] > outArray[17])?(outArray[17]):(outArray[18]);
  outArray[20] <= (outArray[20] > outArray[19])?(outArray[20]):(outArray[19]);
  outArray[19] <= (outArray[20] > outArray[19])?(outArray[19]):(outArray[20]);
  outArray[22] <= (outArray[22] > outArray[21])?(outArray[22]):(outArray[21]);
  outArray[21] <= (outArray[22] > outArray[21])?(outArray[21]):(outArray[22]);
  outArray[24] <= (outArray[24] > outArray[23])?(outArray[24]):(outArray[23]);
  outArray[23] <= (outArray[24] > outArray[23])?(outArray[23]):(outArray[24]);
  outArray[26] <= (outArray[26] > outArray[25])?(outArray[26]):(outArray[25]);
  outArray[25] <= (outArray[26] > outArray[25])?(outArray[25]):(outArray[26]);
  outArray[28] <= (outArray[28] > outArray[27])?(outArray[28]):(outArray[27]);
  outArray[27] <= (outArray[28] > outArray[27])?(outArray[27]):(outArray[28]);
  outArray[30] <= (outArray[30] > outArray[29])?(outArray[30]):(outArray[29]);
  outArray[29] <= (outArray[30] > outArray[29])?(outArray[29]):(outArray[30]);

  end
  
  always @(negedge clk) begin

  end
 
endmodule

module test();

  parameter half_per = 1;
  //parameter WID = 32;
  //parameter NUM = 32;
  //reg [WID-1:0] array [NUM-1:0]; 
  //integer i;
  reg clk;
  //wire [WID -1:0] Out [NUM-1:0]; 
//  integer f;
  always #half_per clk = ~clk;

  initial begin
    //for (i = 0; i < NUM; i=i+1)
      //array[WID*i + NUM -1 : WID*i] = NUM - i;
    //array[WID-1:0] = 'h40; 
    clk = 0;    
    //$dumpfile("simple.vcd");
    //$dumpvars(0, clk, array, Out);
    //$monitor("clk=%5b, array=%5b, Out=%5b", clk, array, Out);
  end

  bubble bub1(clk);
  
  initial begin
    @(posedge clk);    
    @(posedge clk);    
    @(posedge clk);    
    @(posedge clk);
    @(posedge clk);    
    @(posedge clk);    
    @(posedge clk);    
    @(posedge clk);
    @(posedge clk);    
    @(posedge clk);    
    @(posedge clk);    
    @(posedge clk);
    @(posedge clk);    
    @(posedge clk);    
    @(posedge clk);    
    @(posedge clk);
    @(posedge clk);    
    @(posedge clk);    
    @(posedge clk);    
    @(posedge clk);
    @(posedge clk);    
    @(posedge clk);    
    @(posedge clk);    
    @(posedge clk);
    $finish;
  end
endmodule
