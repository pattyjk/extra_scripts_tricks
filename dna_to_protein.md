## Perl script DNA -> Protein
```
# This script will convert your DNA sequence to PROTEIN Sequence

# While executing this script it asks for the file name of the DNA sequence. If the sequence file is not available in the same directory of this script, enter the name of the file along with the path.  eg.In windows:  c:\dnafile.txt, In Linux: /home/user/sequence/dnafile.txt

print "\n\n\t\#################### DNA 2 PROTEIN #################### \n\n";
print "This script will convert your DNA sequence to PROTEIN Sequence\n\n";
print "ENTER THE FILENAME OF THE DNA SEQUENCE:= ";
$DNAfilename = <STDIN>;
chomp $DNAfilename;
unless ( open(DNAFILE, $DNAfilename) ) {
    print "Cannot open file \"$DNAfilename\"\n\n";
}
@DNA = <DNAFILE>;
close DNAFILE;
$DNA = join( '', @DNA);
print " \nThe original DNA file is:\n$DNA \n";
$DNA =~ s/\s//g;
my $protein='';
my $codon;
for(my $i=0;$i<(length($DNA)-2);$i+=3)
{
$codon=substr($DNA,$i,3);
$protein.=&codon2aa($codon);
}
print "The translated protein is :\n$protein\n";
<STDIN>;

sub codon2aa{
my($codon)=@_;
$codon=uc $codon;
my(%g)=('TCA'=>'S','TCC'=>'S','TCG'=>'S','TCT'=>'S','TTC'=>'F','TTT'=>'F','TTA'=>'L','TTG'=>'L','TAC'=>'Y','TAT'=>'Y','TAA'=>'_','TAG'=>'_','TGC'=>'C','TGT'=>'C','TGA'=>'_','TGG'=>'W','CTA'=>'L','CTC'=>'L','CTG'=>'L','CTT'=>'L','CCA'=>'P','CCC'=>'P','CCG'=>'P','CCT'=>'P','CAC'=>'H','CAT'=>'H','CAA'=>'Q','CAG'=>'Q','CGA'=>'R','CGC'=>'R','CGG'=>'R','CGT'=>'R','ATA'=>'I','ATC'=>'I','ATT'=>'I','ATG'=>'M','ACA'=>'T','ACC'=>'T','ACG'=>'T','ACT'=>'T','AAC'=>'N','AAT'=>'N','AAA'=>'K','AAG'=>'K','AGC'=>'S','AGT'=>'S','AGA'=>'R','AGG'=>'R','GTA'=>'V','GTC'=>'V','GTG'=>'V','GTT'=>'V','GCA'=>'A','GCC'=>'A','GCG'=>'A','GCT'=>'A','GAC'=>'D','GAT'=>'D','GAA'=>'E','GAG'=>'E','GGA'=>'G','GGC'=>'G','GGG'=>'G','GGT'=>'G');
if(exists $g{$codon})
{
return $g{$codon};
}
else
{
print STDERR "Bad codon \"$codon\"!!\n";
exit;
}
}
```

Write this to a file (e.g. DNA_to_perl.perl) and call with perl <code_file> DNA_file
