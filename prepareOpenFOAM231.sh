#----------------------------------*-sh-*--------------------------------------
# =========                 |
# \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
#  \\    /   O peration     |
#   \\  /    A nd           | Copyright (C) 2016-2017 OpenCFD Ltd. 
#    \\/     M anipulation  |
#------------------------------------------------------------------------------
# License
#     This file is part of OpenFOAM.
#
#     OpenFOAM is free software: you can redistribute it and/or modify it
#     under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
#
#     OpenFOAM is distributed in the hope that it will be useful, but WITHOUT
#     ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#     FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
#     for more details.
#
#     You should have received a copy of the GNU General Public License
#     along with OpenFOAM.  If not, see <http://www.gnu.org/licenses/>.
#
# File
#     prepareOpenFOAM
#
# Description
#     this script will
#     1) Pull openfoam231 from docker hub if it does not exist in the local
#        environment 
#     2) Create a container with the name openfoam231 in Ubuntu 18.04
#     3) Image is loaded with the building enviromnment for OpenFOAM-2.3.1
#     4) See building & installation guide at:
#        https://openfoamwiki.net/index.php/Installation/Linux/OpenFOAM-2.3.1/Ubuntu#Ubuntu_18.04
#
#     Note: Docker daemon should be running before  launching script 
#
#------------------------------------------------------------------------------

username="$USER"
user="$(id -u)"
home="${1:-$HOME}"
ofHome="$home/OpenFOAM"

imageName="ztnuaa/openfoam231:latest"
containerName="openfoam231"   
displayVar="$DISPLAY"

# OpenFOAM enviroment list

# List container name :
echo "*******************************************************"
echo "Following Docker containers are present on your system:"
echo "*******************************************************"
docker ps -a 

echo WM_CC

# Create docker container for OpenFOAM operation   
echo "*******************************************************"
echo ""
echo "Creating Docker OpenFOAM container ${containerName}"

docker run  -it -d --name ${containerName} --user=${user}   \
    -e USER=${username}                                     \
    --workdir="$home"                                       \
    --volume="$ofHome:$ofHome"                              \
    --volume="/etc/group:/etc/group:ro"                     \
    --volume="/etc/passwd:/etc/passwd:ro"                   \
    --volume="/etc/shadow:/etc/shadow:ro"                   \
    --volume="/etc/sudoers:/etc/sudoers:ro"                 \
    --volume="/etc/sudoers.d:/etc/sudoers.d:ro"             \
    ${imageName}                                            \
     /bin/bash --rcfile $ofHome'/OpenFOAM-2.3.1/etc/bashrc'

echo "Container ${containerName} was created."

echo "*******************************************************"
echo "Run the ./startOpenFOAM script to launch container"
echo "*******************************************************"
