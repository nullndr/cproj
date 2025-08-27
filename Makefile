CC := gcc
CFLAGS := -Wall -Wextra -Iinclude -Icommon -std=c23

PROG_NAME := program
SRC_DIR := src
BIN_DIR := bin
TEST_DIR  := tests

TARGET := $(BIN_DIR)/$(PROG_NAME)

SRCS := $(wildcard $(SRC_DIR)/*.c)
OBJS := $(SRCS:$(SRC_DIR)/%.c=$(BIN_DIR)/%.o)

TEST_SRCS := $(wildcard $(TEST_DIR)/*.c)
TEST_OBJS := $(TEST_SRCS:$(TEST_DIR)/%.c=$(BIN_DIR)/%.test.o)
TEST_BIN  := $(BIN_DIR)/tests

all: compile_flags.txt $(TARGET)

compile_flags.txt: Makefile
	@echo "Generating compile_flags.txt from CFLAGS..."
	@echo $(CFLAGS) | tr ' ' '\n' > compile_flags.txt

$(TARGET): $(OBJS) | $(BIN_DIR)
	$(CC) $(OBJS) -o $@
	@rm -f $(OBJS)

$(BIN_DIR)/%.o: $(SRC_DIR)/%.c | $(BIN_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

test: $(TEST_BIN)
	@echo "Running tests..."
	@$(TEST_BIN)

$(TEST_BIN): $(TEST_OBJS) $(filter-out $(BIN_DIR)/main.o,$(OBJS)) | $(BIN_DIR)
	$(CC) $^ -o $@

$(BIN_DIR)/%.test.o: $(TEST_DIR)/%.c | $(BIN_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(BIN_DIR)/*.o
	rm -f $(TEST_BIN) $(BIN_DIR)/*test
	rm -f $(TARGET)

.PHONY: all clean test
