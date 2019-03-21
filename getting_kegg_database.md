## Download large file and make into table
```
#wget to get file
wget 'https://www.genome.jp/kegg-bin/download_htext?htext=ko00001&format=htext&filedir=' -O ko00001.keg

##fix file into a table
kegfile="ko00001.keg"

while read -r prefix content
do
    case "$prefix" in A) col1="$content";; \
                      B) col2="$content" ;; \
                      C) col3="$content";; \
                      D) echo -e "$col1\t$col2\t$col3\t$content";;
    esac 
done < <(sed '/^[#!+]/d;s/<[^>]*>//g;s/^./& /' < "$kegfile") > kegg_full.txt
```

## Fix in R
```
R
library(tidyr)

#read in data
kegg_full<-read.delim("kegg_full.txt", header=F, sep='\t')

#give columns names
names(kegg_full)<-c("Level1", 'Level2', 'Level3', 'Tot')
kegg_full$Full<-kegg_full$Tot

separate(kegg_full, Tot, sep=, into=c("KO", "Gene", "Product", "EC")
