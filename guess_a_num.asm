section .data                 ;Initilized data
;ask to enter a number
msg1     db     "Enter a number less than 100 to guess"
num      dd     35
game_won db     "Congratulation you have guessed corectly"
lesser   db     "The Guessed value is less than the number"
len_lt   equ    $-lesser
greater  db     "The Guessed value is greater than the number"
len_gt   equ    $-greater
len_gw   equ    $-game_won
lenmsg1  equ    $-msg1
newline  db     0x0A         ;new line 1 byte

;------------------

section .bss                  ;Uninitilized data
;need to store a user value
user_input  resb   4

;------------------
section .text                 ;Code section
 global _start


_start:
 ;Printing the msg
 mov eax, 4                   ;Syscall number for write
 mov ebx,1                    ;file discripter for stdout
 mov ecx, msg1                ;The msg to display
 mov edx,lenmsg1              ;How manny bytes to write
 int 80h                      ;interupt for sys call execution
 jmp l1
 ;call excepts a return keyword
l1:
 call new_line
 call read_data

;looping structure
;there will be first check if the number is same

 call parse_input
                ; target number
 cmp ebx ,[num]
 ;Check if equal
 je  equal
 
 jl less_than
 ;check if greater than
 jg  greater_than
 ;if not greater or equal then less than the num
 
;--------------------
less_than:
 ;if less than
 mov eax,4
 mov ebx,1
 mov ecx,lesser
 mov edx,len_lt
 int 80h
 
 call new_line
 jmp l1
;--------------------
greater_than:
 mov eax,4
 mov ebx,1
 mov ecx,greater
 mov edx, len_gt
 int 80h

 call new_line
 jmp l1
;--------------------
equal:
 ;print success message and exit
  mov eax,4
  mov ebx,1
  mov ecx,game_won
  mov edx,len_gw
  int 80h
  
  call new_line
  jmp end_program
;--------------------
read_data:
   mov eax,3
   mov ebx, 0
   mov ecx,user_input
   mov edx,4
   int 80h
   ret
;--------------------
new_line:
;change line
   mov eax,4
   mov ebx,1
   mov ecx ,newline
   mov edx,1
   int 80h
   ret
 ;exit
;--------------------

end_program: 
 mov eax,1
 int 80h
 

parse_input:
    xor ebx, ebx            ; Clear result register (final number)
    xor ecx, ecx            ; Index counter (used to access user_input)

.convert_loop:
    movzx eax, byte [user_input + ecx] ; Load one byte (character)
    cmp eax, 0x0A           ; Check for newline (end of input)
    je .done_convert        ; If newline, stop
    sub eax, '0'            ; Convert ASCII to digit
    imul ebx, ebx, 10       ; Multiply result so far by 10
    add ebx, eax            ; Add current digit to result
    inc ecx                 ; Move to next character
    jmp .convert_loop       ; Repeat

.done_convert:
    ret
