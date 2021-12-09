# CS 3270: Programming Languages
## GitHub Notes

Information on how to use Git/GitHub on the command line

## Access the command line

*Windows users*: using File Explorer, navigate to the folder where you want to perform the `git` commands and then right click and select **Git Bash Here**.

*Mac users*: navigate to the folder where you want to perform the `git` commands and then open a terminal.

For cloning, you'll want to navigate to the folder where you want the cloned folder from GitHub to reside in. For all other commands, navigate into the folder containing your local Git repository.

## Clone (or download) repository from GitHub

Run the following command:

```
git clone <remote_repo>
```

Replace `<remote_repo>` with the URL of your assigned repository on GitHub. The URL can be copied by clicking on the **Code | Clone with HTTPS** button in the repository on GitHub.

For example, the command to clone the repository for Homework 4 that is assigned to a student with GitHub username `vandercc` in the Spring 2021 edition of CS 3270 would look like this:

```
git clone https://github.com/vu-cs3270-s21/hw04-vandercc.git
```

If the command is successful, you now have a local copy of your GitHub repository for Homework 4.

## Commit

Once you are ready to commit some code, open a Bash command prompt or terminal.

You must first *stage* the files that you want to commit. Note that this step needs to be done before actually committing the file(s). This step was not needed in CLion, because it is done automatically for you.

The following command will add (or stage) all files that can be committed in the local repository:

```
git add .
```

If you want to just add (or stage) one particular file, e.g., you only want to commit `hw04.rkt`, in the prompt/terminal, go into (i.e., `cd`) the repository's root folder and then run the following command:

```
git add hw04.rkt
```

If you receive a warning "warning: LF will be replaced by CRLF ...", you can ignore the warning.

Now that you have added (or staged) the files to be committed, you can perform commit step. Run the following command:

```
git commit -m "<message>"
```

You should replace `<message>` with a brief description of what was committed. For example:

```
git commit -m "Completed first two problems."
```

## Push commits to GitHub

Once you've committed, you can push the commits to GitHub. Run the following command:

```
git push
```

You may want to go to your repository on GitHub to confirm that the push completed successfully.