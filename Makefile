# -*- Makefile -*-

# Folders
OBJ = ./Objects
LIB = ./Libraries
SRC = ./Source

# Compiler
NAME = Assembler
CC = gcc
INCLUDE = $(foreach D, $(LIB), -I$(D))
DEPFLAGS = -MP -MD
WARNINGS = -Wall -Werror
CFLAGS = $(WARNINGS) $(DEPFLAGS) $(INCLUDE)

# Files list
CFILES = $(foreach D, $(SRC), $(wildcard $(D)/*.c))
OBJECTS = $(patsubst $(SRC)/%.c,$(OBJ)/%.o,$(CFILES))
DEPFILES = $(patsubst %.o,%.d,$(OBJECTS))

# Buildiing the assembler
all: $(NAME)
	@echo The assembler has been built.	

# Linking all object files
$(NAME): $(OBJECTS)
	$(CC) $(OBJECTS) -o $@

# Compiling source file into object file
$(OBJ)/%.o: $(SRC)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

clean-all: clean
	@rm -rf $(OBJ)/*.o $(OBJ)/*.d

clean:
	@rm -rf *.o *.d *.dat *.asm *.s *.txt $(NAME)

status:
	$(info - Repository Status:)
	@git status
	@git diff --stat

# Include dependencies 
-include $(DEPFILES)

