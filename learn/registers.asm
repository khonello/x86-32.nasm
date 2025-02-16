section .rodata
    ;

section .bss
    ;

section .text

    global main
    extern printf

main:

    mov eax, 1
    xor ebx, ebx
    int 0x80