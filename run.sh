#!/bin/bash

if [ "$#" -eq 0 ]; then

    echo "Usage: $0 <filename>"
    exit 1
else

        filename="$1"
        filepath=$(find . -type f -name "$filename")

        if [[ ! -e "$filepath" ]]; then
                echo "[x] Provide an asm file"
                exit 1
        else
                if [[ "$filepath" =~ .+[.]asm$ ]]; then

                        dirpath=$(dirname "$filepath")
                        basename=$(basename "$filepath")
                        without_ext="${basename%.*}"

                        echo "[√] Compiling object file..."
                        cd "$dirpath"
                        nasm -f elf32 -o "$without_ext.o" "$basename"

                        if [[ $? -eq 0 ]]; then

                                # ld -m elf_i386 -s -o "$without_ext" "$without_ext.o"
                                gcc -m32 "$without_ext.o" -o "$without_ext" 2> /dev/null
                                echo "[√] Done"

                                "./$without_ext"
                                rm "$without_ext.o" "$without_ext"
                                cd - > /dev/null

                        else
                                echo "[x] Compiling failed"
                                exit 1
                        fi

                else
                        echo "[x] File is not supported"
                        exit 1
                fi
        fi
fi