Codigo SEGMENT
	Assume CS: Codigo; DS:Codigo; SS:Codigo
	Org 100H
Entrada: JMP Nomeprog


    MSG1    DB    "Insira o Primeiro Numero: $"
    MSG2    DB    "Insira o Segundo Numero: $"
    MSG3    DB    "Resultado: $"
    SALTALINHA DB 0AH, 0DH, "$"
    NUM1    DB  0
    NUM2    DB  0                            ; inicializo geral com 0
    DIG1    DB  0
    DIG2    DB  0
    ANS     DB  0  
    
    
;         


               
Nomeprog PROC NEAR
    
    
;ENTRADA DO PRIMEIRO NUMERO


    MOV DX,OFFSET MSG1  ;move a string msg1 da linha 4h 
    CALL Mostrarstring 
     
              
    MOV AL,01H      ;chama funcao 01h (le uma entrada do teclado)  da 21h
    INT 21H       
    
    
    
    SUB AL,30H      ;converte de ASCII pra decimal
    MOV DIG1,AL     ;move o primeiro digito para DIGIT1
    
    
    
    MOV AH,01H      ;chama funcao 01h de novo
    INT 21H          
    
    
    SUB AH,30H      ;converte de ASCII pra decimal
    MOV DIG2,AL     ;move o segundo digito pra DIGIT2
    
    
    MOV AL,DIG1     ;move o primeiro digito para AL
    MOV BL,10       ;move 10 pra BL
    MUL BL          ;multiplica o digito 1 em AL por 10(BL)
    MOV NUM1,AL     ;move al(primeiro digito) para NUM1
    MOV AL,DIG2     ;move o segundo digito para AL
    ADD NUM1,AL     ;soma o primeiro digito com o segundo
    ; nesse ponto, o primeiro numero esta guardado em NUM1
    
    
    
    MOV DX,OFFSET SALTALINHA
    CALL Mostrarstring      ; pula a linha, simplesmente

    
    
;ENTRADA DO SEGUNDO NUMERO
    MOV DX,OFFSET MSG2  ;printa string    
    CALL Mostrarstring  ;
    
    
    MOV AH,01H      ;recebe entrada do teclado
    INT 21H
    SUB AL,30H      ;converte de ASCII para decimal
    MOV DIG1,AL     ;move o primeiro digito para DIGIT1
    
    

    MOV AH,01H      ;recebe entrada do teclado
    INT 21H
    SUB AL,30H      ;converte de ASCII para decimal
    MOV DIG2,AL     ;move o segundo digito para DIGIT2
    
    
    
    MOV AL,DIG1     ;move o primeiro digito para AL
    MOV BL,10       ;move 10 pra BL
    MUL BL          ;multiplica o digito 1 em AL por 10(BL)
    MOV NUM2,AL     ;move AL(primeiro digito) para NUM2 
    MOV AL,DIG2     ;move o segundo digito pra AL
    ADD NUM2,AL     ;soma o primeiro digito com o segundo
    ; nesse ponto, o segundo numero esta guardado em NUM2
    
    
    
    MOV DX,OFFSET SALTALINHA
    CALL Mostrarstring              ; pula a linha de novo





;ADICAO
    MOV BL,NUM1    ;move o primeiro numero pra BL
    ADD BL,NUM2    ;adiciona o segundo numero com o primeiro em BL
    
    CALL Mudanca   ;chama a funcao MUDANCA
    
    MOV DX,OFFSET MSG3
    CALL Mostrarstring     ;printa a string do resultado
    
    
    CALL Resultado         ;chama a funcao RESULTADO
                           ;interrupcao 20H
    INT 20H  
    
Nomeprog ENDP              ;encerra
  


Mostrarstring PROC NEAR  ; Funcaozinha pra printar as strings

	MOV AH, 09H
	INT 21H
	RET

Mostrarstring ENDP

Mudanca PROC  
    MOV AH,0        ;move 0 pra AH
    MOV AL,BL       ;move BL(resultado da soma) pra AL
    MOV BL,10       ;move 10 pra BL
    DIV BL          ;divide o que ta em AL(resultado da soma) por BL
    MOV BL,AL       ;move AL(resultado dividido por 10) pra BL
    MOV BH,AH       ;move AH(0) pra BH
    ADD BH,30H      ;converte BH(0) pra ASCII
    MOV ANS,BH      ;move BH(0 em ASCII) pra ANS
    MOV AH,0        ;move 0 pra AH
    MOV AL,BL       ;move BL(resultado dividido por 10) pra  AL
    MOV BL,10       ;BL fica 10
    DIV BL          ;Divide AL por BL
    MOV BL,AL       ;Move o resultado pra BL
    MOV BH,AH       ;move 0 pra BH
    ADD BH,30h      ;fica 0 em ASCII
    ADD BL, 30h     ;BL(resultado da divisao) fica em ASCII
    RET
Mudanca ENDP 




Resultado PROC
         
    MOV DL,BL      ;move o resultado em ASCII  pra DL
    MOV AH,02H     ;printa primeiro digito da resposta em DL
    INT 21H    
            
            
    MOV DL,BH      ;move segundo digito pra DL 
    MOV AH,02H     ;printa segundo digito
    INT 21H   
    
    
    MOV DL,ANS     ;pega o resto (0 ou 1) que tiver em ANS
    MOV AH,02H     ;printa
    INT 21H 
    
    
    RET
Resultado ENDP   

Codigo ENDS
END Entrada
