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

module load samtools

# index the assemblies and get the column that has the contig lengths
samtools faidx ${query}
samtools faidx ${ref}
querysz=$(cut -f2 ${query}.fai | paste -sd+ | bc)
refsz=$(cut -f2 ${ref}.fai | paste -sd+ | bc)

# calculate the average genome sizes
avgsz=$(echo "("${genomesize1}"+"${genomesize2}")/2" | bc -l)

# count the number of snps, and then subtract out the five header lines
numsnp=$(wc -l ${out}_nonrepeat.snps | cut -f1 --delimiter=" ")
numsnp=$(echo $numsnp"-5" | bc)

# calculate the percent heterozygosity
hetperc=$(echo ${numsnp}"/"${avgsz}"*100" | bc -l)

# pretty format the calculation
# take snps and divide by genome size then multiply by 100 to get percent heterozygosity
printf "(%'.0f SNPs / %'.0f bp) x 100 = %0.4f%% heterozygosity\n" $numsnp $avgsz $hetperc
