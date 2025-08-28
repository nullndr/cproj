
#include "utils.h"
#include <stdarg.h>
#include <stdio.h>

void log_info(const char *fmt, ...) {
  va_list args;
  va_start(args, fmt);
  fprintf(stdout, "[INFO] ");
  vfprintf(stdout, fmt, args);
  va_end(args);
}

void log_error(const char *fmt, ...) {
  va_list args;
  va_start(args, fmt);
  fprintf(stderr, "[ERROR] ");
  vfprintf(stderr, fmt, args);
  va_end(args);
}
