edureka.md
## Linux Shell Scripting


Tools use: Oracle DB Developer VM, from VirtualBoxVM, via Mac

#### Agenda
- Getting started with Linux
- Command Line Essentials
- Shell Script Basic
- Using Variables
- Basic Operators
- Shell Loops
- Shell Functions
- Use Cases

---
### Why Linux?
- Open source opearting system
- access to source code
- highly secure
- runs faster

What is a Kernel?
- The computer programs that allocate the system resources and coordinate all the details of the computer's internals is called the operating system or the Kernel. Users communicate with the OS through a program called the Shell.
- Apple uses its own signature operating system. XNU, which since 2001 has been derived from `Unix Kernel` and known as `OS X`. Before `OS X` came `OS 9`, otherwise know as "Classic".

---
### CLI - Command Line Essentials
- `cd`  eg `$ cd /home/edureka/`
- `pwd` eg. `$ pwd`
- `ls`  eg. `$ ls /home/`, `$ ls -l`
- `cp`  eg. `$ cp c.txt /hhome/edureka/`
- `mv`  eg. `$ mv c.txt /home/Public`
- `rm`  eg. `$ rm c.txt`
- `echo`  eg. `$ echo "hello world"`
- `cat` eg. `$ cat c.txt`
- `less`  eg. `$ less c.txt` Q
- `grep`  eg. `$ mv --help | grep verbose`
- `mkdir`eg. `$ mkdir files`
- `touch` eg. `$ touch file1.txt file2.txt file3.txt`
- `chmod` eg. `$ chmod +x test.sh` `$ chmod 777 test.sh`
- `man + help`  eg. `$ man + help`, mac os $`man man`

#### test.sh
```
#!/bin/sh

echo "hello learner"
```

#### chmod
uuu ggg ooo filename date

user, group, others filename date

chmod ugo filename

* 0 = 0 = nothing
* 1 = 1 = x = execute
* 2 = 2 = w = write
* 3 = 2+1 = w+x
* 4 = 4 = r = read
* 5 = 4+1 = r+x
* 6 = 4+2+1 = r+w+x

#### Command Line Interface vs Graphical User Interface

---
### Shell Script Basic
The Shell is a Command Line Interpreter. It translates commands entered by the user and converts them into a language that is understood by the Kernel.

The basic concept of a shell script is a list of commands, which are listed in the order of execution. A good shell script will have comments, preceded by #sign, describing the steps.

Bourne Shell Types
- Bournel Shell
- Korn Shell
- Bourne-Again Shell
- POSIX Shell

C Shell Types
- C Shell
- TENEX/TOPS
- Z Shel

#### example1.sh
``` sh
#!/bin/sh

#Author : Edureka
#Script is as follows

echo "What is your name?"
read PERSON
echo "Hello, $PERSON"
```
console:
``` console
antw@Mac-mini temp % ./example1.sh
zsh: permission denied: ./example1.sh
antw@Mac-mini temp % chmod 777 example1.sh
antw@Mac-mini temp % ./example1.sh        
What is your name?
Eureka Eureka
Hello, Eureka Eureka
antw@Mac-mini temp % 
```
---
### Using Variables
A variable is a character string to which we assign a value. The value assigned could be a number, text, filename, device, or any other type of data.

Variable Types:
- Local Variable
- Environment Variable
- Shell Variable

#### variable.sh
``` sh
#!/bin/sh

#variable_name=variable_value

Name="Edureka Edureka"
echo $NAME
```
scalar variables - hold one value at a time

`readonly` variable - cannot be change

`unset` variable - delete/remove the variable from the list

- #$0 - filename of the script
  - $1....9 - correspond to the arguments with which a script was invoked, 
number corresponding to the position of the argument.
- $# - return the number of arguments applied to a script
- $* - return all the arguments that are double quoted
- $@ - return all the arguments that are individually double quoted
- $? - exit status of the last command. eg. `$ echo $?`, 0 is successful, 1 is unsuccessful.
- $$ - the process number of the current shell for the shell script. Also the process ID.

