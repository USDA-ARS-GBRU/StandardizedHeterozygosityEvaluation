# Standardized Heterozygosity Evaluation

We reckognized that there are numerous ways to calculate percent heterozygosity within a single individual and those reported numbers are often not comparable. We have established this as a documented method for utilization in the Hulse-Kemp Lab to calculate a % Heterozygosity value which can be comparable across different efforts.

Generally, we are utilizing whole genome assemblies which are becoming more complete as technology improves which enables giving a more robust assessment of genome-wide heterozygosity level that can be comparable across species.

### <ins>This method utilizes the following process:</ins>

1. Run nucmer alignment between finished haplotype level assemblies from a single organism.
2. Extract non-repetitive snps.
3. Count snps and divide by organism genome size.
4. Multiply by 100 to get to a % heterozygosity.
