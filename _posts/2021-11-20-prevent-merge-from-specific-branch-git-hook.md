---
layout: post
title: "Prevent merge from a specific branch using Git Hooks"
date: 2021-11-20 15:30:00 -0300
tags: automation collaboration
redirect_from:
  - /2020/11/restore-single-postgres-table
---

Git Hooks are a little known but incredibly flexible feature of Git. They allow for the execution of arbitrary snippets of code during the several stages of the source code development workflow, for instance: `pre-commit`, `pre-rebase`, `pre-merge-commit`, `post-merge`, among others.

I recently had to implement one for preventing developers from accidentally merging from a specific branch, let's call it "Sandbox", into feature branches of a project. At first I didn't know that I was going to use a Git Hook, but after reading a bit about it seemed the right tool for the job, and the `pre-merge-commit` hook introduced in Git `2.24` fit like a glove to my needs. Here's how it works:

> This hook is invoked by `git-merge`, and can be bypassed with the `--no-verify option`. It takes no parameters, and is invoked after the merge has been carried out successfully and before obtaining the proposed commit log message to make a commit. Exiting with a non-zero status from this script causes the `git merge` command to abort before creating a commit.

So without further ado here's the end result, which was based in [this gist](https://gist.github.com/mwise/69ec35b646b52d98050d):

```sh
#!/bin/sh

# This git hook will prevent merging from specific branches

FORBIDDEN_BRANCH="Sandbox"

if [[ $GIT_REFLOG_ACTION == *merge* ]]; then
	if [[ $GIT_REFLOG_ACTION == *$FORBIDDEN_BRANCH* ]]; then
		echo
		echo \# STOP THE PRESSES!
		echo \#
		echo \# You are trying to merge from: \"$FORBIDDEN_BRANCH\"
		echo \# Surely you don\'t mean that?
		echo \#
		echo \# Run the following command now to discard your working tree changes:
		echo \#
		echo \# git reset --merge
		echo
		exit 1
	fi
fi
```

It's a really simple bash script that confirms the `merge` action is being executed and checks if the name of the forbidden branch is contained in the command. If both conditions are met then the merge action is prevented from being carried out by exiting the script with a non zero return code. 

One downside of Git hooks is that they live in the `.git/hooks` subdirectory of the Git directory which is not under source control, so they need to be manually distributed and installed in each developer's local repository.

Nonetheless you can also use Git's template directory feature to automate the distribution of the hook for newcomers, since it allows for the copy of files and directories to the Git directory when cloning a repository (`git clone`).

---

<b>Further Reference</b>

* [Git Hooks](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)
* [Teamplate Directory](http://git-scm.com/docs/git-init#_template_directory)
