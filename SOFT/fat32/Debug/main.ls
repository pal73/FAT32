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
2821  015a cd0886        	call	_putchar
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
2950  0188 cd0886        	call	_putchar
2952                     ; 191 temp11=10;
2954                     ; 192 t^=temp11;
2956  018b 7b02          	ld	a,(OFST-1,sp)
2957  018d a80a          	xor	a,	#10
2958  018f 6b02          	ld	(OFST-1,sp),a
2959                     ; 193 putchar(temp11);
2961  0191 a60a          	ld	a,#10
2962  0193 cd0886        	call	_putchar
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
2977  01a4 cd0886        	call	_putchar
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
2999  01be cd0886        	call	_putchar
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
3021  01d8 cd0886        	call	_putchar
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
3043  01f2 cd0886        	call	_putchar
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
3071  020f cd0886        	call	_putchar
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
3095  0228 cd0886        	call	_putchar
3097                     ; 223 putchar(t);
3099  022b 7b02          	ld	a,(OFST-1,sp)
3100  022d cd0886        	call	_putchar
3102                     ; 225 putchar(0x0a);
3104  0230 a60a          	ld	a,#10
3105  0232 cd0886        	call	_putchar
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
3265  0245 cc0883        	jp	L1771
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
3279  0255 cd0a3f        	call	_DF_mf_dev_read
3281  0258               L5771:
3282                     ; 241 			if(memory_manufacturer=='S') {
3284  0258 b6bc          	ld	a,_memory_manufacturer
3285  025a a153          	cp	a,#83
3286  025c 2603          	jrne	L7771
3287                     ; 242 				temp_L=ST_RDID_read();
3289  025e cd0947        	call	_ST_RDID_read
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
3306  027a ac830883      	jpf	L1771
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
3320  028b cd0a93        	call	_DF_status_read
3322  028e 6b04          	ld	(OFST+0,sp),a
3323  0290               L5002:
3324                     ; 258 		if(memory_manufacturer=='S') {
3326  0290 b6bc          	ld	a,_memory_manufacturer
3327  0292 a153          	cp	a,#83
3328  0294 2605          	jrne	L7002
3329                     ; 259 			temp=ST_status_read();
3331  0296 cd0973        	call	_ST_status_read
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
3350  02b1 ac830883      	jpf	L1771
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
3364  02c2 cd0a76        	call	_DF_memo_to_256
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
3382  02db ac830883      	jpf	L1771
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
3396  02ec cd0a76        	call	_DF_memo_to_256
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
3414  0305 ac830883      	jpf	L1771
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
3438  0329 cd0af3        	call	_DF_buffer_read
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
3511  0392 ac830883      	jpf	L1771
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
3542  03bb cc0883        	jp	L1771
3543  03be               L44:
3546  03be ae0050        	ldw	x,#_buff
3547  03c1 89            	pushw	x
3548  03c2 ae0100        	ldw	x,#256
3549  03c5 89            	pushw	x
3550  03c6 5f            	clrw	x
3551  03c7 cd0b39        	call	_DF_buffer_write
3553  03ca 5b04          	addw	sp,#4
3554  03cc ac830883      	jpf	L1771
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
3717  04a1 cc0883        	jp	L1771
3718  04a4               L05:
3721  04a4 ae0050        	ldw	x,#_buff
3722  04a7 89            	pushw	x
3723  04a8 ae0100        	ldw	x,#256
3724  04ab 89            	pushw	x
3725  04ac 5f            	clrw	x
3726  04ad cd0b39        	call	_DF_buffer_write
3728  04b0 5b04          	addw	sp,#4
3729  04b2 ac830883      	jpf	L1771
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
3746  04cb cd0aad        	call	_DF_page_to_buffer
3748  04ce               L3012:
3749                     ; 382 		if(memory_manufacturer=='S') {
3751  04ce b6bc          	ld	a,_memory_manufacturer
3752  04d0 a153          	cp	a,#83
3753  04d2 2703          	jreq	L25
3754  04d4 cc0883        	jp	L1771
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
3770  04ec cd09f1        	call	_ST_READ
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
3841  0555 ac830883      	jpf	L1771
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
3858  056b cd0ad0        	call	_DF_buffer_to_page_er
3860  056e               L3112:
3861                     ; 404 		if(memory_manufacturer=='S') {
3863  056e b6bc          	ld	a,_memory_manufacturer
3864  0570 a153          	cp	a,#83
3865  0572 2703          	jreq	L45
3866  0574 cc0883        	jp	L1771
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
3894  0594 cd0998        	call	_ST_WREN
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
3916  05b2 cd09a5        	call	_ST_WRITE
3918  05b5 5b08          	addw	sp,#8
3919  05b7 ac830883      	jpf	L1771
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
4006  0627 cd0998        	call	_ST_WREN
4008                     ; 439 					delay_ms(100); 
4010  062a ae0064        	ldw	x,#100
4011  062d cd0060        	call	_delay_ms
4013                     ; 440 		ST_bulk_erase();
4015  0630 cd098b        	call	_ST_bulk_erase
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
4033                     ; 443 		current_page_cnt=100;
4035  064c 35640001      	mov	_current_page_cnt,#100
4036                     ; 444 		current_page_cnt_=4;
4038  0650 35040000      	mov	_current_page_cnt_,#4
4040  0654 ac830883      	jpf	L1771
4041  0658               L7212:
4042                     ; 447 	else if(UIB[1]==21) 
4044  0658 c60001        	ld	a,_UIB+1
4045  065b a115          	cp	a,#21
4046  065d 2703          	jreq	L06
4047  065f cc0768        	jp	L5312
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
4101  069e cc0883        	jp	L1771
4102  06a1               L26:
4103                     ; 482 			if(memory_manufacturer=='A') {
4105  06a1 b6bc          	ld	a,_memory_manufacturer
4106  06a3 a141          	cp	a,#65
4107  06a5 264e          	jrne	L5512
4108                     ; 483 				DF_buffer_write(/*//current_buffer*//*1,*/0,256,buff);
4110  06a7 ae0050        	ldw	x,#_buff
4111  06aa 89            	pushw	x
4112  06ab ae0100        	ldw	x,#256
4113  06ae 89            	pushw	x
4114  06af 5f            	clrw	x
4115  06b0 cd0b39        	call	_DF_buffer_write
4117  06b3 5b04          	addw	sp,#4
4118                     ; 484 				DF_buffer_to_page_er(/*///current_buffer*//*1,*/current_page);
4120  06b5 be11          	ldw	x,_current_page
4121  06b7 cd0ad0        	call	_DF_buffer_to_page_er
4123                     ; 485 				current_page++;
4125  06ba be11          	ldw	x,_current_page
4126  06bc 1c0001        	addw	x,#1
4127  06bf bf11          	ldw	_current_page,x
4128                     ; 486 				if(current_page<file_lengt_in_pages)
4130  06c1 be11          	ldw	x,_current_page
4131  06c3 b313          	cpw	x,_file_lengt_in_pages
4132  06c5 2424          	jruge	L7512
4133                     ; 488 					delay_ms(100);
4135  06c7 ae0064        	ldw	x,#100
4136  06ca cd0060        	call	_delay_ms
4138                     ; 489 					uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
4140  06cd 4b00          	push	#0
4141  06cf 4b00          	push	#0
4142  06d1 3b0011        	push	_current_page
4143  06d4 b612          	ld	a,_current_page+1
4144  06d6 a4ff          	and	a,#255
4145  06d8 88            	push	a
4146  06d9 4b15          	push	#21
4147  06db ae0016        	ldw	x,#22
4148  06de a604          	ld	a,#4
4149  06e0 95            	ld	xh,a
4150  06e1 cd00d2        	call	_uart_out
4152  06e4 5b05          	addw	sp,#5
4153                     ; 490 					current_byte_in_buffer=0;
4155  06e6 5f            	clrw	x
4156  06e7 bf0d          	ldw	_current_byte_in_buffer,x
4158  06e9 200a          	jra	L5512
4159  06eb               L7512:
4160                     ; 494 					EE_PAGE_LEN=current_page;
4162  06eb be11          	ldw	x,_current_page
4163  06ed 89            	pushw	x
4164  06ee ae0000        	ldw	x,#_EE_PAGE_LEN
4165  06f1 cd0000        	call	c_eewrw
4167  06f4 85            	popw	x
4168  06f5               L5512:
4169                     ; 497 			if(memory_manufacturer=='S') {
4171  06f5 b6bc          	ld	a,_memory_manufacturer
4172  06f7 a153          	cp	a,#83
4173  06f9 2703          	jreq	L46
4174  06fb cc0883        	jp	L1771
4175  06fe               L46:
4176                     ; 498 				ST_WREN();
4178  06fe cd0998        	call	_ST_WREN
4180                     ; 499 				delay_ms(100);
4182  0701 ae0064        	ldw	x,#100
4183  0704 cd0060        	call	_delay_ms
4185                     ; 500 				ST_WRITE((unsigned long)(current_page*256UL),256,buff);
4187  0707 ae0050        	ldw	x,#_buff
4188  070a 89            	pushw	x
4189  070b ae0100        	ldw	x,#256
4190  070e 89            	pushw	x
4191  070f be11          	ldw	x,_current_page
4192  0711 90ae0100      	ldw	y,#256
4193  0715 cd0000        	call	c_umul
4195  0718 be02          	ldw	x,c_lreg+2
4196  071a 89            	pushw	x
4197  071b be00          	ldw	x,c_lreg
4198  071d 89            	pushw	x
4199  071e cd09a5        	call	_ST_WRITE
4201  0721 5b08          	addw	sp,#8
4202                     ; 501 				current_page++;
4204  0723 be11          	ldw	x,_current_page
4205  0725 1c0001        	addw	x,#1
4206  0728 bf11          	ldw	_current_page,x
4207                     ; 502 				if(current_page<file_lengt_in_pages)
4209  072a be11          	ldw	x,_current_page
4210  072c b313          	cpw	x,_file_lengt_in_pages
4211  072e 242a          	jruge	L5612
4212                     ; 504 					delay_ms(100);
4214  0730 ae0064        	ldw	x,#100
4215  0733 cd0060        	call	_delay_ms
4217                     ; 505 					uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
4219  0736 4b00          	push	#0
4220  0738 4b00          	push	#0
4221  073a 3b0011        	push	_current_page
4222  073d b612          	ld	a,_current_page+1
4223  073f a4ff          	and	a,#255
4224  0741 88            	push	a
4225  0742 4b15          	push	#21
4226  0744 ae0016        	ldw	x,#22
4227  0747 a604          	ld	a,#4
4228  0749 95            	ld	xh,a
4229  074a cd00d2        	call	_uart_out
4231  074d 5b05          	addw	sp,#5
4232                     ; 506 					current_page_cnt=100;
4234  074f 35640001      	mov	_current_page_cnt,#100
4235                     ; 507 					current_byte_in_buffer=0;
4237  0753 5f            	clrw	x
4238  0754 bf0d          	ldw	_current_byte_in_buffer,x
4240  0756 ac830883      	jpf	L1771
4241  075a               L5612:
4242                     ; 511 					EE_PAGE_LEN=current_page;
4244  075a be11          	ldw	x,_current_page
4245  075c 89            	pushw	x
4246  075d ae0000        	ldw	x,#_EE_PAGE_LEN
4247  0760 cd0000        	call	c_eewrw
4249  0763 85            	popw	x
4250  0764 ac830883      	jpf	L1771
4251  0768               L5312:
4252                     ; 522 	else if(UIB[1]==24) {
4254  0768 c60001        	ld	a,_UIB+1
4255  076b a118          	cp	a,#24
4256  076d 2615          	jrne	L3712
4257                     ; 525 		rele_cnt=10;
4259  076f ae000a        	ldw	x,#10
4260  0772 bf05          	ldw	_rele_cnt,x
4261                     ; 526 		ST_WREN();
4263  0774 cd0998        	call	_ST_WREN
4265                     ; 527 		delay_ms(100);
4267  0777 ae0064        	ldw	x,#100
4268  077a cd0060        	call	_delay_ms
4270                     ; 528 		ST_bulk_erase();
4272  077d cd098b        	call	_ST_bulk_erase
4275  0780 ac830883      	jpf	L1771
4276  0784               L3712:
4277                     ; 533 	else if(UIB[1]==25)
4279  0784 c60001        	ld	a,_UIB+1
4280  0787 a119          	cp	a,#25
4281  0789 2703          	jreq	L66
4282  078b cc086b        	jp	L7712
4283  078e               L66:
4284                     ; 537 		current_page=0;
4286  078e 5f            	clrw	x
4287  078f bf11          	ldw	_current_page,x
4288                     ; 539 		for(i__=0;i__<EE_PAGE_LEN;i__++)
4290  0791 5f            	clrw	x
4291  0792 1f03          	ldw	(OFST-1,sp),x
4293  0794 ac5f085f      	jpf	L5022
4294  0798               L1022:
4295                     ; 541 			if(memory_manufacturer=='S') {	
4297  0798 b6bc          	ld	a,_memory_manufacturer
4298  079a a153          	cp	a,#83
4299  079c 2619          	jrne	L1122
4300                     ; 542 				DF_page_to_buffer(i__);
4302  079e 1e03          	ldw	x,(OFST-1,sp)
4303  07a0 cd0aad        	call	_DF_page_to_buffer
4305                     ; 543 				delay_ms(100);			
4307  07a3 ae0064        	ldw	x,#100
4308  07a6 cd0060        	call	_delay_ms
4310                     ; 544 				DF_buffer_read(0,256, buff);
4312  07a9 ae0050        	ldw	x,#_buff
4313  07ac 89            	pushw	x
4314  07ad ae0100        	ldw	x,#256
4315  07b0 89            	pushw	x
4316  07b1 5f            	clrw	x
4317  07b2 cd0af3        	call	_DF_buffer_read
4319  07b5 5b04          	addw	sp,#4
4320  07b7               L1122:
4321                     ; 547 			if(memory_manufacturer=='S') {	
4323  07b7 b6bc          	ld	a,_memory_manufacturer
4324  07b9 a153          	cp	a,#83
4325  07bb 261a          	jrne	L3122
4326                     ; 548 				ST_READ((long)(i__*256),256, buff);
4328  07bd ae0050        	ldw	x,#_buff
4329  07c0 89            	pushw	x
4330  07c1 ae0100        	ldw	x,#256
4331  07c4 89            	pushw	x
4332  07c5 1e07          	ldw	x,(OFST+3,sp)
4333  07c7 4f            	clr	a
4334  07c8 02            	rlwa	x,a
4335  07c9 cd0000        	call	c_itolx
4337  07cc be02          	ldw	x,c_lreg+2
4338  07ce 89            	pushw	x
4339  07cf be00          	ldw	x,c_lreg
4340  07d1 89            	pushw	x
4341  07d2 cd09f1        	call	_ST_READ
4343  07d5 5b08          	addw	sp,#8
4344  07d7               L3122:
4345                     ; 551 			uart_out_adr_block ((256*i__)+0,buff,64);
4347  07d7 4b40          	push	#64
4348  07d9 ae0050        	ldw	x,#_buff
4349  07dc 89            	pushw	x
4350  07dd 1e06          	ldw	x,(OFST+2,sp)
4351  07df 4f            	clr	a
4352  07e0 02            	rlwa	x,a
4353  07e1 cd0000        	call	c_itolx
4355  07e4 be02          	ldw	x,c_lreg+2
4356  07e6 89            	pushw	x
4357  07e7 be00          	ldw	x,c_lreg
4358  07e9 89            	pushw	x
4359  07ea cd017c        	call	_uart_out_adr_block
4361  07ed 5b07          	addw	sp,#7
4362                     ; 552 			delay_ms(100);    
4364  07ef ae0064        	ldw	x,#100
4365  07f2 cd0060        	call	_delay_ms
4367                     ; 553 			uart_out_adr_block ((256*i__)+64,&buff[64],64);
4369  07f5 4b40          	push	#64
4370  07f7 ae0090        	ldw	x,#_buff+64
4371  07fa 89            	pushw	x
4372  07fb 1e06          	ldw	x,(OFST+2,sp)
4373  07fd 4f            	clr	a
4374  07fe 02            	rlwa	x,a
4375  07ff 1c0040        	addw	x,#64
4376  0802 cd0000        	call	c_itolx
4378  0805 be02          	ldw	x,c_lreg+2
4379  0807 89            	pushw	x
4380  0808 be00          	ldw	x,c_lreg
4381  080a 89            	pushw	x
4382  080b cd017c        	call	_uart_out_adr_block
4384  080e 5b07          	addw	sp,#7
4385                     ; 554 			delay_ms(100);    
4387  0810 ae0064        	ldw	x,#100
4388  0813 cd0060        	call	_delay_ms
4390                     ; 555 			uart_out_adr_block ((256*i__)+128,&buff[128],64);
4392  0816 4b40          	push	#64
4393  0818 ae00d0        	ldw	x,#_buff+128
4394  081b 89            	pushw	x
4395  081c 1e06          	ldw	x,(OFST+2,sp)
4396  081e 4f            	clr	a
4397  081f 02            	rlwa	x,a
4398  0820 1c0080        	addw	x,#128
4399  0823 cd0000        	call	c_itolx
4401  0826 be02          	ldw	x,c_lreg+2
4402  0828 89            	pushw	x
4403  0829 be00          	ldw	x,c_lreg
4404  082b 89            	pushw	x
4405  082c cd017c        	call	_uart_out_adr_block
4407  082f 5b07          	addw	sp,#7
4408                     ; 556 			delay_ms(100);    
4410  0831 ae0064        	ldw	x,#100
4411  0834 cd0060        	call	_delay_ms
4413                     ; 557 			uart_out_adr_block ((256*i__)+192,&buff[192],64);
4415  0837 4b40          	push	#64
4416  0839 ae0110        	ldw	x,#_buff+192
4417  083c 89            	pushw	x
4418  083d 1e06          	ldw	x,(OFST+2,sp)
4419  083f 4f            	clr	a
4420  0840 02            	rlwa	x,a
4421  0841 1c00c0        	addw	x,#192
4422  0844 cd0000        	call	c_itolx
4424  0847 be02          	ldw	x,c_lreg+2
4425  0849 89            	pushw	x
4426  084a be00          	ldw	x,c_lreg
4427  084c 89            	pushw	x
4428  084d cd017c        	call	_uart_out_adr_block
4430  0850 5b07          	addw	sp,#7
4431                     ; 558 			delay_ms(100);   
4433  0852 ae0064        	ldw	x,#100
4434  0855 cd0060        	call	_delay_ms
4436                     ; 539 		for(i__=0;i__<EE_PAGE_LEN;i__++)
4438  0858 1e03          	ldw	x,(OFST-1,sp)
4439  085a 1c0001        	addw	x,#1
4440  085d 1f03          	ldw	(OFST-1,sp),x
4441  085f               L5022:
4444  085f 1e03          	ldw	x,(OFST-1,sp)
4445  0861 c30000        	cpw	x,_EE_PAGE_LEN
4446  0864 2403          	jruge	L07
4447  0866 cc0798        	jp	L1022
4448  0869               L07:
4450  0869 2018          	jra	L1771
4451  086b               L7712:
4452                     ; 568 	else if(UIB[1]==30)
4454  086b c60001        	ld	a,_UIB+1
4455  086e a11e          	cp	a,#30
4456  0870 2606          	jrne	L7122
4457                     ; 590           bSTART=1;
4459  0872 7210000c      	bset	_bSTART
4461  0876 200b          	jra	L1771
4462  0878               L7122:
4463                     ; 602 	else if(UIB[1]==40)
4465  0878 c60001        	ld	a,_UIB+1
4466  087b a128          	cp	a,#40
4467  087d 2604          	jrne	L1771
4468                     ; 624 		bSTART=1;	
4470  087f 7210000c      	bset	_bSTART
4471  0883               L1771:
4472                     ; 629 }
4475  0883 5b04          	addw	sp,#4
4476  0885 81            	ret
4513                     ; 632 void putchar(char c)
4513                     ; 633 {
4514                     	switch	.text
4515  0886               _putchar:
4517  0886 88            	push	a
4518       00000000      OFST:	set	0
4521  0887               L5422:
4522                     ; 634 while (tx_counter == TX_BUFFER_SIZE);
4524  0887 b622          	ld	a,_tx_counter
4525  0889 a150          	cp	a,#80
4526  088b 27fa          	jreq	L5422
4527                     ; 636 if (tx_counter || ((UART1->SR & UART1_SR_TXE)==0))
4529  088d 3d22          	tnz	_tx_counter
4530  088f 2607          	jrne	L3522
4532  0891 c65230        	ld	a,21040
4533  0894 a580          	bcp	a,#128
4534  0896 261d          	jrne	L1522
4535  0898               L3522:
4536                     ; 638    tx_buffer[tx_wr_index]=c;
4538  0898 5f            	clrw	x
4539  0899 b621          	ld	a,_tx_wr_index
4540  089b 2a01          	jrpl	L47
4541  089d 53            	cplw	x
4542  089e               L47:
4543  089e 97            	ld	xl,a
4544  089f 7b01          	ld	a,(OFST+1,sp)
4545  08a1 e704          	ld	(_tx_buffer,x),a
4546                     ; 639    if (++tx_wr_index == TX_BUFFER_SIZE) tx_wr_index=0;
4548  08a3 3c21          	inc	_tx_wr_index
4549  08a5 b621          	ld	a,_tx_wr_index
4550  08a7 a150          	cp	a,#80
4551  08a9 2602          	jrne	L5522
4554  08ab 3f21          	clr	_tx_wr_index
4555  08ad               L5522:
4556                     ; 640    ++tx_counter;
4558  08ad 3c22          	inc	_tx_counter
4560  08af               L7522:
4561                     ; 644 UART1->CR2|= UART1_CR2_TIEN;
4563  08af 721e5235      	bset	21045,#7
4564                     ; 646 }
4567  08b3 84            	pop	a
4568  08b4 81            	ret
4569  08b5               L1522:
4570                     ; 642 else UART1->DR=c;
4572  08b5 7b01          	ld	a,(OFST+1,sp)
4573  08b7 c75231        	ld	21041,a
4574  08ba 20f3          	jra	L7522
4597                     ; 649 void spi_init(void){
4598                     	switch	.text
4599  08bc               _spi_init:
4603                     ; 651 	GPIOA->DDR|=(1<<3);
4605  08bc 72165002      	bset	20482,#3
4606                     ; 652 	GPIOA->CR1|=(1<<3);
4608  08c0 72165003      	bset	20483,#3
4609                     ; 653 	GPIOA->CR2&=~(1<<3);
4611  08c4 72175004      	bres	20484,#3
4612                     ; 654 	GPIOA->ODR|=(1<<3);	
4614  08c8 72165000      	bset	20480,#3
4615                     ; 657 	GPIOB->DDR|=(1<<5);
4617  08cc 721a5007      	bset	20487,#5
4618                     ; 658 	GPIOB->CR1|=(1<<5);
4620  08d0 721a5008      	bset	20488,#5
4621                     ; 659 	GPIOB->CR2&=~(1<<5);
4623  08d4 721b5009      	bres	20489,#5
4624                     ; 660 	GPIOB->ODR|=(1<<5);	
4626  08d8 721a5005      	bset	20485,#5
4627                     ; 662 	GPIOC->DDR|=(1<<3);
4629  08dc 7216500c      	bset	20492,#3
4630                     ; 663 	GPIOC->CR1|=(1<<3);
4632  08e0 7216500d      	bset	20493,#3
4633                     ; 664 	GPIOC->CR2&=~(1<<3);
4635  08e4 7217500e      	bres	20494,#3
4636                     ; 665 	GPIOC->ODR|=(1<<3);	
4638  08e8 7216500a      	bset	20490,#3
4639                     ; 667 	GPIOC->DDR|=(1<<5);
4641  08ec 721a500c      	bset	20492,#5
4642                     ; 668 	GPIOC->CR1|=(1<<5);
4644  08f0 721a500d      	bset	20493,#5
4645                     ; 669 	GPIOC->CR2|=(1<<5);
4647  08f4 721a500e      	bset	20494,#5
4648                     ; 670 	GPIOC->ODR|=(1<<5);	
4650  08f8 721a500a      	bset	20490,#5
4651                     ; 672 	GPIOC->DDR|=(1<<6);
4653  08fc 721c500c      	bset	20492,#6
4654                     ; 673 	GPIOC->CR1|=(1<<6);
4656  0900 721c500d      	bset	20493,#6
4657                     ; 674 	GPIOC->CR2|=(1<<6);
4659  0904 721c500e      	bset	20494,#6
4660                     ; 675 	GPIOC->ODR|=(1<<6);	
4662  0908 721c500a      	bset	20490,#6
4663                     ; 677 	GPIOC->DDR&=~(1<<7);
4665  090c 721f500c      	bres	20492,#7
4666                     ; 678 	GPIOC->CR1&=~(1<<7);
4668  0910 721f500d      	bres	20493,#7
4669                     ; 679 	GPIOC->CR2&=~(1<<7);
4671  0914 721f500e      	bres	20494,#7
4672                     ; 680 	GPIOC->ODR|=(1<<7);	
4674  0918 721e500a      	bset	20490,#7
4675                     ; 682 	SPI->CR1= /*SPI_CR1_LSBFIRST |*/
4675                     ; 683 			SPI_CR1_SPE | 
4675                     ; 684 			( (4<< 3) & SPI_CR1_BR ) |
4675                     ; 685 			SPI_CR1_MSTR |
4675                     ; 686 			SPI_CR1_CPOL |
4675                     ; 687 			SPI_CR1_CPHA; 
4677  091c 35675200      	mov	20992,#103
4678                     ; 689 	SPI->CR2= SPI_CR2_SSM | SPI_CR2_SSI;
4680  0920 35035201      	mov	20993,#3
4681                     ; 690 	SPI->ICR= 0;	
4683  0924 725f5202      	clr	20994
4684                     ; 691 }
4687  0928 81            	ret
4730                     ; 694 char spi(char in){
4731                     	switch	.text
4732  0929               _spi:
4734  0929 88            	push	a
4735  092a 88            	push	a
4736       00000001      OFST:	set	1
4739  092b               L5132:
4740                     ; 696 	while(!((SPI->SR)&SPI_SR_TXE));
4742  092b c65203        	ld	a,20995
4743  092e a502          	bcp	a,#2
4744  0930 27f9          	jreq	L5132
4745                     ; 697 	SPI->DR=in;
4747  0932 7b02          	ld	a,(OFST+1,sp)
4748  0934 c75204        	ld	20996,a
4750  0937               L5232:
4751                     ; 698 	while(!((SPI->SR)&SPI_SR_RXNE));
4753  0937 c65203        	ld	a,20995
4754  093a a501          	bcp	a,#1
4755  093c 27f9          	jreq	L5232
4756                     ; 699 	c=SPI->DR;	
4758  093e c65204        	ld	a,20996
4759  0941 6b01          	ld	(OFST+0,sp),a
4760                     ; 700 	return c;
4762  0943 7b01          	ld	a,(OFST+0,sp)
4765  0945 85            	popw	x
4766  0946 81            	ret
4831                     ; 704 long ST_RDID_read(void)
4831                     ; 705 {
4832                     	switch	.text
4833  0947               _ST_RDID_read:
4835  0947 5204          	subw	sp,#4
4836       00000004      OFST:	set	4
4839                     ; 708 d0=0;
4841  0949 0f04          	clr	(OFST+0,sp)
4842                     ; 709 d1=0;
4844                     ; 710 d2=0;
4846                     ; 711 d3=0;
4848                     ; 713 ST_CS_ON
4850  094b 721b5005      	bres	20485,#5
4851                     ; 714 spi(0x9f);
4853  094f a69f          	ld	a,#159
4854  0951 add6          	call	_spi
4856                     ; 715 mdr0=spi(0xff);
4858  0953 a6ff          	ld	a,#255
4859  0955 add2          	call	_spi
4861  0957 b718          	ld	_mdr0,a
4862                     ; 716 mdr1=spi(0xff);
4864  0959 a6ff          	ld	a,#255
4865  095b adcc          	call	_spi
4867  095d b717          	ld	_mdr1,a
4868                     ; 717 mdr2=spi(0xff);
4870  095f a6ff          	ld	a,#255
4871  0961 adc6          	call	_spi
4873  0963 b716          	ld	_mdr2,a
4874                     ; 720 ST_CS_OFF
4876  0965 721a5005      	bset	20485,#5
4877                     ; 721 return  *((long*)&d0);
4879  0969 96            	ldw	x,sp
4880  096a 1c0004        	addw	x,#OFST+0
4881  096d cd0000        	call	c_ltor
4885  0970 5b04          	addw	sp,#4
4886  0972 81            	ret
4921                     ; 725 char ST_status_read(void)
4921                     ; 726 {
4922                     	switch	.text
4923  0973               _ST_status_read:
4925  0973 88            	push	a
4926       00000001      OFST:	set	1
4929                     ; 730 ST_CS_ON
4931  0974 721b5005      	bres	20485,#5
4932                     ; 731 spi(0x05);
4934  0978 a605          	ld	a,#5
4935  097a adad          	call	_spi
4937                     ; 732 d0=spi(0xff);
4939  097c a6ff          	ld	a,#255
4940  097e ada9          	call	_spi
4942  0980 6b01          	ld	(OFST+0,sp),a
4943                     ; 734 ST_CS_OFF
4945  0982 721a5005      	bset	20485,#5
4946                     ; 735 return d0;
4948  0986 7b01          	ld	a,(OFST+0,sp)
4951  0988 5b01          	addw	sp,#1
4952  098a 81            	ret
4976                     ; 739 void ST_bulk_erase(void)
4976                     ; 740 {
4977                     	switch	.text
4978  098b               _ST_bulk_erase:
4982                     ; 741 ST_CS_ON
4984  098b 721b5005      	bres	20485,#5
4985                     ; 742 spi(0xC7);
4987  098f a6c7          	ld	a,#199
4988  0991 ad96          	call	_spi
4990                     ; 745 ST_CS_OFF
4992  0993 721a5005      	bset	20485,#5
4993                     ; 746 }
4996  0997 81            	ret
5020                     ; 748 void ST_WREN(void)
5020                     ; 749 {
5021                     	switch	.text
5022  0998               _ST_WREN:
5026                     ; 751 ST_CS_ON
5028  0998 721b5005      	bres	20485,#5
5029                     ; 752 spi(0x06);
5031  099c a606          	ld	a,#6
5032  099e ad89          	call	_spi
5034                     ; 754 ST_CS_OFF
5036  09a0 721a5005      	bset	20485,#5
5037                     ; 755 }  
5040  09a4 81            	ret
5130                     ; 758 void ST_WRITE(unsigned long memo_addr,unsigned short len, char* adr)
5130                     ; 759 {
5131                     	switch	.text
5132  09a5               _ST_WRITE:
5134  09a5 5205          	subw	sp,#5
5135       00000005      OFST:	set	5
5138                     ; 763 adr2=(char)(memo_addr>>16);
5140  09a7 7b09          	ld	a,(OFST+4,sp)
5141  09a9 6b03          	ld	(OFST-2,sp),a
5142                     ; 764 adr1=(char)((memo_addr>>8)&0x00ff);
5144  09ab 7b0a          	ld	a,(OFST+5,sp)
5145  09ad a4ff          	and	a,#255
5146  09af 6b02          	ld	(OFST-3,sp),a
5147                     ; 765 adr0=(char)((memo_addr)&0x00ff);
5149  09b1 7b0b          	ld	a,(OFST+6,sp)
5150  09b3 a4ff          	and	a,#255
5151  09b5 6b01          	ld	(OFST-4,sp),a
5152                     ; 766 ST_CS_ON
5154  09b7 721b5005      	bres	20485,#5
5155                     ; 768 spi(0x02);
5157  09bb a602          	ld	a,#2
5158  09bd cd0929        	call	_spi
5160                     ; 769 spi(adr2);
5162  09c0 7b03          	ld	a,(OFST-2,sp)
5163  09c2 cd0929        	call	_spi
5165                     ; 770 spi(adr1);
5167  09c5 7b02          	ld	a,(OFST-3,sp)
5168  09c7 cd0929        	call	_spi
5170                     ; 771 spi(adr0);
5172  09ca 7b01          	ld	a,(OFST-4,sp)
5173  09cc cd0929        	call	_spi
5175                     ; 773 for(i=0;i<len;i++)
5177  09cf 5f            	clrw	x
5178  09d0 1f04          	ldw	(OFST-1,sp),x
5180  09d2 2010          	jra	L3742
5181  09d4               L7642:
5182                     ; 775 	spi(adr[i]);
5184  09d4 1e0e          	ldw	x,(OFST+9,sp)
5185  09d6 72fb04        	addw	x,(OFST-1,sp)
5186  09d9 f6            	ld	a,(x)
5187  09da cd0929        	call	_spi
5189                     ; 773 for(i=0;i<len;i++)
5191  09dd 1e04          	ldw	x,(OFST-1,sp)
5192  09df 1c0001        	addw	x,#1
5193  09e2 1f04          	ldw	(OFST-1,sp),x
5194  09e4               L3742:
5197  09e4 1e04          	ldw	x,(OFST-1,sp)
5198  09e6 130c          	cpw	x,(OFST+7,sp)
5199  09e8 25ea          	jrult	L7642
5200                     ; 778 ST_CS_OFF
5202  09ea 721a5005      	bset	20485,#5
5203                     ; 779 }
5206  09ee 5b05          	addw	sp,#5
5207  09f0 81            	ret
5297                     ; 782 void ST_READ(unsigned long memo_addr,unsigned short len, char* adr)
5297                     ; 783 {
5298                     	switch	.text
5299  09f1               _ST_READ:
5301  09f1 5205          	subw	sp,#5
5302       00000005      OFST:	set	5
5305                     ; 789 adr2=(char)(memo_addr>>16);
5307  09f3 7b09          	ld	a,(OFST+4,sp)
5308  09f5 6b03          	ld	(OFST-2,sp),a
5309                     ; 790 adr1=(char)((memo_addr>>8)&0x00ff);
5311  09f7 7b0a          	ld	a,(OFST+5,sp)
5312  09f9 a4ff          	and	a,#255
5313  09fb 6b02          	ld	(OFST-3,sp),a
5314                     ; 791 adr0=(char)((memo_addr)&0x00ff);
5316  09fd 7b0b          	ld	a,(OFST+6,sp)
5317  09ff a4ff          	and	a,#255
5318  0a01 6b01          	ld	(OFST-4,sp),a
5319                     ; 792 ST_CS_ON
5321  0a03 721b5005      	bres	20485,#5
5322                     ; 793 spi(0x03);
5324  0a07 a603          	ld	a,#3
5325  0a09 cd0929        	call	_spi
5327                     ; 794 spi(adr2);
5329  0a0c 7b03          	ld	a,(OFST-2,sp)
5330  0a0e cd0929        	call	_spi
5332                     ; 795 spi(adr1);
5334  0a11 7b02          	ld	a,(OFST-3,sp)
5335  0a13 cd0929        	call	_spi
5337                     ; 796 spi(adr0);
5339  0a16 7b01          	ld	a,(OFST-4,sp)
5340  0a18 cd0929        	call	_spi
5342                     ; 798 for(i=0;i<len;i++)
5344  0a1b 5f            	clrw	x
5345  0a1c 1f04          	ldw	(OFST-1,sp),x
5347  0a1e 2012          	jra	L1552
5348  0a20               L5452:
5349                     ; 800 	adr[i]=spi(0xff);
5351  0a20 a6ff          	ld	a,#255
5352  0a22 cd0929        	call	_spi
5354  0a25 1e0e          	ldw	x,(OFST+9,sp)
5355  0a27 72fb04        	addw	x,(OFST-1,sp)
5356  0a2a f7            	ld	(x),a
5357                     ; 798 for(i=0;i<len;i++)
5359  0a2b 1e04          	ldw	x,(OFST-1,sp)
5360  0a2d 1c0001        	addw	x,#1
5361  0a30 1f04          	ldw	(OFST-1,sp),x
5362  0a32               L1552:
5365  0a32 1e04          	ldw	x,(OFST-1,sp)
5366  0a34 130c          	cpw	x,(OFST+7,sp)
5367  0a36 25e8          	jrult	L5452
5368                     ; 803 ST_CS_OFF
5370  0a38 721a5005      	bset	20485,#5
5371                     ; 804 }
5374  0a3c 5b05          	addw	sp,#5
5375  0a3e 81            	ret
5441                     ; 808 long DF_mf_dev_read(void)
5441                     ; 809 {
5442                     	switch	.text
5443  0a3f               _DF_mf_dev_read:
5445  0a3f 5204          	subw	sp,#4
5446       00000004      OFST:	set	4
5449                     ; 812 d0=0;
5451  0a41 0f04          	clr	(OFST+0,sp)
5452                     ; 813 d1=0;
5454                     ; 814 d2=0;
5456                     ; 815 d3=0;
5458                     ; 817 CS_ON
5460  0a43 7217500a      	bres	20490,#3
5461                     ; 818 spi(0x9f);
5463  0a47 a69f          	ld	a,#159
5464  0a49 cd0929        	call	_spi
5466                     ; 819 mdr0=spi(0xff);
5468  0a4c a6ff          	ld	a,#255
5469  0a4e cd0929        	call	_spi
5471  0a51 b718          	ld	_mdr0,a
5472                     ; 820 mdr1=spi(0xff);
5474  0a53 a6ff          	ld	a,#255
5475  0a55 cd0929        	call	_spi
5477  0a58 b717          	ld	_mdr1,a
5478                     ; 821 mdr2=spi(0xff);
5480  0a5a a6ff          	ld	a,#255
5481  0a5c cd0929        	call	_spi
5483  0a5f b716          	ld	_mdr2,a
5484                     ; 822 mdr3=spi(0xff);  
5486  0a61 a6ff          	ld	a,#255
5487  0a63 cd0929        	call	_spi
5489  0a66 b715          	ld	_mdr3,a
5490                     ; 824 CS_OFF
5492  0a68 7216500a      	bset	20490,#3
5493                     ; 825 return  *((long*)&d0);
5495  0a6c 96            	ldw	x,sp
5496  0a6d 1c0004        	addw	x,#OFST+0
5497  0a70 cd0000        	call	c_ltor
5501  0a73 5b04          	addw	sp,#4
5502  0a75 81            	ret
5526                     ; 829 void DF_memo_to_256(void)
5526                     ; 830 {
5527                     	switch	.text
5528  0a76               _DF_memo_to_256:
5532                     ; 832 CS_ON
5534  0a76 7217500a      	bres	20490,#3
5535                     ; 833 spi(0x3d);
5537  0a7a a63d          	ld	a,#61
5538  0a7c cd0929        	call	_spi
5540                     ; 834 spi(0x2a); 
5542  0a7f a62a          	ld	a,#42
5543  0a81 cd0929        	call	_spi
5545                     ; 835 spi(0x80);
5547  0a84 a680          	ld	a,#128
5548  0a86 cd0929        	call	_spi
5550                     ; 836 spi(0xa6);
5552  0a89 a6a6          	ld	a,#166
5553  0a8b cd0929        	call	_spi
5555                     ; 838 CS_OFF
5557  0a8e 7216500a      	bset	20490,#3
5558                     ; 839 }  
5561  0a92 81            	ret
5596                     ; 844 char DF_status_read(void)
5596                     ; 845 {
5597                     	switch	.text
5598  0a93               _DF_status_read:
5600  0a93 88            	push	a
5601       00000001      OFST:	set	1
5604                     ; 849 CS_ON
5606  0a94 7217500a      	bres	20490,#3
5607                     ; 850 spi(0xd7);
5609  0a98 a6d7          	ld	a,#215
5610  0a9a cd0929        	call	_spi
5612                     ; 851 d0=spi(0xff);
5614  0a9d a6ff          	ld	a,#255
5615  0a9f cd0929        	call	_spi
5617  0aa2 6b01          	ld	(OFST+0,sp),a
5618                     ; 853 CS_OFF
5620  0aa4 7216500a      	bset	20490,#3
5621                     ; 854 return d0;
5623  0aa8 7b01          	ld	a,(OFST+0,sp)
5626  0aaa 5b01          	addw	sp,#1
5627  0aac 81            	ret
5671                     ; 858 void DF_page_to_buffer(unsigned page_addr)
5671                     ; 859 {
5672                     	switch	.text
5673  0aad               _DF_page_to_buffer:
5675  0aad 89            	pushw	x
5676  0aae 88            	push	a
5677       00000001      OFST:	set	1
5680                     ; 862 d0=0x53; 
5682                     ; 866 CS_ON
5684  0aaf 7217500a      	bres	20490,#3
5685                     ; 867 spi(d0);
5687  0ab3 a653          	ld	a,#83
5688  0ab5 cd0929        	call	_spi
5690                     ; 868 spi(page_addr/256/**(((char*)&page_addr)+1)*/);
5692  0ab8 7b02          	ld	a,(OFST+1,sp)
5693  0aba cd0929        	call	_spi
5695                     ; 869 spi(page_addr%256/**((char*)&page_addr)*/);
5697  0abd 7b03          	ld	a,(OFST+2,sp)
5698  0abf a4ff          	and	a,#255
5699  0ac1 cd0929        	call	_spi
5701                     ; 870 spi(0xff);
5703  0ac4 a6ff          	ld	a,#255
5704  0ac6 cd0929        	call	_spi
5706                     ; 872 CS_OFF
5708  0ac9 7216500a      	bset	20490,#3
5709                     ; 873 }
5712  0acd 5b03          	addw	sp,#3
5713  0acf 81            	ret
5758                     ; 876 void DF_buffer_to_page_er(/*char buff,*/unsigned page_addr)
5758                     ; 877 {
5759                     	switch	.text
5760  0ad0               _DF_buffer_to_page_er:
5762  0ad0 89            	pushw	x
5763  0ad1 88            	push	a
5764       00000001      OFST:	set	1
5767                     ; 880 d0=0x83; 
5769                     ; 883 CS_ON
5771  0ad2 7217500a      	bres	20490,#3
5772                     ; 884 spi(d0);
5774  0ad6 a683          	ld	a,#131
5775  0ad8 cd0929        	call	_spi
5777                     ; 885 spi(page_addr/256/**(((char*)&page_addr)+1)*/);
5779  0adb 7b02          	ld	a,(OFST+1,sp)
5780  0add cd0929        	call	_spi
5782                     ; 886 spi(page_addr%256/**((char*)&page_addr)*/);
5784  0ae0 7b03          	ld	a,(OFST+2,sp)
5785  0ae2 a4ff          	and	a,#255
5786  0ae4 cd0929        	call	_spi
5788                     ; 887 spi(0xff);
5790  0ae7 a6ff          	ld	a,#255
5791  0ae9 cd0929        	call	_spi
5793                     ; 889 CS_OFF
5795  0aec 7216500a      	bset	20490,#3
5796                     ; 890 }
5799  0af0 5b03          	addw	sp,#3
5800  0af2 81            	ret
5872                     ; 893 void DF_buffer_read(unsigned buff_addr,unsigned len, char* adr)
5872                     ; 894 {
5873                     	switch	.text
5874  0af3               _DF_buffer_read:
5876  0af3 89            	pushw	x
5877  0af4 5203          	subw	sp,#3
5878       00000003      OFST:	set	3
5881                     ; 898 d0=0x54; 
5883                     ; 900 CS_ON
5885  0af6 7217500a      	bres	20490,#3
5886                     ; 901 spi(d0);
5888  0afa a654          	ld	a,#84
5889  0afc cd0929        	call	_spi
5891                     ; 902 spi(0xff);
5893  0aff a6ff          	ld	a,#255
5894  0b01 cd0929        	call	_spi
5896                     ; 903 spi(buff_addr/256/**(((char*)&buff_addr)+1)*/);
5898  0b04 7b04          	ld	a,(OFST+1,sp)
5899  0b06 cd0929        	call	_spi
5901                     ; 904 spi(buff_addr%256/**((char*)&buff_addr)*/);
5903  0b09 7b05          	ld	a,(OFST+2,sp)
5904  0b0b a4ff          	and	a,#255
5905  0b0d cd0929        	call	_spi
5907                     ; 905 spi(0xff);
5909  0b10 a6ff          	ld	a,#255
5910  0b12 cd0929        	call	_spi
5912                     ; 906 for(i=0;i<len;i++)
5914  0b15 5f            	clrw	x
5915  0b16 1f02          	ldw	(OFST-1,sp),x
5917  0b18 2012          	jra	L3472
5918  0b1a               L7372:
5919                     ; 908 	adr[i]=spi(0xff);
5921  0b1a a6ff          	ld	a,#255
5922  0b1c cd0929        	call	_spi
5924  0b1f 1e0a          	ldw	x,(OFST+7,sp)
5925  0b21 72fb02        	addw	x,(OFST-1,sp)
5926  0b24 f7            	ld	(x),a
5927                     ; 906 for(i=0;i<len;i++)
5929  0b25 1e02          	ldw	x,(OFST-1,sp)
5930  0b27 1c0001        	addw	x,#1
5931  0b2a 1f02          	ldw	(OFST-1,sp),x
5932  0b2c               L3472:
5935  0b2c 1e02          	ldw	x,(OFST-1,sp)
5936  0b2e 1308          	cpw	x,(OFST+5,sp)
5937  0b30 25e8          	jrult	L7372
5938                     ; 911 CS_OFF
5940  0b32 7216500a      	bset	20490,#3
5941                     ; 912 }
5944  0b36 5b05          	addw	sp,#5
5945  0b38 81            	ret
6017                     ; 915 void DF_buffer_write(/*char buff,*/unsigned buff_addr,unsigned len, char* adr)
6017                     ; 916 {
6018                     	switch	.text
6019  0b39               _DF_buffer_write:
6021  0b39 89            	pushw	x
6022  0b3a 5203          	subw	sp,#3
6023       00000003      OFST:	set	3
6026                     ; 920 d0=0x84; 
6028                     ; 922 CS_ON
6030  0b3c 7217500a      	bres	20490,#3
6031                     ; 923 spi(d0);
6033  0b40 a684          	ld	a,#132
6034  0b42 cd0929        	call	_spi
6036                     ; 924 spi(0xff);
6038  0b45 a6ff          	ld	a,#255
6039  0b47 cd0929        	call	_spi
6041                     ; 925 spi(buff_addr/256/**(((char*)&buff_addr)+1)*/);
6043  0b4a 7b04          	ld	a,(OFST+1,sp)
6044  0b4c cd0929        	call	_spi
6046                     ; 926 spi(buff_addr%256/**((char*)&buff_addr)*/);
6048  0b4f 7b05          	ld	a,(OFST+2,sp)
6049  0b51 a4ff          	and	a,#255
6050  0b53 cd0929        	call	_spi
6052                     ; 928 for(i=0;i<len;i++)
6054  0b56 5f            	clrw	x
6055  0b57 1f02          	ldw	(OFST-1,sp),x
6057  0b59 2010          	jra	L1103
6058  0b5b               L5003:
6059                     ; 930 	spi(adr[i]);
6061  0b5b 1e0a          	ldw	x,(OFST+7,sp)
6062  0b5d 72fb02        	addw	x,(OFST-1,sp)
6063  0b60 f6            	ld	a,(x)
6064  0b61 cd0929        	call	_spi
6066                     ; 928 for(i=0;i<len;i++)
6068  0b64 1e02          	ldw	x,(OFST-1,sp)
6069  0b66 1c0001        	addw	x,#1
6070  0b69 1f02          	ldw	(OFST-1,sp),x
6071  0b6b               L1103:
6074  0b6b 1e02          	ldw	x,(OFST-1,sp)
6075  0b6d 1308          	cpw	x,(OFST+5,sp)
6076  0b6f 25ea          	jrult	L5003
6077                     ; 933 CS_OFF
6079  0b71 7216500a      	bset	20490,#3
6080                     ; 934 }
6083  0b75 5b05          	addw	sp,#5
6084  0b77 81            	ret
6107                     ; 956 void gpio_init(void){
6108                     	switch	.text
6109  0b78               _gpio_init:
6113                     ; 966 	GPIOD->DDR|=(1<<2);
6115  0b78 72145011      	bset	20497,#2
6116                     ; 967 	GPIOD->CR1|=(1<<2);
6118  0b7c 72145012      	bset	20498,#2
6119                     ; 968 	GPIOD->CR2|=(1<<2);
6121  0b80 72145013      	bset	20499,#2
6122                     ; 969 	GPIOD->ODR&=~(1<<2);
6124  0b84 7215500f      	bres	20495,#2
6125                     ; 971 	GPIOD->DDR|=(1<<4);
6127  0b88 72185011      	bset	20497,#4
6128                     ; 972 	GPIOD->CR1|=(1<<4);
6130  0b8c 72185012      	bset	20498,#4
6131                     ; 973 	GPIOD->CR2&=~(1<<4);
6133  0b90 72195013      	bres	20499,#4
6134                     ; 975 	GPIOC->DDR&=~(1<<4);
6136  0b94 7219500c      	bres	20492,#4
6137                     ; 976 	GPIOC->CR1&=~(1<<4);
6139  0b98 7219500d      	bres	20493,#4
6140                     ; 977 	GPIOC->CR2&=~(1<<4);
6142  0b9c 7219500e      	bres	20494,#4
6143                     ; 981 }
6146  0ba0 81            	ret
6198                     ; 984 void uart_in(void)
6198                     ; 985 {
6199                     	switch	.text
6200  0ba1               _uart_in:
6202  0ba1 89            	pushw	x
6203       00000002      OFST:	set	2
6206                     ; 989 if(rx_buffer_overflow)
6208                     	btst	_rx_buffer_overflow
6209  0ba7 240d          	jruge	L7403
6210                     ; 991 	rx_wr_index=0;
6212  0ba9 5f            	clrw	x
6213  0baa bf1c          	ldw	_rx_wr_index,x
6214                     ; 992 	rx_rd_index=0;
6216  0bac 5f            	clrw	x
6217  0bad bf1a          	ldw	_rx_rd_index,x
6218                     ; 993 	rx_counter=0;
6220  0baf 5f            	clrw	x
6221  0bb0 bf1e          	ldw	_rx_counter,x
6222                     ; 994 	rx_buffer_overflow=0;
6224  0bb2 72110001      	bres	_rx_buffer_overflow
6225  0bb6               L7403:
6226                     ; 997 if(rx_counter&&(rx_buffer[index_offset(rx_wr_index,-1)])==END)
6228  0bb6 be1e          	ldw	x,_rx_counter
6229  0bb8 2775          	jreq	L1503
6231  0bba aeffff        	ldw	x,#65535
6232  0bbd 89            	pushw	x
6233  0bbe be1c          	ldw	x,_rx_wr_index
6234  0bc0 ad6f          	call	_index_offset
6236  0bc2 5b02          	addw	sp,#2
6237  0bc4 e654          	ld	a,(_rx_buffer,x)
6238  0bc6 a10a          	cp	a,#10
6239  0bc8 2665          	jrne	L1503
6240                     ; 1002 	temp=rx_buffer[index_offset(rx_wr_index,-3)];
6242  0bca aefffd        	ldw	x,#65533
6243  0bcd 89            	pushw	x
6244  0bce be1c          	ldw	x,_rx_wr_index
6245  0bd0 ad5f          	call	_index_offset
6247  0bd2 5b02          	addw	sp,#2
6248  0bd4 e654          	ld	a,(_rx_buffer,x)
6249  0bd6 6b01          	ld	(OFST-1,sp),a
6250                     ; 1003     	if(temp<100) 
6252  0bd8 7b01          	ld	a,(OFST-1,sp)
6253  0bda a164          	cp	a,#100
6254  0bdc 2451          	jruge	L1503
6255                     ; 1006     		if(control_check(index_offset(rx_wr_index,-1)))
6257  0bde aeffff        	ldw	x,#65535
6258  0be1 89            	pushw	x
6259  0be2 be1c          	ldw	x,_rx_wr_index
6260  0be4 ad4b          	call	_index_offset
6262  0be6 5b02          	addw	sp,#2
6263  0be8 9f            	ld	a,xl
6264  0be9 ad6e          	call	_control_check
6266  0beb 4d            	tnz	a
6267  0bec 2741          	jreq	L1503
6268                     ; 1009     			rx_rd_index=index_offset(rx_wr_index,-3-temp);
6270  0bee a6ff          	ld	a,#255
6271  0bf0 97            	ld	xl,a
6272  0bf1 a6fd          	ld	a,#253
6273  0bf3 1001          	sub	a,(OFST-1,sp)
6274  0bf5 2401          	jrnc	L041
6275  0bf7 5a            	decw	x
6276  0bf8               L041:
6277  0bf8 02            	rlwa	x,a
6278  0bf9 89            	pushw	x
6279  0bfa 01            	rrwa	x,a
6280  0bfb be1c          	ldw	x,_rx_wr_index
6281  0bfd ad32          	call	_index_offset
6283  0bff 5b02          	addw	sp,#2
6284  0c01 bf1a          	ldw	_rx_rd_index,x
6285                     ; 1010     			for(i=0;i<temp;i++)
6287  0c03 0f02          	clr	(OFST+0,sp)
6289  0c05 2018          	jra	L3603
6290  0c07               L7503:
6291                     ; 1012 				UIB[i]=rx_buffer[index_offset(rx_rd_index,i)];
6293  0c07 7b02          	ld	a,(OFST+0,sp)
6294  0c09 5f            	clrw	x
6295  0c0a 97            	ld	xl,a
6296  0c0b 89            	pushw	x
6297  0c0c 7b04          	ld	a,(OFST+2,sp)
6298  0c0e 5f            	clrw	x
6299  0c0f 97            	ld	xl,a
6300  0c10 89            	pushw	x
6301  0c11 be1a          	ldw	x,_rx_rd_index
6302  0c13 ad1c          	call	_index_offset
6304  0c15 5b02          	addw	sp,#2
6305  0c17 e654          	ld	a,(_rx_buffer,x)
6306  0c19 85            	popw	x
6307  0c1a d70000        	ld	(_UIB,x),a
6308                     ; 1010     			for(i=0;i<temp;i++)
6310  0c1d 0c02          	inc	(OFST+0,sp)
6311  0c1f               L3603:
6314  0c1f 7b02          	ld	a,(OFST+0,sp)
6315  0c21 1101          	cp	a,(OFST-1,sp)
6316  0c23 25e2          	jrult	L7503
6317                     ; 1014 			rx_rd_index=rx_wr_index;
6319  0c25 be1c          	ldw	x,_rx_wr_index
6320  0c27 bf1a          	ldw	_rx_rd_index,x
6321                     ; 1015 			rx_counter=0;
6323  0c29 5f            	clrw	x
6324  0c2a bf1e          	ldw	_rx_counter,x
6325                     ; 1025 			uart_in_an();
6327  0c2c cd023c        	call	_uart_in_an
6329  0c2f               L1503:
6330                     ; 1034 }
6333  0c2f 85            	popw	x
6334  0c30 81            	ret
6377                     ; 1037 signed short index_offset (signed short index,signed short offset)
6377                     ; 1038 {
6378                     	switch	.text
6379  0c31               _index_offset:
6381  0c31 89            	pushw	x
6382       00000000      OFST:	set	0
6385                     ; 1039 index=index+offset;
6387  0c32 1e01          	ldw	x,(OFST+1,sp)
6388  0c34 72fb05        	addw	x,(OFST+5,sp)
6389  0c37 1f01          	ldw	(OFST+1,sp),x
6390                     ; 1040 if(index>=RX_BUFFER_SIZE) index-=RX_BUFFER_SIZE; 
6392  0c39 9c            	rvf
6393  0c3a 1e01          	ldw	x,(OFST+1,sp)
6394  0c3c a30064        	cpw	x,#100
6395  0c3f 2f07          	jrslt	L1113
6398  0c41 1e01          	ldw	x,(OFST+1,sp)
6399  0c43 1d0064        	subw	x,#100
6400  0c46 1f01          	ldw	(OFST+1,sp),x
6401  0c48               L1113:
6402                     ; 1041 if(index<0) index+=RX_BUFFER_SIZE;
6404  0c48 9c            	rvf
6405  0c49 1e01          	ldw	x,(OFST+1,sp)
6406  0c4b 2e07          	jrsge	L3113
6409  0c4d 1e01          	ldw	x,(OFST+1,sp)
6410  0c4f 1c0064        	addw	x,#100
6411  0c52 1f01          	ldw	(OFST+1,sp),x
6412  0c54               L3113:
6413                     ; 1042 return index;
6415  0c54 1e01          	ldw	x,(OFST+1,sp)
6418  0c56 5b02          	addw	sp,#2
6419  0c58 81            	ret
6482                     ; 1046 char control_check(char index)
6482                     ; 1047 {
6483                     	switch	.text
6484  0c59               _control_check:
6486  0c59 88            	push	a
6487  0c5a 5203          	subw	sp,#3
6488       00000003      OFST:	set	3
6491                     ; 1048 char i=0,ii=0,iii;
6495                     ; 1050 if(rx_buffer[index]!=END) return 0;
6497  0c5c 5f            	clrw	x
6498  0c5d 97            	ld	xl,a
6499  0c5e e654          	ld	a,(_rx_buffer,x)
6500  0c60 a10a          	cp	a,#10
6501  0c62 2703          	jreq	L7413
6504  0c64 4f            	clr	a
6506  0c65 2051          	jra	L251
6507  0c67               L7413:
6508                     ; 1052 ii=rx_buffer[index_offset(index,-2)];
6510  0c67 aefffe        	ldw	x,#65534
6511  0c6a 89            	pushw	x
6512  0c6b 7b06          	ld	a,(OFST+3,sp)
6513  0c6d 5f            	clrw	x
6514  0c6e 97            	ld	xl,a
6515  0c6f adc0          	call	_index_offset
6517  0c71 5b02          	addw	sp,#2
6518  0c73 e654          	ld	a,(_rx_buffer,x)
6519  0c75 6b02          	ld	(OFST-1,sp),a
6520                     ; 1053 iii=0;
6522  0c77 0f01          	clr	(OFST-2,sp)
6523                     ; 1054 for(i=0;i<=ii;i++)
6525  0c79 0f03          	clr	(OFST+0,sp)
6527  0c7b 2022          	jra	L5513
6528  0c7d               L1513:
6529                     ; 1056 	iii^=rx_buffer[index_offset(index,-2-ii+i)];
6531  0c7d a6ff          	ld	a,#255
6532  0c7f 97            	ld	xl,a
6533  0c80 a6fe          	ld	a,#254
6534  0c82 1002          	sub	a,(OFST-1,sp)
6535  0c84 2401          	jrnc	L641
6536  0c86 5a            	decw	x
6537  0c87               L641:
6538  0c87 1b03          	add	a,(OFST+0,sp)
6539  0c89 2401          	jrnc	L051
6540  0c8b 5c            	incw	x
6541  0c8c               L051:
6542  0c8c 02            	rlwa	x,a
6543  0c8d 89            	pushw	x
6544  0c8e 01            	rrwa	x,a
6545  0c8f 7b06          	ld	a,(OFST+3,sp)
6546  0c91 5f            	clrw	x
6547  0c92 97            	ld	xl,a
6548  0c93 ad9c          	call	_index_offset
6550  0c95 5b02          	addw	sp,#2
6551  0c97 7b01          	ld	a,(OFST-2,sp)
6552  0c99 e854          	xor	a,	(_rx_buffer,x)
6553  0c9b 6b01          	ld	(OFST-2,sp),a
6554                     ; 1054 for(i=0;i<=ii;i++)
6556  0c9d 0c03          	inc	(OFST+0,sp)
6557  0c9f               L5513:
6560  0c9f 7b03          	ld	a,(OFST+0,sp)
6561  0ca1 1102          	cp	a,(OFST-1,sp)
6562  0ca3 23d8          	jrule	L1513
6563                     ; 1058 if (iii!=rx_buffer[index_offset(index,-1)]) return 0;	
6565  0ca5 aeffff        	ldw	x,#65535
6566  0ca8 89            	pushw	x
6567  0ca9 7b06          	ld	a,(OFST+3,sp)
6568  0cab 5f            	clrw	x
6569  0cac 97            	ld	xl,a
6570  0cad ad82          	call	_index_offset
6572  0caf 5b02          	addw	sp,#2
6573  0cb1 e654          	ld	a,(_rx_buffer,x)
6574  0cb3 1101          	cp	a,(OFST-2,sp)
6575  0cb5 2704          	jreq	L1613
6578  0cb7 4f            	clr	a
6580  0cb8               L251:
6582  0cb8 5b04          	addw	sp,#4
6583  0cba 81            	ret
6584  0cbb               L1613:
6585                     ; 1060 return 1;
6587  0cbb a601          	ld	a,#1
6589  0cbd 20f9          	jra	L251
6631                     ; 1069 @far @interrupt void TIM4_UPD_Interrupt (void) {
6633                     	switch	.text
6634  0cbf               f_TIM4_UPD_Interrupt:
6638                     ; 1071 	if(play) {
6640                     	btst	_play
6641  0cc4 2445          	jruge	L3713
6642                     ; 1072 		TIM2->CCR3H= 0x00;	
6644  0cc6 725f5315      	clr	21269
6645                     ; 1073 		TIM2->CCR3L= sample;
6647  0cca 5500195316    	mov	21270,_sample
6648                     ; 1074 		sample_cnt++;
6650  0ccf be23          	ldw	x,_sample_cnt
6651  0cd1 1c0001        	addw	x,#1
6652  0cd4 bf23          	ldw	_sample_cnt,x
6653                     ; 1075 		if(sample_cnt>=256) {
6655  0cd6 9c            	rvf
6656  0cd7 be23          	ldw	x,_sample_cnt
6657  0cd9 a30100        	cpw	x,#256
6658  0cdc 2f03          	jrslt	L5713
6659                     ; 1076 			sample_cnt=0;
6661  0cde 5f            	clrw	x
6662  0cdf bf23          	ldw	_sample_cnt,x
6663  0ce1               L5713:
6664                     ; 1080 		sample=buff[sample_cnt];
6666  0ce1 be23          	ldw	x,_sample_cnt
6667  0ce3 d60050        	ld	a,(_buff,x)
6668  0ce6 b719          	ld	_sample,a
6669                     ; 1082 		if(sample_cnt==132)	{
6671  0ce8 be23          	ldw	x,_sample_cnt
6672  0cea a30084        	cpw	x,#132
6673  0ced 2604          	jrne	L7713
6674                     ; 1083 			bBUFF_LOAD=1;
6676  0cef 7210000b      	bset	_bBUFF_LOAD
6677  0cf3               L7713:
6678                     ; 1087 		if(sample_cnt==5) {
6680  0cf3 be23          	ldw	x,_sample_cnt
6681  0cf5 a30005        	cpw	x,#5
6682  0cf8 2604          	jrne	L1023
6683                     ; 1088 			bBUFF_READ_H=1;
6685  0cfa 7210000a      	bset	_bBUFF_READ_H
6686  0cfe               L1023:
6687                     ; 1091 		if(sample_cnt==150) {
6689  0cfe be23          	ldw	x,_sample_cnt
6690  0d00 a30096        	cpw	x,#150
6691  0d03 2615          	jrne	L5023
6692                     ; 1092 			bBUFF_READ_L=1;
6694  0d05 72100009      	bset	_bBUFF_READ_L
6695  0d09 200f          	jra	L5023
6696  0d0b               L3713:
6697                     ; 1099 	else if(!bSTART) {
6699                     	btst	_bSTART
6700  0d10 2508          	jrult	L5023
6701                     ; 1100 		TIM2->CCR3H= 0x00;	
6703  0d12 725f5315      	clr	21269
6704                     ; 1101 		TIM2->CCR3L= 0x7f;//pwm_fade_in;
6706  0d16 357f5316      	mov	21270,#127
6707  0d1a               L5023:
6708                     ; 1156 		if(but_block_cnt)but_on_drv_cnt=0;
6710  0d1a be02          	ldw	x,_but_block_cnt
6711  0d1c 2702          	jreq	L1123
6714  0d1e 3fb9          	clr	_but_on_drv_cnt
6715  0d20               L1123:
6716                     ; 1157 		if((((GPIOC->IDR)&(1<<4))) && (but_on_drv_cnt<100)) {
6718  0d20 c6500b        	ld	a,20491
6719  0d23 a510          	bcp	a,#16
6720  0d25 271f          	jreq	L3123
6722  0d27 b6b9          	ld	a,_but_on_drv_cnt
6723  0d29 a164          	cp	a,#100
6724  0d2b 2419          	jruge	L3123
6725                     ; 1158 			but_on_drv_cnt++;
6727  0d2d 3cb9          	inc	_but_on_drv_cnt
6728                     ; 1159 			if((but_on_drv_cnt>2)&&(bRELEASE))
6730  0d2f b6b9          	ld	a,_but_on_drv_cnt
6731  0d31 a103          	cp	a,#3
6732  0d33 2517          	jrult	L7123
6734                     	btst	_bRELEASE
6735  0d3a 2410          	jruge	L7123
6736                     ; 1161 				bRELEASE=0;
6738  0d3c 72110000      	bres	_bRELEASE
6739                     ; 1162 				bSTART=1;
6741  0d40 7210000c      	bset	_bSTART
6742  0d44 2006          	jra	L7123
6743  0d46               L3123:
6744                     ; 1166 			but_on_drv_cnt=0;
6746  0d46 3fb9          	clr	_but_on_drv_cnt
6747                     ; 1167 			bRELEASE=1;
6749  0d48 72100000      	bset	_bRELEASE
6750  0d4c               L7123:
6751                     ; 1172 	if(++t0_cnt0>=125){
6753  0d4c 3c00          	inc	_t0_cnt0
6754  0d4e b600          	ld	a,_t0_cnt0
6755  0d50 a17d          	cp	a,#125
6756  0d52 2530          	jrult	L1223
6757                     ; 1173     		t0_cnt0=0;
6759  0d54 3f00          	clr	_t0_cnt0
6760                     ; 1174     		b100Hz=1;
6762  0d56 72100008      	bset	_b100Hz
6763                     ; 1184 		if(++t0_cnt1>=10){
6765  0d5a 3c01          	inc	_t0_cnt1
6766  0d5c b601          	ld	a,_t0_cnt1
6767  0d5e a10a          	cp	a,#10
6768  0d60 2506          	jrult	L3223
6769                     ; 1185 			t0_cnt1=0;
6771  0d62 3f01          	clr	_t0_cnt1
6772                     ; 1186 			b10Hz=1;
6774  0d64 72100007      	bset	_b10Hz
6775  0d68               L3223:
6776                     ; 1189 		if(++t0_cnt2>=20){
6778  0d68 3c02          	inc	_t0_cnt2
6779  0d6a b602          	ld	a,_t0_cnt2
6780  0d6c a114          	cp	a,#20
6781  0d6e 2506          	jrult	L5223
6782                     ; 1190 			t0_cnt2=0;
6784  0d70 3f02          	clr	_t0_cnt2
6785                     ; 1191 			b5Hz=1;
6787  0d72 72100006      	bset	_b5Hz
6788  0d76               L5223:
6789                     ; 1194 		if(++t0_cnt3>=100){
6791  0d76 3c03          	inc	_t0_cnt3
6792  0d78 b603          	ld	a,_t0_cnt3
6793  0d7a a164          	cp	a,#100
6794  0d7c 2506          	jrult	L1223
6795                     ; 1195 			t0_cnt3=0;
6797  0d7e 3f03          	clr	_t0_cnt3
6798                     ; 1196 			b1Hz=1;
6800  0d80 72100005      	bset	_b1Hz
6801  0d84               L1223:
6802                     ; 1200 	TIM4->SR1&=~TIM4_SR1_UIF;			// disable break interrupt
6804  0d84 72115344      	bres	21316,#0
6805                     ; 1201 	return;
6808  0d88 80            	iret
6834                     ; 1205 @far @interrupt void UARTTxInterrupt (void) {
6835                     	switch	.text
6836  0d89               f_UARTTxInterrupt:
6840                     ; 1207 	if (tx_counter){
6842  0d89 3d22          	tnz	_tx_counter
6843  0d8b 271a          	jreq	L1423
6844                     ; 1208 		--tx_counter;
6846  0d8d 3a22          	dec	_tx_counter
6847                     ; 1209 		UART1->DR=tx_buffer[tx_rd_index];
6849  0d8f 5f            	clrw	x
6850  0d90 b620          	ld	a,_tx_rd_index
6851  0d92 2a01          	jrpl	L061
6852  0d94 53            	cplw	x
6853  0d95               L061:
6854  0d95 97            	ld	xl,a
6855  0d96 e604          	ld	a,(_tx_buffer,x)
6856  0d98 c75231        	ld	21041,a
6857                     ; 1210 		if (++tx_rd_index == TX_BUFFER_SIZE) tx_rd_index=0;
6859  0d9b 3c20          	inc	_tx_rd_index
6860  0d9d b620          	ld	a,_tx_rd_index
6861  0d9f a150          	cp	a,#80
6862  0da1 260c          	jrne	L5423
6865  0da3 3f20          	clr	_tx_rd_index
6866  0da5 2008          	jra	L5423
6867  0da7               L1423:
6868                     ; 1213 		bOUT_FREE=1;
6870  0da7 72100003      	bset	_bOUT_FREE
6871                     ; 1214 		UART1->CR2&= ~UART1_CR2_TIEN;
6873  0dab 721f5235      	bres	21045,#7
6874  0daf               L5423:
6875                     ; 1216 }
6878  0daf 80            	iret
6907                     ; 1219 @far @interrupt void UARTRxInterrupt (void) {
6908                     	switch	.text
6909  0db0               f_UARTRxInterrupt:
6913                     ; 1224 	rx_status=UART1->SR;
6915  0db0 5552300008    	mov	_rx_status,21040
6916                     ; 1225 	rx_data=UART1->DR;
6918  0db5 5552310007    	mov	_rx_data,21041
6919                     ; 1227 	if (rx_status & (UART1_SR_RXNE)){
6921  0dba b608          	ld	a,_rx_status
6922  0dbc a520          	bcp	a,#32
6923  0dbe 272c          	jreq	L7523
6924                     ; 1228 		rx_buffer[rx_wr_index]=rx_data;
6926  0dc0 be1c          	ldw	x,_rx_wr_index
6927  0dc2 b607          	ld	a,_rx_data
6928  0dc4 e754          	ld	(_rx_buffer,x),a
6929                     ; 1229 		bRXIN=1;
6931  0dc6 72100002      	bset	_bRXIN
6932                     ; 1230 		if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
6934  0dca be1c          	ldw	x,_rx_wr_index
6935  0dcc 1c0001        	addw	x,#1
6936  0dcf bf1c          	ldw	_rx_wr_index,x
6937  0dd1 a30064        	cpw	x,#100
6938  0dd4 2603          	jrne	L1623
6941  0dd6 5f            	clrw	x
6942  0dd7 bf1c          	ldw	_rx_wr_index,x
6943  0dd9               L1623:
6944                     ; 1231 		if (++rx_counter == RX_BUFFER_SIZE){
6946  0dd9 be1e          	ldw	x,_rx_counter
6947  0ddb 1c0001        	addw	x,#1
6948  0dde bf1e          	ldw	_rx_counter,x
6949  0de0 a30064        	cpw	x,#100
6950  0de3 2607          	jrne	L7523
6951                     ; 1232 			rx_counter=0;
6953  0de5 5f            	clrw	x
6954  0de6 bf1e          	ldw	_rx_counter,x
6955                     ; 1233 			rx_buffer_overflow=1;
6957  0de8 72100001      	bset	_rx_buffer_overflow
6958  0dec               L7523:
6959                     ; 1236 }
6962  0dec 80            	iret
7024                     ; 1242 main()
7024                     ; 1243 {
7026                     	switch	.text
7027  0ded               _main:
7031                     ; 1244 CLK->CKDIVR=0;
7033  0ded 725f50c6      	clr	20678
7034                     ; 1246 rele_cnt_index=0;
7036  0df1 3fbb          	clr	_rele_cnt_index
7037                     ; 1248 GPIOD->DDR&=~(1<<6);
7039  0df3 721d5011      	bres	20497,#6
7040                     ; 1249 GPIOD->CR1|=(1<<6);
7042  0df7 721c5012      	bset	20498,#6
7043                     ; 1250 GPIOD->CR2|=(1<<6);
7045  0dfb 721c5013      	bset	20499,#6
7046                     ; 1252 GPIOD->DDR|=(1<<5);
7048  0dff 721a5011      	bset	20497,#5
7049                     ; 1253 GPIOD->CR1|=(1<<5);
7051  0e03 721a5012      	bset	20498,#5
7052                     ; 1254 GPIOD->CR2|=(1<<5);	
7054  0e07 721a5013      	bset	20499,#5
7055                     ; 1255 GPIOD->ODR|=(1<<5);
7057  0e0b 721a500f      	bset	20495,#5
7058                     ; 1257 delay_ms(10);
7060  0e0f ae000a        	ldw	x,#10
7061  0e12 cd0060        	call	_delay_ms
7063                     ; 1259 if(!(GPIOD->IDR&=(1<<6))) 
7065  0e15 c65010        	ld	a,20496
7066  0e18 a440          	and	a,#64
7067  0e1a c75010        	ld	20496,a
7068  0e1d 2606          	jrne	L5723
7069                     ; 1261 	rele_cnt_index=1;
7071  0e1f 350100bb      	mov	_rele_cnt_index,#1
7073  0e23 2018          	jra	L7723
7074  0e25               L5723:
7075                     ; 1265 	GPIOD->ODR&=~(1<<5);
7077  0e25 721b500f      	bres	20495,#5
7078                     ; 1266 	delay_ms(10);
7080  0e29 ae000a        	ldw	x,#10
7081  0e2c cd0060        	call	_delay_ms
7083                     ; 1267 	if(!(GPIOD->IDR&=(1<<6))) 
7085  0e2f c65010        	ld	a,20496
7086  0e32 a440          	and	a,#64
7087  0e34 c75010        	ld	20496,a
7088  0e37 2604          	jrne	L7723
7089                     ; 1269 		rele_cnt_index=2;
7091  0e39 350200bb      	mov	_rele_cnt_index,#2
7092  0e3d               L7723:
7093                     ; 1273 gpio_init();
7095  0e3d cd0b78        	call	_gpio_init
7097                     ; 1280 spi_init();
7099  0e40 cd08bc        	call	_spi_init
7101                     ; 1282 t4_init();
7103  0e43 cd0039        	call	_t4_init
7105                     ; 1284 FLASH_DUKR=0xae;
7107  0e46 35ae5064      	mov	_FLASH_DUKR,#174
7108                     ; 1285 FLASH_DUKR=0x56;
7110  0e4a 35565064      	mov	_FLASH_DUKR,#86
7111                     ; 1290 dumm[1]++;
7113  0e4e 725c017d      	inc	_dumm+1
7114                     ; 1292 uart_init();
7116  0e52 cd00a2        	call	_uart_init
7118                     ; 1294 ST_RDID_read();
7120  0e55 cd0947        	call	_ST_RDID_read
7122                     ; 1295 if(mdr0==0x20) memory_manufacturer='S';	
7124  0e58 b618          	ld	a,_mdr0
7125  0e5a a120          	cp	a,#32
7126  0e5c 2606          	jrne	L3033
7129  0e5e 355300bc      	mov	_memory_manufacturer,#83
7131  0e62 200d          	jra	L5033
7132  0e64               L3033:
7133                     ; 1298 	DF_mf_dev_read();
7135  0e64 cd0a3f        	call	_DF_mf_dev_read
7137                     ; 1299 	if(mdr0==0x1F) memory_manufacturer='A';
7139  0e67 b618          	ld	a,_mdr0
7140  0e69 a11f          	cp	a,#31
7141  0e6b 2604          	jrne	L5033
7144  0e6d 354100bc      	mov	_memory_manufacturer,#65
7145  0e71               L5033:
7146                     ; 1302 t2_init();
7148  0e71 cd0000        	call	_t2_init
7150                     ; 1304 ST_WREN();
7152  0e74 cd0998        	call	_ST_WREN
7154                     ; 1306 enableInterrupts();	
7157  0e77 9a            rim
7159  0e78               L1133:
7160                     ; 1311 	if(bBUFF_LOAD)
7162                     	btst	_bBUFF_LOAD
7163  0e7d 2425          	jruge	L5133
7164                     ; 1313 		bBUFF_LOAD=0;
7166  0e7f 7211000b      	bres	_bBUFF_LOAD
7167                     ; 1315 		if(current_page<last_page)
7169  0e83 be11          	ldw	x,_current_page
7170  0e85 b30f          	cpw	x,_last_page
7171  0e87 2409          	jruge	L7133
7172                     ; 1317 			current_page++;
7174  0e89 be11          	ldw	x,_current_page
7175  0e8b 1c0001        	addw	x,#1
7176  0e8e bf11          	ldw	_current_page,x
7178  0e90 2007          	jra	L1233
7179  0e92               L7133:
7180                     ; 1321 			current_page=0;
7182  0e92 5f            	clrw	x
7183  0e93 bf11          	ldw	_current_page,x
7184                     ; 1322 			play=0;
7186  0e95 72110004      	bres	_play
7187  0e99               L1233:
7188                     ; 1324 		if(memory_manufacturer=='A')
7190  0e99 b6bc          	ld	a,_memory_manufacturer
7191  0e9b a141          	cp	a,#65
7192  0e9d 2605          	jrne	L5133
7193                     ; 1326 			DF_page_to_buffer(/*///current_buffer_H*//*1,*/current_page);
7195  0e9f be11          	ldw	x,_current_page
7196  0ea1 cd0aad        	call	_DF_page_to_buffer
7198  0ea4               L5133:
7199                     ; 1330 	if(bBUFF_READ_L)
7201                     	btst	_bBUFF_READ_L
7202  0ea9 243a          	jruge	L5233
7203                     ; 1332 		bBUFF_READ_L=0;
7205  0eab 72110009      	bres	_bBUFF_READ_L
7206                     ; 1333 		if(memory_manufacturer=='A')
7208  0eaf b6bc          	ld	a,_memory_manufacturer
7209  0eb1 a141          	cp	a,#65
7210  0eb3 260e          	jrne	L7233
7211                     ; 1335 			DF_buffer_read(/*///current_buffer_L*//*1,*/0,128,buff);
7213  0eb5 ae0050        	ldw	x,#_buff
7214  0eb8 89            	pushw	x
7215  0eb9 ae0080        	ldw	x,#128
7216  0ebc 89            	pushw	x
7217  0ebd 5f            	clrw	x
7218  0ebe cd0af3        	call	_DF_buffer_read
7220  0ec1 5b04          	addw	sp,#4
7221  0ec3               L7233:
7222                     ; 1337 		if(memory_manufacturer=='S')
7224  0ec3 b6bc          	ld	a,_memory_manufacturer
7225  0ec5 a153          	cp	a,#83
7226  0ec7 261c          	jrne	L5233
7227                     ; 1339 			ST_READ((unsigned long)((unsigned long)(current_page*256UL)),128,buff);
7229  0ec9 ae0050        	ldw	x,#_buff
7230  0ecc 89            	pushw	x
7231  0ecd ae0080        	ldw	x,#128
7232  0ed0 89            	pushw	x
7233  0ed1 be11          	ldw	x,_current_page
7234  0ed3 90ae0100      	ldw	y,#256
7235  0ed7 cd0000        	call	c_umul
7237  0eda be02          	ldw	x,c_lreg+2
7238  0edc 89            	pushw	x
7239  0edd be00          	ldw	x,c_lreg
7240  0edf 89            	pushw	x
7241  0ee0 cd09f1        	call	_ST_READ
7243  0ee3 5b08          	addw	sp,#8
7244  0ee5               L5233:
7245                     ; 1343 	if(bBUFF_READ_H) 
7247                     	btst	_bBUFF_READ_H
7248  0eea 2441          	jruge	L3333
7249                     ; 1345 		bBUFF_READ_H=0;
7251  0eec 7211000a      	bres	_bBUFF_READ_H
7252                     ; 1346 		if(memory_manufacturer=='A') 
7254  0ef0 b6bc          	ld	a,_memory_manufacturer
7255  0ef2 a141          	cp	a,#65
7256  0ef4 2610          	jrne	L5333
7257                     ; 1348 			DF_buffer_read(/*///current_buffer_L*//*1,*/128,128,&buff[128]);
7259  0ef6 ae00d0        	ldw	x,#_buff+128
7260  0ef9 89            	pushw	x
7261  0efa ae0080        	ldw	x,#128
7262  0efd 89            	pushw	x
7263  0efe ae0080        	ldw	x,#128
7264  0f01 cd0af3        	call	_DF_buffer_read
7266  0f04 5b04          	addw	sp,#4
7267  0f06               L5333:
7268                     ; 1350 		if(memory_manufacturer=='S') 
7270  0f06 b6bc          	ld	a,_memory_manufacturer
7271  0f08 a153          	cp	a,#83
7272  0f0a 2621          	jrne	L3333
7273                     ; 1352 			ST_READ((unsigned long)((unsigned long)(current_page*256UL)+128UL),128,&buff[128]);
7275  0f0c ae00d0        	ldw	x,#_buff+128
7276  0f0f 89            	pushw	x
7277  0f10 ae0080        	ldw	x,#128
7278  0f13 89            	pushw	x
7279  0f14 be11          	ldw	x,_current_page
7280  0f16 90ae0100      	ldw	y,#256
7281  0f1a cd0000        	call	c_umul
7283  0f1d a680          	ld	a,#128
7284  0f1f cd0000        	call	c_ladc
7286  0f22 be02          	ldw	x,c_lreg+2
7287  0f24 89            	pushw	x
7288  0f25 be00          	ldw	x,c_lreg
7289  0f27 89            	pushw	x
7290  0f28 cd09f1        	call	_ST_READ
7292  0f2b 5b08          	addw	sp,#8
7293  0f2d               L3333:
7294                     ; 1356 	if(bRXIN)
7296                     	btst	_bRXIN
7297  0f32 2407          	jruge	L1433
7298                     ; 1358 		bRXIN=0;
7300  0f34 72110002      	bres	_bRXIN
7301                     ; 1360 		uart_in();
7303  0f38 cd0ba1        	call	_uart_in
7305  0f3b               L1433:
7306                     ; 1364 	if(b100Hz)
7308                     	btst	_b100Hz
7309  0f40 2503          	jrult	L661
7310  0f42 cc1006        	jp	L3433
7311  0f45               L661:
7312                     ; 1366 		b100Hz=0;
7314  0f45 72110008      	bres	_b100Hz
7315                     ; 1368 		if(but_block_cnt)but_block_cnt--;
7317  0f49 be02          	ldw	x,_but_block_cnt
7318  0f4b 2707          	jreq	L5433
7321  0f4d be02          	ldw	x,_but_block_cnt
7322  0f4f 1d0001        	subw	x,#1
7323  0f52 bf02          	ldw	_but_block_cnt,x
7324  0f54               L5433:
7325                     ; 1370 		if(bSTART==1) 
7327                     	btst	_bSTART
7328  0f59 247c          	jruge	L7433
7329                     ; 1372 			if(play) 
7331                     	btst	_play
7332  0f60 2406          	jruge	L1533
7333                     ; 1382 				bSTART=0;
7335  0f62 7211000c      	bres	_bSTART
7337  0f66 206f          	jra	L7433
7338  0f68               L1533:
7339                     ; 1389 				current_page=1;
7341  0f68 ae0001        	ldw	x,#1
7342  0f6b bf11          	ldw	_current_page,x
7343                     ; 1394 				last_page=EE_PAGE_LEN-1;
7345  0f6d ce0000        	ldw	x,_EE_PAGE_LEN
7346  0f70 5a            	decw	x
7347  0f71 bf0f          	ldw	_last_page,x
7348                     ; 1396 				if(memory_manufacturer=='A')
7350  0f73 b6bc          	ld	a,_memory_manufacturer
7351  0f75 a141          	cp	a,#65
7352  0f77 2630          	jrne	L5533
7353                     ; 1398 					DF_page_to_buffer(/*///current_buffer_H*//*1,*/current_page);
7355  0f79 ae0001        	ldw	x,#1
7356  0f7c cd0aad        	call	_DF_page_to_buffer
7358                     ; 1399 					delay_ms(10);
7360  0f7f ae000a        	ldw	x,#10
7361  0f82 cd0060        	call	_delay_ms
7363                     ; 1400 					DF_buffer_read(/*///current_buffer_L*//*1,*/0,128,buff);
7365  0f85 ae0050        	ldw	x,#_buff
7366  0f88 89            	pushw	x
7367  0f89 ae0080        	ldw	x,#128
7368  0f8c 89            	pushw	x
7369  0f8d 5f            	clrw	x
7370  0f8e cd0af3        	call	_DF_buffer_read
7372  0f91 5b04          	addw	sp,#4
7373                     ; 1401 					delay_ms(10);
7375  0f93 ae000a        	ldw	x,#10
7376  0f96 cd0060        	call	_delay_ms
7378                     ; 1402 					DF_buffer_read(/*///current_buffer_L*//*1,*/128,128,&buff[128]);         
7380  0f99 ae00d0        	ldw	x,#_buff+128
7381  0f9c 89            	pushw	x
7382  0f9d ae0080        	ldw	x,#128
7383  0fa0 89            	pushw	x
7384  0fa1 ae0080        	ldw	x,#128
7385  0fa4 cd0af3        	call	_DF_buffer_read
7387  0fa7 5b04          	addw	sp,#4
7388  0fa9               L5533:
7389                     ; 1404 				if(memory_manufacturer=='S') 
7391  0fa9 b6bc          	ld	a,_memory_manufacturer
7392  0fab a153          	cp	a,#83
7393  0fad 2615          	jrne	L7533
7394                     ; 1406 					ST_READ(0,256,buff);
7396  0faf ae0050        	ldw	x,#_buff
7397  0fb2 89            	pushw	x
7398  0fb3 ae0100        	ldw	x,#256
7399  0fb6 89            	pushw	x
7400  0fb7 ae0000        	ldw	x,#0
7401  0fba 89            	pushw	x
7402  0fbb ae0000        	ldw	x,#0
7403  0fbe 89            	pushw	x
7404  0fbf cd09f1        	call	_ST_READ
7406  0fc2 5b08          	addw	sp,#8
7407  0fc4               L7533:
7408                     ; 1408 				play=1;
7410  0fc4 72100004      	bset	_play
7411                     ; 1409 				bSTART=0;
7413  0fc8 7211000c      	bres	_bSTART
7414                     ; 1411 				rele_cnt=rele_cnt_const[rele_cnt_index];
7416  0fcc b6bb          	ld	a,_rele_cnt_index
7417  0fce 5f            	clrw	x
7418  0fcf 97            	ld	xl,a
7419  0fd0 d60000        	ld	a,(_rele_cnt_const,x)
7420  0fd3 5f            	clrw	x
7421  0fd4 97            	ld	xl,a
7422  0fd5 bf05          	ldw	_rele_cnt,x
7423  0fd7               L7433:
7424                     ; 1417 		if(current_page_cnt)
7426  0fd7 3d01          	tnz	_current_page_cnt
7427  0fd9 272b          	jreq	L3433
7428                     ; 1419 			current_page_cnt--;
7430  0fdb 3a01          	dec	_current_page_cnt
7431                     ; 1420 			if(!current_page_cnt)
7433  0fdd 3d01          	tnz	_current_page_cnt
7434  0fdf 2625          	jrne	L3433
7435                     ; 1423 				CS_FLASH
7437  0fe1 c6500a        	ld	a,20490
7438  0fe4 a808          	xor	a,	#8
7439  0fe6 c7500a        	ld	20490,a
7440                     ; 1425 				uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
7442  0fe9 4b00          	push	#0
7443  0feb 4b00          	push	#0
7444  0fed 3b0011        	push	_current_page
7445  0ff0 b612          	ld	a,_current_page+1
7446  0ff2 a4ff          	and	a,#255
7447  0ff4 88            	push	a
7448  0ff5 4b15          	push	#21
7449  0ff7 ae0016        	ldw	x,#22
7450  0ffa a604          	ld	a,#4
7451  0ffc 95            	ld	xh,a
7452  0ffd cd00d2        	call	_uart_out
7454  1000 5b05          	addw	sp,#5
7455                     ; 1426 				current_page_cnt=100;
7457  1002 35640001      	mov	_current_page_cnt,#100
7458  1006               L3433:
7459                     ; 1431 	if(b10Hz)
7461                     	btst	_b10Hz
7462  100b 2413          	jruge	L5633
7463                     ; 1433 		b10Hz=0;
7465  100d 72110007      	bres	_b10Hz
7466                     ; 1435 		rele_drv();
7468  1011 cd004a        	call	_rele_drv
7470                     ; 1436 		pwm_fade_in++;
7472  1014 3cba          	inc	_pwm_fade_in
7473                     ; 1437 		if(pwm_fade_in>128)pwm_fade_in=128;			
7475  1016 b6ba          	ld	a,_pwm_fade_in
7476  1018 a181          	cp	a,#129
7477  101a 2504          	jrult	L5633
7480  101c 358000ba      	mov	_pwm_fade_in,#128
7481  1020               L5633:
7482                     ; 1440 	if(b5Hz)
7484                     	btst	_b5Hz
7485  1025 2404          	jruge	L1733
7486                     ; 1442 		b5Hz=0;
7488  1027 72110006      	bres	_b5Hz
7489  102b               L1733:
7490                     ; 1448 	if(b1Hz)
7492                     	btst	_b1Hz
7493  1030 2503          	jrult	L071
7494  1032 cc0e78        	jp	L1133
7495  1035               L071:
7496                     ; 1451 		b1Hz=0;
7498  1035 72110005      	bres	_b1Hz
7499  1039 ac780e78      	jpf	L1133
8013                     	xdef	_main
8014                     	switch	.ubsct
8015  0000               _current_page_cnt_:
8016  0000 00            	ds.b	1
8017                     	xdef	_current_page_cnt_
8018  0001               _current_page_cnt:
8019  0001 00            	ds.b	1
8020                     	xdef	_current_page_cnt
8021                     .eeprom:	section	.data
8022  0000               _EE_PAGE_LEN:
8023  0000 0000          	ds.b	2
8024                     	xdef	_EE_PAGE_LEN
8025                     	switch	.bss
8026  0000               _UIB:
8027  0000 000000000000  	ds.b	80
8028                     	xdef	_UIB
8029  0050               _buff:
8030  0050 000000000000  	ds.b	300
8031                     	xdef	_buff
8032  017c               _dumm:
8033  017c 000000000000  	ds.b	100
8034                     	xdef	_dumm
8035                     .bit:	section	.data,bit
8036  0000               _bRELEASE:
8037  0000 00            	ds.b	1
8038                     	xdef	_bRELEASE
8039  0001               _rx_buffer_overflow:
8040  0001 00            	ds.b	1
8041                     	xdef	_rx_buffer_overflow
8042  0002               _bRXIN:
8043  0002 00            	ds.b	1
8044                     	xdef	_bRXIN
8045  0003               _bOUT_FREE:
8046  0003 00            	ds.b	1
8047                     	xdef	_bOUT_FREE
8048  0004               _play:
8049  0004 00            	ds.b	1
8050                     	xdef	_play
8051  0005               _b1Hz:
8052  0005 00            	ds.b	1
8053                     	xdef	_b1Hz
8054  0006               _b5Hz:
8055  0006 00            	ds.b	1
8056                     	xdef	_b5Hz
8057  0007               _b10Hz:
8058  0007 00            	ds.b	1
8059                     	xdef	_b10Hz
8060  0008               _b100Hz:
8061  0008 00            	ds.b	1
8062                     	xdef	_b100Hz
8063  0009               _bBUFF_READ_L:
8064  0009 00            	ds.b	1
8065                     	xdef	_bBUFF_READ_L
8066  000a               _bBUFF_READ_H:
8067  000a 00            	ds.b	1
8068                     	xdef	_bBUFF_READ_H
8069  000b               _bBUFF_LOAD:
8070  000b 00            	ds.b	1
8071                     	xdef	_bBUFF_LOAD
8072  000c               _bSTART:
8073  000c 00            	ds.b	1
8074                     	xdef	_bSTART
8075                     	switch	.ubsct
8076  0002               _but_block_cnt:
8077  0002 0000          	ds.b	2
8078                     	xdef	_but_block_cnt
8079                     	xdef	_memory_manufacturer
8080                     	xdef	_rele_cnt_const
8081                     	xdef	_rele_cnt_index
8082                     	xdef	_pwm_fade_in
8083  0004               _rx_offset:
8084  0004 00            	ds.b	1
8085                     	xdef	_rx_offset
8086  0005               _rele_cnt:
8087  0005 0000          	ds.b	2
8088                     	xdef	_rele_cnt
8089  0007               _rx_data:
8090  0007 00            	ds.b	1
8091                     	xdef	_rx_data
8092  0008               _rx_status:
8093  0008 00            	ds.b	1
8094                     	xdef	_rx_status
8095  0009               _file_lengt:
8096  0009 00000000      	ds.b	4
8097                     	xdef	_file_lengt
8098  000d               _current_byte_in_buffer:
8099  000d 0000          	ds.b	2
8100                     	xdef	_current_byte_in_buffer
8101  000f               _last_page:
8102  000f 0000          	ds.b	2
8103                     	xdef	_last_page
8104  0011               _current_page:
8105  0011 0000          	ds.b	2
8106                     	xdef	_current_page
8107  0013               _file_lengt_in_pages:
8108  0013 0000          	ds.b	2
8109                     	xdef	_file_lengt_in_pages
8110  0015               _mdr3:
8111  0015 00            	ds.b	1
8112                     	xdef	_mdr3
8113  0016               _mdr2:
8114  0016 00            	ds.b	1
8115                     	xdef	_mdr2
8116  0017               _mdr1:
8117  0017 00            	ds.b	1
8118                     	xdef	_mdr1
8119  0018               _mdr0:
8120  0018 00            	ds.b	1
8121                     	xdef	_mdr0
8122                     	xdef	_but_on_drv_cnt
8123                     	xdef	_but_drv_cnt
8124  0019               _sample:
8125  0019 00            	ds.b	1
8126                     	xdef	_sample
8127  001a               _rx_rd_index:
8128  001a 0000          	ds.b	2
8129                     	xdef	_rx_rd_index
8130  001c               _rx_wr_index:
8131  001c 0000          	ds.b	2
8132                     	xdef	_rx_wr_index
8133  001e               _rx_counter:
8134  001e 0000          	ds.b	2
8135                     	xdef	_rx_counter
8136                     	xdef	_rx_buffer
8137  0020               _tx_rd_index:
8138  0020 00            	ds.b	1
8139                     	xdef	_tx_rd_index
8140  0021               _tx_wr_index:
8141  0021 00            	ds.b	1
8142                     	xdef	_tx_wr_index
8143  0022               _tx_counter:
8144  0022 00            	ds.b	1
8145                     	xdef	_tx_counter
8146                     	xdef	_tx_buffer
8147  0023               _sample_cnt:
8148  0023 0000          	ds.b	2
8149                     	xdef	_sample_cnt
8150                     	xdef	_t0_cnt3
8151                     	xdef	_t0_cnt2
8152                     	xdef	_t0_cnt1
8153                     	xdef	_t0_cnt0
8154                     	xdef	_ST_bulk_erase
8155                     	xdef	_ST_READ
8156                     	xdef	_ST_WRITE
8157                     	xdef	_ST_WREN
8158                     	xdef	_ST_status_read
8159                     	xdef	_ST_RDID_read
8160                     	xdef	_uart_in_an
8161                     	xdef	_control_check
8162                     	xdef	_index_offset
8163                     	xdef	_uart_in
8164                     	xdef	_gpio_init
8165                     	xdef	_spi_init
8166                     	xdef	_spi
8167                     	xdef	_DF_buffer_to_page_er
8168                     	xdef	_DF_page_to_buffer
8169                     	xdef	_DF_buffer_write
8170                     	xdef	_DF_buffer_read
8171                     	xdef	_DF_status_read
8172                     	xdef	_DF_memo_to_256
8173                     	xdef	_DF_mf_dev_read
8174                     	xdef	_uart_init
8175                     	xdef	f_UARTRxInterrupt
8176                     	xdef	f_UARTTxInterrupt
8177                     	xdef	_putchar
8178                     	xdef	_uart_out_adr_block
8179                     	xdef	_uart_out
8180                     	xdef	f_TIM4_UPD_Interrupt
8181                     	xdef	_delay_ms
8182                     	xdef	_rele_drv
8183                     	xdef	_t4_init
8184                     	xdef	_t2_init
8185                     	xref.b	c_lreg
8186                     	xref.b	c_x
8187                     	xref.b	c_y
8207                     	xref	c_ladc
8208                     	xref	c_itolx
8209                     	xref	c_umul
8210                     	xref	c_eewrw
8211                     	xref	c_lglsh
8212                     	xref	c_uitolx
8213                     	xref	c_lgursh
8214                     	xref	c_lcmp
8215                     	xref	c_ltor
8216                     	xref	c_lgadc
8217                     	xref	c_rtol
8218                     	xref	c_vmul
8219                     	end
