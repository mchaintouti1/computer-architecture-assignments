Assignment 1: This project implements a single-cycle processor using VHDL and Xilinx tools, following a bottom-up hardware design approach.
The processor includes:
An ALU and Register File
Instruction Fetch, Decode, Execute, and Memory stages (IF, DEC, EXEC, MEM)
A unified Datapath
A Control Unit that decodes instructions and generates control signals
ROM-based instruction memory initialized via a .coe file
The final system integrates the Datapath and Control Unit into a complete processor capable of executing a predefined instruction set.

Assignment 2: This project extends the previously designed single-cycle processor into a multi-cycle processor using VHDL and Xilinx tools 
The design introduces:
Pipeline-style intermediate registers between IF, DEC, EXEC, MEM, and WB stages
A finite state machine (FSM)–based control unit that sequences instruction execution across multiple clock cycles
A modified datapath supporting staged execution and data persistence between cycles
The final system integrates the updated datapath and FSM control unit into a complete multi-cycle processor capable of executing the supported instruction 
set with improved structural clarity and control over execution flow.

Assignment 3: This project implements the transformation of a single-cycle processor into a fully pipelined processor using VHDL, 
following a classic IF–DEC–EXEC–MEM–WB architecture. The design extends the original datapath with:
Pipeline registers between stages to enable concurrent instruction execution
A forwarding unit to resolve data hazards without stalling when possible
A hazard detection unit to identify load-use and control hazards and insert stalls when required
Additional control and data registers to ensure correct synchronization across pipeline stages
The final system integrates the pipelined datapath with the control unit, supporting correct instruction execution under data dependencies while improving 
instruction throughput through pipelining.
