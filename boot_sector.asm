[org 0x7c00]					;; Specify load address
[bits 16]

section .text
	global start

start:
cli
jmp 0x0000:ZeroSeg
ZeroSeg:						;; Set all segment registers to 0
	xor ax, ax
	mov ss, ax
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov sp, start				;; Set stack pointer
	cld							;; Clear direction flag
sti


push ax							;; Reset disk
xor ax, ax
int 0x13
pop ax

mov si, STR						;; Put string in si
call printf

mov al, 1						;; Number of sectors to read
mov cl, 2						;; Sector
call readDisk


;; mov si, STR_HEX_INFO
;; call printf
;; 
;; mov dx, [0x7c00 + 510]
;; call printh


mov ax, 0x2400					;; Disable A20 line
int 0x15

;; mov si, STR_A20_TEST
;; call printf
call testA20
;; mov si, STR_A20_RES
;; call printf
mov dx, ax
call printh

call enableA20

;; mov si, STR_A20_TEST
;; call printf
;; mov si, STR_A20_RES
;; call printf
mov dx, ax
call printh

jmp second_sector

jmp $							;; Loop

%include "./printf.asm"
%include "./printh.asm"
%include "./read_disk.asm"
%include "./testA20.asm"
%include "./enableA20.asm"

STR: db "Hello World!", 0x0a, 0x0d, 0
STR_TEST: db "String loaded from second sector", 0x0a, 0x0d, 0 
;; STR_A20_TEST: db "A20 Test: ", 0x0a, 0x0d, 0
;; STR_A20_RES: db "A20 Test Result (0 = Disabled): ", 0
STR_HEX_INFO: db "Last two bytes of Bootloader: ", 0

;; Padding and magic number
times 510 - ($ - $$) db 0
dw 0xaa55

;; Second sector
second_sector:
	mov si, STR_TEST
	call printf
	times 152 db 0
