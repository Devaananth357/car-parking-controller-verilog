\# Parameterized Car Parking Controller



I built this controller in Verilog to practise handling entry and exit gates independently while keeping a shared count of the cars inside.



The default parking capacity is four cars. Both the capacity and gate timeout can be changed through module parameters.



A request opens a gate when entry or exit is allowed. The count changes only after the car’s passage is confirmed. If no confirmation arrives within the timeout, the gate closes without changing the count.



When one car enters and another exits during the same clock cycle, the count stays unchanged. Entry is blocked when parking is full, and exit requests are blocked when the count is zero.



\*\*Simulation\*\*



I checked normal entry and exit, simultaneous passage, full and empty boundaries, and timeout behavior. I also tested passage on the final allowed cycle to check that confirmation takes priority over timeout.



!\[Parking controller simulation](Images/simulation\_waveform.jpg)



\*\*Design and implementation\*\*



The project was developed in Vivado 2026.1 for an Artix-7 FPGA.



!\[RTL schematic](Images/rtl\_schematic.jpg)



!\[Synthesized schematic](Images/synthesized\_schematic.jpg)



A 10 ns clock constraint was applied. The timing report showed a setup slack of +7.522 ns, hold slack of +0.142 ns, and zero failing endpoints for the constrained paths.



!\[Timing summary](Images/timing\_summary.jpg)



\*\*Project files\*\*



\- `Car\_parking\_Design.v` — controller RTL

\- `Car\_parking\_testbench.v` — simulation testbench

\- `Car\_parking\_constraints.xdc` — clock constraint

\- `Images/` — simulation and Vivado result screenshots



To run the simulation, add the Verilog files to a Vivado project and set `Car\_parking\_testbench` as the simulation top. Use `Car\_parking\_Design` as the design top for synthesis and implementation.

