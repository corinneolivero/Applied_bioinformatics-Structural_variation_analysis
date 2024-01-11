#!/bin/bash -l
#SBATCH -A naiss2023-5-114
#SBATCH -p core
#SBATCH -n 10
#SBATCH -t 6:00:00
#SBATCH -J ${i}_manta.sh
#SBATCH --mail-type=ALL
#SBATCH --mail-user nelly.makinen.3552@student.uu.se
# Load modules
module load bioinfo-tools
module load manta/1.6.0
OUTPUT_DIR = /crex/proj/snic2020-6-9/nobackup/AB_studentproj/Analysis/03_SV_Analysis/Output/${i}_manta
mkdir -p "$OUTPUT_DIR"
#1. Generate config
/sw/bioinfo/manta/1.6.0/rackham/bin/configManta.py --bam "/crex/proj/snic2020-6-9/nobackup/AB_studentproj/Analysis/01_Genome_Alignment/Output/Bowtie2_test_output/${i}_bowtie2_sorted.bam" --referenceFasta "/crex/proj/snic2020-6-9/nobackup/AB_studentproj/Reference_genome/GCF_010015445.1_GENO_Pfluv_1.0_genomic.fna" --runDir "/crex/proj/snic2020-6-9/nobackup/AB_studentproj/Analysis/03_SV_Analysis/Output/${i}_manta"
#2. Run Manta Workflow
/crex/proj/snic2020-6-9/nobackup/AB_studentproj/Analysis/03_SV_Analysis/Output/${i}_manta/runWorkflow.py -m local -j 10
