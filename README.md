# RC4 core #
## Introduction ##
This is an experimental hardware implementatio of the RC4 stream cipher.

The core implements the cipher using memories with many read and write
ports in order to be able to generate a keystream every cycle. The
question is if the achieved clock frequency is to low to make the core
usable. The answer after implementation results is that, yes it does
work. The reusulting implementation achieves a clock frequency high
enough to be usable.


## Functionality ##
The core implements the RFC4345 ciphers arcfour128 including keystream
byte skipping of the first 1536 bytes. Currently the only key sizes
supported are 128 and 256 bits.


## Implementation notes ##
The synthesis, mapping tool might not be able to map the key and state
memories to memory blocks in the target technology, but instead end up
using separate registers. The reason for this is a combination of many
ports and asynchronous reads. The many ports can be handled by memory
mirroring, but the asynchronous read ports are needed to achieve the one
cycle/byte performance.


## Implementation results ##
**Altera Cyclone IV GX**
 - LEs: 8190
 - Registers: 2236
 - 57 MHz clock
 - 258 cycles initialization latency.
 - 1 keystream byte/cycle during generation.
 - 456 Mbps performance.


## Status ##
**(2014-01-23):** First complete implementation. Still not debugged.


**(2014-01-17):** Most parts of the functionality is done. The key size
has been limited to 128 and 256 bits for the first version. The RTL is
still not complete and no testbench is available.


**(2014-01-13):** Repo init.


