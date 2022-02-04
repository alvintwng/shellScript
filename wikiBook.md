Bash Shell Scripting

### Some introductory examples
We can either type this directly at the Bash prompt, or else save this as a file (say, hello_world.sh) 
and run it by typing bash `hello_world.sh` or `./hello_world.sh` at the Bash prompt. 

``` console
[oracle@localhost 2022Shell]$ cd ~
[oracle@localhost ~]$ vim hello_world.sh
[oracle@localhost ~]$ echo 'Hello world!'
Hello world!
[oracle@localhost ~]$ bash hello_world.sh
Hello world! 
[oracle@localhost ~]$ ./hello_world.sh
bash: ./hello_world.sh: Permission denied
[oracle@localhost ~]$ ls -la hello_world.sh
-rw-r--r--. 1 oracle oinstall 21 Feb  3 00:15 hello_world.sh
[oracle@localhost ~]$ chmod +x hello_world.sh
[oracle@localhost ~]$ ls -la hello_world.sh
-rwxr-xr-x. 1 oracle oinstall 21 Feb  3 00:15 hello_world.sh
[oracle@localhost ~]$ ./hello_world.sh
Hello world! 
[oracle@localhost ~]$ 
```
Here we have used the `$` symbol to indicate the Bash prompt: after `$`, 
the rest of the line shows the command that we typed, and the following line shows the output of the command.


#### testConfig.sh
``` sh
if [[ -e config.txt ]] ; then
  echo 'The file "config.txt" already exists. Comparing with default . . .'
  diff -u config-default.txt config.txt > config-diff.txt
  echo 'A diff has been written to "config-diff.txt".'
else
  echo 'The file "config.txt" does not exist. Copying default . . .'
  cp config-default.txt config.txt
  echo '. . . done.'
fi
```
``` console
[oracle@localhost 2022Shell]$ ls config*.txt
config-default.txt  
[oracle@localhost 2022Shell]$ sh testConfig.sh
The file "config.txt" does not exist. Copying default . . .
. . . done.
[oracle@localhost 2022Shell]$ ls config*.txt
config-default.txt  config.txt 
[oracle@localhost 2022Shell]$ sh testConfig.sh
The file "config.txt" already exists. Comparing with default . . .
A diff has been written to "config-diff.txt".
[oracle@localhost 2022Shell]$ ls config*.txt
config-default.txt  config-diff.txt  config.txt
```

 --help, man
``` console
[oracle@localhost ~]$ man diff
[oracle@localhost ~]$ 
[oracle@localhost ~]$ diff --help
...
```

### Simple commands
* `cd ..` - navigate "up" one directory
* `rm foo.txt bar.txt baz.txt` - deletes the files
* `/foo/bar/baz bip.txt` -  runs the program
* `cd 'path/to/directory'` - absolute path
* `cd ../../` -  up 2 directories
* `cd -` or just `cd` - to default home directory

#### Quoting `' '`; `" "`
```sh
rm 'this file.txt'
```
``` sh
rm "this file.txt"
```
``` sh
rm this\ file.txt
```
``` diff
- Caution:
In Unix, GNU/Linux distributions and other Unix-like systems, 
file names can contain spaces, tabs, newlines, and even control characters.
```

#### Blackslash
``` console
[oracle@localhost scripts]$ touch \*.txt
[oracle@localhost scripts]$ vim \*.txt
[oracle@localhost scripts]$ ls *.txt
source.txt  ^test.txt  *.txt
```
#### Tilde expansion `~`

has as a lot of features, but the main one is this: in a word that consists solely of a tilde `~`, 
or in a word that begins with `~/` (tilde-slash), the tilde is replaced with the full path 
to the current user's home directory. For example, this command:
``` sh
echo ~/*.txt
```

#### Brace expansion `{ }`
```sh
ls file1.txt file2.txt file3.txt file4.txt file5.txt
```
```sh
ls file{1,2,3,4,5}.txt
```
```sh
ls file{1..5..1}.txt
```
```sh
ls file{1..5}.txt
```
#### Redirecting output `>`; `>>`

`>` - overwrite the destination file

`>>` - append the command's output 

If we wish for standard error to be combined with standard output,
```sh
cat input.txt &>> output.txt
```
```sh
cat input.txt >> output.txt 2>&1
```
 standard error to be appended to a different file from standard output
```sh
cat input.txt >> output.txt 2>> error.txt
```
#### A preview of pipelines
A pipeline is a series of commands separated by the pipe character `|`. 
``` sh
cat input.txt | grep foo | grep -v bar
```
the pipeline prints any lines of `input.txt` that _do_ contain foo and _do not_ contain bar.

### Variables
${*variable_name*}
```sh
location=world               # store "world" in the variable "location"
echo "Hello, ${location}!"   # print "Hello, world!"
```
```sh
cmd_to_run=echo                   # store "echo" in the variable "cmd_to_run"
"${cmd_to_run}" 'Hello, world!'   # print "Hello, world!"
```
It is generally a good idea to wrap variable expansions in double-quotes; for example, use `"$var"` rather than `$var`.