#### variable.sh
``` sh
#!/bin/sh

echo "File name: $0"
echo "First parameter: $1"
echo "Second parameter: $2"
echo "Quoted Values: $@"
echo "Quoted Values: $*"
echo "No of Parameters: $#"
```
console:
``` console
antw@Mac-mini temp % chmod 777 variable.sh                
antw@Mac-mini temp % ./variable.sh Edureka Learner
File name: ./variable.sh
First parameter: Edureka
Second parameter: Learner
Quoted Values: Edureka Learner
Quoted Values: Edureka Learner
No of Parameters: 2
```
#### variable.sh
``` sh
for TOKEN in $*
do
        echo $TOKEN
done
```
console:
``` console
antw@Mac-mini temp % ./variable.sh "Edureka Learner"
Edureka
Learner
antw@Mac-mini temp % echo $?                        
0
antw@Mac-mini temp % 
```
---
### Basic Operators
* Arithmetic Operators
* Relational Operators
* Boolean Operators
* String Operators
* File Test Operators

#### Arithmetic Operators
| Operators | Purpose | Example |
|---|---|---|
| + (Addition)      | Adds values on either side of the operator | `expr $a + $b` will give 30|
| - (Substraction)  | Substract right hand operand from left hand operand | `expr $a - $b` will give -10 |
| * (Multiplcation) | Multiples values on either side of the operator | `expr $a \* $b` will give 200 |
| / (Division)      | Divides left hand operand by right hand operand | `expr $b / $a` will give 2|
| % (Modulus)       | Divides left hand operand by right hand operand and returns remainder | `expr $b % $a` will give 0 |
| = (Assignment)    | Assigns right operand in left operand | `a = $b` would assign value of b into a |
| == (Equality)     | Compares two numbers, if both are same then return true.| `[$a == $b]` would return false |
| != (Not Equality) | Compares two numbers, if both are different then return true. | `[ $a != $b ]` would return true |

#### Relational Operators
| Operators | Purpose | Example |
|---|---|---|
| -eq | Check if the value of two operands are equal or not; if yes, then the condition becomes true. | `[ $a -eq $b ]` is not true. |
| -ne | Check if the value of two operands are equal or not; if values are not equal, then the condition becomes true. | `[ $a -ne $b ]` is true. |
| -gt | Check if the value of left operand is greater than the value of right operand; if yes then the condition becomes true. | `[ $a -gt $b ]` is not true. |
| -lt | Check if the value of left operand is less than the value of right operand; if yes then the condition becomes true. | `[ $a -lt $b ]` is true. |
| -ge | Check if the value of left operand is greater than or equal to the value of right operand; if yes then the condition becomes true. | `[ $a -ge $b ]` is not true. |
| -le | Check if the value of left operand is less than or equal to the value of right operand; if yes then the condition becomes true. | `[ $a -le $b ]` is true. |

Relational Operators only work on numeric values
#### Boolean Operators
| Operators | Purpose | Example |
|---|---|---|
| ! | This is logical negation. This inverts a true condition into false and vice versa. | `[ ! false ]` is true. |
| -o | This is logical **OR**. If one of the operands is true, then the condition becomes true. | `[ $a -lt 20 -o $b -gt 100 ]` is true. |
| -a | This is logical **AND**. If both the operands are true, then the condition becomes true otherwise false. | `[ $a -lt 20 -a $b -gt 100 ]` is true. |

#### String Operators
| Operators | Purpose | Example |
|---|---|---|
| = | Checks if the value of two operands are equal or not; if yes, then the condition becomes true. | `[ $a = $b ]` is not true. |
| != | Checks if the value of two operands are equal or not; if values are not equal then the condition becomes true. | `[ $a != $b ]` is true.  |
| -z | Check if the given string operand size is zero; if it is zero length, then it returns true. | `[ -z $a ]` is not true. |
| -n | Checks if the given string operand size is non-zero; if it is nonzero length, then it returns true. | `[ -n $a ]` is not false.|
| str | Check if **str** is not the empty string; if it is empty, then it returns false. | `[ $a ]` is not false. |

