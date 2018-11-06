/*
 * MIT License
 *
 * Copyright (c) 2018 Kamil Lorenc
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
#include <stdio.h>
#include <limits.h>
#include <getopt.h>

#include "module.h"

#define LONG_OPTION (( CHAR_MAX + 1 ))

typedef enum {
  MODE_UNDEFINED = 0,
  MODE_DEFINE,
  MODE_SIZEOF,
  MODE_USAGE,
  MODE_HELP,
} mode_t;

void help(int argc, char **argv, int usage)
{
  printf("Usage: %s -d|-s SYMBOL INCLUDE | -h\n", argv[0]);
  if (!usage)
  {
    printf("\n"
        "\t-d, --define  Print final value of preprocessor macro\n"
        "\t-s, --sizeof  Print total length of type/struct\n"
        "\t-h, --help    Print this help message and exit\n"
        "\tINCLUDE       Header where symbol is defined\n"
        "\tSYMBOL        Symbol which value is to be examined\n"
        "\n");
  }
}

int main(int argc, char **argv)
{
  int c;
  int digit_optind = 0;
  mode_t mode = MODE_UNDEFINED;

  while (1) {
    int this_option_optind = optind ? optind : 1;
    int option_index = 0;
    static struct option long_options[] = {
      /* {name, has_arg, flag, val} */
      {"define", no_argument, 0, 'd' },
      {"sizeof", no_argument, 0, 's' },
      {"help", no_argument, 0, 'h' },
      {0, 0, 0, 0 }
    };

    c = getopt_long(argc, argv, "dsh",
        long_options, &option_index);
    if (c == -1)
      break;

    switch (c) {
      case 'd':
        mode = MODE_DEFINE;
        break;

      case 's':
        mode = MODE_SIZEOF;
        break;

      case 'h':
        mode = MODE_HELP;
        break;

      default:
        /* optstrings not handled (mistakes?) */
        printf("error when parsing options (%c returned)\n", c);
        return 1;
    }
  }

  /* positional arguments */
  if ((mode != MODE_HELP) && (mode != MODE_USAGE))
  {
    if ((argc - optind) == 2)
    {
      printf("%s %s\n", argv[optind], argv[optind+1]);
    }
    else
    {
      mode = MODE_USAGE;
    }
  }

  if ((mode == MODE_HELP) || (mode == MODE_USAGE))
  {
    help(argc, argv, mode == MODE_USAGE);
    return 0;
  }

  return 0;
}
