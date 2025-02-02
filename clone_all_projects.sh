#!/usr/bin/env bash
# script for cloning all projects from gitlab project group
# make script executable, prepare gitlab token, subgroup id and ssh keys

work_dir=&(pwd)

# personal gitlab token
# https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html
echo Please enter your gitlab personal access token:
read TOKEN
# group id from gitlab web interface
echo Enter gitlab group id:
read GITLAB_GROUP_ID

# getting all projects info by gitlab api, a lot of info
curl --header "PRIVATE-TOKEN:$TOKEN" -s "https://gitlab.com/api/v4/groups/$GITLAB_GROUP_ID/projects?include_subgroups=true&per_page100" > ${work_dir}/repo_list.txt

# looking for search string, deleting double quotes
grep -oP '(?<=\bssh_url_to_repo\":)[^,]+' ${work_dir}/repo_list.txt | tr -d '"' > ${work_dir}/ssh_url_list.txt

# cloning each repo
# you need to have ssh keys to clone without password
# https://docs.gitlab.com/ee/user/ssh.html

while read i; do
	git clone $i
done < ${work_dir}/ssh_url_list.txt

