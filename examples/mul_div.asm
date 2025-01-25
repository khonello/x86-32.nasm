; div and mul
section .rodata
    d_frmt db "Division quotient %d and remainder %d", 10, 0
    m_frmt db "Multiplication result %d", 10, 0

section .text
    global main
    extern printf

main:
    call div_func
    add esp, 12

    call mul_func
    add esp, 8

    mov eax, 1
    xor ebx, ebx
    
    int 0x80

div_func:

    push ebp
    mov ebp, esp

    xor edx, edx

    mov dword eax, 17
    mov dword ecx, 4
    div ecx

    push dword edx
    push dword eax
    push d_frmt

    call printf

    mov esp, ebp
    pop ebp
    ret

mul_func:
    
    push ebp
    mov ebp, esp

    xor edx, edx

    mov dword eax, 5
    mov dword ecx, 4
    mul ecx

    push eax
    push m_frmt

    call printf

    mov esp, ebp
    pop ebp
    ret