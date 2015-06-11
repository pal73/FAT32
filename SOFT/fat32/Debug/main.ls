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
2198  0000 1e            	dc.b	30
2199  0001 32            	dc.b	50
2200  0002 46            	dc.b	70
2201                     	bsct
2202  00bc               _memory_manufacturer:
2203  00bc 53            	dc.b	83
2232                     ; 60 void t2_init(void){
2234                     	switch	.text
2235  0000               _t2_init:
2239                     ; 61 	TIM2->PSCR = 0;
2241  0000 725f530e      	clr	21262
2242                     ; 62 	TIM2->ARRH= 0x00;
2244  0004 725f530f      	clr	21263
2245                     ; 63 	TIM2->ARRL= 0xff;
2247  0008 35ff5310      	mov	21264,#255
2248                     ; 64 	TIM2->CCR1H= 0x00;	
2250  000c 725f5311      	clr	21265
2251                     ; 65 	TIM2->CCR1L= 200;
2253  0010 35c85312      	mov	21266,#200
2254                     ; 66 	TIM2->CCR2H= 0x00;	
2256  0014 725f5313      	clr	21267
2257                     ; 67 	TIM2->CCR2L= 200;
2259  0018 35c85314      	mov	21268,#200
2260                     ; 68 	TIM2->CCR3H= 0x00;	
2262  001c 725f5315      	clr	21269
2263                     ; 69 	TIM2->CCR3L= 50;
2265  0020 35325316      	mov	21270,#50
2266                     ; 72 	TIM2->CCMR2= ((6<<4) & TIM2_CCMR_OCM) | TIM2_CCMR_OCxPE; //OC2 toggle mode, prelouded
2268  0024 35685308      	mov	21256,#104
2269                     ; 73 	TIM2->CCMR3= ((6<<4) & TIM2_CCMR_OCM) | TIM2_CCMR_OCxPE; //OC2 toggle mode, prelouded
2271  0028 35685309      	mov	21257,#104
2272                     ; 74 	TIM2->CCER1= /*TIM2_CCER1_CC1E | TIM2_CCER1_CC1P |*/ TIM2_CCER1_CC2E | TIM2_CCER1_CC2P; //OC1, OC2 output pins enabled
2274  002c 3530530a      	mov	21258,#48
2275                     ; 76 	TIM2->CCER2= TIM2_CCER2_CC3E /*| TIM2_CCER2_CC3P*/; //OC1, OC2 output pins enabled
2277  0030 3501530b      	mov	21259,#1
2278                     ; 78 	TIM2->CR1=(TIM2_CR1_CEN | TIM2_CR1_ARPE);	
2280  0034 35815300      	mov	21248,#129
2281                     ; 80 }
2284  0038 81            	ret
2307                     ; 83 void t4_init(void){
2308                     	switch	.text
2309  0039               _t4_init:
2313                     ; 84 	TIM4->PSCR = 3;
2315  0039 35035347      	mov	21319,#3
2316                     ; 85 	TIM4->ARR= 158;
2318  003d 359e5348      	mov	21320,#158
2319                     ; 86 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
2321  0041 72105343      	bset	21315,#0
2322                     ; 88 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
2324  0045 35855340      	mov	21312,#133
2325                     ; 90 }
2328  0049 81            	ret
2352                     ; 93 void rele_drv(void) {
2353                     	switch	.text
2354  004a               _rele_drv:
2358                     ; 96 	if(rele_cnt) {
2360  004a be05          	ldw	x,_rele_cnt
2361  004c 270d          	jreq	L1641
2362                     ; 97 		rele_cnt--;
2364  004e be05          	ldw	x,_rele_cnt
2365  0050 1d0001        	subw	x,#1
2366  0053 bf05          	ldw	_rele_cnt,x
2367                     ; 98 		GPIOD->ODR|=(1<<4);
2369  0055 7218500f      	bset	20495,#4
2371  0059 2004          	jra	L3641
2372  005b               L1641:
2373                     ; 100 	else GPIOD->ODR&=~(1<<4); 
2375  005b 7219500f      	bres	20495,#4
2376  005f               L3641:
2377                     ; 115 }
2380  005f 81            	ret
2441                     ; 118 long delay_ms(short in)
2441                     ; 119 {
2442                     	switch	.text
2443  0060               _delay_ms:
2445  0060 520c          	subw	sp,#12
2446       0000000c      OFST:	set	12
2449                     ; 122 i=((long)in)*100UL;
2451  0062 90ae0064      	ldw	y,#100
2452  0066 cd0000        	call	c_vmul
2454  0069 96            	ldw	x,sp
2455  006a 1c0005        	addw	x,#OFST-7
2456  006d cd0000        	call	c_rtol
2458                     ; 124 for(ii=0;ii<i;ii++)
2460  0070 ae0000        	ldw	x,#0
2461  0073 1f0b          	ldw	(OFST-1,sp),x
2462  0075 ae0000        	ldw	x,#0
2463  0078 1f09          	ldw	(OFST-3,sp),x
2465  007a 2012          	jra	L3251
2466  007c               L7151:
2467                     ; 126 		iii++;
2469  007c 96            	ldw	x,sp
2470  007d 1c0001        	addw	x,#OFST-11
2471  0080 a601          	ld	a,#1
2472  0082 cd0000        	call	c_lgadc
2474                     ; 124 for(ii=0;ii<i;ii++)
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
2494                     ; 129 }
2497  009f 5b0c          	addw	sp,#12
2498  00a1 81            	ret
2521                     ; 132 void uart_init (void){
2522                     	switch	.text
2523  00a2               _uart_init:
2527                     ; 133 	GPIOD->DDR|=(1<<5);
2529  00a2 721a5011      	bset	20497,#5
2530                     ; 134 	GPIOD->CR1|=(1<<5);
2532  00a6 721a5012      	bset	20498,#5
2533                     ; 135 	GPIOD->CR2|=(1<<5);
2535  00aa 721a5013      	bset	20499,#5
2536                     ; 138 	GPIOD->DDR&=~(1<<6);
2538  00ae 721d5011      	bres	20497,#6
2539                     ; 139 	GPIOD->CR1&=~(1<<6);
2541  00b2 721d5012      	bres	20498,#6
2542                     ; 140 	GPIOD->CR2&=~(1<<6);
2544  00b6 721d5013      	bres	20499,#6
2545                     ; 143 	UART1->CR1&=~UART1_CR1_M;					
2547  00ba 72195234      	bres	21044,#4
2548                     ; 144 	UART1->CR3|= (0<<4) & UART1_CR3_STOP;	
2550  00be c65236        	ld	a,21046
2551                     ; 145 	UART1->BRR2= 0x01;//0x03;
2553  00c1 35015233      	mov	21043,#1
2554                     ; 146 	UART1->BRR1= 0x1a;//0x68;
2556  00c5 351a5232      	mov	21042,#26
2557                     ; 147 	UART1->CR2|= UART1_CR2_TEN | UART3_CR2_REN | UART3_CR2_RIEN;	
2559  00c9 c65235        	ld	a,21045
2560  00cc aa2c          	or	a,#44
2561  00ce c75235        	ld	21045,a
2562                     ; 148 }
2565  00d1 81            	ret
2683                     ; 151 void uart_out (char num,char data0,char data1,char data2,char data3,char data4,char data5){
2684                     	switch	.text
2685  00d2               _uart_out:
2687  00d2 89            	pushw	x
2688  00d3 520c          	subw	sp,#12
2689       0000000c      OFST:	set	12
2692                     ; 152 	char i=0,t=0,UOB[10];
2696  00d5 0f01          	clr	(OFST-11,sp)
2697                     ; 155 	UOB[0]=data0;
2699  00d7 9f            	ld	a,xl
2700  00d8 6b02          	ld	(OFST-10,sp),a
2701                     ; 156 	UOB[1]=data1;
2703  00da 7b11          	ld	a,(OFST+5,sp)
2704  00dc 6b03          	ld	(OFST-9,sp),a
2705                     ; 157 	UOB[2]=data2;
2707  00de 7b12          	ld	a,(OFST+6,sp)
2708  00e0 6b04          	ld	(OFST-8,sp),a
2709                     ; 158 	UOB[3]=data3;
2711  00e2 7b13          	ld	a,(OFST+7,sp)
2712  00e4 6b05          	ld	(OFST-7,sp),a
2713                     ; 159 	UOB[4]=data4;
2715  00e6 7b14          	ld	a,(OFST+8,sp)
2716  00e8 6b06          	ld	(OFST-6,sp),a
2717                     ; 160 	UOB[5]=data5;
2719  00ea 7b15          	ld	a,(OFST+9,sp)
2720  00ec 6b07          	ld	(OFST-5,sp),a
2721                     ; 161 	for (i=0;i<num;i++)
2723  00ee 0f0c          	clr	(OFST+0,sp)
2725  00f0 2013          	jra	L5261
2726  00f2               L1261:
2727                     ; 163 		t^=UOB[i];
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
2741                     ; 161 	for (i=0;i<num;i++)
2743  0103 0c0c          	inc	(OFST+0,sp)
2744  0105               L5261:
2747  0105 7b0c          	ld	a,(OFST+0,sp)
2748  0107 110d          	cp	a,(OFST+1,sp)
2749  0109 25e7          	jrult	L1261
2750                     ; 165 	UOB[num]=num;
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
2763                     ; 166 	t^=UOB[num];
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
2777                     ; 167 	UOB[num+1]=t;
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
2790                     ; 168 	UOB[num+2]=END;
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
2803                     ; 172 	for (i=0;i<num+3;i++)
2805  0149 0f0c          	clr	(OFST+0,sp)
2807  014b 2012          	jra	L5361
2808  014d               L1361:
2809                     ; 174 		putchar(UOB[i]);
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
2821  015a cd08b2        	call	_putchar
2823                     ; 172 	for (i=0;i<num+3;i++)
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
2840                     ; 177 	bOUT_FREE=0;	  	
2842  0175 72110003      	bres	_bOUT_FREE
2843                     ; 178 }
2846  0179 5b0e          	addw	sp,#14
2847  017b 81            	ret
2929                     ; 181 void uart_out_adr_block (unsigned long adress,char *ptr, char len)
2929                     ; 182 {
2930                     	switch	.text
2931  017c               _uart_out_adr_block:
2933  017c 5203          	subw	sp,#3
2934       00000003      OFST:	set	3
2937                     ; 186 t=0;
2939  017e 0f02          	clr	(OFST-1,sp)
2940                     ; 187 temp11=CMND;
2942                     ; 188 t^=temp11;
2944  0180 7b02          	ld	a,(OFST-1,sp)
2945  0182 a816          	xor	a,	#22
2946  0184 6b02          	ld	(OFST-1,sp),a
2947                     ; 189 putchar(temp11);
2949  0186 a616          	ld	a,#22
2950  0188 cd08b2        	call	_putchar
2952                     ; 191 temp11=10;
2954                     ; 192 t^=temp11;
2956  018b 7b02          	ld	a,(OFST-1,sp)
2957  018d a80a          	xor	a,	#10
2958  018f 6b02          	ld	(OFST-1,sp),a
2959                     ; 193 putchar(temp11);
2961  0191 a60a          	ld	a,#10
2962  0193 cd08b2        	call	_putchar
2964                     ; 195 temp11=adress%256;//(*((char*)&adress));
2966  0196 7b09          	ld	a,(OFST+6,sp)
2967  0198 a4ff          	and	a,#255
2968  019a 6b03          	ld	(OFST+0,sp),a
2969                     ; 196 t^=temp11;
2971  019c 7b02          	ld	a,(OFST-1,sp)
2972  019e 1803          	xor	a,	(OFST+0,sp)
2973  01a0 6b02          	ld	(OFST-1,sp),a
2974                     ; 197 putchar(temp11);
2976  01a2 7b03          	ld	a,(OFST+0,sp)
2977  01a4 cd08b2        	call	_putchar
2979                     ; 198 adress>>=8;
2981  01a7 96            	ldw	x,sp
2982  01a8 1c0006        	addw	x,#OFST+3
2983  01ab a608          	ld	a,#8
2984  01ad cd0000        	call	c_lgursh
2986                     ; 199 temp11=adress%256;//(*(((char*)&adress)+1));
2988  01b0 7b09          	ld	a,(OFST+6,sp)
2989  01b2 a4ff          	and	a,#255
2990  01b4 6b03          	ld	(OFST+0,sp),a
2991                     ; 200 t^=temp11;
2993  01b6 7b02          	ld	a,(OFST-1,sp)
2994  01b8 1803          	xor	a,	(OFST+0,sp)
2995  01ba 6b02          	ld	(OFST-1,sp),a
2996                     ; 201 putchar(temp11);
2998  01bc 7b03          	ld	a,(OFST+0,sp)
2999  01be cd08b2        	call	_putchar
3001                     ; 202 adress>>=8;
3003  01c1 96            	ldw	x,sp
3004  01c2 1c0006        	addw	x,#OFST+3
3005  01c5 a608          	ld	a,#8
3006  01c7 cd0000        	call	c_lgursh
3008                     ; 203 temp11=adress%256;//(*(((char*)&adress)+2));
3010  01ca 7b09          	ld	a,(OFST+6,sp)
3011  01cc a4ff          	and	a,#255
3012  01ce 6b03          	ld	(OFST+0,sp),a
3013                     ; 204 t^=temp11;
3015  01d0 7b02          	ld	a,(OFST-1,sp)
3016  01d2 1803          	xor	a,	(OFST+0,sp)
3017  01d4 6b02          	ld	(OFST-1,sp),a
3018                     ; 205 putchar(temp11);
3020  01d6 7b03          	ld	a,(OFST+0,sp)
3021  01d8 cd08b2        	call	_putchar
3023                     ; 206 adress>>=8;
3025  01db 96            	ldw	x,sp
3026  01dc 1c0006        	addw	x,#OFST+3
3027  01df a608          	ld	a,#8
3028  01e1 cd0000        	call	c_lgursh
3030                     ; 207 temp11=adress%256;//(*(((char*)&adress)+3));
3032  01e4 7b09          	ld	a,(OFST+6,sp)
3033  01e6 a4ff          	and	a,#255
3034  01e8 6b03          	ld	(OFST+0,sp),a
3035                     ; 208 t^=temp11;
3037  01ea 7b02          	ld	a,(OFST-1,sp)
3038  01ec 1803          	xor	a,	(OFST+0,sp)
3039  01ee 6b02          	ld	(OFST-1,sp),a
3040                     ; 209 putchar(temp11);
3042  01f0 7b03          	ld	a,(OFST+0,sp)
3043  01f2 cd08b2        	call	_putchar
3045                     ; 212 for(i11=0;i11<len;i11++)
3047  01f5 0f01          	clr	(OFST-2,sp)
3049  01f7 201b          	jra	L7071
3050  01f9               L3071:
3051                     ; 214 	temp11=ptr[i11];
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
3063                     ; 215 	t^=temp11;
3065  0207 7b02          	ld	a,(OFST-1,sp)
3066  0209 1803          	xor	a,	(OFST+0,sp)
3067  020b 6b02          	ld	(OFST-1,sp),a
3068                     ; 216 	putchar(temp11);
3070  020d 7b03          	ld	a,(OFST+0,sp)
3071  020f cd08b2        	call	_putchar
3073                     ; 212 for(i11=0;i11<len;i11++)
3075  0212 0c01          	inc	(OFST-2,sp)
3076  0214               L7071:
3079  0214 7b01          	ld	a,(OFST-2,sp)
3080  0216 110c          	cp	a,(OFST+9,sp)
3081  0218 25df          	jrult	L3071
3082                     ; 219 temp11=(len+6);
3084  021a 7b0c          	ld	a,(OFST+9,sp)
3085  021c ab06          	add	a,#6
3086  021e 6b03          	ld	(OFST+0,sp),a
3087                     ; 220 t^=temp11;
3089  0220 7b02          	ld	a,(OFST-1,sp)
3090  0222 1803          	xor	a,	(OFST+0,sp)
3091  0224 6b02          	ld	(OFST-1,sp),a
3092                     ; 221 putchar(temp11);
3094  0226 7b03          	ld	a,(OFST+0,sp)
3095  0228 cd08b2        	call	_putchar
3097                     ; 223 putchar(t);
3099  022b 7b02          	ld	a,(OFST-1,sp)
3100  022d cd08b2        	call	_putchar
3102                     ; 225 putchar(0x0a);
3104  0230 a60a          	ld	a,#10
3105  0232 cd08b2        	call	_putchar
3107                     ; 227 bOUT_FREE=0;	   
3109  0235 72110003      	bres	_bOUT_FREE
3110                     ; 228 }
3113  0239 5b03          	addw	sp,#3
3114  023b 81            	ret
3252                     ; 230 void uart_in_an(void) {
3253                     	switch	.text
3254  023c               _uart_in_an:
3256  023c 5204          	subw	sp,#4
3257       00000004      OFST:	set	4
3260                     ; 233 	if(UIB[0]==CMND) {
3262  023e c60000        	ld	a,_UIB
3263  0241 a116          	cp	a,#22
3264  0243 2703          	jreq	L24
3265  0245 cc08af        	jp	L1771
3266  0248               L24:
3267                     ; 234 		if(UIB[1]==1) {
3269  0248 c60001        	ld	a,_UIB+1
3270  024b a101          	cp	a,#1
3271  024d 262f          	jrne	L3771
3272                     ; 238 			if(memory_manufacturer=='A') {
3274  024f b6bc          	ld	a,_memory_manufacturer
3275  0251 a141          	cp	a,#65
3276  0253 2603          	jrne	L5771
3277                     ; 239 				temp_L=DF_mf_dev_read();
3279  0255 cd0a6b        	call	_DF_mf_dev_read
3281  0258               L5771:
3282                     ; 241 			if(memory_manufacturer=='S') {
3284  0258 b6bc          	ld	a,_memory_manufacturer
3285  025a a153          	cp	a,#83
3286  025c 2603          	jrne	L7771
3287                     ; 242 				temp_L=ST_RDID_read();
3289  025e cd0973        	call	_ST_RDID_read
3291  0261               L7771:
3292                     ; 244 			uart_out (6,CMND,1,mdr0/**((char*)&temp_L)*/,mdr1/**(((char*)&temp_L)+1)*/,mdr2/**(((char*)&temp_L)+2)*/,mdr3/**(((char*)&temp_L)+3)*/);
3294  0261 3b0015        	push	_mdr3
3295  0264 3b0016        	push	_mdr2
3296  0267 3b0017        	push	_mdr1
3297  026a 3b0018        	push	_mdr0
3298  026d 4b01          	push	#1
3299  026f ae0016        	ldw	x,#22
3300  0272 a606          	ld	a,#6
3301  0274 95            	ld	xh,a
3302  0275 cd00d2        	call	_uart_out
3304  0278 5b05          	addw	sp,#5
3306  027a acaf08af      	jpf	L1771
3307  027e               L3771:
3308                     ; 252 	else if(UIB[1]==2) {
3310  027e c60001        	ld	a,_UIB+1
3311  0281 a102          	cp	a,#2
3312  0283 2630          	jrne	L3002
3313                     ; 255 		if(memory_manufacturer=='A') {
3315  0285 b6bc          	ld	a,_memory_manufacturer
3316  0287 a141          	cp	a,#65
3317  0289 2605          	jrne	L5002
3318                     ; 256 			temp=DF_status_read();
3320  028b cd0abf        	call	_DF_status_read
3322  028e 6b04          	ld	(OFST+0,sp),a
3323  0290               L5002:
3324                     ; 258 		if(memory_manufacturer=='S') {
3326  0290 b6bc          	ld	a,_memory_manufacturer
3327  0292 a153          	cp	a,#83
3328  0294 2605          	jrne	L7002
3329                     ; 259 			temp=ST_status_read();
3331  0296 cd099f        	call	_ST_status_read
3333  0299 6b04          	ld	(OFST+0,sp),a
3334  029b               L7002:
3335                     ; 261 		uart_out (3,CMND,2,temp,0,0,0);    
3337  029b 4b00          	push	#0
3338  029d 4b00          	push	#0
3339  029f 4b00          	push	#0
3340  02a1 7b07          	ld	a,(OFST+3,sp)
3341  02a3 88            	push	a
3342  02a4 4b02          	push	#2
3343  02a6 ae0016        	ldw	x,#22
3344  02a9 a603          	ld	a,#3
3345  02ab 95            	ld	xh,a
3346  02ac cd00d2        	call	_uart_out
3348  02af 5b05          	addw	sp,#5
3350  02b1 acaf08af      	jpf	L1771
3351  02b5               L3002:
3352                     ; 265 	else if(UIB[1]==3)
3354  02b5 c60001        	ld	a,_UIB+1
3355  02b8 a103          	cp	a,#3
3356  02ba 2623          	jrne	L3102
3357                     ; 268 		if(memory_manufacturer=='A') {
3359  02bc b6bc          	ld	a,_memory_manufacturer
3360  02be a141          	cp	a,#65
3361  02c0 2603          	jrne	L5102
3362                     ; 269 			DF_memo_to_256();
3364  02c2 cd0aa2        	call	_DF_memo_to_256
3366  02c5               L5102:
3367                     ; 271 		uart_out (2,CMND,3,temp,0,0,0);    
3369  02c5 4b00          	push	#0
3370  02c7 4b00          	push	#0
3371  02c9 4b00          	push	#0
3372  02cb 7b07          	ld	a,(OFST+3,sp)
3373  02cd 88            	push	a
3374  02ce 4b03          	push	#3
3375  02d0 ae0016        	ldw	x,#22
3376  02d3 a602          	ld	a,#2
3377  02d5 95            	ld	xh,a
3378  02d6 cd00d2        	call	_uart_out
3380  02d9 5b05          	addw	sp,#5
3382  02db acaf08af      	jpf	L1771
3383  02df               L3102:
3384                     ; 274 	else if(UIB[1]==4)
3386  02df c60001        	ld	a,_UIB+1
3387  02e2 a104          	cp	a,#4
3388  02e4 2623          	jrne	L1202
3389                     ; 277 		if(memory_manufacturer=='A') {
3391  02e6 b6bc          	ld	a,_memory_manufacturer
3392  02e8 a141          	cp	a,#65
3393  02ea 2603          	jrne	L3202
3394                     ; 278 			DF_memo_to_256();
3396  02ec cd0aa2        	call	_DF_memo_to_256
3398  02ef               L3202:
3399                     ; 280 		uart_out (2,CMND,3,temp,0,0,0);    
3401  02ef 4b00          	push	#0
3402  02f1 4b00          	push	#0
3403  02f3 4b00          	push	#0
3404  02f5 7b07          	ld	a,(OFST+3,sp)
3405  02f7 88            	push	a
3406  02f8 4b03          	push	#3
3407  02fa ae0016        	ldw	x,#22
3408  02fd a602          	ld	a,#2
3409  02ff 95            	ld	xh,a
3410  0300 cd00d2        	call	_uart_out
3412  0303 5b05          	addw	sp,#5
3414  0305 acaf08af      	jpf	L1771
3415  0309               L1202:
3416                     ; 283 	else if(UIB[1]==10)
3418  0309 c60001        	ld	a,_UIB+1
3419  030c a10a          	cp	a,#10
3420  030e 2703cc0396    	jrne	L7202
3421                     ; 287 		if(memory_manufacturer=='A') {
3423  0313 b6bc          	ld	a,_memory_manufacturer
3424  0315 a141          	cp	a,#65
3425  0317 2615          	jrne	L1302
3426                     ; 288 			if(UIB[2]==1)DF_buffer_read(/*1,*/0,256, buff);
3428  0319 c60002        	ld	a,_UIB+2
3429  031c a101          	cp	a,#1
3430  031e 260e          	jrne	L1302
3433  0320 ae0050        	ldw	x,#_buff
3434  0323 89            	pushw	x
3435  0324 ae0100        	ldw	x,#256
3436  0327 89            	pushw	x
3437  0328 5f            	clrw	x
3438  0329 cd0b1f        	call	_DF_buffer_read
3440  032c 5b04          	addw	sp,#4
3441  032e               L1302:
3442                     ; 293 		uart_out_adr_block (0,buff,64);
3444  032e 4b40          	push	#64
3445  0330 ae0050        	ldw	x,#_buff
3446  0333 89            	pushw	x
3447  0334 ae0000        	ldw	x,#0
3448  0337 89            	pushw	x
3449  0338 ae0000        	ldw	x,#0
3450  033b 89            	pushw	x
3451  033c cd017c        	call	_uart_out_adr_block
3453  033f 5b07          	addw	sp,#7
3454                     ; 294 		delay_ms(100);    
3456  0341 ae0064        	ldw	x,#100
3457  0344 cd0060        	call	_delay_ms
3459                     ; 295 		uart_out_adr_block (64,&buff[64],64);
3461  0347 4b40          	push	#64
3462  0349 ae0090        	ldw	x,#_buff+64
3463  034c 89            	pushw	x
3464  034d ae0040        	ldw	x,#64
3465  0350 89            	pushw	x
3466  0351 ae0000        	ldw	x,#0
3467  0354 89            	pushw	x
3468  0355 cd017c        	call	_uart_out_adr_block
3470  0358 5b07          	addw	sp,#7
3471                     ; 296 		delay_ms(100);    
3473  035a ae0064        	ldw	x,#100
3474  035d cd0060        	call	_delay_ms
3476                     ; 297 		uart_out_adr_block (128,&buff[128],64);
3478  0360 4b40          	push	#64
3479  0362 ae00d0        	ldw	x,#_buff+128
3480  0365 89            	pushw	x
3481  0366 ae0080        	ldw	x,#128
3482  0369 89            	pushw	x
3483  036a ae0000        	ldw	x,#0
3484  036d 89            	pushw	x
3485  036e cd017c        	call	_uart_out_adr_block
3487  0371 5b07          	addw	sp,#7
3488                     ; 298 		delay_ms(100);    
3490  0373 ae0064        	ldw	x,#100
3491  0376 cd0060        	call	_delay_ms
3493                     ; 299 		uart_out_adr_block (192,&buff[192],64);
3495  0379 4b40          	push	#64
3496  037b ae0110        	ldw	x,#_buff+192
3497  037e 89            	pushw	x
3498  037f ae00c0        	ldw	x,#192
3499  0382 89            	pushw	x
3500  0383 ae0000        	ldw	x,#0
3501  0386 89            	pushw	x
3502  0387 cd017c        	call	_uart_out_adr_block
3504  038a 5b07          	addw	sp,#7
3505                     ; 300 		delay_ms(100);    
3507  038c ae0064        	ldw	x,#100
3508  038f cd0060        	call	_delay_ms
3511  0392 acaf08af      	jpf	L1771
3512  0396               L7202:
3513                     ; 303 	else if(UIB[1]==11)
3515  0396 c60001        	ld	a,_UIB+1
3516  0399 a10b          	cp	a,#11
3517  039b 2633          	jrne	L7302
3518                     ; 309 		for(i=0;i<256;i++)buff[i]=0;
3520  039d 5f            	clrw	x
3521  039e 1f03          	ldw	(OFST-1,sp),x
3522  03a0               L1402:
3525  03a0 1e03          	ldw	x,(OFST-1,sp)
3526  03a2 724f0050      	clr	(_buff,x)
3529  03a6 1e03          	ldw	x,(OFST-1,sp)
3530  03a8 1c0001        	addw	x,#1
3531  03ab 1f03          	ldw	(OFST-1,sp),x
3534  03ad 1e03          	ldw	x,(OFST-1,sp)
3535  03af a30100        	cpw	x,#256
3536  03b2 25ec          	jrult	L1402
3537                     ; 311 		if(UIB[2]==1)DF_buffer_write(/*1,*/0,256, buff);
3539  03b4 c60002        	ld	a,_UIB+2
3540  03b7 a101          	cp	a,#1
3541  03b9 2703          	jreq	L44
3542  03bb cc08af        	jp	L1771
3543  03be               L44:
3546  03be ae0050        	ldw	x,#_buff
3547  03c1 89            	pushw	x
3548  03c2 ae0100        	ldw	x,#256
3549  03c5 89            	pushw	x
3550  03c6 5f            	clrw	x
3551  03c7 cd0b65        	call	_DF_buffer_write
3553  03ca 5b04          	addw	sp,#4
3554  03cc acaf08af      	jpf	L1771
3555  03d0               L7302:
3556                     ; 315 	else if(UIB[1]==12)
3558  03d0 c60001        	ld	a,_UIB+1
3559  03d3 a10c          	cp	a,#12
3560  03d5 2703          	jreq	L64
3561  03d7 cc04b6        	jp	L3502
3562  03da               L64:
3563                     ; 321 		for(i=0;i<256;i++)buff[i]=0;
3565  03da 5f            	clrw	x
3566  03db 1f03          	ldw	(OFST-1,sp),x
3567  03dd               L5502:
3570  03dd 1e03          	ldw	x,(OFST-1,sp)
3571  03df 724f0050      	clr	(_buff,x)
3574  03e3 1e03          	ldw	x,(OFST-1,sp)
3575  03e5 1c0001        	addw	x,#1
3576  03e8 1f03          	ldw	(OFST-1,sp),x
3579  03ea 1e03          	ldw	x,(OFST-1,sp)
3580  03ec a30100        	cpw	x,#256
3581  03ef 25ec          	jrult	L5502
3582                     ; 323 		if(UIB[3]==1)
3584  03f1 c60003        	ld	a,_UIB+3
3585  03f4 a101          	cp	a,#1
3586  03f6 2632          	jrne	L3602
3587                     ; 325 			buff[0]=0x00;
3589  03f8 725f0050      	clr	_buff
3590                     ; 326 			buff[1]=0x11;
3592  03fc 35110051      	mov	_buff+1,#17
3593                     ; 327 			buff[2]=0x22;
3595  0400 35220052      	mov	_buff+2,#34
3596                     ; 328 			buff[3]=0x33;
3598  0404 35330053      	mov	_buff+3,#51
3599                     ; 329 			buff[4]=0x44;
3601  0408 35440054      	mov	_buff+4,#68
3602                     ; 330 			buff[5]=0x55;
3604  040c 35550055      	mov	_buff+5,#85
3605                     ; 331 			buff[6]=0x66;
3607  0410 35660056      	mov	_buff+6,#102
3608                     ; 332 			buff[7]=0x77;
3610  0414 35770057      	mov	_buff+7,#119
3611                     ; 333 			buff[8]=0x88;
3613  0418 35880058      	mov	_buff+8,#136
3614                     ; 334 			buff[9]=0x99;
3616  041c 35990059      	mov	_buff+9,#153
3617                     ; 335 			buff[10]=0;
3619  0420 725f005a      	clr	_buff+10
3620                     ; 336 			buff[11]=0;
3622  0424 725f005b      	clr	_buff+11
3624  0428 2070          	jra	L5602
3625  042a               L3602:
3626                     ; 339 		else if(UIB[3]==2)
3628  042a c60003        	ld	a,_UIB+3
3629  042d a102          	cp	a,#2
3630  042f 2632          	jrne	L7602
3631                     ; 341 			buff[0]=0x00;
3633  0431 725f0050      	clr	_buff
3634                     ; 342 			buff[1]=0x10;
3636  0435 35100051      	mov	_buff+1,#16
3637                     ; 343 			buff[2]=0x20;
3639  0439 35200052      	mov	_buff+2,#32
3640                     ; 344 			buff[3]=0x30;
3642  043d 35300053      	mov	_buff+3,#48
3643                     ; 345 			buff[4]=0x40;
3645  0441 35400054      	mov	_buff+4,#64
3646                     ; 346 			buff[5]=0x50;
3648  0445 35500055      	mov	_buff+5,#80
3649                     ; 347 			buff[6]=0x60;
3651  0449 35600056      	mov	_buff+6,#96
3652                     ; 348 			buff[7]=0x70;
3654  044d 35700057      	mov	_buff+7,#112
3655                     ; 349 			buff[8]=0x80;
3657  0451 35800058      	mov	_buff+8,#128
3658                     ; 350 			buff[9]=0x90;
3660  0455 35900059      	mov	_buff+9,#144
3661                     ; 351 			buff[10]=0;
3663  0459 725f005a      	clr	_buff+10
3664                     ; 352 			buff[11]=0;
3666  045d 725f005b      	clr	_buff+11
3668  0461 2037          	jra	L5602
3669  0463               L7602:
3670                     ; 355 		else if(UIB[3]==3)
3672  0463 c60003        	ld	a,_UIB+3
3673  0466 a103          	cp	a,#3
3674  0468 2630          	jrne	L5602
3675                     ; 357 			buff[0]=0x98;
3677  046a 35980050      	mov	_buff,#152
3678                     ; 358 			buff[1]=0x87;
3680  046e 35870051      	mov	_buff+1,#135
3681                     ; 359 			buff[2]=0x76;
3683  0472 35760052      	mov	_buff+2,#118
3684                     ; 360 			buff[3]=0x65;
3686  0476 35650053      	mov	_buff+3,#101
3687                     ; 361 			buff[4]=0x54;
3689  047a 35540054      	mov	_buff+4,#84
3690                     ; 362 			buff[5]=0x43;
3692  047e 35430055      	mov	_buff+5,#67
3693                     ; 363 			buff[6]=0x32;
3695  0482 35320056      	mov	_buff+6,#50
3696                     ; 364 			buff[7]=0x21;
3698  0486 35210057      	mov	_buff+7,#33
3699                     ; 365 			buff[8]=0x10;
3701  048a 35100058      	mov	_buff+8,#16
3702                     ; 366 			buff[9]=0x00;
3704  048e 725f0059      	clr	_buff+9
3705                     ; 367 			buff[10]=0;
3707  0492 725f005a      	clr	_buff+10
3708                     ; 368 			buff[11]=0;
3710  0496 725f005b      	clr	_buff+11
3711  049a               L5602:
3712                     ; 370 		if(UIB[2]==1)DF_buffer_write(/*1,*/0,256, buff);
3714  049a c60002        	ld	a,_UIB+2
3715  049d a101          	cp	a,#1
3716  049f 2703          	jreq	L05
3717  04a1 cc08af        	jp	L1771
3718  04a4               L05:
3721  04a4 ae0050        	ldw	x,#_buff
3722  04a7 89            	pushw	x
3723  04a8 ae0100        	ldw	x,#256
3724  04ab 89            	pushw	x
3725  04ac 5f            	clrw	x
3726  04ad cd0b65        	call	_DF_buffer_write
3728  04b0 5b04          	addw	sp,#4
3729  04b2 acaf08af      	jpf	L1771
3730  04b6               L3502:
3731                     ; 374 	else if(UIB[1]==13)
3733  04b6 c60001        	ld	a,_UIB+1
3734  04b9 a10d          	cp	a,#13
3735  04bb 2703cc0559    	jrne	L1012
3736                     ; 379 		if(memory_manufacturer=='A') {	
3738  04c0 b6bc          	ld	a,_memory_manufacturer
3739  04c2 a141          	cp	a,#65
3740  04c4 2608          	jrne	L3012
3741                     ; 380 			DF_page_to_buffer(/*UIB[2],*/UIB[3]);
3743  04c6 c60003        	ld	a,_UIB+3
3744  04c9 5f            	clrw	x
3745  04ca 97            	ld	xl,a
3746  04cb cd0ad9        	call	_DF_page_to_buffer
3748  04ce               L3012:
3749                     ; 382 		if(memory_manufacturer=='S') {
3751  04ce b6bc          	ld	a,_memory_manufacturer
3752  04d0 a153          	cp	a,#83
3753  04d2 2703          	jreq	L25
3754  04d4 cc08af        	jp	L1771
3755  04d7               L25:
3756                     ; 383 			current_page=11;
3758  04d7 ae000b        	ldw	x,#11
3759  04da bf11          	ldw	_current_page,x
3760                     ; 384 			ST_READ((long)(current_page*256),256, buff);
3762  04dc ae0050        	ldw	x,#_buff
3763  04df 89            	pushw	x
3764  04e0 ae0100        	ldw	x,#256
3765  04e3 89            	pushw	x
3766  04e4 ae0b00        	ldw	x,#2816
3767  04e7 89            	pushw	x
3768  04e8 ae0000        	ldw	x,#0
3769  04eb 89            	pushw	x
3770  04ec cd0a1d        	call	_ST_READ
3772  04ef 5b08          	addw	sp,#8
3773                     ; 386 			uart_out_adr_block (0,buff,64);
3775  04f1 4b40          	push	#64
3776  04f3 ae0050        	ldw	x,#_buff
3777  04f6 89            	pushw	x
3778  04f7 ae0000        	ldw	x,#0
3779  04fa 89            	pushw	x
3780  04fb ae0000        	ldw	x,#0
3781  04fe 89            	pushw	x
3782  04ff cd017c        	call	_uart_out_adr_block
3784  0502 5b07          	addw	sp,#7
3785                     ; 387 			delay_ms(100);    
3787  0504 ae0064        	ldw	x,#100
3788  0507 cd0060        	call	_delay_ms
3790                     ; 388 			uart_out_adr_block (64,&buff[64],64);
3792  050a 4b40          	push	#64
3793  050c ae0090        	ldw	x,#_buff+64
3794  050f 89            	pushw	x
3795  0510 ae0040        	ldw	x,#64
3796  0513 89            	pushw	x
3797  0514 ae0000        	ldw	x,#0
3798  0517 89            	pushw	x
3799  0518 cd017c        	call	_uart_out_adr_block
3801  051b 5b07          	addw	sp,#7
3802                     ; 389 			delay_ms(100);    
3804  051d ae0064        	ldw	x,#100
3805  0520 cd0060        	call	_delay_ms
3807                     ; 390 			uart_out_adr_block (128,&buff[128],64);
3809  0523 4b40          	push	#64
3810  0525 ae00d0        	ldw	x,#_buff+128
3811  0528 89            	pushw	x
3812  0529 ae0080        	ldw	x,#128
3813  052c 89            	pushw	x
3814  052d ae0000        	ldw	x,#0
3815  0530 89            	pushw	x
3816  0531 cd017c        	call	_uart_out_adr_block
3818  0534 5b07          	addw	sp,#7
3819                     ; 391 			delay_ms(100);    
3821  0536 ae0064        	ldw	x,#100
3822  0539 cd0060        	call	_delay_ms
3824                     ; 392 			uart_out_adr_block (192,&buff[192],64);
3826  053c 4b40          	push	#64
3827  053e ae0110        	ldw	x,#_buff+192
3828  0541 89            	pushw	x
3829  0542 ae00c0        	ldw	x,#192
3830  0545 89            	pushw	x
3831  0546 ae0000        	ldw	x,#0
3832  0549 89            	pushw	x
3833  054a cd017c        	call	_uart_out_adr_block
3835  054d 5b07          	addw	sp,#7
3836                     ; 393 			delay_ms(100); 
3838  054f ae0064        	ldw	x,#100
3839  0552 cd0060        	call	_delay_ms
3841  0555 acaf08af      	jpf	L1771
3842  0559               L1012:
3843                     ; 396 	else if(UIB[1]==14)
3845  0559 c60001        	ld	a,_UIB+1
3846  055c a10e          	cp	a,#14
3847  055e 265b          	jrne	L1112
3848                     ; 401 		if(memory_manufacturer=='A') {	
3850  0560 b6bc          	ld	a,_memory_manufacturer
3851  0562 a141          	cp	a,#65
3852  0564 2608          	jrne	L3112
3853                     ; 402 			DF_buffer_to_page_er(/*UIB[2],*/UIB[3]);
3855  0566 c60003        	ld	a,_UIB+3
3856  0569 5f            	clrw	x
3857  056a 97            	ld	xl,a
3858  056b cd0afc        	call	_DF_buffer_to_page_er
3860  056e               L3112:
3861                     ; 404 		if(memory_manufacturer=='S') {
3863  056e b6bc          	ld	a,_memory_manufacturer
3864  0570 a153          	cp	a,#83
3865  0572 2703          	jreq	L45
3866  0574 cc08af        	jp	L1771
3867  0577               L45:
3868                     ; 405 			for(i=0;i<256;i++) {
3870  0577 5f            	clrw	x
3871  0578 1f03          	ldw	(OFST-1,sp),x
3872  057a               L7112:
3873                     ; 406 				buff[i]=(char)i;
3875  057a 7b04          	ld	a,(OFST+0,sp)
3876  057c 1e03          	ldw	x,(OFST-1,sp)
3877  057e d70050        	ld	(_buff,x),a
3878                     ; 405 			for(i=0;i<256;i++) {
3880  0581 1e03          	ldw	x,(OFST-1,sp)
3881  0583 1c0001        	addw	x,#1
3882  0586 1f03          	ldw	(OFST-1,sp),x
3885  0588 1e03          	ldw	x,(OFST-1,sp)
3886  058a a30100        	cpw	x,#256
3887  058d 25eb          	jrult	L7112
3888                     ; 408 			current_page=11;
3890  058f ae000b        	ldw	x,#11
3891  0592 bf11          	ldw	_current_page,x
3892                     ; 409 			ST_WREN();
3894  0594 cd09c4        	call	_ST_WREN
3896                     ; 410 			delay_ms(100);
3898  0597 ae0064        	ldw	x,#100
3899  059a cd0060        	call	_delay_ms
3901                     ; 411 			ST_WRITE((long)(current_page*256),256,buff);		
3903  059d ae0050        	ldw	x,#_buff
3904  05a0 89            	pushw	x
3905  05a1 ae0100        	ldw	x,#256
3906  05a4 89            	pushw	x
3907  05a5 be11          	ldw	x,_current_page
3908  05a7 4f            	clr	a
3909  05a8 02            	rlwa	x,a
3910  05a9 cd0000        	call	c_uitolx
3912  05ac be02          	ldw	x,c_lreg+2
3913  05ae 89            	pushw	x
3914  05af be00          	ldw	x,c_lreg
3915  05b1 89            	pushw	x
3916  05b2 cd09d1        	call	_ST_WRITE
3918  05b5 5b08          	addw	sp,#8
3919  05b7 acaf08af      	jpf	L1771
3920  05bb               L1112:
3921                     ; 416 	else if(UIB[1]==20)
3923  05bb c60001        	ld	a,_UIB+1
3924  05be a114          	cp	a,#20
3925  05c0 2703          	jreq	L65
3926  05c2 cc0658        	jp	L7212
3927  05c5               L65:
3928                     ; 420         CS_ON  
3930  05c5 7217500a      	bres	20490,#3
3931                     ; 421 		file_lengt=0;
3933  05c9 ae0000        	ldw	x,#0
3934  05cc bf0b          	ldw	_file_lengt+2,x
3935  05ce ae0000        	ldw	x,#0
3936  05d1 bf09          	ldw	_file_lengt,x
3937                     ; 422 		file_lengt+=UIB[5];
3939  05d3 c60005        	ld	a,_UIB+5
3940  05d6 ae0009        	ldw	x,#_file_lengt
3941  05d9 88            	push	a
3942  05da cd0000        	call	c_lgadc
3944  05dd 84            	pop	a
3945                     ; 423 		file_lengt<<=8;
3947  05de ae0009        	ldw	x,#_file_lengt
3948  05e1 a608          	ld	a,#8
3949  05e3 cd0000        	call	c_lglsh
3951                     ; 424 		file_lengt+=UIB[4];
3953  05e6 c60004        	ld	a,_UIB+4
3954  05e9 ae0009        	ldw	x,#_file_lengt
3955  05ec 88            	push	a
3956  05ed cd0000        	call	c_lgadc
3958  05f0 84            	pop	a
3959                     ; 425 		file_lengt<<=8;
3961  05f1 ae0009        	ldw	x,#_file_lengt
3962  05f4 a608          	ld	a,#8
3963  05f6 cd0000        	call	c_lglsh
3965                     ; 426 		file_lengt+=UIB[3];
3967  05f9 c60003        	ld	a,_UIB+3
3968  05fc ae0009        	ldw	x,#_file_lengt
3969  05ff 88            	push	a
3970  0600 cd0000        	call	c_lgadc
3972  0603 84            	pop	a
3973                     ; 427 		file_lengt_in_pages=file_lengt;
3975  0604 be0b          	ldw	x,_file_lengt+2
3976  0606 bf13          	ldw	_file_lengt_in_pages,x
3977                     ; 428 		file_lengt<<=8;
3979  0608 ae0009        	ldw	x,#_file_lengt
3980  060b a608          	ld	a,#8
3981  060d cd0000        	call	c_lglsh
3983                     ; 429 		file_lengt+=UIB[2];
3985  0610 c60002        	ld	a,_UIB+2
3986  0613 ae0009        	ldw	x,#_file_lengt
3987  0616 88            	push	a
3988  0617 cd0000        	call	c_lgadc
3990  061a 84            	pop	a
3991                     ; 434 		current_page=0;
3993  061b 5f            	clrw	x
3994  061c bf11          	ldw	_current_page,x
3995                     ; 435 		current_byte_in_buffer=0;
3997  061e 5f            	clrw	x
3998  061f bf0d          	ldw	_current_byte_in_buffer,x
3999                     ; 437 		if(memory_manufacturer=='S') {
4001  0621 b6bc          	ld	a,_memory_manufacturer
4002  0623 a153          	cp	a,#83
4003  0625 260c          	jrne	L1312
4004                     ; 438 			ST_WREN();
4006  0627 cd09c4        	call	_ST_WREN
4008                     ; 439 					delay_ms(100); 
4010  062a ae0064        	ldw	x,#100
4011  062d cd0060        	call	_delay_ms
4013                     ; 440 		ST_bulk_erase();
4015  0630 cd09b7        	call	_ST_bulk_erase
4017  0633               L1312:
4018                     ; 442 		uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
4020  0633 4b00          	push	#0
4021  0635 4b00          	push	#0
4022  0637 3b0011        	push	_current_page
4023  063a b612          	ld	a,_current_page+1
4024  063c a4ff          	and	a,#255
4025  063e 88            	push	a
4026  063f 4b15          	push	#21
4027  0641 ae0016        	ldw	x,#22
4028  0644 a604          	ld	a,#4
4029  0646 95            	ld	xh,a
4030  0647 cd00d2        	call	_uart_out
4032  064a 5b05          	addw	sp,#5
4033                     ; 443 		current_page_cnt=10;
4035  064c 350a0001      	mov	_current_page_cnt,#10
4036                     ; 444 		current_page_cnt_=4;
4038  0650 35040000      	mov	_current_page_cnt_,#4
4040  0654 acaf08af      	jpf	L1771
4041  0658               L7212:
4042                     ; 447 	else if(UIB[1]==21) 
4044  0658 c60001        	ld	a,_UIB+1
4045  065b a115          	cp	a,#21
4046  065d 2703          	jreq	L06
4047  065f cc0774        	jp	L5312
4048  0662               L06:
4049                     ; 454 		if(current_page_cnt_)
4051  0662 3d00          	tnz	_current_page_cnt_
4052  0664 270a          	jreq	L7312
4053                     ; 456 			current_page_cnt_--;
4055  0666 3a00          	dec	_current_page_cnt_
4056                     ; 457 			if(current_page_cnt_==0)
4058  0668 3d00          	tnz	_current_page_cnt_
4059  066a 2606          	jrne	L3412
4060                     ; 459 				current_page_cnt=0;	
4062  066c 3f01          	clr	_current_page_cnt
4063  066e 2002          	jra	L3412
4064  0670               L7312:
4065                     ; 464 			current_page_cnt=0;
4067  0670 3f01          	clr	_current_page_cnt
4068  0672               L3412:
4069                     ; 469           for(i=0;i<64;i++)
4071  0672 5f            	clrw	x
4072  0673 1f03          	ldw	(OFST-1,sp),x
4073  0675               L5412:
4074                     ; 471           	buff[current_byte_in_buffer+i]=UIB[2+i];
4076  0675 1e03          	ldw	x,(OFST-1,sp)
4077  0677 d60002        	ld	a,(_UIB+2,x)
4078  067a be0d          	ldw	x,_current_byte_in_buffer
4079  067c 72fb03        	addw	x,(OFST-1,sp)
4080  067f d70050        	ld	(_buff,x),a
4081                     ; 469           for(i=0;i<64;i++)
4083  0682 1e03          	ldw	x,(OFST-1,sp)
4084  0684 1c0001        	addw	x,#1
4085  0687 1f03          	ldw	(OFST-1,sp),x
4088  0689 1e03          	ldw	x,(OFST-1,sp)
4089  068b a30040        	cpw	x,#64
4090  068e 25e5          	jrult	L5412
4091                     ; 473           current_byte_in_buffer+=64;
4093  0690 be0d          	ldw	x,_current_byte_in_buffer
4094  0692 1c0040        	addw	x,#64
4095  0695 bf0d          	ldw	_current_byte_in_buffer,x
4096                     ; 474           if(current_byte_in_buffer>=256)
4098  0697 be0d          	ldw	x,_current_byte_in_buffer
4099  0699 a30100        	cpw	x,#256
4100  069c 2403          	jruge	L26
4101  069e cc08af        	jp	L1771
4102  06a1               L26:
4103                     ; 481           	CS_FLASH
4105  06a1 c6500a        	ld	a,20490
4106  06a4 a808          	xor	a,	#8
4107  06a6 c7500a        	ld	20490,a
4108                     ; 482 			if(memory_manufacturer=='A') {
4110  06a9 b6bc          	ld	a,_memory_manufacturer
4111  06ab a141          	cp	a,#65
4112  06ad 264e          	jrne	L5512
4113                     ; 483 				DF_buffer_write(/*//current_buffer*//*1,*/0,256,buff);
4115  06af ae0050        	ldw	x,#_buff
4116  06b2 89            	pushw	x
4117  06b3 ae0100        	ldw	x,#256
4118  06b6 89            	pushw	x
4119  06b7 5f            	clrw	x
4120  06b8 cd0b65        	call	_DF_buffer_write
4122  06bb 5b04          	addw	sp,#4
4123                     ; 484 				DF_buffer_to_page_er(/*///current_buffer*//*1,*/current_page);
4125  06bd be11          	ldw	x,_current_page
4126  06bf cd0afc        	call	_DF_buffer_to_page_er
4128                     ; 485 				current_page++;
4130  06c2 be11          	ldw	x,_current_page
4131  06c4 1c0001        	addw	x,#1
4132  06c7 bf11          	ldw	_current_page,x
4133                     ; 486 				if(current_page<file_lengt_in_pages)
4135  06c9 be11          	ldw	x,_current_page
4136  06cb b313          	cpw	x,_file_lengt_in_pages
4137  06cd 2424          	jruge	L7512
4138                     ; 488 					delay_ms(100);
4140  06cf ae0064        	ldw	x,#100
4141  06d2 cd0060        	call	_delay_ms
4143                     ; 489 					uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
4145  06d5 4b00          	push	#0
4146  06d7 4b00          	push	#0
4147  06d9 3b0011        	push	_current_page
4148  06dc b612          	ld	a,_current_page+1
4149  06de a4ff          	and	a,#255
4150  06e0 88            	push	a
4151  06e1 4b15          	push	#21
4152  06e3 ae0016        	ldw	x,#22
4153  06e6 a604          	ld	a,#4
4154  06e8 95            	ld	xh,a
4155  06e9 cd00d2        	call	_uart_out
4157  06ec 5b05          	addw	sp,#5
4158                     ; 490 					current_byte_in_buffer=0;
4160  06ee 5f            	clrw	x
4161  06ef bf0d          	ldw	_current_byte_in_buffer,x
4163  06f1 200a          	jra	L5512
4164  06f3               L7512:
4165                     ; 494 					EE_PAGE_LEN=current_page;
4167  06f3 be11          	ldw	x,_current_page
4168  06f5 89            	pushw	x
4169  06f6 ae0000        	ldw	x,#_EE_PAGE_LEN
4170  06f9 cd0000        	call	c_eewrw
4172  06fc 85            	popw	x
4173  06fd               L5512:
4174                     ; 497 			if(memory_manufacturer=='S') {
4176  06fd b6bc          	ld	a,_memory_manufacturer
4177  06ff a153          	cp	a,#83
4178  0701 2703          	jreq	L46
4179  0703 cc08af        	jp	L1771
4180  0706               L46:
4181                     ; 498 				ST_WREN();
4183  0706 cd09c4        	call	_ST_WREN
4185                     ; 499 				delay_ms(100);
4187  0709 ae0064        	ldw	x,#100
4188  070c cd0060        	call	_delay_ms
4190                     ; 500 				ST_WRITE((unsigned long)(current_page*256UL),256,buff);
4192  070f ae0050        	ldw	x,#_buff
4193  0712 89            	pushw	x
4194  0713 ae0100        	ldw	x,#256
4195  0716 89            	pushw	x
4196  0717 be11          	ldw	x,_current_page
4197  0719 90ae0100      	ldw	y,#256
4198  071d cd0000        	call	c_umul
4200  0720 be02          	ldw	x,c_lreg+2
4201  0722 89            	pushw	x
4202  0723 be00          	ldw	x,c_lreg
4203  0725 89            	pushw	x
4204  0726 cd09d1        	call	_ST_WRITE
4206  0729 5b08          	addw	sp,#8
4207                     ; 501 				current_page++;
4209  072b be11          	ldw	x,_current_page
4210  072d 1c0001        	addw	x,#1
4211  0730 bf11          	ldw	_current_page,x
4212                     ; 502 				if(current_page<file_lengt_in_pages)
4214  0732 be11          	ldw	x,_current_page
4215  0734 b313          	cpw	x,_file_lengt_in_pages
4216  0736 242e          	jruge	L5612
4217                     ; 504 					delay_ms(100);
4219  0738 ae0064        	ldw	x,#100
4220  073b cd0060        	call	_delay_ms
4222                     ; 505 					uart_out (5,CMND,21,current_page%256,current_page/256,0,0);
4224  073e 4b00          	push	#0
4225  0740 4b00          	push	#0
4226  0742 3b0011        	push	_current_page
4227  0745 b612          	ld	a,_current_page+1
4228  0747 a4ff          	and	a,#255
4229  0749 88            	push	a
4230  074a 4b15          	push	#21
4231  074c ae0016        	ldw	x,#22
4232  074f a605          	ld	a,#5
4233  0751 95            	ld	xh,a
4234  0752 cd00d2        	call	_uart_out
4236  0755 5b05          	addw	sp,#5
4237                     ; 506 					current_page_cnt=10;
4239  0757 350a0001      	mov	_current_page_cnt,#10
4240                     ; 507 					current_page_cnt_=4;
4242  075b 35040000      	mov	_current_page_cnt_,#4
4243                     ; 508 					current_byte_in_buffer=0;
4245  075f 5f            	clrw	x
4246  0760 bf0d          	ldw	_current_byte_in_buffer,x
4248  0762 acaf08af      	jpf	L1771
4249  0766               L5612:
4250                     ; 512 					EE_PAGE_LEN=current_page;
4252  0766 be11          	ldw	x,_current_page
4253  0768 89            	pushw	x
4254  0769 ae0000        	ldw	x,#_EE_PAGE_LEN
4255  076c cd0000        	call	c_eewrw
4257  076f 85            	popw	x
4258  0770 acaf08af      	jpf	L1771
4259  0774               L5312:
4260                     ; 523 	else if(UIB[1]==24) {
4262  0774 c60001        	ld	a,_UIB+1
4263  0777 a118          	cp	a,#24
4264  0779 2615          	jrne	L3712
4265                     ; 526 		rele_cnt=10;
4267  077b ae000a        	ldw	x,#10
4268  077e bf05          	ldw	_rele_cnt,x
4269                     ; 527 		ST_WREN();
4271  0780 cd09c4        	call	_ST_WREN
4273                     ; 528 		delay_ms(100);
4275  0783 ae0064        	ldw	x,#100
4276  0786 cd0060        	call	_delay_ms
4278                     ; 529 		ST_bulk_erase();
4280  0789 cd09b7        	call	_ST_bulk_erase
4283  078c acaf08af      	jpf	L1771
4284  0790               L3712:
4285                     ; 534 	else if(UIB[1]==25)
4287  0790 c60001        	ld	a,_UIB+1
4288  0793 a119          	cp	a,#25
4289  0795 2703          	jreq	L66
4290  0797 cc0877        	jp	L7712
4291  079a               L66:
4292                     ; 538 		current_page=0;
4294  079a 5f            	clrw	x
4295  079b bf11          	ldw	_current_page,x
4296                     ; 540 		for(i__=0;i__<EE_PAGE_LEN;i__++)
4298  079d 5f            	clrw	x
4299  079e 1f03          	ldw	(OFST-1,sp),x
4301  07a0 ac6b086b      	jpf	L5022
4302  07a4               L1022:
4303                     ; 542 			if(memory_manufacturer=='S') {	
4305  07a4 b6bc          	ld	a,_memory_manufacturer
4306  07a6 a153          	cp	a,#83
4307  07a8 2619          	jrne	L1122
4308                     ; 543 				DF_page_to_buffer(i__);
4310  07aa 1e03          	ldw	x,(OFST-1,sp)
4311  07ac cd0ad9        	call	_DF_page_to_buffer
4313                     ; 544 				delay_ms(100);			
4315  07af ae0064        	ldw	x,#100
4316  07b2 cd0060        	call	_delay_ms
4318                     ; 545 				DF_buffer_read(0,256, buff);
4320  07b5 ae0050        	ldw	x,#_buff
4321  07b8 89            	pushw	x
4322  07b9 ae0100        	ldw	x,#256
4323  07bc 89            	pushw	x
4324  07bd 5f            	clrw	x
4325  07be cd0b1f        	call	_DF_buffer_read
4327  07c1 5b04          	addw	sp,#4
4328  07c3               L1122:
4329                     ; 548 			if(memory_manufacturer=='S') {	
4331  07c3 b6bc          	ld	a,_memory_manufacturer
4332  07c5 a153          	cp	a,#83
4333  07c7 261a          	jrne	L3122
4334                     ; 549 				ST_READ((long)(i__*256),256, buff);
4336  07c9 ae0050        	ldw	x,#_buff
4337  07cc 89            	pushw	x
4338  07cd ae0100        	ldw	x,#256
4339  07d0 89            	pushw	x
4340  07d1 1e07          	ldw	x,(OFST+3,sp)
4341  07d3 4f            	clr	a
4342  07d4 02            	rlwa	x,a
4343  07d5 cd0000        	call	c_itolx
4345  07d8 be02          	ldw	x,c_lreg+2
4346  07da 89            	pushw	x
4347  07db be00          	ldw	x,c_lreg
4348  07dd 89            	pushw	x
4349  07de cd0a1d        	call	_ST_READ
4351  07e1 5b08          	addw	sp,#8
4352  07e3               L3122:
4353                     ; 552 			uart_out_adr_block ((256*i__)+0,buff,64);
4355  07e3 4b40          	push	#64
4356  07e5 ae0050        	ldw	x,#_buff
4357  07e8 89            	pushw	x
4358  07e9 1e06          	ldw	x,(OFST+2,sp)
4359  07eb 4f            	clr	a
4360  07ec 02            	rlwa	x,a
4361  07ed cd0000        	call	c_itolx
4363  07f0 be02          	ldw	x,c_lreg+2
4364  07f2 89            	pushw	x
4365  07f3 be00          	ldw	x,c_lreg
4366  07f5 89            	pushw	x
4367  07f6 cd017c        	call	_uart_out_adr_block
4369  07f9 5b07          	addw	sp,#7
4370                     ; 553 			delay_ms(100);    
4372  07fb ae0064        	ldw	x,#100
4373  07fe cd0060        	call	_delay_ms
4375                     ; 554 			uart_out_adr_block ((256*i__)+64,&buff[64],64);
4377  0801 4b40          	push	#64
4378  0803 ae0090        	ldw	x,#_buff+64
4379  0806 89            	pushw	x
4380  0807 1e06          	ldw	x,(OFST+2,sp)
4381  0809 4f            	clr	a
4382  080a 02            	rlwa	x,a
4383  080b 1c0040        	addw	x,#64
4384  080e cd0000        	call	c_itolx
4386  0811 be02          	ldw	x,c_lreg+2
4387  0813 89            	pushw	x
4388  0814 be00          	ldw	x,c_lreg
4389  0816 89            	pushw	x
4390  0817 cd017c        	call	_uart_out_adr_block
4392  081a 5b07          	addw	sp,#7
4393                     ; 555 			delay_ms(100);    
4395  081c ae0064        	ldw	x,#100
4396  081f cd0060        	call	_delay_ms
4398                     ; 556 			uart_out_adr_block ((256*i__)+128,&buff[128],64);
4400  0822 4b40          	push	#64
4401  0824 ae00d0        	ldw	x,#_buff+128
4402  0827 89            	pushw	x
4403  0828 1e06          	ldw	x,(OFST+2,sp)
4404  082a 4f            	clr	a
4405  082b 02            	rlwa	x,a
4406  082c 1c0080        	addw	x,#128
4407  082f cd0000        	call	c_itolx
4409  0832 be02          	ldw	x,c_lreg+2
4410  0834 89            	pushw	x
4411  0835 be00          	ldw	x,c_lreg
4412  0837 89            	pushw	x
4413  0838 cd017c        	call	_uart_out_adr_block
4415  083b 5b07          	addw	sp,#7
4416                     ; 557 			delay_ms(100);    
4418  083d ae0064        	ldw	x,#100
4419  0840 cd0060        	call	_delay_ms
4421                     ; 558 			uart_out_adr_block ((256*i__)+192,&buff[192],64);
4423  0843 4b40          	push	#64
4424  0845 ae0110        	ldw	x,#_buff+192
4425  0848 89            	pushw	x
4426  0849 1e06          	ldw	x,(OFST+2,sp)
4427  084b 4f            	clr	a
4428  084c 02            	rlwa	x,a
4429  084d 1c00c0        	addw	x,#192
4430  0850 cd0000        	call	c_itolx
4432  0853 be02          	ldw	x,c_lreg+2
4433  0855 89            	pushw	x
4434  0856 be00          	ldw	x,c_lreg
4435  0858 89            	pushw	x
4436  0859 cd017c        	call	_uart_out_adr_block
4438  085c 5b07          	addw	sp,#7
4439                     ; 559 			delay_ms(100);   
4441  085e ae0064        	ldw	x,#100
4442  0861 cd0060        	call	_delay_ms
4444                     ; 540 		for(i__=0;i__<EE_PAGE_LEN;i__++)
4446  0864 1e03          	ldw	x,(OFST-1,sp)
4447  0866 1c0001        	addw	x,#1
4448  0869 1f03          	ldw	(OFST-1,sp),x
4449  086b               L5022:
4452  086b 1e03          	ldw	x,(OFST-1,sp)
4453  086d c30000        	cpw	x,_EE_PAGE_LEN
4454  0870 2403          	jruge	L07
4455  0872 cc07a4        	jp	L1022
4456  0875               L07:
4458  0875 2038          	jra	L1771
4459  0877               L7712:
4460                     ; 566 	else if(UIB[1]==26)		//Запрос телеметрии
4462  0877 c60001        	ld	a,_UIB+1
4463  087a a11a          	cp	a,#26
4464  087c 2619          	jrne	L7122
4465                     ; 569 		uart_out (4,CMND,26,current_page_cnt,current_page_cnt_,0,0);    
4467  087e 4b00          	push	#0
4468  0880 4b00          	push	#0
4469  0882 3b0000        	push	_current_page_cnt_
4470  0885 3b0001        	push	_current_page_cnt
4471  0888 4b1a          	push	#26
4472  088a ae0016        	ldw	x,#22
4473  088d a604          	ld	a,#4
4474  088f 95            	ld	xh,a
4475  0890 cd00d2        	call	_uart_out
4477  0893 5b05          	addw	sp,#5
4479  0895 2018          	jra	L1771
4480  0897               L7122:
4481                     ; 573 	else if(UIB[1]==30)
4483  0897 c60001        	ld	a,_UIB+1
4484  089a a11e          	cp	a,#30
4485  089c 2606          	jrne	L3222
4486                     ; 595           bSTART=1;
4488  089e 7210000c      	bset	_bSTART
4490  08a2 200b          	jra	L1771
4491  08a4               L3222:
4492                     ; 607 	else if(UIB[1]==40)
4494  08a4 c60001        	ld	a,_UIB+1
4495  08a7 a128          	cp	a,#40
4496  08a9 2604          	jrne	L1771
4497                     ; 629 		bSTART=1;	
4499  08ab 7210000c      	bset	_bSTART
4500  08af               L1771:
4501                     ; 634 }
4504  08af 5b04          	addw	sp,#4
4505  08b1 81            	ret
4542                     ; 637 void putchar(char c)
4542                     ; 638 {
4543                     	switch	.text
4544  08b2               _putchar:
4546  08b2 88            	push	a
4547       00000000      OFST:	set	0
4550  08b3               L1522:
4551                     ; 639 while (tx_counter == TX_BUFFER_SIZE);
4553  08b3 b622          	ld	a,_tx_counter
4554  08b5 a150          	cp	a,#80
4555  08b7 27fa          	jreq	L1522
4556                     ; 641 if (tx_counter || ((UART1->SR & UART1_SR_TXE)==0))
4558  08b9 3d22          	tnz	_tx_counter
4559  08bb 2607          	jrne	L7522
4561  08bd c65230        	ld	a,21040
4562  08c0 a580          	bcp	a,#128
4563  08c2 261d          	jrne	L5522
4564  08c4               L7522:
4565                     ; 643    tx_buffer[tx_wr_index]=c;
4567  08c4 5f            	clrw	x
4568  08c5 b621          	ld	a,_tx_wr_index
4569  08c7 2a01          	jrpl	L47
4570  08c9 53            	cplw	x
4571  08ca               L47:
4572  08ca 97            	ld	xl,a
4573  08cb 7b01          	ld	a,(OFST+1,sp)
4574  08cd e704          	ld	(_tx_buffer,x),a
4575                     ; 644    if (++tx_wr_index == TX_BUFFER_SIZE) tx_wr_index=0;
4577  08cf 3c21          	inc	_tx_wr_index
4578  08d1 b621          	ld	a,_tx_wr_index
4579  08d3 a150          	cp	a,#80
4580  08d5 2602          	jrne	L1622
4583  08d7 3f21          	clr	_tx_wr_index
4584  08d9               L1622:
4585                     ; 645    ++tx_counter;
4587  08d9 3c22          	inc	_tx_counter
4589  08db               L3622:
4590                     ; 649 UART1->CR2|= UART1_CR2_TIEN;
4592  08db 721e5235      	bset	21045,#7
4593                     ; 651 }
4596  08df 84            	pop	a
4597  08e0 81            	ret
4598  08e1               L5522:
4599                     ; 647 else UART1->DR=c;
4601  08e1 7b01          	ld	a,(OFST+1,sp)
4602  08e3 c75231        	ld	21041,a
4603  08e6 20f3          	jra	L3622
4626                     ; 654 void spi_init(void){
4627                     	switch	.text
4628  08e8               _spi_init:
4632                     ; 656 	GPIOA->DDR|=(1<<3);
4634  08e8 72165002      	bset	20482,#3
4635                     ; 657 	GPIOA->CR1|=(1<<3);
4637  08ec 72165003      	bset	20483,#3
4638                     ; 658 	GPIOA->CR2&=~(1<<3);
4640  08f0 72175004      	bres	20484,#3
4641                     ; 659 	GPIOA->ODR|=(1<<3);	
4643  08f4 72165000      	bset	20480,#3
4644                     ; 662 	GPIOB->DDR|=(1<<5);
4646  08f8 721a5007      	bset	20487,#5
4647                     ; 663 	GPIOB->CR1|=(1<<5);
4649  08fc 721a5008      	bset	20488,#5
4650                     ; 664 	GPIOB->CR2&=~(1<<5);
4652  0900 721b5009      	bres	20489,#5
4653                     ; 665 	GPIOB->ODR|=(1<<5);	
4655  0904 721a5005      	bset	20485,#5
4656                     ; 667 	GPIOC->DDR|=(1<<3);
4658  0908 7216500c      	bset	20492,#3
4659                     ; 668 	GPIOC->CR1|=(1<<3);
4661  090c 7216500d      	bset	20493,#3
4662                     ; 669 	GPIOC->CR2&=~(1<<3);
4664  0910 7217500e      	bres	20494,#3
4665                     ; 670 	GPIOC->ODR|=(1<<3);	
4667  0914 7216500a      	bset	20490,#3
4668                     ; 672 	GPIOC->DDR|=(1<<5);
4670  0918 721a500c      	bset	20492,#5
4671                     ; 673 	GPIOC->CR1|=(1<<5);
4673  091c 721a500d      	bset	20493,#5
4674                     ; 674 	GPIOC->CR2|=(1<<5);
4676  0920 721a500e      	bset	20494,#5
4677                     ; 675 	GPIOC->ODR|=(1<<5);	
4679  0924 721a500a      	bset	20490,#5
4680                     ; 677 	GPIOC->DDR|=(1<<6);
4682  0928 721c500c      	bset	20492,#6
4683                     ; 678 	GPIOC->CR1|=(1<<6);
4685  092c 721c500d      	bset	20493,#6
4686                     ; 679 	GPIOC->CR2|=(1<<6);
4688  0930 721c500e      	bset	20494,#6
4689                     ; 680 	GPIOC->ODR|=(1<<6);	
4691  0934 721c500a      	bset	20490,#6
4692                     ; 682 	GPIOC->DDR&=~(1<<7);
4694  0938 721f500c      	bres	20492,#7
4695                     ; 683 	GPIOC->CR1&=~(1<<7);
4697  093c 721f500d      	bres	20493,#7
4698                     ; 684 	GPIOC->CR2&=~(1<<7);
4700  0940 721f500e      	bres	20494,#7
4701                     ; 685 	GPIOC->ODR|=(1<<7);	
4703  0944 721e500a      	bset	20490,#7
4704                     ; 687 	SPI->CR1= /*SPI_CR1_LSBFIRST |*/
4704                     ; 688 			SPI_CR1_SPE | 
4704                     ; 689 			( (4<< 3) & SPI_CR1_BR ) |
4704                     ; 690 			SPI_CR1_MSTR |
4704                     ; 691 			SPI_CR1_CPOL |
4704                     ; 692 			SPI_CR1_CPHA; 
4706  0948 35675200      	mov	20992,#103
4707                     ; 694 	SPI->CR2= SPI_CR2_SSM | SPI_CR2_SSI;
4709  094c 35035201      	mov	20993,#3
4710                     ; 695 	SPI->ICR= 0;	
4712  0950 725f5202      	clr	20994
4713                     ; 696 }
4716  0954 81            	ret
4759                     ; 699 char spi(char in){
4760                     	switch	.text
4761  0955               _spi:
4763  0955 88            	push	a
4764  0956 88            	push	a
4765       00000001      OFST:	set	1
4768  0957               L1232:
4769                     ; 701 	while(!((SPI->SR)&SPI_SR_TXE));
4771  0957 c65203        	ld	a,20995
4772  095a a502          	bcp	a,#2
4773  095c 27f9          	jreq	L1232
4774                     ; 702 	SPI->DR=in;
4776  095e 7b02          	ld	a,(OFST+1,sp)
4777  0960 c75204        	ld	20996,a
4779  0963               L1332:
4780                     ; 703 	while(!((SPI->SR)&SPI_SR_RXNE));
4782  0963 c65203        	ld	a,20995
4783  0966 a501          	bcp	a,#1
4784  0968 27f9          	jreq	L1332
4785                     ; 704 	c=SPI->DR;	
4787  096a c65204        	ld	a,20996
4788  096d 6b01          	ld	(OFST+0,sp),a
4789                     ; 705 	return c;
4791  096f 7b01          	ld	a,(OFST+0,sp)
4794  0971 85            	popw	x
4795  0972 81            	ret
4860                     ; 709 long ST_RDID_read(void)
4860                     ; 710 {
4861                     	switch	.text
4862  0973               _ST_RDID_read:
4864  0973 5204          	subw	sp,#4
4865       00000004      OFST:	set	4
4868                     ; 713 d0=0;
4870  0975 0f04          	clr	(OFST+0,sp)
4871                     ; 714 d1=0;
4873                     ; 715 d2=0;
4875                     ; 716 d3=0;
4877                     ; 718 ST_CS_ON
4879  0977 721b5005      	bres	20485,#5
4880                     ; 719 spi(0x9f);
4882  097b a69f          	ld	a,#159
4883  097d add6          	call	_spi
4885                     ; 720 mdr0=spi(0xff);
4887  097f a6ff          	ld	a,#255
4888  0981 add2          	call	_spi
4890  0983 b718          	ld	_mdr0,a
4891                     ; 721 mdr1=spi(0xff);
4893  0985 a6ff          	ld	a,#255
4894  0987 adcc          	call	_spi
4896  0989 b717          	ld	_mdr1,a
4897                     ; 722 mdr2=spi(0xff);
4899  098b a6ff          	ld	a,#255
4900  098d adc6          	call	_spi
4902  098f b716          	ld	_mdr2,a
4903                     ; 725 ST_CS_OFF
4905  0991 721a5005      	bset	20485,#5
4906                     ; 726 return  *((long*)&d0);
4908  0995 96            	ldw	x,sp
4909  0996 1c0004        	addw	x,#OFST+0
4910  0999 cd0000        	call	c_ltor
4914  099c 5b04          	addw	sp,#4
4915  099e 81            	ret
4950                     ; 730 char ST_status_read(void)
4950                     ; 731 {
4951                     	switch	.text
4952  099f               _ST_status_read:
4954  099f 88            	push	a
4955       00000001      OFST:	set	1
4958                     ; 735 ST_CS_ON
4960  09a0 721b5005      	bres	20485,#5
4961                     ; 736 spi(0x05);
4963  09a4 a605          	ld	a,#5
4964  09a6 adad          	call	_spi
4966                     ; 737 d0=spi(0xff);
4968  09a8 a6ff          	ld	a,#255
4969  09aa ada9          	call	_spi
4971  09ac 6b01          	ld	(OFST+0,sp),a
4972                     ; 739 ST_CS_OFF
4974  09ae 721a5005      	bset	20485,#5
4975                     ; 740 return d0;
4977  09b2 7b01          	ld	a,(OFST+0,sp)
4980  09b4 5b01          	addw	sp,#1
4981  09b6 81            	ret
5005                     ; 744 void ST_bulk_erase(void)
5005                     ; 745 {
5006                     	switch	.text
5007  09b7               _ST_bulk_erase:
5011                     ; 746 ST_CS_ON
5013  09b7 721b5005      	bres	20485,#5
5014                     ; 747 spi(0xC7);
5016  09bb a6c7          	ld	a,#199
5017  09bd ad96          	call	_spi
5019                     ; 750 ST_CS_OFF
5021  09bf 721a5005      	bset	20485,#5
5022                     ; 751 }
5025  09c3 81            	ret
5049                     ; 753 void ST_WREN(void)
5049                     ; 754 {
5050                     	switch	.text
5051  09c4               _ST_WREN:
5055                     ; 756 ST_CS_ON
5057  09c4 721b5005      	bres	20485,#5
5058                     ; 757 spi(0x06);
5060  09c8 a606          	ld	a,#6
5061  09ca ad89          	call	_spi
5063                     ; 759 ST_CS_OFF
5065  09cc 721a5005      	bset	20485,#5
5066                     ; 760 }  
5069  09d0 81            	ret
5159                     ; 763 void ST_WRITE(unsigned long memo_addr,unsigned short len, char* adr)
5159                     ; 764 {
5160                     	switch	.text
5161  09d1               _ST_WRITE:
5163  09d1 5205          	subw	sp,#5
5164       00000005      OFST:	set	5
5167                     ; 768 adr2=(char)(memo_addr>>16);
5169  09d3 7b09          	ld	a,(OFST+4,sp)
5170  09d5 6b03          	ld	(OFST-2,sp),a
5171                     ; 769 adr1=(char)((memo_addr>>8)&0x00ff);
5173  09d7 7b0a          	ld	a,(OFST+5,sp)
5174  09d9 a4ff          	and	a,#255
5175  09db 6b02          	ld	(OFST-3,sp),a
5176                     ; 770 adr0=(char)((memo_addr)&0x00ff);
5178  09dd 7b0b          	ld	a,(OFST+6,sp)
5179  09df a4ff          	and	a,#255
5180  09e1 6b01          	ld	(OFST-4,sp),a
5181                     ; 771 ST_CS_ON
5183  09e3 721b5005      	bres	20485,#5
5184                     ; 773 spi(0x02);
5186  09e7 a602          	ld	a,#2
5187  09e9 cd0955        	call	_spi
5189                     ; 774 spi(adr2);
5191  09ec 7b03          	ld	a,(OFST-2,sp)
5192  09ee cd0955        	call	_spi
5194                     ; 775 spi(adr1);
5196  09f1 7b02          	ld	a,(OFST-3,sp)
5197  09f3 cd0955        	call	_spi
5199                     ; 776 spi(adr0);
5201  09f6 7b01          	ld	a,(OFST-4,sp)
5202  09f8 cd0955        	call	_spi
5204                     ; 778 for(i=0;i<len;i++)
5206  09fb 5f            	clrw	x
5207  09fc 1f04          	ldw	(OFST-1,sp),x
5209  09fe 2010          	jra	L7742
5210  0a00               L3742:
5211                     ; 780 	spi(adr[i]);
5213  0a00 1e0e          	ldw	x,(OFST+9,sp)
5214  0a02 72fb04        	addw	x,(OFST-1,sp)
5215  0a05 f6            	ld	a,(x)
5216  0a06 cd0955        	call	_spi
5218                     ; 778 for(i=0;i<len;i++)
5220  0a09 1e04          	ldw	x,(OFST-1,sp)
5221  0a0b 1c0001        	addw	x,#1
5222  0a0e 1f04          	ldw	(OFST-1,sp),x
5223  0a10               L7742:
5226  0a10 1e04          	ldw	x,(OFST-1,sp)
5227  0a12 130c          	cpw	x,(OFST+7,sp)
5228  0a14 25ea          	jrult	L3742
5229                     ; 783 ST_CS_OFF
5231  0a16 721a5005      	bset	20485,#5
5232                     ; 784 }
5235  0a1a 5b05          	addw	sp,#5
5236  0a1c 81            	ret
5326                     ; 787 void ST_READ(unsigned long memo_addr,unsigned short len, char* adr)
5326                     ; 788 {
5327                     	switch	.text
5328  0a1d               _ST_READ:
5330  0a1d 5205          	subw	sp,#5
5331       00000005      OFST:	set	5
5334                     ; 794 adr2=(char)(memo_addr>>16);
5336  0a1f 7b09          	ld	a,(OFST+4,sp)
5337  0a21 6b03          	ld	(OFST-2,sp),a
5338                     ; 795 adr1=(char)((memo_addr>>8)&0x00ff);
5340  0a23 7b0a          	ld	a,(OFST+5,sp)
5341  0a25 a4ff          	and	a,#255
5342  0a27 6b02          	ld	(OFST-3,sp),a
5343                     ; 796 adr0=(char)((memo_addr)&0x00ff);
5345  0a29 7b0b          	ld	a,(OFST+6,sp)
5346  0a2b a4ff          	and	a,#255
5347  0a2d 6b01          	ld	(OFST-4,sp),a
5348                     ; 797 ST_CS_ON
5350  0a2f 721b5005      	bres	20485,#5
5351                     ; 798 spi(0x03);
5353  0a33 a603          	ld	a,#3
5354  0a35 cd0955        	call	_spi
5356                     ; 799 spi(adr2);
5358  0a38 7b03          	ld	a,(OFST-2,sp)
5359  0a3a cd0955        	call	_spi
5361                     ; 800 spi(adr1);
5363  0a3d 7b02          	ld	a,(OFST-3,sp)
5364  0a3f cd0955        	call	_spi
5366                     ; 801 spi(adr0);
5368  0a42 7b01          	ld	a,(OFST-4,sp)
5369  0a44 cd0955        	call	_spi
5371                     ; 803 for(i=0;i<len;i++)
5373  0a47 5f            	clrw	x
5374  0a48 1f04          	ldw	(OFST-1,sp),x
5376  0a4a 2012          	jra	L5552
5377  0a4c               L1552:
5378                     ; 805 	adr[i]=spi(0xff);
5380  0a4c a6ff          	ld	a,#255
5381  0a4e cd0955        	call	_spi
5383  0a51 1e0e          	ldw	x,(OFST+9,sp)
5384  0a53 72fb04        	addw	x,(OFST-1,sp)
5385  0a56 f7            	ld	(x),a
5386                     ; 803 for(i=0;i<len;i++)
5388  0a57 1e04          	ldw	x,(OFST-1,sp)
5389  0a59 1c0001        	addw	x,#1
5390  0a5c 1f04          	ldw	(OFST-1,sp),x
5391  0a5e               L5552:
5394  0a5e 1e04          	ldw	x,(OFST-1,sp)
5395  0a60 130c          	cpw	x,(OFST+7,sp)
5396  0a62 25e8          	jrult	L1552
5397                     ; 808 ST_CS_OFF
5399  0a64 721a5005      	bset	20485,#5
5400                     ; 809 }
5403  0a68 5b05          	addw	sp,#5
5404  0a6a 81            	ret
5470                     ; 813 long DF_mf_dev_read(void)
5470                     ; 814 {
5471                     	switch	.text
5472  0a6b               _DF_mf_dev_read:
5474  0a6b 5204          	subw	sp,#4
5475       00000004      OFST:	set	4
5478                     ; 817 d0=0;
5480  0a6d 0f04          	clr	(OFST+0,sp)
5481                     ; 818 d1=0;
5483                     ; 819 d2=0;
5485                     ; 820 d3=0;
5487                     ; 822 CS_ON
5489  0a6f 7217500a      	bres	20490,#3
5490                     ; 823 spi(0x9f);
5492  0a73 a69f          	ld	a,#159
5493  0a75 cd0955        	call	_spi
5495                     ; 824 mdr0=spi(0xff);
5497  0a78 a6ff          	ld	a,#255
5498  0a7a cd0955        	call	_spi
5500  0a7d b718          	ld	_mdr0,a
5501                     ; 825 mdr1=spi(0xff);
5503  0a7f a6ff          	ld	a,#255
5504  0a81 cd0955        	call	_spi
5506  0a84 b717          	ld	_mdr1,a
5507                     ; 826 mdr2=spi(0xff);
5509  0a86 a6ff          	ld	a,#255
5510  0a88 cd0955        	call	_spi
5512  0a8b b716          	ld	_mdr2,a
5513                     ; 827 mdr3=spi(0xff);  
5515  0a8d a6ff          	ld	a,#255
5516  0a8f cd0955        	call	_spi
5518  0a92 b715          	ld	_mdr3,a
5519                     ; 829 CS_OFF
5521  0a94 7216500a      	bset	20490,#3
5522                     ; 830 return  *((long*)&d0);
5524  0a98 96            	ldw	x,sp
5525  0a99 1c0004        	addw	x,#OFST+0
5526  0a9c cd0000        	call	c_ltor
5530  0a9f 5b04          	addw	sp,#4
5531  0aa1 81            	ret
5555                     ; 834 void DF_memo_to_256(void)
5555                     ; 835 {
5556                     	switch	.text
5557  0aa2               _DF_memo_to_256:
5561                     ; 837 CS_ON
5563  0aa2 7217500a      	bres	20490,#3
5564                     ; 838 spi(0x3d);
5566  0aa6 a63d          	ld	a,#61
5567  0aa8 cd0955        	call	_spi
5569                     ; 839 spi(0x2a); 
5571  0aab a62a          	ld	a,#42
5572  0aad cd0955        	call	_spi
5574                     ; 840 spi(0x80);
5576  0ab0 a680          	ld	a,#128
5577  0ab2 cd0955        	call	_spi
5579                     ; 841 spi(0xa6);
5581  0ab5 a6a6          	ld	a,#166
5582  0ab7 cd0955        	call	_spi
5584                     ; 843 CS_OFF
5586  0aba 7216500a      	bset	20490,#3
5587                     ; 844 }  
5590  0abe 81            	ret
5625                     ; 849 char DF_status_read(void)
5625                     ; 850 {
5626                     	switch	.text
5627  0abf               _DF_status_read:
5629  0abf 88            	push	a
5630       00000001      OFST:	set	1
5633                     ; 854 CS_ON
5635  0ac0 7217500a      	bres	20490,#3
5636                     ; 855 spi(0xd7);
5638  0ac4 a6d7          	ld	a,#215
5639  0ac6 cd0955        	call	_spi
5641                     ; 856 d0=spi(0xff);
5643  0ac9 a6ff          	ld	a,#255
5644  0acb cd0955        	call	_spi
5646  0ace 6b01          	ld	(OFST+0,sp),a
5647                     ; 858 CS_OFF
5649  0ad0 7216500a      	bset	20490,#3
5650                     ; 859 return d0;
5652  0ad4 7b01          	ld	a,(OFST+0,sp)
5655  0ad6 5b01          	addw	sp,#1
5656  0ad8 81            	ret
5700                     ; 863 void DF_page_to_buffer(unsigned page_addr)
5700                     ; 864 {
5701                     	switch	.text
5702  0ad9               _DF_page_to_buffer:
5704  0ad9 89            	pushw	x
5705  0ada 88            	push	a
5706       00000001      OFST:	set	1
5709                     ; 867 d0=0x53; 
5711                     ; 871 CS_ON
5713  0adb 7217500a      	bres	20490,#3
5714                     ; 872 spi(d0);
5716  0adf a653          	ld	a,#83
5717  0ae1 cd0955        	call	_spi
5719                     ; 873 spi(page_addr/256/**(((char*)&page_addr)+1)*/);
5721  0ae4 7b02          	ld	a,(OFST+1,sp)
5722  0ae6 cd0955        	call	_spi
5724                     ; 874 spi(page_addr%256/**((char*)&page_addr)*/);
5726  0ae9 7b03          	ld	a,(OFST+2,sp)
5727  0aeb a4ff          	and	a,#255
5728  0aed cd0955        	call	_spi
5730                     ; 875 spi(0xff);
5732  0af0 a6ff          	ld	a,#255
5733  0af2 cd0955        	call	_spi
5735                     ; 877 CS_OFF
5737  0af5 7216500a      	bset	20490,#3
5738                     ; 878 }
5741  0af9 5b03          	addw	sp,#3
5742  0afb 81            	ret
5787                     ; 881 void DF_buffer_to_page_er(/*char buff,*/unsigned page_addr)
5787                     ; 882 {
5788                     	switch	.text
5789  0afc               _DF_buffer_to_page_er:
5791  0afc 89            	pushw	x
5792  0afd 88            	push	a
5793       00000001      OFST:	set	1
5796                     ; 885 d0=0x83; 
5798                     ; 888 CS_ON
5800  0afe 7217500a      	bres	20490,#3
5801                     ; 889 spi(d0);
5803  0b02 a683          	ld	a,#131
5804  0b04 cd0955        	call	_spi
5806                     ; 890 spi(page_addr/256/**(((char*)&page_addr)+1)*/);
5808  0b07 7b02          	ld	a,(OFST+1,sp)
5809  0b09 cd0955        	call	_spi
5811                     ; 891 spi(page_addr%256/**((char*)&page_addr)*/);
5813  0b0c 7b03          	ld	a,(OFST+2,sp)
5814  0b0e a4ff          	and	a,#255
5815  0b10 cd0955        	call	_spi
5817                     ; 892 spi(0xff);
5819  0b13 a6ff          	ld	a,#255
5820  0b15 cd0955        	call	_spi
5822                     ; 894 CS_OFF
5824  0b18 7216500a      	bset	20490,#3
5825                     ; 895 }
5828  0b1c 5b03          	addw	sp,#3
5829  0b1e 81            	ret
5901                     ; 898 void DF_buffer_read(unsigned buff_addr,unsigned len, char* adr)
5901                     ; 899 {
5902                     	switch	.text
5903  0b1f               _DF_buffer_read:
5905  0b1f 89            	pushw	x
5906  0b20 5203          	subw	sp,#3
5907       00000003      OFST:	set	3
5910                     ; 903 d0=0x54; 
5912                     ; 905 CS_ON
5914  0b22 7217500a      	bres	20490,#3
5915                     ; 906 spi(d0);
5917  0b26 a654          	ld	a,#84
5918  0b28 cd0955        	call	_spi
5920                     ; 907 spi(0xff);
5922  0b2b a6ff          	ld	a,#255
5923  0b2d cd0955        	call	_spi
5925                     ; 908 spi(buff_addr/256/**(((char*)&buff_addr)+1)*/);
5927  0b30 7b04          	ld	a,(OFST+1,sp)
5928  0b32 cd0955        	call	_spi
5930                     ; 909 spi(buff_addr%256/**((char*)&buff_addr)*/);
5932  0b35 7b05          	ld	a,(OFST+2,sp)
5933  0b37 a4ff          	and	a,#255
5934  0b39 cd0955        	call	_spi
5936                     ; 910 spi(0xff);
5938  0b3c a6ff          	ld	a,#255
5939  0b3e cd0955        	call	_spi
5941                     ; 911 for(i=0;i<len;i++)
5943  0b41 5f            	clrw	x
5944  0b42 1f02          	ldw	(OFST-1,sp),x
5946  0b44 2012          	jra	L7472
5947  0b46               L3472:
5948                     ; 913 	adr[i]=spi(0xff);
5950  0b46 a6ff          	ld	a,#255
5951  0b48 cd0955        	call	_spi
5953  0b4b 1e0a          	ldw	x,(OFST+7,sp)
5954  0b4d 72fb02        	addw	x,(OFST-1,sp)
5955  0b50 f7            	ld	(x),a
5956                     ; 911 for(i=0;i<len;i++)
5958  0b51 1e02          	ldw	x,(OFST-1,sp)
5959  0b53 1c0001        	addw	x,#1
5960  0b56 1f02          	ldw	(OFST-1,sp),x
5961  0b58               L7472:
5964  0b58 1e02          	ldw	x,(OFST-1,sp)
5965  0b5a 1308          	cpw	x,(OFST+5,sp)
5966  0b5c 25e8          	jrult	L3472
5967                     ; 916 CS_OFF
5969  0b5e 7216500a      	bset	20490,#3
5970                     ; 917 }
5973  0b62 5b05          	addw	sp,#5
5974  0b64 81            	ret
6046                     ; 920 void DF_buffer_write(/*char buff,*/unsigned buff_addr,unsigned len, char* adr)
6046                     ; 921 {
6047                     	switch	.text
6048  0b65               _DF_buffer_write:
6050  0b65 89            	pushw	x
6051  0b66 5203          	subw	sp,#3
6052       00000003      OFST:	set	3
6055                     ; 925 d0=0x84; 
6057                     ; 927 CS_ON
6059  0b68 7217500a      	bres	20490,#3
6060                     ; 928 spi(d0);
6062  0b6c a684          	ld	a,#132
6063  0b6e cd0955        	call	_spi
6065                     ; 929 spi(0xff);
6067  0b71 a6ff          	ld	a,#255
6068  0b73 cd0955        	call	_spi
6070                     ; 930 spi(buff_addr/256/**(((char*)&buff_addr)+1)*/);
6072  0b76 7b04          	ld	a,(OFST+1,sp)
6073  0b78 cd0955        	call	_spi
6075                     ; 931 spi(buff_addr%256/**((char*)&buff_addr)*/);
6077  0b7b 7b05          	ld	a,(OFST+2,sp)
6078  0b7d a4ff          	and	a,#255
6079  0b7f cd0955        	call	_spi
6081                     ; 933 for(i=0;i<len;i++)
6083  0b82 5f            	clrw	x
6084  0b83 1f02          	ldw	(OFST-1,sp),x
6086  0b85 2010          	jra	L5103
6087  0b87               L1103:
6088                     ; 935 	spi(adr[i]);
6090  0b87 1e0a          	ldw	x,(OFST+7,sp)
6091  0b89 72fb02        	addw	x,(OFST-1,sp)
6092  0b8c f6            	ld	a,(x)
6093  0b8d cd0955        	call	_spi
6095                     ; 933 for(i=0;i<len;i++)
6097  0b90 1e02          	ldw	x,(OFST-1,sp)
6098  0b92 1c0001        	addw	x,#1
6099  0b95 1f02          	ldw	(OFST-1,sp),x
6100  0b97               L5103:
6103  0b97 1e02          	ldw	x,(OFST-1,sp)
6104  0b99 1308          	cpw	x,(OFST+5,sp)
6105  0b9b 25ea          	jrult	L1103
6106                     ; 938 CS_OFF
6108  0b9d 7216500a      	bset	20490,#3
6109                     ; 939 }
6112  0ba1 5b05          	addw	sp,#5
6113  0ba3 81            	ret
6136                     ; 961 void gpio_init(void){
6137                     	switch	.text
6138  0ba4               _gpio_init:
6142                     ; 971 	GPIOD->DDR|=(1<<2);
6144  0ba4 72145011      	bset	20497,#2
6145                     ; 972 	GPIOD->CR1|=(1<<2);
6147  0ba8 72145012      	bset	20498,#2
6148                     ; 973 	GPIOD->CR2|=(1<<2);
6150  0bac 72145013      	bset	20499,#2
6151                     ; 974 	GPIOD->ODR&=~(1<<2);
6153  0bb0 7215500f      	bres	20495,#2
6154                     ; 976 	GPIOD->DDR|=(1<<4);
6156  0bb4 72185011      	bset	20497,#4
6157                     ; 977 	GPIOD->CR1|=(1<<4);
6159  0bb8 72185012      	bset	20498,#4
6160                     ; 978 	GPIOD->CR2&=~(1<<4);
6162  0bbc 72195013      	bres	20499,#4
6163                     ; 980 	GPIOC->DDR&=~(1<<4);
6165  0bc0 7219500c      	bres	20492,#4
6166                     ; 981 	GPIOC->CR1&=~(1<<4);
6168  0bc4 7219500d      	bres	20493,#4
6169                     ; 982 	GPIOC->CR2&=~(1<<4);
6171  0bc8 7219500e      	bres	20494,#4
6172                     ; 986 }
6175  0bcc 81            	ret
6227                     ; 989 void uart_in(void)
6227                     ; 990 {
6228                     	switch	.text
6229  0bcd               _uart_in:
6231  0bcd 89            	pushw	x
6232       00000002      OFST:	set	2
6235                     ; 994 if(rx_buffer_overflow)
6237                     	btst	_rx_buffer_overflow
6238  0bd3 240d          	jruge	L3503
6239                     ; 996 	rx_wr_index=0;
6241  0bd5 5f            	clrw	x
6242  0bd6 bf1c          	ldw	_rx_wr_index,x
6243                     ; 997 	rx_rd_index=0;
6245  0bd8 5f            	clrw	x
6246  0bd9 bf1a          	ldw	_rx_rd_index,x
6247                     ; 998 	rx_counter=0;
6249  0bdb 5f            	clrw	x
6250  0bdc bf1e          	ldw	_rx_counter,x
6251                     ; 999 	rx_buffer_overflow=0;
6253  0bde 72110001      	bres	_rx_buffer_overflow
6254  0be2               L3503:
6255                     ; 1002 if(rx_counter&&(rx_buffer[index_offset(rx_wr_index,-1)])==END)
6257  0be2 be1e          	ldw	x,_rx_counter
6258  0be4 2775          	jreq	L5503
6260  0be6 aeffff        	ldw	x,#65535
6261  0be9 89            	pushw	x
6262  0bea be1c          	ldw	x,_rx_wr_index
6263  0bec ad6f          	call	_index_offset
6265  0bee 5b02          	addw	sp,#2
6266  0bf0 e654          	ld	a,(_rx_buffer,x)
6267  0bf2 a10a          	cp	a,#10
6268  0bf4 2665          	jrne	L5503
6269                     ; 1007 	temp=rx_buffer[index_offset(rx_wr_index,-3)];
6271  0bf6 aefffd        	ldw	x,#65533
6272  0bf9 89            	pushw	x
6273  0bfa be1c          	ldw	x,_rx_wr_index
6274  0bfc ad5f          	call	_index_offset
6276  0bfe 5b02          	addw	sp,#2
6277  0c00 e654          	ld	a,(_rx_buffer,x)
6278  0c02 6b01          	ld	(OFST-1,sp),a
6279                     ; 1008     	if(temp<100) 
6281  0c04 7b01          	ld	a,(OFST-1,sp)
6282  0c06 a164          	cp	a,#100
6283  0c08 2451          	jruge	L5503
6284                     ; 1011     		if(control_check(index_offset(rx_wr_index,-1)))
6286  0c0a aeffff        	ldw	x,#65535
6287  0c0d 89            	pushw	x
6288  0c0e be1c          	ldw	x,_rx_wr_index
6289  0c10 ad4b          	call	_index_offset
6291  0c12 5b02          	addw	sp,#2
6292  0c14 9f            	ld	a,xl
6293  0c15 ad6e          	call	_control_check
6295  0c17 4d            	tnz	a
6296  0c18 2741          	jreq	L5503
6297                     ; 1014     			rx_rd_index=index_offset(rx_wr_index,-3-temp);
6299  0c1a a6ff          	ld	a,#255
6300  0c1c 97            	ld	xl,a
6301  0c1d a6fd          	ld	a,#253
6302  0c1f 1001          	sub	a,(OFST-1,sp)
6303  0c21 2401          	jrnc	L041
6304  0c23 5a            	decw	x
6305  0c24               L041:
6306  0c24 02            	rlwa	x,a
6307  0c25 89            	pushw	x
6308  0c26 01            	rrwa	x,a
6309  0c27 be1c          	ldw	x,_rx_wr_index
6310  0c29 ad32          	call	_index_offset
6312  0c2b 5b02          	addw	sp,#2
6313  0c2d bf1a          	ldw	_rx_rd_index,x
6314                     ; 1015     			for(i=0;i<temp;i++)
6316  0c2f 0f02          	clr	(OFST+0,sp)
6318  0c31 2018          	jra	L7603
6319  0c33               L3603:
6320                     ; 1017 				UIB[i]=rx_buffer[index_offset(rx_rd_index,i)];
6322  0c33 7b02          	ld	a,(OFST+0,sp)
6323  0c35 5f            	clrw	x
6324  0c36 97            	ld	xl,a
6325  0c37 89            	pushw	x
6326  0c38 7b04          	ld	a,(OFST+2,sp)
6327  0c3a 5f            	clrw	x
6328  0c3b 97            	ld	xl,a
6329  0c3c 89            	pushw	x
6330  0c3d be1a          	ldw	x,_rx_rd_index
6331  0c3f ad1c          	call	_index_offset
6333  0c41 5b02          	addw	sp,#2
6334  0c43 e654          	ld	a,(_rx_buffer,x)
6335  0c45 85            	popw	x
6336  0c46 d70000        	ld	(_UIB,x),a
6337                     ; 1015     			for(i=0;i<temp;i++)
6339  0c49 0c02          	inc	(OFST+0,sp)
6340  0c4b               L7603:
6343  0c4b 7b02          	ld	a,(OFST+0,sp)
6344  0c4d 1101          	cp	a,(OFST-1,sp)
6345  0c4f 25e2          	jrult	L3603
6346                     ; 1019 			rx_rd_index=rx_wr_index;
6348  0c51 be1c          	ldw	x,_rx_wr_index
6349  0c53 bf1a          	ldw	_rx_rd_index,x
6350                     ; 1020 			rx_counter=0;
6352  0c55 5f            	clrw	x
6353  0c56 bf1e          	ldw	_rx_counter,x
6354                     ; 1030 			uart_in_an();
6356  0c58 cd023c        	call	_uart_in_an
6358  0c5b               L5503:
6359                     ; 1039 }
6362  0c5b 85            	popw	x
6363  0c5c 81            	ret
6406                     ; 1042 signed short index_offset (signed short index,signed short offset)
6406                     ; 1043 {
6407                     	switch	.text
6408  0c5d               _index_offset:
6410  0c5d 89            	pushw	x
6411       00000000      OFST:	set	0
6414                     ; 1044 index=index+offset;
6416  0c5e 1e01          	ldw	x,(OFST+1,sp)
6417  0c60 72fb05        	addw	x,(OFST+5,sp)
6418  0c63 1f01          	ldw	(OFST+1,sp),x
6419                     ; 1045 if(index>=RX_BUFFER_SIZE) index-=RX_BUFFER_SIZE; 
6421  0c65 9c            	rvf
6422  0c66 1e01          	ldw	x,(OFST+1,sp)
6423  0c68 a30064        	cpw	x,#100
6424  0c6b 2f07          	jrslt	L5113
6427  0c6d 1e01          	ldw	x,(OFST+1,sp)
6428  0c6f 1d0064        	subw	x,#100
6429  0c72 1f01          	ldw	(OFST+1,sp),x
6430  0c74               L5113:
6431                     ; 1046 if(index<0) index+=RX_BUFFER_SIZE;
6433  0c74 9c            	rvf
6434  0c75 1e01          	ldw	x,(OFST+1,sp)
6435  0c77 2e07          	jrsge	L7113
6438  0c79 1e01          	ldw	x,(OFST+1,sp)
6439  0c7b 1c0064        	addw	x,#100
6440  0c7e 1f01          	ldw	(OFST+1,sp),x
6441  0c80               L7113:
6442                     ; 1047 return index;
6444  0c80 1e01          	ldw	x,(OFST+1,sp)
6447  0c82 5b02          	addw	sp,#2
6448  0c84 81            	ret
6511                     ; 1051 char control_check(char index)
6511                     ; 1052 {
6512                     	switch	.text
6513  0c85               _control_check:
6515  0c85 88            	push	a
6516  0c86 5203          	subw	sp,#3
6517       00000003      OFST:	set	3
6520                     ; 1053 char i=0,ii=0,iii;
6524                     ; 1055 if(rx_buffer[index]!=END) return 0;
6526  0c88 5f            	clrw	x
6527  0c89 97            	ld	xl,a
6528  0c8a e654          	ld	a,(_rx_buffer,x)
6529  0c8c a10a          	cp	a,#10
6530  0c8e 2703          	jreq	L3513
6533  0c90 4f            	clr	a
6535  0c91 2051          	jra	L251
6536  0c93               L3513:
6537                     ; 1057 ii=rx_buffer[index_offset(index,-2)];
6539  0c93 aefffe        	ldw	x,#65534
6540  0c96 89            	pushw	x
6541  0c97 7b06          	ld	a,(OFST+3,sp)
6542  0c99 5f            	clrw	x
6543  0c9a 97            	ld	xl,a
6544  0c9b adc0          	call	_index_offset
6546  0c9d 5b02          	addw	sp,#2
6547  0c9f e654          	ld	a,(_rx_buffer,x)
6548  0ca1 6b02          	ld	(OFST-1,sp),a
6549                     ; 1058 iii=0;
6551  0ca3 0f01          	clr	(OFST-2,sp)
6552                     ; 1059 for(i=0;i<=ii;i++)
6554  0ca5 0f03          	clr	(OFST+0,sp)
6556  0ca7 2022          	jra	L1613
6557  0ca9               L5513:
6558                     ; 1061 	iii^=rx_buffer[index_offset(index,-2-ii+i)];
6560  0ca9 a6ff          	ld	a,#255
6561  0cab 97            	ld	xl,a
6562  0cac a6fe          	ld	a,#254
6563  0cae 1002          	sub	a,(OFST-1,sp)
6564  0cb0 2401          	jrnc	L641
6565  0cb2 5a            	decw	x
6566  0cb3               L641:
6567  0cb3 1b03          	add	a,(OFST+0,sp)
6568  0cb5 2401          	jrnc	L051
6569  0cb7 5c            	incw	x
6570  0cb8               L051:
6571  0cb8 02            	rlwa	x,a
6572  0cb9 89            	pushw	x
6573  0cba 01            	rrwa	x,a
6574  0cbb 7b06          	ld	a,(OFST+3,sp)
6575  0cbd 5f            	clrw	x
6576  0cbe 97            	ld	xl,a
6577  0cbf ad9c          	call	_index_offset
6579  0cc1 5b02          	addw	sp,#2
6580  0cc3 7b01          	ld	a,(OFST-2,sp)
6581  0cc5 e854          	xor	a,	(_rx_buffer,x)
6582  0cc7 6b01          	ld	(OFST-2,sp),a
6583                     ; 1059 for(i=0;i<=ii;i++)
6585  0cc9 0c03          	inc	(OFST+0,sp)
6586  0ccb               L1613:
6589  0ccb 7b03          	ld	a,(OFST+0,sp)
6590  0ccd 1102          	cp	a,(OFST-1,sp)
6591  0ccf 23d8          	jrule	L5513
6592                     ; 1063 if (iii!=rx_buffer[index_offset(index,-1)]) return 0;	
6594  0cd1 aeffff        	ldw	x,#65535
6595  0cd4 89            	pushw	x
6596  0cd5 7b06          	ld	a,(OFST+3,sp)
6597  0cd7 5f            	clrw	x
6598  0cd8 97            	ld	xl,a
6599  0cd9 ad82          	call	_index_offset
6601  0cdb 5b02          	addw	sp,#2
6602  0cdd e654          	ld	a,(_rx_buffer,x)
6603  0cdf 1101          	cp	a,(OFST-2,sp)
6604  0ce1 2704          	jreq	L5613
6607  0ce3 4f            	clr	a
6609  0ce4               L251:
6611  0ce4 5b04          	addw	sp,#4
6612  0ce6 81            	ret
6613  0ce7               L5613:
6614                     ; 1065 return 1;
6616  0ce7 a601          	ld	a,#1
6618  0ce9 20f9          	jra	L251
6660                     ; 1074 @far @interrupt void TIM4_UPD_Interrupt (void) {
6662                     	switch	.text
6663  0ceb               f_TIM4_UPD_Interrupt:
6667                     ; 1076 	if(play) {
6669                     	btst	_play
6670  0cf0 2445          	jruge	L7713
6671                     ; 1077 		TIM2->CCR3H= 0x00;	
6673  0cf2 725f5315      	clr	21269
6674                     ; 1078 		TIM2->CCR3L= sample;
6676  0cf6 5500195316    	mov	21270,_sample
6677                     ; 1079 		sample_cnt++;
6679  0cfb be23          	ldw	x,_sample_cnt
6680  0cfd 1c0001        	addw	x,#1
6681  0d00 bf23          	ldw	_sample_cnt,x
6682                     ; 1080 		if(sample_cnt>=256) {
6684  0d02 9c            	rvf
6685  0d03 be23          	ldw	x,_sample_cnt
6686  0d05 a30100        	cpw	x,#256
6687  0d08 2f03          	jrslt	L1023
6688                     ; 1081 			sample_cnt=0;
6690  0d0a 5f            	clrw	x
6691  0d0b bf23          	ldw	_sample_cnt,x
6692  0d0d               L1023:
6693                     ; 1085 		sample=buff[sample_cnt];
6695  0d0d be23          	ldw	x,_sample_cnt
6696  0d0f d60050        	ld	a,(_buff,x)
6697  0d12 b719          	ld	_sample,a
6698                     ; 1087 		if(sample_cnt==132)	{
6700  0d14 be23          	ldw	x,_sample_cnt
6701  0d16 a30084        	cpw	x,#132
6702  0d19 2604          	jrne	L3023
6703                     ; 1088 			bBUFF_LOAD=1;
6705  0d1b 7210000b      	bset	_bBUFF_LOAD
6706  0d1f               L3023:
6707                     ; 1092 		if(sample_cnt==5) {
6709  0d1f be23          	ldw	x,_sample_cnt
6710  0d21 a30005        	cpw	x,#5
6711  0d24 2604          	jrne	L5023
6712                     ; 1093 			bBUFF_READ_H=1;
6714  0d26 7210000a      	bset	_bBUFF_READ_H
6715  0d2a               L5023:
6716                     ; 1096 		if(sample_cnt==150) {
6718  0d2a be23          	ldw	x,_sample_cnt
6719  0d2c a30096        	cpw	x,#150
6720  0d2f 2615          	jrne	L1123
6721                     ; 1097 			bBUFF_READ_L=1;
6723  0d31 72100009      	bset	_bBUFF_READ_L
6724  0d35 200f          	jra	L1123
6725  0d37               L7713:
6726                     ; 1104 	else if(!bSTART) {
6728                     	btst	_bSTART
6729  0d3c 2508          	jrult	L1123
6730                     ; 1105 		TIM2->CCR3H= 0x00;	
6732  0d3e 725f5315      	clr	21269
6733                     ; 1106 		TIM2->CCR3L= 0x7f;//pwm_fade_in;
6735  0d42 357f5316      	mov	21270,#127
6736  0d46               L1123:
6737                     ; 1161 		if(but_block_cnt)but_on_drv_cnt=0;
6739  0d46 be02          	ldw	x,_but_block_cnt
6740  0d48 2702          	jreq	L5123
6743  0d4a 3fb9          	clr	_but_on_drv_cnt
6744  0d4c               L5123:
6745                     ; 1162 		if((((GPIOC->IDR)&(1<<4))) && (but_on_drv_cnt<100)) {
6747  0d4c c6500b        	ld	a,20491
6748  0d4f a510          	bcp	a,#16
6749  0d51 271f          	jreq	L7123
6751  0d53 b6b9          	ld	a,_but_on_drv_cnt
6752  0d55 a164          	cp	a,#100
6753  0d57 2419          	jruge	L7123
6754                     ; 1163 			but_on_drv_cnt++;
6756  0d59 3cb9          	inc	_but_on_drv_cnt
6757                     ; 1164 			if((but_on_drv_cnt>2)&&(bRELEASE))
6759  0d5b b6b9          	ld	a,_but_on_drv_cnt
6760  0d5d a103          	cp	a,#3
6761  0d5f 2517          	jrult	L3223
6763                     	btst	_bRELEASE
6764  0d66 2410          	jruge	L3223
6765                     ; 1166 				bRELEASE=0;
6767  0d68 72110000      	bres	_bRELEASE
6768                     ; 1167 				bSTART=1;
6770  0d6c 7210000c      	bset	_bSTART
6771  0d70 2006          	jra	L3223
6772  0d72               L7123:
6773                     ; 1171 			but_on_drv_cnt=0;
6775  0d72 3fb9          	clr	_but_on_drv_cnt
6776                     ; 1172 			bRELEASE=1;
6778  0d74 72100000      	bset	_bRELEASE
6779  0d78               L3223:
6780                     ; 1177 	if(++t0_cnt0>=125){
6782  0d78 3c00          	inc	_t0_cnt0
6783  0d7a b600          	ld	a,_t0_cnt0
6784  0d7c a17d          	cp	a,#125
6785  0d7e 2530          	jrult	L5223
6786                     ; 1178     		t0_cnt0=0;
6788  0d80 3f00          	clr	_t0_cnt0
6789                     ; 1179     		b100Hz=1;
6791  0d82 72100008      	bset	_b100Hz
6792                     ; 1189 		if(++t0_cnt1>=10){
6794  0d86 3c01          	inc	_t0_cnt1
6795  0d88 b601          	ld	a,_t0_cnt1
6796  0d8a a10a          	cp	a,#10
6797  0d8c 2506          	jrult	L7223
6798                     ; 1190 			t0_cnt1=0;
6800  0d8e 3f01          	clr	_t0_cnt1
6801                     ; 1191 			b10Hz=1;
6803  0d90 72100007      	bset	_b10Hz
6804  0d94               L7223:
6805                     ; 1194 		if(++t0_cnt2>=20){
6807  0d94 3c02          	inc	_t0_cnt2
6808  0d96 b602          	ld	a,_t0_cnt2
6809  0d98 a114          	cp	a,#20
6810  0d9a 2506          	jrult	L1323
6811                     ; 1195 			t0_cnt2=0;
6813  0d9c 3f02          	clr	_t0_cnt2
6814                     ; 1196 			b5Hz=1;
6816  0d9e 72100006      	bset	_b5Hz
6817  0da2               L1323:
6818                     ; 1199 		if(++t0_cnt3>=100){
6820  0da2 3c03          	inc	_t0_cnt3
6821  0da4 b603          	ld	a,_t0_cnt3
6822  0da6 a164          	cp	a,#100
6823  0da8 2506          	jrult	L5223
6824                     ; 1200 			t0_cnt3=0;
6826  0daa 3f03          	clr	_t0_cnt3
6827                     ; 1201 			b1Hz=1;
6829  0dac 72100005      	bset	_b1Hz
6830  0db0               L5223:
6831                     ; 1205 	TIM4->SR1&=~TIM4_SR1_UIF;			// disable break interrupt
6833  0db0 72115344      	bres	21316,#0
6834                     ; 1206 	return;
6837  0db4 80            	iret
6863                     ; 1210 @far @interrupt void UARTTxInterrupt (void) {
6864                     	switch	.text
6865  0db5               f_UARTTxInterrupt:
6869                     ; 1212 	if (tx_counter){
6871  0db5 3d22          	tnz	_tx_counter
6872  0db7 271a          	jreq	L5423
6873                     ; 1213 		--tx_counter;
6875  0db9 3a22          	dec	_tx_counter
6876                     ; 1214 		UART1->DR=tx_buffer[tx_rd_index];
6878  0dbb 5f            	clrw	x
6879  0dbc b620          	ld	a,_tx_rd_index
6880  0dbe 2a01          	jrpl	L061
6881  0dc0 53            	cplw	x
6882  0dc1               L061:
6883  0dc1 97            	ld	xl,a
6884  0dc2 e604          	ld	a,(_tx_buffer,x)
6885  0dc4 c75231        	ld	21041,a
6886                     ; 1215 		if (++tx_rd_index == TX_BUFFER_SIZE) tx_rd_index=0;
6888  0dc7 3c20          	inc	_tx_rd_index
6889  0dc9 b620          	ld	a,_tx_rd_index
6890  0dcb a150          	cp	a,#80
6891  0dcd 260c          	jrne	L1523
6894  0dcf 3f20          	clr	_tx_rd_index
6895  0dd1 2008          	jra	L1523
6896  0dd3               L5423:
6897                     ; 1218 		bOUT_FREE=1;
6899  0dd3 72100003      	bset	_bOUT_FREE
6900                     ; 1219 		UART1->CR2&= ~UART1_CR2_TIEN;
6902  0dd7 721f5235      	bres	21045,#7
6903  0ddb               L1523:
6904                     ; 1221 }
6907  0ddb 80            	iret
6936                     ; 1224 @far @interrupt void UARTRxInterrupt (void) {
6937                     	switch	.text
6938  0ddc               f_UARTRxInterrupt:
6942                     ; 1229 	rx_status=UART1->SR;
6944  0ddc 5552300008    	mov	_rx_status,21040
6945                     ; 1230 	rx_data=UART1->DR;
6947  0de1 5552310007    	mov	_rx_data,21041
6948                     ; 1232 	if (rx_status & (UART1_SR_RXNE)){
6950  0de6 b608          	ld	a,_rx_status
6951  0de8 a520          	bcp	a,#32
6952  0dea 272c          	jreq	L3623
6953                     ; 1233 		rx_buffer[rx_wr_index]=rx_data;
6955  0dec be1c          	ldw	x,_rx_wr_index
6956  0dee b607          	ld	a,_rx_data
6957  0df0 e754          	ld	(_rx_buffer,x),a
6958                     ; 1234 		bRXIN=1;
6960  0df2 72100002      	bset	_bRXIN
6961                     ; 1235 		if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
6963  0df6 be1c          	ldw	x,_rx_wr_index
6964  0df8 1c0001        	addw	x,#1
6965  0dfb bf1c          	ldw	_rx_wr_index,x
6966  0dfd a30064        	cpw	x,#100
6967  0e00 2603          	jrne	L5623
6970  0e02 5f            	clrw	x
6971  0e03 bf1c          	ldw	_rx_wr_index,x
6972  0e05               L5623:
6973                     ; 1236 		if (++rx_counter == RX_BUFFER_SIZE){
6975  0e05 be1e          	ldw	x,_rx_counter
6976  0e07 1c0001        	addw	x,#1
6977  0e0a bf1e          	ldw	_rx_counter,x
6978  0e0c a30064        	cpw	x,#100
6979  0e0f 2607          	jrne	L3623
6980                     ; 1237 			rx_counter=0;
6982  0e11 5f            	clrw	x
6983  0e12 bf1e          	ldw	_rx_counter,x
6984                     ; 1238 			rx_buffer_overflow=1;
6986  0e14 72100001      	bset	_rx_buffer_overflow
6987  0e18               L3623:
6988                     ; 1241 }
6991  0e18 80            	iret
7055                     ; 1247 main()
7055                     ; 1248 {
7057                     	switch	.text
7058  0e19               _main:
7062                     ; 1249 CLK->CKDIVR=0;
7064  0e19 725f50c6      	clr	20678
7065                     ; 1251 rele_cnt_index=0;
7067  0e1d 3fbb          	clr	_rele_cnt_index
7068                     ; 1253 GPIOD->DDR&=~(1<<6);
7070  0e1f 721d5011      	bres	20497,#6
7071                     ; 1254 GPIOD->CR1|=(1<<6);
7073  0e23 721c5012      	bset	20498,#6
7074                     ; 1255 GPIOD->CR2|=(1<<6);
7076  0e27 721c5013      	bset	20499,#6
7077                     ; 1257 GPIOD->DDR|=(1<<5);
7079  0e2b 721a5011      	bset	20497,#5
7080                     ; 1258 GPIOD->CR1|=(1<<5);
7082  0e2f 721a5012      	bset	20498,#5
7083                     ; 1259 GPIOD->CR2|=(1<<5);	
7085  0e33 721a5013      	bset	20499,#5
7086                     ; 1260 GPIOD->ODR|=(1<<5);
7088  0e37 721a500f      	bset	20495,#5
7089                     ; 1262 delay_ms(10);
7091  0e3b ae000a        	ldw	x,#10
7092  0e3e cd0060        	call	_delay_ms
7094                     ; 1264 if(!(GPIOD->IDR&=(1<<6))) 
7096  0e41 c65010        	ld	a,20496
7097  0e44 a440          	and	a,#64
7098  0e46 c75010        	ld	20496,a
7099  0e49 2606          	jrne	L1033
7100                     ; 1266 	rele_cnt_index=1;
7102  0e4b 350100bb      	mov	_rele_cnt_index,#1
7104  0e4f 2018          	jra	L3033
7105  0e51               L1033:
7106                     ; 1270 	GPIOD->ODR&=~(1<<5);
7108  0e51 721b500f      	bres	20495,#5
7109                     ; 1271 	delay_ms(10);
7111  0e55 ae000a        	ldw	x,#10
7112  0e58 cd0060        	call	_delay_ms
7114                     ; 1272 	if(!(GPIOD->IDR&=(1<<6))) 
7116  0e5b c65010        	ld	a,20496
7117  0e5e a440          	and	a,#64
7118  0e60 c75010        	ld	20496,a
7119  0e63 2604          	jrne	L3033
7120                     ; 1274 		rele_cnt_index=2;
7122  0e65 350200bb      	mov	_rele_cnt_index,#2
7123  0e69               L3033:
7124                     ; 1278 gpio_init();
7126  0e69 cd0ba4        	call	_gpio_init
7128                     ; 1285 spi_init();
7130  0e6c cd08e8        	call	_spi_init
7132                     ; 1287 t4_init();
7134  0e6f cd0039        	call	_t4_init
7136                     ; 1289 FLASH_DUKR=0xae;
7138  0e72 35ae5064      	mov	_FLASH_DUKR,#174
7139                     ; 1290 FLASH_DUKR=0x56;
7141  0e76 35565064      	mov	_FLASH_DUKR,#86
7142                     ; 1295 dumm[1]++;
7144  0e7a 725c017d      	inc	_dumm+1
7145                     ; 1297 uart_init();
7147  0e7e cd00a2        	call	_uart_init
7149                     ; 1299 ST_RDID_read();
7151  0e81 cd0973        	call	_ST_RDID_read
7153                     ; 1300 if(mdr0==0x20) memory_manufacturer='S';	
7155  0e84 b618          	ld	a,_mdr0
7156  0e86 a120          	cp	a,#32
7157  0e88 2606          	jrne	L7033
7160  0e8a 355300bc      	mov	_memory_manufacturer,#83
7162  0e8e 200d          	jra	L1133
7163  0e90               L7033:
7164                     ; 1303 	DF_mf_dev_read();
7166  0e90 cd0a6b        	call	_DF_mf_dev_read
7168                     ; 1304 	if(mdr0==0x1F) memory_manufacturer='A';
7170  0e93 b618          	ld	a,_mdr0
7171  0e95 a11f          	cp	a,#31
7172  0e97 2604          	jrne	L1133
7175  0e99 354100bc      	mov	_memory_manufacturer,#65
7176  0e9d               L1133:
7177                     ; 1307 t2_init();
7179  0e9d cd0000        	call	_t2_init
7181                     ; 1309 ST_WREN();
7183  0ea0 cd09c4        	call	_ST_WREN
7185                     ; 1311 enableInterrupts();	
7188  0ea3 9a            rim
7190  0ea4               L5133:
7191                     ; 1316 	if(bBUFF_LOAD)
7193                     	btst	_bBUFF_LOAD
7194  0ea9 2425          	jruge	L1233
7195                     ; 1318 		bBUFF_LOAD=0;
7197  0eab 7211000b      	bres	_bBUFF_LOAD
7198                     ; 1320 		if(current_page<last_page)
7200  0eaf be11          	ldw	x,_current_page
7201  0eb1 b30f          	cpw	x,_last_page
7202  0eb3 2409          	jruge	L3233
7203                     ; 1322 			current_page++;
7205  0eb5 be11          	ldw	x,_current_page
7206  0eb7 1c0001        	addw	x,#1
7207  0eba bf11          	ldw	_current_page,x
7209  0ebc 2007          	jra	L5233
7210  0ebe               L3233:
7211                     ; 1326 			current_page=0;
7213  0ebe 5f            	clrw	x
7214  0ebf bf11          	ldw	_current_page,x
7215                     ; 1327 			play=0;
7217  0ec1 72110004      	bres	_play
7218  0ec5               L5233:
7219                     ; 1329 		if(memory_manufacturer=='A')
7221  0ec5 b6bc          	ld	a,_memory_manufacturer
7222  0ec7 a141          	cp	a,#65
7223  0ec9 2605          	jrne	L1233
7224                     ; 1331 			DF_page_to_buffer(/*///current_buffer_H*//*1,*/current_page);
7226  0ecb be11          	ldw	x,_current_page
7227  0ecd cd0ad9        	call	_DF_page_to_buffer
7229  0ed0               L1233:
7230                     ; 1335 	if(bBUFF_READ_L)
7232                     	btst	_bBUFF_READ_L
7233  0ed5 243a          	jruge	L1333
7234                     ; 1337 		bBUFF_READ_L=0;
7236  0ed7 72110009      	bres	_bBUFF_READ_L
7237                     ; 1338 		if(memory_manufacturer=='A')
7239  0edb b6bc          	ld	a,_memory_manufacturer
7240  0edd a141          	cp	a,#65
7241  0edf 260e          	jrne	L3333
7242                     ; 1340 			DF_buffer_read(/*///current_buffer_L*//*1,*/0,128,buff);
7244  0ee1 ae0050        	ldw	x,#_buff
7245  0ee4 89            	pushw	x
7246  0ee5 ae0080        	ldw	x,#128
7247  0ee8 89            	pushw	x
7248  0ee9 5f            	clrw	x
7249  0eea cd0b1f        	call	_DF_buffer_read
7251  0eed 5b04          	addw	sp,#4
7252  0eef               L3333:
7253                     ; 1342 		if(memory_manufacturer=='S')
7255  0eef b6bc          	ld	a,_memory_manufacturer
7256  0ef1 a153          	cp	a,#83
7257  0ef3 261c          	jrne	L1333
7258                     ; 1344 			ST_READ((unsigned long)((unsigned long)(current_page*256UL)),128,buff);
7260  0ef5 ae0050        	ldw	x,#_buff
7261  0ef8 89            	pushw	x
7262  0ef9 ae0080        	ldw	x,#128
7263  0efc 89            	pushw	x
7264  0efd be11          	ldw	x,_current_page
7265  0eff 90ae0100      	ldw	y,#256
7266  0f03 cd0000        	call	c_umul
7268  0f06 be02          	ldw	x,c_lreg+2
7269  0f08 89            	pushw	x
7270  0f09 be00          	ldw	x,c_lreg
7271  0f0b 89            	pushw	x
7272  0f0c cd0a1d        	call	_ST_READ
7274  0f0f 5b08          	addw	sp,#8
7275  0f11               L1333:
7276                     ; 1348 	if(bBUFF_READ_H) 
7278                     	btst	_bBUFF_READ_H
7279  0f16 2441          	jruge	L7333
7280                     ; 1350 		bBUFF_READ_H=0;
7282  0f18 7211000a      	bres	_bBUFF_READ_H
7283                     ; 1351 		if(memory_manufacturer=='A') 
7285  0f1c b6bc          	ld	a,_memory_manufacturer
7286  0f1e a141          	cp	a,#65
7287  0f20 2610          	jrne	L1433
7288                     ; 1353 			DF_buffer_read(/*///current_buffer_L*//*1,*/128,128,&buff[128]);
7290  0f22 ae00d0        	ldw	x,#_buff+128
7291  0f25 89            	pushw	x
7292  0f26 ae0080        	ldw	x,#128
7293  0f29 89            	pushw	x
7294  0f2a ae0080        	ldw	x,#128
7295  0f2d cd0b1f        	call	_DF_buffer_read
7297  0f30 5b04          	addw	sp,#4
7298  0f32               L1433:
7299                     ; 1355 		if(memory_manufacturer=='S') 
7301  0f32 b6bc          	ld	a,_memory_manufacturer
7302  0f34 a153          	cp	a,#83
7303  0f36 2621          	jrne	L7333
7304                     ; 1357 			ST_READ((unsigned long)((unsigned long)(current_page*256UL)+128UL),128,&buff[128]);
7306  0f38 ae00d0        	ldw	x,#_buff+128
7307  0f3b 89            	pushw	x
7308  0f3c ae0080        	ldw	x,#128
7309  0f3f 89            	pushw	x
7310  0f40 be11          	ldw	x,_current_page
7311  0f42 90ae0100      	ldw	y,#256
7312  0f46 cd0000        	call	c_umul
7314  0f49 a680          	ld	a,#128
7315  0f4b cd0000        	call	c_ladc
7317  0f4e be02          	ldw	x,c_lreg+2
7318  0f50 89            	pushw	x
7319  0f51 be00          	ldw	x,c_lreg
7320  0f53 89            	pushw	x
7321  0f54 cd0a1d        	call	_ST_READ
7323  0f57 5b08          	addw	sp,#8
7324  0f59               L7333:
7325                     ; 1361 	if(bRXIN)
7327                     	btst	_bRXIN
7328  0f5e 2407          	jruge	L5433
7329                     ; 1363 		bRXIN=0;
7331  0f60 72110002      	bres	_bRXIN
7332                     ; 1365 		uart_in();
7334  0f64 cd0bcd        	call	_uart_in
7336  0f67               L5433:
7337                     ; 1369 	if(b100Hz)
7339                     	btst	_b100Hz
7340  0f6c 2503cc1003    	jruge	L7433
7341                     ; 1371 		b100Hz=0;
7343  0f71 72110008      	bres	_b100Hz
7344                     ; 1373 		if(but_block_cnt)but_block_cnt--;
7346  0f75 be02          	ldw	x,_but_block_cnt
7347  0f77 2707          	jreq	L1533
7350  0f79 be02          	ldw	x,_but_block_cnt
7351  0f7b 1d0001        	subw	x,#1
7352  0f7e bf02          	ldw	_but_block_cnt,x
7353  0f80               L1533:
7354                     ; 1375 		if(bSTART==1) 
7356                     	btst	_bSTART
7357  0f85 247c          	jruge	L7433
7358                     ; 1377 			if(play) 
7360                     	btst	_play
7361  0f8c 2406          	jruge	L5533
7362                     ; 1387 				bSTART=0;
7364  0f8e 7211000c      	bres	_bSTART
7366  0f92 206f          	jra	L7433
7367  0f94               L5533:
7368                     ; 1394 				current_page=1;
7370  0f94 ae0001        	ldw	x,#1
7371  0f97 bf11          	ldw	_current_page,x
7372                     ; 1399 				last_page=EE_PAGE_LEN-1;
7374  0f99 ce0000        	ldw	x,_EE_PAGE_LEN
7375  0f9c 5a            	decw	x
7376  0f9d bf0f          	ldw	_last_page,x
7377                     ; 1401 				if(memory_manufacturer=='A')
7379  0f9f b6bc          	ld	a,_memory_manufacturer
7380  0fa1 a141          	cp	a,#65
7381  0fa3 2630          	jrne	L1633
7382                     ; 1403 					DF_page_to_buffer(/*///current_buffer_H*//*1,*/current_page);
7384  0fa5 ae0001        	ldw	x,#1
7385  0fa8 cd0ad9        	call	_DF_page_to_buffer
7387                     ; 1404 					delay_ms(10);
7389  0fab ae000a        	ldw	x,#10
7390  0fae cd0060        	call	_delay_ms
7392                     ; 1405 					DF_buffer_read(/*///current_buffer_L*//*1,*/0,128,buff);
7394  0fb1 ae0050        	ldw	x,#_buff
7395  0fb4 89            	pushw	x
7396  0fb5 ae0080        	ldw	x,#128
7397  0fb8 89            	pushw	x
7398  0fb9 5f            	clrw	x
7399  0fba cd0b1f        	call	_DF_buffer_read
7401  0fbd 5b04          	addw	sp,#4
7402                     ; 1406 					delay_ms(10);
7404  0fbf ae000a        	ldw	x,#10
7405  0fc2 cd0060        	call	_delay_ms
7407                     ; 1407 					DF_buffer_read(/*///current_buffer_L*//*1,*/128,128,&buff[128]);         
7409  0fc5 ae00d0        	ldw	x,#_buff+128
7410  0fc8 89            	pushw	x
7411  0fc9 ae0080        	ldw	x,#128
7412  0fcc 89            	pushw	x
7413  0fcd ae0080        	ldw	x,#128
7414  0fd0 cd0b1f        	call	_DF_buffer_read
7416  0fd3 5b04          	addw	sp,#4
7417  0fd5               L1633:
7418                     ; 1409 				if(memory_manufacturer=='S') 
7420  0fd5 b6bc          	ld	a,_memory_manufacturer
7421  0fd7 a153          	cp	a,#83
7422  0fd9 2615          	jrne	L3633
7423                     ; 1411 					ST_READ(0,256,buff);
7425  0fdb ae0050        	ldw	x,#_buff
7426  0fde 89            	pushw	x
7427  0fdf ae0100        	ldw	x,#256
7428  0fe2 89            	pushw	x
7429  0fe3 ae0000        	ldw	x,#0
7430  0fe6 89            	pushw	x
7431  0fe7 ae0000        	ldw	x,#0
7432  0fea 89            	pushw	x
7433  0feb cd0a1d        	call	_ST_READ
7435  0fee 5b08          	addw	sp,#8
7436  0ff0               L3633:
7437                     ; 1413 				play=1;
7439  0ff0 72100004      	bset	_play
7440                     ; 1414 				bSTART=0;
7442  0ff4 7211000c      	bres	_bSTART
7443                     ; 1416 				rele_cnt=rele_cnt_const[rele_cnt_index];
7445  0ff8 b6bb          	ld	a,_rele_cnt_index
7446  0ffa 5f            	clrw	x
7447  0ffb 97            	ld	xl,a
7448  0ffc d60000        	ld	a,(_rele_cnt_const,x)
7449  0fff 5f            	clrw	x
7450  1000 97            	ld	xl,a
7451  1001 bf05          	ldw	_rele_cnt,x
7452  1003               L7433:
7453                     ; 1425 	if(b10Hz)
7455                     	btst	_b10Hz
7456  1008 2441          	jruge	L5633
7457                     ; 1427 		b10Hz=0;
7459  100a 72110007      	bres	_b10Hz
7460                     ; 1429 		rele_drv();
7462  100e cd004a        	call	_rele_drv
7464                     ; 1430 		pwm_fade_in++;
7466  1011 3cba          	inc	_pwm_fade_in
7467                     ; 1431 		if(pwm_fade_in>128)pwm_fade_in=128;
7469  1013 b6ba          	ld	a,_pwm_fade_in
7470  1015 a181          	cp	a,#129
7471  1017 2504          	jrult	L7633
7474  1019 358000ba      	mov	_pwm_fade_in,#128
7475  101d               L7633:
7476                     ; 1433 		if(current_page_cnt)
7478  101d 3d01          	tnz	_current_page_cnt
7479  101f 272a          	jreq	L5633
7480                     ; 1435 			current_page_cnt--;
7482  1021 3a01          	dec	_current_page_cnt
7483                     ; 1436 			if(!current_page_cnt)
7485  1023 3d01          	tnz	_current_page_cnt
7486  1025 2624          	jrne	L5633
7487                     ; 1438 				uart_out (5,CMND,21,current_page%256,current_page/256,1,0);
7489  1027 4b00          	push	#0
7490  1029 4b01          	push	#1
7491  102b 3b0011        	push	_current_page
7492  102e b612          	ld	a,_current_page+1
7493  1030 a4ff          	and	a,#255
7494  1032 88            	push	a
7495  1033 4b15          	push	#21
7496  1035 ae0016        	ldw	x,#22
7497  1038 a605          	ld	a,#5
7498  103a 95            	ld	xh,a
7499  103b cd00d2        	call	_uart_out
7501  103e 5b05          	addw	sp,#5
7502                     ; 1439 				current_page_cnt=10;
7504  1040 350a0001      	mov	_current_page_cnt,#10
7505                     ; 1440 				current_page_cnt_=4;
7507  1044 35040000      	mov	_current_page_cnt_,#4
7508                     ; 1441 				current_byte_in_buffer=0;
7510  1048 5f            	clrw	x
7511  1049 bf0d          	ldw	_current_byte_in_buffer,x
7512  104b               L5633:
7513                     ; 1447 	if(b5Hz)
7515                     	btst	_b5Hz
7516  1050 2404          	jruge	L5733
7517                     ; 1449 		b5Hz=0;
7519  1052 72110006      	bres	_b5Hz
7520  1056               L5733:
7521                     ; 1455 	if(b1Hz)
7523                     	btst	_b1Hz
7524  105b 2503          	jrult	L661
7525  105d cc0ea4        	jp	L5133
7526  1060               L661:
7527                     ; 1458 		b1Hz=0;
7529  1060 72110005      	bres	_b1Hz
7530  1064 aca40ea4      	jpf	L5133
8044                     	xdef	_main
8045                     	switch	.ubsct
8046  0000               _current_page_cnt_:
8047  0000 00            	ds.b	1
8048                     	xdef	_current_page_cnt_
8049  0001               _current_page_cnt:
8050  0001 00            	ds.b	1
8051                     	xdef	_current_page_cnt
8052                     .eeprom:	section	.data
8053  0000               _EE_PAGE_LEN:
8054  0000 0000          	ds.b	2
8055                     	xdef	_EE_PAGE_LEN
8056                     	switch	.bss
8057  0000               _UIB:
8058  0000 000000000000  	ds.b	80
8059                     	xdef	_UIB
8060  0050               _buff:
8061  0050 000000000000  	ds.b	300
8062                     	xdef	_buff
8063  017c               _dumm:
8064  017c 000000000000  	ds.b	100
8065                     	xdef	_dumm
8066                     .bit:	section	.data,bit
8067  0000               _bRELEASE:
8068  0000 00            	ds.b	1
8069                     	xdef	_bRELEASE
8070  0001               _rx_buffer_overflow:
8071  0001 00            	ds.b	1
8072                     	xdef	_rx_buffer_overflow
8073  0002               _bRXIN:
8074  0002 00            	ds.b	1
8075                     	xdef	_bRXIN
8076  0003               _bOUT_FREE:
8077  0003 00            	ds.b	1
8078                     	xdef	_bOUT_FREE
8079  0004               _play:
8080  0004 00            	ds.b	1
8081                     	xdef	_play
8082  0005               _b1Hz:
8083  0005 00            	ds.b	1
8084                     	xdef	_b1Hz
8085  0006               _b5Hz:
8086  0006 00            	ds.b	1
8087                     	xdef	_b5Hz
8088  0007               _b10Hz:
8089  0007 00            	ds.b	1
8090                     	xdef	_b10Hz
8091  0008               _b100Hz:
8092  0008 00            	ds.b	1
8093                     	xdef	_b100Hz
8094  0009               _bBUFF_READ_L:
8095  0009 00            	ds.b	1
8096                     	xdef	_bBUFF_READ_L
8097  000a               _bBUFF_READ_H:
8098  000a 00            	ds.b	1
8099                     	xdef	_bBUFF_READ_H
8100  000b               _bBUFF_LOAD:
8101  000b 00            	ds.b	1
8102                     	xdef	_bBUFF_LOAD
8103  000c               _bSTART:
8104  000c 00            	ds.b	1
8105                     	xdef	_bSTART
8106                     	switch	.ubsct
8107  0002               _but_block_cnt:
8108  0002 0000          	ds.b	2
8109                     	xdef	_but_block_cnt
8110                     	xdef	_memory_manufacturer
8111                     	xdef	_rele_cnt_const
8112                     	xdef	_rele_cnt_index
8113                     	xdef	_pwm_fade_in
8114  0004               _rx_offset:
8115  0004 00            	ds.b	1
8116                     	xdef	_rx_offset
8117  0005               _rele_cnt:
8118  0005 0000          	ds.b	2
8119                     	xdef	_rele_cnt
8120  0007               _rx_data:
8121  0007 00            	ds.b	1
8122                     	xdef	_rx_data
8123  0008               _rx_status:
8124  0008 00            	ds.b	1
8125                     	xdef	_rx_status
8126  0009               _file_lengt:
8127  0009 00000000      	ds.b	4
8128                     	xdef	_file_lengt
8129  000d               _current_byte_in_buffer:
8130  000d 0000          	ds.b	2
8131                     	xdef	_current_byte_in_buffer
8132  000f               _last_page:
8133  000f 0000          	ds.b	2
8134                     	xdef	_last_page
8135  0011               _current_page:
8136  0011 0000          	ds.b	2
8137                     	xdef	_current_page
8138  0013               _file_lengt_in_pages:
8139  0013 0000          	ds.b	2
8140                     	xdef	_file_lengt_in_pages
8141  0015               _mdr3:
8142  0015 00            	ds.b	1
8143                     	xdef	_mdr3
8144  0016               _mdr2:
8145  0016 00            	ds.b	1
8146                     	xdef	_mdr2
8147  0017               _mdr1:
8148  0017 00            	ds.b	1
8149                     	xdef	_mdr1
8150  0018               _mdr0:
8151  0018 00            	ds.b	1
8152                     	xdef	_mdr0
8153                     	xdef	_but_on_drv_cnt
8154                     	xdef	_but_drv_cnt
8155  0019               _sample:
8156  0019 00            	ds.b	1
8157                     	xdef	_sample
8158  001a               _rx_rd_index:
8159  001a 0000          	ds.b	2
8160                     	xdef	_rx_rd_index
8161  001c               _rx_wr_index:
8162  001c 0000          	ds.b	2
8163                     	xdef	_rx_wr_index
8164  001e               _rx_counter:
8165  001e 0000          	ds.b	2
8166                     	xdef	_rx_counter
8167                     	xdef	_rx_buffer
8168  0020               _tx_rd_index:
8169  0020 00            	ds.b	1
8170                     	xdef	_tx_rd_index
8171  0021               _tx_wr_index:
8172  0021 00            	ds.b	1
8173                     	xdef	_tx_wr_index
8174  0022               _tx_counter:
8175  0022 00            	ds.b	1
8176                     	xdef	_tx_counter
8177                     	xdef	_tx_buffer
8178  0023               _sample_cnt:
8179  0023 0000          	ds.b	2
8180                     	xdef	_sample_cnt
8181                     	xdef	_t0_cnt3
8182                     	xdef	_t0_cnt2
8183                     	xdef	_t0_cnt1
8184                     	xdef	_t0_cnt0
8185                     	xdef	_ST_bulk_erase
8186                     	xdef	_ST_READ
8187                     	xdef	_ST_WRITE
8188                     	xdef	_ST_WREN
8189                     	xdef	_ST_status_read
8190                     	xdef	_ST_RDID_read
8191                     	xdef	_uart_in_an
8192                     	xdef	_control_check
8193                     	xdef	_index_offset
8194                     	xdef	_uart_in
8195                     	xdef	_gpio_init
8196                     	xdef	_spi_init
8197                     	xdef	_spi
8198                     	xdef	_DF_buffer_to_page_er
8199                     	xdef	_DF_page_to_buffer
8200                     	xdef	_DF_buffer_write
8201                     	xdef	_DF_buffer_read
8202                     	xdef	_DF_status_read
8203                     	xdef	_DF_memo_to_256
8204                     	xdef	_DF_mf_dev_read
8205                     	xdef	_uart_init
8206                     	xdef	f_UARTRxInterrupt
8207                     	xdef	f_UARTTxInterrupt
8208                     	xdef	_putchar
8209                     	xdef	_uart_out_adr_block
8210                     	xdef	_uart_out
8211                     	xdef	f_TIM4_UPD_Interrupt
8212                     	xdef	_delay_ms
8213                     	xdef	_rele_drv
8214                     	xdef	_t4_init
8215                     	xdef	_t2_init
8216                     	xref.b	c_lreg
8217                     	xref.b	c_x
8218                     	xref.b	c_y
8238                     	xref	c_ladc
8239                     	xref	c_itolx
8240                     	xref	c_umul
8241                     	xref	c_eewrw
8242                     	xref	c_lglsh
8243                     	xref	c_uitolx
8244                     	xref	c_lgursh
8245                     	xref	c_lcmp
8246                     	xref	c_ltor
8247                     	xref	c_lgadc
8248                     	xref	c_rtol
8249                     	xref	c_vmul
8250                     	end
