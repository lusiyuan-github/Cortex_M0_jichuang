module Keyboard(
    input   wire   		 HCLK,
    input   wire  		 HRESETn,
    input   wire [7:0]   col,
    output  wire [7:0] 	 key_interrupt
);

reg [11:0]  sreg0;
wire[11:0]  sreg0_nxt;

reg [11:0]  sreg1;
wire[11:0]  sreg1_nxt;

reg [11:0]  sreg2;
wire[11:0]  sreg2_nxt;

reg [11:0]  sreg3;
wire[11:0]  sreg3_nxt;

reg [11:0]  sreg4;
wire[11:0]  sreg4_nxt;

reg [11:0]  sreg5;
wire[11:0]  sreg5_nxt;

reg [11:0]  sreg6;
wire[11:0]  sreg6_nxt;

reg [11:0]  sreg7;
wire[11:0]  sreg7_nxt;

assign  sreg0_nxt   =   sreg0 + 1'b1;
assign  sreg1_nxt   =   sreg1 + 1'b1;
assign  sreg2_nxt   =   sreg2 + 1'b1;
assign  sreg3_nxt   =   sreg3 + 1'b1;
assign  sreg4_nxt   =   sreg4 + 1'b1;
assign  sreg5_nxt   =   sreg5 + 1'b1;
assign  sreg6_nxt   =   sreg6 + 1'b1;
assign  sreg7_nxt   =   sreg7 + 1'b1;

always@(posedge HCLK or negedge HRESETn) begin
    if(~HRESETn) begin
        sreg0   <=  12'b0;
    end else if(col[0]) begin
        if(sreg0 != 12'hfff)
           sreg0   <=  sreg0_nxt;
    end else 
        sreg0   <=  12'b0;
end

always@(posedge HCLK or negedge HRESETn) begin
    if(~HRESETn) begin
        sreg1   <=  12'b0;
    end else if(col[1]) begin
        if(sreg1 != 12'hfff)
           sreg1   <=  sreg1_nxt;
    end else 
        sreg1   <=  12'b0;
end

always@(posedge HCLK or negedge HRESETn) begin
    if(~HRESETn) begin
        sreg2   <=  12'b0;
    end else if(col[2]) begin
        if(sreg2 != 12'hfff)
           sreg2   <=  sreg2_nxt;
    end else 
        sreg2   <=  12'b0;
end

always@(posedge HCLK or negedge HRESETn) begin
    if(~HRESETn) begin
        sreg3   <=  12'b0;
    end else if(col[3]) begin
        if(sreg3 != 12'hfff)
           sreg3   <=  sreg3_nxt;
    end else 
        sreg3   <=  12'b0;
end

always@(posedge HCLK or negedge HRESETn) begin
    if(~HRESETn) begin
        sreg4   <=  12'b0;
    end else if(col[4]) begin
        if(sreg4 != 12'hfff)
           sreg4   <=  sreg4_nxt;
    end else 
        sreg4   <=  12'b0;
end

always@(posedge HCLK or negedge HRESETn) begin
    if(~HRESETn) begin
        sreg5   <=  12'b0;
    end else if(col[5]) begin
        if(sreg5 != 12'hfff)
           sreg5   <=  sreg5_nxt;
    end else 
        sreg5   <=  12'b0;
end

always@(posedge HCLK or negedge HRESETn) begin
    if(~HRESETn) begin
        sreg6   <=  12'b0;
    end else if(col[6]) begin
        if(sreg6 != 12'hfff)
           sreg6   <=  sreg6_nxt;
    end else 
        sreg6   <=  12'b0;
end

always@(posedge HCLK or negedge HRESETn) begin
    if(~HRESETn) begin
        sreg7   <=  12'b0;
    end else if(col[7]) begin
        if(sreg7 != 12'hfff)
           sreg7   <=  sreg7_nxt;
    end else 
        sreg7   <=  12'b0;
end


assign key_interrupt[0] =   (sreg0 != 12'hfff) & (sreg0_nxt == 12'hfff);

assign key_interrupt[1] =   (sreg1 != 12'hfff) & (sreg1_nxt == 12'hfff);

assign key_interrupt[2] =   (sreg2 != 12'hfff) & (sreg2_nxt == 12'hfff);

assign key_interrupt[3] =   (sreg3 != 12'hfff) & (sreg3_nxt == 12'hfff);

assign key_interrupt[4] =   (sreg4 != 12'hfff) & (sreg4_nxt == 12'hfff);

assign key_interrupt[5] =   (sreg5 != 12'hfff) & (sreg5_nxt == 12'hfff);

assign key_interrupt[6] =   (sreg6 != 12'hfff) & (sreg6_nxt == 12'hfff);

assign key_interrupt[7] =   (sreg7 != 12'hfff) & (sreg7_nxt == 12'hfff);

endmodule