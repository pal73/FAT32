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
2360  004a be03          	ldw	x,_rele_cnt
2361  004c 270d          	jreq	L1641
2362                     ; 94 		rele_cnt--;
2364  004e be03          	ldw	x,_rele_cnt
2365  0050 1d0001        	subw	x,#1
2366  0053 bf03          	ldw	_rele_cnt,x
2367                     ; 95 		GPIOD->ODR|=(1<<4);
2369  0055 7218500f      	bset	20495,#4
2371  0059 2004          	jra	L3641
2372  005b               L1641:
2373                     ; 97 	else GPIOD->ODR&=~(1<<4); 
2375  005b 7219500f      	bres	20495,#4
2376  005f               L3641:
2377                     ; 105 }
2380  005f 81            	ret
2441                     ; 108 long delay_ms(short in)
2441                     ; 109 {
2442                     	switch	.text
2443  0060               _delay_ms:
2445  0060 520c          	subw	sp,#12
2446       0000000c      OFST:	set	12
2449                     ; 112 i=((long)in)*100UL;
2451  0062 90ae0064      	ldw	y,#100
2452  0066 cd0000        	call	c_vmul
2454  0069 96            	ldw	x,sp
2455  006a 1c0005        	addw	x,#OFST-7
2456  006d cd0000        	call	c_rtol
2458                     ; 114 for(ii=0;ii<i;ii++)
2460  0070 ae0000        	ldw	x,#0
2461  0073 1f0b          	ldw	(OFST-1,sp),x
2462  0075 ae0000        	ldw	x,#0
2463  0078 1f09          	ldw	(OFST-3,sp),x
2465  007a 2012          	jra	L3251
2466  007c               L7151:
2467                     ; 116 		iii++;
2469  007c 96            	ldw	x,sp
2470  007d 1c0001        	addw	x,#OFST-11
2471  0080 a601          	ld	a,#1
2472  0082 cd0000        	call	c_lgadc
2474                     ; 114 for(ii=0;ii<i;ii++)
2476  0085 96            	ldw	x,sp
2477  0086 1c0009        	addw	x,#OFST-3
2478  0089 a601          	ld	a,#1
2479  008b cd0000        	call	c_lgadc
2481  008e               L3251:
2484  008e 9c            	rvf
2485  008f 96            	ldw	x,sp
2486  0090 1c0009        	addw	x,#OFST-3
2487  0093 cd0000        	call	c_ltor
2489  0096 96            	ldw	x,sp
2490  0097 1c0005        	addw	x,#OFST-7
2491  009a cd0000        	call	c_lcmp
2493  009d 2fdd          	jrslt	L7151
2494                     ; 119 }
2497  009f 5b0c          	addw	sp,#12
2498  00a1 81            	ret
2521                     ; 122 void uart_init (void){
2522                     	switch	.text
2523  00a2               _uart_init:
2527                     ; 123 	GPIOD->DDR|=(1<<5);
2529  00a2 721a5011      	bset	20497,#5
2530                     ; 124 	GPIOD->CR1|=(1<<5);
2532  00a6 721a5012      	bset	20498,#5
2533                     ; 125 	GPIOD->CR2|=(1<<5);
2535  00aa 721a5013      	bset	20499,#5
2536                     ; 128 	GPIOD->DDR&=~(1<<6);
2538  00ae 721d5011      	bres	20497,#6
2539                     ; 129 	GPIOD->CR1&=~(1<<6);
2541  00b2 721d5012      	bres	20498,#6
2542                     ; 130 	GPIOD->CR2&=~(1<<6);
2544  00b6 721d5013      	bres	20499,#6
2545                     ; 133 	UART1->CR1&=~UART1_CR1_M;					
2547  00ba 72195234      	bres	21044,#4
2548                     ; 134 	UART1->CR3|= (0<<4) & UART1_CR3_STOP;	
2550  00be c65236        	ld	a,21046
2551                     ; 135 	UART1->BRR2= 0x01;//0x03;
2553  00c1 35015233      	mov	21043,#1
2554                     ; 136 	UART1->BRR1= 0x1a;//0x68;
2556  00c5 351a5232      	mov	21042,#26
2557                     ; 137 	UART1->CR2|= UART1_CR2_TEN | UART3_CR2_REN | UART3_CR2_RIEN;	
2559  00c9 c65235        	ld	a,21045
2560  00cc aa2c          	or	a,#44
2561  00ce c75235        	ld	21045,a
2562                     ; 138 }
2565  00d1 81            	ret
2683                     ; 141 void uart_out (char num,char data0,char data1,char data2,char data3,char data4,char data5){
2684                     	switch	.text
2685  00d2               _uart_out:
2687  00d2 89            	pushw	x
2688  00d3 520c          	subw	sp,#12
2689       0000000c      OFST:	set	12
2692                     ; 142 	char i=0,t=0,UOB[10];
2696  00d5 0f01          	clr	(OFST-11,sp)
2697                     ; 145 	UOB[0]=data0;
2699  00d7 9f            	ld	a,xl
2700  00d8 6b02          	ld	(OFST-10,sp),a
2701                     ; 146 	UOB[1]=data1;
2703  00da 7b11          	ld	a,(OFST+5,sp)
2704  00dc 6b03          	ld	(OFST-9,sp),a
2705                     ; 147 	UOB[2]=data2;
2707  00de 7b12          	ld	a,(OFST+6,sp)
2708  00e0 6b04          	ld	(OFST-8,sp),a
2709                     ; 148 	UOB[3]=data3;
2711  00e2 7b13          	ld	a,(OFST+7,sp)
2712  00e4 6b05          	ld	(OFST-7,sp),a
2713                     ; 149 	UOB[4]=data4;
2715  00e6 7b14          	ld	a,(OFST+8,sp)
2716  00e8 6b06          	ld	(OFST-6,sp),a
2717                     ; 150 	UOB[5]=data5;
2719  00ea 7b15          	ld	a,(OFST+9,sp)
2720  00ec 6b07          	ld	(OFST-5,sp),a
2721                     ; 151 	for (i=0;i<num;i++)
2723  00ee 0f0c          	clr	(OFST+0,sp)
2725  00f0 2013          	jra	L5261
2726  00f2               L1261:
2727                     ; 153 		t^=UOB[i];
2729  00f2 96            	ldw	x,sp
2730  00f3 1c0002        	addw	x,#OFST-10
2731  00f6 9f            	ld	a,xl
2732  00f7 5e            	swapw	x
2733  00f8 1b0c          	add	a,(OFST+0,sp)
2734  00fa 2401          	jrnc	L02
2735  00fc 5c            	incw	x
2736  00fd               L02:
2737  00fd 02            	rlwa	x,a
2738  00fe 7b01          	ld	a,(OFST-11,sp)
2739  0100 f8            	xor	a,	(x)
2740  0101 6b01          	ld	(OFST-11,sp),a
2741                     ; 151 	for (i=0;i<num;i++)
2743  0103 0c0c          	inc	(OFST+0,sp)
2744  0105               L5261:
2747  0105 7b0c          	ld	a,(OFST+0,sp)
2748  0107 110d          	cp	a,(OFST+1,sp)
2749  0109 25e7          	jrult	L1261
2750                     ; 155 	UOB[num]=num;
2752  010b 96            	ldw	x,sp
2753  010c 1c0002        	addw	x,#OFST-10
2754  010f 9f            	ld	a,xl
2755  0110 5e            	swapw	x
2756  0111 1b0d          	add	a,(OFST+1,sp)
2757  0113 2401          	jrnc	L22
2758  0115 5c            	incw	x
2759  0116               L22:
2760  0116 02            	rlwa	x,a
2761  0117 7b0d          	ld	a,(OFST+1,sp)
2762  0119 f7            	ld	(x),a
2763                     ; 156 	t^=UOB[num];
2765  011a 96            	ldw	x,sp
2766  011b 1c0002        	addw	x,#OFST-10
2767  011e 9f            	ld	a,xl
2768  011f 5e            	swapw	x
2769  0120 1b0d          	add	a,(OFST+1,sp)
2770  0122 2401          	jrnc	L42
2771  0124 5c            	incw	x
2772  0125               L42:
2773  0125 02            	rlwa	x,a
2774  0126 7b01          	ld	a,(OFST-11,sp)
2775  0128 f8            	xor	a,	(x)
2776  0129 6b01          	ld	(OFST-11,sp),a
2777                     ; 157 	UOB[num+1]=t;
2779  012b 96            	ldw	x,sp
2780  012c 1c0003        	addw	x,#OFST-9
2781  012f 9f            	ld	a,xl
2782  0130 5e            	swapw	x
2783  0131 1b0d          	add	a,(OFST+1,sp)
2784  0133 2401          	jrnc	L62
2785  0135 5c            	incw	x
2786  0136               L62:
2787  0136 02            	rlwa	x,a
2788  0137 7b01          	ld	a,(OFST-11,sp)
2789  0139 f7            	ld	(x),a
2790                     ; 158 	UOB[num+2]=END;
2792  013a 96            	ldw	x,sp
2793  013b 1c0004        	addw	x,#OFST-8
2794  013e 9f            	ld	a,xl
2795  013f 5e            	swapw	x
2796  0140 1b0d          	add	a,(OFST+1,sp)
2797  0142 2401          	jrnc	L03
2798  0144 5c            	incw	x
2799  0145               L03:
2800  0145 02            	rlwa	x,a
2801  0146 a60a          	ld	a,#10
2802  0148 f7            	ld	(x),a
2803                     ; 162 	for (i=0;i<num+3;i++)
2805  0149 0f0c          	clr	(OFST+0,sp)
2807  014b 2012          	jra	L5361
2808  014d               L1361:
2809                     ; 164 		putchar(UOB[i]);
2811  014d 96            	ldw	x,sp
2812  014e 1c0002        	addw	x,#OFST-10
2813  0151 9f            	ld	a,xl
2814  0152 5e            	swapw	x
2815  0153 1b0c          	add	a,(OFST+0,sp)
2816  0155 2401          	jrnc	L23
2817  0157 5c            	incw	x
2818  0158               L23:
2819  0158 02            	rlwa	x,a
2820  0159 f6            	ld	a,(x)
2821  015a cd0841        	call	_putchar
2823                     ; 162 	for (i=0;i<num+3;i++)
2825  015d 0c0c          	inc	(OFST+0,sp)
2826  015f               L5361:
2829  015f 9c            	rvf
2830  0160 7b0c          	ld	a,(OFST+0,sp)
2831  0162 5f            	clrw	x
2832  0163 97            	ld	xl,a
2833  0164 7b0d          	ld	a,(OFST+1,sp)
2834  0166 905f          	clrw	y
2835  0168 9097          	ld	yl,a
2836  016a 72a90003      	addw	y,#3
2837  016e bf00          	ldw	c_x,x
2838  0170 90b300        	cpw	y,c_x
2839  0173 2cd8          	jrsgt	L1361
2840                     ; 167 	bOUT_FREE=0;	  	
2842  0175 72110003      	bres	_bOUT_FREE
2843                     ; 168 }
2846  0179 5b0e          	addw	sp,#14
2847  017b 81            	ret
2929                     ; 171 void uart_out_adr_block (unsigned long adress,char *ptr, char len)
2929                     ; 172 {
2930                     	switch	.text
2931  017c               _uart_out_adr_block:
2933  017c 5203          	subw	sp,#3
2934       00000003      OFST:	set	3
2937                     ; 176 t=0;
2939  017e 0f02          	clr	(OFST-1,sp)
2940                     ; 177 temp11=CMND;
2942                     ; 178 t^=temp11;
2944  0180 7b02          	ld	a,(OFST-1,sp)
2945  0182 a816          	xor	a,	#22
2946  0184 6b02          	ld	(OFST-1,sp),a
2947                     ; 179 putchar(temp11);
2949  0186 a616          	ld	a,#22
2950  0188 cd0841        	call	_putchar
2952                     ; 181 temp11=10;
2954                     ; 182 t^=temp11;
2956  018b 7b02          	ld	a,(OFST-1,sp)
2957  018d a80a          	xor	a,	#10
2958  018f 6b02          	ld	(OFST-1,sp),a
2959                     ; 183 putchar(temp11);
2961  0191 a60a          	ld	a,#10
2962  0193 cd0841        	call	_putchar
2964                     ; 185 temp11=adress%256;//(*((char*)&adress));
2966  0196 7b09          	ld	a,(OFST+6,sp)
2967  0198 a4ff          	and	a,#255
2968  019a 6b03          	ld	(OFST+0,sp),a
2969                     ; 186 t^=temp11;
2971  019c 7b02          	ld	a,(OFST-1,sp)
2972  019e 1803          	xor	a,	(OFST+0,sp)
2973  01a0 6b02          	ld	(OFST-1,sp),a
2974                     ; 187 putchar(temp11);
2976  01a2 7b03          	ld	a,(OFST+0,sp)
2977  01a4 cd0841        	call	_putchar
2979                     ; 188 adress>>=8;
2981  01a7 96            	ldw	x,sp
2982  01a8 1c0006        	addw	x,#OFST+3
2983  01ab a608          	ld	a,#8
2984  01ad cd0000        	call	c_lgursh
2986                     ; 189 temp11=adress%256;//(*(((char*)&adress)+1));
2988  01b0 7b09          	ld	a,(OFST+6,sp)
2989  01b2 a4ff          	and	a,#255
2990  01b4 6b03          	ld	(OFST+0,sp),a
2991                     ; 190 t^=temp11;
2993  01b6 7b02          	ld	a,(OFST-1,sp)
2994  01b8 1803          	xor	a,	(OFST+0,sp)
2995  01ba 6b02          	ld	(OFST-1,sp),a
2996                     ; 191 putchar(temp11);
2998  01bc 7b03          	ld	a,(OFST+0,sp)
2999  01be cd0841        	call	_putchar
3001                     ; 192 adress>>=8;
3003  01c1 96            	ldw	x,sp
3004  01c2 1c0006        	addw	x,#OFST+3
3005  01c5 a608          	ld	a,#8
3006  01c7 cd0000        	call	c_lgursh
3008                     ; 193 temp11=adress%256;//(*(((char*)&adress)+2));
3010  01ca 7b09          	ld	a,(OFST+6,sp)
3011  01cc a4ff          	and	a,#255
3012  01ce 6b03          	ld	(OFST+0,sp),a
3013                     ; 194 t^=temp11;
3015  01d0 7b02          	ld	a,(OFST-1,sp)
3016  01d2 1803          	xor	a,	(OFST+0,sp)
3017  01d4 6b02          	ld	(OFST-1,sp),a
3018                     ; 195 putchar(temp11);
3020  01d6 7b03          	ld	a,(OFST+0,sp)
3021  01d8 cd0841        	call	_putchar
3023                     ; 196 adress>>=8;
3025  01db 96            	ldw	x,sp
3026  01dc 1c0006        	addw	x,#OFST+3
3027  01df a608          	ld	a,#8
3028  01e1 cd0000        	call	c_lgursh
3030                     ; 197 temp11=adress%256;//(*(((char*)&adress)+3));
3032  01e4 7b09          	ld	a,(OFST+6,sp)
3033  01e6 a4ff          	and	a,#255
3034  01e8 6b03          	ld	(OFST+0,sp),a
3035                     ; 198 t^=temp11;
3037  01ea 7b02          	ld	a,(OFST-1,sp)
3038  01ec 1803          	xor	a,	(OFST+0,sp)
3039  01ee 6b02          	ld	(OFST-1,sp),a
3040                     ; 199 putchar(temp11);
3042  01f0 7b03          	ld	a,(OFST+0,sp)
3043  01f2 cd0841        	call	_putchar
3045                     ; 202 for(i11=0;i11<len;i11++)
3047  01f5 0f01          	clr	(OFST-2,sp)
3049  01f7 201b          	jra	L7071
3050  01f9               L3071:
3051                     ; 204 	temp11=ptr[i11];
3053  01f9 7b0a          	ld	a,(OFST+7,sp)
3054  01fb 97            	ld	xl,a
3055  01fc 7b0b          	ld	a,(OFST+8,sp)
3056  01fe 1b01          	add	a,(OFST-2,sp)
3057  0200 2401          	jrnc	L63
3058  0202 5c            	incw	x
3059  0203               L63:
3060  0203 02            	rlwa	x,a
3061  0204 f6            	ld	a,(x)
3062  0205 6b03          	ld	(OFST+0,sp),a
3063                     ; 205 	t^=temp11;
3065  0207 7b02          	ld	a,(OFST-1,sp)
3066  0209 1803          	xor	a,	(OFST+0,sp)
3067  020b 6b02          	ld	(OFST-1,sp),a
3068                     ; 206 	putchar(temp11);
3070  020d 7b03          	ld	a,(OFST+0,sp)
3071  020f cd0841        	call	_putchar
3073                     ; 202 for(i11=0;i11<len;i11++)
3075  0212 0c01          	inc	(OFST-2,sp)
3076  0214               L7071:
3079  0214 7b01          	ld	a,(OFST-2,sp)
3080  0216 110c          	cp	a,(OFST+9,sp)
3081  0218 25df          	jrult	L3071
3082                     ; 209 temp11=(len+6);
3084  021a 7b0c          	ld	a,(OFST+9,sp)
3085  021c ab06          	add	a,#6
3086  021e 6b03          	ld	(OFST+0,sp),a
3087                     ; 210 t^=temp11;
3089  0220 7b02          	ld	a,(OFST-1,sp)
3090  0222 1803          	xor	a,	(OFST+0,sp)
3091  0224 6b02          	ld	(OFST-1,sp),a
3092                     ; 211 putchar(temp11);
3094  0226 7b03          	ld	a,(OFST+0,sp)
3095  0228 cd0841        	call	_putchar
3097                     ; 213 putchar(t);
3099  022b 7b02          	ld	a,(OFST-1,sp)
3100  022d cd0841        	call	_putchar
3102                     ; 215 putchar(0x0a);
3104  0230 a60a          	ld	a,#10
3105  0232 cd0841        	call	_putchar
3107                     ; 217 bOUT_FREE=0;	   
3109  0235 72110003      	bres	_bOUT_FREE
3110                     ; 218 }
3113  0239 5b03          	addw	sp,#3
3114  023b 81            	ret
3248                     ; 220 void uart_in_an(void) {
3249                     	switch	.text
3250  023c               _uart_in_an:
3252  023c 5204          	subw	sp,#4
3253       00000004      OFST:	set	4
3256                     ; 223 	if(UIB[0]==CMND) {
3258  023e c60000        	ld	a,_UIB
3259  0241 a116          	cp	a,#22
3260  0243 2703          	jreq	L24
3261  0245 cc083e        	jp	L1771
3262  0248               L24:
3263                     ; 224 		if(UIB[1]==1) {
3265  0248 c60001        	ld	a,_UIB+1
3266  024b a101          	cp	a,#1
3267  024d 262f          	jrne	L3771
3268                     ; 228 			if(memory_manufacturer=='A') {
3270  024f b6bc          	ld	a,_memory_manufacturer
3271  0251 a141          	cp	a,#65
3272  0253 2603          	jrne	L5771
3273                     ; 229 				temp_L=DF_mf_dev_read();
3275  0255 cd09ed        	call	_DF_mf_dev_read
3277  0258               L5771:
3278                     ; 231 			if(memory_manufacturer=='S') {
3280  0258 b6bc          	ld	a,_memory_manufacturer
3281  025a a153          	cp	a,#83
3282  025c 2603          	jrne	L7771
3283                     ; 232 				temp_L=ST_RDID_read();
3285  025e cd0902        	call	_ST_RDID_read
3287  0261               L7771:
3288                     ; 234 			uart_out (6,CMND,1,mdr0/**((char*)&temp_L)*/,mdr1/**(((char*)&temp_L)+1)*/,mdr2/**(((char*)&temp_L)+2)*/,mdr3/**(((char*)&temp_L)+3)*/);
3290  0261 3b0013        	push	_mdr3
3291  0264 3b0014        	push	_mdr2
3292  0267 3b0015        	push	_mdr1
3293  026a 3b0016        	push	_mdr0
3294  026d 4b01          	push	#1
3295  026f ae0016        	ldw	x,#22
3296  0272 a606          	ld	a,#6
3297  0274 95            	ld	xh,a
3298  0275 cd00d2        	call	_uart_out
3300  0278 5b05          	addw	sp,#5
3302  027a ac3e083e      	jpf	L1771
3303  027e               L3771:
3304                     ; 241 	else if(UIB[1]==2) {
3306  027e c60001        	ld	a,_UIB+1
3307  0281 a102          	cp	a,#2
3308  0283 2630          	jrne	L3002
3309                     ; 244 		if(memory_manufacturer=='A') {
3311  0285 b6bc          	ld	a,_memory_manufacturer
3312  0287 a141          	cp	a,#65
3313  0289 2605          	jrne	L5002
3314                     ; 245 			temp=DF_status_read();
3316  028b cd0a41        	call	_DF_status_read
3318  028e 6b04          	ld	(OFST+0,sp),a
3319  0290               L5002:
3320                     ; 247 		if(memory_manufacturer=='S') {
3322  0290 b6bc          	ld	a,_memory_manufacturer
3323  0292 a153          	cp	a,#83
3324  0294 2605          	jrne	L7002
3325                     ; 248 			temp=ST_status_read();
3327  0296 cd092e        	call	_ST_status_read
3329  0299 6b04          	ld	(OFST+0,sp),a
3330  029b               L7002:
3331                     ; 250 		uart_out (3,CMND,2,temp,0,0,0);    
3333  029b 4b00          	push	#0
3334  029d 4b00          	push	#0
3335  029f 4b00          	push	#0
3336  02a1 7b07          	ld	a,(OFST+3,sp)
3337  02a3 88            	push	a
3338  02a4 4b02          	push	#2
3339  02a6 ae0016        	ldw	x,#22
3340  02a9 a603          	ld	a,#3
3341  02ab 95            	ld	xh,a
3342  02ac cd00d2        	call	_uart_out
3344  02af 5b05          	addw	sp,#5
3346  02b1 ac3e083e      	jpf	L1771
3347  02b5               L3002:
3348                     ; 254 	else if(UIB[1]==3)
3350  02b5 c60001        	ld	a,_UIB+1
3351  02b8 a103          	cp	a,#3
3352  02ba 2623          	jrne	L3102
3353                     ; 257 		if(memory_manufacturer=='A') {
3355  02bc b6bc          	ld	a,_memory_manufacturer
3356  02be a141          	cp	a,#65
3357  02c0 2603          	jrne	L5102
3358                     ; 258 			DF_memo_to_256();
3360  02c2 cd0a24        	call	_DF_memo_to_256
3362  02c5               L5102:
3363                     ; 260 		uart_out (2,CMND,3,temp,0,0,0);    
3365  02c5 4b00          	push	#0
3366  02c7 4b00          	push	#0
3367  02c9 4b00          	push	#0
3368  02cb 7b07          	ld	a,(OFST+3,sp)
3369  02cd 88            	push	a
3370  02ce 4b03          	push	#3
3371  02d0 ae0016        	ldw	x,#22
3372  02d3 a602          	ld	a,#2
3373  02d5 95            	ld	xh,a
3374  02d6 cd00d2        	call	_uart_out
3376  02d9 5b05          	addw	sp,#5
3378  02db ac3e083e      	jpf	L1771
3379  02df               L3102:
3380                     ; 263 	else if(UIB[1]==4)
3382  02df c60001        	ld	a,_UIB+1
3383  02e2 a104          	cp	a,#4
3384  02e4 2623          	jrne	L1202
3385                     ; 266 		if(memory_manufacturer=='A') {
3387  02e6 b6bc          	ld	a,_memory_manufacturer
3388  02e8 a141          	cp	a,#65
3389  02ea 2603          	jrne	L3202
3390                     ; 267 			DF_memo_to_256();
3392  02ec cd0a24        	call	_DF_memo_to_256
3394  02ef               L3202:
3395                     ; 269 		uart_out (2,CMND,3,temp,0,0,0);    
3397  02ef 4b00          	push	#0
3398  02f1 4b00          	push	#0
3399  02f3 4b00          	push	#0
3400  02f5 7b07          	ld	a,(OFST+3,sp)
3401  02f7 88            	push	a
3402  02f8 4b03          	push	#3
3403  02fa ae0016        	ldw	x,#22
3404  02fd a602          	ld	a,#2
3405  02ff 95            	ld	xh,a
3406  0300 cd00d2        	call	_uart_out
3408  0303 5b05          	addw	sp,#5
3410  0305 ac3e083e      	jpf	L1771
3411  0309               L1202:
3412                     ; 272 	else if(UIB[1]==10)
3414  0309 c60001        	ld	a,_UIB+1
3415  030c a10a          	cp	a,#10
3416  030e 2703cc0396    	jrne	L7202
3417                     ; 276 		if(memory_manufacturer=='A') {
3419  0313 b6bc          	ld	a,_memory_manufacturer
3420  0315 a141          	cp	a,#65
3421  0317 2615          	jrne	L1302
3422                     ; 277 			if(UIB[2]==1)DF_buffer_read(/*1,*/0,256, buff);
3424  0319 c60002        	ld	a,_UIB+2
3425  031c a101          	cp	a,#1
3426  031e 260e          	jrne	L1302
3429  0320 ae0050        	ldw	x,#_buff
3430  0323 89            	pushw	x
3431  0324 ae0100        	ldw	x,#256
3432  0327 89            	pushw	x
3433  0328 5f            	clrw	x
3434  0329 cd0aa1        	call	_DF_buffer_read
3436  032c 5b04          	addw	sp,#4
3437  032e               L1302:
3438                     ; 282 		uart_out_adr_block (0,buff,64);
3440  032e 4b40          	push	#64
3441  0330 ae0050        	ldw	x,#_buff
3442  0333 89            	pushw	x
3443  0334 ae0000        	ldw	x,#0
3444  0337 89            	pushw	x
3445  0338 ae0000        	ldw	x,#0
3446  033b 89            	pushw	x
3447  033c cd017c        	call	_uart_out_adr_block
3449  033f 5b07          	addw	sp,#7
3450                     ; 283 		delay_ms(100);    
3452  0341 ae0064        	ldw	x,#100
3453  0344 cd0060        	call	_delay_ms
3455                     ; 284 		uart_out_adr_block (64,&buff[64],64);
3457  0347 4b40          	push	#64
3458  0349 ae0090        	ldw	x,#_buff+64
3459  034c 89            	pushw	x
3460  034d ae0040        	ldw	x,#64
3461  0350 89            	pushw	x
3462  0351 ae0000        	ldw	x,#0
3463  0354 89            	pushw	x
3464  0355 cd017c        	call	_uart_out_adr_block
3466  0358 5b07          	addw	sp,#7
3467                     ; 285 		delay_ms(100);    
3469  035a ae0064        	ldw	x,#100
3470  035d cd0060        	call	_delay_ms
3472                     ; 286 		uart_out_adr_block (128,&buff[128],64);
3474  0360 4b40          	push	#64
3475  0362 ae00d0        	ldw	x,#_buff+128
3476  0365 89            	pushw	x
3477  0366 ae0080        	ldw	x,#128
3478  0369 89            	pushw	x
3479  036a ae0000        	ldw	x,#0
3480  036d 89            	pushw	x
3481  036e cd017c        	call	_uart_out_adr_block
3483  0371 5b07          	addw	sp,#7
3484                     ; 287 		delay_ms(100);    
3486  0373 ae0064        	ldw	x,#100
3487  0376 cd0060        	call	_delay_ms
3489                     ; 288 		uart_out_adr_block (192,&buff[192],64);
3491  0379 4b40          	push	#64
3492  037b ae0110        	ldw	x,#_buff+192
3493  037e 89            	pushw	x
3494  037f ae00c0        	ldw	x,#192
3495  0382 89            	pushw	x
3496  0383 ae0000        	ldw	x,#0
3497  0386 89            	pushw	x
3498  0387 cd017c        	call	_uart_out_adr_block
3500  038a 5b07          	addw	sp,#7
3501                     ; 289 		delay_ms(100);    
3503  038c ae0064        	ldw	x,#100
3504  038f cd0060        	call	_delay_ms
3507  0392 ac3e083e      	jpf	L1771
3508  0396               L7202:
3509                     ; 292 	else if(UIB[1]==11)
3511  0396 c60001        	ld	a,_UIB+1
3512  0399 a10b          	cp	a,#11
3513  039b 2633          	jrne	L7302
3514                     ; 298 		for(i=0;i<256;i++)buff[i]=0;
3516  039d 5f            	clrw	x
3517  039e 1f03          	ldw	(OFST-1,sp),x
3518  03a0               L1402:
3521  03a0 1e03          	ldw	x,(OFST-1,sp)
3522  03a2 724f0050      	clr	(_buff,x)
3525  03a6 1e03          	ldw	x,(OFST-1,sp)
3526  03a8 1c0001        	addw	x,#1
3527  03ab 1f03          	ldw	(OFST-1,sp),x
3530  03ad 1e03          	ldw	x,(OFST-1,sp)
3531  03af a30100        	cpw	x,#256
3532  03b2 25ec          	jrult	L1402
3533                     ; 300 		if(UIB[2]==1)DF_buffer_write(/*1,*/0,256, buff);
3535  03b4 c60002        	ld	a,_UIB+2
3536  03b7 a101          	cp	a,#1
3537  03b9 2703          	jreq	L44
3538  03bb cc083e        	jp	L1771
3539  03be               L44:
3542  03be ae0050        	ldw	x,#_buff
3543  03c1 89            	pushw	x
3544  03c2 ae0100        	ldw	x,#256
3545  03c5 89            	pushw	x
3546  03c6 5f            	clrw	x
3547  03c7 cd0ae7        	call	_DF_buffer_write
3549  03ca 5b04          	addw	sp,#4
3550  03cc ac3e083e      	jpf	L1771
3551  03d0               L7302:
3552                     ; 304 	else if(UIB[1]==12)
3554  03d0 c60001        	ld	a,_UIB+1
3555  03d3 a10c          	cp	a,#12
3556  03d5 2703          	jreq	L64
3557  03d7 cc04b6        	jp	L3502
3558  03da               L64:
3559                     ; 310 		for(i=0;i<256;i++)buff[i]=0;
3561  03da 5f            	clrw	x
3562  03db 1f03          	ldw	(OFST-1,sp),x
3563  03dd               L5502:
3566  03dd 1e03          	ldw	x,(OFST-1,sp)
3567  03df 724f0050      	clr	(_buff,x)
3570  03e3 1e03          	ldw	x,(OFST-1,sp)
3571  03e5 1c0001        	addw	x,#1
3572  03e8 1f03          	ldw	(OFST-1,sp),x
3575  03ea 1e03          	ldw	x,(OFST-1,sp)
3576  03ec a30100        	cpw	x,#256
3577  03ef 25ec          	jrult	L5502
3578                     ; 312 		if(UIB[3]==1)
3580  03f1 c60003        	ld	a,_UIB+3
3581  03f4 a101          	cp	a,#1
3582  03f6 2632          	jrne	L3602
3583                     ; 314 			buff[0]=0x00;
3585  03f8 725f0050      	clr	_buff
3586                     ; 315 			buff[1]=0x11;
3588  03fc 35110051      	mov	_buff+1,#17
3589                     ; 316 			buff[2]=0x22;
3591  0400 35220052      	mov	_buff+2,#34
3592                     ; 317 			buff[3]=0x33;
3594  0404 35330053      	mov	_buff+3,#51
3595                     ; 318 			buff[4]=0x44;
3597  0408 35440054      	mov	_buff+4,#68
3598                     ; 319 			buff[5]=0x55;
3600  040c 35550055      	mov	_buff+5,#85
3601                     ; 320 			buff[6]=0x66;
3603  0410 35660056      	mov	_buff+6,#102
3604                     ; 321 			buff[7]=0x77;
3606  0414 35770057      	mov	_buff+7,#119
3607                     ; 322 			buff[8]=0x88;
3609  0418 35880058      	mov	_buff+8,#136
3610                     ; 323 			buff[9]=0x99;
3612  041c 35990059      	mov	_buff+9,#153
3613                     ; 324 			buff[10]=0;
3615  0420 725f005a      	clr	_buff+10
3616                     ; 325 			buff[11]=0;
3618  0424 725f005b      	clr	_buff+11
3620  0428 2070          	jra	L5602
3621  042a               L3602:
3622                     ; 328 		else if(UIB[3]==2)
3624  042a c60003        	ld	a,_UIB+3
3625  042d a102          	cp	a,#2
3626  042f 2632          	jrne	L7602
3627                     ; 330 			buff[0]=0x00;
3629  0431 725f0050      	clr	_buff
3630                     ; 331 			buff[1]=0x10;
3632  0435 35100051      	mov	_buff+1,#16
3633                     ; 332 			buff[2]=0x20;
3635  0439 35200052      	mov	_buff+2,#32
3636                     ; 333 			buff[3]=0x30;
3638  043d 35300053      	mov	_buff+3,#48
3639                     ; 334 			buff[4]=0x40;
3641  0441 35400054      	mov	_buff+4,#64
3642                     ; 335 			buff[5]=0x50;
3644  0445 35500055      	mov	_buff+5,#80
3645                     ; 336 			buff[6]=0x60;
3647  0449 35600056      	mov	_buff+6,#96
3648                     ; 337 			buff[7]=0x70;
3650  044d 35700057      	mov	_buff+7,#112
3651                     ; 338 			buff[8]=0x80;
3653  0451 35800058      	mov	_buff+8,#128
3654                     ; 339 			buff[9]=0x90;
3656  0455 35900059      	mov	_buff+9,#144
3657                     ; 340 			buff[10]=0;
3659  0459 725f005a      	clr	_buff+10
3660                     ; 341 			buff[11]=0;
3662  045d 725f005b      	clr	_buff+11
3664  0461 2037          	jra	L5602
3665  0463               L7602:
3666                     ; 344 		else if(UIB[3]==3)
3668  0463 c60003        	ld	a,_UIB+3
3669  0466 a103          	cp	a,#3
3670  0468 2630          	jrne	L5602
3671                     ; 346 			buff[0]=0x98;
3673  046a 35980050      	mov	_buff,#152
3674                     ; 347 			buff[1]=0x87;
3676  046e 35870051      	mov	_buff+1,#135
3677                     ; 348 			buff[2]=0x76;
3679  0472 35760052      	mov	_buff+2,#118
3680                     ; 349 			buff[3]=0x65;
3682  0476 35650053      	mov	_buff+3,#101
3683                     ; 350 			buff[4]=0x54;
3685  047a 35540054      	mov	_buff+4,#84
3686                     ; 351 			buff[5]=0x43;
3688  047e 35430055      	mov	_buff+5,#67
3689                     ; 352 			buff[6]=0x32;
3691  0482 35320056      	mov	_buff+6,#50
3692                     ; 353 			buff[7]=0x21;
3694  0486 35210057      	mov	_buff+7,#33
3695                     ; 354 			buff[8]=0x10;
3697  048a 35100058      	mov	_buff+8,#16
3698                     ; 355 			buff[9]=0x00;
3700  048e 725f0059      	clr	_buff+9
3701                     ; 356 			buff[10]=0;
3703  0492 725f005a      	clr	_buff+10
3704                     ; 357 			buff[11]=0;
3706  0496 725f005b      	clr	_buff+11
3707  049a               L5602:
3708                     ; 359 		if(UIB[2]==1)DF_buffer_write(/*1,*/0,256, buff);
3710  049a c60002        	ld	a,_UIB+2
3711  049d a101          	cp	a,#1
3712  049f 2703          	jreq	L05
3713  04a1 cc083e        	jp	L1771
3714  04a4               L05:
3717  04a4 ae0050        	ldw	x,#_buff
3718  04a7 89            	pushw	x
3719  04a8 ae0100        	ldw	x,#256
3720  04ab 89            	pushw	x
3721  04ac 5f            	clrw	x
3722  04ad cd0ae7        	call	_DF_buffer_write
3724  04b0 5b04          	addw	sp,#4
3725  04b2 ac3e083e      	jpf	L1771
3726  04b6               L3502:
3727                     ; 363 	else if(UIB[1]==13)
3729  04b6 c60001        	ld	a,_UIB+1
3730  04b9 a10d          	cp	a,#13
3731  04bb 2703cc0559    	jrne	L1012
3732                     ; 368 		if(memory_manufacturer=='A') {	
3734  04c0 b6bc          	ld	a,_memory_manufacturer
3735  04c2 a141          	cp	a,#65
3736  04c4 2608          	jrne	L3012
3737                     ; 369 			DF_page_to_buffer(/*UIB[2],*/UIB[3]);
3739  04c6 c60003        	ld	a,_UIB+3
3740  04c9 5f            	clrw	x
3741  04ca 97            	ld	xl,a
3742  04cb cd0a5b        	call	_DF_page_to_buffer
3744  04ce               L3012:
3745                     ; 371 		if(memory_manufacturer=='S') {
3747  04ce b6bc          	ld	a,_memory_manufacturer
3748  04d0 a153          	cp	a,#83
3749  04d2 2703          	jreq	L25
3750  04d4 cc083e        	jp	L1771
3751  04d7               L25:
3752                     ; 372 			current_page=11;
3754  04d7 ae000b        	ldw	x,#11
3755  04da bf0f          	ldw	_current_page,x
3756                     ; 373 			ST_READ((long)(current_page*256),256, buff);
3758  04dc ae0050        	ldw	x,#_buff
3759  04df 89            	pushw	x
3760  04e0 ae0100        	ldw	x,#256
3761  04e3 89            	pushw	x
3762  04e4 ae0b00        	ldw	x,#2816
3763  04e7 89            	pushw	x
3764  04e8 ae0000        	ldw	x,#0
3765  04eb 89            	pushw	x
3766  04ec cd099f        	call	_ST_READ
3768  04ef 5b08          	addw	sp,#8
3769                     ; 375 			uart_out_adr_block (0,buff,64);
3771  04f1 4b40          	push	#64
3772  04f3 ae0050        	ldw	x,#_buff
3773  04f6 89            	pushw	x
3774  04f7 ae0000        	ldw	x,#0
3775  04fa 89            	pushw	x
3776  04fb ae0000        	ldw	x,#0
3777  04fe 89            	pushw	x
3778  04ff cd017c        	call	_uart_out_adr_block
3780  0502 5b07          	addw	sp,#7
3781                     ; 376 			delay_ms(100);    
3783  0504 ae0064        	ldw	x,#100
3784  0507 cd0060        	call	_delay_ms
3786                     ; 377 			uart_out_adr_block (64,&buff[64],64);
3788  050a 4b40          	push	#64
3789  050c ae0090        	ldw	x,#_buff+64
3790  050f 89            	pushw	x
3791  0510 ae0040        	ldw	x,#64
3792  0513 89            	pushw	x
3793  0514 ae0000        	ldw	x,#0
3794  0517 89            	pushw	x
3795  0518 cd017c        	call	_uart_out_adr_block
3797  051b 5b07          	addw	sp,#7
3798                     ; 378 			delay_ms(100);    
3800  051d ae0064        	ldw	x,#100
3801  0520 cd0060        	call	_delay_ms
3803                     ; 379 			uart_out_adr_block (128,&buff[128],64);
3805  0523 4b40          	push	#64
3806  0525 ae00d0        	ldw	x,#_buff+128
3807  0528 89            	pushw	x
3808  0529 ae0080        	ldw	x,#128
3809  052c 89            	pushw	x
3810  052d ae0000        	ldw	x,#0
3811  0530 89            	pushw	x
3812  0531 cd017c        	call	_uart_out_adr_block
3814  0534 5b07          	addw	sp,#7
3815                     ; 380 			delay_ms(100);    
3817  0536 ae0064        	ldw	x,#100
3818  0539 cd0060        	call	_delay_ms
3820                     ; 381 			uart_out_adr_block (192,&buff[192],64);
3822  053c 4b40          	push	#64
3823  053e ae0110        	ldw	x,#_buff+192
3824  0541 89            	pushw	x
3825  0542 ae00c0        	ldw	x,#192
3826  0545 89            	pushw	x
3827  0546 ae0000        	ldw	x,#0
3828  0549 89            	pushw	x
3829  054a cd017c        	call	_uart_out_adr_block
3831  054d 5b07          	addw	sp,#7
3832                     ; 382 			delay_ms(100); 
3834  054f ae0064        	ldw	x,#100
3835  0552 cd0060        	call	_delay_ms
3837  0555 ac3e083e      	jpf	L1771
3838  0559               L1012:
3839                     ; 385 	else if(UIB[1]==14)
3841  0559 c60001        	ld	a,_UIB+1
3842  055c a10e          	cp	a,#14
3843  055e 265b          	jrne	L1112
3844                     ; 390 		if(memory_manufacturer=='A') {	
3846  0560 b6bc          	ld	a,_memory_manufacturer
3847  0562 a141          	cp	a,#65
3848  0564 2608          	jrne	L3112
3849                     ; 391 			DF_buffer_to_page_er(/*UIB[2],*/UIB[3]);
3851  0566 c60003        	ld	a,_UIB+3
3852  0569 5f            	clrw	x
3853  056a 97            	ld	xl,a
3854  056b cd0a7e        	call	_DF_buffer_to_page_er
3856  056e               L3112:
3857                     ; 393 		if(memory_manufacturer=='S') {
3859  056e b6bc          	ld	a,_memory_manufacturer
3860  0570 a153          	cp	a,#83
3861  0572 2703          	jreq	L45
3862  0574 cc083e        	jp	L1771
3863  0577               L45:
3864                     ; 394 			for(i=0;i<256;i++) {
3866  0577 5f            	clrw	x
3867  0578 1f03          	ldw	(OFST-1,sp),x
3868  057a               L7112:
3869                     ; 395 				buff[i]=(char)i;
3871  057a 7b04          	ld	a,(OFST+0,sp)
3872  057c 1e03          	ldw	x,(OFST-1,sp)
3873  057e d70050        	ld	(_buff,x),a
3874                     ; 394 			for(i=0;i<256;i++) {
3876  0581 1e03          	ldw	x,(OFST-1,sp)
3877  0583 1c0001        	addw	x,#1
3878  0586 1f03          	ldw	(OFST-1,sp),x
3881  0588 1e03          	ldw	x,(OFST-1,sp)
3882  058a a30100        	cpw	x,#256
3883  058d 25eb          	jrult	L7112
3884                     ; 397 			current_page=11;
3886  058f ae000b        	ldw	x,#11
3887  0592 bf0f          	ldw	_current_page,x
3888                     ; 398 			ST_WREN();
3890  0594 cd0946        	call	_ST_WREN
3892                     ; 399 			delay_ms(100);
3894  0597 ae0064        	ldw	x,#100
3895  059a cd0060        	call	_delay_ms
3897                     ; 400 			ST_WRITE((long)(current_page*256),256,buff);		
3899  059d ae0050        	ldw	x,#_buff
3900  05a0 89            	pushw	x
3901  05a1 ae0100        	ldw	x,#256
3902  05a4 89            	pushw	x
3903  05a5 be0f          	ldw	x,_current_page
3904  05a7 4f            	clr	a
3905  05a8 02            	rlwa	x,a
3906  05a9 cd0000        	call	c_uitolx
3908  05ac be02          	ldw	x,c_lreg+2
3909  05ae 89            	pushw	x
3910  05af be00          	ldw	x,c_lreg
3911  05b1 89            	pushw	x
3912  05b2 cd0953        	call	_ST_WRITE
3914  05b5 5b08          	addw	sp,#8
3915  05b7 ac3e083e      	jpf	L1771
3916  05bb               L1112:
3917                     ; 405 	else if(UIB[1]==20)
3919  05bb c60001        	ld	a,_UIB+1
3920  05be a114          	cp	a,#20
3921  05c0 2703cc0643    	jrne	L7212
3922                     ; 410 		file_lengt=0;
3924  05c5 ae0000        	ldw	x,#0
3925  05c8 bf09          	ldw	_file_lengt+2,x
3926  05ca ae0000        	ldw	x,#0
3927  05cd bf07          	ldw	_file_lengt,x
3928                     ; 411 		file_lengt+=UIB[5];
3930  05cf c60005        	ld	a,_UIB+5
3931  05d2 ae0007        	ldw	x,#_file_lengt
3932  05d5 88            	push	a
3933  05d6 cd0000        	call	c_lgadc
3935  05d9 84            	pop	a
3936                     ; 412 		file_lengt<<=8;
3938  05da ae0007        	ldw	x,#_file_lengt
3939  05dd a608          	ld	a,#8
3940  05df cd0000        	call	c_lglsh
3942                     ; 413 		file_lengt+=UIB[4];
3944  05e2 c60004        	ld	a,_UIB+4
3945  05e5 ae0007        	ldw	x,#_file_lengt
3946  05e8 88            	push	a
3947  05e9 cd0000        	call	c_lgadc
3949  05ec 84            	pop	a
3950                     ; 414 		file_lengt<<=8;
3952  05ed ae0007        	ldw	x,#_file_lengt
3953  05f0 a608          	ld	a,#8
3954  05f2 cd0000        	call	c_lglsh
3956                     ; 415 		file_lengt+=UIB[3];
3958  05f5 c60003        	ld	a,_UIB+3
3959  05f8 ae0007        	ldw	x,#_file_lengt
3960  05fb 88            	push	a
3961  05fc cd0000        	call	c_lgadc
3963  05ff 84            	pop	a
3964                     ; 416 		file_lengt_in_pages=file_lengt;
3966  0600 be09          	ldw	x,_file_lengt+2
3967  0602 bf11          	ldw	_file_lengt_in_pages,x
3968                     ; 417 		file_lengt<<=8;
3970  0604 ae0007        	ldw	x,#_file_lengt
3971  0607 a608          	ld	a,#8
3972  0609 cd0000        	call	c_lglsh
3974                     ; 418 		file_lengt+=UIB[2];
3976  060c c60002        	ld	a,_UIB+2
3977  060f ae0007        	ldw	x,#_file_lengt
3978  0612 88            	push	a
3979  0613 cd0000        	call	c_lgadc
3981  0616 84            	pop	a
3982                     ; 423 		current_page=0;
3984  0617 5f            	clrw	x
3985  0618 bf0f          	ldw	_current_page,x
3986                     ; 424 		current_byte_in_buffer=0;
3988  061a 5f            	clrw	x
3989  061b bf0b          	ldw	_current_byte_in_buffer,x
3990                     ; 426 		if(memory_manufacturer=='S') {
3992  061d b6bc          	ld	a,_memory_manufacturer
3993  061f a153          	cp	a,#83
3994  0621 2603          	jrne	L1312
3995                     ; 427 			ST_WREN();
3997  0623 cd0946        	call	_ST_WREN
3999  0626               L1312:
4000                     ; 429 		uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
4002  0626 4b00          	push	#0
4003  0628 4b00          	push	#0
4004  062a 3b000f        	push	_current_page
4005  062d b610          	ld	a,_current_page+1
4006  062f a4ff          	and	a,#255
4007  0631 88            	push	a
4008  0632 4b15          	push	#21
4009  0634 ae0016        	ldw	x,#22
4010  0637 a604          	ld	a,#4
4011  0639 95            	ld	xh,a
4012  063a cd00d2        	call	_uart_out
4014  063d 5b05          	addw	sp,#5
4016  063f ac3e083e      	jpf	L1771
4017  0643               L7212:
4018                     ; 432 	else if(UIB[1]==21)
4020  0643 c60001        	ld	a,_UIB+1
4021  0646 a115          	cp	a,#21
4022  0648 2703          	jreq	L65
4023  064a cc073f        	jp	L5312
4024  064d               L65:
4025                     ; 437           for(i=0;i<64;i++)
4027  064d 5f            	clrw	x
4028  064e 1f03          	ldw	(OFST-1,sp),x
4029  0650               L7312:
4030                     ; 439           	buff[current_byte_in_buffer+i]=UIB[2+i];
4032  0650 1e03          	ldw	x,(OFST-1,sp)
4033  0652 d60002        	ld	a,(_UIB+2,x)
4034  0655 be0b          	ldw	x,_current_byte_in_buffer
4035  0657 72fb03        	addw	x,(OFST-1,sp)
4036  065a d70050        	ld	(_buff,x),a
4037                     ; 437           for(i=0;i<64;i++)
4039  065d 1e03          	ldw	x,(OFST-1,sp)
4040  065f 1c0001        	addw	x,#1
4041  0662 1f03          	ldw	(OFST-1,sp),x
4044  0664 1e03          	ldw	x,(OFST-1,sp)
4045  0666 a30040        	cpw	x,#64
4046  0669 25e5          	jrult	L7312
4047                     ; 441           current_byte_in_buffer+=64;
4049  066b be0b          	ldw	x,_current_byte_in_buffer
4050  066d 1c0040        	addw	x,#64
4051  0670 bf0b          	ldw	_current_byte_in_buffer,x
4052                     ; 442           if(current_byte_in_buffer>=256)
4054  0672 be0b          	ldw	x,_current_byte_in_buffer
4055  0674 a30100        	cpw	x,#256
4056  0677 2403          	jruge	L06
4057  0679 cc083e        	jp	L1771
4058  067c               L06:
4059                     ; 450 			if(memory_manufacturer=='A') {
4061  067c b6bc          	ld	a,_memory_manufacturer
4062  067e a141          	cp	a,#65
4063  0680 264e          	jrne	L7412
4064                     ; 451 				DF_buffer_write(/*//current_buffer*//*1,*/0,256,buff);
4066  0682 ae0050        	ldw	x,#_buff
4067  0685 89            	pushw	x
4068  0686 ae0100        	ldw	x,#256
4069  0689 89            	pushw	x
4070  068a 5f            	clrw	x
4071  068b cd0ae7        	call	_DF_buffer_write
4073  068e 5b04          	addw	sp,#4
4074                     ; 452 				DF_buffer_to_page_er(/*///current_buffer*//*1,*/current_page);
4076  0690 be0f          	ldw	x,_current_page
4077  0692 cd0a7e        	call	_DF_buffer_to_page_er
4079                     ; 453 				current_page++;
4081  0695 be0f          	ldw	x,_current_page
4082  0697 1c0001        	addw	x,#1
4083  069a bf0f          	ldw	_current_page,x
4084                     ; 454 				if(current_page<file_lengt_in_pages)
4086  069c be0f          	ldw	x,_current_page
4087  069e b311          	cpw	x,_file_lengt_in_pages
4088  06a0 2424          	jruge	L1512
4089                     ; 456 					delay_ms(100);
4091  06a2 ae0064        	ldw	x,#100
4092  06a5 cd0060        	call	_delay_ms
4094                     ; 457 					uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
4096  06a8 4b00          	push	#0
4097  06aa 4b00          	push	#0
4098  06ac 3b000f        	push	_current_page
4099  06af b610          	ld	a,_current_page+1
4100  06b1 a4ff          	and	a,#255
4101  06b3 88            	push	a
4102  06b4 4b15          	push	#21
4103  06b6 ae0016        	ldw	x,#22
4104  06b9 a604          	ld	a,#4
4105  06bb 95            	ld	xh,a
4106  06bc cd00d2        	call	_uart_out
4108  06bf 5b05          	addw	sp,#5
4109                     ; 458 					current_byte_in_buffer=0;
4111  06c1 5f            	clrw	x
4112  06c2 bf0b          	ldw	_current_byte_in_buffer,x
4114  06c4 200a          	jra	L7412
4115  06c6               L1512:
4116                     ; 462 					EE_PAGE_LEN=current_page;
4118  06c6 be0f          	ldw	x,_current_page
4119  06c8 89            	pushw	x
4120  06c9 ae0000        	ldw	x,#_EE_PAGE_LEN
4121  06cc cd0000        	call	c_eewrw
4123  06cf 85            	popw	x
4124  06d0               L7412:
4125                     ; 465 			if(memory_manufacturer=='S') {
4127  06d0 b6bc          	ld	a,_memory_manufacturer
4128  06d2 a153          	cp	a,#83
4129  06d4 2703          	jreq	L26
4130  06d6 cc083e        	jp	L1771
4131  06d9               L26:
4132                     ; 466 				ST_WREN();
4134  06d9 cd0946        	call	_ST_WREN
4136                     ; 467 				delay_ms(100);
4138  06dc ae0064        	ldw	x,#100
4139  06df cd0060        	call	_delay_ms
4141                     ; 468 				ST_WRITE((unsigned long)(current_page*256UL),256,buff);
4143  06e2 ae0050        	ldw	x,#_buff
4144  06e5 89            	pushw	x
4145  06e6 ae0100        	ldw	x,#256
4146  06e9 89            	pushw	x
4147  06ea be0f          	ldw	x,_current_page
4148  06ec 90ae0100      	ldw	y,#256
4149  06f0 cd0000        	call	c_umul
4151  06f3 be02          	ldw	x,c_lreg+2
4152  06f5 89            	pushw	x
4153  06f6 be00          	ldw	x,c_lreg
4154  06f8 89            	pushw	x
4155  06f9 cd0953        	call	_ST_WRITE
4157  06fc 5b08          	addw	sp,#8
4158                     ; 469 				current_page++;
4160  06fe be0f          	ldw	x,_current_page
4161  0700 1c0001        	addw	x,#1
4162  0703 bf0f          	ldw	_current_page,x
4163                     ; 470 				if(current_page<file_lengt_in_pages)
4165  0705 be0f          	ldw	x,_current_page
4166  0707 b311          	cpw	x,_file_lengt_in_pages
4167  0709 2426          	jruge	L7512
4168                     ; 472 					delay_ms(100);
4170  070b ae0064        	ldw	x,#100
4171  070e cd0060        	call	_delay_ms
4173                     ; 473 					uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
4175  0711 4b00          	push	#0
4176  0713 4b00          	push	#0
4177  0715 3b000f        	push	_current_page
4178  0718 b610          	ld	a,_current_page+1
4179  071a a4ff          	and	a,#255
4180  071c 88            	push	a
4181  071d 4b15          	push	#21
4182  071f ae0016        	ldw	x,#22
4183  0722 a604          	ld	a,#4
4184  0724 95            	ld	xh,a
4185  0725 cd00d2        	call	_uart_out
4187  0728 5b05          	addw	sp,#5
4188                     ; 474 					current_byte_in_buffer=0;
4190  072a 5f            	clrw	x
4191  072b bf0b          	ldw	_current_byte_in_buffer,x
4193  072d ac3e083e      	jpf	L1771
4194  0731               L7512:
4195                     ; 478 					EE_PAGE_LEN=current_page;
4197  0731 be0f          	ldw	x,_current_page
4198  0733 89            	pushw	x
4199  0734 ae0000        	ldw	x,#_EE_PAGE_LEN
4200  0737 cd0000        	call	c_eewrw
4202  073a 85            	popw	x
4203  073b ac3e083e      	jpf	L1771
4204  073f               L5312:
4205                     ; 490 	else if(UIB[1]==25)
4207  073f c60001        	ld	a,_UIB+1
4208  0742 a119          	cp	a,#25
4209  0744 2703          	jreq	L46
4210  0746 cc0826        	jp	L5612
4211  0749               L46:
4212                     ; 494 		current_page=0;
4214  0749 5f            	clrw	x
4215  074a bf0f          	ldw	_current_page,x
4216                     ; 496 		for(i__=0;i__<EE_PAGE_LEN;i__++)
4218  074c 5f            	clrw	x
4219  074d 1f03          	ldw	(OFST-1,sp),x
4221  074f ac1a081a      	jpf	L3712
4222  0753               L7612:
4223                     ; 498 			if(memory_manufacturer=='S') {	
4225  0753 b6bc          	ld	a,_memory_manufacturer
4226  0755 a153          	cp	a,#83
4227  0757 2619          	jrne	L7712
4228                     ; 499 				DF_page_to_buffer(i__);
4230  0759 1e03          	ldw	x,(OFST-1,sp)
4231  075b cd0a5b        	call	_DF_page_to_buffer
4233                     ; 500 				delay_ms(100);			
4235  075e ae0064        	ldw	x,#100
4236  0761 cd0060        	call	_delay_ms
4238                     ; 501 				DF_buffer_read(0,256, buff);
4240  0764 ae0050        	ldw	x,#_buff
4241  0767 89            	pushw	x
4242  0768 ae0100        	ldw	x,#256
4243  076b 89            	pushw	x
4244  076c 5f            	clrw	x
4245  076d cd0aa1        	call	_DF_buffer_read
4247  0770 5b04          	addw	sp,#4
4248  0772               L7712:
4249                     ; 504 			if(memory_manufacturer=='S') {	
4251  0772 b6bc          	ld	a,_memory_manufacturer
4252  0774 a153          	cp	a,#83
4253  0776 261a          	jrne	L1022
4254                     ; 505 				ST_READ((long)(i__*256),256, buff);
4256  0778 ae0050        	ldw	x,#_buff
4257  077b 89            	pushw	x
4258  077c ae0100        	ldw	x,#256
4259  077f 89            	pushw	x
4260  0780 1e07          	ldw	x,(OFST+3,sp)
4261  0782 4f            	clr	a
4262  0783 02            	rlwa	x,a
4263  0784 cd0000        	call	c_itolx
4265  0787 be02          	ldw	x,c_lreg+2
4266  0789 89            	pushw	x
4267  078a be00          	ldw	x,c_lreg
4268  078c 89            	pushw	x
4269  078d cd099f        	call	_ST_READ
4271  0790 5b08          	addw	sp,#8
4272  0792               L1022:
4273                     ; 508 			uart_out_adr_block ((256*i__)+0,buff,64);
4275  0792 4b40          	push	#64
4276  0794 ae0050        	ldw	x,#_buff
4277  0797 89            	pushw	x
4278  0798 1e06          	ldw	x,(OFST+2,sp)
4279  079a 4f            	clr	a
4280  079b 02            	rlwa	x,a
4281  079c cd0000        	call	c_itolx
4283  079f be02          	ldw	x,c_lreg+2
4284  07a1 89            	pushw	x
4285  07a2 be00          	ldw	x,c_lreg
4286  07a4 89            	pushw	x
4287  07a5 cd017c        	call	_uart_out_adr_block
4289  07a8 5b07          	addw	sp,#7
4290                     ; 509 			delay_ms(100);    
4292  07aa ae0064        	ldw	x,#100
4293  07ad cd0060        	call	_delay_ms
4295                     ; 510 			uart_out_adr_block ((256*i__)+64,&buff[64],64);
4297  07b0 4b40          	push	#64
4298  07b2 ae0090        	ldw	x,#_buff+64
4299  07b5 89            	pushw	x
4300  07b6 1e06          	ldw	x,(OFST+2,sp)
4301  07b8 4f            	clr	a
4302  07b9 02            	rlwa	x,a
4303  07ba 1c0040        	addw	x,#64
4304  07bd cd0000        	call	c_itolx
4306  07c0 be02          	ldw	x,c_lreg+2
4307  07c2 89            	pushw	x
4308  07c3 be00          	ldw	x,c_lreg
4309  07c5 89            	pushw	x
4310  07c6 cd017c        	call	_uart_out_adr_block
4312  07c9 5b07          	addw	sp,#7
4313                     ; 511 			delay_ms(100);    
4315  07cb ae0064        	ldw	x,#100
4316  07ce cd0060        	call	_delay_ms
4318                     ; 512 			uart_out_adr_block ((256*i__)+128,&buff[128],64);
4320  07d1 4b40          	push	#64
4321  07d3 ae00d0        	ldw	x,#_buff+128
4322  07d6 89            	pushw	x
4323  07d7 1e06          	ldw	x,(OFST+2,sp)
4324  07d9 4f            	clr	a
4325  07da 02            	rlwa	x,a
4326  07db 1c0080        	addw	x,#128
4327  07de cd0000        	call	c_itolx
4329  07e1 be02          	ldw	x,c_lreg+2
4330  07e3 89            	pushw	x
4331  07e4 be00          	ldw	x,c_lreg
4332  07e6 89            	pushw	x
4333  07e7 cd017c        	call	_uart_out_adr_block
4335  07ea 5b07          	addw	sp,#7
4336                     ; 513 			delay_ms(100);    
4338  07ec ae0064        	ldw	x,#100
4339  07ef cd0060        	call	_delay_ms
4341                     ; 514 			uart_out_adr_block ((256*i__)+192,&buff[192],64);
4343  07f2 4b40          	push	#64
4344  07f4 ae0110        	ldw	x,#_buff+192
4345  07f7 89            	pushw	x
4346  07f8 1e06          	ldw	x,(OFST+2,sp)
4347  07fa 4f            	clr	a
4348  07fb 02            	rlwa	x,a
4349  07fc 1c00c0        	addw	x,#192
4350  07ff cd0000        	call	c_itolx
4352  0802 be02          	ldw	x,c_lreg+2
4353  0804 89            	pushw	x
4354  0805 be00          	ldw	x,c_lreg
4355  0807 89            	pushw	x
4356  0808 cd017c        	call	_uart_out_adr_block
4358  080b 5b07          	addw	sp,#7
4359                     ; 515 			delay_ms(100);   
4361  080d ae0064        	ldw	x,#100
4362  0810 cd0060        	call	_delay_ms
4364                     ; 496 		for(i__=0;i__<EE_PAGE_LEN;i__++)
4366  0813 1e03          	ldw	x,(OFST-1,sp)
4367  0815 1c0001        	addw	x,#1
4368  0818 1f03          	ldw	(OFST-1,sp),x
4369  081a               L3712:
4372  081a 1e03          	ldw	x,(OFST-1,sp)
4373  081c c30000        	cpw	x,_EE_PAGE_LEN
4374  081f 2403          	jruge	L66
4375  0821 cc0753        	jp	L7612
4376  0824               L66:
4378  0824 2018          	jra	L1771
4379  0826               L5612:
4380                     ; 525 	else if(UIB[1]==30)
4382  0826 c60001        	ld	a,_UIB+1
4383  0829 a11e          	cp	a,#30
4384  082b 2606          	jrne	L5022
4385                     ; 547           bSTART=1;
4387  082d 7210000c      	bset	_bSTART
4389  0831 200b          	jra	L1771
4390  0833               L5022:
4391                     ; 559 	else if(UIB[1]==40)
4393  0833 c60001        	ld	a,_UIB+1
4394  0836 a128          	cp	a,#40
4395  0838 2604          	jrne	L1771
4396                     ; 581 		bSTART=1;	
4398  083a 7210000c      	bset	_bSTART
4399  083e               L1771:
4400                     ; 585 }
4403  083e 5b04          	addw	sp,#4
4404  0840 81            	ret
4441                     ; 588 void putchar(char c)
4441                     ; 589 {
4442                     	switch	.text
4443  0841               _putchar:
4445  0841 88            	push	a
4446       00000000      OFST:	set	0
4449  0842               L3322:
4450                     ; 590 while (tx_counter == TX_BUFFER_SIZE);
4452  0842 b620          	ld	a,_tx_counter
4453  0844 a150          	cp	a,#80
4454  0846 27fa          	jreq	L3322
4455                     ; 592 if (tx_counter || ((UART1->SR & UART1_SR_TXE)==0))
4457  0848 3d20          	tnz	_tx_counter
4458  084a 2607          	jrne	L1422
4460  084c c65230        	ld	a,21040
4461  084f a580          	bcp	a,#128
4462  0851 261d          	jrne	L7322
4463  0853               L1422:
4464                     ; 594    tx_buffer[tx_wr_index]=c;
4466  0853 5f            	clrw	x
4467  0854 b61f          	ld	a,_tx_wr_index
4468  0856 2a01          	jrpl	L27
4469  0858 53            	cplw	x
4470  0859               L27:
4471  0859 97            	ld	xl,a
4472  085a 7b01          	ld	a,(OFST+1,sp)
4473  085c e704          	ld	(_tx_buffer,x),a
4474                     ; 595    if (++tx_wr_index == TX_BUFFER_SIZE) tx_wr_index=0;
4476  085e 3c1f          	inc	_tx_wr_index
4477  0860 b61f          	ld	a,_tx_wr_index
4478  0862 a150          	cp	a,#80
4479  0864 2602          	jrne	L3422
4482  0866 3f1f          	clr	_tx_wr_index
4483  0868               L3422:
4484                     ; 596    ++tx_counter;
4486  0868 3c20          	inc	_tx_counter
4488  086a               L5422:
4489                     ; 600 UART1->CR2|= UART1_CR2_TIEN;
4491  086a 721e5235      	bset	21045,#7
4492                     ; 602 }
4495  086e 84            	pop	a
4496  086f 81            	ret
4497  0870               L7322:
4498                     ; 598 else UART1->DR=c;
4500  0870 7b01          	ld	a,(OFST+1,sp)
4501  0872 c75231        	ld	21041,a
4502  0875 20f3          	jra	L5422
4525                     ; 605 void spi_init(void){
4526                     	switch	.text
4527  0877               _spi_init:
4531                     ; 607 	GPIOA->DDR|=(1<<3);
4533  0877 72165002      	bset	20482,#3
4534                     ; 608 	GPIOA->CR1|=(1<<3);
4536  087b 72165003      	bset	20483,#3
4537                     ; 609 	GPIOA->CR2&=~(1<<3);
4539  087f 72175004      	bres	20484,#3
4540                     ; 610 	GPIOA->ODR|=(1<<3);	
4542  0883 72165000      	bset	20480,#3
4543                     ; 613 	GPIOB->DDR|=(1<<5);
4545  0887 721a5007      	bset	20487,#5
4546                     ; 614 	GPIOB->CR1|=(1<<5);
4548  088b 721a5008      	bset	20488,#5
4549                     ; 615 	GPIOB->CR2&=~(1<<5);
4551  088f 721b5009      	bres	20489,#5
4552                     ; 616 	GPIOB->ODR|=(1<<5);	
4554  0893 721a5005      	bset	20485,#5
4555                     ; 618 	GPIOC->DDR|=(1<<3);
4557  0897 7216500c      	bset	20492,#3
4558                     ; 619 	GPIOC->CR1|=(1<<3);
4560  089b 7216500d      	bset	20493,#3
4561                     ; 620 	GPIOC->CR2&=~(1<<3);
4563  089f 7217500e      	bres	20494,#3
4564                     ; 621 	GPIOC->ODR|=(1<<3);	
4566  08a3 7216500a      	bset	20490,#3
4567                     ; 623 	GPIOC->DDR|=(1<<5);
4569  08a7 721a500c      	bset	20492,#5
4570                     ; 624 	GPIOC->CR1|=(1<<5);
4572  08ab 721a500d      	bset	20493,#5
4573                     ; 625 	GPIOC->CR2|=(1<<5);
4575  08af 721a500e      	bset	20494,#5
4576                     ; 626 	GPIOC->ODR|=(1<<5);	
4578  08b3 721a500a      	bset	20490,#5
4579                     ; 628 	GPIOC->DDR|=(1<<6);
4581  08b7 721c500c      	bset	20492,#6
4582                     ; 629 	GPIOC->CR1|=(1<<6);
4584  08bb 721c500d      	bset	20493,#6
4585                     ; 630 	GPIOC->CR2|=(1<<6);
4587  08bf 721c500e      	bset	20494,#6
4588                     ; 631 	GPIOC->ODR|=(1<<6);	
4590  08c3 721c500a      	bset	20490,#6
4591                     ; 633 	GPIOC->DDR&=~(1<<7);
4593  08c7 721f500c      	bres	20492,#7
4594                     ; 634 	GPIOC->CR1&=~(1<<7);
4596  08cb 721f500d      	bres	20493,#7
4597                     ; 635 	GPIOC->CR2&=~(1<<7);
4599  08cf 721f500e      	bres	20494,#7
4600                     ; 636 	GPIOC->ODR|=(1<<7);	
4602  08d3 721e500a      	bset	20490,#7
4603                     ; 638 	SPI->CR1= /*SPI_CR1_LSBFIRST |*/
4603                     ; 639 			SPI_CR1_SPE | 
4603                     ; 640 			( (4<< 3) & SPI_CR1_BR ) |
4603                     ; 641 			SPI_CR1_MSTR |
4603                     ; 642 			SPI_CR1_CPOL |
4603                     ; 643 			SPI_CR1_CPHA; 
4605  08d7 35675200      	mov	20992,#103
4606                     ; 645 	SPI->CR2= SPI_CR2_SSM | SPI_CR2_SSI;
4608  08db 35035201      	mov	20993,#3
4609                     ; 646 	SPI->ICR= 0;	
4611  08df 725f5202      	clr	20994
4612                     ; 647 }
4615  08e3 81            	ret
4658                     ; 650 char spi(char in){
4659                     	switch	.text
4660  08e4               _spi:
4662  08e4 88            	push	a
4663  08e5 88            	push	a
4664       00000001      OFST:	set	1
4667  08e6               L3032:
4668                     ; 652 	while(!((SPI->SR)&SPI_SR_TXE));
4670  08e6 c65203        	ld	a,20995
4671  08e9 a502          	bcp	a,#2
4672  08eb 27f9          	jreq	L3032
4673                     ; 653 	SPI->DR=in;
4675  08ed 7b02          	ld	a,(OFST+1,sp)
4676  08ef c75204        	ld	20996,a
4678  08f2               L3132:
4679                     ; 654 	while(!((SPI->SR)&SPI_SR_RXNE));
4681  08f2 c65203        	ld	a,20995
4682  08f5 a501          	bcp	a,#1
4683  08f7 27f9          	jreq	L3132
4684                     ; 655 	c=SPI->DR;	
4686  08f9 c65204        	ld	a,20996
4687  08fc 6b01          	ld	(OFST+0,sp),a
4688                     ; 656 	return c;
4690  08fe 7b01          	ld	a,(OFST+0,sp)
4693  0900 85            	popw	x
4694  0901 81            	ret
4759                     ; 660 long ST_RDID_read(void)
4759                     ; 661 {
4760                     	switch	.text
4761  0902               _ST_RDID_read:
4763  0902 5204          	subw	sp,#4
4764       00000004      OFST:	set	4
4767                     ; 664 d0=0;
4769  0904 0f04          	clr	(OFST+0,sp)
4770                     ; 665 d1=0;
4772                     ; 666 d2=0;
4774                     ; 667 d3=0;
4776                     ; 669 ST_CS_ON
4778  0906 721b5005      	bres	20485,#5
4779                     ; 670 spi(0x9f);
4781  090a a69f          	ld	a,#159
4782  090c add6          	call	_spi
4784                     ; 671 mdr0=spi(0xff);
4786  090e a6ff          	ld	a,#255
4787  0910 add2          	call	_spi
4789  0912 b716          	ld	_mdr0,a
4790                     ; 672 mdr1=spi(0xff);
4792  0914 a6ff          	ld	a,#255
4793  0916 adcc          	call	_spi
4795  0918 b715          	ld	_mdr1,a
4796                     ; 673 mdr2=spi(0xff);
4798  091a a6ff          	ld	a,#255
4799  091c adc6          	call	_spi
4801  091e b714          	ld	_mdr2,a
4802                     ; 676 ST_CS_OFF
4804  0920 721a5005      	bset	20485,#5
4805                     ; 677 return  *((long*)&d0);
4807  0924 96            	ldw	x,sp
4808  0925 1c0004        	addw	x,#OFST+0
4809  0928 cd0000        	call	c_ltor
4813  092b 5b04          	addw	sp,#4
4814  092d 81            	ret
4849                     ; 681 char ST_status_read(void)
4849                     ; 682 {
4850                     	switch	.text
4851  092e               _ST_status_read:
4853  092e 88            	push	a
4854       00000001      OFST:	set	1
4857                     ; 686 ST_CS_ON
4859  092f 721b5005      	bres	20485,#5
4860                     ; 687 spi(0x05);
4862  0933 a605          	ld	a,#5
4863  0935 adad          	call	_spi
4865                     ; 688 d0=spi(0xff);
4867  0937 a6ff          	ld	a,#255
4868  0939 ada9          	call	_spi
4870  093b 6b01          	ld	(OFST+0,sp),a
4871                     ; 690 ST_CS_OFF
4873  093d 721a5005      	bset	20485,#5
4874                     ; 691 return d0;
4876  0941 7b01          	ld	a,(OFST+0,sp)
4879  0943 5b01          	addw	sp,#1
4880  0945 81            	ret
4904                     ; 695 void ST_WREN(void)
4904                     ; 696 {
4905                     	switch	.text
4906  0946               _ST_WREN:
4910                     ; 698 ST_CS_ON
4912  0946 721b5005      	bres	20485,#5
4913                     ; 699 spi(0x06);
4915  094a a606          	ld	a,#6
4916  094c ad96          	call	_spi
4918                     ; 701 ST_CS_OFF
4920  094e 721a5005      	bset	20485,#5
4921                     ; 702 }  
4924  0952 81            	ret
5014                     ; 705 void ST_WRITE(unsigned long memo_addr,unsigned short len, char* adr)
5014                     ; 706 {
5015                     	switch	.text
5016  0953               _ST_WRITE:
5018  0953 5205          	subw	sp,#5
5019       00000005      OFST:	set	5
5022                     ; 710 adr2=(char)(memo_addr>>16);
5024  0955 7b09          	ld	a,(OFST+4,sp)
5025  0957 6b03          	ld	(OFST-2,sp),a
5026                     ; 711 adr1=(char)((memo_addr>>8)&0x00ff);
5028  0959 7b0a          	ld	a,(OFST+5,sp)
5029  095b a4ff          	and	a,#255
5030  095d 6b02          	ld	(OFST-3,sp),a
5031                     ; 712 adr0=(char)((memo_addr)&0x00ff);
5033  095f 7b0b          	ld	a,(OFST+6,sp)
5034  0961 a4ff          	and	a,#255
5035  0963 6b01          	ld	(OFST-4,sp),a
5036                     ; 713 ST_CS_ON
5038  0965 721b5005      	bres	20485,#5
5039                     ; 714 spi(0x0a);
5041  0969 a60a          	ld	a,#10
5042  096b cd08e4        	call	_spi
5044                     ; 715 spi(adr2);
5046  096e 7b03          	ld	a,(OFST-2,sp)
5047  0970 cd08e4        	call	_spi
5049                     ; 716 spi(adr1);
5051  0973 7b02          	ld	a,(OFST-3,sp)
5052  0975 cd08e4        	call	_spi
5054                     ; 717 spi(adr0);
5056  0978 7b01          	ld	a,(OFST-4,sp)
5057  097a cd08e4        	call	_spi
5059                     ; 719 for(i=0;i<len;i++)
5061  097d 5f            	clrw	x
5062  097e 1f04          	ldw	(OFST-1,sp),x
5064  0980 2010          	jra	L1542
5065  0982               L5442:
5066                     ; 721 	spi(adr[i]);
5068  0982 1e0e          	ldw	x,(OFST+9,sp)
5069  0984 72fb04        	addw	x,(OFST-1,sp)
5070  0987 f6            	ld	a,(x)
5071  0988 cd08e4        	call	_spi
5073                     ; 719 for(i=0;i<len;i++)
5075  098b 1e04          	ldw	x,(OFST-1,sp)
5076  098d 1c0001        	addw	x,#1
5077  0990 1f04          	ldw	(OFST-1,sp),x
5078  0992               L1542:
5081  0992 1e04          	ldw	x,(OFST-1,sp)
5082  0994 130c          	cpw	x,(OFST+7,sp)
5083  0996 25ea          	jrult	L5442
5084                     ; 724 ST_CS_OFF
5086  0998 721a5005      	bset	20485,#5
5087                     ; 725 }
5090  099c 5b05          	addw	sp,#5
5091  099e 81            	ret
5181                     ; 728 void ST_READ(unsigned long memo_addr,unsigned short len, char* adr)
5181                     ; 729 {
5182                     	switch	.text
5183  099f               _ST_READ:
5185  099f 5205          	subw	sp,#5
5186       00000005      OFST:	set	5
5189                     ; 735 adr2=(char)(memo_addr>>16);
5191  09a1 7b09          	ld	a,(OFST+4,sp)
5192  09a3 6b03          	ld	(OFST-2,sp),a
5193                     ; 736 adr1=(char)((memo_addr>>8)&0x00ff);
5195  09a5 7b0a          	ld	a,(OFST+5,sp)
5196  09a7 a4ff          	and	a,#255
5197  09a9 6b02          	ld	(OFST-3,sp),a
5198                     ; 737 adr0=(char)((memo_addr)&0x00ff);
5200  09ab 7b0b          	ld	a,(OFST+6,sp)
5201  09ad a4ff          	and	a,#255
5202  09af 6b01          	ld	(OFST-4,sp),a
5203                     ; 738 ST_CS_ON
5205  09b1 721b5005      	bres	20485,#5
5206                     ; 739 spi(0x03);
5208  09b5 a603          	ld	a,#3
5209  09b7 cd08e4        	call	_spi
5211                     ; 740 spi(adr2);
5213  09ba 7b03          	ld	a,(OFST-2,sp)
5214  09bc cd08e4        	call	_spi
5216                     ; 741 spi(adr1);
5218  09bf 7b02          	ld	a,(OFST-3,sp)
5219  09c1 cd08e4        	call	_spi
5221                     ; 742 spi(adr0);
5223  09c4 7b01          	ld	a,(OFST-4,sp)
5224  09c6 cd08e4        	call	_spi
5226                     ; 744 for(i=0;i<len;i++)
5228  09c9 5f            	clrw	x
5229  09ca 1f04          	ldw	(OFST-1,sp),x
5231  09cc 2012          	jra	L7252
5232  09ce               L3252:
5233                     ; 746 	adr[i]=spi(0xff);
5235  09ce a6ff          	ld	a,#255
5236  09d0 cd08e4        	call	_spi
5238  09d3 1e0e          	ldw	x,(OFST+9,sp)
5239  09d5 72fb04        	addw	x,(OFST-1,sp)
5240  09d8 f7            	ld	(x),a
5241                     ; 744 for(i=0;i<len;i++)
5243  09d9 1e04          	ldw	x,(OFST-1,sp)
5244  09db 1c0001        	addw	x,#1
5245  09de 1f04          	ldw	(OFST-1,sp),x
5246  09e0               L7252:
5249  09e0 1e04          	ldw	x,(OFST-1,sp)
5250  09e2 130c          	cpw	x,(OFST+7,sp)
5251  09e4 25e8          	jrult	L3252
5252                     ; 749 ST_CS_OFF
5254  09e6 721a5005      	bset	20485,#5
5255                     ; 750 }
5258  09ea 5b05          	addw	sp,#5
5259  09ec 81            	ret
5325                     ; 754 long DF_mf_dev_read(void)
5325                     ; 755 {
5326                     	switch	.text
5327  09ed               _DF_mf_dev_read:
5329  09ed 5204          	subw	sp,#4
5330       00000004      OFST:	set	4
5333                     ; 758 d0=0;
5335  09ef 0f04          	clr	(OFST+0,sp)
5336                     ; 759 d1=0;
5338                     ; 760 d2=0;
5340                     ; 761 d3=0;
5342                     ; 763 CS_ON
5344  09f1 7217500a      	bres	20490,#3
5345                     ; 764 spi(0x9f);
5347  09f5 a69f          	ld	a,#159
5348  09f7 cd08e4        	call	_spi
5350                     ; 765 mdr0=spi(0xff);
5352  09fa a6ff          	ld	a,#255
5353  09fc cd08e4        	call	_spi
5355  09ff b716          	ld	_mdr0,a
5356                     ; 766 mdr1=spi(0xff);
5358  0a01 a6ff          	ld	a,#255
5359  0a03 cd08e4        	call	_spi
5361  0a06 b715          	ld	_mdr1,a
5362                     ; 767 mdr2=spi(0xff);
5364  0a08 a6ff          	ld	a,#255
5365  0a0a cd08e4        	call	_spi
5367  0a0d b714          	ld	_mdr2,a
5368                     ; 768 mdr3=spi(0xff);  
5370  0a0f a6ff          	ld	a,#255
5371  0a11 cd08e4        	call	_spi
5373  0a14 b713          	ld	_mdr3,a
5374                     ; 770 CS_OFF
5376  0a16 7216500a      	bset	20490,#3
5377                     ; 771 return  *((long*)&d0);
5379  0a1a 96            	ldw	x,sp
5380  0a1b 1c0004        	addw	x,#OFST+0
5381  0a1e cd0000        	call	c_ltor
5385  0a21 5b04          	addw	sp,#4
5386  0a23 81            	ret
5410                     ; 775 void DF_memo_to_256(void)
5410                     ; 776 {
5411                     	switch	.text
5412  0a24               _DF_memo_to_256:
5416                     ; 778 CS_ON
5418  0a24 7217500a      	bres	20490,#3
5419                     ; 779 spi(0x3d);
5421  0a28 a63d          	ld	a,#61
5422  0a2a cd08e4        	call	_spi
5424                     ; 780 spi(0x2a); 
5426  0a2d a62a          	ld	a,#42
5427  0a2f cd08e4        	call	_spi
5429                     ; 781 spi(0x80);
5431  0a32 a680          	ld	a,#128
5432  0a34 cd08e4        	call	_spi
5434                     ; 782 spi(0xa6);
5436  0a37 a6a6          	ld	a,#166
5437  0a39 cd08e4        	call	_spi
5439                     ; 784 CS_OFF
5441  0a3c 7216500a      	bset	20490,#3
5442                     ; 785 }  
5445  0a40 81            	ret
5480                     ; 790 char DF_status_read(void)
5480                     ; 791 {
5481                     	switch	.text
5482  0a41               _DF_status_read:
5484  0a41 88            	push	a
5485       00000001      OFST:	set	1
5488                     ; 795 CS_ON
5490  0a42 7217500a      	bres	20490,#3
5491                     ; 796 spi(0xd7);
5493  0a46 a6d7          	ld	a,#215
5494  0a48 cd08e4        	call	_spi
5496                     ; 797 d0=spi(0xff);
5498  0a4b a6ff          	ld	a,#255
5499  0a4d cd08e4        	call	_spi
5501  0a50 6b01          	ld	(OFST+0,sp),a
5502                     ; 799 CS_OFF
5504  0a52 7216500a      	bset	20490,#3
5505                     ; 800 return d0;
5507  0a56 7b01          	ld	a,(OFST+0,sp)
5510  0a58 5b01          	addw	sp,#1
5511  0a5a 81            	ret
5555                     ; 804 void DF_page_to_buffer(unsigned page_addr)
5555                     ; 805 {
5556                     	switch	.text
5557  0a5b               _DF_page_to_buffer:
5559  0a5b 89            	pushw	x
5560  0a5c 88            	push	a
5561       00000001      OFST:	set	1
5564                     ; 808 d0=0x53; 
5566                     ; 812 CS_ON
5568  0a5d 7217500a      	bres	20490,#3
5569                     ; 813 spi(d0);
5571  0a61 a653          	ld	a,#83
5572  0a63 cd08e4        	call	_spi
5574                     ; 814 spi(page_addr/256/**(((char*)&page_addr)+1)*/);
5576  0a66 7b02          	ld	a,(OFST+1,sp)
5577  0a68 cd08e4        	call	_spi
5579                     ; 815 spi(page_addr%256/**((char*)&page_addr)*/);
5581  0a6b 7b03          	ld	a,(OFST+2,sp)
5582  0a6d a4ff          	and	a,#255
5583  0a6f cd08e4        	call	_spi
5585                     ; 816 spi(0xff);
5587  0a72 a6ff          	ld	a,#255
5588  0a74 cd08e4        	call	_spi
5590                     ; 818 CS_OFF
5592  0a77 7216500a      	bset	20490,#3
5593                     ; 819 }
5596  0a7b 5b03          	addw	sp,#3
5597  0a7d 81            	ret
5642                     ; 822 void DF_buffer_to_page_er(/*char buff,*/unsigned page_addr)
5642                     ; 823 {
5643                     	switch	.text
5644  0a7e               _DF_buffer_to_page_er:
5646  0a7e 89            	pushw	x
5647  0a7f 88            	push	a
5648       00000001      OFST:	set	1
5651                     ; 826 d0=0x83; 
5653                     ; 829 CS_ON
5655  0a80 7217500a      	bres	20490,#3
5656                     ; 830 spi(d0);
5658  0a84 a683          	ld	a,#131
5659  0a86 cd08e4        	call	_spi
5661                     ; 831 spi(page_addr/256/**(((char*)&page_addr)+1)*/);
5663  0a89 7b02          	ld	a,(OFST+1,sp)
5664  0a8b cd08e4        	call	_spi
5666                     ; 832 spi(page_addr%256/**((char*)&page_addr)*/);
5668  0a8e 7b03          	ld	a,(OFST+2,sp)
5669  0a90 a4ff          	and	a,#255
5670  0a92 cd08e4        	call	_spi
5672                     ; 833 spi(0xff);
5674  0a95 a6ff          	ld	a,#255
5675  0a97 cd08e4        	call	_spi
5677                     ; 835 CS_OFF
5679  0a9a 7216500a      	bset	20490,#3
5680                     ; 836 }
5683  0a9e 5b03          	addw	sp,#3
5684  0aa0 81            	ret
5756                     ; 839 void DF_buffer_read(unsigned buff_addr,unsigned len, char* adr)
5756                     ; 840 {
5757                     	switch	.text
5758  0aa1               _DF_buffer_read:
5760  0aa1 89            	pushw	x
5761  0aa2 5203          	subw	sp,#3
5762       00000003      OFST:	set	3
5765                     ; 844 d0=0x54; 
5767                     ; 846 CS_ON
5769  0aa4 7217500a      	bres	20490,#3
5770                     ; 847 spi(d0);
5772  0aa8 a654          	ld	a,#84
5773  0aaa cd08e4        	call	_spi
5775                     ; 848 spi(0xff);
5777  0aad a6ff          	ld	a,#255
5778  0aaf cd08e4        	call	_spi
5780                     ; 849 spi(buff_addr/256/**(((char*)&buff_addr)+1)*/);
5782  0ab2 7b04          	ld	a,(OFST+1,sp)
5783  0ab4 cd08e4        	call	_spi
5785                     ; 850 spi(buff_addr%256/**((char*)&buff_addr)*/);
5787  0ab7 7b05          	ld	a,(OFST+2,sp)
5788  0ab9 a4ff          	and	a,#255
5789  0abb cd08e4        	call	_spi
5791                     ; 851 spi(0xff);
5793  0abe a6ff          	ld	a,#255
5794  0ac0 cd08e4        	call	_spi
5796                     ; 852 for(i=0;i<len;i++)
5798  0ac3 5f            	clrw	x
5799  0ac4 1f02          	ldw	(OFST-1,sp),x
5801  0ac6 2012          	jra	L1272
5802  0ac8               L5172:
5803                     ; 854 	adr[i]=spi(0xff);
5805  0ac8 a6ff          	ld	a,#255
5806  0aca cd08e4        	call	_spi
5808  0acd 1e0a          	ldw	x,(OFST+7,sp)
5809  0acf 72fb02        	addw	x,(OFST-1,sp)
5810  0ad2 f7            	ld	(x),a
5811                     ; 852 for(i=0;i<len;i++)
5813  0ad3 1e02          	ldw	x,(OFST-1,sp)
5814  0ad5 1c0001        	addw	x,#1
5815  0ad8 1f02          	ldw	(OFST-1,sp),x
5816  0ada               L1272:
5819  0ada 1e02          	ldw	x,(OFST-1,sp)
5820  0adc 1308          	cpw	x,(OFST+5,sp)
5821  0ade 25e8          	jrult	L5172
5822                     ; 857 CS_OFF
5824  0ae0 7216500a      	bset	20490,#3
5825                     ; 858 }
5828  0ae4 5b05          	addw	sp,#5
5829  0ae6 81            	ret
5901                     ; 861 void DF_buffer_write(/*char buff,*/unsigned buff_addr,unsigned len, char* adr)
5901                     ; 862 {
5902                     	switch	.text
5903  0ae7               _DF_buffer_write:
5905  0ae7 89            	pushw	x
5906  0ae8 5203          	subw	sp,#3
5907       00000003      OFST:	set	3
5910                     ; 866 d0=0x84; 
5912                     ; 868 CS_ON
5914  0aea 7217500a      	bres	20490,#3
5915                     ; 869 spi(d0);
5917  0aee a684          	ld	a,#132
5918  0af0 cd08e4        	call	_spi
5920                     ; 870 spi(0xff);
5922  0af3 a6ff          	ld	a,#255
5923  0af5 cd08e4        	call	_spi
5925                     ; 871 spi(buff_addr/256/**(((char*)&buff_addr)+1)*/);
5927  0af8 7b04          	ld	a,(OFST+1,sp)
5928  0afa cd08e4        	call	_spi
5930                     ; 872 spi(buff_addr%256/**((char*)&buff_addr)*/);
5932  0afd 7b05          	ld	a,(OFST+2,sp)
5933  0aff a4ff          	and	a,#255
5934  0b01 cd08e4        	call	_spi
5936                     ; 874 for(i=0;i<len;i++)
5938  0b04 5f            	clrw	x
5939  0b05 1f02          	ldw	(OFST-1,sp),x
5941  0b07 2010          	jra	L7672
5942  0b09               L3672:
5943                     ; 876 	spi(adr[i]);
5945  0b09 1e0a          	ldw	x,(OFST+7,sp)
5946  0b0b 72fb02        	addw	x,(OFST-1,sp)
5947  0b0e f6            	ld	a,(x)
5948  0b0f cd08e4        	call	_spi
5950                     ; 874 for(i=0;i<len;i++)
5952  0b12 1e02          	ldw	x,(OFST-1,sp)
5953  0b14 1c0001        	addw	x,#1
5954  0b17 1f02          	ldw	(OFST-1,sp),x
5955  0b19               L7672:
5958  0b19 1e02          	ldw	x,(OFST-1,sp)
5959  0b1b 1308          	cpw	x,(OFST+5,sp)
5960  0b1d 25ea          	jrult	L3672
5961                     ; 879 CS_OFF
5963  0b1f 7216500a      	bset	20490,#3
5964                     ; 880 }
5967  0b23 5b05          	addw	sp,#5
5968  0b25 81            	ret
5991                     ; 902 void gpio_init(void){
5992                     	switch	.text
5993  0b26               _gpio_init:
5997                     ; 912 	GPIOD->DDR|=(1<<2);
5999  0b26 72145011      	bset	20497,#2
6000                     ; 913 	GPIOD->CR1|=(1<<2);
6002  0b2a 72145012      	bset	20498,#2
6003                     ; 914 	GPIOD->CR2|=(1<<2);
6005  0b2e 72145013      	bset	20499,#2
6006                     ; 915 	GPIOD->ODR&=~(1<<2);
6008  0b32 7215500f      	bres	20495,#2
6009                     ; 917 	GPIOD->DDR|=(1<<4);
6011  0b36 72185011      	bset	20497,#4
6012                     ; 918 	GPIOD->CR1|=(1<<4);
6014  0b3a 72185012      	bset	20498,#4
6015                     ; 919 	GPIOD->CR2&=~(1<<4);
6017  0b3e 72195013      	bres	20499,#4
6018                     ; 921 	GPIOC->DDR&=~(1<<4);
6020  0b42 7219500c      	bres	20492,#4
6021                     ; 922 	GPIOC->CR1&=~(1<<4);
6023  0b46 7219500d      	bres	20493,#4
6024                     ; 923 	GPIOC->CR2&=~(1<<4);
6026  0b4a 7219500e      	bres	20494,#4
6027                     ; 927 }
6030  0b4e 81            	ret
6082                     ; 930 void uart_in(void)
6082                     ; 931 {
6083                     	switch	.text
6084  0b4f               _uart_in:
6086  0b4f 89            	pushw	x
6087       00000002      OFST:	set	2
6090                     ; 935 if(rx_buffer_overflow)
6092                     	btst	_rx_buffer_overflow
6093  0b55 240d          	jruge	L5203
6094                     ; 937 	rx_wr_index=0;
6096  0b57 5f            	clrw	x
6097  0b58 bf1a          	ldw	_rx_wr_index,x
6098                     ; 938 	rx_rd_index=0;
6100  0b5a 5f            	clrw	x
6101  0b5b bf18          	ldw	_rx_rd_index,x
6102                     ; 939 	rx_counter=0;
6104  0b5d 5f            	clrw	x
6105  0b5e bf1c          	ldw	_rx_counter,x
6106                     ; 940 	rx_buffer_overflow=0;
6108  0b60 72110001      	bres	_rx_buffer_overflow
6109  0b64               L5203:
6110                     ; 943 if(rx_counter&&(rx_buffer[index_offset(rx_wr_index,-1)])==END)
6112  0b64 be1c          	ldw	x,_rx_counter
6113  0b66 2775          	jreq	L7203
6115  0b68 aeffff        	ldw	x,#65535
6116  0b6b 89            	pushw	x
6117  0b6c be1a          	ldw	x,_rx_wr_index
6118  0b6e ad6f          	call	_index_offset
6120  0b70 5b02          	addw	sp,#2
6121  0b72 e654          	ld	a,(_rx_buffer,x)
6122  0b74 a10a          	cp	a,#10
6123  0b76 2665          	jrne	L7203
6124                     ; 948 	temp=rx_buffer[index_offset(rx_wr_index,-3)];
6126  0b78 aefffd        	ldw	x,#65533
6127  0b7b 89            	pushw	x
6128  0b7c be1a          	ldw	x,_rx_wr_index
6129  0b7e ad5f          	call	_index_offset
6131  0b80 5b02          	addw	sp,#2
6132  0b82 e654          	ld	a,(_rx_buffer,x)
6133  0b84 6b01          	ld	(OFST-1,sp),a
6134                     ; 949     	if(temp<100) 
6136  0b86 7b01          	ld	a,(OFST-1,sp)
6137  0b88 a164          	cp	a,#100
6138  0b8a 2451          	jruge	L7203
6139                     ; 952     		if(control_check(index_offset(rx_wr_index,-1)))
6141  0b8c aeffff        	ldw	x,#65535
6142  0b8f 89            	pushw	x
6143  0b90 be1a          	ldw	x,_rx_wr_index
6144  0b92 ad4b          	call	_index_offset
6146  0b94 5b02          	addw	sp,#2
6147  0b96 9f            	ld	a,xl
6148  0b97 ad6e          	call	_control_check
6150  0b99 4d            	tnz	a
6151  0b9a 2741          	jreq	L7203
6152                     ; 955     			rx_rd_index=index_offset(rx_wr_index,-3-temp);
6154  0b9c a6ff          	ld	a,#255
6155  0b9e 97            	ld	xl,a
6156  0b9f a6fd          	ld	a,#253
6157  0ba1 1001          	sub	a,(OFST-1,sp)
6158  0ba3 2401          	jrnc	L431
6159  0ba5 5a            	decw	x
6160  0ba6               L431:
6161  0ba6 02            	rlwa	x,a
6162  0ba7 89            	pushw	x
6163  0ba8 01            	rrwa	x,a
6164  0ba9 be1a          	ldw	x,_rx_wr_index
6165  0bab ad32          	call	_index_offset
6167  0bad 5b02          	addw	sp,#2
6168  0baf bf18          	ldw	_rx_rd_index,x
6169                     ; 956     			for(i=0;i<temp;i++)
6171  0bb1 0f02          	clr	(OFST+0,sp)
6173  0bb3 2018          	jra	L1403
6174  0bb5               L5303:
6175                     ; 958 				UIB[i]=rx_buffer[index_offset(rx_rd_index,i)];
6177  0bb5 7b02          	ld	a,(OFST+0,sp)
6178  0bb7 5f            	clrw	x
6179  0bb8 97            	ld	xl,a
6180  0bb9 89            	pushw	x
6181  0bba 7b04          	ld	a,(OFST+2,sp)
6182  0bbc 5f            	clrw	x
6183  0bbd 97            	ld	xl,a
6184  0bbe 89            	pushw	x
6185  0bbf be18          	ldw	x,_rx_rd_index
6186  0bc1 ad1c          	call	_index_offset
6188  0bc3 5b02          	addw	sp,#2
6189  0bc5 e654          	ld	a,(_rx_buffer,x)
6190  0bc7 85            	popw	x
6191  0bc8 d70000        	ld	(_UIB,x),a
6192                     ; 956     			for(i=0;i<temp;i++)
6194  0bcb 0c02          	inc	(OFST+0,sp)
6195  0bcd               L1403:
6198  0bcd 7b02          	ld	a,(OFST+0,sp)
6199  0bcf 1101          	cp	a,(OFST-1,sp)
6200  0bd1 25e2          	jrult	L5303
6201                     ; 960 			rx_rd_index=rx_wr_index;
6203  0bd3 be1a          	ldw	x,_rx_wr_index
6204  0bd5 bf18          	ldw	_rx_rd_index,x
6205                     ; 961 			rx_counter=0;
6207  0bd7 5f            	clrw	x
6208  0bd8 bf1c          	ldw	_rx_counter,x
6209                     ; 971 			uart_in_an();
6211  0bda cd023c        	call	_uart_in_an
6213  0bdd               L7203:
6214                     ; 980 }
6217  0bdd 85            	popw	x
6218  0bde 81            	ret
6261                     ; 983 signed short index_offset (signed short index,signed short offset)
6261                     ; 984 {
6262                     	switch	.text
6263  0bdf               _index_offset:
6265  0bdf 89            	pushw	x
6266       00000000      OFST:	set	0
6269                     ; 985 index=index+offset;
6271  0be0 1e01          	ldw	x,(OFST+1,sp)
6272  0be2 72fb05        	addw	x,(OFST+5,sp)
6273  0be5 1f01          	ldw	(OFST+1,sp),x
6274                     ; 986 if(index>=RX_BUFFER_SIZE) index-=RX_BUFFER_SIZE; 
6276  0be7 9c            	rvf
6277  0be8 1e01          	ldw	x,(OFST+1,sp)
6278  0bea a30064        	cpw	x,#100
6279  0bed 2f07          	jrslt	L7603
6282  0bef 1e01          	ldw	x,(OFST+1,sp)
6283  0bf1 1d0064        	subw	x,#100
6284  0bf4 1f01          	ldw	(OFST+1,sp),x
6285  0bf6               L7603:
6286                     ; 987 if(index<0) index+=RX_BUFFER_SIZE;
6288  0bf6 9c            	rvf
6289  0bf7 1e01          	ldw	x,(OFST+1,sp)
6290  0bf9 2e07          	jrsge	L1703
6293  0bfb 1e01          	ldw	x,(OFST+1,sp)
6294  0bfd 1c0064        	addw	x,#100
6295  0c00 1f01          	ldw	(OFST+1,sp),x
6296  0c02               L1703:
6297                     ; 988 return index;
6299  0c02 1e01          	ldw	x,(OFST+1,sp)
6302  0c04 5b02          	addw	sp,#2
6303  0c06 81            	ret
6366                     ; 992 char control_check(char index)
6366                     ; 993 {
6367                     	switch	.text
6368  0c07               _control_check:
6370  0c07 88            	push	a
6371  0c08 5203          	subw	sp,#3
6372       00000003      OFST:	set	3
6375                     ; 994 char i=0,ii=0,iii;
6379                     ; 996 if(rx_buffer[index]!=END) return 0;
6381  0c0a 5f            	clrw	x
6382  0c0b 97            	ld	xl,a
6383  0c0c e654          	ld	a,(_rx_buffer,x)
6384  0c0e a10a          	cp	a,#10
6385  0c10 2703          	jreq	L5213
6388  0c12 4f            	clr	a
6390  0c13 2051          	jra	L641
6391  0c15               L5213:
6392                     ; 998 ii=rx_buffer[index_offset(index,-2)];
6394  0c15 aefffe        	ldw	x,#65534
6395  0c18 89            	pushw	x
6396  0c19 7b06          	ld	a,(OFST+3,sp)
6397  0c1b 5f            	clrw	x
6398  0c1c 97            	ld	xl,a
6399  0c1d adc0          	call	_index_offset
6401  0c1f 5b02          	addw	sp,#2
6402  0c21 e654          	ld	a,(_rx_buffer,x)
6403  0c23 6b02          	ld	(OFST-1,sp),a
6404                     ; 999 iii=0;
6406  0c25 0f01          	clr	(OFST-2,sp)
6407                     ; 1000 for(i=0;i<=ii;i++)
6409  0c27 0f03          	clr	(OFST+0,sp)
6411  0c29 2022          	jra	L3313
6412  0c2b               L7213:
6413                     ; 1002 	iii^=rx_buffer[index_offset(index,-2-ii+i)];
6415  0c2b a6ff          	ld	a,#255
6416  0c2d 97            	ld	xl,a
6417  0c2e a6fe          	ld	a,#254
6418  0c30 1002          	sub	a,(OFST-1,sp)
6419  0c32 2401          	jrnc	L241
6420  0c34 5a            	decw	x
6421  0c35               L241:
6422  0c35 1b03          	add	a,(OFST+0,sp)
6423  0c37 2401          	jrnc	L441
6424  0c39 5c            	incw	x
6425  0c3a               L441:
6426  0c3a 02            	rlwa	x,a
6427  0c3b 89            	pushw	x
6428  0c3c 01            	rrwa	x,a
6429  0c3d 7b06          	ld	a,(OFST+3,sp)
6430  0c3f 5f            	clrw	x
6431  0c40 97            	ld	xl,a
6432  0c41 ad9c          	call	_index_offset
6434  0c43 5b02          	addw	sp,#2
6435  0c45 7b01          	ld	a,(OFST-2,sp)
6436  0c47 e854          	xor	a,	(_rx_buffer,x)
6437  0c49 6b01          	ld	(OFST-2,sp),a
6438                     ; 1000 for(i=0;i<=ii;i++)
6440  0c4b 0c03          	inc	(OFST+0,sp)
6441  0c4d               L3313:
6444  0c4d 7b03          	ld	a,(OFST+0,sp)
6445  0c4f 1102          	cp	a,(OFST-1,sp)
6446  0c51 23d8          	jrule	L7213
6447                     ; 1004 if (iii!=rx_buffer[index_offset(index,-1)]) return 0;	
6449  0c53 aeffff        	ldw	x,#65535
6450  0c56 89            	pushw	x
6451  0c57 7b06          	ld	a,(OFST+3,sp)
6452  0c59 5f            	clrw	x
6453  0c5a 97            	ld	xl,a
6454  0c5b ad82          	call	_index_offset
6456  0c5d 5b02          	addw	sp,#2
6457  0c5f e654          	ld	a,(_rx_buffer,x)
6458  0c61 1101          	cp	a,(OFST-2,sp)
6459  0c63 2704          	jreq	L7313
6462  0c65 4f            	clr	a
6464  0c66               L641:
6466  0c66 5b04          	addw	sp,#4
6467  0c68 81            	ret
6468  0c69               L7313:
6469                     ; 1006 return 1;
6471  0c69 a601          	ld	a,#1
6473  0c6b 20f9          	jra	L641
6515                     ; 1015 @far @interrupt void TIM4_UPD_Interrupt (void) {
6517                     	switch	.text
6518  0c6d               f_TIM4_UPD_Interrupt:
6522                     ; 1017 	if(play) {
6524                     	btst	_play
6525  0c72 2445          	jruge	L1513
6526                     ; 1018 		TIM2->CCR3H= 0x00;	
6528  0c74 725f5315      	clr	21269
6529                     ; 1019 		TIM2->CCR3L= sample;
6531  0c78 5500175316    	mov	21270,_sample
6532                     ; 1020 		sample_cnt++;
6534  0c7d be21          	ldw	x,_sample_cnt
6535  0c7f 1c0001        	addw	x,#1
6536  0c82 bf21          	ldw	_sample_cnt,x
6537                     ; 1021 		if(sample_cnt>=256) {
6539  0c84 9c            	rvf
6540  0c85 be21          	ldw	x,_sample_cnt
6541  0c87 a30100        	cpw	x,#256
6542  0c8a 2f03          	jrslt	L3513
6543                     ; 1022 			sample_cnt=0;
6545  0c8c 5f            	clrw	x
6546  0c8d bf21          	ldw	_sample_cnt,x
6547  0c8f               L3513:
6548                     ; 1026 		sample=buff[sample_cnt];
6550  0c8f be21          	ldw	x,_sample_cnt
6551  0c91 d60050        	ld	a,(_buff,x)
6552  0c94 b717          	ld	_sample,a
6553                     ; 1028 		if(sample_cnt==132)	{
6555  0c96 be21          	ldw	x,_sample_cnt
6556  0c98 a30084        	cpw	x,#132
6557  0c9b 2604          	jrne	L5513
6558                     ; 1029 			bBUFF_LOAD=1;
6560  0c9d 7210000b      	bset	_bBUFF_LOAD
6561  0ca1               L5513:
6562                     ; 1033 		if(sample_cnt==5) {
6564  0ca1 be21          	ldw	x,_sample_cnt
6565  0ca3 a30005        	cpw	x,#5
6566  0ca6 2604          	jrne	L7513
6567                     ; 1034 			bBUFF_READ_H=1;
6569  0ca8 7210000a      	bset	_bBUFF_READ_H
6570  0cac               L7513:
6571                     ; 1037 		if(sample_cnt==150) {
6573  0cac be21          	ldw	x,_sample_cnt
6574  0cae a30096        	cpw	x,#150
6575  0cb1 2615          	jrne	L3613
6576                     ; 1038 			bBUFF_READ_L=1;
6578  0cb3 72100009      	bset	_bBUFF_READ_L
6579  0cb7 200f          	jra	L3613
6580  0cb9               L1513:
6581                     ; 1045 	else if(!bSTART) {
6583                     	btst	_bSTART
6584  0cbe 2508          	jrult	L3613
6585                     ; 1046 		TIM2->CCR3H= 0x00;	
6587  0cc0 725f5315      	clr	21269
6588                     ; 1047 		TIM2->CCR3L= 0x7f;//pwm_fade_in;
6590  0cc4 357f5316      	mov	21270,#127
6591  0cc8               L3613:
6592                     ; 1102 		if(but_block_cnt)but_on_drv_cnt=0;
6594  0cc8 be00          	ldw	x,_but_block_cnt
6595  0cca 2702          	jreq	L7613
6598  0ccc 3fb9          	clr	_but_on_drv_cnt
6599  0cce               L7613:
6600                     ; 1103 		if((((GPIOC->IDR)&(1<<4))) && (but_on_drv_cnt<100)) {
6602  0cce c6500b        	ld	a,20491
6603  0cd1 a510          	bcp	a,#16
6604  0cd3 271f          	jreq	L1713
6606  0cd5 b6b9          	ld	a,_but_on_drv_cnt
6607  0cd7 a164          	cp	a,#100
6608  0cd9 2419          	jruge	L1713
6609                     ; 1104 			but_on_drv_cnt++;
6611  0cdb 3cb9          	inc	_but_on_drv_cnt
6612                     ; 1105 			if((but_on_drv_cnt>2)&&(bRELEASE))
6614  0cdd b6b9          	ld	a,_but_on_drv_cnt
6615  0cdf a103          	cp	a,#3
6616  0ce1 2517          	jrult	L5713
6618                     	btst	_bRELEASE
6619  0ce8 2410          	jruge	L5713
6620                     ; 1107 				bRELEASE=0;
6622  0cea 72110000      	bres	_bRELEASE
6623                     ; 1108 				bSTART=1;
6625  0cee 7210000c      	bset	_bSTART
6626  0cf2 2006          	jra	L5713
6627  0cf4               L1713:
6628                     ; 1112 			but_on_drv_cnt=0;
6630  0cf4 3fb9          	clr	_but_on_drv_cnt
6631                     ; 1113 			bRELEASE=1;
6633  0cf6 72100000      	bset	_bRELEASE
6634  0cfa               L5713:
6635                     ; 1118 	if(++t0_cnt0>=125){
6637  0cfa 3c00          	inc	_t0_cnt0
6638  0cfc b600          	ld	a,_t0_cnt0
6639  0cfe a17d          	cp	a,#125
6640  0d00 2530          	jrult	L7713
6641                     ; 1119     		t0_cnt0=0;
6643  0d02 3f00          	clr	_t0_cnt0
6644                     ; 1120     		b100Hz=1;
6646  0d04 72100008      	bset	_b100Hz
6647                     ; 1130 		if(++t0_cnt1>=10){
6649  0d08 3c01          	inc	_t0_cnt1
6650  0d0a b601          	ld	a,_t0_cnt1
6651  0d0c a10a          	cp	a,#10
6652  0d0e 2506          	jrult	L1023
6653                     ; 1131 			t0_cnt1=0;
6655  0d10 3f01          	clr	_t0_cnt1
6656                     ; 1132 			b10Hz=1;
6658  0d12 72100007      	bset	_b10Hz
6659  0d16               L1023:
6660                     ; 1135 		if(++t0_cnt2>=20){
6662  0d16 3c02          	inc	_t0_cnt2
6663  0d18 b602          	ld	a,_t0_cnt2
6664  0d1a a114          	cp	a,#20
6665  0d1c 2506          	jrult	L3023
6666                     ; 1136 			t0_cnt2=0;
6668  0d1e 3f02          	clr	_t0_cnt2
6669                     ; 1137 			b5Hz=1;
6671  0d20 72100006      	bset	_b5Hz
6672  0d24               L3023:
6673                     ; 1140 		if(++t0_cnt3>=100){
6675  0d24 3c03          	inc	_t0_cnt3
6676  0d26 b603          	ld	a,_t0_cnt3
6677  0d28 a164          	cp	a,#100
6678  0d2a 2506          	jrult	L7713
6679                     ; 1141 			t0_cnt3=0;
6681  0d2c 3f03          	clr	_t0_cnt3
6682                     ; 1142 			b1Hz=1;
6684  0d2e 72100005      	bset	_b1Hz
6685  0d32               L7713:
6686                     ; 1146 	TIM4->SR1&=~TIM4_SR1_UIF;			// disable break interrupt
6688  0d32 72115344      	bres	21316,#0
6689                     ; 1147 	return;
6692  0d36 80            	iret
6718                     ; 1151 @far @interrupt void UARTTxInterrupt (void) {
6719                     	switch	.text
6720  0d37               f_UARTTxInterrupt:
6724                     ; 1153 	if (tx_counter){
6726  0d37 3d20          	tnz	_tx_counter
6727  0d39 271a          	jreq	L7123
6728                     ; 1154 		--tx_counter;
6730  0d3b 3a20          	dec	_tx_counter
6731                     ; 1155 		UART1->DR=tx_buffer[tx_rd_index];
6733  0d3d 5f            	clrw	x
6734  0d3e b61e          	ld	a,_tx_rd_index
6735  0d40 2a01          	jrpl	L451
6736  0d42 53            	cplw	x
6737  0d43               L451:
6738  0d43 97            	ld	xl,a
6739  0d44 e604          	ld	a,(_tx_buffer,x)
6740  0d46 c75231        	ld	21041,a
6741                     ; 1156 		if (++tx_rd_index == TX_BUFFER_SIZE) tx_rd_index=0;
6743  0d49 3c1e          	inc	_tx_rd_index
6744  0d4b b61e          	ld	a,_tx_rd_index
6745  0d4d a150          	cp	a,#80
6746  0d4f 260c          	jrne	L3223
6749  0d51 3f1e          	clr	_tx_rd_index
6750  0d53 2008          	jra	L3223
6751  0d55               L7123:
6752                     ; 1159 		bOUT_FREE=1;
6754  0d55 72100003      	bset	_bOUT_FREE
6755                     ; 1160 		UART1->CR2&= ~UART1_CR2_TIEN;
6757  0d59 721f5235      	bres	21045,#7
6758  0d5d               L3223:
6759                     ; 1162 }
6762  0d5d 80            	iret
6791                     ; 1165 @far @interrupt void UARTRxInterrupt (void) {
6792                     	switch	.text
6793  0d5e               f_UARTRxInterrupt:
6797                     ; 1170 	rx_status=UART1->SR;
6799  0d5e 5552300006    	mov	_rx_status,21040
6800                     ; 1171 	rx_data=UART1->DR;
6802  0d63 5552310005    	mov	_rx_data,21041
6803                     ; 1173 	if (rx_status & (UART1_SR_RXNE)){
6805  0d68 b606          	ld	a,_rx_status
6806  0d6a a520          	bcp	a,#32
6807  0d6c 272c          	jreq	L5323
6808                     ; 1174 		rx_buffer[rx_wr_index]=rx_data;
6810  0d6e be1a          	ldw	x,_rx_wr_index
6811  0d70 b605          	ld	a,_rx_data
6812  0d72 e754          	ld	(_rx_buffer,x),a
6813                     ; 1175 		bRXIN=1;
6815  0d74 72100002      	bset	_bRXIN
6816                     ; 1176 		if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
6818  0d78 be1a          	ldw	x,_rx_wr_index
6819  0d7a 1c0001        	addw	x,#1
6820  0d7d bf1a          	ldw	_rx_wr_index,x
6821  0d7f a30064        	cpw	x,#100
6822  0d82 2603          	jrne	L7323
6825  0d84 5f            	clrw	x
6826  0d85 bf1a          	ldw	_rx_wr_index,x
6827  0d87               L7323:
6828                     ; 1177 		if (++rx_counter == RX_BUFFER_SIZE){
6830  0d87 be1c          	ldw	x,_rx_counter
6831  0d89 1c0001        	addw	x,#1
6832  0d8c bf1c          	ldw	_rx_counter,x
6833  0d8e a30064        	cpw	x,#100
6834  0d91 2607          	jrne	L5323
6835                     ; 1178 			rx_counter=0;
6837  0d93 5f            	clrw	x
6838  0d94 bf1c          	ldw	_rx_counter,x
6839                     ; 1179 			rx_buffer_overflow=1;
6841  0d96 72100001      	bset	_rx_buffer_overflow
6842  0d9a               L5323:
6843                     ; 1182 }
6846  0d9a 80            	iret
6905                     ; 1188 main(){
6907                     	switch	.text
6908  0d9b               _main:
6912                     ; 1189 	CLK->CKDIVR=0;
6914  0d9b 725f50c6      	clr	20678
6915                     ; 1191 	rele_cnt_index=0;
6917  0d9f 3fbb          	clr	_rele_cnt_index
6918                     ; 1192 	GPIOD->DDR&=~(1<<6);
6920  0da1 721d5011      	bres	20497,#6
6921                     ; 1193 	GPIOD->CR1|=(1<<6);
6923  0da5 721c5012      	bset	20498,#6
6924                     ; 1194 	GPIOD->CR2|=(1<<6);
6926  0da9 721c5013      	bset	20499,#6
6927                     ; 1196 	GPIOD->DDR|=(1<<5);
6929  0dad 721a5011      	bset	20497,#5
6930                     ; 1197 	GPIOD->CR1|=(1<<5);
6932  0db1 721a5012      	bset	20498,#5
6933                     ; 1198 	GPIOD->CR2|=(1<<5);	
6935  0db5 721a5013      	bset	20499,#5
6936                     ; 1199 	GPIOD->ODR|=(1<<5);
6938  0db9 721a500f      	bset	20495,#5
6939                     ; 1201 	delay_ms(10);
6941  0dbd ae000a        	ldw	x,#10
6942  0dc0 cd0060        	call	_delay_ms
6944                     ; 1203 	if(!(GPIOD->IDR&=(1<<6))) {
6946  0dc3 c65010        	ld	a,20496
6947  0dc6 a440          	and	a,#64
6948  0dc8 c75010        	ld	20496,a
6949  0dcb 2606          	jrne	L3523
6950                     ; 1204 		rele_cnt_index=1;
6952  0dcd 350100bb      	mov	_rele_cnt_index,#1
6954  0dd1 2018          	jra	L5523
6955  0dd3               L3523:
6956                     ; 1207 		GPIOD->ODR&=~(1<<5);
6958  0dd3 721b500f      	bres	20495,#5
6959                     ; 1208 		delay_ms(10);
6961  0dd7 ae000a        	ldw	x,#10
6962  0dda cd0060        	call	_delay_ms
6964                     ; 1209 		if(!(GPIOD->IDR&=(1<<6))) {
6966  0ddd c65010        	ld	a,20496
6967  0de0 a440          	and	a,#64
6968  0de2 c75010        	ld	20496,a
6969  0de5 2604          	jrne	L5523
6970                     ; 1210 			rele_cnt_index=2;
6972  0de7 350200bb      	mov	_rele_cnt_index,#2
6973  0deb               L5523:
6974                     ; 1215 	gpio_init();
6976  0deb cd0b26        	call	_gpio_init
6978                     ; 1222 	spi_init();
6980  0dee cd0877        	call	_spi_init
6982                     ; 1224 		t4_init();
6984  0df1 cd0039        	call	_t4_init
6986                     ; 1228 	FLASH_DUKR=0xae;
6988  0df4 35ae5064      	mov	_FLASH_DUKR,#174
6989                     ; 1229 	FLASH_DUKR=0x56;
6991  0df8 35565064      	mov	_FLASH_DUKR,#86
6992                     ; 1234 	dumm[1]++;
6994  0dfc 725c017d      	inc	_dumm+1
6995                     ; 1236 	uart_init();
6997  0e00 cd00a2        	call	_uart_init
6999                     ; 1238 	ST_RDID_read();
7001  0e03 cd0902        	call	_ST_RDID_read
7003                     ; 1239 	if(mdr0==0x20) memory_manufacturer='S';	
7005  0e06 b616          	ld	a,_mdr0
7006  0e08 a120          	cp	a,#32
7007  0e0a 2606          	jrne	L1623
7010  0e0c 355300bc      	mov	_memory_manufacturer,#83
7012  0e10 200d          	jra	L3623
7013  0e12               L1623:
7014                     ; 1245 	DF_mf_dev_read();
7016  0e12 cd09ed        	call	_DF_mf_dev_read
7018                     ; 1246 	if(mdr0==0x1F) memory_manufacturer='A';
7020  0e15 b616          	ld	a,_mdr0
7021  0e17 a11f          	cp	a,#31
7022  0e19 2604          	jrne	L3623
7025  0e1b 354100bc      	mov	_memory_manufacturer,#65
7026  0e1f               L3623:
7027                     ; 1249 t2_init();
7029  0e1f cd0000        	call	_t2_init
7031                     ; 1251 	enableInterrupts();	
7034  0e22 9a            rim
7036  0e23               L7623:
7037                     ; 1255 		if(bBUFF_LOAD) {
7039                     	btst	_bBUFF_LOAD
7040  0e28 2425          	jruge	L3723
7041                     ; 1256 			bBUFF_LOAD=0;
7043  0e2a 7211000b      	bres	_bBUFF_LOAD
7044                     ; 1258 			if(current_page<last_page) {
7046  0e2e be0f          	ldw	x,_current_page
7047  0e30 b30d          	cpw	x,_last_page
7048  0e32 2409          	jruge	L5723
7049                     ; 1259 				current_page++;
7051  0e34 be0f          	ldw	x,_current_page
7052  0e36 1c0001        	addw	x,#1
7053  0e39 bf0f          	ldw	_current_page,x
7055  0e3b 2007          	jra	L7723
7056  0e3d               L5723:
7057                     ; 1263 				current_page=0;
7059  0e3d 5f            	clrw	x
7060  0e3e bf0f          	ldw	_current_page,x
7061                     ; 1264 				play=0;
7063  0e40 72110004      	bres	_play
7064  0e44               L7723:
7065                     ; 1266 			if(memory_manufacturer=='A') {
7067  0e44 b6bc          	ld	a,_memory_manufacturer
7068  0e46 a141          	cp	a,#65
7069  0e48 2605          	jrne	L3723
7070                     ; 1267 				DF_page_to_buffer(/*///current_buffer_H*//*1,*/current_page);
7072  0e4a be0f          	ldw	x,_current_page
7073  0e4c cd0a5b        	call	_DF_page_to_buffer
7075  0e4f               L3723:
7076                     ; 1271 		if(bBUFF_READ_L) {
7078                     	btst	_bBUFF_READ_L
7079  0e54 243a          	jruge	L3033
7080                     ; 1272 			bBUFF_READ_L=0;
7082  0e56 72110009      	bres	_bBUFF_READ_L
7083                     ; 1273 			if(memory_manufacturer=='A') {
7085  0e5a b6bc          	ld	a,_memory_manufacturer
7086  0e5c a141          	cp	a,#65
7087  0e5e 260e          	jrne	L5033
7088                     ; 1274 				DF_buffer_read(/*///current_buffer_L*//*1,*/0,128,buff);
7090  0e60 ae0050        	ldw	x,#_buff
7091  0e63 89            	pushw	x
7092  0e64 ae0080        	ldw	x,#128
7093  0e67 89            	pushw	x
7094  0e68 5f            	clrw	x
7095  0e69 cd0aa1        	call	_DF_buffer_read
7097  0e6c 5b04          	addw	sp,#4
7098  0e6e               L5033:
7099                     ; 1276 			if(memory_manufacturer=='S') {
7101  0e6e b6bc          	ld	a,_memory_manufacturer
7102  0e70 a153          	cp	a,#83
7103  0e72 261c          	jrne	L3033
7104                     ; 1277 				ST_READ((unsigned long)((unsigned long)(current_page*256UL)),128,buff);
7106  0e74 ae0050        	ldw	x,#_buff
7107  0e77 89            	pushw	x
7108  0e78 ae0080        	ldw	x,#128
7109  0e7b 89            	pushw	x
7110  0e7c be0f          	ldw	x,_current_page
7111  0e7e 90ae0100      	ldw	y,#256
7112  0e82 cd0000        	call	c_umul
7114  0e85 be02          	ldw	x,c_lreg+2
7115  0e87 89            	pushw	x
7116  0e88 be00          	ldw	x,c_lreg
7117  0e8a 89            	pushw	x
7118  0e8b cd099f        	call	_ST_READ
7120  0e8e 5b08          	addw	sp,#8
7121  0e90               L3033:
7122                     ; 1281 		if(bBUFF_READ_H) {
7124                     	btst	_bBUFF_READ_H
7125  0e95 2441          	jruge	L1133
7126                     ; 1282 			bBUFF_READ_H=0;
7128  0e97 7211000a      	bres	_bBUFF_READ_H
7129                     ; 1283 			if(memory_manufacturer=='A') {
7131  0e9b b6bc          	ld	a,_memory_manufacturer
7132  0e9d a141          	cp	a,#65
7133  0e9f 2610          	jrne	L3133
7134                     ; 1284 				DF_buffer_read(/*///current_buffer_L*//*1,*/128,128,&buff[128]);
7136  0ea1 ae00d0        	ldw	x,#_buff+128
7137  0ea4 89            	pushw	x
7138  0ea5 ae0080        	ldw	x,#128
7139  0ea8 89            	pushw	x
7140  0ea9 ae0080        	ldw	x,#128
7141  0eac cd0aa1        	call	_DF_buffer_read
7143  0eaf 5b04          	addw	sp,#4
7144  0eb1               L3133:
7145                     ; 1286 			if(memory_manufacturer=='S') {
7147  0eb1 b6bc          	ld	a,_memory_manufacturer
7148  0eb3 a153          	cp	a,#83
7149  0eb5 2621          	jrne	L1133
7150                     ; 1287 				ST_READ((unsigned long)((unsigned long)(current_page*256UL)+128UL),128,&buff[128]);
7152  0eb7 ae00d0        	ldw	x,#_buff+128
7153  0eba 89            	pushw	x
7154  0ebb ae0080        	ldw	x,#128
7155  0ebe 89            	pushw	x
7156  0ebf be0f          	ldw	x,_current_page
7157  0ec1 90ae0100      	ldw	y,#256
7158  0ec5 cd0000        	call	c_umul
7160  0ec8 a680          	ld	a,#128
7161  0eca cd0000        	call	c_ladc
7163  0ecd be02          	ldw	x,c_lreg+2
7164  0ecf 89            	pushw	x
7165  0ed0 be00          	ldw	x,c_lreg
7166  0ed2 89            	pushw	x
7167  0ed3 cd099f        	call	_ST_READ
7169  0ed6 5b08          	addw	sp,#8
7170  0ed8               L1133:
7171                     ; 1291 		if(bRXIN)	{
7173                     	btst	_bRXIN
7174  0edd 2407          	jruge	L7133
7175                     ; 1292 			bRXIN=0;
7177  0edf 72110002      	bres	_bRXIN
7178                     ; 1294 			uart_in();
7180  0ee3 cd0b4f        	call	_uart_in
7182  0ee6               L7133:
7183                     ; 1298 		if(b100Hz){
7185                     	btst	_b100Hz
7186  0eeb 2503cc0f82    	jruge	L1233
7187                     ; 1299 			b100Hz=0;
7189  0ef0 72110008      	bres	_b100Hz
7190                     ; 1301 			if(but_block_cnt)but_block_cnt--;
7192  0ef4 be00          	ldw	x,_but_block_cnt
7193  0ef6 2707          	jreq	L3233
7196  0ef8 be00          	ldw	x,_but_block_cnt
7197  0efa 1d0001        	subw	x,#1
7198  0efd bf00          	ldw	_but_block_cnt,x
7199  0eff               L3233:
7200                     ; 1303 			if(bSTART==1) {
7202                     	btst	_bSTART
7203  0f04 247c          	jruge	L1233
7204                     ; 1304 				if(play) {
7206                     	btst	_play
7207  0f0b 2406          	jruge	L7233
7208                     ; 1312 				bSTART=0;
7210  0f0d 7211000c      	bres	_bSTART
7212  0f11 206f          	jra	L1233
7213  0f13               L7233:
7214                     ; 1319 					current_page=1;
7216  0f13 ae0001        	ldw	x,#1
7217  0f16 bf0f          	ldw	_current_page,x
7218                     ; 1324 					last_page=EE_PAGE_LEN-1;
7220  0f18 ce0000        	ldw	x,_EE_PAGE_LEN
7221  0f1b 5a            	decw	x
7222  0f1c bf0d          	ldw	_last_page,x
7223                     ; 1326 					if(memory_manufacturer=='A') {
7225  0f1e b6bc          	ld	a,_memory_manufacturer
7226  0f20 a141          	cp	a,#65
7227  0f22 2630          	jrne	L3333
7228                     ; 1327 						DF_page_to_buffer(/*///current_buffer_H*//*1,*/current_page);
7230  0f24 ae0001        	ldw	x,#1
7231  0f27 cd0a5b        	call	_DF_page_to_buffer
7233                     ; 1328 						delay_ms(10);
7235  0f2a ae000a        	ldw	x,#10
7236  0f2d cd0060        	call	_delay_ms
7238                     ; 1329 						DF_buffer_read(/*///current_buffer_L*//*1,*/0,128,buff);
7240  0f30 ae0050        	ldw	x,#_buff
7241  0f33 89            	pushw	x
7242  0f34 ae0080        	ldw	x,#128
7243  0f37 89            	pushw	x
7244  0f38 5f            	clrw	x
7245  0f39 cd0aa1        	call	_DF_buffer_read
7247  0f3c 5b04          	addw	sp,#4
7248                     ; 1330 						delay_ms(10);
7250  0f3e ae000a        	ldw	x,#10
7251  0f41 cd0060        	call	_delay_ms
7253                     ; 1331 						DF_buffer_read(/*///current_buffer_L*//*1,*/128,128,&buff[128]);         
7255  0f44 ae00d0        	ldw	x,#_buff+128
7256  0f47 89            	pushw	x
7257  0f48 ae0080        	ldw	x,#128
7258  0f4b 89            	pushw	x
7259  0f4c ae0080        	ldw	x,#128
7260  0f4f cd0aa1        	call	_DF_buffer_read
7262  0f52 5b04          	addw	sp,#4
7263  0f54               L3333:
7264                     ; 1333 					if(memory_manufacturer=='S') {
7266  0f54 b6bc          	ld	a,_memory_manufacturer
7267  0f56 a153          	cp	a,#83
7268  0f58 2615          	jrne	L5333
7269                     ; 1334 						ST_READ(0,256,buff);
7271  0f5a ae0050        	ldw	x,#_buff
7272  0f5d 89            	pushw	x
7273  0f5e ae0100        	ldw	x,#256
7274  0f61 89            	pushw	x
7275  0f62 ae0000        	ldw	x,#0
7276  0f65 89            	pushw	x
7277  0f66 ae0000        	ldw	x,#0
7278  0f69 89            	pushw	x
7279  0f6a cd099f        	call	_ST_READ
7281  0f6d 5b08          	addw	sp,#8
7282  0f6f               L5333:
7283                     ; 1336 					play=1;
7285  0f6f 72100004      	bset	_play
7286                     ; 1337 					bSTART=0;
7288  0f73 7211000c      	bres	_bSTART
7289                     ; 1339 					rele_cnt=rele_cnt_const[rele_cnt_index];
7291  0f77 b6bb          	ld	a,_rele_cnt_index
7292  0f79 5f            	clrw	x
7293  0f7a 97            	ld	xl,a
7294  0f7b d60000        	ld	a,(_rele_cnt_const,x)
7295  0f7e 5f            	clrw	x
7296  0f7f 97            	ld	xl,a
7297  0f80 bf03          	ldw	_rele_cnt,x
7298  0f82               L1233:
7299                     ; 1349 		if(b10Hz){
7301                     	btst	_b10Hz
7302  0f87 2413          	jruge	L7333
7303                     ; 1350 			b10Hz=0;
7305  0f89 72110007      	bres	_b10Hz
7306                     ; 1352 			rele_drv();
7308  0f8d cd004a        	call	_rele_drv
7310                     ; 1353 			pwm_fade_in++;
7312  0f90 3cba          	inc	_pwm_fade_in
7313                     ; 1354 			if(pwm_fade_in>128)pwm_fade_in=128;			
7315  0f92 b6ba          	ld	a,_pwm_fade_in
7316  0f94 a181          	cp	a,#129
7317  0f96 2504          	jrult	L7333
7320  0f98 358000ba      	mov	_pwm_fade_in,#128
7321  0f9c               L7333:
7322                     ; 1357 		if(b5Hz){
7324                     	btst	_b5Hz
7325  0fa1 2404          	jruge	L3433
7326                     ; 1358 			b5Hz=0;
7328  0fa3 72110006      	bres	_b5Hz
7329  0fa7               L3433:
7330                     ; 1363 		if(b1Hz){
7332                     	btst	_b1Hz
7333  0fac 2503          	jrult	L261
7334  0fae cc0e23        	jp	L7623
7335  0fb1               L261:
7336                     ; 1365 			b1Hz=0;
7338  0fb1 72110005      	bres	_b1Hz
7339  0fb5 ac230e23      	jpf	L7623
7835                     	xdef	_main
7836                     .eeprom:	section	.data
7837  0000               _EE_PAGE_LEN:
7838  0000 0000          	ds.b	2
7839                     	xdef	_EE_PAGE_LEN
7840                     	switch	.bss
7841  0000               _UIB:
7842  0000 000000000000  	ds.b	80
7843                     	xdef	_UIB
7844  0050               _buff:
7845  0050 000000000000  	ds.b	300
7846                     	xdef	_buff
7847  017c               _dumm:
7848  017c 000000000000  	ds.b	100
7849                     	xdef	_dumm
7850                     .bit:	section	.data,bit
7851  0000               _bRELEASE:
7852  0000 00            	ds.b	1
7853                     	xdef	_bRELEASE
7854  0001               _rx_buffer_overflow:
7855  0001 00            	ds.b	1
7856                     	xdef	_rx_buffer_overflow
7857  0002               _bRXIN:
7858  0002 00            	ds.b	1
7859                     	xdef	_bRXIN
7860  0003               _bOUT_FREE:
7861  0003 00            	ds.b	1
7862                     	xdef	_bOUT_FREE
7863  0004               _play:
7864  0004 00            	ds.b	1
7865                     	xdef	_play
7866  0005               _b1Hz:
7867  0005 00            	ds.b	1
7868                     	xdef	_b1Hz
7869  0006               _b5Hz:
7870  0006 00            	ds.b	1
7871                     	xdef	_b5Hz
7872  0007               _b10Hz:
7873  0007 00            	ds.b	1
7874                     	xdef	_b10Hz
7875  0008               _b100Hz:
7876  0008 00            	ds.b	1
7877                     	xdef	_b100Hz
7878  0009               _bBUFF_READ_L:
7879  0009 00            	ds.b	1
7880                     	xdef	_bBUFF_READ_L
7881  000a               _bBUFF_READ_H:
7882  000a 00            	ds.b	1
7883                     	xdef	_bBUFF_READ_H
7884  000b               _bBUFF_LOAD:
7885  000b 00            	ds.b	1
7886                     	xdef	_bBUFF_LOAD
7887  000c               _bSTART:
7888  000c 00            	ds.b	1
7889                     	xdef	_bSTART
7890                     	switch	.ubsct
7891  0000               _but_block_cnt:
7892  0000 0000          	ds.b	2
7893                     	xdef	_but_block_cnt
7894                     	xdef	_memory_manufacturer
7895                     	xdef	_rele_cnt_const
7896                     	xdef	_rele_cnt_index
7897                     	xdef	_pwm_fade_in
7898  0002               _rx_offset:
7899  0002 00            	ds.b	1
7900                     	xdef	_rx_offset
7901  0003               _rele_cnt:
7902  0003 0000          	ds.b	2
7903                     	xdef	_rele_cnt
7904  0005               _rx_data:
7905  0005 00            	ds.b	1
7906                     	xdef	_rx_data
7907  0006               _rx_status:
7908  0006 00            	ds.b	1
7909                     	xdef	_rx_status
7910  0007               _file_lengt:
7911  0007 00000000      	ds.b	4
7912                     	xdef	_file_lengt
7913  000b               _current_byte_in_buffer:
7914  000b 0000          	ds.b	2
7915                     	xdef	_current_byte_in_buffer
7916  000d               _last_page:
7917  000d 0000          	ds.b	2
7918                     	xdef	_last_page
7919  000f               _current_page:
7920  000f 0000          	ds.b	2
7921                     	xdef	_current_page
7922  0011               _file_lengt_in_pages:
7923  0011 0000          	ds.b	2
7924                     	xdef	_file_lengt_in_pages
7925  0013               _mdr3:
7926  0013 00            	ds.b	1
7927                     	xdef	_mdr3
7928  0014               _mdr2:
7929  0014 00            	ds.b	1
7930                     	xdef	_mdr2
7931  0015               _mdr1:
7932  0015 00            	ds.b	1
7933                     	xdef	_mdr1
7934  0016               _mdr0:
7935  0016 00            	ds.b	1
7936                     	xdef	_mdr0
7937                     	xdef	_but_on_drv_cnt
7938                     	xdef	_but_drv_cnt
7939  0017               _sample:
7940  0017 00            	ds.b	1
7941                     	xdef	_sample
7942  0018               _rx_rd_index:
7943  0018 0000          	ds.b	2
7944                     	xdef	_rx_rd_index
7945  001a               _rx_wr_index:
7946  001a 0000          	ds.b	2
7947                     	xdef	_rx_wr_index
7948  001c               _rx_counter:
7949  001c 0000          	ds.b	2
7950                     	xdef	_rx_counter
7951                     	xdef	_rx_buffer
7952  001e               _tx_rd_index:
7953  001e 00            	ds.b	1
7954                     	xdef	_tx_rd_index
7955  001f               _tx_wr_index:
7956  001f 00            	ds.b	1
7957                     	xdef	_tx_wr_index
7958  0020               _tx_counter:
7959  0020 00            	ds.b	1
7960                     	xdef	_tx_counter
7961                     	xdef	_tx_buffer
7962  0021               _sample_cnt:
7963  0021 0000          	ds.b	2
7964                     	xdef	_sample_cnt
7965                     	xdef	_t0_cnt3
7966                     	xdef	_t0_cnt2
7967                     	xdef	_t0_cnt1
7968                     	xdef	_t0_cnt0
7969                     	xdef	_ST_READ
7970                     	xdef	_ST_WRITE
7971                     	xdef	_ST_WREN
7972                     	xdef	_ST_status_read
7973                     	xdef	_ST_RDID_read
7974                     	xdef	_uart_in_an
7975                     	xdef	_control_check
7976                     	xdef	_index_offset
7977                     	xdef	_uart_in
7978                     	xdef	_gpio_init
7979                     	xdef	_spi_init
7980                     	xdef	_spi
7981                     	xdef	_DF_buffer_to_page_er
7982                     	xdef	_DF_page_to_buffer
7983                     	xdef	_DF_buffer_write
7984                     	xdef	_DF_buffer_read
7985                     	xdef	_DF_status_read
7986                     	xdef	_DF_memo_to_256
7987                     	xdef	_DF_mf_dev_read
7988                     	xdef	_uart_init
7989                     	xdef	f_UARTRxInterrupt
7990                     	xdef	f_UARTTxInterrupt
7991                     	xdef	_putchar
7992                     	xdef	_uart_out_adr_block
7993                     	xdef	_uart_out
7994                     	xdef	f_TIM4_UPD_Interrupt
7995                     	xdef	_delay_ms
7996                     	xdef	_rele_drv
7997                     	xdef	_t4_init
7998                     	xdef	_t2_init
7999                     	xref.b	c_lreg
8000                     	xref.b	c_x
8001                     	xref.b	c_y
8021                     	xref	c_ladc
8022                     	xref	c_itolx
8023                     	xref	c_umul
8024                     	xref	c_eewrw
8025                     	xref	c_lglsh
8026                     	xref	c_uitolx
8027                     	xref	c_lgursh
8028                     	xref	c_lcmp
8029                     	xref	c_ltor
8030                     	xref	c_lgadc
8031                     	xref	c_rtol
8032                     	xref	c_vmul
8033                     	end
