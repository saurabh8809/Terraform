#!/bin/bash
cd $(dirname $0)
echo ""

ADDED_FILE=$(git diff --name-only --diff-filter=A HEAD^..HEAD ./input_files/)

# ADDED_FILE="input_files/vnet-var.json"

# DELETED_FILES="input_files/vnet-var-2.json
# input_files/vnet-var.json"

MODIFIED_FILE=$(git diff --name-only --diff-filter=M HEAD^..HEAD ./input_files/)
# MODIFIED_FILE="input_files/mod.json"
# DELETED_FILES=$(git diff --name-only --diff-filter=D HEAD^..HEAD ./input_files/)
DELETED_FILES="input_files/vnet-var-2.json"

if [[ -n ${ADDED_FILE} ]]; then
#{
    for vNAME in ${ADDED_FILE}
    do 
        AD_FILE_NAME=$(echo ${vNAME} | awk -F '/' '{print $2}')
        TF_WORKSPACE_NAME=$(echo ${vNAME} | awk -F '/' '{print $2}' | awk -F '.' '{print $1}')
        echo "ADDED_FILE is ${AD_FILE_NAME} and Workspace is ${TF_WORKSPACE_NAME}"
        terraform init
        terraform workspace new ${TF_WORKSPACE_NAME}
        terraform apply --auto-approve --var-file=${vNAME}
    done
#}
else
    echo "Variable ADDED_FILE is empty."
fi


if [[ -n ${MODIFIED_FILE} ]]; then
#{
    for vNAME in ${MODIFIED_FILE}
    do 
        MD_FILE_NAME=$(echo ${vNAME} | awk -F '/' '{print $2}')
        TF_WORKSPACE_NAME=$(echo ${vNAME} | awk -F '/' '{print $2}' | awk -F '.' '{print $1}')
        echo "MODIFIED_FILE is ${MD_FILE_NAME} and Workspace is ${TF_WORKSPACE_NAME}"
        terraform init
        terraform workspace select ${TF_WORKSPACE_NAME}
        terraform apply --auto-approve --var-file=${vNAME}
    done
#}
else
    echo "Variable MODIFIED_FILE is empty."
fi


if [[ -n ${DELETED_FILES} ]]; then
#{

    for vNAME in ${DELETED_FILES}
    do 
        DELL_FILE_NAME=$(echo ${vNAME} | awk -F '/' '{print $2}')
        TF_WORKSPACE_NAME=$(echo ${vNAME} | awk -F '/' '{print $2}' | awk -F '.' '{print $1}')
        echo "DELETED_FILES is ${DELL_FILE_NAME} and Workspace is ${TF_WORKSPACE_NAME}"
        terraform init
        terraform workspace select ${TF_WORKSPACE_NAME}
        if [[ $? != 0 ]]
        then
            echo "ERROR:Workspace  ${TF_WORKSPACE_NAME} doesn't exist. Exiting..."
            exit 1
        fi
        terraform destroy --auto-approve --var-file=${vNAME}
        terraform workspace select default
        terraform workspace delete ${TF_WORKSPACE_NAME}
    done


# You can create this workspace with the "new" subcommand
# or include the "-or-create" flag with the "select" subcommand.

    # DELL_FILE_NAME=$(echo ${DELETED_FILES} | awk -F '/' '{print $2}')
    # TF_WORKSPACE_NAME=$(echo ${DELETED_FILES} | awk -F '/' '{print $2}' | awk -F '.' '{print $1}')
    # echo "DELETED_FILES is ${DEll_FILE_NAME} and Workspace is ${TF_WORKSPACE_NAME}"
#}
else
    echo "Variable is DELETED_FILES empty."
fi
