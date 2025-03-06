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
