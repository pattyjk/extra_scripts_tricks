## Install with conda
```
conda create --name virsorter \
              -c bioconda mcl=14.137 \
                      muscle \
                      blast \
                      perl-bioperl \
                      perl-file-which \
                      hmmer=3.1b2 \
                      perl-parallel-forkmanager \
                      perl-list-moreutils
```

## General workflow
```
Bin reads with metaSPades/metaBat, host prediction
Map abundance of contigs with BowTie or bbmap
virsorter to pull out viral contigs
```
