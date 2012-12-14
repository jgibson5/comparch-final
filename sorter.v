//This program (written in verilog) sorts a list
//to run, just compile and run the module A_TEST


// define gates with delays
`define AND and #50
`define OR or #50
`define NOT not #50 
`define XOR xor #50
`define XNOR xnor #50

//This module is represents a bit in a single register
//On the rising edge of the clock, the value of bit q is set to input d,
//provided that the write enable is on high.
//q is constantly being output
module D_FF(q,d,e,clk);
  output q;
  input d, e, clk;
  reg q; // Indicate that q is stateholding
  always @(posedge clk)// Hold value except at edge
  if (e)
    q=d;
endmodule

//This module represents a 32 bit register
//on the rising edge of the clock, the value of the register q is set to input d
//provided that the write enable is on high
//q is constantly being output
//both q and d are 32 bits
module D_FF32(q,d,e,clk);
  output [31:0] q;
  input [31:0] d;
  input clk;
  input e;
  D_FF reg_0(q[0],d[0],e,clk);
  D_FF reg_1(q[1],d[1],e,clk);
  D_FF reg_2(q[2],d[2],e,clk);
  D_FF reg_3(q[3],d[3],e,clk);
  D_FF reg_4(q[4],d[4],e,clk);
  D_FF reg_5(q[5],d[5],e,clk);
  D_FF reg_6(q[6],d[6],e,clk);
  D_FF reg_7(q[7],d[7],e,clk);
  D_FF reg_8(q[8],d[8],e,clk);
  D_FF reg_9(q[9],d[9],e,clk);
  D_FF reg_10(q[10],d[10],e,clk);
  D_FF reg_11(q[11],d[11],e,clk);
  D_FF reg_12(q[12],d[12],e,clk);
  D_FF reg_13(q[13],d[13],e,clk);
  D_FF reg_14(q[14],d[14],e,clk);
  D_FF reg_15(q[15],d[15],e,clk);
  D_FF reg_16(q[16],d[16],e,clk);
  D_FF reg_17(q[17],d[17],e,clk);
  D_FF reg_18(q[18],d[18],e,clk);
  D_FF reg_19(q[19],d[19],e,clk);
  D_FF reg_20(q[20],d[20],e,clk);
  D_FF reg_21(q[21],d[21],e,clk);
  D_FF reg_22(q[22],d[22],e,clk);
  D_FF reg_23(q[23],d[23],e,clk);
  D_FF reg_24(q[24],d[24],e,clk);
  D_FF reg_25(q[25],d[25],e,clk);
  D_FF reg_26(q[26],d[26],e,clk);
  D_FF reg_27(q[27],d[27],e,clk);
  D_FF reg_28(q[28],d[28],e,clk);
  D_FF reg_29(q[29],d[29],e,clk);
  D_FF reg_30(q[30],d[30],e,clk);
  D_FF reg_31(q[31],d[31],e,clk);
endmodule



//compares a and b
//c is true if a>b
//c is false otherwise
module greater_than(c,a,b);
  output c;
  input a;
  input b;
  wire temp1;
  wire temp2;
  
  //a>b if and only if a=1 and b=0
  
  //check to see if a is 1
  `XNOR(temp1,a,1);
  
  //check to see if b is 0
  `XNOR(temp2,b,0);
  
  //makes sure that a==1 and b==0
  `AND(c,temp1,temp2);

endmodule

//compares a and b
//c is true if a>=b
//c is false otherwise
module greater_than_or_equal_to(c,a,b);
  output c;
  input a;
  input b;
  
  //a>=b if a=1 or if b=0
  
  //check to see if a is 1
  `XNOR(temp1,a,1);
  
  //check to see if b is 0
  `XNOR(temp2,b,0);
  
  //makes sure that a==1 or b==0
  `OR(c,temp1,temp2);  
endmodule

//compares a and b
//c is true if a==b
//c is false otherwise
module equal_to(c,a,b);
  output c;
  input a;
  input b;
  
  `XNOR(c,a,b);
endmodule


