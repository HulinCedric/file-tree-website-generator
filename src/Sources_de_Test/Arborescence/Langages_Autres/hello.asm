 cseg segment
 assume cs:cseg, ds:cseg
 org 100h	
 main proc	
 jmp debut
 mess db 'Hello world!$'
 debut:
 mov dx, offset mess
 mov ah, 9
 int 21h
 ret
 main endp	
 cseg ends
 end main
