
BINF 6308 Assignment8

# Project name: transcriptome assembly
The project demos the transcriptome assembly process by 
using third-party modules called Trinity, and in the end,
apply Perl to get the results of the statistical analyzation
in a text file from both De Novo assembly and reference-
guided assembly method for further comparison. 


## Description

This transcriptome assembly uses bam and FASTQ files derived
from the previous assignments 7; the assembled target is an
Aiptasia and the genome data are derived from the Illumina
MiSeq machine. We will follow the steps to finish our task. 


## Getting Started

* Hi, this is the documentation for assignment 8 of the bio-computational
  method course.
* That's start reference guided assembly project from the beginning, step
  by step, code by code.
* The working environment is under the Command line prompt, such as a Mac
  terminal or Ubuntu (with Bash script), so please prepare it in advance.   


### Dependencies

* Python version 3.8.10 and compatible modules (if needed)
* Trinity (including TrinityStats.pl)
* Samtools 1.10


### Installing

Install the third-party software above with specific dependencies
(if needed)


### Executing program

* Use the vim editor to prepare bash scripts for the following steps:

* Genome guided transcriptome assembly
  1. Use Samtools to merge all the bam files from assignments 7
  2. Apply the merged bam file to the transcriptome assembly
  3. Analyze the results by TrinityStats.pl to acquire basic 
     contigs information for evaluating transcription

* De Novo transcriptome assembly
  1. Use paired FASTQ files from assignments 7
  2. Apply those files for a de novo transcriptome assembly
  3. Analyze the results by TrinityStats.pl to acquire basic 
     contigs information for evaluating transcription

* In the end, make all scripts into one via the pipeline

  Here is the link of file: 
```
https://github.com/NU-Bioinformatics/module-08-YaoChiehYao.git
```


## Method
This transcriptome assembly project mainly uses Trinity, a third-party package, for assembling
and analyzing the targeted Aiptasia genome sequences. The trinity software has two methods 
genome-guided and de novo. Finally, we make use of them and, in the end, apply the statistic
module TrinityStats.pl to compare the result of the work.

