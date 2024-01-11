#!/bin/bash -l
#SBATCH -A naiss2023-5-114
#SBATCH -p core
#SBATCH -n 10
#SBATCH -t 10:00:00
#SBATCH -J DNA_script.sh
#SBATCH --mail-type=ALL
#SBATCH --mail-user nelly.makinen.3552@student.uu.se
# Load modules
module load bioinfo-tools
module load mapDamage
module load samtools
INPUT="/crex/proj/snic2020-6-9/nobackup/AB_studentproj/Analysis/01_Genome_Alignment/Output/Bowtie2_test_output"
REF="/crex/proj/snic2020-6-9/nobackup/AB_studentproj/Reference_genome/GCF_010015445.1_GENO_Pfluv_1.0_genomic.fna"
LOG="/crex/proj/snic2020-6-9/nobackup/AB_studentproj/Analysis/02_DNA_Contamination"
OUTDIR="/crex/proj/snic2020-6-9/nobackup/AB_studentproj/Analysis/02_DNA_Contamination/"
mkdir -p "$OUTDIR/Output_${i}"
mapDamage -i $INPUT/${i}_bowtie2_sorted.bam -d $OUTDIR/Output_${i} -r $REF
