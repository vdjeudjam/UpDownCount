# MPLAB IDE generated this makefile for use with GNU make.
# Project: 7Segment_Display.mcp
# Date: Mon Jun 01 18:23:44 2015

AS = MPASMWIN.exe
CC = mcc18.exe
LD = mplink.exe
AR = mplib.exe
RM = rm

Segment_Display.cof : Segment_Display.o
	$(LD) /p16F84A "Segment_Display.o" /u_DEBUG /z__MPLAB_BUILD=1 /z__MPLAB_DEBUG=1 /o"Segment_Display.cof" /M"Segment_Display.map" /W /x

Segment_Display.o : Segment_Display.asm ../../../../../Program\ Files\ (x86)/Microchip/MPASM\ Suite/p16f84A.inc
	$(AS) /q /p16F84A "Segment_Display.asm" /l"Segment_Display.lst" /e"Segment_Display.err" /d__DEBUG=1

clean : 
	$(RM) "Segment_Display.o" "Segment_Display.hex" "Segment_Display.err" "Segment_Display.lst" "Segment_Display.cof"

