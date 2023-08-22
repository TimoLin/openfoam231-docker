#----------------------------------*-sh-*--------------------------------------
# =========                 |
# \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
#  \\    /   O peration     |
#   \\  /    A nd           | 
#    \\/     M anipulation  | Copyright (C) 2016-2017 OpenCFD Ltd.
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
#     startOpenFOAM
#
# Description
#      This script will
#          1) Start the OpenFOAM container with name 'openfoam222'
#             in the the shell terminal. 
#          2) Post-processing: Users can launch paraview/paraFoam from the
#             terminal to post-process the results
#      Note
#          1) User should run xhost+ from other terminal
#          2) Docker daemon should be running before launching this script 
#          3) User can launch the script in a different shell to have
#             create the OpenFOAM environment in a different terminal
#
#------------------------------------------------------------------------------

dockerName=openfoam231

#docker start openfoam231 -i

# The docker container is created using name.
# Thus there will be only one container named as 

# Get current running openfoam231 docker container
container_id=$(docker ps -aqf "name=$dockerName")

# Get the openfoam231 container's status
container_status=$(docker container inspect -f '{{.State.Status}}' $dockerName)

echo $container_status

enterOF231()
{
    docker exec -it $container_id  /bin/bash
}

enterOF231root()
{
    docker exec -u root -it $container_id  /bin/bash
}

startOF231()
{
    docker start openfoam231 -i
}

# Handling different container status
# https://docs.docker.com/engine/reference/commandline/ps/#status
case $container_status in

    running)
        echo "Attaching container $dockerName:$container_id"
        enterOF231
        ;;
        
    created|exited|paused)
        echo "Starting container $dockerName:$container_id"
        startOF231
        ;;
esac

