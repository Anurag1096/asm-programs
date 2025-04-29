section .data                 ;Initilized data
;ask to enter a number
msg1  db "Enter a number less than 100 to guess"
num   dd  35
game_won db "Congratulation you have guessed corectly"
len_gw  equ $-game_won
lenmsg1 equ $-msg1
newline db 0x0A         ;new line 1 byte

;------------------

section .bss                  ;Uninitilized data
;need to store a user value
user_input  resb   4
section .text                 ;Code section
 global _start


 _start:
 ;Printing the msg
 mov eax, 4                   ;Syscall number for write
 mov ebx,1                    ;file discripter for stdout
 mov ecx, msg1                ;The msg to display
 mov edx,lenmsg1              ;How manny bytes to write
 int 80h                      ;interupt for sys call execution

 ;call excepts a return keyword
 call new_line
 call read_data

;looping structure
;there will be first check if the number is same 
 mov eax,num
 ;comparing if the user entered num
 cmp eax,user_input
 ;Check if equal
 je  equal
 ;check if greater than our num 
 jg  greater_than
 ;if not greater or equal then less than the num
 jmp less_than
;--------------------
 less_than:

;--------------------
 greater_than:


;--------------------
equal:
  mov eax,4
  mov ebx,1
  mov ecx,game_won
  mov edx,len_gw
  int 80h
  ret
  
  call new_line
  call end_program
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

 end_porgram: 
 mov eax,1
 int 80h
 ret


