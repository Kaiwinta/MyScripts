##
## EPITECH PROJECT, 2024
## nanotekSpice
## File description:
## Makefile
##

.SILENT:

SRC = $(wildcard src/*.cpp) $(wildcard src/*/*.cpp) $(wildcard src/*/*/*.cpp)

# All the o in a build to be cleaner
OBJ = $(SRC:src/%.cpp=build/%.o)

CPPFLAGS += -Wall -Wextra -Werror -I./include

NAME = DEFINE_NAME

all: $(NAME)

$(NAME): $(OBJ)
	g++ $(CPPFLAGS) -o $(NAME) $(OBJ)
	printf "[%s] - Successfully compiled\n" $(NAME)

build/%.o: src/%.cpp
	mkdir -p $(dir $@)
	g++ $(CPPFLAGS) -c $< -o $@

clean:
	rm -rf build/

fclean: clean
	rm -rf $(NAME)

re: fclean all

debug: CPPFLAGS += -g
debug: re
	printf "[%s] - Debug mode enabled\n" $(NAME)

tests_all: re
	clear
	./tests/start_test.sh

.PHONY: all clean fclean debug re tests_all
