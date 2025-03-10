#!/bin/bash
#SBATCH --job-name="mummer"
#SBATCH -p atlas
#SBATCH -n 48
#SBATCH --mem 374Gb
#SBATCH -t 1-10:00:00
#SBATCH --output="%x_%j.o" # job standard output file (%j replaced by job id)
#SBATCH --error="%x_%j.e" # job standard error file (%j replaced by job id)

module load mummer4

ref_pre=$(basename ${ref} ".gz")
que_pre=$(basename ${query} ".gz")

if [[ ${r_dir}/${ref} =~ .*\.gz ]]; then
	gunzip -c ${r_dir}/${ref} > ${TMPDIR}/${ref_pre}
else
	cp ${r_dir}/${ref} ${TMPDIR}/${ref_pre}
fi


if [[ ${q_dir}/${query} =~ .*\.gz ]]; then
        gunzip -c ${q_dir}/${query} > ${TMPDIR}/${que_pre}
else
        cp ${q_dir}/${query} ${TMPDIR}/${que_pre}
fi

nucmer --prefix=${out} ${TMPDIR}/${ref_pre} ${TMPDIR}/${que_pre}

# Non repeat snps
show-snps -Clr ${out}.delta > ${out}_nonrepeat.snps

module load samtools

# index the assemblies and get the column that has the contig lengths
samtools faidx ${TMPDIR}/${que_pre}
samtools faidx ${TMPDIR}/${ref_pre}
querysz=$(cut -f2 ${TMPDIR}/${que_pre}.fai | paste -sd+ | bc)
refsz=$(cut -f2 ${TMPDIR}/${ref_pre}.fai | paste -sd+ | bc)

# calculate the average genome sizes
avgsz=$(echo "("${querysz}"+"${refsz}")/2" | bc -l)

# count the number of snps, and then subtract out the five header lines
numsnp=$(wc -l ${out}_nonrepeat.snps | cut -f1 --delimiter=" ")
numsnp=$(echo $numsnp"-5" | bc)

# calculate the percent heterozygosity
hetperc=$(echo ${numsnp}"/"${avgsz}"*100" | bc -l)

# pretty format the calculation
# take snps and divide by genome size then multiply by 100 to get percent heterozygosity
printf "(%'.0f SNPs / %'.0f bp) x 100 = %0.4f%% heterozygosity\n" $numsnp $avgsz $hetperc
