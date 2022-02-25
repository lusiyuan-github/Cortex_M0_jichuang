module AHBlite_Decoder
#(
    /*RAMCODE enable parameter*/
    parameter Port0_en = 1,
    /************************/

    /*RAMDATA enable parameter*/
    parameter Port1_en = 1,
    /************************/

    /*LED enable parameter*/
    parameter Port2_en = 1,
    /************************/

    /*UART enable parameter*/
    parameter Port3_en = 1,
    /************************/
	
	/*Matrix_Key enable parameter*/
    parameter Port4_en = 1,
    /************************/
	
	/*SEG enable parameter*/
    parameter Port5_en = 1,
    /************************/
	
	/*TIMER enable parameter*/
    parameter Port6_en = 1
    /************************/	
)(
    input [31:0] HADDR,

    /*RAMCODE OUTPUT SELECTION SIGNAL*/
    output wire P0_HSEL,

    /*RAMDATA OUTPUT SELECTION SIGNAL*/
    output wire P1_HSEL,

    /*LED OUTPUT SELECTION SIGNAL*/
    output wire P2_HSEL,

    /*UART OUTPUT SELECTION SIGNAL*/
    output wire P3_HSEL,

    /*Matrix_Key OUTPUT SELECTION SIGNAL*/
    output wire P4_HSEL,

    /*SEG OUTPUT SELECTION SIGNAL*/
    output wire P5_HSEL,	
	
    /*TIMER OUTPUT SELECTION SIGNAL*/
    output wire P6_HSEL 
	
);

//RAMCODE-----------------------------------

//0x00000000-0x00000400
/*Insert RAMCODE decoder code there*/
assign P0_HSEL = (HADDR[31:16] == 16'h0000) ? Port0_en : 1'b0; 
/***********************************/

//RAMDATA-----------------------------

//0X20000000-0X20000400
/*Insert RAMDATA decoder code there*/
assign P1_HSEL = (HADDR[31:16] == 16'h2000) ? Port1_en : 1'b0; 
/***********************************/

//PERIPHRAL-----------------------------

//0X40000000 LED
/*Insert LED decoder code there*/
assign P2_HSEL = (HADDR[31:16] == 16'h4000) ? Port2_en : 1'b0; 
/***********************************/

//0X40010000 UART RX DATA
//0X40010004 UART TX STATE
//0X40010008 UART TX DATA
/*Insert UART decoder code there*/
assign P3_HSEL = (HADDR[31:16] == 16'h4001) ? Port3_en : 1'b0;
/***********************************/

//0x40020000 Row
//0x40020004 Col
/*Insert Matrix_Key decoder code there*/
assign P4_HSEL = (HADDR[31:16] == 16'h4002) ? Port4_en : 1'b0;
/***********************************/

//0x40030000 Data
/*Insert SEG decoder code there*/
assign P5_HSEL = (HADDR[31:16] == 16'h4003) ? Port5_en : 1'b0;
/***********************************/

//0X40040000 LOAD
//0X40040004 ENABLE
//0X40040008 VALUE
/*Insert TIMER decoder code there*/
assign P6_HSEL = (HADDR[31:16] == 16'h4004) ? Port6_en : 1'b0;
/***********************************/


endmodule