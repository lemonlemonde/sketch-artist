# Code Source:https://huggingface.co/docs/diffusers/using-diffusers/inpaint
import PIL
import requests
import torch
from io import BytesIO

from diffusers import StableDiffusionInpaintPipeline

pipeline = StableDiffusionInpaintPipeline.from_pretrained(
    "runwayml/stable-diffusion-inpainting",
    torch_dtype=torch.float16,
    use_safetensors=True,
    variant="fp16",
)
# pipeline = pipeline.to("cuda")


# Code Source: https://huggingface.co/docs/diffusers/using-diffusers/inpaint
def download_image(url):
    response = requests.get(url)
    return PIL.Image.open(BytesIO(response.content)).convert("RGB")

img_url = "https://raw.githubusercontent.com/CompVis/latent-diffusion/main/data/inpainting_examples/billow926-12-Wc-Zgx6Y.png"
mask_url = "https://raw.githubusercontent.com/CompVis/latent-diffusion/main/data/inpainting_examples/billow926-12-Wc-Zgx6Y_mask.png"

init_image = download_image(img_url).resize((512, 512))
mask_image = download_image(mask_url).resize((512, 512))


prompt = "Two puppies wearing red hats"

new_image = pipeline(prompt=prompt, image=init_image, mask_image=mask_image).images[0]


new_image

# from diffusers import DiffusionPipeline

# pipe = DiffusionPipeline.from_pretrained("stable-diffusion-v1-5/stable-diffusion-inpainting")

# prompt = "Astronaut in a jungle, cold color palette, muted colors, detailed, 8k"
# image = pipe(prompt).images[0]