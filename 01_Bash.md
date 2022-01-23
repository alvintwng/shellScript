
To check on version
```sh
bash --version
```

```sh
echo $SHELL
```
To list out all types
```sh
cat /etc/shells
```
To switch from one shell to another
```sh
bash
```

``` sh
which bash
```
#### Terminal, MacMini
``` console
antw@Mac-mini ~ %             
antw@Mac-mini ~ % bash --version
GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin20)
Copyright (C) 2007 Free Software Foundation, Inc.
antw@Mac-mini ~ % 
antw@Mac-mini ~ % echo $SHELL
/bin/zsh
antw@Mac-mini ~ % 
antw@Mac-mini ~ % cat /etc/shells
# List of acceptable shells for chpass(1).
# Ftpd will not allow users to connect who are not using
# one of these shells.

/bin/bash
/bin/csh
/bin/dash
/bin/ksh
/bin/sh
/bin/tcsh
/bin/zsh
antw@Mac-mini ~ % 
antw@Mac-mini ~ % which bash
/bin/bash
antw@Mac-mini ~ % 
antw@Mac-mini ~ % bash

The default interactive shell is now zsh.
To update your account to use zsh, please run `chsh -s /bin/zsh`.
For more details, please visit https://support.apple.com/kb/HT208050.
bash-3.2$ 
bash-3.2$ exit
exit
antw@Mac-mini ~ % 

```
#### Terminal, Oracle DB Developer VM
``` console
[oracle@localhost ~]$ 
[oracle@localhost ~]$ bash --version
GNU bash, version 4.2.46(2)-release (x86_64-redhat-linux-gnu)
Copyright (C) 2011 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>

This is free software; you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
[oracle@localhost ~]$ 
[oracle@localhost ~]$ echo $SHELL
/bin/bash
[oracle@localhost ~]$ cat /etc/shells
/bin/sh
/bin/bash
/usr/bin/sh
/usr/bin/bash
/bin/tcsh
/bin/csh
/bin/ksh
/bin/rksh
[oracle@localhost ~]$ 
[oracle@localhost ~]$ which bash
/usr/bin/bash
[oracle@localhost ~]$ bash
[oracle@localhost ~]$ 

```
---
#### Shell types
* **sh** or Bourne Shell: the original shell used in UNIX
* **bash** or Bourne Again shell: the standard GNU shell
* **csh** or C shell: syntax resembles that of the C programming language
* **tcsh** or TENEX C shell: a superset of the common C shell, also call it the Turbo C shell
* **ksh** or the Korn shell: superset of the Bourne shell

#### Shell built-in commands
Bash support 3 types of built0in commands:
* Bourne Shell built-ins:

`:`,`.`, `break`,`cd`,`continue`,`eval`,`exec`,`exit`,`export`,`getopts`,`hash`,`pwd`,`readonly`,`return`,`set`,
`shift`,`test`,`[`,`times`,`trap`,`unmask` and `unset`.

* Bash built-in commands:

`alias`,`bind`,`builtin`,`command`,`declare`,`echo`,`enable`,`help`,`let`,`local`,`logout`,`printf`,`read`,
`shopt`,`type`,`typeset`,`ulimit` and `unalias`.

* Special built-in commands:

When Bash is executing in POSIX mode, built-ins are `:`,`.`,`break`,`continue`,`eval`,`exec`,`exit`,`export`,
`readonly`,`return`,`set`,`shift`,`trap` and `unset`.

#### Example Bash Script
``` sh
#!/bin/bash
clear
echo "This is information provided by mysystem.sh. Program start now."

echo "Hello, $USER"
echo

echo "Today's date is `date`, this is week `date +"%V"`."
echo

echo "These users are currently connected:"
w | cut -d " " -f 1 - | grep -v USER | sort -u
echo

printf "This is `uname -s` running on a `uname -m` processor.\n"
printf "\n"

printf "This is the uptime information:\n"
uptime
printf "\n"

printf "That's all folks! \n"
```
#### init script
Startup scripts stored in Oracle VM, `/etc/rc.d/init.d` or `/etc/init.d`. MacMini will be different location
``` console
[oracle@localhost 2022Shell]$ 
[oracle@localhost 2022Shell]$ pwd
/home/oracle/2022Shell
[oracle@localhost 2022Shell]$ cd /etc/rc.d/init.d
[oracle@localhost init.d]$ ls
functions   network  oracle-database-preinstall-19c-firstboot  rhnsd
netconsole  oracle   README
[oracle@localhost init.d]$ 
[oracle@localhost init.d]$ cd /etc/init.d
[oracle@localhost init.d]$ ls
functions   network  oracle-database-preinstall-19c-firstboot  rhnsd
netconsole  oracle   README
[oracle@localhost init.d]$ 
[oracle@localhost init.d]$ cd /home/oracle/2022Shell
[oracle@localhost 2022Shell]$ ls
mysystem.sh
[oracle@localhost 2022Shell]$ 
```


---
Reference: Bash Guide for Beginners (PDF), Machtelt Garrels, 20081227
