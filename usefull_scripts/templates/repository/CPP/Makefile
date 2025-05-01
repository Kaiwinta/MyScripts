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

tests_script: re
	if [ -f ./tests/start_test.sh ]; then \
		clear \
		./tests/start_test.sh; \
	else \
		echo "No tester file in this repo"; \
		exit 0; \
	fi

.PHONY: all clean fclean debug re tests_script
