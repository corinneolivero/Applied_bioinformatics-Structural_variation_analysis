#!/bin/bash -l
#SBATCH -A naiss2023-5-114
#SBATCH -p core
#SBATCH -n 10
#SBATCH -t 06:00:00
#SBATCH -J Bowtie_parallell.sh
#SBATCH --mail-type=ALL
#SBATCH --mail-user corinne.olivero2@gmail.com

# Load modules
module load bioinfo-tools
module load bowtie2
module load samtools

# Reference genome path
REF="/crex/proj/snic2020-6-9/nobackup/AB_studentproj/Reference_genome/ncbi_dataset/data/GCF_010015445.1/my_reference_genome_index"

# Fastq files path
INPUT="/crex/proj/snic2020-6-9/nobackup/AB_studentproj/Genome"

OUTPUT_DIR="/crex/proj/snic2020-6-9/nobackup/AB_studentproj/Analysis/01_Genome_Alignment/Output/Bowtie2_test_output"
mkdir -p "$OUTPUT_DIR"

bowtie2 -x $REF -1 $INPUT/${i}_1.fq.gz -2 $INPUT/${i}_2.fq.gz -p 10 | samtools view -S -b | samtools sort -o $OUTPUT_DIR/${i}_bowtie2_sorted.bam
samtools index $OUTPUT_DIR/${i}_bowtie2_sorted.bam


