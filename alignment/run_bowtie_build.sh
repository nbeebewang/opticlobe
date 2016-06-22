#!/bin/bash
#
# filename: run_bowtie_build.sh
# summary: script to submit batch job to build a genome index with Bowtie 2
#
#SBATCH -J BowTie2                      # job name
#SBATCH -p serial_requeue               # partition (general,serial_requeue)
#SBATCH -n 8                            # number of cores
#SBATCH -N 1                            # number of nodes
#SBATCH --mem 8000          	        # memory pool for all cores
#SBATCH -t 0-1:00                	    # time (D-HH:MM)
#SBATCH -o log/bowtiebuild_%A.out   	# STDOUT
#SBATCH -e log/bowtiebuild_%A.err     	# STDERR

# load modules
source new-modules.sh
module load bowtie2/2.2.4-fasrc01

# inputs
GENOME="/n/regal/eddy_lab/pkoo/opticlobe/reference_genome/dm6.fa"
#OUTPUT="/n/regal/eddy_lab/pkoo/opticlobe/reference_genome/dm6_bowtie_reference/dm6"

# make output directory <name>_bowtie_reference
GENOMENAME=${GENOME%.fa}
GENOMEDIR=$GENOMENAME"_bowtie_reference/"
if [ ! -d "$GENOMEDIR" ]; then
    echo "making directory " $GENOMEDIR
    mkdir $GENOMEDIR
    cp $GENOME $GENOMEDIR
fi
NAME=${GENOMENAME##*/}

# build bowtie genome index
bowtie2-build $GENOME $GENOMEDIR$NAME

