gcc -o motion-estimation-o motion-estimation-optimized.c -lpng
gcc -o motion-estimation motion-estimation.c -lpng
./motion-estimation images/current.png images/reference.png > output.txt
./motion-estimation-o images/current.png images/reference.png > output-o.txt
diff output.txt output-o.txt