#Author: Eric Spaulding

use strict; #enforce strict mode
use warnings; #give warnings
use File::Copy qw(move); #access the move function which should allow renaming
                         #across multiple file systems and operating systems

$| = 1; ##dumps print lines as you go rather than saving up the buffer
binmode STDOUT, ":utf8"; ##alows for the use of some unicode characters
use constant { true => 1, false => 0 }; #define true and false for the rest of the script
my $os = $^O; #get the current operating system that the script is being run under
#os results that I've seen
#windows8 -> MSWin32
#linux mint14 -> linux
#juno -> linux
#cygwin use bash from cmd -> MSWin32 (in other words it reports the native windows os)
#cygwin terminal -> cygwin

#print "running in: $os\n";
#exit;

open(STDERR,'>/dev/null'); #redirect stderr to stop messages from appearing on screen

main();

sub main{
  my @files = ();
  my $png = getfiles({keyword   => ".png",
                      path      => "figures/",
                      recursive => true});

  push( @files, @$png );

  print "proccessing these files\n";
  #fix any file names with spaces because ebb can't handle spaces
  for(my $i=0; $i < @files; $i++){ 
    my $newfile = $files[$i];
    $newfile =~ s/ /_/g; #replace all spaces with underscores
    $newfile =~ s/&/n/g; #replace all anpersands with n
    print "\t$files[$i] -> $newfile\n"; 
    move $files[$i], $newfile;
    $files[$i] = $newfile;
  }

  foreach my $filename (@files){
    my $syscmd = "ebb $filename";
  	my $result = `$syscmd`;
  	#print "$result \n";
  }
}

#if recursive is true all sub folders found will be checked in depth first search order
sub getfiles{
  my $args = shift;
  my $path    = $args->{'path'};
  my $keyword = $args->{'keyword'};
  my @filenames = ();
  
  #Grab all the matching files in the current directory
  if(length $keyword > 0){
    my $syscmd = "ls -1 $path*$keyword";
    my $result = `$syscmd`;
    @filenames = split(/\n/,$result);
  
    if($args->{'recursive'}){
      #identify all subdirectories
      $syscmd = "ls -1d $path*/"; $result = `$syscmd`;
      my @dirs = removeBlanksFromArray(split("\n",$result));
  
      #recurse on all subdirectories
      foreach my $dir (@dirs){
        push(@filenames, @{getfiles({recursive => $args->{'recursive'},
                                     path      => $dir, 
                                     keyword   => $keyword})});
      }
    }
  }
  
  return \@filenames;
}

sub removeBlanksFromArray{
  my @list = @_;
  my @nlist = ();
  foreach my $e (@list){
    if(length $e > 0){ push(@nlist, $e); }
  }
  return @nlist;
}