#include <unistd.h>
#include <stdlib.h>
 
int main(int argc, char* argv[])
{
	write(1, "Hello world!\n", 13);
	return EXIT_SUCCESS ;
}
