
#ifndef ARGUMENTS_H
#define ARGUMENTS_H

#include <argp.h>
#include <stdlib.h>

struct arguments {};

#define USAGE 0x123

static struct argp_option options[] = {
    {
        .name = "help",
        .key = 'h',
        .arg = 0,
        .flags = 0,
        .doc = "Show this help list",
        .group = -1,
    },
    {
        .name = "usage",
        .key = USAGE,
        .arg = 0,
        .flags = 0,
        .doc = "Give a short usage message",
        .group = 0,
    },
    {
        .name = "version",
        .key = 'v',
        .arg = 0,
        .flags = 0,
        .doc = "Print program version",
        .group = -1,
    },
    {0},
};

static error_t parser(int key, [[gnu::unused]] char *arg,
                      struct argp_state *state) {

  [[gnu::unused]]
  struct arguments *arguments = (struct arguments *)state->input;
  switch (key) {
  case USAGE: {
    argp_state_help(state, state->out_stream,
                    ARGP_HELP_USAGE | ARGP_HELP_EXIT_OK);
    break;
  }
#undef USAGE
  case 'h': {
    argp_state_help(state, state->out_stream, ARGP_HELP_STD_HELP);
    break;
  }
  case 'v': {
    fprintf(state->out_stream, "%s\n", argp_program_version);
    exit(0);
    break;
  }
  case ARGP_KEY_ARG: {
    return ARGP_ERR_UNKNOWN;
  }
  case ARGP_KEY_NO_ARGS: {
    return 0;
  }
  case ARGP_KEY_END: {
    return 0;
  }
  default:
    return ARGP_ERR_UNKNOWN;
  }
  return 0;
}

static struct argp argp = {
    .options = options,
    .parser = parser,
    .args_doc = "",
    .doc = "",
};

#endif
