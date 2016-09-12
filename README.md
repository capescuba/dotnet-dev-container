

# Microsoft ASP.Net development using Bitnami Docker Images

We increasingly see developers adopting two strategies for development. Using a so called “micro services” architecture and using containers for development. At Bitnami, we have developed tools and assets that dramatically lower the overhead for developing with this approach.

If you’ve never tried to start a project with containers before, or you have tried it and found the advice, tools, and documentation to be chaotic, out of date, or wrong, then this tutorial may be for you.

In this tutorial we walk you through using the Bitnami docker images during the development lifecycle of a Microsoft ASP.Net Core Application.

# Why Docker?

We think developers are adopting containers for development because they offer many of the same advantages as developing in VMs, but with lower overhead in terms of developer effort and development machine resources. With Docker, you can create a development environment for your code, and teammates can pull the whole development environment, install it, and quickly get started writing code or fixing bugs.

Docker development environments are more likely to be reproducible than VMs because the definition of each container and how to build it is captured in a Dockerfile.

Docker also has a well known and standard API so tools and cloud services are readily available for docker containers.

# The Bitnami Approach

When we designed and built our development containers, we kept the following guiding principles in mind:

1. Infrastructure should be effort free. By this, we mean, there are certain services in an application that are merely configured. For example, databases and web servers are essential parts of an application, but developers should depend on them like plumbing. They should be there ready to use, but developers should not be forced to waste time and effort creating the plumbing.

2. Production deployment is a late bound decision. Containers are great for development. Sometimes they are great for production, sometimes they are not. If you choose to get started with Bitnami containers for development, it is an easy matter to decide later between monolithic and services architectures, between VMs and Containers, between Cloud and bare metal deployment. This is because Bitnami builds containers specifically with flexibility of production deployment in mind. We ensure that a service running in an immutable and well tested container will behave precisely the same as the same service running in a VM or bare metal.

# Assumptions

First, we assume that you have the following components properly setup:

- [Docker Engine](https://www.docker.com/products/docker-engine)
- [Docker Compose](https://www.docker.com/products/docker-compose)
- [Docker Machine](https://www.docker.com/products/docker-machine)

> The [Docker documentation](https://docs.docker.com/) walks you through installing each of these components.

We also assume that you have some beginner-level experience using these tools.

> **Note**:
>
> If your host OS is Linux you may skip setting up Docker Machine since you'll be able to launch the containers directly in the host OS environment.

## Download the Bitnami Orchestration File for Microsoft ASP.Net Core development

If you have an existing ASP.Net Core application, you will be able to use it with this container, otherwise we will `git clone` a sample project to get things running.
Let's start things off by creating a new directory for you container and application:

```bash
$ mkdir ~/workdir/myapp
$ cd ~/workdir/myapp
```

If you have an existing ASP.Net application, you have 2 options to use this. First, from with your new `myapp` directory, make a copy or `clone` into a new directory `dotnetapp`. e.g:

```bash
$ git clone someGitRepo dotnetapp
```

We will cover the second option in just a moment.

If you do not have a existing application, or do not copy anything to the `dotnetapp` folder a [sample application](https://github.com/capescuba/dotnet-sample-proj.git) will be cloned for you as part of the composition file execution.
You should feel free to fork from this repo as a starting point for your own project.

Next, download our Docker Compose orchestration file for Microsoft ASP.Net Core:

```bash
$ curl -L "https://raw.githubusercontent.com/capescuba/dotnet-dev-container/master/docker-compose.yml" > docker-compose.yml
```

## Run

Lets put the orchestration file to the test:

```bash
$ docker-compose up
```

This command reads the contents of the orchestration file and begins downloading the Docker images required to launch the service listed therein. Depending on the network speeds this can take anywhere from a few seconds to a couple minutes.

After the images have been downloaded, the service listed in the orchestration file is started, which in this case is the  `dotnetapp` service.

Once the Microsoft ASP.Net server has been started, visit port `5000` of the Docker Machine, or use `localhost:5000` in your favourite web browser and you'll be greeted by either by your code in the `dotnetapp` directory or the sample code will cloned for you.

Since the application source resides on the host, you can use your favourite IDE for developing the application. Only the execution of the application occurs inside the isolated container environment.

That’s all there is to it. Without actually installing a single Microsoft ASP.Net Core component on the host you have a completely isolated and highly reproducible Microsoft ASP.Net Core development environment which can be shared with the rest of the team to get them started building the next big feature without worrying about the plumbing involved in setting up the development environment. Let Bitnami do that for you.


As mentioned earlier a second way to use your existing ASP.Net code is available by editing the docker composition file. Open the `docker-compose.yml` file:

```
version: '2'

services:
  dotnetapp:
    image: capescuba/dotnet:v1.0.0
    ports:
      - 5000:5000
    volumes:
      - ./dotnetapp:/dotnetapp
```
 
To map your current project to the docker image simply edit the `volumes:` entry to point to your local folder, e.g.:
```
    volumes:
      - ./mycode/myAspDotNetApp:/dotnetapp
```


## Have at it:
Now your environment is ready to go, fire up your favourite code editor and have some fun. If you are new to Microsoft .Net, or want to find more information on using the open source / core features
[check out the documentation here.](https://docs.microsoft.com/en-us/dotnet/index)

===============================================================================

## TODO:

This is still very much a work in progress example and lacks a few things to make life a little easier as follows:

* Running the ASP.Net Server in the background
After running `docker-compose up` from your terminal, the shell is locked running the server. Some time needs to be spend looking into making the server run in the background. Simply adding `&` to the end of the command does not work.
This means that after any code changes you must stop and restart the container.
* Adding and example Database
The current code does not show how to use a Database as another service into docker via the composition file, however, it should be relatively painless to add in a new service something like:
```
version: '2'

services:
   mongodb:
    image: bitnami/mongodb:3.2.7-r2
  
  dotnetapp:
    image: capescuba/dotnet:v1.0.0
    environment:
      - CONNECTION_STRING=mongodb://mongodb:27017/my_app_development
    depends_on:
      - mongodb
    ports:
      - 5000:5000
    volumes:
      - ./dotnetapp:/dotnetapp
```

Here, as an example, we have added a Mongo Database as a service that can be referenced by the `CONNECTION_STRING` environment variable in the `dotnetapp` service
