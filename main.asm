;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------
EXTREMOS:
	mov #vetor, R5
	mov.w @R5, R6 ; inicializa menor elemnto
	mov.w @R5+, R7 ; inicializa maior elemento
	mov.w #8, R4

checa_menor:
	cmp.w @R5, R6
	jn checa_maior
	mov.w @R5, R6

checa_maior:
	cmp.w @R5, R7
	jge pula_num
	mov.w @R5, R7

pula_num:
	inc.w R5
	dec R4
	jnz checa_menor
	ret

	.data

vetor: .word 8, 121, 234, 567, -1990, 117, 867, 45, -1980

;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            
