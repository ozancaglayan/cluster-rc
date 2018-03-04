#!/bin/bash
#SBATCH -N 1
#SBATCH -p gpu
#SBATCH --gres gpu:1
#SBATCH --job-name your-job-name
#SBATCH --time 02-00
#SBATCH --mem 20G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=<your mail prefix>@univ-lemans.fr

# Run your program(s)
hostname
date
taskset -cap $$
echo
nvidia-smi
