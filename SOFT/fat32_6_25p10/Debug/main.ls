   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32.1 - 30 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
2173                     	switch	.data
2174  0000               _t0_cnt0:
2175  0000 00            	dc.b	0
2176  0001               _t0_cnt1:
2177  0001 00            	dc.b	0
2178  0002               _t0_cnt2:
2179  0002 00            	dc.b	0
2180  0003               _t0_cnt3:
2181  0003 00            	dc.b	0
2182  0004               _tx_buffer:
2183  0004 00            	dc.b	0
2184  0005 000000000000  	ds.b	79
2185  0054               _rx_buffer:
2186  0054 00            	dc.b	0
2187  0055 000000000000  	ds.b	99
2188  00b8               _but_drv_cnt:
2189  00b8 00            	dc.b	0
2190  00b9               _but_on_drv_cnt:
2191  00b9 00            	dc.b	0
2192  00ba               _pwm_fade_in:
2193  00ba 00            	dc.b	0
2194  00bb               _rele_cnt_index:
2195  00bb 00            	dc.b	0
2196                     .const:	section	.text
2197  0000               _rele_cnt_const:
2198  0000 1e            	dc.b	30
2199  0001 32            	dc.b	50
2200  0002 46            	dc.b	70
2201                     	switch	.data
2202  00bc               _memory_manufacturer:
2203  00bc 53            	dc.b	83
2232                     ; 57 void t2_init(void){
2234                     	switch	.text
2235  0000               _t2_init:
2239                     ; 58 	TIM2->PSCR = 0;
2241  0000 725f530e      	clr	21262
2242                     ; 59 	TIM2->ARRH= 0x00;
2244  0004 725f530f      	clr	21263
2245                     ; 60 	TIM2->ARRL= 0xff;
2247  0008 35ff5310      	mov	21264,#255
2248                     ; 61 	TIM2->CCR1H= 0x00;	
2250  000c 725f5311      	clr	21265
2251                     ; 62 	TIM2->CCR1L= 200;
2253  0010 35c85312      	mov	21266,#200
2254                     ; 63 	TIM2->CCR2H= 0x00;	
2256  0014 725f5313      	clr	21267
2257                     ; 64 	TIM2->CCR2L= 200;
2259  0018 35c85314      	mov	21268,#200
2260                     ; 65 	TIM2->CCR3H= 0x00;	
2262  001c 725f5315      	clr	21269
2263                     ; 66 	TIM2->CCR3L= 50;
2265  0020 35325316      	mov	21270,#50
2266                     ; 69 	TIM2->CCMR2= ((6<<4) & TIM2_CCMR_OCM) | TIM2_CCMR_OCxPE; //OC2 toggle mode, prelouded
2268  0024 35685308      	mov	21256,#104
2269                     ; 70 	TIM2->CCMR3= ((6<<4) & TIM2_CCMR_OCM) | TIM2_CCMR_OCxPE; //OC2 toggle mode, prelouded
2271  0028 35685309      	mov	21257,#104
2272                     ; 71 	TIM2->CCER1= /*TIM2_CCER1_CC1E | TIM2_CCER1_CC1P |*/ TIM2_CCER1_CC2E | TIM2_CCER1_CC2P; //OC1, OC2 output pins enabled
2274  002c 3530530a      	mov	21258,#48
2275                     ; 73 	TIM2->CCER2= TIM2_CCER2_CC3E /*| TIM2_CCER2_CC3P*/; //OC1, OC2 output pins enabled
2277  0030 3501530b      	mov	21259,#1
2278                     ; 75 	TIM2->CR1=(TIM2_CR1_CEN | TIM2_CR1_ARPE);	
2280  0034 35815300      	mov	21248,#129
2281                     ; 77 }
2284  0038 81            	ret
2307                     ; 80 void t4_init(void){
2308                     	switch	.text
2309  0039               _t4_init:
2313                     ; 81 	TIM4->PSCR = 3;
2315  0039 35035347      	mov	21319,#3
2316                     ; 82 	TIM4->ARR= 158;
2318  003d 359e5348      	mov	21320,#158
2319                     ; 83 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
2321  0041 72105343      	bset	21315,#0
2322                     ; 85 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
2324  0045 35855340      	mov	21312,#133
2325                     ; 87 }
2328  0049 81            	ret
2352                     ; 90 void rele_drv(void) {
2353                     	switch	.text
2354  004a               _rele_drv:
2358                     ; 93 	if(rele_cnt) {
2360  004a ce01e3        	ldw	x,_rele_cnt
2361  004d 270f          	jreq	L1641
2362                     ; 94 		rele_cnt--;
2364  004f ce01e3        	ldw	x,_rele_cnt
2365  0052 1d0001        	subw	x,#1
2366  0055 cf01e3        	ldw	_rele_cnt,x
2367                     ; 95 		GPIOD->ODR|=(1<<4);
2369  0058 7218500f      	bset	20495,#4
2371  005c 2004          	jra	L3641
2372  005e               L1641:
2373                     ; 97 	else GPIOD->ODR&=~(1<<4); 
2375  005e 7219500f      	bres	20495,#4
2376  0062               L3641:
2377                     ; 112 }
2380  0062 81            	ret
2433                     ; 115 long delay_ms(short in)
2433                     ; 116 {
2434                     	switch	.text
2435  0063               _delay_ms:
2437  0063 520c          	subw	sp,#12
2438       0000000c      OFST:	set	12
2441                     ; 119 i=((long)in)*100UL;
2443  0065 90ae0064      	ldw	y,#100
2444  0069 cd0000        	call	c_vmul
2446  006c 96            	ldw	x,sp
2447  006d 1c0005        	addw	x,#OFST-7
2448  0070 cd0000        	call	c_rtol
2450                     ; 121 for(ii=0;ii<i;ii++)
2452  0073 ae0000        	ldw	x,#0
2453  0076 1f0b          	ldw	(OFST-1,sp),x
2454  0078 ae0000        	ldw	x,#0
2455  007b 1f09          	ldw	(OFST-3,sp),x
2457  007d 2012          	jra	L3151
2458  007f               L7051:
2459                     ; 123 		iii++;
2461  007f 96            	ldw	x,sp
2462  0080 1c0001        	addw	x,#OFST-11
2463  0083 a601          	ld	a,#1
2464  0085 cd0000        	call	c_lgadc
2466                     ; 121 for(ii=0;ii<i;ii++)
2468  0088 96            	ldw	x,sp
2469  0089 1c0009        	addw	x,#OFST-3
2470  008c a601          	ld	a,#1
2471  008e cd0000        	call	c_lgadc
2473  0091               L3151:
2476  0091 9c            	rvf
2477  0092 96            	ldw	x,sp
2478  0093 1c0009        	addw	x,#OFST-3
2479  0096 cd0000        	call	c_ltor
2481  0099 96            	ldw	x,sp
2482  009a 1c0005        	addw	x,#OFST-7
2483  009d cd0000        	call	c_lcmp
2485  00a0 2fdd          	jrslt	L7051
2486                     ; 126 }
2489  00a2 5b0c          	addw	sp,#12
2490  00a4 81            	ret
2513                     ; 129 void uart_init (void){
2514                     	switch	.text
2515  00a5               _uart_init:
2519                     ; 130 	GPIOD->DDR|=(1<<5);
2521  00a5 721a5011      	bset	20497,#5
2522                     ; 131 	GPIOD->CR1|=(1<<5);
2524  00a9 721a5012      	bset	20498,#5
2525                     ; 132 	GPIOD->CR2|=(1<<5);
2527  00ad 721a5013      	bset	20499,#5
2528                     ; 135 	GPIOD->DDR&=~(1<<6);
2530  00b1 721d5011      	bres	20497,#6
2531                     ; 136 	GPIOD->CR1&=~(1<<6);
2533  00b5 721d5012      	bres	20498,#6
2534                     ; 137 	GPIOD->CR2&=~(1<<6);
2536  00b9 721d5013      	bres	20499,#6
2537                     ; 140 	UART1->CR1&=~UART1_CR1_M;					
2539  00bd 72195234      	bres	21044,#4
2540                     ; 141 	UART1->CR3|= (0<<4) & UART1_CR3_STOP;	
2542  00c1 c65236        	ld	a,21046
2543                     ; 142 	UART1->BRR2= 0x01;//0x03;
2545  00c4 35015233      	mov	21043,#1
2546                     ; 143 	UART1->BRR1= 0x1a;//0x68;
2548  00c8 351a5232      	mov	21042,#26
2549                     ; 144 	UART1->CR2|= UART1_CR2_TEN | UART3_CR2_REN | UART3_CR2_RIEN;	
2551  00cc c65235        	ld	a,21045
2552  00cf aa2c          	or	a,#44
2553  00d1 c75235        	ld	21045,a
2554                     ; 145 }
2557  00d4 81            	ret
2657                     ; 148 void uart_out (char num,char data0,char data1,char data2,char data3,char data4,char data5){
2658                     	switch	.text
2659  00d5               _uart_out:
2661  00d5 89            	pushw	x
2662  00d6 520c          	subw	sp,#12
2663       0000000c      OFST:	set	12
2666                     ; 149 	char i=0,t=0,UOB[10];
2670  00d8 0f01          	clr	(OFST-11,sp)
2671                     ; 152 	UOB[0]=data0;
2673  00da 9f            	ld	a,xl
2674  00db 6b02          	ld	(OFST-10,sp),a
2675                     ; 153 	UOB[1]=data1;
2677  00dd 7b11          	ld	a,(OFST+5,sp)
2678  00df 6b03          	ld	(OFST-9,sp),a
2679                     ; 154 	UOB[2]=data2;
2681  00e1 7b12          	ld	a,(OFST+6,sp)
2682  00e3 6b04          	ld	(OFST-8,sp),a
2683                     ; 155 	UOB[3]=data3;
2685  00e5 7b13          	ld	a,(OFST+7,sp)
2686  00e7 6b05          	ld	(OFST-7,sp),a
2687                     ; 156 	UOB[4]=data4;
2689  00e9 7b14          	ld	a,(OFST+8,sp)
2690  00eb 6b06          	ld	(OFST-6,sp),a
2691                     ; 157 	UOB[5]=data5;
2693  00ed 7b15          	ld	a,(OFST+9,sp)
2694  00ef 6b07          	ld	(OFST-5,sp),a
2695                     ; 158 	for (i=0;i<num;i++)
2697  00f1 0f0c          	clr	(OFST+0,sp)
2699  00f3 2013          	jra	L3751
2700  00f5               L7651:
2701                     ; 160 		t^=UOB[i];
2703  00f5 96            	ldw	x,sp
2704  00f6 1c0002        	addw	x,#OFST-10
2705  00f9 9f            	ld	a,xl
2706  00fa 5e            	swapw	x
2707  00fb 1b0c          	add	a,(OFST+0,sp)
2708  00fd 2401          	jrnc	L02
2709  00ff 5c            	incw	x
2710  0100               L02:
2711  0100 02            	rlwa	x,a
2712  0101 7b01          	ld	a,(OFST-11,sp)
2713  0103 f8            	xor	a,	(x)
2714  0104 6b01          	ld	(OFST-11,sp),a
2715                     ; 158 	for (i=0;i<num;i++)
2717  0106 0c0c          	inc	(OFST+0,sp)
2718  0108               L3751:
2721  0108 7b0c          	ld	a,(OFST+0,sp)
2722  010a 110d          	cp	a,(OFST+1,sp)
2723  010c 25e7          	jrult	L7651
2724                     ; 162 	UOB[num]=num;
2726  010e 96            	ldw	x,sp
2727  010f 1c0002        	addw	x,#OFST-10
2728  0112 9f            	ld	a,xl
2729  0113 5e            	swapw	x
2730  0114 1b0d          	add	a,(OFST+1,sp)
2731  0116 2401          	jrnc	L22
2732  0118 5c            	incw	x
2733  0119               L22:
2734  0119 02            	rlwa	x,a
2735  011a 7b0d          	ld	a,(OFST+1,sp)
2736  011c f7            	ld	(x),a
2737                     ; 163 	t^=UOB[num];
2739  011d 96            	ldw	x,sp
2740  011e 1c0002        	addw	x,#OFST-10
2741  0121 9f            	ld	a,xl
2742  0122 5e            	swapw	x
2743  0123 1b0d          	add	a,(OFST+1,sp)
2744  0125 2401          	jrnc	L42
2745  0127 5c            	incw	x
2746  0128               L42:
2747  0128 02            	rlwa	x,a
2748  0129 7b01          	ld	a,(OFST-11,sp)
2749  012b f8            	xor	a,	(x)
2750  012c 6b01          	ld	(OFST-11,sp),a
2751                     ; 164 	UOB[num+1]=t;
2753  012e 96            	ldw	x,sp
2754  012f 1c0003        	addw	x,#OFST-9
2755  0132 9f            	ld	a,xl
2756  0133 5e            	swapw	x
2757  0134 1b0d          	add	a,(OFST+1,sp)
2758  0136 2401          	jrnc	L62
2759  0138 5c            	incw	x
2760  0139               L62:
2761  0139 02            	rlwa	x,a
2762  013a 7b01          	ld	a,(OFST-11,sp)
2763  013c f7            	ld	(x),a
2764                     ; 165 	UOB[num+2]=END;
2766  013d 96            	ldw	x,sp
2767  013e 1c0004        	addw	x,#OFST-8
2768  0141 9f            	ld	a,xl
2769  0142 5e            	swapw	x
2770  0143 1b0d          	add	a,(OFST+1,sp)
2771  0145 2401          	jrnc	L03
2772  0147 5c            	incw	x
2773  0148               L03:
2774  0148 02            	rlwa	x,a
2775  0149 a60a          	ld	a,#10
2776  014b f7            	ld	(x),a
2777                     ; 169 	for (i=0;i<num+3;i++)
2779  014c 0f0c          	clr	(OFST+0,sp)
2781  014e 2012          	jra	L3061
2782  0150               L7751:
2783                     ; 171 		putchar(UOB[i]);
2785  0150 96            	ldw	x,sp
2786  0151 1c0002        	addw	x,#OFST-10
2787  0154 9f            	ld	a,xl
2788  0155 5e            	swapw	x
2789  0156 1b0c          	add	a,(OFST+0,sp)
2790  0158 2401          	jrnc	L23
2791  015a 5c            	incw	x
2792  015b               L23:
2793  015b 02            	rlwa	x,a
2794  015c f6            	ld	a,(x)
2795  015d cd0899        	call	_putchar
2797                     ; 169 	for (i=0;i<num+3;i++)
2799  0160 0c0c          	inc	(OFST+0,sp)
2800  0162               L3061:
2803  0162 9c            	rvf
2804  0163 7b0c          	ld	a,(OFST+0,sp)
2805  0165 5f            	clrw	x
2806  0166 97            	ld	xl,a
2807  0167 7b0d          	ld	a,(OFST+1,sp)
2808  0169 905f          	clrw	y
2809  016b 9097          	ld	yl,a
2810  016d 72a90003      	addw	y,#3
2811  0171 bf00          	ldw	c_x,x
2812  0173 90b300        	cpw	y,c_x
2813  0176 2cd8          	jrsgt	L7751
2814                     ; 174 	bOUT_FREE=0;	  	
2816  0178 72110003      	bres	_bOUT_FREE
2817                     ; 175 }
2820  017c 5b0e          	addw	sp,#14
2821  017e 81            	ret
2893                     ; 178 void uart_out_adr_block (unsigned long adress,char *ptr, char len)
2893                     ; 179 {
2894                     	switch	.text
2895  017f               _uart_out_adr_block:
2897  017f 5203          	subw	sp,#3
2898       00000003      OFST:	set	3
2901                     ; 183 t=0;
2903  0181 0f02          	clr	(OFST-1,sp)
2904                     ; 184 temp11=CMND;
2906                     ; 185 t^=temp11;
2908  0183 7b02          	ld	a,(OFST-1,sp)
2909  0185 a816          	xor	a,	#22
2910  0187 6b02          	ld	(OFST-1,sp),a
2911                     ; 186 putchar(temp11);
2913  0189 a616          	ld	a,#22
2914  018b cd0899        	call	_putchar
2916                     ; 188 temp11=10;
2918                     ; 189 t^=temp11;
2920  018e 7b02          	ld	a,(OFST-1,sp)
2921  0190 a80a          	xor	a,	#10
2922  0192 6b02          	ld	(OFST-1,sp),a
2923                     ; 190 putchar(temp11);
2925  0194 a60a          	ld	a,#10
2926  0196 cd0899        	call	_putchar
2928                     ; 192 temp11=adress%256;//(*((char*)&adress));
2930  0199 7b09          	ld	a,(OFST+6,sp)
2931  019b a4ff          	and	a,#255
2932  019d 6b03          	ld	(OFST+0,sp),a
2933                     ; 193 t^=temp11;
2935  019f 7b02          	ld	a,(OFST-1,sp)
2936  01a1 1803          	xor	a,	(OFST+0,sp)
2937  01a3 6b02          	ld	(OFST-1,sp),a
2938                     ; 194 putchar(temp11);
2940  01a5 7b03          	ld	a,(OFST+0,sp)
2941  01a7 cd0899        	call	_putchar
2943                     ; 195 adress>>=8;
2945  01aa 96            	ldw	x,sp
2946  01ab 1c0006        	addw	x,#OFST+3
2947  01ae a608          	ld	a,#8
2948  01b0 cd0000        	call	c_lgursh
2950                     ; 196 temp11=adress%256;//(*(((char*)&adress)+1));
2952  01b3 7b09          	ld	a,(OFST+6,sp)
2953  01b5 a4ff          	and	a,#255
2954  01b7 6b03          	ld	(OFST+0,sp),a
2955                     ; 197 t^=temp11;
2957  01b9 7b02          	ld	a,(OFST-1,sp)
2958  01bb 1803          	xor	a,	(OFST+0,sp)
2959  01bd 6b02          	ld	(OFST-1,sp),a
2960                     ; 198 putchar(temp11);
2962  01bf 7b03          	ld	a,(OFST+0,sp)
2963  01c1 cd0899        	call	_putchar
2965                     ; 199 adress>>=8;
2967  01c4 96            	ldw	x,sp
2968  01c5 1c0006        	addw	x,#OFST+3
2969  01c8 a608          	ld	a,#8
2970  01ca cd0000        	call	c_lgursh
2972                     ; 200 temp11=adress%256;//(*(((char*)&adress)+2));
2974  01cd 7b09          	ld	a,(OFST+6,sp)
2975  01cf a4ff          	and	a,#255
2976  01d1 6b03          	ld	(OFST+0,sp),a
2977                     ; 201 t^=temp11;
2979  01d3 7b02          	ld	a,(OFST-1,sp)
2980  01d5 1803          	xor	a,	(OFST+0,sp)
2981  01d7 6b02          	ld	(OFST-1,sp),a
2982                     ; 202 putchar(temp11);
2984  01d9 7b03          	ld	a,(OFST+0,sp)
2985  01db cd0899        	call	_putchar
2987                     ; 203 adress>>=8;
2989  01de 96            	ldw	x,sp
2990  01df 1c0006        	addw	x,#OFST+3
2991  01e2 a608          	ld	a,#8
2992  01e4 cd0000        	call	c_lgursh
2994                     ; 204 temp11=adress%256;//(*(((char*)&adress)+3));
2996  01e7 7b09          	ld	a,(OFST+6,sp)
2997  01e9 a4ff          	and	a,#255
2998  01eb 6b03          	ld	(OFST+0,sp),a
2999                     ; 205 t^=temp11;
3001  01ed 7b02          	ld	a,(OFST-1,sp)
3002  01ef 1803          	xor	a,	(OFST+0,sp)
3003  01f1 6b02          	ld	(OFST-1,sp),a
3004                     ; 206 putchar(temp11);
3006  01f3 7b03          	ld	a,(OFST+0,sp)
3007  01f5 cd0899        	call	_putchar
3009                     ; 209 for(i11=0;i11<len;i11++)
3011  01f8 0f01          	clr	(OFST-2,sp)
3013  01fa 201b          	jra	L3461
3014  01fc               L7361:
3015                     ; 211 	temp11=ptr[i11];
3017  01fc 7b0a          	ld	a,(OFST+7,sp)
3018  01fe 97            	ld	xl,a
3019  01ff 7b0b          	ld	a,(OFST+8,sp)
3020  0201 1b01          	add	a,(OFST-2,sp)
3021  0203 2401          	jrnc	L63
3022  0205 5c            	incw	x
3023  0206               L63:
3024  0206 02            	rlwa	x,a
3025  0207 f6            	ld	a,(x)
3026  0208 6b03          	ld	(OFST+0,sp),a
3027                     ; 212 	t^=temp11;
3029  020a 7b02          	ld	a,(OFST-1,sp)
3030  020c 1803          	xor	a,	(OFST+0,sp)
3031  020e 6b02          	ld	(OFST-1,sp),a
3032                     ; 213 	putchar(temp11);
3034  0210 7b03          	ld	a,(OFST+0,sp)
3035  0212 cd0899        	call	_putchar
3037                     ; 209 for(i11=0;i11<len;i11++)
3039  0215 0c01          	inc	(OFST-2,sp)
3040  0217               L3461:
3043  0217 7b01          	ld	a,(OFST-2,sp)
3044  0219 110c          	cp	a,(OFST+9,sp)
3045  021b 25df          	jrult	L7361
3046                     ; 216 temp11=(len+6);
3048  021d 7b0c          	ld	a,(OFST+9,sp)
3049  021f ab06          	add	a,#6
3050  0221 6b03          	ld	(OFST+0,sp),a
3051                     ; 217 t^=temp11;
3053  0223 7b02          	ld	a,(OFST-1,sp)
3054  0225 1803          	xor	a,	(OFST+0,sp)
3055  0227 6b02          	ld	(OFST-1,sp),a
3056                     ; 218 putchar(temp11);
3058  0229 7b03          	ld	a,(OFST+0,sp)
3059  022b cd0899        	call	_putchar
3061                     ; 220 putchar(t);
3063  022e 7b02          	ld	a,(OFST-1,sp)
3064  0230 cd0899        	call	_putchar
3066                     ; 222 putchar(0x0a);
3068  0233 a60a          	ld	a,#10
3069  0235 cd0899        	call	_putchar
3071                     ; 224 bOUT_FREE=0;	   
3073  0238 72110003      	bres	_bOUT_FREE
3074                     ; 225 }
3077  023c 5b03          	addw	sp,#3
3078  023e 81            	ret
3196                     ; 227 void uart_in_an(void) {
3197                     	switch	.text
3198  023f               _uart_in_an:
3200  023f 5204          	subw	sp,#4
3201       00000004      OFST:	set	4
3204                     ; 230 	if(UIB[0]==CMND) {
3206  0241 c60000        	ld	a,_UIB
3207  0244 a116          	cp	a,#22
3208  0246 2703          	jreq	L24
3209  0248 cc0896        	jp	L3071
3210  024b               L24:
3211                     ; 231 		if(UIB[1]==1) {
3213  024b c60001        	ld	a,_UIB+1
3214  024e a101          	cp	a,#1
3215  0250 2631          	jrne	L5071
3216                     ; 235 			if(memory_manufacturer=='A') {
3218  0252 c600bc        	ld	a,_memory_manufacturer
3219  0255 a141          	cp	a,#65
3220  0257 2603          	jrne	L7071
3221                     ; 236 				temp_L=DF_mf_dev_read();
3223  0259 cd0a61        	call	_DF_mf_dev_read
3225  025c               L7071:
3226                     ; 238 			if(memory_manufacturer=='S') {
3228  025c c600bc        	ld	a,_memory_manufacturer
3229  025f a153          	cp	a,#83
3230  0261 2603          	jrne	L1171
3231                     ; 239 				temp_L=ST_RDID_read();
3233  0263 cd0966        	call	_ST_RDID_read
3235  0266               L1171:
3236                     ; 241 			uart_out (6,CMND,1,mdr0/**((char*)&temp_L)*/,mdr1/**(((char*)&temp_L)+1)*/,mdr2/**(((char*)&temp_L)+2)*/,mdr3/**(((char*)&temp_L)+3)*/);
3238  0266 3b01f3        	push	_mdr3
3239  0269 3b01f4        	push	_mdr2
3240  026c 3b01f5        	push	_mdr1
3241  026f 3b01f6        	push	_mdr0
3242  0272 4b01          	push	#1
3243  0274 ae0016        	ldw	x,#22
3244  0277 a606          	ld	a,#6
3245  0279 95            	ld	xh,a
3246  027a cd00d5        	call	_uart_out
3248  027d 5b05          	addw	sp,#5
3250  027f ac960896      	jpf	L3071
3251  0283               L5071:
3252                     ; 249 	else if(UIB[1]==2) {
3254  0283 c60001        	ld	a,_UIB+1
3255  0286 a102          	cp	a,#2
3256  0288 2632          	jrne	L5171
3257                     ; 252 		if(memory_manufacturer=='A') {
3259  028a c600bc        	ld	a,_memory_manufacturer
3260  028d a141          	cp	a,#65
3261  028f 2605          	jrne	L7171
3262                     ; 253 			temp=DF_status_read();
3264  0291 cd0ab9        	call	_DF_status_read
3266  0294 6b04          	ld	(OFST+0,sp),a
3267  0296               L7171:
3268                     ; 255 		if(memory_manufacturer=='S') {
3270  0296 c600bc        	ld	a,_memory_manufacturer
3271  0299 a153          	cp	a,#83
3272  029b 2605          	jrne	L1271
3273                     ; 256 			temp=ST_status_read();
3275  029d cd0995        	call	_ST_status_read
3277  02a0 6b04          	ld	(OFST+0,sp),a
3278  02a2               L1271:
3279                     ; 258 		uart_out (3,CMND,2,temp,0,0,0);    
3281  02a2 4b00          	push	#0
3282  02a4 4b00          	push	#0
3283  02a6 4b00          	push	#0
3284  02a8 7b07          	ld	a,(OFST+3,sp)
3285  02aa 88            	push	a
3286  02ab 4b02          	push	#2
3287  02ad ae0016        	ldw	x,#22
3288  02b0 a603          	ld	a,#3
3289  02b2 95            	ld	xh,a
3290  02b3 cd00d5        	call	_uart_out
3292  02b6 5b05          	addw	sp,#5
3294  02b8 ac960896      	jpf	L3071
3295  02bc               L5171:
3296                     ; 262 	else if(UIB[1]==3)
3298  02bc c60001        	ld	a,_UIB+1
3299  02bf a103          	cp	a,#3
3300  02c1 2624          	jrne	L5271
3301                     ; 265 		if(memory_manufacturer=='A') {
3303  02c3 c600bc        	ld	a,_memory_manufacturer
3304  02c6 a141          	cp	a,#65
3305  02c8 2603          	jrne	L7271
3306                     ; 266 			DF_memo_to_256();
3308  02ca cd0a9c        	call	_DF_memo_to_256
3310  02cd               L7271:
3311                     ; 268 		uart_out (2,CMND,3,temp,0,0,0);    
3313  02cd 4b00          	push	#0
3314  02cf 4b00          	push	#0
3315  02d1 4b00          	push	#0
3316  02d3 7b07          	ld	a,(OFST+3,sp)
3317  02d5 88            	push	a
3318  02d6 4b03          	push	#3
3319  02d8 ae0016        	ldw	x,#22
3320  02db a602          	ld	a,#2
3321  02dd 95            	ld	xh,a
3322  02de cd00d5        	call	_uart_out
3324  02e1 5b05          	addw	sp,#5
3326  02e3 ac960896      	jpf	L3071
3327  02e7               L5271:
3328                     ; 271 	else if(UIB[1]==4)
3330  02e7 c60001        	ld	a,_UIB+1
3331  02ea a104          	cp	a,#4
3332  02ec 2624          	jrne	L3371
3333                     ; 274 		if(memory_manufacturer=='A') {
3335  02ee c600bc        	ld	a,_memory_manufacturer
3336  02f1 a141          	cp	a,#65
3337  02f3 2603          	jrne	L5371
3338                     ; 275 			DF_memo_to_256();
3340  02f5 cd0a9c        	call	_DF_memo_to_256
3342  02f8               L5371:
3343                     ; 277 		uart_out (2,CMND,3,temp,0,0,0);    
3345  02f8 4b00          	push	#0
3346  02fa 4b00          	push	#0
3347  02fc 4b00          	push	#0
3348  02fe 7b07          	ld	a,(OFST+3,sp)
3349  0300 88            	push	a
3350  0301 4b03          	push	#3
3351  0303 ae0016        	ldw	x,#22
3352  0306 a602          	ld	a,#2
3353  0308 95            	ld	xh,a
3354  0309 cd00d5        	call	_uart_out
3356  030c 5b05          	addw	sp,#5
3358  030e ac960896      	jpf	L3071
3359  0312               L3371:
3360                     ; 280 	else if(UIB[1]==10)
3362  0312 c60001        	ld	a,_UIB+1
3363  0315 a10a          	cp	a,#10
3364  0317 2703cc03a0    	jrne	L1471
3365                     ; 284 		if(memory_manufacturer=='A') {
3367  031c c600bc        	ld	a,_memory_manufacturer
3368  031f a141          	cp	a,#65
3369  0321 2615          	jrne	L3471
3370                     ; 285 			if(UIB[2]==1)DF_buffer_read(/*1,*/0,256, buff);
3372  0323 c60002        	ld	a,_UIB+2
3373  0326 a101          	cp	a,#1
3374  0328 260e          	jrne	L3471
3377  032a ae0050        	ldw	x,#_buff
3378  032d 89            	pushw	x
3379  032e ae0100        	ldw	x,#256
3380  0331 89            	pushw	x
3381  0332 5f            	clrw	x
3382  0333 cd0b19        	call	_DF_buffer_read
3384  0336 5b04          	addw	sp,#4
3385  0338               L3471:
3386                     ; 290 		uart_out_adr_block (0,buff,64);
3388  0338 4b40          	push	#64
3389  033a ae0050        	ldw	x,#_buff
3390  033d 89            	pushw	x
3391  033e ae0000        	ldw	x,#0
3392  0341 89            	pushw	x
3393  0342 ae0000        	ldw	x,#0
3394  0345 89            	pushw	x
3395  0346 cd017f        	call	_uart_out_adr_block
3397  0349 5b07          	addw	sp,#7
3398                     ; 291 		delay_ms(100);    
3400  034b ae0064        	ldw	x,#100
3401  034e cd0063        	call	_delay_ms
3403                     ; 292 		uart_out_adr_block (64,&buff[64],64);
3405  0351 4b40          	push	#64
3406  0353 ae0090        	ldw	x,#_buff+64
3407  0356 89            	pushw	x
3408  0357 ae0040        	ldw	x,#64
3409  035a 89            	pushw	x
3410  035b ae0000        	ldw	x,#0
3411  035e 89            	pushw	x
3412  035f cd017f        	call	_uart_out_adr_block
3414  0362 5b07          	addw	sp,#7
3415                     ; 293 		delay_ms(100);    
3417  0364 ae0064        	ldw	x,#100
3418  0367 cd0063        	call	_delay_ms
3420                     ; 294 		uart_out_adr_block (128,&buff[128],64);
3422  036a 4b40          	push	#64
3423  036c ae00d0        	ldw	x,#_buff+128
3424  036f 89            	pushw	x
3425  0370 ae0080        	ldw	x,#128
3426  0373 89            	pushw	x
3427  0374 ae0000        	ldw	x,#0
3428  0377 89            	pushw	x
3429  0378 cd017f        	call	_uart_out_adr_block
3431  037b 5b07          	addw	sp,#7
3432                     ; 295 		delay_ms(100);    
3434  037d ae0064        	ldw	x,#100
3435  0380 cd0063        	call	_delay_ms
3437                     ; 296 		uart_out_adr_block (192,&buff[192],64);
3439  0383 4b40          	push	#64
3440  0385 ae0110        	ldw	x,#_buff+192
3441  0388 89            	pushw	x
3442  0389 ae00c0        	ldw	x,#192
3443  038c 89            	pushw	x
3444  038d ae0000        	ldw	x,#0
3445  0390 89            	pushw	x
3446  0391 cd017f        	call	_uart_out_adr_block
3448  0394 5b07          	addw	sp,#7
3449                     ; 297 		delay_ms(100);    
3451  0396 ae0064        	ldw	x,#100
3452  0399 cd0063        	call	_delay_ms
3455  039c ac960896      	jpf	L3071
3456  03a0               L1471:
3457                     ; 300 	else if(UIB[1]==11)
3459  03a0 c60001        	ld	a,_UIB+1
3460  03a3 a10b          	cp	a,#11
3461  03a5 2633          	jrne	L1571
3462                     ; 306 		for(i=0;i<256;i++)buff[i]=0;
3464  03a7 5f            	clrw	x
3465  03a8 1f03          	ldw	(OFST-1,sp),x
3466  03aa               L3571:
3469  03aa 1e03          	ldw	x,(OFST-1,sp)
3470  03ac 724f0050      	clr	(_buff,x)
3473  03b0 1e03          	ldw	x,(OFST-1,sp)
3474  03b2 1c0001        	addw	x,#1
3475  03b5 1f03          	ldw	(OFST-1,sp),x
3478  03b7 1e03          	ldw	x,(OFST-1,sp)
3479  03b9 a30100        	cpw	x,#256
3480  03bc 25ec          	jrult	L3571
3481                     ; 308 		if(UIB[2]==1)DF_buffer_write(/*1,*/0,256, buff);
3483  03be c60002        	ld	a,_UIB+2
3484  03c1 a101          	cp	a,#1
3485  03c3 2703          	jreq	L44
3486  03c5 cc0896        	jp	L3071
3487  03c8               L44:
3490  03c8 ae0050        	ldw	x,#_buff
3491  03cb 89            	pushw	x
3492  03cc ae0100        	ldw	x,#256
3493  03cf 89            	pushw	x
3494  03d0 5f            	clrw	x
3495  03d1 cd0b5f        	call	_DF_buffer_write
3497  03d4 5b04          	addw	sp,#4
3498  03d6 ac960896      	jpf	L3071
3499  03da               L1571:
3500                     ; 312 	else if(UIB[1]==12)
3502  03da c60001        	ld	a,_UIB+1
3503  03dd a10c          	cp	a,#12
3504  03df 2703          	jreq	L64
3505  03e1 cc04c0        	jp	L5671
3506  03e4               L64:
3507                     ; 318 		for(i=0;i<256;i++)buff[i]=0;
3509  03e4 5f            	clrw	x
3510  03e5 1f03          	ldw	(OFST-1,sp),x
3511  03e7               L7671:
3514  03e7 1e03          	ldw	x,(OFST-1,sp)
3515  03e9 724f0050      	clr	(_buff,x)
3518  03ed 1e03          	ldw	x,(OFST-1,sp)
3519  03ef 1c0001        	addw	x,#1
3520  03f2 1f03          	ldw	(OFST-1,sp),x
3523  03f4 1e03          	ldw	x,(OFST-1,sp)
3524  03f6 a30100        	cpw	x,#256
3525  03f9 25ec          	jrult	L7671
3526                     ; 320 		if(UIB[3]==1)
3528  03fb c60003        	ld	a,_UIB+3
3529  03fe a101          	cp	a,#1
3530  0400 2632          	jrne	L5771
3531                     ; 322 			buff[0]=0x00;
3533  0402 725f0050      	clr	_buff
3534                     ; 323 			buff[1]=0x11;
3536  0406 35110051      	mov	_buff+1,#17
3537                     ; 324 			buff[2]=0x22;
3539  040a 35220052      	mov	_buff+2,#34
3540                     ; 325 			buff[3]=0x33;
3542  040e 35330053      	mov	_buff+3,#51
3543                     ; 326 			buff[4]=0x44;
3545  0412 35440054      	mov	_buff+4,#68
3546                     ; 327 			buff[5]=0x55;
3548  0416 35550055      	mov	_buff+5,#85
3549                     ; 328 			buff[6]=0x66;
3551  041a 35660056      	mov	_buff+6,#102
3552                     ; 329 			buff[7]=0x77;
3554  041e 35770057      	mov	_buff+7,#119
3555                     ; 330 			buff[8]=0x88;
3557  0422 35880058      	mov	_buff+8,#136
3558                     ; 331 			buff[9]=0x99;
3560  0426 35990059      	mov	_buff+9,#153
3561                     ; 332 			buff[10]=0;
3563  042a 725f005a      	clr	_buff+10
3564                     ; 333 			buff[11]=0;
3566  042e 725f005b      	clr	_buff+11
3568  0432 2070          	jra	L7771
3569  0434               L5771:
3570                     ; 336 		else if(UIB[3]==2)
3572  0434 c60003        	ld	a,_UIB+3
3573  0437 a102          	cp	a,#2
3574  0439 2632          	jrne	L1002
3575                     ; 338 			buff[0]=0x00;
3577  043b 725f0050      	clr	_buff
3578                     ; 339 			buff[1]=0x10;
3580  043f 35100051      	mov	_buff+1,#16
3581                     ; 340 			buff[2]=0x20;
3583  0443 35200052      	mov	_buff+2,#32
3584                     ; 341 			buff[3]=0x30;
3586  0447 35300053      	mov	_buff+3,#48
3587                     ; 342 			buff[4]=0x40;
3589  044b 35400054      	mov	_buff+4,#64
3590                     ; 343 			buff[5]=0x50;
3592  044f 35500055      	mov	_buff+5,#80
3593                     ; 344 			buff[6]=0x60;
3595  0453 35600056      	mov	_buff+6,#96
3596                     ; 345 			buff[7]=0x70;
3598  0457 35700057      	mov	_buff+7,#112
3599                     ; 346 			buff[8]=0x80;
3601  045b 35800058      	mov	_buff+8,#128
3602                     ; 347 			buff[9]=0x90;
3604  045f 35900059      	mov	_buff+9,#144
3605                     ; 348 			buff[10]=0;
3607  0463 725f005a      	clr	_buff+10
3608                     ; 349 			buff[11]=0;
3610  0467 725f005b      	clr	_buff+11
3612  046b 2037          	jra	L7771
3613  046d               L1002:
3614                     ; 352 		else if(UIB[3]==3)
3616  046d c60003        	ld	a,_UIB+3
3617  0470 a103          	cp	a,#3
3618  0472 2630          	jrne	L7771
3619                     ; 354 			buff[0]=0x98;
3621  0474 35980050      	mov	_buff,#152
3622                     ; 355 			buff[1]=0x87;
3624  0478 35870051      	mov	_buff+1,#135
3625                     ; 356 			buff[2]=0x76;
3627  047c 35760052      	mov	_buff+2,#118
3628                     ; 357 			buff[3]=0x65;
3630  0480 35650053      	mov	_buff+3,#101
3631                     ; 358 			buff[4]=0x54;
3633  0484 35540054      	mov	_buff+4,#84
3634                     ; 359 			buff[5]=0x43;
3636  0488 35430055      	mov	_buff+5,#67
3637                     ; 360 			buff[6]=0x32;
3639  048c 35320056      	mov	_buff+6,#50
3640                     ; 361 			buff[7]=0x21;
3642  0490 35210057      	mov	_buff+7,#33
3643                     ; 362 			buff[8]=0x10;
3645  0494 35100058      	mov	_buff+8,#16
3646                     ; 363 			buff[9]=0x00;
3648  0498 725f0059      	clr	_buff+9
3649                     ; 364 			buff[10]=0;
3651  049c 725f005a      	clr	_buff+10
3652                     ; 365 			buff[11]=0;
3654  04a0 725f005b      	clr	_buff+11
3655  04a4               L7771:
3656                     ; 367 		if(UIB[2]==1)DF_buffer_write(/*1,*/0,256, buff);
3658  04a4 c60002        	ld	a,_UIB+2
3659  04a7 a101          	cp	a,#1
3660  04a9 2703          	jreq	L05
3661  04ab cc0896        	jp	L3071
3662  04ae               L05:
3665  04ae ae0050        	ldw	x,#_buff
3666  04b1 89            	pushw	x
3667  04b2 ae0100        	ldw	x,#256
3668  04b5 89            	pushw	x
3669  04b6 5f            	clrw	x
3670  04b7 cd0b5f        	call	_DF_buffer_write
3672  04ba 5b04          	addw	sp,#4
3673  04bc ac960896      	jpf	L3071
3674  04c0               L5671:
3675                     ; 371 	else if(UIB[1]==13)
3677  04c0 c60001        	ld	a,_UIB+1
3678  04c3 a10d          	cp	a,#13
3679  04c5 2703          	jreq	L25
3680  04c7 cc0566        	jp	L3102
3681  04ca               L25:
3682                     ; 376 		if(memory_manufacturer=='A') {	
3684  04ca c600bc        	ld	a,_memory_manufacturer
3685  04cd a141          	cp	a,#65
3686  04cf 2608          	jrne	L5102
3687                     ; 377 			DF_page_to_buffer(/*UIB[2],*/UIB[3]);
3689  04d1 c60003        	ld	a,_UIB+3
3690  04d4 5f            	clrw	x
3691  04d5 97            	ld	xl,a
3692  04d6 cd0ad3        	call	_DF_page_to_buffer
3694  04d9               L5102:
3695                     ; 379 		if(memory_manufacturer=='S') {
3697  04d9 c600bc        	ld	a,_memory_manufacturer
3698  04dc a153          	cp	a,#83
3699  04de 2703          	jreq	L45
3700  04e0 cc0896        	jp	L3071
3701  04e3               L45:
3702                     ; 380 			current_page=11;
3704  04e3 ae000b        	ldw	x,#11
3705  04e6 cf01ef        	ldw	_current_page,x
3706                     ; 381 			ST_READ((long)(current_page*256),256, buff);
3708  04e9 ae0050        	ldw	x,#_buff
3709  04ec 89            	pushw	x
3710  04ed ae0100        	ldw	x,#256
3711  04f0 89            	pushw	x
3712  04f1 ae0b00        	ldw	x,#2816
3713  04f4 89            	pushw	x
3714  04f5 ae0000        	ldw	x,#0
3715  04f8 89            	pushw	x
3716  04f9 cd0a13        	call	_ST_READ
3718  04fc 5b08          	addw	sp,#8
3719                     ; 383 			uart_out_adr_block (0,buff,64);
3721  04fe 4b40          	push	#64
3722  0500 ae0050        	ldw	x,#_buff
3723  0503 89            	pushw	x
3724  0504 ae0000        	ldw	x,#0
3725  0507 89            	pushw	x
3726  0508 ae0000        	ldw	x,#0
3727  050b 89            	pushw	x
3728  050c cd017f        	call	_uart_out_adr_block
3730  050f 5b07          	addw	sp,#7
3731                     ; 384 			delay_ms(100);    
3733  0511 ae0064        	ldw	x,#100
3734  0514 cd0063        	call	_delay_ms
3736                     ; 385 			uart_out_adr_block (64,&buff[64],64);
3738  0517 4b40          	push	#64
3739  0519 ae0090        	ldw	x,#_buff+64
3740  051c 89            	pushw	x
3741  051d ae0040        	ldw	x,#64
3742  0520 89            	pushw	x
3743  0521 ae0000        	ldw	x,#0
3744  0524 89            	pushw	x
3745  0525 cd017f        	call	_uart_out_adr_block
3747  0528 5b07          	addw	sp,#7
3748                     ; 386 			delay_ms(100);    
3750  052a ae0064        	ldw	x,#100
3751  052d cd0063        	call	_delay_ms
3753                     ; 387 			uart_out_adr_block (128,&buff[128],64);
3755  0530 4b40          	push	#64
3756  0532 ae00d0        	ldw	x,#_buff+128
3757  0535 89            	pushw	x
3758  0536 ae0080        	ldw	x,#128
3759  0539 89            	pushw	x
3760  053a ae0000        	ldw	x,#0
3761  053d 89            	pushw	x
3762  053e cd017f        	call	_uart_out_adr_block
3764  0541 5b07          	addw	sp,#7
3765                     ; 388 			delay_ms(100);    
3767  0543 ae0064        	ldw	x,#100
3768  0546 cd0063        	call	_delay_ms
3770                     ; 389 			uart_out_adr_block (192,&buff[192],64);
3772  0549 4b40          	push	#64
3773  054b ae0110        	ldw	x,#_buff+192
3774  054e 89            	pushw	x
3775  054f ae00c0        	ldw	x,#192
3776  0552 89            	pushw	x
3777  0553 ae0000        	ldw	x,#0
3778  0556 89            	pushw	x
3779  0557 cd017f        	call	_uart_out_adr_block
3781  055a 5b07          	addw	sp,#7
3782                     ; 390 			delay_ms(100); 
3784  055c ae0064        	ldw	x,#100
3785  055f cd0063        	call	_delay_ms
3787  0562 ac960896      	jpf	L3071
3788  0566               L3102:
3789                     ; 393 	else if(UIB[1]==14)
3791  0566 c60001        	ld	a,_UIB+1
3792  0569 a10e          	cp	a,#14
3793  056b 265f          	jrne	L3202
3794                     ; 398 		if(memory_manufacturer=='A') {	
3796  056d c600bc        	ld	a,_memory_manufacturer
3797  0570 a141          	cp	a,#65
3798  0572 2608          	jrne	L5202
3799                     ; 399 			DF_buffer_to_page_er(/*UIB[2],*/UIB[3]);
3801  0574 c60003        	ld	a,_UIB+3
3802  0577 5f            	clrw	x
3803  0578 97            	ld	xl,a
3804  0579 cd0af6        	call	_DF_buffer_to_page_er
3806  057c               L5202:
3807                     ; 401 		if(memory_manufacturer=='S') {
3809  057c c600bc        	ld	a,_memory_manufacturer
3810  057f a153          	cp	a,#83
3811  0581 2703          	jreq	L65
3812  0583 cc0896        	jp	L3071
3813  0586               L65:
3814                     ; 402 			for(i=0;i<256;i++) {
3816  0586 5f            	clrw	x
3817  0587 1f03          	ldw	(OFST-1,sp),x
3818  0589               L1302:
3819                     ; 403 				buff[i]=(char)i;
3821  0589 7b04          	ld	a,(OFST+0,sp)
3822  058b 1e03          	ldw	x,(OFST-1,sp)
3823  058d d70050        	ld	(_buff,x),a
3824                     ; 402 			for(i=0;i<256;i++) {
3826  0590 1e03          	ldw	x,(OFST-1,sp)
3827  0592 1c0001        	addw	x,#1
3828  0595 1f03          	ldw	(OFST-1,sp),x
3831  0597 1e03          	ldw	x,(OFST-1,sp)
3832  0599 a30100        	cpw	x,#256
3833  059c 25eb          	jrult	L1302
3834                     ; 405 			current_page=11;
3836  059e ae000b        	ldw	x,#11
3837  05a1 cf01ef        	ldw	_current_page,x
3838                     ; 406 			ST_WREN();
3840  05a4 cd09ba        	call	_ST_WREN
3842                     ; 407 			delay_ms(100);
3844  05a7 ae0064        	ldw	x,#100
3845  05aa cd0063        	call	_delay_ms
3847                     ; 408 			ST_WRITE((long)(current_page*256),256,buff);		
3849  05ad ae0050        	ldw	x,#_buff
3850  05b0 89            	pushw	x
3851  05b1 ae0100        	ldw	x,#256
3852  05b4 89            	pushw	x
3853  05b5 ce01ef        	ldw	x,_current_page
3854  05b8 4f            	clr	a
3855  05b9 02            	rlwa	x,a
3856  05ba cd0000        	call	c_uitolx
3858  05bd be02          	ldw	x,c_lreg+2
3859  05bf 89            	pushw	x
3860  05c0 be00          	ldw	x,c_lreg
3861  05c2 89            	pushw	x
3862  05c3 cd09c7        	call	_ST_WRITE
3864  05c6 5b08          	addw	sp,#8
3865  05c8 ac960896      	jpf	L3071
3866  05cc               L3202:
3867                     ; 413 	else if(UIB[1]==20)
3869  05cc c60001        	ld	a,_UIB+1
3870  05cf a114          	cp	a,#20
3871  05d1 2703          	jreq	L06
3872  05d3 cc0665        	jp	L1402
3873  05d6               L06:
3874                     ; 418 		file_lengt=0;
3876  05d6 ae0000        	ldw	x,#0
3877  05d9 cf01e9        	ldw	_file_lengt+2,x
3878  05dc ae0000        	ldw	x,#0
3879  05df cf01e7        	ldw	_file_lengt,x
3880                     ; 419 		file_lengt+=UIB[5];
3882  05e2 c60005        	ld	a,_UIB+5
3883  05e5 ae01e7        	ldw	x,#_file_lengt
3884  05e8 88            	push	a
3885  05e9 cd0000        	call	c_lgadc
3887  05ec 84            	pop	a
3888                     ; 420 		file_lengt<<=8;
3890  05ed ae01e7        	ldw	x,#_file_lengt
3891  05f0 a608          	ld	a,#8
3892  05f2 cd0000        	call	c_lglsh
3894                     ; 421 		file_lengt+=UIB[4];
3896  05f5 c60004        	ld	a,_UIB+4
3897  05f8 ae01e7        	ldw	x,#_file_lengt
3898  05fb 88            	push	a
3899  05fc cd0000        	call	c_lgadc
3901  05ff 84            	pop	a
3902                     ; 422 		file_lengt<<=8;
3904  0600 ae01e7        	ldw	x,#_file_lengt
3905  0603 a608          	ld	a,#8
3906  0605 cd0000        	call	c_lglsh
3908                     ; 423 		file_lengt+=UIB[3];
3910  0608 c60003        	ld	a,_UIB+3
3911  060b ae01e7        	ldw	x,#_file_lengt
3912  060e 88            	push	a
3913  060f cd0000        	call	c_lgadc
3915  0612 84            	pop	a
3916                     ; 424 		file_lengt_in_pages=file_lengt;
3918  0613 ce01e9        	ldw	x,_file_lengt+2
3919  0616 cf01f1        	ldw	_file_lengt_in_pages,x
3920                     ; 425 		file_lengt<<=8;
3922  0619 ae01e7        	ldw	x,#_file_lengt
3923  061c a608          	ld	a,#8
3924  061e cd0000        	call	c_lglsh
3926                     ; 426 		file_lengt+=UIB[2];
3928  0621 c60002        	ld	a,_UIB+2
3929  0624 ae01e7        	ldw	x,#_file_lengt
3930  0627 88            	push	a
3931  0628 cd0000        	call	c_lgadc
3933  062b 84            	pop	a
3934                     ; 431 		current_page=0;
3936  062c 5f            	clrw	x
3937  062d cf01ef        	ldw	_current_page,x
3938                     ; 432 		current_byte_in_buffer=0;
3940  0630 5f            	clrw	x
3941  0631 cf01eb        	ldw	_current_byte_in_buffer,x
3942                     ; 434 		if(memory_manufacturer=='S') {
3944  0634 c600bc        	ld	a,_memory_manufacturer
3945  0637 a153          	cp	a,#83
3946  0639 260c          	jrne	L3402
3947                     ; 435 			ST_WREN();
3949  063b cd09ba        	call	_ST_WREN
3951                     ; 436 					delay_ms(100);
3953  063e ae0064        	ldw	x,#100
3954  0641 cd0063        	call	_delay_ms
3956                     ; 437 		ST_bulk_erase();
3958  0644 cd09ad        	call	_ST_bulk_erase
3960  0647               L3402:
3961                     ; 439 		uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
3963  0647 4b00          	push	#0
3964  0649 4b00          	push	#0
3965  064b 3b01ef        	push	_current_page
3966  064e c601f0        	ld	a,_current_page+1
3967  0651 a4ff          	and	a,#255
3968  0653 88            	push	a
3969  0654 4b15          	push	#21
3970  0656 ae0016        	ldw	x,#22
3971  0659 a604          	ld	a,#4
3972  065b 95            	ld	xh,a
3973  065c cd00d5        	call	_uart_out
3975  065f 5b05          	addw	sp,#5
3977  0661 ac960896      	jpf	L3071
3978  0665               L1402:
3979                     ; 442 	else if(UIB[1]==21)
3981  0665 c60001        	ld	a,_UIB+1
3982  0668 a115          	cp	a,#21
3983  066a 2703          	jreq	L26
3984  066c cc0777        	jp	L7402
3985  066f               L26:
3986                     ; 447           for(i=0;i<64;i++)
3988  066f 5f            	clrw	x
3989  0670 1f03          	ldw	(OFST-1,sp),x
3990  0672               L1502:
3991                     ; 449           	buff[current_byte_in_buffer+i]=UIB[2+i];
3993  0672 1e03          	ldw	x,(OFST-1,sp)
3994  0674 d60002        	ld	a,(_UIB+2,x)
3995  0677 ce01eb        	ldw	x,_current_byte_in_buffer
3996  067a 72fb03        	addw	x,(OFST-1,sp)
3997  067d d70050        	ld	(_buff,x),a
3998                     ; 447           for(i=0;i<64;i++)
4000  0680 1e03          	ldw	x,(OFST-1,sp)
4001  0682 1c0001        	addw	x,#1
4002  0685 1f03          	ldw	(OFST-1,sp),x
4005  0687 1e03          	ldw	x,(OFST-1,sp)
4006  0689 a30040        	cpw	x,#64
4007  068c 25e4          	jrult	L1502
4008                     ; 451           current_byte_in_buffer+=64;
4010  068e ce01eb        	ldw	x,_current_byte_in_buffer
4011  0691 1c0040        	addw	x,#64
4012  0694 cf01eb        	ldw	_current_byte_in_buffer,x
4013                     ; 452           if(current_byte_in_buffer>=256)
4015  0697 ce01eb        	ldw	x,_current_byte_in_buffer
4016  069a a30100        	cpw	x,#256
4017  069d 2403          	jruge	L46
4018  069f cc0896        	jp	L3071
4019  06a2               L46:
4020                     ; 460 			if(memory_manufacturer=='A') {
4022  06a2 c600bc        	ld	a,_memory_manufacturer
4023  06a5 a141          	cp	a,#65
4024  06a7 2656          	jrne	L1602
4025                     ; 461 				DF_buffer_write(/*//current_buffer*//*1,*/0,256,buff);
4027  06a9 ae0050        	ldw	x,#_buff
4028  06ac 89            	pushw	x
4029  06ad ae0100        	ldw	x,#256
4030  06b0 89            	pushw	x
4031  06b1 5f            	clrw	x
4032  06b2 cd0b5f        	call	_DF_buffer_write
4034  06b5 5b04          	addw	sp,#4
4035                     ; 462 				DF_buffer_to_page_er(/*///current_buffer*//*1,*/current_page);
4037  06b7 ce01ef        	ldw	x,_current_page
4038  06ba cd0af6        	call	_DF_buffer_to_page_er
4040                     ; 463 				current_page++;
4042  06bd ce01ef        	ldw	x,_current_page
4043  06c0 1c0001        	addw	x,#1
4044  06c3 cf01ef        	ldw	_current_page,x
4045                     ; 464 				if(current_page<file_lengt_in_pages)
4047  06c6 ce01ef        	ldw	x,_current_page
4048  06c9 c301f1        	cpw	x,_file_lengt_in_pages
4049  06cc 2426          	jruge	L3602
4050                     ; 466 					delay_ms(100);
4052  06ce ae0064        	ldw	x,#100
4053  06d1 cd0063        	call	_delay_ms
4055                     ; 467 					uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
4057  06d4 4b00          	push	#0
4058  06d6 4b00          	push	#0
4059  06d8 3b01ef        	push	_current_page
4060  06db c601f0        	ld	a,_current_page+1
4061  06de a4ff          	and	a,#255
4062  06e0 88            	push	a
4063  06e1 4b15          	push	#21
4064  06e3 ae0016        	ldw	x,#22
4065  06e6 a604          	ld	a,#4
4066  06e8 95            	ld	xh,a
4067  06e9 cd00d5        	call	_uart_out
4069  06ec 5b05          	addw	sp,#5
4070                     ; 468 					current_byte_in_buffer=0;
4072  06ee 5f            	clrw	x
4073  06ef cf01eb        	ldw	_current_byte_in_buffer,x
4075  06f2 200b          	jra	L1602
4076  06f4               L3602:
4077                     ; 472 					EE_PAGE_LEN=current_page;
4079  06f4 ce01ef        	ldw	x,_current_page
4080  06f7 89            	pushw	x
4081  06f8 ae0000        	ldw	x,#_EE_PAGE_LEN
4082  06fb cd0000        	call	c_eewrw
4084  06fe 85            	popw	x
4085  06ff               L1602:
4086                     ; 475 			if(memory_manufacturer=='S') {
4088  06ff c600bc        	ld	a,_memory_manufacturer
4089  0702 a153          	cp	a,#83
4090  0704 2703          	jreq	L66
4091  0706 cc0896        	jp	L3071
4092  0709               L66:
4093                     ; 476 				ST_WREN();
4095  0709 cd09ba        	call	_ST_WREN
4097                     ; 477 				delay_ms(100);
4099  070c ae0064        	ldw	x,#100
4100  070f cd0063        	call	_delay_ms
4102                     ; 478 				ST_WRITE((unsigned long)(current_page*256UL),256,buff);
4104  0712 ae0050        	ldw	x,#_buff
4105  0715 89            	pushw	x
4106  0716 ae0100        	ldw	x,#256
4107  0719 89            	pushw	x
4108  071a ce01ef        	ldw	x,_current_page
4109  071d 90ae0100      	ldw	y,#256
4110  0721 cd0000        	call	c_umul
4112  0724 be02          	ldw	x,c_lreg+2
4113  0726 89            	pushw	x
4114  0727 be00          	ldw	x,c_lreg
4115  0729 89            	pushw	x
4116  072a cd09c7        	call	_ST_WRITE
4118  072d 5b08          	addw	sp,#8
4119                     ; 479 				current_page++;
4121  072f ce01ef        	ldw	x,_current_page
4122  0732 1c0001        	addw	x,#1
4123  0735 cf01ef        	ldw	_current_page,x
4124                     ; 480 				if(current_page<file_lengt_in_pages)
4126  0738 ce01ef        	ldw	x,_current_page
4127  073b c301f1        	cpw	x,_file_lengt_in_pages
4128  073e 2428          	jruge	L1702
4129                     ; 482 					delay_ms(100);
4131  0740 ae0064        	ldw	x,#100
4132  0743 cd0063        	call	_delay_ms
4134                     ; 483 					uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
4136  0746 4b00          	push	#0
4137  0748 4b00          	push	#0
4138  074a 3b01ef        	push	_current_page
4139  074d c601f0        	ld	a,_current_page+1
4140  0750 a4ff          	and	a,#255
4141  0752 88            	push	a
4142  0753 4b15          	push	#21
4143  0755 ae0016        	ldw	x,#22
4144  0758 a604          	ld	a,#4
4145  075a 95            	ld	xh,a
4146  075b cd00d5        	call	_uart_out
4148  075e 5b05          	addw	sp,#5
4149                     ; 484 					current_byte_in_buffer=0;
4151  0760 5f            	clrw	x
4152  0761 cf01eb        	ldw	_current_byte_in_buffer,x
4154  0764 ac960896      	jpf	L3071
4155  0768               L1702:
4156                     ; 488 					EE_PAGE_LEN=current_page;
4158  0768 ce01ef        	ldw	x,_current_page
4159  076b 89            	pushw	x
4160  076c ae0000        	ldw	x,#_EE_PAGE_LEN
4161  076f cd0000        	call	c_eewrw
4163  0772 85            	popw	x
4164  0773 ac960896      	jpf	L3071
4165  0777               L7402:
4166                     ; 499 	else if(UIB[1]==24) {
4168  0777 c60001        	ld	a,_UIB+1
4169  077a a118          	cp	a,#24
4170  077c 2616          	jrne	L7702
4171                     ; 502 		rele_cnt=10;
4173  077e ae000a        	ldw	x,#10
4174  0781 cf01e3        	ldw	_rele_cnt,x
4175                     ; 503 		ST_WREN();
4177  0784 cd09ba        	call	_ST_WREN
4179                     ; 504 		delay_ms(100);
4181  0787 ae0064        	ldw	x,#100
4182  078a cd0063        	call	_delay_ms
4184                     ; 505 		ST_bulk_erase();
4186  078d cd09ad        	call	_ST_bulk_erase
4189  0790 ac960896      	jpf	L3071
4190  0794               L7702:
4191                     ; 510 	else if(UIB[1]==25)
4193  0794 c60001        	ld	a,_UIB+1
4194  0797 a119          	cp	a,#25
4195  0799 2703          	jreq	L07
4196  079b cc087e        	jp	L3012
4197  079e               L07:
4198                     ; 514 		current_page=0;
4200  079e 5f            	clrw	x
4201  079f cf01ef        	ldw	_current_page,x
4202                     ; 516 		for(i__=0;i__<EE_PAGE_LEN;i__++)
4204  07a2 5f            	clrw	x
4205  07a3 1f03          	ldw	(OFST-1,sp),x
4207  07a5 ac720872      	jpf	L1112
4208  07a9               L5012:
4209                     ; 518 			if(memory_manufacturer=='S') {	
4211  07a9 c600bc        	ld	a,_memory_manufacturer
4212  07ac a153          	cp	a,#83
4213  07ae 2619          	jrne	L5112
4214                     ; 519 				DF_page_to_buffer(i__);
4216  07b0 1e03          	ldw	x,(OFST-1,sp)
4217  07b2 cd0ad3        	call	_DF_page_to_buffer
4219                     ; 520 				delay_ms(100);			
4221  07b5 ae0064        	ldw	x,#100
4222  07b8 cd0063        	call	_delay_ms
4224                     ; 521 				DF_buffer_read(0,256, buff);
4226  07bb ae0050        	ldw	x,#_buff
4227  07be 89            	pushw	x
4228  07bf ae0100        	ldw	x,#256
4229  07c2 89            	pushw	x
4230  07c3 5f            	clrw	x
4231  07c4 cd0b19        	call	_DF_buffer_read
4233  07c7 5b04          	addw	sp,#4
4234  07c9               L5112:
4235                     ; 524 			if(memory_manufacturer=='S') {	
4237  07c9 c600bc        	ld	a,_memory_manufacturer
4238  07cc a153          	cp	a,#83
4239  07ce 261a          	jrne	L7112
4240                     ; 525 				ST_READ((long)(i__*256),256, buff);
4242  07d0 ae0050        	ldw	x,#_buff
4243  07d3 89            	pushw	x
4244  07d4 ae0100        	ldw	x,#256
4245  07d7 89            	pushw	x
4246  07d8 1e07          	ldw	x,(OFST+3,sp)
4247  07da 4f            	clr	a
4248  07db 02            	rlwa	x,a
4249  07dc cd0000        	call	c_itolx
4251  07df be02          	ldw	x,c_lreg+2
4252  07e1 89            	pushw	x
4253  07e2 be00          	ldw	x,c_lreg
4254  07e4 89            	pushw	x
4255  07e5 cd0a13        	call	_ST_READ
4257  07e8 5b08          	addw	sp,#8
4258  07ea               L7112:
4259                     ; 528 			uart_out_adr_block ((256*i__)+0,buff,64);
4261  07ea 4b40          	push	#64
4262  07ec ae0050        	ldw	x,#_buff
4263  07ef 89            	pushw	x
4264  07f0 1e06          	ldw	x,(OFST+2,sp)
4265  07f2 4f            	clr	a
4266  07f3 02            	rlwa	x,a
4267  07f4 cd0000        	call	c_itolx
4269  07f7 be02          	ldw	x,c_lreg+2
4270  07f9 89            	pushw	x
4271  07fa be00          	ldw	x,c_lreg
4272  07fc 89            	pushw	x
4273  07fd cd017f        	call	_uart_out_adr_block
4275  0800 5b07          	addw	sp,#7
4276                     ; 529 			delay_ms(100);    
4278  0802 ae0064        	ldw	x,#100
4279  0805 cd0063        	call	_delay_ms
4281                     ; 530 			uart_out_adr_block ((256*i__)+64,&buff[64],64);
4283  0808 4b40          	push	#64
4284  080a ae0090        	ldw	x,#_buff+64
4285  080d 89            	pushw	x
4286  080e 1e06          	ldw	x,(OFST+2,sp)
4287  0810 4f            	clr	a
4288  0811 02            	rlwa	x,a
4289  0812 1c0040        	addw	x,#64
4290  0815 cd0000        	call	c_itolx
4292  0818 be02          	ldw	x,c_lreg+2
4293  081a 89            	pushw	x
4294  081b be00          	ldw	x,c_lreg
4295  081d 89            	pushw	x
4296  081e cd017f        	call	_uart_out_adr_block
4298  0821 5b07          	addw	sp,#7
4299                     ; 531 			delay_ms(100);    
4301  0823 ae0064        	ldw	x,#100
4302  0826 cd0063        	call	_delay_ms
4304                     ; 532 			uart_out_adr_block ((256*i__)+128,&buff[128],64);
4306  0829 4b40          	push	#64
4307  082b ae00d0        	ldw	x,#_buff+128
4308  082e 89            	pushw	x
4309  082f 1e06          	ldw	x,(OFST+2,sp)
4310  0831 4f            	clr	a
4311  0832 02            	rlwa	x,a
4312  0833 1c0080        	addw	x,#128
4313  0836 cd0000        	call	c_itolx
4315  0839 be02          	ldw	x,c_lreg+2
4316  083b 89            	pushw	x
4317  083c be00          	ldw	x,c_lreg
4318  083e 89            	pushw	x
4319  083f cd017f        	call	_uart_out_adr_block
4321  0842 5b07          	addw	sp,#7
4322                     ; 533 			delay_ms(100);    
4324  0844 ae0064        	ldw	x,#100
4325  0847 cd0063        	call	_delay_ms
4327                     ; 534 			uart_out_adr_block ((256*i__)+192,&buff[192],64);
4329  084a 4b40          	push	#64
4330  084c ae0110        	ldw	x,#_buff+192
4331  084f 89            	pushw	x
4332  0850 1e06          	ldw	x,(OFST+2,sp)
4333  0852 4f            	clr	a
4334  0853 02            	rlwa	x,a
4335  0854 1c00c0        	addw	x,#192
4336  0857 cd0000        	call	c_itolx
4338  085a be02          	ldw	x,c_lreg+2
4339  085c 89            	pushw	x
4340  085d be00          	ldw	x,c_lreg
4341  085f 89            	pushw	x
4342  0860 cd017f        	call	_uart_out_adr_block
4344  0863 5b07          	addw	sp,#7
4345                     ; 535 			delay_ms(100);   
4347  0865 ae0064        	ldw	x,#100
4348  0868 cd0063        	call	_delay_ms
4350                     ; 516 		for(i__=0;i__<EE_PAGE_LEN;i__++)
4352  086b 1e03          	ldw	x,(OFST-1,sp)
4353  086d 1c0001        	addw	x,#1
4354  0870 1f03          	ldw	(OFST-1,sp),x
4355  0872               L1112:
4358  0872 1e03          	ldw	x,(OFST-1,sp)
4359  0874 c30000        	cpw	x,_EE_PAGE_LEN
4360  0877 2403          	jruge	L27
4361  0879 cc07a9        	jp	L5012
4362  087c               L27:
4364  087c 2018          	jra	L3071
4365  087e               L3012:
4366                     ; 545 	else if(UIB[1]==30)
4368  087e c60001        	ld	a,_UIB+1
4369  0881 a11e          	cp	a,#30
4370  0883 2606          	jrne	L3212
4371                     ; 567           bSTART=1;
4373  0885 7210000c      	bset	_bSTART
4375  0889 200b          	jra	L3071
4376  088b               L3212:
4377                     ; 579 	else if(UIB[1]==40)
4379  088b c60001        	ld	a,_UIB+1
4380  088e a128          	cp	a,#40
4381  0890 2604          	jrne	L3071
4382                     ; 601 		bSTART=1;	
4384  0892 7210000c      	bset	_bSTART
4385  0896               L3071:
4386                     ; 606 }
4389  0896 5b04          	addw	sp,#4
4390  0898 81            	ret
4425                     ; 609 void putchar(char c)
4425                     ; 610 {
4426                     	switch	.text
4427  0899               _putchar:
4429  0899 88            	push	a
4430       00000000      OFST:	set	0
4433  089a               L7412:
4434                     ; 611 while (tx_counter == TX_BUFFER_SIZE);
4436  089a c60200        	ld	a,_tx_counter
4437  089d a150          	cp	a,#80
4438  089f 27f9          	jreq	L7412
4439                     ; 613 if (tx_counter || ((UART1->SR & UART1_SR_TXE)==0))
4441  08a1 725d0200      	tnz	_tx_counter
4442  08a5 2607          	jrne	L5512
4444  08a7 c65230        	ld	a,21040
4445  08aa a580          	bcp	a,#128
4446  08ac 2626          	jrne	L3512
4447  08ae               L5512:
4448                     ; 615    tx_buffer[tx_wr_index]=c;
4450  08ae 5f            	clrw	x
4451  08af c601ff        	ld	a,_tx_wr_index
4452  08b2 2a01          	jrpl	L67
4453  08b4 53            	cplw	x
4454  08b5               L67:
4455  08b5 97            	ld	xl,a
4456  08b6 7b01          	ld	a,(OFST+1,sp)
4457  08b8 d70004        	ld	(_tx_buffer,x),a
4458                     ; 616    if (++tx_wr_index == TX_BUFFER_SIZE) tx_wr_index=0;
4460  08bb 725c01ff      	inc	_tx_wr_index
4461  08bf c601ff        	ld	a,_tx_wr_index
4462  08c2 a150          	cp	a,#80
4463  08c4 2604          	jrne	L7512
4466  08c6 725f01ff      	clr	_tx_wr_index
4467  08ca               L7512:
4468                     ; 617    ++tx_counter;
4470  08ca 725c0200      	inc	_tx_counter
4472  08ce               L1612:
4473                     ; 621 UART1->CR2|= UART1_CR2_TIEN;
4475  08ce 721e5235      	bset	21045,#7
4476                     ; 623 }
4479  08d2 84            	pop	a
4480  08d3 81            	ret
4481  08d4               L3512:
4482                     ; 619 else UART1->DR=c;
4484  08d4 7b01          	ld	a,(OFST+1,sp)
4485  08d6 c75231        	ld	21041,a
4486  08d9 20f3          	jra	L1612
4509                     ; 626 void spi_init(void){
4510                     	switch	.text
4511  08db               _spi_init:
4515                     ; 628 	GPIOA->DDR|=(1<<3);
4517  08db 72165002      	bset	20482,#3
4518                     ; 629 	GPIOA->CR1|=(1<<3);
4520  08df 72165003      	bset	20483,#3
4521                     ; 630 	GPIOA->CR2&=~(1<<3);
4523  08e3 72175004      	bres	20484,#3
4524                     ; 631 	GPIOA->ODR|=(1<<3);	
4526  08e7 72165000      	bset	20480,#3
4527                     ; 634 	GPIOB->DDR|=(1<<5);
4529  08eb 721a5007      	bset	20487,#5
4530                     ; 635 	GPIOB->CR1|=(1<<5);
4532  08ef 721a5008      	bset	20488,#5
4533                     ; 636 	GPIOB->CR2&=~(1<<5);
4535  08f3 721b5009      	bres	20489,#5
4536                     ; 637 	GPIOB->ODR|=(1<<5);	
4538  08f7 721a5005      	bset	20485,#5
4539                     ; 639 	GPIOC->DDR|=(1<<3);
4541  08fb 7216500c      	bset	20492,#3
4542                     ; 640 	GPIOC->CR1|=(1<<3);
4544  08ff 7216500d      	bset	20493,#3
4545                     ; 641 	GPIOC->CR2&=~(1<<3);
4547  0903 7217500e      	bres	20494,#3
4548                     ; 642 	GPIOC->ODR|=(1<<3);	
4550  0907 7216500a      	bset	20490,#3
4551                     ; 644 	GPIOC->DDR|=(1<<5);
4553  090b 721a500c      	bset	20492,#5
4554                     ; 645 	GPIOC->CR1|=(1<<5);
4556  090f 721a500d      	bset	20493,#5
4557                     ; 646 	GPIOC->CR2|=(1<<5);
4559  0913 721a500e      	bset	20494,#5
4560                     ; 647 	GPIOC->ODR|=(1<<5);	
4562  0917 721a500a      	bset	20490,#5
4563                     ; 649 	GPIOC->DDR|=(1<<6);
4565  091b 721c500c      	bset	20492,#6
4566                     ; 650 	GPIOC->CR1|=(1<<6);
4568  091f 721c500d      	bset	20493,#6
4569                     ; 651 	GPIOC->CR2|=(1<<6);
4571  0923 721c500e      	bset	20494,#6
4572                     ; 652 	GPIOC->ODR|=(1<<6);	
4574  0927 721c500a      	bset	20490,#6
4575                     ; 654 	GPIOC->DDR&=~(1<<7);
4577  092b 721f500c      	bres	20492,#7
4578                     ; 655 	GPIOC->CR1&=~(1<<7);
4580  092f 721f500d      	bres	20493,#7
4581                     ; 656 	GPIOC->CR2&=~(1<<7);
4583  0933 721f500e      	bres	20494,#7
4584                     ; 657 	GPIOC->ODR|=(1<<7);	
4586  0937 721e500a      	bset	20490,#7
4587                     ; 659 	SPI->CR1= /*SPI_CR1_LSBFIRST |*/
4587                     ; 660 			SPI_CR1_SPE | 
4587                     ; 661 			( (4<< 3) & SPI_CR1_BR ) |
4587                     ; 662 			SPI_CR1_MSTR |
4587                     ; 663 			SPI_CR1_CPOL |
4587                     ; 664 			SPI_CR1_CPHA; 
4589  093b 35675200      	mov	20992,#103
4590                     ; 666 	SPI->CR2= SPI_CR2_SSM | SPI_CR2_SSI;
4592  093f 35035201      	mov	20993,#3
4593                     ; 667 	SPI->ICR= 0;	
4595  0943 725f5202      	clr	20994
4596                     ; 668 }
4599  0947 81            	ret
4638                     ; 671 char spi(char in){
4639                     	switch	.text
4640  0948               _spi:
4642  0948 88            	push	a
4643  0949 88            	push	a
4644       00000001      OFST:	set	1
4647  094a               L3122:
4648                     ; 673 	while(!((SPI->SR)&SPI_SR_TXE));
4650  094a c65203        	ld	a,20995
4651  094d a502          	bcp	a,#2
4652  094f 27f9          	jreq	L3122
4653                     ; 674 	SPI->DR=in;
4655  0951 7b02          	ld	a,(OFST+1,sp)
4656  0953 c75204        	ld	20996,a
4658  0956               L3222:
4659                     ; 675 	while(!((SPI->SR)&SPI_SR_RXNE));
4661  0956 c65203        	ld	a,20995
4662  0959 a501          	bcp	a,#1
4663  095b 27f9          	jreq	L3222
4664                     ; 676 	c=SPI->DR;	
4666  095d c65204        	ld	a,20996
4667  0960 6b01          	ld	(OFST+0,sp),a
4668                     ; 677 	return c;
4670  0962 7b01          	ld	a,(OFST+0,sp)
4673  0964 85            	popw	x
4674  0965 81            	ret
4731                     ; 681 long ST_RDID_read(void)
4731                     ; 682 {
4732                     	switch	.text
4733  0966               _ST_RDID_read:
4735  0966 5204          	subw	sp,#4
4736       00000004      OFST:	set	4
4739                     ; 685 d0=0;
4741  0968 0f04          	clr	(OFST+0,sp)
4742                     ; 686 d1=0;
4744                     ; 687 d2=0;
4746                     ; 688 d3=0;
4748                     ; 690 ST_CS_ON
4750  096a 721b5005      	bres	20485,#5
4751                     ; 691 spi(0x9f);
4753  096e a69f          	ld	a,#159
4754  0970 add6          	call	_spi
4756                     ; 692 mdr0=spi(0xff);
4758  0972 a6ff          	ld	a,#255
4759  0974 add2          	call	_spi
4761  0976 c701f6        	ld	_mdr0,a
4762                     ; 693 mdr1=spi(0xff);
4764  0979 a6ff          	ld	a,#255
4765  097b adcb          	call	_spi
4767  097d c701f5        	ld	_mdr1,a
4768                     ; 694 mdr2=spi(0xff);
4770  0980 a6ff          	ld	a,#255
4771  0982 adc4          	call	_spi
4773  0984 c701f4        	ld	_mdr2,a
4774                     ; 697 ST_CS_OFF
4776  0987 721a5005      	bset	20485,#5
4777                     ; 698 return  *((long*)&d0);
4779  098b 96            	ldw	x,sp
4780  098c 1c0004        	addw	x,#OFST+0
4781  098f cd0000        	call	c_ltor
4785  0992 5b04          	addw	sp,#4
4786  0994 81            	ret
4819                     ; 702 char ST_status_read(void)
4819                     ; 703 {
4820                     	switch	.text
4821  0995               _ST_status_read:
4823  0995 88            	push	a
4824       00000001      OFST:	set	1
4827                     ; 707 ST_CS_ON
4829  0996 721b5005      	bres	20485,#5
4830                     ; 708 spi(0x05);
4832  099a a605          	ld	a,#5
4833  099c adaa          	call	_spi
4835                     ; 709 d0=spi(0xff);
4837  099e a6ff          	ld	a,#255
4838  09a0 ada6          	call	_spi
4840  09a2 6b01          	ld	(OFST+0,sp),a
4841                     ; 711 ST_CS_OFF
4843  09a4 721a5005      	bset	20485,#5
4844                     ; 712 return d0;
4846  09a8 7b01          	ld	a,(OFST+0,sp)
4849  09aa 5b01          	addw	sp,#1
4850  09ac 81            	ret
4874                     ; 716 void ST_bulk_erase(void)
4874                     ; 717 {
4875                     	switch	.text
4876  09ad               _ST_bulk_erase:
4880                     ; 718 ST_CS_ON
4882  09ad 721b5005      	bres	20485,#5
4883                     ; 719 spi(0xC7);
4885  09b1 a6c7          	ld	a,#199
4886  09b3 ad93          	call	_spi
4888                     ; 722 ST_CS_OFF
4890  09b5 721a5005      	bset	20485,#5
4891                     ; 723 }
4894  09b9 81            	ret
4918                     ; 725 void ST_WREN(void)
4918                     ; 726 {
4919                     	switch	.text
4920  09ba               _ST_WREN:
4924                     ; 728 ST_CS_ON
4926  09ba 721b5005      	bres	20485,#5
4927                     ; 729 spi(0x06);
4929  09be a606          	ld	a,#6
4930  09c0 ad86          	call	_spi
4932                     ; 731 ST_CS_OFF
4934  09c2 721a5005      	bset	20485,#5
4935                     ; 732 }  
4938  09c6 81            	ret
5016                     ; 735 void ST_WRITE(unsigned long memo_addr,unsigned short len, char* adr)
5016                     ; 736 {
5017                     	switch	.text
5018  09c7               _ST_WRITE:
5020  09c7 5205          	subw	sp,#5
5021       00000005      OFST:	set	5
5024                     ; 740 adr2=(char)(memo_addr>>16);
5026  09c9 7b09          	ld	a,(OFST+4,sp)
5027  09cb 6b03          	ld	(OFST-2,sp),a
5028                     ; 741 adr1=(char)((memo_addr>>8)&0x00ff);
5030  09cd 7b0a          	ld	a,(OFST+5,sp)
5031  09cf a4ff          	and	a,#255
5032  09d1 6b02          	ld	(OFST-3,sp),a
5033                     ; 742 adr0=(char)((memo_addr)&0x00ff);
5035  09d3 7b0b          	ld	a,(OFST+6,sp)
5036  09d5 a4ff          	and	a,#255
5037  09d7 6b01          	ld	(OFST-4,sp),a
5038                     ; 743 ST_CS_ON
5040  09d9 721b5005      	bres	20485,#5
5041                     ; 745 spi(0x02);
5043  09dd a602          	ld	a,#2
5044  09df cd0948        	call	_spi
5046                     ; 746 spi(adr2);
5048  09e2 7b03          	ld	a,(OFST-2,sp)
5049  09e4 cd0948        	call	_spi
5051                     ; 747 spi(adr1);
5053  09e7 7b02          	ld	a,(OFST-3,sp)
5054  09e9 cd0948        	call	_spi
5056                     ; 748 spi(adr0);
5058  09ec 7b01          	ld	a,(OFST-4,sp)
5059  09ee cd0948        	call	_spi
5061                     ; 750 for(i=0;i<len;i++)
5063  09f1 5f            	clrw	x
5064  09f2 1f04          	ldw	(OFST-1,sp),x
5066  09f4 2010          	jra	L3432
5067  09f6               L7332:
5068                     ; 752 	spi(adr[i]);
5070  09f6 1e0e          	ldw	x,(OFST+9,sp)
5071  09f8 72fb04        	addw	x,(OFST-1,sp)
5072  09fb f6            	ld	a,(x)
5073  09fc cd0948        	call	_spi
5075                     ; 750 for(i=0;i<len;i++)
5077  09ff 1e04          	ldw	x,(OFST-1,sp)
5078  0a01 1c0001        	addw	x,#1
5079  0a04 1f04          	ldw	(OFST-1,sp),x
5080  0a06               L3432:
5083  0a06 1e04          	ldw	x,(OFST-1,sp)
5084  0a08 130c          	cpw	x,(OFST+7,sp)
5085  0a0a 25ea          	jrult	L7332
5086                     ; 755 ST_CS_OFF
5088  0a0c 721a5005      	bset	20485,#5
5089                     ; 756 }
5092  0a10 5b05          	addw	sp,#5
5093  0a12 81            	ret
5171                     ; 759 void ST_READ(unsigned long memo_addr,unsigned short len, char* adr)
5171                     ; 760 {
5172                     	switch	.text
5173  0a13               _ST_READ:
5175  0a13 5205          	subw	sp,#5
5176       00000005      OFST:	set	5
5179                     ; 766 adr2=(char)(memo_addr>>16);
5181  0a15 7b09          	ld	a,(OFST+4,sp)
5182  0a17 6b03          	ld	(OFST-2,sp),a
5183                     ; 767 adr1=(char)((memo_addr>>8)&0x00ff);
5185  0a19 7b0a          	ld	a,(OFST+5,sp)
5186  0a1b a4ff          	and	a,#255
5187  0a1d 6b02          	ld	(OFST-3,sp),a
5188                     ; 768 adr0=(char)((memo_addr)&0x00ff);
5190  0a1f 7b0b          	ld	a,(OFST+6,sp)
5191  0a21 a4ff          	and	a,#255
5192  0a23 6b01          	ld	(OFST-4,sp),a
5193                     ; 769 ST_CS_ON
5195  0a25 721b5005      	bres	20485,#5
5196                     ; 770 spi(0x03);
5198  0a29 a603          	ld	a,#3
5199  0a2b cd0948        	call	_spi
5201                     ; 771 spi(adr2);
5203  0a2e 7b03          	ld	a,(OFST-2,sp)
5204  0a30 cd0948        	call	_spi
5206                     ; 772 spi(adr1);
5208  0a33 7b02          	ld	a,(OFST-3,sp)
5209  0a35 cd0948        	call	_spi
5211                     ; 773 spi(adr0);
5213  0a38 7b01          	ld	a,(OFST-4,sp)
5214  0a3a cd0948        	call	_spi
5216                     ; 775 for(i=0;i<len;i++)
5218  0a3d 5f            	clrw	x
5219  0a3e 1f04          	ldw	(OFST-1,sp),x
5221  0a40 2012          	jra	L5042
5222  0a42               L1042:
5223                     ; 777 	adr[i]=spi(0xff);
5225  0a42 a6ff          	ld	a,#255
5226  0a44 cd0948        	call	_spi
5228  0a47 1e0e          	ldw	x,(OFST+9,sp)
5229  0a49 72fb04        	addw	x,(OFST-1,sp)
5230  0a4c f7            	ld	(x),a
5231                     ; 775 for(i=0;i<len;i++)
5233  0a4d 1e04          	ldw	x,(OFST-1,sp)
5234  0a4f 1c0001        	addw	x,#1
5235  0a52 1f04          	ldw	(OFST-1,sp),x
5236  0a54               L5042:
5239  0a54 1e04          	ldw	x,(OFST-1,sp)
5240  0a56 130c          	cpw	x,(OFST+7,sp)
5241  0a58 25e8          	jrult	L1042
5242                     ; 780 ST_CS_OFF
5244  0a5a 721a5005      	bset	20485,#5
5245                     ; 781 }
5248  0a5e 5b05          	addw	sp,#5
5249  0a60 81            	ret
5307                     ; 785 long DF_mf_dev_read(void)
5307                     ; 786 {
5308                     	switch	.text
5309  0a61               _DF_mf_dev_read:
5311  0a61 5204          	subw	sp,#4
5312       00000004      OFST:	set	4
5315                     ; 789 d0=0;
5317  0a63 0f04          	clr	(OFST+0,sp)
5318                     ; 790 d1=0;
5320                     ; 791 d2=0;
5322                     ; 792 d3=0;
5324                     ; 794 CS_ON
5326  0a65 7217500a      	bres	20490,#3
5327                     ; 795 spi(0x9f);
5329  0a69 a69f          	ld	a,#159
5330  0a6b cd0948        	call	_spi
5332                     ; 796 mdr0=spi(0xff);
5334  0a6e a6ff          	ld	a,#255
5335  0a70 cd0948        	call	_spi
5337  0a73 c701f6        	ld	_mdr0,a
5338                     ; 797 mdr1=spi(0xff);
5340  0a76 a6ff          	ld	a,#255
5341  0a78 cd0948        	call	_spi
5343  0a7b c701f5        	ld	_mdr1,a
5344                     ; 798 mdr2=spi(0xff);
5346  0a7e a6ff          	ld	a,#255
5347  0a80 cd0948        	call	_spi
5349  0a83 c701f4        	ld	_mdr2,a
5350                     ; 799 mdr3=spi(0xff);  
5352  0a86 a6ff          	ld	a,#255
5353  0a88 cd0948        	call	_spi
5355  0a8b c701f3        	ld	_mdr3,a
5356                     ; 801 CS_OFF
5358  0a8e 7216500a      	bset	20490,#3
5359                     ; 802 return  *((long*)&d0);
5361  0a92 96            	ldw	x,sp
5362  0a93 1c0004        	addw	x,#OFST+0
5363  0a96 cd0000        	call	c_ltor
5367  0a99 5b04          	addw	sp,#4
5368  0a9b 81            	ret
5392                     ; 806 void DF_memo_to_256(void)
5392                     ; 807 {
5393                     	switch	.text
5394  0a9c               _DF_memo_to_256:
5398                     ; 809 CS_ON
5400  0a9c 7217500a      	bres	20490,#3
5401                     ; 810 spi(0x3d);
5403  0aa0 a63d          	ld	a,#61
5404  0aa2 cd0948        	call	_spi
5406                     ; 811 spi(0x2a); 
5408  0aa5 a62a          	ld	a,#42
5409  0aa7 cd0948        	call	_spi
5411                     ; 812 spi(0x80);
5413  0aaa a680          	ld	a,#128
5414  0aac cd0948        	call	_spi
5416                     ; 813 spi(0xa6);
5418  0aaf a6a6          	ld	a,#166
5419  0ab1 cd0948        	call	_spi
5421                     ; 815 CS_OFF
5423  0ab4 7216500a      	bset	20490,#3
5424                     ; 816 }  
5427  0ab8 81            	ret
5460                     ; 821 char DF_status_read(void)
5460                     ; 822 {
5461                     	switch	.text
5462  0ab9               _DF_status_read:
5464  0ab9 88            	push	a
5465       00000001      OFST:	set	1
5468                     ; 826 CS_ON
5470  0aba 7217500a      	bres	20490,#3
5471                     ; 827 spi(0xd7);
5473  0abe a6d7          	ld	a,#215
5474  0ac0 cd0948        	call	_spi
5476                     ; 828 d0=spi(0xff);
5478  0ac3 a6ff          	ld	a,#255
5479  0ac5 cd0948        	call	_spi
5481  0ac8 6b01          	ld	(OFST+0,sp),a
5482                     ; 830 CS_OFF
5484  0aca 7216500a      	bset	20490,#3
5485                     ; 831 return d0;
5487  0ace 7b01          	ld	a,(OFST+0,sp)
5490  0ad0 5b01          	addw	sp,#1
5491  0ad2 81            	ret
5531                     ; 835 void DF_page_to_buffer(unsigned page_addr)
5531                     ; 836 {
5532                     	switch	.text
5533  0ad3               _DF_page_to_buffer:
5535  0ad3 89            	pushw	x
5536  0ad4 88            	push	a
5537       00000001      OFST:	set	1
5540                     ; 839 d0=0x53; 
5542                     ; 843 CS_ON
5544  0ad5 7217500a      	bres	20490,#3
5545                     ; 844 spi(d0);
5547  0ad9 a653          	ld	a,#83
5548  0adb cd0948        	call	_spi
5550                     ; 845 spi(page_addr/256/**(((char*)&page_addr)+1)*/);
5552  0ade 7b02          	ld	a,(OFST+1,sp)
5553  0ae0 cd0948        	call	_spi
5555                     ; 846 spi(page_addr%256/**((char*)&page_addr)*/);
5557  0ae3 7b03          	ld	a,(OFST+2,sp)
5558  0ae5 a4ff          	and	a,#255
5559  0ae7 cd0948        	call	_spi
5561                     ; 847 spi(0xff);
5563  0aea a6ff          	ld	a,#255
5564  0aec cd0948        	call	_spi
5566                     ; 849 CS_OFF
5568  0aef 7216500a      	bset	20490,#3
5569                     ; 850 }
5572  0af3 5b03          	addw	sp,#3
5573  0af5 81            	ret
5614                     ; 853 void DF_buffer_to_page_er(/*char buff,*/unsigned page_addr)
5614                     ; 854 {
5615                     	switch	.text
5616  0af6               _DF_buffer_to_page_er:
5618  0af6 89            	pushw	x
5619  0af7 88            	push	a
5620       00000001      OFST:	set	1
5623                     ; 857 d0=0x83; 
5625                     ; 860 CS_ON
5627  0af8 7217500a      	bres	20490,#3
5628                     ; 861 spi(d0);
5630  0afc a683          	ld	a,#131
5631  0afe cd0948        	call	_spi
5633                     ; 862 spi(page_addr/256/**(((char*)&page_addr)+1)*/);
5635  0b01 7b02          	ld	a,(OFST+1,sp)
5636  0b03 cd0948        	call	_spi
5638                     ; 863 spi(page_addr%256/**((char*)&page_addr)*/);
5640  0b06 7b03          	ld	a,(OFST+2,sp)
5641  0b08 a4ff          	and	a,#255
5642  0b0a cd0948        	call	_spi
5644                     ; 864 spi(0xff);
5646  0b0d a6ff          	ld	a,#255
5647  0b0f cd0948        	call	_spi
5649                     ; 866 CS_OFF
5651  0b12 7216500a      	bset	20490,#3
5652                     ; 867 }
5655  0b16 5b03          	addw	sp,#3
5656  0b18 81            	ret
5720                     ; 870 void DF_buffer_read(unsigned buff_addr,unsigned len, char* adr)
5720                     ; 871 {
5721                     	switch	.text
5722  0b19               _DF_buffer_read:
5724  0b19 89            	pushw	x
5725  0b1a 5203          	subw	sp,#3
5726       00000003      OFST:	set	3
5729                     ; 875 d0=0x54; 
5731                     ; 877 CS_ON
5733  0b1c 7217500a      	bres	20490,#3
5734                     ; 878 spi(d0);
5736  0b20 a654          	ld	a,#84
5737  0b22 cd0948        	call	_spi
5739                     ; 879 spi(0xff);
5741  0b25 a6ff          	ld	a,#255
5742  0b27 cd0948        	call	_spi
5744                     ; 880 spi(buff_addr/256/**(((char*)&buff_addr)+1)*/);
5746  0b2a 7b04          	ld	a,(OFST+1,sp)
5747  0b2c cd0948        	call	_spi
5749                     ; 881 spi(buff_addr%256/**((char*)&buff_addr)*/);
5751  0b2f 7b05          	ld	a,(OFST+2,sp)
5752  0b31 a4ff          	and	a,#255
5753  0b33 cd0948        	call	_spi
5755                     ; 882 spi(0xff);
5757  0b36 a6ff          	ld	a,#255
5758  0b38 cd0948        	call	_spi
5760                     ; 883 for(i=0;i<len;i++)
5762  0b3b 5f            	clrw	x
5763  0b3c 1f02          	ldw	(OFST-1,sp),x
5765  0b3e 2012          	jra	L5452
5766  0b40               L1452:
5767                     ; 885 	adr[i]=spi(0xff);
5769  0b40 a6ff          	ld	a,#255
5770  0b42 cd0948        	call	_spi
5772  0b45 1e0a          	ldw	x,(OFST+7,sp)
5773  0b47 72fb02        	addw	x,(OFST-1,sp)
5774  0b4a f7            	ld	(x),a
5775                     ; 883 for(i=0;i<len;i++)
5777  0b4b 1e02          	ldw	x,(OFST-1,sp)
5778  0b4d 1c0001        	addw	x,#1
5779  0b50 1f02          	ldw	(OFST-1,sp),x
5780  0b52               L5452:
5783  0b52 1e02          	ldw	x,(OFST-1,sp)
5784  0b54 1308          	cpw	x,(OFST+5,sp)
5785  0b56 25e8          	jrult	L1452
5786                     ; 888 CS_OFF
5788  0b58 7216500a      	bset	20490,#3
5789                     ; 889 }
5792  0b5c 5b05          	addw	sp,#5
5793  0b5e 81            	ret
5857                     ; 892 void DF_buffer_write(/*char buff,*/unsigned buff_addr,unsigned len, char* adr)
5857                     ; 893 {
5858                     	switch	.text
5859  0b5f               _DF_buffer_write:
5861  0b5f 89            	pushw	x
5862  0b60 5203          	subw	sp,#3
5863       00000003      OFST:	set	3
5866                     ; 897 d0=0x84; 
5868                     ; 899 CS_ON
5870  0b62 7217500a      	bres	20490,#3
5871                     ; 900 spi(d0);
5873  0b66 a684          	ld	a,#132
5874  0b68 cd0948        	call	_spi
5876                     ; 901 spi(0xff);
5878  0b6b a6ff          	ld	a,#255
5879  0b6d cd0948        	call	_spi
5881                     ; 902 spi(buff_addr/256/**(((char*)&buff_addr)+1)*/);
5883  0b70 7b04          	ld	a,(OFST+1,sp)
5884  0b72 cd0948        	call	_spi
5886                     ; 903 spi(buff_addr%256/**((char*)&buff_addr)*/);
5888  0b75 7b05          	ld	a,(OFST+2,sp)
5889  0b77 a4ff          	and	a,#255
5890  0b79 cd0948        	call	_spi
5892                     ; 905 for(i=0;i<len;i++)
5894  0b7c 5f            	clrw	x
5895  0b7d 1f02          	ldw	(OFST-1,sp),x
5897  0b7f 2010          	jra	L3062
5898  0b81               L7752:
5899                     ; 907 	spi(adr[i]);
5901  0b81 1e0a          	ldw	x,(OFST+7,sp)
5902  0b83 72fb02        	addw	x,(OFST-1,sp)
5903  0b86 f6            	ld	a,(x)
5904  0b87 cd0948        	call	_spi
5906                     ; 905 for(i=0;i<len;i++)
5908  0b8a 1e02          	ldw	x,(OFST-1,sp)
5909  0b8c 1c0001        	addw	x,#1
5910  0b8f 1f02          	ldw	(OFST-1,sp),x
5911  0b91               L3062:
5914  0b91 1e02          	ldw	x,(OFST-1,sp)
5915  0b93 1308          	cpw	x,(OFST+5,sp)
5916  0b95 25ea          	jrult	L7752
5917                     ; 910 CS_OFF
5919  0b97 7216500a      	bset	20490,#3
5920                     ; 911 }
5923  0b9b 5b05          	addw	sp,#5
5924  0b9d 81            	ret
5947                     ; 933 void gpio_init(void){
5948                     	switch	.text
5949  0b9e               _gpio_init:
5953                     ; 943 	GPIOD->DDR|=(1<<2);
5955  0b9e 72145011      	bset	20497,#2
5956                     ; 944 	GPIOD->CR1|=(1<<2);
5958  0ba2 72145012      	bset	20498,#2
5959                     ; 945 	GPIOD->CR2|=(1<<2);
5961  0ba6 72145013      	bset	20499,#2
5962                     ; 946 	GPIOD->ODR&=~(1<<2);
5964  0baa 7215500f      	bres	20495,#2
5965                     ; 948 	GPIOD->DDR|=(1<<4);
5967  0bae 72185011      	bset	20497,#4
5968                     ; 949 	GPIOD->CR1|=(1<<4);
5970  0bb2 72185012      	bset	20498,#4
5971                     ; 950 	GPIOD->CR2&=~(1<<4);
5973  0bb6 72195013      	bres	20499,#4
5974                     ; 952 	GPIOC->DDR&=~(1<<4);
5976  0bba 7219500c      	bres	20492,#4
5977                     ; 953 	GPIOC->CR1&=~(1<<4);
5979  0bbe 7219500d      	bres	20493,#4
5980                     ; 954 	GPIOC->CR2&=~(1<<4);
5982  0bc2 7219500e      	bres	20494,#4
5983                     ; 958 }
5986  0bc6 81            	ret
6034                     ; 961 void uart_in(void)
6034                     ; 962 {
6035                     	switch	.text
6036  0bc7               _uart_in:
6038  0bc7 89            	pushw	x
6039       00000002      OFST:	set	2
6042                     ; 966 if(rx_buffer_overflow)
6044                     	btst	_rx_buffer_overflow
6045  0bcd 2410          	jruge	L5362
6046                     ; 968 	rx_wr_index=0;
6048  0bcf 5f            	clrw	x
6049  0bd0 cf01fa        	ldw	_rx_wr_index,x
6050                     ; 969 	rx_rd_index=0;
6052  0bd3 5f            	clrw	x
6053  0bd4 cf01f8        	ldw	_rx_rd_index,x
6054                     ; 970 	rx_counter=0;
6056  0bd7 5f            	clrw	x
6057  0bd8 cf01fc        	ldw	_rx_counter,x
6058                     ; 971 	rx_buffer_overflow=0;
6060  0bdb 72110001      	bres	_rx_buffer_overflow
6061  0bdf               L5362:
6062                     ; 974 if(rx_counter&&(rx_buffer[index_offset(rx_wr_index,-1)])==END)
6064  0bdf ce01fc        	ldw	x,_rx_counter
6065  0be2 2603cc0c68    	jreq	L7362
6067  0be7 aeffff        	ldw	x,#65535
6068  0bea 89            	pushw	x
6069  0beb ce01fa        	ldw	x,_rx_wr_index
6070  0bee ad7a          	call	_index_offset
6072  0bf0 5b02          	addw	sp,#2
6073  0bf2 d60054        	ld	a,(_rx_buffer,x)
6074  0bf5 a10a          	cp	a,#10
6075  0bf7 266f          	jrne	L7362
6076                     ; 979 	temp=rx_buffer[index_offset(rx_wr_index,-3)];
6078  0bf9 aefffd        	ldw	x,#65533
6079  0bfc 89            	pushw	x
6080  0bfd ce01fa        	ldw	x,_rx_wr_index
6081  0c00 ad68          	call	_index_offset
6083  0c02 5b02          	addw	sp,#2
6084  0c04 d60054        	ld	a,(_rx_buffer,x)
6085  0c07 6b01          	ld	(OFST-1,sp),a
6086                     ; 980     	if(temp<100) 
6088  0c09 7b01          	ld	a,(OFST-1,sp)
6089  0c0b a164          	cp	a,#100
6090  0c0d 2459          	jruge	L7362
6091                     ; 983     		if(control_check(index_offset(rx_wr_index,-1)))
6093  0c0f aeffff        	ldw	x,#65535
6094  0c12 89            	pushw	x
6095  0c13 ce01fa        	ldw	x,_rx_wr_index
6096  0c16 ad52          	call	_index_offset
6098  0c18 5b02          	addw	sp,#2
6099  0c1a 9f            	ld	a,xl
6100  0c1b ad75          	call	_control_check
6102  0c1d 4d            	tnz	a
6103  0c1e 2748          	jreq	L7362
6104                     ; 986     			rx_rd_index=index_offset(rx_wr_index,-3-temp);
6106  0c20 a6ff          	ld	a,#255
6107  0c22 97            	ld	xl,a
6108  0c23 a6fd          	ld	a,#253
6109  0c25 1001          	sub	a,(OFST-1,sp)
6110  0c27 2401          	jrnc	L241
6111  0c29 5a            	decw	x
6112  0c2a               L241:
6113  0c2a 02            	rlwa	x,a
6114  0c2b 89            	pushw	x
6115  0c2c 01            	rrwa	x,a
6116  0c2d ce01fa        	ldw	x,_rx_wr_index
6117  0c30 ad38          	call	_index_offset
6119  0c32 5b02          	addw	sp,#2
6120  0c34 cf01f8        	ldw	_rx_rd_index,x
6121                     ; 987     			for(i=0;i<temp;i++)
6123  0c37 0f02          	clr	(OFST+0,sp)
6125  0c39 201a          	jra	L1562
6126  0c3b               L5462:
6127                     ; 989 				UIB[i]=rx_buffer[index_offset(rx_rd_index,i)];
6129  0c3b 7b02          	ld	a,(OFST+0,sp)
6130  0c3d 5f            	clrw	x
6131  0c3e 97            	ld	xl,a
6132  0c3f 89            	pushw	x
6133  0c40 7b04          	ld	a,(OFST+2,sp)
6134  0c42 5f            	clrw	x
6135  0c43 97            	ld	xl,a
6136  0c44 89            	pushw	x
6137  0c45 ce01f8        	ldw	x,_rx_rd_index
6138  0c48 ad20          	call	_index_offset
6140  0c4a 5b02          	addw	sp,#2
6141  0c4c d60054        	ld	a,(_rx_buffer,x)
6142  0c4f 85            	popw	x
6143  0c50 d70000        	ld	(_UIB,x),a
6144                     ; 987     			for(i=0;i<temp;i++)
6146  0c53 0c02          	inc	(OFST+0,sp)
6147  0c55               L1562:
6150  0c55 7b02          	ld	a,(OFST+0,sp)
6151  0c57 1101          	cp	a,(OFST-1,sp)
6152  0c59 25e0          	jrult	L5462
6153                     ; 991 			rx_rd_index=rx_wr_index;
6155  0c5b ce01fa        	ldw	x,_rx_wr_index
6156  0c5e cf01f8        	ldw	_rx_rd_index,x
6157                     ; 992 			rx_counter=0;
6159  0c61 5f            	clrw	x
6160  0c62 cf01fc        	ldw	_rx_counter,x
6161                     ; 1002 			uart_in_an();
6163  0c65 cd023f        	call	_uart_in_an
6165  0c68               L7362:
6166                     ; 1011 }
6169  0c68 85            	popw	x
6170  0c69 81            	ret
6209                     ; 1014 signed short index_offset (signed short index,signed short offset)
6209                     ; 1015 {
6210                     	switch	.text
6211  0c6a               _index_offset:
6213  0c6a 89            	pushw	x
6214       00000000      OFST:	set	0
6217                     ; 1016 index=index+offset;
6219  0c6b 1e01          	ldw	x,(OFST+1,sp)
6220  0c6d 72fb05        	addw	x,(OFST+5,sp)
6221  0c70 1f01          	ldw	(OFST+1,sp),x
6222                     ; 1017 if(index>=RX_BUFFER_SIZE) index-=RX_BUFFER_SIZE; 
6224  0c72 9c            	rvf
6225  0c73 1e01          	ldw	x,(OFST+1,sp)
6226  0c75 a30064        	cpw	x,#100
6227  0c78 2f07          	jrslt	L3762
6230  0c7a 1e01          	ldw	x,(OFST+1,sp)
6231  0c7c 1d0064        	subw	x,#100
6232  0c7f 1f01          	ldw	(OFST+1,sp),x
6233  0c81               L3762:
6234                     ; 1018 if(index<0) index+=RX_BUFFER_SIZE;
6236  0c81 9c            	rvf
6237  0c82 1e01          	ldw	x,(OFST+1,sp)
6238  0c84 2e07          	jrsge	L5762
6241  0c86 1e01          	ldw	x,(OFST+1,sp)
6242  0c88 1c0064        	addw	x,#100
6243  0c8b 1f01          	ldw	(OFST+1,sp),x
6244  0c8d               L5762:
6245                     ; 1019 return index;
6247  0c8d 1e01          	ldw	x,(OFST+1,sp)
6250  0c8f 5b02          	addw	sp,#2
6251  0c91 81            	ret
6306                     ; 1023 char control_check(char index)
6306                     ; 1024 {
6307                     	switch	.text
6308  0c92               _control_check:
6310  0c92 88            	push	a
6311  0c93 5203          	subw	sp,#3
6312       00000003      OFST:	set	3
6315                     ; 1025 char i=0,ii=0,iii;
6319                     ; 1027 if(rx_buffer[index]!=END) return 0;
6321  0c95 5f            	clrw	x
6322  0c96 97            	ld	xl,a
6323  0c97 d60054        	ld	a,(_rx_buffer,x)
6324  0c9a a10a          	cp	a,#10
6325  0c9c 2703          	jreq	L1272
6328  0c9e 4f            	clr	a
6330  0c9f 2055          	jra	L451
6331  0ca1               L1272:
6332                     ; 1029 ii=rx_buffer[index_offset(index,-2)];
6334  0ca1 aefffe        	ldw	x,#65534
6335  0ca4 89            	pushw	x
6336  0ca5 7b06          	ld	a,(OFST+3,sp)
6337  0ca7 5f            	clrw	x
6338  0ca8 97            	ld	xl,a
6339  0ca9 adbf          	call	_index_offset
6341  0cab 5b02          	addw	sp,#2
6342  0cad d60054        	ld	a,(_rx_buffer,x)
6343  0cb0 6b02          	ld	(OFST-1,sp),a
6344                     ; 1030 iii=0;
6346  0cb2 0f01          	clr	(OFST-2,sp)
6347                     ; 1031 for(i=0;i<=ii;i++)
6349  0cb4 0f03          	clr	(OFST+0,sp)
6351  0cb6 2023          	jra	L7272
6352  0cb8               L3272:
6353                     ; 1033 	iii^=rx_buffer[index_offset(index,-2-ii+i)];
6355  0cb8 a6ff          	ld	a,#255
6356  0cba 97            	ld	xl,a
6357  0cbb a6fe          	ld	a,#254
6358  0cbd 1002          	sub	a,(OFST-1,sp)
6359  0cbf 2401          	jrnc	L051
6360  0cc1 5a            	decw	x
6361  0cc2               L051:
6362  0cc2 1b03          	add	a,(OFST+0,sp)
6363  0cc4 2401          	jrnc	L251
6364  0cc6 5c            	incw	x
6365  0cc7               L251:
6366  0cc7 02            	rlwa	x,a
6367  0cc8 89            	pushw	x
6368  0cc9 01            	rrwa	x,a
6369  0cca 7b06          	ld	a,(OFST+3,sp)
6370  0ccc 5f            	clrw	x
6371  0ccd 97            	ld	xl,a
6372  0cce ad9a          	call	_index_offset
6374  0cd0 5b02          	addw	sp,#2
6375  0cd2 7b01          	ld	a,(OFST-2,sp)
6376  0cd4 d80054        	xor	a,	(_rx_buffer,x)
6377  0cd7 6b01          	ld	(OFST-2,sp),a
6378                     ; 1031 for(i=0;i<=ii;i++)
6380  0cd9 0c03          	inc	(OFST+0,sp)
6381  0cdb               L7272:
6384  0cdb 7b03          	ld	a,(OFST+0,sp)
6385  0cdd 1102          	cp	a,(OFST-1,sp)
6386  0cdf 23d7          	jrule	L3272
6387                     ; 1035 if (iii!=rx_buffer[index_offset(index,-1)]) return 0;	
6389  0ce1 aeffff        	ldw	x,#65535
6390  0ce4 89            	pushw	x
6391  0ce5 7b06          	ld	a,(OFST+3,sp)
6392  0ce7 5f            	clrw	x
6393  0ce8 97            	ld	xl,a
6394  0ce9 cd0c6a        	call	_index_offset
6396  0cec 5b02          	addw	sp,#2
6397  0cee d60054        	ld	a,(_rx_buffer,x)
6398  0cf1 1101          	cp	a,(OFST-2,sp)
6399  0cf3 2704          	jreq	L3372
6402  0cf5 4f            	clr	a
6404  0cf6               L451:
6406  0cf6 5b04          	addw	sp,#4
6407  0cf8 81            	ret
6408  0cf9               L3372:
6409                     ; 1037 return 1;
6411  0cf9 a601          	ld	a,#1
6413  0cfb 20f9          	jra	L451
6455                     ; 1046 @far @interrupt void TIM4_UPD_Interrupt (void) {
6457                     	switch	.text
6458  0cfd               f_TIM4_UPD_Interrupt:
6462                     ; 1048 	if(play) {
6464                     	btst	_play
6465  0d02 244e          	jruge	L5472
6466                     ; 1049 		TIM2->CCR3H= 0x00;	
6468  0d04 725f5315      	clr	21269
6469                     ; 1050 		TIM2->CCR3L= sample;
6471  0d08 5501f75316    	mov	21270,_sample
6472                     ; 1051 		sample_cnt++;
6474  0d0d ce0201        	ldw	x,_sample_cnt
6475  0d10 1c0001        	addw	x,#1
6476  0d13 cf0201        	ldw	_sample_cnt,x
6477                     ; 1052 		if(sample_cnt>=256) {
6479  0d16 9c            	rvf
6480  0d17 ce0201        	ldw	x,_sample_cnt
6481  0d1a a30100        	cpw	x,#256
6482  0d1d 2f04          	jrslt	L7472
6483                     ; 1053 			sample_cnt=0;
6485  0d1f 5f            	clrw	x
6486  0d20 cf0201        	ldw	_sample_cnt,x
6487  0d23               L7472:
6488                     ; 1057 		sample=buff[sample_cnt];
6490  0d23 ce0201        	ldw	x,_sample_cnt
6491  0d26 d60050        	ld	a,(_buff,x)
6492  0d29 c701f7        	ld	_sample,a
6493                     ; 1059 		if(sample_cnt==132)	{
6495  0d2c ce0201        	ldw	x,_sample_cnt
6496  0d2f a30084        	cpw	x,#132
6497  0d32 2604          	jrne	L1572
6498                     ; 1060 			bBUFF_LOAD=1;
6500  0d34 7210000b      	bset	_bBUFF_LOAD
6501  0d38               L1572:
6502                     ; 1064 		if(sample_cnt==5) {
6504  0d38 ce0201        	ldw	x,_sample_cnt
6505  0d3b a30005        	cpw	x,#5
6506  0d3e 2604          	jrne	L3572
6507                     ; 1065 			bBUFF_READ_H=1;
6509  0d40 7210000a      	bset	_bBUFF_READ_H
6510  0d44               L3572:
6511                     ; 1068 		if(sample_cnt==150) {
6513  0d44 ce0201        	ldw	x,_sample_cnt
6514  0d47 a30096        	cpw	x,#150
6515  0d4a 2615          	jrne	L7572
6516                     ; 1069 			bBUFF_READ_L=1;
6518  0d4c 72100009      	bset	_bBUFF_READ_L
6519  0d50 200f          	jra	L7572
6520  0d52               L5472:
6521                     ; 1076 	else if(!bSTART) {
6523                     	btst	_bSTART
6524  0d57 2508          	jrult	L7572
6525                     ; 1077 		TIM2->CCR3H= 0x00;	
6527  0d59 725f5315      	clr	21269
6528                     ; 1078 		TIM2->CCR3L= 0x7f;//pwm_fade_in;
6530  0d5d 357f5316      	mov	21270,#127
6531  0d61               L7572:
6532                     ; 1133 		if(but_block_cnt)but_on_drv_cnt=0;
6534  0d61 ce01e0        	ldw	x,_but_block_cnt
6535  0d64 2704          	jreq	L3672
6538  0d66 725f00b9      	clr	_but_on_drv_cnt
6539  0d6a               L3672:
6540                     ; 1134 		if((((GPIOC->IDR)&(1<<4))) && (but_on_drv_cnt<100)) {
6542  0d6a c6500b        	ld	a,20491
6543  0d6d a510          	bcp	a,#16
6544  0d6f 2723          	jreq	L5672
6546  0d71 c600b9        	ld	a,_but_on_drv_cnt
6547  0d74 a164          	cp	a,#100
6548  0d76 241c          	jruge	L5672
6549                     ; 1135 			but_on_drv_cnt++;
6551  0d78 725c00b9      	inc	_but_on_drv_cnt
6552                     ; 1136 			if((but_on_drv_cnt>2)&&(bRELEASE))
6554  0d7c c600b9        	ld	a,_but_on_drv_cnt
6555  0d7f a103          	cp	a,#3
6556  0d81 2519          	jrult	L1772
6558                     	btst	_bRELEASE
6559  0d88 2412          	jruge	L1772
6560                     ; 1138 				bRELEASE=0;
6562  0d8a 72110000      	bres	_bRELEASE
6563                     ; 1139 				bSTART=1;
6565  0d8e 7210000c      	bset	_bSTART
6566  0d92 2008          	jra	L1772
6567  0d94               L5672:
6568                     ; 1143 			but_on_drv_cnt=0;
6570  0d94 725f00b9      	clr	_but_on_drv_cnt
6571                     ; 1144 			bRELEASE=1;
6573  0d98 72100000      	bset	_bRELEASE
6574  0d9c               L1772:
6575                     ; 1149 	if(++t0_cnt0>=125){
6577  0d9c 725c0000      	inc	_t0_cnt0
6578  0da0 c60000        	ld	a,_t0_cnt0
6579  0da3 a17d          	cp	a,#125
6580  0da5 2541          	jrult	L3772
6581                     ; 1150     		t0_cnt0=0;
6583  0da7 725f0000      	clr	_t0_cnt0
6584                     ; 1151     		b100Hz=1;
6586  0dab 72100008      	bset	_b100Hz
6587                     ; 1161 		if(++t0_cnt1>=10){
6589  0daf 725c0001      	inc	_t0_cnt1
6590  0db3 c60001        	ld	a,_t0_cnt1
6591  0db6 a10a          	cp	a,#10
6592  0db8 2508          	jrult	L5772
6593                     ; 1162 			t0_cnt1=0;
6595  0dba 725f0001      	clr	_t0_cnt1
6596                     ; 1163 			b10Hz=1;
6598  0dbe 72100007      	bset	_b10Hz
6599  0dc2               L5772:
6600                     ; 1166 		if(++t0_cnt2>=20){
6602  0dc2 725c0002      	inc	_t0_cnt2
6603  0dc6 c60002        	ld	a,_t0_cnt2
6604  0dc9 a114          	cp	a,#20
6605  0dcb 2508          	jrult	L7772
6606                     ; 1167 			t0_cnt2=0;
6608  0dcd 725f0002      	clr	_t0_cnt2
6609                     ; 1168 			b5Hz=1;
6611  0dd1 72100006      	bset	_b5Hz
6612  0dd5               L7772:
6613                     ; 1171 		if(++t0_cnt3>=100){
6615  0dd5 725c0003      	inc	_t0_cnt3
6616  0dd9 c60003        	ld	a,_t0_cnt3
6617  0ddc a164          	cp	a,#100
6618  0dde 2508          	jrult	L3772
6619                     ; 1172 			t0_cnt3=0;
6621  0de0 725f0003      	clr	_t0_cnt3
6622                     ; 1173 			b1Hz=1;
6624  0de4 72100005      	bset	_b1Hz
6625  0de8               L3772:
6626                     ; 1177 	TIM4->SR1&=~TIM4_SR1_UIF;			// disable break interrupt
6628  0de8 72115344      	bres	21316,#0
6629                     ; 1178 	return;
6632  0dec 80            	iret
6658                     ; 1182 @far @interrupt void UARTTxInterrupt (void) {
6659                     	switch	.text
6660  0ded               f_UARTTxInterrupt:
6664                     ; 1184 	if (tx_counter){
6666  0ded 725d0200      	tnz	_tx_counter
6667  0df1 2723          	jreq	L3103
6668                     ; 1185 		--tx_counter;
6670  0df3 725a0200      	dec	_tx_counter
6671                     ; 1186 		UART1->DR=tx_buffer[tx_rd_index];
6673  0df7 5f            	clrw	x
6674  0df8 c601fe        	ld	a,_tx_rd_index
6675  0dfb 2a01          	jrpl	L261
6676  0dfd 53            	cplw	x
6677  0dfe               L261:
6678  0dfe 97            	ld	xl,a
6679  0dff d60004        	ld	a,(_tx_buffer,x)
6680  0e02 c75231        	ld	21041,a
6681                     ; 1187 		if (++tx_rd_index == TX_BUFFER_SIZE) tx_rd_index=0;
6683  0e05 725c01fe      	inc	_tx_rd_index
6684  0e09 c601fe        	ld	a,_tx_rd_index
6685  0e0c a150          	cp	a,#80
6686  0e0e 260e          	jrne	L7103
6689  0e10 725f01fe      	clr	_tx_rd_index
6690  0e14 2008          	jra	L7103
6691  0e16               L3103:
6692                     ; 1190 		bOUT_FREE=1;
6694  0e16 72100003      	bset	_bOUT_FREE
6695                     ; 1191 		UART1->CR2&= ~UART1_CR2_TIEN;
6697  0e1a 721f5235      	bres	21045,#7
6698  0e1e               L7103:
6699                     ; 1193 }
6702  0e1e 80            	iret
6731                     ; 1196 @far @interrupt void UARTRxInterrupt (void) {
6732                     	switch	.text
6733  0e1f               f_UARTRxInterrupt:
6737                     ; 1201 	rx_status=UART1->SR;
6739  0e1f 55523001e6    	mov	_rx_status,21040
6740                     ; 1202 	rx_data=UART1->DR;
6742  0e24 55523101e5    	mov	_rx_data,21041
6743                     ; 1204 	if (rx_status & (UART1_SR_RXNE)){
6745  0e29 c601e6        	ld	a,_rx_status
6746  0e2c a520          	bcp	a,#32
6747  0e2e 2735          	jreq	L1303
6748                     ; 1205 		rx_buffer[rx_wr_index]=rx_data;
6750  0e30 ce01fa        	ldw	x,_rx_wr_index
6751  0e33 c601e5        	ld	a,_rx_data
6752  0e36 d70054        	ld	(_rx_buffer,x),a
6753                     ; 1206 		bRXIN=1;
6755  0e39 72100002      	bset	_bRXIN
6756                     ; 1207 		if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
6758  0e3d ce01fa        	ldw	x,_rx_wr_index
6759  0e40 1c0001        	addw	x,#1
6760  0e43 cf01fa        	ldw	_rx_wr_index,x
6761  0e46 a30064        	cpw	x,#100
6762  0e49 2604          	jrne	L3303
6765  0e4b 5f            	clrw	x
6766  0e4c cf01fa        	ldw	_rx_wr_index,x
6767  0e4f               L3303:
6768                     ; 1208 		if (++rx_counter == RX_BUFFER_SIZE){
6770  0e4f ce01fc        	ldw	x,_rx_counter
6771  0e52 1c0001        	addw	x,#1
6772  0e55 cf01fc        	ldw	_rx_counter,x
6773  0e58 a30064        	cpw	x,#100
6774  0e5b 2608          	jrne	L1303
6775                     ; 1209 			rx_counter=0;
6777  0e5d 5f            	clrw	x
6778  0e5e cf01fc        	ldw	_rx_counter,x
6779                     ; 1210 			rx_buffer_overflow=1;
6781  0e61 72100001      	bset	_rx_buffer_overflow
6782  0e65               L1303:
6783                     ; 1213 }
6786  0e65 80            	iret
6846                     ; 1219 main()
6846                     ; 1220 {
6848                     	switch	.text
6849  0e66               _main:
6853                     ; 1221 CLK->CKDIVR=0;
6855  0e66 725f50c6      	clr	20678
6856                     ; 1223 rele_cnt_index=0;
6858  0e6a 725f00bb      	clr	_rele_cnt_index
6859                     ; 1225 GPIOD->DDR&=~(1<<6);
6861  0e6e 721d5011      	bres	20497,#6
6862                     ; 1226 GPIOD->CR1|=(1<<6);
6864  0e72 721c5012      	bset	20498,#6
6865                     ; 1227 GPIOD->CR2|=(1<<6);
6867  0e76 721c5013      	bset	20499,#6
6868                     ; 1229 GPIOD->DDR|=(1<<5);
6870  0e7a 721a5011      	bset	20497,#5
6871                     ; 1230 GPIOD->CR1|=(1<<5);
6873  0e7e 721a5012      	bset	20498,#5
6874                     ; 1231 GPIOD->CR2|=(1<<5);	
6876  0e82 721a5013      	bset	20499,#5
6877                     ; 1232 GPIOD->ODR|=(1<<5);
6879  0e86 721a500f      	bset	20495,#5
6880                     ; 1234 delay_ms(10);
6882  0e8a ae000a        	ldw	x,#10
6883  0e8d cd0063        	call	_delay_ms
6885                     ; 1236 if(!(GPIOD->IDR&=(1<<6))) 
6887  0e90 c65010        	ld	a,20496
6888  0e93 a440          	and	a,#64
6889  0e95 c75010        	ld	20496,a
6890  0e98 2606          	jrne	L7403
6891                     ; 1238 	rele_cnt_index=1;
6893  0e9a 350100bb      	mov	_rele_cnt_index,#1
6895  0e9e 2018          	jra	L1503
6896  0ea0               L7403:
6897                     ; 1242 	GPIOD->ODR&=~(1<<5);
6899  0ea0 721b500f      	bres	20495,#5
6900                     ; 1243 	delay_ms(10);
6902  0ea4 ae000a        	ldw	x,#10
6903  0ea7 cd0063        	call	_delay_ms
6905                     ; 1244 	if(!(GPIOD->IDR&=(1<<6))) 
6907  0eaa c65010        	ld	a,20496
6908  0ead a440          	and	a,#64
6909  0eaf c75010        	ld	20496,a
6910  0eb2 2604          	jrne	L1503
6911                     ; 1246 		rele_cnt_index=2;
6913  0eb4 350200bb      	mov	_rele_cnt_index,#2
6914  0eb8               L1503:
6915                     ; 1250 gpio_init();
6917  0eb8 cd0b9e        	call	_gpio_init
6919                     ; 1257 spi_init();
6921  0ebb cd08db        	call	_spi_init
6923                     ; 1259 t4_init();
6925  0ebe cd0039        	call	_t4_init
6927                     ; 1261 FLASH_DUKR=0xae;
6929  0ec1 35ae5064      	mov	_FLASH_DUKR,#174
6930                     ; 1262 FLASH_DUKR=0x56;
6932  0ec5 35565064      	mov	_FLASH_DUKR,#86
6933                     ; 1267 dumm[1]++;
6935  0ec9 725c017d      	inc	_dumm+1
6936                     ; 1269 uart_init();
6938  0ecd cd00a5        	call	_uart_init
6940                     ; 1271 ST_RDID_read();
6942  0ed0 cd0966        	call	_ST_RDID_read
6944                     ; 1272 if(mdr0==0x20) memory_manufacturer='S';	
6946  0ed3 c601f6        	ld	a,_mdr0
6947  0ed6 a120          	cp	a,#32
6948  0ed8 2606          	jrne	L5503
6951  0eda 355300bc      	mov	_memory_manufacturer,#83
6953  0ede 200e          	jra	L7503
6954  0ee0               L5503:
6955                     ; 1275 	DF_mf_dev_read();
6957  0ee0 cd0a61        	call	_DF_mf_dev_read
6959                     ; 1276 	if(mdr0==0x1F) memory_manufacturer='A';
6961  0ee3 c601f6        	ld	a,_mdr0
6962  0ee6 a11f          	cp	a,#31
6963  0ee8 2604          	jrne	L7503
6966  0eea 354100bc      	mov	_memory_manufacturer,#65
6967  0eee               L7503:
6968                     ; 1279 t2_init();
6970  0eee cd0000        	call	_t2_init
6972                     ; 1281 ST_WREN();
6974  0ef1 cd09ba        	call	_ST_WREN
6976                     ; 1283 enableInterrupts();	
6979  0ef4 9a            rim
6981  0ef5               L3603:
6982                     ; 1288 	if(bBUFF_LOAD)
6984                     	btst	_bBUFF_LOAD
6985  0efa 242c          	jruge	L7603
6986                     ; 1290 		bBUFF_LOAD=0;
6988  0efc 7211000b      	bres	_bBUFF_LOAD
6989                     ; 1292 		if(current_page<last_page)
6991  0f00 ce01ef        	ldw	x,_current_page
6992  0f03 c301ed        	cpw	x,_last_page
6993  0f06 240b          	jruge	L1703
6994                     ; 1294 			current_page++;
6996  0f08 ce01ef        	ldw	x,_current_page
6997  0f0b 1c0001        	addw	x,#1
6998  0f0e cf01ef        	ldw	_current_page,x
7000  0f11 2008          	jra	L3703
7001  0f13               L1703:
7002                     ; 1298 			current_page=0;
7004  0f13 5f            	clrw	x
7005  0f14 cf01ef        	ldw	_current_page,x
7006                     ; 1299 			play=0;
7008  0f17 72110004      	bres	_play
7009  0f1b               L3703:
7010                     ; 1301 		if(memory_manufacturer=='A')
7012  0f1b c600bc        	ld	a,_memory_manufacturer
7013  0f1e a141          	cp	a,#65
7014  0f20 2606          	jrne	L7603
7015                     ; 1303 			DF_page_to_buffer(/*///current_buffer_H*//*1,*/current_page);
7017  0f22 ce01ef        	ldw	x,_current_page
7018  0f25 cd0ad3        	call	_DF_page_to_buffer
7020  0f28               L7603:
7021                     ; 1307 	if(bBUFF_READ_L)
7023                     	btst	_bBUFF_READ_L
7024  0f2d 243d          	jruge	L7703
7025                     ; 1309 		bBUFF_READ_L=0;
7027  0f2f 72110009      	bres	_bBUFF_READ_L
7028                     ; 1310 		if(memory_manufacturer=='A')
7030  0f33 c600bc        	ld	a,_memory_manufacturer
7031  0f36 a141          	cp	a,#65
7032  0f38 260e          	jrne	L1013
7033                     ; 1312 			DF_buffer_read(/*///current_buffer_L*//*1,*/0,128,buff);
7035  0f3a ae0050        	ldw	x,#_buff
7036  0f3d 89            	pushw	x
7037  0f3e ae0080        	ldw	x,#128
7038  0f41 89            	pushw	x
7039  0f42 5f            	clrw	x
7040  0f43 cd0b19        	call	_DF_buffer_read
7042  0f46 5b04          	addw	sp,#4
7043  0f48               L1013:
7044                     ; 1314 		if(memory_manufacturer=='S')
7046  0f48 c600bc        	ld	a,_memory_manufacturer
7047  0f4b a153          	cp	a,#83
7048  0f4d 261d          	jrne	L7703
7049                     ; 1316 			ST_READ((unsigned long)((unsigned long)(current_page*256UL)),128,buff);
7051  0f4f ae0050        	ldw	x,#_buff
7052  0f52 89            	pushw	x
7053  0f53 ae0080        	ldw	x,#128
7054  0f56 89            	pushw	x
7055  0f57 ce01ef        	ldw	x,_current_page
7056  0f5a 90ae0100      	ldw	y,#256
7057  0f5e cd0000        	call	c_umul
7059  0f61 be02          	ldw	x,c_lreg+2
7060  0f63 89            	pushw	x
7061  0f64 be00          	ldw	x,c_lreg
7062  0f66 89            	pushw	x
7063  0f67 cd0a13        	call	_ST_READ
7065  0f6a 5b08          	addw	sp,#8
7066  0f6c               L7703:
7067                     ; 1320 	if(bBUFF_READ_H) 
7069                     	btst	_bBUFF_READ_H
7070  0f71 2444          	jruge	L5013
7071                     ; 1322 		bBUFF_READ_H=0;
7073  0f73 7211000a      	bres	_bBUFF_READ_H
7074                     ; 1323 		if(memory_manufacturer=='A') 
7076  0f77 c600bc        	ld	a,_memory_manufacturer
7077  0f7a a141          	cp	a,#65
7078  0f7c 2610          	jrne	L7013
7079                     ; 1325 			DF_buffer_read(/*///current_buffer_L*//*1,*/128,128,&buff[128]);
7081  0f7e ae00d0        	ldw	x,#_buff+128
7082  0f81 89            	pushw	x
7083  0f82 ae0080        	ldw	x,#128
7084  0f85 89            	pushw	x
7085  0f86 ae0080        	ldw	x,#128
7086  0f89 cd0b19        	call	_DF_buffer_read
7088  0f8c 5b04          	addw	sp,#4
7089  0f8e               L7013:
7090                     ; 1327 		if(memory_manufacturer=='S') 
7092  0f8e c600bc        	ld	a,_memory_manufacturer
7093  0f91 a153          	cp	a,#83
7094  0f93 2622          	jrne	L5013
7095                     ; 1329 			ST_READ((unsigned long)((unsigned long)(current_page*256UL)+128UL),128,&buff[128]);
7097  0f95 ae00d0        	ldw	x,#_buff+128
7098  0f98 89            	pushw	x
7099  0f99 ae0080        	ldw	x,#128
7100  0f9c 89            	pushw	x
7101  0f9d ce01ef        	ldw	x,_current_page
7102  0fa0 90ae0100      	ldw	y,#256
7103  0fa4 cd0000        	call	c_umul
7105  0fa7 a680          	ld	a,#128
7106  0fa9 cd0000        	call	c_ladc
7108  0fac be02          	ldw	x,c_lreg+2
7109  0fae 89            	pushw	x
7110  0faf be00          	ldw	x,c_lreg
7111  0fb1 89            	pushw	x
7112  0fb2 cd0a13        	call	_ST_READ
7114  0fb5 5b08          	addw	sp,#8
7115  0fb7               L5013:
7116                     ; 1333 	if(bRXIN)
7118                     	btst	_bRXIN
7119  0fbc 2407          	jruge	L3113
7120                     ; 1335 		bRXIN=0;
7122  0fbe 72110002      	bres	_bRXIN
7123                     ; 1337 		uart_in();
7125  0fc2 cd0bc7        	call	_uart_in
7127  0fc5               L3113:
7128                     ; 1341 	if(b100Hz)
7130                     	btst	_b100Hz
7131  0fca 2503          	jrult	L071
7132  0fcc cc106a        	jp	L5113
7133  0fcf               L071:
7134                     ; 1343 		b100Hz=0;
7136  0fcf 72110008      	bres	_b100Hz
7137                     ; 1345 		if(but_block_cnt)but_block_cnt--;
7139  0fd3 ce01e0        	ldw	x,_but_block_cnt
7140  0fd6 2709          	jreq	L7113
7143  0fd8 ce01e0        	ldw	x,_but_block_cnt
7144  0fdb 1d0001        	subw	x,#1
7145  0fde cf01e0        	ldw	_but_block_cnt,x
7146  0fe1               L7113:
7147                     ; 1347 		if(bSTART==1) 
7149                     	btst	_bSTART
7150  0fe6 24e4          	jruge	L5113
7151                     ; 1349 			if(play) 
7153                     	btst	_play
7154  0fed 2406          	jruge	L3213
7155                     ; 1359 				bSTART=0;
7157  0fef 7211000c      	bres	_bSTART
7159  0ff3 2075          	jra	L5113
7160  0ff5               L3213:
7161                     ; 1366 				current_page=1;
7163  0ff5 ae0001        	ldw	x,#1
7164  0ff8 cf01ef        	ldw	_current_page,x
7165                     ; 1371 				last_page=EE_PAGE_LEN-1;
7167  0ffb ce0000        	ldw	x,_EE_PAGE_LEN
7168  0ffe 5a            	decw	x
7169  0fff cf01ed        	ldw	_last_page,x
7170                     ; 1373 				if(memory_manufacturer=='A')
7172  1002 c600bc        	ld	a,_memory_manufacturer
7173  1005 a141          	cp	a,#65
7174  1007 2630          	jrne	L7213
7175                     ; 1375 					DF_page_to_buffer(/*///current_buffer_H*//*1,*/current_page);
7177  1009 ae0001        	ldw	x,#1
7178  100c cd0ad3        	call	_DF_page_to_buffer
7180                     ; 1376 					delay_ms(10);
7182  100f ae000a        	ldw	x,#10
7183  1012 cd0063        	call	_delay_ms
7185                     ; 1377 					DF_buffer_read(/*///current_buffer_L*//*1,*/0,128,buff);
7187  1015 ae0050        	ldw	x,#_buff
7188  1018 89            	pushw	x
7189  1019 ae0080        	ldw	x,#128
7190  101c 89            	pushw	x
7191  101d 5f            	clrw	x
7192  101e cd0b19        	call	_DF_buffer_read
7194  1021 5b04          	addw	sp,#4
7195                     ; 1378 					delay_ms(10);
7197  1023 ae000a        	ldw	x,#10
7198  1026 cd0063        	call	_delay_ms
7200                     ; 1379 					DF_buffer_read(/*///current_buffer_L*//*1,*/128,128,&buff[128]);         
7202  1029 ae00d0        	ldw	x,#_buff+128
7203  102c 89            	pushw	x
7204  102d ae0080        	ldw	x,#128
7205  1030 89            	pushw	x
7206  1031 ae0080        	ldw	x,#128
7207  1034 cd0b19        	call	_DF_buffer_read
7209  1037 5b04          	addw	sp,#4
7210  1039               L7213:
7211                     ; 1381 				if(memory_manufacturer=='S') 
7213  1039 c600bc        	ld	a,_memory_manufacturer
7214  103c a153          	cp	a,#83
7215  103e 2615          	jrne	L1313
7216                     ; 1383 					ST_READ(0,256,buff);
7218  1040 ae0050        	ldw	x,#_buff
7219  1043 89            	pushw	x
7220  1044 ae0100        	ldw	x,#256
7221  1047 89            	pushw	x
7222  1048 ae0000        	ldw	x,#0
7223  104b 89            	pushw	x
7224  104c ae0000        	ldw	x,#0
7225  104f 89            	pushw	x
7226  1050 cd0a13        	call	_ST_READ
7228  1053 5b08          	addw	sp,#8
7229  1055               L1313:
7230                     ; 1385 				play=1;
7232  1055 72100004      	bset	_play
7233                     ; 1386 				bSTART=0;
7235  1059 7211000c      	bres	_bSTART
7236                     ; 1388 				rele_cnt=rele_cnt_const[rele_cnt_index];
7238  105d c600bb        	ld	a,_rele_cnt_index
7239  1060 5f            	clrw	x
7240  1061 97            	ld	xl,a
7241  1062 d60000        	ld	a,(_rele_cnt_const,x)
7242  1065 5f            	clrw	x
7243  1066 97            	ld	xl,a
7244  1067 cf01e3        	ldw	_rele_cnt,x
7245  106a               L5113:
7246                     ; 1396 	if(b10Hz)
7248                     	btst	_b10Hz
7249  106f 2416          	jruge	L3313
7250                     ; 1398 		b10Hz=0;
7252  1071 72110007      	bres	_b10Hz
7253                     ; 1400 		rele_drv();
7255  1075 cd004a        	call	_rele_drv
7257                     ; 1401 		pwm_fade_in++;
7259  1078 725c00ba      	inc	_pwm_fade_in
7260                     ; 1402 		if(pwm_fade_in>128)pwm_fade_in=128;			
7262  107c c600ba        	ld	a,_pwm_fade_in
7263  107f a181          	cp	a,#129
7264  1081 2504          	jrult	L3313
7267  1083 358000ba      	mov	_pwm_fade_in,#128
7268  1087               L3313:
7269                     ; 1405 	if(b5Hz)
7271                     	btst	_b5Hz
7272  108c 2404          	jruge	L7313
7273                     ; 1407 		b5Hz=0;
7275  108e 72110006      	bres	_b5Hz
7276  1092               L7313:
7277                     ; 1413 	if(b1Hz)
7279                     	btst	_b1Hz
7280  1097 2503          	jrult	L271
7281  1099 cc0ef5        	jp	L3603
7282  109c               L271:
7283                     ; 1416 		b1Hz=0;
7285  109c 72110005      	bres	_b1Hz
7286  10a0 acf50ef5      	jpf	L3603
7720                     	xdef	_main
7721                     .eeprom:	section	.data
7722  0000               _EE_PAGE_LEN:
7723  0000 0000          	ds.b	2
7724                     	xdef	_EE_PAGE_LEN
7725                     	switch	.bss
7726  0000               _UIB:
7727  0000 000000000000  	ds.b	80
7728                     	xdef	_UIB
7729  0050               _buff:
7730  0050 000000000000  	ds.b	300
7731                     	xdef	_buff
7732  017c               _dumm:
7733  017c 000000000000  	ds.b	100
7734                     	xdef	_dumm
7735                     .bit:	section	.data,bit
7736  0000               _bRELEASE:
7737  0000 00            	ds.b	1
7738                     	xdef	_bRELEASE
7739  0001               _rx_buffer_overflow:
7740  0001 00            	ds.b	1
7741                     	xdef	_rx_buffer_overflow
7742  0002               _bRXIN:
7743  0002 00            	ds.b	1
7744                     	xdef	_bRXIN
7745  0003               _bOUT_FREE:
7746  0003 00            	ds.b	1
7747                     	xdef	_bOUT_FREE
7748  0004               _play:
7749  0004 00            	ds.b	1
7750                     	xdef	_play
7751  0005               _b1Hz:
7752  0005 00            	ds.b	1
7753                     	xdef	_b1Hz
7754  0006               _b5Hz:
7755  0006 00            	ds.b	1
7756                     	xdef	_b5Hz
7757  0007               _b10Hz:
7758  0007 00            	ds.b	1
7759                     	xdef	_b10Hz
7760  0008               _b100Hz:
7761  0008 00            	ds.b	1
7762                     	xdef	_b100Hz
7763  0009               _bBUFF_READ_L:
7764  0009 00            	ds.b	1
7765                     	xdef	_bBUFF_READ_L
7766  000a               _bBUFF_READ_H:
7767  000a 00            	ds.b	1
7768                     	xdef	_bBUFF_READ_H
7769  000b               _bBUFF_LOAD:
7770  000b 00            	ds.b	1
7771                     	xdef	_bBUFF_LOAD
7772  000c               _bSTART:
7773  000c 00            	ds.b	1
7774                     	xdef	_bSTART
7775                     	switch	.bss
7776  01e0               _but_block_cnt:
7777  01e0 0000          	ds.b	2
7778                     	xdef	_but_block_cnt
7779                     	xdef	_memory_manufacturer
7780                     	xdef	_rele_cnt_const
7781                     	xdef	_rele_cnt_index
7782                     	xdef	_pwm_fade_in
7783  01e2               _rx_offset:
7784  01e2 00            	ds.b	1
7785                     	xdef	_rx_offset
7786  01e3               _rele_cnt:
7787  01e3 0000          	ds.b	2
7788                     	xdef	_rele_cnt
7789  01e5               _rx_data:
7790  01e5 00            	ds.b	1
7791                     	xdef	_rx_data
7792  01e6               _rx_status:
7793  01e6 00            	ds.b	1
7794                     	xdef	_rx_status
7795  01e7               _file_lengt:
7796  01e7 00000000      	ds.b	4
7797                     	xdef	_file_lengt
7798  01eb               _current_byte_in_buffer:
7799  01eb 0000          	ds.b	2
7800                     	xdef	_current_byte_in_buffer
7801  01ed               _last_page:
7802  01ed 0000          	ds.b	2
7803                     	xdef	_last_page
7804  01ef               _current_page:
7805  01ef 0000          	ds.b	2
7806                     	xdef	_current_page
7807  01f1               _file_lengt_in_pages:
7808  01f1 0000          	ds.b	2
7809                     	xdef	_file_lengt_in_pages
7810  01f3               _mdr3:
7811  01f3 00            	ds.b	1
7812                     	xdef	_mdr3
7813  01f4               _mdr2:
7814  01f4 00            	ds.b	1
7815                     	xdef	_mdr2
7816  01f5               _mdr1:
7817  01f5 00            	ds.b	1
7818                     	xdef	_mdr1
7819  01f6               _mdr0:
7820  01f6 00            	ds.b	1
7821                     	xdef	_mdr0
7822                     	xdef	_but_on_drv_cnt
7823                     	xdef	_but_drv_cnt
7824  01f7               _sample:
7825  01f7 00            	ds.b	1
7826                     	xdef	_sample
7827  01f8               _rx_rd_index:
7828  01f8 0000          	ds.b	2
7829                     	xdef	_rx_rd_index
7830  01fa               _rx_wr_index:
7831  01fa 0000          	ds.b	2
7832                     	xdef	_rx_wr_index
7833  01fc               _rx_counter:
7834  01fc 0000          	ds.b	2
7835                     	xdef	_rx_counter
7836                     	xdef	_rx_buffer
7837  01fe               _tx_rd_index:
7838  01fe 00            	ds.b	1
7839                     	xdef	_tx_rd_index
7840  01ff               _tx_wr_index:
7841  01ff 00            	ds.b	1
7842                     	xdef	_tx_wr_index
7843  0200               _tx_counter:
7844  0200 00            	ds.b	1
7845                     	xdef	_tx_counter
7846                     	xdef	_tx_buffer
7847  0201               _sample_cnt:
7848  0201 0000          	ds.b	2
7849                     	xdef	_sample_cnt
7850                     	xdef	_t0_cnt3
7851                     	xdef	_t0_cnt2
7852                     	xdef	_t0_cnt1
7853                     	xdef	_t0_cnt0
7854                     	xdef	_ST_bulk_erase
7855                     	xdef	_ST_READ
7856                     	xdef	_ST_WRITE
7857                     	xdef	_ST_WREN
7858                     	xdef	_ST_status_read
7859                     	xdef	_ST_RDID_read
7860                     	xdef	_uart_in_an
7861                     	xdef	_control_check
7862                     	xdef	_index_offset
7863                     	xdef	_uart_in
7864                     	xdef	_gpio_init
7865                     	xdef	_spi_init
7866                     	xdef	_spi
7867                     	xdef	_DF_buffer_to_page_er
7868                     	xdef	_DF_page_to_buffer
7869                     	xdef	_DF_buffer_write
7870                     	xdef	_DF_buffer_read
7871                     	xdef	_DF_status_read
7872                     	xdef	_DF_memo_to_256
7873                     	xdef	_DF_mf_dev_read
7874                     	xdef	_uart_init
7875                     	xdef	f_UARTRxInterrupt
7876                     	xdef	f_UARTTxInterrupt
7877                     	xdef	_putchar
7878                     	xdef	_uart_out_adr_block
7879                     	xdef	_uart_out
7880                     	xdef	f_TIM4_UPD_Interrupt
7881                     	xdef	_delay_ms
7882                     	xdef	_rele_drv
7883                     	xdef	_t4_init
7884                     	xdef	_t2_init
7885                     	xref.b	c_lreg
7886                     	xref.b	c_x
7887                     	xref.b	c_y
7907                     	xref	c_ladc
7908                     	xref	c_itolx
7909                     	xref	c_umul
7910                     	xref	c_eewrw
7911                     	xref	c_lglsh
7912                     	xref	c_uitolx
7913                     	xref	c_lgursh
7914                     	xref	c_lcmp
7915                     	xref	c_ltor
7916                     	xref	c_lgadc
7917                     	xref	c_rtol
7918                     	xref	c_vmul
7919                     	end
