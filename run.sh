#!/bin/bash

if [ "$#" -eq 0 ]; then

    echo -e "\e[38;2;255;0;0mUsage: $0 <filename>\e[0m"
    exit 1
else

        filename="$1"
        filepath=$(find . -type f -name "$filename")

        if [[ ! -e "$filepath" ]]; then
                echo -e "\e[38;2;255;0;0m[x] File '$filename' does not exist\e[0m"
                exit 1
        else
                if [[ "$filepath" =~ .+[.]asm$ ]]; then

                        dirpath=$(dirname "$filepath")
                        basename=$(basename "$filepath")

                        without_ext="${basename%.*}"

                        echo -e "\e[38;2;243;143;0m[√] Compiling object file...\e[0m"
                        cd "$dirpath"

                        if [[ ! "$dirpath" =~ "baremetal" ]]; then
                                
                                nasm -f elf32 "$basename" -o "$without_ext.o"
                                if [[ $? -eq 0 ]]; then

                                        echo -e "\e[38;2;243;143;0m[√] Linking using gcc (32-bit) to access CRT. Entry should be main\e[0m"
                                        gcc -m32 "$without_ext.o" -o "$without_ext" 2> /dev/null

                                        if [[ $? -eq 0 ]]; then

                                                echo -e "\e[38;2;243;143;0m[√] Done\e[0m\n"
                                        else
                                                echo -e "\e[38;2;255;0;0m[x] Linking failed. Can't link using gcc. Entry is _start\e[0m"
                                                echo -e "\e[38;2;243;143;0m[√] Linking using ld\e[0m\n"
                                                
                                                ld -m elf_i386 -s -o "$without_ext" "$without_ext.o"
                                        fi
                                        
                                        ./"$without_ext"

                                        rm "$without_ext.o" "$without_ext"
                                        cd - > /dev/null
                                else
                                        echo -e "\e[38;2;255;0;0m[x] Compiling failed...\e[0m"
                                        exit 1
                                fi
                        
                        else
                                
                                mbr_file=$(find /mnt/c/Users/Khonello/Documents/Developer/Languages/Assembly/baremetal/realmode/src -type f -iname "mbr.asm")
                                vbr_file=$(find /mnt/c/Users/Khonello/Documents/Developer/Languages/Assembly/baremetal/realmode/src -type f -iname "fat12.asm")
                                src_dirpath=$(dirname "$mbr_file")

                                nasm -f bin "$mbr_file" -o "${mbr_file%.asm}.bin"
                                nasm -f bin "$vbr_file" -o "${vbr_file%.asm}.bin"

                                # seek implies to move forward by bs * seek in output file before write
                                # count implies bs * count to copy from `if` to `of`

                                dd if=/dev/zero of=${src_dirpath}/disk.img bs=512 count=2048

                                dd if="${mbr_file%.asm}.bin" of="${src_dirpath}/disk.img" bs=512 conv=notrunc count=1
                                dd if="${vbr_file%.asm}.bin" of="${src_dirpath}/disk.img" bs=512 conv=notrunc count=1 seek=1

                                # dd if=vbr.bin of=disk.img bs=512 conv=notrunc seek=1 count=1
                                # dd if=kernel.bin of=disk.img bs=512 conv=notrunc seek=2

                                qemu-system-i386 -drive file="${src_dirpath}/disk.img",format=raw,index=0,media=disk
                                find "$src_dirpath" -type f \( -iname "*.bin" -o -iname "*.img" \) -exec rm -f {} +

                        fi

                else
                        echo -e "\e[38;2;255;0;0m[x] File is not supported\e[0m"
                        exit 1
                fi
        fi
fi