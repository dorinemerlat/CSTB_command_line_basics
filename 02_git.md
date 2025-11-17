
# Introduction to Git and GitHub

## Why Use Git?

New sentence.

- **Version Control for Your Code:** Git allows you to track changes in your code, revert back to previous versions, and maintain an organized history of your project.
- **Track Changes in Your Code's History:** With Git, every change you make can be logged, and you can compare versions to see what has been modified over time.
- **Collaborate with Others:** Git enables multiple developers to work on the same codebase simultaneously without conflicts. By managing changes through branches and merges, Git keeps everything organized.
- **Backup Your Code Remotely:** Using Git hosting platforms like GitHub or GitLab, you can store your code remotely. This acts as a backup, ensuring that your work is safe even if your local machine fails.

## Git Hosting Services:

Git repositories need a remote service to be easily accessible, particularly when working collaboratively. Two popular Git hosting services are:

- **GitHub:** GitHub is a web-based platform that provides Git repository hosting. It also offers additional features such as issue tracking, code review, continuous integration, and collaboration tools.
- **GitLab:** GitLab is another Git hosting platform that offers similar features as GitHub. It includes Git repositories, continuous integration, and a variety of tools for managing your code and project lifecycle.

## Connect Your Local Git to SSH

Using SSH (Secure Shell) keys is a secure method of connecting to Git hosting services like GitHub or GitLab. This allows you to push and pull changes from your repositories without needing to enter your username and password each time.

### Connect in command line

To set up SSH:

1. Generate an SSH key on your local machine:
   
```bash
ssh-keygen -t rsa -b 4096
```

2. Add the SSH key to your Git hosting service account (GitHub or GitLab). Go to your account settings -> SSH Keys, and add the public key (usually found in `~/.ssh/id_rsa.pub`).
3. Test the SSH connection:

```bash	
ssh -T git@github.com
```

### Connect with VSCode

You can also connect your local Git to GiHub using the VSCode interface.

1. Open VSCode and go to the Source Control tab.
2. Click on the gear icon and select "Clone Repository."
3. Choose the repository you want to clone and select "Clone."
4. You will be prompted to sign in to your GitHub account and authorize the connection.
5. Once connected, you can push and pull changes directly from VSCode.
   
**Exercise**: Connect your GitHub account to your local machine (in your case: your server account) using the method of your choice.

## Cloning a Repository

Cloning a repository means creating a copy of a remote repository on your local machine. To clone a repository, use the following command:

```bash
git clone <repository_url>
```

## Forking a Repository

Forking is the process of creating a copy of someone else's repository under your account. This is useful if you want to make changes to a project but don't have direct write access to the original repository. You can later submit a pull request to propose your changes.

To fork a repository:
1. Go to the repository page on GitHub or GitLab.
2. Click the "Fork" button to create a copy of the repository under your own account.

**Exercise**: Fork this repository on GitHub (use the "Fork" button) and clone your fork to your local machine using `git clone <your-fork-url>`.

## The Commit

A commit is the fundamental unit of change in Git. It represents a snapshot of the project at a given point in time. A commit includes:

- **A set of changes** (the diff, which shows what files were modified and how).
- **A commit message**, which describes the changes you made.

Each commit is identified by a unique hash (a long string of characters) that serves as a reference to that specific snapshot.

Example: 

```bash
git commit -m "First release of Hello World!"
```

Output:

```
[master (root-commit) 221ec6e] First release of Hello World!
 3 files changed, 26 insertions(+)
 create mode 100644 README.md
 create mode 100644 bluestyle.css
 create mode 100644 index.html
```

The identifier `221ec6e` is the commit hash, the message `add git.md` describes the changes made in this commit and the next lines shows the files that were created, modified or removed and how many lines were added or deleted.

### Best Practices for Commit

- **1 commit = 1 feature:** It is best practice to commit related changes together. For example, don't commit code that changes the layout of a website alongside code that adds a new feature.
- **Descriptive commit messages:** Make sure your commit messages clearly describe what the changes are. A good commit message helps you and others understand what was done and why.

## Diff

A diff is a comparison between two versions of the code. It shows the changes made between those versions, highlighting what was added, modified, or deleted.

### Using the Command Line

```bash
git diff <commit1> <commit2>
```

### Using VSCode

In the `Source Control Graph` of `Source Control` panel, click on a commit. You can see the changes made to your files. The green lines represent additions, red lines represent deletions, and yellow lines represent modifications.

### On GitHub

On GitHub, you can view the diff between two commits by going to the commit page and clicking on the "Files changed" tab. This will show you the changes made in that commit.

You can also go to the "History" tab of a file to see the changes made to that file over time.

## Information Commands

Git provides several commands to get information about your project and repository:

- Show the **status** of your working directory: `git status`
- View the **commit history**: `git log` (use `q` to exit). Use `--oneline` option for a more concise view.
- Show the differences between commits: `git diff <commit1> <commit2>`
  
## Adding or Removing Files

To track new files or remove files from Git, use the following commands:

- **Add new or modified files** to the staging area: `git add <file_name>` (`git add .` to add all files)    
- **Remove files** from Git's tracking: `git rm <file_name>`
  
## Committing Changes

Once you've added or removed files, you can commit the changes to Git with the following command:

```bash
git commit -m "Your commit message here"
```

## Pushing and Pulling Changes Remotely

Git allows you to synchronize your local repository with a remote repository, such as GitHub or GitLab. 

- Push your commits to the remote repository: `git push origin <branch_name>`
- Pull changes from the remote repository: `git pull origin <branch_name>`

These commands ensure that your local repository is in sync with the remote repository, allowing for collaboration.

