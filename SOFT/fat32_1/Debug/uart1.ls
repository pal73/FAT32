   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32.1 - 30 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  16                     	switch	.data
  17  0000               _bOUT_FREE:
  18  0000 00            	dc.b	0
  19                     	bsct
  20  0000               _UIB:
  21  0000 00            	dc.b	0
  22  0001 00            	dc.b	0
  23  0002 00            	dc.b	0
  24  0003 00            	dc.b	0
  25  0004 00            	dc.b	0
  26  0005 00            	dc.b	0
  27  0006 00            	dc.b	0
  28  0007 00            	dc.b	0
  29  0008 00            	dc.b	0
  30  0009 00            	dc.b	0
  31  000a 000000000000  	ds.b	70
  32                     	switch	.data
  33  0001               _tx_wr_index:
  34  0001 00            	dc.b	0
  35  0002               _tx_rd_index:
  36  0002 00            	dc.b	0
  37  0003               _tx_counter:
  38  0003 00            	dc.b	0
  39  0004               _rx_wr_index:
  40  0004 00            	dc.b	0
  41  0005               _rx_rd_index:
  42  0005 00            	dc.b	0
  43  0006               _rx_counter:
  44  0006 00            	dc.b	0
  45                     	bsct
  46  0050               _tx_buffer:
  47  0050 00            	dc.b	0
  48  0051 000000000000  	ds.b	79
  49                     	switch	.data
  50  0007               _bRXIN:
  51  0007 00            	dc.b	0
  52                     	bsct
  53  00a0               _flag:
  54  00a0 00            	dc.b	0
  55  00a1               _rx_buffer:
  56  00a1 00            	dc.b	0
  57  00a2 000000000000  	ds.b	79
  58                     	switch	.data
  59  0008               _rx_buffer_overflow:
  60  0008 00            	dc.b	0
  89                     ; 21 void uart_init (void){
  91                     	switch	.text
  92  0000               _uart_init:
  96                     ; 22 	UART1->CR1&=~UART1_CR1_M;					
  98  0000 72195234      	bres	21044,#4
  99                     ; 23 	UART1->CR3|= (0<<4) & UART1_CR3_STOP;	
 101  0004 c65236        	ld	a,21046
 102                     ; 24 	UART1->BRR2= 0x01;//0x03;
 104  0007 35015233      	mov	21043,#1
 105                     ; 25 	UART1->BRR1= 0x1a;//0x68;
 107  000b 351a5232      	mov	21042,#26
 108                     ; 26 	UART1->CR2|= UART1_CR2_TEN | UART3_CR2_REN | UART3_CR2_RIEN;	
 110  000f c65235        	ld	a,21045
 111  0012 aa2c          	or	a,#44
 112  0014 c75235        	ld	21045,a
 113                     ; 27 }
 116  0017 81            	ret
 234                     ; 30 void uart_out (char num,char data0,char data1,char data2,char data3,char data4,char data5){
 235                     	switch	.text
 236  0018               _uart_out:
 238  0018 89            	pushw	x
 239  0019 520c          	subw	sp,#12
 240       0000000c      OFST:	set	12
 243                     ; 31 	char i=0,t=0,UOB[10];
 247  001b 0f01          	clr	(OFST-11,sp)
 248                     ; 34 	UOB[0]=data0;
 250  001d 9f            	ld	a,xl
 251  001e 6b02          	ld	(OFST-10,sp),a
 252                     ; 35 	UOB[1]=data1;
 254  0020 7b11          	ld	a,(OFST+5,sp)
 255  0022 6b03          	ld	(OFST-9,sp),a
 256                     ; 36 	UOB[2]=data2;
 258  0024 7b12          	ld	a,(OFST+6,sp)
 259  0026 6b04          	ld	(OFST-8,sp),a
 260                     ; 37 	UOB[3]=data3;
 262  0028 7b13          	ld	a,(OFST+7,sp)
 263  002a 6b05          	ld	(OFST-7,sp),a
 264                     ; 38 	UOB[4]=data4;
 266  002c 7b14          	ld	a,(OFST+8,sp)
 267  002e 6b06          	ld	(OFST-6,sp),a
 268                     ; 39 	UOB[5]=data5;
 270  0030 7b15          	ld	a,(OFST+9,sp)
 271  0032 6b07          	ld	(OFST-5,sp),a
 272                     ; 40 	for (i=0;i<num;i++)
 274  0034 0f0c          	clr	(OFST+0,sp)
 276  0036 2013          	jra	L701
 277  0038               L301:
 278                     ; 42 		t^=UOB[i];
 280  0038 96            	ldw	x,sp
 281  0039 1c0002        	addw	x,#OFST-10
 282  003c 9f            	ld	a,xl
 283  003d 5e            	swapw	x
 284  003e 1b0c          	add	a,(OFST+0,sp)
 285  0040 2401          	jrnc	L01
 286  0042 5c            	incw	x
 287  0043               L01:
 288  0043 02            	rlwa	x,a
 289  0044 7b01          	ld	a,(OFST-11,sp)
 290  0046 f8            	xor	a,	(x)
 291  0047 6b01          	ld	(OFST-11,sp),a
 292                     ; 40 	for (i=0;i<num;i++)
 294  0049 0c0c          	inc	(OFST+0,sp)
 295  004b               L701:
 298  004b 7b0c          	ld	a,(OFST+0,sp)
 299  004d 110d          	cp	a,(OFST+1,sp)
 300  004f 25e7          	jrult	L301
 301                     ; 44 	UOB[num]=num;
 303  0051 96            	ldw	x,sp
 304  0052 1c0002        	addw	x,#OFST-10
 305  0055 9f            	ld	a,xl
 306  0056 5e            	swapw	x
 307  0057 1b0d          	add	a,(OFST+1,sp)
 308  0059 2401          	jrnc	L21
 309  005b 5c            	incw	x
 310  005c               L21:
 311  005c 02            	rlwa	x,a
 312  005d 7b0d          	ld	a,(OFST+1,sp)
 313  005f f7            	ld	(x),a
 314                     ; 45 	t^=UOB[num];
 316  0060 96            	ldw	x,sp
 317  0061 1c0002        	addw	x,#OFST-10
 318  0064 9f            	ld	a,xl
 319  0065 5e            	swapw	x
 320  0066 1b0d          	add	a,(OFST+1,sp)
 321  0068 2401          	jrnc	L41
 322  006a 5c            	incw	x
 323  006b               L41:
 324  006b 02            	rlwa	x,a
 325  006c 7b01          	ld	a,(OFST-11,sp)
 326  006e f8            	xor	a,	(x)
 327  006f 6b01          	ld	(OFST-11,sp),a
 328                     ; 46 	UOB[num+1]=t;
 330  0071 96            	ldw	x,sp
 331  0072 1c0003        	addw	x,#OFST-9
 332  0075 9f            	ld	a,xl
 333  0076 5e            	swapw	x
 334  0077 1b0d          	add	a,(OFST+1,sp)
 335  0079 2401          	jrnc	L61
 336  007b 5c            	incw	x
 337  007c               L61:
 338  007c 02            	rlwa	x,a
 339  007d 7b01          	ld	a,(OFST-11,sp)
 340  007f f7            	ld	(x),a
 341                     ; 47 	UOB[num+2]=END;
 343  0080 96            	ldw	x,sp
 344  0081 1c0004        	addw	x,#OFST-8
 345  0084 9f            	ld	a,xl
 346  0085 5e            	swapw	x
 347  0086 1b0d          	add	a,(OFST+1,sp)
 348  0088 2401          	jrnc	L02
 349  008a 5c            	incw	x
 350  008b               L02:
 351  008b 02            	rlwa	x,a
 352  008c a60a          	ld	a,#10
 353  008e f7            	ld	(x),a
 354                     ; 51 	for (i=0;i<num+3;i++)
 356  008f 0f0c          	clr	(OFST+0,sp)
 358  0091 2012          	jra	L711
 359  0093               L311:
 360                     ; 53 		putchar(UOB[i]);
 362  0093 96            	ldw	x,sp
 363  0094 1c0002        	addw	x,#OFST-10
 364  0097 9f            	ld	a,xl
 365  0098 5e            	swapw	x
 366  0099 1b0c          	add	a,(OFST+0,sp)
 367  009b 2401          	jrnc	L22
 368  009d 5c            	incw	x
 369  009e               L22:
 370  009e 02            	rlwa	x,a
 371  009f f6            	ld	a,(x)
 372  00a0 cd0156        	call	_putchar
 374                     ; 51 	for (i=0;i<num+3;i++)
 376  00a3 0c0c          	inc	(OFST+0,sp)
 377  00a5               L711:
 380  00a5 9c            	rvf
 381  00a6 7b0c          	ld	a,(OFST+0,sp)
 382  00a8 5f            	clrw	x
 383  00a9 97            	ld	xl,a
 384  00aa 7b0d          	ld	a,(OFST+1,sp)
 385  00ac 905f          	clrw	y
 386  00ae 9097          	ld	yl,a
 387  00b0 72a90003      	addw	y,#3
 388  00b4 bf00          	ldw	c_x,x
 389  00b6 90b300        	cpw	y,c_x
 390  00b9 2cd8          	jrsgt	L311
 391                     ; 56 	bOUT_FREE=0;	  	
 393  00bb 725f0000      	clr	_bOUT_FREE
 394                     ; 57 }
 397  00bf 5b0e          	addw	sp,#14
 398  00c1 81            	ret
 480                     ; 87 void uart_out_adr_block (unsigned long adress,char *ptr, char len)
 480                     ; 88 {
 481                     	switch	.text
 482  00c2               _uart_out_adr_block:
 484  00c2 5203          	subw	sp,#3
 485       00000003      OFST:	set	3
 488                     ; 92 t=0;
 490  00c4 0f02          	clr	(OFST-1,sp)
 491                     ; 93 temp11=CMND;
 493                     ; 94 t^=temp11;
 495  00c6 7b02          	ld	a,(OFST-1,sp)
 496  00c8 a816          	xor	a,	#22
 497  00ca 6b02          	ld	(OFST-1,sp),a
 498                     ; 95 putchar(temp11);
 500  00cc a616          	ld	a,#22
 501  00ce cd0156        	call	_putchar
 503                     ; 97 temp11=10;
 505                     ; 98 t^=temp11;
 507  00d1 7b02          	ld	a,(OFST-1,sp)
 508  00d3 a80a          	xor	a,	#10
 509  00d5 6b02          	ld	(OFST-1,sp),a
 510                     ; 99 putchar(temp11);
 512  00d7 a60a          	ld	a,#10
 513  00d9 ad7b          	call	_putchar
 515                     ; 101 temp11=(*((char*)&adress));
 517  00db 7b06          	ld	a,(OFST+3,sp)
 518  00dd 6b03          	ld	(OFST+0,sp),a
 519                     ; 102 t^=temp11;
 521  00df 7b02          	ld	a,(OFST-1,sp)
 522  00e1 1803          	xor	a,	(OFST+0,sp)
 523  00e3 6b02          	ld	(OFST-1,sp),a
 524                     ; 103 putchar(temp11);
 526  00e5 7b03          	ld	a,(OFST+0,sp)
 527  00e7 ad6d          	call	_putchar
 529                     ; 105 temp11=(*(((char*)&adress)+1));
 531  00e9 7b07          	ld	a,(OFST+4,sp)
 532  00eb 6b03          	ld	(OFST+0,sp),a
 533                     ; 106 t^=temp11;
 535  00ed 7b02          	ld	a,(OFST-1,sp)
 536  00ef 1803          	xor	a,	(OFST+0,sp)
 537  00f1 6b02          	ld	(OFST-1,sp),a
 538                     ; 107 putchar(temp11);
 540  00f3 7b03          	ld	a,(OFST+0,sp)
 541  00f5 ad5f          	call	_putchar
 543                     ; 109 temp11=(*(((char*)&adress)+2));
 545  00f7 7b08          	ld	a,(OFST+5,sp)
 546  00f9 6b03          	ld	(OFST+0,sp),a
 547                     ; 110 t^=temp11;
 549  00fb 7b02          	ld	a,(OFST-1,sp)
 550  00fd 1803          	xor	a,	(OFST+0,sp)
 551  00ff 6b02          	ld	(OFST-1,sp),a
 552                     ; 111 putchar(temp11);
 554  0101 7b03          	ld	a,(OFST+0,sp)
 555  0103 ad51          	call	_putchar
 557                     ; 113 temp11=(*(((char*)&adress)+3));
 559  0105 7b09          	ld	a,(OFST+6,sp)
 560  0107 6b03          	ld	(OFST+0,sp),a
 561                     ; 114 t^=temp11;
 563  0109 7b02          	ld	a,(OFST-1,sp)
 564  010b 1803          	xor	a,	(OFST+0,sp)
 565  010d 6b02          	ld	(OFST-1,sp),a
 566                     ; 115 putchar(temp11);
 568  010f 7b03          	ld	a,(OFST+0,sp)
 569  0111 ad43          	call	_putchar
 571                     ; 118 for(i11=0;i11<len;i11++)
 573  0113 0f01          	clr	(OFST-2,sp)
 575  0115 201a          	jra	L171
 576  0117               L561:
 577                     ; 120 	temp11=ptr[i11];
 579  0117 7b0a          	ld	a,(OFST+7,sp)
 580  0119 97            	ld	xl,a
 581  011a 7b0b          	ld	a,(OFST+8,sp)
 582  011c 1b01          	add	a,(OFST-2,sp)
 583  011e 2401          	jrnc	L62
 584  0120 5c            	incw	x
 585  0121               L62:
 586  0121 02            	rlwa	x,a
 587  0122 f6            	ld	a,(x)
 588  0123 6b03          	ld	(OFST+0,sp),a
 589                     ; 121 	t^=temp11;
 591  0125 7b02          	ld	a,(OFST-1,sp)
 592  0127 1803          	xor	a,	(OFST+0,sp)
 593  0129 6b02          	ld	(OFST-1,sp),a
 594                     ; 122 	putchar(temp11);
 596  012b 7b03          	ld	a,(OFST+0,sp)
 597  012d ad27          	call	_putchar
 599                     ; 118 for(i11=0;i11<len;i11++)
 601  012f 0c01          	inc	(OFST-2,sp)
 602  0131               L171:
 605  0131 7b01          	ld	a,(OFST-2,sp)
 606  0133 110c          	cp	a,(OFST+9,sp)
 607  0135 25e0          	jrult	L561
 608                     ; 125 temp11=(len+6);
 610  0137 7b0c          	ld	a,(OFST+9,sp)
 611  0139 ab06          	add	a,#6
 612  013b 6b03          	ld	(OFST+0,sp),a
 613                     ; 126 t^=temp11;
 615  013d 7b02          	ld	a,(OFST-1,sp)
 616  013f 1803          	xor	a,	(OFST+0,sp)
 617  0141 6b02          	ld	(OFST-1,sp),a
 618                     ; 127 putchar(temp11);
 620  0143 7b03          	ld	a,(OFST+0,sp)
 621  0145 ad0f          	call	_putchar
 623                     ; 129 putchar(t);
 625  0147 7b02          	ld	a,(OFST-1,sp)
 626  0149 ad0b          	call	_putchar
 628                     ; 131 putchar(0x0a);
 630  014b a60a          	ld	a,#10
 631  014d ad07          	call	_putchar
 633                     ; 133 bOUT_FREE=0;	   
 635  014f 725f0000      	clr	_bOUT_FREE
 636                     ; 134 }
 639  0153 5b03          	addw	sp,#3
 640  0155 81            	ret
 677                     ; 137 void putchar(char c)
 677                     ; 138 {
 678                     	switch	.text
 679  0156               _putchar:
 681  0156 88            	push	a
 682       00000000      OFST:	set	0
 685  0157               L512:
 686                     ; 139 while (tx_counter == TX_BUFFER_SIZE);
 688  0157 c60003        	ld	a,_tx_counter
 689  015a a150          	cp	a,#80
 690  015c 27f9          	jreq	L512
 691                     ; 141 if (tx_counter || ((UART1->SR & UART1_SR_TXE)==0))
 693  015e 725d0003      	tnz	_tx_counter
 694  0162 2607          	jrne	L322
 696  0164 c65230        	ld	a,21040
 697  0167 a580          	bcp	a,#128
 698  0169 2622          	jrne	L122
 699  016b               L322:
 700                     ; 143    tx_buffer[tx_wr_index]=c;
 702  016b c60001        	ld	a,_tx_wr_index
 703  016e 5f            	clrw	x
 704  016f 97            	ld	xl,a
 705  0170 7b01          	ld	a,(OFST+1,sp)
 706  0172 e750          	ld	(_tx_buffer,x),a
 707                     ; 144    if (++tx_wr_index == TX_BUFFER_SIZE) tx_wr_index=0;
 709  0174 725c0001      	inc	_tx_wr_index
 710  0178 c60001        	ld	a,_tx_wr_index
 711  017b a150          	cp	a,#80
 712  017d 2604          	jrne	L522
 715  017f 725f0001      	clr	_tx_wr_index
 716  0183               L522:
 717                     ; 145    ++tx_counter;
 719  0183 725c0003      	inc	_tx_counter
 721  0187               L722:
 722                     ; 149 UART1->CR2|= UART1_CR2_TIEN;
 724  0187 721e5235      	bset	21045,#7
 725                     ; 151 }
 728  018b 84            	pop	a
 729  018c 81            	ret
 730  018d               L122:
 731                     ; 147 else UART1->DR=c;
 733  018d 7b01          	ld	a,(OFST+1,sp)
 734  018f c75231        	ld	21041,a
 735  0192 20f3          	jra	L722
 762                     ; 155 @far @interrupt void UARTTxInterrupt (void) {
 764                     	switch	.text
 765  0194               f_UARTTxInterrupt:
 769                     ; 162 	if (tx_counter){
 771  0194 725d0003      	tnz	_tx_counter
 772  0198 271f          	jreq	L142
 773                     ; 163 		--tx_counter;
 775  019a 725a0003      	dec	_tx_counter
 776                     ; 164 		UART1->DR=tx_buffer[tx_rd_index];
 778  019e c60002        	ld	a,_tx_rd_index
 779  01a1 5f            	clrw	x
 780  01a2 97            	ld	xl,a
 781  01a3 e650          	ld	a,(_tx_buffer,x)
 782  01a5 c75231        	ld	21041,a
 783                     ; 165 		if (++tx_rd_index == TX_BUFFER_SIZE) tx_rd_index=0;
 785  01a8 725c0002      	inc	_tx_rd_index
 786  01ac c60002        	ld	a,_tx_rd_index
 787  01af a150          	cp	a,#80
 788  01b1 260e          	jrne	L542
 791  01b3 725f0002      	clr	_tx_rd_index
 792  01b7 2008          	jra	L542
 793  01b9               L142:
 794                     ; 168 		bOUT_FREE=1;
 796  01b9 35010000      	mov	_bOUT_FREE,#1
 797                     ; 169 		UART1->CR2&= ~UART1_CR2_TIEN;
 799  01bd 721f5235      	bres	21045,#7
 800  01c1               L542:
 801                     ; 171 }
 804  01c1 80            	iret
 857                     ; 210 void uart_in(void)
 857                     ; 211 {
 859                     	switch	.text
 860  01c2               _uart_in:
 862  01c2 89            	pushw	x
 863       00000002      OFST:	set	2
 866                     ; 214 disableInterrupts();
 869  01c3 9b            sim
 871                     ; 215 if(rx_buffer_overflow)
 874  01c4 725d0008      	tnz	_rx_buffer_overflow
 875  01c8 2710          	jreq	L172
 876                     ; 217 	rx_wr_index=0;
 878  01ca 725f0004      	clr	_rx_wr_index
 879                     ; 218 	rx_rd_index=0;
 881  01ce 725f0005      	clr	_rx_rd_index
 882                     ; 219 	rx_counter=0;
 884  01d2 725f0006      	clr	_rx_counter
 885                     ; 220 	rx_buffer_overflow=0;
 887  01d6 725f0008      	clr	_rx_buffer_overflow
 888  01da               L172:
 889                     ; 223 if(rx_counter&&(rx_buffer[index_offset(rx_wr_index,-1)])==END)
 891  01da 725d0006      	tnz	_rx_counter
 892  01de 2775          	jreq	L372
 894  01e0 aeffff        	ldw	x,#65535
 895  01e3 c60004        	ld	a,_rx_wr_index
 896  01e6 95            	ld	xh,a
 897  01e7 cd0000        	call	_index_offset
 899  01ea 5f            	clrw	x
 900  01eb 97            	ld	xl,a
 901  01ec e6a1          	ld	a,(_rx_buffer,x)
 902  01ee a10a          	cp	a,#10
 903  01f0 2663          	jrne	L372
 904                     ; 226     temp=rx_buffer[index_offset(rx_wr_index,-3)];
 906  01f2 aefffd        	ldw	x,#65533
 907  01f5 c60004        	ld	a,_rx_wr_index
 908  01f8 95            	ld	xh,a
 909  01f9 cd0000        	call	_index_offset
 911  01fc 5f            	clrw	x
 912  01fd 97            	ld	xl,a
 913  01fe e6a1          	ld	a,(_rx_buffer,x)
 914  0200 6b01          	ld	(OFST-1,sp),a
 915                     ; 227     	if(temp<100) 
 917  0202 7b01          	ld	a,(OFST-1,sp)
 918  0204 a164          	cp	a,#100
 919  0206 244d          	jruge	L372
 920                     ; 229     		if(control_check(index_offset(rx_wr_index,-1)))
 922  0208 aeffff        	ldw	x,#65535
 923  020b c60004        	ld	a,_rx_wr_index
 924  020e 95            	ld	xh,a
 925  020f cd0000        	call	_index_offset
 927  0212 cd0000        	call	_control_check
 929  0215 4d            	tnz	a
 930  0216 273d          	jreq	L372
 931                     ; 232     			rx_rd_index=index_offset(rx_wr_index,-3-temp);
 933  0218 a6fd          	ld	a,#253
 934  021a 1001          	sub	a,(OFST-1,sp)
 935  021c 97            	ld	xl,a
 936  021d c60004        	ld	a,_rx_wr_index
 937  0220 95            	ld	xh,a
 938  0221 cd0000        	call	_index_offset
 940  0224 c70005        	ld	_rx_rd_index,a
 941                     ; 233     			for(i=0;i<temp;i++)
 943  0227 0f02          	clr	(OFST+0,sp)
 945  0229 2018          	jra	L503
 946  022b               L103:
 947                     ; 235 				UIB[i]=rx_buffer[index_offset(rx_rd_index,i)];
 949  022b 7b02          	ld	a,(OFST+0,sp)
 950  022d 5f            	clrw	x
 951  022e 97            	ld	xl,a
 952  022f 89            	pushw	x
 953  0230 7b04          	ld	a,(OFST+2,sp)
 954  0232 97            	ld	xl,a
 955  0233 c60005        	ld	a,_rx_rd_index
 956  0236 95            	ld	xh,a
 957  0237 cd0000        	call	_index_offset
 959  023a 5f            	clrw	x
 960  023b 97            	ld	xl,a
 961  023c e6a1          	ld	a,(_rx_buffer,x)
 962  023e 85            	popw	x
 963  023f e700          	ld	(_UIB,x),a
 964                     ; 233     			for(i=0;i<temp;i++)
 966  0241 0c02          	inc	(OFST+0,sp)
 967  0243               L503:
 970  0243 7b02          	ld	a,(OFST+0,sp)
 971  0245 1101          	cp	a,(OFST-1,sp)
 972  0247 25e2          	jrult	L103
 973                     ; 237 			rx_rd_index=rx_wr_index;
 975  0249 5500040005    	mov	_rx_rd_index,_rx_wr_index
 976                     ; 238 			rx_counter=0;
 978  024e 725f0006      	clr	_rx_counter
 979                     ; 239 			uart_in_an();
 981  0252 cd0000        	call	_uart_in_an
 983  0255               L372:
 984                     ; 247 enableInterrupts();
 987  0255 9a            rim
 989                     ; 248 } 
 993  0256 85            	popw	x
 994  0257 81            	ret
1042                     ; 252 @far @interrupt void UARTRxInterrupt (void) {
1044                     	switch	.text
1045  0258               f_UARTRxInterrupt:
1047       00000002      OFST:	set	2
1048  0258 89            	pushw	x
1051                     ; 256 	char status=0,data=0;
1055                     ; 260 	status=UART1->SR;
1057  0259 c65230        	ld	a,21040
1058  025c 6b01          	ld	(OFST-1,sp),a
1059                     ; 261 	data=UART1->DR;
1061  025e c65231        	ld	a,21041
1062  0261 6b02          	ld	(OFST+0,sp),a
1063                     ; 263 	if (status & (UART1_SR_RXNE)){
1065  0263 7b01          	ld	a,(OFST-1,sp)
1066  0265 a520          	bcp	a,#32
1067  0267 272f          	jreq	L333
1068                     ; 264 		rx_buffer[rx_wr_index]=data;
1070  0269 c60004        	ld	a,_rx_wr_index
1071  026c 5f            	clrw	x
1072  026d 97            	ld	xl,a
1073  026e 7b02          	ld	a,(OFST+0,sp)
1074  0270 e7a1          	ld	(_rx_buffer,x),a
1075                     ; 265 		bRXIN=1;
1077  0272 35010007      	mov	_bRXIN,#1
1078                     ; 266 		if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
1080  0276 725c0004      	inc	_rx_wr_index
1081  027a c60004        	ld	a,_rx_wr_index
1082  027d a150          	cp	a,#80
1083  027f 2604          	jrne	L533
1086  0281 725f0004      	clr	_rx_wr_index
1087  0285               L533:
1088                     ; 267 		if (++rx_counter == RX_BUFFER_SIZE){
1090  0285 725c0006      	inc	_rx_counter
1091  0289 c60006        	ld	a,_rx_counter
1092  028c a150          	cp	a,#80
1093  028e 2608          	jrne	L333
1094                     ; 268 			rx_counter=0;
1096  0290 725f0006      	clr	_rx_counter
1097                     ; 269 			rx_buffer_overflow=1;
1099  0294 35010008      	mov	_rx_buffer_overflow,#1
1100  0298               L333:
1101                     ; 272 }
1104  0298 5b02          	addw	sp,#2
1105  029a 80            	iret
1239                     	xref	_control_check
1240                     	xref	_index_offset
1241                     	xref	_uart_in_an
1242                     	xdef	_uart_in
1243                     	xdef	f_UARTRxInterrupt
1244                     	xdef	f_UARTTxInterrupt
1245                     	xdef	_uart_out_adr_block
1246                     	xdef	_putchar
1247                     	xdef	_uart_out
1248                     	xdef	_uart_init
1249                     	xdef	_UIB
1250                     	xdef	_rx_buffer_overflow
1251                     	xdef	_rx_buffer
1252                     	xdef	_flag
1253                     	xdef	_bRXIN
1254                     	xdef	_rx_counter
1255                     	xdef	_rx_rd_index
1256                     	xdef	_rx_wr_index
1257                     	xdef	_tx_counter
1258                     	xdef	_tx_rd_index
1259                     	xdef	_tx_wr_index
1260                     	xdef	_tx_buffer
1261                     	xdef	_bOUT_FREE
1262                     	xref.b	c_x
1281                     	end
