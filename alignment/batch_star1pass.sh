#!/bin/bash
#
# filename: batch_star1pass.sh
# summary: run the STAR aligner in 1-pass mode with arguments: 
#	<path_to_fastq> <path_to_reference_genome> <output_directory>
# example: sbatch batch_star1pass.sh $DATAPATH $GENOMEPATH $OUTPUTPATH
#
#SBATCH -J STAR1pass							# job name
#SBATCH -p serial_requeue        				# partition (general,serial_requeue)
#SBATCH -n 8                            		# number of cores
#SBATCH -N 1                            		# number of nodes
#SBATCH --mem 32000                				# memory pool for all cores
#SBATCH -t 0-2:00                       		# time (D-HH:MM)
#SBATCH -o log/star1pass_%A.out   				# STDOUT
#SBATCH -e log/star1pass_%A.err     			# STDERR

# load modules
source new-modules.sh
module load gcc/4.8.2-fasrc01 STAR/2.5.0c-fasrc01

# perform alignment to reference genome
STAR \
--genomeDir $2 \
--genomeLoad NoSharedMemory \
--runThreadN 8 \
--readFilesIn $1 \
--readFilesCommand zcat \
--outFileNamePrefix $3 \
--outSAMtype BAM SortedByCoordinate \
--outFilterType BySJout
# --outFilterMultimapNmax 1 \

