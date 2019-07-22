from PIL import Image, ImageOps, ImageDraw

x,y = (3200,2400)
cX, cY = (1000,1000)
shift = 100
bboxCurrent =  ((x/2 - cX/2) + shift, (y/2 - cY/2) + shift, (x/2 + cX/2) + shift, (y/2 + cY/2) + shift)
bboxReference = (x/2 - cX/2, y/2 - cY/2, x/2 + cX/2, y/2 + cY/2)
currentImage = Image.new("L", (x, y),color=46)
referenceImage = Image.new("L", (x, y),color=46)

cDraw = ImageDraw.Draw(currentImage)
rDraw = ImageDraw.Draw(referenceImage)

cDraw.ellipse(bboxCurrent, fill=115)
rDraw.ellipse(bboxReference, fill=155)

currentImage.save('./images/current-large.png')
referenceImage.save('./images/reference-large.png')
