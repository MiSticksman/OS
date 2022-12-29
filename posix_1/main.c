#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <getopt.h>

int main(int argc, char *argv[]) {
    int n = -1;
    int t = 0;
    struct option longopts[] =
    {
        {
        .name = "number",
        .has_arg = required_argument,
        .flag = NULL,
        .val = 'n'
        },
        {
        .name = "timeout",
        .has_arg = optional_argument,
        .flag = NULL,
        .val = 't'
        },
        {
        }
    };

    while (1)
    {
        int c = getopt_long(argc, argv, "n:t::", longopts, NULL);

        if (c == -1)
        {
        break;
        }

        switch (c)
        {
        case 'n':
            n = atoi(optarg);
            break;
        case 't':
            if (optarg)
            {
            t = atoi(optarg);
            }
            else
            {
            t = 1;
            }
            break;
        default:

        }
    }

        if (n == -1 || optind == argc - 1) {
            printf("usage: -n|--number <N> [-t|--timeout [<T>]] -- <TEXT>");
        }
        else {
            for (size_t i = 0; i < n; i++)
            {
                printf("%s ",argv[argc - 1]);
                printf("\n");
                if (t != -1)
                {
                    sleep(t);
                }
            }
        }
    
    return 0;
}
