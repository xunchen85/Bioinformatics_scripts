#!usr/bin/perl -w
# usage perl Random_sampling.pl input_file number minimum_length given_length >output_file
# Author: Xun Chen
# Email: xunchen85@gmail.com or chen.xun.3r@kyoto-u.ac.jp
# Date: 2021/1/6

use strict;
my $line="";
my @db=();
open DB, "$ARGV[0]";
my $order=0;
while(<DB>){
 my @line=split;
 $line=$line[0];
 chomp($line);
 if($line=~">"){
  $db[++$order]=$line."\t";
               }
 else{$db[$order].=$line;}
                 }

my $len=@db;my $random1=0;my $random2=0;my @candidate=();my $seq="";
my $random3=0;
for(my $i=0;$i<$ARGV[1];){
  $random1=int(rand($len));
  @candidate=split /\s+/, $db[$random1];
  $random2=int(rand(length($candidate[1])));
  $random3=int(rand($ARGV[3]));
  $seq=substr $candidate[1], $random2, $random3;
  if($seq=~"N" || length($candidate[1])<=$ARGV[3] || length($seq)<$ARGV[2]){next;}
  print "$candidate[0]_$random2\n$seq\n";
 #  print "$seq\n";
  $i++;
                         }
