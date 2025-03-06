# Code Source:https://huggingface.co/docs/diffusers/using-diffusers/inpaint
import PIL
from PIL import Image, ImageDraw
import requests
import torch
from io import BytesIO

from diffusers import DiffusionPipeline

# ========= Make pipelines =========
# init_pipeline = StableDiffusionPipeline.from_pretrained(
#     "runwayml/stable-diffusion-v1-5",
#     torch_dtype=torch.float16,
#     use_safetensors=True,
#     variant="fp16",
# )
init_pipeline = DiffusionPipeline.from_pretrained("segmind/tiny-sd", torch_dtype=torch.float16)
init_pipeline = init_pipeline.to("cuda")

# pipeline = StableDiffusionInpaintPipeline.from_pretrained(**init_pipeline.components)
pipeline = StableDiffusionInpaintPipeline.from_pretrained(
    "runwayml/stable-diffusion-inpainting",
    torch_dtype=torch.float16,
    use_safetensors=True,
    variant="fp16",
)
pipeline = pipeline.to("cuda")


# ========= Initial sketch =========
prompt = input("Initial prompt for sketch: ")
init_img = init_pipeline(prompt = prompt).images[0]
init_img = init_img.resize((512, 512))
init_img.show()
init_img.save()

while (True):

    # ========== User provides mask ==========
    # TODO: make this interactive with UI
    topleft_x, topleft_y = input("Top left corner of mask (x1, y1): ").split(", ")
    bottomright_x, bottomright_y = input("Bottom right corner of mask (x2, y2): ").split(", ")
    coords = [(int(topleft_x), int(topleft_y)), (int(bottomright_x), int(bottomright_y))]
    # display the mask
    draw = ImageDraw.Draw(init_img)
    draw.rectangle(coords, outline="red", width=5)
    init_img.show()

    # create mask
    # black background
    mask_img = Image.new("1", (512, 512))
    mask_draw = ImageDraw.Draw(mask_img)
    mask_draw.rectangle((512,512), fill="#000000")
    # white mask
    mask_draw.rectangle(coords, fill="#ffffff")
    mask_img.show()


    # ========= Inpainting =========
    prompt = input("What would you like to change in the mask?: ")
    # generate inpainted image
    new_image = pipeline(prompt=prompt, image=init_img, mask_image=mask_img).images[0]

    new_image.show()
    
    isEnd = "a"
    while (isEnd != "y" and isEnd != "n"):
        isEnd = input("Are you satisfied? (y/n)")
    if (isEnd == "y"):
        break