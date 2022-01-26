# The Bash Environment
## Shell initialization files
### System-wide configuration files
#### /etc/profile
``` sh
# /etc/profile

# System wide environment and startup programs, for login setup
# Functions and aliases go in /etc/bashrc

# It's NOT a good idea to change this file unless you know what you
# are doing. It's much better to create a custom.sh shell script in
# /etc/profile.d/ to make custom changes to your environment, as this
# will prevent the need for merging in future updates.

...
...

```
``` console
[oracle@localhost profile.d]$ ls
256term.csh                   bash_completion.sh  colorls.csh  flatpak.sh  less.csh       sh.local  vte.sh
256term.sh                    colorgrep.csh       colorls.sh   lang.csh    less.sh        vim.csh   which2.csh
abrt-console-notification.sh  colorgrep.sh        csh.local    lang.sh     PackageKit.sh  vim.sh    which2.sh
```
#### /etc/bashrc

[oracle@localhost oracle]$ cat /etc/bashrc
``` sh
# /etc/bashrc

# System wide functions and aliases
# Environment stuff goes in /etc/profile

# It's NOT a good idea to change this file unless you know what you
# are doing. It's much better to create a custom.sh shell script in
# /etc/profile.d/ to make custom changes to your environment, as this
# will prevent the need for merging in future updates.

...
...
```


### Individual user configuration files
#### ~/.bash_profile
``` console
[oracle@localhost scripts]$ locate .bash_profile
/etc/skel/.bash_profile
/u01/userhome/oracle/.bash_profile
```

- /etc/skel/.bash_profile, or
- /u01/userhome/oracle/.bash_profile
``` sh
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH
```
#### ~/.bash_login

#### ~/.profile
In the adsence of `~/.bash_profile` and `~/.bash_login`, `~/.profile` is read.

#### ~/.bashrc
``` console
[oracle@localhost scripts]$ locate .bashrc
/etc/skel/.bashrc
/u01/userhome/oracle/.bashrc
```

- /etc/skel/.bashrc
``` sh
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
```

- /u01/userhome/oracle/.bashrc
``` sh
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

if test "m$JAVAENV" = "m"
then
export TMZ="GMT" 
export JAVA_HOME=`ls -d /home/oracle/java/jdk* 2>/dev/null`
if test "m$JAVA_HOME" = "m"
then
export JAVA_HOME=/u01/app/oracle/product/version/db_1/jdk
fi
export PATH=$JAVA_HOME/bin:/home/oracle/bin:/home/oracle/sqlcl/bin:/home/oracle/sqldeveloper:/home/oracle/datamodeler:$PATH:/home/oracle/sqlcl/bin:/home/oracle/sqldeveloper:/home/oracle/bin
export JAVAENV=true
fi

#LD_LIBRARY_PATH
#set up db for su login and gnome terminal use so LD_LIBRARY_PATH pure for gnome and user does not have to . oraenv
#do I still get ui issues "m1" = "m0" ie is it really an issue of these 10 lines ( and install). -a "m1" = "m0"
pstree -s $$ | egrep "\-su-|gnome-terminal" >/dev/null 2>&1
export GNOME_CHECK=$?
if test "m$DBENV" = "m" -a "m$GNOME_CHECK" = "m0" 
then
export TMP=/tmp
export TMPDIR=$TMP
export ORACLE_UNQNAME=orclcdb
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/version/db_1
export ORACLE_SID=orclcdb
#LD_LIBRARY_PATH
export PATH=/home/oracle/bin:/home/oracle/LDLIB:$ORACLE_HOME/bin:/usr/sbin:$PATH
#during install set LD_LIBRARY_PATH otherwise rely on LDLIB wrappers and ~/bin/sql sqlplus and modeller
if test -f /tmp/1/buildTimeStillInstalling
then
export LD_LIBRARY_PATH=$ORACLE_HOME/lib
fi
export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib
export DBENV=true
#export SQL_OR_SQLPLUS=sql -oci
export SQL_OR_SQLPLUS=sqlplus
fi
if test "m$DONOTSETTWO_TASK" = "m"
		then
		export TWO_TASK=ORCL
		fi
export PATH=/home/oracle/Desktop/Database_Track/coffeeshop:$PATH
```

