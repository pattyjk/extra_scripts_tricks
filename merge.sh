#!/bin/bash

# Set the directory where your FASTQ files are located
directory="/hpcstor6/scratch01/p/patrick.kearns/Becker_lab_ITS/DE_demux/R1"

cd "$directory" || exit

# Iterate over each unique prefix before the underscore
for prefix in $(ls *.fastq | cut -d '_' -f 1 | sort | uniq); do
    # Use the first file name with the current prefix as reference
    reference_file=$(ls "$prefix"_*.fastq | head -n 1)
    # Merge files with the same prefix
    cat "$prefix"_*.fastq > merged_"$prefix".fastq
    echo "Merged files with prefix $prefix using $reference_file as reference"
done

directory="/hpcstor6/scratch01/p/patrick.kearns/Becker_lab_ITS/DE_demux/R2"

cd "$directory" || exit

# Iterate over each unique prefix before the underscore
for prefix in $(ls *.fastq | cut -d '_' -f 1 | sort | uniq); do
    # Use the first file name with the current prefix as reference
    reference_file=$(ls "$prefix"_*.fastq | head -n 1)
    # Merge files with the same prefix
    cat "$prefix"_*.fastq > merged_"$prefix".fastq
    echo "Merged files with prefix $prefix using $reference_file as reference"
done