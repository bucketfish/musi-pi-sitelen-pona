# -*- coding: utf-8 -*-
from PIL import Image, ImageDraw, ImageFont
import sys

# Settings
W, H = (256, 256)

thing = bytes(sys.argv[1], 'ascii').decode("unicode-escape")
print(thing)
# Font
font = ImageFont.truetype("linja-sike.otf", 256, encoding='utf-8', layout_engine=ImageFont.LAYOUT_RAQM)

# Image
image = Image.new("RGBA", (W, H), "#00000000")
draw = ImageDraw.Draw(image)
offset_w, offset_h = font.getoffset(thing)
w, h = draw.textsize(thing, font=font)
pos = ((W-w-offset_w)/2, (H-h-offset_h)/2)

# Draw
draw.text(pos, thing, "white", font=font)

# Save png file
image.save("test.png")
