section .data
ip_address db 127,0,0,1
port dw 0x1F90

 sockaddr_in:
  dw 2                 ;sin_family = AFnet =2
  dw port              ;8080
  dd 0x0100007F        ; sin_addr = 127.0.0.1 (little endian)
  times 8 in 0         ; zero padding

message db "Hello" ,10
len_msg equ $-message

section .bss 
 socketfd resb 1      ;reserving one byte

section .text

global _start

_start:
;to write to a socket we need to first create a socket
; socket(AF_INET, SOCK_STREAM, 0)


