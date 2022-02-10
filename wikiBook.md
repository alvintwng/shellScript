Bash Shell Scripting

* [Some introductory examples](#some-introductory-examples)
  * [testConfig.sh](#testConfig-sh)
* [Simple commands](#simple-commands)
  * Quoting `'``;``"`, Blackslash, Tilde expansion `~`, Brace expansion `{}`, Redirecting output `>``;``>>`,A preview of pipelines 
* [Variables](#variables)
  * mkfile.sh
* [positional parameters](#positional-parameters)
* [Exit status](#exit-status)
* [Conditional expressions and `if` statements](#conditional-expressions-and-if-statements)
  * Test expression, Conditional expressions, Combining conditions
* [Loops](#loops)
* [Shell functions](#shell-functions)
* [Subshells, environment variables, and scope](#subshells-environment-variables-and-scope)
* [Pipelines and command substitution](#pipelines-and-command-substitution)
* [Shell arithmetic](#shell-arithmetic)
* [External Programs](#external-programs)


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

### positional parameters
**are identified by numbers rather than by names**

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
# echo "$*" > "$file"   # $@ or $*
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

:star: :point_right: The exit status of a command is (briefly) available as `$?`. 

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

### Conditional expressions and `if` statements
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
Test expression 🌟
``` sh
# First build a function that simply returns the code given
returns() { return $*; }

# Then use read to prompt user to try it out.
read -p "Exit code:" exit   # read `help read' if you need more info

if (returns $exit)
  then echo "true, $?"
  else echo "false, $?"
fi
```
equivalent (changed function name and variable name, added `echo` for my debug)
``` sh
# Let's reuse the returns function.
functionReturns() { return $*; }

read -p "Exit code:" exitStatus
echo "exitStatus: $exitStatus"

# if (                      and                 ) else            fi
functionReturns $exitStatus && echo "true, $?" || echo "false, $?"

# The REAL equivalent, false is like `returns 1'
# Of course you can use the returns $exit instead of false.
# (returns $exit ||(echo "false, $?"; false)) && echo "true, $?"
```

#### Conditional expressions
:star2: :stars: :star: Most commonly used conditions supported by Bash's `[[ … ]]` notation

* `-e file`
      True if *file* exists
* `-d file`
      True if *file* exists and is a directory.
* `-f file`
      True if *file* exists and is a regular file.
* `string1 == string2`
      True if *string1* and *string2* are equal.
* `string ~= pattern`
      True if *string* matches *pattern*.               :point_left: :confused:
* `string != pattern`
      True if *string* does not match *pattern*.        :point_left: :confused:

In the last three types of tests, the value on the left is usually a variable expansion; for example, `[[ "$var" = 'value' ]]` returns a successful exit status if the variable named `var` contains the value `value`.


The following script is equivalent to the above `if` statements, but it only prints output if the first argument is `--verbose`:

verbose.sh, also myTest on **`{ }`**, **`( (  ) )`**, **`;`** and blank
``` sh
#!/bin/bash

if [[ "$1" == --verbose ]]
  then verbose_mode=TRUE                                                ### without ;
    shift # remove the option from $@
else
  verbose_mode=FALSE
fi

if [[ -e source1.txt ]] ; then
  {                                                                     ### {
    if [[ "$verbose_mode" == TRUE ]] ; then
      echo 'source1.txt exists; copying to destination.txt.'
    fi 
  }                                                                     ### }
  cp source1.txt destination.txt
elif [[ -e source2.txt ]] ; then
  ( if [[ "$verbose_mode" == TRUE ]] ; then                             ### (
      ( echo 'source1.txt does not exist, but source2.txt does.'        ### (
        echo 'Copying source2.txt to destination.txt.' )                ### (
    fi   )                                                              ### (
  cp source2.txt destination.txt
else                                                                    ### blank
  if [[ "$verbose_mode" == TRUE ]]                                      ### without ;
    then
      echo 'Neither source1.txt nor source2.txt exists; exiting.'
  fi
  exit 1 # terminate the script with a nonzero exit status (failure)
fi
```
"verbose": it generates a lot of output.

``` console
sh-4.2$ ./verbose.sh
sh-4.2$ echo $?
1
sh-4.2$ ./verbose.sh --verbose
Neither source1.txt nor source2.txt exists; exiting.
sh-4.2$ echo $?
1
```
#### Combining conditions
``` sh
#!/bin/bash

if [[ -e source.txt ]] && ! [[ -e destination.txt ]] ; then
  # source.txt exists, destination.txt does not exist; perform the copy:
  cp source.txt destination.txt
fi
```
can also write the above this way:
``` sh
#!/bin/bash

if [[ -e source.txt && ! -e destination.txt ]] ; then
  # source.txt exists, destination.txt does not exist; perform the copy:
  cp source.txt destination.txt
fi
```
#### Notes on readability
- The commands within an `if` statement are indented ... 
- The semicolon character `;` is used before `then`. ...
- A newline is used after `then` and after `else`. ...
- Regular commands are separated by newlines, never semicolons. This is a general convention, ...

### Loops
rename them to *.txt.bak
``` sh
for file in *.txt ; do
  mv "$file" "$file.bak"
done
```

integers 1 through 20 (using brace expansion):
``` sh
for i in {1..20} ; do
  echo "$i"
done
```

the positional parameters "$@":
``` sh
for arg in "$@" ; do
  echo "$arg"
done
```

while loop  - mynote: will continue run if wait.txt is available.
```sh
while [[ -e wait.txt ]] ; do
  sleep 3 # "sleep" for three seconds
done
```

until loop - the reverse of the above
``` sh
until [[ -e proceed.txt ]] ; do
  sleep 3 # "sleep" for three seconds
done
```

mynote :star:
``` console
[oracle@localhost ~]$ alias loop20='for i in {1..20}; do (sleep 1; echo "$i"); done'
[oracle@localhost ~]$ loop20
```

### Shell functions
``` sh
#!/bin/bash
# Usage:     get_password VARNAME
# Asks the user for a password; saves it as $VARNAME.
# Returns a non-zero exit status if standard input is not a terminal, or if the
# "read" command returns a non-zero exit status.
get_password() {
  if [[ -t 0 ]] ; then
    read -r -p 'Password:' -s "$1" && echo
  else
    return 1
  fi
}

get_password PASSWORD && echo "$PASSWORD"
```
:point_right:
The function `get_password` doesn't do anything that couldn't be done without a shell function, but the result is much more readable. 
The function invokes the built-in command `read` with several options that most Bash programmers will not be familiar with. (
- The `-r` option disables a special meaning for the backslash character; 
- the `-p` option causes a specified prompt, in this case `Password:`, to be displayed at the head of the line; and
- the `-s` option prevents the password from being displayed as the user types it in. Since 
- the `-s` option also prevents the user's newline from being displayed, 
- the `echo` command supplies a newline.) Additionally, 
- the function uses the conditional expression `-t 0` to make sure that the script's input is coming from a terminal (a console), .... 

Within a shell function, the positional parameters (`$1`, `$2`, and so on, as well as `$@`, `$*`, and `$#`) refer to the arguments that the function was called with, not the arguments of the script that contains the function. 
If the latter are needed, then they need to be passed in explicitly to the function, using `"$@"`. 

A function call returns an exit status, just like a script (or almost any command). 
To explicitly specify an exit status, use the `return` command, which terminates the function call and returns the specified exit status. 
If no exit status is specified, ... then the function returns the exit status of the last command that was run.

* Incidentally, either `function` or `( )` may be omitted from a function declaration, but at least one must be present.
 Instead of `function get_password ( )`, many programmers write `get_password()`. 
* Similarly, the `{ … }` notation is not exactly required, and is not specific to functions; it is simply a notation for grouping a sequence of commands into a single compound command. 
* The body of a function must be a compound command, such as a `{ … }` block or an `if `statement; `{ … }` is the conventional choice, even when all it contains is a single compound command and so could theoretically be dispensed with.

### Subshells, environment variables, and scope
#### Subshells
In Bash, one or more commands can be wrapped in parentheses, causing those commands to be executed in a "subshell".
``` sh
#!/bin/bash

foo=bar
echo "$foo" # prints 'bar'

# subshell:
(
  echo "$foo" # prints 'bar' - the subshell inherits its parents' variables
  baz=bip
  echo "$baz" # prints 'bip' - the subshell can create its own variables
  foo=foo
  echo "$foo" # prints 'foo' - the subshell can modify inherited variables
)

echo "$baz" # prints nothing (just a newline) - the subshell's new variables are lost
echo "$foo" # prints 'bar' - the subshell's changes to old variables are lost
```
``` console
      bar
      bar
      bip
      foo

      bar
```
:point_right:
A subshell also delimits changes to other aspects of the execution environment; ...
``` sh
#!/bin/bash

cd /
pwd # prints '/'

# subshell:
(
  pwd # prints '/' - the subshell inherits the working directory
  cd home
  pwd # prints '/home' - the subshell can change the working directory
) # end of subshell

pwd # prints '/' - the subshell's changes to the working directory are lost
```
``` console
      /
      /
      /home
      /
      sh-4.2$ pwd
      /home/oracle/2022Shell
```
An `exit` statement within a subshell terminates only that subshell.  :point_left: :confused:
```sh
#!/bin/bash
( exit 0 ) && echo 'subshell succeeded'
( exit 1 ) || echo 'subshell failed'
```
``` console
      subshell succeeded
      subshell failed
```
#### Environment variables
Note that export doesn't just create an environment variable; it actually marks the Bash variable as an exported variable, and later assignments to the Bash variable will affect the environment variable as well.
``` sh
#!/bin/bash
foo=bar
bash -c 'echo $foo' # prints nothing
export foo
bash -c 'echo $foo' # prints 'bar'
foo=baz
bash -c 'echo $foo' # prints 'baz'

export foo=bax
bash -c 'foo=bad' # has no effect
echo "$foo" # print 'bax'
```
* the Bash built-in command `.` ("dot") or source, which runs an external file almost as though it were a shell function. :point_left: :confused:
  header.sh
  ``` sh
  foo=bar
  function baz ()
  {
    echo "$@"
  }
  ```
  ``` sh
  #!/bin/bash
  . header.sh
  baz "$foo"
  ```
  will print `'bar'`.


#### Scope
* Bash variables that are localized to a function-call are scoped to the function that contains them, including any functions called by that function.
  * The `local` built-in command can be used to localize one or more variables to a function-call, using the syntax `local var1 var2` or `local var1=val1 var2=val2`.
  * They differ from non-localized variables only in that they disappear when their function-call ends. In particular, they still *are* visible to subshells and child function-calls. Furthermore, like non-localized variables, they can be exported into the environment so as to be seen by child processes as well.
  
In effect, using `local` to localize a variable to a function-call is like putting the function-call in a subshell, except that it only affects the one variable; other variables can still be left non-"local".
``` sh
#!/bin/bash

foo=bar

function f1 ()
{
  echo "$foo"
}

function f2 ()
{
  local foo=baz
  f1 # prints 'baz'
}

f2
```
... will actually print `baz` rather than `bar`. This is because the original value of `$foo` is hidden until `f2` returns. (In programming language theory, a variable like `$foo` is said to be "dynamically scoped" rather than "lexically scoped".)

... since `local` is simply an executable command, a function can decide at execution-time whether to localize a given variable, so this script:
``` sh
#!/bin/bash

function f ()
{
  if [[ "$1" == 'yes' ]] ; then
    local foo
  fi
  foo=baz
}

foo=bar
f yes # modifies a localized $foo, so has no effect
echo "$foo" # prints 'bar'
f # modifies the non-localized $foo, setting it to 'baz'
echo "$foo" # prints 'baz'
```

### Pipelines and command substitution
#### Pipelines

#### Command substitution
There is really no reason that the caller should have to save the password in a variable. If get_password simply printed the password to its standard output, then the caller could use command substitution, and use it directly:
```sh
#!/bin/bash
 
function get_password ( )
# Usage:     get_password
# Asks the user for a password; prints it for capture by calling code.
# Returns a non-zero exit status if standard input is not a terminal, or if
# standard output *is* a terminal, or if the "read" command returns a non-zero
# exit status.
{
  if [[ -t 0 ]] && ! [[ -t 1 ]] ; then
    local PASSWORD
    read -r -p 'Password:' -s PASSWORD && echo >&2
    echo "$PASSWORD"
  else
    return 1
  fi
}

echo `get_password`
# echo "$(get_password)"
```
In addition to the notation `$(…)`, an older notation `` `…` `` (using backquotes) is also supported, and still quite commonly found. The two notations have the same effect, but the syntax of `` `…` `` is more restrictive, and in complex cases it can be trickier to get right.

Command substitution allows nesting; something like `a "$(b "$(c)")"` is allowed. (It runs the command `c`, using its output as an argument to `b`, and using the output of *that* as an argument to `a`.)

### Shell arithmetic
Arithmetic expressions in Bash are closely modeled on those in C, ...
#### Arithmetic expansion :+1:
``` sh
echo $(( 3 + 4 * (5 - 1) ))
```
#### expr (deprecated)
```sh
echo `expr 3 + 4 \* \( 5 - 1 \)`
```
#### Numeric operators
`+` (addition), `-` (subtraction),`*` (multiplication), `/` (integer division, described above), `%` (modulo division) and ** ("exponentiation").

In addition to the simple assignment operator `=`, Bash also supports compound operators such as `+=`, `-=`, `*=`, `/=`, and `%=`, which perform an operation followed by an assignment.
The increment operator `++` increases a variable's value by 1;
The decrement operator `--` is exactly the same, except that it decreases the variable's value by 1.


#### Referring to variables
``` sh
i=2+3
echo $(( 7 * i ))
```
#### Assigning to variables
``` sh
echo $(( 7 * (i = 2 + 3) ))
```
#### Arithmetic expressions as their own commands
A command can consist entirely of an arithmetic expression, using either of the following syntaxes:
``` sh
(( i = 2 + 3 ))
```
```sh
let 'i = 2 + 3'
```
Both styles of command return an exit status of zero ("successful" or "true") if the expression evaluates to a non-zero value, and an exit status of one ("failure" or "false") if the expression evaluates to zero. For example, this:
``` sh
(( 0 )) || echo zero
(( 1 )) && echo non-zero
```
``` console
[oracle@localhost ~]$ (( 0 )) || echo zero; (( 1 )) && echo non-zero
zero
non-zero
```

#### The comma operator
Arithmetic expressions can contain multiple sub-expressions separated by commas `,`. 
``` sh
echo $(( i = 2 , j = 2 + i , i * j ))
```
sets `$i` to `2`, sets `$j` to `4`, and prints `8`.

The `let` built-in actually supports multiple expressions directly without needing a comma; therefore, the following three commands are equivalent:
```sh
(( i = 2 , j = 2 + i , i * j ))
```
```sh
let 'i = 2 , j = 2 + i , i * j'
```
```sh
let 'i = 2' 'j = 2 + i' 'i * j'
```

#### Comparison, Boolean, and conditional operators
integer comparison operators `<`, `>`, `<=`, `>=`, `==` (meaning =), and `!=`. Each evaluates to 1 for "true" or 0 for "false".

the Boolean operators 
`&&`, which evaluates to 0 if either of its operands is zero, and to 1 otherwise; 
`||`, which evaluates to 1 if either of its operands is nonzero, and to 0 otherwise; and ! ("not"), which evaluates to 1 if its operand is zero, and to 0 otherwise. 

And they support the conditional operator `b ? e1 : e2`. This operator evaluates `e1`, and returns its result, if `b` is nonzero; otherwise, it evaluates `e2` and returns its result.

These operators can be combined in complex ways:
```sh
(( i = ( ( a > b && c < d + e || f == g + h ) ? j : k ) ))
```
#### Arithmetic for-loops
Bash also supports another style, modeled on the for-loops of C and related languages, using shell arithmetic:
```sh
# print all integers 1 through 20:
for (( i = 1 ; i <= 20 ; ++i )) ; do
  echo $i
done
```
This for-loop uses three separate arithmetic expressions ...
```sh
# print all integers 1 through 20:
(( i = 1 ))
while (( i <= 20 )) ; do
  echo $i
  (( ++i ))
done
```

#### Bitwise operators
Just as in C, the bitwise operators are `&` (bitwise "and"), `|` (bitwise "or"), `^` (bitwise "exclusive or"), `~` (bitwise "not"), `<<` (bitwise left-shift), and `>>` (bitwise right-shift), as well as `&=` and `|=` and `^=` (which include assignment, just like `+=`).

#### Integer literals
... literals may be expressed in any base in the range 2–64, using the notation *base#value*.
```sh
echo $(( 12 ))        # use the default of base ten (decimal)
echo $(( 10#12 ))     # explicitly specify base ten (decimal)
echo $(( 2#1100 ))    # base two (binary)
echo $(( 8#14 ))      # base eight (octal)
echo $(( 16#C ))      # base sixteen (hexadecimal)
echo $(( 8 + 2#100 )) # eight in base ten (decimal), plus four in base two (binary)
```
will print 12 six times.

... There are also two special notations: prefixing a literal with `0` indicates base-eight (octal), and prefixing it with `0x` or `0X` indicates base-sixteen (hexadecimal). For example, `030` is equivalent to `8#30`, and `0x6F` is equivalent to `16#6F`.

#### Integer variables
A variable may be declared as an integer variable 
```sh
declare -i n
n='2 + 3 > 4'
```
**`declare`** - Declare variables and/or give them attributes.  If no names are  given
              then  display the values of variables. (from `help declare`)

is more or less equivalent to this:
``` sh
n=$((2 + 3 > 4))
```
#### Non-integer arithmetic
Bash shell arithmetic only supports integer arithmetic. However, external programs can often be used to obtain similar functionality for non-integer values.
```sh
echo "$(echo '3.4 + 2.2' | bc)"   # prints 5.6
```
**`bc`** [ -hlwsqv ] [long-options] [ FILE ... ]

*   is a language that supports arbitrary precision numbers with interactive
       execution of statements.  There are some similarities in the syntax to the C
       programming  language. ... (from `man bc`)
*   '`scale` ( expression )'
The value of the `scale` function is the number of digits after the decimal point in the expression. (from `info bc`)

... to support non-integers, become something like this:
```sh
# print the powers of one-half, from 1 to 1/512:
i=1
while [ $( echo "$i > 0.001" | bc ) = 1 ] ; do
  echo $i
  i=$( echo "scale = scale($i) + 1 ; $i / 2" | bc )
done
```
mynote
``` console
[oracle@localhost ~]$ i=0.01; echo "$i > 0.001" | bc
1
[oracle@localhost ~]$ i=0.0001; echo "$i > 0.001" | bc
0
[oracle@localhost ~]$ (echo "scale = 5; 0.01/2")| bc
.00500
```

### External Programs
Bash, as a shell, is actually a 'glue' language. It helps programs to cooperate with each other, and benefits from it. Always Search The Internet for what you want -- there are lots of command line utilities available.

- Using [whiptail](https://en.wikibooks.org/wiki/Bash_Shell_Scripting/Whiptail)
  ``` console
  [oracle@localhost ~]$ whiptail --title "Example Dialog" --infobox "This is an example of an info box." 8 78
  [oracle@localhost ~]$ TERM=ansi whiptail --title "Example Dialog" --infobox "This is an example of an info box" 8 78
  ```
- Using [AWK](https://en.wikibooks.org/wiki/AWK)
  ``` console
  awk '{print $2,$1}' filename
  ```
- Using [sed](https://en.wikibooks.org/wiki/Sed)  ("stream editor") 
  ``` console
  sed s/cat/dog/g in > out
  ```
- Using [grep](https://en.wikibooks.org/wiki/Grep)
  ``` console
  [oracle@localhost ~]$ ls |grep output
  debug_output.tx
  ``
- Using man, info and help
  - Appending `--long-help`, `--help` or `--usage` to a command-line program may also gives you the usage information. Possible synonyms include `-H` and `-h`.
  ``` sh
  man --help
  man man

  info --help
  man info
  info info

  help help
  ```
  - Pressing `h` in `man` and `info`'s interfaces can also give you some direction.






---
https://en.wikibooks.org/wiki/Bash_Shell_Scripting      :point_left: :confused:
