`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Devaananth
// 
// Create Date: 01.10.2026 20:44:00
// Design Name: Car_parking
// Module Name: Car_parking_Design
// Project Name: Car_parking_controller
// Target Devices: Artix - 7
// Tool Versions: Vivado v2026.1 (64-bit)
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////


module Car_parking_Design#(
    parameter CAPACITY = 4,
    parameter GATE_TIMEOUT = 10
    )(
    input  clk,
    input  reset,
    input  entry_request,
    input  exit_request,
    input car_passed_in,
    input car_passed_out,
    
    output reg entry_gate_open,
    output reg exit_gate_open,
    output wire parking_full,
    output reg [$clog2(CAPACITY+1)-1:0] car_count
    );
    assign parking_full = (car_count == CAPACITY);
    
    reg entry_state;
    reg exit_state;
    
    wire entry_done;
    
    assign entry_done = (car_passed_in == 1 && entry_gate_open == 1) ? 1:0;
    
    wire exit_done;
    
    assign exit_done = (car_passed_out == 1 && exit_gate_open == 1) ? 1:0;
    
    localparam open = 1'b1;
    localparam close = 1'b0;
    
    localparam Timer_bits = (GATE_TIMEOUT > 1) ? $clog2(GATE_TIMEOUT) : 1;
    
    reg [Timer_bits-1 : 0] entry_timer;
    reg [Timer_bits-1 : 0] exit_timer;
    
    always @(posedge clk or posedge reset)
    begin
        if(reset)
        begin
            entry_gate_open <= 0;
            exit_gate_open <= 0;
            entry_state <= close;
            exit_state <= close;
            entry_timer <= 0;
            exit_timer <= 0;
            car_count <= 0;
        end
        else
        begin
            case(entry_state)
            close:
            begin
                entry_gate_open <= 0;
                entry_timer <= 0;
                if(entry_request && ~parking_full)
                begin
                    entry_state <= open;
                    entry_gate_open <= 1;
                end
            end
            open:
            begin
                if(car_passed_in)
                begin
                    entry_timer <= 0;
                    entry_state <= close;
                    entry_gate_open <= 0;
                end
                else
                begin
                    if(entry_timer == GATE_TIMEOUT - 1)
                    begin
                        entry_state <= close;
                        entry_timer <= 0;
                        entry_gate_open <= 0;
                    end
                    else
                    begin
                        entry_timer <= entry_timer + 1;
                    end
                end
            end   
            endcase
            case(exit_state)
            close:
            begin
                exit_gate_open <= 0;
                exit_timer <= 0;
                exit_state <= close;
                if(car_count > 0 && exit_request)
                begin
                    exit_state <= open;
                    exit_gate_open <= 1;
                end
            end
            open:
            begin
                if(car_passed_out)
                begin
                    exit_state <= close;
                    exit_gate_open <= 0;
                    exit_timer <= 0;
                end
                else
                begin
                    if(exit_timer == GATE_TIMEOUT - 1)
                    begin
                        exit_state <= close;
                        exit_gate_open <= 0;
                        exit_timer <= 0;
                    end
                    else
                    begin
                        exit_timer <= exit_timer + 1;
                    end
                end
            end
            endcase
            if(entry_done && exit_done)
            begin
                car_count <= car_count;
            end
            else if(entry_done && ~exit_done && car_count < CAPACITY )
            begin
                car_count <= car_count + 1;
            end
            else if(~entry_done && exit_done && car_count > 0)
            begin
                car_count <= car_count - 1;
            end
        end
    end
endmodule