### positional parameters  are identified by numbers rather than by names

suppose we want to create a simple script called `mkfile.sh` that takes two arguments — a filename, and a line of text — and creates the specified file with the specified text.

mkfile.sh
```sh
#!/bin/bash
echo "$2" > "$1"
```
``` console
bash-3.2$ vim mkfile.sh
bash-3.2$ chmod +x mkfile.sh
bash-3.2$ ./mkfile.sh file-to-create.txt 'line to put in file'
bash-3.2$ cat file-to-create.txt
line to put in file
```

We can also refer to all of the arguments at once by using `$@`, which expands to *all* of the positional parameters, in order. When wrapped in double-quotes, as `"$@"`, each argument becomes a separate word. (Note: the alternative $* is perhaps more common.)
This is often useful in concert with the built-in command shift, which removes the first positional parameter, such that `$2` becomes `$1`, `$3` becomes `$2`, and so on. 

mkfile.sh
``` sh
#!/bin/bash
file="$1" 		# save the first argument as "$file"
shift 			# drop the first argument from "$@"
echo "$@" > "$file" 	# write the remaining arguments to "$file"
```
``` console
bash-3.2$ exit
exit
antw@Mac-mini scripts % vim mkfile.sh
antw@Mac-mini scripts % ./mkfile.sh file-to-create.txt line to put in file
antw@Mac-mini scripts % cat file-to-create.txt
line to put in file
```
and all of the arguments, except the filename, will be written to the file.

Note that positional parameters beyond `$9` require the curly braces; should you need to refer to the tenth argument, for example, you must write `${10}`.

### Exit status
When a process completes, it returns a small non-negative integer value, called its exit status or its return status, to the operating system.  By convention, it returns zero if it completed successfully, and a positive number if it failed with an error. 

Example: `exit 4` terminates the shell script, returning an exit status of four.

The exit status of a command is (briefly) available as `$?`. 

``` console
bash-3.2$ cat test.sh
#!/bin/bash
rm file,txt
touch file.txt
bash-3.2$ echo $?
0
bash-3.2$ ls file.txt
ls: file.txt: No such file or directory
bash-3.2$ echo $?
1
bash-3.2$ ./test.sh
bash: ./test.sh: Permission denied
bash-3.2$ echo $?
126
```
`rm file.txt && touch file.txt`
This is the same as before, except that it won't try to run touch unless rm has succeeded.

`! rm file.txt` is equivalent to `rm file.txt`, except that it will indicate success if `rm` indicates failure, and vice versa.

The exit status of a command is (briefly) available as `$?`. 

For example, the `grep` command (which searches for lines in a file that match a specified pattern) returns `0` if it finds a match, `1` if it finds no matches, and `2` if a genuine error occurs.

### Conditional expressions and if statements
``` sh
#!/bin/bash

if [[ -e source.txt ]] ; then
  cp source.txt destination.txt
fi
```
The above uses two built-in commands:
* The construction `[[ condition ]]` returns an *exit status* of zero (success) if `condition` is true, and 
a nonzero exit status (failure) if `condition` is false. In our case, `condition` is` -e source.txt`, which is true if and only if there exists a file named `source.txt`.
* The construction
  ```
  if command1 ; then
    command2
  fi
  ```
  < first runs `command1`; if that completes successfully (that is, if its exit status is zero), then it goes on to run `command2`.

the above is equivalent to this:
``` sh
#!/bin/bash

[[ -e source.txt ]] && cp source.txt destination.txt
```
#### `if` statements
``` sh
#!/bin/bash

if [[ -e source1.txt ]] ; then
  echo 'source1.txt exists; copying to destination.txt.'
  cp source1.txt destination.txt
elif [[ -e source2.txt ]] ; then
  echo 'source1.txt does not exist, but source2.txt does.'
  echo 'Copying source2.txt to destination.txt.'
  cp source2.txt destination.txt
else
  echo 'Neither source1.txt nor source2.txt exists; exiting.'
  exit 1 # terminate the script with a nonzero exit status (failure)
fi
```
Test expression
``` sh
# First build a function that simply returns the code given
returns() { return $*; }
# Then use read to prompt user to try it out.
read -p "Exit code:" exit
if (returns $exit)
  then echo "true, $?"
  else echo "false, $?"
fi
```
equivalent
``` sh
# Let's reuse the returns function.
returns() { return $*; }
read -p "Exit code:" exit

# if (        and                 ) else            fi
returns $exit && echo "true, $?" || echo "false, $?"

# The REAL equivalent, false is like `returns 1'
# Of course you can use the returns $exit instead of false.
# (returns $exit ||(echo "false, $?"; false)) && echo "true, $?"
```

---

https://en.wikibooks.org/wiki/Bash_Shell_Scripting
