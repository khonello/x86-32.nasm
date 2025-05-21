[org 0x7C00]
[bits 16]

start:

    mov ah, 0x00
    mov al, 0x03

    int 0x10

    mov ax, 0x0500
     
    cli                                     ; disable interrupts
    mov ss, ax                              ; SS is the segment register ( determining the base address ), while SP is the offset within that segment
    mov sp, 0x7BFF                          ; SP is offset for the SS
    sti                                     ; enable interrupts

    xor ax, ax

    mov ds, ax
    mov es, ax

    call output_mbr
    jmp $

output_mbr:

    mov si, mbr_msg
    call print
    ret

output_error:

    mov si, error_msg
    call print
    ret

print:

    mov ah, 0x0E                            ; tty
    .loop:

        lodsb
        test al, al

        jz done
        int 0x10                            ; video services

        jmp .loop

done:
    mov ah, 0x02

    mov dh, 0x01
    mov dl, 0x00

    int 0x10
    ret


mbr_msg db "MBR loaded successfully...", 0x0
error_msg db "Error", 0x0

times 446 - ( $ - $$ ) db 0x00

; partition entry
db 0x80                     ; Bootable
db 0x00, 0x09, 0x00         ; CHS start
db 0x83                     ; System ID: Linux
db 0xFE, 0xFF, 0xFF         ; CHS end
dd 0x00000008               ; LBA                                   ; LBA start should be divisible by 8. 8 sectors making 4 KB which is the physical sector size for SSD
dd 0x00200000               ; Number of Sector                      ; 1 GB

db 0x00                     ; Not Bootable
db 0x8A, 0x11, 0x82
db 0x07                     ; System ID: NTFS
db 0xFE, 0xFF, 0xFF
dd 0x00200008               ; 0x00000008 + 0x00200000 = 0x00200008
dd 0x00100000               ;                                       ; 512 MB

db 0x00
db 0xCF, 0x15, 0xC3
db 0x05
db 0xFE, 0xFF, 0xFF
dd 0x00300008               ; 0x00200008 + 0x00100000 = 0x00300008
dd 0x00080000               ;                                       ; 256 MB

db 0x00
db 0x00, 0x00, 0x00
db 0x00
db 0xFE, 0xFF, 0xFF
dd 0x00000000
dd 0x00000000

dw 0xAA55