#!/bin/bash
#SBATCH --partition=tiny
#SBATCH --nodes=1                # 1 computer nodes
#SBATCH --ntasks-per-node=32     # 32 MPI tasks on EACH NODE
#SBATCH --cpus-per-task=4        # 4 OpenMP threads on EACH TASK, i.e. 1x32x4=128 cores
#SBATCH --mem=3.5GB              # 440GB mem on EACH NODE
#SBATCH --time=5:00:00          # Time limit hrs:min:sec
#SBATCH --output=10qubits_%j.log      # Standard output
#SBATCH --error=10qubits_%j.err       # Standard error log
module load  intel/2020.2.254
module load  intelmpi/2019.8.254
MATLAB=/cm/shared/apps/maths/matlab/R2020b/bin/matlab
OUTPUT=/home/feiyanliu3/scratch/10qubits.output

cd /home/feiyanliu3/scratch/10qubits/1
mpirun -genv OMP_NUM_THREADS=4 -genv I_MPI_PIN=1 -genv OMP_PROC_BIND=true -genv OMP_PLACES=cores $MATLAB  < main.m > $OUTPUT

date >>$OUTPUT