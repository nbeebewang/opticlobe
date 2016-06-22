#!/bin/bash
#
# filename: run_star2pass.sh
# summary: wrapper script to run a batch job for batch_star2pass.sh
#	which is a STAR aligner in 2-pass mode with arguments:
#	<path_to_fastq> <path_to_reference_genome> <output_directory>

# inputs
DATA="/n/regal/eddy_lab/pkoo/opticlobe/data/"
GENOME="/n/regal/eddy_lab/pkoo/opticlobe/reference_genome/dm6_reference"
OUTPUT="/n/regal/eddy_lab/pkoo/opticlobe/alignment/"

# make alignment directory
if [ ! -d "$OUTPUT" ]; then
    mkdir $OUTPUT
fi

# make a directory for star2pass within alignment directory
STARDIR=$OUTPUT"star2pass"
if [ ! -d "$STARDIR" ]; then
    mkdir $STARDIR
fi

# submit jobs for all fastq files in DATA directory
for i in $DATA*.fastq*; do 
    NAME=${i%.fastq.gz}
    NAME=${NAME##*/}
    sbatch batch_star2pass.sh $i $GENOME $STARDIR$NAME
done

