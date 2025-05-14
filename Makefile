LIB_SUFFIX = cimd
LIB_NAME = lib$(LIB_SUFFIX).a

ASM_SRC_DIR = src
ASM_OBJ_DIR = obj

MAIN = main.c
TEST_BIN = teste

ASM_SRCS = $(wildcard $(ASM_SRC_DIR)/*.asm)
ASM_OBJS = $(patsubst $(ASM_SRC_DIR)/%.asm, $(ASM_OBJ_DIR)/%.o, $(ASM_SRCS))

CC = gcc

CFLAGS = -Wall -Wextra -Werror

LINK_LIB = -L. -l:$(LIB_NAME)

NASM = nasm -f elf64 -I. \
            -DARCH_X86_64=1 \
            -DHAVE_ALIGNED_STACK=1 \
            -DPIC=1 \
            -Dprivate_prefix=my \


.PHONY: all
all: help

.PHONY: help
help: ## Prints help for targets with comments
	@echo "Available Rules:"
	@cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


.PHONY: lib
lib: $(LIB_NAME) ## Creates only the lib

.PHONY: t
t: $(LIB_NAME) $(MAIN) $(ASM_OBJS)
	$(CC) $(CFLAGS) $(MAIN) $(LINK_LIB) -o $(TEST_BIN)

$(LIB_NAME): $(ASM_OBJS)
	@ar -rcs $(LIB_NAME) $(ASM_OBJS)

$(ASM_OBJ_DIR)/%.o: $(ASM_SRC_DIR)/%.asm
	$(NASM) $< -o $@


.PHONY: clean
clean: ## Deletes the build artifacts and the test executable
	@rm -f $(ASM_OBJS)
	@rm -f $(TEST_BIN)

.PHONY: fclean
fclean: clean ## Deletes the build artifacts, the test executable and the .a
	@rm -f $(LIB_NAME)
