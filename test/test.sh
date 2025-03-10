# generate the mutated genome

# bgzip At_mito.fasta1~wget https://www.ebi.ac.uk/ena/browser/api/fasta/Y08501.2?download=true
# mv 'Y08501.2?download=true' At_mito.fasta
# bgzip At_mito.fasta

# mutate.sh subrate=0.012345 indelrate=0 in=At_mito.fasta.gz out=At_mito.mut.fasta.gz

#Target Identity:        98.77%
#Substitution Rate:      1.23%
#Indel Rate:             0.00%

# submit like this on ATLAS
sbatch --account="PROJECTNAME" \
	--export=q_dir="~/StandardizedHeterozygosityEvaluation/test",query="At_mito.mut.fasta.gz",r_dir="~/StandardizedHeterozygosityEvaluation/test",ref="At_mito.fasta.gz",out="test_mito" \
	 Genomewide_het_cal.atlas.sh
