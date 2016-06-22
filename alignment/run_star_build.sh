#!/bin/bash
#
# filename: run_star_build.sh
# summary: script to run STAR genome generate with a reference 
# genome and reference annotation
#
#SBATCH -J STARbuild                    # job name
#SBATCH -p serial_requeue               # partition (general,serial_requeue)
#SBATCH -n 4                            # number of cores
#SBATCH -N 1                            # number of nodes
#SBATCH --mem 16000                     # memory pool for all cores
#SBATCH -t 0-2:00                       # time (D-HH:MM)
#SBATCH -o log/starbuild_%A.out         # STDOUT
#SBATCH -e log/starbuild_%A.err         # STDERR

# load modules 
source new-modules.sh
module load gcc/4.8.2-fasrc01 STAR/2.5.0c-fasrc01

# inputs
GENOME="/n/eddyfs01/pkoo/data/opticlobe/reference_genome/dm6.fa"
ANNOTATION="/n/eddyfs01/pkoo/data/opticlobe/reference_annotation/dm6_Ensembl.gtf"

# make output directory for indexed reference genome
GENOMENAME=${GENOME.fa}
GENOMEDIR=$GENOMENAME"_reference/"
if [ ! -d "$GENOMEDIR" ]; then
    echo "making directory "$GENOMEDIR
    mkdir $GENOMEDIR
fi

STAR \
--runMode genomeGenerate \
--runThreadN 8 \
--genomeDir $GENOMEDIR \
--genomeFastaFiles $GENOME \
--sjdbGTFfile $ANNOTATION \
--sjdbOverhang 99
