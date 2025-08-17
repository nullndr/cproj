CC := gcc
CFLAGS := -Wall -Wextra -Iheaders

PROG_NAME := program
SRC_DIR := src
BIN_DIR := bin
INC_DIR := include

TARGET := $(BIN_DIR)/$(PROG_NAME)

SRCS := $(wildcard $(SRC_DIR)/*.c)
OBJS := $(SRCS:$(SRC_DIR)/%.c=$(BIN_DIR)/%.o)

all: $(TARGET)

$(TARGET): $(OBJS) | $(BIN_DIR)
	$(CC) $(OBJS) -o $@
	@rm -f $(OBJS)

$(BIN_DIR)/%.o: $(SRC_DIR)/%.c | $(BIN_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(BIN_DIR)

.PHONY: all clean
