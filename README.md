### What is?

This was supposed to be a fun little project that helps me learn Docker and stuff :(

### Commands 

```
docker build --no-cache -t sketch-artist:latest .
docker run --gpus all --runtime nvidia -it sketch-artist:latest

python3 sketch.py

docker ps -a
docker cp <container_id>:<file_path> <local_rel_path>
```