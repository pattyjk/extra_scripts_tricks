## Scripts to convert SILVA database to SINTAX compatable database
```
#get latest SILVA (https://www.arb-silva.de/download/archive/qiime/)
#wget https://www.arb-silva.de/fileadmin/silva_databases/qiime/Silva_132_release.zip

#in linux shell
#grab fasta headers and write to file
grep "^>" input.fa | sed "-es/^>//" > labels.txt

#in R
R
# R v. 3.4.1
tax_labels<-read.delim('labels.txt', header=F)
silva_anno<-read.delim('', header=F)

#merge together, puts taxonomy in same order
seq_tax<-merge(tax_labels, silva_anno, by.x='', by.y='')

#add semicolon and 'tax=' to sequence name

#clean up taxonomy names
>D50541;tax=f:Aerococcaceae,g:Abiotrophia,s:Abiotrophia_defectiva;

#add semi colon to end of taxonomy

#remove any spaces in header and any ';', ',', and '()', which are no bueno

#write to file
write.table(X, 'X.txt', row.names=F, quote=F, sep='\t')
quit()

#replace fasta names using a perl script
https://www.biostars.org/p/103089/

#database is ready to be used with SINTAX
```
