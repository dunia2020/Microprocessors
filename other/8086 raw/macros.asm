PRINT MACRO CHAR 		;�������� ��������� ��� ��������� ���� AL ���� �����	
PUSH DX	
PUSH AX	
MOV AH,2	
MOV DL,CHAR	
INT 21H	
POP AX	
POP DX
ENDM

PRINT_STR MACRO MESSAGE 	;�������� ��������� string	
PUSH DX	
PUSH AX	
MOV AH,9	
MOV DX,OFFSET MESSAGE	
INT 21H	
POP AX	
POP DX
ENDM

READ MACRO 			;�������� ��������� ��� �� ������������ ��� ���������� ���� AL	
MOV AH,8	
INT 21H
ENDM

EXIT MACRO	
MOV AX,4C00H	
INT 21H
ENDM