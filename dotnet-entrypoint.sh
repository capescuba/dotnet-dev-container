#!/bin/bash

#call useful embedded functions
#source /opt/bitnami/stacksmith-utils.sh
#print_welcome_page
#check_for_updates &

#Sets up and starts the ASP.Net Core Application Server
function startAspDotNet {
    echo -e "Restoring dotnet app dependencies"
    dotnet restore

    echo -e "Running dotnet app"
    dotnet run
}


echo -e "Starting App, Checking for existing project ..."


#If no ASP.Net app is found in the working directory then we clone the sample one
#otherwise just start the server
if [ -e ./project.json ]; then
    echo -e "Found existing asp.Net App, reusing"
    startAspDotNet
else
    echo -e "Install default app ... to  " ,$PWD
    git clone https://github.com/capescuba/dotnet-sample-proj.git $PWD -v --progress
    startAspDotNet
fi
