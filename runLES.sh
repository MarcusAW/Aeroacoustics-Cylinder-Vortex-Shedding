#!/bin/bash
#SBATCH --job-name=CAAcylinder
#SBATCH --time=24:00:00
#SBATCH --ntasks=36
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=2G

module load OpenFOAM/v2106-foss-2021a
. ${FOAM_BASH}

mv 5000 RANS_0 
rm -r 0* 1* 2* 3* 4* 5* 6* 7* 8* 9* pro* post* acou*
cp -r RANS_0 0
rm -r 0/uniform
rm 0/force*
rm 0/y*
rm 0/phi
cp constant/turbulenceProperties_LES constant/turbulenceProperties
cp system/controlDict_LES system/controlDict
cp system/fvSchemes_LES system/fvSchemes
cp system/fvSolution_LES system/fvSolution
decomposePar
mpirun --mca btl ^openib -np 36 renumberMesh -overwrite -parallel
mpirun --mca btl ^openib -np 36 pimpleFoam -parallel



