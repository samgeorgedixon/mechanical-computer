
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

| Index | Instr (4b) | imm (8b) | Notes                         |
| :---: | :--------- | :------- | ----------------------------- |
|   0   | nop        |          | No Operation                  |
|   1   | sav        |          | Save: ACC -> T1               |
|   2   | res        |          | Restore: ACC <- T1            |
|       | swap?      |          |                               |
|   3   | lda        | address  | Load to ACC from Memory       |
|   4   | sta        | address  | Store to Memory from ACC      |
|   -   |            |          |                               |
|   6   | add        | address  | ACC = ACC + Memory[address]   |
|   7   | sub        | address  | ACC = ACC - Memory[address]   |
|   8   | and        | address  | ACC = ACC and Memory[address] |
|   9   | xor        | address  | ACC = ACC xor Memory[address] |
|   -   |            |          |                               |
|  10   | jmp        | address  | Jump to Address               |
|  11   | bz         | address  | Branch if Zero Flag           |
|  12   | bc         | address  | Branch if Carry Flag          |
