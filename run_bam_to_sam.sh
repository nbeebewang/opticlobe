#!/bin/bash
#
# filename: run_star1pass.sh
# summary: wrapper script to run a batch job for batch_star1pass.sh
# which is a STAR aligner in 1-pass mode with arguments:
#

# inputs
DATA="/n/eddyfs01/pkoo/data/opticlobe/alignment/STAR1pass/test"

# make alignment directory, if doesn’t exist
if [ ! -d "$DATA" ]; then
    mkdir $DATA
fi

# submit jobs for all fastq files in DATA directory
for i in $DATA*.bam; do
    NAME=${i%.bam}
    NAME=${NAME##*/}
    sbatch bam_to_sam.sh $i  $DATA$NAME".sam"
done


