;
; DesignAssignment1.asm
;
; Created: 2/9/2018 7:01:49 PM
; Author : Tenniel Takenaka-Fuller
;


;------------------------------
; STEP 1 OF DESIGN ASSIGNMENT 1
; Initialize Data
;------------------------------
; Store 300 numbers onto stack. STARTADDR = 0x0222. Use Pointers to fill up reg

; Used to initialize the SP to point to the last location of RAM (RAMEND)
.MACRO STACK
	LDI @0, HIGH(@1)
	OUT SPH, @0
	LDI @0, LOW(@1)
	OUT SPL, @0
.ENDMACRO

STACK R20, RAMEND	

;----------------------------------
; Set Pointers to First Num on Stack
;----------------------------------				

	LDI XH, HIGH(0x0222)				; set X pointer to high bits of mem location
	LDI XL, LOW(0x0222)					; set X pointer to low bits of mem location
	LDI YH, HIGH(0x0400)				; set Y pointer to high bits of div by 5 mem location
	LDI YL, LOW(0x0400)					; set Y pointer to low bits of div by 5 mem location
	LDI ZH, HIGH(0x0600)				; set Z pointer to high bits of non-div by 5 mem location
	LDI ZL, LOW(0x0600)					; set Z pointer to low bits of non-div by 5 mem location

;----------------------------------
; Clear sum & counter registers
;----------------------------------
	LDI R16, 0
	LDI R17, 0
	LDI R18, 0
	LDI R19, 0
	LDI R25, 0 

;----------------------------------
; Store the counter (300 = 0x012C)
;----------------------------------
	LDI R21, LOW(300)			; LOW = 0x2C
	LDI R22, HIGH(300)			; HIGH = 0x01


;----------------------------------
; Start population process
;----------------------------------
	LDI R23, HIGH(0x0222)
	LDI R25, LOW(0X0222)

startProgram:
	ADD R25, R23
	ST X+, R25						; write r25 to where x is pointing, then increment x
	

;----------------------------------
; STEP 2 OF DESIGN ASSIGNMENT 1
;----------------------------------
; Use reg to parse through numbers. If number is divisible by 5, store. Store into 0x0400 else store in 0x0600

	MOV R24, R25					; copies R25 into R24 so R25 value stays in tact
divByFive:
	CPI R24, 5						; check if loaded # less than 5
	BRLO notDivisible				
	
	SUBI R24, 5						; recursive subtraction to see if it is divisible by 5
	CPI R24, 5						; compare the subtracted number to five to see if it should keep dividing
	BRSH divByFive					; If R24 larger than 5, keep subtracting by 5
	CPI R24, 0						; compare r24 to 0 to see if # < 5 is divisible by 5
	BRNE notDivisible				; If it is not 0 (not divisible by 5) then jump to non-divisible loop
	ST Y+, R25						; write r25 to where y is pointing, then increment y
	ADD R16, R25					; sum of the divisible number by 5
	CP R16, R25
	BRLO divFiveCarry	
	RJMP checkThreeHundred	

divFiveCarry:
	INC R17
	RJMP checkThreeHundred

notDivisible:
	ST Z+, R25						; store original number to z
	ADD R18, R25					; sum the original number 
	CP R18, R25
	BRLO nonDivFiveCarry
	RJMP checkThreeHundred

nonDivFiveCarry:
	INC R19

; Use R21:R22
checkThreeHundred:
	CPI R21, 1						; CMP Low bit of 300 to 1 
	BRLO decHigh					; if low bit is less than 1, jump to dechigh
	DEC R21							; dec the counter of r21 and jump to top
	RJMP startProgram

decHigh:
	CPI R22, 1						; compare high bit (0x01) to 1
	BRLO done						; if not 0, do not finish program
	DEC R22							; decrement high bit
	LDI R21, 0xFF					; load 0xFF into low bit register
	DEC R21							; decrement the low bit reg 
	RJMP startProgram				; start program again

done:
































