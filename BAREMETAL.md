# Real Mode

## Segment Registers

In real mode, registers are `16 Bits` including segments registers. Physical memory is `20 Bits` which is equivalent to `1 MB`. The `Segment` is the `Base`. <br>
- `CS` stores instructions pairs with `IP` as offset 
- `DS` stores data defined pairs with `SI` as offset and sometimes `BX`
- `SS` stores data pushed onto the stack pairs with `BP` and `SP` 
- `ES` holds destination for memory operations pairs with `DI` as offset

The `Base` and the `Offset` are each `16 Bits`. <br>
Physical Address = (`Base` << `4` ) + `Offset`. <br><br>
Base and Offset both ranges `From` 0x0000 `To` 0xFFFF which is `16 Bits` each.

## Interrupts
- **Hardware Interrupts**

#### CPU Exceptions
<table>
  <tr>
    <th style="width: 100px;">INT #</th>
    <th style="width: 300px;">Name</th>
    <th style="width: 600px;">Parameters</th>
    <th style="width: 600px;">Return Status</th>
    <th style="width: 600px;">Description</th>
  </tr>
  <tr>
    <td>0x00</td>
    <td>Divide Error</td>
    <td>None</td>
    <td>None</td>
    <td>Raised when there is a division by zero</td>
  </tr>
  <tr>
    <td>0x01</td>
    <td>Debug Exception</td>
    <td>None</td>
    <td>None</td>
    <td>Triggered for single step debugging operations</td>
  </tr>
  <tr>
    <td>0x02</td>
    <td>NMI Interrupt</td>
    <td>None</td>
    <td>None</td>
    <td>Non-maskable interrupt triggered by hardware</td>
  </tr>
  <tr>
    <td>0x03</td>
    <td>Breakpoint</td>
    <td>None</td>
    <td>None</td>
    <td>Invoked during debugging to signal breakpoints</td>
  </tr>
  <tr>
    <td>0x04</td>
    <td>Overflow</td>
    <td>None</td>
    <td>None</td>
    <td>Occurs when the INTO instruction is executed with OF flag set</td>
  </tr>
  <tr>
    <td>0x05</td>
    <td>Bound Range Exceeded</td>
    <td>None</td>
    <td>None</td>
    <td>Raised when BOUND instruction finds value out of range</td>
  </tr>
  <tr>
    <td>0x06</td>
    <td>Invalid Opcode</td>
    <td>None</td>
    <td>None</td>
    <td>Occurs when an invalid opcode is encountered</td>
  </tr>
  <tr>
    <td>0x07</td>
    <td>Device Not Available</td>
    <td>None</td>
    <td>None</td>
    <td>Triggered when a floating-point or WAIT instruction is executed</td>
  </tr>
  <tr>
    <td>0x08</td>
    <td>Double Fault</td>
    <td>None</td>
    <td>None</td>
    <td>Raised when an exception occurs during exception handler</td>
  </tr>
  <tr>
    <td>0x09</td>
    <td>Coprocessor Segment Overrun</td>
    <td>None</td>
    <td>None</td>
    <td>Reserved (not used since i386)</td>
  </tr>
  <tr>
    <td>0x0A</td>
    <td>Invalid TSS</td>
    <td>None</td>
    <td>None</td>
    <td>Raised when a task switch to a segment with an invalid TSS</td>
  </tr>
  <tr>
    <td>0x0B</td>
    <td>Segment Not Present</td>
    <td>None</td>
    <td>None</td>
    <td>Triggered when loading a segment register with a null selector</td>
  </tr>
  <tr>
    <td>0x0C</td>
    <td>Stack-Segment Fault</td>
    <td>None</td>
    <td>None</td>
    <td>Occurs on stack operations when stack segment is not present</td>
  </tr>
  <tr>
    <td>0x0D</td>
    <td>General Protection</td>
    <td>None</td>
    <td>None</td>
    <td>Raised for various protection violations</td>
  </tr>
  <tr>
    <td>0x0E</td>
    <td>Page Fault</td>
    <td>None</td>
    <td>None</td>
    <td>Occurs when a page is not present in memory during address translation</td>
  </tr>
  <tr>
    <td>0x0F</td>
    <td>Reserved</td>
    <td>None</td>
    <td>None</td>
    <td>Reserved by Intel</td>
  </tr>
  <tr>
    <td>0x10</td>
    <td>x87 FPU Error</td>
    <td>None</td>
    <td>None</td>
    <td>Indicates a floating point error occurred</td>
  </tr>
  <tr>
    <td>0x11</td>
    <td>Alignment Check</td>
    <td>None</td>
    <td>None</td>
    <td>Raised for misaligned memory access (if enabled)</td>
  </tr>
  <tr>
    <td>0x12</td>
    <td>Machine Check</td>
    <td>None</td>
    <td>None</td>
    <td>Indicates a machine check error occurred</td>
  </tr>
  <tr>
    <td>0x13</td>
    <td>SIMD Floating-Point Exception</td>
    <td>None</td>
    <td>None</td>
    <td>Triggered by errors in SSE/SSE2/SSE3 instructions</td>
  </tr>
