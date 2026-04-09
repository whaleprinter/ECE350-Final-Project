# Processor
## NAME (NETID)
Amrita Ganeriwalla ag745
## Description of Design
In this CPU:
1. I created 5 pipelined stages
2. at each stage, i also had separate latches for register routing 
3. my alu and multdiv and exceptions all together give one output 
4. i flush the pc and f/d latch everytime there is a branch taken or a mump instruction. this is so that the pc does not give the incorrect instruction address to the cpu. 
5. for the I-type instructions, 
## Bypassing
i check for A and B in the w->d and m->d stage 
for b, there is the added complexity to checking (avoid forwarding rt or rd by ISA for sw bc for stores, the register content going to memory should be the value that was read earlier)

•	Flush: I flush every time there is a branch taken or jump instruction. This is because the wrong PC (next instruction address) is loaded from the instruction memory and the control flow has now changed. We figure this out in the execute stage and by now in the PC, FD latch have wrong PC in them so they need to be flushed. 
•	Bypassing:
o	For ALU and multdiv inputs: check if forwarding needed from memory or writeback stage (but only for instructions that write to a register)
	for the B input, need to also make sure it is not a store word because for stores the register content going into memory should be the value that was read earlier 
•	Stalling:
o	Forwarding solves most data hazards but load words need to be specially handled. A lw reads data from memory but that data does not become available until the memory stage (one stage after the ALU result). If the instruction immediately after a load tries to use the loaded value, the forwarding cannot help bc it is just not ready yet. So we insert a stall for one cycle – gives the load instrn time to finish and get its data back. 


## Optimizations
The best one was that ALU and multdiv give out the same output!

## Bugs
