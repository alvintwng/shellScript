

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
Event           | Designator Description
---             | ---
!!              | Last command
!*n*            | Command number ***n***
!-*n*           | Current command number minus ***n***
!*string*       | Most recent command beginning with ***string***
!?*string*      | Most recentcommand containung ***string***
^*str1*^*str2*  |Last command replacing ***str1*** with ***str2***

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
