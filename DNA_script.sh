#!/bin/bash -l
#SBATCH -A naiss2023-5-114
#SBATCH -p core
#SBATCH -n 10
#SBATCH -t 10:00:00
#SBATCH -J DNA_script.sh
#SBATCH --mail-type=ALL
#SBATCH --mail-user corinne.olivero2@gmail.com

# Load modules
module load bioinfo-tools
module load mapdamage

INPUT="/crex/proj/snic2020-6-9/nobackup/AB_studentproj/Analysis/01_Genome_Alignment/Output/Bowtie2_test_output"
REF="/crex/proj/snic2020-6-9/nobackup/AB_studentproj/Reference_genome/GCF_010015445.1_GENO_Pfluv_1.0_genomic.fna"
LOG="/crex/proj/snic2020-6-9/nobackup/AB_studentproj/Analysis/02_DNA_Contamination"

# Indexing with samtools
samtools faidx $REF ind_ref

running_mapdamage() {
    OUTDIR="/crex/proj/snic2020-6-9/nobackup/AB_studentproj/Analysis/02_DNA_Contamination/Output"
    mkdir -p "$OUTDIR"
    mapDamage -i $INPUT/${i}_bowtie2_sorted.bam -r ind_ref -g 951300000 -p 10 -o $OUTDIR/${i}_mapDamage_output

}


# Filter files that start with "BT" or "spina"
for i in BT_* spina_*
do
    running_mapdamage "$i" &
done
wait

