#include <stdlib.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdbool.h>
#include <stdio.h>
#include <unistd.h>
#include <png.h>

#define BLOCK_HEIGHT 16
#define BLOCK_WIDTH 16

int valid_parameters(char * current_image_file, char * reference_image_file);
void encode(png_bytep* current_image, png_bytep* reference_image);

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

void encode(png_bytep* current_image, png_bytep* reference_image) {
    for(int y = 0; y < current_height; y++){
        for(int x = 0; x < current_width; x++){
            printf("%d", row_pointers[y][x]);
        }
        printf("\n");
    }
}

// int compute_sad(int x, int y, int r, int s) {
//     int diff, sad = 0; // sad: sum of absolute differences
//     int i, j;

//     for (i = 0; i < 16; i++) {
//         for (j = 0; j < 16; j++) {
//             diff = current_image_file[x + i][y + j] - reference_image_file[(x + r) + i][(y + s) + j];
//             if (diff < 0) {
//                 diff -= diff;
//             }
//             sad += diff;
//         }
//     }

//     return sad;
// }
