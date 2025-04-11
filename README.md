# TL;DR?


Interact through CLI to generate an image and in-paint (modify) parts of the image until you're done!

> 📌  **Note:** 
> Meant to be run on a Jetson Orin Nano Developer Kit with updated firmware.
> https://developer.nvidia.com/embedded/learn/get-started-jetson-orin-nano-devkit#prepare

**Process:**
1. Describe an image
2. View the image 🤔 
    - (need to copy onto host machine)
3. Specify the (x,y) coordinates of a bounding box.
4. Describe the changes you want within the bounding box.
5. View the new image 👀 
    - (need to copy onto host machine again)
6. Repeat until you're satisfied :)

> ℹ️ **Info:** 
> Each image generation will take a few minutes 🫠


---

## Quick Start

1. Build docker container
```shell
docker build --no-cache -t sketch-artist:latest .
```

2. Run docker container
```shell
docker run --gpus all --runtime nvidia -it sketch-artist:latest
```

3. Within container, run the script
```shell
python3 sketch.py
```

4. Copy out the images folder onto your host machine.
(to view the images, as container has no easy method of viewing images)

```shell
# check all containers (`-a` for exited containers too)
docker ps -a

# recursively copy the imgs folder and contents into current working directory on host machine
# e.g., `docker cp b1a845f4f7ab:/sketch-artist/imgs/ .`
docker cp <container_id>:<file or dir path> <local_rel_path>

```

---
---

## Tech Stack
- diffusion pipeline
    - `segmind/tiny-sd`
- stable diffusion inpainting pipeline
    - `runwayml/stable-diffusion-inpainting`
- base docker image
    - `dustynv/l4t-pytorch:r36.4.0`
