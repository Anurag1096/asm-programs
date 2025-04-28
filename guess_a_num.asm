section .data                 ;Initilized data
;ask to enter a number
msg1  db "Enter a number less than 100 to guess"
lenmsg1 equ $-msg1
newline db 0x0A         ;new line 1 byte

;------------------

section .bss                  ;Uninitilized data

section .text                 ;Code section
 global _start


 _start:
 ;Printing the msg
 mov eax, 4                   ;Syscall number for write
 mov ebx,1                    ;file discripter for stdout
 mov ecx, msg1                ;The msg to display
 mov edx,lenmsg1              ;How manny bytes to write
 int 80h                      ;interupt for sys call execution


 ;change line
 mov eax,4
 mov ebx,1
 mov ecx ,newline
 mov edx,1
 int 80h



 ;exit
 mov eax,1
 int 80h