#### ~/.bash_logout
``` console
[oracle@localhost scripts]$ locate .bash_logout
/etc/skel/.bash_logout
/u01/userhome/oracle/.bash_logout
[oracle@localhost scripts]$ cat /u01/userhome/oracle/.bash_logout
# ~/.bash_logout

[oracle@localhost scripts]$ cat /etc/skel/.bash_logout
# ~/.bash_logout

[oracle@localhost scripts]$ 
```


### Changing shell configuration files
``` console
[oracle@localhost ~]$ cp .bashrc .bashrc.old
[oracle@localhost ~]$ vim .bashrc
[oracle@localhost ~]$ 
[oracle@localhost ~]$ diff .bashrc .bashrc.old
55,58d54
< 
< #20220126 my edition
< alias pdw='pwd'
< 
```

after restart
``` console
[oracle@localhost ~]$ pwd
/home/oracle
[oracle@localhost ~]$ pdw
/home/oracle
```

## Variables
### Types of variables
#### Global variables
Global variables or environment variables are available in all shells. The `env` or `printenv` commands can be used to display.
``` console
[oracle@localhost 2022Shell]$ env
XDG_VTNR=1
XDG_SESSION_ID=1
SSH_AGENT_PID=7644
HOSTNAME=localhost.localdomain
IMSETTINGS_INTEGRATE_DESKTOP=yes
SHELL=/bin/bash
XDG_MENU_PREFIX=gnome-
TERM=xterm-256color
VTE_VERSION=5202
HISTSIZE=1000
ORACLE_UNQNAME=orclcdb
TMPDIR=/tmp
...
```
#### Local variables
Local variables are only available in the current shell. 

#### Variables by content
- String variables
- Integer variables
- Constant variables
- Array variables

### Creating variables
**VARNAME="value"**
``` console
[oracle@localhost ]$ MYVAR1="2"
[oracle@localhost 2022Shell]$ echo $MYVAR1
2
[oracle@localhost ]$ first_name="Franky"
[oracle@localhost ]$ echo $first_name
Franky
[oracle@localhost ]$ full_name = "Franky M."
bash: full_name: command not found...
[oracle@localhost ]$ full_name="Franky M."
[oracle@localhost ]$ echo $full_name
Franky M.
[oracle@localhost ]$ unset MYVAR1 first_name full_name
[oracle@localhost ]$ echo $MYVAR1 $first_name $full_name
```
### Exporting variables
A subshell can change variables it inherited from the parent, but the changes made by the child don't affect the parent.
``` console
[oracle@localhost ]$ full_name="Franky M."
[oracle@localhost ]$ bash
[oracle@localhost ]$ echo $full_name

[oracle@localhost ]$ exit
exit
[oracle@localhost ]$ export full_name
[oracle@localhost ]$ bash
[oracle@localhost ]$ echo $full_name
Franky M.
[oracle@localhost ]$ export full_name="Charles the Great"
[oracle@localhost ]$ echo $full_name
Charles the Great
[oracle@localhost ]$ exit
exit
[oracle@localhost ]$ echo $full_name
Franky M.
[oracle@localhost ]$ 
```
When first trying to read the value of `full_name`, it is not there (**echo** shows a null string). 

The subshell quits, and `full_name` is exported in the parent - a variable can be exported after it has been assigned a value.

Then a new subshell is started, in which the variable exported from the parent is visible.

The variable is changed to hold another name, but the value for this variable in the parent stays the same.


### Reserved variables

### Special parameters

### Script recycling with variables

## Quoting characters
### why?
### Escape characters
### Single quotes
### Double quotes
### ANSI-C quoting
### Locales

## 3.4. Shell expansion
### General
### Brace expansion
### Tilde expansion
### Shell parameter and variable expansion
### Command substitution
### Arithmetic expansion
### Process substitution
### Word splitting
### File name expansion

## Aliases
### What are aliases?
### Creating and removing aliases

## More Bash options
### Displaying options
### Changing options

---
Reference: Bash Guide for Beginners (PDF), Machtelt Garrels, 20081227
