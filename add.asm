section .data 
 num     dd 10
 num2    dd 7
 newline db 0xA    ; ASCII newline = '\n'

section .bss
  result resb 4   ;four bytes allocated
  outbuf resb 16  ;buffer for ASCII string

section .text
 global _start

_start:
  mov eax , [num]
  mov ebx , [num2]
  add eax , ebx
  mov [result] , eax
   
  ;convert to ASCII string
  mov ecx,outbuf
  add ecx, 15           ;point to the end of the buffer
  mov byte [ecx], 0
  

  mov eax , [result]   ; the number to convert
  mov ebx, 10          ;divisor for decimal

convert_loop:
    xor edx, edx
    div ebx                ; eax / 10, remainder in edx
    add dl, '0'            ; Convert digit to ASCII
    dec ecx
    mov [ecx], dl
    test eax, eax
    jnz convert_loop


   ; Write result to stdout
    mov eax, 4             ; sys_write
    mov ebx, 1             ; stdout
    mov edx, outbuf        ; full buffer
    add edx, 15
    sub edx, ecx           ; calculate length
    mov esi, ecx           ; start of string
    mov ecx, esi
    int 80h


;Print new line

   mov eax,4
   mov ebx,1
   mov ecx,newline
   mov edx,1
   int 80h
    ; Exit
    mov eax, 1
    xor ebx, ebx
    int 80h