#### File Test Operators
| Operators | Purpose | Example |
|---|---|---|
| -b file | Checks if file is a block special file; if yes, then the conditional becomes true. | `[ -b $file ]` is false. |
| -c file | Checks if file is a character special file; if yes, then the conditional becomes true. | `[ -c $file ]` is false.  |
| -d file | Checks if file is a directory; if yes, then the conditional becomes true. | `[ -d $file ]` is not true. |
| -f file | Checks if file is an ordinary file as opposed to a directory or special file; if yes, then the conditional becomes true.  | `[ -f $file ]` is true. |
| -g file | Checks if file has its set group ID (SGID) bit set; if yes, then the conditional becomes true.  | `[ -g $file ]` is false. |
| -k file | Checks if file has its sticky bit set; if yes, then the conditional becomes true.  | `[ -k $file ]` is false. |
| -p file | Checks if file is a named pipe; if yes, then the conditional becomes true.  | `[ -p $file ]` is false. |
| -t file | Checks if file descriptor is open and associated with a terminal; if yes, then the conditional becomes true.  | `[ -t $file ]` is false. |
| -u file | Checks if file has its set User ID (SUID) bit set; if yes, then the conditional becomes true.  | `[ -u $file ]` is false. |
| -r file | Checks if file is readable; if yes, then the conditional becomes true.  | `[ -r $file ]` is true. |
| -w file | Checks if file is writable; if yes, then the conditional becomes true.  | `[ -w $file ]` is true. |
| -x file | Checks if file is executable; if yes, then the conditional becomes true.  | `[ -x $file ]` is true. |
| -s file | Checks if file has size greater than 0; if yes, then the conditional becomes true.  | `[ -s $file ]` is true. |
| -e file | Checks if file  exists; is true even if file is a directory but exists. | `[ -e $file ]` is true. |

---
### Shell Loops
* The While Loop
* The For Loop
* The Until Loop
* Nested Loops
* Loop Control

#### for.sh
``` sh
#!/bin/sh

for var in 0 1 2 3 4 5 6 7 8 9
do 
        echo $var
done
```
console:
``` console
antw@Mac-mini temp % chmod 777 for.sh
antw@Mac-mini temp % ./for.sh
0
1
2
3
4
5
6
7
8
9
antw@Mac-mini temp % 
```
#### while.sh
``` sh
#!/bin/sh

a=0

while [ $a -lt 10 ]
do 
        echo $a
        a=`expr $a + 1`
done
```
#### until.sh
``` sh
#!/bin/sh

a=0

until [ ! $a -lt 10 ]
do 
        echo $a
        a=`expr $a + 1`
done
```
#### nested.sh
``` sh
#!/bin/sh

a=0
while [ "$a" -lt 10 ]           # this is loop1
do
        b="$a"
        while [ "$b" -ge 0 ]    # this is loop2
        do
                echo -n "$b "
                b=`expr $b - 1`
        done
        echo 
        a=`expr $a + 1`
done
```
console:
``` console
[oracle@localhost mytest]$ chmod 777 nested.sh
[oracle@localhost mytest]$ ./nested.sh
0 
1 0 
2 1 0 
3 2 1 0 
4 3 2 1 0 
5 4 3 2 1 0 
6 5 4 3 2 1 0 
7 6 5 4 3 2 1 0 
8 7 6 5 4 3 2 1 0 
9 8 7 6 5 4 3 2 1 0 
[oracle@localhost mytest]$ 
```
Work on Oracle terminal, not on MacOS
#### infinite.sh
``` sh
#!/bin/sh

a=10

until [ $a -gt 0]
do
        echo $a
        a=`expr $a + 1`
done
```
ctrl-C to break/stop.

#### break.sh
``` sh
#!/bin/sh

a=0

while [ $a -lt 10 ]
do
        echo $a
        if [ $a -eq 5 ]
        then 
                break
        fi
        a=`expr $a + 1`
done
```
#### continue.sh
``` sh
#!/bin/sh

NUMS="1 2 3 4 5 6 7"

for NUM in $NUMS
do
        Q=`expr $NUM % 2`
        if [ $Q -eq 0 ]
        then 
                echo "Number is an even number!!"
                continue
        fi
        echo "Found odd number"
done
```
---
### Shell Functions
* Creating Functions
* Passing Parameters to Functions
* Returning Values from Functions
* Nested Functions
* Function Call from Prompt

#### functions.sh
``` sh
#!/bin/sh
#define function

Hello(){ 
        echo "Hello learner"
}

#Invoke Function
Hello
```
console:
``` console
antw@Mac-mini temp % chmod 777 functions.sh
antw@Mac-mini temp % ./functions.sh
Hello learner
```
#### funcstions.sh
``` sh
#!/bin/sh
#define function

Hello(){ 
        echo "Hello $1 $2"
        return 10
}

#Invoke Function
Hello Priyanka Chopra

#Capture value returned previously
ret=$?
echo "Return value is $ret"
```
console:
``` console
antw@Mac-mini temp % ./functions.sh
Hello Priyanka Chopra
Return value is 10
```

