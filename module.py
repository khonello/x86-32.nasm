from typing import NamedTuple

class CHS(NamedTuple):

    c: int
    h: int
    s: int

def chs_lba( chs: CHS) -> int:
    '''
    Converts Cylinder-Head-Sector (CHS) to Logical Block Address (LBA).

    CHS limits:
        - C ∈ [0, 1023]
        - H ∈ [0, 254]
        - S ∈ [1, 63]  (note: Sector starts at 1)

    Standard BIOS geometry:
        - Heads per Cylinder: 255
        - Sectors per Track: 63

    Args:
        c (int): Cylinder
        h (int): Head
        s (int): Sector

    Returns:
        int: Logical Block Address
    '''

    HPC = 255  # Heads per Cylinder
    SPT = 63   # Sectors per Track

    if chs.c > 1023 or chs.h > 254 or chs.s < 1 or chs.s > 63:
        raise ValueError("CHS values out of valid range")

    # Convert using LBA = (C * HPC + H) * SPT + (S - 1)
    lba = ((chs.c * HPC + chs.h) * SPT) + (chs.s - 1)
    return lba

def lba_chs( lba_start: int ):
    '''
    CHS limits: C ≤ 1023, H ≤ 254, S ≤ 63 (S starts at 1). 
        These are the value ranges 
            - C = (0 - 1023)
            - H = (0 - 254)
            - S = (1 - 63)

    These are standard BIOS values for CHS calculation
        Heads Per Cylinder: 255
        Sectors Per Track: 63
        Bytes Per Sector: 512

    To calculate, we must invert the LBA calculation formula

    Args:
        lba_start

    Returns:
        chs (namedtuple): A namedtuple containing 'c' (Cylinder), 'h' (Head), and 's' (Sector).
    '''

    HPC = 255
    SPT = 63

    c = lba_start // ( HPC * SPT )
    h = ( lba_start // SPT ) % HPC
    s = ( lba_start % SPT ) + 1

    chs = CHS(c= c, h= h, s= s)
    if c > 1023 or h > 254 or s > 63:

        raise ValueError("CHS values exceed limits")
    return chs

def shift_and_pack( chs: CHS ):
    '''
    Takes a namedtuple 'chs' containing Cylinder (C), Head (H), and Sector (S) values, and performs the bit-shifting and packing as required for the MBR partition entry.
    
    Args:
        chs (namedtuple): A namedtuple containing 'c' (Cylinder), 'h' (Head), and 's' (Sector).
    
    Returns:
        tuple: A tuple of 3 bytes that represent the packed CHS values for the MBR partition entry.
    '''
    
    c = chs.c
    h = chs.h
    s = chs.s
    
    byte1 = h
    byte2 = ((c >> 8) & 0x03) << 6 | (s & 0x3F)
    byte3 = c & 0xFF
    
    return (byte1, byte2, byte3)

packed_chs = shift_and_pack(lba_chs( 0x00300008 ))
print(f"Packed CHS values: {packed_chs}")
