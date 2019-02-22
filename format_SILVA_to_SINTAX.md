## Scripts to convert SILVA database in QIIME format to SINTAX compatable database
```
#get latest SILVA (https://www.arb-silva.de/download/archive/qiime/)
#just need to change the #'s in the file below to change version. 
#wget https://www.arb-silva.de/fileadmin/silva_databases/qiime/Silva_132_release.zip

#in linux shell
#grab fasta headers and write to file
grep "^>"  silva_132_90_16S.fna | sed "-es/^>//" > labels.txt

#in R
R
# R v. 3.4.1
tax_labels<-read.delim('labels.txt', header=F)
dim(tax_labels)
#166393      1

silva_anno<-read.delim("consensus_taxonomy_7_levels.txt", header=F)
dim(silva_anno)
#166393      2

#fix headers
names(silva_anno)<-c("Seq_name", "tax")

#merge together, puts taxonomy in same order
seq_tax<-merge(tax_labels, silva_anno, by.x='V1', by.y='Seq_name', sort=F)
dim(seq_tax)
#166393      2

#add semicolon and 'tax=' to sequence name
seq_tax$add<-rep(";tax=", length(nrow(seq_tax)))
seq_tax$V1<-paste(seq_tax$V1, seq_tax$add, sep="")
seq_tax<-seq_tax[,-3]

#remove periods from sequence names
seq_tax$V1<-gsub("[.]", '', seq_tax$V1)

#clean up taxonomy names to be Sintax compatiable
seq_tax$tax<-gsub("D_0__", "k:", seq_tax$tax)
seq_tax$tax<-gsub("D_1__", "p:", seq_tax$tax)
seq_tax$tax<-gsub("D_2__", "c:", seq_tax$tax)
seq_tax$tax<-gsub("D_3__", "o:", seq_tax$tax)
seq_tax$tax<-gsub("D_4__", "f:", seq_tax$tax)
seq_tax$tax<-gsub("D_5__", "g:", seq_tax$tax)
seq_tax$tax<-gsub("D_6__", "s:", seq_tax$tax)
seq_tax$tax<-gsub(",", "_", seq_tax$tax)
seq_tax$tax<-gsub(";", ",", seq_tax$tax)
seq_tax$tax<-gsub("[[:space:]]", "_", seq_tax$tax)
seq_tax$tax<-gsub("[.]", "_", seq_tax$tax)
seq_tax$tax<-gsub("-", "_", seq_tax$tax)

#remove ambiguous_taxa from taxonomy
seq_tax$tax<-gsub("Ambiguous_taxa,", "", seq_tax$tax)
seq_tax$tax<-gsub(",Ambiguous_taxa", "", seq_tax$tax)
seq_tax$tax<-gsub("Ambiguous_taxa", "", seq_tax$tax)

#add semi colon to end of taxonomy
seq_tax$add2<-rep(";", length(nrow(seq_tax)))
seq_tax$tax<-paste(seq_tax$tax, seq_tax$add2, sep="")
seq_tax<-seq_tax[,-3]

#merge taxonomy to sequence name
seq_tax$full<-paste(seq_tax$V1, seq_tax$tax, sep='')

#add '>' to full header name
seq_tax$full<-paste('>', sep='', seq_tax$full)

#write to file
seq_tax2<-seq_tax[,3]
write.table(seq_tax2, 'seq_tax.txt', sep='\t', quote=F, row.names=F)
quit()
n

#remove header on file
tail -n +2 seq_tax.txt > seq_tax2.txt 
```

## Rename
Replace fasta names using a perl script, needs to be copy and pasted into a text file
```
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
```
## Run perl script
```
perl fix_header.pl seq_tax2.txt silva_132_90_16S.fna > SILVA_132-90.fna
#sintax of script perl fix_header.pl new_headers database > output

#find incomplete taxonomy annotations
grep 'tax=;' SILVA_132-90.fna > bad_seqs.txt
sed -i 's/>//' bad_seqs.txt

#remove incomplete taxonomy information
#chmod 777 faSomeRecords
./faSomeRecords -exclude SILVA_132-90.fna bad_seqs.txt SILVA_132-90_SINTAX.fna
```

## Make into 'udb' file for faster loading
```
./usearch64 -makeudb_sintax SILVA_132-90_SINTAX.fna -output SILVA_132-90_SINTAX.udb
```

## Verify names with USEARCH binary by running test taxonomy
```
./usearch64 -sintax test.fna -db SILVA_132-90_SINTAX.udb -tabbedout reads.sintax -strand both -sintax_cutoff 0.8

```
Database is ready to be used with SINTAX
