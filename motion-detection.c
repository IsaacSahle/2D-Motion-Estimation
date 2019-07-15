#include <stdlib.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdbool.h>
#include <stdio.h>
#include <unistd.h>
#include <png.h>
#include <limits.h>

#define BLOCK_HEIGHT 16
#define BLOCK_WIDTH 16

int valid_parameters(char * current_image_file, char * reference_image_file);
void encode(
    png_bytep* current_image,
    png_bytep* reference_image,
    int current_height,
    int reference_height,
    int current_width,
    int reference_width);
int compute_sad(
    int y,
    int x,
    int r,
    int s,
    png_bytep* current_image,
    png_bytep* reference_image,
    int current_height,
    int reference_height,
    int current_width,
    int reference_width);

int main(int argc, char **argv) {
    if (argc < 2 || !valid_parameters(argv[1], argv[2])) {
        perror("Invalid parameters");
        return EXIT_FAILURE;
    }

    int current_width, current_height, reference_width, reference_height;
    FILE* current_image = fopen(argv[1],"rb");
    FILE* reference_image = fopen(argv[2],"rb");

    png_structp current_png = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
    png_structp reference_png = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);

    if(!current_png || !reference_png){
        perror("Error reading pngs\n");
        return EXIT_FAILURE;
    }

    png_infop current_info = png_create_info_struct(current_png);
    png_init_io(current_png, current_image);
    png_read_info(current_png, current_info);

    png_infop reference_info = png_create_info_struct(reference_png);
    png_init_io(reference_png, reference_image);
    png_read_info(reference_png, reference_info);

    current_width = png_get_image_width(current_png, current_info);
    current_height = png_get_image_height(current_png, current_info);
    reference_height = png_get_image_height(reference_png, reference_info);
    reference_width = png_get_image_width(reference_png, reference_info);

    png_bytep *current_row_pointers = (png_bytep*)malloc(sizeof(png_bytep) * current_height);
    png_bytep *reference_row_pointers = (png_bytep*)malloc(sizeof(png_bytep) * reference_height);

    for(int y = 0; y < current_height; y++) {
        current_row_pointers[y] = (png_byte*)malloc(png_get_rowbytes(current_png, current_info));
    }
    
    for(int y = 0; y < reference_height; y++) {
        reference_row_pointers[y] = (png_byte*)malloc(png_get_rowbytes(reference_png, reference_info));
    }

    png_read_image(current_png, current_row_pointers);
    png_read_image(reference_png, reference_row_pointers);

    encode(
        current_row_pointers,
        reference_row_pointers,
        current_height,
        reference_height,
        current_width,
        reference_width);

    fclose(current_image);
    fclose(reference_image);
    png_destroy_read_struct(&current_png, &current_info, NULL);
    png_destroy_read_struct(&reference_png, &reference_info, NULL);

    return EXIT_SUCCESS;
}

int valid_parameters(char * current_image_file, char * reference_image_file) {
    int current_fd;
    int reference_fd;

    if ((current_fd = open(current_image_file, O_RDONLY) == -1)) {
        return false;
    }

    if ((reference_fd = open(reference_image_file, O_RDONLY)) == -1) {
        close(current_fd);
        return false;
    }

    close(reference_fd);
    return true;
}

