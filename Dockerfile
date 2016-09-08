## BUILDING
##   (from project root directory)
##   $ docker build -t node-js-for-bitnami-bitnami-docker-express .
##
## RUNNING
##   $ docker run -p 3000:3000 node-js-for-bitnami-bitnami-docker-express
##
## CONNECTING
##   Lookup the IP of your active docker host using:
##     $ docker-machine ip $(docker-machine active)
##   Connect to the container at DOCKER_IP:3000
##     replacing DOCKER_IP for the IP of your active docker host

FROM gcr.io/stacksmith-images/ubuntu-buildpack:14.04-r9

MAINTAINER Bitnami <containers@bitnami.com>

ENV STACKSMITH_STACK_ID="3k5lftf" \
    STACKSMITH_STACK_NAME="Node.js for bitnami/bitnami-docker-express" \
    STACKSMITH_STACK_PRIVATE="1"

RUN bitnami-pkg install node-6.5.0-0 --checksum 52cb7f26dff5661fadb0d3ca50ff4e267b746604a935b3299c3a9383104d0055

ENV PATH=/opt/bitnami/node/bin:/opt/bitnami/python/bin:$PATH \
    NODE_PATH=/opt/bitnami/node/lib/node_modules

## STACKSMITH-END: Modifications below this line will be unchanged when regenerating

# ExpressJS template
ENV BITNAMI_APP_NAME=express
ENV BITNAMI_IMAGE_VERSION=4.14.0-r1

RUN npm install -g express-generator@4

COPY rootfs/ /

# The extra files that we bundle should use the Bitnami User
# so the entrypoint does not have any permission issues
RUN chown -R bitnami:bitnami /app_template

USER bitnami
# This will add an specific version of Express that will validate the package.json requirement
# so we will not download any other version
# It also generates the cache in ~/.npm
RUN mkdir ~/test_app && cd ~/test_app &&\
 npm install express@4.14.0 &&\
 express -f . && npm install && sudo rm -rf /tmp/npm* ~/test_app

WORKDIR /app
EXPOSE 3000

ENTRYPOINT ["/app-entrypoint.sh"]
CMD ["npm", "start"]
