   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32.1 - 30 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  44                     ; 171 @far @interrupt void UARTTxInterrupt (void) {
  45                     	switch	.text
  46  0000               f_UARTTxInterrupt:
  50                     ; 188 }
  53  0000 80            	iret
  95                     ; 271 @far @interrupt void UARTRxInterrupt (void) {
  96                     	switch	.text
  97  0001               f_UARTRxInterrupt:
  99       00000002      OFST:	set	2
 100  0001 89            	pushw	x
 103                     ; 275 	char status=0,data=0;
 105  0002 0f01          	clr	(OFST-1,sp)
 108  0004 0f02          	clr	(OFST+0,sp)
 109                     ; 292 }
 112  0006 5b02          	addw	sp,#2
 113  0008 80            	iret
 125                     	xdef	f_UARTRxInterrupt
 126                     	xdef	f_UARTTxInterrupt
 145                     	end
