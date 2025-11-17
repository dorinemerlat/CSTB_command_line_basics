# UNIX and bash training

## 1. Basic concepts

Everything is a file in UNIX: directories, files, devices, sockets, etc.

The shell is a program that interprets commands and acts as an intermediary between the user and the operating system. Like any other scripting language, the shell has variables, control structures, and functions.

An executable file is a file that can be run as a program; it can be a binary file or a script (text) file.

When you run a command in the shell, the shell first looks for a shell alias, then a shell function, then a built-in command, and finally an executable file in the PATH.

GNU/Linux is the union of the GNU operating system and the Linux kernel. The kernel is the core of the system, surrounded by the shell and the GNU operating system provides the tools and libraries.

## Preambule

### What is a path ?

A path is a unique location to a file or a folder in a file system of an OS. A path to a file is a combination of / and alpha-numeric characters. For example, the path to a file is /home/username/file.txt, the path to a folder is /home/username/foldername
A path can be absolute, meaning it start from the root directory (/); or relative, meaning it starts from the current directory.

A dot (.) represents the current directory, and two dots (..) represent the parent directory.

It is good practice to avoid spaces or special characters in file and directory names.

### Run a command

To run a command, type the command and press Enter. The command will be executed, and the output will be displayed in the terminal.

To kill a running command, press `Ctrl + C`. To exit the terminal, type `exit` and press Enter.

### Command syntax

A command is made of a command name and options. Following the GNU convention, options are usually preceded by a dash (-) or two dashes (--), in a short or long form. Options can be followed by arguments, may be separated by a space or an equal sign.
Multiple short options can be combined after a single dash.

Example:
```bash
ls -a
ls --all
ls -lah
head -n 10 file.txt
head --lines=10 file.txt
head -n10 file.txt
```

### Documentation

To learn more about a command, use the `man` command followed by the command name. If not available, you might use the `--help` or `-h` option.
It is also common to find the `-v`, `--version` or `-V` option to display the version of the program.

```bash
man ls
ls --help
ls -v
```

## 2. Navigate and list files

`ls` - List files in current directory

```bash
ls         # List files in current directory
ls -l      # List files in long format
ls -a      # List all files, including hidden files
ls -lh     # List files in long format with human-readable file sizes
ls -lS     # List files in long format sorted by size
ls -ltr    # List files in long format sorted by modification time in reverse order
```

`pwd` - Print working directory

`cd` - Change directory

```bash
cd /path/to/directory
cd ..                   # Go up one directory
cd                      # Go to home directory
cd -                    # Go to previous directory
```

`tree` - List files in a tree-like format

```bash
tree
```

## 3. File operations

`cp` - Copy files

```bash
cp file.txt file_copy.txt
cp -r directory directory_copy
```

`mv` - Move files

```bash
mv file.txt /path/to/directory
mv file.txt file_new.txt
```

`mkdir` - Create directories

```bash
mkdir directory
mkdir -p directory/subdirectory
```

`rm` - Remove files (think twice before using this command)

```bash
rm file.txt
rm -r directory
```

## 4. Manipulate text files

`cat` - Concatenate files and print on the standard output

```bash
cat file.txt
```

`head` - Output the first part of files

```bash
head file.txt
head -n 10 file.txt
```

`tail` - Output the last part of files

```bash
tail file.txt
tail -n 10 file.txt
```

`less` - View files one page at a time, type `q` to quit

```bash
less file.txt
```

`cut` - Select portions of each line of a file, similar to split in Python

```bash
cut -d ' ' -f1 file.txt
```

`sort` - Sort lines of text files

```bash
sort file.txt
sort -r file.txt
sort -n file.txt
```

`uniq` - Report or omit repeated lines

```bash
uniq file.txt
uniq -c file.txt
```

`wc` - Count lines, words, and characters in files

```bash
wc file.txt
wc -l file.txt
wc -w file.txt
wc -c file.txt
```

`grep` - Search for patterns in files

