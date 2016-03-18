#!/usr/bin/perl
# copied from http://www.perlmonks.org/?node_id=1114292
=head1 NAME

B<hdl_splitlib> - Split up a single Verilog library file into several 
+files

=head1 SYNOPSIS

hdl_splitlib file ...

=head1 DESCRIPTION

Split up a single Verilog library file into several files.  Each outpu
+t
file will contain a single C<module> or C<class>.

Input is a file (or files).

Output is written to the current directory (several files).
Some warning messages may be sent to STDOUT.

Known limitations:
    - `endcelldefine or `undef compiler directives may follow endmodul
+e
    - Those pesky `define macros!!
    - module/class definitions which are commented out

Example: hdl_splitlib lib.v

=cut


use warnings FATAL => 'all';
use strict;

my $directives_found = 0;
my $out              = 'temp.v';
my $fh;
my $modname;

open $fh, '>', $out;
while (<>) {
    print $fh $_;
    if (/^\s*end(?:module|class)\b/) {
        close $fh;
        rename $out, "$modname.v";
        open $fh, '>', $out;
    }
    elsif (/^\s*(?:module|class)\s+(\w+)/) {
        $modname = $1;
    }
    if (/`(define|celldefine|undef)/) {         # `
        $directives_found = 1;
        print;
    }
}

if ($directives_found) {
    print "\nWarning.  The input file may contain problematic compiler
+";
    print " directives (define, undef, celldefine).\n\n";
}

unless (-z $out) {
    print "\nWarning.  All lines after the last 'endmodule' ";
    print "line in the input file have been deleted.  These ";
    print "should have only been comments.\n\n";
}

