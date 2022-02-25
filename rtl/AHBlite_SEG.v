module AHBlite_SEG(
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
    output reg    [7:0]	 seg_led,     //段选 高有效
	 output wire	  [3:0]  an			  //位选 低有效
);

assign HRESP = 1'b0;
assign HREADYOUT = 1'b1;

wire write_en;
assign write_en = HSEL & HTRANS[1] & HWRITE & HREADY;

reg wr_en_reg;
always @ (posedge HCLK or negedge HRESETn) begin
    if (~HRESETn) wr_en_reg <= 1'b0;
    else if (write_en) wr_en_reg <= 1'b1;
    else wr_en_reg <= 1'b0;
end
 
//总线数据缓存 
reg [15:0]	DATA;
always @(posedge HCLK or negedge HRESETn)
begin
  if(!HRESETn)
    DATA <= 16'h0000;
  else if(wr_en_reg && HREADY)
    DATA <= HWDATA[15:0];
end

//产生刷新时钟
reg [15:0] counter;
reg scan_clk;

always @(posedge HCLK or negedge HRESETn)
begin
  if(!HRESETn)
    begin
      counter <= 16'h0000;
	  scan_clk<= 1'b0;
    end
  else
	begin
	  if(counter==16'h7000)
		begin
		  scan_clk <= ~scan_clk;
		  counter  <= 16'h0000;
		end 
	  else
	    counter <= counter + 1'b1;
    end 
end

reg [3:0] ring = 4'b1110;   //位选信号  低有效
assign an = ring; 
/*
always @(posedge scan_clk or negedge HRESETn)
  begin
    if(!HRESETn)
		ring <= 4'b1110;
	else
		ring <= {ring[2:0],ring[3]};     //循环左移
end
*/
//从低位到高位 依次刷新
wire [3:0] code;

assign code =
  (ring == 4'b1110) ? DATA[3:0]   :
  (ring == 4'b1101) ? DATA[7:4]   :
  (ring == 4'b1011) ? DATA[11:8]  :
  (ring == 4'b0111) ? DATA[15:12] :
  4'b0000;

always @(*)
case (code)  
    4'h0 : seg_led = 8'h3f;
    4'h1 : seg_led = 8'h06;
    4'h2 : seg_led = 8'h5b;
    4'h3 : seg_led = 8'h4f;
    4'h4 : seg_led = 8'h66;
    4'h5 : seg_led = 8'h6d;
    4'h6 : seg_led = 8'h7d;
    4'h7 : seg_led = 8'h07;
    4'h8 : seg_led = 8'h7f;
    4'h9 : seg_led = 8'h6f;
    4'ha : seg_led = 8'h77;
    4'hb : seg_led = 8'h7c;
    4'hc : seg_led = 8'h39;
    4'hd : seg_led = 8'h5e;
    4'he : seg_led = 8'h79;
    4'hf : seg_led = 8'h71;
    default :seg_led = 8'h00;
endcase

assign HRDATA = {16'b0, DATA};

endmodule