```bash
grep pattern file.txt
grep -i pattern file.txt
grep -v pattern file.txt
```

`sed` - Stream editor for filtering and transforming text

```bash
sed 's/pattern/replacement/g' file.txt
sed '/pattern/d' file.txt
```

## 5. Redirection and pipes

`>` - Redirect output to a file

```bash
ls > files.txt
```

`>>` - Append output to a file

```bash
ls >> files.txt
```

Commands can be piped together using the pipe operator `|`

```bash
ls | grep pattern
```


## Exercise

1. Create a directory called `my_directory` and navigate to it.
2. Copy the file `/home/kress/Q13613.fasta` to `seq.fasta`
3. What is the size of the file ?
4. What type of file is ?
5. How many lines does it have ?
6. Display the first 10 lines of the file.
7. Extract the sequences' descriptions from the file.
8. Filter out the descriptions from SwissProt.
9. Extract the sequences' taxids.
10. Sort the taxids in ascending order.
11. Count occurrences of each taxid.
12. Display the taxid with the highest number of occurrences.
13. Remove duplicated taxids.
14. Remove the field PE from the file.
15. Only keep the sequence names.
16. Extract the sequences' accession numbers.

### Solution

```bash
# 1
mkdir my_directory
cd my_directory
# 2
cp /home/kress/Q13613.fasta seq.fasta
# 3
ls -lh seq.fasta
# 4
file seq.fasta
# 5
wc -l seq.fasta
# 6
head seq.fasta
# 7
grep '>' seq.fasta
# 8
grep -v '^>sp' seq.fasta
# 9
grep -o 'OX=[0-9]*' seq.fasta | cut -d= -f2
# 10
grep -o 'OX=[0-9]*' seq.fasta | cut -d= -f2 | sort -n
# 11
grep -o 'OX=[0-9]*' seq.fasta | cut -d= -f2 | sort | uniq -c
# 12
# sort must be numeric
grep -o 'OX=[0-9]*' seq.fasta | cut -d= -f2 |sort|uniq -c|sort -nr|head -1
# 13
# use sort -u to remove non-adjacent duplicates
grep -o 'OX=[0-9]*' seq.fasta | cut -d= -f2 | sort -u
# 14
sed 's/ PE=[0-9]*//' seq.fasta
# 15
grep -o '>[^ ]*' seq.fasta | cut -c2-
# 16
grep -o 'AC=[A-Z0-9]*' seq.fasta | cut -d= -f2
cut -d ' ' -f1 seq.fasta | cut -c2-
```

## Useful additional tools and job control

### Process and job management (useful on servers)

```bash
# run a command in background
long_running_command &

# bring job to foreground (job number from `jobs`)
fg %1

# run something that survives logout
nohup my_long_task.sh &
disown
```

### awk and xargs — powerful text-processing helpers

```bash
# print 3rd column
awk '{print $3}' file.tsv

# sum numbers in column 2
awk '{sum += $2} END {print sum}' data.txt

# use xargs to parallelize simple commands
find . -name "*.gz" | xargs -n1 -P4 gunzip
```

### Compression and archives

- A gzip file (.gz) is just a single file compressed to reduce its size.

- A tar.gz file is a tar archive (a collection of multiple files and folders kept together) that is then compressed with gzip.
  

```bash
# create a gzipped tar archive
tar -czvf results.tar.gz /path/to/results

# extract
tar -xzvf results.tar.gz

# gzip a single file
gzip file.txt
# gunzip to restore
gunzip file.txt.gz
```


### Copying and synchronizing between machines (scp, rsync):

```bash
# copy file to remote host
scp localfile.txt user@remote:/path/

# sync a directory (efficient: only copies diffs)
rsync -avh --progress /local/dir/ user@remote:/remote/dir/
# -a : archive mode — copies directories recursively and preserves permissions, timestamps, links, etc.
# -v : verbose — shows detailed output during the transfer.
# -h : human-readable — displays file sizes in a readable format (KB, MB, GB).
# --progress : shows the progress of each file being transferred.
```
