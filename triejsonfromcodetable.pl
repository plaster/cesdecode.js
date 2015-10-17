#!/usr/bin/perl

use strict;
use warnings;
use utf8;

# input: CODE Table like http://ftp.unicode.org/Public/MAPPINGS/VENDORS/MICSFT/WINDOWS/CP932.TXT
# output: JSON Trie ( [ byte ] => String )

my @t;

sub putleaf {
	my ($code_src, $code_dst) = @_;
	my $vref;
	my $allbytes = '';
	while ($code_src =~ m/\G(..)/g) {
		my $thisbyte = $1;
		if ($vref) {
			if (! $$vref) {
				$$vref = +[];
			} elsif (ref($$vref) ne 'ARRAY') {
				warn "discarding $allbytes => $$vref\n";
				$$vref = +[];
			}
		} else {
			$$vref = \@t;
		}
		$allbytes .= $thisbyte;
		$vref = \( $$vref->[ hex($thisbyte) ] );
	}
	$vref or die 'internal error';

	if (ref($$vref) eq 'ARRAY') {
		warn "ignored $allbytes => $code_dst\n";
	} elsif ($$vref) {
		warn "overwriting $allbytes => $$vref\n";
		$$vref = $code_dst;
	} else {
		$$vref = $code_dst;
	}
}

my $nlines = 0;
while (my $line = <STDIN>) {
	chomp $line;
	$line =~ s/#.*//;
	if ($line =~ m/^0x((?:[0-9A-Z][0-9A-Z])+)\t(?:0x|U\+)([0-9A-Z]{4})/) {
		my $code_src = $1;
		my $code_dst = $2;
		putleaf( $code_src, $code_dst );
	}
	++$nlines;
}

sub tojsonvalue {
	my $v = shift;
	if (! ref($v)) {
		if (defined($v)) {
			return qq{"\\u$v"};
		} else {
			return "null";
		}
	} elsif (ref($v) eq 'ARRAY') {
		my $result = '[';
		for (my $i = 0; $i < scalar(@{$v}); ++$i) {
			$i and $result .= ',';
			$result .= tojsonvalue($v->[$i]);
		}
		$result .= ']';
	} else {
		die 'tojsonvalue failed';
	}
}

print tojsonvalue(\@t);

exit;
