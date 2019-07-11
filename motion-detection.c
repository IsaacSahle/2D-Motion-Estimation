#include <stdlib.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdbool.h>
#include <stdio.h>
#include <unistd.h>


int valid_parameters(char * current_image_file, char * reference_image_file);

int main(int argc, char **argv){

    if (argc < 2 || !valid_parameters(argv[1], argv[2]))
    {
        perror("Invalid parameters");
        return EXIT_FAILURE;
    }


return EXIT_SUCCESS;
}

int valid_parameters(char * current_image_file, char * reference_image_file) {
    int current_fd;
    int reference_fd;
    if((current_fd = open(current_image_file, O_RDONLY) == -1)){
        return false;
    }

    if((reference_fd = open(reference_image_file, O_RDONLY)) == -1) {
        close(current_fd);
        return false;
    }

    close(reference_fd);
    return true;
}