</table>

- **BIOS Interrupts**

#### Video Services `INT 0x10`
<table>
  <tr>
    <th style="width: 100px;">AH</th>
    <th style="width: 300px;">Name</th>
    <th style="width: 600px;">Parameters</th>
    <th style="width: 600px;">Return Status</th>
    <th style="width: 600px;">Description</th>
  </tr>
  <tr>
    <td>0x00</td>
    <td>Set Video Mode</td>
    <td>AL = video mode</td>
    <td>None</td>
    <td>Changes the video mode of the display</td>
  </tr>
  <tr>
    <td>0x01</td>
    <td>Set Cursor Shape</td>
    <td>CH = start line, CL = end line</td>
    <td>None</td>
    <td>Modifies the appearance of the text cursor</td>
  </tr>
  <tr>
    <td>0x02</td>
    <td>Set Cursor pos</td>
    <td>DH = row, DL = col, BH = page number</td>
    <td>None</td>
    <td>Moves the cursor to a specified pos</td>
  </tr>
  <tr>
    <td>0x03</td>
    <td>Get Cursor pos and Shape</td>
    <td>BH = page number</td>
    <td>CH = start line, CL = end line, DH = row, DL = col</td>
    <td>Retrieves the current cursor pos and shape</td>
  </tr>
  <tr>
    <td>0x04</td>
    <td>Get Light Pen pos</td>
    <td>None</td>
    <td>AH = trigger status, BX = pixel col, CX = pixel row, DH = character row, DL = character col</td>
    <td>Reads the pos of a light pen if avail</td>
  </tr>
  <tr>
    <td>0x05</td>
    <td>Set Active Display Page</td>
    <td>AL = page number</td>
    <td>None</td>
    <td>Selects the active page for text modes</td>
  </tr>
  <tr>
    <td>0x06</td>
    <td>Scroll Up Window</td>
    <td>AL = # of lines, BH = attribute, CH/CL = row/col of upper left, DH/DL = row/col of lower right</td>
    <td>None</td>
    <td>Scrolls a text window upwards</td>
  </tr>
  <tr>
    <td>0x07</td>
    <td>Scroll Down Window</td>
    <td>AL = # of lines, BH = attribute, CH/CL = row/col of upper left, DH/DL = row/col of lower right</td>
    <td>None</td>
    <td>Scrolls a text window downwards</td>
  </tr>
  <tr>
    <td>0x08</td>
    <td>Read character and Attribute</td>
    <td>BH = page number</td>
    <td>AL = character, AH = attribute</td>
    <td>Reads a character and its attribute at cursor pos</td>
  </tr>
  <tr>
    <td>0x09</td>
    <td>Write character and Attribute</td>
    <td>AL = character, BH = page number, BL = attribute, CX = count</td>
    <td>None</td>
    <td>Writes a character with attribute at cursor pos</td>
  </tr>
  <tr>
    <td>0x0A</td>
    <td>Write character Only</td>
    <td>AL = character, BH = page number, CX = count</td>
    <td>None</td>
    <td>Writes a character at cursor pos without changing attribute</td>
  </tr>
  <tr>
    <td>0x0B</td>
    <td>Set Color Palette</td>
    <td>BH = 0 (set border), BH = 1 (set palette), BL = color</td>
    <td>None</td>
    <td>Sets the border color or background color palette</td>
  </tr>
  <tr>
    <td>0x0C</td>
    <td>Write Pixel</td>
    <td>AL = color, CX = col, DX = row</td>
    <td>None</td>
    <td>Writes a pixel at specified coord in graphics mode</td>
  </tr>
  <tr>
    <td>0x0D</td>
    <td>Read Pixel</td>
    <td>CX = col, DX = row</td>
    <td>AL = color</td>
    <td>Reads the color of a pixel at specified coord</td>
  </tr>
  <tr>
    <td>0x0E</td>
    <td>Write character (TTY)</td>
    <td>AL = character, BH = page number, BL = foreground color</td>
    <td>None</td>
    <td>Writes a character and advances cursor like a teletype</td>
  </tr>
  <tr>
    <td>0x0F</td>
    <td>Get Current Video Mode</td>
    <td>None</td>
    <td>AH = number of character cols, AL = video mode, BH = active page</td>
    <td>Returns the current video mode and screen dimensions</td>
  </tr>
