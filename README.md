# COMP3311

Only my solution of exercise and practices exercise

## Pre-requisite

You can easily set up the postgres environment by [docker](https://docs.docker.com/install/). You may need an account for [docker registry](https://www.docker.com/) to pull the server image (or you can use another registry like aliyun's or 163's).

```bash
docker run --name my-postgres -p 5432:5432 -e POSTGRES_PASSWORD=apple123 -d postgres
```

You may need `sudo` to run this command (etc. in Fedora), but in latest ubuntu, it's not required.  
Then you can control the postgres server by:

```bash
docker start my-postgres
docker stop my-postgres
```

And, connect to the postgres by

```bash
./connect
```
