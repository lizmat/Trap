unit class Trap;
has str @!text;

method print(*@_ --> True) {
    @!text.push: @_.join
}
method say(*@_ --> True) {              # older versions of Raku
    @!text.push: @_.join ~ "\n"
}
method printf($format, *@_ --> True) {  # older versions of Raku
    @!text.push: sprintf($format, @_)
}

method text(--> str) { @!text.join }

multi method CALL-ME(Trap:U: $one is raw) {
    $one = self.new
}
multi method CALL-ME(Trap:U: $one is raw, $two is raw) {
    $one = $two = self.new
}

=begin pod

=head1 NAME

Trap - Trap $*OUT and/or $*ERR output

=head1 SYNOPSIS

=begin code :lang<raku>

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

=end code

=head1 DESCRIPTION

Trap exports a class C<Trap> that can be called to capture standard
output and/or standard error, typically for a lexical scope.

The class can be called with either one or two arguments, each of which
should be a writeable local dynamic variable C<$*OUT> or C<$*OUT>. Or one
can create the C<Trap> object manually.  Or one can use C<Trap> to just
trap the standard output and/or standard error (see SYNOPSIS for examples).

Note that if you're only interested in surpressing output from B<warnings>,
you should use the C<quietly> statement prefix.

=head1 AUTHOR

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/Trap . Comments and
Pull Requests are welcome.

If you like this module, or what I’m doing more generally, committing to a
L<small sponsorship|https://github.com/sponsors/lizmat/>  would mean a great
deal to me!

=head1 COPYRIGHT AND LICENSE

Copyright 2022, 2024 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
