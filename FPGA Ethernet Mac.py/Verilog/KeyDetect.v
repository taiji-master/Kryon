// File: KeyDetect.v
// Generated by MyHDL 0.10
// Date: Wed Jul 18 09:17:19 2018


`timescale 1ns/10ps

module KeyDetect (
    clk,
    key1,
    key2,
    key3,
    key4,
    Dkey1,
    Dkey2,
    Dkey3,
    Dkey4,
    Clear,
    Dkey1Down
);


input clk;
input key1;
input key2;
input key3;
input key4;
output Dkey1;
reg Dkey1;
output Dkey2;
reg Dkey2;
output Dkey3;
reg Dkey3;
output Dkey4;
reg Dkey4;
output Clear;
reg Clear;
output Dkey1Down;
wire Dkey1Down;

reg regDkey1 = 1;
reg [16:0] msCNT = 0;
reg [7:0] key4Reg = 255;
reg [7:0] key3Reg = 255;
reg [7:0] key2Reg = 255;
reg [7:0] key1Reg = 255;
reg [7:0] clrCNT = 0;




assign Dkey1Down = (regDkey1 & (~Dkey1));


always @(posedge clk) begin: KEYDETECT_SEQ
    if ((msCNT == 100000)) begin
        msCNT <= 0;
    end
    else begin
        msCNT <= (msCNT + 1);
    end
    if ((msCNT == 0)) begin
        key1Reg[8-1:1] <= key1Reg[7-1:0];
        key1Reg[0] <= key1;
        key2Reg[8-1:1] <= key2Reg[7-1:0];
        key2Reg[0] <= key2;
        key3Reg[8-1:1] <= key3Reg[7-1:0];
        key3Reg[0] <= key3;
        key4Reg[8-1:1] <= key4Reg[7-1:0];
        key4Reg[0] <= key4;
    end
    regDkey1 <= Dkey1;
    if (((regDkey1 == 0) && (Dkey1 == 1) && (clrCNT > 30))) begin
        Clear <= 1;
    end
    else begin
        Clear <= 0;
    end
    if (Clear) begin
        clrCNT <= 0;
    end
    else begin
        if (((msCNT == 0) && (Dkey1 == 0) && (clrCNT < 255))) begin
            clrCNT <= (clrCNT + 1);
        end
    end
    case (key1Reg)
        'h0: begin
            Dkey1 <= 0;
        end
        'hff: begin
            Dkey1 <= 1;
        end
    endcase
    case (key2Reg)
        'h0: begin
            Dkey2 <= 0;
        end
        'hff: begin
            Dkey2 <= 1;
        end
    endcase
    case (key3Reg)
        'h0: begin
            Dkey3 <= 0;
        end
        'hff: begin
            Dkey3 <= 1;
        end
    endcase
    case (key4Reg)
        'h0: begin
            Dkey4 <= 0;
        end
        'hff: begin
            Dkey4 <= 1;
        end
    endcase
end

endmodule