* Samtools
 Samtools is a software to utilize the aligned sequence in SAM format via sort and index commands to
 arrange the assembly results into bam files(binary version of sam file) and give indexing to the bam
 as a bam.bai (bam indexing file) for further use. 

 Merge commands parameters: 
 - b list of an input bam file
 - input path of multiple bam files or one txt file includes all
 - output path of a merged bam file
 (reference: http://www.htslib.org/doc/samtools-merge.html Author: Heng Li from the Sanger Institute )

* Trinity
 An RNAseq transcriptome assembly tool for both Genome guided and De Novo methods. 
 The parameters are: 

  Reference-guided transcriptome assembly
  - genome_guided_bam (coordinate-sorted bam file for Trinity's reference)
  - genome_guided_max_intron 10000 (set this number base on your targeted organism)
  - resource set-up for the job (assign memory and cup requirement) 
  - output path
 
  De Novo transcriptome assembly
  - seqType (type of reads in fq  means FASTQ format)
  - output path
  - resource set-up for the job (assign memory and cup requirement) 
  - left (left read FASTQ files)
  - right (right read FASTQ files)
  (reference: https://manpages.ubuntu.com/manpages/bionic/man1/Trinity.1.html Author: UBUNTU forum)

* TrinityStats.pl
  It's a submodule in the Perl script of Trinity for analyzing the result of transcriptome assembly. 
  The parameters are: 
  - input file path (it takes Trinity-GG.fasta file as input)
  - output file path (it exports basic information of contigs and could save as a txt file)


## Conclusion
There are several methods to evaluate the quality of transcriptome assembly done by Trinity,
such as the followings: 

1. Use TransRate software to generate statistical results. (dev by Hibberd Lab and Kelly Lab)
2. Compute DETONATE scores. (dev by Deweylab)
3. compute contig length (N50 on the set of the transcript shows 90% of the expression data)
4. Use BUSCO(Benchmarking Universal Single-Copy Orthologs) to examine the completeness with 
   (Ezlab, Swiss)
5. Compare the assembly result to the protein database such as BLAST

Based on computing the contig length of both Genome guided and De Novo methods, they are both exemplary
assembly since the N50 value is higher than the average contigs. Among assemblers, the de novo method
was slightly prior than guided by comparing the number of transcripted genes and higher assembled base.    

(reference: https://github.com/trinityrnaseq/trinityrnaseq/wiki/Transcriptome-Assembly-Quality-Assessment Author: Brain Haas)


Here are the analyzed results: 
################################
### Genome guidede Trasncriptome Assembly**
################################
Total trinity 'genes':	28609
Total trinity transcripts:	30380
Percent GC: 38.57

########################################
Stats based on ALL transcript contigs:
########################################

	Contig N10: 1861
	Contig N20: 1286
	Contig N30: 954
	Contig N40: 728
	Contig N50: 570

	Median contig length: 349
	Average contig: 497.20
	Total assembled bases: 15105064


#####################################################
## Stats based on ONLY LONGEST ISOFORM per 'GENE':
#####################################################

	Contig N10: 1587
	Contig N20: 1102
	Contig N30: 823
	Contig N40: 640
	Contig N50: 514

	Median contig length: 340
	Average contig: 465.22
	Total assembled bases: 13309358


################################
### De Novo Trasncriptome Assembly
################################
Total trinity 'genes':	29094
Total trinity transcripts:	32646
Percent GC: 38.68

########################################
Stats based on ALL transcript contigs:
########################################

	Contig N10: 2029
	Contig N20: 1411
	Contig N30: 1044
	Contig N40: 784
	Contig N50: 603

	Median contig length: 343
	Average contig: 507.34
	Total assembled bases: 16562727


#####################################################
## Stats based on ONLY LONGEST ISOFORM per 'GENE':
#####################################################

	Contig N10: 1722
	Contig N20: 1162
	Contig N30: 852
	Contig N40: 651
	Contig N50: 513

	Median contig length: 326
	Average contig: 460.95
	Total assembled bases: 13410761


## Citations

1. Trimmomatic package citation:
Trinity RNAseq transcriptome assembly reference: 
Grabherr, M. G. M. G., Haas, B. J. B. J., Yassour, M. M., Levin, J. Z. J. Z., Thompson, D. A. D. A., Amit, I. I., Adiconis, X. X., Fan, L. L., Raychowdhury, R. R., Zeng, Q. Q., Chen, Z. Z., Mauceli, E. E., Hacohen, N. N., Gnirke, A. A., Rhind, N. N., di Palma, F. F., Birren, B. W. B. W., Nusbaum, C. C., Lindblad-Toh, K. K., … Regev, A. A. (2011). Trinity: reconstructing a full-length transcriptome without a genome from RNA-Seq data. Nature Biotechnology, 29(7), 644–652. https://doi.org/10.1038/nbt.1883
  
Trinity De Nove transcriptome assembly reference: 
Haas, B. J., Papanicolaou, A., Yassour, M., Grabherr, M., Blood, P. D., Bowden, J., Couger, M. B., Eccles, D., Li, B., Lieber, M., MacManes, M. D., Ott, M., Orvis, J., Pochet, N., Strozzi, F., Weeks, N., Westerman, R., William, T., Dewey, C. N., … Regev, A. (2013). De novo transcript sequence reconstruction from RNA-seq using the Trinity platform for reference generation and analysis. Nature Protocols, 8(8), 1494–1512. https://doi.org/10.1038/nprot.2013.084


2. Samtools packahe citation:
Li, H., Handsaker, B., Wysoker, A., Fennell, T., Ruan, J., Homer, N., Marth, G., Abecasis, G., & Durbin, R. (2009). The Sequence Alignment/Map format and SAMtools. Bioinformatics, 25(16), 2078–2079. https://doi.org/10.1093/bioinformatics/btp352


## Help

Any other issue contact with yao.yao-@northeastern.edu


## Authors

Yao Chieh Yao
Northeastern University Bioinformatics


## Version History

* 1.0
    * Assignment01 Finish 
* 0.1
    * Assignment01 Release 


## License

This project is an assignment work and only license to TA and professors of Northeastern University Bioinformatics 


## Acknowledgments


