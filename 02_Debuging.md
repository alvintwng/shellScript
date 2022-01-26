## Writing and debugging scripts

### Creating and running a script
#### `which`, `whereis`
for finding informaition about programs and files

to find the binary, source files or manual 
``` console
mysyste:[oracle@localhost 2022Shell]$ whereis --help]

Usage:
 whereis [options] file

Options:
 -b         search only for binaries
 -B <dirs>  define binaries lookup path
 -m         search only for manuals
 -M <dirs>  define man lookup path
 -s         search only for sources
 -S <dirs>  define sources lookup path
 -f         terminate <dirs> argument list
 -u         search for unusual entries
 -l         output effective lookup paths

For more details see whereis(1).
[oracle@localhost 2022Shell]$ whereis bash
bash: /usr/bin/bash /usr/share/man/man1/bash.1.gz
[oracle@localhost 2022Shell]$ which bash
/usr/bin/bash
[oracle@localhost 2022Shell]$ locate bash
/etc/bash_completion.d
...
```
#### script1.sh
```sh
#!/usr/bin/bash
# This script clears the terminal, displays a greeeting and gives information
# about current connected users. The two example variables are set and displayed.

clear

echo "The script starts now."   # clear terminal window

echo "Hi, $USER!"               # dollar sign is used to get content of variable
echo

echo "I will now fetch you a list of connected users:"
echo
w                               # show who is .ogged on end
echo

echo "I'm setting two variables now."
COLOUR="black"
VALUE="9"
echo "This is a string: $COLOUR"
echo "And this is a number: $VALUE"
echo

echo "I'm giving you back your prompt now."
echo
```

#### `export PATH="$PATH:~/scripts"`
``` console
[oracle@localhost scripts]$ chmod u+x script1.sh
[oracle@localhost scripts]$ ls -l script1.sh
-rwxr--r--. 1 oracle oinstall 335 Jan 26 00:14 script1.sh

[oracle@localhost scripts]$ pwd
/home/oracle/2022Shell/scripts

[oracle@localhost 2022Shell]$ export PATH="$PATH:/home/oracle/2022Shell/scripts"
[oracle@localhost 2022Shell]$ script1.sh

The script starts now.
Hi, oracle!

I will now fetch you a list of connected users:

 00:05:59 up  1:01,  2 users,  load average: 0.27, 0.16, 0.13
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
oracle   :0       :0               23:05   ?xdm?   3:55   0.15s /usr/libexec/gnome-ses
oracle   pts/0    :0               23:05    7.00s  0.21s  0.00s /usr/bin/bash /home/or

I'm setting two variables now.
This is a string: black
And this is a number: 9

I'm giving you back your prompt now.

[oracle@localhost 2022Shell]$ echo $COLOUR

[oracle@localhost 2022Shell]$ echo $VALUE

[oracle@localhost 2022Shell]$ 
```

#### source script1.sh
any changes made, will be visible when the script finished execution.
``` console
[oracle@localhost 2022Shell]$ source script1.sh
...

[oracle@localhost 2022Shell]$ echo $VALUE
9
[oracle@localhost 2022Shell]$ 
```

### Debugging Bash script
#### `bash -x script1.sh`
Debugging on the entire script
``` console
antw@Mac-mini 2022shell % bash -x script1.sh
+ clear

+ echo 'The script starts now.'
The script starts now.
+ echo 'Hi, antw!'
Hi, antw!
+ echo

+ echo 'I will now fetch you a list of connected users:'
I will now fetch you a list of connected users:
+ echo

+ w
14:22  up  2:29, 2 users, load averages: 1.31 1.18 1.19
USER     TTY      FROM              LOGIN@  IDLE WHAT
antw     console  -                11:54    2:28 -
antw     s000     -                11:54       - w
+ echo

+ echo 'I'\''m setting two variables now.'
I'm setting two variables now.
+ COLOUR=black
+ VALUE=9
+ echo 'This is a string: black'
This is a string: black
+ echo 'And this is a number: 9'
And this is a number: 9
+ echo

+ echo 'I'\''m giving you back your prompt now.'
I'm giving you back your prompt now.
+ echo

antw@Mac-mini 2022shell % 
```
#### `set -x`
Debugging on part(s) of the script
```sh
set -x      # activate debugging from here
w
set +x      # stop debugging from here 
```
``` console
The script starts now.
Hi, antw!

I will now fetch you a list of connected users:

+ w
14:28  up  2:34, 2 users, load averages: 1.13 1.13 1.16
USER     TTY      FROM              LOGIN@  IDLE WHAT
antw     console  -                11:54    2:33 -
antw     s000     -                11:54       - w
+ set +x

I'm setting two variables now.
This is a string: black
And this is a number: 9

I'm giving you back your prompt now.

antw@Mac-mini scripts % 
```
#### Overview of set debugging options
| Short notation | Long notation | Result |
|---|---|---|
| set -f | set -o noglob | Disable file name generating using metacharacters (globbing). |
| set -v | set -o verbose | Prints shell input lines as they are read. |
| set -x | set -o xtrace | Print command traces before executing command. |

demostrate
``` console
[oracle@localhost scripts]$ set -v
__vte_prompt_command
[oracle@localhost scripts]$ ls
ls
commented-scripts.sh  script1.sh
__vte_prompt_command
[oracle@localhost scripts]$ set +v
set +v
[oracle@localhost scripts]$ ls
commented-scripts.sh  script1.sh
[oracle@localhost scripts]$ ls *
commented-scripts.sh  script1.sh
[oracle@localhost scripts]$ set -f
[oracle@localhost scripts]$ ls *
ls: cannot access *: No such file or directory
[oracle@localhost scripts]$ touch *
[oracle@localhost scripts]$ ls
*  commented-scripts.sh  script1.sh
[oracle@localhost scripts]$ rm *
[oracle@localhost scripts]$ ls
commented-scripts.sh  script1.sh
[oracle@localhost scripts]$ 
```

can be specified in the script itself. Options can be combined.
``` sh
#!/bin/bash -xv
```

can add `echo` statements
```sh
echo "Variable VARNAME is now set ti $VARNAME."
```


---
Reference: Bash Guide for Beginners (PDF), Machtelt Garrels, 20081227
