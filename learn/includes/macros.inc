%macro EXIT_MACRO 0

    mov eax, SYS_EXIT
    xor ebx, ebx

    int 0x80
%endmacro
