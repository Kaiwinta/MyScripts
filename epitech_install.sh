#/bin/bash

mkdir ~/Epitech
mkdir ~/Epitech/tek1
mkdir ~/Epitech/tek2
mkdir ~/Epitech/AER
mkdir ~/Epitech/Hub


ORG_NAME="EpitechPromo2028"

YEARS="tek1"
MODULE="OTHER"

gh repo list $ORG_NAME --limit 1000 --json name --jq '.[].name' | while read repo; do
    if [[ "$repo" =~ -[1-2][0-9]{2} ]]; then
        YEARS="tek1"
    elif [[ "$repo" =~ -[3-4][0-9]{2} ]]; then
        YEARS="tek2"
    fi
    if [[ "$repo" =~ B-([A-Za-z]{3})- ]]; then
        MODULE="${BASH_REMATCH[1]}"
    elif [[ "$repo" =~ G-([A-Za-z]{3})- ]]; then
        MODULE="${BASH_REMATCH[1]}"
    else
        MODULE="Unknown"
    fi
    if [[ "$repo" =~ -([A-Za-z0-9]+)-titouan\.pradoura$ ]]; then
        PROJECT_NAME="${BASH_REMATCH[1]}"
    else
        PROJECT_NAME="$repo"
    fi

    git clone "git@github.com:$ORG_NAME/$repo.git" ~/Epitech/$YEARS/$MODULE/$PROJECT_NAME
done
