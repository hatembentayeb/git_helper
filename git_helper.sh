#!/bin/bash 
##########################################################################
##  Maintainer: HATEM BEN TAYEB 
##  This script aim to help git users to template their git commits
##########################################################################



# Define different git actions, useful for templating the commit message
u="UPDATE"
f="FIX"
a="ADD"


GitHost=$(git remote -v |tr "\n" " " | awk '{print $2}' | cut -d'/' -f 3)
repo_name=$(basename `git rev-parse --show-toplevel`)
branch_name=$( git rev-parse --abbrev-ref HEAD)
commit_date=$(date +'%Y-%m-%d  %H:%M:%S')
commit_count=$(git rev-list --all --count)

# Read options passed as arguments to the script
while getopts "a:u:f:c:" opt; do
    case $opt in
        a) files="$OPTARG"  action=$a;;
        u) files="$OPTARG"  action=$u;;
        f) files="$OPTARG"  action=$f;;
        c) commit_msg="$OPTARG";;
        *)  exit 0;;
    esac
done

# Show informations about current commit before continuing
echo -e " \
GitHost     : $GitHost \n \
RepoName    : $repo_name \n \
BranchName  : $branch_name \n \
Action      : $action  \n \
CommitMsg   : $commit_msg \n \
CommitDate  : $commit_date\n \
files  : $files\n \
CommitCount : $commit_count "| \
boxes -d stone

# Ask user permission to continue towards the git flow process 

read -p " Validate (Y/N)? : " ok

echo -e " \n"

if [[ $ok == "y" ]] 
then 

    git add $files && git commit -m "$action: $commit_msg on $commit_date" && git push origin $branch_name
    
else 

    echo -e "\n [-] Thabet ro7ek !!\n"

fi