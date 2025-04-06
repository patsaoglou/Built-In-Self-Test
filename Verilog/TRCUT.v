module TRCUT(clk,RST,si,se,so);

input clk,si,se, RST;
output so;

wire a,b,c,d,i,j;

assign so = d;

SDFF Raj(clk, RST, j, si, se, a);
SDFF Rbi(clk, RST, i, a, se, b);
SDFF Rc(clk, RST, c, b, se, c);
SDFF Rd(clk, RST, d, c, se, d);

CUT cut (
    .a(a),
    .b(b),
    .c(c),
    .d(d),
    .i(i),
    .j(j)
);

endmodule