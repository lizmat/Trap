[![Actions Status](https://github.com/lizmat/Trap/actions/workflows/linux.yml/badge.svg)](https://github.com/lizmat/Trap/actions) [![Actions Status](https://github.com/lizmat/Trap/actions/workflows/macos.yml/badge.svg)](https://github.com/lizmat/Trap/actions) [![Actions Status](https://github.com/lizmat/Trap/actions/workflows/windows.yml/badge.svg)](https://github.com/lizmat/Trap/actions)

NAME
====

Trap - Trap \$*OUT and/or \$*ERR output

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

my $trap;
{
    $trap = Trap(my $*OUT);
    note "not on STDOUT";
}
say $trap.silent;  # True

my $visual;
{
    # show output as well as trapping
    $visual = Trap(my $*OUT, :tee<OUT>)
    say "Quality first";  # also shown
}
print $visual.text;  # Quality First␤
```

DESCRIPTION
===========

Trap exports a class `Trap` that can be called to capture standard output and/or standard error, typically for a lexical scope.

The class can be called with either one or two arguments, each of which should be a writeable local dynamic variable `$*OUT` or `$*ERR`. Or one can create the `Trap` object manually. Or one can use `Trap` to just trap the standard output and/or standard error (see SYNOPSIS for examples).

Note that if you're only interested in surpressing output from **warnings**, you should use the `quietly` statement prefix.

METHODS
=======

text
----

Returns the combined text that was captured.

silent
------

Returns `True` if no output was captured at all (not even empty strings), `False` otherwise.

TEEING OUTPUT
=============

```raku
my $trap = Trap(my $*OUT, :tee<OUT>)
say "foo";        # foo␤    on STDOUT
note $trap.text;  # foo␤    on STDERR
```

The named argument `:tee` can be specified to output captured output as it is being captured on either the original STDOUT or STDERR output handle (by specifying the string "OUT" or "ERR".

```raku
my $trap = Trap(my $*OUT, :tee("teed.output".IO))
say "foo";        # foo␤    on STDOUT
note $trap.text;  # foo␤    on STDERR
```

One can also specify any `IO::Path` or`IO::Handle` object to have the output trapped to.

The name of this named argument is inspired by the [Unix `tee`](https://en.wikipedia.org/wiki/Tee_(command)) command.

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/Trap . Comments and Pull Requests are welcome.

If you like this module, or what I’m doing more generally, committing to a [small sponsorship](https://github.com/sponsors/lizmat/) would mean a great deal to me!

COPYRIGHT AND LICENSE
=====================

Copyright 2022, 2024, 2025 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