void encode(
    png_bytep* current_image,
    png_bytep* reference_image,
    int current_height,
    int reference_height,
    int current_width,
    int reference_width) {

    int current_x, current_y;
    for(int y = 0; y < current_height; y+=BLOCK_HEIGHT) {
        int motion_vector_x, motion_vector_y, min_sad = INT_MAX;
        for(int x = 0; x < current_width; x+=BLOCK_WIDTH) {
            int r = y;
            int s = x;
            motion_vector_x = r - y;
            motion_vector_y = s - x;
            // printf("x: %d y: %d\n", x, y);
            if (compute_sad(y, x, r, s, current_image, reference_image, current_height, reference_height, current_width, reference_width) >= 0) {
                min_sad = compute_sad(y, x, r, s, current_image, reference_image, current_height, reference_height, current_width, reference_width);
            }

            // left
            if (r - BLOCK_WIDTH >= 0) {
                r = r - BLOCK_WIDTH;
                // printf("Left 16\n");
                int left_16_sad = compute_sad(y, x, r, s, current_image, reference_image, current_height, reference_height, current_width, reference_width);
                if (left_16_sad < min_sad && left_16_sad >= 0) {
                    min_sad = left_16_sad;
                    motion_vector_x = r - y;
                    motion_vector_y = s - x;
                }

                if (r - BLOCK_WIDTH >= 0) {
                    r = r - BLOCK_WIDTH;
                    // printf("Left 32\n");
                    int left_32_sad = compute_sad(y, x, r, s, current_image, reference_image, current_height, reference_height, current_width, reference_width);
                    if (left_32_sad < min_sad && left_32_sad >= 0) {
                        min_sad = left_32_sad;
                        motion_vector_x = r - y;
                        motion_vector_y = s - x;
                    }
                }
            }

            // reset value of r here before further checks
            r = y;

            // right
            if (r + BLOCK_WIDTH < current_width) {
                r = r + BLOCK_WIDTH;
                // printf("Right 16 %d\n", r);
                // printf("r: %d s: %d\n", r, s);
                int right_16_sad = compute_sad(y, x, r, s, current_image, reference_image, current_height, reference_height, current_width, reference_width);
                if (right_16_sad < min_sad && right_16_sad >= 0) {
                    min_sad = right_16_sad;
                    motion_vector_x = r - y;
                    motion_vector_y = s - x;
                }

                if (r + BLOCK_WIDTH < current_width) {
                    r = r + BLOCK_WIDTH;
                    // printf("Right 32\n");
                    int right_32_sad = compute_sad(y, x, r, s, current_image, reference_image, current_height, reference_height, current_width, reference_width);
                    if (right_32_sad < min_sad && right_32_sad >= 0) {
                        min_sad = right_32_sad;
                        motion_vector_x = r - y;
                        motion_vector_y = s - x;
                    }
                }
            }

            // down
            if (s - BLOCK_HEIGHT >= 0) {
                s = s - BLOCK_HEIGHT;
                // printf("Down 16\n");
                int down_16_sad = compute_sad(y, x, r, s, current_image, reference_image, current_height, reference_height, current_width, reference_width);
                if (down_16_sad < min_sad && down_16_sad >= 0) {
                    min_sad = down_16_sad;
                    motion_vector_x = r - y;
                    motion_vector_y = s - x;
                }

                if (s - BLOCK_HEIGHT >= 0) {
                    s = s - BLOCK_HEIGHT;
                    // printf("Down 32\n");
                    int down_32_sad = compute_sad(y, x, r, s, current_image, reference_image, current_height, reference_height, current_width, reference_width);
                    if (down_32_sad < min_sad && down_32_sad >= 0) {
                        min_sad = down_32_sad;
                        motion_vector_x = r - y;
                        motion_vector_y = s - x;
                    }
                }
            }

            // reset value of s here before further checks
            s = x;

            // up
            if (s + BLOCK_HEIGHT < current_width) {
                s = s + BLOCK_HEIGHT;
                // printf("Up 16\n");
                int up_16_sad = compute_sad(y, x, r, s, current_image, reference_image, current_height, reference_height, current_width, reference_width);
                if (up_16_sad < min_sad && up_16_sad >= 0) {
                    min_sad = up_16_sad;
                    motion_vector_x = r - y;
                    motion_vector_y = s - x;
                }

                if (s + BLOCK_HEIGHT < current_width) {
                    s = s + BLOCK_HEIGHT;
                    // printf("Up 32\n");
                    int up_32_sad = compute_sad(y, x, r, s, current_image, reference_image, current_height, reference_height, current_width, reference_width);
                    if (up_32_sad < min_sad && up_32_sad >= 0) {
                        min_sad = up_32_sad;
                        motion_vector_x = r - y;
                        motion_vector_y = s - x;
                    }
                }
            }
        }

        printf("SAD: %d\n", min_sad);
        printf("Motion x: %d y: %d\n", motion_vector_x, motion_vector_y);
    }
}

// sad: sum of absolute differences
int compute_sad(
    int y,
    int x,
    int r,
    int s,
    png_bytep* current_image,
    png_bytep* reference_image,
    int current_height,
    int reference_height,
    int current_width,
    int reference_width) {

    int diff, sad = 0;
    int i, j;
    if(r + BLOCK_HEIGHT > reference_height || s + BLOCK_WIDTH > reference_width) {
        // printf("Ref height: %d y: %d r: %d\n", reference_height, y, r);
        // printf("Ref width: %d x: %d s: %d\n", reference_width, x, s);
        return -1;
    }

    for (i = 0; i < BLOCK_HEIGHT; i++) {
        for (j = 0; j < BLOCK_WIDTH; j++) {
            diff = current_image[y + i][x + j] - reference_image[r+ i][s + j];
            if (diff < 0) {
                diff -= diff;
            }
            sad += diff;
        }
    }
    if(sad > 0) {
        printf("Sad calculated: %d\n", sad);
    }
    
    return sad;
}
