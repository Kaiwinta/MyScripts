#!/bin/bash

TYPE=$1
COMMENT=$2
FORCE=$3

if [[ -z "$COMMENT" && "$TYPE" != "-h" ]]; then
    echo "Usage: pushnorme.sh [type] [comment] [--force]"
    echo "[comment] is missing"
    exit 1
fi

case "$TYPE" in
    ".") MESSAGE="[feat]: $COMMENT" ;;
    "-f") MESSAGE="[fix]: $COMMENT" ;;
    "-d") MESSAGE="[doc]: $COMMENT" ;;
    "-s") MESSAGE="[style]: $COMMENT" ;;
    "-rm") MESSAGE="[del]: $COMMENT" ;;
    "-t") MESSAGE="[test]: $COMMENT" ;;
    "-p") MESSAGE="[perf]: $COMMENT" ;;
    "-r") MESSAGE="[refactor]: $COMMENT" ;;
    "-b") MESSAGE="[build]: $COMMENT" ;;
    "-m") MESSAGE="[merge]: $COMMENT" ;;
    "-h") 
        echo "Usage: pushnorme.sh [type] [comment] [--force]"
        echo "type: -f fix, -d doc, -rm del, -s style, -t test, -b build, -m merge -p perf, -r refactor, -h help"
        echo "type: -h help"
        echo "type: feature being the default (Use pushnorme.sh . [comment])"
        echo "comment: comment of the commit"
        echo "force: --force to force the commit even if the Makefile fails"
        exit 0
        ;;
    *) MESSAGE="[feat]: $COMMENT" ;;
esac

if [[ -f Makefile && (-z "$FORCE" || "$FORCE" != "--force") ]]; then
    make fclean && make -j16 || { 
        echo "Make failed, attempting full clean rebuild..."
        make fclean && make -j16 && make fclean || {
            echo "Error: Build failed even after full clean"
            exit 1
        }
    }
    if make tests_run > /dev/null 2>&1; then
        echo "Tests executed successfully."
    else
        if make tests_run 2>&1 | grep -q "No rule to make target 'tests_run'"; then
            echo "No tests found, continuing..."
        else
            echo "Tests failed."
            exit 1
        fi
    fi
fi

if  git branch | grep -q "* main" ; then
    echo "Trying to commit on the main branch is a bad habits"
    echo "Do you want to continue? [y/n]"
    read -r answer
    if [[ "$answer" != "y" ]]; then
        echo "Aborting..."
        exit 0
    fi
fi

if git commit -m "$MESSAGE" | grep "nothing to commit" ; then
    echo "Quitting due to absence of changes"
    exit 0
fi
git push 2> /tmp/pushnorme_error


if [[ -s /tmp/pushnorme_error ]]; then
    echo "Error: Push failed, trying to set upstream..."
    cmd=$(cat /tmp/pushnorme_error | grep "git push --set-upstream")
    if [[ -n "$cmd" ]]; then
        echo "Executing: $cmd"
        eval "$cmd"
        rm /tmp/pushnorme_error
        exit 0
    else
        cat /tmp/pushnorme_error
        rm /tmp/pushnorme_error
        exit 1
    fi
fi