//this module is a single unit of the compare module
//It is used to determine whether or not A>=B
//a and b are single bits in A and B respectively
module comparison_unit(ge_out,e_out,a,b,ge_in,e_in);
  
  //ge_out is 1 if A>=B up to the bits of A and B that we have checked
  //ge_out returns false otherwise
  output ge_out;
  
  //e_out returns true if A==B up to the bits of A and B that we have checked
  //e_out returns false otherwise
  output e_out;
  
  //a is the current bit of a we are looking out
  input a;
  
  //b is the current bit of b we are looking at
  input b;
  
  //ge_in is true if A>=B up to the bits of A and B checked before a and b
  //ge_in is false otherwise
  input ge_in;
  
  //e_in is true if A==B up to the bits of A and B checkced before a and b
  //e_in is false otherwise
  input e_in;
  
  //aeb is true iff a==b
  //false otherwise
  wire aeb;
  
  equal_to et1(aeb,a,b);

  //e_out is true iff aeb and e_in are true
  `AND(e_out,e_in,aeb);
  
  //ageb is true if a>=b
  //false otherwise
  wire ageb;
  
  greater_than_or_equal_to gtet1(ageb,a,b);
  
  //ne is true iff a!=b
  wire ne;
  
  `NOT(ne,e_in);
  
  
  //g is true iff A>B up to the point before a and b
  wire g;
  
  //that is to say if a>=b and a!=b, then a>b
  `AND(g,ne,ge_in);
  
  //temp1 is true if A>=B up to the point before a and b, and a>=b
  wire temp1;
  
  `AND(temp1,ageb,ge_in);
  
  //if A>B then it doesn't matter if a>=b. if A=B, then it does matter, so check for that
  `OR(ge_out,g,temp1);
  
endmodule

//compares 32 bit numbers a and b to see if a>=b
//returns true if a>=b, false otherwise
module compare(c,a,b);
  input [31:0] a;
  input [31:0] b;
  output c;
  wire [31:0] ge;
  wire [31:0] e;

  //does a comparison chain to determine if a>=b
  comparison_unit c_unit31(ge[31],e[31],a[31],b[31],1,1);  
  comparison_unit c_unit30(ge[30],e[30],a[30],b[30],ge[31],e[31]);
  comparison_unit c_unit29(ge[29],e[29],a[29],b[29],ge[30],e[30]);
  comparison_unit c_unit28(ge[28],e[28],a[28],b[28],ge[29],e[29]);
  comparison_unit c_unit27(ge[27],e[27],a[27],b[27],ge[28],e[28]);
  comparison_unit c_unit26(ge[26],e[26],a[26],b[26],ge[27],e[27]);
  comparison_unit c_unit25(ge[25],e[25],a[25],b[25],ge[26],e[26]);
  comparison_unit c_unit24(ge[24],e[24],a[24],b[24],ge[25],e[25]);
  comparison_unit c_unit23(ge[23],e[23],a[23],b[23],ge[24],e[24]);
  comparison_unit c_unit22(ge[22],e[22],a[22],b[22],ge[23],e[23]);
  comparison_unit c_unit21(ge[21],e[21],a[21],b[21],ge[22],e[22]);
  comparison_unit c_unit20(ge[20],e[20],a[20],b[20],ge[21],e[21]);
  comparison_unit c_unit19(ge[19],e[19],a[19],b[19],ge[20],e[20]);
  comparison_unit c_unit18(ge[18],e[18],a[18],b[18],ge[19],e[19]);
  comparison_unit c_unit17(ge[17],e[17],a[17],b[17],ge[18],e[18]);
  comparison_unit c_unit16(ge[16],e[16],a[16],b[16],ge[17],e[17]);
  comparison_unit c_unit15(ge[15],e[15],a[15],b[15],ge[16],e[16]);
  comparison_unit c_unit14(ge[14],e[14],a[14],b[14],ge[15],e[15]);
  comparison_unit c_unit13(ge[13],e[13],a[13],b[13],ge[14],e[14]);
  comparison_unit c_unit12(ge[12],e[12],a[12],b[12],ge[13],e[13]);
  comparison_unit c_unit11(ge[11],e[11],a[11],b[11],ge[12],e[12]);
  comparison_unit c_unit10(ge[10],e[10],a[10],b[10],ge[11],e[11]);
  comparison_unit c_unit9(ge[9],e[9],a[9],b[9],ge[10],e[10]);
  comparison_unit c_unit8(ge[8],e[8],a[8],b[8],ge[9],e[9]);
  comparison_unit c_unit7(ge[7],e[7],a[7],b[7],ge[8],e[8]);
  comparison_unit c_unit6(ge[6],e[6],a[6],b[6],ge[7],e[7]);
  comparison_unit c_unit5(ge[5],e[5],a[5],b[5],ge[6],e[6]);
  comparison_unit c_unit4(ge[4],e[4],a[4],b[4],ge[5],e[5]);
  comparison_unit c_unit3(ge[3],e[3],a[3],b[3],ge[4],e[4]);
  comparison_unit c_unit2(ge[2],e[2],a[2],b[2],ge[3],e[3]);
  comparison_unit c_unit1(ge[1],e[1],a[1],b[1],ge[2],e[2]);
  comparison_unit c_unit0(c,e[0],a[0],b[0],ge[1],e[1]);
  
endmodule

//compares 32 bit numbers a_in and b_in
//if a_in>=b_in, then a_out=b_in and b_out=a_in
//if a_in<b_in, then a_out=a_in and b_out=b_in
module compare_and_switch(a_out,b_out,a_in,b_in);
  
  //input values
  input [31:0] a_in;
  input [31:0] b_in;
  
  //output values
  output [31:0] a_out;
  output [31:0] b_out;
  
  //this is true if a_in>=b_in, false otherwise
  wire c;
  
  compare my_comparison(c,a_in,b_in);
  
  
  //flips each bit of a and b if c is true, otherwise doesn't flip
  bit_flip bf0(a_out[0],b_out[0],a_in[0],b_in[0],c);
  bit_flip bf1(a_out[1],b_out[1],a_in[1],b_in[1],c);
  bit_flip bf2(a_out[2],b_out[2],a_in[2],b_in[2],c);
  bit_flip bf3(a_out[3],b_out[3],a_in[3],b_in[3],c);
  bit_flip bf4(a_out[4],b_out[4],a_in[4],b_in[4],c);
  bit_flip bf5(a_out[5],b_out[5],a_in[5],b_in[5],c);
  bit_flip bf6(a_out[6],b_out[6],a_in[6],b_in[6],c);
  bit_flip bf7(a_out[7],b_out[7],a_in[7],b_in[7],c);
  bit_flip bf8(a_out[8],b_out[8],a_in[8],b_in[8],c);
  bit_flip bf9(a_out[9],b_out[9],a_in[9],b_in[9],c);
  bit_flip bf10(a_out[10],b_out[10],a_in[10],b_in[10],c);
  bit_flip bf11(a_out[11],b_out[11],a_in[11],b_in[11],c);
  bit_flip bf12(a_out[12],b_out[12],a_in[12],b_in[12],c);
  bit_flip bf13(a_out[13],b_out[13],a_in[13],b_in[13],c);
  bit_flip bf14(a_out[14],b_out[14],a_in[14],b_in[14],c);
  bit_flip bf15(a_out[15],b_out[15],a_in[15],b_in[15],c);
  bit_flip bf16(a_out[16],b_out[16],a_in[16],b_in[16],c);
  bit_flip bf17(a_out[17],b_out[17],a_in[17],b_in[17],c);
  bit_flip bf18(a_out[18],b_out[18],a_in[18],b_in[18],c);
  bit_flip bf19(a_out[19],b_out[19],a_in[19],b_in[19],c);
  bit_flip bf20(a_out[20],b_out[20],a_in[20],b_in[20],c);
  bit_flip bf21(a_out[21],b_out[21],a_in[21],b_in[21],c);
  bit_flip bf22(a_out[22],b_out[22],a_in[22],b_in[22],c);
  bit_flip bf23(a_out[23],b_out[23],a_in[23],b_in[23],c);
  bit_flip bf24(a_out[24],b_out[24],a_in[24],b_in[24],c);
  bit_flip bf25(a_out[25],b_out[25],a_in[25],b_in[25],c);
  bit_flip bf26(a_out[26],b_out[26],a_in[26],b_in[26],c);
  bit_flip bf27(a_out[27],b_out[27],a_in[27],b_in[27],c);
  bit_flip bf28(a_out[28],b_out[28],a_in[28],b_in[28],c);
  bit_flip bf29(a_out[29],b_out[29],a_in[29],b_in[29],c);
  bit_flip bf30(a_out[30],b_out[30],a_in[30],b_in[30],c);
  bit_flip bf31(a_out[31],b_out[31],a_in[31],b_in[31],c);
  
  
endmodule

//flips two inputs if the switch is on
//if c is true, then a_out=b_in and b_out=a_in
//if c is false, then a_out=a_in and b_out=b_in
module bit_flip(a_out,b_out,a_in,b_in,c);
  input a_in;
  input b_in;
  input c;
  output a_out;
  output b_out;
  
  //nc is the opposite of c
  wire nc;
  `NOT(nc,c);
  
  //temp1=a_in if c, 0 otherwise
  wire temp1;
  `AND(temp1,c,a_in);

  //temp2=b_in if c, 0 otherwise
  wire temp2;
  `AND(temp2,c,b_in);
  
  //temp3=a_in if nc, 0 otherwise
  wire temp3;
  `AND(temp3,nc,a_in);
  
  //temp4=a_in if c, 0 otherwise
  wire temp4;
  `AND(temp4,nc,b_in);
  
  //if c, a_out=b_in, if nc, a_out=a_in
  `OR(a_out,temp2,temp3);
  
  //if c, b_out=a_in, if nc, b_out=b_in
  `OR(b_out,temp1,temp4);
  
