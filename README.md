# Standardized Heterozygosity Evaluation

We reckognized that there are numerous ways to calculate percent heterozygosity within a single individual and those reported numbers are often not comparable. We have established this as a documented method for utilization in the Hulse-Kemp Lab to calculate a % Heterozygosity value which can be comparable across different efforts.

Generally, we are utilizing whole genome assemblies which are becoming more complete as technology improves which enables giving a more robust assessment of genome-wide heterozygosity level that can be comparable across species.

### <ins>This method utilizes the following process:</ins>

1. Run nucmer alignment between finished haplotype level assemblies from a single organism.
2. Extract non-repetitive snps.
3. Count snps and divide by organism genome size.
4. Multiply by 100 to get to a % heterozygosity.

```
module load mummer

query='assembly-1.fasta'
ref='assembly-2.fasta'
out='assembly-1_onto_assembly-2'

# Step 1 - nucmer alignment
nucmer --prefix=${out} ${ref} ${query}

# Step 2 - extract non-repeat snps
show-snps -Clr ${out}.delta > ${out}_nonrepeat.snps

# Step 3 - count the number of SNPS by counting the number of lines in the .snps file 
wc -l ${out}_nonrepeat.snps
```
Each SNP is on a single line in the .snps file. Subtract the 5 header lines to count the number of SNPs. Divide the number of SNPs by the genome size and multiply by 100 to get the percent heterozygosity. For example, if there are 4088858 lines in the .snps file and the chile pepper genome is 3.5 Gb then (4,088,853 SNPs / 3,500,000,000 bp) x 100 = **0.1168% heterozygosity.**
