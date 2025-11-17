# Good Practices: Writing Scripts and Managing Files

The use of Bash scripts is essential in bioinformatics to automate analyses and handle large volumes of data. A well-designed script improves code readability, prevents errors, and optimizes task execution. 

## File Permissions and Management

###  What are rights and permissions?

In Linux, file permissions are rules that determine who can access, modify, or execute files and directories. They are foundational to Linux security, ensuring that only authorized users or processes can interact with your data. Here’s a breakdown:

- **Read** (`r`): View the file’s contents or list a directory’s files.
- **Write** (`w`): Modify a file or add/delete files in a directory.
- **Execute** (`x`): Run a file as a program/script or enter a directory.

Permissions are assigned to three categories of users:

- **User (Owner)** (`u`): The person who created the file.
- **Group** (`g`): Users belonging to a shared group (e.g., “developers” or “admins”).
- **Others** (`o`): Everyone else on the system.

There is also `a` for all users, which combines `ugo`.	

### How to check permissions of files or directories ?

```bash
ls -l
```

Example:

```bash
ls -l NarX.txt
```

Output

```
-rw-r--r-- 1 user group 46 Apr 14 16:37 NarX.txt
```

The above command represents these following information:

- Column 1: 
    - The first character indicate the **type** of element, `-` means it's a file, `d` means it's a directory.
    - The next nine characters (`rw-r–r–`) show the **security**. The first three characters are for the owner, the next three are for the group, and the last three are for others. The characters are in the order of read, write, and execute. If the permission is granted, it is represented by the letter, if it is not granted, it is represented by a `-`.
- Column 2: **number of links** to the file.
- Column 3: **owner** of the file.
- Column 4: **group owner** of the file. (which has special access to these files)
- Column 5: **size** of the file in bytes.
- Column 6-7: **date and time** the file was last modified.
- Column 8: **name** of the file.
- Column 9: **symbolic link** (if the file is a symbolic link).


### How to change permissions?

The command you use to change the security permissions on files is called `chmod`, , which stands for “change mode” because the nine security characters are collectively called the security “mode” of the file. You can modify permissions using symbolic notation or octal notation. We will focus here on symbolic notation.

Symbolic notation allows you to add, remove, or set permissions for specific users.

Operators used to modify permissions:

- `+`: add permission.
- `-`: remove permission.
- `=`: set permission.

Indicate the category of users (`u`, `g`, `o`, `a`), the operator to use and the permission to give to the category of users (`r`, `w`, `x`).

Example:

```bash
chmod u+x file.sh
```

Give `execute` permission to the owner of the file `file.sh`.

You can also change multiple permissions at once. For example, if you want to take all permissions away from everyone, you would type. 

```bash	
chmod ugo-rwx xyz.txt
```

The code above revokes all the read(r), write(w), and execute(x) permission from all user(u), group(g), and others(o) for the file xyz.txt.

Example:

```bash
chmod u+x file.sh
```

**Exercise**: Create a file and change its permissions so that everyone can execute it.

### File and Folder Manipulation

#### Commands to manage files and folders

- `touch`: Create an empty file.
- `mkdir`: Create a directory.
- `cp`: Copy files (`cp -r` for directories).
- `mv`: Move files.
- `rm`: Remove files (`rm -r` for directories).
- `rmdir`: Remove directories.

#### `find` command

The `find` command is used to search for files and directories in a directory hierarchy based on various criteria. It can be combined with different options to customize the search.

Common options:
- Search by name: `find /path -name "filename.txt"`. Example: `find /path -name "*.txt"` (all `.txt` files).
- Search by type: `find /path -type f` (file) or `find /path -type d` (directory).
- Search by size: `find /path -size +10M` (greater than 10MB) or `find /path -size -10M` (less than 10MB).
- Search by modification time: `find /path -mtime -1` (modified in the last 24 hours) or `find /path -mtime +1` (modified more than 24 hours ago).
- Search by user: `find /path -user username`.
- Execute commands on found files: `find /path -exec command {} \;`. By example: `find /path -name "*.txt" -exec cp {} /destination \;`.
- Limit search depth: `find /path -maxdepth 1` (search only in the current directory).

## Bash scripts

### What is a Bash script?

A Bash script is a sequence of Unix/Linux commands grouped into a file and executed sequentially. The goal is to automate repetitive tasks and improve work efficiency.

Example of minimal script :

```bash
#!/bin/bash
# This is a comment

echo "Hello World!"
```

Line by line:

- `#!/bin/bash`: Indicates that the script should be interpreted by Bash.
- `#`: Everything following on the line is a comment.
- `echo`: Displays text on the screen.

**Exercise**: Create a script hello.sh that displays "Hello World!" and execute it.

### Execution of bash scripts

When executing a script, there are different ways to do it, each having consequences on the shell environment.

#### Running with `bash script.sh`

