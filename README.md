# docker_xscf_build

Get the latest published docker container from Hub.Docker [https://hub.docker.com/r/alunde/xscf_build](https://hub.docker.com/r/alunde/xscf_build)
```
docker pull alunde/xscf_build
```

Small docker containing xs and cf command line and build tools (customize for your own needs)

```
git clone 
cd /Users/<userid>/Documents/Projects/docker_xscf_build
docker build --no-cache -t alunde/xscf_build:latest .
docker build -t alunde/xscf_build:latest .
docker run -ti -p 22:22 alunde/xscf_build:latest
docker push alunde/xscf_build:latest
```
Kill running container
```
export dockid=$(docker container ls | grep  xscf_build | cut -d ' ' -f 1) ; echo $dockid ; docker container stop $dockid

```

Connect with:
```
vi  /Users/<userid>/.ssh/known_hosts ; echo "Root PW is" ; echo "" ; echo "Nirvana8484" ; echo "" ; ssh root@localhost
ssh root@localhost
```