## Branches

Branches are a way to work on different versions of your project. Using branches helps keep your main (master) branch stable while you work on new features or fixes.

### Why Use Branches?

- **Collaborative work:** Multiple people can work on different branches without interfering with each other’s work.
- **Feature development:** You can create a branch for each new feature or bug fix, keeping your main branch stable and functional.


### Working with Branches

- Create a new branch: `git branch <branch_name>`
- Switch to a branch: `git checkout <branch_name>`
- Create and switch to a branch in one command: `git checkout -b <new_branch>`
- Delete a branch: `git branch -d <branch_name>`
- List all branches: `git branch`
  
### Merging Branches

Once you’ve completed your work on a branch and are ready to integrate the changes into the main branch, you can merge the branch:

1. Switch to the main branch: `git checkout main`
2. Merge the other branch into the main branch: `git merge <branch_name>`

## Reverting to a Previous Commit

### Using `git checkout` (Detached HEAD)

If you want to temporarily view or experiment with a previous commit, you can use `git checkout` to move to a specific commit. This will place you in a detached HEAD state, meaning you aren't on a branch but instead just inspecting that particular commit.

```bash
git checkout <commit_hash>
```

To exit the detached HEAD state and return to a branch, use the following command:

```bash
git checkout <branch_name>
```

For example, if you want to return to the main branch, run:

```bash
git checkout main
```

This will bring you back to your working branch, allowing you to continue making changes as usual.

### How to revert to a previous commit using the `git reset` command

To revert to a previous commit, you must first get the commit ID. To do that, run the command below:

```bash
git log --oneline
```

By example, in my terminal, I get the following output:

```
d8139ea (HEAD -> main) add task.txt
ee61567 Update diff part on git.md
53241ab (origin/main) Update git.md
04082b6 add git.md
90f8aef add good_practices.md
37c01e8 First commit
```

To go back to the second commit, you run the `git reset` command followed by the commit ID. That is:

```bash
git reset <commit_id>
```

For example, to go back to the previous commit, you run:

```bash
git reset ee61567
```

Exercise: Open the `task.txt` file and add a new line `4. Research`. Add and commit the changes. Display the changes made in the file. Then, revert to the previous commit.

By default, the `git reset` is a **soft** reset. It moves the HEAD to a specified commit without affecting your working directory or staging area. The changes stay in your files and are still staged for commit. Useful to uncommit changes but keep them for modification.

With the `--hard` option, the reset will move the HEAD to a specified commit and discard all changes in the working directory and staging area. Useful to discard changes and start fresh.Be cautious as this **permanently deletes changes**.

```bash	
git reset --hard <commit_hash>
```

### How to revert to a previous commit using the `git revert ` command

Unlike the git reset command, the git revert command creates a new commit for the reverted changes. The commit where we reverted from will not be deleted.

```bash
git revert <commit_id>
```

### When to use `git reset` or `git revert`

You should use `git reset` when working on a local repository with changes yet to be pushed remotely. This is because running this command after pulling changes from the remote repo will alter the commit history of the project, leading to merge conflicts for everyone working on the project.

`git reset` is a good option when you realize that the changes being made to a particular local branch should be somewhere else. You can reset and move to the desired branch without losing your file changes.

`git revert` is a good option for reverting changes pushed to a remote repository. Since this command creates a new commit, you can safely get rid of your mistakes without rearranging the commit history for everyone else.

## Resolving merge conflicts

When working with branches, you might encounter merge conflicts. A **merge conflict** occurs when Git is unable to automatically combine changes from different branches. This usually happens when two changes affect the same part of a file.

### How merge conflicts happen? 

A conflict typically arises during a **merge** operation when two branches have modified the same lines of code or made changes to the same file. Git can't decide which version of the code should be kept, so it marks the file as conflicted.

### Example of a conflict

You and a teammate both modify the same line in a file in different branches.

When merging, Git will identify the conflicting changes and mark the file as conflicted.


### Steps to resolve a merge conflict

1. **Identify the conflicted files**: Git will notify you of the conflicted files when you try to merge branches. You can also use `git status` to see which files have conflicts.
2. **Open the conflicted file**: Git marks the conflict areas with special markers:
   - `<<<<<<< HEAD`: your current branch's changes.
   - `=======`: separates your changes from the other branch.
   - `>>>>>>> branch_name`: changes from the branch you're merging.

Example:

```
<<<<<<< HEAD
Your changes
=======
Changes from the other branch
>>>>>>> branch_name
```

3. **Resolve the conflict**: Manually edit the file to combine the changes or choose one version over the other. Remove the conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`) after resolving the issue. In VSCode, you can use the `Accept Current Change` or `Accept Incoming Change` options to resolve conflicts.
4. **Stage the resolved file**: After editing the file, stage it to mark the conflict as resolved.

```bash	
git add <file_name>
```

5. **Complete the merge**: If you were merging, commit the changes to finalize the merge.

```bash
git commit 
```

Tips for Conflict Resolution:

- Communicate with your team: If you're unsure about how to resolve a conflict, discuss it with the team to agree on the correct changes.
- Use a merge tool: Git provides tools like git mergetool to help visualize and resolve conflicts in an easier way. You can also use external merge tools like VSCode.
- Avoid large merges: Try to merge frequently to reduce the chance of complex conflicts. Keep branches small and focused.

## References

- [Formation Git: Ou comment bien collaborer à plusieurs sur son code](https://viarezo.fr/assets/files/formations/2022_Git_slides.pdf)
- [Git reverting to previous commit](https://www.freecodecamp.org/news/git-reverting-to-previous-commit-how-to-revert-to-last-commit/)

