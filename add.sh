#!/bin/bash

# Set the directory where your files are located
directory="/hpcstor6/scratch01/p/patrick.kearns/Becker_lab_ITS/DE_demux/R1"

cd "$directory" || exit

# Add "_L001_R1_001" to all filenames before the extension
for file in *.fastq; do
    if [[ -f "$file" ]]; then
        new_name="${file%.fastq}_L001_R1_001.fastq"
        mv "$file" "$new_name"
        echo "Renamed $file to $new_name"
    fi
done

directory="/hpcstor6/scratch01/p/patrick.kearns/Becker_lab_ITS/DE_demux/R2"

cd "$directory" || exit

# Add "_L001_R2_001" to all filenames before the extension
for file in *.fastq; do
    if [[ -f "$file" ]]; then
        new_name="${file%.fastq}_L001_R2_001.fastq"
        mv "$file" "$new_name"
        echo "Renamed $file to $new_name"
    fi
done