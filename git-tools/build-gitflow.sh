#!/bin/bash


################## FUNCTIONS ################

echo_error() {
    echo -e $1 1>&2
    exit 1
}

add_stuff() {
    RANDOM_FILE="devops-random-file-"`shuf -i 100-999 -n 1`".txt"
    echo $RANDOM_FILE > $RANDOM_FILE
    git add $RANDOM_FILE
}

commit_stuff() {
    add_stuff
    add_stuff
    add_stuff
    git commit -m "$1 added some stuff"
}

#############################################


# Arg checking
if [[ $# -ne 2 ]]; then
  echo_error "Usage: "`basename $0`" <repo_path> <branch_type>"
fi

REPO_PATH=$1
BRANCH=$2

# Params validation
if [[ ! -d $REPO_PATH/.git/ ]]; then
  echo_error "The repo $REPO_PATH does not exists or isn't a git repo"
fi

if [[ $BRANCH != release-* && $BRANCH != feature-* && $BRANCH != bugfix-* && $BRANCH != hotfix-* && $BRANCH != support-* ]]; then
    echo_error "Invalid branch name $BRANCH, valid branches are: release-*, feature-*, bugfix-*, hotfix-*, support-*"
fi


# Parsing params
BRANCH_TYPE=`echo $BRANCH | awk -F "-" '{print $1}'`
BRANCH_NAME=`echo $BRANCH | awk -F "-" '{print $2}'`
if [[ $BRANCH_TYPE == "bugix" || $BRANCH_TYPE == "feature" ]]; then
    # They doesn't go to master, so they doesn't have tag
    BRANCH_ID="TICKET-"`shuf -i 100-999 -n 1`
else
    # Hotfix and release goes to master (and develop), so they will be taged pointing to master
    BRANCH_ID=$BRANCH_NAME
fi




# MAIN EXECUTION

cd $REPO_PATH
git flow init -d > /dev/null

git flow $BRANCH_TYPE start $BRANCH_ID

commit_stuff $BRANCH_ID

git flow $BRANCH_TYPE finish $BRANCH_ID

echo "REMEMBER TO PUSH THE CHANGES"
