module CUT(a,b,c,d,i,j);

input a,b,c,d;
output i,j;

wire e,f,g,h;

assign e = a ^ b;
assign f = c ^ d;
assign g = a ^ c;
assign h = b ^ d;
assign i = e & f;
assign j = g | h;

endmodule