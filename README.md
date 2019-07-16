# 2D Motion Estimation in Video Frames

Motion estimation includes the process of determining the motion vectors of different areas in the frame being encoded.
Typically, motion estimation is very computationally demanding, so it is the bottleneck in MPEG video encoding.

## Basic Theory of Motion Estimation

- Find similarities between video frames and exploit this to achieve high compression rates
- Code only the relative movement of current frame to reference frame
- Use Sum of Absolute Differences (SAD) as the measurement metric
- SAD typically computed for 16x16 blocks

## Our Program

Our program will take in two images, one being the current and the other a reference image, and will output the motion vector and differences in the images.
It will also output the minimum SAD value.

Example current and reference images:

#### Current Image

![current](https://user-images.githubusercontent.com/28017034/61314897-7de9c380-a7b2-11e9-87f3-a66dd2a2cd9e.png)

#### Reference Image

![reference](https://user-images.githubusercontent.com/28017034/61314900-80e4b400-a7b2-11e9-9188-62c3cad5de67.png)

### Running the Program

In order to run the application, just run the following commands:

1) To generate images using our image generator: ```python3 images/image_generator.py``` and may need to run ```pip3 install pillow``` before this as well

2) To create the executable file: ```gcc -o <path_to_exec_file> motion-detection.c -lpng```

3) To run the executable file: ```.<path_to_exec_file> <path_to_current_image> <path_to_reference_image>```

## Team

- Isaac Sahle
- Shreyas Devalapurkar
