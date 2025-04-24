section .data
  message db "Enter a number less than 10: "
  lenMsg equ $-message
  dis  db "Result: "
  lenDis equ $-dis
  num db "9"
  newLine db 0xA
section .bss 
   userNum resb 1

section .text                    ;Code section
 global _start


_start:
  
  ;print the message
  mov eax,4                      ;Write syscall
  mov ebx,1                      ;arg passed to the syscall
  mov ecx,message
  mov edx, lenMsg
  int 80h                        ;call kernel
  

  

  ;Now to read the user input from the terminal
  

  mov eax,3                       ;Read syscall
  mov ebx, 0                      ;arg passed to the syscall
  mov ecx,userNum
  mov edx,1
  int 80h                         ;call kernel

  ;Substraction operation


  movzx eax,byte [num]                   ;putting num in the eax register
  sub eax,"0"                     ;now sub "0" to convert it to integer
  movzx ebx, byte [userNum]
  sub ebx,"0"
  sub eax,ebx
  add eax,"0"
  mov [userNum],al                 ;storing the last bits
  int 80h


  ;Now to print the display message
  mov eax, 4
  mov ebx,1
  mov ecx, dis
  mov edx, lenDis
  int 80h

  ;Now to print the result of the computation

  mov eax,4                      ;write syscall for printing the reuslt of substraction
  mov ebx,1
  mov ecx, userNum
  mov edx, 1
  int 80h
  ;printing new line
  mov eax,4                      ;write syscall
  mov ebx,1
  mov ecx, newLine
  mov edx, 1
  int 80h                        ;call kernel

  ;exit
  mov eax,1
  mov ebx,0
  int 80h
