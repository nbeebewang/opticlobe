#!/bin/bash
#
# filename: run_tophat.sh
# summary: wrapper script to run a batch for TopHat aligner with arguments:
#	<path_to_fastq> <path_to_reference_genome> 
#	<path_to_annotation_genome> <output_directory>

DATA="/n/regal/eddy_lab/pkoo/opticlobe/data/"
GENOME="/n/regal/eddy_lab/pkoo/opticlobe/reference_genome/dm6_bowtie_reference/dm6"
ANNOTATION="/n/regal/eddy_lab/pkoo/opticlobe/reference_annotation/dm6_Ensembl.gtf"
OUTPUT="/n/regal/eddy_lab/pkoo/opticlobe/alignment/"

# make alignment directory
if [ ! -d "$OUTPUT" ]; then
    mkdir $OUTPUT
fi

# make a directory for logs
DIRECTORY=$OUTPUT"tophat"
if [ ! -d "$DIRECTORY" ]; then
    mkdir $DIRECTORY
fi

# submit jobs for all fastq files in DATA directory
for i in $DATA*.fastq*; do 
    NAME=${i%.fastq.gz}
    NAME=${NAME##*/}
    sbatch batch_tophat.sh $i $GENOME $ANNOTATION $DIRECTORY$NAME
done

