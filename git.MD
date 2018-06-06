# Git

## UNDO THIS THING I JUST DID!

    Unstaged (Un-added) files that have changed:
    `$ git clean -f`
    To see what files will be affected before running this command, can do:
    `$ git clean -n`

    undo changes before they have been "git add"ed
    `$ git checkout -- <file_name>`

    stash changes before they have been "git add"ed
    `$ git stash`

    undo changes after they have been "git add"ed
    `$ git reset <file_name> || git reset`

    undo changes after git commit


## WHERE AM I?

    go back and forth in commit history
    `$ git checkout <commit_hash>`

    what commit am I currently on?
    `$ git show`


## FUN WITH BRANCHES

    delete branch locally and remotely
    `$ git push <remote_name> --delete <branch_name>`
    `$ git branch -d <branch_name>`


## WORKING WITH REMOTES

    `git add remote <name-of-remote>`
    `git remote rm <name-of-remote>`
    `git remote -v`


## REBASING

### INTEGRATING FEATURE BRANCH INTO INTEGRATION BRANCH

#### overview- this process will include 2 different uses of ‘git rebaseʼ and 1 use of ‘git mergeʼ. Git rebase is like a swiss army knife, you can do many different things with it.
##### FIGURE OUT HOW MANY COMMITS ARE IN FEATURE BRANCH THAT NEED TO BE SQUASHED
1. git log — this will show you all commits, with the latest commit being at the top.
2. Count how many commits there are from the top commit all the way down till you find the 1st commit of your feature branch.
##### TELL GIT HOW MANY COMMITS YOU ARE LOOKING TO SQUASH (the ones you just counted)
3. `git rebase -i HEAD~4`
  * In this example, we counted 4 commits from the latest commit to the first one of the feature branch
##### DO THE SQUASHING
— The RANGE OF COMMITS is expressed from (the latest) HEAD through the 4 commits before HEAD
— A text editor will pop up after this command, this is your access to the many tools in the swiss army knife that is git rebase
— Here we pick up at the text editor which popped up, depending on what text editor your CLI uses, it should look something similar to this:
##### THINGS TO KNOW AT THIS STEP
- The keyword “pick” is one of the tools of the swiss army knife, it basically
says “hey keep this thing the same”. We can replace that keyword to
do different things
- What we want to do is “squash”, so for every commit that you want to
squash, erase the pick keyword and write squash
- YOU CANNOT SQUASH ALL COMMITS, the act of squashing requires at
least one commit to remain, this will be the commit that contains all
the other squashed commits.
- YOU CANNOT SQUASH THE FIRST COMMIT IN THIS LIST, the one at
the top (which is the earliest of the commits). This one must remain.
So an example where we squash these 4 commits into one would look like this:

 —Next step to squashing is to SAVE the file and EXIT.
— FINAL STEP — ANOTHER TEXT EDITOR WILL POP UP.
For simplicityʼs sake, you can simply just EXIT out of this one. AND DONE. 

Do you even squash bro?

##### THE NEW WAY TO DO A MERGE, CALLED “FAST FORWARD MERGE”
— When you do a simple “git merge” a brand new commit is created purely to commemorate the act of this merge. This is clutter that we want to avoid.
— So the new way to merge is
1. Go to your feature branch — `$ git checkout <my-feature-branch>`
2. Rebase feature branch onto integration — `$ git rebase integration`
3. Switch to integration — `$ git checkout integration`
4. Do the merge — `$ git merge <my-feature-branch>`

AND DONE.
