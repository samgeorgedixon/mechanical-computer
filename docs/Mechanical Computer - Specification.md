
---
## Overview

Proposed here is a proof-of-concept design for a mechanical computer made up of linkages in the basic building block form of 'locks' & 'balances'. The CPU will have a data flow of 2/4 bits but 8 bit words.

---

<div style="page-break-before: always;"></div>

## Contents
---



---

<div style="page-break-before: always;"></div>

## Instruction Set Architecture (ISA)
---

| Index | Instr (4b) | imm (8b) | Notes                            |
| :---: | :--------- | :------- | -------------------------------- |
|   0   | nop        |          | No Operation                     |
|   1   | sav        |          | Save: ACC -> T1                  |
|   2   | res        |          | Restore: ACC <- T1               |
|       | swap?      |          |                                  |
|   3   | lda0       | address  | Load to ACC from MemoryL0 (RAM)  |
|   4   | sta0       | address  | Store to MemoryL0 from ACC (RAM) |
|   5   | lda1       | address  | Load to ACC from MemoryL1 (ROM)  |
|   6   | sta2       | address  | Store to MemoryL2 from ACC (I/O) |
|   -   |            |          |                                  |
|   7   | add        | address  | ACC = ACC + Memory[address]      |
|   8   | sub        | address  | ACC = ACC - Memory[address]      |
|   9   | and        | address  | ACC = ACC and Memory[address]    |
|  10   | xor        | address  | ACC = ACC xor Memory[address]    |
|   -   |            |          |                                  |
|  11   | jmp        | address  | Jump to Address                  |
|  12   | bz         | address  | Branch if Zero Flag              |
|  13   | bc         | address  | Branch if Carry Flag             |
