#!/bin/bash
#
# summary: script to convert bam file to sam file
#
#SBATCH -J bam_to_sam         # job name
#SBATCH -p eddy # partition (general,serial_requeue)
#SBATCH -n 1         # number of cores
#SBATCH -N 1         # number of nodes
#SBATCH --mem 8000           # memory pool for all cores
#SBATCH -t 0-03:00         # time (D-HH:MM)
#SBATCH -o ../log/bam_to_sam_%A.out          # STDOUT
#SBATCH -e ../log/bam_to_sam_%A.err         # STDERR

# load modules
source new-modules.sh
module load samtools/1.2-fasrc01

samtools view -h $1 > $2
