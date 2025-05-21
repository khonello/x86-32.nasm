; sample LBA value: 0x00300008
section .data

    c dw 0xC3
    h db 0xCF
    s db 0x15

    bytes_msg db "first byte: %d, second byte: %d and third byte: %d", 0xA, 0x0

section .bss

    bytes resb 0x03

section .text

    global main
    extern printf

main:

    call print_bytes

    mov eax, 0x1
    xor ebx, ebx

    int 0x80

compute_byte1:

    ; first byte is the head
    push ebp
    mov ebp, esp

    xor eax, eax

    mov al, [h]
    mov [bytes], al
    
    mov esp, ebp
    pop ebp
    ret

compute_byte2:

    ; second byte is the upper 2 bits of the cylinder and the sector which is 6 bits
    push ebp
    mov ebp, esp

    xor eax, eax

    mov ax, [c]
    
    shr ax, 0x08
    and ax, 0x03

    shl ax, 0x06

    xor bx, bx

    mov bl, [s]
    and bl, 0x3F

    or ax, bx

    mov [bytes + 1], al
    
    mov esp, ebp
    pop ebp
    ret

compute_byte3:

    ; third byte is the lower 8 bits of the cylinder
    push ebp
    mov ebp, esp

    xor eax, eax

    mov ax, [c]
    and ax, 0xFF

    mov [bytes + 2], al
    
    mov esp, ebp
    pop ebp
    ret

print_bytes:

    push ebp
    mov ebp, esp
    
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx

    call compute_byte1
    call compute_byte2
    call compute_byte3

    mov al, [bytes + 2]
    mov bl, [bytes + 1]
    mov cl, [bytes]
    
    push eax
    push ebx
    push ecx
    push bytes_msg

    call printf
    add esp, 16

    mov esp, ebp
    pop ebp
    ret