</table>

#### Keyboard Services `INT 0x16`
<table>
  <tr>
    <th style="width: 100px;">AH</th>
    <th style="width: 300px;">Name</th>
    <th style="width: 600px;">Parameters</th>
    <th style="width: 600px;">Return Status</th>
    <th style="width: 600px;">Description</th>
  </tr>
  <tr>
    <td>0x00</td>
    <td>Read character</td>
    <td>None</td>
    <td>AH = scan code, AL = ASCII character</td>
    <td>Waits for and reads a character from keyboard</td>
  </tr>
  <tr>
    <td>0x01</td>
    <td>Check for character</td>
    <td>None</td>
    <td>ZF = 0 if character available, AH = scan code, AL = ASCII character</td>
    <td>Checks if a character is available in keyboard buffer</td>
  </tr>
  <tr>
    <td>0x02</td>
    <td>Get Shift Flags</td>
    <td>None</td>
    <td>AL = shift flags</td>
    <td>Returns the current state of modifier keys</td>
  </tr>
  <tr>
    <td>0x03</td>
    <td>Set Typematic Rate</td>
    <td>AL = 0x05, BL = setting</td>
    <td>None</td>
    <td>Sets the keyboard repeat rate and delay</td>
  </tr>
  <tr>
    <td>0x04</td>
    <td>Set Keyboard LED</td>
    <td>AL = LED state</td>
    <td>None</td>
    <td>Controls the state of keyboard LEDs ( Num/Caps/Scroll )</td>
  </tr>
  <tr>
    <td>0x05</td>
    <td>Store Keystroke in Buffer</td>
    <td>CH = scan code, CL = ASCII character</td>
    <td>AL = 0 if successful, 1 if buffer full</td>
    <td>Stores a keystroke in the keyboard buffer</td>
  </tr>
  <tr>
    <td>0x10</td>
    <td>Read Extended character</td>
    <td>None</td>
    <td>AH = scan code, AL = ASCII character</td>
    <td>Reads an extended character from keyboard</td>
  </tr>
  <tr>
    <td>0x11</td>
    <td>Check for Extended character</td>
    <td>None</td>
    <td>ZF = 0 if character available, AH = scan code, AL = ASCII character</td>
    <td>Checks if an extended character is available</td>
  </tr>
  <tr>
    <td>0x12</td>
    <td>Get Extended Shift Flags</td>
    <td>None</td>
    <td>AX = extended shift flags</td>
    <td>Returns extended information about modifier keys</td>
  </tr>
