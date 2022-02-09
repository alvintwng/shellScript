# shellScript
Shell Scripting notes


*   [01_Bash.md](01_Bash.md)
    ```sh
    bash --version
    ```
    ```sh
    echo $SHELL
    ```
    ```sh
    cat /etc/shells
    ```
    ``` sh
    which bash
    ```
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


*   [note.md](note.md)

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
    ``` sh
    #!/bin/bash
    file="$1" 		# save the first argument as "$file"
    shift 			# drop the first argument from "$@"
    echo "$@" > "$file" 	# write the remaining arguments to "$file"
    ```
    `if` statement
    ```sh
    #!/bin/bash

    if [[ -e source.txt ]] ; then
      cp source.txt destination.txt
    fi
    ```
    ``` sh
    # First build a function that simply returns the code given
    returns() { return $*; }

    # Then use read to prompt user to try it out.
    read -p "Exit code:" exit

    if (returns $exit)
      then echo "true, $?"
      else echo "false, $?"
    fi
    ```
  
    ```sh
    while [[ -e wait.txt ]] ; do
      sleep 3 # "sleep" for three seconds
    done    
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


---
