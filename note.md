# ny note


alternate for schell script, **`alias`**
```sh
alias lsal='clear; ls -al'
```
rather
```sh
#!/bin/sh
clear
ls -al
```



A list of fundamental UN*X system commands follows:
```
  ls         # Give a simple listing of files.
  ll         # Give a listing of files with file details.
  cp         # Copy files.
  mv         # Move or rename files.
  rm         # Remove files.  
  rm -r      # Remove entire directory subtree.
  cd         # Change directories.
  pwd        # Print working directory.
  cat        # Lists a file or files sequentially.
  more       # Displays a file a screenfull at a time.
  pg         # Variant on "more".
  mkdir      # Make a directory.
  rmdir      # Remove a directory.
```

`*` The shell also allows files to be defined in terms of "wildcard characters" that define a range of files. 

The "`?`" wildcard character substitutes for any single character.

#### `sort` < unsortText.txt
``` console
[oracle@localhost 2022Shell]$ cat unsortText.txt
	sort
   	PORKY
	ELMER
	FOGHORN
	DAFFY
	WILE
	BUGS
	<CTL-D>
[oracle@localhost 2022Shell]$ sort < unsortText.txt
	BUGS
	<CTL-D>
	DAFFY
	ELMER
	FOGHORN
   	PORKY
	sort
	WILE
[oracle@localhost 2022Shell]$ 
```
#### `>`, `>>`, `| tee`
``` console
[oracle@localhost 2022Shell]$ sort < unsortText.txt > sortedText.txt
[oracle@localhost 2022Shell]$ ls
mysystem.sh  scripts  sortedText.txt  unsortText.txt
[oracle@localhost 2022Shell]$ sort < unsortText.txt >> sortedText2.txt
[oracle@localhost 2022Shell]$ l
bash: l: command not found...
[oracle@localhost 2022Shell]$ ls
mysystem.sh  scripts  sortedText2.txt  sortedText.txt  unsortText.txt
[oracle@localhost 2022Shell]$ sort < unsortText.txt | tee sortedText3.txt
	BUGS
	<CTL-D>
	DAFFY
	ELMER
	FOGHORN
   	PORKY
	sort
	WILE
[oracle@localhost 2022Shell]$ 
```
By the way, "sort" has some handy additional options:
```
   sort -u    # Eliminate redundant lines in output.
   sort -r    # Sort in reverse order.
   sort -n    # Sort numbers. 
   sort +1    # Skip first field in sorting.
```
>> myNote: check with `man sort` for more   

#### chaining them with a `;`
``` console
[oracle@localhost 2022Shell]$ rm sort*.*; ls
mysystem.sh  scripts  unsortText.txt
```
A time-consuming program can also be run in a "parallel" fashion by following it with a `&`:

   sort < bigfile.txt > output.txt &
#### permission, `chmod`
Each file under `UN*X` has a set of "permission" bits, listed by an `ll` as:
```
   rwxrwxrwx
```
The "r" gives "read" permission, the "w" gives "write" permission, and the "x" gives "execute" permission. 

You can use "chmod" to set these permissions by specifying them as an octal code. For example:
```
   chmod 644 myfile.txt
```
You can use the same octal scheme to set execute permission, or just use the "+x" option:
```
   chmod +x mypgm
```
## shell variables

``` console
[oracle@localhost 2022Shell]$ shvar="This is a test."
[oracle@localhost 2022Shell]$ echo $shvar
This is a test.
[oracle@localhost 2022Shell]$ allfiles=*
[oracle@localhost 2022Shell]$ echo $allfiles
mysystem.sh scripts unsortText.txt
[oracle@localhost 2022Shell]$ 
```
If you want to call other shell programs from a shell program and have them use the same shell variables as the calling program, 
you have to "export" them as follows:

#### shpgm
```sh
   shvar="This is a test!"
   export shvar
   echo "Calling program two."
   shpgm2
   echo "Done!"
```   
If "shpgm2" simply contains:
#### shpgm2
```sh
   echo $shvar
```
-- then it will echo "This is a test!".

``` console
[oracle@localhost scripts]$ shpgm
bash: /home/oracle/2022Shell/scripts/shpgm: Permission denied
[oracle@localhost scripts]$ chmod +x shpgm
[oracle@localhost scripts]$ chmod +x shpgm2
[oracle@localhost scripts]$ ls
commented-scripts.sh  script1  script1.sh  shpgm2  shpgm
[oracle@localhost scripts]$ shpgm
Calling program two.
This is a test!
Done!
```

## Command Substitution

`fgrep` - which searches a file for a string
``` console
[oracle@localhost scripts]$ fgrep UN*X source.txt
```
enclose the string in single quotes, `'`
``` console
[oracle@localhost scripts]$ echo "$shvar"

[oracle@localhost scripts]$ echo '$shvar'
$shvar
```
back-quote, `\`
``` console
antw@Mac-mini scripts % expr 2 + 4
6
antw@Mac-mini scripts % expr 3 * 7
expr: syntax error
antw@Mac-mini scripts % expr 3 \* 7
21
```
don't work for `expr` ?
``` console
antw@Mac-mini scripts % expr 12 / 3
4
antw@Mac-mini scripts % shcmd="expr 12 / 3"
antw@Mac-mini scripts % echo $shcmd
expr 12 / 3
antw@Mac-mini scripts % echo "$shcmd"
expr 12 / 3
antw@Mac-mini scripts % echo '$shcmd' 
$shcmd
antw@Mac-mini scripts % $shcmd       
zsh: no such file or directory: expr 12 / 3

antw@Mac-mini scripts % sh
sh-3.2$ expr 12 / 3
4
sh-3.2$ shcmd="expr 12 / 3"
sh-3.2$ echo $shcmd
expr 12 / 3
sh-3.2$ $shcmd
4
```

from wikibooks
``` sh
location=world               # store "world" in the variable "location"
echo "Hello, ${location}\!"   # print "Hello, world!", noted back-quote for `!`. not work for sh
```
``` sh
cmd_to_run=echo                   # store "echo" in the variable "cmd_to_run"
"${cmd_to_run}" 'Hello, world!'   # print "Hello, world!"
```
``` sh
foo='a  b*'    # store "a  b*" in the variable "foo"
echo $foo
```


##  COMMAND-LINE ARGUMENTS
* In general, shell programs operate in a "batch" mode, that is, without interaction from the user, and so most of their parameters are obtained on the command line.

Each argument on the command line can be seen inside the shell program as a shell variable of the form "$1", "$2", "$3", and so on, with "$1" corresponding to the first argument, "$2" the second, "$3" the third, and so on.

There is also a "special" argument variable, "$0", that gives the name of the shell program itself. Other special variables include "$#", which gives the number of arguments supplied, and "$*", which gives a string with all the arguments supplied.

Since the argument variables are in the range "$1" to "$9", so what happens if you have more than 9 arguments? No problem, you can use the "shift" command to move the arguments down through the argument list. That is, when you execute "shift" then the second argument becomes "$1", the third argument becomes "$2", and so on, and if you do a "shift" again the third argument becomes "$1"; and so on. You can also add a count to cause a multiple shift:

   shift 3
-- shifts the arguments three times, so that the fourth argument ends up in "$1".

## Some introductory examples

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


---
An Introduction To Shell Programming - http://www.faqs.org/docs/air/tsshell.html

https://en.wikibooks.org/wiki/Bash_Shell_Scripting

