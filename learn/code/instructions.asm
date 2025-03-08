section .rodata

    ; movement
    source db 0x4B, 0x48, 0x4F, 0x4E, 0x45, 0x4C, 0x4C, 0x4F
    len equ 2

    ; logical
    logical_frmt db "result of logical operation %d", 0xA, 0x0

    ; arithmetic
    mul_frmt db "result of multiplication %d", 0xA, 0x0
    div_frmt db "result of division. quotient %d remainder %d", 0xA, 0x0
    
    msg db "Hello World", 0xA, 0x0

section .bss
    destination resb len

section .text
    global main
    extern printf

main:
    ; call movement_func
    ; call arithmetic_func
    ; call logical_func
    call flow_func
    jmp exit

; movement
movement_func:

    push ebp
    mov ebp, esp

    ; forward copy
    cld

    ; backward copy
    ; std

    mov ecx, len

    lea esi, [source]           ; using [] dereferences but with lea, we are getting the address. useful for computing offset
    lea edi, [destination]

    rep movsb                   ; decrement ecx after every iteration, rep stops when ecx is zero

    mov eax, 4
    mov ebx, 1
    mov ecx, destination
    mov edx, len
    int 0x80

    mov esp, ebp
    pop ebp
    ret

; arithmetic
arithmetic_func:

    push ebp
    mov ebp, esp

    basic_label:
    
        mul_label:

            mov eax, 6                   ; result will be in eax:edx
            mov ecx, 4

            mul ecx
            push dword eax
            push mul_frmt

            call printf
            add esp, 8

        div_label:

            mov eax, 7                  ; result will be in eax:edx
            mov ecx, 2

            div ecx
            push dword edx
            push dword eax
            push div_frmt

            call printf
            add esp, 12

    comparison_label:

        cmp_label:

            mov al, 5
            cmp al, 3                   ; 5 - 3. if negative then left is lesser than right else if positive then left is greater than right

            ; jg test_label

        test_label:

            mov al, 0
            test al, al                 ; performs bitwise AND and sets zero flag if zero. does not modify destination register

            ; jz exit

    mov esp, ebp
    pop ebp
    ret

; logical
logical_func:
    
    push ebp
    mov ebp, esp

    bitwise_label:

        mov eax, 0xFF

        shl eax, 8
        or al, 0xFF

        push word ax
        push logical_frmt
        call printf

        add esp, 8

    mov esp, ebp
    pop ebp
    ret

; flow
flow_func:

    push ebp
    mov ebp, esp

    jump_label:
        
        unconditional_label:
            jmp conditional_label

        conditional_label:

            xor al, al
            je exit                         ; same as jz

    loop_label:

        mov ecx, 2
        ; default_label:

        ;     push ecx                      ; save ecx because printf does not preserve ecx register
        ;     push msg
        ;     call printf

        ;     add esp, 4
        ;     pop ecx

        ;     loop default_label

        ; .jump_label:

        ;     push ecx
        ;     push msg
        ;     call printf

        ;     add esp, 4
        ;     pop ecx

        ;     dec ecx
        ;     jne .jump_label

    mov esp, ebp
    pop ebp
    ret

exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80