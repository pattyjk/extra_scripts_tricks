## Format for use in R
```
#converts raw data off the plate reader to a easy to use format

library(reshape2)
#read data in
data<-read.table("test_plate_reader.txt", sep='\t', skip=18)

#prune off extra columns
data<-data[,c(-2,-1)]

#add sample names to headers (if each column is a specific strain)
names(data)<-c("ARL", "FUG",	"SLF",	"CLF",	"CEF",	"NCG",	"TCG",	"SFX",	"RFX",	"SMF",	"LFX",	"Blank")

#reshape data into long format
data_m<-melt(data)

#add any other metadata
data_m$salinity<-rep(0, nrow(data_m))
```
