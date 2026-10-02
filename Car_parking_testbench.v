`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Devaananth
// 
// Design Name: Car_parking
// Module Name: Car_parking_testbench
// Project Name: Car_parking_controller
// Target Devices: Artix - 7
// Tool Versions: Vivado v2026.1 (64-bit)
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////


module Car_parking_testbench;
    reg clk;
    reg reset;
    reg entry_request;
    reg exit_request;
    reg car_passed_in;
    reg car_passed_out;
    
    wire entry_gate_open;
    wire exit_gate_open;
    wire parking_full;
    wire [2:0] car_count;
    
    Car_parking_Design #(
        .CAPACITY(4),
        .GATE_TIMEOUT(10)
    ) dut (
        .clk(clk),
        .reset(reset),
        .entry_request(entry_request),
        .exit_request(exit_request),
        .car_passed_in(car_passed_in),
        .car_passed_out(car_passed_out),
        .entry_gate_open(entry_gate_open),
        .exit_gate_open(exit_gate_open),
        .parking_full(parking_full),
        .car_count(car_count)
    );
    
    always #5 clk = ~clk;
    
    initial 
    begin
        clk = 0;
        reset = 1;
        entry_request = 0;
        exit_request = 0;
        car_passed_in = 0;
        car_passed_out = 0;

        repeat (2) @(negedge clk);
        reset = 0;

        @(negedge clk);
        entry_request = 1;

        @(negedge clk);
        entry_request = 0;
        car_passed_in = 1;

        @(negedge clk);
        car_passed_in = 0;
        
        @(negedge clk);
        exit_request = 1;
        entry_request = 1;
        
        @(negedge clk);
        exit_request = 0;
        entry_request = 0;
        car_passed_out = 1;
        car_passed_in = 1;
        
        @(negedge clk);
        car_passed_out = 0;
        car_passed_in = 0;
        
        #10
        @(negedge clk);
        entry_request = 1;
        @(negedge clk);
        entry_request = 0;
        repeat (11) @(negedge clk);
        
        
        @(negedge clk);
        entry_request = 1;

        @(negedge clk);
        entry_request = 0;
        car_passed_in = 1;

        @(negedge clk);
        car_passed_in = 0;
        
        @(negedge clk);
        entry_request = 1;

        @(negedge clk);
        entry_request = 0;
        car_passed_in = 1;

        @(negedge clk);
        car_passed_in = 0;
        
        @(negedge clk);
        entry_request = 1;

        @(negedge clk);
        entry_request = 0;
        car_passed_in = 1;

        @(negedge clk);
        car_passed_in = 0;
        
        @(negedge clk);
        entry_request = 1;
        
        @(negedge clk);
        entry_request = 0;
        
        repeat (2) @(negedge clk);
        
        @(negedge clk);
        exit_request = 1;

        @(negedge clk);
        exit_request = 0;
        car_passed_out = 1;

        @(negedge clk);
        car_passed_out = 0;
        
        @(negedge clk);
        entry_request = 1;

        @(negedge clk);
        entry_request = 0;
        car_passed_in = 1;

        @(negedge clk);
        car_passed_in = 0;
        
        @(negedge clk);
        exit_request = 1;

        @(negedge clk);
        exit_request = 0;
        car_passed_out = 1;

        @(negedge clk);
        car_passed_out = 0;
        
        @(negedge clk);
        exit_request = 1;

        @(negedge clk);
        exit_request = 0;
        car_passed_out = 1;

        @(negedge clk);
        car_passed_out = 0;
        
        @(negedge clk);
        exit_request = 1;

        @(negedge clk);
        exit_request = 0;
        car_passed_out = 1;

        @(negedge clk);
        car_passed_out = 0;
        
        @(negedge clk);
        exit_request = 1;

        @(negedge clk);
        exit_request = 0;
        car_passed_out = 1;

        @(negedge clk);
        car_passed_out = 0;
        
        @(negedge clk);
        entry_request = 1;

        @(negedge clk);
        entry_request = 0;
        
        repeat(9) @(negedge clk);
        car_passed_in = 1;

        @(negedge clk);
        car_passed_in = 0;

        @(negedge clk);
        exit_request = 1;

        @(negedge clk);
        exit_request = 0;
        
        repeat(12) @(negedge clk);
    
        @(negedge clk);
        repeat (2) @(negedge clk);
        $finish;
    end
endmodule
