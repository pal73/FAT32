   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32.1 - 30 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
2173                     	bsct
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
2198  0000 0a            	dc.b	10
2199  0001 19            	dc.b	25
2200  0002 32            	dc.b	50
2201                     	bsct
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
2263                     ; 66 	TIM2->CCR3L= 200;
2265  0020 35c85316      	mov	21270,#200
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
2353                     ; 90 void rele_drv(void) 
2353                     ; 91 {
2354                     	switch	.text
2355  004a               _rele_drv:
2359                     ; 92 	if(rele_cnt) 
2361  004a be03          	ldw	x,_rele_cnt
2362  004c 2711          	jreq	L1641
2363                     ; 94 		play=0;
2365  004e 72110004      	bres	_play
2366                     ; 95 		rele_cnt--;
2368  0052 be03          	ldw	x,_rele_cnt
2369  0054 1d0001        	subw	x,#1
2370  0057 bf03          	ldw	_rele_cnt,x
2371                     ; 96 		GPIOD->ODR|=(1<<4);
2373  0059 7218500f      	bset	20495,#4
2375  005d 2004          	jra	L3641
2376  005f               L1641:
2377                     ; 98 	else GPIOD->ODR&=~(1<<4); 
2379  005f 7219500f      	bres	20495,#4
2380  0063               L3641:
2381                     ; 99 }
2384  0063 81            	ret
2445                     ; 102 long delay_ms(short in)
2445                     ; 103 {
2446                     	switch	.text
2447  0064               _delay_ms:
2449  0064 520c          	subw	sp,#12
2450       0000000c      OFST:	set	12
2453                     ; 106 i=((long)in)*100UL;
2455  0066 90ae0064      	ldw	y,#100
2456  006a cd0000        	call	c_vmul
2458  006d 96            	ldw	x,sp
2459  006e 1c0005        	addw	x,#OFST-7
2460  0071 cd0000        	call	c_rtol
2462                     ; 108 for(ii=0;ii<i;ii++)
2464  0074 ae0000        	ldw	x,#0
2465  0077 1f0b          	ldw	(OFST-1,sp),x
2466  0079 ae0000        	ldw	x,#0
2467  007c 1f09          	ldw	(OFST-3,sp),x
2469  007e 2012          	jra	L3251
2470  0080               L7151:
2471                     ; 110 		iii++;
2473  0080 96            	ldw	x,sp
2474  0081 1c0001        	addw	x,#OFST-11
2475  0084 a601          	ld	a,#1
2476  0086 cd0000        	call	c_lgadc
2478                     ; 108 for(ii=0;ii<i;ii++)
2480  0089 96            	ldw	x,sp
2481  008a 1c0009        	addw	x,#OFST-3
2482  008d a601          	ld	a,#1
2483  008f cd0000        	call	c_lgadc
2485  0092               L3251:
2488  0092 9c            	rvf
2489  0093 96            	ldw	x,sp
2490  0094 1c0009        	addw	x,#OFST-3
2491  0097 cd0000        	call	c_ltor
2493  009a 96            	ldw	x,sp
2494  009b 1c0005        	addw	x,#OFST-7
2495  009e cd0000        	call	c_lcmp
2497  00a1 2fdd          	jrslt	L7151
2498                     ; 113 }
2501  00a3 5b0c          	addw	sp,#12
2502  00a5 81            	ret
2525                     ; 116 void uart_init (void){
2526                     	switch	.text
2527  00a6               _uart_init:
2531                     ; 117 	GPIOD->DDR|=(1<<5);
2533  00a6 721a5011      	bset	20497,#5
2534                     ; 118 	GPIOD->CR1|=(1<<5);
2536  00aa 721a5012      	bset	20498,#5
2537                     ; 119 	GPIOD->CR2|=(1<<5);
2539  00ae 721a5013      	bset	20499,#5
2540                     ; 122 	GPIOD->DDR&=~(1<<6);
2542  00b2 721d5011      	bres	20497,#6
2543                     ; 123 	GPIOD->CR1&=~(1<<6);
2545  00b6 721d5012      	bres	20498,#6
2546                     ; 124 	GPIOD->CR2&=~(1<<6);
2548  00ba 721d5013      	bres	20499,#6
2549                     ; 127 	UART1->CR1&=~UART1_CR1_M;					
2551  00be 72195234      	bres	21044,#4
2552                     ; 128 	UART1->CR3|= (0<<4) & UART1_CR3_STOP;	
2554  00c2 c65236        	ld	a,21046
2555                     ; 129 	UART1->BRR2= 0x01;//0x03;
2557  00c5 35015233      	mov	21043,#1
2558                     ; 130 	UART1->BRR1= 0x1a;//0x68;
2560  00c9 351a5232      	mov	21042,#26
2561                     ; 131 	UART1->CR2|= UART1_CR2_TEN | UART3_CR2_REN | UART3_CR2_RIEN;	
2563  00cd c65235        	ld	a,21045
2564  00d0 aa2c          	or	a,#44
2565  00d2 c75235        	ld	21045,a
2566                     ; 132 }
2569  00d5 81            	ret
2687                     ; 135 void uart_out (char num,char data0,char data1,char data2,char data3,char data4,char data5){
2688                     	switch	.text
2689  00d6               _uart_out:
2691  00d6 89            	pushw	x
2692  00d7 520c          	subw	sp,#12
2693       0000000c      OFST:	set	12
2696                     ; 136 	char i=0,t=0,UOB[10];
2700  00d9 0f01          	clr	(OFST-11,sp)
2701                     ; 139 	UOB[0]=data0;
2703  00db 9f            	ld	a,xl
2704  00dc 6b02          	ld	(OFST-10,sp),a
2705                     ; 140 	UOB[1]=data1;
2707  00de 7b11          	ld	a,(OFST+5,sp)
2708  00e0 6b03          	ld	(OFST-9,sp),a
2709                     ; 141 	UOB[2]=data2;
2711  00e2 7b12          	ld	a,(OFST+6,sp)
2712  00e4 6b04          	ld	(OFST-8,sp),a
2713                     ; 142 	UOB[3]=data3;
2715  00e6 7b13          	ld	a,(OFST+7,sp)
2716  00e8 6b05          	ld	(OFST-7,sp),a
2717                     ; 143 	UOB[4]=data4;
2719  00ea 7b14          	ld	a,(OFST+8,sp)
2720  00ec 6b06          	ld	(OFST-6,sp),a
2721                     ; 144 	UOB[5]=data5;
2723  00ee 7b15          	ld	a,(OFST+9,sp)
2724  00f0 6b07          	ld	(OFST-5,sp),a
2725                     ; 145 	for (i=0;i<num;i++)
2727  00f2 0f0c          	clr	(OFST+0,sp)
2729  00f4 2013          	jra	L5261
2730  00f6               L1261:
2731                     ; 147 		t^=UOB[i];
2733  00f6 96            	ldw	x,sp
2734  00f7 1c0002        	addw	x,#OFST-10
2735  00fa 9f            	ld	a,xl
2736  00fb 5e            	swapw	x
2737  00fc 1b0c          	add	a,(OFST+0,sp)
2738  00fe 2401          	jrnc	L02
2739  0100 5c            	incw	x
2740  0101               L02:
2741  0101 02            	rlwa	x,a
2742  0102 7b01          	ld	a,(OFST-11,sp)
2743  0104 f8            	xor	a,	(x)
2744  0105 6b01          	ld	(OFST-11,sp),a
2745                     ; 145 	for (i=0;i<num;i++)
2747  0107 0c0c          	inc	(OFST+0,sp)
2748  0109               L5261:
2751  0109 7b0c          	ld	a,(OFST+0,sp)
2752  010b 110d          	cp	a,(OFST+1,sp)
2753  010d 25e7          	jrult	L1261
2754                     ; 149 	UOB[num]=num;
2756  010f 96            	ldw	x,sp
2757  0110 1c0002        	addw	x,#OFST-10
2758  0113 9f            	ld	a,xl
2759  0114 5e            	swapw	x
2760  0115 1b0d          	add	a,(OFST+1,sp)
2761  0117 2401          	jrnc	L22
2762  0119 5c            	incw	x
2763  011a               L22:
2764  011a 02            	rlwa	x,a
2765  011b 7b0d          	ld	a,(OFST+1,sp)
2766  011d f7            	ld	(x),a
2767                     ; 150 	t^=UOB[num];
2769  011e 96            	ldw	x,sp
2770  011f 1c0002        	addw	x,#OFST-10
2771  0122 9f            	ld	a,xl
2772  0123 5e            	swapw	x
2773  0124 1b0d          	add	a,(OFST+1,sp)
2774  0126 2401          	jrnc	L42
2775  0128 5c            	incw	x
2776  0129               L42:
2777  0129 02            	rlwa	x,a
2778  012a 7b01          	ld	a,(OFST-11,sp)
2779  012c f8            	xor	a,	(x)
2780  012d 6b01          	ld	(OFST-11,sp),a
2781                     ; 151 	UOB[num+1]=t;
2783  012f 96            	ldw	x,sp
2784  0130 1c0003        	addw	x,#OFST-9
2785  0133 9f            	ld	a,xl
2786  0134 5e            	swapw	x
2787  0135 1b0d          	add	a,(OFST+1,sp)
2788  0137 2401          	jrnc	L62
2789  0139 5c            	incw	x
2790  013a               L62:
2791  013a 02            	rlwa	x,a
2792  013b 7b01          	ld	a,(OFST-11,sp)
2793  013d f7            	ld	(x),a
2794                     ; 152 	UOB[num+2]=END;
2796  013e 96            	ldw	x,sp
2797  013f 1c0004        	addw	x,#OFST-8
2798  0142 9f            	ld	a,xl
2799  0143 5e            	swapw	x
2800  0144 1b0d          	add	a,(OFST+1,sp)
2801  0146 2401          	jrnc	L03
2802  0148 5c            	incw	x
2803  0149               L03:
2804  0149 02            	rlwa	x,a
2805  014a a60a          	ld	a,#10
2806  014c f7            	ld	(x),a
2807                     ; 156 	for (i=0;i<num+3;i++)
2809  014d 0f0c          	clr	(OFST+0,sp)
2811  014f 2012          	jra	L5361
2812  0151               L1361:
2813                     ; 158 		putchar(UOB[i]);
2815  0151 96            	ldw	x,sp
2816  0152 1c0002        	addw	x,#OFST-10
2817  0155 9f            	ld	a,xl
2818  0156 5e            	swapw	x
2819  0157 1b0c          	add	a,(OFST+0,sp)
2820  0159 2401          	jrnc	L23
2821  015b 5c            	incw	x
2822  015c               L23:
2823  015c 02            	rlwa	x,a
2824  015d f6            	ld	a,(x)
2825  015e cd0869        	call	_putchar
2827                     ; 156 	for (i=0;i<num+3;i++)
2829  0161 0c0c          	inc	(OFST+0,sp)
2830  0163               L5361:
2833  0163 9c            	rvf
2834  0164 7b0c          	ld	a,(OFST+0,sp)
2835  0166 5f            	clrw	x
2836  0167 97            	ld	xl,a
2837  0168 7b0d          	ld	a,(OFST+1,sp)
2838  016a 905f          	clrw	y
2839  016c 9097          	ld	yl,a
2840  016e 72a90003      	addw	y,#3
2841  0172 bf00          	ldw	c_x,x
2842  0174 90b300        	cpw	y,c_x
2843  0177 2cd8          	jrsgt	L1361
2844                     ; 161 	bOUT_FREE=0;	  	
2846  0179 72110003      	bres	_bOUT_FREE
2847                     ; 162 }
2850  017d 5b0e          	addw	sp,#14
2851  017f 81            	ret
2933                     ; 165 void uart_out_adr_block (unsigned long adress,char *ptr, char len)
2933                     ; 166 {
2934                     	switch	.text
2935  0180               _uart_out_adr_block:
2937  0180 5203          	subw	sp,#3
2938       00000003      OFST:	set	3
2941                     ; 170 t=0;
2943  0182 0f02          	clr	(OFST-1,sp)
2944                     ; 171 temp11=CMND;
2946                     ; 172 t^=temp11;
2948  0184 7b02          	ld	a,(OFST-1,sp)
2949  0186 a816          	xor	a,	#22
2950  0188 6b02          	ld	(OFST-1,sp),a
2951                     ; 173 putchar(temp11);
2953  018a a616          	ld	a,#22
2954  018c cd0869        	call	_putchar
2956                     ; 175 temp11=10;
2958                     ; 176 t^=temp11;
2960  018f 7b02          	ld	a,(OFST-1,sp)
2961  0191 a80a          	xor	a,	#10
2962  0193 6b02          	ld	(OFST-1,sp),a
2963                     ; 177 putchar(temp11);
2965  0195 a60a          	ld	a,#10
2966  0197 cd0869        	call	_putchar
2968                     ; 179 temp11=adress%256;//(*((char*)&adress));
2970  019a 7b09          	ld	a,(OFST+6,sp)
2971  019c a4ff          	and	a,#255
2972  019e 6b03          	ld	(OFST+0,sp),a
2973                     ; 180 t^=temp11;
2975  01a0 7b02          	ld	a,(OFST-1,sp)
2976  01a2 1803          	xor	a,	(OFST+0,sp)
2977  01a4 6b02          	ld	(OFST-1,sp),a
2978                     ; 181 putchar(temp11);
2980  01a6 7b03          	ld	a,(OFST+0,sp)
2981  01a8 cd0869        	call	_putchar
2983                     ; 182 adress>>=8;
2985  01ab 96            	ldw	x,sp
2986  01ac 1c0006        	addw	x,#OFST+3
2987  01af a608          	ld	a,#8
2988  01b1 cd0000        	call	c_lgursh
2990                     ; 183 temp11=adress%256;//(*(((char*)&adress)+1));
2992  01b4 7b09          	ld	a,(OFST+6,sp)
2993  01b6 a4ff          	and	a,#255
2994  01b8 6b03          	ld	(OFST+0,sp),a
2995                     ; 184 t^=temp11;
2997  01ba 7b02          	ld	a,(OFST-1,sp)
2998  01bc 1803          	xor	a,	(OFST+0,sp)
2999  01be 6b02          	ld	(OFST-1,sp),a
3000                     ; 185 putchar(temp11);
3002  01c0 7b03          	ld	a,(OFST+0,sp)
3003  01c2 cd0869        	call	_putchar
3005                     ; 186 adress>>=8;
3007  01c5 96            	ldw	x,sp
3008  01c6 1c0006        	addw	x,#OFST+3
3009  01c9 a608          	ld	a,#8
3010  01cb cd0000        	call	c_lgursh
3012                     ; 187 temp11=adress%256;//(*(((char*)&adress)+2));
3014  01ce 7b09          	ld	a,(OFST+6,sp)
3015  01d0 a4ff          	and	a,#255
3016  01d2 6b03          	ld	(OFST+0,sp),a
3017                     ; 188 t^=temp11;
3019  01d4 7b02          	ld	a,(OFST-1,sp)
3020  01d6 1803          	xor	a,	(OFST+0,sp)
3021  01d8 6b02          	ld	(OFST-1,sp),a
3022                     ; 189 putchar(temp11);
3024  01da 7b03          	ld	a,(OFST+0,sp)
3025  01dc cd0869        	call	_putchar
3027                     ; 190 adress>>=8;
3029  01df 96            	ldw	x,sp
3030  01e0 1c0006        	addw	x,#OFST+3
3031  01e3 a608          	ld	a,#8
3032  01e5 cd0000        	call	c_lgursh
3034                     ; 191 temp11=adress%256;//(*(((char*)&adress)+3));
3036  01e8 7b09          	ld	a,(OFST+6,sp)
3037  01ea a4ff          	and	a,#255
3038  01ec 6b03          	ld	(OFST+0,sp),a
3039                     ; 192 t^=temp11;
3041  01ee 7b02          	ld	a,(OFST-1,sp)
3042  01f0 1803          	xor	a,	(OFST+0,sp)
3043  01f2 6b02          	ld	(OFST-1,sp),a
3044                     ; 193 putchar(temp11);
3046  01f4 7b03          	ld	a,(OFST+0,sp)
3047  01f6 cd0869        	call	_putchar
3049                     ; 196 for(i11=0;i11<len;i11++)
3051  01f9 0f01          	clr	(OFST-2,sp)
3053  01fb 201b          	jra	L7071
3054  01fd               L3071:
3055                     ; 198 	temp11=ptr[i11];
3057  01fd 7b0a          	ld	a,(OFST+7,sp)
3058  01ff 97            	ld	xl,a
3059  0200 7b0b          	ld	a,(OFST+8,sp)
3060  0202 1b01          	add	a,(OFST-2,sp)
3061  0204 2401          	jrnc	L63
3062  0206 5c            	incw	x
3063  0207               L63:
3064  0207 02            	rlwa	x,a
3065  0208 f6            	ld	a,(x)
3066  0209 6b03          	ld	(OFST+0,sp),a
3067                     ; 199 	t^=temp11;
3069  020b 7b02          	ld	a,(OFST-1,sp)
3070  020d 1803          	xor	a,	(OFST+0,sp)
3071  020f 6b02          	ld	(OFST-1,sp),a
3072                     ; 200 	putchar(temp11);
3074  0211 7b03          	ld	a,(OFST+0,sp)
3075  0213 cd0869        	call	_putchar
3077                     ; 196 for(i11=0;i11<len;i11++)
3079  0216 0c01          	inc	(OFST-2,sp)
3080  0218               L7071:
3083  0218 7b01          	ld	a,(OFST-2,sp)
3084  021a 110c          	cp	a,(OFST+9,sp)
3085  021c 25df          	jrult	L3071
3086                     ; 203 temp11=(len+6);
3088  021e 7b0c          	ld	a,(OFST+9,sp)
3089  0220 ab06          	add	a,#6
3090  0222 6b03          	ld	(OFST+0,sp),a
3091                     ; 204 t^=temp11;
3093  0224 7b02          	ld	a,(OFST-1,sp)
3094  0226 1803          	xor	a,	(OFST+0,sp)
3095  0228 6b02          	ld	(OFST-1,sp),a
3096                     ; 205 putchar(temp11);
3098  022a 7b03          	ld	a,(OFST+0,sp)
3099  022c cd0869        	call	_putchar
3101                     ; 207 putchar(t);
3103  022f 7b02          	ld	a,(OFST-1,sp)
3104  0231 cd0869        	call	_putchar
3106                     ; 209 putchar(0x0a);
3108  0234 a60a          	ld	a,#10
3109  0236 cd0869        	call	_putchar
3111                     ; 211 bOUT_FREE=0;	   
3113  0239 72110003      	bres	_bOUT_FREE
3114                     ; 212 }
3117  023d 5b03          	addw	sp,#3
3118  023f 81            	ret
3253                     ; 214 void uart_in_an(void) {
3254                     	switch	.text
3255  0240               _uart_in_an:
3257  0240 5204          	subw	sp,#4
3258       00000004      OFST:	set	4
3261                     ; 217 	if(UIB[0]==CMND) {
3263  0242 c60000        	ld	a,_UIB
3264  0245 a116          	cp	a,#22
3265  0247 2703          	jreq	L24
3266  0249 cc0866        	jp	L1771
3267  024c               L24:
3268                     ; 218 		if(UIB[1]==1) {
3270  024c c60001        	ld	a,_UIB+1
3271  024f a101          	cp	a,#1
3272  0251 262f          	jrne	L3771
3273                     ; 222 			if(memory_manufacturer=='A') {
3275  0253 b6bc          	ld	a,_memory_manufacturer
3276  0255 a141          	cp	a,#65
3277  0257 2603          	jrne	L5771
3278                     ; 223 				temp_L=DF_mf_dev_read();
3280  0259 cd0a4e        	call	_DF_mf_dev_read
3282  025c               L5771:
3283                     ; 225 			if(memory_manufacturer=='S') {
3285  025c b6bc          	ld	a,_memory_manufacturer
3286  025e a153          	cp	a,#83
3287  0260 2603          	jrne	L7771
3288                     ; 226 				temp_L=ST_RDID_read();
3290  0262 cd092a        	call	_ST_RDID_read
3292  0265               L7771:
3293                     ; 228 			uart_out (6,CMND,1,mdr0/**((char*)&temp_L)*/,mdr1/**(((char*)&temp_L)+1)*/,mdr2/**(((char*)&temp_L)+2)*/,mdr3/**(((char*)&temp_L)+3)*/);
3295  0265 3b0013        	push	_mdr3
3296  0268 3b0014        	push	_mdr2
3297  026b 3b0015        	push	_mdr1
3298  026e 3b0016        	push	_mdr0
3299  0271 4b01          	push	#1
3300  0273 ae0016        	ldw	x,#22
3301  0276 a606          	ld	a,#6
3302  0278 95            	ld	xh,a
3303  0279 cd00d6        	call	_uart_out
3305  027c 5b05          	addw	sp,#5
3307  027e ac660866      	jpf	L1771
3308  0282               L3771:
3309                     ; 235 	else if(UIB[1]==2) {
3311  0282 c60001        	ld	a,_UIB+1
3312  0285 a102          	cp	a,#2
3313  0287 2630          	jrne	L3002
3314                     ; 238 		if(memory_manufacturer=='A') {
3316  0289 b6bc          	ld	a,_memory_manufacturer
3317  028b a141          	cp	a,#65
3318  028d 2605          	jrne	L5002
3319                     ; 239 			temp=DF_status_read();
3321  028f cd0aa2        	call	_DF_status_read
3323  0292 6b04          	ld	(OFST+0,sp),a
3324  0294               L5002:
3325                     ; 241 		if(memory_manufacturer=='S') {
3327  0294 b6bc          	ld	a,_memory_manufacturer
3328  0296 a153          	cp	a,#83
3329  0298 2605          	jrne	L7002
3330                     ; 242 			temp=ST_status_read();
3332  029a cd0956        	call	_ST_status_read
3334  029d 6b04          	ld	(OFST+0,sp),a
3335  029f               L7002:
3336                     ; 244 		uart_out (3,CMND,2,temp,0,0,0);    
3338  029f 4b00          	push	#0
3339  02a1 4b00          	push	#0
3340  02a3 4b00          	push	#0
3341  02a5 7b07          	ld	a,(OFST+3,sp)
3342  02a7 88            	push	a
3343  02a8 4b02          	push	#2
3344  02aa ae0016        	ldw	x,#22
3345  02ad a603          	ld	a,#3
3346  02af 95            	ld	xh,a
3347  02b0 cd00d6        	call	_uart_out
3349  02b3 5b05          	addw	sp,#5
3351  02b5 ac660866      	jpf	L1771
3352  02b9               L3002:
3353                     ; 248 	else if(UIB[1]==3)
3355  02b9 c60001        	ld	a,_UIB+1
3356  02bc a103          	cp	a,#3
3357  02be 2623          	jrne	L3102
3358                     ; 251 		if(memory_manufacturer=='A') {
3360  02c0 b6bc          	ld	a,_memory_manufacturer
3361  02c2 a141          	cp	a,#65
3362  02c4 2603          	jrne	L5102
3363                     ; 252 			DF_memo_to_256();
3365  02c6 cd0a85        	call	_DF_memo_to_256
3367  02c9               L5102:
3368                     ; 254 		uart_out (2,CMND,3,temp,0,0,0);    
3370  02c9 4b00          	push	#0
3371  02cb 4b00          	push	#0
3372  02cd 4b00          	push	#0
3373  02cf 7b07          	ld	a,(OFST+3,sp)
3374  02d1 88            	push	a
3375  02d2 4b03          	push	#3
3376  02d4 ae0016        	ldw	x,#22
3377  02d7 a602          	ld	a,#2
3378  02d9 95            	ld	xh,a
3379  02da cd00d6        	call	_uart_out
3381  02dd 5b05          	addw	sp,#5
3383  02df ac660866      	jpf	L1771
3384  02e3               L3102:
3385                     ; 257 	else if(UIB[1]==4)
3387  02e3 c60001        	ld	a,_UIB+1
3388  02e6 a104          	cp	a,#4
3389  02e8 2623          	jrne	L1202
3390                     ; 260 		if(memory_manufacturer=='A') {
3392  02ea b6bc          	ld	a,_memory_manufacturer
3393  02ec a141          	cp	a,#65
3394  02ee 2603          	jrne	L3202
3395                     ; 261 			DF_memo_to_256();
3397  02f0 cd0a85        	call	_DF_memo_to_256
3399  02f3               L3202:
3400                     ; 263 		uart_out (2,CMND,3,temp,0,0,0);    
3402  02f3 4b00          	push	#0
3403  02f5 4b00          	push	#0
3404  02f7 4b00          	push	#0
3405  02f9 7b07          	ld	a,(OFST+3,sp)
3406  02fb 88            	push	a
3407  02fc 4b03          	push	#3
3408  02fe ae0016        	ldw	x,#22
3409  0301 a602          	ld	a,#2
3410  0303 95            	ld	xh,a
3411  0304 cd00d6        	call	_uart_out
3413  0307 5b05          	addw	sp,#5
3415  0309 ac660866      	jpf	L1771
3416  030d               L1202:
3417                     ; 266 	else if(UIB[1]==10)
3419  030d c60001        	ld	a,_UIB+1
3420  0310 a10a          	cp	a,#10
3421  0312 2703cc039a    	jrne	L7202
3422                     ; 270 		if(memory_manufacturer=='A') {
3424  0317 b6bc          	ld	a,_memory_manufacturer
3425  0319 a141          	cp	a,#65
3426  031b 2615          	jrne	L1302
3427                     ; 271 			if(UIB[2]==1)DF_buffer_read(/*1,*/0,256, buff);
3429  031d c60002        	ld	a,_UIB+2
3430  0320 a101          	cp	a,#1
3431  0322 260e          	jrne	L1302
3434  0324 ae0050        	ldw	x,#_buff
3435  0327 89            	pushw	x
3436  0328 ae0100        	ldw	x,#256
3437  032b 89            	pushw	x
3438  032c 5f            	clrw	x
3439  032d cd0b02        	call	_DF_buffer_read
3441  0330 5b04          	addw	sp,#4
3442  0332               L1302:
3443                     ; 276 		uart_out_adr_block (0,buff,64);
3445  0332 4b40          	push	#64
3446  0334 ae0050        	ldw	x,#_buff
3447  0337 89            	pushw	x
3448  0338 ae0000        	ldw	x,#0
3449  033b 89            	pushw	x
3450  033c ae0000        	ldw	x,#0
3451  033f 89            	pushw	x
3452  0340 cd0180        	call	_uart_out_adr_block
3454  0343 5b07          	addw	sp,#7
3455                     ; 277 		delay_ms(100);    
3457  0345 ae0064        	ldw	x,#100
3458  0348 cd0064        	call	_delay_ms
3460                     ; 278 		uart_out_adr_block (64,&buff[64],64);
3462  034b 4b40          	push	#64
3463  034d ae0090        	ldw	x,#_buff+64
3464  0350 89            	pushw	x
3465  0351 ae0040        	ldw	x,#64
3466  0354 89            	pushw	x
3467  0355 ae0000        	ldw	x,#0
3468  0358 89            	pushw	x
3469  0359 cd0180        	call	_uart_out_adr_block
3471  035c 5b07          	addw	sp,#7
3472                     ; 279 		delay_ms(100);    
3474  035e ae0064        	ldw	x,#100
3475  0361 cd0064        	call	_delay_ms
3477                     ; 280 		uart_out_adr_block (128,&buff[128],64);
3479  0364 4b40          	push	#64
3480  0366 ae00d0        	ldw	x,#_buff+128
3481  0369 89            	pushw	x
3482  036a ae0080        	ldw	x,#128
3483  036d 89            	pushw	x
3484  036e ae0000        	ldw	x,#0
3485  0371 89            	pushw	x
3486  0372 cd0180        	call	_uart_out_adr_block
3488  0375 5b07          	addw	sp,#7
3489                     ; 281 		delay_ms(100);    
3491  0377 ae0064        	ldw	x,#100
3492  037a cd0064        	call	_delay_ms
3494                     ; 282 		uart_out_adr_block (192,&buff[192],64);
3496  037d 4b40          	push	#64
3497  037f ae0110        	ldw	x,#_buff+192
3498  0382 89            	pushw	x
3499  0383 ae00c0        	ldw	x,#192
3500  0386 89            	pushw	x
3501  0387 ae0000        	ldw	x,#0
3502  038a 89            	pushw	x
3503  038b cd0180        	call	_uart_out_adr_block
3505  038e 5b07          	addw	sp,#7
3506                     ; 283 		delay_ms(100);    
3508  0390 ae0064        	ldw	x,#100
3509  0393 cd0064        	call	_delay_ms
3512  0396 ac660866      	jpf	L1771
3513  039a               L7202:
3514                     ; 286 	else if(UIB[1]==11)
3516  039a c60001        	ld	a,_UIB+1
3517  039d a10b          	cp	a,#11
3518  039f 2633          	jrne	L7302
3519                     ; 292 		for(i=0;i<256;i++)buff[i]=0;
3521  03a1 5f            	clrw	x
3522  03a2 1f03          	ldw	(OFST-1,sp),x
3523  03a4               L1402:
3526  03a4 1e03          	ldw	x,(OFST-1,sp)
3527  03a6 724f0050      	clr	(_buff,x)
3530  03aa 1e03          	ldw	x,(OFST-1,sp)
3531  03ac 1c0001        	addw	x,#1
3532  03af 1f03          	ldw	(OFST-1,sp),x
3535  03b1 1e03          	ldw	x,(OFST-1,sp)
3536  03b3 a30100        	cpw	x,#256
3537  03b6 25ec          	jrult	L1402
3538                     ; 294 		if(UIB[2]==1)DF_buffer_write(/*1,*/0,256, buff);
3540  03b8 c60002        	ld	a,_UIB+2
3541  03bb a101          	cp	a,#1
3542  03bd 2703          	jreq	L44
3543  03bf cc0866        	jp	L1771
3544  03c2               L44:
3547  03c2 ae0050        	ldw	x,#_buff
3548  03c5 89            	pushw	x
3549  03c6 ae0100        	ldw	x,#256
3550  03c9 89            	pushw	x
3551  03ca 5f            	clrw	x
3552  03cb cd0b48        	call	_DF_buffer_write
3554  03ce 5b04          	addw	sp,#4
3555  03d0 ac660866      	jpf	L1771
3556  03d4               L7302:
3557                     ; 298 	else if(UIB[1]==12)
3559  03d4 c60001        	ld	a,_UIB+1
3560  03d7 a10c          	cp	a,#12
3561  03d9 2703          	jreq	L64
3562  03db cc04ba        	jp	L3502
3563  03de               L64:
3564                     ; 304 		for(i=0;i<256;i++)buff[i]=0;
3566  03de 5f            	clrw	x
3567  03df 1f03          	ldw	(OFST-1,sp),x
3568  03e1               L5502:
3571  03e1 1e03          	ldw	x,(OFST-1,sp)
3572  03e3 724f0050      	clr	(_buff,x)
3575  03e7 1e03          	ldw	x,(OFST-1,sp)
3576  03e9 1c0001        	addw	x,#1
3577  03ec 1f03          	ldw	(OFST-1,sp),x
3580  03ee 1e03          	ldw	x,(OFST-1,sp)
3581  03f0 a30100        	cpw	x,#256
3582  03f3 25ec          	jrult	L5502
3583                     ; 306 		if(UIB[3]==1)
3585  03f5 c60003        	ld	a,_UIB+3
3586  03f8 a101          	cp	a,#1
3587  03fa 2632          	jrne	L3602
3588                     ; 308 			buff[0]=0x00;
3590  03fc 725f0050      	clr	_buff
3591                     ; 309 			buff[1]=0x11;
3593  0400 35110051      	mov	_buff+1,#17
3594                     ; 310 			buff[2]=0x22;
3596  0404 35220052      	mov	_buff+2,#34
3597                     ; 311 			buff[3]=0x33;
3599  0408 35330053      	mov	_buff+3,#51
3600                     ; 312 			buff[4]=0x44;
3602  040c 35440054      	mov	_buff+4,#68
3603                     ; 313 			buff[5]=0x55;
3605  0410 35550055      	mov	_buff+5,#85
3606                     ; 314 			buff[6]=0x66;
3608  0414 35660056      	mov	_buff+6,#102
3609                     ; 315 			buff[7]=0x77;
3611  0418 35770057      	mov	_buff+7,#119
3612                     ; 316 			buff[8]=0x88;
3614  041c 35880058      	mov	_buff+8,#136
3615                     ; 317 			buff[9]=0x99;
3617  0420 35990059      	mov	_buff+9,#153
3618                     ; 318 			buff[10]=0;
3620  0424 725f005a      	clr	_buff+10
3621                     ; 319 			buff[11]=0;
3623  0428 725f005b      	clr	_buff+11
3625  042c 2070          	jra	L5602
3626  042e               L3602:
3627                     ; 322 		else if(UIB[3]==2)
3629  042e c60003        	ld	a,_UIB+3
3630  0431 a102          	cp	a,#2
3631  0433 2632          	jrne	L7602
3632                     ; 324 			buff[0]=0x00;
3634  0435 725f0050      	clr	_buff
3635                     ; 325 			buff[1]=0x10;
3637  0439 35100051      	mov	_buff+1,#16
3638                     ; 326 			buff[2]=0x20;
3640  043d 35200052      	mov	_buff+2,#32
3641                     ; 327 			buff[3]=0x30;
3643  0441 35300053      	mov	_buff+3,#48
3644                     ; 328 			buff[4]=0x40;
3646  0445 35400054      	mov	_buff+4,#64
3647                     ; 329 			buff[5]=0x50;
3649  0449 35500055      	mov	_buff+5,#80
3650                     ; 330 			buff[6]=0x60;
3652  044d 35600056      	mov	_buff+6,#96
3653                     ; 331 			buff[7]=0x70;
3655  0451 35700057      	mov	_buff+7,#112
3656                     ; 332 			buff[8]=0x80;
3658  0455 35800058      	mov	_buff+8,#128
3659                     ; 333 			buff[9]=0x90;
3661  0459 35900059      	mov	_buff+9,#144
3662                     ; 334 			buff[10]=0;
3664  045d 725f005a      	clr	_buff+10
3665                     ; 335 			buff[11]=0;
3667  0461 725f005b      	clr	_buff+11
3669  0465 2037          	jra	L5602
3670  0467               L7602:
3671                     ; 338 		else if(UIB[3]==3)
3673  0467 c60003        	ld	a,_UIB+3
3674  046a a103          	cp	a,#3
3675  046c 2630          	jrne	L5602
3676                     ; 340 			buff[0]=0x98;
3678  046e 35980050      	mov	_buff,#152
3679                     ; 341 			buff[1]=0x87;
3681  0472 35870051      	mov	_buff+1,#135
3682                     ; 342 			buff[2]=0x76;
3684  0476 35760052      	mov	_buff+2,#118
3685                     ; 343 			buff[3]=0x65;
3687  047a 35650053      	mov	_buff+3,#101
3688                     ; 344 			buff[4]=0x54;
3690  047e 35540054      	mov	_buff+4,#84
3691                     ; 345 			buff[5]=0x43;
3693  0482 35430055      	mov	_buff+5,#67
3694                     ; 346 			buff[6]=0x32;
3696  0486 35320056      	mov	_buff+6,#50
3697                     ; 347 			buff[7]=0x21;
3699  048a 35210057      	mov	_buff+7,#33
3700                     ; 348 			buff[8]=0x10;
3702  048e 35100058      	mov	_buff+8,#16
3703                     ; 349 			buff[9]=0x00;
3705  0492 725f0059      	clr	_buff+9
3706                     ; 350 			buff[10]=0;
3708  0496 725f005a      	clr	_buff+10
3709                     ; 351 			buff[11]=0;
3711  049a 725f005b      	clr	_buff+11
3712  049e               L5602:
3713                     ; 353 		if(UIB[2]==1)DF_buffer_write(/*1,*/0,256, buff);
3715  049e c60002        	ld	a,_UIB+2
3716  04a1 a101          	cp	a,#1
3717  04a3 2703          	jreq	L05
3718  04a5 cc0866        	jp	L1771
3719  04a8               L05:
3722  04a8 ae0050        	ldw	x,#_buff
3723  04ab 89            	pushw	x
3724  04ac ae0100        	ldw	x,#256
3725  04af 89            	pushw	x
3726  04b0 5f            	clrw	x
3727  04b1 cd0b48        	call	_DF_buffer_write
3729  04b4 5b04          	addw	sp,#4
3730  04b6 ac660866      	jpf	L1771
3731  04ba               L3502:
3732                     ; 357 	else if(UIB[1]==13)
3734  04ba c60001        	ld	a,_UIB+1
3735  04bd a10d          	cp	a,#13
3736  04bf 2703cc055d    	jrne	L1012
3737                     ; 362 		if(memory_manufacturer=='A') {	
3739  04c4 b6bc          	ld	a,_memory_manufacturer
3740  04c6 a141          	cp	a,#65
3741  04c8 2608          	jrne	L3012
3742                     ; 363 			DF_page_to_buffer(/*UIB[2],*/UIB[3]);
3744  04ca c60003        	ld	a,_UIB+3
3745  04cd 5f            	clrw	x
3746  04ce 97            	ld	xl,a
3747  04cf cd0abc        	call	_DF_page_to_buffer
3749  04d2               L3012:
3750                     ; 365 		if(memory_manufacturer=='S') {
3752  04d2 b6bc          	ld	a,_memory_manufacturer
3753  04d4 a153          	cp	a,#83
3754  04d6 2703          	jreq	L25
3755  04d8 cc0866        	jp	L1771
3756  04db               L25:
3757                     ; 366 			current_page=11;
3759  04db ae000b        	ldw	x,#11
3760  04de bf0f          	ldw	_current_page,x
3761                     ; 367 			ST_READ((long)(current_page*256),256, buff);
3763  04e0 ae0050        	ldw	x,#_buff
3764  04e3 89            	pushw	x
3765  04e4 ae0100        	ldw	x,#256
3766  04e7 89            	pushw	x
3767  04e8 ae0b00        	ldw	x,#2816
3768  04eb 89            	pushw	x
3769  04ec ae0000        	ldw	x,#0
3770  04ef 89            	pushw	x
3771  04f0 cd0a00        	call	_ST_READ
3773  04f3 5b08          	addw	sp,#8
3774                     ; 369 			uart_out_adr_block (0,buff,64);
3776  04f5 4b40          	push	#64
3777  04f7 ae0050        	ldw	x,#_buff
3778  04fa 89            	pushw	x
3779  04fb ae0000        	ldw	x,#0
3780  04fe 89            	pushw	x
3781  04ff ae0000        	ldw	x,#0
3782  0502 89            	pushw	x
3783  0503 cd0180        	call	_uart_out_adr_block
3785  0506 5b07          	addw	sp,#7
3786                     ; 370 			delay_ms(100);    
3788  0508 ae0064        	ldw	x,#100
3789  050b cd0064        	call	_delay_ms
3791                     ; 371 			uart_out_adr_block (64,&buff[64],64);
3793  050e 4b40          	push	#64
3794  0510 ae0090        	ldw	x,#_buff+64
3795  0513 89            	pushw	x
3796  0514 ae0040        	ldw	x,#64
3797  0517 89            	pushw	x
3798  0518 ae0000        	ldw	x,#0
3799  051b 89            	pushw	x
3800  051c cd0180        	call	_uart_out_adr_block
3802  051f 5b07          	addw	sp,#7
3803                     ; 372 			delay_ms(100);    
3805  0521 ae0064        	ldw	x,#100
3806  0524 cd0064        	call	_delay_ms
3808                     ; 373 			uart_out_adr_block (128,&buff[128],64);
3810  0527 4b40          	push	#64
3811  0529 ae00d0        	ldw	x,#_buff+128
3812  052c 89            	pushw	x
3813  052d ae0080        	ldw	x,#128
3814  0530 89            	pushw	x
3815  0531 ae0000        	ldw	x,#0
3816  0534 89            	pushw	x
3817  0535 cd0180        	call	_uart_out_adr_block
3819  0538 5b07          	addw	sp,#7
3820                     ; 374 			delay_ms(100);    
3822  053a ae0064        	ldw	x,#100
3823  053d cd0064        	call	_delay_ms
3825                     ; 375 			uart_out_adr_block (192,&buff[192],64);
3827  0540 4b40          	push	#64
3828  0542 ae0110        	ldw	x,#_buff+192
3829  0545 89            	pushw	x
3830  0546 ae00c0        	ldw	x,#192
3831  0549 89            	pushw	x
3832  054a ae0000        	ldw	x,#0
3833  054d 89            	pushw	x
3834  054e cd0180        	call	_uart_out_adr_block
3836  0551 5b07          	addw	sp,#7
3837                     ; 376 			delay_ms(100); 
3839  0553 ae0064        	ldw	x,#100
3840  0556 cd0064        	call	_delay_ms
3842  0559 ac660866      	jpf	L1771
3843  055d               L1012:
3844                     ; 379 	else if(UIB[1]==14)
3846  055d c60001        	ld	a,_UIB+1
3847  0560 a10e          	cp	a,#14
3848  0562 265b          	jrne	L1112
3849                     ; 384 		if(memory_manufacturer=='A') {	
3851  0564 b6bc          	ld	a,_memory_manufacturer
3852  0566 a141          	cp	a,#65
3853  0568 2608          	jrne	L3112
3854                     ; 385 			DF_buffer_to_page_er(/*UIB[2],*/UIB[3]);
3856  056a c60003        	ld	a,_UIB+3
3857  056d 5f            	clrw	x
3858  056e 97            	ld	xl,a
3859  056f cd0adf        	call	_DF_buffer_to_page_er
3861  0572               L3112:
3862                     ; 387 		if(memory_manufacturer=='S') {
3864  0572 b6bc          	ld	a,_memory_manufacturer
3865  0574 a153          	cp	a,#83
3866  0576 2703          	jreq	L45
3867  0578 cc0866        	jp	L1771
3868  057b               L45:
3869                     ; 388 			for(i=0;i<256;i++) {
3871  057b 5f            	clrw	x
3872  057c 1f03          	ldw	(OFST-1,sp),x
3873  057e               L7112:
3874                     ; 389 				buff[i]=(char)i;
3876  057e 7b04          	ld	a,(OFST+0,sp)
3877  0580 1e03          	ldw	x,(OFST-1,sp)
3878  0582 d70050        	ld	(_buff,x),a
3879                     ; 388 			for(i=0;i<256;i++) {
3881  0585 1e03          	ldw	x,(OFST-1,sp)
3882  0587 1c0001        	addw	x,#1
3883  058a 1f03          	ldw	(OFST-1,sp),x
3886  058c 1e03          	ldw	x,(OFST-1,sp)
3887  058e a30100        	cpw	x,#256
3888  0591 25eb          	jrult	L7112
3889                     ; 391 			current_page=11;
3891  0593 ae000b        	ldw	x,#11
3892  0596 bf0f          	ldw	_current_page,x
3893                     ; 392 			ST_WREN();
3895  0598 cd096e        	call	_ST_WREN
3897                     ; 393 			delay_ms(100);
3899  059b ae0064        	ldw	x,#100
3900  059e cd0064        	call	_delay_ms
3902                     ; 394 			ST_WRITE((long)(current_page*256),256,buff);		
3904  05a1 ae0050        	ldw	x,#_buff
3905  05a4 89            	pushw	x
3906  05a5 ae0100        	ldw	x,#256
3907  05a8 89            	pushw	x
3908  05a9 be0f          	ldw	x,_current_page
3909  05ab 4f            	clr	a
3910  05ac 02            	rlwa	x,a
3911  05ad cd0000        	call	c_uitolx
3913  05b0 be02          	ldw	x,c_lreg+2
3914  05b2 89            	pushw	x
3915  05b3 be00          	ldw	x,c_lreg
3916  05b5 89            	pushw	x
3917  05b6 cd09b4        	call	_ST_WRITE
3919  05b9 5b08          	addw	sp,#8
3920  05bb ac660866      	jpf	L1771
3921  05bf               L1112:
3922                     ; 399 	else if(UIB[1]==20)
3924  05bf c60001        	ld	a,_UIB+1
3925  05c2 a114          	cp	a,#20
3926  05c4 2703cc064d    	jrne	L7212
3927                     ; 404 		file_lengt=0;
3929  05c9 ae0000        	ldw	x,#0
3930  05cc bf09          	ldw	_file_lengt+2,x
3931  05ce ae0000        	ldw	x,#0
3932  05d1 bf07          	ldw	_file_lengt,x
3933                     ; 405 		file_lengt+=UIB[5];
3935  05d3 c60005        	ld	a,_UIB+5
3936  05d6 ae0007        	ldw	x,#_file_lengt
3937  05d9 88            	push	a
3938  05da cd0000        	call	c_lgadc
3940  05dd 84            	pop	a
3941                     ; 406 		file_lengt<<=8;
3943  05de ae0007        	ldw	x,#_file_lengt
3944  05e1 a608          	ld	a,#8
3945  05e3 cd0000        	call	c_lglsh
3947                     ; 407 		file_lengt+=UIB[4];
3949  05e6 c60004        	ld	a,_UIB+4
3950  05e9 ae0007        	ldw	x,#_file_lengt
3951  05ec 88            	push	a
3952  05ed cd0000        	call	c_lgadc
3954  05f0 84            	pop	a
3955                     ; 408 		file_lengt<<=8;
3957  05f1 ae0007        	ldw	x,#_file_lengt
3958  05f4 a608          	ld	a,#8
3959  05f6 cd0000        	call	c_lglsh
3961                     ; 409 		file_lengt+=UIB[3];
3963  05f9 c60003        	ld	a,_UIB+3
3964  05fc ae0007        	ldw	x,#_file_lengt
3965  05ff 88            	push	a
3966  0600 cd0000        	call	c_lgadc
3968  0603 84            	pop	a
3969                     ; 410 		file_lengt_in_pages=file_lengt;
3971  0604 be09          	ldw	x,_file_lengt+2
3972  0606 bf11          	ldw	_file_lengt_in_pages,x
3973                     ; 411 		file_lengt<<=8;
3975  0608 ae0007        	ldw	x,#_file_lengt
3976  060b a608          	ld	a,#8
3977  060d cd0000        	call	c_lglsh
3979                     ; 412 		file_lengt+=UIB[2];
3981  0610 c60002        	ld	a,_UIB+2
3982  0613 ae0007        	ldw	x,#_file_lengt
3983  0616 88            	push	a
3984  0617 cd0000        	call	c_lgadc
3986  061a 84            	pop	a
3987                     ; 417 		current_page=0;
3989  061b 5f            	clrw	x
3990  061c bf0f          	ldw	_current_page,x
3991                     ; 418 		current_byte_in_buffer=0;
3993  061e 5f            	clrw	x
3994  061f bf0b          	ldw	_current_byte_in_buffer,x
3995                     ; 420 		if(memory_manufacturer=='S') {
3997  0621 b6bc          	ld	a,_memory_manufacturer
3998  0623 a153          	cp	a,#83
3999  0625 2609          	jrne	L1312
4000                     ; 421 			ST_WREN();
4002  0627 cd096e        	call	_ST_WREN
4004                     ; 439 			delay_ms(100);
4006  062a ae0064        	ldw	x,#100
4007  062d cd0064        	call	_delay_ms
4009  0630               L1312:
4010                     ; 443 		uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
4012  0630 4b00          	push	#0
4013  0632 4b00          	push	#0
4014  0634 3b000f        	push	_current_page
4015  0637 b610          	ld	a,_current_page+1
4016  0639 a4ff          	and	a,#255
4017  063b 88            	push	a
4018  063c 4b15          	push	#21
4019  063e ae0016        	ldw	x,#22
4020  0641 a604          	ld	a,#4
4021  0643 95            	ld	xh,a
4022  0644 cd00d6        	call	_uart_out
4024  0647 5b05          	addw	sp,#5
4026  0649 ac660866      	jpf	L1771
4027  064d               L7212:
4028                     ; 446 	else if(UIB[1]==21)
4030  064d c60001        	ld	a,_UIB+1
4031  0650 a115          	cp	a,#21
4032  0652 2703          	jreq	L65
4033  0654 cc0749        	jp	L5312
4034  0657               L65:
4035                     ; 451           for(i=0;i<64;i++)
4037  0657 5f            	clrw	x
4038  0658 1f03          	ldw	(OFST-1,sp),x
4039  065a               L7312:
4040                     ; 453           	buff[current_byte_in_buffer+i]=UIB[2+i];
4042  065a 1e03          	ldw	x,(OFST-1,sp)
4043  065c d60002        	ld	a,(_UIB+2,x)
4044  065f be0b          	ldw	x,_current_byte_in_buffer
4045  0661 72fb03        	addw	x,(OFST-1,sp)
4046  0664 d70050        	ld	(_buff,x),a
4047                     ; 451           for(i=0;i<64;i++)
4049  0667 1e03          	ldw	x,(OFST-1,sp)
4050  0669 1c0001        	addw	x,#1
4051  066c 1f03          	ldw	(OFST-1,sp),x
4054  066e 1e03          	ldw	x,(OFST-1,sp)
4055  0670 a30040        	cpw	x,#64
4056  0673 25e5          	jrult	L7312
4057                     ; 455           current_byte_in_buffer+=64;
4059  0675 be0b          	ldw	x,_current_byte_in_buffer
4060  0677 1c0040        	addw	x,#64
4061  067a bf0b          	ldw	_current_byte_in_buffer,x
4062                     ; 456           if(current_byte_in_buffer>=256)
4064  067c be0b          	ldw	x,_current_byte_in_buffer
4065  067e a30100        	cpw	x,#256
4066  0681 2403          	jruge	L06
4067  0683 cc0866        	jp	L1771
4068  0686               L06:
4069                     ; 464 			if(memory_manufacturer=='A') {
4071  0686 b6bc          	ld	a,_memory_manufacturer
4072  0688 a141          	cp	a,#65
4073  068a 264e          	jrne	L7412
4074                     ; 465 				DF_buffer_write(/*//current_buffer*//*1,*/0,256,buff);
4076  068c ae0050        	ldw	x,#_buff
4077  068f 89            	pushw	x
4078  0690 ae0100        	ldw	x,#256
4079  0693 89            	pushw	x
4080  0694 5f            	clrw	x
4081  0695 cd0b48        	call	_DF_buffer_write
4083  0698 5b04          	addw	sp,#4
4084                     ; 466 				DF_buffer_to_page_er(/*///current_buffer*//*1,*/current_page);
4086  069a be0f          	ldw	x,_current_page
4087  069c cd0adf        	call	_DF_buffer_to_page_er
4089                     ; 467 				current_page++;
4091  069f be0f          	ldw	x,_current_page
4092  06a1 1c0001        	addw	x,#1
4093  06a4 bf0f          	ldw	_current_page,x
4094                     ; 468 				if(current_page<file_lengt_in_pages)
4096  06a6 be0f          	ldw	x,_current_page
4097  06a8 b311          	cpw	x,_file_lengt_in_pages
4098  06aa 2424          	jruge	L1512
4099                     ; 470 					delay_ms(100);
4101  06ac ae0064        	ldw	x,#100
4102  06af cd0064        	call	_delay_ms
4104                     ; 471 					uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
4106  06b2 4b00          	push	#0
4107  06b4 4b00          	push	#0
4108  06b6 3b000f        	push	_current_page
4109  06b9 b610          	ld	a,_current_page+1
4110  06bb a4ff          	and	a,#255
4111  06bd 88            	push	a
4112  06be 4b15          	push	#21
4113  06c0 ae0016        	ldw	x,#22
4114  06c3 a604          	ld	a,#4
4115  06c5 95            	ld	xh,a
4116  06c6 cd00d6        	call	_uart_out
4118  06c9 5b05          	addw	sp,#5
4119                     ; 472 					current_byte_in_buffer=0;
4121  06cb 5f            	clrw	x
4122  06cc bf0b          	ldw	_current_byte_in_buffer,x
4124  06ce 200a          	jra	L7412
4125  06d0               L1512:
4126                     ; 476 					EE_PAGE_LEN=current_page;
4128  06d0 be0f          	ldw	x,_current_page
4129  06d2 89            	pushw	x
4130  06d3 ae0000        	ldw	x,#_EE_PAGE_LEN
4131  06d6 cd0000        	call	c_eewrw
4133  06d9 85            	popw	x
4134  06da               L7412:
4135                     ; 479 			if(memory_manufacturer=='S') {
4137  06da b6bc          	ld	a,_memory_manufacturer
4138  06dc a153          	cp	a,#83
4139  06de 2703          	jreq	L26
4140  06e0 cc0866        	jp	L1771
4141  06e3               L26:
4142                     ; 480 				ST_WREN();
4144  06e3 cd096e        	call	_ST_WREN
4146                     ; 481 				delay_ms(100);
4148  06e6 ae0064        	ldw	x,#100
4149  06e9 cd0064        	call	_delay_ms
4151                     ; 484 				ST_WRITE((unsigned long)(current_page*256UL),256,buff);
4153  06ec ae0050        	ldw	x,#_buff
4154  06ef 89            	pushw	x
4155  06f0 ae0100        	ldw	x,#256
4156  06f3 89            	pushw	x
4157  06f4 be0f          	ldw	x,_current_page
4158  06f6 90ae0100      	ldw	y,#256
4159  06fa cd0000        	call	c_umul
4161  06fd be02          	ldw	x,c_lreg+2
4162  06ff 89            	pushw	x
4163  0700 be00          	ldw	x,c_lreg
4164  0702 89            	pushw	x
4165  0703 cd09b4        	call	_ST_WRITE
4167  0706 5b08          	addw	sp,#8
4168                     ; 485 				current_page++;
4170  0708 be0f          	ldw	x,_current_page
4171  070a 1c0001        	addw	x,#1
4172  070d bf0f          	ldw	_current_page,x
4173                     ; 486 				if(current_page<file_lengt_in_pages)
4175  070f be0f          	ldw	x,_current_page
4176  0711 b311          	cpw	x,_file_lengt_in_pages
4177  0713 2426          	jruge	L7512
4178                     ; 488 					delay_ms(100);
4180  0715 ae0064        	ldw	x,#100
4181  0718 cd0064        	call	_delay_ms
4183                     ; 489 					uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
4185  071b 4b00          	push	#0
4186  071d 4b00          	push	#0
4187  071f 3b000f        	push	_current_page
4188  0722 b610          	ld	a,_current_page+1
4189  0724 a4ff          	and	a,#255
4190  0726 88            	push	a
4191  0727 4b15          	push	#21
4192  0729 ae0016        	ldw	x,#22
4193  072c a604          	ld	a,#4
4194  072e 95            	ld	xh,a
4195  072f cd00d6        	call	_uart_out
4197  0732 5b05          	addw	sp,#5
4198                     ; 490 					current_byte_in_buffer=0;
4200  0734 5f            	clrw	x
4201  0735 bf0b          	ldw	_current_byte_in_buffer,x
4203  0737 ac660866      	jpf	L1771
4204  073b               L7512:
4205                     ; 494 					EE_PAGE_LEN=current_page;
4207  073b be0f          	ldw	x,_current_page
4208  073d 89            	pushw	x
4209  073e ae0000        	ldw	x,#_EE_PAGE_LEN
4210  0741 cd0000        	call	c_eewrw
4212  0744 85            	popw	x
4213  0745 ac660866      	jpf	L1771
4214  0749               L5312:
4215                     ; 506 	else if(UIB[1]==25)
4217  0749 c60001        	ld	a,_UIB+1
4218  074c a119          	cp	a,#25
4219  074e 2703          	jreq	L46
4220  0750 cc0830        	jp	L5612
4221  0753               L46:
4222                     ; 510 		current_page=0;
4224  0753 5f            	clrw	x
4225  0754 bf0f          	ldw	_current_page,x
4226                     ; 512 		for(i__=0;i__<EE_PAGE_LEN;i__++)
4228  0756 5f            	clrw	x
4229  0757 1f03          	ldw	(OFST-1,sp),x
4231  0759 ac240824      	jpf	L3712
4232  075d               L7612:
4233                     ; 514 			if(memory_manufacturer=='S') {	
4235  075d b6bc          	ld	a,_memory_manufacturer
4236  075f a153          	cp	a,#83
4237  0761 2619          	jrne	L7712
4238                     ; 515 				DF_page_to_buffer(i__);
4240  0763 1e03          	ldw	x,(OFST-1,sp)
4241  0765 cd0abc        	call	_DF_page_to_buffer
4243                     ; 516 				delay_ms(100);			
4245  0768 ae0064        	ldw	x,#100
4246  076b cd0064        	call	_delay_ms
4248                     ; 517 				DF_buffer_read(0,256, buff);
4250  076e ae0050        	ldw	x,#_buff
4251  0771 89            	pushw	x
4252  0772 ae0100        	ldw	x,#256
4253  0775 89            	pushw	x
4254  0776 5f            	clrw	x
4255  0777 cd0b02        	call	_DF_buffer_read
4257  077a 5b04          	addw	sp,#4
4258  077c               L7712:
4259                     ; 520 			if(memory_manufacturer=='S') {	
4261  077c b6bc          	ld	a,_memory_manufacturer
4262  077e a153          	cp	a,#83
4263  0780 261a          	jrne	L1022
4264                     ; 521 				ST_READ((long)(i__*256),256, buff);
4266  0782 ae0050        	ldw	x,#_buff
4267  0785 89            	pushw	x
4268  0786 ae0100        	ldw	x,#256
4269  0789 89            	pushw	x
4270  078a 1e07          	ldw	x,(OFST+3,sp)
4271  078c 4f            	clr	a
4272  078d 02            	rlwa	x,a
4273  078e cd0000        	call	c_itolx
4275  0791 be02          	ldw	x,c_lreg+2
4276  0793 89            	pushw	x
4277  0794 be00          	ldw	x,c_lreg
4278  0796 89            	pushw	x
4279  0797 cd0a00        	call	_ST_READ
4281  079a 5b08          	addw	sp,#8
4282  079c               L1022:
4283                     ; 524 			uart_out_adr_block ((256*i__)+0,buff,64);
4285  079c 4b40          	push	#64
4286  079e ae0050        	ldw	x,#_buff
4287  07a1 89            	pushw	x
4288  07a2 1e06          	ldw	x,(OFST+2,sp)
4289  07a4 4f            	clr	a
4290  07a5 02            	rlwa	x,a
4291  07a6 cd0000        	call	c_itolx
4293  07a9 be02          	ldw	x,c_lreg+2
4294  07ab 89            	pushw	x
4295  07ac be00          	ldw	x,c_lreg
4296  07ae 89            	pushw	x
4297  07af cd0180        	call	_uart_out_adr_block
4299  07b2 5b07          	addw	sp,#7
4300                     ; 525 			delay_ms(100);    
4302  07b4 ae0064        	ldw	x,#100
4303  07b7 cd0064        	call	_delay_ms
4305                     ; 526 			uart_out_adr_block ((256*i__)+64,&buff[64],64);
4307  07ba 4b40          	push	#64
4308  07bc ae0090        	ldw	x,#_buff+64
4309  07bf 89            	pushw	x
4310  07c0 1e06          	ldw	x,(OFST+2,sp)
4311  07c2 4f            	clr	a
4312  07c3 02            	rlwa	x,a
4313  07c4 1c0040        	addw	x,#64
4314  07c7 cd0000        	call	c_itolx
4316  07ca be02          	ldw	x,c_lreg+2
4317  07cc 89            	pushw	x
4318  07cd be00          	ldw	x,c_lreg
4319  07cf 89            	pushw	x
4320  07d0 cd0180        	call	_uart_out_adr_block
4322  07d3 5b07          	addw	sp,#7
4323                     ; 527 			delay_ms(100);    
4325  07d5 ae0064        	ldw	x,#100
4326  07d8 cd0064        	call	_delay_ms
4328                     ; 528 			uart_out_adr_block ((256*i__)+128,&buff[128],64);
4330  07db 4b40          	push	#64
4331  07dd ae00d0        	ldw	x,#_buff+128
4332  07e0 89            	pushw	x
4333  07e1 1e06          	ldw	x,(OFST+2,sp)
4334  07e3 4f            	clr	a
4335  07e4 02            	rlwa	x,a
4336  07e5 1c0080        	addw	x,#128
4337  07e8 cd0000        	call	c_itolx
4339  07eb be02          	ldw	x,c_lreg+2
4340  07ed 89            	pushw	x
4341  07ee be00          	ldw	x,c_lreg
4342  07f0 89            	pushw	x
4343  07f1 cd0180        	call	_uart_out_adr_block
4345  07f4 5b07          	addw	sp,#7
4346                     ; 529 			delay_ms(100);    
4348  07f6 ae0064        	ldw	x,#100
4349  07f9 cd0064        	call	_delay_ms
4351                     ; 530 			uart_out_adr_block ((256*i__)+192,&buff[192],64);
4353  07fc 4b40          	push	#64
4354  07fe ae0110        	ldw	x,#_buff+192
4355  0801 89            	pushw	x
4356  0802 1e06          	ldw	x,(OFST+2,sp)
4357  0804 4f            	clr	a
4358  0805 02            	rlwa	x,a
4359  0806 1c00c0        	addw	x,#192
4360  0809 cd0000        	call	c_itolx
4362  080c be02          	ldw	x,c_lreg+2
4363  080e 89            	pushw	x
4364  080f be00          	ldw	x,c_lreg
4365  0811 89            	pushw	x
4366  0812 cd0180        	call	_uart_out_adr_block
4368  0815 5b07          	addw	sp,#7
4369                     ; 531 			delay_ms(100);   
4371  0817 ae0064        	ldw	x,#100
4372  081a cd0064        	call	_delay_ms
4374                     ; 512 		for(i__=0;i__<EE_PAGE_LEN;i__++)
4376  081d 1e03          	ldw	x,(OFST-1,sp)
4377  081f 1c0001        	addw	x,#1
4378  0822 1f03          	ldw	(OFST-1,sp),x
4379  0824               L3712:
4382  0824 1e03          	ldw	x,(OFST-1,sp)
4383  0826 c30000        	cpw	x,_EE_PAGE_LEN
4384  0829 2403          	jruge	L66
4385  082b cc075d        	jp	L7612
4386  082e               L66:
4388  082e 2036          	jra	L1771
4389  0830               L5612:
4390                     ; 538 	else if(UIB[1]==55)
4392  0830 c60001        	ld	a,_UIB+1
4393  0833 a137          	cp	a,#55
4394  0835 2617          	jrne	L5022
4395                     ; 542 		current_page=0;
4397  0837 5f            	clrw	x
4398  0838 bf0f          	ldw	_current_page,x
4399                     ; 544 		if(memory_manufacturer=='S') {
4401  083a b6bc          	ld	a,_memory_manufacturer
4402  083c a153          	cp	a,#83
4403  083e 2626          	jrne	L1771
4404                     ; 545 			ST_WREN();
4406  0840 cd096e        	call	_ST_WREN
4408                     ; 546 			delay_ms(100);		
4410  0843 ae0064        	ldw	x,#100
4411  0846 cd0064        	call	_delay_ms
4413                     ; 547 			ST_BULK_ERASE();
4415  0849 cd097b        	call	_ST_BULK_ERASE
4417  084c 2018          	jra	L1771
4418  084e               L5022:
4419                     ; 556 	else if(UIB[1]==30)
4421  084e c60001        	ld	a,_UIB+1
4422  0851 a11e          	cp	a,#30
4423  0853 2606          	jrne	L3122
4424                     ; 578           bSTART=1;
4426  0855 7210000c      	bset	_bSTART
4428  0859 200b          	jra	L1771
4429  085b               L3122:
4430                     ; 590 	else if(UIB[1]==40)
4432  085b c60001        	ld	a,_UIB+1
4433  085e a128          	cp	a,#40
4434  0860 2604          	jrne	L1771
4435                     ; 612 		bSTART=1;	
4437  0862 7210000c      	bset	_bSTART
4438  0866               L1771:
4439                     ; 616 }
4442  0866 5b04          	addw	sp,#4
4443  0868 81            	ret
4480                     ; 619 void putchar(char c)
4480                     ; 620 {
4481                     	switch	.text
4482  0869               _putchar:
4484  0869 88            	push	a
4485       00000000      OFST:	set	0
4488  086a               L1422:
4489                     ; 621 while (tx_counter == TX_BUFFER_SIZE);
4491  086a b620          	ld	a,_tx_counter
4492  086c a150          	cp	a,#80
4493  086e 27fa          	jreq	L1422
4494                     ; 623 if (tx_counter || ((UART1->SR & UART1_SR_TXE)==0))
4496  0870 3d20          	tnz	_tx_counter
4497  0872 2607          	jrne	L7422
4499  0874 c65230        	ld	a,21040
4500  0877 a580          	bcp	a,#128
4501  0879 261d          	jrne	L5422
4502  087b               L7422:
4503                     ; 625    tx_buffer[tx_wr_index]=c;
4505  087b 5f            	clrw	x
4506  087c b61f          	ld	a,_tx_wr_index
4507  087e 2a01          	jrpl	L27
4508  0880 53            	cplw	x
4509  0881               L27:
4510  0881 97            	ld	xl,a
4511  0882 7b01          	ld	a,(OFST+1,sp)
4512  0884 e704          	ld	(_tx_buffer,x),a
4513                     ; 626    if (++tx_wr_index == TX_BUFFER_SIZE) tx_wr_index=0;
4515  0886 3c1f          	inc	_tx_wr_index
4516  0888 b61f          	ld	a,_tx_wr_index
4517  088a a150          	cp	a,#80
4518  088c 2602          	jrne	L1522
4521  088e 3f1f          	clr	_tx_wr_index
4522  0890               L1522:
4523                     ; 627    ++tx_counter;
4525  0890 3c20          	inc	_tx_counter
4527  0892               L3522:
4528                     ; 631 UART1->CR2|= UART1_CR2_TIEN;
4530  0892 721e5235      	bset	21045,#7
4531                     ; 633 }
4534  0896 84            	pop	a
4535  0897 81            	ret
4536  0898               L5422:
4537                     ; 629 else UART1->DR=c;
4539  0898 7b01          	ld	a,(OFST+1,sp)
4540  089a c75231        	ld	21041,a
4541  089d 20f3          	jra	L3522
4564                     ; 636 void spi_init(void){
4565                     	switch	.text
4566  089f               _spi_init:
4570                     ; 637 	GPIOA->DDR|=(1<<3);
4572  089f 72165002      	bset	20482,#3
4573                     ; 638 	GPIOA->CR1|=(1<<3);
4575  08a3 72165003      	bset	20483,#3
4576                     ; 639 	GPIOA->CR2&=~(1<<3);
4578  08a7 72175004      	bres	20484,#3
4579                     ; 640 	GPIOA->ODR|=(1<<3);	
4581  08ab 72165000      	bset	20480,#3
4582                     ; 642 	GPIOB->DDR|=(1<<5);
4584  08af 721a5007      	bset	20487,#5
4585                     ; 643 	GPIOB->CR1|=(1<<5);
4587  08b3 721a5008      	bset	20488,#5
4588                     ; 644 	GPIOB->CR2&=~(1<<5);
4590  08b7 721b5009      	bres	20489,#5
4591                     ; 645 	GPIOB->ODR|=(1<<5);	
4593  08bb 721a5005      	bset	20485,#5
4594                     ; 647 	GPIOC->DDR|=(1<<3);
4596  08bf 7216500c      	bset	20492,#3
4597                     ; 648 	GPIOC->CR1|=(1<<3);
4599  08c3 7216500d      	bset	20493,#3
4600                     ; 649 	GPIOC->CR2&=~(1<<3);
4602  08c7 7217500e      	bres	20494,#3
4603                     ; 650 	GPIOC->ODR|=(1<<3);	
4605  08cb 7216500a      	bset	20490,#3
4606                     ; 652 	GPIOC->DDR|=(1<<5);
4608  08cf 721a500c      	bset	20492,#5
4609                     ; 653 	GPIOC->CR1|=(1<<5);
4611  08d3 721a500d      	bset	20493,#5
4612                     ; 654 	GPIOC->CR2|=(1<<5);
4614  08d7 721a500e      	bset	20494,#5
4615                     ; 655 	GPIOC->ODR|=(1<<5);	
4617  08db 721a500a      	bset	20490,#5
4618                     ; 657 	GPIOC->DDR|=(1<<6);
4620  08df 721c500c      	bset	20492,#6
4621                     ; 658 	GPIOC->CR1|=(1<<6);
4623  08e3 721c500d      	bset	20493,#6
4624                     ; 659 	GPIOC->CR2|=(1<<6);
4626  08e7 721c500e      	bset	20494,#6
4627                     ; 660 	GPIOC->ODR|=(1<<6);	
4629  08eb 721c500a      	bset	20490,#6
4630                     ; 662 	GPIOC->DDR&=~(1<<7);
4632  08ef 721f500c      	bres	20492,#7
4633                     ; 663 	GPIOC->CR1&=~(1<<7);
4635  08f3 721f500d      	bres	20493,#7
4636                     ; 664 	GPIOC->CR2&=~(1<<7);
4638  08f7 721f500e      	bres	20494,#7
4639                     ; 665 	GPIOC->ODR|=(1<<7);	
4641  08fb 721e500a      	bset	20490,#7
4642                     ; 667 	SPI->CR1= /*SPI_CR1_LSBFIRST |*/
4642                     ; 668 			SPI_CR1_SPE | 
4642                     ; 669 			( (4<< 3) & SPI_CR1_BR ) |
4642                     ; 670 			SPI_CR1_MSTR |
4642                     ; 671 			SPI_CR1_CPOL |
4642                     ; 672 			SPI_CR1_CPHA; 
4644  08ff 35675200      	mov	20992,#103
4645                     ; 674 	SPI->CR2= SPI_CR2_SSM | SPI_CR2_SSI;
4647  0903 35035201      	mov	20993,#3
4648                     ; 675 	SPI->ICR= 0;	
4650  0907 725f5202      	clr	20994
4651                     ; 676 }
4654  090b 81            	ret
4697                     ; 679 char spi(char in){
4698                     	switch	.text
4699  090c               _spi:
4701  090c 88            	push	a
4702  090d 88            	push	a
4703       00000001      OFST:	set	1
4706  090e               L1132:
4707                     ; 681 	while(!((SPI->SR)&SPI_SR_TXE));
4709  090e c65203        	ld	a,20995
4710  0911 a502          	bcp	a,#2
4711  0913 27f9          	jreq	L1132
4712                     ; 682 	SPI->DR=in;
4714  0915 7b02          	ld	a,(OFST+1,sp)
4715  0917 c75204        	ld	20996,a
4717  091a               L1232:
4718                     ; 683 	while(!((SPI->SR)&SPI_SR_RXNE));
4720  091a c65203        	ld	a,20995
4721  091d a501          	bcp	a,#1
4722  091f 27f9          	jreq	L1232
4723                     ; 684 	c=SPI->DR;	
4725  0921 c65204        	ld	a,20996
4726  0924 6b01          	ld	(OFST+0,sp),a
4727                     ; 685 	return c;
4729  0926 7b01          	ld	a,(OFST+0,sp)
4732  0928 85            	popw	x
4733  0929 81            	ret
4798                     ; 689 long ST_RDID_read(void)
4798                     ; 690 {
4799                     	switch	.text
4800  092a               _ST_RDID_read:
4802  092a 5204          	subw	sp,#4
4803       00000004      OFST:	set	4
4806                     ; 693 d0=0;
4808  092c 0f04          	clr	(OFST+0,sp)
4809                     ; 694 d1=0;
4811                     ; 695 d2=0;
4813                     ; 696 d3=0;
4815                     ; 698 ST_CS_ON
4817  092e 721b5005      	bres	20485,#5
4818                     ; 699 spi(0x9f);
4820  0932 a69f          	ld	a,#159
4821  0934 add6          	call	_spi
4823                     ; 700 mdr0=spi(0xff);
4825  0936 a6ff          	ld	a,#255
4826  0938 add2          	call	_spi
4828  093a b716          	ld	_mdr0,a
4829                     ; 701 mdr1=spi(0xff);
4831  093c a6ff          	ld	a,#255
4832  093e adcc          	call	_spi
4834  0940 b715          	ld	_mdr1,a
4835                     ; 702 mdr2=spi(0xff);
4837  0942 a6ff          	ld	a,#255
4838  0944 adc6          	call	_spi
4840  0946 b714          	ld	_mdr2,a
4841                     ; 705 ST_CS_OFF
4843  0948 721a5005      	bset	20485,#5
4844                     ; 706 return  *((long*)&d0);
4846  094c 96            	ldw	x,sp
4847  094d 1c0004        	addw	x,#OFST+0
4848  0950 cd0000        	call	c_ltor
4852  0953 5b04          	addw	sp,#4
4853  0955 81            	ret
4888                     ; 710 char ST_status_read(void)
4888                     ; 711 {
4889                     	switch	.text
4890  0956               _ST_status_read:
4892  0956 88            	push	a
4893       00000001      OFST:	set	1
4896                     ; 715 ST_CS_ON
4898  0957 721b5005      	bres	20485,#5
4899                     ; 716 spi(0x05);
4901  095b a605          	ld	a,#5
4902  095d adad          	call	_spi
4904                     ; 717 d0=spi(0xff);
4906  095f a6ff          	ld	a,#255
4907  0961 ada9          	call	_spi
4909  0963 6b01          	ld	(OFST+0,sp),a
4910                     ; 719 ST_CS_OFF
4912  0965 721a5005      	bset	20485,#5
4913                     ; 720 return d0;
4915  0969 7b01          	ld	a,(OFST+0,sp)
4918  096b 5b01          	addw	sp,#1
4919  096d 81            	ret
4943                     ; 724 void ST_WREN(void)
4943                     ; 725 {
4944                     	switch	.text
4945  096e               _ST_WREN:
4949                     ; 727 ST_CS_ON
4951  096e 721b5005      	bres	20485,#5
4952                     ; 728 spi(0x06);
4954  0972 a606          	ld	a,#6
4955  0974 ad96          	call	_spi
4957                     ; 730 ST_CS_OFF
4959  0976 721a5005      	bset	20485,#5
4960                     ; 731 }  
4963  097a 81            	ret
4987                     ; 734 void ST_BULK_ERASE(void)
4987                     ; 735 {
4988                     	switch	.text
4989  097b               _ST_BULK_ERASE:
4993                     ; 737 ST_CS_ON
4995  097b 721b5005      	bres	20485,#5
4996                     ; 738 spi(0xc7);
4998  097f a6c7          	ld	a,#199
4999  0981 ad89          	call	_spi
5001                     ; 740 ST_CS_OFF
5003  0983 721a5005      	bset	20485,#5
5004                     ; 741 }  
5007  0987 81            	ret
5069                     ; 744 void ST_PAGE_ERASE(unsigned short page)
5069                     ; 745 {
5070                     	switch	.text
5071  0988               _ST_PAGE_ERASE:
5073  0988 89            	pushw	x
5074  0989 5203          	subw	sp,#3
5075       00000003      OFST:	set	3
5078                     ; 748 ST_CS_ON
5080  098b 721b5005      	bres	20485,#5
5081                     ; 749 spi(0xDB);
5083  098f a6db          	ld	a,#219
5084  0991 cd090c        	call	_spi
5086                     ; 750 adr2=(char)(page>>8);
5088  0994 7b04          	ld	a,(OFST+1,sp)
5089  0996 6b03          	ld	(OFST+0,sp),a
5090                     ; 751 adr1=(char)(page);
5092  0998 7b05          	ld	a,(OFST+2,sp)
5093  099a 6b02          	ld	(OFST-1,sp),a
5094                     ; 752 adr0=(char)(0);
5096  099c 0f01          	clr	(OFST-2,sp)
5097                     ; 753 spi(adr2);
5099  099e 7b03          	ld	a,(OFST+0,sp)
5100  09a0 cd090c        	call	_spi
5102                     ; 754 spi(adr1);
5104  09a3 7b02          	ld	a,(OFST-1,sp)
5105  09a5 cd090c        	call	_spi
5107                     ; 755 spi(adr0);
5109  09a8 7b01          	ld	a,(OFST-2,sp)
5110  09aa cd090c        	call	_spi
5112                     ; 756 ST_CS_OFF
5114  09ad 721a5005      	bset	20485,#5
5115                     ; 757 }  
5118  09b1 5b05          	addw	sp,#5
5119  09b3 81            	ret
5209                     ; 760 void ST_WRITE(unsigned long memo_addr,unsigned short len, char* adr)
5209                     ; 761 {
5210                     	switch	.text
5211  09b4               _ST_WRITE:
5213  09b4 5205          	subw	sp,#5
5214       00000005      OFST:	set	5
5217                     ; 765 adr2=(char)(memo_addr>>16);
5219  09b6 7b09          	ld	a,(OFST+4,sp)
5220  09b8 6b03          	ld	(OFST-2,sp),a
5221                     ; 766 adr1=(char)((memo_addr>>8)&0x00ff);
5223  09ba 7b0a          	ld	a,(OFST+5,sp)
5224  09bc a4ff          	and	a,#255
5225  09be 6b02          	ld	(OFST-3,sp),a
5226                     ; 767 adr0=(char)((memo_addr)&0x00ff);
5228  09c0 7b0b          	ld	a,(OFST+6,sp)
5229  09c2 a4ff          	and	a,#255
5230  09c4 6b01          	ld	(OFST-4,sp),a
5231                     ; 768 ST_CS_ON
5233  09c6 721b5005      	bres	20485,#5
5234                     ; 769 spi(0x02);
5236  09ca a602          	ld	a,#2
5237  09cc cd090c        	call	_spi
5239                     ; 770 spi(adr2);
5241  09cf 7b03          	ld	a,(OFST-2,sp)
5242  09d1 cd090c        	call	_spi
5244                     ; 771 spi(adr1);
5246  09d4 7b02          	ld	a,(OFST-3,sp)
5247  09d6 cd090c        	call	_spi
5249                     ; 772 spi(adr0);
5251  09d9 7b01          	ld	a,(OFST-4,sp)
5252  09db cd090c        	call	_spi
5254                     ; 774 for(i=0;i<len;i++)
5256  09de 5f            	clrw	x
5257  09df 1f04          	ldw	(OFST-1,sp),x
5259  09e1 2010          	jra	L1252
5260  09e3               L5152:
5261                     ; 776 	spi(adr[i]);
5263  09e3 1e0e          	ldw	x,(OFST+9,sp)
5264  09e5 72fb04        	addw	x,(OFST-1,sp)
5265  09e8 f6            	ld	a,(x)
5266  09e9 cd090c        	call	_spi
5268                     ; 774 for(i=0;i<len;i++)
5270  09ec 1e04          	ldw	x,(OFST-1,sp)
5271  09ee 1c0001        	addw	x,#1
5272  09f1 1f04          	ldw	(OFST-1,sp),x
5273  09f3               L1252:
5276  09f3 1e04          	ldw	x,(OFST-1,sp)
5277  09f5 130c          	cpw	x,(OFST+7,sp)
5278  09f7 25ea          	jrult	L5152
5279                     ; 779 ST_CS_OFF
5281  09f9 721a5005      	bset	20485,#5
5282                     ; 780 }
5285  09fd 5b05          	addw	sp,#5
5286  09ff 81            	ret
5376                     ; 783 void ST_READ(unsigned long memo_addr,unsigned short len, char* adr)
5376                     ; 784 {
5377                     	switch	.text
5378  0a00               _ST_READ:
5380  0a00 5205          	subw	sp,#5
5381       00000005      OFST:	set	5
5384                     ; 790 adr2=(char)(memo_addr>>16);
5386  0a02 7b09          	ld	a,(OFST+4,sp)
5387  0a04 6b03          	ld	(OFST-2,sp),a
5388                     ; 791 adr1=(char)((memo_addr>>8)&0x00ff);
5390  0a06 7b0a          	ld	a,(OFST+5,sp)
5391  0a08 a4ff          	and	a,#255
5392  0a0a 6b02          	ld	(OFST-3,sp),a
5393                     ; 792 adr0=(char)((memo_addr)&0x00ff);
5395  0a0c 7b0b          	ld	a,(OFST+6,sp)
5396  0a0e a4ff          	and	a,#255
5397  0a10 6b01          	ld	(OFST-4,sp),a
5398                     ; 793 ST_CS_ON
5400  0a12 721b5005      	bres	20485,#5
5401                     ; 794 spi(0x03);
5403  0a16 a603          	ld	a,#3
5404  0a18 cd090c        	call	_spi
5406                     ; 795 spi(adr2);
5408  0a1b 7b03          	ld	a,(OFST-2,sp)
5409  0a1d cd090c        	call	_spi
5411                     ; 796 spi(adr1);
5413  0a20 7b02          	ld	a,(OFST-3,sp)
5414  0a22 cd090c        	call	_spi
5416                     ; 797 spi(adr0);
5418  0a25 7b01          	ld	a,(OFST-4,sp)
5419  0a27 cd090c        	call	_spi
5421                     ; 799 for(i=0;i<len;i++)
5423  0a2a 5f            	clrw	x
5424  0a2b 1f04          	ldw	(OFST-1,sp),x
5426  0a2d 2012          	jra	L7752
5427  0a2f               L3752:
5428                     ; 801 	adr[i]=spi(0xff);
5430  0a2f a6ff          	ld	a,#255
5431  0a31 cd090c        	call	_spi
5433  0a34 1e0e          	ldw	x,(OFST+9,sp)
5434  0a36 72fb04        	addw	x,(OFST-1,sp)
5435  0a39 f7            	ld	(x),a
5436                     ; 799 for(i=0;i<len;i++)
5438  0a3a 1e04          	ldw	x,(OFST-1,sp)
5439  0a3c 1c0001        	addw	x,#1
5440  0a3f 1f04          	ldw	(OFST-1,sp),x
5441  0a41               L7752:
5444  0a41 1e04          	ldw	x,(OFST-1,sp)
5445  0a43 130c          	cpw	x,(OFST+7,sp)
5446  0a45 25e8          	jrult	L3752
5447                     ; 804 ST_CS_OFF
5449  0a47 721a5005      	bset	20485,#5
5450                     ; 805 }
5453  0a4b 5b05          	addw	sp,#5
5454  0a4d 81            	ret
5520                     ; 809 long DF_mf_dev_read(void)
5520                     ; 810 {
5521                     	switch	.text
5522  0a4e               _DF_mf_dev_read:
5524  0a4e 5204          	subw	sp,#4
5525       00000004      OFST:	set	4
5528                     ; 813 d0=0;
5530  0a50 0f04          	clr	(OFST+0,sp)
5531                     ; 814 d1=0;
5533                     ; 815 d2=0;
5535                     ; 816 d3=0;
5537                     ; 818 CS_ON
5539  0a52 7217500a      	bres	20490,#3
5540                     ; 819 spi(0x9f);
5542  0a56 a69f          	ld	a,#159
5543  0a58 cd090c        	call	_spi
5545                     ; 820 mdr0=spi(0xff);
5547  0a5b a6ff          	ld	a,#255
5548  0a5d cd090c        	call	_spi
5550  0a60 b716          	ld	_mdr0,a
5551                     ; 821 mdr1=spi(0xff);
5553  0a62 a6ff          	ld	a,#255
5554  0a64 cd090c        	call	_spi
5556  0a67 b715          	ld	_mdr1,a
5557                     ; 822 mdr2=spi(0xff);
5559  0a69 a6ff          	ld	a,#255
5560  0a6b cd090c        	call	_spi
5562  0a6e b714          	ld	_mdr2,a
5563                     ; 823 mdr3=spi(0xff);  
5565  0a70 a6ff          	ld	a,#255
5566  0a72 cd090c        	call	_spi
5568  0a75 b713          	ld	_mdr3,a
5569                     ; 825 CS_OFF
5571  0a77 7216500a      	bset	20490,#3
5572                     ; 826 return  *((long*)&d0);
5574  0a7b 96            	ldw	x,sp
5575  0a7c 1c0004        	addw	x,#OFST+0
5576  0a7f cd0000        	call	c_ltor
5580  0a82 5b04          	addw	sp,#4
5581  0a84 81            	ret
5605                     ; 830 void DF_memo_to_256(void)
5605                     ; 831 {
5606                     	switch	.text
5607  0a85               _DF_memo_to_256:
5611                     ; 833 CS_ON
5613  0a85 7217500a      	bres	20490,#3
5614                     ; 834 spi(0x3d);
5616  0a89 a63d          	ld	a,#61
5617  0a8b cd090c        	call	_spi
5619                     ; 835 spi(0x2a); 
5621  0a8e a62a          	ld	a,#42
5622  0a90 cd090c        	call	_spi
5624                     ; 836 spi(0x80);
5626  0a93 a680          	ld	a,#128
5627  0a95 cd090c        	call	_spi
5629                     ; 837 spi(0xa6);
5631  0a98 a6a6          	ld	a,#166
5632  0a9a cd090c        	call	_spi
5634                     ; 839 CS_OFF
5636  0a9d 7216500a      	bset	20490,#3
5637                     ; 840 }  
5640  0aa1 81            	ret
5675                     ; 845 char DF_status_read(void)
5675                     ; 846 {
5676                     	switch	.text
5677  0aa2               _DF_status_read:
5679  0aa2 88            	push	a
5680       00000001      OFST:	set	1
5683                     ; 850 CS_ON
5685  0aa3 7217500a      	bres	20490,#3
5686                     ; 851 spi(0xd7);
5688  0aa7 a6d7          	ld	a,#215
5689  0aa9 cd090c        	call	_spi
5691                     ; 852 d0=spi(0xff);
5693  0aac a6ff          	ld	a,#255
5694  0aae cd090c        	call	_spi
5696  0ab1 6b01          	ld	(OFST+0,sp),a
5697                     ; 854 CS_OFF
5699  0ab3 7216500a      	bset	20490,#3
5700                     ; 855 return d0;
5702  0ab7 7b01          	ld	a,(OFST+0,sp)
5705  0ab9 5b01          	addw	sp,#1
5706  0abb 81            	ret
5750                     ; 859 void DF_page_to_buffer(unsigned page_addr)
5750                     ; 860 {
5751                     	switch	.text
5752  0abc               _DF_page_to_buffer:
5754  0abc 89            	pushw	x
5755  0abd 88            	push	a
5756       00000001      OFST:	set	1
5759                     ; 863 d0=0x53; 
5761                     ; 867 CS_ON
5763  0abe 7217500a      	bres	20490,#3
5764                     ; 868 spi(d0);
5766  0ac2 a653          	ld	a,#83
5767  0ac4 cd090c        	call	_spi
5769                     ; 869 spi(page_addr/256/**(((char*)&page_addr)+1)*/);
5771  0ac7 7b02          	ld	a,(OFST+1,sp)
5772  0ac9 cd090c        	call	_spi
5774                     ; 870 spi(page_addr%256/**((char*)&page_addr)*/);
5776  0acc 7b03          	ld	a,(OFST+2,sp)
5777  0ace a4ff          	and	a,#255
5778  0ad0 cd090c        	call	_spi
5780                     ; 871 spi(0xff);
5782  0ad3 a6ff          	ld	a,#255
5783  0ad5 cd090c        	call	_spi
5785                     ; 873 CS_OFF
5787  0ad8 7216500a      	bset	20490,#3
5788                     ; 874 }
5791  0adc 5b03          	addw	sp,#3
5792  0ade 81            	ret
5837                     ; 877 void DF_buffer_to_page_er(/*char buff,*/unsigned page_addr)
5837                     ; 878 {
5838                     	switch	.text
5839  0adf               _DF_buffer_to_page_er:
5841  0adf 89            	pushw	x
5842  0ae0 88            	push	a
5843       00000001      OFST:	set	1
5846                     ; 881 d0=0x83; 
5848                     ; 884 CS_ON
5850  0ae1 7217500a      	bres	20490,#3
5851                     ; 885 spi(d0);
5853  0ae5 a683          	ld	a,#131
5854  0ae7 cd090c        	call	_spi
5856                     ; 886 spi(page_addr/256/**(((char*)&page_addr)+1)*/);
5858  0aea 7b02          	ld	a,(OFST+1,sp)
5859  0aec cd090c        	call	_spi
5861                     ; 887 spi(page_addr%256/**((char*)&page_addr)*/);
5863  0aef 7b03          	ld	a,(OFST+2,sp)
5864  0af1 a4ff          	and	a,#255
5865  0af3 cd090c        	call	_spi
5867                     ; 888 spi(0xff);
5869  0af6 a6ff          	ld	a,#255
5870  0af8 cd090c        	call	_spi
5872                     ; 890 CS_OFF
5874  0afb 7216500a      	bset	20490,#3
5875                     ; 891 }
5878  0aff 5b03          	addw	sp,#3
5879  0b01 81            	ret
5951                     ; 894 void DF_buffer_read(unsigned buff_addr,unsigned len, char* adr)
5951                     ; 895 {
5952                     	switch	.text
5953  0b02               _DF_buffer_read:
5955  0b02 89            	pushw	x
5956  0b03 5203          	subw	sp,#3
5957       00000003      OFST:	set	3
5960                     ; 899 d0=0x54; 
5962                     ; 901 CS_ON
5964  0b05 7217500a      	bres	20490,#3
5965                     ; 902 spi(d0);
5967  0b09 a654          	ld	a,#84
5968  0b0b cd090c        	call	_spi
5970                     ; 903 spi(0xff);
5972  0b0e a6ff          	ld	a,#255
5973  0b10 cd090c        	call	_spi
5975                     ; 904 spi(buff_addr/256/**(((char*)&buff_addr)+1)*/);
5977  0b13 7b04          	ld	a,(OFST+1,sp)
5978  0b15 cd090c        	call	_spi
5980                     ; 905 spi(buff_addr%256/**((char*)&buff_addr)*/);
5982  0b18 7b05          	ld	a,(OFST+2,sp)
5983  0b1a a4ff          	and	a,#255
5984  0b1c cd090c        	call	_spi
5986                     ; 906 spi(0xff);
5988  0b1f a6ff          	ld	a,#255
5989  0b21 cd090c        	call	_spi
5991                     ; 907 for(i=0;i<len;i++)
5993  0b24 5f            	clrw	x
5994  0b25 1f02          	ldw	(OFST-1,sp),x
5996  0b27 2012          	jra	L1772
5997  0b29               L5672:
5998                     ; 909 	adr[i]=spi(0xff);
6000  0b29 a6ff          	ld	a,#255
6001  0b2b cd090c        	call	_spi
6003  0b2e 1e0a          	ldw	x,(OFST+7,sp)
6004  0b30 72fb02        	addw	x,(OFST-1,sp)
6005  0b33 f7            	ld	(x),a
6006                     ; 907 for(i=0;i<len;i++)
6008  0b34 1e02          	ldw	x,(OFST-1,sp)
6009  0b36 1c0001        	addw	x,#1
6010  0b39 1f02          	ldw	(OFST-1,sp),x
6011  0b3b               L1772:
6014  0b3b 1e02          	ldw	x,(OFST-1,sp)
6015  0b3d 1308          	cpw	x,(OFST+5,sp)
6016  0b3f 25e8          	jrult	L5672
6017                     ; 912 CS_OFF
6019  0b41 7216500a      	bset	20490,#3
6020                     ; 913 }
6023  0b45 5b05          	addw	sp,#5
6024  0b47 81            	ret
6096                     ; 916 void DF_buffer_write(/*char buff,*/unsigned buff_addr,unsigned len, char* adr)
6096                     ; 917 {
6097                     	switch	.text
6098  0b48               _DF_buffer_write:
6100  0b48 89            	pushw	x
6101  0b49 5203          	subw	sp,#3
6102       00000003      OFST:	set	3
6105                     ; 921 d0=0x84; 
6107                     ; 923 CS_ON
6109  0b4b 7217500a      	bres	20490,#3
6110                     ; 924 spi(d0);
6112  0b4f a684          	ld	a,#132
6113  0b51 cd090c        	call	_spi
6115                     ; 925 spi(0xff);
6117  0b54 a6ff          	ld	a,#255
6118  0b56 cd090c        	call	_spi
6120                     ; 926 spi(buff_addr/256/**(((char*)&buff_addr)+1)*/);
6122  0b59 7b04          	ld	a,(OFST+1,sp)
6123  0b5b cd090c        	call	_spi
6125                     ; 927 spi(buff_addr%256/**((char*)&buff_addr)*/);
6127  0b5e 7b05          	ld	a,(OFST+2,sp)
6128  0b60 a4ff          	and	a,#255
6129  0b62 cd090c        	call	_spi
6131                     ; 929 for(i=0;i<len;i++)
6133  0b65 5f            	clrw	x
6134  0b66 1f02          	ldw	(OFST-1,sp),x
6136  0b68 2010          	jra	L7303
6137  0b6a               L3303:
6138                     ; 931 	spi(adr[i]);
6140  0b6a 1e0a          	ldw	x,(OFST+7,sp)
6141  0b6c 72fb02        	addw	x,(OFST-1,sp)
6142  0b6f f6            	ld	a,(x)
6143  0b70 cd090c        	call	_spi
6145                     ; 929 for(i=0;i<len;i++)
6147  0b73 1e02          	ldw	x,(OFST-1,sp)
6148  0b75 1c0001        	addw	x,#1
6149  0b78 1f02          	ldw	(OFST-1,sp),x
6150  0b7a               L7303:
6153  0b7a 1e02          	ldw	x,(OFST-1,sp)
6154  0b7c 1308          	cpw	x,(OFST+5,sp)
6155  0b7e 25ea          	jrult	L3303
6156                     ; 934 CS_OFF
6158  0b80 7216500a      	bset	20490,#3
6159                     ; 935 }
6162  0b84 5b05          	addw	sp,#5
6163  0b86 81            	ret
6186                     ; 957 void gpio_init(void){
6187                     	switch	.text
6188  0b87               _gpio_init:
6192                     ; 967 	GPIOD->DDR|=(1<<2);
6194  0b87 72145011      	bset	20497,#2
6195                     ; 968 	GPIOD->CR1|=(1<<2);
6197  0b8b 72145012      	bset	20498,#2
6198                     ; 969 	GPIOD->CR2|=(1<<2);
6200  0b8f 72145013      	bset	20499,#2
6201                     ; 970 	GPIOD->ODR&=~(1<<2);
6203  0b93 7215500f      	bres	20495,#2
6204                     ; 972 	GPIOD->DDR|=(1<<4);
6206  0b97 72185011      	bset	20497,#4
6207                     ; 973 	GPIOD->CR1|=(1<<4);
6209  0b9b 72185012      	bset	20498,#4
6210                     ; 974 	GPIOD->CR2&=~(1<<4);
6212  0b9f 72195013      	bres	20499,#4
6213                     ; 976 	GPIOC->DDR&=~(1<<4);
6215  0ba3 7219500c      	bres	20492,#4
6216                     ; 977 	GPIOC->CR1&=~(1<<4);
6218  0ba7 7219500d      	bres	20493,#4
6219                     ; 978 	GPIOC->CR2&=~(1<<4);
6221  0bab 7219500e      	bres	20494,#4
6222                     ; 982 }
6225  0baf 81            	ret
6277                     ; 985 void uart_in(void)
6277                     ; 986 {
6278                     	switch	.text
6279  0bb0               _uart_in:
6281  0bb0 89            	pushw	x
6282       00000002      OFST:	set	2
6285                     ; 990 if(rx_buffer_overflow)
6287                     	btst	_rx_buffer_overflow
6288  0bb6 240d          	jruge	L5703
6289                     ; 992 	rx_wr_index=0;
6291  0bb8 5f            	clrw	x
6292  0bb9 bf1a          	ldw	_rx_wr_index,x
6293                     ; 993 	rx_rd_index=0;
6295  0bbb 5f            	clrw	x
6296  0bbc bf18          	ldw	_rx_rd_index,x
6297                     ; 994 	rx_counter=0;
6299  0bbe 5f            	clrw	x
6300  0bbf bf1c          	ldw	_rx_counter,x
6301                     ; 995 	rx_buffer_overflow=0;
6303  0bc1 72110001      	bres	_rx_buffer_overflow
6304  0bc5               L5703:
6305                     ; 998 if(rx_counter&&(rx_buffer[index_offset(rx_wr_index,-1)])==END)
6307  0bc5 be1c          	ldw	x,_rx_counter
6308  0bc7 2775          	jreq	L7703
6310  0bc9 aeffff        	ldw	x,#65535
6311  0bcc 89            	pushw	x
6312  0bcd be1a          	ldw	x,_rx_wr_index
6313  0bcf ad6f          	call	_index_offset
6315  0bd1 5b02          	addw	sp,#2
6316  0bd3 e654          	ld	a,(_rx_buffer,x)
6317  0bd5 a10a          	cp	a,#10
6318  0bd7 2665          	jrne	L7703
6319                     ; 1003 	temp=rx_buffer[index_offset(rx_wr_index,-3)];
6321  0bd9 aefffd        	ldw	x,#65533
6322  0bdc 89            	pushw	x
6323  0bdd be1a          	ldw	x,_rx_wr_index
6324  0bdf ad5f          	call	_index_offset
6326  0be1 5b02          	addw	sp,#2
6327  0be3 e654          	ld	a,(_rx_buffer,x)
6328  0be5 6b01          	ld	(OFST-1,sp),a
6329                     ; 1004     	if(temp<100) 
6331  0be7 7b01          	ld	a,(OFST-1,sp)
6332  0be9 a164          	cp	a,#100
6333  0beb 2451          	jruge	L7703
6334                     ; 1007     		if(control_check(index_offset(rx_wr_index,-1)))
6336  0bed aeffff        	ldw	x,#65535
6337  0bf0 89            	pushw	x
6338  0bf1 be1a          	ldw	x,_rx_wr_index
6339  0bf3 ad4b          	call	_index_offset
6341  0bf5 5b02          	addw	sp,#2
6342  0bf7 9f            	ld	a,xl
6343  0bf8 ad6e          	call	_control_check
6345  0bfa 4d            	tnz	a
6346  0bfb 2741          	jreq	L7703
6347                     ; 1010     			rx_rd_index=index_offset(rx_wr_index,-3-temp);
6349  0bfd a6ff          	ld	a,#255
6350  0bff 97            	ld	xl,a
6351  0c00 a6fd          	ld	a,#253
6352  0c02 1001          	sub	a,(OFST-1,sp)
6353  0c04 2401          	jrnc	L041
6354  0c06 5a            	decw	x
6355  0c07               L041:
6356  0c07 02            	rlwa	x,a
6357  0c08 89            	pushw	x
6358  0c09 01            	rrwa	x,a
6359  0c0a be1a          	ldw	x,_rx_wr_index
6360  0c0c ad32          	call	_index_offset
6362  0c0e 5b02          	addw	sp,#2
6363  0c10 bf18          	ldw	_rx_rd_index,x
6364                     ; 1011     			for(i=0;i<temp;i++)
6366  0c12 0f02          	clr	(OFST+0,sp)
6368  0c14 2018          	jra	L1113
6369  0c16               L5013:
6370                     ; 1013 				UIB[i]=rx_buffer[index_offset(rx_rd_index,i)];
6372  0c16 7b02          	ld	a,(OFST+0,sp)
6373  0c18 5f            	clrw	x
6374  0c19 97            	ld	xl,a
6375  0c1a 89            	pushw	x
6376  0c1b 7b04          	ld	a,(OFST+2,sp)
6377  0c1d 5f            	clrw	x
6378  0c1e 97            	ld	xl,a
6379  0c1f 89            	pushw	x
6380  0c20 be18          	ldw	x,_rx_rd_index
6381  0c22 ad1c          	call	_index_offset
6383  0c24 5b02          	addw	sp,#2
6384  0c26 e654          	ld	a,(_rx_buffer,x)
6385  0c28 85            	popw	x
6386  0c29 d70000        	ld	(_UIB,x),a
6387                     ; 1011     			for(i=0;i<temp;i++)
6389  0c2c 0c02          	inc	(OFST+0,sp)
6390  0c2e               L1113:
6393  0c2e 7b02          	ld	a,(OFST+0,sp)
6394  0c30 1101          	cp	a,(OFST-1,sp)
6395  0c32 25e2          	jrult	L5013
6396                     ; 1015 			rx_rd_index=rx_wr_index;
6398  0c34 be1a          	ldw	x,_rx_wr_index
6399  0c36 bf18          	ldw	_rx_rd_index,x
6400                     ; 1016 			rx_counter=0;
6402  0c38 5f            	clrw	x
6403  0c39 bf1c          	ldw	_rx_counter,x
6404                     ; 1026 			uart_in_an();
6406  0c3b cd0240        	call	_uart_in_an
6408  0c3e               L7703:
6409                     ; 1035 }
6412  0c3e 85            	popw	x
6413  0c3f 81            	ret
6456                     ; 1038 signed short index_offset (signed short index,signed short offset)
6456                     ; 1039 {
6457                     	switch	.text
6458  0c40               _index_offset:
6460  0c40 89            	pushw	x
6461       00000000      OFST:	set	0
6464                     ; 1040 index=index+offset;
6466  0c41 1e01          	ldw	x,(OFST+1,sp)
6467  0c43 72fb05        	addw	x,(OFST+5,sp)
6468  0c46 1f01          	ldw	(OFST+1,sp),x
6469                     ; 1041 if(index>=RX_BUFFER_SIZE) index-=RX_BUFFER_SIZE; 
6471  0c48 9c            	rvf
6472  0c49 1e01          	ldw	x,(OFST+1,sp)
6473  0c4b a30064        	cpw	x,#100
6474  0c4e 2f07          	jrslt	L7313
6477  0c50 1e01          	ldw	x,(OFST+1,sp)
6478  0c52 1d0064        	subw	x,#100
6479  0c55 1f01          	ldw	(OFST+1,sp),x
6480  0c57               L7313:
6481                     ; 1042 if(index<0) index+=RX_BUFFER_SIZE;
6483  0c57 9c            	rvf
6484  0c58 1e01          	ldw	x,(OFST+1,sp)
6485  0c5a 2e07          	jrsge	L1413
6488  0c5c 1e01          	ldw	x,(OFST+1,sp)
6489  0c5e 1c0064        	addw	x,#100
6490  0c61 1f01          	ldw	(OFST+1,sp),x
6491  0c63               L1413:
6492                     ; 1043 return index;
6494  0c63 1e01          	ldw	x,(OFST+1,sp)
6497  0c65 5b02          	addw	sp,#2
6498  0c67 81            	ret
6561                     ; 1047 char control_check(char index)
6561                     ; 1048 {
6562                     	switch	.text
6563  0c68               _control_check:
6565  0c68 88            	push	a
6566  0c69 5203          	subw	sp,#3
6567       00000003      OFST:	set	3
6570                     ; 1049 char i=0,ii=0,iii;
6574                     ; 1051 if(rx_buffer[index]!=END) return 0;
6576  0c6b 5f            	clrw	x
6577  0c6c 97            	ld	xl,a
6578  0c6d e654          	ld	a,(_rx_buffer,x)
6579  0c6f a10a          	cp	a,#10
6580  0c71 2703          	jreq	L5713
6583  0c73 4f            	clr	a
6585  0c74 2051          	jra	L251
6586  0c76               L5713:
6587                     ; 1053 ii=rx_buffer[index_offset(index,-2)];
6589  0c76 aefffe        	ldw	x,#65534
6590  0c79 89            	pushw	x
6591  0c7a 7b06          	ld	a,(OFST+3,sp)
6592  0c7c 5f            	clrw	x
6593  0c7d 97            	ld	xl,a
6594  0c7e adc0          	call	_index_offset
6596  0c80 5b02          	addw	sp,#2
6597  0c82 e654          	ld	a,(_rx_buffer,x)
6598  0c84 6b02          	ld	(OFST-1,sp),a
6599                     ; 1054 iii=0;
6601  0c86 0f01          	clr	(OFST-2,sp)
6602                     ; 1055 for(i=0;i<=ii;i++)
6604  0c88 0f03          	clr	(OFST+0,sp)
6606  0c8a 2022          	jra	L3023
6607  0c8c               L7713:
6608                     ; 1057 	iii^=rx_buffer[index_offset(index,-2-ii+i)];
6610  0c8c a6ff          	ld	a,#255
6611  0c8e 97            	ld	xl,a
6612  0c8f a6fe          	ld	a,#254
6613  0c91 1002          	sub	a,(OFST-1,sp)
6614  0c93 2401          	jrnc	L641
6615  0c95 5a            	decw	x
6616  0c96               L641:
6617  0c96 1b03          	add	a,(OFST+0,sp)
6618  0c98 2401          	jrnc	L051
6619  0c9a 5c            	incw	x
6620  0c9b               L051:
6621  0c9b 02            	rlwa	x,a
6622  0c9c 89            	pushw	x
6623  0c9d 01            	rrwa	x,a
6624  0c9e 7b06          	ld	a,(OFST+3,sp)
6625  0ca0 5f            	clrw	x
6626  0ca1 97            	ld	xl,a
6627  0ca2 ad9c          	call	_index_offset
6629  0ca4 5b02          	addw	sp,#2
6630  0ca6 7b01          	ld	a,(OFST-2,sp)
6631  0ca8 e854          	xor	a,	(_rx_buffer,x)
6632  0caa 6b01          	ld	(OFST-2,sp),a
6633                     ; 1055 for(i=0;i<=ii;i++)
6635  0cac 0c03          	inc	(OFST+0,sp)
6636  0cae               L3023:
6639  0cae 7b03          	ld	a,(OFST+0,sp)
6640  0cb0 1102          	cp	a,(OFST-1,sp)
6641  0cb2 23d8          	jrule	L7713
6642                     ; 1059 if (iii!=rx_buffer[index_offset(index,-1)]) return 0;	
6644  0cb4 aeffff        	ldw	x,#65535
6645  0cb7 89            	pushw	x
6646  0cb8 7b06          	ld	a,(OFST+3,sp)
6647  0cba 5f            	clrw	x
6648  0cbb 97            	ld	xl,a
6649  0cbc ad82          	call	_index_offset
6651  0cbe 5b02          	addw	sp,#2
6652  0cc0 e654          	ld	a,(_rx_buffer,x)
6653  0cc2 1101          	cp	a,(OFST-2,sp)
6654  0cc4 2704          	jreq	L7023
6657  0cc6 4f            	clr	a
6659  0cc7               L251:
6661  0cc7 5b04          	addw	sp,#4
6662  0cc9 81            	ret
6663  0cca               L7023:
6664                     ; 1061 return 1;
6666  0cca a601          	ld	a,#1
6668  0ccc 20f9          	jra	L251
6710                     ; 1070 @far @interrupt void TIM4_UPD_Interrupt (void) {
6712                     	switch	.text
6713  0cce               f_TIM4_UPD_Interrupt:
6717                     ; 1072 	if(play) {
6719                     	btst	_play
6720  0cd3 2445          	jruge	L1223
6721                     ; 1073 		TIM2->CCR3H= 0x00;	
6723  0cd5 725f5315      	clr	21269
6724                     ; 1074 		TIM2->CCR3L= sample;
6726  0cd9 5500175316    	mov	21270,_sample
6727                     ; 1075 		sample_cnt++;
6729  0cde be21          	ldw	x,_sample_cnt
6730  0ce0 1c0001        	addw	x,#1
6731  0ce3 bf21          	ldw	_sample_cnt,x
6732                     ; 1076 		if(sample_cnt>=256) {
6734  0ce5 9c            	rvf
6735  0ce6 be21          	ldw	x,_sample_cnt
6736  0ce8 a30100        	cpw	x,#256
6737  0ceb 2f03          	jrslt	L3223
6738                     ; 1077 			sample_cnt=0;
6740  0ced 5f            	clrw	x
6741  0cee bf21          	ldw	_sample_cnt,x
6742  0cf0               L3223:
6743                     ; 1081 		sample=buff[sample_cnt];
6745  0cf0 be21          	ldw	x,_sample_cnt
6746  0cf2 d60050        	ld	a,(_buff,x)
6747  0cf5 b717          	ld	_sample,a
6748                     ; 1083 		if(sample_cnt==132)	{
6750  0cf7 be21          	ldw	x,_sample_cnt
6751  0cf9 a30084        	cpw	x,#132
6752  0cfc 2604          	jrne	L5223
6753                     ; 1084 			bBUFF_LOAD=1;
6755  0cfe 7210000b      	bset	_bBUFF_LOAD
6756  0d02               L5223:
6757                     ; 1088 		if(sample_cnt==5) {
6759  0d02 be21          	ldw	x,_sample_cnt
6760  0d04 a30005        	cpw	x,#5
6761  0d07 2604          	jrne	L7223
6762                     ; 1089 			bBUFF_READ_H=1;
6764  0d09 7210000a      	bset	_bBUFF_READ_H
6765  0d0d               L7223:
6766                     ; 1092 		if(sample_cnt==150) {
6768  0d0d be21          	ldw	x,_sample_cnt
6769  0d0f a30096        	cpw	x,#150
6770  0d12 2615          	jrne	L3323
6771                     ; 1093 			bBUFF_READ_L=1;
6773  0d14 72100009      	bset	_bBUFF_READ_L
6774  0d18 200f          	jra	L3323
6775  0d1a               L1223:
6776                     ; 1100 	else if(!bSTART) {
6778                     	btst	_bSTART
6779  0d1f 2508          	jrult	L3323
6780                     ; 1101 		TIM2->CCR3H= 0x00;	
6782  0d21 725f5315      	clr	21269
6783                     ; 1102 		TIM2->CCR3L= 0x7f;//pwm_fade_in;
6785  0d25 357f5316      	mov	21270,#127
6786  0d29               L3323:
6787                     ; 1159 		if(but_block_cnt)but_on_drv_cnt=0;
6789  0d29 be00          	ldw	x,_but_block_cnt
6790  0d2b 2702          	jreq	L7323
6793  0d2d 3fb9          	clr	_but_on_drv_cnt
6794  0d2f               L7323:
6795                     ; 1160 		if((((GPIOC->IDR)&(1<<4))) && (but_on_drv_cnt<100)) {
6797  0d2f c6500b        	ld	a,20491
6798  0d32 a510          	bcp	a,#16
6799  0d34 271f          	jreq	L1423
6801  0d36 b6b9          	ld	a,_but_on_drv_cnt
6802  0d38 a164          	cp	a,#100
6803  0d3a 2419          	jruge	L1423
6804                     ; 1161 			but_on_drv_cnt++;
6806  0d3c 3cb9          	inc	_but_on_drv_cnt
6807                     ; 1162 			if((but_on_drv_cnt>2)&&(bRELEASE))
6809  0d3e b6b9          	ld	a,_but_on_drv_cnt
6810  0d40 a103          	cp	a,#3
6811  0d42 2517          	jrult	L5423
6813                     	btst	_bRELEASE
6814  0d49 2410          	jruge	L5423
6815                     ; 1164 				bRELEASE=0;
6817  0d4b 72110000      	bres	_bRELEASE
6818                     ; 1165 				bSTART=1;
6820  0d4f 7210000c      	bset	_bSTART
6821  0d53 2006          	jra	L5423
6822  0d55               L1423:
6823                     ; 1169 			but_on_drv_cnt=0;
6825  0d55 3fb9          	clr	_but_on_drv_cnt
6826                     ; 1170 			bRELEASE=1;
6828  0d57 72100000      	bset	_bRELEASE
6829  0d5b               L5423:
6830                     ; 1175 	if(++t0_cnt0>=125){
6832  0d5b 3c00          	inc	_t0_cnt0
6833  0d5d b600          	ld	a,_t0_cnt0
6834  0d5f a17d          	cp	a,#125
6835  0d61 2530          	jrult	L7423
6836                     ; 1176     		t0_cnt0=0;
6838  0d63 3f00          	clr	_t0_cnt0
6839                     ; 1177     		b100Hz=1;
6841  0d65 72100008      	bset	_b100Hz
6842                     ; 1183 		if(++t0_cnt1>=10){
6844  0d69 3c01          	inc	_t0_cnt1
6845  0d6b b601          	ld	a,_t0_cnt1
6846  0d6d a10a          	cp	a,#10
6847  0d6f 2506          	jrult	L1523
6848                     ; 1184 			t0_cnt1=0;
6850  0d71 3f01          	clr	_t0_cnt1
6851                     ; 1185 			b10Hz=1;
6853  0d73 72100007      	bset	_b10Hz
6854  0d77               L1523:
6855                     ; 1188 		if(++t0_cnt2>=20){
6857  0d77 3c02          	inc	_t0_cnt2
6858  0d79 b602          	ld	a,_t0_cnt2
6859  0d7b a114          	cp	a,#20
6860  0d7d 2506          	jrult	L3523
6861                     ; 1189 			t0_cnt2=0;
6863  0d7f 3f02          	clr	_t0_cnt2
6864                     ; 1190 			b5Hz=1;
6866  0d81 72100006      	bset	_b5Hz
6867  0d85               L3523:
6868                     ; 1193 		if(++t0_cnt3>=100){
6870  0d85 3c03          	inc	_t0_cnt3
6871  0d87 b603          	ld	a,_t0_cnt3
6872  0d89 a164          	cp	a,#100
6873  0d8b 2506          	jrult	L7423
6874                     ; 1194 			t0_cnt3=0;
6876  0d8d 3f03          	clr	_t0_cnt3
6877                     ; 1195 			b1Hz=1;
6879  0d8f 72100005      	bset	_b1Hz
6880  0d93               L7423:
6881                     ; 1199 	TIM4->SR1&=~TIM4_SR1_UIF;			// disable break interrupt
6883  0d93 72115344      	bres	21316,#0
6884                     ; 1200 	return;
6887  0d97 80            	iret
6913                     ; 1204 @far @interrupt void UARTTxInterrupt (void) {
6914                     	switch	.text
6915  0d98               f_UARTTxInterrupt:
6919                     ; 1206 	if (tx_counter){
6921  0d98 3d20          	tnz	_tx_counter
6922  0d9a 271a          	jreq	L7623
6923                     ; 1207 		--tx_counter;
6925  0d9c 3a20          	dec	_tx_counter
6926                     ; 1208 		UART1->DR=tx_buffer[tx_rd_index];
6928  0d9e 5f            	clrw	x
6929  0d9f b61e          	ld	a,_tx_rd_index
6930  0da1 2a01          	jrpl	L061
6931  0da3 53            	cplw	x
6932  0da4               L061:
6933  0da4 97            	ld	xl,a
6934  0da5 e604          	ld	a,(_tx_buffer,x)
6935  0da7 c75231        	ld	21041,a
6936                     ; 1209 		if (++tx_rd_index == TX_BUFFER_SIZE) tx_rd_index=0;
6938  0daa 3c1e          	inc	_tx_rd_index
6939  0dac b61e          	ld	a,_tx_rd_index
6940  0dae a150          	cp	a,#80
6941  0db0 260c          	jrne	L3723
6944  0db2 3f1e          	clr	_tx_rd_index
6945  0db4 2008          	jra	L3723
6946  0db6               L7623:
6947                     ; 1212 		bOUT_FREE=1;
6949  0db6 72100003      	bset	_bOUT_FREE
6950                     ; 1213 		UART1->CR2&= ~UART1_CR2_TIEN;
6952  0dba 721f5235      	bres	21045,#7
6953  0dbe               L3723:
6954                     ; 1215 }
6957  0dbe 80            	iret
6986                     ; 1218 @far @interrupt void UARTRxInterrupt (void) {
6987                     	switch	.text
6988  0dbf               f_UARTRxInterrupt:
6992                     ; 1223 	rx_status=UART1->SR;
6994  0dbf 5552300006    	mov	_rx_status,21040
6995                     ; 1224 	rx_data=UART1->DR;
6997  0dc4 5552310005    	mov	_rx_data,21041
6998                     ; 1226 	if (rx_status & (UART1_SR_RXNE)){
7000  0dc9 b606          	ld	a,_rx_status
7001  0dcb a520          	bcp	a,#32
7002  0dcd 272c          	jreq	L5033
7003                     ; 1227 		rx_buffer[rx_wr_index]=rx_data;
7005  0dcf be1a          	ldw	x,_rx_wr_index
7006  0dd1 b605          	ld	a,_rx_data
7007  0dd3 e754          	ld	(_rx_buffer,x),a
7008                     ; 1228 		bRXIN=1;
7010  0dd5 72100002      	bset	_bRXIN
7011                     ; 1229 		if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
7013  0dd9 be1a          	ldw	x,_rx_wr_index
7014  0ddb 1c0001        	addw	x,#1
7015  0dde bf1a          	ldw	_rx_wr_index,x
7016  0de0 a30064        	cpw	x,#100
7017  0de3 2603          	jrne	L7033
7020  0de5 5f            	clrw	x
7021  0de6 bf1a          	ldw	_rx_wr_index,x
7022  0de8               L7033:
7023                     ; 1230 		if (++rx_counter == RX_BUFFER_SIZE){
7025  0de8 be1c          	ldw	x,_rx_counter
7026  0dea 1c0001        	addw	x,#1
7027  0ded bf1c          	ldw	_rx_counter,x
7028  0def a30064        	cpw	x,#100
7029  0df2 2607          	jrne	L5033
7030                     ; 1231 			rx_counter=0;
7032  0df4 5f            	clrw	x
7033  0df5 bf1c          	ldw	_rx_counter,x
7034                     ; 1232 			rx_buffer_overflow=1;
7036  0df7 72100001      	bset	_rx_buffer_overflow
7037  0dfb               L5033:
7038                     ; 1235 }
7041  0dfb 80            	iret
7080                     ; 1241 main()
7080                     ; 1242 {
7082                     	switch	.text
7083  0dfc               _main:
7087                     ; 1243 CLK->CKDIVR=0;
7089  0dfc 725f50c6      	clr	20678
7090                     ; 1245 rele_cnt_index=0;
7092  0e00 3fbb          	clr	_rele_cnt_index
7093                     ; 1246 GPIOD->DDR&=~(1<<6);
7095  0e02 721d5011      	bres	20497,#6
7096                     ; 1247 GPIOD->CR1|=(1<<6);
7098  0e06 721c5012      	bset	20498,#6
7099                     ; 1248 GPIOD->CR2|=(1<<6);
7101  0e0a 721c5013      	bset	20499,#6
7102                     ; 1250 GPIOD->DDR|=(1<<5);
7104  0e0e 721a5011      	bset	20497,#5
7105                     ; 1251 GPIOD->CR1|=(1<<5);
7107  0e12 721a5012      	bset	20498,#5
7108                     ; 1252 GPIOD->CR2|=(1<<5);	
7110  0e16 721a5013      	bset	20499,#5
7111                     ; 1253 GPIOD->ODR|=(1<<5);
7113  0e1a 721a500f      	bset	20495,#5
7114                     ; 1255 delay_ms(10);
7116  0e1e ae000a        	ldw	x,#10
7117  0e21 cd0064        	call	_delay_ms
7119                     ; 1257 if(!(GPIOD->IDR&=(1<<6))) 
7121  0e24 c65010        	ld	a,20496
7122  0e27 a440          	and	a,#64
7123  0e29 c75010        	ld	20496,a
7124  0e2c 2606          	jrne	L3233
7125                     ; 1259 	rele_cnt_index=1;
7127  0e2e 350100bb      	mov	_rele_cnt_index,#1
7129  0e32 2018          	jra	L5233
7130  0e34               L3233:
7131                     ; 1263 	GPIOD->ODR&=~(1<<5);
7133  0e34 721b500f      	bres	20495,#5
7134                     ; 1264 	delay_ms(10);
7136  0e38 ae000a        	ldw	x,#10
7137  0e3b cd0064        	call	_delay_ms
7139                     ; 1265 	if(!(GPIOD->IDR&=(1<<6)))
7141  0e3e c65010        	ld	a,20496
7142  0e41 a440          	and	a,#64
7143  0e43 c75010        	ld	20496,a
7144  0e46 2604          	jrne	L5233
7145                     ; 1267 		rele_cnt_index=2;
7147  0e48 350200bb      	mov	_rele_cnt_index,#2
7148  0e4c               L5233:
7149                     ; 1272 gpio_init();
7151  0e4c cd0b87        	call	_gpio_init
7153                     ; 1273 delay_ms(100);
7155  0e4f ae0064        	ldw	x,#100
7156  0e52 cd0064        	call	_delay_ms
7158                     ; 1274 delay_ms(100);
7160  0e55 ae0064        	ldw	x,#100
7161  0e58 cd0064        	call	_delay_ms
7163                     ; 1275 delay_ms(100);
7165  0e5b ae0064        	ldw	x,#100
7166  0e5e cd0064        	call	_delay_ms
7168                     ; 1278 t4_init();
7170  0e61 cd0039        	call	_t4_init
7172                     ; 1280 t2_init();
7174  0e64 cd0000        	call	_t2_init
7176                     ; 1281 spi_init();
7178  0e67 cd089f        	call	_spi_init
7180                     ; 1283 FLASH_DUKR=0xae;
7182  0e6a 35ae5064      	mov	_FLASH_DUKR,#174
7183                     ; 1284 FLASH_DUKR=0x56;
7185  0e6e 35565064      	mov	_FLASH_DUKR,#86
7186                     ; 1288 enableInterrupts();	
7189  0e72 9a            rim
7191  0e73               L1333:
7192                     ; 1292 if(b100Hz)
7194                     	btst	_b100Hz
7195  0e78 2433          	jruge	L5333
7196                     ; 1294 	b100Hz=0;
7198  0e7a 72110008      	bres	_b100Hz
7199                     ; 1296 	if(but_block_cnt)but_block_cnt--;
7201  0e7e be00          	ldw	x,_but_block_cnt
7202  0e80 2707          	jreq	L7333
7205  0e82 be00          	ldw	x,_but_block_cnt
7206  0e84 1d0001        	subw	x,#1
7207  0e87 bf00          	ldw	_but_block_cnt,x
7208  0e89               L7333:
7209                     ; 1298 	if(bSTART==1) 
7211                     	btst	_bSTART
7212  0e8e 241d          	jruge	L5333
7213                     ; 1300 		if(!play) 
7215                     	btst	_play
7216  0e95 2512          	jrult	L3433
7217                     ; 1302 			if(!but_block_cnt)
7219  0e97 be00          	ldw	x,_but_block_cnt
7220  0e99 260e          	jrne	L3433
7221                     ; 1304 				play=1;
7223  0e9b 72100004      	bset	_play
7224                     ; 1305 				rele_cnt=150;
7226  0e9f ae0096        	ldw	x,#150
7227  0ea2 bf03          	ldw	_rele_cnt,x
7228                     ; 1306 				but_block_cnt=50;
7230  0ea4 ae0032        	ldw	x,#50
7231  0ea7 bf00          	ldw	_but_block_cnt,x
7232  0ea9               L3433:
7233                     ; 1309 		bSTART=0;
7235  0ea9 7211000c      	bres	_bSTART
7236  0ead               L5333:
7237                     ; 1312 if(b10Hz)
7239                     	btst	_b10Hz
7240  0eb2 2407          	jruge	L7433
7241                     ; 1314 	b10Hz=0;
7243  0eb4 72110007      	bres	_b10Hz
7244                     ; 1316 	rele_drv();
7246  0eb8 cd004a        	call	_rele_drv
7248  0ebb               L7433:
7249                     ; 1319 if(b5Hz)
7251                     	btst	_b5Hz
7252  0ec0 2404          	jruge	L1533
7253                     ; 1321 	b5Hz=0;
7255  0ec2 72110006      	bres	_b5Hz
7256  0ec6               L1533:
7257                     ; 1324 if(b1Hz)
7259                     	btst	_b1Hz
7260  0ecb 24a6          	jruge	L1333
7261                     ; 1327 	b1Hz=0;
7263  0ecd 72110005      	bres	_b1Hz
7264  0ed1 20a0          	jra	L1333
7760                     	xdef	_main
7761                     .eeprom:	section	.data
7762  0000               _EE_PAGE_LEN:
7763  0000 0000          	ds.b	2
7764                     	xdef	_EE_PAGE_LEN
7765                     	switch	.bss
7766  0000               _UIB:
7767  0000 000000000000  	ds.b	80
7768                     	xdef	_UIB
7769  0050               _buff:
7770  0050 000000000000  	ds.b	300
7771                     	xdef	_buff
7772  017c               _dumm:
7773  017c 000000000000  	ds.b	100
7774                     	xdef	_dumm
7775                     .bit:	section	.data,bit
7776  0000               _bRELEASE:
7777  0000 00            	ds.b	1
7778                     	xdef	_bRELEASE
7779  0001               _rx_buffer_overflow:
7780  0001 00            	ds.b	1
7781                     	xdef	_rx_buffer_overflow
7782  0002               _bRXIN:
7783  0002 00            	ds.b	1
7784                     	xdef	_bRXIN
7785  0003               _bOUT_FREE:
7786  0003 00            	ds.b	1
7787                     	xdef	_bOUT_FREE
7788  0004               _play:
7789  0004 00            	ds.b	1
7790                     	xdef	_play
7791  0005               _b1Hz:
7792  0005 00            	ds.b	1
7793                     	xdef	_b1Hz
7794  0006               _b5Hz:
7795  0006 00            	ds.b	1
7796                     	xdef	_b5Hz
7797  0007               _b10Hz:
7798  0007 00            	ds.b	1
7799                     	xdef	_b10Hz
7800  0008               _b100Hz:
7801  0008 00            	ds.b	1
7802                     	xdef	_b100Hz
7803  0009               _bBUFF_READ_L:
7804  0009 00            	ds.b	1
7805                     	xdef	_bBUFF_READ_L
7806  000a               _bBUFF_READ_H:
7807  000a 00            	ds.b	1
7808                     	xdef	_bBUFF_READ_H
7809  000b               _bBUFF_LOAD:
7810  000b 00            	ds.b	1
7811                     	xdef	_bBUFF_LOAD
7812  000c               _bSTART:
7813  000c 00            	ds.b	1
7814                     	xdef	_bSTART
7815                     	switch	.ubsct
7816  0000               _but_block_cnt:
7817  0000 0000          	ds.b	2
7818                     	xdef	_but_block_cnt
7819                     	xdef	_memory_manufacturer
7820                     	xdef	_rele_cnt_const
7821                     	xdef	_rele_cnt_index
7822                     	xdef	_pwm_fade_in
7823  0002               _rx_offset:
7824  0002 00            	ds.b	1
7825                     	xdef	_rx_offset
7826  0003               _rele_cnt:
7827  0003 0000          	ds.b	2
7828                     	xdef	_rele_cnt
7829  0005               _rx_data:
7830  0005 00            	ds.b	1
7831                     	xdef	_rx_data
7832  0006               _rx_status:
7833  0006 00            	ds.b	1
7834                     	xdef	_rx_status
7835  0007               _file_lengt:
7836  0007 00000000      	ds.b	4
7837                     	xdef	_file_lengt
7838  000b               _current_byte_in_buffer:
7839  000b 0000          	ds.b	2
7840                     	xdef	_current_byte_in_buffer
7841  000d               _last_page:
7842  000d 0000          	ds.b	2
7843                     	xdef	_last_page
7844  000f               _current_page:
7845  000f 0000          	ds.b	2
7846                     	xdef	_current_page
7847  0011               _file_lengt_in_pages:
7848  0011 0000          	ds.b	2
7849                     	xdef	_file_lengt_in_pages
7850  0013               _mdr3:
7851  0013 00            	ds.b	1
7852                     	xdef	_mdr3
7853  0014               _mdr2:
7854  0014 00            	ds.b	1
7855                     	xdef	_mdr2
7856  0015               _mdr1:
7857  0015 00            	ds.b	1
7858                     	xdef	_mdr1
7859  0016               _mdr0:
7860  0016 00            	ds.b	1
7861                     	xdef	_mdr0
7862                     	xdef	_but_on_drv_cnt
7863                     	xdef	_but_drv_cnt
7864  0017               _sample:
7865  0017 00            	ds.b	1
7866                     	xdef	_sample
7867  0018               _rx_rd_index:
7868  0018 0000          	ds.b	2
7869                     	xdef	_rx_rd_index
7870  001a               _rx_wr_index:
7871  001a 0000          	ds.b	2
7872                     	xdef	_rx_wr_index
7873  001c               _rx_counter:
7874  001c 0000          	ds.b	2
7875                     	xdef	_rx_counter
7876                     	xdef	_rx_buffer
7877  001e               _tx_rd_index:
7878  001e 00            	ds.b	1
7879                     	xdef	_tx_rd_index
7880  001f               _tx_wr_index:
7881  001f 00            	ds.b	1
7882                     	xdef	_tx_wr_index
7883  0020               _tx_counter:
7884  0020 00            	ds.b	1
7885                     	xdef	_tx_counter
7886                     	xdef	_tx_buffer
7887  0021               _sample_cnt:
7888  0021 0000          	ds.b	2
7889                     	xdef	_sample_cnt
7890                     	xdef	_t0_cnt3
7891                     	xdef	_t0_cnt2
7892                     	xdef	_t0_cnt1
7893                     	xdef	_t0_cnt0
7894                     	xdef	_ST_PAGE_ERASE
7895                     	xdef	_ST_BULK_ERASE
7896                     	xdef	_ST_READ
7897                     	xdef	_ST_WRITE
7898                     	xdef	_ST_WREN
7899                     	xdef	_ST_status_read
7900                     	xdef	_ST_RDID_read
7901                     	xdef	_uart_in_an
7902                     	xdef	_control_check
7903                     	xdef	_index_offset
7904                     	xdef	_uart_in
7905                     	xdef	_gpio_init
7906                     	xdef	_spi_init
7907                     	xdef	_spi
7908                     	xdef	_DF_buffer_to_page_er
7909                     	xdef	_DF_page_to_buffer
7910                     	xdef	_DF_buffer_write
7911                     	xdef	_DF_buffer_read
7912                     	xdef	_DF_status_read
7913                     	xdef	_DF_memo_to_256
7914                     	xdef	_DF_mf_dev_read
7915                     	xdef	_uart_init
7916                     	xdef	f_UARTRxInterrupt
7917                     	xdef	f_UARTTxInterrupt
7918                     	xdef	_putchar
7919                     	xdef	_uart_out_adr_block
7920                     	xdef	_uart_out
7921                     	xdef	f_TIM4_UPD_Interrupt
7922                     	xdef	_delay_ms
7923                     	xdef	_rele_drv
7924                     	xdef	_t4_init
7925                     	xdef	_t2_init
7926                     	xref.b	c_lreg
7927                     	xref.b	c_x
7928                     	xref.b	c_y
7948                     	xref	c_itolx
7949                     	xref	c_umul
7950                     	xref	c_eewrw
7951                     	xref	c_lglsh
7952                     	xref	c_uitolx
7953                     	xref	c_lgursh
7954                     	xref	c_lcmp
7955                     	xref	c_ltor
7956                     	xref	c_lgadc
7957                     	xref	c_rtol
7958                     	xref	c_vmul
7959                     	end
