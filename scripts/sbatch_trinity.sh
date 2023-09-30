#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=1
#SBATCH --time=20:00:00
#SBATCH --job-name=trinity
#SBATCH --mem=100G
#SBATCH --partition=short
#SBATCH --exclusive
#SBATCH --output="batch-%x-%j.output"   # where to direct standard output; will be batch-jobname-jobID.output
#SBATCH --mail-type=ALL
#SBATCH --mail-user=yao.yao-@northeastern.edu 
# Usage: sbatch scripts/sbatch_trinity.sh 

# working environment set up
echo "Starting our analysis $(date)"
echo "Loading our BINF6308 Anaconda environment."
module load anaconda3/2021.11
source activate BINF-12-2021
echo "Loading samtools."
module load samtools/1.10

echo " Make directory for data files"
mkdir -p data/

# Create symbolic link to connect the sam and bam files from /home/yao.yao-/AiptasiaRNASeq/data/ to project/data folder 
echo "Link trimmed FASTQ files from home to working directory" 
ln -s /home/yao.yao-/AiptasiaRNASeq/data/trimmed/paired data/paired
ln -s /home/yao.yao-/AiptasiaRNASeq/data/trimmed/unpaired data/unpaired
echo "Link alignment files from home to working directory"
ln -s /home/yao.yao-/AiptasiaRNASeq/data/sam data/sam
ln -s /home/yao.yao-/AiptasiaRNASeq/data/bam data/bam

echo "Make directory for log files"
mkdir -p results/logs/

echo "Staring Guided Assembly $(date)"
echo "Merge all BAM alignment files $(date)"
bash scripts/mergeAll.sh 1>results/logs/$SLURM_JOB_NAME-$SLURM_JOB_ID-mergeAll.log 2>results/logs/$SLURM_JOB_NAME-$SLURM_JOB_ID-mergeAll.err

echo "Assemble the Guided Transcriptome $(date)"
bash scripts/runTrinity.sh 1>results/logs/$SLURM_JOB_NAME-$SLURM_JOB_ID-trinity_guided.log 2>results/logs/$SLURM_JOB_NAME-$SLURM_JOB_ID-trinity_guided.err

echo "Analyze the Guided Transcriptome $(date)"
bash scripts/analyzeTrinity.sh 1>results/$SLURM_JOB_NAME-$SLURM_JOB_ID-trinity_guided_stats.txt 2>results/logs/$SLURM_JOB_NAME-$SLURM_JOB_ID-analyzeTrinity.err

echo "Guided Assembly completed $(date)"

echo "Staring De Novo Assembly $(date)"
echo "Assemble the De Novo Transcriptome $(date)"
bash scripts/trinityDeNovo.sh 1>results/logs/$SLURM_JOB_NAME-$SLURM_JOB_ID-trinity_de_novo.log 2>results/logs/$SLURM_JOB_NAME-$SLURM_JOB_ID-trinity_de_novo.err

echo "Analyze the De Novo Transcriptome $(date)"
bash scripts/analyzeTrinityDeNovo.sh 1>results/$SLURM_JOB_NAME-$SLURM_JOB_ID-trinity_de_novo_stats.txt 2>results/logs/$SLURM_JOB_NAME-$SLURM_JOB_ID-analyzeTrinityDeNovo.err

echo "De Novo Assembly completed $(date)"

echo "Moving key files back to /home"
cp -r results/trinity_guided /home/yao.yao-/AiptasiaRNASeq/data/trinity_guided
cp -r results/trinity_de_novo /home/yao.yao-/AiptasiaRNASeq/data/trinity_de_novo
cp results/trinity*stats.txt /home/yao.yao-/AiptasiaRNASeq/data/

echo "Assemblies complete $(date)"