</table>

#### Disk Services `INT 0x13`
<table>
  <tr>
    <th style="width: 100px;">AH</th>
    <th style="width: 300px;">Name</th>
    <th style="width: 600px;">Parameters</th>
    <th style="width: 600px;">Return Status</th>
    <th style="width: 600px;">Description</th>
  </tr>
  <tr>
    <td>0x00</td>
    <td>Reset Disk System</td>
    <td>DL = drive number</td>
    <td>CF set on error, AH = status code</td>
    <td>Resets the disk controller and drive</td>
  </tr>
  <tr>
    <td>0x02</td>
    <td>Read Sector(s)</td>
    <td>AL = sectors to read, CH = cylinder, CL = sector, DH = head, DL = drive, ES:BX = buffer</td>
    <td>CF set on error, AH = status code</td>
    <td>Reads one or more sectors from disk to memory</td>
  </tr>
  <tr>
    <td>0x03</td>
    <td>Write Sector(s)</td>
    <td>AL = sectors to write, CH = cylinder, CL = sector, DH = head, DL = drive, ES:BX = buffer</td>
    <td>CF set on error, AH = status code</td>
    <td>Writes one or more sectors from memory to disk</td>
  </tr>
  <tr>
    <td>0x04</td>
    <td>Verify Sector(s)</td>
    <td>AL = sectors to verify, CH = cylinder, CL = sector, DH = head, DL = drive</td>
    <td>CF set on error, AH = status code</td>
    <td>Verifies readability of one or more sectors</td>
  </tr>
  <tr>
    <td>0x08</td>
    <td>Get Drive Parameters</td>
    <td>DL = drive number</td>
    <td>CF set on error, AH = status code, CH = max cylinder, CL = max sector, DH = max head, DL = number of drives</td>
    <td>Returns drive parameters (heads, cylinders, sectors)</td>
  </tr>
  <tr>
    <td>0x0C</td>
    <td>Seek</td>
    <td>CH = cylinder, DH = head, DL = drive</td>
    <td>CF set on error, AH = status code</td>
    <td>Moves disk head to specified cylinder</td>
  </tr>
  <tr>
    <td>0x15</td>
    <td>Get Disk Type</td>
    <td>DL = drive number</td>
    <td>AH = disk type, CF set if error</td>
    <td>Returns the type of disk drive</td>
  </tr>
  <tr>
    <td>0x41</td>
    <td>Check Extensions Present</td>
    <td>BX = 0x55AA, DL = drive number</td>
    <td>CF clear if supported, BX = 0xAA55, AH = major version, AL = interface support bitmap</td>
    <td>Checks if extended disk functions are available</td>
  </tr>
  <tr>
    <td>0x42</td>
    <td>Extended Read Sectors</td>
    <td>DS:SI = disk address packet, DL = drive number</td>
    <td>CF set on error, AH = status code</td>
    <td>Reads sectors using LBA addressing ( for large disks )</td>
  </tr>
  <tr>
    <td>0x43</td>
    <td>Extended Write Sectors</td>
    <td>DS:SI = disk address packet, DL = drive number</td>
    <td>CF set on error, AH = status code</td>
    <td>Writes sectors using LBA addressing ( for large disks )</td>
  </tr>
</table>

