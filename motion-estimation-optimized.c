#include <stdlib.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdbool.h>
#include <stdio.h>
#include <unistd.h>
#include <png.h>
#include <limits.h>
#include <string.h>
#include <arm_neon.h>

#define BLOCK_HEIGHT 16
#define BLOCK_WIDTH 16

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

    if(current_height < BLOCK_HEIGHT || current_width < BLOCK_WIDTH){
        perror("Provide an image with height and width dimensions >= 16\n");
    } else {
        encode(
        current_row_pointers,
        reference_row_pointers,
        current_height,
        reference_height,
        current_width,
        reference_width);
    }
    

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
    int num_blocks_y, num_blocks_x, y_bound, x_bound;
    num_blocks_y = ((current_height << BLOCK_HEIGHT) / BLOCK_HEIGHT) >> BLOCK_HEIGHT;
    num_blocks_x = ((current_width << BLOCK_WIDTH) / BLOCK_WIDTH) >> BLOCK_WIDTH;
    y_bound = num_blocks_y * BLOCK_HEIGHT;
    x_bound = num_blocks_x * BLOCK_WIDTH;

    uint16_t sad_values[num_blocks_y][num_blocks_x];
    memset(sad_values, 0, ((num_blocks_y) * (num_blocks_x)) * sizeof(uint16_t));
    int current_sad = 0;
    int y_block = 0;
    int x_block;
    for (int y = 0; y < y_bound; y += BLOCK_HEIGHT)
    {
        x_block = 0;
        for (int x = 0; x < x_bound; x += BLOCK_WIDTH)
        {
            uint8x16_t reference_row_one = vld1q_u8(&(reference_image[y][x]));
            uint8x16_t reference_row_two = vld1q_u8(&(reference_image[y + 1][x]));
            uint8x16_t reference_row_three = vld1q_u8(&(reference_image[y + 2][x]));
            uint8x16_t reference_row_four = vld1q_u8(&(reference_image[y + 3][x]));
            uint8x16_t reference_row_five = vld1q_u8(&(reference_image[y + 4][x]));
            uint8x16_t reference_row_six = vld1q_u8(&(reference_image[y + 5][x]));
            uint8x16_t reference_row_seven = vld1q_u8(&(reference_image[y + 6][x]));
            uint8x16_t reference_row_eight = vld1q_u8(&(reference_image[y + 7][x]));
            uint8x16_t reference_row_nine = vld1q_u8(&(reference_image[y + 8][x]));
            uint8x16_t reference_row_ten = vld1q_u8(&(reference_image[y + 9][x]));
            uint8x16_t reference_row_eleven = vld1q_u8(&(reference_image[y + 10][x]));
            uint8x16_t reference_row_twelve = vld1q_u8(&(reference_image[y + 11][x]));
            uint8x16_t reference_row_thirteen = vld1q_u8(&(reference_image[y + 12][x]));
            uint8x16_t reference_row_fourteen = vld1q_u8(&(reference_image[y + 13][x]));
            uint8x16_t reference_row_fifteen = vld1q_u8(&(reference_image[y + 14][x]));
            uint8x16_t reference_row_sixteen = vld1q_u8(&(reference_image[y + 15][x]));

            uint8x16_t current_row_one = vld1q_u8(&(current_image[y][x]));
            uint8x16_t current_row_two = vld1q_u8(&(current_image[y + 1][x]));
            uint8x16_t current_row_three = vld1q_u8(&(current_image[y + 2][x]));
            uint8x16_t current_row_four = vld1q_u8(&(current_image[y + 3][x]));
            uint8x16_t current_row_five = vld1q_u8(&(current_image[y + 4][x]));
            uint8x16_t current_row_six = vld1q_u8(&(current_image[y + 5][x]));
            uint8x16_t current_row_seven = vld1q_u8(&(current_image[y + 6][x]));
            uint8x16_t current_row_eight = vld1q_u8(&(current_image[y + 7][x]));
            uint8x16_t current_row_nine = vld1q_u8(&(current_image[y + 8][x]));
            uint8x16_t current_row_ten = vld1q_u8(&(current_image[y + 9][x]));
            uint8x16_t current_row_eleven = vld1q_u8(&(current_image[y + 10][x]));
            uint8x16_t current_row_twelve = vld1q_u8(&(current_image[y + 11][x]));
            uint8x16_t current_row_thirteen = vld1q_u8(&(current_image[y + 12][x]));
            uint8x16_t current_row_fourteen = vld1q_u8(&(current_image[y + 13][x]));
            uint8x16_t current_row_fifteen = vld1q_u8(&(current_image[y + 14][x]));
            uint8x16_t current_row_sixteen = vld1q_u8(&(current_image[y + 15][x]));

            uint8x16_t result_row_one = vabdq_u8(current_row_one, reference_row_one);
            uint8x16_t result_row_two = vabdq_u8(current_row_two, reference_row_two);
            uint8x16_t result_row_three = vabdq_u8(current_row_three, reference_row_three);
            uint8x16_t result_row_four = vabdq_u8(current_row_four, reference_row_four);
            uint8x16_t result_row_five = vabdq_u8(current_row_five, reference_row_five);
            uint8x16_t result_row_six = vabdq_u8(current_row_six, reference_row_six);
            uint8x16_t result_row_seven = vabdq_u8(current_row_seven, reference_row_seven);
            uint8x16_t result_row_eight = vabdq_u8(current_row_eight, reference_row_eight);
            uint8x16_t result_row_nine = vabdq_u8(current_row_nine, reference_row_nine);
            uint8x16_t result_row_ten = vabdq_u8(current_row_ten, reference_row_ten);
            uint8x16_t result_row_eleven = vabdq_u8(current_row_eleven, reference_row_eleven);
            uint8x16_t result_row_twelve = vabdq_u8(current_row_twelve, reference_row_twelve);
            uint8x16_t result_row_thirteen = vabdq_u8(current_row_thirteen, reference_row_thirteen);
            uint8x16_t result_row_fourteen = vabdq_u8(current_row_fourteen, reference_row_fourteen);
            uint8x16_t result_row_fifteen = vabdq_u8(current_row_fifteen, reference_row_fifteen);
            uint8x16_t result_row_sixteen = vabdq_u8(current_row_sixteen, reference_row_sixteen);

            uint16_t sum = 0;
            for (int i = 0; i < BLOCK_WIDTH; i++)
            {
                sum += result_row_one[i];
                sum += result_row_two[i];
                sum += result_row_three[i];
                sum += result_row_four[i];
                sum += result_row_five[i];
                sum += result_row_six[i];
                sum += result_row_seven[i];
                sum += result_row_eight[i];
                sum += result_row_nine[i];
                sum += result_row_ten[i];
                sum += result_row_eleven[i];
                sum += result_row_twelve[i];
                sum += result_row_thirteen[i];
                sum += result_row_fourteen[i];
                sum += result_row_fifteen[i];
                sum += result_row_sixteen[i];
            }
            sad_values[y_block][x_block] = sum;
            x_block++;
        }
        y_block++;
    }

    for (int y = 0; y < num_blocks_y; y++)
    {
        for (int x = 0; x < num_blocks_x; x++)
        {
            int min_sad = sad_values[y][x];
            int motion_vector_x = 0;
            int motion_vector_y = 0;
            if (min_sad > 0)
            {
                if (x + 1 < num_blocks_x)
                {
                    if (sad_values[y][x + 1] < min_sad)
                    {
                        min_sad = sad_values[y][x + 1];
                        motion_vector_x = 1;
                        motion_vector_y = 0;
                    }
                    if (x + 2 < num_blocks_x)
                    {
                        if (sad_values[y][x + 2] < min_sad)
                        {
                            min_sad = sad_values[y][x + 2];
                            motion_vector_x = 2;
                            motion_vector_y = 0;
                        }
                    }
                }

                if (x - 1 >= 0)
                {
                    if (sad_values[y][x - 1] < min_sad)
                    {
                        min_sad = sad_values[y][x - 1];
                        motion_vector_x = -1;
                        motion_vector_y = 0;
                    }
                    if (x - 2 >= 0)
                    {
                        if (sad_values[y][x - 2] < min_sad)
                        {
                            min_sad = sad_values[y][x - 2];
                            motion_vector_x = -2;
                            motion_vector_y = 0;
                        }
                    }
                }

                if (y + 1 < num_blocks_y)
                {
                    if (sad_values[y + 1][x] < min_sad)
                    {
                        min_sad = sad_values[y + 1][x];
                        motion_vector_x = 0;
                        motion_vector_y = 1;
                    }
                    if (y + 2 < num_blocks_y)
                    {
                        if (sad_values[y + 2][x] < min_sad)
                        {
                            min_sad = sad_values[y + 2][x];
                            motion_vector_x = 0;
                            motion_vector_y = 2;
                        }
                    }
                }

                if (y - 1 >= 0)
                {
                    if (sad_values[y - 1][x] < min_sad)
                    {
                        min_sad = sad_values[y - 1][x];
                        motion_vector_x = 0;
                        motion_vector_y = -1;
                    }
                    if (y - 2 >= 0)
                    {
                        if (sad_values[y - 2][x] < min_sad)
                        {
                            min_sad = sad_values[y - 2][x];
                            motion_vector_x = 0;
                            motion_vector_y = -2;
                        }
                    }
                }
                // if(min_sad > 0){
                //     printf("Min sad: %u  motion x: %d y: %d\n", min_sad, motion_vector_x, motion_vector_y);
                // }
            }
            // printf("%d ", sad_values[y][x]);
        }
        // printf("\n");
    }
}