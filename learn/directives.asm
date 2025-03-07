[bits 32]

%include "/mnt/c/Users/Khonello/Documents/Developer/Languages/Assembly/learn/includes/constants.inc"
%include "/mnt/c/Users/Khonello/Documents/Developer/Languages/Assembly/learn/includes/macros.inc"

%define MAIN 1
%define START 0

%macro PRINT_MACRO 1

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, %1
    mov edx, %1_len

    int 0x80
%endmacro

%if MAIN

    %define ENTRY main
%else
    %define ENTRY _start
%endif

section .rodata

    .alignment:

        var1 dw 0x1234                  ; 16 bit

        align 4                         ; align `var2` to 4 byte boundary
        var2 dd 0x12345678

        zeros times 4 db 0              ; array of 4 zeros

    .data:

        msg db "Hello, World!", 0xA, 0x0
        msg_len equ $ - msg

        array_frmt db "data is %d", 0xA, 0x0

    .directive:

        array:
            %assign i 0
            %rep 10

                db i
                %assign i i + 1
            %endrep

    times 512 - ($ - $$) nop
    
section .bss
    ;

section .text

    global ENTRY
    extern printf

ENTRY:

    PRINT_MACRO msg

    mov esi, array
    movzx eax, byte [esi + 2]
    
    push eax
    push array_frmt
    call printf
    
    add esp, 8

    times 10 nop
    jmp exit

exit:
    EXIT_MACRO
