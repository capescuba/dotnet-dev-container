## BUILDING
##   (from project root directory)
##   $ docker build -t debian-for-capescuba-dotnet-dev-container .
##
## RUNNING
##   $ docker run debian-for-capescuba-dotnet-dev-container

FROM gcr.io/stacksmith-images/debian-buildpack:wheezy-r9

MAINTAINER Bitnami <containers@bitnami.com>

ENV STACKSMITH_STACK_ID="6ea9876" \
    STACKSMITH_STACK_NAME="Debian for capescuba/dotnet-dev-container" \
    STACKSMITH_STACK_PRIVATE="1"

## STACKSMITH-END: Modifications below this line will be unchanged when regenerating

##Add the dotnet core
FROM microsoft/dotnet

#Copy local files
COPY . /dotnetapp
WORKDIR /dotnetapp

#copy and set the entrypoint
COPY ./dotnet-entrypoint.sh /
ENTRYPOINT ["/dotnet-entrypoint.sh"]

#Expose port 5000 and set env variables for the ASP.Net Core Server
EXPOSE 5000/tcp
ENV ASPNETCORE_URLS http://*:5000
