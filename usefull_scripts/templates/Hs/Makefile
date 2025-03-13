##
## EPITECH PROJECT, 2025
## DEFINE_NAME
## File description:
## Makefile
##

EXEC = DEFINE_NAME

STACKPROJET = project-test

STACKFLAGS = --allow-different-user

BINPATHFLAGS = --local-install-root --stack-yaml "stack.yaml"

BINPATH := $(shell stack path $(BINPATHFLAGS) --allow-different-user )/bin/$(STACKPROJET)-exe

all: $(EXEC)

$(EXEC):
	stack build $(STACKFLAGS)
	@if [ -f "$(BINPATH)" ]; then \
		cp $(BINPATH) $(EXEC); \
	else \
		echo "Error: $(BINPATH) not found!"; \
		exit 1; \
	fi

clean:
	stack clean $(STACKFLAGS)

fclean: clean
	stack clean $(STACKFLAGS) --full
	rm -f $(EXEC)

re: fclean all

run_tests:
	stack test $(STACKFLAGS) --coverage

generate_report:
	stack hpc report --all --destdir test/coverage

tests_run: re run_tests generate_report

ci: STACKFLAGS += --stack-root /tmp/.stack
ci:
	mkdir -p /tmp/.stack
	stack build $(STACKFLAGS)
	stack test $(STACKFLAGS) --coverage
	stack hpc report --all --destdir test/coverage $(STACKFLAGS)

silent: STACKFLAGS += --silent
silent: re

.PHONY: all clean fclean re tests_run silent ci