#/bin/bash

ORG_NAME="EpitechPromo2028"
TEK3_ORG_NAME="EpitechPGE3-2025"

YEARS="tek1"
MODULE="OTHER"

clone_one_roga() {
    ORG_NAME="$1"
    REMOVE_GIT="$2"

    gh repo list "$ORG_NAME" --limit 1000 --json name --jq '.[].name' | while read -r repo; do

        if [[ "$repo" =~ ^[BG]-([A-Z]{3})-([0-9]{3})-STG-([0-9]+)-[0-9]+-([^-]+) ]]; then
            MODULE="${BASH_REMATCH[1]}"
            LEVEL="${BASH_REMATCH[2]}"
            SEMESTER="${BASH_REMATCH[3]}"
            PROJECT_NAME="${BASH_REMATCH[4]}"
        else
            echo "Skipping unrecognized repo: $repo"
            continue
        fi

        if (( LEVEL < 300 )); then
            YEARS="tek1"
        elif (( LEVEL < 500 )); then
            YEARS="tek2"
        else
            YEARS="tek3"
        fi

        TARGET_DIR="./Epitech/$YEARS/Semester$SEMESTER/$MODULE/$PROJECT_NAME"

        echo "Cloning $repo → $TARGET_DIR"
        mkdir -p "$TARGET_DIR"
        git clone "git@github.com:$ORG_NAME/$repo.git" "$TARGET_DIR"
        FILE_COUNT=$(ls "$TARGET_DIR" | wc -l)
        if (( FILE_COUNT == 0 )); then
            rm -rf "$TARGET_DIR"
        elif [[ "$REMOVE_GIT" == "true" ]]; then
            rm -rf "$TARGET_DIR/.git"
        fi
    done
}

setup_epitech_repo() {
    mkdir ~/Epitech
    mkdir ~/Epitech/tek1
    mkdir ~/Epitech/tek2
    mkdir ~/Epitech/tek3

    clone_one_roga $ORG_NAME "false"
    clone_one_roga $TEK3_ORG_NAME "false"
}
