; basic intro
section .data

    msg db "Hello World", 0xA
    len equ $ - msg

section .text
    
    global _start

_start:

    push len
    push msg
    call func

func:
    push ebp
    mov ebp, esp

    mov eax, 4
    mov ebx, 1
    mov ecx, [ebp + 8]
    mov edx, [ebp + 12]
    int 0x80

    add esp, 8

    mov eax, 1
    int 0x80

    mov esp, ebp
    pop ebp
    ret