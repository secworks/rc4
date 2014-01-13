rc4
===
This is an experimental hardware implementatio of the RC4 stream cipher.

The core implements the cipher using memories with many read and write
ports in order to be able to generate a keystream every cycle. The
question is if the achieved clock frequency is to low to make the core
usable.

The core implements the RFC4345 ciphers arcfour128 and arcfour modes as
well as a flexible key size from 8 to 256 bits.
