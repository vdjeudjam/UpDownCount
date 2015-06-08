;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Microcontrollers Laboratory                   ;;
;; Exercise 3: Counter and Display System        ;;
;; Author: DJEUDJAM VERANE                       ;;
;; UB Number: FE11A046              		     ;;
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

ORG 0x000

;;defining PORT B ad output
bsf STATUS,5
movlw  b'0000000'	;setting PORTB pins to output
movwf TRISB
movlw b'00110'	;setting PORTA pins RA1 and RA2 to input
movwf TRISA
bcf STATUS,5

Start
	btfsc PORTA, 01h	;get the value from RA1 if it is 0
	call UpCount
	xorlw	b'1101111'		;check for last entry
	btfsc	STATUS, Z		;if true set Zero flag
	call UpCount

	btfsc PORTA, 02h	;get the value from RA2 if it is 0
	call DownCount
	xorlw b'0111111'
	btfsc STATUS, Z
	call DownCount		

	goto Start	

UpCount
	movf count,w
	call Table
	movwf PORTB
	call Wait
	btfsc PORTA, 01h
	incf count,f
	retlw count

DownCount
	movf count,w
	call Table
	movwf PORTB
	call Wait
	btfsc PORTA, 02h
	decf count,f
	retlw count

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
	retlw b'0111111'
	retlw b'0000110'
	retlw b'1011011'
	retlw b'1001111'
	retlw b'1100110'
	retlw b'1101101'
	retlw b'1111101'
	retlw b'0000111'
	retlw b'1111111'
	retlw b'1101111'

END

