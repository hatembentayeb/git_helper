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
action=$( if [[ $1 == "u" ]];then echo $u;elif [[ $1 == "f" ]];then echo $f;elif [[ $1 == "a" ]];then echo $a;fi )
commit_msg=$2
commit_date=$(date +'%Y-%m-%d  %H:%M:%S')
commit_count=$(git rev-list --all --count)


# Show informations about current commit before continuing
echo -e " \
GitHost     : $GitHost \n \
RepoName    : $repo_name \n \
BranchName  : $branch_name \n \
Action      : $action  \n \
CommitMsg   : $commit_msg \n \
CommitDate  : $commit_date\n \
CommitCount : $commit_count "| \
boxes -d stone

# Ask user permission to continue towards the git flow process 

read -p " Validate (Y/N)? : " ok

echo -e " \n"

if [[ $ok == "y" ]] 
then 

    git add -A && git commit -m "$u: $commit_msg on $commit_date" && git push origin $branch_name
    
else 

    echo -e "\n [-] Thabet ro7ek !!\n"

fi