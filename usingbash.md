

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

#### Expanding History
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

#### Switching Users
A regular user can call upon most shell commands but some are only available to the priviledged root "superuser".
The superuser can use the **reboot** command to immediately restart the system.

On a typical Linux system, the user created during installation is given to the **sudo** command that allows commands to be executed as if they were the superuser. When **sudo* requests a password it requres the user password - not the password of the root superuser:

``` console
sh-3.2$ reboot
reboot: Operation not permitted
sh-3.2$ sudo reboot
Password:
```
``` console
[oracle@localhost 2022Shell]$ sudo passwd root
[sudo] password for oracle: 
Changing password for user root.
New password: 
BAD PASSWORD: The password fails the dictionary check - it is based on a dictionary word
Retype new password: 
passwd: all authentication tokens updated successfully.
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
[oracle@localhost 2022Shell]$ 
```



---
:point_left: :confused:
