##
## EPITECH PROJECT, 2025
## DEFINE_NAME
## File description:
## Makefile
##

.SILENT:

NAME    =   DEFINE_NAME

SRC   =   $(wildcard src/*.c src/*/*.c src/*/*/*.c)

OBJ	=	$(SRC:.c=.o)

IFLAGS	=	-I./include

WFLAGS	=	-Wall -Wconversion -Wpedantic -O3 \
            -Wsign-compare -Wtype-limits -Walloc-zero \
            -Wmissing-field-initializers -Wunused-variable \
            -Wcast-qual -Wduplicated-branches \
            -Winit-self -Wuninitialized

CFLAGS  =   $(IFLAGS) $(WFLAGS)

all: $(OBJ)
	gcc -o $(NAME) $(OBJ) $(CFLAGS)
	printf "[%s] — Successfully compiled\n" $(NAME)

clean:
	rm -f $(OBJ)
	rm -f vgcore.*

fclean: clean
	rm -f $(NAME)

re: fclean all

debug: CFLAGS += -g
debug: re
	printf "[%s] — Debug mode enabled\n" $(NAME)

tests_script: re
	if [ -f ./tests/start_test.sh ]; then \
		clear \
		./tests/start_test.sh; \
	else \
		echo "No tester file in this repo"; \
		exit 0; \
	fi

.PHONY: all clean fclean re debug tests_script
