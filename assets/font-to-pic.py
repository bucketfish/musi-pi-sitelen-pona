# -*- coding: utf-8 -*-
from PIL import Image, ImageDraw, ImageFont


# Settings
W, H = (256, 256)

# Font
font = ImageFont.truetype("linja-sike.otf", 256, encoding='utf-8', layout_engine=ImageFont.LAYOUT_RAQM)

# Image
image = Image.new("RGBA", (W, H), "#00000000")
draw = ImageDraw.Draw(image)
offset_w, offset_h = font.getoffset("\uE662")
w, h = draw.textsize("\uE662", font=font)
pos = ((W-w-offset_w)/2, (H-h-offset_h)/2)

# Draw
draw.text(pos, "\uE662", "white", font=font)

# Save png file
image.save("test.png")
