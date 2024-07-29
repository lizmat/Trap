[![Actions Status](https://github.com/lizmat/Trap/actions/workflows/linux.yml/badge.svg)](https://github.com/lizmat/Trap/actions) [![Actions Status](https://github.com/lizmat/Trap/actions/workflows/macos.yml/badge.svg)](https://github.com/lizmat/Trap/actions) [![Actions Status](https://github.com/lizmat/Trap/actions/workflows/windows.yml/badge.svg)](https://github.com/lizmat/Trap/actions)

NAME
====

Trap - Trap $*OUT and/or $*ERR output

SYNOPSIS
========

```raku
use Trap;

my $out;
my $err;
{   # separate capturing
    $out = Trap(my $*OUT);
    $err = Trap(my $*ERR);
    say "Hello world!";
    note "Goodbye!"
}
print "STDOUT: $out.text()";  # SDDOUT: Hello world!␤
print "STDERR: $err.text()";  # STDERR: Goodbye!␤

my $merged;
{   # merged capturing
    $merged = Trap(my $*OUT, my $*ERR);
    say "Hello world!";
    note "Goodbye!"
}
print $merged.text;  # Hello world!␤Goodbye!␤

my $new;
{   # creating the object manually
    $new = my $*OUT = Trap.new;
    say "Hello world!";
}
print "with object: $new.text()";  # with object: Hello world!␤

{   # ignoring any output
    Trap(my $*OUT, my $*ERR);
    say "shall never be seen";
}
```

DESCRIPTION
===========

Trap exports a class `Trap` that can be called to capture standard output and/or standard error, typically for a lexical scope.

The class can be called with either one or two arguments, each of which should be a writeable local dynamic variable `$*OUT` or `$*OUT`. Or one can create the `Trap` object manually. Or one can use `Trap` to just trap the standard output and/or standard error (see SYNOPSIS for examples).

Note that if you're only interested in surpressing output from **warnings**, you should use the `quietly` statement prefix.

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/Trap . Comments and Pull Requests are welcome.

If you like this module, or what I’m doing more generally, committing to a [small sponsorship](https://github.com/sponsors/lizmat/) would mean a great deal to me!

COPYRIGHT AND LICENSE
=====================

Copyright 2022 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

