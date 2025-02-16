section .data
    ; db - Define Byte ( 8 Bits )
    singlebyte      db 1
    arraybyte       db 1, 2, 3
    charbyte        db "Hello", 0xa

    ; dw - Define Word ( 16 Bits )
    singleword      dw 512
    arrayword       dw 512, 1024, 2048

    ; dd - Define DoubleWord ( 32 Bits )
    doubleword      dd 65536
    arraydouble     dd 65536, 131072, 196608
    
    singlepi        dd 3.402823466e+38

    ; dq - Define QuadWord ( 64 Bits )
    quadword        dd 4294967295
    arrayquad       dd 4294967295, 

    doublepi        dt 3.402823466e+39

section .text
    global _start

_start:
    
    mov eax, 1
    int 0x80