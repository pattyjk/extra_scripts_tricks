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
library(dplyr)

#read in data
kegg_full<-read.delim("/Users/patty/Dropbox/kegg_full.txt", header=F, sep='\t')

#give columns names
names(kegg_full)<-c("Level1", 'Level2', 'Level3', 'Tot')
kegg_full$Full<-kegg_full$Tot

#extract KO numbers
kegg_full<-separate(kegg_full, Tot, extra='merge', sep=" ", into=c("KO", "OTHER") )

#extract gene names
kegg_full<-separate(kegg_full, OTHER, extra='merge', sep=";", into=c("Gene", "OTHER") )

#extract EC numbers
kegg_full<-separate(kegg_full, OTHER, extra='merge', sep="EC:", into=c("Product", "EC"))

#fix product and EC columns
kegg_full$Product<-gsub("\\[", "", kegg_full$Product)
kegg_full$EC<-gsub("]", "", kegg_full$EC)
kegg_full$EC<-gsub(" ", ", ", kegg_full$EC)

#fix gene column so only one gene name per line
dim(kegg_full)
#23,236 by 8

kegg_full<- kegg_full %>% 
  mutate(Gene = strsplit(as.character(Gene), ",")) %>% 
  unnest(Gene)

dim(kegg_full)
#30705 by 8

#strip extra space from gene column
kegg_full$Gene<-gsub("[[:space:]]", "", kegg_full$Gene)

#write to a file
write.table(kegg_full, "kegg_full_fixed.txt", row.names=F, quote=F, sep='\t')
```
