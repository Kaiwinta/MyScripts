##
## EPITECH PROJECT, 2025
## DEFINE_NAME
## File description:
## Makefile
##

EXEC = DEFINE_NAME

STACKPROJET = project-test

SFLAGS = --allow-different-user

BPATHFLAG = --local-install-root --stack-yaml "stack.yaml"

BINPATH := $(shell stack path $(BPATHFLAG) $(SFLAGS) )/bin/$(STACKPROJET)-exe
all: $(EXEC)

$(EXEC):
	stack build $(SFLAGS)
	@if [ -f "$(BINPATH)" ]; then \
		cp $(BINPATH) $(EXEC); \
	else \
		echo "Error: $(BINPATH) not found!"; \
		exit 1; \
	fi

clean:
	stack clean $(SFLAGS)

fclean: clean
	stack clean $(SFLAGS) --full
	rm -f $(EXEC)

re: fclean all

run_tests:
	stack test $(SFLAGS) --coverage

generate_report:
	stack hpc report --all --destdir test/coverage

tests_run: re run_tests generate_report

ci: SFLAGS += --stack-root /tmp/.stack
ci:
	mkdir -p /tmp/.stack
	stack build $(SFLAGS)
	stack test $(SFLAGS) --coverage
	stack hpc report --all --destdir test/coverage $(SFLAGS)

silent: SFLAGS += --silent
silent: re

.PHONY: all clean fclean re tests_run silent ci
