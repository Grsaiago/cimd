LIB_NAME = libcimd.a

ASM_SRC_DIR = src
ASM_OBJ_DIR = obj

MAIN = main.c
TEST_BIN = teste

ASM_SRCS = $(wildcard $(ASM_SRC_DIR)/*.asm)
ASM_OBJS = $(wildcard $(ASM_OBJ_DIR)/*.o)

CC = gcc

CFLAGS = -Wall -Wextra -Werror

.PHONY: all
all: help

.PHONY: help
help: ## Prints help for targets with comments
	@echo "Available Rules:"
	@cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


.PHONY: lib ## Creates only the lib
lib: $(LIB_NAME)

.PHONY: t
t: $(LIB_NAME) $(MAIN)
	$(CC) $(CFLAGS) $(LIB_NAME) $(MAIN) -o $(TEST_BIN)

$(LIB_NAME): $(ASM_OBJS)
	@ar -rcs $(LIB_NAME) $(ASM_OBJS)


$(ASM_OBJ_DIR)/%.o: $(ASM_SRC_DIR)/%.asm
	$(CC) $< -o $@


.PHONY: clean
clean: ## Deletes the build artifacts and the test executable
	@rm -f $(ASM_OBJS)
	@rm -f $(TEST_BIN)

.PHONY: fclean
fclean: clean ## Deletes the build artifacts, the test executable and the .a
	@rm -f $(LIB_NAME)
