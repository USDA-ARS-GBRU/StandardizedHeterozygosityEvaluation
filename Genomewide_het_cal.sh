#!/bin/bash
#SBATCH --job-name="mummer"
#SBATCH --partition=priority-mem --qos=gbru
#SBATCH -n 40
#SBATCH -t 1-10:00:00
#SBATCH --output="%x_%j.o" # job standard output file (%j replaced by job id)
#SBATCH --error="%x_%j.e" # job standard error file (%j replaced by job id)


module load mummer

# Query
q_dir='STEP_5/YakHifi_HDA149_B5/'
query='ragtag.scaffold.fasta'

# Reference
r_dir='STEP_5/YakHifi_HDA330_B5/'
ref='ragtag.scaffold.fasta'

out='YakHifi_HDA149_B5_onto_YakHifi_HDA149_B5'

nucmer --prefix=${out} ${r_dir}/${ref} ${q_dir}/${query}

# Non repeat snps
show-snps -Clr ${out}.delta > ${out}_nonrepeat.snps

#count the snps
wc -l YakHifi_HDA149_B5_onto_YakHifi_HDA149_B5_nonrepeat.snps | awk '{print $1-5}'

#take snps and divide by genome size then multiply by 100 to get percent heterozygosity
