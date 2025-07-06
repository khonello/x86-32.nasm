# Guide to FAT File Systems

## Overview

The **File Allocation Table (FAT)** is one of the oldest and most widely supported file systems. Despite its age, FAT remains crucial for bootloaders, embedded systems, and removable media due to its simplicity and universal compatibility.

## FAT Variants Comparison

### FAT12
- **Introduced:** 1977 (with MS-DOS 1.0)
- **Cluster Size:** 12-bit entries
- **Maximum Capacity:** 32 MB
- **Maximum File Size:** 32 MB
- **Typical Use:** Floppy disks (1.44 MB), very small embedded systems
- **System IDs:** `0x01`
- **Status:** Legacy, rarely used today

### FAT16
- **Introduced:** 1987 (with MS-DOS 3.0)
- **Cluster Size:** 16-bit entries
- **Maximum Capacity:** 2 GB (with 512-byte sectors), 4 GB (with larger sectors)
- **Maximum File Size:** 2 GB
- **Typical Use:** Old hard drives, some embedded systems, small USB drives
- **System IDs:** 
  - `0x04` - FAT16 (< 32 MB, CHS)
  - `0x06` - FAT16 (≥ 32 MB, CHS)
  - `0x0E` - FAT16 (LBA addressing)
- **Status:** Legacy, limited use

### FAT32
- **Introduced:** 1996 (with Windows 95 OSR2)
- **Cluster Size:** 28-bit entries (32-bit with 4 bits reserved)
- **Maximum Capacity:** 2 TB (Windows limit), 16 TB (theoretical)
- **Maximum File Size:** 4 GB
- **Typical Use:** USB drives, SD cards, external drives, digital cameras
- **System IDs:**
  - `0x0B` - FAT32 (CHS addressing)
  - `0x0C` - FAT32 (LBA addressing) **← Recommended**
- **Status:** Current standard for removable media

### exFAT (Extended FAT)
- **Introduced:** 2006 (with Windows CE 6.0)
- **Cluster Size:** 64-bit entries
- **Maximum Capacity:** 128 PB (theoretical)
- **Maximum File Size:** 128 PB
- **Typical Use:** Large USB drives, SD cards > 32GB, digital cameras (4K video)
- **System IDs:** `0x07` (shares with NTFS)
- **Status:** Modern standard for large removable media

## System ID Reference Table

| System ID | File System | Addressing | Capacity Range | Modern Use |
|-----------|-------------|------------|----------------|------------|
| `0x01` | FAT12 | CHS | Up to 32 MB | Floppy disks only |
| `0x04` | FAT16 | CHS | < 32 MB | Legacy systems |
| `0x06` | FAT16 | CHS | 32 MB - 2 GB | Legacy systems |
| `0x07` | NTFS/exFAT | LBA | Variable | Windows/Large media |
| `0x0B` | FAT32 | CHS | 512 MB - 2 TB | Legacy FAT32 |
| **`0x0C`** | **FAT32** | **LBA** | **512 MB - 2 TB** | **Recommended** |
| `0x0E` | FAT16 | LBA | 32 MB - 2 GB | Modern FAT16 |

## Addressing Methods

### CHS (Cylinder-Head-Sector)
- **Legacy method** used in older systems
- **Limitations:** 
  - 1024 cylinders max
  - 256 heads max  
  - 63 sectors per track max
  - **Total limit:** ~8.4 GB
- **Formula:** `LBA = (C × heads_per_cylinder + H) × sectors_per_track + (S - 1)`

### LBA (Logical Block Addressing)
- **Modern method** for addressing sectors
- **Advantages:**
  - No geometry limitations
  - Supports drives of any size
  - Direct sector addressing
  - Simpler calculations
- **Formula:** Direct sector number (0-based)

## Bootloader Considerations

### For MBR Bootloaders

When choosing FAT for bootloader partitions:

```assembly
; Recommended for modern bootloaders
db 0x0C                     ; FAT32 (LBA addressing)
dd 0x00000008               ; LBA start sector
```

### Compatibility Matrix

| System | FAT12 | FAT16 | FAT32 | exFAT |
|--------|-------|-------|-------|-------|
| MS-DOS | ✓ | ✓ | ✗ | ✗ |
| Windows 9x | ✓ | ✓ | ✓ | ✗ |
| Windows NT+ | ✓ | ✓ | ✓ | ✓ |
| Linux | ✓ | ✓ | ✓ | ✓* |
| macOS | ✓ | ✓ | ✓ | ✓* |
| Embedded | ✓ | ✓ | ✓ | ✗ |

*_Requires additional drivers or kernel support_

## Technical Structure

### FAT Table Structure
```
[Boot Sector] [FAT 1] [FAT 2] [Root Directory] [Data Area]
```

### Boot Sector Layout (First 512 bytes)
- **Bytes 0-2:** Jump instruction
- **Bytes 3-10:** OEM name
- **Bytes 11-12:** Bytes per sector (usually 512)
- **Byte 13:** Sectors per cluster
- **Bytes 14-15:** Reserved sectors
- **Byte 16:** Number of FATs (usually 2)
- **And more...**

### Cluster Allocation
- **FAT12:** 2-4 KB clusters
- **FAT16:** 4-32 KB clusters  
- **FAT32:** 4-32 KB clusters
- **exFAT:** 4 KB - 32 MB clusters

## Best Practices

### For Bootloader Development
1. **Use FAT32-LBA (0x0C)** for partitions 512MB+
2. **Align partitions** to 4KB boundaries for SSD performance
3. **Reserve sectors 1-7** for bootloader code
4. **Place file system** starting at sector 8 or higher

### For System Compatibility
1. **FAT32** for maximum compatibility across all systems
2. **exFAT** only for large files (>4GB) or large drives (>32GB)
3. **Avoid FAT12/FAT16** unless specifically required

### For Performance
1. **Choose appropriate cluster size** based on typical file sizes
2. **Minimize fragmentation** by pre-allocating space
3. **Use LBA addressing** for modern drives
4. **Align to physical sector boundaries** (4KB for SSDs)

## Modern Usage Guidelines

### When to Use Each FAT Variant

**FAT32 (0x0C):**
- USB drives and SD cards
- Digital camera storage
- Bootloader partitions
- Cross-platform compatibility needed
- Files under 4GB

**exFAT (0x07):**
- Large USB drives (>32GB)
- 4K video recording
- Files larger than 4GB
- Modern devices only

**FAT16/FAT12:**
- Legacy system support
- Embedded systems with limited resources
- Floppy disk emulation

## Conclusion

While FAT file systems are considered legacy, they remain essential for:
- **Bootloader development** due to simplicity
- **Embedded systems** with resource constraints  
- **Universal compatibility** across all operating systems
- **Removable media** that needs to work everywhere

For modern bootloader development, **FAT32 with LBA addressing (System ID 0x0C)** provides the best balance of compatibility, capacity, and performance.