When you run a script using `bash script.sh`, the script executes in a **new shell**. This means that any changes made within the script, such as setting variables or changing directories (`cd`),** will not persist** in the current shell once the script finishes. The main shell remains unchanged after the script completes.

Example:

```bash
# script.sh
export MY_VAR="value"
cd /path/to/dir
```

If you run `bash script.sh`, the `MY_VAR` variable will not be available in your current shell, and the directory will not change.

#### Running with `./script.sh` or `source script.sh`

When you use `. script.sh` (or `source script.sh`), the script runs in the **current shell**. This means that changes like setting variables or changing directories **will persist** in the current shell after the script finishes.

Example: If you run `. script.sh` or `source script.sh`, the `MY_VAR` variable will be available in the current shell, and the directory will be changed.

### Variables and Expansions

A Bash variable allows storing values and reusing them.

Examples:

```bash
name="Gaspard"
echo $name
```

Special variables include:

- `$HOME`: Home directory.
- `$PATH`: Paths of executables. (paths are separated by `:`)
- `$PWD`: Current directory. #LOG: Differences entre pwd et $PWD

**Exercise**: Create a script that displays your username and your current directory.

**Expansion** in Bash refers to the process where certain constructs in a command are **evaluated and replaced** by their values or results before the command is executed. This process happens automatically when Bash interprets the command line. There is different type of expansion

#### Variable Expansion

Replaces a variable with its value.

```bash
name="Gaspard"
echo "Hello, $name!"
```

Here, `$name` is expanded to "Gaspard".

#### Command Expansion

Replaces a command inside backticks or `$()` with its output.

```bash
date=$(date)
echo "Current date: $date"
```

Here, `$(date)` is expanded to the output of the date command.

#### Path Expansion

Expands file paths with wildcard characters like `*` (wildcard for a several character), `?` (wildcard for a single character), and `~` (home directory of the current user).

```bash	
echo ~/Documents/*   # Expands to all files in the Documents directory
```

#### Brace Expansion

Generates multiple strings by expanding a pattern.

```bash
echo file{1,2,3}.txt
# Output: file1.txt file2.txt file3.txt
```

#### Arithmetic Expansion

```bash
echo $((5 + 3))
# Output: 8
```

### Arguments and Options

Scripts can receive command-line arguments.

Example:

```bash
#!/bin/bash
echo "Hello, $1!"
``` 

**Exercice :** Modify your script to take an argument and display "Hello, [Name]".

##  Error Handling and Script Robustness

### Error Codes and Handling

Each command returns a code ($?) indicating success (0) or failure (≠0).

Example:

```bash
ls nonexistent_file.txt
echo $?  # Will display a nonzero error code
```

You can add a check to verify if a file exists before attempting to open it

```bash
#!/bin/bash

# Define the file name
file="nonexistent_file.txt"

# Check if the file exists
if [ -e "$file" ]; then
  echo "The file exists. Opening the file..."
  # Add code to open the file here (e.g., cat "$file")
else
  echo "The file does not exist!"
  # Handle the error (e.g., exit or log the error)
fi
```

Explanation:

- `-e "$file"` checks if the file exists (it works for regular files, directories, symlinks, etc.).
- If the file exists, it proceeds to open it (you can replace echo with a command to open the file, like `cat "$file"`).
- If the file does not exist, it prints a message saying so.

This approach ensures that your script does not attempt to open a nonexistent file, preventing errors.

### Using `set -euo pipefail`

This setting strengthens script robustness:

```bash
set -euo pipefail
```

#### `set -e`

Immediately exit if any command has a non-zero exit status.

#### `set -u`

Reference to any variable you haven't previously defined is an error, and causes the program to immediately exit.

Example: 

```bash
#!/bin/bash
firstName="Aaron"
fullName="$firstname Maxwell"
echo "$fullName"
```

Without `set -u`, this will be a silent error and the script will display " Maxwell". With `set -u`, it will display an error message.

#### `set -o pipefail`

Prevents errors in a pipeline from being masked. If any command in a pipeline fails, that return code will be used as the return code of the whole pipeline. 

Example:

```bash
$ grep some-string /non/existent/file | sort
```

Without `set -o pipefail`, the return code `grep: /non/existent/file: No such file or directory` and the return code will be 0. With `set -o pipefail`, the return code will be that of `grep`.

#### `set -x`: useful for debugging

When debugging a script, it can be useful to see the commands as they are executed. 

#### Setting IFS

The IFS variable - which stands for Internal Field Separator - controls what Bash calls word splitting. When set to a string, each character in the string is considered by Bash to separate words. This governs how bash will iterate through a sequence. 

##### Example 1

```bash
#!/bin/bash
items="a b c"
for x in $items; do
    echo "$x"
done
```

This will print out:

```
a
b
c
```

By default, IFS is set to `$' '`. The previous example is equivalent to:

```bash
#!/bin/bash
items="a b c"
IFS=$' '
for x in $items; do
    echo "$x"
done
```

