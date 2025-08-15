unit class Trap:ver<0.0.3>:auth<zef:lizmat>;
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

# vim: expandtab shiftwidth=4
