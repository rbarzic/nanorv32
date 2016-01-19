#! /usr/bin/perl 
# STS : Simple Template System

use strict ;
use File::Basename;

use Getopt::Long;
Getopt::Long::Configure('auto_abbrev', 'ignore_case');


use Data::Dumper;               # For dumping of data structures
$Data::Dumper::Indent = 1;


my $user_defined_input_dir = "";

my $target_file;


my %comments = (
    '.v' => {
        'lang'  => 'verilog',
        'comment'   => '//',
        },
    '.c' => {
        'lang' => 'c',
        'comment'   => '//',
        },
    '.cpp' => {
        'lang' => 'c++',
        'comment'   => '//',
        },

    '.ac' => {
        'lang' => 'archc',
        'comment'   => '//',
        },

    '.pl' => {
        'lang' => 'perl',
        'comment'   => '\#',
        },
    '.py' => {
        'lang' => 'python',
        'comment'   => '\#',
        },
    );



read_cmd_line();

Data::Dumper->Dump([ \%comments ], ["Verilog preprocessor symbol"]);

my $complete_filename = $ARGV[0];

my($filename, $directories, $suffix) =  fileparse($complete_filename, qr/\.[^.]*/);

my $input_dir;
if($user_defined_input_dir ne "") {
    $input_dir = $user_defined_input_dir;
} else {
    $input_dir = $directories;
}



my $stripped_filename = $input_dir . '/' . $filename . '.stripped' . $suffix;

my $comment_string;
my $found = 0;
my @extracted_lines = ();
# INFILE should be the "stripped" file
open(INFILE,"$stripped_filename") or die "Can't open file $stripped_filename\n";
open(OUTFILE,">$complete_filename") or die "Can't open file $complete_filename\n";



if (exists $comments{$suffix}) {
    $comment_string = $comments{$suffix}{comment};
} else {
    die "Unsupported file extension : $suffix\n";
}

MAIN: while (<INFILE>) {
    my $current_line = $_;
    if ($current_line =~ m/^
         \s*
         $comment_string
         \@begin\[
         (\w+)
         \]
         /x

        ) {

        $found = 1;
        @extracted_lines = ();
        print OUTFILE  $current_line;
        print "Found : $1\n";
        next MAIN;
    }

    if ($current_line =~ m/^
         \s*
         $comment_string
         \@end\[
         (\w+)
         \]
         /x

        ) {
        
        $found = 0;
        my $snippet = $1;
        my $snippet_file = $input_dir . '/' . $snippet . '.generated' . $suffix;
        print "Inserting  data from : $snippet_file\n";
        open(SNIPPET,"$snippet_file") or die "Can't open $snippet_file for reading \n";
        my @snippet_code = ();
        while(<SNIPPET>) {push @snippet_code,$_;};
        close(SNIPPET);
        print OUTFILE  @snippet_code;
        # print OUTFILE  $current_line;
    }
#    if($found) {
#        push @extracted_lines,$current_line;
#    }  else {
        print OUTFILE  $current_line;
#    }



}

close(INFILE);
close(OUTFILE);

#
# Purpose : Read command line
#
sub read_cmd_line {

  my $parsecmdline = GetOptions
    (

     "help"                 => sub { pod2usage(-verbose => 1,-exitval => 0)},
 #    "man"                  => sub { pod2usage(-verbose => 2,-exitval => 0)},
     "target=s"            => \$target_file,
     "input_dir=s"            => \$user_defined_input_dir,
    );
  pod2usage(-verbose => 1,-exitval => 1) if (!$parsecmdline);
  #pod2usage(-message => "No input specified", -verbose => 1, -exitval => 1) if ($#ARGV == -1);
}



