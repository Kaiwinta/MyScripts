##
## EPITECH PROJECT, 2024
## DEFINE_NAME
## File description:
## Makefile
##

.SILENT:

BUILD_DIR = build
NAME = DEFINE_NAME

all: $(NAME)

$(NAME):
	mkdir -p $(BUILD_DIR)
	cd $(BUILD_DIR) && cmake .. > /dev/null
	cd $(BUILD_DIR) && cmake --build . > /dev/null
	cp $(BUILD_DIR)/$(NAME) . > /dev/null 2>&1 || true
	echo "[✔] - Build complete: $(NAME)"

clean:
	rm -rf $(BUILD_DIR)/*
	rm -f $(NAME)
	echo "[✔] - Clean complete"

fclean: clean
	rm -rf $(BUILD_DIR)
	echo "[✔] - Full clean complete"

re: fclean all

tests_script: re
	if [ -f ./tests/start_test.sh ]; then \
		clear; \
		./tests/start_test.sh; \
	else \
		echo "No tester file in this repo"; \
		exit 0; \
	fi

.PHONY: all clean fclean re tests_script