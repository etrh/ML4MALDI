#!/bin/bash
#PBS -N tSNEParallel
#PBS -l select=1:ncpus=350:mem=500gb:scratch_local=5gb
#PBS -l walltime=96:00:00
#PBS -m ae
# The 4 lines above are options for scheduling system: job will run 96 hours at maximum, 1 machine with 350 processors, 500GB RAM + 5GB scratch SSD, email notification will be sent when the job aborts (a) or ends (e)

trap 'clean_scratch' TERM EXIT

# define a DATADIR variable: directory where the input files are taken from and where output will be copied to
#DATADIR=/storage/brno3-cerit/home/$USER/ # substitute username and path to to your real username and path
#MYIN=/storage/brno3-cerit/home/$USER/tSNEjob/
#MYR=metacentrum_tSNE.R
#MYOUT=/storage/brno3-cerit/home/$USER/tSNEjob/OUT

# append a line to the file "jobs_info.txt" containing the ID of the job, the hostname of node it is run on and the path to a scratch directory
# this information helps to find a scratch directory in case the job fails and you need to remove the scratch directory manually
echo "$PBS_JOBID is running on node `hostname -f` in a scratch directory $SCRATCHDIR" >> ~/jobs_info.txt

#load R
#module add R-4.0.0-intel-centos

#activate anaconda
source ~/.bashrc
conda activate ml

# test if scratch directory is set
# if scratch directory is not set, issue error message and exit
test -n "$SCRATCHDIR" || { echo >&2 "Variable SCRATCHDIR is not set!"; exit 1; }

# copy required input files to scratch directory
# if the copy operation fails, issue error message and exit
cp tsne.db  $SCRATCHDIR || { echo >&2 "Error while copying input file(s)!"; exit 2; }
cp metacentrum_TSNE.py $SCRATCHDIR

# move into scratch directory
cd $SCRATCHDIR || exit 2
#cp -r $MYIN/* .
#cd ~

#export R_LIBS="/storage/brno3-cerit/home/$USER/R/x86_64-pc-linux-gnu-library/4.0/"
#R -q --vanilla < $MYR > $MYR.output
#copy everything to MYOUT
#cp -r * $MYOUT/

echo "`which python`" >> ~/python_info.txt

python metacentrum_TSNE.py
cp tsne_done.env /storage/brno3-cerit/home/$USER/tsne_out/

# clean the SCRATCH directory
clean_scratch

