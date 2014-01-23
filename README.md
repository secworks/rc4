# RC4 core #
## Introduction ##
This is an experimental hardware implementatio of the RC4 stream cipher.

The core implements the cipher using memories with many read and write
ports in order to be able to generate a keystream every cycle. The
question is if the achieved clock frequency is to low to make the core
usable.

## Functionality ##
The core implements the RFC4345 ciphers arcfour128 and arcfour modes as
well as a flexible key size from 8 to 256 bits.


## Implementation results ##
**Altera Cyclone IV GX**
 - LEs: 8190
 - Registers: 2236
 - 57 MHz clock
 - 258 cycles initialization latency.
 - 1 keystream byte/cycle during generation.


## Status ##
**(2014-01-23):** First complete implementation. Still not debugged.


**(2014-01-17):** Most parts of the functionality is done. The key size
has been limited to 128 and 256 bits for the first version. The RTL is
still not complete and no testbench is available.


**(2014-01-13):** Repo init.