#### BIOS System Services `INT 0x15`
<table>
  <tr>
    <th style="width: 100px;">AH</th>
    <th style="width: 300px;">Name</th>
    <th style="width: 600px;">Parameters</th>
    <th style="width: 600px;">Return Status</th>
    <th style="width: 600px;">Description</th>
  </tr>
  <tr>
    <td>0x00</td>
    <td>Get Memory Size</td>
    <td>None</td>
    <td>AX = KB of memory</td>
    <td>Returns the amount of base memory installed</td>
  </tr>
  <tr>
    <td>0x01</td>
    <td>Get Extended Memory Size</td>
    <td>None</td>
    <td>AX = KB of extended memory</td>
    <td>Returns the amount of extended memory available</td>
  </tr>
  <tr>
    <td>0x02</td>
    <td>Get System Configuration</td>
    <td>None</td>
    <td>Varies</td>
    <td>Retrieves system configuration information</td>
  </tr>
  <tr>
    <td>0x03</td>
    <td>Enable/Disable A20 Line</td>
    <td>AL = 0 (disable), 1 (enable)</td>
    <td>CF set on error, AH = status</td>
    <td>Controls the A20 address line</td>
  </tr>
  <tr>
    <td>0x04</td>
    <td>Power Management Functions</td>
    <td>Varies</td>
    <td>Varies</td>
    <td>Handles various power management operations</td>
  </tr>
  <tr>
    <td>0x05</td>
    <td>APM Installation Check</td>
    <td>None</td>
    <td>CF clear if supported, AH = major version, AL = minor version</td>
    <td>Checks if Advanced Power Management is installed</td>
  </tr>
  <tr>
    <td>0x06</td>
    <td>Get CPU Cache Information</td>
    <td>None</td>
    <td>CF clear if supported, AH = cache information</td>
    <td>Retrieves information about the CPU cache</td>
  </tr>
  <tr>
    <td>0x07</td>
    <td>Get PCI BIOS Information</td>
    <td>None</td>
    <td>CF clear if supported, AH = PCI BIOS version</td>
    <td>Returns information about the PCI BIOS</td>
  </tr>
</table>


## MBR Bootloader

The `MBR` bootloader is the first stage bootloader. It is the first sector which is `512 Bytes` in size.

It is loaded into memory at `0x0000:0x7C00` with `0x7C00` being the offset.
The first sector being `512 Bytes` begins from `0x0000:0x7C00` to `0x0000:0x7C00 + 0x1FF` = `0x0000:0x7DFF`.

> In Real Mode, each sector is `512 Bytes`

### Breakdown of MBR
- The bootloader code is the first `446 Bytes`
```
Assembly

org 0x7C00
bits 16

start:

    ; Clear the screen
    mov ah, 0x00         ; BIOS interrupt to clear screen
    mov al, 0x03         ; Set video mode to 3 (80x25 text)
    int 0x10             ; BIOS interrupt to set video mode

    ; Load next stage bootloader
    mov si, output_msg   ; Load message offset
    call print           ; Call print function

    jmp $                ; Infinite loop to prevent falling through

print:

    ; Print string at DS:SI
    mov ah, 0x0E         ; BIOS teletype function
    mov bh, 0x00         ; Video page

    .loop:
        lodsb                ; Load byte at DS:SI into AL and increment SI

        test al, al          ; Check if character is null (string terminator)
        jz .done             ; Jump to `done` if null

        int 0x10             ; Print character
        jmp .loop

    .done:
        ret

output_msg db "Hello World", 0x0
times 446 - ($ - $$) db nop ; NOP instruction
```
- The partition table is `64 Bytes`. Each partition being `16 Bytes`. <br>
  `Sample Partition`
  - Bootable Flag
  - CHS Start
  - System ID
  - CHS End
  - LBA Start
  - Number of Sectors

### Partition Structure
  Bootable Flag
  - `0x80` = Bootable
  - `0x00` = Not Bootable

  CHS
  - `Cylinder` <br>
    Single track vertical along all platters. `0x0` being the first cylinder. Each platter has two tracks
  - `Head` <br>
    For read and write operations. `0x0` being the first head
  - `Sector` <br>
    A single division of a track. `0x1` being the first sector

  ```
  assembly

  chs db 0x0, 0x0, 0x0
  ```

  ```
  assembly

  ; First Byte:
  ;     Head                                  ==>    8 bits

  ; Second Byte:
  ;     Upper 2 Bits of Cylinder and Sector   ==>    2 Bits and 6 Bits

  ; Third Byte:
  ;     Lower 8 Bits of Cylinder              ==>    8 Bits

  ```

  System ID
  - `0x07` = NTFS
  - `0x83` = Linux
  - `0x05` = Extended

  LBA
  - `0x00000800` = 8192

