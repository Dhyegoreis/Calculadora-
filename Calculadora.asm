section .data 
m0 db 'Bem vindo a Calculadora!!', 0xa 
tm0 equ $ - m0

m1 db 'Digite o primeiro numero:', 0xa 
tm1 equ $ - m1

m2 db 'Digite o segundo numero:',0xa
tm2 equ $ - m2

    m3 db "Qual operação será efetuada:", 0xA
         db "1 para somar", 0xA
         db "2 para subtração", 0xA
         db "3 para multiplicação", 0xA
         db "4 para divisão", 0xA
         db "0 para sair da calculadora", 0
    tm3 equ $ - m3  

m4 db 'Digite sua escolha:',0xa
tm4 equ $ - m4

m5 db 'O Resutado é :',0xa
tm5 equ $ - m5

m6 db 'Escolha errada',0xa
tm6 equ $ - m6

m7 db 'Deseja fazer outra operação ? (1 - Sim, 0 - Não):',0xa
tm6 equ $ - m7

section .bss

    n1 resb 2
    n2 resb 2 
    n4 resb 2
    n_e resb 2
    Resutado resb 2
   
section .text 
    global _start 

_start:
    mov eax, 4
     mov ebx, 1
     mov ecx, m0
     mov edx,  tm0
     int 0x80

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
     mov edx, tm4
     int 0x80

     mov eax, 3
     mov ebx, 0
     mov ecx, n4
     mov edx,  2
     int 0x80

     movzx eax, byte [n4]
     sub eax, '0'

    ; Verifica se a escolha é válida
     cmp eax, 0
     jl n_e
     cmp eax, 4
     jg n_e

     cmp eax, 0                 
     je exit

     call m4
     jmp m7

escolha_invalida:
    ; Mensagem de erro
     mov eax, 4
     mov ebx, 1
     mov ecx, m6
     mov edx, tm6
     int 0x80
     jmp obter_escolha

sair:
    mov eax, 1
    int 0x80