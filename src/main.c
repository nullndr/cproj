#include "arguments.h"

int main(int argc, char **argv) {
  struct arguments arguments = {};
  argp_parse(&argp, argc, argv, ARGP_NO_HELP, 0, &arguments);
  return 0;
}
