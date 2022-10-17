# Operating System
Simple boot sector written in x86\_64 Assembly. Prints a hexadecimal and hangs.

## Required packages
- make (For makefile)
- nasm (For compiling binary)
- qemu (For emulation)
- cdrtools (For generating ISO)

## Cloning and execution
#### Clone repository
```sh
git clone https://github.com/manankarnik/operating-system.git
```

#### Change branch
```sh
git checkout 04-print_hex-function
```

#### Change directory
```sh
cd operating-system
```

#### Compile binary
Uses nasm to compile to bin
```sh
make
```

#### Emulate
Uses qemu-system-x86\_64 to emulate boot sector
```sh
make run
```

#### Generate ISO
ISO can be attached to virtualbox (not tested on hardware)
```sh
make iso
```

#### Delete generated files
Removes all iso and bin files generated by make
```sh
make clean
```

## Functions
#### print
Prints a string using int 0x10. Move the string defined by db to si register.
- 0x0a:	Line Feed (New line)
- 0x0d:	Carriage Return
- 0:	Terminates string
```asm
mov     si, STR
call    print
STR:	db "Hello World!", 0x0a, 0x0d, 0
```

#### print\_hex
Prints hexadecimal value. Move either a hexadecimal or memory address to dx register.
```asm
mov     dx, 0x1234
call    print_hex
```

## Reference
[OS Development PDF](https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf)
