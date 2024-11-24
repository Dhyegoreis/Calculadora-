section .data 
m1 db 'Digite o primeiro numero:', 0xa 
tm1 equ $ - m1

m2 db 'Digite o segundo numero:',0xa
tm2 equ $ - m2

m3 db 'Qual operação sera efetuada:',0xa
tm3 equ $ - m3

m4 db '1 para somar  ',0xa
tm4 equ $ - m4

m5 db '2 para subtração.  ',0xa
tm5 equ $ - m5

m6 db '3 para multiplicação. ',0xa
tm6 equ $ - m6

m7 db '4 para divisão ',0xa
tm7 equ $ - m7

m8 db '0 sair da calculadora ',0xa
tm8 equ $ - m8

section .bss

    n1 resb 2
    n2 resb 2 
    ope4 resb 2
    ope5 resb 2
    ope6 resb 2
    ope7 resb 2
    ope8 resb 2





section .text 
    global _start 

_start:

     mov eax, 4
     mov ebx, 1
     mov ecx, m1
     mov edx,  tm1
     int 0x80

     mov eax, 3
     mov ebx, 0
     mov ecx, n1
     mov edx,  2
     int 0x80

     mov eax, 4
     mov ebx, 1
     mov ecx, m2
     mov edx,  tm2
     int 0x80

     mov eax, 3
     mov ebx, 0
     mov ecx, n2
     mov edx,  2
     int 0x80
     
         mov eax, 4
     mov ebx, 1
     mov ecx, m3
     mov edx,  tm3
     int 0x80

     mov eax, 4
     mov ebx, 1
     mov ecx, m4
     mov edx,  tm4
     int 0x80

      mov eax, 4
     mov ebx, 1
     mov ecx, m5
     mov edx,  tm5
     int 0x80

     mov eax, 4
     mov ebx, 1
     mov ecx, m6
     mov edx,  tm6
     int 0x80

     mov eax, 4
     mov ebx, 1
     mov ecx, m7
     mov edx,  tm7
     int 0x80

     mov eax, 4
     mov ebx, 1
     mov ecx, m8
     mov edx,  tm8
     int 0x80
     
     mov al, [n1]
     mov bl, [n2]
     sub al, '0'
     sub bl, '0'
     add al,bl
     add al, '0'
     mov [resposta], al
     int 0x80

     mov eax, 4
     mov ebx, 1
     mov ecx, resposta
     mov edx, 2
      int 0x80
    
     mov al, [n1]
     mov bl, [n2]
     sub al, '0'
     sub bl, '0'
     mul bl
     add al, '0'
     mov [resposta], al
      int 0x80

     mov eax, 4
     mov ebx, 1
     mov ecx, resposta
     mov edx, 2
     int 0x80
    
     mov al, [n1]
     mov bl, [n2]
     sub al, '0'
     sub bl, '0'
     div bl
     add al, '0'
     add ah, '0'
     mov [resposta], al
     mov [resto], ah
     int 0x80

     mov eax, 4
     mov ebx, 1
     mov ecx, resposta
     mov edx, 2
     int 0x80
    
     mov eax, 4
     mov ebx, 1
     mov ecx, resto
     mov edx, 2
     int 0x80

sair:
    mov eax, 1
    int 0x80