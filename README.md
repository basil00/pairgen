pairgen
=======

Pairgen is a tool for generating pairs of "similar" Bitcoin addresses.  For
example, generate a pair of addresses that share the first *80* bits:

    $ pairgen 80
    ...
    WIF[1] = ...
    WIF[2] = ...

    shared = 20chars
    hash160[1] = 53e1f4f491509f9012bd901be5147447f770018b
    hash160[2] = 53e1f4f491509f9012bd825ce1e9599b253188ef

    shared = 15chars
    addr[1] = 18eXmgR5Svoqqa6PaYVrKvbH6hvrp5xe3A
    addr[2] = 18eXmgR5Svoqqa6JXSMmbNaD4Cs5ThcV1P

Pairgen exploits the so-called [birthday
attack](http://en.wikipedia.org/wiki/Birthday_attack) to find long (partial)
collisions.  Pairgen's algorithm is similar to other tools such as
[MD5CRK](http://en.wikipedia.org/wiki/MD5CRK).

Warnings!
---------

Pairgen is experimental software.

**You must independently verify all generated addresses before use!**  Never
send Bitcoins to a generated address before uploading (and verifying) the
private keys using other wallet software.

Usage
-----

The basic usage of pairgen is:

    pairgen bits

where *bits* is the number of shared bits.

The advanced usage of pairgen is:

    pairgen [--job=JOB] [--message=MESSAGE] bits [distinguished-bits]

The *job* option tells pairgen to store state in the files *job.secret*,
*job.public* and *job.work*.  Jobs can be stopped and restarted, which is
useful for large runs.

The *message* option allows the user to specify the message used for 
signature generation.

The *distinguished-bits* determines how granular the work is.

Hacking
-------

* *More work is good*: more work = higher chance of finding a solution
  (unlike vanitygen).
* *Reuse work*: The *job* option can be used to find multiple solutions.
  Restart pairgen (with the same command-line arguments) to find the next
  solution.  This will reuse work, so finding more solutions becomes easier
  over time.
* *Split work*: The *job.public* file can safely be distributed.  You can
  generate work on multiple machines, and combine the work by concatenating
  the resulting *job.work* files.

Building
--------

For Linux make sure that gmp-dev is installed, then run make:

    $ make

For Windows use MinGW cross-compilation.  First Download and build gmp-6.0.0
from source, then run:

    $ make -f Makefile.windows

BUGS
----

The *job.secret* file is not encrypted in any way.

If a worker thread finds a loop with no distinguished point, it will loop
forever.  Currently pairgen just relies on this being unlikely.

LICENSE
-------

The new pairgen code is GPLv3.  Pairgen incorporates other code (e.g.
libsecp256k1) distributed under other compatible open source licenses.

