section .data
    m0 db 'Bem vindo a Calculadora!!', 0xa
    tm0 equ $ - m0

    m1 db 'Digite o primeiro numero:', 0xa
    tm1 equ $ - m1

    m2 db 'Digite o segundo numero:', 0xa
    tm2 equ $ - m2

    m3 db "Qual operacao sera efetuada:", 0xA
        db "1 para somar", 0xA
        db "2 para subtracao", 0xA
        db "3 para multiplicacao", 0xA
        db "4 para divisao", 0xA
        db "0 para sair da calculadora", 0xa
    tm3 equ $ - m3

    m4 db 'Digite sua escolha:', 0xa
    tm4 equ $ - m4

    m5 db 'O Resultado e: ', 0xa
    tm5 equ $ - m5

    m6 db 'Escolha errada', 0xa
    tm6 equ $ - m6

    m7 db 'Numero invalido. Escolha outro numero:', 0xa
    tm7 equ $ - m7

    m8 db 'Erro: Divisao por zero nao e permitido', 0xa
    tm8 equ $ - m8

    m9 db 'Deseja continua ? (1 para sim e 0 para não.)', 0xa
    tm9 equ $ - m9
    
    m10 db 'Calculadora finalizada .', 0xa
    tm10 equ $ - m10

section .bss
    n1 resb 2
    n2 resb 2
    escolha resb 2
    resultado resb 4
    continuar resb 2

section .text
global _start

_start:
    ; Mensagem de boas-vindas
    mov eax, 4
    mov ebx, 1
    mov ecx, m0
    mov edx, tm0
    int 0x80

loop_calculadora:
    ; Solicita o primeiro número
    mov eax, 4
    mov ebx, 1
    mov ecx, m1
    mov edx, tm1
    int 0x80

    ; Lê o primeiro número
    mov eax, 3
    mov ebx, 0
    mov ecx, n1
    mov edx, 2
    int 0x80
    call validar_n1

    ; Solicita o segundo número
    mov eax, 4
    mov ebx, 1
    mov ecx, m2
    mov edx, tm2
    int 0x80

    ; Lê o segundo número
    mov eax, 3
    mov ebx, 0
    mov ecx, n2
    mov edx, 2
    int 0x80
    call validar_n2

    ; Solicita a operação
    mov eax, 4
    mov ebx, 1
    mov ecx, m3
    mov edx, tm3
    int 0x80

    ; Solicita a escolha da operação
    mov eax, 4
    mov ebx, 1
    mov ecx, m4
    mov edx, tm4
    int 0x80

    ; Lê a escolha da operação
    mov eax, 3
    mov ebx, 0
    mov ecx, escolha
    mov edx, 2
    int 0x80

    ; Decisão com base na escolha
    mov al, [escolha]
    sub al, '0'
    cmp al, 1
    je somar
    cmp al, 2
    je subtrair
    cmp al, 3
    je multiplicar
    cmp al, 4
    je dividir
    cmp al, 0
    je sair
    jmp escolha_invalida

somar:
    ; Soma n1 e n2
    mov al, [n1]
    sub al, '0'
    mov bl, [n2]
    sub bl, '0'
    add al, bl
    add al, '0'
    mov [resultado], al
    call exibir_resultado
    jmp continuar_calculadora
    
subtrair:
    ; Subtração n1 - n2
    mov al, [n1]
    sub al, '0'
    mov bl, [n2]
    sub bl, '0'
    sub al, bl
    add al, '0'
    mov [resultado], al
    call exibir_resultado
    jmp continuar_calculadora

multiplicar:
    ; Multiplicação n1 * n2
    mov al, [n1]
    sub al, '0'
    mov bl, [n2]
    sub bl, '0'
    mul bl
    add al, '0'
    mov [resultado], al
    call exibir_resultado 
    jmp continuar_calculadora

dividir:
    ; Divisão n1 / n2
    mov al, [n1]
    sub al, '0'
    mov bl, [n2]
    sub bl, '0'
    cmp bl, 0
    je erro_divisao_msg
    div bl
    add al, '0'
    mov [resultado], al
    call exibir_resultado
    jmp continuar_calculadora

escolha_invalida:
    ; Mensagem de escolha inválida
    mov eax, 4
    mov ebx, 1
    mov ecx, m6
    mov edx, tm6
    int 0x80
    jmp loop_calculadora

erro_divisao_msg:
    mov eax, 4
    mov ebx, 1
    mov ecx, m8
    mov edx, tm8
    int 0x80
    jmp loop_calculadora

continuar_calculadora:
    ; Pergunta se deseja continuar ou sair
    mov eax, 4
    mov ebx, 1
    mov ecx, m9
    mov edx, tm9
    int 0x80

    ; Lê a resposta do usuário
    mov eax, 3
    mov ebx, 0
    mov ecx, continuar
    mov edx, 2
    int 0x80

    mov al, [continuar]
    sub al, '0'
    cmp al, 1
    je loop_calculadora
    cmp al, 0
    je sair
    jmp continuar_calculadora

validar_n1:
    ; Valida o primeiro número
    mov al, [n1]
    sub al, '0'
    cmp al, 1
    jl numero_invalido
    cmp al, 100
    jg numero_invalido
    ret

validar_n2:
    ; Valida o segundo número
    mov al, [n2]
    sub al, '0'
    cmp al, 1
    jl numero_invalido
    cmp al, 100
    jg numero_invalido
    ret

numero_invalido:
    ; Mensagem de número inválido
    mov eax, 4
    mov ebx, 1
    mov ecx, m7
    mov edx, tm7
    int 0x80
    jmp loop_calculadora

exibir_resultado:
    ; Exibe o resultado armazenado em [resultado]
    mov eax, 4
    mov ebx, 1
    mov ecx, m5
    mov edx, tm5
    int 0x80

    ; Exibe o valor do resultado
    mov eax, 4
    mov ebx, 1
    lea ecx, [resultado]
    mov edx, 2
    int 0x80
    ret

sair:
    
    mov eax, 4
    mov ebx, 1
    mov ecx, m10
    mov edx, tm10
    int 0x80
    
    mov eax, 1
    int 0x80