#### functions.sh
``` sh
#!/bin/sh
#define function

number_one () { 
        echo "Alpha online...Over"
        number_two
}

number_two () { 
        echo "Beta online...Over"
}

number_one
```
console:
``` console
antw@Mac-mini temp % ./functions.sh
Alpha online...Over
Beta online...Over
```

---
### Use Cases
#### scan.sh
``` sh
#!/bin/bash

is_alive_ping()
{
        ping -c 1 $1 > /dev/null
        [ $? -eq 0 ] && echo Node with IP: $i is up.
}

for i in 192.168.2.{1..255}
do
is_alive_ping $i & disown
done
exit 
```
after google "What is my IP address", replace the IP address with 116.14.135.

#### chk_hosts.sh
yet to work
``` sh

#!/bin/bash

for i in $@
do
ping -c 1 $i &> /dev/null

if [ $? -ne 0 ]; then
        echo "'date': ping failed, $i host is down!" | mail -s "$i host is down!" workingmail@gmail.com

fi
done
```
console:
``` console
antw@Mac-mini temp % ./chk_hosts.sh google.com 192.168.2.2 192.1.1.2
antw@Mac-mini temp % 
```
Gmail Spam Folder:
```
antw    192.1.1.2 host is down!
antw    192.168.2.2 host is down!
```
other example of sending email thru script
``` console
antw@Mac-mini temp % mail -s 'message subject' workingmail@gmail.com <<< 'testing message body'
```
#### monitor.sh
https://youtu.be/GtovwKDemnI?t=3921

``` sh
#!/bin/bash

LOG=/tmp/mylog.log
SECONDS=60

EMAIL=working@gmail.com

for i in $@; do
    echo "$1-UP!" > $LOG.$i
done

while true; do
    for i in $@; do

        ping -c 1 $i &> /dev/null
        if [ $? -ne 0 ]; then
            STATUS=$(cat $LOG.$i)
                if [ $STATUS != "$i-DOWN!" ]; then
                    echo "`date`:ping failed, $i host is down!" |
                    mail -s "$i host is down!" $EMAIL

                fi
            echo "$i-DOWN!" > $LOG.$i
        else
            STATUS=$(cat $LOG.$i)
                if [ $STATUS != "$i-UP!" ]; then
                    echo "`date`: ping OK, $i host is up!"

                fi
            echo "$i-UP!" > $LOG.$i
        fi
    done

    sleep $SECONDS
done

```
To test need to sure that the IP address not used.
``` console
$ ./monitor.sh google.com 192.168.2.2 192.1.1.2
antw@Mac-mini temp % cd /tmp
antw@Mac-mini /tmp % ls mylog*.*
mylog.log.192.1.1.2	mylog.log.192.168.2.2	mylog.log.google.com
antw@Mac-mini /tmp % cat mylog.log.google.com
google.com-UP!
antw@Mac-mini /tmp % cat mylog.log.192.1.1.2
192.1.1.2-DOWN!
antw@Mac-mini /tmp % cat mylog.log.192.168.2.2                   
192.168.2.2-DOWN!
antw@Mac-mini /tmp %  
```
Gmail Spam Folder:
```
antw    192.1.1.2 host is down!
antw    192.168.2.2 host is down!
```

#### backup.sh
https://youtu.be/GtovwKDemnI?t=4130

``` sh
#mount shared directory
mount -t cifs //192.168.1.16/2tbShared/Shubham/BlogImages //home/edureka/2tbshared -o username=edureka,password=edureka

# what to backup,
backup_files="//home/edureka/2tbshared"

# where to backup to,
dest="/home/edureka/backup"

# Create archive filename,
day=$(date +%A)
hostname=$(hostname -s)
archive_file="$hostname-$day.tgz"

# Print start status message,
echo "Backing up $backup_files to $dest/$arhive_file"
date
echo

# Backup the files using tar,
tar czf $dest/$archive_file $backup_files

# Print end status message,
echo
echo "Backup finished"
date

# Long listing of files in $dest to check file sizes.
ls -lh $dest

#unmount
unmount //home/edureka/2tbshared
```
yet to test run

---

ref Youtube: [Shell Scripting Tutorial | Shell Scripting Crash Course | Linux Certification Training | Edureka](https://youtu.be/GtovwKDemnI)

---
