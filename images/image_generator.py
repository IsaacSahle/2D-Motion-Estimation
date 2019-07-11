from PIL import Image, ImageOps, ImageDraw

x,y = (320,240)
cX, cY = (64,64)
shift = 30
bboxCurrent =  ((x/2 - cX/2) + shift, (y/2 - cY/2) + shift, (x/2 + cX/2) + shift, (y/2 + cY/2) + shift)
bboxReference = (x/2 - cX/2, y/2 - cY/2, x/2 + cX/2, y/2 + cY/2)
currentImage = Image.new("L", (x, y),color="black")
referenceImage = Image.new("L", (x, y),color="black")

cDraw = ImageDraw.Draw(currentImage)
rDraw = ImageDraw.Draw(referenceImage)

cDraw.ellipse(bboxCurrent, fill=255)
rDraw.ellipse(bboxReference, fill=255)

currentImage.save('current.png')
referenceImage.save('reference.png')