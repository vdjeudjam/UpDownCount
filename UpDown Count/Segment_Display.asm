;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Microcontrollers Laboratory                   ;;
;; Exercise 3: Counter and Display System        ;;
;; Author: EYOG YVON LEONCE                      ;;
;; UB Number: FE11A070              		     ;;
;; Date: 01/06/2015                              ;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; This program uses a common cathode 7-segment display in PROTEUS

	LIST p=16f84A 
	#include <p16f84A.inc>		
	__CONFIG _CP_OFF & _WDT_OFF & _PWRTE_ON & _XT_OSC

count equ 0Bh
N1 equ 0Dh	;First counter for delay loop
N2 equ 0Eh
N3 equ 0Ch

;Register Bit Label Equates
Input1   equ 01h   ;PUSH BUTTON INPUT RA1
Input2   equ 02h   ;PUSH BUTTON INPUT RA2
ORG 0x000

;;defining PORT B ad output
bsf STATUS,5
movlw  b'0000000'	;setting PORTB pins to output
movwf TRISB
movlw b'00110'	;setting PORTA pins RA1 and RA2 to input
movwf TRISA
bcf STATUS,5


    movlw b'0000000'  ;30h	;0
    movwf count
    movf count,w

Start
call Table

call initial_check

goto Start
;}

initial_check ;{
btfsc PORTA, Input1 ; check if ra1 one is on {
goto button_one    
;}
btfsc PORTA, Input2 ; else check if ra2 is on{
goto button_two
;}
goto initial_check;else wait for either push
;}
return

;logic to for RA1
button_one
call UpCount; increment counter
call Wait


;check_b    BTFSS PORTA,Input2 ; Wait for button release
 ;          GOTO check_a

;goto check_a
goto initial_check

;logic for RA2
button_two

call DownCount; increment counter
call Wait
goto initial_check

;logic to increment
UpCount
	movf count,w
	call Table
	movwf PORTB
	btfsc PORTA, 01h
	incf count,f
	return

;logic to decrement
DownCount
    decf count,f
	movf count,w
	call Table
	movwf PORTB
	
	
	
	return

Wait
			;999990 cycles
	movlw	07h
	movwf	N1
	movlw	2Fh
	movwf	N2
	movlw	03h
	movwf	N3
loop
	decfsz	N1, f
	goto	$+2
	decfsz	N2, f
	goto	$+2
	decfsz	N3, f
	goto	loop

			;6 cycles
	goto	$+1
	goto	$+1
	goto	$+1

			;4 cycles (including call)
	return
Table
	addwf PCL,f		;PCL is prgram counter
	RETLW 0x3f ; 0
RETLW 0x06 ; 1
RETLW 0x5b ; 2
RETLW 0x4f ; 3
RETLW 0x66 ; 4
RETLW 0x6d ; 5
RETLW 0x7d ; 6
RETLW 0x07 ; 7
RETLW 0x7f ; 8
RETLW 0x6f ; 9

END

