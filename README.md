# RC4 core #
## Introduction ##
This is an experimental hardware implementation of the RC4 stream cipher.

The core implements the cipher using memories with many read and write
ports in order to be able to generate a keystream byte every cycle. The
question is if the achieved clock frequency is to low to make the core
usable. The answer after implementation the design in a FPGA device is
that, yes it does work. The reusulting implementation achieves a clock
frequency high enough to be usable. The design however is rather large.

Also, RC4 is a very, very broken cipher. Nobody should be using RC4. So
don't use this core, ok?


## Functionality ##
The core implements RC4 including the arcfour128 and arcfour256 versions
specified in [RFC4 4345](https://www.ietf.org/rfc/rfc4345.txt). This
means support for skipping the first 1536 keystream bytes. Currently the
only key sizes supported are 128 and 256 bits.


## Implementation notes ##
The synthesis and mapping tool you use might not be able to map the key
and state memories to memory blocks available in the target technology,
but instead end up using separate registers. The reason for this is a
combination of many ports and asynchronous reads. The many ports can be
handled by memory mirroring, but the asynchronous read ports are needed
to achieve the one cycle/byte performance.


## FuseSoC
This core is supported by the
[FuseSoC](https://github.com/olofk/fusesoc) core package manager and
build system. Some quick  FuseSoC instructions:

install FuseSoC
~~~
pip install fusesoc
~~~

Create and enter a new workspace
~~~
mkdir workspace && cd workspace
~~~

Register rc4 as a library in the workspace
~~~
fusesoc library add rc4 /path/to/rc4
~~~

...if repo is available locally or...
...to get the upstream repo
~~~
fusesoc library add rc4 https://github.com/secworks/rc4
~~~

To run lint
~~~
fusesoc run --target=lint secworks:crypto:rc4
~~~

Run tb_rc testbench
~~~
fusesoc run --target=tb_rc4 secworks:crypto:rc4
~~~

Run with modelsim instead of default tool (icarus)
~~~
fusesoc run --target=tb_rc4 --tool=modelsim secworks:crypto:rc4
~~~

List all targets
~~~
fusesoc core show secworks:crypto:rc4
~~~


## Implementation results ##
**Altera Cyclone IV GX**
 - LEs: 8190
 - Registers: 2236
 - 57 MHz clock
 - 258 cycles initialization latency.
 - 1 keystream byte/cycle during generation.
 - 456 Mbps performance.


## Status ##
(2014-01-23):
First complete implementation. Still not debugged.


(2014-01-17)
Most parts of the functionality is done. The key size
has been limited to 128 and 256 bits for the first version. The RTL is
still not complete and no testbench is available.


(2014-01-13)
Repo init.
