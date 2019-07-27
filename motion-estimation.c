#include <stdlib.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdbool.h>
#include <stdio.h>
#include <unistd.h>
#include <png.h>
#include <limits.h>
#include <string.h>

#define BLOCK_HEIGHT 16
#define BLOCK_WIDTH 16
#define INCOMPLETE_SAD -1 // MUST BE NEGATIVE

int valid_parameters(char *current_image_file, char *reference_image_file);
void encode(
    png_bytep *current_image,
    png_bytep *reference_image,
    int current_height,
    int reference_height,
    int current_width,
    int reference_width);

int main(int argc, char **argv)
{
    if (argc < 2 || !valid_parameters(argv[1], argv[2]))
    {
        perror("Invalid parameters");
        return EXIT_FAILURE;
    }

    int current_width, current_height, reference_width, reference_height;
    FILE *current_image = fopen(argv[1], "rb");
    FILE *reference_image = fopen(argv[2], "rb");

    png_structp current_png = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
    png_structp reference_png = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);

    if (!current_png || !reference_png)
    {
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

    png_bytep *current_row_pointers = (png_bytep *)malloc(sizeof(png_bytep) * current_height);
    png_bytep *reference_row_pointers = (png_bytep *)malloc(sizeof(png_bytep) * reference_height);

    for (int y = 0; y < current_height; y++)
    {
        current_row_pointers[y] = (png_byte *)malloc(png_get_rowbytes(current_png, current_info));
    }

    for (int y = 0; y < reference_height; y++)
    {
        reference_row_pointers[y] = (png_byte *)malloc(png_get_rowbytes(reference_png, reference_info));
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

int valid_parameters(char *current_image_file, char *reference_image_file)
{
    int current_fd;
    int reference_fd;

    if ((current_fd = open(current_image_file, O_RDONLY) == -1))
    {
        return false;
    }

    if ((reference_fd = open(reference_image_file, O_RDONLY)) == -1)
    {
        close(current_fd);
        return false;
    }

    close(reference_fd);
    return true;
}

void encode(
    png_bytep *current_image,
    png_bytep *reference_image,
    int current_height,
    int reference_height,
    int current_width,
    int reference_width)
{

    int current_x, current_y;
    int motion_vector_y, motion_vector_x, min_sad;
    int test_r, test_s;
    int sad_values[current_height / BLOCK_HEIGHT][current_width / BLOCK_WIDTH];
    memset(sad_values, 0, ((current_height / BLOCK_HEIGHT) * (current_width / BLOCK_WIDTH)) * sizeof(int));
    int i, j, diff, sad;
    for (int y = 0; y < current_height; y += BLOCK_HEIGHT)
    {
        for (int x = 0; x < current_width; x += BLOCK_WIDTH)
        {
            int i, j, diff, sad;
            sad = 0;
            int y_index = y / BLOCK_HEIGHT;
            int x_index = x / BLOCK_WIDTH;
            if (y + BLOCK_HEIGHT <= current_height && x + BLOCK_WIDTH <= current_width)
            {
                for (i = 0; i < BLOCK_HEIGHT; i++)
                {
                    for (j = 0; j < BLOCK_WIDTH; j++)
                    {
                        diff = current_image[y + i][x + j] - reference_image[y + i][x + j];
                        if (diff < 0)
                        {
                            diff -= (2 * diff);
                        }
                        sad += diff;
                    }
                }
                sad_values[y_index][x_index] = sad;
            }
            else
            {
                sad_values[y_index][x_index] = -1;
            }
        }
    }

    for (int y = 0; y < current_height / BLOCK_HEIGHT; y++)
    {
        for (int x = 0; x < current_width / BLOCK_WIDTH; x++)
        {
            int min_sad = sad_values[y][x];
            int motion_vector_x = 0;
            int motion_vector_y = 0;
            if (min_sad > 0)
            {
                if (x + 1 < current_width / BLOCK_WIDTH)
                {
                    if (sad_values[y][x + 1] < min_sad && sad_values[y][x + 1] != INCOMPLETE_SAD)
                    {
                        min_sad = sad_values[y][x + 1];
                        motion_vector_x = 1;
                        motion_vector_y = 0;
                    }
                }

                if (x + 2 < current_width / BLOCK_WIDTH)
                {
                    if (sad_values[y][x + 2] < min_sad && sad_values[y][x + 2] != INCOMPLETE_SAD)
                    {
                        min_sad = sad_values[y][x + 2];
                        motion_vector_x = 2;
                        motion_vector_y = 0;
                    }
                }

                if (x - 1 >= 0)
                {
                    if (sad_values[y][x - 1] < min_sad && sad_values[y][x - 1] != INCOMPLETE_SAD)
                    {
                        min_sad = sad_values[y][x - 1];
                        motion_vector_x = -1;
                        motion_vector_y = 0;
                    }
                }

                if (x - 2 >= 0)
                {
                    if (sad_values[y][x - 2] < min_sad && sad_values[y][x - 2] != INCOMPLETE_SAD)
                    {
                        min_sad = sad_values[y][x - 2];
                        motion_vector_x = -2;
                        motion_vector_y = 0;
                    }
                }

                if (y + 1 < current_height / BLOCK_HEIGHT)
                {
                    if (sad_values[y + 1][x] < min_sad && sad_values[y + 1][x] != INCOMPLETE_SAD)
                    {
                        min_sad = sad_values[y + 1][x];
                        motion_vector_x = 0;
                        motion_vector_y = 1;
                    }
                }

                if (y + 2 < current_height / BLOCK_HEIGHT)
                {
                    if (sad_values[y + 2][x] < min_sad && sad_values[y + 2][x] != INCOMPLETE_SAD)
                    {
                        min_sad = sad_values[y + 2][x];
                        motion_vector_x = 0;
                        motion_vector_y = 2;
                    }
                }

                if (y - 1 >= 0)
                {
                    if (sad_values[y - 1][x] < min_sad && sad_values[y - 1][x] != INCOMPLETE_SAD)
                    {
                        min_sad = sad_values[y - 1][x];
                        motion_vector_x = 0;
                        motion_vector_y = -1;
                    }
                }

                if (y - 2 >= 0)
                {
                    if (sad_values[y - 2][x] < min_sad && sad_values[y - 2][x] != INCOMPLETE_SAD)
                    {
                        min_sad = sad_values[y - 2][x];
                        motion_vector_x = 0;
                        motion_vector_y = -2;
                    }
                }
                // if (min_sad > 0)
                // {
                //     printf("Min sad: %d  motion x: %d y: %d\n", min_sad, motion_vector_x, motion_vector_y);
                // }
            }
            // printf("%d ", sad_values[y][x]);
        }
        // printf("\n");
    }
}