TYPE=$1
PROJECT_NAME=$2

TEMPLATE_PATH="templates"

if [[ -z "$PROJECT_NAME" ]]; then
    echo "Usage: init_project.sh [type] [project_name]"
    echo "[project_name] is missing"
    exit 1
fi

base_project() {
    FOLDER=$1

    echo "Initializing $FOLDER project $PROJECT_NAME"
    echo "Creating project structure"
    mkdir -p include src

    if [[ -f "$TEMPLATE_PATH/$FOLDER/.gitignore" ]]; then
        cp "$TEMPLATE_PATH/$FOLDER/.gitignore" .gitignore
        sed -i 's/DEFINE_NAME/'"$PROJECT_NAME"'/g' .gitignore
    else
        echo ".gitignore not found in $TEMPLATE_PATH/$FOLDER"
    fi

    if [[ -f "$TEMPLATE_PATH/$FOLDER/Makefile" ]]; then
        cp "$TEMPLATE_PATH/$FOLDER/Makefile" Makefile
        sed -i 's/DEFINE_NAME/'"$PROJECT_NAME"'/g' Makefile
    else
        echo "Makefile not found in $TEMPLATE_PATH/$FOLDER"
    fi

    if [[ -d "$TEMPLATE_PATH/$FOLDER/src" ]]; then
        cp -r "$TEMPLATE_PATH/$FOLDER/src" .
    else
        echo "src/ not found in $TEMPLATE_PATH/$FOLDER"
    fi

    touch include/.gitkeep
    echo "Project $PROJECT_NAME initialized"
}

if [[ "$TYPE" == "-C" ]]; then
    base_project C
elif [[ "$TYPE" == "-CPP" ]]; then
    base_project CPP
fi