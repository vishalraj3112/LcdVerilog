module lcd_2(clk, lcd_rs, lcd_rw, lcd_e, lcd_4, lcd_5, lcd_6, lcd_7);
 parameter n = 27;
 parameter k = 17; 
 (* LOC="E12" *) input clk; // synthesis attribute PERIOD clk "100.0 MHz" 
 reg [n-1:0] count=0; 
 reg lcd_busy=1; 
 reg lcd_stb; 
 reg [5:0] lcd_code;
 reg [6:0] lcd_stuff; 
 (* LOC="Y14" *) output reg lcd_rs; 
 (* LOC="W13" *) output reg lcd_rw;
 (* LOC="Y15" *) output reg lcd_7; 
 (* LOC="AB16" *) output reg lcd_6;
 (* LOC="Y16" *) output reg lcd_5; 
(* LOC="AA12" *) output reg lcd_4;
 (* LOC="AB4" *) output reg lcd_e;  
 always @ (posedge clk) 
 begin 
 count <= count + 1; 
 case (count[k+7:k+2]) 
 0: lcd_code <= 6'b000010; // function set 
 1: lcd_code <= 6'b000010; 
 2: lcd_code <= 6'b001100;
 3: lcd_code <= 6'b000000; // display on/off control
 4: lcd_code <= 6'b001100; 
 5: lcd_code <= 6'b000000; // display clear
 6: lcd_code <= 6'b000001;
 7: lcd_code <= 6'b000000; // entry mode set
 8: lcd_code <= 6'b000110;
 9: lcd_code <= 6'h24; // M 
 10: lcd_code <= 6'h2D; 
 11: lcd_code <= 6'h26; // e 
 12: lcd_code <= 6'h25; 
 13: lcd_code <= 6'h26; // m 
 14: lcd_code <= 6'h2D;
 15: lcd_code <= 6'h22; // - 
 16: lcd_code <= 6'h2D; 
 17: lcd_code <= 6'h24; // O 
 18: lcd_code <= 6'h2F; 
 19: lcd_code <= 6'h27; // u
 20: lcd_code <= 6'h25; 
 21: lcd_code <= 6'h27; // t 
 22: lcd_code <= 6'h24; 
 23: lcd_code <= 6'h27; // p 
 24: lcd_code <= 6'h20; 
 25: lcd_code <= 6'h27; // u 
 26: lcd_code <= 6'h25; 
 27: lcd_code <= 6'h27; // t 
 28: lcd_code <= 6'h24;
 29: lcd_code <= 6'h23; // : 
 30: lcd_code <= 6'h2A;
 31: lcd_code <= 6'h22; //  
 32: lcd_code <= 6'h20; 
 default: lcd_code <= 6'b010000; 
 endcase 
 if (lcd_rw)
 lcd_busy <= 0;
 lcd_stb <= ^count[k+1:k+0] & ~lcd_rw & lcd_busy; // clkrate / 2^(k+2) 
 lcd_stuff <= {lcd_stb,lcd_code};
 {lcd_e,lcd_rs,lcd_rw,lcd_7,lcd_6,lcd_5,lcd_4} <= lcd_stuff;
 end
 endmodule
 