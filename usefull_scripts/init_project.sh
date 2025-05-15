#!/bin/bash

TYPE=$1
PROJECT_NAME=$2

SCRIPT_FULL_PATH="$(realpath "$0")"
SCRIPT_DIR="$(dirname "$SCRIPT_FULL_PATH")"

TEMPLATE_PATH="$SCRIPT_DIR/templates"
REPOTEMPLATE_PATH="$TEMPLATE_PATH/repository"
WORKFLOWTEMPLATE_PATH="$TEMPLATE_PATH/workflows"

GIT_PROJECT=false

if [[ -z "$PROJECT_NAME" ]]; then
    echo "Usage: init_project.sh [type] [project_name]"
    echo "[project_name] is missing"
    exit 1
fi


read -p "Do you want to setup a git project? (yes/no) " yn
    case $yn in
        yes | Y | y | Yes | YES)
            GIT_PROJECT=true
            ;;
        *)
    esac

stack_project() {
    BASE_PROJECT_NAME=project-test

    echo "Copying Workflows file and dependencies"
    cp -r "$WORKFLOWTEMPLATE_PATH/Hs/." 

    echo "Renaming Makefile..."
    sed -i 's/DEFINE_NAME/'"$PROJECT_NAME"'/g' Makefile
    sed -i "s/$BASE_PROJECT_NAME/$PROJECT_NAME/g" Makefile
    echo "Renaming .gitignore..."
    sed -i "s/$BASE_PROJECT_NAME/$PROJECT_NAME/g" .gitignore
    echo "Renaming $BASE_PROJECT_NAME.cabal..."
    sed -i "s/$BASE_PROJECT_NAME/$PROJECT_NAME/g" $BASE_PROJECT_NAME.cabal
    echo "Renaming package.yaml..."
    sed -i "s/$BASE_PROJECT_NAME/$PROJECT_NAME/g" package.yaml
    echo "Renaming cabal file name..."
    mv $BASE_PROJECT_NAME.cabal $PROJECT_NAME.cabal
    echo "Project '$PROJECT_NAME' initialized successfully!"
}

c_based_project() {
    echo "Renaming Makefile..."
    sed -i 's/DEFINE_NAME/'"$PROJECT_NAME"'/g' Makefile

    if [[ "$1" == "CPP" ]]; then
        echo "Renaming CMakeLists.txt..."
        sed -i 's/DEFINE_NAME/'"$PROJECT_NAME"'/g' CMakeLists.txt
    fi

    echo "Copying Workflows file and dependencies"
    cp -r "$WORKFLOWTEMPLATE_PATH/C-CPP/." .

    echo "Renaming Build workflow..."
    sed -i "s/DEFINE_NAME/$PROJECT_NAME/g" .github/workflows/Build.yml

    if [[ -f ".github/workflows/Deploy.yml" ]]; then
        echo "Renaming Deploy workflow..."
        sed -i "s/DEFINE_NAME/$PROJECT_NAME/g" .github/workflows/Deploy.yml
    fi
}

base_project() {
    FOLDER=$1

    echo "Initializing $FOLDER project: $PROJECT_NAME"

    echo "Copying template..."
    cp -r "$REPOTEMPLATE_PATH/$FOLDER/." .

    echo "Copy done, renaming files..."
    if [[ "$FOLDER" == "C" ]]; then
        c_based_project C
    elif [[ "$FOLDER" == "CPP" ]]; then
        c_based_project CPP
    elif [[ "$FOLDER" == "Hs" ]]; then
        stack_project Hs
    fi

    if [[ "$GIT_PROJECT" == true ]]; then
        if [[ -f ".gitignore" ]]; then
            echo "Renaming .gitignore..."
            sed -i "s/DEFINE_NAME/$PROJECT_NAME/g" .gitignore
        fi
        echo "Project '$PROJECT_NAME' initialized successfully!"
        if [[ ! -d ".git" ]]; then
            echo "You are not in a git repository, Push is not possible"
            exit 1
        fi
        git add -A
        git commit -m "🎉 Initial commit 🎉"
        git push
        echo "setting up deploy and dev branches..."
        if [[ -f ".github/workflows/Deploy.yml" ]]; then
            git checkout -b deploy
            git push --set-upstream origin deploy
        fi
        git checkout -b dev
        git push --set-upstream origin dev
    else
        if [[ -f ".gitignore" ]]; then
            echo "Removing .gitignore file..."
            rm .gitignore
        fi
    fi

}

if [[ "$TYPE" == "-C" ]]; then
    base_project C
elif [[ "$TYPE" == "-CPP" ]]; then
    base_project CPP
elif [[ "$TYPE" == "-Hs" ]]; then
    base_project Hs
else
    echo "Invalid project type: $TYPE"
    echo "Valid options: -C, -CPP, -Hs"
    exit 1
fi
