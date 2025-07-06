[org 0x7E00]
[bits 16]

start:

    call output

print:

    mov ah, 0x0E
    .loop:

        lodsb

        test al, al
        jz .done

        int 0x10
        jmp .loop

    .done:
        ;

    ret

output:

    mov si, msg
    call print
    ret

msg db "FAT 12", 0x0