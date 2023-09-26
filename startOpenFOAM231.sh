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
#          1) Get the status of the container with name 'openfoam231'
#          2) Start the OpenFOAM container with name 'openfoam231'
#             in the the shell terminal. 
#          3) Enter the container if it's running and start the container if it's
#             stopped.
#      Note
#          1) Docker daemon should be running before launching this script 
#          2) User can launch the script in a different shell to have
#             create the OpenFOAM environment in a different terminal
#
#------------------------------------------------------------------------------

dockerName=openfoam231

# If you want to use bash
#shellName=/bin/bash

# If you want to use zsh
shellName=/bin/zsh

# The docker container is created using name.
# Thus there will be only one container named as it

# Get current running openfoam231 docker container
container_id=$(docker ps -aqf "name=$dockerName")
if [ -z "$container_id" ]
then
    # The container is not created!
    echo "Error: Container $dockerName is not created!"
    echo "Note:  Please run prepareOpenFOAM231.sh first!"
    exit 1
else
    # Get the openfoam231 container's status
    container_status=$(docker container inspect -f '{{.State.Status}}' $dockerName)
    
    enterOF231()
    {
        docker exec -it $container_id  $shellName
    }
    
    enterOF231root()
    {
        docker exec -u root -it $container_id $shellName
    }
    
    startOF231()
    {
        docker start openfoam231 -i
    }
    
    # Handling different container status
    # https://docs.docker.com/engine/reference/commandline/ps/#status
    case $container_status in
    
        running)
            echo "Entering container $dockerName:$container_id..."
            enterOF231
            ;;
            
        created|exited|paused)
            echo "Starting container $dockerName:$container_id..."
            startOF231
            ;;
        *)
            echo "Please check the container $dockerName:$container_id status $container_status."
            exit 1
            ;;
    esac
fi
