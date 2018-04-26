INCLUDE macros.asm
    
ORG 100H

.STACK
    DW   128  DUP(?)       

.DATA                                
    MSG DB 0DH,0AH,"DOSE TOYS ARITHMOYS: ",'$'
    SPACE DB " ",'$'
    ADDITION DB 0DH,0AH,"A=",'$' 
    MULTIPLICATION DB 0DH,0AH,"M=",'$'
    NEWLINE DB 0AH, 0DH, '$'
	
.CODE
	JMP START
	
START:      
    PRINT_STR MSG
    MOV CX, 05H				; 3 �����������
DIGITS:
    CALL HEX_KEYB			; �������� ��� 3 ������
	PUSH AX					; ��� ���������� ���� ��� ������
	LOOP DIGITS       
	         
	POP AX   
	MOV BX,AX 				; ���������� ��� ������ ���� BX
	MOV BH,0        
    POP AX   
	MOV CX,AX     			; ���������� ��� �������� ���� CX
	MOV CH,0           
	POP AX 
	MOV DX,AX 				; ���������� ��� ������ ���� DX 
	MOV DH,0
	PUSH AX					; ���� ��� ������ � ������ (����� �����������)
	
	MOV AX,CX
	ADD AX,BX
	ADD AX,DX 				; ����������� ����������� ���� AX
	MOV DX,AX 				; ��� ���� ���������� ���� DX
     
	POP AX					; �������� ��� 3�� �������
	MOV BH,0
	MUL BL 					; ����������� ��������������� ���� AX
	MOV CH,0
	MUL CL
	MOV CX,AX				; ��� ���� ���������� ���� CX

WAIT_FOR_ENTER:
    READ					; ������� ��� �� ������ ��� ENTER
    CMP AL,'m'
    JE EXIT 
    SUB AL,30H
    CMP AL,221
    JE PRINTING
    JMP WAIT_FOR_ENTER     	; ��������� ��� ��� ��� ������� ENTER       
	
PRINTING:	
	PRINT_STR ADDITION      ; �������� ���������         
    CALL PRINT_HEX
    PRINT_STR MULTIPLICATION ; �������� ���������������  
    MOV DX,CX
    CALL PRINT_HEX 
    PRINT_STR NEWLINE		; ��� ������ �� ���������
    JMP START
TERMIN:
    RET   	
        
 ; ������� ��� ��������� ���� ������ �� ����������� �������       
PRINT_HEX PROC
	PUSH AX				; ���������� ��� �����������
	MOV AX, DX
	PUSH DX
	MOV DX, AX
    
    PUSH CX
	MOV CX, 04H 		; �� loop �� ����������� 4 �����
HEXAL:
	SHR AX,12			; ��������� ��� bit ��� ������� (��'�� msb ��� lsb)
	AND AX,0FH
	CALL CHECK_HEX 		; ��������� � ascii ��� ���� 4 bit 
	SHL DX,4			; �������� ��� �������
	MOV AX,DX
	LOOP HEXAL
         
    POP CX
	POP DX				; ��������� ��� �����������
	POP AX
	RET
PRINT_HEX ENDP	
	     
        
; ������� ��� ������� 4bit �������� ��� ���������� 16����
CHECK_HEX PROC
	CMP AL,9
	JLE ADR1
	ADD AL,37H				; �� ����� �-F
	JMP ADR2
ADR1:
	ADD AL,'0'				; �� ����� 0-9
ADR2:        
	PRINT AL    
	RET
CHECK_HEX ENDP        
        
        
HEX_KEYB PROC
READSTART:
    CMP CX,03H
    JE SPACE1
    READ
	CMP AL,'M'				; �� ������� �� �, ������������
	JE EXIT
	CMP AL,'0'
	JL READSTART 			; ������� ������� ��� 0-F
	CMP AL,'F'
	JG READSTART 
	PRINT AL				; �������� ��� ������ ��� ���������� ���� �����
	CMP AL,'9' 				; �� ����� �-F
	JG NEXT2
	MOV AH,0
	SUB AX,'0'				; ��������� ��� ASCII ��������� �� ����������� �����
	RET          
NEXT2:    					; �� ����� 0-9
    MOV AH,0
	SUB AX,'A'				; ��������� ��� ASCII ��������� �� ����������� �����
	ADD AX,10
    RET
SPACE1:
    PRINT_STR SPACE
    RET
EXIT: EXIT
HEX_KEYB ENDP
	         