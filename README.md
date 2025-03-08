# x86 Assembly Learning Project

A comprehensive project for learning x86 Assembly programming, covering everything from basic concepts to bare metal programming.

## Project Structure

```
.
├── baremetal/
│   ├── realmode.asm
├── learn/
│   ├── code/
│   │   ├── datatypes.asm
│   │   ├── directives.asm
│   │   ├── flags.asm
│   │   ├── instructions.asm
│   │   └── memory.asm
│   └── includes/
│       ├── constants.inc
│       └── macros.inc
└── run.sh
```

## Getting Started

### Prerequisites
- NASM (Netwide Assembler)
- GCC (for linking user-space programs)
- Linux environment or WSL for Windows

### Building and Running

1. For regular assembly programs:
    > Run `./run.sh <filename>` and will create an `elf32` executable, run and remove it.

2. For bare metal programs:
   > Place your code in the `baremetal/`, run `./run.sh <filename>` and will create a binary file. NOTE: This assumes that you are creating a 16-bit bare metal program.

## Topics Covered

### Basic Assembly
- Data types and declarations
- Common instructions
- Memory operations
- CPU flags and conditions
- Assembly directives

### Bare Metal Programming
- Real Mode (16-bit)
> NOTE: This for now

### Advanced Concepts
- Macros
- Include files
- Memory alignment
- System calls

## License

This project is licensed under the terms of the included LICENSE file.