endmodule

//if s is true, return b
//if s is false, return a

module MUX_32(out, a, b, s);
output [31:0] out;
input [31:0] a;
input [31:0] b;
input s;

wire ns;
wire [31:0] tempA;
wire [31:0] tempB;

`NOT find_ns(ns,s); 

  `AND a0(tempA[0],a[0],ns);
  `AND a1(tempA[1],a[1],ns);
  `AND a2(tempA[2],a[2],ns);
  `AND a3(tempA[3],a[3],ns);
  `AND a4(tempA[4],a[4],ns);
  `AND a5(tempA[5],a[5],ns);
  `AND a6(tempA[6],a[6],ns);
  `AND a7(tempA[7],a[7],ns);
  `AND a8(tempA[8],a[8],ns);
  `AND a9(tempA[9],a[9],ns);
  `AND a10(tempA[10],a[10],ns);
  `AND a11(tempA[11],a[11],ns);
  `AND a12(tempA[12],a[12],ns);
  `AND a13(tempA[13],a[13],ns);
  `AND a14(tempA[14],a[14],ns);
  `AND a15(tempA[15],a[15],ns);
  `AND a16(tempA[16],a[16],ns);
  `AND a17(tempA[17],a[17],ns);
  `AND a18(tempA[18],a[18],ns);
  `AND a19(tempA[19],a[19],ns);
  `AND a20(tempA[20],a[20],ns);
  `AND a21(tempA[21],a[21],ns);
  `AND a22(tempA[22],a[22],ns);
  `AND a23(tempA[23],a[23],ns);
  `AND a24(tempA[24],a[24],ns);
  `AND a25(tempA[25],a[25],ns);
  `AND a26(tempA[26],a[26],ns);
  `AND a27(tempA[27],a[27],ns);
  `AND a28(tempA[28],a[28],ns);
  `AND a29(tempA[29],a[29],ns);
  `AND a30(tempA[30],a[30],ns);
  `AND a31(tempA[31],a[31],ns);
  
  
  `AND b0(tempB[0],b[0],s);
  `AND b1(tempB[1],b[1],s);
  `AND b2(tempB[2],b[2],s);
  `AND b3(tempB[3],b[3],s);
  `AND b4(tempB[4],b[4],s);
  `AND b5(tempB[5],b[5],s);
  `AND b6(tempB[6],b[6],s);
  `AND b7(tempB[7],b[7],s);
  `AND b8(tempB[8],b[8],s);
  `AND b9(tempB[9],b[9],s);
  `AND b10(tempB[10],b[10],s);
  `AND b11(tempB[11],b[11],s);
  `AND b12(tempB[12],b[12],s);
  `AND b13(tempB[13],b[13],s);
  `AND b14(tempB[14],b[14],s);
  `AND b15(tempB[15],b[15],s);
  `AND b16(tempB[16],b[16],s);
  `AND b17(tempB[17],b[17],s);
  `AND b18(tempB[18],b[18],s);
  `AND b19(tempB[19],b[19],s);
  `AND b20(tempB[20],b[20],s);
  `AND b21(tempB[21],b[21],s);
  `AND b22(tempB[22],b[22],s);
  `AND b23(tempB[23],b[23],s);
  `AND b24(tempB[24],b[24],s);
  `AND b25(tempB[25],b[25],s);
  `AND b26(tempB[26],b[26],s);
  `AND b27(tempB[27],b[27],s);
  `AND b28(tempB[28],b[28],s);
  `AND b29(tempB[29],b[29],s);
  `AND b30(tempB[30],b[30],s);
  `AND b31(tempB[31],b[31],s);
  
  
  `OR o0(out[0],tempA[0],tempB[0]);
  `OR o1(out[1],tempA[1],tempB[1]);
  `OR o2(out[2],tempA[2],tempB[2]);
  `OR o3(out[3],tempA[3],tempB[3]);
  `OR o4(out[4],tempA[4],tempB[4]);
  `OR o5(out[5],tempA[5],tempB[5]);
  `OR o6(out[6],tempA[6],tempB[6]);
  `OR o7(out[7],tempA[7],tempB[7]);
  `OR o8(out[8],tempA[8],tempB[8]);
  `OR o9(out[9],tempA[9],tempB[9]);
  `OR o10(out[10],tempA[10],tempB[10]);
  `OR o11(out[11],tempA[11],tempB[11]);
  `OR o12(out[12],tempA[12],tempB[12]);
  `OR o13(out[13],tempA[13],tempB[13]);
  `OR o14(out[14],tempA[14],tempB[14]);
  `OR o15(out[15],tempA[15],tempB[15]);
  `OR o16(out[16],tempA[16],tempB[16]);
  `OR o17(out[17],tempA[17],tempB[17]);
  `OR o18(out[18],tempA[18],tempB[18]);
  `OR o19(out[19],tempA[19],tempB[19]);
  `OR o20(out[20],tempA[20],tempB[20]);
  `OR o21(out[21],tempA[21],tempB[21]);
  `OR o22(out[22],tempA[22],tempB[22]);
  `OR o23(out[23],tempA[23],tempB[23]);
  `OR o24(out[24],tempA[24],tempB[24]);
  `OR o25(out[25],tempA[25],tempB[25]);
  `OR o26(out[26],tempA[26],tempB[26]);
  `OR o27(out[27],tempA[27],tempB[27]);
  `OR o28(out[28],tempA[28],tempB[28]);
  `OR o29(out[29],tempA[29],tempB[29]);
  `OR o30(out[30],tempA[30],tempB[30]);
  `OR o31(out[31],tempA[31],tempB[31]);

endmodule

module list_sorter(clk,e,s,Input_list,Output_list);
  input clk;
  input e;
  input s;
  input [351:0] Input_list;
  output [351:0] Output_list;
  
  //Input_list reformatted
  wire [31:0] Input_wire [10:0];
  assign  {Input_wire[0],Input_wire[1],Input_wire[2],Input_wire[3],Input_wire[4],Input_wire[5],Input_wire[6],Input_wire[7],Input_wire[8],Input_wire[9],Input_wire[10]}=Input_list;
  

    
  wire [31:0] q1 [10:0];
  wire [31:0] q2 [10:0];
  wire [31:0] i1 [10:0];
  wire [31:0] i2 [10:0];
  wire [31:0] d1 [10:0];
  wire [31:0] d2 [10:0];
  
  assign Output_list={q1[0],q1[1],q1[2],q1[3],q1[4],q1[5],q1[6],q1[7],q1[8],q1[9],q1[10]};
  
  MUX_32 ma0(i1[0],d1[0], Input_wire[0], s);
  MUX_32 ma1(i1[1],d1[1], Input_wire[1], s);
  MUX_32 ma2(i1[2],d1[2], Input_wire[2], s);
  MUX_32 ma3(i1[3],d1[3], Input_wire[3], s);
  MUX_32 ma4(i1[4],d1[4], Input_wire[4], s);
  MUX_32 ma5(i1[5],d1[5], Input_wire[5], s);
  MUX_32 ma6(i1[6],d1[6], Input_wire[6], s);
  MUX_32 ma7(i1[7],d1[7], Input_wire[7], s);
  MUX_32 ma8(i1[8],d1[8], Input_wire[8], s);
  MUX_32 ma9(i1[9],d1[9], Input_wire[9], s);
  MUX_32 ma10(i1[10],d1[10], Input_wire[10], s);

  MUX_32 mb0(i2[0],d2[0], Input_wire[0], s);
  MUX_32 mb1(i2[1],d2[1], Input_wire[1], s);
  MUX_32 mb2(i2[2],d2[2], Input_wire[2], s);
  MUX_32 mb3(i2[3],d2[3], Input_wire[3], s);
  MUX_32 mb4(i2[4],d2[4], Input_wire[4], s);
  MUX_32 mb5(i2[5],d2[5], Input_wire[5], s);
  MUX_32 mb6(i2[6],d2[6], Input_wire[6], s);
  MUX_32 mb7(i2[7],d2[7], Input_wire[7], s);
  MUX_32 mb8(i2[8],d2[8], Input_wire[8], s);
  MUX_32 mb9(i2[9],d2[9], Input_wire[9], s);
  MUX_32 mb10(i2[10],d2[10], Input_wire[10], s);
  
  D_FF32 ra0(q1[0],i1[0],e,clk);
  D_FF32 ra1(q1[1],i1[1],e,clk);
  D_FF32 ra2(q1[2],i1[2],e,clk);
  D_FF32 ra3(q1[3],i1[3],e,clk);
  D_FF32 ra4(q1[4],i1[4],e,clk);
  D_FF32 ra5(q1[5],i1[5],e,clk);
  D_FF32 ra6(q1[6],i1[6],e,clk);
  D_FF32 ra7(q1[7],i1[7],e,clk);
  D_FF32 ra8(q1[8],i1[8],e,clk);
  D_FF32 ra9(q1[9],i1[9],e,clk);
  D_FF32 ra10(q1[10],i1[10],e,clk);
  
  D_FF32 rb0(q2[0],i2[0],e,clk);
  D_FF32 rb1(q2[1],i2[1],e,clk);
  D_FF32 rb2(q2[2],i2[2],e,clk);
  D_FF32 rb3(q2[3],i2[3],e,clk);
  D_FF32 rb4(q2[4],i2[4],e,clk);
  D_FF32 rb5(q2[5],i2[5],e,clk);
  D_FF32 rb6(q2[6],i2[6],e,clk);
  D_FF32 rb7(q2[7],i2[7],e,clk);
  D_FF32 rb8(q2[8],i2[8],e,clk);
  D_FF32 rb9(q2[9],i2[9],e,clk);
  D_FF32 rb10(q2[10],i2[10],e,clk);
  
  assign d1[0]=q2[0];
  assign d2[10]=q1[10];
  
  compare_and_switch csa0(d2[0],d2[1],q1[0],q1[1]);
  compare_and_switch csb1(d1[1],d1[2],q2[1],q2[2]);
  
  compare_and_switch csa2(d2[2],d2[3],q1[2],q1[3]);
  compare_and_switch csb3(d1[3],d1[4],q2[3],q2[4]);
  
  compare_and_switch csa4(d2[4],d2[5],q1[4],q1[5]);
  compare_and_switch csb5(d1[5],d1[6],q2[5],q2[6]);
  
  compare_and_switch csa6(d2[6],d2[7],q1[6],q1[7]);
  compare_and_switch csb7(d1[7],d1[8],q2[7],q2[8]);
  
  compare_and_switch csa8(d2[8],d2[9],q1[8],q1[9]);
  compare_and_switch csb9(d1[9],d1[10],q2[9],q2[10]);
endmodule

module A_TEST; // Testing the list sorter module to see if it actually sorts the list

  //initialize variables
  
  //clock
  reg clk;
  
 
//write enable
  reg e;
  
  //if s is high, we can set the initial state of the lists
  //if s is low, the list is sorting
  reg s;
  
  //this is the initial list
  reg [31:0] List [10:0];
  
  //this is the final output of the list
  wire [31:0] Output_list [10:0];
  
  //This is the initial list formatted for the sorter
  wire [351:0] Input_list;
  
  //this is the output of the sorter
  wire [351:0] List_out;
  
  
  
initial // Stimulus

begin
  
  //set variables
  
  //set the initial state of the list
  s=1;
  
  //start clock on low
  clk=0;
  
  //always allow lists to write
  e=1;
  
  
  //This is our starting list
  //it should be sorted by the time we are done
  List[0]=1;
  List[1]=53111;
  List[2]=5;
  List[3]=17;
  List[4]=213;
  List[5]=5;
  List[6]=8;
  List[7]=5314;
  List[8]=2;
  List[9]=9;
  List[10]=12;
  
  
  //set the state of the list
  #10000 s=1;
  #20000 s=1;
  
  //Start sorting the list
  #20000 s=0;
end

  //drive the clock forward
always
  
 #10000 clk=!clk;

//create the module that will sort our list
list_sorter my_sorter(clk,e,s,Input_list,List_out);

//pack up the inputs
assign Input_list={List[0],List[1],List[2],List[3],List[4],List[5],List[6],List[7],List[8],List[9],List[10]};

//unpack the outputs
assign {Output_list[0],Output_list[1],Output_list[2],Output_list[3],Output_list[4],Output_list[5],Output_list[6],Output_list[7],Output_list[8],Output_list[9],Output_list[10]}=List_out;

initial // Response


//look at the output
//this output is the list
//it should sort itself over time
$monitor($time, ,Output_list[0], ,Output_list[1], ,Output_list[2], ,Output_list[3], ,Output_list[4], ,Output_list[5], ,Output_list[6], ,Output_list[7], ,Output_list[8], ,Output_list[9], ,Output_list[10]);
endmodule
