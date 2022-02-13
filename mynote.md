# mynote
Shell Scripting notes

[top]: topOfThePage

*   [01_Bash.md](01_Bash.md)

    `bash --version`

    `echo $SHELL`

    `cat /etc/shells`

    `which bash`

     Bourne Shell built-ins:
    
      `:`,`.`,`break`,`cd`,`continue`,`eval`,`exec`,`exit`,`export`,`getopts`, `hash`, `pwd`, `readonly`, `return`, `set`, `shift`,`test`,`[`,`times`,`trap`,`unmask` and `unset`.

     Bash built-in commands:
    
      `alias`,`bind`,`builtin`,`command`,`declare`,`echo`,`enable`,`help`,`let`, `local`, `logout`, `printf`,`read`, `shopt`,`type`,`typeset`,`ulimit` and `unalias`.

*   [02_Debuging.md](02_Debuging.md)
    #### `bash -x script1.sh`
    Debugging on the entire script
    #### `set -x`
    Debugging on part(s) of the script
    ```sh
    set -x      # activate debugging from here
    w
    set +x      # stop debugging from here 
    ```


*   [introToShell.md](introToShell.md)

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
    alternate for schell script, **`alias`**
    ```sh
    alias lsal='clear; ls -al'
    ```

*   [wikiBooks](wikiBook.md)
    positional parameters
    ``` sh
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
    `if` statement
    ```sh
    if [[ -e config.txt ]] ; then
      # if config.txt exists:
      diff -u config-default.txt config.txt > config-diff.txt # see what's changed
    else
      # if config.txt does not exist:
      cp config-default.txt config.txt # take the default
    fi
    ```
    function
    ``` sh
    returns() { return $*; }

    read -p "Exit code:" exit

    if (returns $exit)
      then echo "true, $?"
      else echo "false, $?"
    fi
    ```
    `while`
 
    ```sh
    while [[ -e wait.txt ]] ; do
      sleep 3 # "sleep" for three seconds
    done    
    ```
    
    shell function
    ```sh
    #!/bin/bash
    # Usage:     get_password VARNAME
    get_password() {
      if [[ -t 0 ]] ; then
        read -r -p 'Password:' -s "$1" && echo
      else
        return 1
      fi
    }

    get_password PASSWORD && echo "$PASSWORD"
    ```
    
    to support non-integers
    ``` sh
    # print the powers of one-half, from 1 to 1/512:
    i=1
    while [ $( echo "$i > 0.001" | bc ) = 1 ] ; do
      echo $i
      i=$( echo "scale = scale($i) + 1 ; $i / 2" | bc )
    done
    ```

*   [usingBash](usingBash.md)

    [Filling Arrays](usingbash.md#filling-arrays)
    ```sh
    #!/bin/bash

    arr=(Alpha Bravo Charlie Delta Echo)
    unset arr[1]

    echo "Array arr[1]: ${arr[1]}"                  # (blank)
    echo "Array arr all: ${arr[@]}"                 # Alpha Charlie Delta Echo
    echo "Array arr length: ${#arr[@]}"             # 4
    echo "Array arr elements filled: ${!arr[@]}"    # 0 2 3 4
    ```
    [Randomizing Numbers](usingbash.md#randomizing-numbers)
    ``` console
    sh-3.2$ echo "$(((RANDOM%10)+1))"
    6
    sh-3.2$ echo "$(((RANDOM%10)+1))"
    1
    ```

---
[:top: Top](#top)
