#!/bin/bash
#SBATCH --job-name=CAAcylinder_mesh
#SBATCH --time=24:00:00
#SBATCH --ntasks=36
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=2G

module load OpenFOAM/v2106-foss-2021a
. ${FOAM_BASH}

rm -r 0* 1* 2* 3* 4* 5* 6* 7* 8* 9* pro* post* acou*
cp -r C0.orig 0
cp constant/turbulenceProperties_RANS constant/turbulenceProperties
blockMesh
refineWallLayer cylinder 0.5 -overwrite
cp system/controlDict_RANS system/controlDict
cp system/fvSchemes_RANS system/fvSchemes
cp system/fvSolution_RANS system/fvSolution
decomposePar
mpirun --mca btl ^openib -np 32 renumberMesh -overwrite -parallel
mpirun --mca btl ^openib -np 32 simpleFoam -parallel
reconstructPar


