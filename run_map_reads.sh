#!/bin/bash
#
# filename: run_map_reads.sh
# summary: wrapper script to run a batch job for batch_map_reads.sh
# which is extrats reads information from sam files:
#

#inputs
DATA="/n/eddyfs01/pkoo/data/opticlobe/alignment/STAR2pass/TEST/"
REFGENOME="/n/eddyfs01/pkoo/data/opticlobe/reference_genome/dm6.fa" 


# submit jobs for all fastq files in DATA directory
for i in $DATA*.sam; do


    sbatch map_reads.sh $i $REFGENOME
done

