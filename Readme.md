# OpenFoam231-docker
Please note that this repo reuses publicly available scripts and the following instruction created by OpenCFD. Scripts and the instruction were modified according to my needs and to run OpenFoam 2.3.1.

### This instruction assumes that you have a working docker on your system.

## How-to
Note that you may need to mark the install and start scripts as executable.

### 1. Run the prepareOpenFOAM231 script.
This will download an image from [ztnuaa/openfoam231](https://hub.docker.com/repository/docker/ztnuaa/openfoam231/general) and setup a container based on Ubuntu-18.04. The container has already installed the building environment to compile the OpenFOAM-2.3.1 following the guide from [OpenFOAM wiki](https://openfoamwiki.net/index.php/Installation/Linux/OpenFOAM-2.3.1/Ubuntu#Ubuntu_18.04) Step 1-4. Note, the qt environment for Paraview is not considered here.

### 2. To run OpenFoam run the "startOpenFOAM231" script.
This will start the openfoam231 container if it's stopped, or enter the container if it's already running.

### 4. Build OpenFOAM-2.3.1 and your own solvers/libraries.
The etc/bashrc of OpenFOAM-2.3.1 has been already sourced in the `docker run` command. If you have some environment variables, your should export it by yourself. To compile the OpenFOAM-2.3.1 source code, please follow the installation guide at [OpenFOAM-2.3.1 Ubuntu-18.04](https://openfoamwiki.net/index.php/Installation/Linux/OpenFOAM-2.3.1/Ubuntu#Ubuntu_18.04) Step 5~15. 

### 5. "Getting started" instruction from OpenFOAM website.
Use it to check if everything is working well.

Create a project directory within the $HOME/OpenFOAM directory named <USER>-2.2.2 (e.g. chris-2.2.2 for user chris and OpenFOAM version 2.2.2) and create a directory named run within it, e.g. by typing:

```bash
mkdir -p $FOAM_RUN
```
Copy across the backward facing step example, generate the mesh with blockMesh and run the steady flow, incompressible solver simpleFoam

```bash
cd $FOAM_RUN
cp -r $FOAM_TUTORIALS/incompressible/simpleFoam/pitzDaily .
cd pitzDaily
blockMesh
simpleFoam
paraFoam
```
