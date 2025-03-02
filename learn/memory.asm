section .data
    
    stack_msg db "argument is %d and local variable is %d", 0xA, 0x0
    heap_msg db "old break is %p, value stored in the heap %u and new break is %p", 0xA, 0x0

    error_msg db "error in heap allocation", 0xA, 0x0

section .bss
    
    old_brk resd 1
    new_brk resd 1

section .text

    global main
    extern printf

main:

    call memory_func
    jmp exit

memory_func:

    push ebp
    mov ebp, esp

    ; push 5
    ; call stack_func
    
    ; add esp, 4                    ; clean up the stack after call

    call heap_func

    mov esp, ebp
    pop ebp
    ret

stack_func:
    ; stack memory

    push ebp
    mov ebp, esp

    sub esp, 4
    mov dword [ebp - 4], 4

    push dword [ebp - 4]          ; local variable
    push dword [ebp + 8]          ; argument
    push stack_msg

    call printf
    add esp, 12

    mov esp, ebp
    pop ebp 
    ret

heap_func:
    ; heap memory

    push ebp
    mov ebp, esp

    mov eax, 45                     ; sys_brk
    xor ebx, ebx                    ; 0 to get current break
    int 0x80

    mov edx, eax
    cmp edx, -1
    je debug                        ; if the return break is 0xFFFFFFFF, which in unsigned is -1, we compare it with -1 and if zero, we jump to debug

    mov [old_brk], eax

    mov eax, 45
    mov ebx, [old_brk]
    add ebx, 0x1000                 ; allocate 4KB
    int 0x80
    
    mov edx, eax
    cmp edx, -1
    je debug

    mov [new_brk], eax
    
    push dword [old_brk]
    pop dword edi

    mov byte [edi + 4], 255        ; write to the allocated memory

    push dword [new_brk]
    push dword [edi + 4]
    push dword [old_brk]
    push heap_msg

    call printf                     ; print old and new breaks
    add esp, 16

    mov eax, 45
    mov ebx, [old_brk]              ; free the allocated memory
    int 0x80
    
    mov esp, ebp
    pop ebp
    ret

debug:

    push error_msg
    call printf
    add esp, 4

    jmp exit

exit:

    mov eax, 1
    xor ebx, ebx
    int 0x80