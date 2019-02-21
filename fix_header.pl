use strict;
use warnings;

my @arr;

while (<>) {
    chomp;
    push @arr, $_ if length;
    last if eof;
}

while (<>) {
    print /^>/ ? shift(@arr) . "\n" : $_;
}
#taken from: https://www.biostars.org/p/103089/
