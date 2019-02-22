## Script to extracted sequences based on IDs in a text file

```
#in linux shell
awk 'NR==1{printf $0"\t";next}{printf /^>/ ? "\n"$0"\t" : $0}' fasta_file.fna | awk -F"\t" 'BEGIN{while((getline k < seqs_list.txt")>0)i[k]=1}{gsub("^>","",$0); if(i[$1]){print ">"$1"\n"$2}}' > out.fna

#out.fna is the file to be written
#fasta_file.fna is the file to be extracted from
#seqs_list is a file, where one line is a sequence name and has no '>', hat has a list of sequences to be extracted, e.g.:

MKYQ0100064355192875521084;tax=;
MJEQ010371897648798876489751;tax=;
HG9755231534688815348277;tax=;
```
