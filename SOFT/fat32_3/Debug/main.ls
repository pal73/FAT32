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
2199  0001 32            	dc.b	50
2200  0002 64            	dc.b	100
2229                     ; 54 void t2_init(void){
2231                     	switch	.text
2232  0000               _t2_init:
2236                     ; 55 	TIM2->PSCR = 0;
2238  0000 725f530e      	clr	21262
2239                     ; 56 	TIM2->ARRH= 0x00;
2241  0004 725f530f      	clr	21263
2242                     ; 57 	TIM2->ARRL= 0xff;
2244  0008 35ff5310      	mov	21264,#255
2245                     ; 58 	TIM2->CCR1H= 0x00;	
2247  000c 725f5311      	clr	21265
2248                     ; 59 	TIM2->CCR1L= 200;
2250  0010 35c85312      	mov	21266,#200
2251                     ; 60 	TIM2->CCR2H= 0x00;	
2253  0014 725f5313      	clr	21267
2254                     ; 61 	TIM2->CCR2L= 200;
2256  0018 35c85314      	mov	21268,#200
2257                     ; 62 	TIM2->CCR3H= 0x00;	
2259  001c 725f5315      	clr	21269
2260                     ; 63 	TIM2->CCR3L= 200;
2262  0020 35c85316      	mov	21270,#200
2263                     ; 66 	TIM2->CCMR2= ((6<<4) & TIM2_CCMR_OCM) | TIM2_CCMR_OCxPE; //OC2 toggle mode, prelouded
2265  0024 35685308      	mov	21256,#104
2266                     ; 67 	TIM2->CCMR3= ((6<<4) & TIM2_CCMR_OCM) | TIM2_CCMR_OCxPE; //OC2 toggle mode, prelouded
2268  0028 35685309      	mov	21257,#104
2269                     ; 68 	TIM2->CCER1= /*TIM2_CCER1_CC1E | TIM2_CCER1_CC1P |*/ TIM2_CCER1_CC2E | TIM2_CCER1_CC2P; //OC1, OC2 output pins enabled
2271  002c 3530530a      	mov	21258,#48
2272                     ; 70 	TIM2->CCER2= TIM2_CCER2_CC3E /*| TIM2_CCER2_CC3P*/; //OC1, OC2 output pins enabled
2274  0030 3501530b      	mov	21259,#1
2275                     ; 72 	TIM2->CR1=(TIM2_CR1_CEN | TIM2_CR1_ARPE);	
2277  0034 35815300      	mov	21248,#129
2278                     ; 74 }
2281  0038 81            	ret
2304                     ; 77 void t4_init(void){
2305                     	switch	.text
2306  0039               _t4_init:
2310                     ; 78 	TIM4->PSCR = 3;
2312  0039 35035347      	mov	21319,#3
2313                     ; 79 	TIM4->ARR= 158;
2315  003d 359e5348      	mov	21320,#158
2316                     ; 80 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
2318  0041 72105343      	bset	21315,#0
2319                     ; 82 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
2321  0045 35855340      	mov	21312,#133
2322                     ; 84 }
2325  0049 81            	ret
2349                     ; 87 void rele_drv(void) {
2350                     	switch	.text
2351  004a               _rele_drv:
2355                     ; 89 	if(rele_cnt) {
2357  004a be01          	ldw	x,_rele_cnt
2358  004c 270d          	jreq	L1641
2359                     ; 90 		rele_cnt--;
2361  004e be01          	ldw	x,_rele_cnt
2362  0050 1d0001        	subw	x,#1
2363  0053 bf01          	ldw	_rele_cnt,x
2364                     ; 91 		GPIOD->ODR|=(1<<4);
2366  0055 7218500f      	bset	20495,#4
2368  0059 2004          	jra	L3641
2369  005b               L1641:
2370                     ; 93 	else GPIOD->ODR&=~(1<<4); 
2372  005b 7219500f      	bres	20495,#4
2373  005f               L3641:
2374                     ; 100 }
2377  005f 81            	ret
2438                     ; 103 long delay_ms(short in)
2438                     ; 104 {
2439                     	switch	.text
2440  0060               _delay_ms:
2442  0060 520c          	subw	sp,#12
2443       0000000c      OFST:	set	12
2446                     ; 107 i=((long)in)*100UL;
2448  0062 90ae0064      	ldw	y,#100
2449  0066 cd0000        	call	c_vmul
2451  0069 96            	ldw	x,sp
2452  006a 1c0005        	addw	x,#OFST-7
2453  006d cd0000        	call	c_rtol
2455                     ; 109 for(ii=0;ii<i;ii++)
2457  0070 ae0000        	ldw	x,#0
2458  0073 1f0b          	ldw	(OFST-1,sp),x
2459  0075 ae0000        	ldw	x,#0
2460  0078 1f09          	ldw	(OFST-3,sp),x
2462  007a 2012          	jra	L3251
2463  007c               L7151:
2464                     ; 111 		iii++;
2466  007c 96            	ldw	x,sp
2467  007d 1c0001        	addw	x,#OFST-11
2468  0080 a601          	ld	a,#1
2469  0082 cd0000        	call	c_lgadc
2471                     ; 109 for(ii=0;ii<i;ii++)
2473  0085 96            	ldw	x,sp
2474  0086 1c0009        	addw	x,#OFST-3
2475  0089 a601          	ld	a,#1
2476  008b cd0000        	call	c_lgadc
2478  008e               L3251:
2481  008e 9c            	rvf
2482  008f 96            	ldw	x,sp
2483  0090 1c0009        	addw	x,#OFST-3
2484  0093 cd0000        	call	c_ltor
2486  0096 96            	ldw	x,sp
2487  0097 1c0005        	addw	x,#OFST-7
2488  009a cd0000        	call	c_lcmp
2490  009d 2fdd          	jrslt	L7151
2491                     ; 114 }
2494  009f 5b0c          	addw	sp,#12
2495  00a1 81            	ret
2518                     ; 117 void uart_init (void){
2519                     	switch	.text
2520  00a2               _uart_init:
2524                     ; 118 	GPIOD->DDR|=(1<<5);
2526  00a2 721a5011      	bset	20497,#5
2527                     ; 119 	GPIOD->CR1|=(1<<5);
2529  00a6 721a5012      	bset	20498,#5
2530                     ; 120 	GPIOD->CR2|=(1<<5);
2532  00aa 721a5013      	bset	20499,#5
2533                     ; 123 	GPIOD->DDR&=~(1<<6);
2535  00ae 721d5011      	bres	20497,#6
2536                     ; 124 	GPIOD->CR1&=~(1<<6);
2538  00b2 721d5012      	bres	20498,#6
2539                     ; 125 	GPIOD->CR2&=~(1<<6);
2541  00b6 721d5013      	bres	20499,#6
2542                     ; 128 	UART1->CR1&=~UART1_CR1_M;					
2544  00ba 72195234      	bres	21044,#4
2545                     ; 129 	UART1->CR3|= (0<<4) & UART1_CR3_STOP;	
2547  00be c65236        	ld	a,21046
2548                     ; 130 	UART1->BRR2= 0x01;//0x03;
2550  00c1 35015233      	mov	21043,#1
2551                     ; 131 	UART1->BRR1= 0x1a;//0x68;
2553  00c5 351a5232      	mov	21042,#26
2554                     ; 132 	UART1->CR2|= UART1_CR2_TEN | UART3_CR2_REN | UART3_CR2_RIEN;	
2556  00c9 c65235        	ld	a,21045
2557  00cc aa2c          	or	a,#44
2558  00ce c75235        	ld	21045,a
2559                     ; 133 }
2562  00d1 81            	ret
2680                     ; 136 void uart_out (char num,char data0,char data1,char data2,char data3,char data4,char data5){
2681                     	switch	.text
2682  00d2               _uart_out:
2684  00d2 89            	pushw	x
2685  00d3 520c          	subw	sp,#12
2686       0000000c      OFST:	set	12
2689                     ; 137 	char i=0,t=0,UOB[10];
2693  00d5 0f01          	clr	(OFST-11,sp)
2694                     ; 140 	UOB[0]=data0;
2696  00d7 9f            	ld	a,xl
2697  00d8 6b02          	ld	(OFST-10,sp),a
2698                     ; 141 	UOB[1]=data1;
2700  00da 7b11          	ld	a,(OFST+5,sp)
2701  00dc 6b03          	ld	(OFST-9,sp),a
2702                     ; 142 	UOB[2]=data2;
2704  00de 7b12          	ld	a,(OFST+6,sp)
2705  00e0 6b04          	ld	(OFST-8,sp),a
2706                     ; 143 	UOB[3]=data3;
2708  00e2 7b13          	ld	a,(OFST+7,sp)
2709  00e4 6b05          	ld	(OFST-7,sp),a
2710                     ; 144 	UOB[4]=data4;
2712  00e6 7b14          	ld	a,(OFST+8,sp)
2713  00e8 6b06          	ld	(OFST-6,sp),a
2714                     ; 145 	UOB[5]=data5;
2716  00ea 7b15          	ld	a,(OFST+9,sp)
2717  00ec 6b07          	ld	(OFST-5,sp),a
2718                     ; 146 	for (i=0;i<num;i++)
2720  00ee 0f0c          	clr	(OFST+0,sp)
2722  00f0 2013          	jra	L5261
2723  00f2               L1261:
2724                     ; 148 		t^=UOB[i];
2726  00f2 96            	ldw	x,sp
2727  00f3 1c0002        	addw	x,#OFST-10
2728  00f6 9f            	ld	a,xl
2729  00f7 5e            	swapw	x
2730  00f8 1b0c          	add	a,(OFST+0,sp)
2731  00fa 2401          	jrnc	L02
2732  00fc 5c            	incw	x
2733  00fd               L02:
2734  00fd 02            	rlwa	x,a
2735  00fe 7b01          	ld	a,(OFST-11,sp)
2736  0100 f8            	xor	a,	(x)
2737  0101 6b01          	ld	(OFST-11,sp),a
2738                     ; 146 	for (i=0;i<num;i++)
2740  0103 0c0c          	inc	(OFST+0,sp)
2741  0105               L5261:
2744  0105 7b0c          	ld	a,(OFST+0,sp)
2745  0107 110d          	cp	a,(OFST+1,sp)
2746  0109 25e7          	jrult	L1261
2747                     ; 150 	UOB[num]=num;
2749  010b 96            	ldw	x,sp
2750  010c 1c0002        	addw	x,#OFST-10
2751  010f 9f            	ld	a,xl
2752  0110 5e            	swapw	x
2753  0111 1b0d          	add	a,(OFST+1,sp)
2754  0113 2401          	jrnc	L22
2755  0115 5c            	incw	x
2756  0116               L22:
2757  0116 02            	rlwa	x,a
2758  0117 7b0d          	ld	a,(OFST+1,sp)
2759  0119 f7            	ld	(x),a
2760                     ; 151 	t^=UOB[num];
2762  011a 96            	ldw	x,sp
2763  011b 1c0002        	addw	x,#OFST-10
2764  011e 9f            	ld	a,xl
2765  011f 5e            	swapw	x
2766  0120 1b0d          	add	a,(OFST+1,sp)
2767  0122 2401          	jrnc	L42
2768  0124 5c            	incw	x
2769  0125               L42:
2770  0125 02            	rlwa	x,a
2771  0126 7b01          	ld	a,(OFST-11,sp)
2772  0128 f8            	xor	a,	(x)
2773  0129 6b01          	ld	(OFST-11,sp),a
2774                     ; 152 	UOB[num+1]=t;
2776  012b 96            	ldw	x,sp
2777  012c 1c0003        	addw	x,#OFST-9
2778  012f 9f            	ld	a,xl
2779  0130 5e            	swapw	x
2780  0131 1b0d          	add	a,(OFST+1,sp)
2781  0133 2401          	jrnc	L62
2782  0135 5c            	incw	x
2783  0136               L62:
2784  0136 02            	rlwa	x,a
2785  0137 7b01          	ld	a,(OFST-11,sp)
2786  0139 f7            	ld	(x),a
2787                     ; 153 	UOB[num+2]=END;
2789  013a 96            	ldw	x,sp
2790  013b 1c0004        	addw	x,#OFST-8
2791  013e 9f            	ld	a,xl
2792  013f 5e            	swapw	x
2793  0140 1b0d          	add	a,(OFST+1,sp)
2794  0142 2401          	jrnc	L03
2795  0144 5c            	incw	x
2796  0145               L03:
2797  0145 02            	rlwa	x,a
2798  0146 a60a          	ld	a,#10
2799  0148 f7            	ld	(x),a
2800                     ; 157 	for (i=0;i<num+3;i++)
2802  0149 0f0c          	clr	(OFST+0,sp)
2804  014b 2012          	jra	L5361
2805  014d               L1361:
2806                     ; 159 		putchar(UOB[i]);
2808  014d 96            	ldw	x,sp
2809  014e 1c0002        	addw	x,#OFST-10
2810  0151 9f            	ld	a,xl
2811  0152 5e            	swapw	x
2812  0153 1b0c          	add	a,(OFST+0,sp)
2813  0155 2401          	jrnc	L23
2814  0157 5c            	incw	x
2815  0158               L23:
2816  0158 02            	rlwa	x,a
2817  0159 f6            	ld	a,(x)
2818  015a cd068b        	call	_putchar
2820                     ; 157 	for (i=0;i<num+3;i++)
2822  015d 0c0c          	inc	(OFST+0,sp)
2823  015f               L5361:
2826  015f 9c            	rvf
2827  0160 7b0c          	ld	a,(OFST+0,sp)
2828  0162 5f            	clrw	x
2829  0163 97            	ld	xl,a
2830  0164 7b0d          	ld	a,(OFST+1,sp)
2831  0166 905f          	clrw	y
2832  0168 9097          	ld	yl,a
2833  016a 72a90003      	addw	y,#3
2834  016e bf00          	ldw	c_x,x
2835  0170 90b300        	cpw	y,c_x
2836  0173 2cd8          	jrsgt	L1361
2837                     ; 162 	bOUT_FREE=0;	  	
2839  0175 72110002      	bres	_bOUT_FREE
2840                     ; 163 }
2843  0179 5b0e          	addw	sp,#14
2844  017b 81            	ret
2926                     ; 166 void uart_out_adr_block (unsigned long adress,char *ptr, char len)
2926                     ; 167 {
2927                     	switch	.text
2928  017c               _uart_out_adr_block:
2930  017c 5203          	subw	sp,#3
2931       00000003      OFST:	set	3
2934                     ; 171 t=0;
2936  017e 0f02          	clr	(OFST-1,sp)
2937                     ; 172 temp11=CMND;
2939                     ; 173 t^=temp11;
2941  0180 7b02          	ld	a,(OFST-1,sp)
2942  0182 a816          	xor	a,	#22
2943  0184 6b02          	ld	(OFST-1,sp),a
2944                     ; 174 putchar(temp11);
2946  0186 a616          	ld	a,#22
2947  0188 cd068b        	call	_putchar
2949                     ; 176 temp11=10;
2951                     ; 177 t^=temp11;
2953  018b 7b02          	ld	a,(OFST-1,sp)
2954  018d a80a          	xor	a,	#10
2955  018f 6b02          	ld	(OFST-1,sp),a
2956                     ; 178 putchar(temp11);
2958  0191 a60a          	ld	a,#10
2959  0193 cd068b        	call	_putchar
2961                     ; 180 temp11=adress%256;//(*((char*)&adress));
2963  0196 7b09          	ld	a,(OFST+6,sp)
2964  0198 a4ff          	and	a,#255
2965  019a 6b03          	ld	(OFST+0,sp),a
2966                     ; 181 t^=temp11;
2968  019c 7b02          	ld	a,(OFST-1,sp)
2969  019e 1803          	xor	a,	(OFST+0,sp)
2970  01a0 6b02          	ld	(OFST-1,sp),a
2971                     ; 182 putchar(temp11);
2973  01a2 7b03          	ld	a,(OFST+0,sp)
2974  01a4 cd068b        	call	_putchar
2976                     ; 183 adress>>=8;
2978  01a7 96            	ldw	x,sp
2979  01a8 1c0006        	addw	x,#OFST+3
2980  01ab a608          	ld	a,#8
2981  01ad cd0000        	call	c_lgursh
2983                     ; 184 temp11=adress%256;//(*(((char*)&adress)+1));
2985  01b0 7b09          	ld	a,(OFST+6,sp)
2986  01b2 a4ff          	and	a,#255
2987  01b4 6b03          	ld	(OFST+0,sp),a
2988                     ; 185 t^=temp11;
2990  01b6 7b02          	ld	a,(OFST-1,sp)
2991  01b8 1803          	xor	a,	(OFST+0,sp)
2992  01ba 6b02          	ld	(OFST-1,sp),a
2993                     ; 186 putchar(temp11);
2995  01bc 7b03          	ld	a,(OFST+0,sp)
2996  01be cd068b        	call	_putchar
2998                     ; 187 adress>>=8;
3000  01c1 96            	ldw	x,sp
3001  01c2 1c0006        	addw	x,#OFST+3
3002  01c5 a608          	ld	a,#8
3003  01c7 cd0000        	call	c_lgursh
3005                     ; 188 temp11=adress%256;//(*(((char*)&adress)+2));
3007  01ca 7b09          	ld	a,(OFST+6,sp)
3008  01cc a4ff          	and	a,#255
3009  01ce 6b03          	ld	(OFST+0,sp),a
3010                     ; 189 t^=temp11;
3012  01d0 7b02          	ld	a,(OFST-1,sp)
3013  01d2 1803          	xor	a,	(OFST+0,sp)
3014  01d4 6b02          	ld	(OFST-1,sp),a
3015                     ; 190 putchar(temp11);
3017  01d6 7b03          	ld	a,(OFST+0,sp)
3018  01d8 cd068b        	call	_putchar
3020                     ; 191 adress>>=8;
3022  01db 96            	ldw	x,sp
3023  01dc 1c0006        	addw	x,#OFST+3
3024  01df a608          	ld	a,#8
3025  01e1 cd0000        	call	c_lgursh
3027                     ; 192 temp11=adress%256;//(*(((char*)&adress)+3));
3029  01e4 7b09          	ld	a,(OFST+6,sp)
3030  01e6 a4ff          	and	a,#255
3031  01e8 6b03          	ld	(OFST+0,sp),a
3032                     ; 193 t^=temp11;
3034  01ea 7b02          	ld	a,(OFST-1,sp)
3035  01ec 1803          	xor	a,	(OFST+0,sp)
3036  01ee 6b02          	ld	(OFST-1,sp),a
3037                     ; 194 putchar(temp11);
3039  01f0 7b03          	ld	a,(OFST+0,sp)
3040  01f2 cd068b        	call	_putchar
3042                     ; 197 for(i11=0;i11<len;i11++)
3044  01f5 0f01          	clr	(OFST-2,sp)
3046  01f7 201b          	jra	L7071
3047  01f9               L3071:
3048                     ; 199 	temp11=ptr[i11];
3050  01f9 7b0a          	ld	a,(OFST+7,sp)
3051  01fb 97            	ld	xl,a
3052  01fc 7b0b          	ld	a,(OFST+8,sp)
3053  01fe 1b01          	add	a,(OFST-2,sp)
3054  0200 2401          	jrnc	L63
3055  0202 5c            	incw	x
3056  0203               L63:
3057  0203 02            	rlwa	x,a
3058  0204 f6            	ld	a,(x)
3059  0205 6b03          	ld	(OFST+0,sp),a
3060                     ; 200 	t^=temp11;
3062  0207 7b02          	ld	a,(OFST-1,sp)
3063  0209 1803          	xor	a,	(OFST+0,sp)
3064  020b 6b02          	ld	(OFST-1,sp),a
3065                     ; 201 	putchar(temp11);
3067  020d 7b03          	ld	a,(OFST+0,sp)
3068  020f cd068b        	call	_putchar
3070                     ; 197 for(i11=0;i11<len;i11++)
3072  0212 0c01          	inc	(OFST-2,sp)
3073  0214               L7071:
3076  0214 7b01          	ld	a,(OFST-2,sp)
3077  0216 110c          	cp	a,(OFST+9,sp)
3078  0218 25df          	jrult	L3071
3079                     ; 204 temp11=(len+6);
3081  021a 7b0c          	ld	a,(OFST+9,sp)
3082  021c ab06          	add	a,#6
3083  021e 6b03          	ld	(OFST+0,sp),a
3084                     ; 205 t^=temp11;
3086  0220 7b02          	ld	a,(OFST-1,sp)
3087  0222 1803          	xor	a,	(OFST+0,sp)
3088  0224 6b02          	ld	(OFST-1,sp),a
3089                     ; 206 putchar(temp11);
3091  0226 7b03          	ld	a,(OFST+0,sp)
3092  0228 cd068b        	call	_putchar
3094                     ; 208 putchar(t);
3096  022b 7b02          	ld	a,(OFST-1,sp)
3097  022d cd068b        	call	_putchar
3099                     ; 210 putchar(0x0a);
3101  0230 a60a          	ld	a,#10
3102  0232 cd068b        	call	_putchar
3104                     ; 212 bOUT_FREE=0;	   
3106  0235 72110002      	bres	_bOUT_FREE
3107                     ; 213 }
3110  0239 5b03          	addw	sp,#3
3111  023b 81            	ret
3230                     ; 215 void uart_in_an(void) {
3231                     	switch	.text
3232  023c               _uart_in_an:
3234  023c 5204          	subw	sp,#4
3235       00000004      OFST:	set	4
3238                     ; 218 	if(UIB[0]==CMND) {
3240  023e c60000        	ld	a,_UIB
3241  0241 a116          	cp	a,#22
3242  0243 2703          	jreq	L24
3243  0245 cc0688        	jp	L5671
3244  0248               L24:
3245                     ; 219 		if(UIB[1]==1) {
3247  0248 c60001        	ld	a,_UIB+1
3248  024b a101          	cp	a,#1
3249  024d 2620          	jrne	L7671
3250                     ; 224 			temp_L=DF_mf_dev_read();
3252  024f cd0827        	call	_DF_mf_dev_read
3254                     ; 229 			uart_out (6,CMND,1,mdr0/**((char*)&temp_L)*/,mdr1/**(((char*)&temp_L)+1)*/,mdr2/**(((char*)&temp_L)+2)*/,mdr3/**(((char*)&temp_L)+3)*/);
3256  0252 3b0011        	push	_mdr3
3257  0255 3b0012        	push	_mdr2
3258  0258 3b0013        	push	_mdr1
3259  025b 3b0014        	push	_mdr0
3260  025e 4b01          	push	#1
3261  0260 ae0016        	ldw	x,#22
3262  0263 a606          	ld	a,#6
3263  0265 95            	ld	xh,a
3264  0266 cd00d2        	call	_uart_out
3266  0269 5b05          	addw	sp,#5
3268  026b ac880688      	jpf	L5671
3269  026f               L7671:
3270                     ; 236 	else if(UIB[1]==2) {
3272  026f c60001        	ld	a,_UIB+1
3273  0272 a102          	cp	a,#2
3274  0274 261f          	jrne	L3771
3275                     ; 240 		temp=DF_status_read();
3277  0276 cd087b        	call	_DF_status_read
3279  0279 6b04          	ld	(OFST+0,sp),a
3280                     ; 245 		uart_out (3,CMND,2,temp,0,0,0);    
3282  027b 4b00          	push	#0
3283  027d 4b00          	push	#0
3284  027f 4b00          	push	#0
3285  0281 7b07          	ld	a,(OFST+3,sp)
3286  0283 88            	push	a
3287  0284 4b02          	push	#2
3288  0286 ae0016        	ldw	x,#22
3289  0289 a603          	ld	a,#3
3290  028b 95            	ld	xh,a
3291  028c cd00d2        	call	_uart_out
3293  028f 5b05          	addw	sp,#5
3295  0291 ac880688      	jpf	L5671
3296  0295               L3771:
3297                     ; 249 	else if(UIB[1]==3)
3299  0295 c60001        	ld	a,_UIB+1
3300  0298 a103          	cp	a,#3
3301  029a 261d          	jrne	L7771
3302                     ; 253 		DF_memo_to_256();
3304  029c cd085e        	call	_DF_memo_to_256
3306                     ; 255 		uart_out (2,CMND,3,temp,0,0,0);    
3308  029f 4b00          	push	#0
3309  02a1 4b00          	push	#0
3310  02a3 4b00          	push	#0
3311  02a5 7b07          	ld	a,(OFST+3,sp)
3312  02a7 88            	push	a
3313  02a8 4b03          	push	#3
3314  02aa ae0016        	ldw	x,#22
3315  02ad a602          	ld	a,#2
3316  02af 95            	ld	xh,a
3317  02b0 cd00d2        	call	_uart_out
3319  02b3 5b05          	addw	sp,#5
3321  02b5 ac880688      	jpf	L5671
3322  02b9               L7771:
3323                     ; 258 	else if(UIB[1]==4)
3325  02b9 c60001        	ld	a,_UIB+1
3326  02bc a104          	cp	a,#4
3327  02be 261d          	jrne	L3002
3328                     ; 262 		DF_memo_to_256();
3330  02c0 cd085e        	call	_DF_memo_to_256
3332                     ; 264 		uart_out (2,CMND,3,temp,0,0,0);    
3334  02c3 4b00          	push	#0
3335  02c5 4b00          	push	#0
3336  02c7 4b00          	push	#0
3337  02c9 7b07          	ld	a,(OFST+3,sp)
3338  02cb 88            	push	a
3339  02cc 4b03          	push	#3
3340  02ce ae0016        	ldw	x,#22
3341  02d1 a602          	ld	a,#2
3342  02d3 95            	ld	xh,a
3343  02d4 cd00d2        	call	_uart_out
3345  02d7 5b05          	addw	sp,#5
3347  02d9 ac880688      	jpf	L5671
3348  02dd               L3002:
3349                     ; 267 	else if(UIB[1]==10)
3351  02dd c60001        	ld	a,_UIB+1
3352  02e0 a10a          	cp	a,#10
3353  02e2 2703cc0364    	jrne	L7002
3354                     ; 272 		if(UIB[2]==1)DF_buffer_read(/*1,*/0,256, buff);
3356  02e7 c60002        	ld	a,_UIB+2
3357  02ea a101          	cp	a,#1
3358  02ec 260e          	jrne	L1102
3361  02ee ae0050        	ldw	x,#_buff
3362  02f1 89            	pushw	x
3363  02f2 ae0100        	ldw	x,#256
3364  02f5 89            	pushw	x
3365  02f6 5f            	clrw	x
3366  02f7 cd08db        	call	_DF_buffer_read
3368  02fa 5b04          	addw	sp,#4
3369  02fc               L1102:
3370                     ; 277 		uart_out_adr_block (0,buff,64);
3372  02fc 4b40          	push	#64
3373  02fe ae0050        	ldw	x,#_buff
3374  0301 89            	pushw	x
3375  0302 ae0000        	ldw	x,#0
3376  0305 89            	pushw	x
3377  0306 ae0000        	ldw	x,#0
3378  0309 89            	pushw	x
3379  030a cd017c        	call	_uart_out_adr_block
3381  030d 5b07          	addw	sp,#7
3382                     ; 278 		delay_ms(100);    
3384  030f ae0064        	ldw	x,#100
3385  0312 cd0060        	call	_delay_ms
3387                     ; 279 		uart_out_adr_block (64,&buff[64],64);
3389  0315 4b40          	push	#64
3390  0317 ae0090        	ldw	x,#_buff+64
3391  031a 89            	pushw	x
3392  031b ae0040        	ldw	x,#64
3393  031e 89            	pushw	x
3394  031f ae0000        	ldw	x,#0
3395  0322 89            	pushw	x
3396  0323 cd017c        	call	_uart_out_adr_block
3398  0326 5b07          	addw	sp,#7
3399                     ; 280 		delay_ms(100);    
3401  0328 ae0064        	ldw	x,#100
3402  032b cd0060        	call	_delay_ms
3404                     ; 281 		uart_out_adr_block (128,&buff[128],64);
3406  032e 4b40          	push	#64
3407  0330 ae00d0        	ldw	x,#_buff+128
3408  0333 89            	pushw	x
3409  0334 ae0080        	ldw	x,#128
3410  0337 89            	pushw	x
3411  0338 ae0000        	ldw	x,#0
3412  033b 89            	pushw	x
3413  033c cd017c        	call	_uart_out_adr_block
3415  033f 5b07          	addw	sp,#7
3416                     ; 282 		delay_ms(100);    
3418  0341 ae0064        	ldw	x,#100
3419  0344 cd0060        	call	_delay_ms
3421                     ; 283 		uart_out_adr_block (192,&buff[192],64);
3423  0347 4b40          	push	#64
3424  0349 ae0110        	ldw	x,#_buff+192
3425  034c 89            	pushw	x
3426  034d ae00c0        	ldw	x,#192
3427  0350 89            	pushw	x
3428  0351 ae0000        	ldw	x,#0
3429  0354 89            	pushw	x
3430  0355 cd017c        	call	_uart_out_adr_block
3432  0358 5b07          	addw	sp,#7
3433                     ; 284 		delay_ms(100);    
3435  035a ae0064        	ldw	x,#100
3436  035d cd0060        	call	_delay_ms
3439  0360 ac880688      	jpf	L5671
3440  0364               L7002:
3441                     ; 287 	else if(UIB[1]==11)
3443  0364 c60001        	ld	a,_UIB+1
3444  0367 a10b          	cp	a,#11
3445  0369 2633          	jrne	L5102
3446                     ; 293 		for(i=0;i<256;i++)buff[i]=0;
3448  036b 5f            	clrw	x
3449  036c 1f03          	ldw	(OFST-1,sp),x
3450  036e               L7102:
3453  036e 1e03          	ldw	x,(OFST-1,sp)
3454  0370 724f0050      	clr	(_buff,x)
3457  0374 1e03          	ldw	x,(OFST-1,sp)
3458  0376 1c0001        	addw	x,#1
3459  0379 1f03          	ldw	(OFST-1,sp),x
3462  037b 1e03          	ldw	x,(OFST-1,sp)
3463  037d a30100        	cpw	x,#256
3464  0380 25ec          	jrult	L7102
3465                     ; 295 		if(UIB[2]==1)DF_buffer_write(/*1,*/0,256, buff);
3467  0382 c60002        	ld	a,_UIB+2
3468  0385 a101          	cp	a,#1
3469  0387 2703          	jreq	L44
3470  0389 cc0688        	jp	L5671
3471  038c               L44:
3474  038c ae0050        	ldw	x,#_buff
3475  038f 89            	pushw	x
3476  0390 ae0100        	ldw	x,#256
3477  0393 89            	pushw	x
3478  0394 5f            	clrw	x
3479  0395 cd0921        	call	_DF_buffer_write
3481  0398 5b04          	addw	sp,#4
3482  039a ac880688      	jpf	L5671
3483  039e               L5102:
3484                     ; 299 	else if(UIB[1]==12)
3486  039e c60001        	ld	a,_UIB+1
3487  03a1 a10c          	cp	a,#12
3488  03a3 2703          	jreq	L64
3489  03a5 cc0484        	jp	L1302
3490  03a8               L64:
3491                     ; 305 		for(i=0;i<256;i++)buff[i]=0;
3493  03a8 5f            	clrw	x
3494  03a9 1f03          	ldw	(OFST-1,sp),x
3495  03ab               L3302:
3498  03ab 1e03          	ldw	x,(OFST-1,sp)
3499  03ad 724f0050      	clr	(_buff,x)
3502  03b1 1e03          	ldw	x,(OFST-1,sp)
3503  03b3 1c0001        	addw	x,#1
3504  03b6 1f03          	ldw	(OFST-1,sp),x
3507  03b8 1e03          	ldw	x,(OFST-1,sp)
3508  03ba a30100        	cpw	x,#256
3509  03bd 25ec          	jrult	L3302
3510                     ; 307 		if(UIB[3]==1)
3512  03bf c60003        	ld	a,_UIB+3
3513  03c2 a101          	cp	a,#1
3514  03c4 2632          	jrne	L1402
3515                     ; 309 			buff[0]=0x00;
3517  03c6 725f0050      	clr	_buff
3518                     ; 310 			buff[1]=0x11;
3520  03ca 35110051      	mov	_buff+1,#17
3521                     ; 311 			buff[2]=0x22;
3523  03ce 35220052      	mov	_buff+2,#34
3524                     ; 312 			buff[3]=0x33;
3526  03d2 35330053      	mov	_buff+3,#51
3527                     ; 313 			buff[4]=0x44;
3529  03d6 35440054      	mov	_buff+4,#68
3530                     ; 314 			buff[5]=0x55;
3532  03da 35550055      	mov	_buff+5,#85
3533                     ; 315 			buff[6]=0x66;
3535  03de 35660056      	mov	_buff+6,#102
3536                     ; 316 			buff[7]=0x77;
3538  03e2 35770057      	mov	_buff+7,#119
3539                     ; 317 			buff[8]=0x88;
3541  03e6 35880058      	mov	_buff+8,#136
3542                     ; 318 			buff[9]=0x99;
3544  03ea 35990059      	mov	_buff+9,#153
3545                     ; 319 			buff[10]=0;
3547  03ee 725f005a      	clr	_buff+10
3548                     ; 320 			buff[11]=0;
3550  03f2 725f005b      	clr	_buff+11
3552  03f6 2070          	jra	L3402
3553  03f8               L1402:
3554                     ; 323 		else if(UIB[3]==2)
3556  03f8 c60003        	ld	a,_UIB+3
3557  03fb a102          	cp	a,#2
3558  03fd 2632          	jrne	L5402
3559                     ; 325 			buff[0]=0x00;
3561  03ff 725f0050      	clr	_buff
3562                     ; 326 			buff[1]=0x10;
3564  0403 35100051      	mov	_buff+1,#16
3565                     ; 327 			buff[2]=0x20;
3567  0407 35200052      	mov	_buff+2,#32
3568                     ; 328 			buff[3]=0x30;
3570  040b 35300053      	mov	_buff+3,#48
3571                     ; 329 			buff[4]=0x40;
3573  040f 35400054      	mov	_buff+4,#64
3574                     ; 330 			buff[5]=0x50;
3576  0413 35500055      	mov	_buff+5,#80
3577                     ; 331 			buff[6]=0x60;
3579  0417 35600056      	mov	_buff+6,#96
3580                     ; 332 			buff[7]=0x70;
3582  041b 35700057      	mov	_buff+7,#112
3583                     ; 333 			buff[8]=0x80;
3585  041f 35800058      	mov	_buff+8,#128
3586                     ; 334 			buff[9]=0x90;
3588  0423 35900059      	mov	_buff+9,#144
3589                     ; 335 			buff[10]=0;
3591  0427 725f005a      	clr	_buff+10
3592                     ; 336 			buff[11]=0;
3594  042b 725f005b      	clr	_buff+11
3596  042f 2037          	jra	L3402
3597  0431               L5402:
3598                     ; 339 		else if(UIB[3]==3)
3600  0431 c60003        	ld	a,_UIB+3
3601  0434 a103          	cp	a,#3
3602  0436 2630          	jrne	L3402
3603                     ; 341 			buff[0]=0x98;
3605  0438 35980050      	mov	_buff,#152
3606                     ; 342 			buff[1]=0x87;
3608  043c 35870051      	mov	_buff+1,#135
3609                     ; 343 			buff[2]=0x76;
3611  0440 35760052      	mov	_buff+2,#118
3612                     ; 344 			buff[3]=0x65;
3614  0444 35650053      	mov	_buff+3,#101
3615                     ; 345 			buff[4]=0x54;
3617  0448 35540054      	mov	_buff+4,#84
3618                     ; 346 			buff[5]=0x43;
3620  044c 35430055      	mov	_buff+5,#67
3621                     ; 347 			buff[6]=0x32;
3623  0450 35320056      	mov	_buff+6,#50
3624                     ; 348 			buff[7]=0x21;
3626  0454 35210057      	mov	_buff+7,#33
3627                     ; 349 			buff[8]=0x10;
3629  0458 35100058      	mov	_buff+8,#16
3630                     ; 350 			buff[9]=0x00;
3632  045c 725f0059      	clr	_buff+9
3633                     ; 351 			buff[10]=0;
3635  0460 725f005a      	clr	_buff+10
3636                     ; 352 			buff[11]=0;
3638  0464 725f005b      	clr	_buff+11
3639  0468               L3402:
3640                     ; 354 		if(UIB[2]==1)DF_buffer_write(/*1,*/0,256, buff);
3642  0468 c60002        	ld	a,_UIB+2
3643  046b a101          	cp	a,#1
3644  046d 2703          	jreq	L05
3645  046f cc0688        	jp	L5671
3646  0472               L05:
3649  0472 ae0050        	ldw	x,#_buff
3650  0475 89            	pushw	x
3651  0476 ae0100        	ldw	x,#256
3652  0479 89            	pushw	x
3653  047a 5f            	clrw	x
3654  047b cd0921        	call	_DF_buffer_write
3656  047e 5b04          	addw	sp,#4
3657  0480 ac880688      	jpf	L5671
3658  0484               L1302:
3659                     ; 358 	else if(UIB[1]==13)
3661  0484 c60001        	ld	a,_UIB+1
3662  0487 a10d          	cp	a,#13
3663  0489 260c          	jrne	L7502
3664                     ; 364 		DF_page_to_buffer(/*UIB[2],*/UIB[3]);
3666  048b c60003        	ld	a,_UIB+3
3667  048e 5f            	clrw	x
3668  048f 97            	ld	xl,a
3669  0490 cd0895        	call	_DF_page_to_buffer
3672  0493 ac880688      	jpf	L5671
3673  0497               L7502:
3674                     ; 380 	else if(UIB[1]==14)
3676  0497 c60001        	ld	a,_UIB+1
3677  049a a10e          	cp	a,#14
3678  049c 260c          	jrne	L3602
3679                     ; 386 		DF_buffer_to_page_er(/*UIB[2],*/UIB[3]);
3681  049e c60003        	ld	a,_UIB+3
3682  04a1 5f            	clrw	x
3683  04a2 97            	ld	xl,a
3684  04a3 cd08b8        	call	_DF_buffer_to_page_er
3687  04a6 ac880688      	jpf	L5671
3688  04aa               L3602:
3689                     ; 400 	else if(UIB[1]==20)
3691  04aa c60001        	ld	a,_UIB+1
3692  04ad a114          	cp	a,#20
3693  04af 2671          	jrne	L7602
3694                     ; 405 		file_lengt=0;
3696  04b1 ae0000        	ldw	x,#0
3697  04b4 bf07          	ldw	_file_lengt+2,x
3698  04b6 ae0000        	ldw	x,#0
3699  04b9 bf05          	ldw	_file_lengt,x
3700                     ; 406 		file_lengt+=UIB[5];
3702  04bb c60005        	ld	a,_UIB+5
3703  04be ae0005        	ldw	x,#_file_lengt
3704  04c1 88            	push	a
3705  04c2 cd0000        	call	c_lgadc
3707  04c5 84            	pop	a
3708                     ; 407 		file_lengt<<=8;
3710  04c6 ae0005        	ldw	x,#_file_lengt
3711  04c9 a608          	ld	a,#8
3712  04cb cd0000        	call	c_lglsh
3714                     ; 408 		file_lengt+=UIB[4];
3716  04ce c60004        	ld	a,_UIB+4
3717  04d1 ae0005        	ldw	x,#_file_lengt
3718  04d4 88            	push	a
3719  04d5 cd0000        	call	c_lgadc
3721  04d8 84            	pop	a
3722                     ; 409 		file_lengt<<=8;
3724  04d9 ae0005        	ldw	x,#_file_lengt
3725  04dc a608          	ld	a,#8
3726  04de cd0000        	call	c_lglsh
3728                     ; 410 		file_lengt+=UIB[3];
3730  04e1 c60003        	ld	a,_UIB+3
3731  04e4 ae0005        	ldw	x,#_file_lengt
3732  04e7 88            	push	a
3733  04e8 cd0000        	call	c_lgadc
3735  04eb 84            	pop	a
3736                     ; 411 		file_lengt_in_pages=file_lengt;
3738  04ec be07          	ldw	x,_file_lengt+2
3739  04ee bf0f          	ldw	_file_lengt_in_pages,x
3740                     ; 412 		file_lengt<<=8;
3742  04f0 ae0005        	ldw	x,#_file_lengt
3743  04f3 a608          	ld	a,#8
3744  04f5 cd0000        	call	c_lglsh
3746                     ; 413 		file_lengt+=UIB[2];
3748  04f8 c60002        	ld	a,_UIB+2
3749  04fb ae0005        	ldw	x,#_file_lengt
3750  04fe 88            	push	a
3751  04ff cd0000        	call	c_lgadc
3753  0502 84            	pop	a
3754                     ; 418 		current_page=0;
3756  0503 5f            	clrw	x
3757  0504 bf0d          	ldw	_current_page,x
3758                     ; 419 		current_byte_in_buffer=0;
3760  0506 5f            	clrw	x
3761  0507 bf09          	ldw	_current_byte_in_buffer,x
3762                     ; 424 		uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
3764  0509 4b00          	push	#0
3765  050b 4b00          	push	#0
3766  050d 4b00          	push	#0
3767  050f 4b00          	push	#0
3768  0511 4b15          	push	#21
3769  0513 ae0016        	ldw	x,#22
3770  0516 a604          	ld	a,#4
3771  0518 95            	ld	xh,a
3772  0519 cd00d2        	call	_uart_out
3774  051c 5b05          	addw	sp,#5
3776  051e ac880688      	jpf	L5671
3777  0522               L7602:
3778                     ; 427 	else if(UIB[1]==21)
3780  0522 c60001        	ld	a,_UIB+1
3781  0525 a115          	cp	a,#21
3782  0527 2703cc05af    	jrne	L3702
3783                     ; 432           for(i=0;i<64;i++)
3785  052c 5f            	clrw	x
3786  052d 1f03          	ldw	(OFST-1,sp),x
3787  052f               L5702:
3788                     ; 434           	buff[current_byte_in_buffer+i]=UIB[2+i];
3790  052f 1e03          	ldw	x,(OFST-1,sp)
3791  0531 d60002        	ld	a,(_UIB+2,x)
3792  0534 be09          	ldw	x,_current_byte_in_buffer
3793  0536 72fb03        	addw	x,(OFST-1,sp)
3794  0539 d70050        	ld	(_buff,x),a
3795                     ; 432           for(i=0;i<64;i++)
3797  053c 1e03          	ldw	x,(OFST-1,sp)
3798  053e 1c0001        	addw	x,#1
3799  0541 1f03          	ldw	(OFST-1,sp),x
3802  0543 1e03          	ldw	x,(OFST-1,sp)
3803  0545 a30040        	cpw	x,#64
3804  0548 25e5          	jrult	L5702
3805                     ; 436           current_byte_in_buffer+=64;
3807  054a be09          	ldw	x,_current_byte_in_buffer
3808  054c 1c0040        	addw	x,#64
3809  054f bf09          	ldw	_current_byte_in_buffer,x
3810                     ; 437           if(current_byte_in_buffer>=256)
3812  0551 be09          	ldw	x,_current_byte_in_buffer
3813  0553 a30100        	cpw	x,#256
3814  0556 2403          	jruge	L25
3815  0558 cc0688        	jp	L5671
3816  055b               L25:
3817                     ; 446           	DF_buffer_write(/*//current_buffer*//*1,*/0,256,buff);
3819  055b ae0050        	ldw	x,#_buff
3820  055e 89            	pushw	x
3821  055f ae0100        	ldw	x,#256
3822  0562 89            	pushw	x
3823  0563 5f            	clrw	x
3824  0564 cd0921        	call	_DF_buffer_write
3826  0567 5b04          	addw	sp,#4
3827                     ; 447           	DF_buffer_to_page_er(/*///current_buffer*//*1,*/current_page);
3829  0569 be0d          	ldw	x,_current_page
3830  056b cd08b8        	call	_DF_buffer_to_page_er
3832                     ; 448 			current_page++;
3834  056e be0d          	ldw	x,_current_page
3835  0570 1c0001        	addw	x,#1
3836  0573 bf0d          	ldw	_current_page,x
3837                     ; 449 			if(current_page<file_lengt_in_pages)
3839  0575 be0d          	ldw	x,_current_page
3840  0577 b30f          	cpw	x,_file_lengt_in_pages
3841  0579 2426          	jruge	L5012
3842                     ; 451 				delay_ms(100);
3844  057b ae0064        	ldw	x,#100
3845  057e cd0060        	call	_delay_ms
3847                     ; 452 				uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
3849  0581 4b00          	push	#0
3850  0583 4b00          	push	#0
3851  0585 3b000d        	push	_current_page
3852  0588 b60e          	ld	a,_current_page+1
3853  058a a4ff          	and	a,#255
3854  058c 88            	push	a
3855  058d 4b15          	push	#21
3856  058f ae0016        	ldw	x,#22
3857  0592 a604          	ld	a,#4
3858  0594 95            	ld	xh,a
3859  0595 cd00d2        	call	_uart_out
3861  0598 5b05          	addw	sp,#5
3862                     ; 453 				current_byte_in_buffer=0;
3864  059a 5f            	clrw	x
3865  059b bf09          	ldw	_current_byte_in_buffer,x
3867  059d ac880688      	jpf	L5671
3868  05a1               L5012:
3869                     ; 457 				EE_PAGE_LEN=current_page;
3871  05a1 be0d          	ldw	x,_current_page
3872  05a3 89            	pushw	x
3873  05a4 ae0000        	ldw	x,#_EE_PAGE_LEN
3874  05a7 cd0000        	call	c_eewrw
3876  05aa 85            	popw	x
3877  05ab ac880688      	jpf	L5671
3878  05af               L3702:
3879                     ; 485 	else if(UIB[1]==25)
3881  05af c60001        	ld	a,_UIB+1
3882  05b2 a119          	cp	a,#25
3883  05b4 2703          	jreq	L45
3884  05b6 cc0670        	jp	L3112
3885  05b9               L45:
3886                     ; 489 		current_page=0;
3888  05b9 5f            	clrw	x
3889  05ba bf0d          	ldw	_current_page,x
3890                     ; 491 		for(i__=0;i__<EE_PAGE_LEN;i__++)
3892  05bc 5f            	clrw	x
3893  05bd 1f03          	ldw	(OFST-1,sp),x
3895  05bf ac640664      	jpf	L1212
3896  05c3               L5112:
3897                     ; 494 			DF_page_to_buffer(i__);
3899  05c3 1e03          	ldw	x,(OFST-1,sp)
3900  05c5 cd0895        	call	_DF_page_to_buffer
3902                     ; 495 			delay_ms(100);			
3904  05c8 ae0064        	ldw	x,#100
3905  05cb cd0060        	call	_delay_ms
3907                     ; 496 			DF_buffer_read(0,256, buff);
3909  05ce ae0050        	ldw	x,#_buff
3910  05d1 89            	pushw	x
3911  05d2 ae0100        	ldw	x,#256
3912  05d5 89            	pushw	x
3913  05d6 5f            	clrw	x
3914  05d7 cd08db        	call	_DF_buffer_read
3916  05da 5b04          	addw	sp,#4
3917                     ; 503 			uart_out_adr_block ((256*i__)+0,buff,64);
3919  05dc 4b40          	push	#64
3920  05de ae0050        	ldw	x,#_buff
3921  05e1 89            	pushw	x
3922  05e2 1e06          	ldw	x,(OFST+2,sp)
3923  05e4 4f            	clr	a
3924  05e5 02            	rlwa	x,a
3925  05e6 cd0000        	call	c_itolx
3927  05e9 be02          	ldw	x,c_lreg+2
3928  05eb 89            	pushw	x
3929  05ec be00          	ldw	x,c_lreg
3930  05ee 89            	pushw	x
3931  05ef cd017c        	call	_uart_out_adr_block
3933  05f2 5b07          	addw	sp,#7
3934                     ; 504 			delay_ms(100);    
3936  05f4 ae0064        	ldw	x,#100
3937  05f7 cd0060        	call	_delay_ms
3939                     ; 505 			uart_out_adr_block ((256*i__)+64,&buff[64],64);
3941  05fa 4b40          	push	#64
3942  05fc ae0090        	ldw	x,#_buff+64
3943  05ff 89            	pushw	x
3944  0600 1e06          	ldw	x,(OFST+2,sp)
3945  0602 4f            	clr	a
3946  0603 02            	rlwa	x,a
3947  0604 1c0040        	addw	x,#64
3948  0607 cd0000        	call	c_itolx
3950  060a be02          	ldw	x,c_lreg+2
3951  060c 89            	pushw	x
3952  060d be00          	ldw	x,c_lreg
3953  060f 89            	pushw	x
3954  0610 cd017c        	call	_uart_out_adr_block
3956  0613 5b07          	addw	sp,#7
3957                     ; 506 			delay_ms(100);    
3959  0615 ae0064        	ldw	x,#100
3960  0618 cd0060        	call	_delay_ms
3962                     ; 507 			uart_out_adr_block ((256*i__)+128,&buff[128],64);
3964  061b 4b40          	push	#64
3965  061d ae00d0        	ldw	x,#_buff+128
3966  0620 89            	pushw	x
3967  0621 1e06          	ldw	x,(OFST+2,sp)
3968  0623 4f            	clr	a
3969  0624 02            	rlwa	x,a
3970  0625 1c0080        	addw	x,#128
3971  0628 cd0000        	call	c_itolx
3973  062b be02          	ldw	x,c_lreg+2
3974  062d 89            	pushw	x
3975  062e be00          	ldw	x,c_lreg
3976  0630 89            	pushw	x
3977  0631 cd017c        	call	_uart_out_adr_block
3979  0634 5b07          	addw	sp,#7
3980                     ; 508 			delay_ms(100);    
3982  0636 ae0064        	ldw	x,#100
3983  0639 cd0060        	call	_delay_ms
3985                     ; 509 			uart_out_adr_block ((256*i__)+192,&buff[192],64);
3987  063c 4b40          	push	#64
3988  063e ae0110        	ldw	x,#_buff+192
3989  0641 89            	pushw	x
3990  0642 1e06          	ldw	x,(OFST+2,sp)
3991  0644 4f            	clr	a
3992  0645 02            	rlwa	x,a
3993  0646 1c00c0        	addw	x,#192
3994  0649 cd0000        	call	c_itolx
3996  064c be02          	ldw	x,c_lreg+2
3997  064e 89            	pushw	x
3998  064f be00          	ldw	x,c_lreg
3999  0651 89            	pushw	x
4000  0652 cd017c        	call	_uart_out_adr_block
4002  0655 5b07          	addw	sp,#7
4003                     ; 510 			delay_ms(100);   
4005  0657 ae0064        	ldw	x,#100
4006  065a cd0060        	call	_delay_ms
4008                     ; 491 		for(i__=0;i__<EE_PAGE_LEN;i__++)
4010  065d 1e03          	ldw	x,(OFST-1,sp)
4011  065f 1c0001        	addw	x,#1
4012  0662 1f03          	ldw	(OFST-1,sp),x
4013  0664               L1212:
4016  0664 1e03          	ldw	x,(OFST-1,sp)
4017  0666 c30000        	cpw	x,_EE_PAGE_LEN
4018  0669 2403          	jruge	L65
4019  066b cc05c3        	jp	L5112
4020  066e               L65:
4022  066e 2018          	jra	L5671
4023  0670               L3112:
4024                     ; 520 	else if(UIB[1]==30)
4026  0670 c60001        	ld	a,_UIB+1
4027  0673 a11e          	cp	a,#30
4028  0675 2606          	jrne	L7212
4029                     ; 542           bSTART=1;
4031  0677 7210000b      	bset	_bSTART
4033  067b 200b          	jra	L5671
4034  067d               L7212:
4035                     ; 554 	else if(UIB[1]==40)
4037  067d c60001        	ld	a,_UIB+1
4038  0680 a128          	cp	a,#40
4039  0682 2604          	jrne	L5671
4040                     ; 576 		bSTART=1;	
4042  0684 7210000b      	bset	_bSTART
4043  0688               L5671:
4044                     ; 580 }
4047  0688 5b04          	addw	sp,#4
4048  068a 81            	ret
4085                     ; 583 void putchar(char c)
4085                     ; 584 {
4086                     	switch	.text
4087  068b               _putchar:
4089  068b 88            	push	a
4090       00000000      OFST:	set	0
4093  068c               L5512:
4094                     ; 585 while (tx_counter == TX_BUFFER_SIZE);
4096  068c b61e          	ld	a,_tx_counter
4097  068e a150          	cp	a,#80
4098  0690 27fa          	jreq	L5512
4099                     ; 587 if (tx_counter || ((UART1->SR & UART1_SR_TXE)==0))
4101  0692 3d1e          	tnz	_tx_counter
4102  0694 2607          	jrne	L3612
4104  0696 c65230        	ld	a,21040
4105  0699 a580          	bcp	a,#128
4106  069b 261d          	jrne	L1612
4107  069d               L3612:
4108                     ; 589    tx_buffer[tx_wr_index]=c;
4110  069d 5f            	clrw	x
4111  069e b61d          	ld	a,_tx_wr_index
4112  06a0 2a01          	jrpl	L26
4113  06a2 53            	cplw	x
4114  06a3               L26:
4115  06a3 97            	ld	xl,a
4116  06a4 7b01          	ld	a,(OFST+1,sp)
4117  06a6 e704          	ld	(_tx_buffer,x),a
4118                     ; 590    if (++tx_wr_index == TX_BUFFER_SIZE) tx_wr_index=0;
4120  06a8 3c1d          	inc	_tx_wr_index
4121  06aa b61d          	ld	a,_tx_wr_index
4122  06ac a150          	cp	a,#80
4123  06ae 2602          	jrne	L5612
4126  06b0 3f1d          	clr	_tx_wr_index
4127  06b2               L5612:
4128                     ; 591    ++tx_counter;
4130  06b2 3c1e          	inc	_tx_counter
4132  06b4               L7612:
4133                     ; 595 UART1->CR2|= UART1_CR2_TIEN;
4135  06b4 721e5235      	bset	21045,#7
4136                     ; 597 }
4139  06b8 84            	pop	a
4140  06b9 81            	ret
4141  06ba               L1612:
4142                     ; 593 else UART1->DR=c;
4144  06ba 7b01          	ld	a,(OFST+1,sp)
4145  06bc c75231        	ld	21041,a
4146  06bf 20f3          	jra	L7612
4169                     ; 600 void spi_init(void){
4170                     	switch	.text
4171  06c1               _spi_init:
4175                     ; 602 	GPIOB->DDR|=(1<<5);
4177  06c1 721a5007      	bset	20487,#5
4178                     ; 603 	GPIOB->CR1|=(1<<5);
4180  06c5 721a5008      	bset	20488,#5
4181                     ; 604 	GPIOB->CR2&=~(1<<5);
4183  06c9 721b5009      	bres	20489,#5
4184                     ; 605 	GPIOB->ODR|=(1<<5);	
4186  06cd 721a5005      	bset	20485,#5
4187                     ; 607 	GPIOC->DDR|=(1<<3);
4189  06d1 7216500c      	bset	20492,#3
4190                     ; 608 	GPIOC->CR1|=(1<<3);
4192  06d5 7216500d      	bset	20493,#3
4193                     ; 609 	GPIOC->CR2&=~(1<<3);
4195  06d9 7217500e      	bres	20494,#3
4196                     ; 610 	GPIOC->ODR|=(1<<3);	
4198  06dd 7216500a      	bset	20490,#3
4199                     ; 612 	GPIOC->DDR|=(1<<5);
4201  06e1 721a500c      	bset	20492,#5
4202                     ; 613 	GPIOC->CR1|=(1<<5);
4204  06e5 721a500d      	bset	20493,#5
4205                     ; 614 	GPIOC->CR2|=(1<<5);
4207  06e9 721a500e      	bset	20494,#5
4208                     ; 615 	GPIOC->ODR|=(1<<5);	
4210  06ed 721a500a      	bset	20490,#5
4211                     ; 617 	GPIOC->DDR|=(1<<6);
4213  06f1 721c500c      	bset	20492,#6
4214                     ; 618 	GPIOC->CR1|=(1<<6);
4216  06f5 721c500d      	bset	20493,#6
4217                     ; 619 	GPIOC->CR2|=(1<<6);
4219  06f9 721c500e      	bset	20494,#6
4220                     ; 620 	GPIOC->ODR|=(1<<6);	
4222  06fd 721c500a      	bset	20490,#6
4223                     ; 622 	GPIOC->DDR&=~(1<<7);
4225  0701 721f500c      	bres	20492,#7
4226                     ; 623 	GPIOC->CR1&=~(1<<7);
4228  0705 721f500d      	bres	20493,#7
4229                     ; 624 	GPIOC->CR2&=~(1<<7);
4231  0709 721f500e      	bres	20494,#7
4232                     ; 625 	GPIOC->ODR|=(1<<7);	
4234  070d 721e500a      	bset	20490,#7
4235                     ; 627 	SPI->CR1= /*SPI_CR1_LSBFIRST |*/
4235                     ; 628 			SPI_CR1_SPE | 
4235                     ; 629 			( (4<< 3) & SPI_CR1_BR ) |
4235                     ; 630 			SPI_CR1_MSTR |
4235                     ; 631 			SPI_CR1_CPOL |
4235                     ; 632 			SPI_CR1_CPHA; 
4237  0711 35675200      	mov	20992,#103
4238                     ; 634 	SPI->CR2= SPI_CR2_SSM | SPI_CR2_SSI;
4240  0715 35035201      	mov	20993,#3
4241                     ; 635 	SPI->ICR= 0;	
4243  0719 725f5202      	clr	20994
4244                     ; 636 }
4247  071d 81            	ret
4290                     ; 639 char spi(char in){
4291                     	switch	.text
4292  071e               _spi:
4294  071e 88            	push	a
4295  071f 88            	push	a
4296       00000001      OFST:	set	1
4299  0720               L5222:
4300                     ; 641 	while(!((SPI->SR)&SPI_SR_TXE));
4302  0720 c65203        	ld	a,20995
4303  0723 a502          	bcp	a,#2
4304  0725 27f9          	jreq	L5222
4305                     ; 642 	SPI->DR=in;
4307  0727 7b02          	ld	a,(OFST+1,sp)
4308  0729 c75204        	ld	20996,a
4310  072c               L5322:
4311                     ; 643 	while(!((SPI->SR)&SPI_SR_RXNE));
4313  072c c65203        	ld	a,20995
4314  072f a501          	bcp	a,#1
4315  0731 27f9          	jreq	L5322
4316                     ; 644 	c=SPI->DR;	
4318  0733 c65204        	ld	a,20996
4319  0736 6b01          	ld	(OFST+0,sp),a
4320                     ; 645 	return c;
4322  0738 7b01          	ld	a,(OFST+0,sp)
4325  073a 85            	popw	x
4326  073b 81            	ret
4391                     ; 649 long ST_RDID_read(void)
4391                     ; 650 {
4392                     	switch	.text
4393  073c               _ST_RDID_read:
4395  073c 5204          	subw	sp,#4
4396       00000004      OFST:	set	4
4399                     ; 653 d0=0;
4401  073e 0f04          	clr	(OFST+0,sp)
4402                     ; 654 d1=0;
4404                     ; 655 d2=0;
4406                     ; 656 d3=0;
4408                     ; 658 ST_CS_ON
4410  0740 721b5005      	bres	20485,#5
4411                     ; 659 spi(0x9f);
4413  0744 a69f          	ld	a,#159
4414  0746 add6          	call	_spi
4416                     ; 660 mdr0=spi(0xff);
4418  0748 a6ff          	ld	a,#255
4419  074a add2          	call	_spi
4421  074c b714          	ld	_mdr0,a
4422                     ; 661 mdr1=spi(0xff);
4424  074e a6ff          	ld	a,#255
4425  0750 adcc          	call	_spi
4427  0752 b713          	ld	_mdr1,a
4428                     ; 662 mdr2=spi(0xff);
4430  0754 a6ff          	ld	a,#255
4431  0756 adc6          	call	_spi
4433  0758 b712          	ld	_mdr2,a
4434                     ; 665 ST_CS_OFF
4436  075a 721a5005      	bset	20485,#5
4437                     ; 666 return  *((long*)&d0);
4439  075e 96            	ldw	x,sp
4440  075f 1c0004        	addw	x,#OFST+0
4441  0762 cd0000        	call	c_ltor
4445  0765 5b04          	addw	sp,#4
4446  0767 81            	ret
4481                     ; 670 char ST_status_read(void)
4481                     ; 671 {
4482                     	switch	.text
4483  0768               _ST_status_read:
4485  0768 88            	push	a
4486       00000001      OFST:	set	1
4489                     ; 675 ST_CS_ON
4491  0769 721b5005      	bres	20485,#5
4492                     ; 676 spi(0x05);
4494  076d a605          	ld	a,#5
4495  076f adad          	call	_spi
4497                     ; 677 d0=spi(0xff);
4499  0771 a6ff          	ld	a,#255
4500  0773 ada9          	call	_spi
4502  0775 6b01          	ld	(OFST+0,sp),a
4503                     ; 679 ST_CS_OFF
4505  0777 721a5005      	bset	20485,#5
4506                     ; 680 return d0;
4508  077b 7b01          	ld	a,(OFST+0,sp)
4511  077d 5b01          	addw	sp,#1
4512  077f 81            	ret
4536                     ; 684 void ST_WREN(void)
4536                     ; 685 {
4537                     	switch	.text
4538  0780               _ST_WREN:
4542                     ; 687 ST_CS_ON
4544  0780 721b5005      	bres	20485,#5
4545                     ; 688 spi(0x06);
4547  0784 a606          	ld	a,#6
4548  0786 ad96          	call	_spi
4550                     ; 690 ST_CS_OFF
4552  0788 721a5005      	bset	20485,#5
4553                     ; 691 }  
4556  078c 81            	ret
4646                     ; 694 void ST_WRITE(unsigned long memo_addr,unsigned short len, char* adr)
4646                     ; 695 {
4647                     	switch	.text
4648  078d               _ST_WRITE:
4650  078d 5205          	subw	sp,#5
4651       00000005      OFST:	set	5
4654                     ; 699 adr2=(char)(memo_addr>>16);
4656  078f 7b09          	ld	a,(OFST+4,sp)
4657  0791 6b03          	ld	(OFST-2,sp),a
4658                     ; 700 adr1=(char)((memo_addr>>8)&0x00ff);
4660  0793 7b0a          	ld	a,(OFST+5,sp)
4661  0795 a4ff          	and	a,#255
4662  0797 6b02          	ld	(OFST-3,sp),a
4663                     ; 701 adr0=(char)((memo_addr)&0x00ff);
4665  0799 7b0b          	ld	a,(OFST+6,sp)
4666  079b a4ff          	and	a,#255
4667  079d 6b01          	ld	(OFST-4,sp),a
4668                     ; 702 ST_CS_ON
4670  079f 721b5005      	bres	20485,#5
4671                     ; 703 spi(0x0a);
4673  07a3 a60a          	ld	a,#10
4674  07a5 cd071e        	call	_spi
4676                     ; 704 spi(adr2);
4678  07a8 7b03          	ld	a,(OFST-2,sp)
4679  07aa cd071e        	call	_spi
4681                     ; 705 spi(adr1);
4683  07ad 7b02          	ld	a,(OFST-3,sp)
4684  07af cd071e        	call	_spi
4686                     ; 706 spi(adr0);
4688  07b2 7b01          	ld	a,(OFST-4,sp)
4689  07b4 cd071e        	call	_spi
4691                     ; 708 for(i=0;i<len;i++)
4693  07b7 5f            	clrw	x
4694  07b8 1f04          	ldw	(OFST-1,sp),x
4696  07ba 2010          	jra	L3732
4697  07bc               L7632:
4698                     ; 710 	spi(adr[i]);
4700  07bc 1e0e          	ldw	x,(OFST+9,sp)
4701  07be 72fb04        	addw	x,(OFST-1,sp)
4702  07c1 f6            	ld	a,(x)
4703  07c2 cd071e        	call	_spi
4705                     ; 708 for(i=0;i<len;i++)
4707  07c5 1e04          	ldw	x,(OFST-1,sp)
4708  07c7 1c0001        	addw	x,#1
4709  07ca 1f04          	ldw	(OFST-1,sp),x
4710  07cc               L3732:
4713  07cc 1e04          	ldw	x,(OFST-1,sp)
4714  07ce 130c          	cpw	x,(OFST+7,sp)
4715  07d0 25ea          	jrult	L7632
4716                     ; 713 ST_CS_OFF
4718  07d2 721a5005      	bset	20485,#5
4719                     ; 714 }
4722  07d6 5b05          	addw	sp,#5
4723  07d8 81            	ret
4813                     ; 717 void ST_READ(unsigned long memo_addr,unsigned short len, char* adr)
4813                     ; 718 {
4814                     	switch	.text
4815  07d9               _ST_READ:
4817  07d9 5205          	subw	sp,#5
4818       00000005      OFST:	set	5
4821                     ; 724 adr2=(char)(memo_addr>>16);
4823  07db 7b09          	ld	a,(OFST+4,sp)
4824  07dd 6b03          	ld	(OFST-2,sp),a
4825                     ; 725 adr1=(char)((memo_addr>>8)&0x00ff);
4827  07df 7b0a          	ld	a,(OFST+5,sp)
4828  07e1 a4ff          	and	a,#255
4829  07e3 6b02          	ld	(OFST-3,sp),a
4830                     ; 726 adr0=(char)((memo_addr)&0x00ff);
4832  07e5 7b0b          	ld	a,(OFST+6,sp)
4833  07e7 a4ff          	and	a,#255
4834  07e9 6b01          	ld	(OFST-4,sp),a
4835                     ; 727 ST_CS_ON
4837  07eb 721b5005      	bres	20485,#5
4838                     ; 728 spi(0x03);
4840  07ef a603          	ld	a,#3
4841  07f1 cd071e        	call	_spi
4843                     ; 729 spi(adr2);
4845  07f4 7b03          	ld	a,(OFST-2,sp)
4846  07f6 cd071e        	call	_spi
4848                     ; 730 spi(adr1);
4850  07f9 7b02          	ld	a,(OFST-3,sp)
4851  07fb cd071e        	call	_spi
4853                     ; 731 spi(adr0);
4855  07fe 7b01          	ld	a,(OFST-4,sp)
4856  0800 cd071e        	call	_spi
4858                     ; 733 for(i=0;i<len;i++)
4860  0803 5f            	clrw	x
4861  0804 1f04          	ldw	(OFST-1,sp),x
4863  0806 2012          	jra	L1542
4864  0808               L5442:
4865                     ; 735 	adr[i]=spi(0xff);
4867  0808 a6ff          	ld	a,#255
4868  080a cd071e        	call	_spi
4870  080d 1e0e          	ldw	x,(OFST+9,sp)
4871  080f 72fb04        	addw	x,(OFST-1,sp)
4872  0812 f7            	ld	(x),a
4873                     ; 733 for(i=0;i<len;i++)
4875  0813 1e04          	ldw	x,(OFST-1,sp)
4876  0815 1c0001        	addw	x,#1
4877  0818 1f04          	ldw	(OFST-1,sp),x
4878  081a               L1542:
4881  081a 1e04          	ldw	x,(OFST-1,sp)
4882  081c 130c          	cpw	x,(OFST+7,sp)
4883  081e 25e8          	jrult	L5442
4884                     ; 738 ST_CS_OFF
4886  0820 721a5005      	bset	20485,#5
4887                     ; 739 }
4890  0824 5b05          	addw	sp,#5
4891  0826 81            	ret
4957                     ; 743 long DF_mf_dev_read(void)
4957                     ; 744 {
4958                     	switch	.text
4959  0827               _DF_mf_dev_read:
4961  0827 5204          	subw	sp,#4
4962       00000004      OFST:	set	4
4965                     ; 747 d0=0;
4967  0829 0f04          	clr	(OFST+0,sp)
4968                     ; 748 d1=0;
4970                     ; 749 d2=0;
4972                     ; 750 d3=0;
4974                     ; 752 CS_ON
4976  082b 7217500a      	bres	20490,#3
4977                     ; 753 spi(0x9f);
4979  082f a69f          	ld	a,#159
4980  0831 cd071e        	call	_spi
4982                     ; 754 mdr0=spi(0xff);
4984  0834 a6ff          	ld	a,#255
4985  0836 cd071e        	call	_spi
4987  0839 b714          	ld	_mdr0,a
4988                     ; 755 mdr1=spi(0xff);
4990  083b a6ff          	ld	a,#255
4991  083d cd071e        	call	_spi
4993  0840 b713          	ld	_mdr1,a
4994                     ; 756 mdr2=spi(0xff);
4996  0842 a6ff          	ld	a,#255
4997  0844 cd071e        	call	_spi
4999  0847 b712          	ld	_mdr2,a
5000                     ; 757 mdr3=spi(0xff);  
5002  0849 a6ff          	ld	a,#255
5003  084b cd071e        	call	_spi
5005  084e b711          	ld	_mdr3,a
5006                     ; 759 CS_OFF
5008  0850 7216500a      	bset	20490,#3
5009                     ; 760 return  *((long*)&d0);
5011  0854 96            	ldw	x,sp
5012  0855 1c0004        	addw	x,#OFST+0
5013  0858 cd0000        	call	c_ltor
5017  085b 5b04          	addw	sp,#4
5018  085d 81            	ret
5042                     ; 764 void DF_memo_to_256(void)
5042                     ; 765 {
5043                     	switch	.text
5044  085e               _DF_memo_to_256:
5048                     ; 767 CS_ON
5050  085e 7217500a      	bres	20490,#3
5051                     ; 768 spi(0x3d);
5053  0862 a63d          	ld	a,#61
5054  0864 cd071e        	call	_spi
5056                     ; 769 spi(0x2a); 
5058  0867 a62a          	ld	a,#42
5059  0869 cd071e        	call	_spi
5061                     ; 770 spi(0x80);
5063  086c a680          	ld	a,#128
5064  086e cd071e        	call	_spi
5066                     ; 771 spi(0xa6);
5068  0871 a6a6          	ld	a,#166
5069  0873 cd071e        	call	_spi
5071                     ; 773 CS_OFF
5073  0876 7216500a      	bset	20490,#3
5074                     ; 774 }  
5077  087a 81            	ret
5112                     ; 779 char DF_status_read(void)
5112                     ; 780 {
5113                     	switch	.text
5114  087b               _DF_status_read:
5116  087b 88            	push	a
5117       00000001      OFST:	set	1
5120                     ; 784 CS_ON
5122  087c 7217500a      	bres	20490,#3
5123                     ; 785 spi(0xd7);
5125  0880 a6d7          	ld	a,#215
5126  0882 cd071e        	call	_spi
5128                     ; 786 d0=spi(0xff);
5130  0885 a6ff          	ld	a,#255
5131  0887 cd071e        	call	_spi
5133  088a 6b01          	ld	(OFST+0,sp),a
5134                     ; 788 CS_OFF
5136  088c 7216500a      	bset	20490,#3
5137                     ; 789 return d0;
5139  0890 7b01          	ld	a,(OFST+0,sp)
5142  0892 5b01          	addw	sp,#1
5143  0894 81            	ret
5187                     ; 793 void DF_page_to_buffer(unsigned page_addr)
5187                     ; 794 {
5188                     	switch	.text
5189  0895               _DF_page_to_buffer:
5191  0895 89            	pushw	x
5192  0896 88            	push	a
5193       00000001      OFST:	set	1
5196                     ; 797 d0=0x53; 
5198                     ; 801 CS_ON
5200  0897 7217500a      	bres	20490,#3
5201                     ; 802 spi(d0);
5203  089b a653          	ld	a,#83
5204  089d cd071e        	call	_spi
5206                     ; 803 spi(page_addr/256/**(((char*)&page_addr)+1)*/);
5208  08a0 7b02          	ld	a,(OFST+1,sp)
5209  08a2 cd071e        	call	_spi
5211                     ; 804 spi(page_addr%256/**((char*)&page_addr)*/);
5213  08a5 7b03          	ld	a,(OFST+2,sp)
5214  08a7 a4ff          	and	a,#255
5215  08a9 cd071e        	call	_spi
5217                     ; 805 spi(0xff);
5219  08ac a6ff          	ld	a,#255
5220  08ae cd071e        	call	_spi
5222                     ; 807 CS_OFF
5224  08b1 7216500a      	bset	20490,#3
5225                     ; 808 }
5228  08b5 5b03          	addw	sp,#3
5229  08b7 81            	ret
5274                     ; 811 void DF_buffer_to_page_er(/*char buff,*/unsigned page_addr)
5274                     ; 812 {
5275                     	switch	.text
5276  08b8               _DF_buffer_to_page_er:
5278  08b8 89            	pushw	x
5279  08b9 88            	push	a
5280       00000001      OFST:	set	1
5283                     ; 815 d0=0x83; 
5285                     ; 818 CS_ON
5287  08ba 7217500a      	bres	20490,#3
5288                     ; 819 spi(d0);
5290  08be a683          	ld	a,#131
5291  08c0 cd071e        	call	_spi
5293                     ; 820 spi(page_addr/256/**(((char*)&page_addr)+1)*/);
5295  08c3 7b02          	ld	a,(OFST+1,sp)
5296  08c5 cd071e        	call	_spi
5298                     ; 821 spi(page_addr%256/**((char*)&page_addr)*/);
5300  08c8 7b03          	ld	a,(OFST+2,sp)
5301  08ca a4ff          	and	a,#255
5302  08cc cd071e        	call	_spi
5304                     ; 822 spi(0xff);
5306  08cf a6ff          	ld	a,#255
5307  08d1 cd071e        	call	_spi
5309                     ; 824 CS_OFF
5311  08d4 7216500a      	bset	20490,#3
5312                     ; 825 }
5315  08d8 5b03          	addw	sp,#3
5316  08da 81            	ret
5388                     ; 828 void DF_buffer_read(unsigned buff_addr,unsigned len, char* adr)
5388                     ; 829 {
5389                     	switch	.text
5390  08db               _DF_buffer_read:
5392  08db 89            	pushw	x
5393  08dc 5203          	subw	sp,#3
5394       00000003      OFST:	set	3
5397                     ; 833 d0=0x54; 
5399                     ; 835 CS_ON
5401  08de 7217500a      	bres	20490,#3
5402                     ; 836 spi(d0);
5404  08e2 a654          	ld	a,#84
5405  08e4 cd071e        	call	_spi
5407                     ; 837 spi(0xff);
5409  08e7 a6ff          	ld	a,#255
5410  08e9 cd071e        	call	_spi
5412                     ; 838 spi(buff_addr/256/**(((char*)&buff_addr)+1)*/);
5414  08ec 7b04          	ld	a,(OFST+1,sp)
5415  08ee cd071e        	call	_spi
5417                     ; 839 spi(buff_addr%256/**((char*)&buff_addr)*/);
5419  08f1 7b05          	ld	a,(OFST+2,sp)
5420  08f3 a4ff          	and	a,#255
5421  08f5 cd071e        	call	_spi
5423                     ; 840 spi(0xff);
5425  08f8 a6ff          	ld	a,#255
5426  08fa cd071e        	call	_spi
5428                     ; 841 for(i=0;i<len;i++)
5430  08fd 5f            	clrw	x
5431  08fe 1f02          	ldw	(OFST-1,sp),x
5433  0900 2012          	jra	L3462
5434  0902               L7362:
5435                     ; 843 	adr[i]=spi(0xff);
5437  0902 a6ff          	ld	a,#255
5438  0904 cd071e        	call	_spi
5440  0907 1e0a          	ldw	x,(OFST+7,sp)
5441  0909 72fb02        	addw	x,(OFST-1,sp)
5442  090c f7            	ld	(x),a
5443                     ; 841 for(i=0;i<len;i++)
5445  090d 1e02          	ldw	x,(OFST-1,sp)
5446  090f 1c0001        	addw	x,#1
5447  0912 1f02          	ldw	(OFST-1,sp),x
5448  0914               L3462:
5451  0914 1e02          	ldw	x,(OFST-1,sp)
5452  0916 1308          	cpw	x,(OFST+5,sp)
5453  0918 25e8          	jrult	L7362
5454                     ; 846 CS_OFF
5456  091a 7216500a      	bset	20490,#3
5457                     ; 847 }
5460  091e 5b05          	addw	sp,#5
5461  0920 81            	ret
5533                     ; 850 void DF_buffer_write(/*char buff,*/unsigned buff_addr,unsigned len, char* adr)
5533                     ; 851 {
5534                     	switch	.text
5535  0921               _DF_buffer_write:
5537  0921 89            	pushw	x
5538  0922 5203          	subw	sp,#3
5539       00000003      OFST:	set	3
5542                     ; 855 d0=0x84; 
5544                     ; 857 CS_ON
5546  0924 7217500a      	bres	20490,#3
5547                     ; 858 spi(d0);
5549  0928 a684          	ld	a,#132
5550  092a cd071e        	call	_spi
5552                     ; 859 spi(0xff);
5554  092d a6ff          	ld	a,#255
5555  092f cd071e        	call	_spi
5557                     ; 860 spi(buff_addr/256/**(((char*)&buff_addr)+1)*/);
5559  0932 7b04          	ld	a,(OFST+1,sp)
5560  0934 cd071e        	call	_spi
5562                     ; 861 spi(buff_addr%256/**((char*)&buff_addr)*/);
5564  0937 7b05          	ld	a,(OFST+2,sp)
5565  0939 a4ff          	and	a,#255
5566  093b cd071e        	call	_spi
5568                     ; 863 for(i=0;i<len;i++)
5570  093e 5f            	clrw	x
5571  093f 1f02          	ldw	(OFST-1,sp),x
5573  0941 2010          	jra	L1172
5574  0943               L5072:
5575                     ; 865 	spi(adr[i]);
5577  0943 1e0a          	ldw	x,(OFST+7,sp)
5578  0945 72fb02        	addw	x,(OFST-1,sp)
5579  0948 f6            	ld	a,(x)
5580  0949 cd071e        	call	_spi
5582                     ; 863 for(i=0;i<len;i++)
5584  094c 1e02          	ldw	x,(OFST-1,sp)
5585  094e 1c0001        	addw	x,#1
5586  0951 1f02          	ldw	(OFST-1,sp),x
5587  0953               L1172:
5590  0953 1e02          	ldw	x,(OFST-1,sp)
5591  0955 1308          	cpw	x,(OFST+5,sp)
5592  0957 25ea          	jrult	L5072
5593                     ; 868 CS_OFF
5595  0959 7216500a      	bset	20490,#3
5596                     ; 869 }
5599  095d 5b05          	addw	sp,#5
5600  095f 81            	ret
5623                     ; 891 void gpio_init(void){
5624                     	switch	.text
5625  0960               _gpio_init:
5629                     ; 901 	GPIOD->DDR|=(1<<2);
5631  0960 72145011      	bset	20497,#2
5632                     ; 902 	GPIOD->CR1|=(1<<2);
5634  0964 72145012      	bset	20498,#2
5635                     ; 903 	GPIOD->CR2|=(1<<2);
5637  0968 72145013      	bset	20499,#2
5638                     ; 904 	GPIOD->ODR&=~(1<<2);
5640  096c 7215500f      	bres	20495,#2
5641                     ; 906 	GPIOD->DDR|=(1<<4);
5643  0970 72185011      	bset	20497,#4
5644                     ; 907 	GPIOD->CR1|=(1<<4);
5646  0974 72185012      	bset	20498,#4
5647                     ; 908 	GPIOD->CR2&=~(1<<4);
5649  0978 72195013      	bres	20499,#4
5650                     ; 910 	GPIOC->DDR&=~(1<<4);
5652  097c 7219500c      	bres	20492,#4
5653                     ; 911 	GPIOC->CR1&=~(1<<4);
5655  0980 7219500d      	bres	20493,#4
5656                     ; 912 	GPIOC->CR2&=~(1<<4);
5658  0984 7219500e      	bres	20494,#4
5659                     ; 916 }
5662  0988 81            	ret
5714                     ; 919 void uart_in(void)
5714                     ; 920 {
5715                     	switch	.text
5716  0989               _uart_in:
5718  0989 89            	pushw	x
5719       00000002      OFST:	set	2
5722                     ; 924 if(rx_buffer_overflow)
5724                     	btst	_rx_buffer_overflow
5725  098f 240d          	jruge	L7472
5726                     ; 926 	rx_wr_index=0;
5728  0991 5f            	clrw	x
5729  0992 bf18          	ldw	_rx_wr_index,x
5730                     ; 927 	rx_rd_index=0;
5732  0994 5f            	clrw	x
5733  0995 bf16          	ldw	_rx_rd_index,x
5734                     ; 928 	rx_counter=0;
5736  0997 5f            	clrw	x
5737  0998 bf1a          	ldw	_rx_counter,x
5738                     ; 929 	rx_buffer_overflow=0;
5740  099a 72110000      	bres	_rx_buffer_overflow
5741  099e               L7472:
5742                     ; 932 if(rx_counter&&(rx_buffer[index_offset(rx_wr_index,-1)])==END)
5744  099e be1a          	ldw	x,_rx_counter
5745  09a0 2775          	jreq	L1572
5747  09a2 aeffff        	ldw	x,#65535
5748  09a5 89            	pushw	x
5749  09a6 be18          	ldw	x,_rx_wr_index
5750  09a8 ad6f          	call	_index_offset
5752  09aa 5b02          	addw	sp,#2
5753  09ac e654          	ld	a,(_rx_buffer,x)
5754  09ae a10a          	cp	a,#10
5755  09b0 2665          	jrne	L1572
5756                     ; 937 	temp=rx_buffer[index_offset(rx_wr_index,-3)];
5758  09b2 aefffd        	ldw	x,#65533
5759  09b5 89            	pushw	x
5760  09b6 be18          	ldw	x,_rx_wr_index
5761  09b8 ad5f          	call	_index_offset
5763  09ba 5b02          	addw	sp,#2
5764  09bc e654          	ld	a,(_rx_buffer,x)
5765  09be 6b01          	ld	(OFST-1,sp),a
5766                     ; 938     	if(temp<100) 
5768  09c0 7b01          	ld	a,(OFST-1,sp)
5769  09c2 a164          	cp	a,#100
5770  09c4 2451          	jruge	L1572
5771                     ; 941     		if(control_check(index_offset(rx_wr_index,-1)))
5773  09c6 aeffff        	ldw	x,#65535
5774  09c9 89            	pushw	x
5775  09ca be18          	ldw	x,_rx_wr_index
5776  09cc ad4b          	call	_index_offset
5778  09ce 5b02          	addw	sp,#2
5779  09d0 9f            	ld	a,xl
5780  09d1 ad6e          	call	_control_check
5782  09d3 4d            	tnz	a
5783  09d4 2741          	jreq	L1572
5784                     ; 944     			rx_rd_index=index_offset(rx_wr_index,-3-temp);
5786  09d6 a6ff          	ld	a,#255
5787  09d8 97            	ld	xl,a
5788  09d9 a6fd          	ld	a,#253
5789  09db 1001          	sub	a,(OFST-1,sp)
5790  09dd 2401          	jrnc	L421
5791  09df 5a            	decw	x
5792  09e0               L421:
5793  09e0 02            	rlwa	x,a
5794  09e1 89            	pushw	x
5795  09e2 01            	rrwa	x,a
5796  09e3 be18          	ldw	x,_rx_wr_index
5797  09e5 ad32          	call	_index_offset
5799  09e7 5b02          	addw	sp,#2
5800  09e9 bf16          	ldw	_rx_rd_index,x
5801                     ; 945     			for(i=0;i<temp;i++)
5803  09eb 0f02          	clr	(OFST+0,sp)
5805  09ed 2018          	jra	L3672
5806  09ef               L7572:
5807                     ; 947 				UIB[i]=rx_buffer[index_offset(rx_rd_index,i)];
5809  09ef 7b02          	ld	a,(OFST+0,sp)
5810  09f1 5f            	clrw	x
5811  09f2 97            	ld	xl,a
5812  09f3 89            	pushw	x
5813  09f4 7b04          	ld	a,(OFST+2,sp)
5814  09f6 5f            	clrw	x
5815  09f7 97            	ld	xl,a
5816  09f8 89            	pushw	x
5817  09f9 be16          	ldw	x,_rx_rd_index
5818  09fb ad1c          	call	_index_offset
5820  09fd 5b02          	addw	sp,#2
5821  09ff e654          	ld	a,(_rx_buffer,x)
5822  0a01 85            	popw	x
5823  0a02 d70000        	ld	(_UIB,x),a
5824                     ; 945     			for(i=0;i<temp;i++)
5826  0a05 0c02          	inc	(OFST+0,sp)
5827  0a07               L3672:
5830  0a07 7b02          	ld	a,(OFST+0,sp)
5831  0a09 1101          	cp	a,(OFST-1,sp)
5832  0a0b 25e2          	jrult	L7572
5833                     ; 949 			rx_rd_index=rx_wr_index;
5835  0a0d be18          	ldw	x,_rx_wr_index
5836  0a0f bf16          	ldw	_rx_rd_index,x
5837                     ; 950 			rx_counter=0;
5839  0a11 5f            	clrw	x
5840  0a12 bf1a          	ldw	_rx_counter,x
5841                     ; 960 			uart_in_an();
5843  0a14 cd023c        	call	_uart_in_an
5845  0a17               L1572:
5846                     ; 969 }
5849  0a17 85            	popw	x
5850  0a18 81            	ret
5893                     ; 972 signed short index_offset (signed short index,signed short offset)
5893                     ; 973 {
5894                     	switch	.text
5895  0a19               _index_offset:
5897  0a19 89            	pushw	x
5898       00000000      OFST:	set	0
5901                     ; 974 index=index+offset;
5903  0a1a 1e01          	ldw	x,(OFST+1,sp)
5904  0a1c 72fb05        	addw	x,(OFST+5,sp)
5905  0a1f 1f01          	ldw	(OFST+1,sp),x
5906                     ; 975 if(index>=RX_BUFFER_SIZE) index-=RX_BUFFER_SIZE; 
5908  0a21 9c            	rvf
5909  0a22 1e01          	ldw	x,(OFST+1,sp)
5910  0a24 a30064        	cpw	x,#100
5911  0a27 2f07          	jrslt	L1103
5914  0a29 1e01          	ldw	x,(OFST+1,sp)
5915  0a2b 1d0064        	subw	x,#100
5916  0a2e 1f01          	ldw	(OFST+1,sp),x
5917  0a30               L1103:
5918                     ; 976 if(index<0) index+=RX_BUFFER_SIZE;
5920  0a30 9c            	rvf
5921  0a31 1e01          	ldw	x,(OFST+1,sp)
5922  0a33 2e07          	jrsge	L3103
5925  0a35 1e01          	ldw	x,(OFST+1,sp)
5926  0a37 1c0064        	addw	x,#100
5927  0a3a 1f01          	ldw	(OFST+1,sp),x
5928  0a3c               L3103:
5929                     ; 977 return index;
5931  0a3c 1e01          	ldw	x,(OFST+1,sp)
5934  0a3e 5b02          	addw	sp,#2
5935  0a40 81            	ret
5998                     ; 981 char control_check(char index)
5998                     ; 982 {
5999                     	switch	.text
6000  0a41               _control_check:
6002  0a41 88            	push	a
6003  0a42 5203          	subw	sp,#3
6004       00000003      OFST:	set	3
6007                     ; 983 char i=0,ii=0,iii;
6011                     ; 985 if(rx_buffer[index]!=END) return 0;
6013  0a44 5f            	clrw	x
6014  0a45 97            	ld	xl,a
6015  0a46 e654          	ld	a,(_rx_buffer,x)
6016  0a48 a10a          	cp	a,#10
6017  0a4a 2703          	jreq	L7403
6020  0a4c 4f            	clr	a
6022  0a4d 2051          	jra	L631
6023  0a4f               L7403:
6024                     ; 987 ii=rx_buffer[index_offset(index,-2)];
6026  0a4f aefffe        	ldw	x,#65534
6027  0a52 89            	pushw	x
6028  0a53 7b06          	ld	a,(OFST+3,sp)
6029  0a55 5f            	clrw	x
6030  0a56 97            	ld	xl,a
6031  0a57 adc0          	call	_index_offset
6033  0a59 5b02          	addw	sp,#2
6034  0a5b e654          	ld	a,(_rx_buffer,x)
6035  0a5d 6b02          	ld	(OFST-1,sp),a
6036                     ; 988 iii=0;
6038  0a5f 0f01          	clr	(OFST-2,sp)
6039                     ; 989 for(i=0;i<=ii;i++)
6041  0a61 0f03          	clr	(OFST+0,sp)
6043  0a63 2022          	jra	L5503
6044  0a65               L1503:
6045                     ; 991 	iii^=rx_buffer[index_offset(index,-2-ii+i)];
6047  0a65 a6ff          	ld	a,#255
6048  0a67 97            	ld	xl,a
6049  0a68 a6fe          	ld	a,#254
6050  0a6a 1002          	sub	a,(OFST-1,sp)
6051  0a6c 2401          	jrnc	L231
6052  0a6e 5a            	decw	x
6053  0a6f               L231:
6054  0a6f 1b03          	add	a,(OFST+0,sp)
6055  0a71 2401          	jrnc	L431
6056  0a73 5c            	incw	x
6057  0a74               L431:
6058  0a74 02            	rlwa	x,a
6059  0a75 89            	pushw	x
6060  0a76 01            	rrwa	x,a
6061  0a77 7b06          	ld	a,(OFST+3,sp)
6062  0a79 5f            	clrw	x
6063  0a7a 97            	ld	xl,a
6064  0a7b ad9c          	call	_index_offset
6066  0a7d 5b02          	addw	sp,#2
6067  0a7f 7b01          	ld	a,(OFST-2,sp)
6068  0a81 e854          	xor	a,	(_rx_buffer,x)
6069  0a83 6b01          	ld	(OFST-2,sp),a
6070                     ; 989 for(i=0;i<=ii;i++)
6072  0a85 0c03          	inc	(OFST+0,sp)
6073  0a87               L5503:
6076  0a87 7b03          	ld	a,(OFST+0,sp)
6077  0a89 1102          	cp	a,(OFST-1,sp)
6078  0a8b 23d8          	jrule	L1503
6079                     ; 993 if (iii!=rx_buffer[index_offset(index,-1)]) return 0;	
6081  0a8d aeffff        	ldw	x,#65535
6082  0a90 89            	pushw	x
6083  0a91 7b06          	ld	a,(OFST+3,sp)
6084  0a93 5f            	clrw	x
6085  0a94 97            	ld	xl,a
6086  0a95 ad82          	call	_index_offset
6088  0a97 5b02          	addw	sp,#2
6089  0a99 e654          	ld	a,(_rx_buffer,x)
6090  0a9b 1101          	cp	a,(OFST-2,sp)
6091  0a9d 2704          	jreq	L1603
6094  0a9f 4f            	clr	a
6096  0aa0               L631:
6098  0aa0 5b04          	addw	sp,#4
6099  0aa2 81            	ret
6100  0aa3               L1603:
6101                     ; 995 return 1;
6103  0aa3 a601          	ld	a,#1
6105  0aa5 20f9          	jra	L631
6147                     ; 1004 @far @interrupt void TIM4_UPD_Interrupt (void) {
6149                     	switch	.text
6150  0aa7               f_TIM4_UPD_Interrupt:
6154                     ; 1006 	if(play) {
6156                     	btst	_play
6157  0aac 2449          	jruge	L3703
6158                     ; 1007 		TIM2->CCR3H= 0x00;	
6160  0aae 725f5315      	clr	21269
6161                     ; 1008 		TIM2->CCR3L= sample;
6163  0ab2 5500155316    	mov	21270,_sample
6164                     ; 1009 		sample_cnt++;
6166  0ab7 be1f          	ldw	x,_sample_cnt
6167  0ab9 1c0001        	addw	x,#1
6168  0abc bf1f          	ldw	_sample_cnt,x
6169                     ; 1010 		if(sample_cnt>=256) {
6171  0abe 9c            	rvf
6172  0abf be1f          	ldw	x,_sample_cnt
6173  0ac1 a30100        	cpw	x,#256
6174  0ac4 2f03          	jrslt	L5703
6175                     ; 1011 			sample_cnt=0;
6177  0ac6 5f            	clrw	x
6178  0ac7 bf1f          	ldw	_sample_cnt,x
6179  0ac9               L5703:
6180                     ; 1015 		sample=buff[sample_cnt];
6182  0ac9 be1f          	ldw	x,_sample_cnt
6183  0acb d60050        	ld	a,(_buff,x)
6184  0ace b715          	ld	_sample,a
6185                     ; 1017 		if(sample_cnt==132)	{
6187  0ad0 be1f          	ldw	x,_sample_cnt
6188  0ad2 a30084        	cpw	x,#132
6189  0ad5 2604          	jrne	L7703
6190                     ; 1018 			bBUFF_LOAD=1;
6192  0ad7 7210000a      	bset	_bBUFF_LOAD
6193  0adb               L7703:
6194                     ; 1022 		if(sample_cnt==5) {
6196  0adb be1f          	ldw	x,_sample_cnt
6197  0add a30005        	cpw	x,#5
6198  0ae0 2604          	jrne	L1013
6199                     ; 1023 			bBUFF_READ_H=1;
6201  0ae2 72100009      	bset	_bBUFF_READ_H
6202  0ae6               L1013:
6203                     ; 1026 		if(sample_cnt==150) {
6205  0ae6 be1f          	ldw	x,_sample_cnt
6206  0ae8 a30096        	cpw	x,#150
6207  0aeb 2604          	jrne	L3013
6208                     ; 1027 			bBUFF_READ_L=1;
6210  0aed 72100008      	bset	_bBUFF_READ_L
6211  0af1               L3013:
6212                     ; 1030 		but_drv_cnt=0;
6214  0af1 3fb8          	clr	_but_drv_cnt
6215                     ; 1031 		but_on_drv_cnt=0;
6217  0af3 3fb9          	clr	_but_on_drv_cnt
6219  0af5 202f          	jra	L5013
6220  0af7               L3703:
6221                     ; 1034 	else if(!bSTART) {
6223                     	btst	_bSTART
6224  0afc 2528          	jrult	L5013
6225                     ; 1035 		TIM2->CCR3H= 0x00;	
6227  0afe 725f5315      	clr	21269
6228                     ; 1036 		TIM2->CCR3L= pwm_fade_in;
6230  0b02 5500ba5316    	mov	21270,_pwm_fade_in
6231                     ; 1040 		if(((GPIOC->IDR)&(1<<4))) {
6233  0b07 c6500b        	ld	a,20491
6234  0b0a a510          	bcp	a,#16
6235  0b0c 2702          	jreq	L1113
6236                     ; 1041 			but_on_drv_cnt++;
6238  0b0e 3cb9          	inc	_but_on_drv_cnt
6239  0b10               L1113:
6240                     ; 1044 		but_drv_cnt++;
6242  0b10 3cb8          	inc	_but_drv_cnt
6243                     ; 1045 		if(but_drv_cnt>20) {
6245  0b12 b6b8          	ld	a,_but_drv_cnt
6246  0b14 a115          	cp	a,#21
6247  0b16 250e          	jrult	L5013
6248                     ; 1046 			but_drv_cnt=0;
6250  0b18 3fb8          	clr	_but_drv_cnt
6251                     ; 1047 			if(but_on_drv_cnt>12) {
6253  0b1a b6b9          	ld	a,_but_on_drv_cnt
6254  0b1c a10d          	cp	a,#13
6255  0b1e 2506          	jrult	L5013
6256                     ; 1048 				bSTART=1;
6258  0b20 7210000b      	bset	_bSTART
6259                     ; 1049 				but_on_drv_cnt=0;
6261  0b24 3fb9          	clr	_but_on_drv_cnt
6262  0b26               L5013:
6263                     ; 1059 	if(++t0_cnt0>=125){
6265  0b26 3c00          	inc	_t0_cnt0
6266  0b28 b600          	ld	a,_t0_cnt0
6267  0b2a a17d          	cp	a,#125
6268  0b2c 2530          	jrult	L7113
6269                     ; 1060     		t0_cnt0=0;
6271  0b2e 3f00          	clr	_t0_cnt0
6272                     ; 1061     		b100Hz=1;
6274  0b30 72100007      	bset	_b100Hz
6275                     ; 1063 		if(++t0_cnt1>=10){
6277  0b34 3c01          	inc	_t0_cnt1
6278  0b36 b601          	ld	a,_t0_cnt1
6279  0b38 a10a          	cp	a,#10
6280  0b3a 2506          	jrult	L1213
6281                     ; 1064 			t0_cnt1=0;
6283  0b3c 3f01          	clr	_t0_cnt1
6284                     ; 1065 			b10Hz=1;
6286  0b3e 72100006      	bset	_b10Hz
6287  0b42               L1213:
6288                     ; 1068 		if(++t0_cnt2>=20){
6290  0b42 3c02          	inc	_t0_cnt2
6291  0b44 b602          	ld	a,_t0_cnt2
6292  0b46 a114          	cp	a,#20
6293  0b48 2506          	jrult	L3213
6294                     ; 1069 			t0_cnt2=0;
6296  0b4a 3f02          	clr	_t0_cnt2
6297                     ; 1070 			b5Hz=1;
6299  0b4c 72100005      	bset	_b5Hz
6300  0b50               L3213:
6301                     ; 1073 		if(++t0_cnt3>=100){
6303  0b50 3c03          	inc	_t0_cnt3
6304  0b52 b603          	ld	a,_t0_cnt3
6305  0b54 a164          	cp	a,#100
6306  0b56 2506          	jrult	L7113
6307                     ; 1074 			t0_cnt3=0;
6309  0b58 3f03          	clr	_t0_cnt3
6310                     ; 1075 			b1Hz=1;
6312  0b5a 72100004      	bset	_b1Hz
6313  0b5e               L7113:
6314                     ; 1079 	TIM4->SR1&=~TIM4_SR1_UIF;			// disable break interrupt
6316  0b5e 72115344      	bres	21316,#0
6317                     ; 1080 	return;
6320  0b62 80            	iret
6346                     ; 1084 @far @interrupt void UARTTxInterrupt (void) {
6347                     	switch	.text
6348  0b63               f_UARTTxInterrupt:
6352                     ; 1086 	if (tx_counter){
6354  0b63 3d1e          	tnz	_tx_counter
6355  0b65 271a          	jreq	L7313
6356                     ; 1087 		--tx_counter;
6358  0b67 3a1e          	dec	_tx_counter
6359                     ; 1088 		UART1->DR=tx_buffer[tx_rd_index];
6361  0b69 5f            	clrw	x
6362  0b6a b61c          	ld	a,_tx_rd_index
6363  0b6c 2a01          	jrpl	L441
6364  0b6e 53            	cplw	x
6365  0b6f               L441:
6366  0b6f 97            	ld	xl,a
6367  0b70 e604          	ld	a,(_tx_buffer,x)
6368  0b72 c75231        	ld	21041,a
6369                     ; 1089 		if (++tx_rd_index == TX_BUFFER_SIZE) tx_rd_index=0;
6371  0b75 3c1c          	inc	_tx_rd_index
6372  0b77 b61c          	ld	a,_tx_rd_index
6373  0b79 a150          	cp	a,#80
6374  0b7b 260c          	jrne	L3413
6377  0b7d 3f1c          	clr	_tx_rd_index
6378  0b7f 2008          	jra	L3413
6379  0b81               L7313:
6380                     ; 1092 		bOUT_FREE=1;
6382  0b81 72100002      	bset	_bOUT_FREE
6383                     ; 1093 		UART1->CR2&= ~UART1_CR2_TIEN;
6385  0b85 721f5235      	bres	21045,#7
6386  0b89               L3413:
6387                     ; 1095 }
6390  0b89 80            	iret
6419                     ; 1098 @far @interrupt void UARTRxInterrupt (void) {
6420                     	switch	.text
6421  0b8a               f_UARTRxInterrupt:
6425                     ; 1103 	rx_status=UART1->SR;
6427  0b8a 5552300004    	mov	_rx_status,21040
6428                     ; 1104 	rx_data=UART1->DR;
6430  0b8f 5552310003    	mov	_rx_data,21041
6431                     ; 1106 	if (rx_status & (UART1_SR_RXNE)){
6433  0b94 b604          	ld	a,_rx_status
6434  0b96 a520          	bcp	a,#32
6435  0b98 272c          	jreq	L5513
6436                     ; 1107 		rx_buffer[rx_wr_index]=rx_data;
6438  0b9a be18          	ldw	x,_rx_wr_index
6439  0b9c b603          	ld	a,_rx_data
6440  0b9e e754          	ld	(_rx_buffer,x),a
6441                     ; 1108 		bRXIN=1;
6443  0ba0 72100001      	bset	_bRXIN
6444                     ; 1109 		if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
6446  0ba4 be18          	ldw	x,_rx_wr_index
6447  0ba6 1c0001        	addw	x,#1
6448  0ba9 bf18          	ldw	_rx_wr_index,x
6449  0bab a30064        	cpw	x,#100
6450  0bae 2603          	jrne	L7513
6453  0bb0 5f            	clrw	x
6454  0bb1 bf18          	ldw	_rx_wr_index,x
6455  0bb3               L7513:
6456                     ; 1110 		if (++rx_counter == RX_BUFFER_SIZE){
6458  0bb3 be1a          	ldw	x,_rx_counter
6459  0bb5 1c0001        	addw	x,#1
6460  0bb8 bf1a          	ldw	_rx_counter,x
6461  0bba a30064        	cpw	x,#100
6462  0bbd 2607          	jrne	L5513
6463                     ; 1111 			rx_counter=0;
6465  0bbf 5f            	clrw	x
6466  0bc0 bf1a          	ldw	_rx_counter,x
6467                     ; 1112 			rx_buffer_overflow=1;
6469  0bc2 72100000      	bset	_rx_buffer_overflow
6470  0bc6               L5513:
6471                     ; 1115 }
6474  0bc6 80            	iret
6527                     ; 1121 main(){
6529                     	switch	.text
6530  0bc7               _main:
6534                     ; 1122 	CLK->CKDIVR=0;
6536  0bc7 725f50c6      	clr	20678
6537                     ; 1124 	rele_cnt_index=0;
6539  0bcb 3fbb          	clr	_rele_cnt_index
6540                     ; 1125 	GPIOD->DDR&=~(1<<6);
6542  0bcd 721d5011      	bres	20497,#6
6543                     ; 1126 	GPIOD->CR1|=(1<<6);
6545  0bd1 721c5012      	bset	20498,#6
6546                     ; 1127 	GPIOD->CR2|=(1<<6);
6548  0bd5 721c5013      	bset	20499,#6
6549                     ; 1129 	GPIOD->DDR|=(1<<5);
6551  0bd9 721a5011      	bset	20497,#5
6552                     ; 1130 	GPIOD->CR1|=(1<<5);
6554  0bdd 721a5012      	bset	20498,#5
6555                     ; 1131 	GPIOD->CR2|=(1<<5);	
6557  0be1 721a5013      	bset	20499,#5
6558                     ; 1132 	GPIOD->ODR|=(1<<5);
6560  0be5 721a500f      	bset	20495,#5
6561                     ; 1134 	delay_ms(10);
6563  0be9 ae000a        	ldw	x,#10
6564  0bec cd0060        	call	_delay_ms
6566                     ; 1136 	if(!(GPIOD->IDR&=(1<<6))) {
6568  0bef c65010        	ld	a,20496
6569  0bf2 a440          	and	a,#64
6570  0bf4 c75010        	ld	20496,a
6571  0bf7 2606          	jrne	L3713
6572                     ; 1137 		rele_cnt_index=1;
6574  0bf9 350100bb      	mov	_rele_cnt_index,#1
6576  0bfd 2018          	jra	L5713
6577  0bff               L3713:
6578                     ; 1140 		GPIOD->ODR&=~(1<<5);
6580  0bff 721b500f      	bres	20495,#5
6581                     ; 1141 		delay_ms(10);
6583  0c03 ae000a        	ldw	x,#10
6584  0c06 cd0060        	call	_delay_ms
6586                     ; 1142 		if(!(GPIOD->IDR&=(1<<6))) {
6588  0c09 c65010        	ld	a,20496
6589  0c0c a440          	and	a,#64
6590  0c0e c75010        	ld	20496,a
6591  0c11 2604          	jrne	L5713
6592                     ; 1143 			rele_cnt_index=2;
6594  0c13 350200bb      	mov	_rele_cnt_index,#2
6595  0c17               L5713:
6596                     ; 1148 	gpio_init();
6598  0c17 cd0960        	call	_gpio_init
6600                     ; 1149 	delay_ms(100);
6602  0c1a ae0064        	ldw	x,#100
6603  0c1d cd0060        	call	_delay_ms
6605                     ; 1150 	delay_ms(100);
6607  0c20 ae0064        	ldw	x,#100
6608  0c23 cd0060        	call	_delay_ms
6610                     ; 1151 	delay_ms(100);
6612  0c26 ae0064        	ldw	x,#100
6613  0c29 cd0060        	call	_delay_ms
6615                     ; 1154 	t4_init();
6617  0c2c cd0039        	call	_t4_init
6619                     ; 1156 	t2_init();
6621  0c2f cd0000        	call	_t2_init
6623                     ; 1157 	spi_init();
6625  0c32 cd06c1        	call	_spi_init
6627                     ; 1159 	FLASH_DUKR=0xae;
6629  0c35 35ae5064      	mov	_FLASH_DUKR,#174
6630                     ; 1160 	FLASH_DUKR=0x56;
6632  0c39 35565064      	mov	_FLASH_DUKR,#86
6633                     ; 1165 	dumm[1]++;
6635  0c3d 725c017d      	inc	_dumm+1
6636                     ; 1167 	uart_init();
6638  0c41 cd00a2        	call	_uart_init
6640                     ; 1169 	enableInterrupts();	
6643  0c44 9a            rim
6645  0c45               L1023:
6646                     ; 1173 		if(bBUFF_LOAD) {
6648                     	btst	_bBUFF_LOAD
6649  0c4a 241f          	jruge	L5023
6650                     ; 1174 			bBUFF_LOAD=0;
6652  0c4c 7211000a      	bres	_bBUFF_LOAD
6653                     ; 1176 			if(current_page<last_page) {
6655  0c50 be0d          	ldw	x,_current_page
6656  0c52 b30b          	cpw	x,_last_page
6657  0c54 2409          	jruge	L7023
6658                     ; 1177 				current_page++;
6660  0c56 be0d          	ldw	x,_current_page
6661  0c58 1c0001        	addw	x,#1
6662  0c5b bf0d          	ldw	_current_page,x
6664  0c5d 2007          	jra	L1123
6665  0c5f               L7023:
6666                     ; 1181 				current_page=0;
6668  0c5f 5f            	clrw	x
6669  0c60 bf0d          	ldw	_current_page,x
6670                     ; 1182 				play=0;
6672  0c62 72110003      	bres	_play
6673  0c66               L1123:
6674                     ; 1185 			DF_page_to_buffer(/*///current_buffer_H*//*1,*/current_page);
6676  0c66 be0d          	ldw	x,_current_page
6677  0c68 cd0895        	call	_DF_page_to_buffer
6679  0c6b               L5023:
6680                     ; 1189 		if(bBUFF_READ_L) {
6682                     	btst	_bBUFF_READ_L
6683  0c70 2412          	jruge	L3123
6684                     ; 1190 			bBUFF_READ_L=0;
6686  0c72 72110008      	bres	_bBUFF_READ_L
6687                     ; 1192 			DF_buffer_read(/*///current_buffer_L*//*1,*/0,128,buff);
6689  0c76 ae0050        	ldw	x,#_buff
6690  0c79 89            	pushw	x
6691  0c7a ae0080        	ldw	x,#128
6692  0c7d 89            	pushw	x
6693  0c7e 5f            	clrw	x
6694  0c7f cd08db        	call	_DF_buffer_read
6696  0c82 5b04          	addw	sp,#4
6697  0c84               L3123:
6698                     ; 1199 		if(bBUFF_READ_H) {
6700                     	btst	_bBUFF_READ_H
6701  0c89 2414          	jruge	L5123
6702                     ; 1200 			bBUFF_READ_H=0;
6704  0c8b 72110009      	bres	_bBUFF_READ_H
6705                     ; 1202 			DF_buffer_read(/*///current_buffer_L*//*1,*/128,128,&buff[128]);
6707  0c8f ae00d0        	ldw	x,#_buff+128
6708  0c92 89            	pushw	x
6709  0c93 ae0080        	ldw	x,#128
6710  0c96 89            	pushw	x
6711  0c97 ae0080        	ldw	x,#128
6712  0c9a cd08db        	call	_DF_buffer_read
6714  0c9d 5b04          	addw	sp,#4
6715  0c9f               L5123:
6716                     ; 1209 		if(bRXIN)	{
6718                     	btst	_bRXIN
6719  0ca4 2407          	jruge	L7123
6720                     ; 1210 			bRXIN=0;
6722  0ca6 72110001      	bres	_bRXIN
6723                     ; 1212 			uart_in();
6725  0caa cd0989        	call	_uart_in
6727  0cad               L7123:
6728                     ; 1216 		if(b100Hz){
6730                     	btst	_b100Hz
6731  0cb2 2476          	jruge	L1223
6732                     ; 1217 			b100Hz=0;
6734  0cb4 72110007      	bres	_b100Hz
6735                     ; 1219 			if(bSTART==1) {
6737                     	btst	_bSTART
6738  0cbd 245f          	jruge	L3223
6739                     ; 1220 				if(play) {
6741                     	btst	_play
6742  0cc4 240a          	jruge	L5223
6743                     ; 1221 					play=0;
6745  0cc6 72110003      	bres	_play
6746                     ; 1222 					bSTART=0;
6748  0cca 7211000b      	bres	_bSTART
6750  0cce 204e          	jra	L3223
6751  0cd0               L5223:
6752                     ; 1225 					current_page=1;
6754  0cd0 ae0001        	ldw	x,#1
6755  0cd3 bf0d          	ldw	_current_page,x
6756                     ; 1226 					last_page=EE_PAGE_LEN-1;
6758  0cd5 ce0000        	ldw	x,_EE_PAGE_LEN
6759  0cd8 5a            	decw	x
6760  0cd9 bf0b          	ldw	_last_page,x
6761                     ; 1229 					DF_page_to_buffer(/*///current_buffer_H*//*1,*/current_page);
6763  0cdb ae0001        	ldw	x,#1
6764  0cde cd0895        	call	_DF_page_to_buffer
6766                     ; 1230 					delay_ms(10);
6768  0ce1 ae000a        	ldw	x,#10
6769  0ce4 cd0060        	call	_delay_ms
6771                     ; 1231 					DF_buffer_read(/*///current_buffer_L*//*1,*/0,128,buff);
6773  0ce7 ae0050        	ldw	x,#_buff
6774  0cea 89            	pushw	x
6775  0ceb ae0080        	ldw	x,#128
6776  0cee 89            	pushw	x
6777  0cef 5f            	clrw	x
6778  0cf0 cd08db        	call	_DF_buffer_read
6780  0cf3 5b04          	addw	sp,#4
6781                     ; 1232 					delay_ms(10);
6783  0cf5 ae000a        	ldw	x,#10
6784  0cf8 cd0060        	call	_delay_ms
6786                     ; 1233 					DF_buffer_read(/*///current_buffer_L*//*1,*/128,128,&buff[128]);         
6788  0cfb ae00d0        	ldw	x,#_buff+128
6789  0cfe 89            	pushw	x
6790  0cff ae0080        	ldw	x,#128
6791  0d02 89            	pushw	x
6792  0d03 ae0080        	ldw	x,#128
6793  0d06 cd08db        	call	_DF_buffer_read
6795  0d09 5b04          	addw	sp,#4
6796                     ; 1238 					play=1;
6798  0d0b 72100003      	bset	_play
6799                     ; 1239 					bSTART=0;
6801  0d0f 7211000b      	bres	_bSTART
6802                     ; 1241 					rele_cnt=rele_cnt_const[rele_cnt_index];
6804  0d13 b6bb          	ld	a,_rele_cnt_index
6805  0d15 5f            	clrw	x
6806  0d16 97            	ld	xl,a
6807  0d17 d60000        	ld	a,(_rele_cnt_const,x)
6808  0d1a 5f            	clrw	x
6809  0d1b 97            	ld	xl,a
6810  0d1c bf01          	ldw	_rele_cnt,x
6811  0d1e               L3223:
6812                     ; 1245 			pwm_fade_in++;
6814  0d1e 3cba          	inc	_pwm_fade_in
6815                     ; 1246 			if(pwm_fade_in>128)pwm_fade_in=128;
6817  0d20 b6ba          	ld	a,_pwm_fade_in
6818  0d22 a181          	cp	a,#129
6819  0d24 2504          	jrult	L1223
6822  0d26 358000ba      	mov	_pwm_fade_in,#128
6823  0d2a               L1223:
6824                     ; 1249 		if(b10Hz){
6826                     	btst	_b10Hz
6827  0d2f 2407          	jruge	L3323
6828                     ; 1250 			b10Hz=0;
6830  0d31 72110006      	bres	_b10Hz
6831                     ; 1252 			rele_drv();
6833  0d35 cd004a        	call	_rele_drv
6835  0d38               L3323:
6836                     ; 1255 		if(b5Hz){
6838                     	btst	_b5Hz
6839  0d3d 2404          	jruge	L5323
6840                     ; 1256 			b5Hz=0;
6842  0d3f 72110005      	bres	_b5Hz
6843  0d43               L5323:
6844                     ; 1261 		if(b1Hz){
6846                     	btst	_b1Hz
6847  0d48 2503          	jrult	L251
6848  0d4a cc0c45        	jp	L1023
6849  0d4d               L251:
6850                     ; 1263 			b1Hz=0;
6852  0d4d 72110004      	bres	_b1Hz
6853  0d51 ac450c45      	jpf	L1023
7320                     	xdef	_main
7321                     .eeprom:	section	.data
7322  0000               _EE_PAGE_LEN:
7323  0000 0000          	ds.b	2
7324                     	xdef	_EE_PAGE_LEN
7325                     	switch	.bss
7326  0000               _UIB:
7327  0000 000000000000  	ds.b	80
7328                     	xdef	_UIB
7329  0050               _buff:
7330  0050 000000000000  	ds.b	300
7331                     	xdef	_buff
7332  017c               _dumm:
7333  017c 000000000000  	ds.b	100
7334                     	xdef	_dumm
7335                     .bit:	section	.data,bit
7336  0000               _rx_buffer_overflow:
7337  0000 00            	ds.b	1
7338                     	xdef	_rx_buffer_overflow
7339  0001               _bRXIN:
7340  0001 00            	ds.b	1
7341                     	xdef	_bRXIN
7342  0002               _bOUT_FREE:
7343  0002 00            	ds.b	1
7344                     	xdef	_bOUT_FREE
7345  0003               _play:
7346  0003 00            	ds.b	1
7347                     	xdef	_play
7348  0004               _b1Hz:
7349  0004 00            	ds.b	1
7350                     	xdef	_b1Hz
7351  0005               _b5Hz:
7352  0005 00            	ds.b	1
7353                     	xdef	_b5Hz
7354  0006               _b10Hz:
7355  0006 00            	ds.b	1
7356                     	xdef	_b10Hz
7357  0007               _b100Hz:
7358  0007 00            	ds.b	1
7359                     	xdef	_b100Hz
7360  0008               _bBUFF_READ_L:
7361  0008 00            	ds.b	1
7362                     	xdef	_bBUFF_READ_L
7363  0009               _bBUFF_READ_H:
7364  0009 00            	ds.b	1
7365                     	xdef	_bBUFF_READ_H
7366  000a               _bBUFF_LOAD:
7367  000a 00            	ds.b	1
7368                     	xdef	_bBUFF_LOAD
7369  000b               _bSTART:
7370  000b 00            	ds.b	1
7371                     	xdef	_bSTART
7372                     	xdef	_rele_cnt_const
7373                     	xdef	_rele_cnt_index
7374                     	xdef	_pwm_fade_in
7375                     	switch	.ubsct
7376  0000               _rx_offset:
7377  0000 00            	ds.b	1
7378                     	xdef	_rx_offset
7379  0001               _rele_cnt:
7380  0001 0000          	ds.b	2
7381                     	xdef	_rele_cnt
7382  0003               _rx_data:
7383  0003 00            	ds.b	1
7384                     	xdef	_rx_data
7385  0004               _rx_status:
7386  0004 00            	ds.b	1
7387                     	xdef	_rx_status
7388  0005               _file_lengt:
7389  0005 00000000      	ds.b	4
7390                     	xdef	_file_lengt
7391  0009               _current_byte_in_buffer:
7392  0009 0000          	ds.b	2
7393                     	xdef	_current_byte_in_buffer
7394  000b               _last_page:
7395  000b 0000          	ds.b	2
7396                     	xdef	_last_page
7397  000d               _current_page:
7398  000d 0000          	ds.b	2
7399                     	xdef	_current_page
7400  000f               _file_lengt_in_pages:
7401  000f 0000          	ds.b	2
7402                     	xdef	_file_lengt_in_pages
7403  0011               _mdr3:
7404  0011 00            	ds.b	1
7405                     	xdef	_mdr3
7406  0012               _mdr2:
7407  0012 00            	ds.b	1
7408                     	xdef	_mdr2
7409  0013               _mdr1:
7410  0013 00            	ds.b	1
7411                     	xdef	_mdr1
7412  0014               _mdr0:
7413  0014 00            	ds.b	1
7414                     	xdef	_mdr0
7415                     	xdef	_but_on_drv_cnt
7416                     	xdef	_but_drv_cnt
7417  0015               _sample:
7418  0015 00            	ds.b	1
7419                     	xdef	_sample
7420  0016               _rx_rd_index:
7421  0016 0000          	ds.b	2
7422                     	xdef	_rx_rd_index
7423  0018               _rx_wr_index:
7424  0018 0000          	ds.b	2
7425                     	xdef	_rx_wr_index
7426  001a               _rx_counter:
7427  001a 0000          	ds.b	2
7428                     	xdef	_rx_counter
7429                     	xdef	_rx_buffer
7430  001c               _tx_rd_index:
7431  001c 00            	ds.b	1
7432                     	xdef	_tx_rd_index
7433  001d               _tx_wr_index:
7434  001d 00            	ds.b	1
7435                     	xdef	_tx_wr_index
7436  001e               _tx_counter:
7437  001e 00            	ds.b	1
7438                     	xdef	_tx_counter
7439                     	xdef	_tx_buffer
7440  001f               _sample_cnt:
7441  001f 0000          	ds.b	2
7442                     	xdef	_sample_cnt
7443                     	xdef	_t0_cnt3
7444                     	xdef	_t0_cnt2
7445                     	xdef	_t0_cnt1
7446                     	xdef	_t0_cnt0
7447                     	xdef	_ST_READ
7448                     	xdef	_ST_WRITE
7449                     	xdef	_ST_WREN
7450                     	xdef	_ST_status_read
7451                     	xdef	_ST_RDID_read
7452                     	xdef	_uart_in_an
7453                     	xdef	_control_check
7454                     	xdef	_index_offset
7455                     	xdef	_uart_in
7456                     	xdef	_gpio_init
7457                     	xdef	_spi_init
7458                     	xdef	_spi
7459                     	xdef	_DF_buffer_to_page_er
7460                     	xdef	_DF_page_to_buffer
7461                     	xdef	_DF_buffer_write
7462                     	xdef	_DF_buffer_read
7463                     	xdef	_DF_status_read
7464                     	xdef	_DF_memo_to_256
7465                     	xdef	_DF_mf_dev_read
7466                     	xdef	_uart_init
7467                     	xdef	f_UARTRxInterrupt
7468                     	xdef	f_UARTTxInterrupt
7469                     	xdef	_putchar
7470                     	xdef	_uart_out_adr_block
7471                     	xdef	_uart_out
7472                     	xdef	f_TIM4_UPD_Interrupt
7473                     	xdef	_delay_ms
7474                     	xdef	_rele_drv
7475                     	xdef	_t4_init
7476                     	xdef	_t2_init
7477                     	xref.b	c_lreg
7478                     	xref.b	c_x
7479                     	xref.b	c_y
7499                     	xref	c_itolx
7500                     	xref	c_eewrw
7501                     	xref	c_lglsh
7502                     	xref	c_lgursh
7503                     	xref	c_lcmp
7504                     	xref	c_ltor
7505                     	xref	c_lgadc
7506                     	xref	c_rtol
7507                     	xref	c_vmul
7508                     	end
