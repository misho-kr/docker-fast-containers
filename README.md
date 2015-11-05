Useful Docker Containers
========================

Dockerized servers, databases, web servers, etc. that are quick to launch with a single command.

Better to pull a Docker image and start a container, instead of installing one or more software packages that will clutter your machine and will run as regular (unrestricted) processes.

* Jenkins
* MongoDB
* MySQL
* Nginx
* Redis
* Tomcat
* Zabbix

### Usage

All Docker containers are started with [docker-compose](https://docs.docker.com/compose). As a consequence the command to bring up any container is boringly repetitious:

```bash
$ docker-compose -f containers/mongo.yml up
Creating containers_mongo_1...
Pulling image mongo:2.6...
2.6: Pulling from library/mongo
ba249489d0b6: Pull complete
...
mongo26_1 | 2015-09-18T03:18:32.354+0000 [initandlisten] waiting for connections on port 27017
```

### SELinux requirement

Most containers will mount the __data__ directory to externalize and preserve the state (any data and log files) after shutdown. On systems with [SELinux](https://en.wikipedia.org/wiki/Security-Enhanced_Linux) in enforcing mode [the bind-mount will fail](http://www.projectatomic.io/blog/2015/06/using-volumes-with-docker-can-cause-problems-with-selinux) unless this command has been executed in advance:

```bash
$ chcon -Rt svirt_sandbox_file_t data
```

### Jenkins as non-root user

The Jenkins process inside the Docker container can be run as either __root__ or __jenkins__ user. From security perspective it is better to choose the latter, however that presents a challenge due to the bind-mounted Jenkins workspace directory.

The solution is to set up the Jenkins workspace directory on the Docker host in advance before it is attached to the container:

```bash
$ mkdir data/jenkins.dir
$ sudo chown $(docker run --rm jenkins echo $(id -u):$(id -g)) data/jenkins.dir 
$ docker-compose -f containers/jenkins.yml up jenkins
```

If you don't want to play this trick then just start the container with the Jenkins process as __root__ user:

```bash
$ docker-compose -f containers/jenkins.yml up jenkins-root
```

