#!/bin/bash
#
# filename: batch_star2pass.sh
# summary: run the STAR aligner in 2-pass mode with arguments:
# 	<path_to_fastq> <path_to_reference_genome> <output_directory>
# example: sbatch batch_star2pass.sh  $DATAPATH $GENOMEPATH $OUTPUTPATH
#
#SBATCH -J STAR2pass						# job name
#SBATCH -p serial_requeue         			# partition (general,serial_requeue)
#SBATCH -n 8                            	# number of cores
#SBATCH -N 1                            	# number of nodes
#SBATCH --mem 32000                			# memory pool for all cores
#SBATCH -t 0-4:00                       	# time (D-HH:MM)
#SBATCH -o log/star2pass_%A.out   			# STDOUT
#SBATCH -e log/star2pass_%A.err     		# STDERR

#load modules -- assumes new modules in effect
source new-modules.sh
module load gcc/4.8.2-fasrc01 STAR/2.5.0c-fasrc01

mkdir -p log 

# perform alignment to reference genome
STAR \
--genomeDir $2 \
--genomeLoad NoSharedMemory \
--runThreadN 8 \
--readFilesIn $1 \
--readFilesCommand zcat \
--outFileNamePrefix $3 \
--outSAMtype BAM SortedByCoordinate \
--twopassMode Basic \
--twopass1readsN -1 \
--outFilterType BySJout \	
--outSAMunmapped Within
# --outFilterMultimapNmax 1 \
