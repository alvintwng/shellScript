

#### `cat -n`, `stat`, `wc`, `file`
``` console
[oracle@localhost 2022Shell]$ vi hello.sh
[oracle@localhost 2022Shell]$ chmod +x hello.sh
[oracle@localhost 2022Shell]$ ./hello.sh
Hello World!
[oracle@localhost 2022Shell]$ cat -n hello.sh
     1	#!/bin/bash
     2	
     3	echo "Hello World!"
[oracle@localhost 2022Shell]$ stat hello.sh
  File: ‘hello.sh’
  Size: 33        	Blocks: 8          IO Block: 4096   regular file
Device: 811h/2065d	Inode: 48141971    Links: 1
Access: (0755/-rwxr-xr-x)  Uid: ( 1000/  oracle)   Gid: (54321/oinstall)
Context: unconfined_u:object_r:unlabeled_t:s0
Access: 2022-02-11 22:49:46.315958141 -0500
Modify: 2022-02-11 22:49:10.107118620 -0500
Change: 2022-02-11 22:49:38.459794252 -0500
 Birth: -
[oracle@localhost 2022Shell]$ wc hello.sh
 3  4 33 hello.sh
[oracle@localhost 2022Shell]$ file hello.sh
hello.sh: Bourne-Again shell script, ASCII text executable
```
#### update yyyy-mm-dd
``` console
[oracle@localhost 2022Shell]$ touch -t 12011200.00 hello.sh
[oracle@localhost 2022Shell]$ stat hello.sh
  File: ‘hello.sh’
  Size: 33        	Blocks: 8          IO Block: 4096   regular file
Device: 811h/2065d	Inode: 48141971    Links: 1
Access: (0755/-rwxr-xr-x)  Uid: ( 1000/  oracle)   Gid: (54321/oinstall)
Context: unconfined_u:object_r:unlabeled_t:s0
Access: 2022-12-01 12:00:00.000000000 -0500
Modify: 2022-12-01 12:00:00.000000000 -0500
Change: 2022-02-11 22:58:32.422344459 -0500
 Birth: -
[oracle@localhost 2022Shell]$ touch -d "2020-01-01 15:00" hello.sh
[oracle@localhost 2022Shell]$ stat hello.sh
  File: ‘hello.sh’
  Size: 33        	Blocks: 8          IO Block: 4096   regular file
Device: 811h/2065d	Inode: 48141971    Links: 1
Access: (0755/-rwxr-xr-x)  Uid: ( 1000/  oracle)   Gid: (54321/oinstall)
Context: unconfined_u:object_r:unlabeled_t:s0
Access: 2020-01-01 15:00:00.000000000 -0500
Modify: 2020-01-01 15:00:00.000000000 -0500
Change: 2022-02-11 22:59:08.585222557 -0500
 Birth: -
[oracle@localhost 2022Shell]$ 
```

### Expanding History
:point_right:   :unamused:

Event           | Designator Description
---             | ---
!!              | Last command
!*n*            | Command number ***n***          :point_left: :confused:
!-*n*           | Current command number minus ***n***
!*string*       | Most recent command beginning with ***string***
!?*string*      | Most recentcommand containung ***string***
^*str1*^*str2*  | Last command replacing ***str1*** with ***str2***

Word:           | Designator Description
---             | ---
:0              | The first word in the line
:*n*            | The ***n***th word in the line, counting from zero
:^              | The second word in the line
:$              | The last word in the line
:%              | Most recent **!?*string*** search result word
:*              | All words except the first word

Modifier        | Decription
---             | ---
:h              | Remove trailing part of path address
:r              | Remove trailing file extension
:e              | Remove all except trailing file extension
:t              | Remove leading part of path address
:p              | Display command but do not execute
:q              | Enclose in quote marks
:x              | Break words at spaces and enclose in quotes
:$/old/new      | Substitute ***old*** for ***new***

``` console
sh-4.2$ grep "bin" hello.sh
#!/bin/bash
sh-4.2$ ^bin^World
grep "World" hello.sh
echo "Hello World!"
sh-4.2$ !!:$:p
hello.sh
sh-4.2$ !!:$:p:r:q
'hello'
```

### Switching Users
A regular user can call upon most shell commands but some are only available to the priviledged root "superuser".
The superuser can use the **reboot** command to immediately restart the system.

On a typical Linux system, the user created during installation is given to the **sudo** command that allows commands to be executed as if they were the superuser. When **sudo** requests a password it requres the user password - not the password of the root superuser:

