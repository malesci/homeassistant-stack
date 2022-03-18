#!/bin/sh
# Go to /config folder or 
# Change this to your Home Assistant config folder if it is different
cd /config

# For removing gitignore files from remote origin
git ls-files -i -c --exclude-from=.gitignore | xargs git rm --cached

# Add all files to the repository with respect to .gitignore rules
git add .

# Commit changes with message with current date stamp
git commit -m "config files on `date +'%Y-%m-%d %H:%M:%S'`"

# Push changes towards GitHub
git push -u origin main

# ##start setup repository
## https://peyanski.com/automatic-home-assistant-backup-to-github/
# echo "# homeassistant" >> README.md
# git init
# git add README.md
# git commit -m "first commit"
# git branch -M main
# git remote add origin git@github.com:malesci/homeassistant.git
# git config core.sshCommand "ssh -i /config/.ssh/gh_id_rsa -F /dev/null"
# git push -u origin main