<table>
  <tr>
    <th style="width: 100px;">Partition #</th>
    <th style="width: 300px;">Offset ( from MBR start )</th>
    <th style="width: 600px;">Size</th>
    <th style="width: 1200px;">Description</th>
  </tr>
  <tr>
    <td>1</td>
    <td>0x1BE (446)</td>
    <td>16 Bytes</td>
    <td>Primary partition</td>
  </tr>
  <tr>
    <td>2</td>
    <td>0x1CE (462)</td>
    <td>16 Bytes</td>
    <td>Primary partition</td>
  </tr>
  <tr>
    <td>3</td>
    <td>0x1DE (478)</td>
    <td>16 Bytes</td>
    <td>Primary partition</td>
  </tr>
  <tr>
    <td>4</td>
    <td>0x1EE (494)</td>
    <td>16 Bytes</td>
    <td>Primary partition</td>
  </tr>
</table>

```
Assembly

; Partition Table ( starts at offset 446 or 0x1BE ) being 64 bytes

; Partition 1
db 0x80              ; Bootable flag
db 0x01, 0x01, 0x00  ; CHS start (head, sector/cylinder high bits, cylinder low bits)
db 0x07              ; System ID (e.g., 0x07 for NTFS)
db 0xFE, 0xFF, 0xFF  ; CHS end
dd 0x00000800        ; LBA start (4 bytes)
dd 0x00020000        ; Number of sectors (4 bytes)

; Partition 2
db 0x00              ; Not bootable
db 0x00, 0x01, 0x01  ; CHS start
db 0x83              ; System ID (e.g., 0x83 for Linux)
db 0xFE, 0xFF, 0xFF  ; CHS end
dd 0x00020800        ; LBA start (4 bytes)
dd 0x00030000        ; Number of sectors (4 bytes)

; Partition 3
db 0x00              ; Not bootable
db 0x00, 0x01, 0x02  ; CHS start
db 0x05              ; System ID (Extended partition)
db 0xFE, 0xFF, 0xFF  ; CHS end
dd 0x00050800        ; LBA start (4 bytes)
dd 0x00040000        ; Number of sectors (4 bytes)

; Partition 4
db 0x00              ; Not bootable
db 0x00, 0x00, 0x00  ; CHS start (unused)
db 0x00              ; System ID (Unused)
db 0x00, 0x00, 0x00  ; CHS end (unused)
dd 0x00000000        ; LBA start (4 bytes)
dd 0x00000000        ; Number of sectors (4 bytes)
```
- The boot signature is `2 Bytes`.
```
Assembly

dw 0xAA55
```

### Full MBR Code

