# Git commands

### Simple commands

```
  git cherry-pick [sha-commita]                         move one commit into current branch
  git revert [sha-commita]                              revert changes
  git revert -m 1 [sha-commita]                         revert only one merge
  git update-index --assume-unchanged [file-name]       disable file following
  git rm --cached -r --ignore-unmatch [file-name]       remove file from cache
  git commit --amend                                    update last commit that is not pushed
  git commit --amend --reset-author                     update author of last commit
  git reset --soft HEAD~1                               delete last commit without deleting files
  git diff --cached                                     dIff from cache


  git stash                                             add files to stash
  git stash list                                        show stashes
  git stash show -p stash@{[STASH_NO]}                  git diff for stash
  git stash apply stash@{[STASH_NO]}                    apply changes from stash
  git stash drop stash@{[STASH_NO]}                     remove stash

  git branch [BRANCH_NAME]                              add new branch
  git branch -d [BRANCH_NAME]                           remove branch
  git branch --merged                                   show merged branches
  git branch --no-merged                                show no merged branches
  git checkout -b [NEW_NAME] master                     creates a branch called [NEW_NAME] based on master
  git push -u origin [NEW_NAME]                         push new branch to origin and turn on remote tracking(-u)

```


### Git config
```
git config --global user.name "[USER_NAME]"
git config --global user.email [EMAIL]
git config --global core.editor [EDITOR_NAME]
git config --global --add url."git@github.com:".insteadOf "https://github.com/"

```


### Git aliases
```
git config --global alias.tree "log --oneline --decorate --all --graph"
git config --global alias.tree1 "log --oneline --decorate --all --graph --format='%Cblue%h%Cgreen<%an>: %Creset%B'"
git config --global alias.diff-tree "log --left-right --graph --cherry-pick --oneline"
```

Example:
 - `git diff-tree master...development`
