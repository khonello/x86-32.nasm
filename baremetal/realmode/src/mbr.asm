[org 0x7C00]
[bits 16]

start:

    ; clear screen
    mov ah, 0x00
    mov al, 0x03

    int 0x10

    ; setup segments
    mov ax, 0x0500
     
    cli                                     ; disable interrupts
    mov ss, ax                              ; SS is the segment register ( determining the base address ), while SP is the offset within that segment
    mov sp, 0x7BFF                          ; SP is offset for the SS
    sti                                     ; enable interrupts

    xor ax, ax

    mov ds, ax
    mov es, ax
    ; end segment
    
    call output_msg
    jmp load_vbr

load_vbr:
    
    ; load second stage bootloader
    xor bx, bx
    jmp extended_read                           ; this is intentional
    
    normal_read:                                ; uses chs calculation though limited to 8GB

        mov ah, 0x02                            ; read sectors. using normal read
        mov al, 0x01                            ; sectors to read
        mov ch, 0x00
        mov cl, 0x02                            ; starting sector, sectors are 1 based meaning they start from 1
        mov dh, 0x00
        mov dl, 0x80                            ; 0x80 means hard disk and 0x00 means floppy

        mov es, bx
        mov bx, 0x7E00

        int 0x13                                ; disk services
        jc disk_error

    extended_read:                              ; uses LBA read. not limited to 8GB

        mov si, dap_packet
        mov dl, 0x80                            ; DL = first HDD ( BIOS drive number )
        mov ah, 0x42                            ; read sectors. using extended read

        int 0x13                                ; disk services
        jc disk_error

    jmp 0x0000:0x7E00

output_msg:

    mov si, success_msg
    call print
    ret

disk_error:

    mov si, error_msg
    call print
    ret

print:

    mov ah, 0x0E                            ; tty
    .loop:

        lodsb
        test al, al

        jz .done
        int 0x10                            ; video services

        jmp .loop

    .done:

        mov ah, 0x02

        mov dh, 0x01
        mov dl, 0x00

        int 0x10
    ret

success_msg db "MBR loaded successfully...", 0x0
error_msg db "Error loading VBR", 0x0

buffer equ 0x7E00
dap_packet:

    db 0x10                             ; size of packet ( 16 bytes )
    db 0x00                             ; reserved
    dw 0x0001                           ; number of sectors to read
    dw buffer                           ; offset from base segment
    dw 0x0000                           ; base segment
    dd 0x00000001                       ; lower 32-bits of LBA start
    dd 0x00000000                       ; upper 32-bits of LBA start

times 446 - ( $ - $$ ) db 0x00

; partition entry
db 0x80                     ; Bootable
db 0x00, 0x09, 0x00         ; CHS start
db 0x0C                     ; System ID: FAT32 with LBA addressing
db 0xFE, 0xFF, 0xFF         ; CHS end
dd 0x00000001               ; LBA                                   ; LBA start should be divisible by 8. 8 sectors making 4 KB which is the physical sector size for SSD
dd 0x00200000               ; Number of Sector                      ; 1 GB

db 0x00                     ; Not Bootable
db 0x8A, 0x11, 0x82
db 0x07                     ; System ID: NTFS
db 0xFE, 0xFF, 0xFF
dd 0x00200001               ; 0x00000001 + 0x00200000 = 0x00200001
dd 0x00100000               ;                                       ; 512 MB

db 0x00
db 0x00, 0x00, 0x00
db 0x00
db 0xFE, 0xFF, 0xFF
dd 0x00000000
dd 0x00000000

db 0x00
db 0x00, 0x00, 0x00
db 0x00
db 0xFE, 0xFF, 0xFF
dd 0x00000000
dd 0x00000000

dw 0xAA55
