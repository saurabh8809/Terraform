#!/bin/bash
cd $(dirname $0)
echo ""

ADDED_FILE=$(git diff --name-only --diff-filter=A HEAD^..HEAD ./input_files/)
MODIFIED_FILE=$(git diff --name-only --diff-filter=M HEAD^..HEAD ./input_files/)
DELETED_FILES=$(git diff --name-only --diff-filter=D HEAD^..HEAD ./input_files/)

if [[ -n $ADDED_FILE ]]; then
    echo "Variable ADDED_FILE is not empty."
else
    echo "Variable ADDED_FILE is empty."
fi

if [[ -n $MODIFIED_FILE ]]; then
    echo "Variable MODIFIED_FILE is not empty."
else
    echo "Variable MODIFIED_FILE is empty."
fi


if [[ -n $DELETED_FILES ]]; then
    echo "Variable  DELETED_FILES is not empty."
else
    echo "Variable is DELETED_FILES empty."
fi