The `$'...'` syntax creates a string, with backslash-escaped characters replaced with special characters - like "\t" for tab and "\n" for newline.

##### Example 2

```bash
items="a b c"
for y in $items; do
    echo "$y"
done
```

This will print out:

```
a b c
```

Here, "words" are separated by a newline, which means bash considers the whole value of "items" as a single word. If IFS is more than one character, splitting will be done on any of those characters

##### Example 3

In Bash, you can use **list** (or **array**). It is a data structure used to store multiple values. Arrays allow you to group related data together and access each value using an index. In Bash, arrays are zero-indexed, meaning the first element has an index of 0. 

```bash
names=("Monkey D. Luffy" "Roronoa Zoro" "Tony Tony Chopper")
echo "${names[@]}"
```

Explanation:

- **Array initialization**: `names=()` creates an array named names.
- **Accessing elements**: You can access array elements using their index, like `${names[0]}` for the first element. 

```bash
#!/bin/bash
names=(
"Monkey D. Luffy"
"Roronoa Zoro"
"Tony Tony Chopper"
)

echo "With default IFS value..."
for name in ${names[@]}; do
echo "$name"
done

echo ""
echo "With strict-mode IFS value..."
IFS=$'\n\t'
for name in ${names[@]}; do
echo "$name"
done
```

Output:

```
With default IFS value...
Monkey
D.
Luffy
Roronoa
Zoro
Tony
Tony
Chopper

With strict-mode IFS value...
Monkey D. Luffy
Roronoa Zoro
Tony Tony Chopper
```

`${names[@]}` is used to refer to all elements of an array. It expands to each element of the array as a separate value.

**Important Notes:**

- **Without quotes**: If you use `${names[@]}` without quotes, the array elements will be treated as individual words (splitting at spaces).
- **With quotes**: When using quotes like `${names[@]}`, each array element is treated as a single string, preserving spaces inside the elements.

##### Example 4

Consider a script that takes filenames as command line arguments:

```bash
for arg in $@; do
    echo "doing something with file: $arg"
done
```

If you invoke this as myscript.sh notes todo-list 'My Resume.doc', then with the default IFS value, the third argument will be mis-parsed as two separate files - named "My" and "Resume.doc". When actually it's a file that has a space in it, named "My Resume.doc".

Setting IFS to `$'\n\t'` means that word splitting will happen only on newlines and tab characters. This very often produces useful splitting behavior.


## Optimization and Best Practices for Reproducible Scripts

### Shebang (`#!`)

The shebang (`#!`) is the first line in a script that specifies the interpreter to be used to run the script. It tells the operating system which program should be used to interpret the script's contents.

Example:

```bash
#!/bin/python3
```

- `#!` is the shebang.
- `/bin/bash` is the path to the Bash interpreter.

It makes the script **portable** by specifying the exact interpreter to use, so the script can run correctly regardless of the user's environment or shell settings.

### Organization and Documentation

A script should be well-documented:

```bash
#!/bin/bash
# This script displays a welcome message.
echo "Hello, $1!"
```

You can add an help function to display the script usage:

```bash
#!/bin/bash
# This script displays a welcome message.
# Usage: ./script.sh [name]
function usage {
    echo "Usage: $0 [name]"
}

if [ $# -eq 0 ]; then
    usage
    exit 1
fi

echo "Hello, $1!"
```

This condition checks if the number of arguments (`$#`) passed to the script is **0**.

### Modularization

Functions help structure a script:

```bash
hello() {
    echo "Hello, $1!"
}
hello Gaspard
```

### Using virtual environments

See next lesson.

## Debugging, options parsing and linters (optional)

Small additions to make scripts robust and maintainable:

- Use `getopts` to parse options in bash scripts instead of manual shifts. Example:

```bash
while getopts ":hf:o:" opt; do
    case $opt in
        h) echo "Usage: $0 -f file -o out"; exit 0 ;;
        f) file="$OPTARG" ;;
        o) out="$OPTARG" ;;
        \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
    esac
done
```

- Use `shellcheck` (installable via package manager) to get automated suggestions for common shell pitfalls.


## Containers (note)

For reproducible environments you may use containers. On personal machines Docker is common; on HPC clusters use Apptainer (formerly Singularity).

- Docker: `docker pull image:tag` and `docker run --rm -it image:tag bash` (not available in all nodes of LBGI server).
- Apptainer/Singularity: you can directly pull from Docker Hub (https://hub.docker.com/) without a running Docker daemon: `apptainer pull docker://nanozoo/cdhit:4.8.1--c697693` which creates a `.sif` file you can run with `apptainer exec ubuntu_20.04.sif bash`.

See the file `05_containers_and_vscode.md` in this folder for concrete commands and examples (Docker Hub, Apptainer/Singularity usage and recommendations).

## References

- [bash_script_mode.md](https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425)
- [How to set file permissions in Linux](https://www.geeksforgeeks.org/set-file-permissions-linux/)