```
Assembly

org 0x7C00
bits 16

start:

    ; Clear the screen
    mov ah, 0x00         ; BIOS interrupt to clear screen
    mov al, 0x03         ; Set video mode to 3 (80x25 text)
    int 0x10             ; BIOS interrupt to set video mode

    jmp load_output

    ; Load second stage bootloader
    mov ah, 0x02         ; BIOS read sector function
    mov al, 0x10         ; Number of sectors to read (16 sectors = 8KB)
    mov ch, 0x00         ; Cylinder 0
    mov cl, 0x02         ; Sector 2 (sectors start from 1, MBR is sector 1)
    mov dh, 0x00         ; Head 0
    mov dl, 0x80         ; Drive number (0x80 for first hard disk)
    
    ; Set buffer address for second stage (typically loaded right after MBR)
    mov bx, 0x0000       ; ES:BX points to the buffer (already set to 0)
    mov es, bx
    mov bx, 0x7E00       ; 0x7E00 = 0x7C00 + 512 (right after MBR)
    
    int 0x13             ; Call BIOS interrupt to read sectors
    jc load_error        ; Jump if carry flag set (error occurred)

    ; Jump to second stage bootloader
    jmp 0x0000:0x7E00    ; Far jump to the loaded second stage

load_error:

    ; Handle load error
    mov si, error_msg
    call print
    jmp $                ; Infinite loop if error

load_output:

    ; Print output message
    mov si, output_msg   ; Load message offset
    call print           ; Call print function
    ret

print:

    ; Print string at DS:SI
    mov ah, 0x0E         ; BIOS teletype function
    mov bh, 0x00         ; Video page number

    .loop:
        lodsb                ; Load byte at DS:SI into AL and increment SI
        
        test al, al          ; Check if character is null (string terminator)
        jz .done             ; If zero (null), exit the function
        int 0x10             ; Call BIOS to print the character in AL
        jmp .loop            ; Continue with next character

    .done:
        ret

error_msg db "Error loading second stage", 0x0
output_msg db "Booting...", 0x0

; Fill the rest of the bootloader with zeros to reach 446 bytes
times 446 - ($ - $$) db 0

; Partition Table (starts at offset 446 / 0x1BE)
; Partition 1
db 0x80              ; Bootable flag
db 0x01, 0x01, 0x00  ; CHS start
db 0x07              ; System ID (NTFS)
db 0xFE, 0xFF, 0xFF  ; CHS end
dd 0x00000800        ; LBA start (4 bytes)
dd 0x00020000        ; Number of sectors (4 bytes)

; Partition 2
db 0x00              ; Not bootable
db 0x00, 0x01, 0x01  ; CHS start
db 0x83              ; System ID (Linux)
db 0xFE, 0xFF, 0xFF  ; CHS end
dd 0x00020800        ; LBA start (4 bytes)
dd 0x00030000        ; Number of sectors (4 bytes)

; Partition 3
db 0x00              ; Not bootable
db 0x00, 0x01, 0x02  ; CHS start
db 0x05              ; System ID (Extended)
db 0xFE, 0xFF, 0xFF  ; CHS end
dd 0x00050800        ; LBA start (4 bytes)
dd 0x00040000        ; Number of sectors (4 bytes)

; Partition 4
db 0x00              ; Not bootable
db 0x00, 0x00, 0x00  ; CHS start
db 0x00              ; System ID (Unused)
db 0x00, 0x00, 0x00  ; CHS end
dd 0x00000000        ; LBA start (4 bytes)
dd 0x00000000        ; Number of sectors (4 bytes)

; Boot signature (last 2 bytes)
dw 0xAA55
```

### Important Topics
Used Areas By MBR
 - `0x00000 – 0x003FF` ( Interrupt Vector Table )
 - `0x00400 – 0x004FF` ( BIOS Data Area )
 - `0x07C00 – 0x07FFF` ( MBR Bootloader )
 - `0xA0000 – 0xBFFFF` ( Video Memory )
 - `0xF0000 – 0xFFFFF` ( BIOS ROM )

Unused Areas for that can be used by Segment
 - `0x0500 – 0x07BFF`    ( Free conventional memory, avoid BIOS Data Area )
 - `0x8000 – 0x9FBFF`    ( Extended free conventional memory )

### Notes
- We do not directly manipulate `IP`, instructions like `jmp 0x0000:0x000A`, `call`, `int` or `ret` modifies it.
- The `CS` stores instructions, it pairs with `IP` as it offset
- The `DS` stores initialized and uninitialized data and pairs with `SI` as offset
- The `ES` is used by `instructions` like `movsb` as destination for moving data, it pairs with `DI` as offset
- The `SS` stores stack data, SS is the segment register (determining the base address), while SP is the offset within that segment
- Multiple segment can have the same base without overlap, if their offsets have enough spaces in-between
- If a partition entry has a system ID which the OS does not recognize, it is ignored
- Each valid partition is recognized and shown as a partition. Example: `C:\`