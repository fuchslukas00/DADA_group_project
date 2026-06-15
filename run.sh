#!/usr/bin/bash
#SBATCH --job-name=gbm_fraw
#SBATCH --partition=clara
#SBATCH --time=04:00:00
#SBATCH --tres-per-task=cpu=4
#SBATCH --mem=32G
#SBATCH --output=gbm_%j.out
#SBATCH --error=gbm_%j.err

source ~/.bashrc
conda activate r-DADA

which R
which Rscript

Rscript train_gbm_year.R