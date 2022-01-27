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

http://www.faqs.org/docs/air/tsshell.html

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
```sh
   shvar="This is a test!"
   export shvar
   echo "Calling program two."
   shpgm2
   echo "Done!"
```   
If "shpgm2" simply contains:
```
   echo $shvar
```
-- then it will echo "This is a test!".

results ??
``` console
[oracle@localhost 2022Shell]$ sh var.sh
Calling program two.
var.sh: line 5: shpgm2: command not found
Done!
[oracle@localhost 2022Shell]$ 

```
