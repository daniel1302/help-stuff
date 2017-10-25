git cherry-pick [sha-commita]                         move one commit into current branch
git revert [sha-commita]                              revert changes
git revert -m 1 [sha-commita]                         revert only one merge
git update-index --assume-unchanged [file-name]       disable file following
git rm --cached -r [file-name]                        remove file from cache
git commit --amend                                    update last commit that is not pushed
git commit --amend --reset-author                     update author of last commit
git reset --soft HEAD~1                               delete last commit without deleting files
git diff --cached                                     dIff from cache


git stash                                             add files to stash
git stash list                                        show stashes
git stash show -p stash@{[NUMER_SATASHA]}             git diff for stash
git stash apply stash@{[NUMER_SATASHA]}               apply changes from stash
git stash drop stash@{[NUMER_SATASHA]}                remove stash

git branch [NAZWA_BRANCHA]                            add new branch
git branch -d [NAZWA_BRANCHA]                         remove branch
git branch --merged                                   show merged branches
git branch --no-merged                                show no merged branches
