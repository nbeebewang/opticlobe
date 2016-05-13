#!/bin/bash
#
# summary: runs mapreads.py script to get reads from sam file and store them in h5 files
#
#SBATCH -J map_reads         # job name
#SBATCH -p eddy # partition (general,serial_requeue)
#SBATCH -n 1         # number of cores
#SBATCH -N 1         # number of nodes
#SBATCH --mem 8000           # memory pool for all cores
#SBATCH -t 0-03:00         # time (D-HH:MM)
#SBATCH -o ../log/bam_to_sam_%A.out          # STDOUT
#SBATCH -e ../log/bam_to_sam_%A.err         # STDERR

# load modules
source new-modules.sh
source activate reads

python mapreads.py $1 $2
