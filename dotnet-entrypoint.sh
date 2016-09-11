#!/bin/bash

#call useful embedded functions
#source /opt/bitnami/stacksmith-utils.sh
#print_welcome_page
#check_for_updates &

echo -e "Starting App"

#set app name to ENV or default
AP="dotnetapp"

if [ "$APP_NAME" != "" ]; then
    AP=$APP_NAME
fi

echo -e "Setting app name ... " , $AP

#set path to github user or default
#P="capescuba"
#if [ "$GITHUB_USER" != "" ]; then
#  P="github.com/$GITHUB_USER/$AP"
#else
#  P="$AP"
#fi


#echo "Using $P for git repo path"


echo -e "Checking for existing project ... "

#If the user does not pass in a git hub account and repo
#then create using a sample project
if [ -e ./project.json ]; then
    echo -e "Found existing asp.Net App, reusing"

    startAspDotNet

else

    #read -p "No user application supplied, would you like a default / sample Asp.Net app?  [y/n]" -n 1 -r
    #echo
    #if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo -e "Install default app ... "
    #fi
fi


function startAspDotNet {
    echo -e "Restoring dotnet app dependencies"
    dotnet restore

    echo -e "Running dotnet app"
    dotnet run
}