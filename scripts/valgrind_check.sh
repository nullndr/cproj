#! /usr/bin/env sh
# valgrind_check.sh
# Run the program with Valgrind to detect memory issues.

main() {
  local program="./bin/program"
  local valgrind_log="./valgrind.log"

  local valgrind_flags="--leak-check=full --show-leak-kinds=all --track-origins=yes --verbose"

  if [[ ! -f "$program" ]]; then
    echo "Building $program..."
    make

    if [[ $? != 0 ]]; then
      echo "Error while compiling $program, aborting"
      exit 1
    fi
  fi

  echo "Running Valgrind on $program..."
  valgrind $valgrind_flags --log-file="$valgrind_log" "$program"

  echo "Valgrind run complete. Output saved in $valgrind_log"
}

main $@