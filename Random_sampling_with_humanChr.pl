#!usr/bin/perl
# usage perl Random_sampling_with_humanChr.pl input_file number_of_sequences minimum_length given_len >output_file
# Author: Xun Chen
# Email: xunchen85@gmail.com or chen.xun.3r@kyoto-u.ac.jp
# Date: 2021/1/6

### note: exclude "N" and other non-nucleotide characters; exclude read shorter than minimun read length;

use strict;
my $line="";
my @db=();
open DB, "$ARGV[0]";
my $order=0;
my $start=0;
my $end=0;
my %chr=();
my $j=0;
my $totallen=0;
my $minLen = $ARGV[2];
my $setLen = $ARGV[3];
my $fileName = $ARGV[0];
my $totalReadCount = $ARGV[1];

while(<DB>){
	my @line=split;
 	$line=$line[0];
 	chomp($line);
 	if($line=~">"){
		if ($order == 0) {
			$order++;
			$chr{$order}[0]=1;
			$chr{$order}[1]=1;
			$chr{$order}[2]=$line;
			$chr{$order}[3] = "";
		} else {
			$chr{$order}[1]=$end;
			#	print "ac: $order @{$chr{$order}}\n";
			#		print "aa $order @{$chr{$order}}\n";
			$order++;
			$chr{$order}[0]=$end+1;
			$chr{$order}[1]=$end+1;
			$chr{$order}[2]=$line;
			$chr{$order}[3] = "";
		}
	} else {
		$chr{$order}[3] = $chr{$order}[3].$line;
		$end = $end + length($line);
	}
}

$totallen=$end;
print "# $fileName\t$totallen\n";
my $len=@db;
my $random1=0;
my $random2=0;
my @candidate=();
my $seq="";
my $random3=0;
my %extracted_seq=();
my $location2=0;
my $location1=0;
my @orderchr = keys %chr;
for (my $i=0;$i<$totalReadCount;){
	$location1 = int(rand($totallen));
	for (my $j = 0; $j < @orderchr;$j++){
		if ($location1 >=$chr{$orderchr[$j]}[0] && $location1 <=$chr{$orderchr[$j]}[1]) {
			$location2 = $location1 - $chr{$orderchr[$j]}[0];
			$seq=substr $chr{$orderchr[$j]}[3], $location2, int($setLen);
			my $seqlen = length($seq);
			#print "$chr{$orderchr[$j]}[2] $location2 $seq\n";
			if($seq=~"N" || $seq=~ "[bdefh-su-zBDEFH-SU-Z]" || length($chr{$orderchr[$j]}[3])<$setLen || length($seq)<$minLen) {
				next;
			} else {
				#		my $id = $candidate[0]."_".${location2};
				#if (exists($extracted_seq{$id})){
					#	print "ac\n";
					#	next;
					#} else {
					##	print "ad\n";
					print "$chr{$orderchr[$j]}[2]_${seqlen}_${location2}_${i}\n$seq\n";
					#	$extracted_seq{$id}=1;
					$i++;
					#}
			}	
		}
	}
}
