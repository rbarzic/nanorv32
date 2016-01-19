#!/usr/bin/perl 
# STS : Simple Template System

use strict ;
use File::Basename;

use Getopt::Long;
Getopt::Long::Configure('auto_abbrev', 'ignore_case');


use Data::Dumper;               # For dumping of data structures
$Data::Dumper::Indent = 1;




my $user_defined_output_dir = "";

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

Data::Dumper->Dump([ \%comments ], ["Comments..."]);

my $complete_filename = $ARGV[0];

my($filename, $directories, $suffix) =  fileparse($complete_filename, qr/\.[^.]*/);

my $output_dir;

if($user_defined_output_dir ne "") {
    $output_dir = $user_defined_output_dir;
} else {
    $output_dir = $directories;
}


my $stripped_file = $output_dir . '/' . $filename . '.stripped' . $suffix;

my $comment_string;
my $found = 0;
my @extracted_lines = ();
open(INFILE,"$complete_filename") or die "Can't open file $complete_filename\n";
open(OUTFILE,">$stripped_file") or die "Can't open file $stripped_file\n";
print "Creating file : $stripped_file\n";

if (exists $comments{$suffix}) {
    $comment_string = $comments{$suffix}{comment};
} else {
    die "Unsupported file extension : $suffix\n";
}

MAIN: while (<INFILE>) {
    if (m/^
         \s*
         $comment_string
         \@begin\[
         (\w+)
         \]
         /x

        ) {
        print "Extracting data for : $1\n";
        $found = 1;
        @extracted_lines = ();
        print OUTFILE  $_;
        next MAIN;
    }

        if (m/^
         \s*
         $comment_string
         \@end\[
         (\w+)
         \]
         /x

        ) {
        
        $found = 0;
        my $snippets = $1;
        my $extracted_file = $output_dir . '/' . $snippets . '.extracted'. $suffix;
        open(EXTRACT,">$extracted_file") or die "Can't open $extracted_file for writing \n";
        print EXTRACT  @extracted_lines;
        close(EXTRACT);
        
    }
    if($found) {
        push @extracted_lines,$_;
    } else {
        print OUTFILE $_;
    }



}

close(INFILE);

#
# Purpose : Read command line
#
sub read_cmd_line {

  my $parsecmdline = GetOptions
    (

     "help"                 => sub { pod2usage(-verbose => 1,-exitval => 0)},
 #    "man"                  => sub { pod2usage(-verbose => 2,-exitval => 0)},
      "output_dir=s"            => \$user_defined_output_dir,
    );
  pod2usage(-verbose => 1,-exitval => 1) if (!$parsecmdline);
  #pod2usage(-message => "No input specified", -verbose => 1, -exitval => 1) if ($#ARGV == -1);
}



