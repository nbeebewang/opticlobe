#!/bin/bash
#
# filename: run_star1pass.sh
# summary: wrapper script to run a batch job for batch_star1pass.sh
# which is a STAR aligner in 1-pass mode with arguments:
#

# inputs
DATA="/n/eddyfs01/pkoo/data/opticlobe/alignment/STAR2pass/TEST/"
REFGENOME = "/n/eddyfs01/pkoo/data/opticlobe/reference_genome/dm6.fa" 


# submit jobs for all fastq files in DATA directory
for i in $DATA*.sam; do
    NAME=${i%.sortedByCoord.out.sam}
    NAME=${NAME##*/}
    sbatch map_reads.sh $i $REFGENOME
done