``` console
sh-3.2$ reboot
reboot: Operation not permitted
sh-3.2$ sudo reboot
Password:
```
#### sudo passwd root
When the root superuser account is locked by default it can be enbled by providing a password for root 
with the **passwd** command:
``` console
[oracle@localhost 2022Shell]$ sudo passwd root
[sudo] password for oracle: 
Changing password for user root.
New password: 
BAD PASSWORD: The password fails the dictionary check - it is based on a dictionary word
Retype new password: 
passwd: all authentication tokens updated successfully.
```
my password was *password*.
#### `su -`
Now that the root superuser account is enabled you can log in as root using the **`su`** command with its **`-`** dash option.
When a regular user first logs into the shell the working directory is by default that user's home directory.
When the superuser logs in with the **`su -`** command the working directory is the `/root` directory.

#### `pwd` `whoami` `exit`
``` console
[oracle@localhost 2022Shell]$ pwd
/home/oracle/2022Shell
[oracle@localhost 2022Shell]$ whoami
oracle
[oracle@localhost 2022Shell]$ su -
Password: 
ABRT has detected 2 problem(s). For more info run: abrt-cli list
[root@localhost ~]# pwd
/root
[root@localhost ~]# whoami
root
[root@localhost ~]# exit
logout
```
### Creating Aliases

``` console
sh-3.2$ alias now='date +%H:%M'
sh-3.2$ now
23:33
sh-3.2$ 
```
``` console
[oracle@localhost 2022Shell]$ ls
0.001                       getPassword2.sh     subshell3.sh
[oracle@localhost 2022Shell]$ alias ls='ls --color=never'
[oracle@localhost 2022Shell]$ ls
0.001			    getPassword2.sh	subshell3.sh
```
Aliases created in a Terminal will be lost when exit the session but 
they can be made permanent by adding them into the **.bashrc** that is hidden file within home directory:

``` console
[oracle@localhost ~]$ cd ~
[oracle@localhost ~]$ vi .bashrc
```
.bashrc
``` sh
#ALIASES SECTION
alias now='date +%H:%M'
alias rm='rm -i'
```
Reopen the Terminal, or enter a `source .bashrc` command, to have it execute the Bash run commands.
``` console
[oracle@localhost ~]$ now
bash: now: command not found...
[oracle@localhost ~]$ source .bashrc
[oracle@localhost ~]$ now
10:47
```
**Mac ios** Since MacOS Catalina `zsh` is the default shell, I created '.zshrc'.
Older version maybe `.bash_profile`.
``` console
antw@Mac-mini ~ % pwd
/Users/antw
antw@Mac-mini ~ % vi .zshrc
antw@Mac-mini ~ % source .zshrc
antw@Mac-mini ~ % now
11:56
antw@Mac-mini ~ % cat -n .zshrc
     1	# 20220213 created this .zshrc WAS .bash_profile
     2	
     3	alias now='date +%H:%M'
     4	alias rm='rm -i'
antw@Mac-mini ~ %  
```

### Filling Arrays

`arr=('First String' 'Second String' 'Third String')`

`arr=([0]='First String' [1]='Second String' [2]='Third String')`
```sh
arr[0]='First String' 
arr[1]='Second String' 
arr[2]='Third String')
```
`${arr[0]}` to referenced                       ;
`${arr[@]}` to see a list of all values         ;
`${#arr[@]}` to find the length of an array     ;
`${!arr[@]}` to discover which elements store a value,  and
`unset` to destroy vairable or array variable.

``` sh
# unset.sh
#!/bin/bash

arr=(Alpha Bravo Charlie Delta Echo)
unset arr[1]

echo "Array arr[1]: ${arr[1]}"
echo "Array arr all: ${arr[@]}"
echo "Array arr length: ${#arr[@]}"
echo "Array arr elements filled: ${!arr[@]}"
```
``` console
sh-4.2$ ./unset.sh
Array arr[1]: 
Array arr all: Alpha Charlie Delta Echo
Array arr length: 4
Array arr elements filled: 0 2 3 4
```

### Randomizing Numbers
Bash provides a `RANDOM` vairable that generates pseudo-random numbers in the range **0 - 32767**.
``` sh
# random1.sh

num=$(( ( RANDOM % 10 ) + 1 ))

function assess
{
	if (( guess == num ))
	then
		echo ":) $guess is Correct!"
		exit
	elif (( guess < num ))
	then echo ":( $guess Is Wrong - Try Higher"
	else echo ":( $guess Is Wong - Try Lower"
	fi
}

while read -p 'Guess My Number 1-10: ' guess
do
	assess
done
```

[lotto.sh](lotto.sh)
``` console
sh-4.2$ ./lotto.sh 9 10
Your Lucky 9 From 10 : 1 3 7 6 2 5 10 9 8 
sh-4.2$ ./lotto.sh 1 15
Your Lucky 1 From 15 : 6 
sh-4.2$ ./lotto.sh
Your Lucky 6 From 59 : 5 46 14 32 2 37 
sh-4.2$ 
```

---
:point_left: :confused:
