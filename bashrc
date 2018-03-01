# Set prompt string to show time left for srun
if [ ! -z $SLURM_JOB_ID ]; then
  PS1='(`squeue -hj $SLURM_JOB_ID -o "%L"` left) '$PS1
fi

slc() {
  # slc: SLURM CPU
  # Give a shell for 5 hours, 4GB RAM and 1 Core (any node)
  srun -n1 --time 05:00:00 --mem 4G $@ --pty $SHELL
}

slg() {
  # slg: SLURM GPU
  # Give a shell for 5 hours, 4GB RAM, 1 GPU and 1 Core (any node)
  srun -n1 --time 05:00:00 --mem 4G -p gpu --gres gpu:1 $@ --pty $SHELL
}

slcm() {
  # slcm: SLURM CPU MACHINE (you should give the machine name)
  # Give a shell for 5 hours, 4GB RAM and 1 Core from a specific node
  # Example: slcm cpu01
  #          slcm gpu05
  #          slcm gpu05 --time 02:00:00 --mem 10G (override defaults)
  MACH=$1
  shift 1
  srun -n1 --time 05:00:00 --mem 4G -w $MACH -p cpu,gpu $@ --pty $SHELL
}

slgm() {
  # slgm: SLURM GPU MACHINE (you should give the machine name)
  # Same as slcm but will also allocate 1 GPU
  # Example: slgm gpu05
  #          slgm gpu05 --time 02:00:00 --mem 10G (override defaults)
  MACH=$1
  shift 1
  srun -n1 --time 05:00:00 --mem 4G -w $MACH -p gpu --gres gpu:1 $@ --pty $SHELL
}

sljup() {
  if [ -z $1 ]; then
    echo "You need to give gpu or cpu as argument."
  else
    PARTITION=$1
    shift 1
    srun -p "$PARTITION" -n 1 $@ ~/.cluster-rc/bin/slurm-jupyter
  fi
}


###############
# SINFO aliases
###############
# Detailed sinfo
alias si="sinfo -o '%8P %10n %.11T %.4c %.8z %.6m %12G %10l %10L %10O %20E' -S '-P'"
# sinfo only on CPU partition
alias sic="sinfo -p cpu -o '%10n %.11T %.4c %.8z %.6m %10l %10L %10O %30E' -S 'T'"
# sinfo only on GPU partition
alias sig="sinfo -p gpu -o '%10n %.11T %.4c %.8z %.6m %12G %10l %10L %10O %30E' -S 'T'"

################
# SQUEUE aliases
################
# Detailed squeue
alias sq="squeue -Su -o '%8i %10u %20j %4t %5D %20R %15b %3C %7m %11l %11L'"
# squeue only on CPU partition
alias sqc="squeue -p cpu -Su -o '%8i %10u %20j %4t %5D %20R %3C %7m %11l %11L'"
# squeue only your jobs
alias squ="sq -u `id -un`"
# squeue only on GPU partition
alias sqg="sq -p gpu"

#######################################################
# SSTAT alias to get information about your RUNNING job
# Usage: sst <jobid>
#     OR sst <jobid>.batch (if you use SBATCH and do
#                           not use SRUN inside)
#######################################################
alias sst='sstat -a --format=JobID,NTasks,AveCPU,AveCPUFreq,AveRSS,MaxRSS,MaxDiskRead,MaxDiskWrite -j'

###############
# SACCT aliases
###############
# Show my currently running jobs
alias sacr='sacct --units=G -s R --format="JobId%10,JobName,ReqMem%6,AllocTRES%35,MaxRSS,Start,End"'
alias sac='sacct --units=G --format="Partition,JobId%10,JobName%20,AllocTRES%30,ReqMem%10,MaxRSS,TimeLimit,Elapsed,End,State"'
alias saca='sacct --units=G -a --format="User,JobId%10,JobName,ReqMem%6,AllocTRES%30,MaxRSS,ExitCode%4,State,Start,End"'
alias sacf='sacct --units=G -S 00:00:00 -s f,ca,to,nf,dl --format="JobId%10,JobName%20,ReqMem%7,MaxRSS,AllocTres%50,State%20"'

##########
# SCONTROL
##########
# scontrol show job -dd <jobid>
alias scj='scontrol show job -dd'
# writes batch script to a file for a running job
alias scwb='scontrol write batch_script'
