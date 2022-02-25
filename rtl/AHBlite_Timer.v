module AHBlite_Timer(
    input  wire          HCLK,    
    input  wire          HRESETn, 
    input  wire          HSEL,    
    input  wire   [31:0] HADDR,   
    input  wire    [1:0] HTRANS,  
    input  wire    [2:0] HSIZE,   
    input  wire    [3:0] HPROT,   
    input  wire          HWRITE,  
    input  wire   [31:0] HWDATA,  
    input  wire          HREADY,  
    output wire          HREADYOUT, 
    output wire   [31:0] HRDATA,  
    output wire          HRESP,
    output wire          timer_irq	
);

assign HRESP = 1'b0;
assign HREADYOUT = 1'b1;

wire read_en;
assign read_en=HSEL&HTRANS[1]&(~HWRITE)&HREADY;

wire write_en;
assign write_en=HSEL&HTRANS[1]&(HWRITE)&HREADY;

reg rd_en_reg;
always@(posedge HCLK or negedge HRESETn) begin
  if(~HRESETn) rd_en_reg <= 1'b0;
  else if(read_en) rd_en_reg <= 1'b1;
  else rd_en_reg <= 1'b0;
end

reg wr_en_reg;
always@(posedge HCLK or negedge HRESETn) begin
  if(~HRESETn) wr_en_reg <= 1'b0;
  else if(write_en) wr_en_reg <= 1'b1;
  else  wr_en_reg <= 1'b0;
end

reg addr_reg;
always@(posedge HCLK or negedge HRESETn) begin
  if(~HRESETn) addr_reg <= 1'b0;
  else if(HSEL & HREADY & HTRANS[1]) addr_reg <= HADDR[2];
end

reg [31:0] load;     //0x00
reg		   enable;   //0x04

always@(posedge HCLK or negedge HRESETn)
  if(~HRESETn) 
    begin
	  load   <= 32'h0000_0000;
      enable <= 1'b0;
    end 
  else if(wr_en_reg && HREADY) 
    begin
      if(~addr_reg)
        load   <= HWDATA;
      else    
        enable <= HWDATA[0];
    end


reg [31:0] value;   //0x08

always@(posedge HCLK or negedge HRESETn)
  if(~HRESETn) 
	value <= 32'h0000_0000;
  else if(enable == 1'b1)
	begin
	  if(value == load - 1'b1)
		value <= 32'h0000_0000;
	  else 
		value <= value + 1'b1;
	end
  else if(enable == 1'b0)
	value <= 32'h0000_0000;
	

assign HRDATA = value;

assign timer_irq = ((enable == 1'b1) && (value == load - 1'b1)) ? 1'b1 : 1'b0;

endmodule


