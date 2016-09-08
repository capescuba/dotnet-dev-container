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
