;the following program is written for genrating random number
%define multiplyer 1234
%define increment  3222
%assign modulus    2*34
;-----------------------------------------------------
section .data     ;writing const value
  seed dd 0    ;seed value :note: Integer is 32 bit

;-----------------------------------------------------
section .text
 global _start


_start:
  ;The following code uses linix syscall for time
  xor ebx,ebx
  mov eax,13
  int 80h

  mov [seed],eax


  ;add seed to the register and call the function
  mov eax, [seed] 
  call genrate_random_number ;Call function

  ;now passing the computed value to the exit system call
  mov ebx, eax
  mov eax, 1          ; syscall number for exit
  int 0x80            ; syscall

;-----------------------------------------------------
;Function's
;-----------------------------------------------------
genrate_random_number:
  ;eax=seed and now we write LCG algo
  ;Multiply eax(Xn) with multiplyer
  mov ebx,multiplyer
  mul ebx
  ;Add increment
  add eax,increment  
  ;Mod eax % modulus
  ;Now we do a division operation
  ;in the ebx we store modulus 
  mov ebx,modulus
  xor edx,edx         ;clearing it to zero
  div ebx              ; EAX = quotient, EDX = remainder
  mov eax,edx
  ret

;-----------------------------------------------------
