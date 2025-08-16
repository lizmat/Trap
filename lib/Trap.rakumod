unit class Trap:ver<0.0.5>:auth<zef:lizmat>;
has str @!text;
has     $.tee;

submethod TWEAK() {
    with $!tee {
        when IO::Path {
            $!tee := .open(:w);
        }
        when IO::Handle {
            $!tee := $_;
        }
        when "OUT" | "ERR" {
            $!tee := PROCESS::{"\$$_"}
        }
        default {
            die "'$_.raku()' cannot be used to tee";
        }
    }
}

submethod close() { try .close with $!tee }

submethod DESTROY() { self.close }  # UNCOVERABLE

method print(*@_ --> True) {
    if @_.join -> $text {
        .print($text) with $!tee;
        @!text.push: $text;
    }
}
method say(*@_ --> True) {              # older versions of Raku
    if @_.join -> $text {
        .say($text) with $!tee;
        @!text.push: $text ~ "\n";
    }
}
method printf($format, *@_ --> True) {  # older versions of Raku
    if @_ {
        .printf($format, @_) with $!tee;
        @!text.push: sprintf($format, @_);
    }
}

method text(--> str) { @!text.join }

method silent(--> Bool:D) { !@!text }

multi method CALL-ME(Trap:U: $one is raw, :$tee) {
    $one = self.new(:$tee)
}
multi method CALL-ME(Trap:U: $one is raw, $two is raw, :$tee) {
    $one = $two = self.new(:$tee)
}

# vim: expandtab shiftwidth=4
