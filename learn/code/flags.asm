section .rodata

    source db "khonello", 0xA, 0x0             ; "khonello\n\0"
    len equ 2

section .bss

    destination resb 4

section .text
    global main
    extern printf

main:
    call flag_func

; flag
flag_func:

    push ebp
    mov ebp, esp
    
    .arithmetic_label:

        .cf_label:
            ; carry flag. unsigned operation
            mov al, 0xFF                    ; carry
            add al, 1
            ; jc exit

            mov al, 0x01                    ; borrow
            sub al, 2
            ; jc exit

        .of_label:
            ; overflow flag. signed operation
            mov al, -128
            sub al, 1
            ; jo exit

    .status_label:

        .zf_label:
            ; zero flag
            xor ebx, ebx
            ; jz exit

        .sf_label:
            ; signed flag
            mov al, 128
            test al, al         ; set when the value is negative ( signed context ) after an arithmetic and logical operation
            ; js exit

        .pf_label:
            ; parity flag
            mov al, 3          ; parity flag is set if the value has even number of bits ( LSBs ) after an arithmetic and logical operation
            test al, al
            ; jp exit

    .control_label:

        .if_label:
            ; interrupt enable flag

            ; NMIs (Non-Maskable Interrupts) are unaffected by the IF flag.
            ; MIs (Maskable Interrupts) are interrupt that can be ignored by the CPU

            ; clear interrupt enable flag (IF = 0). All MIs are ignored by the CPU
            ; cli

            ; set interrupt enable flag (IF = 1)
            ; sti

        .df_label:
            ; direction flag. increment or decrement the source and destination together

            ; clear direction flag
            ; forward copy          ++
            cld

            mov ecx, len

            mov esi, source
            mov edi, destination

            rep movsb                   ; decrement ecx after every iteration, rep stops when ecx is zero

            ; set direction flag
            ; backward copy         --
            std

            mov ecx, len

            lea esi, [source + 9]        ; 9th index being \0
            lea edi, [destination + 3]   ; 3rd index being  null

            rep movsb

            cld

            ; push destination
            ; call printf

            jmp exit

        .id_label:
            ; cpu identification flag
            ; i don't think i will ever need this

        .tf_label:
            ; trap flag
            ; for debugging uses. which i am currently not interested in!

        .rf_label:
            ; resume flag
            ; aids trap flag for debugging uses. which i am currently not interested in!

    .eflag_label:
        ; pushing, modifying and popping EFLAG (32 bit) register from and to the stack
        pushfd          ; push flag doubleworld (32 bit).
        pop eax
        ; xor eax, eax    ; set all flags to zero
        push eax
        popfd

    mov esp, ebp
    pop ebp
    ret

exit:

    mov eax, 1
    xor ebx, ebx

    int 0x80
    