include 'emu8086.inc'    
name "PROJECTATM"
JMP BEGIN
   
DATA SEGMENT 
    CLIENTS      DW 20H ;total number of clients         
    CARDS        DW 0000H,0001H,0002H,0003H,0004H,0005H,0006H,0007H,0008H,0009H,000AH,000BH,000CH,000DH,000EH,000FH,0011H,0012H,0013H,0014H  ;card ids to be stored in database
    PASS         DB 00H,01H,02H,03H,04H,05H,06H,07H,08H,09H,0AH,0BH,0CH,0DH,0EH,0FH,11H,12H,13H,14H ;passcodes to be stored in database
    MSG1         DB 'HELLO!',0
    MSG2         DB 0DH,0AH,'PLEASE ENTER YOUR 4-DIGIT CARD NUMBER: ',0
    MSG3         DB 0DH,0AH,'ENTER YOUR 2-DIGIT PASSCODE: ',0 
    MSG4         DB 0DH,0AH,'ACCESS DENIED  0 ',0  
    MSG5         DB 0DH,0AH,'ACCESS GRANTED 1',0
    MSG6         DB 0DH,0AH,'INCORRECT PASSCODE',0   
    ID_INPUT     DW  0    ;initializing variable for card id
    PASS_INPUT   DB  0    ;initializing variable for passcode
DATA ENDS


CODE SEGMENT

BEGIN:
MOV  AX,DATA
MOV  DS,AX  

;predefined in emu8086.inc
DEFINE_SCAN_NUM           
DEFINE_PRINT_STRING 
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS 


LOOPP:PRINT 0DH                ;prints new line
      LEA  SI,MSG1
      CALL PRINT_STRING
      LEA  SI,MSG2
      CALL PRINT_STRING
      MOV  SI,-1        ;setting SI to -1 for use as index

      CALL SCAN_NUM     ;reads number from the user and stores it in CX
      MOV  ID_INPUT,CX
      MOV  AX,CX
      MOV  CX,0         ;reset the value of CX to 0

DO:   INC  CX           ;incrementing index
      CMP  CX,CLIENTS
      JE   DENY           ;not found in database
      INC  SI
      MOV  DX,SI          ;saves SI into DX to be used later
      CMP  CARDS[SI],AX   ;compare with saved 'array' in data segment
      JE   CHECK_PASS
      JMP  DO

CHECK_PASS:
    LEA  SI, MSG3
    CALL PRINT_STRING
    CALL SCAN_NUM        ; scanning the passcode into CL
    MOV  PASS_INPUT, CL

    MOV  SI, -1        ; resetting SI for passcode search

    DO_PASS:
        INC  SI           ; incrementing index
        CMP  SI, CLIENTS
        JE   DENY   ; not found in our database

        CMP  PASS[SI], CL   ; compare with passcode stored in the PASS array
        JE   CHECKS
        JMP  DO_PASS

CHECKS:ADD  SI,2     
       CMP  SI,DX  ;so we're sure its a correct map
       JE   ALLOW
       JMP  WRONG_PASS

   
WRONG_PASS:LEA  SI,MSG6
     CALL PRINT_STRING
     PRINT 0AH         ;prints new line
     JMP  LOOPP      
      
DENY:LEA  SI,MSG4
     CALL PRINT_STRING
     PRINT 0AH         ;prints new line
     JMP  LOOPP 
      
      
ALLOW:LEA  SI,MSG5
      CALL PRINT_STRING 
      

CODE ENDS
 
END BEGIN
ret    
      
      
          
     
     