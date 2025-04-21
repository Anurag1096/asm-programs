section .data                          ;Data segment

 userMsg  db 'Please enter a number: '   ;Ask user to enter a number
 lenOfMsg equ $-userMsg                ;Getting the length of the user message
 displayMsg db 'you have entered: '
 lenDispMsg equ $-displayMsg


section .bss                           ;Uninitialized data
   num resb 5


section .text                          ;Code segment
  
  global _start                        ;This is the global start for code


_start:                                 ;User prompt

 mov eax, 4
 mov ebx, 1
 mov ecx, userMsg
 mov edx, lenOfMsg
 int 80h

 mov eax, 3
 mov ebx, 2
 mov ecx, num
 mov edx, 5                             ;5 bytes is being stored
 int 80h

 ;output the message "you have entered"

 mov eax,4
 mov ebx, 1
 mov ecx, displayMsg
 mov edx, lenDispMsg
 int 80h

 ;output the entered number

 mov eax, 4
 mov ebx,1
 mov ecx, num 
 mov edx, 5
 int 80h

 ;Exit code
 mov eax, 1
 mov ebx, 0
 int 80h

