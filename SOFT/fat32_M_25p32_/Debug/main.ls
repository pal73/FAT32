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
2232                     ; 57 void t2_init(void){
2233                     	switch	.text
2234  0000               f_t2_init:
2238                     ; 58 	TIM2->PSCR = 0;
2240  0000 725f530e      	clr	21262
2241                     ; 59 	TIM2->ARRH= 0x00;
2243  0004 725f530f      	clr	21263
2244                     ; 60 	TIM2->ARRL= 0xff;
2246  0008 35ff5310      	mov	21264,#255
2247                     ; 61 	TIM2->CCR1H= 0x00;	
2249  000c 725f5311      	clr	21265
2250                     ; 62 	TIM2->CCR1L= 200;
2252  0010 35c85312      	mov	21266,#200
2253                     ; 63 	TIM2->CCR2H= 0x00;	
2255  0014 725f5313      	clr	21267
2256                     ; 64 	TIM2->CCR2L= 200;
2258  0018 35c85314      	mov	21268,#200
2259                     ; 65 	TIM2->CCR3H= 0x00;	
2261  001c 725f5315      	clr	21269
2262                     ; 66 	TIM2->CCR3L= 50;
2264  0020 35325316      	mov	21270,#50
2265                     ; 69 	TIM2->CCMR2= ((6<<4) & TIM2_CCMR_OCM) | TIM2_CCMR_OCxPE; //OC2 toggle mode, prelouded
2267  0024 35685308      	mov	21256,#104
2268                     ; 70 	TIM2->CCMR3= ((6<<4) & TIM2_CCMR_OCM) | TIM2_CCMR_OCxPE; //OC2 toggle mode, prelouded
2270  0028 35685309      	mov	21257,#104
2271                     ; 71 	TIM2->CCER1= /*TIM2_CCER1_CC1E | TIM2_CCER1_CC1P |*/ TIM2_CCER1_CC2E | TIM2_CCER1_CC2P; //OC1, OC2 output pins enabled
2273  002c 3530530a      	mov	21258,#48
2274                     ; 73 	TIM2->CCER2= TIM2_CCER2_CC3E /*| TIM2_CCER2_CC3P*/; //OC1, OC2 output pins enabled
2276  0030 3501530b      	mov	21259,#1
2277                     ; 75 	TIM2->CR1=(TIM2_CR1_CEN | TIM2_CR1_ARPE);	
2279  0034 35815300      	mov	21248,#129
2280                     ; 77 }
2283  0038 87            	retf
2305                     ; 80 void t4_init(void){
2306                     	switch	.text
2307  0039               f_t4_init:
2311                     ; 81 	TIM4->PSCR = 3;
2313  0039 35035347      	mov	21319,#3
2314                     ; 82 	TIM4->ARR= 158;
2316  003d 359e5348      	mov	21320,#158
2317                     ; 83 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
2319  0041 72105343      	bset	21315,#0
2320                     ; 85 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
2322  0045 35855340      	mov	21312,#133
2323                     ; 87 }
2326  0049 87            	retf
2349                     ; 90 void rele_drv(void) {
2350                     	switch	.text
2351  004a               f_rele_drv:
2355                     ; 93 	if(rele_cnt) {
2357  004a be03          	ldw	x,_rele_cnt
2358  004c 270d          	jreq	L1641
2359                     ; 94 		rele_cnt--;
2361  004e be03          	ldw	x,_rele_cnt
2362  0050 1d0001        	subw	x,#1
2363  0053 bf03          	ldw	_rele_cnt,x
2364                     ; 95 		GPIOD->ODR|=(1<<4);
2366  0055 7218500f      	bset	20495,#4
2368  0059 2004          	jra	L3641
2369  005b               L1641:
2370                     ; 97 	else GPIOD->ODR&=~(1<<4); 
2372  005b 7219500f      	bres	20495,#4
2373  005f               L3641:
2374                     ; 112 }
2377  005f 87            	retf
2437                     ; 115 long delay_ms(short in)
2437                     ; 116 {
2438                     	switch	.text
2439  0060               f_delay_ms:
2441  0060 520c          	subw	sp,#12
2442       0000000c      OFST:	set	12
2445                     ; 119 i=((long)in)*100UL;
2447  0062 90ae0064      	ldw	y,#100
2448  0066 8d000000      	callf	d_vmul
2450  006a 96            	ldw	x,sp
2451  006b 1c0005        	addw	x,#OFST-7
2452  006e 8d000000      	callf	d_rtol
2454                     ; 121 for(ii=0;ii<i;ii++)
2456  0072 ae0000        	ldw	x,#0
2457  0075 1f0b          	ldw	(OFST-1,sp),x
2458  0077 ae0000        	ldw	x,#0
2459  007a 1f09          	ldw	(OFST-3,sp),x
2461  007c 2014          	jra	L3251
2462  007e               L7151:
2463                     ; 123 		iii++;
2465  007e 96            	ldw	x,sp
2466  007f 1c0001        	addw	x,#OFST-11
2467  0082 a601          	ld	a,#1
2468  0084 8d000000      	callf	d_lgadc
2470                     ; 121 for(ii=0;ii<i;ii++)
2472  0088 96            	ldw	x,sp
2473  0089 1c0009        	addw	x,#OFST-3
2474  008c a601          	ld	a,#1
2475  008e 8d000000      	callf	d_lgadc
2477  0092               L3251:
2480  0092 9c            	rvf
2481  0093 96            	ldw	x,sp
2482  0094 1c0009        	addw	x,#OFST-3
2483  0097 8d000000      	callf	d_ltor
2485  009b 96            	ldw	x,sp
2486  009c 1c0005        	addw	x,#OFST-7
2487  009f 8d000000      	callf	d_lcmp
2489  00a3 2fd9          	jrslt	L7151
2490                     ; 126 }
2493  00a5 5b0c          	addw	sp,#12
2494  00a7 87            	retf
2516                     ; 129 void uart_init (void){
2517                     	switch	.text
2518  00a8               f_uart_init:
2522                     ; 130 	GPIOD->DDR|=(1<<5);
2524  00a8 721a5011      	bset	20497,#5
2525                     ; 131 	GPIOD->CR1|=(1<<5);
2527  00ac 721a5012      	bset	20498,#5
2528                     ; 132 	GPIOD->CR2|=(1<<5);
2530  00b0 721a5013      	bset	20499,#5
2531                     ; 135 	GPIOD->DDR&=~(1<<6);
2533  00b4 721d5011      	bres	20497,#6
2534                     ; 136 	GPIOD->CR1&=~(1<<6);
2536  00b8 721d5012      	bres	20498,#6
2537                     ; 137 	GPIOD->CR2&=~(1<<6);
2539  00bc 721d5013      	bres	20499,#6
2540                     ; 140 	UART1->CR1&=~UART1_CR1_M;					
2542  00c0 72195234      	bres	21044,#4
2543                     ; 141 	UART1->CR3|= (0<<4) & UART1_CR3_STOP;	
2545  00c4 c65236        	ld	a,21046
2546                     ; 142 	UART1->BRR2= 0x01;//0x03;
2548  00c7 35015233      	mov	21043,#1
2549                     ; 143 	UART1->BRR1= 0x1a;//0x68;
2551  00cb 351a5232      	mov	21042,#26
2552                     ; 144 	UART1->CR2|= UART1_CR2_TEN | UART3_CR2_REN | UART3_CR2_RIEN;	
2554  00cf c65235        	ld	a,21045
2555  00d2 aa2c          	or	a,#44
2556  00d4 c75235        	ld	21045,a
2557                     ; 145 }
2560  00d7 87            	retf
2677                     ; 148 void uart_out (char num,char data0,char data1,char data2,char data3,char data4,char data5){
2678                     	switch	.text
2679  00d8               f_uart_out:
2681  00d8 89            	pushw	x
2682  00d9 520c          	subw	sp,#12
2683       0000000c      OFST:	set	12
2686                     ; 149 	char i=0,t=0,UOB[10];
2690  00db 0f01          	clr	(OFST-11,sp)
2691                     ; 152 	UOB[0]=data0;
2693  00dd 9f            	ld	a,xl
2694  00de 6b02          	ld	(OFST-10,sp),a
2695                     ; 153 	UOB[1]=data1;
2697  00e0 7b12          	ld	a,(OFST+6,sp)
2698  00e2 6b03          	ld	(OFST-9,sp),a
2699                     ; 154 	UOB[2]=data2;
2701  00e4 7b13          	ld	a,(OFST+7,sp)
2702  00e6 6b04          	ld	(OFST-8,sp),a
2703                     ; 155 	UOB[3]=data3;
2705  00e8 7b14          	ld	a,(OFST+8,sp)
2706  00ea 6b05          	ld	(OFST-7,sp),a
2707                     ; 156 	UOB[4]=data4;
2709  00ec 7b15          	ld	a,(OFST+9,sp)
2710  00ee 6b06          	ld	(OFST-6,sp),a
2711                     ; 157 	UOB[5]=data5;
2713  00f0 7b16          	ld	a,(OFST+10,sp)
2714  00f2 6b07          	ld	(OFST-5,sp),a
2715                     ; 158 	for (i=0;i<num;i++)
2717  00f4 0f0c          	clr	(OFST+0,sp)
2719  00f6 2013          	jra	L5261
2720  00f8               L1261:
2721                     ; 160 		t^=UOB[i];
2723  00f8 96            	ldw	x,sp
2724  00f9 1c0002        	addw	x,#OFST-10
2725  00fc 9f            	ld	a,xl
2726  00fd 5e            	swapw	x
2727  00fe 1b0c          	add	a,(OFST+0,sp)
2728  0100 2401          	jrnc	L02
2729  0102 5c            	incw	x
2730  0103               L02:
2731  0103 02            	rlwa	x,a
2732  0104 7b01          	ld	a,(OFST-11,sp)
2733  0106 f8            	xor	a,	(x)
2734  0107 6b01          	ld	(OFST-11,sp),a
2735                     ; 158 	for (i=0;i<num;i++)
2737  0109 0c0c          	inc	(OFST+0,sp)
2738  010b               L5261:
2741  010b 7b0c          	ld	a,(OFST+0,sp)
2742  010d 110d          	cp	a,(OFST+1,sp)
2743  010f 25e7          	jrult	L1261
2744                     ; 162 	UOB[num]=num;
2746  0111 96            	ldw	x,sp
2747  0112 1c0002        	addw	x,#OFST-10
2748  0115 9f            	ld	a,xl
2749  0116 5e            	swapw	x
2750  0117 1b0d          	add	a,(OFST+1,sp)
2751  0119 2401          	jrnc	L22
2752  011b 5c            	incw	x
2753  011c               L22:
2754  011c 02            	rlwa	x,a
2755  011d 7b0d          	ld	a,(OFST+1,sp)
2756  011f f7            	ld	(x),a
2757                     ; 163 	t^=UOB[num];
2759  0120 96            	ldw	x,sp
2760  0121 1c0002        	addw	x,#OFST-10
2761  0124 9f            	ld	a,xl
2762  0125 5e            	swapw	x
2763  0126 1b0d          	add	a,(OFST+1,sp)
2764  0128 2401          	jrnc	L42
2765  012a 5c            	incw	x
2766  012b               L42:
2767  012b 02            	rlwa	x,a
2768  012c 7b01          	ld	a,(OFST-11,sp)
2769  012e f8            	xor	a,	(x)
2770  012f 6b01          	ld	(OFST-11,sp),a
2771                     ; 164 	UOB[num+1]=t;
2773  0131 96            	ldw	x,sp
2774  0132 1c0003        	addw	x,#OFST-9
2775  0135 9f            	ld	a,xl
2776  0136 5e            	swapw	x
2777  0137 1b0d          	add	a,(OFST+1,sp)
2778  0139 2401          	jrnc	L62
2779  013b 5c            	incw	x
2780  013c               L62:
2781  013c 02            	rlwa	x,a
2782  013d 7b01          	ld	a,(OFST-11,sp)
2783  013f f7            	ld	(x),a
2784                     ; 165 	UOB[num+2]=END;
2786  0140 96            	ldw	x,sp
2787  0141 1c0004        	addw	x,#OFST-8
2788  0144 9f            	ld	a,xl
2789  0145 5e            	swapw	x
2790  0146 1b0d          	add	a,(OFST+1,sp)
2791  0148 2401          	jrnc	L03
2792  014a 5c            	incw	x
2793  014b               L03:
2794  014b 02            	rlwa	x,a
2795  014c a60a          	ld	a,#10
2796  014e f7            	ld	(x),a
2797                     ; 169 	for (i=0;i<num+3;i++)
2799  014f 0f0c          	clr	(OFST+0,sp)
2801  0151 2013          	jra	L5361
2802  0153               L1361:
2803                     ; 171 		putchar(UOB[i]);
2805  0153 96            	ldw	x,sp
2806  0154 1c0002        	addw	x,#OFST-10
2807  0157 9f            	ld	a,xl
2808  0158 5e            	swapw	x
2809  0159 1b0c          	add	a,(OFST+0,sp)
2810  015b 2401          	jrnc	L23
2811  015d 5c            	incw	x
2812  015e               L23:
2813  015e 02            	rlwa	x,a
2814  015f f6            	ld	a,(x)
2815  0160 8dd708d7      	callf	f_putchar
2817                     ; 169 	for (i=0;i<num+3;i++)
2819  0164 0c0c          	inc	(OFST+0,sp)
2820  0166               L5361:
2823  0166 9c            	rvf
2824  0167 7b0c          	ld	a,(OFST+0,sp)
2825  0169 5f            	clrw	x
2826  016a 97            	ld	xl,a
2827  016b 7b0d          	ld	a,(OFST+1,sp)
2828  016d 905f          	clrw	y
2829  016f 9097          	ld	yl,a
2830  0171 72a90003      	addw	y,#3
2831  0175 bf00          	ldw	c_x,x
2832  0177 90b300        	cpw	y,c_x
2833  017a 2cd7          	jrsgt	L1361
2834                     ; 174 	bOUT_FREE=0;	  	
2836  017c 72110003      	bres	_bOUT_FREE
2837                     ; 175 }
2840  0180 5b0e          	addw	sp,#14
2841  0182 87            	retf
2922                     ; 178 void uart_out_adr_block (unsigned long adress,char *ptr, char len)
2922                     ; 179 {
2923                     	switch	.text
2924  0183               f_uart_out_adr_block:
2926  0183 5203          	subw	sp,#3
2927       00000003      OFST:	set	3
2930                     ; 183 t=0;
2932  0185 0f02          	clr	(OFST-1,sp)
2933                     ; 184 temp11=CMND;
2935                     ; 185 t^=temp11;
2937  0187 7b02          	ld	a,(OFST-1,sp)
2938  0189 a816          	xor	a,	#22
2939  018b 6b02          	ld	(OFST-1,sp),a
2940                     ; 186 putchar(temp11);
2942  018d a616          	ld	a,#22
2943  018f 8dd708d7      	callf	f_putchar
2945                     ; 188 temp11=10;
2947                     ; 189 t^=temp11;
2949  0193 7b02          	ld	a,(OFST-1,sp)
2950  0195 a80a          	xor	a,	#10
2951  0197 6b02          	ld	(OFST-1,sp),a
2952                     ; 190 putchar(temp11);
2954  0199 a60a          	ld	a,#10
2955  019b 8dd708d7      	callf	f_putchar
2957                     ; 192 temp11=adress%256;//(*((char*)&adress));
2959  019f 7b0a          	ld	a,(OFST+7,sp)
2960  01a1 a4ff          	and	a,#255
2961  01a3 6b03          	ld	(OFST+0,sp),a
2962                     ; 193 t^=temp11;
2964  01a5 7b02          	ld	a,(OFST-1,sp)
2965  01a7 1803          	xor	a,	(OFST+0,sp)
2966  01a9 6b02          	ld	(OFST-1,sp),a
2967                     ; 194 putchar(temp11);
2969  01ab 7b03          	ld	a,(OFST+0,sp)
2970  01ad 8dd708d7      	callf	f_putchar
2972                     ; 195 adress>>=8;
2974  01b1 96            	ldw	x,sp
2975  01b2 1c0007        	addw	x,#OFST+4
2976  01b5 a608          	ld	a,#8
2977  01b7 8d000000      	callf	d_lgursh
2979                     ; 196 temp11=adress%256;//(*(((char*)&adress)+1));
2981  01bb 7b0a          	ld	a,(OFST+7,sp)
2982  01bd a4ff          	and	a,#255
2983  01bf 6b03          	ld	(OFST+0,sp),a
2984                     ; 197 t^=temp11;
2986  01c1 7b02          	ld	a,(OFST-1,sp)
2987  01c3 1803          	xor	a,	(OFST+0,sp)
2988  01c5 6b02          	ld	(OFST-1,sp),a
2989                     ; 198 putchar(temp11);
2991  01c7 7b03          	ld	a,(OFST+0,sp)
2992  01c9 8dd708d7      	callf	f_putchar
2994                     ; 199 adress>>=8;
2996  01cd 96            	ldw	x,sp
2997  01ce 1c0007        	addw	x,#OFST+4
2998  01d1 a608          	ld	a,#8
2999  01d3 8d000000      	callf	d_lgursh
3001                     ; 200 temp11=adress%256;//(*(((char*)&adress)+2));
3003  01d7 7b0a          	ld	a,(OFST+7,sp)
3004  01d9 a4ff          	and	a,#255
3005  01db 6b03          	ld	(OFST+0,sp),a
3006                     ; 201 t^=temp11;
3008  01dd 7b02          	ld	a,(OFST-1,sp)
3009  01df 1803          	xor	a,	(OFST+0,sp)
3010  01e1 6b02          	ld	(OFST-1,sp),a
3011                     ; 202 putchar(temp11);
3013  01e3 7b03          	ld	a,(OFST+0,sp)
3014  01e5 8dd708d7      	callf	f_putchar
3016                     ; 203 adress>>=8;
3018  01e9 96            	ldw	x,sp
3019  01ea 1c0007        	addw	x,#OFST+4
3020  01ed a608          	ld	a,#8
3021  01ef 8d000000      	callf	d_lgursh
3023                     ; 204 temp11=adress%256;//(*(((char*)&adress)+3));
3025  01f3 7b0a          	ld	a,(OFST+7,sp)
3026  01f5 a4ff          	and	a,#255
3027  01f7 6b03          	ld	(OFST+0,sp),a
3028                     ; 205 t^=temp11;
3030  01f9 7b02          	ld	a,(OFST-1,sp)
3031  01fb 1803          	xor	a,	(OFST+0,sp)
3032  01fd 6b02          	ld	(OFST-1,sp),a
3033                     ; 206 putchar(temp11);
3035  01ff 7b03          	ld	a,(OFST+0,sp)
3036  0201 8dd708d7      	callf	f_putchar
3038                     ; 209 for(i11=0;i11<len;i11++)
3040  0205 0f01          	clr	(OFST-2,sp)
3042  0207 201c          	jra	L7071
3043  0209               L3071:
3044                     ; 211 	temp11=ptr[i11];
3046  0209 7b0b          	ld	a,(OFST+8,sp)
3047  020b 97            	ld	xl,a
3048  020c 7b0c          	ld	a,(OFST+9,sp)
3049  020e 1b01          	add	a,(OFST-2,sp)
3050  0210 2401          	jrnc	L63
3051  0212 5c            	incw	x
3052  0213               L63:
3053  0213 02            	rlwa	x,a
3054  0214 f6            	ld	a,(x)
3055  0215 6b03          	ld	(OFST+0,sp),a
3056                     ; 212 	t^=temp11;
3058  0217 7b02          	ld	a,(OFST-1,sp)
3059  0219 1803          	xor	a,	(OFST+0,sp)
3060  021b 6b02          	ld	(OFST-1,sp),a
3061                     ; 213 	putchar(temp11);
3063  021d 7b03          	ld	a,(OFST+0,sp)
3064  021f 8dd708d7      	callf	f_putchar
3066                     ; 209 for(i11=0;i11<len;i11++)
3068  0223 0c01          	inc	(OFST-2,sp)
3069  0225               L7071:
3072  0225 7b01          	ld	a,(OFST-2,sp)
3073  0227 110d          	cp	a,(OFST+10,sp)
3074  0229 25de          	jrult	L3071
3075                     ; 216 temp11=(len+6);
3077  022b 7b0d          	ld	a,(OFST+10,sp)
3078  022d ab06          	add	a,#6
3079  022f 6b03          	ld	(OFST+0,sp),a
3080                     ; 217 t^=temp11;
3082  0231 7b02          	ld	a,(OFST-1,sp)
3083  0233 1803          	xor	a,	(OFST+0,sp)
3084  0235 6b02          	ld	(OFST-1,sp),a
3085                     ; 218 putchar(temp11);
3087  0237 7b03          	ld	a,(OFST+0,sp)
3088  0239 8dd708d7      	callf	f_putchar
3090                     ; 220 putchar(t);
3092  023d 7b02          	ld	a,(OFST-1,sp)
3093  023f 8dd708d7      	callf	f_putchar
3095                     ; 222 putchar(0x0a);
3097  0243 a60a          	ld	a,#10
3098  0245 8dd708d7      	callf	f_putchar
3100                     ; 224 bOUT_FREE=0;	   
3102  0249 72110003      	bres	_bOUT_FREE
3103                     ; 225 }
3106  024d 5b03          	addw	sp,#3
3107  024f 87            	retf
3242                     ; 227 void uart_in_an(void) {
3243                     	switch	.text
3244  0250               f_uart_in_an:
3246  0250 5204          	subw	sp,#4
3247       00000004      OFST:	set	4
3250                     ; 230 	if(UIB[0]==CMND) {
3252  0252 c60000        	ld	a,_UIB
3253  0255 a116          	cp	a,#22
3254  0257 2704          	jreq	L24
3255  0259 acd408d4      	jpf	L1771
3256  025d               L24:
3257                     ; 231 		if(UIB[1]==1) {
3259  025d c60001        	ld	a,_UIB+1
3260  0260 a101          	cp	a,#1
3261  0262 2632          	jrne	L3771
3262                     ; 235 			if(memory_manufacturer=='A') {
3264  0264 b6bc          	ld	a,_memory_manufacturer
3265  0266 a141          	cp	a,#65
3266  0268 2604          	jrne	L5771
3267                     ; 236 				temp_L=DF_mf_dev_read();
3269  026a 8dab0aab      	callf	f_DF_mf_dev_read
3271  026e               L5771:
3272                     ; 238 			if(memory_manufacturer=='S') {
3274  026e b6bc          	ld	a,_memory_manufacturer
3275  0270 a153          	cp	a,#83
3276  0272 2604          	jrne	L7771
3277                     ; 239 				temp_L=ST_RDID_read();
3279  0274 8d980998      	callf	f_ST_RDID_read
3281  0278               L7771:
3282                     ; 241 			uart_out (6,CMND,1,mdr0/**((char*)&temp_L)*/,mdr1/**(((char*)&temp_L)+1)*/,mdr2/**(((char*)&temp_L)+2)*/,mdr3/**(((char*)&temp_L)+3)*/);
3284  0278 3b0013        	push	_mdr3
3285  027b 3b0014        	push	_mdr2
3286  027e 3b0015        	push	_mdr1
3287  0281 3b0016        	push	_mdr0
3288  0284 4b01          	push	#1
3289  0286 ae0016        	ldw	x,#22
3290  0289 a606          	ld	a,#6
3291  028b 95            	ld	xh,a
3292  028c 8dd800d8      	callf	f_uart_out
3294  0290 5b05          	addw	sp,#5
3296  0292 acd408d4      	jpf	L1771
3297  0296               L3771:
3298                     ; 249 	else if(UIB[1]==2) {
3300  0296 c60001        	ld	a,_UIB+1
3301  0299 a102          	cp	a,#2
3302  029b 2633          	jrne	L3002
3303                     ; 252 		if(memory_manufacturer=='A') {
3305  029d b6bc          	ld	a,_memory_manufacturer
3306  029f a141          	cp	a,#65
3307  02a1 2606          	jrne	L5002
3308                     ; 253 			temp=DF_status_read();
3310  02a3 8d090b09      	callf	f_DF_status_read
3312  02a7 6b04          	ld	(OFST+0,sp),a
3313  02a9               L5002:
3314                     ; 255 		if(memory_manufacturer=='S') {
3316  02a9 b6bc          	ld	a,_memory_manufacturer
3317  02ab a153          	cp	a,#83
3318  02ad 2606          	jrne	L7002
3319                     ; 256 			temp=ST_status_read();
3321  02af 8dcd09cd      	callf	f_ST_status_read
3323  02b3 6b04          	ld	(OFST+0,sp),a
3324  02b5               L7002:
3325                     ; 258 		uart_out (3,CMND,2,temp,0,0,0);    
3327  02b5 4b00          	push	#0
3328  02b7 4b00          	push	#0
3329  02b9 4b00          	push	#0
3330  02bb 7b07          	ld	a,(OFST+3,sp)
3331  02bd 88            	push	a
3332  02be 4b02          	push	#2
3333  02c0 ae0016        	ldw	x,#22
3334  02c3 a603          	ld	a,#3
3335  02c5 95            	ld	xh,a
3336  02c6 8dd800d8      	callf	f_uart_out
3338  02ca 5b05          	addw	sp,#5
3340  02cc acd408d4      	jpf	L1771
3341  02d0               L3002:
3342                     ; 262 	else if(UIB[1]==3)
3344  02d0 c60001        	ld	a,_UIB+1
3345  02d3 a103          	cp	a,#3
3346  02d5 2625          	jrne	L3102
3347                     ; 265 		if(memory_manufacturer=='A') {
3349  02d7 b6bc          	ld	a,_memory_manufacturer
3350  02d9 a141          	cp	a,#65
3351  02db 2604          	jrne	L5102
3352                     ; 266 			DF_memo_to_256();
3354  02dd 8de80ae8      	callf	f_DF_memo_to_256
3356  02e1               L5102:
3357                     ; 268 		uart_out (2,CMND,3,temp,0,0,0);    
3359  02e1 4b00          	push	#0
3360  02e3 4b00          	push	#0
3361  02e5 4b00          	push	#0
3362  02e7 7b07          	ld	a,(OFST+3,sp)
3363  02e9 88            	push	a
3364  02ea 4b03          	push	#3
3365  02ec ae0016        	ldw	x,#22
3366  02ef a602          	ld	a,#2
3367  02f1 95            	ld	xh,a
3368  02f2 8dd800d8      	callf	f_uart_out
3370  02f6 5b05          	addw	sp,#5
3372  02f8 acd408d4      	jpf	L1771
3373  02fc               L3102:
3374                     ; 271 	else if(UIB[1]==4)
3376  02fc c60001        	ld	a,_UIB+1
3377  02ff a104          	cp	a,#4
3378  0301 2625          	jrne	L1202
3379                     ; 274 		if(memory_manufacturer=='A') {
3381  0303 b6bc          	ld	a,_memory_manufacturer
3382  0305 a141          	cp	a,#65
3383  0307 2604          	jrne	L3202
3384                     ; 275 			DF_memo_to_256();
3386  0309 8de80ae8      	callf	f_DF_memo_to_256
3388  030d               L3202:
3389                     ; 277 		uart_out (2,CMND,3,temp,0,0,0);    
3391  030d 4b00          	push	#0
3392  030f 4b00          	push	#0
3393  0311 4b00          	push	#0
3394  0313 7b07          	ld	a,(OFST+3,sp)
3395  0315 88            	push	a
3396  0316 4b03          	push	#3
3397  0318 ae0016        	ldw	x,#22
3398  031b a602          	ld	a,#2
3399  031d 95            	ld	xh,a
3400  031e 8dd800d8      	callf	f_uart_out
3402  0322 5b05          	addw	sp,#5
3404  0324 acd408d4      	jpf	L1771
3405  0328               L1202:
3406                     ; 280 	else if(UIB[1]==10)
3408  0328 c60001        	ld	a,_UIB+1
3409  032b a10a          	cp	a,#10
3410  032d 2704acbf03bf  	jrne	L7202
3411                     ; 284 		if(memory_manufacturer=='A') {
3413  0333 b6bc          	ld	a,_memory_manufacturer
3414  0335 a141          	cp	a,#65
3415  0337 2616          	jrne	L1302
3416                     ; 285 			if(UIB[2]==1)DF_buffer_read(/*1,*/0,256, buff);
3418  0339 c60002        	ld	a,_UIB+2
3419  033c a101          	cp	a,#1
3420  033e 260f          	jrne	L1302
3423  0340 ae0050        	ldw	x,#_buff
3424  0343 89            	pushw	x
3425  0344 ae0100        	ldw	x,#256
3426  0347 89            	pushw	x
3427  0348 5f            	clrw	x
3428  0349 8d730b73      	callf	f_DF_buffer_read
3430  034d 5b04          	addw	sp,#4
3431  034f               L1302:
3432                     ; 290 		uart_out_adr_block (0,buff,64);
3434  034f 4b40          	push	#64
3435  0351 ae0050        	ldw	x,#_buff
3436  0354 89            	pushw	x
3437  0355 ae0000        	ldw	x,#0
3438  0358 89            	pushw	x
3439  0359 ae0000        	ldw	x,#0
3440  035c 89            	pushw	x
3441  035d 8d830183      	callf	f_uart_out_adr_block
3443  0361 5b07          	addw	sp,#7
3444                     ; 291 		delay_ms(100);    
3446  0363 ae0064        	ldw	x,#100
3447  0366 8d600060      	callf	f_delay_ms
3449                     ; 292 		uart_out_adr_block (64,&buff[64],64);
3451  036a 4b40          	push	#64
3452  036c ae0090        	ldw	x,#_buff+64
3453  036f 89            	pushw	x
3454  0370 ae0040        	ldw	x,#64
3455  0373 89            	pushw	x
3456  0374 ae0000        	ldw	x,#0
3457  0377 89            	pushw	x
3458  0378 8d830183      	callf	f_uart_out_adr_block
3460  037c 5b07          	addw	sp,#7
3461                     ; 293 		delay_ms(100);    
3463  037e ae0064        	ldw	x,#100
3464  0381 8d600060      	callf	f_delay_ms
3466                     ; 294 		uart_out_adr_block (128,&buff[128],64);
3468  0385 4b40          	push	#64
3469  0387 ae00d0        	ldw	x,#_buff+128
3470  038a 89            	pushw	x
3471  038b ae0080        	ldw	x,#128
3472  038e 89            	pushw	x
3473  038f ae0000        	ldw	x,#0
3474  0392 89            	pushw	x
3475  0393 8d830183      	callf	f_uart_out_adr_block
3477  0397 5b07          	addw	sp,#7
3478                     ; 295 		delay_ms(100);    
3480  0399 ae0064        	ldw	x,#100
3481  039c 8d600060      	callf	f_delay_ms
3483                     ; 296 		uart_out_adr_block (192,&buff[192],64);
3485  03a0 4b40          	push	#64
3486  03a2 ae0110        	ldw	x,#_buff+192
3487  03a5 89            	pushw	x
3488  03a6 ae00c0        	ldw	x,#192
3489  03a9 89            	pushw	x
3490  03aa ae0000        	ldw	x,#0
3491  03ad 89            	pushw	x
3492  03ae 8d830183      	callf	f_uart_out_adr_block
3494  03b2 5b07          	addw	sp,#7
3495                     ; 297 		delay_ms(100);    
3497  03b4 ae0064        	ldw	x,#100
3498  03b7 8d600060      	callf	f_delay_ms
3501  03bb acd408d4      	jpf	L1771
3502  03bf               L7202:
3503                     ; 300 	else if(UIB[1]==11)
3505  03bf c60001        	ld	a,_UIB+1
3506  03c2 a10b          	cp	a,#11
3507  03c4 2635          	jrne	L7302
3508                     ; 306 		for(i=0;i<256;i++)buff[i]=0;
3510  03c6 5f            	clrw	x
3511  03c7 1f03          	ldw	(OFST-1,sp),x
3512  03c9               L1402:
3515  03c9 1e03          	ldw	x,(OFST-1,sp)
3516  03cb 724f0050      	clr	(_buff,x)
3519  03cf 1e03          	ldw	x,(OFST-1,sp)
3520  03d1 1c0001        	addw	x,#1
3521  03d4 1f03          	ldw	(OFST-1,sp),x
3524  03d6 1e03          	ldw	x,(OFST-1,sp)
3525  03d8 a30100        	cpw	x,#256
3526  03db 25ec          	jrult	L1402
3527                     ; 308 		if(UIB[2]==1)DF_buffer_write(/*1,*/0,256, buff);
3529  03dd c60002        	ld	a,_UIB+2
3530  03e0 a101          	cp	a,#1
3531  03e2 2704          	jreq	L44
3532  03e4 acd408d4      	jpf	L1771
3533  03e8               L44:
3536  03e8 ae0050        	ldw	x,#_buff
3537  03eb 89            	pushw	x
3538  03ec ae0100        	ldw	x,#256
3539  03ef 89            	pushw	x
3540  03f0 5f            	clrw	x
3541  03f1 8dbf0bbf      	callf	f_DF_buffer_write
3543  03f5 5b04          	addw	sp,#4
3544  03f7 acd408d4      	jpf	L1771
3545  03fb               L7302:
3546                     ; 312 	else if(UIB[1]==12)
3548  03fb c60001        	ld	a,_UIB+1
3549  03fe a10c          	cp	a,#12
3550  0400 2704          	jreq	L64
3551  0402 ace404e4      	jpf	L3502
3552  0406               L64:
3553                     ; 318 		for(i=0;i<256;i++)buff[i]=0;
3555  0406 5f            	clrw	x
3556  0407 1f03          	ldw	(OFST-1,sp),x
3557  0409               L5502:
3560  0409 1e03          	ldw	x,(OFST-1,sp)
3561  040b 724f0050      	clr	(_buff,x)
3564  040f 1e03          	ldw	x,(OFST-1,sp)
3565  0411 1c0001        	addw	x,#1
3566  0414 1f03          	ldw	(OFST-1,sp),x
3569  0416 1e03          	ldw	x,(OFST-1,sp)
3570  0418 a30100        	cpw	x,#256
3571  041b 25ec          	jrult	L5502
3572                     ; 320 		if(UIB[3]==1)
3574  041d c60003        	ld	a,_UIB+3
3575  0420 a101          	cp	a,#1
3576  0422 2632          	jrne	L3602
3577                     ; 322 			buff[0]=0x00;
3579  0424 725f0050      	clr	_buff
3580                     ; 323 			buff[1]=0x11;
3582  0428 35110051      	mov	_buff+1,#17
3583                     ; 324 			buff[2]=0x22;
3585  042c 35220052      	mov	_buff+2,#34
3586                     ; 325 			buff[3]=0x33;
3588  0430 35330053      	mov	_buff+3,#51
3589                     ; 326 			buff[4]=0x44;
3591  0434 35440054      	mov	_buff+4,#68
3592                     ; 327 			buff[5]=0x55;
3594  0438 35550055      	mov	_buff+5,#85
3595                     ; 328 			buff[6]=0x66;
3597  043c 35660056      	mov	_buff+6,#102
3598                     ; 329 			buff[7]=0x77;
3600  0440 35770057      	mov	_buff+7,#119
3601                     ; 330 			buff[8]=0x88;
3603  0444 35880058      	mov	_buff+8,#136
3604                     ; 331 			buff[9]=0x99;
3606  0448 35990059      	mov	_buff+9,#153
3607                     ; 332 			buff[10]=0;
3609  044c 725f005a      	clr	_buff+10
3610                     ; 333 			buff[11]=0;
3612  0450 725f005b      	clr	_buff+11
3614  0454 2070          	jra	L5602
3615  0456               L3602:
3616                     ; 336 		else if(UIB[3]==2)
3618  0456 c60003        	ld	a,_UIB+3
3619  0459 a102          	cp	a,#2
3620  045b 2632          	jrne	L7602
3621                     ; 338 			buff[0]=0x00;
3623  045d 725f0050      	clr	_buff
3624                     ; 339 			buff[1]=0x10;
3626  0461 35100051      	mov	_buff+1,#16
3627                     ; 340 			buff[2]=0x20;
3629  0465 35200052      	mov	_buff+2,#32
3630                     ; 341 			buff[3]=0x30;
3632  0469 35300053      	mov	_buff+3,#48
3633                     ; 342 			buff[4]=0x40;
3635  046d 35400054      	mov	_buff+4,#64
3636                     ; 343 			buff[5]=0x50;
3638  0471 35500055      	mov	_buff+5,#80
3639                     ; 344 			buff[6]=0x60;
3641  0475 35600056      	mov	_buff+6,#96
3642                     ; 345 			buff[7]=0x70;
3644  0479 35700057      	mov	_buff+7,#112
3645                     ; 346 			buff[8]=0x80;
3647  047d 35800058      	mov	_buff+8,#128
3648                     ; 347 			buff[9]=0x90;
3650  0481 35900059      	mov	_buff+9,#144
3651                     ; 348 			buff[10]=0;
3653  0485 725f005a      	clr	_buff+10
3654                     ; 349 			buff[11]=0;
3656  0489 725f005b      	clr	_buff+11
3658  048d 2037          	jra	L5602
3659  048f               L7602:
3660                     ; 352 		else if(UIB[3]==3)
3662  048f c60003        	ld	a,_UIB+3
3663  0492 a103          	cp	a,#3
3664  0494 2630          	jrne	L5602
3665                     ; 354 			buff[0]=0x98;
3667  0496 35980050      	mov	_buff,#152
3668                     ; 355 			buff[1]=0x87;
3670  049a 35870051      	mov	_buff+1,#135
3671                     ; 356 			buff[2]=0x76;
3673  049e 35760052      	mov	_buff+2,#118
3674                     ; 357 			buff[3]=0x65;
3676  04a2 35650053      	mov	_buff+3,#101
3677                     ; 358 			buff[4]=0x54;
3679  04a6 35540054      	mov	_buff+4,#84
3680                     ; 359 			buff[5]=0x43;
3682  04aa 35430055      	mov	_buff+5,#67
3683                     ; 360 			buff[6]=0x32;
3685  04ae 35320056      	mov	_buff+6,#50
3686                     ; 361 			buff[7]=0x21;
3688  04b2 35210057      	mov	_buff+7,#33
3689                     ; 362 			buff[8]=0x10;
3691  04b6 35100058      	mov	_buff+8,#16
3692                     ; 363 			buff[9]=0x00;
3694  04ba 725f0059      	clr	_buff+9
3695                     ; 364 			buff[10]=0;
3697  04be 725f005a      	clr	_buff+10
3698                     ; 365 			buff[11]=0;
3700  04c2 725f005b      	clr	_buff+11
3701  04c6               L5602:
3702                     ; 367 		if(UIB[2]==1)DF_buffer_write(/*1,*/0,256, buff);
3704  04c6 c60002        	ld	a,_UIB+2
3705  04c9 a101          	cp	a,#1
3706  04cb 2704          	jreq	L05
3707  04cd acd408d4      	jpf	L1771
3708  04d1               L05:
3711  04d1 ae0050        	ldw	x,#_buff
3712  04d4 89            	pushw	x
3713  04d5 ae0100        	ldw	x,#256
3714  04d8 89            	pushw	x
3715  04d9 5f            	clrw	x
3716  04da 8dbf0bbf      	callf	f_DF_buffer_write
3718  04de 5b04          	addw	sp,#4
3719  04e0 acd408d4      	jpf	L1771
3720  04e4               L3502:
3721                     ; 371 	else if(UIB[1]==13)
3723  04e4 c60001        	ld	a,_UIB+1
3724  04e7 a10d          	cp	a,#13
3725  04e9 2704          	jreq	L25
3726  04eb ac930593      	jpf	L1012
3727  04ef               L25:
3728                     ; 376 		if(memory_manufacturer=='A') {	
3730  04ef b6bc          	ld	a,_memory_manufacturer
3731  04f1 a141          	cp	a,#65
3732  04f3 2609          	jrne	L3012
3733                     ; 377 			DF_page_to_buffer(/*UIB[2],*/UIB[3]);
3735  04f5 c60003        	ld	a,_UIB+3
3736  04f8 5f            	clrw	x
3737  04f9 97            	ld	xl,a
3738  04fa 8d250b25      	callf	f_DF_page_to_buffer
3740  04fe               L3012:
3741                     ; 379 		if(memory_manufacturer=='S') {
3743  04fe b6bc          	ld	a,_memory_manufacturer
3744  0500 a153          	cp	a,#83
3745  0502 2704          	jreq	L45
3746  0504 acd408d4      	jpf	L1771
3747  0508               L45:
3748                     ; 380 			current_page=11;
3750  0508 ae000b        	ldw	x,#11
3751  050b bf0f          	ldw	_current_page,x
3752                     ; 381 			ST_READ((long)(current_page*256),256, buff);
3754  050d ae0050        	ldw	x,#_buff
3755  0510 89            	pushw	x
3756  0511 ae0100        	ldw	x,#256
3757  0514 89            	pushw	x
3758  0515 ae0b00        	ldw	x,#2816
3759  0518 89            	pushw	x
3760  0519 ae0000        	ldw	x,#0
3761  051c 89            	pushw	x
3762  051d 8d580a58      	callf	f_ST_READ
3764  0521 5b08          	addw	sp,#8
3765                     ; 383 			uart_out_adr_block (0,buff,64);
3767  0523 4b40          	push	#64
3768  0525 ae0050        	ldw	x,#_buff
3769  0528 89            	pushw	x
3770  0529 ae0000        	ldw	x,#0
3771  052c 89            	pushw	x
3772  052d ae0000        	ldw	x,#0
3773  0530 89            	pushw	x
3774  0531 8d830183      	callf	f_uart_out_adr_block
3776  0535 5b07          	addw	sp,#7
3777                     ; 384 			delay_ms(100);    
3779  0537 ae0064        	ldw	x,#100
3780  053a 8d600060      	callf	f_delay_ms
3782                     ; 385 			uart_out_adr_block (64,&buff[64],64);
3784  053e 4b40          	push	#64
3785  0540 ae0090        	ldw	x,#_buff+64
3786  0543 89            	pushw	x
3787  0544 ae0040        	ldw	x,#64
3788  0547 89            	pushw	x
3789  0548 ae0000        	ldw	x,#0
3790  054b 89            	pushw	x
3791  054c 8d830183      	callf	f_uart_out_adr_block
3793  0550 5b07          	addw	sp,#7
3794                     ; 386 			delay_ms(100);    
3796  0552 ae0064        	ldw	x,#100
3797  0555 8d600060      	callf	f_delay_ms
3799                     ; 387 			uart_out_adr_block (128,&buff[128],64);
3801  0559 4b40          	push	#64
3802  055b ae00d0        	ldw	x,#_buff+128
3803  055e 89            	pushw	x
3804  055f ae0080        	ldw	x,#128
3805  0562 89            	pushw	x
3806  0563 ae0000        	ldw	x,#0
3807  0566 89            	pushw	x
3808  0567 8d830183      	callf	f_uart_out_adr_block
3810  056b 5b07          	addw	sp,#7
3811                     ; 388 			delay_ms(100);    
3813  056d ae0064        	ldw	x,#100
3814  0570 8d600060      	callf	f_delay_ms
3816                     ; 389 			uart_out_adr_block (192,&buff[192],64);
3818  0574 4b40          	push	#64
3819  0576 ae0110        	ldw	x,#_buff+192
3820  0579 89            	pushw	x
3821  057a ae00c0        	ldw	x,#192
3822  057d 89            	pushw	x
3823  057e ae0000        	ldw	x,#0
3824  0581 89            	pushw	x
3825  0582 8d830183      	callf	f_uart_out_adr_block
3827  0586 5b07          	addw	sp,#7
3828                     ; 390 			delay_ms(100); 
3830  0588 ae0064        	ldw	x,#100
3831  058b 8d600060      	callf	f_delay_ms
3833  058f acd408d4      	jpf	L1771
3834  0593               L1012:
3835                     ; 393 	else if(UIB[1]==14)
3837  0593 c60001        	ld	a,_UIB+1
3838  0596 a10e          	cp	a,#14
3839  0598 2661          	jrne	L1112
3840                     ; 398 		if(memory_manufacturer=='A') {	
3842  059a b6bc          	ld	a,_memory_manufacturer
3843  059c a141          	cp	a,#65
3844  059e 2609          	jrne	L3112
3845                     ; 399 			DF_buffer_to_page_er(/*UIB[2],*/UIB[3]);
3847  05a0 c60003        	ld	a,_UIB+3
3848  05a3 5f            	clrw	x
3849  05a4 97            	ld	xl,a
3850  05a5 8d4c0b4c      	callf	f_DF_buffer_to_page_er
3852  05a9               L3112:
3853                     ; 401 		if(memory_manufacturer=='S') {
3855  05a9 b6bc          	ld	a,_memory_manufacturer
3856  05ab a153          	cp	a,#83
3857  05ad 2704          	jreq	L65
3858  05af acd408d4      	jpf	L1771
3859  05b3               L65:
3860                     ; 402 			for(i=0;i<256;i++) {
3862  05b3 5f            	clrw	x
3863  05b4 1f03          	ldw	(OFST-1,sp),x
3864  05b6               L7112:
3865                     ; 403 				buff[i]=(char)i;
3867  05b6 7b04          	ld	a,(OFST+0,sp)
3868  05b8 1e03          	ldw	x,(OFST-1,sp)
3869  05ba d70050        	ld	(_buff,x),a
3870                     ; 402 			for(i=0;i<256;i++) {
3872  05bd 1e03          	ldw	x,(OFST-1,sp)
3873  05bf 1c0001        	addw	x,#1
3874  05c2 1f03          	ldw	(OFST-1,sp),x
3877  05c4 1e03          	ldw	x,(OFST-1,sp)
3878  05c6 a30100        	cpw	x,#256
3879  05c9 25eb          	jrult	L7112
3880                     ; 405 			current_page=11;
3882  05cb ae000b        	ldw	x,#11
3883  05ce bf0f          	ldw	_current_page,x
3884                     ; 406 			ST_WREN();
3886  05d0 8df809f8      	callf	f_ST_WREN
3888                     ; 407 			delay_ms(100);
3890  05d4 ae0064        	ldw	x,#100
3891  05d7 8d600060      	callf	f_delay_ms
3893                     ; 408 			ST_WRITE((long)(current_page*256),256,buff);		
3895  05db ae0050        	ldw	x,#_buff
3896  05de 89            	pushw	x
3897  05df ae0100        	ldw	x,#256
3898  05e2 89            	pushw	x
3899  05e3 be0f          	ldw	x,_current_page
3900  05e5 4f            	clr	a
3901  05e6 02            	rlwa	x,a
3902  05e7 8d000000      	callf	d_uitolx
3904  05eb be02          	ldw	x,c_lreg+2
3905  05ed 89            	pushw	x
3906  05ee be00          	ldw	x,c_lreg
3907  05f0 89            	pushw	x
3908  05f1 8d070a07      	callf	f_ST_WRITE
3910  05f5 5b08          	addw	sp,#8
3911  05f7 acd408d4      	jpf	L1771
3912  05fb               L1112:
3913                     ; 413 	else if(UIB[1]==20)
3915  05fb c60001        	ld	a,_UIB+1
3916  05fe a114          	cp	a,#20
3917  0600 2704          	jreq	L06
3918  0602 ac980698      	jpf	L7212
3919  0606               L06:
3920                     ; 418 		file_lengt=0;
3922  0606 ae0000        	ldw	x,#0
3923  0609 bf09          	ldw	_file_lengt+2,x
3924  060b ae0000        	ldw	x,#0
3925  060e bf07          	ldw	_file_lengt,x
3926                     ; 419 		file_lengt+=UIB[5];
3928  0610 c60005        	ld	a,_UIB+5
3929  0613 ae0007        	ldw	x,#_file_lengt
3930  0616 88            	push	a
3931  0617 8d000000      	callf	d_lgadc
3933  061b 84            	pop	a
3934                     ; 420 		file_lengt<<=8;
3936  061c ae0007        	ldw	x,#_file_lengt
3937  061f a608          	ld	a,#8
3938  0621 8d000000      	callf	d_lglsh
3940                     ; 421 		file_lengt+=UIB[4];
3942  0625 c60004        	ld	a,_UIB+4
3943  0628 ae0007        	ldw	x,#_file_lengt
3944  062b 88            	push	a
3945  062c 8d000000      	callf	d_lgadc
3947  0630 84            	pop	a
3948                     ; 422 		file_lengt<<=8;
3950  0631 ae0007        	ldw	x,#_file_lengt
3951  0634 a608          	ld	a,#8
3952  0636 8d000000      	callf	d_lglsh
3954                     ; 423 		file_lengt+=UIB[3];
3956  063a c60003        	ld	a,_UIB+3
3957  063d ae0007        	ldw	x,#_file_lengt
3958  0640 88            	push	a
3959  0641 8d000000      	callf	d_lgadc
3961  0645 84            	pop	a
3962                     ; 424 		file_lengt_in_pages=file_lengt;
3964  0646 be09          	ldw	x,_file_lengt+2
3965  0648 bf11          	ldw	_file_lengt_in_pages,x
3966                     ; 425 		file_lengt<<=8;
3968  064a ae0007        	ldw	x,#_file_lengt
3969  064d a608          	ld	a,#8
3970  064f 8d000000      	callf	d_lglsh
3972                     ; 426 		file_lengt+=UIB[2];
3974  0653 c60002        	ld	a,_UIB+2
3975  0656 ae0007        	ldw	x,#_file_lengt
3976  0659 88            	push	a
3977  065a 8d000000      	callf	d_lgadc
3979  065e 84            	pop	a
3980                     ; 431 		current_page=0;
3982  065f 5f            	clrw	x
3983  0660 bf0f          	ldw	_current_page,x
3984                     ; 432 		current_byte_in_buffer=0;
3986  0662 5f            	clrw	x
3987  0663 bf0b          	ldw	_current_byte_in_buffer,x
3988                     ; 434 		if(memory_manufacturer=='S') {
3990  0665 b6bc          	ld	a,_memory_manufacturer
3991  0667 a153          	cp	a,#83
3992  0669 260f          	jrne	L1312
3993                     ; 435 			ST_WREN();
3995  066b 8df809f8      	callf	f_ST_WREN
3997                     ; 436 					delay_ms(100);
3999  066f ae0064        	ldw	x,#100
4000  0672 8d600060      	callf	f_delay_ms
4002                     ; 437 		ST_bulk_erase();
4004  0676 8de909e9      	callf	f_ST_bulk_erase
4006  067a               L1312:
4007                     ; 439 		uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
4009  067a 4b00          	push	#0
4010  067c 4b00          	push	#0
4011  067e 3b000f        	push	_current_page
4012  0681 b610          	ld	a,_current_page+1
4013  0683 a4ff          	and	a,#255
4014  0685 88            	push	a
4015  0686 4b15          	push	#21
4016  0688 ae0016        	ldw	x,#22
4017  068b a604          	ld	a,#4
4018  068d 95            	ld	xh,a
4019  068e 8dd800d8      	callf	f_uart_out
4021  0692 5b05          	addw	sp,#5
4023  0694 acd408d4      	jpf	L1771
4024  0698               L7212:
4025                     ; 442 	else if(UIB[1]==21)
4027  0698 c60001        	ld	a,_UIB+1
4028  069b a115          	cp	a,#21
4029  069d 2704          	jreq	L26
4030  069f aca307a3      	jpf	L5312
4031  06a3               L26:
4032                     ; 447           for(i=0;i<64;i++)
4034  06a3 5f            	clrw	x
4035  06a4 1f03          	ldw	(OFST-1,sp),x
4036  06a6               L7312:
4037                     ; 449           	buff[current_byte_in_buffer+i]=UIB[2+i];
4039  06a6 1e03          	ldw	x,(OFST-1,sp)
4040  06a8 d60002        	ld	a,(_UIB+2,x)
4041  06ab be0b          	ldw	x,_current_byte_in_buffer
4042  06ad 72fb03        	addw	x,(OFST-1,sp)
4043  06b0 d70050        	ld	(_buff,x),a
4044                     ; 447           for(i=0;i<64;i++)
4046  06b3 1e03          	ldw	x,(OFST-1,sp)
4047  06b5 1c0001        	addw	x,#1
4048  06b8 1f03          	ldw	(OFST-1,sp),x
4051  06ba 1e03          	ldw	x,(OFST-1,sp)
4052  06bc a30040        	cpw	x,#64
4053  06bf 25e5          	jrult	L7312
4054                     ; 451           current_byte_in_buffer+=64;
4056  06c1 be0b          	ldw	x,_current_byte_in_buffer
4057  06c3 1c0040        	addw	x,#64
4058  06c6 bf0b          	ldw	_current_byte_in_buffer,x
4059                     ; 452           if(current_byte_in_buffer>=256)
4061  06c8 be0b          	ldw	x,_current_byte_in_buffer
4062  06ca a30100        	cpw	x,#256
4063  06cd 2404          	jruge	L46
4064  06cf acd408d4      	jpf	L1771
4065  06d3               L46:
4066                     ; 460 			if(memory_manufacturer=='A') {
4068  06d3 b6bc          	ld	a,_memory_manufacturer
4069  06d5 a141          	cp	a,#65
4070  06d7 2653          	jrne	L7412
4071                     ; 461 				DF_buffer_write(/*//current_buffer*//*1,*/0,256,buff);
4073  06d9 ae0050        	ldw	x,#_buff
4074  06dc 89            	pushw	x
4075  06dd ae0100        	ldw	x,#256
4076  06e0 89            	pushw	x
4077  06e1 5f            	clrw	x
4078  06e2 8dbf0bbf      	callf	f_DF_buffer_write
4080  06e6 5b04          	addw	sp,#4
4081                     ; 462 				DF_buffer_to_page_er(/*///current_buffer*//*1,*/current_page);
4083  06e8 be0f          	ldw	x,_current_page
4084  06ea 8d4c0b4c      	callf	f_DF_buffer_to_page_er
4086                     ; 463 				current_page++;
4088  06ee be0f          	ldw	x,_current_page
4089  06f0 1c0001        	addw	x,#1
4090  06f3 bf0f          	ldw	_current_page,x
4091                     ; 464 				if(current_page<file_lengt_in_pages)
4093  06f5 be0f          	ldw	x,_current_page
4094  06f7 b311          	cpw	x,_file_lengt_in_pages
4095  06f9 2426          	jruge	L1512
4096                     ; 466 					delay_ms(100);
4098  06fb ae0064        	ldw	x,#100
4099  06fe 8d600060      	callf	f_delay_ms
4101                     ; 467 					uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
4103  0702 4b00          	push	#0
4104  0704 4b00          	push	#0
4105  0706 3b000f        	push	_current_page
4106  0709 b610          	ld	a,_current_page+1
4107  070b a4ff          	and	a,#255
4108  070d 88            	push	a
4109  070e 4b15          	push	#21
4110  0710 ae0016        	ldw	x,#22
4111  0713 a604          	ld	a,#4
4112  0715 95            	ld	xh,a
4113  0716 8dd800d8      	callf	f_uart_out
4115  071a 5b05          	addw	sp,#5
4116                     ; 468 					current_byte_in_buffer=0;
4118  071c 5f            	clrw	x
4119  071d bf0b          	ldw	_current_byte_in_buffer,x
4121  071f 200b          	jra	L7412
4122  0721               L1512:
4123                     ; 472 					EE_PAGE_LEN=current_page;
4125  0721 be0f          	ldw	x,_current_page
4126  0723 89            	pushw	x
4127  0724 ae0000        	ldw	x,#_EE_PAGE_LEN
4128  0727 8d000000      	callf	d_eewrw
4130  072b 85            	popw	x
4131  072c               L7412:
4132                     ; 475 			if(memory_manufacturer=='S') {
4134  072c b6bc          	ld	a,_memory_manufacturer
4135  072e a153          	cp	a,#83
4136  0730 2704          	jreq	L66
4137  0732 acd408d4      	jpf	L1771
4138  0736               L66:
4139                     ; 476 				ST_WREN();
4141  0736 8df809f8      	callf	f_ST_WREN
4143                     ; 477 				delay_ms(100);
4145  073a ae0064        	ldw	x,#100
4146  073d 8d600060      	callf	f_delay_ms
4148                     ; 478 				ST_WRITE((unsigned long)(current_page*256UL),256,buff);
4150  0741 ae0050        	ldw	x,#_buff
4151  0744 89            	pushw	x
4152  0745 ae0100        	ldw	x,#256
4153  0748 89            	pushw	x
4154  0749 be0f          	ldw	x,_current_page
4155  074b 90ae0100      	ldw	y,#256
4156  074f 8d000000      	callf	d_umul
4158  0753 be02          	ldw	x,c_lreg+2
4159  0755 89            	pushw	x
4160  0756 be00          	ldw	x,c_lreg
4161  0758 89            	pushw	x
4162  0759 8d070a07      	callf	f_ST_WRITE
4164  075d 5b08          	addw	sp,#8
4165                     ; 479 				current_page++;
4167  075f be0f          	ldw	x,_current_page
4168  0761 1c0001        	addw	x,#1
4169  0764 bf0f          	ldw	_current_page,x
4170                     ; 480 				if(current_page<file_lengt_in_pages)
4172  0766 be0f          	ldw	x,_current_page
4173  0768 b311          	cpw	x,_file_lengt_in_pages
4174  076a 2428          	jruge	L7512
4175                     ; 482 					delay_ms(100);
4177  076c ae0064        	ldw	x,#100
4178  076f 8d600060      	callf	f_delay_ms
4180                     ; 483 					uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
4182  0773 4b00          	push	#0
4183  0775 4b00          	push	#0
4184  0777 3b000f        	push	_current_page
4185  077a b610          	ld	a,_current_page+1
4186  077c a4ff          	and	a,#255
4187  077e 88            	push	a
4188  077f 4b15          	push	#21
4189  0781 ae0016        	ldw	x,#22
4190  0784 a604          	ld	a,#4
4191  0786 95            	ld	xh,a
4192  0787 8dd800d8      	callf	f_uart_out
4194  078b 5b05          	addw	sp,#5
4195                     ; 484 					current_byte_in_buffer=0;
4197  078d 5f            	clrw	x
4198  078e bf0b          	ldw	_current_byte_in_buffer,x
4200  0790 acd408d4      	jpf	L1771
4201  0794               L7512:
4202                     ; 488 					EE_PAGE_LEN=current_page;
4204  0794 be0f          	ldw	x,_current_page
4205  0796 89            	pushw	x
4206  0797 ae0000        	ldw	x,#_EE_PAGE_LEN
4207  079a 8d000000      	callf	d_eewrw
4209  079e 85            	popw	x
4210  079f acd408d4      	jpf	L1771
4211  07a3               L5312:
4212                     ; 499 	else if(UIB[1]==24) {
4214  07a3 c60001        	ld	a,_UIB+1
4215  07a6 a118          	cp	a,#24
4216  07a8 2618          	jrne	L5612
4217                     ; 502 		rele_cnt=10;
4219  07aa ae000a        	ldw	x,#10
4220  07ad bf03          	ldw	_rele_cnt,x
4221                     ; 503 		ST_WREN();
4223  07af 8df809f8      	callf	f_ST_WREN
4225                     ; 504 		delay_ms(100);
4227  07b3 ae0064        	ldw	x,#100
4228  07b6 8d600060      	callf	f_delay_ms
4230                     ; 505 		ST_bulk_erase();
4232  07ba 8de909e9      	callf	f_ST_bulk_erase
4235  07be acd408d4      	jpf	L1771
4236  07c2               L5612:
4237                     ; 510 	else if(UIB[1]==25)
4239  07c2 c60001        	ld	a,_UIB+1
4240  07c5 a119          	cp	a,#25
4241  07c7 2704          	jreq	L07
4242  07c9 acbc08bc      	jpf	L1712
4243  07cd               L07:
4244                     ; 514 		current_page=0;
4246  07cd 5f            	clrw	x
4247  07ce bf0f          	ldw	_current_page,x
4248                     ; 516 		for(i__=0;i__<EE_PAGE_LEN;i__++)
4250  07d0 5f            	clrw	x
4251  07d1 1f03          	ldw	(OFST-1,sp),x
4253  07d3 acaf08af      	jpf	L7712
4254  07d7               L3712:
4255                     ; 518 			if(memory_manufacturer=='S') {	
4257  07d7 b6bc          	ld	a,_memory_manufacturer
4258  07d9 a153          	cp	a,#83
4259  07db 261c          	jrne	L3022
4260                     ; 519 				DF_page_to_buffer(i__);
4262  07dd 1e03          	ldw	x,(OFST-1,sp)
4263  07df 8d250b25      	callf	f_DF_page_to_buffer
4265                     ; 520 				delay_ms(100);			
4267  07e3 ae0064        	ldw	x,#100
4268  07e6 8d600060      	callf	f_delay_ms
4270                     ; 521 				DF_buffer_read(0,256, buff);
4272  07ea ae0050        	ldw	x,#_buff
4273  07ed 89            	pushw	x
4274  07ee ae0100        	ldw	x,#256
4275  07f1 89            	pushw	x
4276  07f2 5f            	clrw	x
4277  07f3 8d730b73      	callf	f_DF_buffer_read
4279  07f7 5b04          	addw	sp,#4
4280  07f9               L3022:
4281                     ; 524 			if(memory_manufacturer=='S') {	
4283  07f9 b6bc          	ld	a,_memory_manufacturer
4284  07fb a153          	cp	a,#83
4285  07fd 261c          	jrne	L5022
4286                     ; 525 				ST_READ((long)(i__*256),256, buff);
4288  07ff ae0050        	ldw	x,#_buff
4289  0802 89            	pushw	x
4290  0803 ae0100        	ldw	x,#256
4291  0806 89            	pushw	x
4292  0807 1e07          	ldw	x,(OFST+3,sp)
4293  0809 4f            	clr	a
4294  080a 02            	rlwa	x,a
4295  080b 8d000000      	callf	d_itolx
4297  080f be02          	ldw	x,c_lreg+2
4298  0811 89            	pushw	x
4299  0812 be00          	ldw	x,c_lreg
4300  0814 89            	pushw	x
4301  0815 8d580a58      	callf	f_ST_READ
4303  0819 5b08          	addw	sp,#8
4304  081b               L5022:
4305                     ; 528 			uart_out_adr_block ((256*i__)+0,buff,64);
4307  081b 4b40          	push	#64
4308  081d ae0050        	ldw	x,#_buff
4309  0820 89            	pushw	x
4310  0821 1e06          	ldw	x,(OFST+2,sp)
4311  0823 4f            	clr	a
4312  0824 02            	rlwa	x,a
4313  0825 8d000000      	callf	d_itolx
4315  0829 be02          	ldw	x,c_lreg+2
4316  082b 89            	pushw	x
4317  082c be00          	ldw	x,c_lreg
4318  082e 89            	pushw	x
4319  082f 8d830183      	callf	f_uart_out_adr_block
4321  0833 5b07          	addw	sp,#7
4322                     ; 529 			delay_ms(100);    
4324  0835 ae0064        	ldw	x,#100
4325  0838 8d600060      	callf	f_delay_ms
4327                     ; 530 			uart_out_adr_block ((256*i__)+64,&buff[64],64);
4329  083c 4b40          	push	#64
4330  083e ae0090        	ldw	x,#_buff+64
4331  0841 89            	pushw	x
4332  0842 1e06          	ldw	x,(OFST+2,sp)
4333  0844 4f            	clr	a
4334  0845 02            	rlwa	x,a
4335  0846 1c0040        	addw	x,#64
4336  0849 8d000000      	callf	d_itolx
4338  084d be02          	ldw	x,c_lreg+2
4339  084f 89            	pushw	x
4340  0850 be00          	ldw	x,c_lreg
4341  0852 89            	pushw	x
4342  0853 8d830183      	callf	f_uart_out_adr_block
4344  0857 5b07          	addw	sp,#7
4345                     ; 531 			delay_ms(100);    
4347  0859 ae0064        	ldw	x,#100
4348  085c 8d600060      	callf	f_delay_ms
4350                     ; 532 			uart_out_adr_block ((256*i__)+128,&buff[128],64);
4352  0860 4b40          	push	#64
4353  0862 ae00d0        	ldw	x,#_buff+128
4354  0865 89            	pushw	x
4355  0866 1e06          	ldw	x,(OFST+2,sp)
4356  0868 4f            	clr	a
4357  0869 02            	rlwa	x,a
4358  086a 1c0080        	addw	x,#128
4359  086d 8d000000      	callf	d_itolx
4361  0871 be02          	ldw	x,c_lreg+2
4362  0873 89            	pushw	x
4363  0874 be00          	ldw	x,c_lreg
4364  0876 89            	pushw	x
4365  0877 8d830183      	callf	f_uart_out_adr_block
4367  087b 5b07          	addw	sp,#7
4368                     ; 533 			delay_ms(100);    
4370  087d ae0064        	ldw	x,#100
4371  0880 8d600060      	callf	f_delay_ms
4373                     ; 534 			uart_out_adr_block ((256*i__)+192,&buff[192],64);
4375  0884 4b40          	push	#64
4376  0886 ae0110        	ldw	x,#_buff+192
4377  0889 89            	pushw	x
4378  088a 1e06          	ldw	x,(OFST+2,sp)
4379  088c 4f            	clr	a
4380  088d 02            	rlwa	x,a
4381  088e 1c00c0        	addw	x,#192
4382  0891 8d000000      	callf	d_itolx
4384  0895 be02          	ldw	x,c_lreg+2
4385  0897 89            	pushw	x
4386  0898 be00          	ldw	x,c_lreg
4387  089a 89            	pushw	x
4388  089b 8d830183      	callf	f_uart_out_adr_block
4390  089f 5b07          	addw	sp,#7
4391                     ; 535 			delay_ms(100);   
4393  08a1 ae0064        	ldw	x,#100
4394  08a4 8d600060      	callf	f_delay_ms
4396                     ; 516 		for(i__=0;i__<EE_PAGE_LEN;i__++)
4398  08a8 1e03          	ldw	x,(OFST-1,sp)
4399  08aa 1c0001        	addw	x,#1
4400  08ad 1f03          	ldw	(OFST-1,sp),x
4401  08af               L7712:
4404  08af 1e03          	ldw	x,(OFST-1,sp)
4405  08b1 c30000        	cpw	x,_EE_PAGE_LEN
4406  08b4 2404          	jruge	L27
4407  08b6 acd707d7      	jpf	L3712
4408  08ba               L27:
4410  08ba 2018          	jra	L1771
4411  08bc               L1712:
4412                     ; 545 	else if(UIB[1]==30)
4414  08bc c60001        	ld	a,_UIB+1
4415  08bf a11e          	cp	a,#30
4416  08c1 2606          	jrne	L1122
4417                     ; 567           bSTART=1;
4419  08c3 7210000c      	bset	_bSTART
4421  08c7 200b          	jra	L1771
4422  08c9               L1122:
4423                     ; 579 	else if(UIB[1]==40)
4425  08c9 c60001        	ld	a,_UIB+1
4426  08cc a128          	cp	a,#40
4427  08ce 2604          	jrne	L1771
4428                     ; 601 		bSTART=1;	
4430  08d0 7210000c      	bset	_bSTART
4431  08d4               L1771:
4432                     ; 606 }
4435  08d4 5b04          	addw	sp,#4
4436  08d6 87            	retf
4472                     ; 609 void putchar(char c)
4472                     ; 610 {
4473                     	switch	.text
4474  08d7               f_putchar:
4476  08d7 88            	push	a
4477       00000000      OFST:	set	0
4480  08d8               L7322:
4481                     ; 611 while (tx_counter == TX_BUFFER_SIZE);
4483  08d8 b620          	ld	a,_tx_counter
4484  08da a150          	cp	a,#80
4485  08dc 27fa          	jreq	L7322
4486                     ; 613 if (tx_counter || ((UART1->SR & UART1_SR_TXE)==0))
4488  08de 3d20          	tnz	_tx_counter
4489  08e0 2607          	jrne	L5422
4491  08e2 c65230        	ld	a,21040
4492  08e5 a580          	bcp	a,#128
4493  08e7 261d          	jrne	L3422
4494  08e9               L5422:
4495                     ; 615    tx_buffer[tx_wr_index]=c;
4497  08e9 5f            	clrw	x
4498  08ea b61f          	ld	a,_tx_wr_index
4499  08ec 2a01          	jrpl	L67
4500  08ee 53            	cplw	x
4501  08ef               L67:
4502  08ef 97            	ld	xl,a
4503  08f0 7b01          	ld	a,(OFST+1,sp)
4504  08f2 e704          	ld	(_tx_buffer,x),a
4505                     ; 616    if (++tx_wr_index == TX_BUFFER_SIZE) tx_wr_index=0;
4507  08f4 3c1f          	inc	_tx_wr_index
4508  08f6 b61f          	ld	a,_tx_wr_index
4509  08f8 a150          	cp	a,#80
4510  08fa 2602          	jrne	L7422
4513  08fc 3f1f          	clr	_tx_wr_index
4514  08fe               L7422:
4515                     ; 617    ++tx_counter;
4517  08fe 3c20          	inc	_tx_counter
4519  0900               L1522:
4520                     ; 621 UART1->CR2|= UART1_CR2_TIEN;
4522  0900 721e5235      	bset	21045,#7
4523                     ; 623 }
4526  0904 84            	pop	a
4527  0905 87            	retf
4528  0906               L3422:
4529                     ; 619 else UART1->DR=c;
4531  0906 7b01          	ld	a,(OFST+1,sp)
4532  0908 c75231        	ld	21041,a
4533  090b 20f3          	jra	L1522
4555                     ; 626 void spi_init(void){
4556                     	switch	.text
4557  090d               f_spi_init:
4561                     ; 628 	GPIOA->DDR|=(1<<3);
4563  090d 72165002      	bset	20482,#3
4564                     ; 629 	GPIOA->CR1|=(1<<3);
4566  0911 72165003      	bset	20483,#3
4567                     ; 630 	GPIOA->CR2&=~(1<<3);
4569  0915 72175004      	bres	20484,#3
4570                     ; 631 	GPIOA->ODR|=(1<<3);	
4572  0919 72165000      	bset	20480,#3
4573                     ; 634 	GPIOB->DDR|=(1<<5);
4575  091d 721a5007      	bset	20487,#5
4576                     ; 635 	GPIOB->CR1|=(1<<5);
4578  0921 721a5008      	bset	20488,#5
4579                     ; 636 	GPIOB->CR2&=~(1<<5);
4581  0925 721b5009      	bres	20489,#5
4582                     ; 637 	GPIOB->ODR|=(1<<5);	
4584  0929 721a5005      	bset	20485,#5
4585                     ; 639 	GPIOC->DDR|=(1<<3);
4587  092d 7216500c      	bset	20492,#3
4588                     ; 640 	GPIOC->CR1|=(1<<3);
4590  0931 7216500d      	bset	20493,#3
4591                     ; 641 	GPIOC->CR2&=~(1<<3);
4593  0935 7217500e      	bres	20494,#3
4594                     ; 642 	GPIOC->ODR|=(1<<3);	
4596  0939 7216500a      	bset	20490,#3
4597                     ; 644 	GPIOC->DDR|=(1<<5);
4599  093d 721a500c      	bset	20492,#5
4600                     ; 645 	GPIOC->CR1|=(1<<5);
4602  0941 721a500d      	bset	20493,#5
4603                     ; 646 	GPIOC->CR2|=(1<<5);
4605  0945 721a500e      	bset	20494,#5
4606                     ; 647 	GPIOC->ODR|=(1<<5);	
4608  0949 721a500a      	bset	20490,#5
4609                     ; 649 	GPIOC->DDR|=(1<<6);
4611  094d 721c500c      	bset	20492,#6
4612                     ; 650 	GPIOC->CR1|=(1<<6);
4614  0951 721c500d      	bset	20493,#6
4615                     ; 651 	GPIOC->CR2|=(1<<6);
4617  0955 721c500e      	bset	20494,#6
4618                     ; 652 	GPIOC->ODR|=(1<<6);	
4620  0959 721c500a      	bset	20490,#6
4621                     ; 654 	GPIOC->DDR&=~(1<<7);
4623  095d 721f500c      	bres	20492,#7
4624                     ; 655 	GPIOC->CR1&=~(1<<7);
4626  0961 721f500d      	bres	20493,#7
4627                     ; 656 	GPIOC->CR2&=~(1<<7);
4629  0965 721f500e      	bres	20494,#7
4630                     ; 657 	GPIOC->ODR|=(1<<7);	
4632  0969 721e500a      	bset	20490,#7
4633                     ; 659 	SPI->CR1= /*SPI_CR1_LSBFIRST |*/
4633                     ; 660 			SPI_CR1_SPE | 
4633                     ; 661 			( (4<< 3) & SPI_CR1_BR ) |
4633                     ; 662 			SPI_CR1_MSTR |
4633                     ; 663 			SPI_CR1_CPOL |
4633                     ; 664 			SPI_CR1_CPHA; 
4635  096d 35675200      	mov	20992,#103
4636                     ; 666 	SPI->CR2= SPI_CR2_SSM | SPI_CR2_SSI;
4638  0971 35035201      	mov	20993,#3
4639                     ; 667 	SPI->ICR= 0;	
4641  0975 725f5202      	clr	20994
4642                     ; 668 }
4645  0979 87            	retf
4687                     ; 671 char spi(char in){
4688                     	switch	.text
4689  097a               f_spi:
4691  097a 88            	push	a
4692  097b 88            	push	a
4693       00000001      OFST:	set	1
4696  097c               L7032:
4697                     ; 673 	while(!((SPI->SR)&SPI_SR_TXE));
4699  097c c65203        	ld	a,20995
4700  097f a502          	bcp	a,#2
4701  0981 27f9          	jreq	L7032
4702                     ; 674 	SPI->DR=in;
4704  0983 7b02          	ld	a,(OFST+1,sp)
4705  0985 c75204        	ld	20996,a
4707  0988               L7132:
4708                     ; 675 	while(!((SPI->SR)&SPI_SR_RXNE));
4710  0988 c65203        	ld	a,20995
4711  098b a501          	bcp	a,#1
4712  098d 27f9          	jreq	L7132
4713                     ; 676 	c=SPI->DR;	
4715  098f c65204        	ld	a,20996
4716  0992 6b01          	ld	(OFST+0,sp),a
4717                     ; 677 	return c;
4719  0994 7b01          	ld	a,(OFST+0,sp)
4722  0996 85            	popw	x
4723  0997 87            	retf
4787                     ; 681 long ST_RDID_read(void)
4787                     ; 682 {
4788                     	switch	.text
4789  0998               f_ST_RDID_read:
4791  0998 5204          	subw	sp,#4
4792       00000004      OFST:	set	4
4795                     ; 685 d0=0;
4797  099a 0f04          	clr	(OFST+0,sp)
4798                     ; 686 d1=0;
4800                     ; 687 d2=0;
4802                     ; 688 d3=0;
4804                     ; 690 ST_CS_ON
4806  099c 721b5005      	bres	20485,#5
4807                     ; 691 spi(0x9f);
4809  09a0 a69f          	ld	a,#159
4810  09a2 8d7a097a      	callf	f_spi
4812                     ; 692 mdr0=spi(0xff);
4814  09a6 a6ff          	ld	a,#255
4815  09a8 8d7a097a      	callf	f_spi
4817  09ac b716          	ld	_mdr0,a
4818                     ; 693 mdr1=spi(0xff);
4820  09ae a6ff          	ld	a,#255
4821  09b0 8d7a097a      	callf	f_spi
4823  09b4 b715          	ld	_mdr1,a
4824                     ; 694 mdr2=spi(0xff);
4826  09b6 a6ff          	ld	a,#255
4827  09b8 8d7a097a      	callf	f_spi
4829  09bc b714          	ld	_mdr2,a
4830                     ; 697 ST_CS_OFF
4832  09be 721a5005      	bset	20485,#5
4833                     ; 698 return  *((long*)&d0);
4835  09c2 96            	ldw	x,sp
4836  09c3 1c0004        	addw	x,#OFST+0
4837  09c6 8d000000      	callf	d_ltor
4841  09ca 5b04          	addw	sp,#4
4842  09cc 87            	retf
4876                     ; 702 char ST_status_read(void)
4876                     ; 703 {
4877                     	switch	.text
4878  09cd               f_ST_status_read:
4880  09cd 88            	push	a
4881       00000001      OFST:	set	1
4884                     ; 707 ST_CS_ON
4886  09ce 721b5005      	bres	20485,#5
4887                     ; 708 spi(0x05);
4889  09d2 a605          	ld	a,#5
4890  09d4 8d7a097a      	callf	f_spi
4892                     ; 709 d0=spi(0xff);
4894  09d8 a6ff          	ld	a,#255
4895  09da 8d7a097a      	callf	f_spi
4897  09de 6b01          	ld	(OFST+0,sp),a
4898                     ; 711 ST_CS_OFF
4900  09e0 721a5005      	bset	20485,#5
4901                     ; 712 return d0;
4903  09e4 7b01          	ld	a,(OFST+0,sp)
4906  09e6 5b01          	addw	sp,#1
4907  09e8 87            	retf
4930                     ; 716 void ST_bulk_erase(void)
4930                     ; 717 {
4931                     	switch	.text
4932  09e9               f_ST_bulk_erase:
4936                     ; 718 ST_CS_ON
4938  09e9 721b5005      	bres	20485,#5
4939                     ; 719 spi(0xC7);
4941  09ed a6c7          	ld	a,#199
4942  09ef 8d7a097a      	callf	f_spi
4944                     ; 722 ST_CS_OFF
4946  09f3 721a5005      	bset	20485,#5
4947                     ; 723 }
4950  09f7 87            	retf
4973                     ; 725 void ST_WREN(void)
4973                     ; 726 {
4974                     	switch	.text
4975  09f8               f_ST_WREN:
4979                     ; 728 ST_CS_ON
4981  09f8 721b5005      	bres	20485,#5
4982                     ; 729 spi(0x06);
4984  09fc a606          	ld	a,#6
4985  09fe 8d7a097a      	callf	f_spi
4987                     ; 731 ST_CS_OFF
4989  0a02 721a5005      	bset	20485,#5
4990                     ; 732 }  
4993  0a06 87            	retf
5082                     ; 735 void ST_WRITE(unsigned long memo_addr,unsigned short len, char* adr)
5082                     ; 736 {
5083                     	switch	.text
5084  0a07               f_ST_WRITE:
5086  0a07 5205          	subw	sp,#5
5087       00000005      OFST:	set	5
5090                     ; 740 adr2=(char)(memo_addr>>16);
5092  0a09 7b0a          	ld	a,(OFST+5,sp)
5093  0a0b 6b03          	ld	(OFST-2,sp),a
5094                     ; 741 adr1=(char)((memo_addr>>8)&0x00ff);
5096  0a0d 7b0b          	ld	a,(OFST+6,sp)
5097  0a0f a4ff          	and	a,#255
5098  0a11 6b02          	ld	(OFST-3,sp),a
5099                     ; 742 adr0=(char)((memo_addr)&0x00ff);
5101  0a13 7b0c          	ld	a,(OFST+7,sp)
5102  0a15 a4ff          	and	a,#255
5103  0a17 6b01          	ld	(OFST-4,sp),a
5104                     ; 743 ST_CS_ON
5106  0a19 721b5005      	bres	20485,#5
5107                     ; 745 spi(0x02);
5109  0a1d a602          	ld	a,#2
5110  0a1f 8d7a097a      	callf	f_spi
5112                     ; 746 spi(adr2);
5114  0a23 7b03          	ld	a,(OFST-2,sp)
5115  0a25 8d7a097a      	callf	f_spi
5117                     ; 747 spi(adr1);
5119  0a29 7b02          	ld	a,(OFST-3,sp)
5120  0a2b 8d7a097a      	callf	f_spi
5122                     ; 748 spi(adr0);
5124  0a2f 7b01          	ld	a,(OFST-4,sp)
5125  0a31 8d7a097a      	callf	f_spi
5127                     ; 750 for(i=0;i<len;i++)
5129  0a35 5f            	clrw	x
5130  0a36 1f04          	ldw	(OFST-1,sp),x
5132  0a38 2011          	jra	L5642
5133  0a3a               L1642:
5134                     ; 752 	spi(adr[i]);
5136  0a3a 1e0f          	ldw	x,(OFST+10,sp)
5137  0a3c 72fb04        	addw	x,(OFST-1,sp)
5138  0a3f f6            	ld	a,(x)
5139  0a40 8d7a097a      	callf	f_spi
5141                     ; 750 for(i=0;i<len;i++)
5143  0a44 1e04          	ldw	x,(OFST-1,sp)
5144  0a46 1c0001        	addw	x,#1
5145  0a49 1f04          	ldw	(OFST-1,sp),x
5146  0a4b               L5642:
5149  0a4b 1e04          	ldw	x,(OFST-1,sp)
5150  0a4d 130d          	cpw	x,(OFST+8,sp)
5151  0a4f 25e9          	jrult	L1642
5152                     ; 755 ST_CS_OFF
5154  0a51 721a5005      	bset	20485,#5
5155                     ; 756 }
5158  0a55 5b05          	addw	sp,#5
5159  0a57 87            	retf
5248                     ; 759 void ST_READ(unsigned long memo_addr,unsigned short len, char* adr)
5248                     ; 760 {
5249                     	switch	.text
5250  0a58               f_ST_READ:
5252  0a58 5205          	subw	sp,#5
5253       00000005      OFST:	set	5
5256                     ; 766 adr2=(char)(memo_addr>>16);
5258  0a5a 7b0a          	ld	a,(OFST+5,sp)
5259  0a5c 6b03          	ld	(OFST-2,sp),a
5260                     ; 767 adr1=(char)((memo_addr>>8)&0x00ff);
5262  0a5e 7b0b          	ld	a,(OFST+6,sp)
5263  0a60 a4ff          	and	a,#255
5264  0a62 6b02          	ld	(OFST-3,sp),a
5265                     ; 768 adr0=(char)((memo_addr)&0x00ff);
5267  0a64 7b0c          	ld	a,(OFST+7,sp)
5268  0a66 a4ff          	and	a,#255
5269  0a68 6b01          	ld	(OFST-4,sp),a
5270                     ; 769 ST_CS_ON
5272  0a6a 721b5005      	bres	20485,#5
5273                     ; 770 spi(0x03);
5275  0a6e a603          	ld	a,#3
5276  0a70 8d7a097a      	callf	f_spi
5278                     ; 771 spi(adr2);
5280  0a74 7b03          	ld	a,(OFST-2,sp)
5281  0a76 8d7a097a      	callf	f_spi
5283                     ; 772 spi(adr1);
5285  0a7a 7b02          	ld	a,(OFST-3,sp)
5286  0a7c 8d7a097a      	callf	f_spi
5288                     ; 773 spi(adr0);
5290  0a80 7b01          	ld	a,(OFST-4,sp)
5291  0a82 8d7a097a      	callf	f_spi
5293                     ; 775 for(i=0;i<len;i++)
5295  0a86 5f            	clrw	x
5296  0a87 1f04          	ldw	(OFST-1,sp),x
5298  0a89 2013          	jra	L3452
5299  0a8b               L7352:
5300                     ; 777 	adr[i]=spi(0xff);
5302  0a8b a6ff          	ld	a,#255
5303  0a8d 8d7a097a      	callf	f_spi
5305  0a91 1e0f          	ldw	x,(OFST+10,sp)
5306  0a93 72fb04        	addw	x,(OFST-1,sp)
5307  0a96 f7            	ld	(x),a
5308                     ; 775 for(i=0;i<len;i++)
5310  0a97 1e04          	ldw	x,(OFST-1,sp)
5311  0a99 1c0001        	addw	x,#1
5312  0a9c 1f04          	ldw	(OFST-1,sp),x
5313  0a9e               L3452:
5316  0a9e 1e04          	ldw	x,(OFST-1,sp)
5317  0aa0 130d          	cpw	x,(OFST+8,sp)
5318  0aa2 25e7          	jrult	L7352
5319                     ; 780 ST_CS_OFF
5321  0aa4 721a5005      	bset	20485,#5
5322                     ; 781 }
5325  0aa8 5b05          	addw	sp,#5
5326  0aaa 87            	retf
5391                     ; 785 long DF_mf_dev_read(void)
5391                     ; 786 {
5392                     	switch	.text
5393  0aab               f_DF_mf_dev_read:
5395  0aab 5204          	subw	sp,#4
5396       00000004      OFST:	set	4
5399                     ; 789 d0=0;
5401  0aad 0f04          	clr	(OFST+0,sp)
5402                     ; 790 d1=0;
5404                     ; 791 d2=0;
5406                     ; 792 d3=0;
5408                     ; 794 CS_ON
5410  0aaf 7217500a      	bres	20490,#3
5411                     ; 795 spi(0x9f);
5413  0ab3 a69f          	ld	a,#159
5414  0ab5 8d7a097a      	callf	f_spi
5416                     ; 796 mdr0=spi(0xff);
5418  0ab9 a6ff          	ld	a,#255
5419  0abb 8d7a097a      	callf	f_spi
5421  0abf b716          	ld	_mdr0,a
5422                     ; 797 mdr1=spi(0xff);
5424  0ac1 a6ff          	ld	a,#255
5425  0ac3 8d7a097a      	callf	f_spi
5427  0ac7 b715          	ld	_mdr1,a
5428                     ; 798 mdr2=spi(0xff);
5430  0ac9 a6ff          	ld	a,#255
5431  0acb 8d7a097a      	callf	f_spi
5433  0acf b714          	ld	_mdr2,a
5434                     ; 799 mdr3=spi(0xff);  
5436  0ad1 a6ff          	ld	a,#255
5437  0ad3 8d7a097a      	callf	f_spi
5439  0ad7 b713          	ld	_mdr3,a
5440                     ; 801 CS_OFF
5442  0ad9 7216500a      	bset	20490,#3
5443                     ; 802 return  *((long*)&d0);
5445  0add 96            	ldw	x,sp
5446  0ade 1c0004        	addw	x,#OFST+0
5447  0ae1 8d000000      	callf	d_ltor
5451  0ae5 5b04          	addw	sp,#4
5452  0ae7 87            	retf
5475                     ; 806 void DF_memo_to_256(void)
5475                     ; 807 {
5476                     	switch	.text
5477  0ae8               f_DF_memo_to_256:
5481                     ; 809 CS_ON
5483  0ae8 7217500a      	bres	20490,#3
5484                     ; 810 spi(0x3d);
5486  0aec a63d          	ld	a,#61
5487  0aee 8d7a097a      	callf	f_spi
5489                     ; 811 spi(0x2a); 
5491  0af2 a62a          	ld	a,#42
5492  0af4 8d7a097a      	callf	f_spi
5494                     ; 812 spi(0x80);
5496  0af8 a680          	ld	a,#128
5497  0afa 8d7a097a      	callf	f_spi
5499                     ; 813 spi(0xa6);
5501  0afe a6a6          	ld	a,#166
5502  0b00 8d7a097a      	callf	f_spi
5504                     ; 815 CS_OFF
5506  0b04 7216500a      	bset	20490,#3
5507                     ; 816 }  
5510  0b08 87            	retf
5544                     ; 821 char DF_status_read(void)
5544                     ; 822 {
5545                     	switch	.text
5546  0b09               f_DF_status_read:
5548  0b09 88            	push	a
5549       00000001      OFST:	set	1
5552                     ; 826 CS_ON
5554  0b0a 7217500a      	bres	20490,#3
5555                     ; 827 spi(0xd7);
5557  0b0e a6d7          	ld	a,#215
5558  0b10 8d7a097a      	callf	f_spi
5560                     ; 828 d0=spi(0xff);
5562  0b14 a6ff          	ld	a,#255
5563  0b16 8d7a097a      	callf	f_spi
5565  0b1a 6b01          	ld	(OFST+0,sp),a
5566                     ; 830 CS_OFF
5568  0b1c 7216500a      	bset	20490,#3
5569                     ; 831 return d0;
5571  0b20 7b01          	ld	a,(OFST+0,sp)
5574  0b22 5b01          	addw	sp,#1
5575  0b24 87            	retf
5618                     ; 835 void DF_page_to_buffer(unsigned page_addr)
5618                     ; 836 {
5619                     	switch	.text
5620  0b25               f_DF_page_to_buffer:
5622  0b25 89            	pushw	x
5623  0b26 88            	push	a
5624       00000001      OFST:	set	1
5627                     ; 839 d0=0x53; 
5629                     ; 843 CS_ON
5631  0b27 7217500a      	bres	20490,#3
5632                     ; 844 spi(d0);
5634  0b2b a653          	ld	a,#83
5635  0b2d 8d7a097a      	callf	f_spi
5637                     ; 845 spi(page_addr/256/**(((char*)&page_addr)+1)*/);
5639  0b31 7b02          	ld	a,(OFST+1,sp)
5640  0b33 8d7a097a      	callf	f_spi
5642                     ; 846 spi(page_addr%256/**((char*)&page_addr)*/);
5644  0b37 7b03          	ld	a,(OFST+2,sp)
5645  0b39 a4ff          	and	a,#255
5646  0b3b 8d7a097a      	callf	f_spi
5648                     ; 847 spi(0xff);
5650  0b3f a6ff          	ld	a,#255
5651  0b41 8d7a097a      	callf	f_spi
5653                     ; 849 CS_OFF
5655  0b45 7216500a      	bset	20490,#3
5656                     ; 850 }
5659  0b49 5b03          	addw	sp,#3
5660  0b4b 87            	retf
5704                     ; 853 void DF_buffer_to_page_er(/*char buff,*/unsigned page_addr)
5704                     ; 854 {
5705                     	switch	.text
5706  0b4c               f_DF_buffer_to_page_er:
5708  0b4c 89            	pushw	x
5709  0b4d 88            	push	a
5710       00000001      OFST:	set	1
5713                     ; 857 d0=0x83; 
5715                     ; 860 CS_ON
5717  0b4e 7217500a      	bres	20490,#3
5718                     ; 861 spi(d0);
5720  0b52 a683          	ld	a,#131
5721  0b54 8d7a097a      	callf	f_spi
5723                     ; 862 spi(page_addr/256/**(((char*)&page_addr)+1)*/);
5725  0b58 7b02          	ld	a,(OFST+1,sp)
5726  0b5a 8d7a097a      	callf	f_spi
5728                     ; 863 spi(page_addr%256/**((char*)&page_addr)*/);
5730  0b5e 7b03          	ld	a,(OFST+2,sp)
5731  0b60 a4ff          	and	a,#255
5732  0b62 8d7a097a      	callf	f_spi
5734                     ; 864 spi(0xff);
5736  0b66 a6ff          	ld	a,#255
5737  0b68 8d7a097a      	callf	f_spi
5739                     ; 866 CS_OFF
5741  0b6c 7216500a      	bset	20490,#3
5742                     ; 867 }
5745  0b70 5b03          	addw	sp,#3
5746  0b72 87            	retf
5817                     ; 870 void DF_buffer_read(unsigned buff_addr,unsigned len, char* adr)
5817                     ; 871 {
5818                     	switch	.text
5819  0b73               f_DF_buffer_read:
5821  0b73 89            	pushw	x
5822  0b74 5203          	subw	sp,#3
5823       00000003      OFST:	set	3
5826                     ; 875 d0=0x54; 
5828                     ; 877 CS_ON
5830  0b76 7217500a      	bres	20490,#3
5831                     ; 878 spi(d0);
5833  0b7a a654          	ld	a,#84
5834  0b7c 8d7a097a      	callf	f_spi
5836                     ; 879 spi(0xff);
5838  0b80 a6ff          	ld	a,#255
5839  0b82 8d7a097a      	callf	f_spi
5841                     ; 880 spi(buff_addr/256/**(((char*)&buff_addr)+1)*/);
5843  0b86 7b04          	ld	a,(OFST+1,sp)
5844  0b88 8d7a097a      	callf	f_spi
5846                     ; 881 spi(buff_addr%256/**((char*)&buff_addr)*/);
5848  0b8c 7b05          	ld	a,(OFST+2,sp)
5849  0b8e a4ff          	and	a,#255
5850  0b90 8d7a097a      	callf	f_spi
5852                     ; 882 spi(0xff);
5854  0b94 a6ff          	ld	a,#255
5855  0b96 8d7a097a      	callf	f_spi
5857                     ; 883 for(i=0;i<len;i++)
5859  0b9a 5f            	clrw	x
5860  0b9b 1f02          	ldw	(OFST-1,sp),x
5862  0b9d 2013          	jra	L5372
5863  0b9f               L1372:
5864                     ; 885 	adr[i]=spi(0xff);
5866  0b9f a6ff          	ld	a,#255
5867  0ba1 8d7a097a      	callf	f_spi
5869  0ba5 1e0b          	ldw	x,(OFST+8,sp)
5870  0ba7 72fb02        	addw	x,(OFST-1,sp)
5871  0baa f7            	ld	(x),a
5872                     ; 883 for(i=0;i<len;i++)
5874  0bab 1e02          	ldw	x,(OFST-1,sp)
5875  0bad 1c0001        	addw	x,#1
5876  0bb0 1f02          	ldw	(OFST-1,sp),x
5877  0bb2               L5372:
5880  0bb2 1e02          	ldw	x,(OFST-1,sp)
5881  0bb4 1309          	cpw	x,(OFST+6,sp)
5882  0bb6 25e7          	jrult	L1372
5883                     ; 888 CS_OFF
5885  0bb8 7216500a      	bset	20490,#3
5886                     ; 889 }
5889  0bbc 5b05          	addw	sp,#5
5890  0bbe 87            	retf
5961                     ; 892 void DF_buffer_write(/*char buff,*/unsigned buff_addr,unsigned len, char* adr)
5961                     ; 893 {
5962                     	switch	.text
5963  0bbf               f_DF_buffer_write:
5965  0bbf 89            	pushw	x
5966  0bc0 5203          	subw	sp,#3
5967       00000003      OFST:	set	3
5970                     ; 897 d0=0x84; 
5972                     ; 899 CS_ON
5974  0bc2 7217500a      	bres	20490,#3
5975                     ; 900 spi(d0);
5977  0bc6 a684          	ld	a,#132
5978  0bc8 8d7a097a      	callf	f_spi
5980                     ; 901 spi(0xff);
5982  0bcc a6ff          	ld	a,#255
5983  0bce 8d7a097a      	callf	f_spi
5985                     ; 902 spi(buff_addr/256/**(((char*)&buff_addr)+1)*/);
5987  0bd2 7b04          	ld	a,(OFST+1,sp)
5988  0bd4 8d7a097a      	callf	f_spi
5990                     ; 903 spi(buff_addr%256/**((char*)&buff_addr)*/);
5992  0bd8 7b05          	ld	a,(OFST+2,sp)
5993  0bda a4ff          	and	a,#255
5994  0bdc 8d7a097a      	callf	f_spi
5996                     ; 905 for(i=0;i<len;i++)
5998  0be0 5f            	clrw	x
5999  0be1 1f02          	ldw	(OFST-1,sp),x
6001  0be3 2011          	jra	L3003
6002  0be5               L7772:
6003                     ; 907 	spi(adr[i]);
6005  0be5 1e0b          	ldw	x,(OFST+8,sp)
6006  0be7 72fb02        	addw	x,(OFST-1,sp)
6007  0bea f6            	ld	a,(x)
6008  0beb 8d7a097a      	callf	f_spi
6010                     ; 905 for(i=0;i<len;i++)
6012  0bef 1e02          	ldw	x,(OFST-1,sp)
6013  0bf1 1c0001        	addw	x,#1
6014  0bf4 1f02          	ldw	(OFST-1,sp),x
6015  0bf6               L3003:
6018  0bf6 1e02          	ldw	x,(OFST-1,sp)
6019  0bf8 1309          	cpw	x,(OFST+6,sp)
6020  0bfa 25e9          	jrult	L7772
6021                     ; 910 CS_OFF
6023  0bfc 7216500a      	bset	20490,#3
6024                     ; 911 }
6027  0c00 5b05          	addw	sp,#5
6028  0c02 87            	retf
6050                     ; 933 void gpio_init(void){
6051                     	switch	.text
6052  0c03               f_gpio_init:
6056                     ; 943 	GPIOD->DDR|=(1<<2);
6058  0c03 72145011      	bset	20497,#2
6059                     ; 944 	GPIOD->CR1|=(1<<2);
6061  0c07 72145012      	bset	20498,#2
6062                     ; 945 	GPIOD->CR2|=(1<<2);
6064  0c0b 72145013      	bset	20499,#2
6065                     ; 946 	GPIOD->ODR&=~(1<<2);
6067  0c0f 7215500f      	bres	20495,#2
6068                     ; 948 	GPIOD->DDR|=(1<<4);
6070  0c13 72185011      	bset	20497,#4
6071                     ; 949 	GPIOD->CR1|=(1<<4);
6073  0c17 72185012      	bset	20498,#4
6074                     ; 950 	GPIOD->CR2&=~(1<<4);
6076  0c1b 72195013      	bres	20499,#4
6077                     ; 952 	GPIOC->DDR&=~(1<<4);
6079  0c1f 7219500c      	bres	20492,#4
6080                     ; 953 	GPIOC->CR1&=~(1<<4);
6082  0c23 7219500d      	bres	20493,#4
6083                     ; 954 	GPIOC->CR2&=~(1<<4);
6085  0c27 7219500e      	bres	20494,#4
6086                     ; 958 }
6089  0c2b 87            	retf
6140                     ; 961 void uart_in(void)
6140                     ; 962 {
6141                     	switch	.text
6142  0c2c               f_uart_in:
6144  0c2c 89            	pushw	x
6145       00000002      OFST:	set	2
6148                     ; 966 if(rx_buffer_overflow)
6150                     	btst	_rx_buffer_overflow
6151  0c32 240d          	jruge	L1403
6152                     ; 968 	rx_wr_index=0;
6154  0c34 5f            	clrw	x
6155  0c35 bf1a          	ldw	_rx_wr_index,x
6156                     ; 969 	rx_rd_index=0;
6158  0c37 5f            	clrw	x
6159  0c38 bf18          	ldw	_rx_rd_index,x
6160                     ; 970 	rx_counter=0;
6162  0c3a 5f            	clrw	x
6163  0c3b bf1c          	ldw	_rx_counter,x
6164                     ; 971 	rx_buffer_overflow=0;
6166  0c3d 72110001      	bres	_rx_buffer_overflow
6167  0c41               L1403:
6168                     ; 974 if(rx_counter&&(rx_buffer[index_offset(rx_wr_index,-1)])==END)
6170  0c41 be1c          	ldw	x,_rx_counter
6171  0c43 2604accb0ccb  	jreq	L3403
6173  0c49 aeffff        	ldw	x,#65535
6174  0c4c 89            	pushw	x
6175  0c4d be1a          	ldw	x,_rx_wr_index
6176  0c4f 8dcd0ccd      	callf	f_index_offset
6178  0c53 5b02          	addw	sp,#2
6179  0c55 e654          	ld	a,(_rx_buffer,x)
6180  0c57 a10a          	cp	a,#10
6181  0c59 2670          	jrne	L3403
6182                     ; 979 	temp=rx_buffer[index_offset(rx_wr_index,-3)];
6184  0c5b aefffd        	ldw	x,#65533
6185  0c5e 89            	pushw	x
6186  0c5f be1a          	ldw	x,_rx_wr_index
6187  0c61 8dcd0ccd      	callf	f_index_offset
6189  0c65 5b02          	addw	sp,#2
6190  0c67 e654          	ld	a,(_rx_buffer,x)
6191  0c69 6b01          	ld	(OFST-1,sp),a
6192                     ; 980     	if(temp<100) 
6194  0c6b 7b01          	ld	a,(OFST-1,sp)
6195  0c6d a164          	cp	a,#100
6196  0c6f 245a          	jruge	L3403
6197                     ; 983     		if(control_check(index_offset(rx_wr_index,-1)))
6199  0c71 aeffff        	ldw	x,#65535
6200  0c74 89            	pushw	x
6201  0c75 be1a          	ldw	x,_rx_wr_index
6202  0c77 8dcd0ccd      	callf	f_index_offset
6204  0c7b 5b02          	addw	sp,#2
6205  0c7d 9f            	ld	a,xl
6206  0c7e 8df50cf5      	callf	f_control_check
6208  0c82 4d            	tnz	a
6209  0c83 2746          	jreq	L3403
6210                     ; 986     			rx_rd_index=index_offset(rx_wr_index,-3-temp);
6212  0c85 a6ff          	ld	a,#255
6213  0c87 97            	ld	xl,a
6214  0c88 a6fd          	ld	a,#253
6215  0c8a 1001          	sub	a,(OFST-1,sp)
6216  0c8c 2401          	jrnc	L241
6217  0c8e 5a            	decw	x
6218  0c8f               L241:
6219  0c8f 02            	rlwa	x,a
6220  0c90 89            	pushw	x
6221  0c91 01            	rrwa	x,a
6222  0c92 be1a          	ldw	x,_rx_wr_index
6223  0c94 8dcd0ccd      	callf	f_index_offset
6225  0c98 5b02          	addw	sp,#2
6226  0c9a bf18          	ldw	_rx_rd_index,x
6227                     ; 987     			for(i=0;i<temp;i++)
6229  0c9c 0f02          	clr	(OFST+0,sp)
6231  0c9e 201a          	jra	L5503
6232  0ca0               L1503:
6233                     ; 989 				UIB[i]=rx_buffer[index_offset(rx_rd_index,i)];
6235  0ca0 7b02          	ld	a,(OFST+0,sp)
6236  0ca2 5f            	clrw	x
6237  0ca3 97            	ld	xl,a
6238  0ca4 89            	pushw	x
6239  0ca5 7b04          	ld	a,(OFST+2,sp)
6240  0ca7 5f            	clrw	x
6241  0ca8 97            	ld	xl,a
6242  0ca9 89            	pushw	x
6243  0caa be18          	ldw	x,_rx_rd_index
6244  0cac 8dcd0ccd      	callf	f_index_offset
6246  0cb0 5b02          	addw	sp,#2
6247  0cb2 e654          	ld	a,(_rx_buffer,x)
6248  0cb4 85            	popw	x
6249  0cb5 d70000        	ld	(_UIB,x),a
6250                     ; 987     			for(i=0;i<temp;i++)
6252  0cb8 0c02          	inc	(OFST+0,sp)
6253  0cba               L5503:
6256  0cba 7b02          	ld	a,(OFST+0,sp)
6257  0cbc 1101          	cp	a,(OFST-1,sp)
6258  0cbe 25e0          	jrult	L1503
6259                     ; 991 			rx_rd_index=rx_wr_index;
6261  0cc0 be1a          	ldw	x,_rx_wr_index
6262  0cc2 bf18          	ldw	_rx_rd_index,x
6263                     ; 992 			rx_counter=0;
6265  0cc4 5f            	clrw	x
6266  0cc5 bf1c          	ldw	_rx_counter,x
6267                     ; 1002 			uart_in_an();
6269  0cc7 8d500250      	callf	f_uart_in_an
6271  0ccb               L3403:
6272                     ; 1011 }
6275  0ccb 85            	popw	x
6276  0ccc 87            	retf
6318                     ; 1014 signed short index_offset (signed short index,signed short offset)
6318                     ; 1015 {
6319                     	switch	.text
6320  0ccd               f_index_offset:
6322  0ccd 89            	pushw	x
6323       00000000      OFST:	set	0
6326                     ; 1016 index=index+offset;
6328  0cce 1e01          	ldw	x,(OFST+1,sp)
6329  0cd0 72fb06        	addw	x,(OFST+6,sp)
6330  0cd3 1f01          	ldw	(OFST+1,sp),x
6331                     ; 1017 if(index>=RX_BUFFER_SIZE) index-=RX_BUFFER_SIZE; 
6333  0cd5 9c            	rvf
6334  0cd6 1e01          	ldw	x,(OFST+1,sp)
6335  0cd8 a30064        	cpw	x,#100
6336  0cdb 2f07          	jrslt	L3013
6339  0cdd 1e01          	ldw	x,(OFST+1,sp)
6340  0cdf 1d0064        	subw	x,#100
6341  0ce2 1f01          	ldw	(OFST+1,sp),x
6342  0ce4               L3013:
6343                     ; 1018 if(index<0) index+=RX_BUFFER_SIZE;
6345  0ce4 9c            	rvf
6346  0ce5 1e01          	ldw	x,(OFST+1,sp)
6347  0ce7 2e07          	jrsge	L5013
6350  0ce9 1e01          	ldw	x,(OFST+1,sp)
6351  0ceb 1c0064        	addw	x,#100
6352  0cee 1f01          	ldw	(OFST+1,sp),x
6353  0cf0               L5013:
6354                     ; 1019 return index;
6356  0cf0 1e01          	ldw	x,(OFST+1,sp)
6359  0cf2 5b02          	addw	sp,#2
6360  0cf4 87            	retf
6422                     ; 1023 char control_check(char index)
6422                     ; 1024 {
6423                     	switch	.text
6424  0cf5               f_control_check:
6426  0cf5 88            	push	a
6427  0cf6 5203          	subw	sp,#3
6428       00000003      OFST:	set	3
6431                     ; 1025 char i=0,ii=0,iii;
6435                     ; 1027 if(rx_buffer[index]!=END) return 0;
6437  0cf8 5f            	clrw	x
6438  0cf9 97            	ld	xl,a
6439  0cfa e654          	ld	a,(_rx_buffer,x)
6440  0cfc a10a          	cp	a,#10
6441  0cfe 2703          	jreq	L1413
6444  0d00 4f            	clr	a
6446  0d01 2057          	jra	L451
6447  0d03               L1413:
6448                     ; 1029 ii=rx_buffer[index_offset(index,-2)];
6450  0d03 aefffe        	ldw	x,#65534
6451  0d06 89            	pushw	x
6452  0d07 7b06          	ld	a,(OFST+3,sp)
6453  0d09 5f            	clrw	x
6454  0d0a 97            	ld	xl,a
6455  0d0b 8dcd0ccd      	callf	f_index_offset
6457  0d0f 5b02          	addw	sp,#2
6458  0d11 e654          	ld	a,(_rx_buffer,x)
6459  0d13 6b02          	ld	(OFST-1,sp),a
6460                     ; 1030 iii=0;
6462  0d15 0f01          	clr	(OFST-2,sp)
6463                     ; 1031 for(i=0;i<=ii;i++)
6465  0d17 0f03          	clr	(OFST+0,sp)
6467  0d19 2024          	jra	L7413
6468  0d1b               L3413:
6469                     ; 1033 	iii^=rx_buffer[index_offset(index,-2-ii+i)];
6471  0d1b a6ff          	ld	a,#255
6472  0d1d 97            	ld	xl,a
6473  0d1e a6fe          	ld	a,#254
6474  0d20 1002          	sub	a,(OFST-1,sp)
6475  0d22 2401          	jrnc	L051
6476  0d24 5a            	decw	x
6477  0d25               L051:
6478  0d25 1b03          	add	a,(OFST+0,sp)
6479  0d27 2401          	jrnc	L251
6480  0d29 5c            	incw	x
6481  0d2a               L251:
6482  0d2a 02            	rlwa	x,a
6483  0d2b 89            	pushw	x
6484  0d2c 01            	rrwa	x,a
6485  0d2d 7b06          	ld	a,(OFST+3,sp)
6486  0d2f 5f            	clrw	x
6487  0d30 97            	ld	xl,a
6488  0d31 8dcd0ccd      	callf	f_index_offset
6490  0d35 5b02          	addw	sp,#2
6491  0d37 7b01          	ld	a,(OFST-2,sp)
6492  0d39 e854          	xor	a,	(_rx_buffer,x)
6493  0d3b 6b01          	ld	(OFST-2,sp),a
6494                     ; 1031 for(i=0;i<=ii;i++)
6496  0d3d 0c03          	inc	(OFST+0,sp)
6497  0d3f               L7413:
6500  0d3f 7b03          	ld	a,(OFST+0,sp)
6501  0d41 1102          	cp	a,(OFST-1,sp)
6502  0d43 23d6          	jrule	L3413
6503                     ; 1035 if (iii!=rx_buffer[index_offset(index,-1)]) return 0;	
6505  0d45 aeffff        	ldw	x,#65535
6506  0d48 89            	pushw	x
6507  0d49 7b06          	ld	a,(OFST+3,sp)
6508  0d4b 5f            	clrw	x
6509  0d4c 97            	ld	xl,a
6510  0d4d 8dcd0ccd      	callf	f_index_offset
6512  0d51 5b02          	addw	sp,#2
6513  0d53 e654          	ld	a,(_rx_buffer,x)
6514  0d55 1101          	cp	a,(OFST-2,sp)
6515  0d57 2704          	jreq	L3513
6518  0d59 4f            	clr	a
6520  0d5a               L451:
6522  0d5a 5b04          	addw	sp,#4
6523  0d5c 87            	retf
6524  0d5d               L3513:
6525                     ; 1037 return 1;
6527  0d5d a601          	ld	a,#1
6529  0d5f 20f9          	jra	L451
6570                     ; 1046 @far @interrupt void TIM4_UPD_Interrupt (void) {
6571                     	switch	.text
6572  0d61               f_TIM4_UPD_Interrupt:
6576                     ; 1048 	if(play) {
6578                     	btst	_play
6579  0d66 2445          	jruge	L5613
6580                     ; 1049 		TIM2->CCR3H= 0x00;	
6582  0d68 725f5315      	clr	21269
6583                     ; 1050 		TIM2->CCR3L= sample;
6585  0d6c 5500175316    	mov	21270,_sample
6586                     ; 1051 		sample_cnt++;
6588  0d71 be21          	ldw	x,_sample_cnt
6589  0d73 1c0001        	addw	x,#1
6590  0d76 bf21          	ldw	_sample_cnt,x
6591                     ; 1052 		if(sample_cnt>=256) {
6593  0d78 9c            	rvf
6594  0d79 be21          	ldw	x,_sample_cnt
6595  0d7b a30100        	cpw	x,#256
6596  0d7e 2f03          	jrslt	L7613
6597                     ; 1053 			sample_cnt=0;
6599  0d80 5f            	clrw	x
6600  0d81 bf21          	ldw	_sample_cnt,x
6601  0d83               L7613:
6602                     ; 1057 		sample=buff[sample_cnt];
6604  0d83 be21          	ldw	x,_sample_cnt
6605  0d85 d60050        	ld	a,(_buff,x)
6606  0d88 b717          	ld	_sample,a
6607                     ; 1059 		if(sample_cnt==132)	{
6609  0d8a be21          	ldw	x,_sample_cnt
6610  0d8c a30084        	cpw	x,#132
6611  0d8f 2604          	jrne	L1713
6612                     ; 1060 			bBUFF_LOAD=1;
6614  0d91 7210000b      	bset	_bBUFF_LOAD
6615  0d95               L1713:
6616                     ; 1064 		if(sample_cnt==5) {
6618  0d95 be21          	ldw	x,_sample_cnt
6619  0d97 a30005        	cpw	x,#5
6620  0d9a 2604          	jrne	L3713
6621                     ; 1065 			bBUFF_READ_H=1;
6623  0d9c 7210000a      	bset	_bBUFF_READ_H
6624  0da0               L3713:
6625                     ; 1068 		if(sample_cnt==150) {
6627  0da0 be21          	ldw	x,_sample_cnt
6628  0da2 a30096        	cpw	x,#150
6629  0da5 2615          	jrne	L7713
6630                     ; 1069 			bBUFF_READ_L=1;
6632  0da7 72100009      	bset	_bBUFF_READ_L
6633  0dab 200f          	jra	L7713
6634  0dad               L5613:
6635                     ; 1076 	else if(!bSTART) {
6637                     	btst	_bSTART
6638  0db2 2508          	jrult	L7713
6639                     ; 1077 		TIM2->CCR3H= 0x00;	
6641  0db4 725f5315      	clr	21269
6642                     ; 1078 		TIM2->CCR3L= 0x7f;//pwm_fade_in;
6644  0db8 357f5316      	mov	21270,#127
6645  0dbc               L7713:
6646                     ; 1133 		if(but_block_cnt)but_on_drv_cnt=0;
6648  0dbc be00          	ldw	x,_but_block_cnt
6649  0dbe 2702          	jreq	L3023
6652  0dc0 3fb9          	clr	_but_on_drv_cnt
6653  0dc2               L3023:
6654                     ; 1134 		if((((GPIOC->IDR)&(1<<4))) && (but_on_drv_cnt<100)) {
6656  0dc2 c6500b        	ld	a,20491
6657  0dc5 a510          	bcp	a,#16
6658  0dc7 271f          	jreq	L5023
6660  0dc9 b6b9          	ld	a,_but_on_drv_cnt
6661  0dcb a164          	cp	a,#100
6662  0dcd 2419          	jruge	L5023
6663                     ; 1135 			but_on_drv_cnt++;
6665  0dcf 3cb9          	inc	_but_on_drv_cnt
6666                     ; 1136 			if((but_on_drv_cnt>2)&&(bRELEASE))
6668  0dd1 b6b9          	ld	a,_but_on_drv_cnt
6669  0dd3 a103          	cp	a,#3
6670  0dd5 2517          	jrult	L1123
6672                     	btst	_bRELEASE
6673  0ddc 2410          	jruge	L1123
6674                     ; 1138 				bRELEASE=0;
6676  0dde 72110000      	bres	_bRELEASE
6677                     ; 1139 				bSTART=1;
6679  0de2 7210000c      	bset	_bSTART
6680  0de6 2006          	jra	L1123
6681  0de8               L5023:
6682                     ; 1143 			but_on_drv_cnt=0;
6684  0de8 3fb9          	clr	_but_on_drv_cnt
6685                     ; 1144 			bRELEASE=1;
6687  0dea 72100000      	bset	_bRELEASE
6688  0dee               L1123:
6689                     ; 1149 	if(++t0_cnt0>=125){
6691  0dee 3c00          	inc	_t0_cnt0
6692  0df0 b600          	ld	a,_t0_cnt0
6693  0df2 a17d          	cp	a,#125
6694  0df4 2530          	jrult	L3123
6695                     ; 1150     		t0_cnt0=0;
6697  0df6 3f00          	clr	_t0_cnt0
6698                     ; 1151     		b100Hz=1;
6700  0df8 72100008      	bset	_b100Hz
6701                     ; 1161 		if(++t0_cnt1>=10){
6703  0dfc 3c01          	inc	_t0_cnt1
6704  0dfe b601          	ld	a,_t0_cnt1
6705  0e00 a10a          	cp	a,#10
6706  0e02 2506          	jrult	L5123
6707                     ; 1162 			t0_cnt1=0;
6709  0e04 3f01          	clr	_t0_cnt1
6710                     ; 1163 			b10Hz=1;
6712  0e06 72100007      	bset	_b10Hz
6713  0e0a               L5123:
6714                     ; 1166 		if(++t0_cnt2>=20){
6716  0e0a 3c02          	inc	_t0_cnt2
6717  0e0c b602          	ld	a,_t0_cnt2
6718  0e0e a114          	cp	a,#20
6719  0e10 2506          	jrult	L7123
6720                     ; 1167 			t0_cnt2=0;
6722  0e12 3f02          	clr	_t0_cnt2
6723                     ; 1168 			b5Hz=1;
6725  0e14 72100006      	bset	_b5Hz
6726  0e18               L7123:
6727                     ; 1171 		if(++t0_cnt3>=100){
6729  0e18 3c03          	inc	_t0_cnt3
6730  0e1a b603          	ld	a,_t0_cnt3
6731  0e1c a164          	cp	a,#100
6732  0e1e 2506          	jrult	L3123
6733                     ; 1172 			t0_cnt3=0;
6735  0e20 3f03          	clr	_t0_cnt3
6736                     ; 1173 			b1Hz=1;
6738  0e22 72100005      	bset	_b1Hz
6739  0e26               L3123:
6740                     ; 1177 	TIM4->SR1&=~TIM4_SR1_UIF;			// disable break interrupt
6742  0e26 72115344      	bres	21316,#0
6743                     ; 1178 	return;
6746  0e2a 80            	iret
6772                     ; 1182 @far @interrupt void UARTTxInterrupt (void) {
6773                     	switch	.text
6774  0e2b               f_UARTTxInterrupt:
6778                     ; 1184 	if (tx_counter){
6780  0e2b 3d20          	tnz	_tx_counter
6781  0e2d 271a          	jreq	L3323
6782                     ; 1185 		--tx_counter;
6784  0e2f 3a20          	dec	_tx_counter
6785                     ; 1186 		UART1->DR=tx_buffer[tx_rd_index];
6787  0e31 5f            	clrw	x
6788  0e32 b61e          	ld	a,_tx_rd_index
6789  0e34 2a01          	jrpl	L261
6790  0e36 53            	cplw	x
6791  0e37               L261:
6792  0e37 97            	ld	xl,a
6793  0e38 e604          	ld	a,(_tx_buffer,x)
6794  0e3a c75231        	ld	21041,a
6795                     ; 1187 		if (++tx_rd_index == TX_BUFFER_SIZE) tx_rd_index=0;
6797  0e3d 3c1e          	inc	_tx_rd_index
6798  0e3f b61e          	ld	a,_tx_rd_index
6799  0e41 a150          	cp	a,#80
6800  0e43 260c          	jrne	L7323
6803  0e45 3f1e          	clr	_tx_rd_index
6804  0e47 2008          	jra	L7323
6805  0e49               L3323:
6806                     ; 1190 		bOUT_FREE=1;
6808  0e49 72100003      	bset	_bOUT_FREE
6809                     ; 1191 		UART1->CR2&= ~UART1_CR2_TIEN;
6811  0e4d 721f5235      	bres	21045,#7
6812  0e51               L7323:
6813                     ; 1193 }
6816  0e51 80            	iret
6845                     ; 1196 @far @interrupt void UARTRxInterrupt (void) {
6846                     	switch	.text
6847  0e52               f_UARTRxInterrupt:
6851                     ; 1201 	rx_status=UART1->SR;
6853  0e52 5552300006    	mov	_rx_status,21040
6854                     ; 1202 	rx_data=UART1->DR;
6856  0e57 5552310005    	mov	_rx_data,21041
6857                     ; 1204 	if (rx_status & (UART1_SR_RXNE)){
6859  0e5c b606          	ld	a,_rx_status
6860  0e5e a520          	bcp	a,#32
6861  0e60 272c          	jreq	L1523
6862                     ; 1205 		rx_buffer[rx_wr_index]=rx_data;
6864  0e62 be1a          	ldw	x,_rx_wr_index
6865  0e64 b605          	ld	a,_rx_data
6866  0e66 e754          	ld	(_rx_buffer,x),a
6867                     ; 1206 		bRXIN=1;
6869  0e68 72100002      	bset	_bRXIN
6870                     ; 1207 		if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
6872  0e6c be1a          	ldw	x,_rx_wr_index
6873  0e6e 1c0001        	addw	x,#1
6874  0e71 bf1a          	ldw	_rx_wr_index,x
6875  0e73 a30064        	cpw	x,#100
6876  0e76 2603          	jrne	L3523
6879  0e78 5f            	clrw	x
6880  0e79 bf1a          	ldw	_rx_wr_index,x
6881  0e7b               L3523:
6882                     ; 1208 		if (++rx_counter == RX_BUFFER_SIZE){
6884  0e7b be1c          	ldw	x,_rx_counter
6885  0e7d 1c0001        	addw	x,#1
6886  0e80 bf1c          	ldw	_rx_counter,x
6887  0e82 a30064        	cpw	x,#100
6888  0e85 2607          	jrne	L1523
6889                     ; 1209 			rx_counter=0;
6891  0e87 5f            	clrw	x
6892  0e88 bf1c          	ldw	_rx_counter,x
6893                     ; 1210 			rx_buffer_overflow=1;
6895  0e8a 72100001      	bset	_rx_buffer_overflow
6896  0e8e               L1523:
6897                     ; 1213 }
6900  0e8e 80            	iret
6960                     ; 1219 main()
6960                     ; 1220 {
6961                     	switch	.text
6962  0e8f               f_main:
6966                     ; 1221 CLK->CKDIVR=0;
6968  0e8f 725f50c6      	clr	20678
6969                     ; 1223 rele_cnt_index=0;
6971  0e93 3fbb          	clr	_rele_cnt_index
6972                     ; 1225 GPIOD->DDR&=~(1<<6);
6974  0e95 721d5011      	bres	20497,#6
6975                     ; 1226 GPIOD->CR1|=(1<<6);
6977  0e99 721c5012      	bset	20498,#6
6978                     ; 1227 GPIOD->CR2|=(1<<6);
6980  0e9d 721c5013      	bset	20499,#6
6981                     ; 1229 GPIOD->DDR|=(1<<5);
6983  0ea1 721a5011      	bset	20497,#5
6984                     ; 1230 GPIOD->CR1|=(1<<5);
6986  0ea5 721a5012      	bset	20498,#5
6987                     ; 1231 GPIOD->CR2|=(1<<5);	
6989  0ea9 721a5013      	bset	20499,#5
6990                     ; 1232 GPIOD->ODR|=(1<<5);
6992  0ead 721a500f      	bset	20495,#5
6993                     ; 1234 delay_ms(10);
6995  0eb1 ae000a        	ldw	x,#10
6996  0eb4 8d600060      	callf	f_delay_ms
6998                     ; 1236 if(!(GPIOD->IDR&=(1<<6))) 
7000  0eb8 c65010        	ld	a,20496
7001  0ebb a440          	and	a,#64
7002  0ebd c75010        	ld	20496,a
7003  0ec0 2606          	jrne	L7623
7004                     ; 1238 	rele_cnt_index=1;
7006  0ec2 350100bb      	mov	_rele_cnt_index,#1
7008  0ec6 2019          	jra	L1723
7009  0ec8               L7623:
7010                     ; 1242 	GPIOD->ODR&=~(1<<5);
7012  0ec8 721b500f      	bres	20495,#5
7013                     ; 1243 	delay_ms(10);
7015  0ecc ae000a        	ldw	x,#10
7016  0ecf 8d600060      	callf	f_delay_ms
7018                     ; 1244 	if(!(GPIOD->IDR&=(1<<6))) 
7020  0ed3 c65010        	ld	a,20496
7021  0ed6 a440          	and	a,#64
7022  0ed8 c75010        	ld	20496,a
7023  0edb 2604          	jrne	L1723
7024                     ; 1246 		rele_cnt_index=2;
7026  0edd 350200bb      	mov	_rele_cnt_index,#2
7027  0ee1               L1723:
7028                     ; 1250 gpio_init();
7030  0ee1 8d030c03      	callf	f_gpio_init
7032                     ; 1257 spi_init();
7034  0ee5 8d0d090d      	callf	f_spi_init
7036                     ; 1259 t4_init();
7038  0ee9 8d390039      	callf	f_t4_init
7040                     ; 1261 FLASH_DUKR=0xae;
7042  0eed 35ae5064      	mov	_FLASH_DUKR,#174
7043                     ; 1262 FLASH_DUKR=0x56;
7045  0ef1 35565064      	mov	_FLASH_DUKR,#86
7046                     ; 1267 dumm[1]++;
7048  0ef5 725c017d      	inc	_dumm+1
7049                     ; 1269 uart_init();
7051  0ef9 8da800a8      	callf	f_uart_init
7053                     ; 1271 ST_RDID_read();
7055  0efd 8d980998      	callf	f_ST_RDID_read
7057                     ; 1272 if(mdr0==0x20) memory_manufacturer='S';	
7059  0f01 b616          	ld	a,_mdr0
7060  0f03 a120          	cp	a,#32
7061  0f05 2606          	jrne	L5723
7064  0f07 355300bc      	mov	_memory_manufacturer,#83
7066  0f0b 200e          	jra	L7723
7067  0f0d               L5723:
7068                     ; 1275 	DF_mf_dev_read();
7070  0f0d 8dab0aab      	callf	f_DF_mf_dev_read
7072                     ; 1276 	if(mdr0==0x1F) memory_manufacturer='A';
7074  0f11 b616          	ld	a,_mdr0
7075  0f13 a11f          	cp	a,#31
7076  0f15 2604          	jrne	L7723
7079  0f17 354100bc      	mov	_memory_manufacturer,#65
7080  0f1b               L7723:
7081                     ; 1279 t2_init();
7083  0f1b 8d000000      	callf	f_t2_init
7085                     ; 1281 ST_WREN();
7087  0f1f 8df809f8      	callf	f_ST_WREN
7089                     ; 1283 enableInterrupts();	
7092  0f23 9a            rim
7094  0f24               L3033:
7095                     ; 1288 	if(bBUFF_LOAD)
7097                     	btst	_bBUFF_LOAD
7098  0f29 2426          	jruge	L7033
7099                     ; 1290 		bBUFF_LOAD=0;
7101  0f2b 7211000b      	bres	_bBUFF_LOAD
7102                     ; 1292 		if(current_page<last_page)
7104  0f2f be0f          	ldw	x,_current_page
7105  0f31 b30d          	cpw	x,_last_page
7106  0f33 2409          	jruge	L1133
7107                     ; 1294 			current_page++;
7109  0f35 be0f          	ldw	x,_current_page
7110  0f37 1c0001        	addw	x,#1
7111  0f3a bf0f          	ldw	_current_page,x
7113  0f3c 2007          	jra	L3133
7114  0f3e               L1133:
7115                     ; 1298 			current_page=0;
7117  0f3e 5f            	clrw	x
7118  0f3f bf0f          	ldw	_current_page,x
7119                     ; 1299 			play=0;
7121  0f41 72110004      	bres	_play
7122  0f45               L3133:
7123                     ; 1301 		if(memory_manufacturer=='A')
7125  0f45 b6bc          	ld	a,_memory_manufacturer
7126  0f47 a141          	cp	a,#65
7127  0f49 2606          	jrne	L7033
7128                     ; 1303 			DF_page_to_buffer(/*///current_buffer_H*//*1,*/current_page);
7130  0f4b be0f          	ldw	x,_current_page
7131  0f4d 8d250b25      	callf	f_DF_page_to_buffer
7133  0f51               L7033:
7134                     ; 1307 	if(bBUFF_READ_L)
7136                     	btst	_bBUFF_READ_L
7137  0f56 243d          	jruge	L7133
7138                     ; 1309 		bBUFF_READ_L=0;
7140  0f58 72110009      	bres	_bBUFF_READ_L
7141                     ; 1310 		if(memory_manufacturer=='A')
7143  0f5c b6bc          	ld	a,_memory_manufacturer
7144  0f5e a141          	cp	a,#65
7145  0f60 260f          	jrne	L1233
7146                     ; 1312 			DF_buffer_read(/*///current_buffer_L*//*1,*/0,128,buff);
7148  0f62 ae0050        	ldw	x,#_buff
7149  0f65 89            	pushw	x
7150  0f66 ae0080        	ldw	x,#128
7151  0f69 89            	pushw	x
7152  0f6a 5f            	clrw	x
7153  0f6b 8d730b73      	callf	f_DF_buffer_read
7155  0f6f 5b04          	addw	sp,#4
7156  0f71               L1233:
7157                     ; 1314 		if(memory_manufacturer=='S')
7159  0f71 b6bc          	ld	a,_memory_manufacturer
7160  0f73 a153          	cp	a,#83
7161  0f75 261e          	jrne	L7133
7162                     ; 1316 			ST_READ((unsigned long)((unsigned long)(current_page*256UL)),128,buff);
7164  0f77 ae0050        	ldw	x,#_buff
7165  0f7a 89            	pushw	x
7166  0f7b ae0080        	ldw	x,#128
7167  0f7e 89            	pushw	x
7168  0f7f be0f          	ldw	x,_current_page
7169  0f81 90ae0100      	ldw	y,#256
7170  0f85 8d000000      	callf	d_umul
7172  0f89 be02          	ldw	x,c_lreg+2
7173  0f8b 89            	pushw	x
7174  0f8c be00          	ldw	x,c_lreg
7175  0f8e 89            	pushw	x
7176  0f8f 8d580a58      	callf	f_ST_READ
7178  0f93 5b08          	addw	sp,#8
7179  0f95               L7133:
7180                     ; 1320 	if(bBUFF_READ_H) 
7182                     	btst	_bBUFF_READ_H
7183  0f9a 2445          	jruge	L5233
7184                     ; 1322 		bBUFF_READ_H=0;
7186  0f9c 7211000a      	bres	_bBUFF_READ_H
7187                     ; 1323 		if(memory_manufacturer=='A') 
7189  0fa0 b6bc          	ld	a,_memory_manufacturer
7190  0fa2 a141          	cp	a,#65
7191  0fa4 2611          	jrne	L7233
7192                     ; 1325 			DF_buffer_read(/*///current_buffer_L*//*1,*/128,128,&buff[128]);
7194  0fa6 ae00d0        	ldw	x,#_buff+128
7195  0fa9 89            	pushw	x
7196  0faa ae0080        	ldw	x,#128
7197  0fad 89            	pushw	x
7198  0fae ae0080        	ldw	x,#128
7199  0fb1 8d730b73      	callf	f_DF_buffer_read
7201  0fb5 5b04          	addw	sp,#4
7202  0fb7               L7233:
7203                     ; 1327 		if(memory_manufacturer=='S') 
7205  0fb7 b6bc          	ld	a,_memory_manufacturer
7206  0fb9 a153          	cp	a,#83
7207  0fbb 2624          	jrne	L5233
7208                     ; 1329 			ST_READ((unsigned long)((unsigned long)(current_page*256UL)+128UL),128,&buff[128]);
7210  0fbd ae00d0        	ldw	x,#_buff+128
7211  0fc0 89            	pushw	x
7212  0fc1 ae0080        	ldw	x,#128
7213  0fc4 89            	pushw	x
7214  0fc5 be0f          	ldw	x,_current_page
7215  0fc7 90ae0100      	ldw	y,#256
7216  0fcb 8d000000      	callf	d_umul
7218  0fcf a680          	ld	a,#128
7219  0fd1 8d000000      	callf	d_ladc
7221  0fd5 be02          	ldw	x,c_lreg+2
7222  0fd7 89            	pushw	x
7223  0fd8 be00          	ldw	x,c_lreg
7224  0fda 89            	pushw	x
7225  0fdb 8d580a58      	callf	f_ST_READ
7227  0fdf 5b08          	addw	sp,#8
7228  0fe1               L5233:
7229                     ; 1333 	if(bRXIN)
7231                     	btst	_bRXIN
7232  0fe6 2408          	jruge	L3333
7233                     ; 1335 		bRXIN=0;
7235  0fe8 72110002      	bres	_bRXIN
7236                     ; 1337 		uart_in();
7238  0fec 8d2c0c2c      	callf	f_uart_in
7240  0ff0               L3333:
7241                     ; 1341 	if(b100Hz)
7243                     	btst	_b100Hz
7244  0ff5 2504ac931093  	jruge	L5333
7245                     ; 1343 		b100Hz=0;
7247  0ffb 72110008      	bres	_b100Hz
7248                     ; 1345 		if(but_block_cnt)but_block_cnt--;
7250  0fff be00          	ldw	x,_but_block_cnt
7251  1001 2707          	jreq	L7333
7254  1003 be00          	ldw	x,_but_block_cnt
7255  1005 1d0001        	subw	x,#1
7256  1008 bf00          	ldw	_but_block_cnt,x
7257  100a               L7333:
7258                     ; 1347 		if(bSTART==1) 
7260                     	btst	_bSTART
7261  100f 24e6          	jruge	L5333
7262                     ; 1349 			if(play) 
7264                     	btst	_play
7265  1016 2406          	jruge	L3433
7266                     ; 1359 				bSTART=0;
7268  1018 7211000c      	bres	_bSTART
7270  101c 2075          	jra	L5333
7271  101e               L3433:
7272                     ; 1366 				current_page=1;
7274  101e ae0001        	ldw	x,#1
7275  1021 bf0f          	ldw	_current_page,x
7276                     ; 1371 				last_page=EE_PAGE_LEN-1;
7278  1023 ce0000        	ldw	x,_EE_PAGE_LEN
7279  1026 5a            	decw	x
7280  1027 bf0d          	ldw	_last_page,x
7281                     ; 1373 				if(memory_manufacturer=='A')
7283  1029 b6bc          	ld	a,_memory_manufacturer
7284  102b a141          	cp	a,#65
7285  102d 2635          	jrne	L7433
7286                     ; 1375 					DF_page_to_buffer(/*///current_buffer_H*//*1,*/current_page);
7288  102f ae0001        	ldw	x,#1
7289  1032 8d250b25      	callf	f_DF_page_to_buffer
7291                     ; 1376 					delay_ms(10);
7293  1036 ae000a        	ldw	x,#10
7294  1039 8d600060      	callf	f_delay_ms
7296                     ; 1377 					DF_buffer_read(/*///current_buffer_L*//*1,*/0,128,buff);
7298  103d ae0050        	ldw	x,#_buff
7299  1040 89            	pushw	x
7300  1041 ae0080        	ldw	x,#128
7301  1044 89            	pushw	x
7302  1045 5f            	clrw	x
7303  1046 8d730b73      	callf	f_DF_buffer_read
7305  104a 5b04          	addw	sp,#4
7306                     ; 1378 					delay_ms(10);
7308  104c ae000a        	ldw	x,#10
7309  104f 8d600060      	callf	f_delay_ms
7311                     ; 1379 					DF_buffer_read(/*///current_buffer_L*//*1,*/128,128,&buff[128]);         
7313  1053 ae00d0        	ldw	x,#_buff+128
7314  1056 89            	pushw	x
7315  1057 ae0080        	ldw	x,#128
7316  105a 89            	pushw	x
7317  105b ae0080        	ldw	x,#128
7318  105e 8d730b73      	callf	f_DF_buffer_read
7320  1062 5b04          	addw	sp,#4
7321  1064               L7433:
7322                     ; 1381 				if(memory_manufacturer=='S') 
7324  1064 b6bc          	ld	a,_memory_manufacturer
7325  1066 a153          	cp	a,#83
7326  1068 2616          	jrne	L1533
7327                     ; 1383 					ST_READ(0,256,buff);
7329  106a ae0050        	ldw	x,#_buff
7330  106d 89            	pushw	x
7331  106e ae0100        	ldw	x,#256
7332  1071 89            	pushw	x
7333  1072 ae0000        	ldw	x,#0
7334  1075 89            	pushw	x
7335  1076 ae0000        	ldw	x,#0
7336  1079 89            	pushw	x
7337  107a 8d580a58      	callf	f_ST_READ
7339  107e 5b08          	addw	sp,#8
7340  1080               L1533:
7341                     ; 1385 				play=1;
7343  1080 72100004      	bset	_play
7344                     ; 1386 				bSTART=0;
7346  1084 7211000c      	bres	_bSTART
7347                     ; 1388 				rele_cnt=rele_cnt_const[rele_cnt_index];
7349  1088 b6bb          	ld	a,_rele_cnt_index
7350  108a 5f            	clrw	x
7351  108b 97            	ld	xl,a
7352  108c d60000        	ld	a,(_rele_cnt_const,x)
7353  108f 5f            	clrw	x
7354  1090 97            	ld	xl,a
7355  1091 bf03          	ldw	_rele_cnt,x
7356  1093               L5333:
7357                     ; 1396 	if(b10Hz)
7359                     	btst	_b10Hz
7360  1098 2414          	jruge	L3533
7361                     ; 1398 		b10Hz=0;
7363  109a 72110007      	bres	_b10Hz
7364                     ; 1400 		rele_drv();
7366  109e 8d4a004a      	callf	f_rele_drv
7368                     ; 1401 		pwm_fade_in++;
7370  10a2 3cba          	inc	_pwm_fade_in
7371                     ; 1402 		if(pwm_fade_in>128)pwm_fade_in=128;			
7373  10a4 b6ba          	ld	a,_pwm_fade_in
7374  10a6 a181          	cp	a,#129
7375  10a8 2504          	jrult	L3533
7378  10aa 358000ba      	mov	_pwm_fade_in,#128
7379  10ae               L3533:
7380                     ; 1405 	if(b5Hz)
7382                     	btst	_b5Hz
7383  10b3 2404          	jruge	L7533
7384                     ; 1407 		b5Hz=0;
7386  10b5 72110006      	bres	_b5Hz
7387  10b9               L7533:
7388                     ; 1413 	if(b1Hz)
7390                     	btst	_b1Hz
7391  10be 2504          	jrult	L071
7392  10c0 ac240f24      	jpf	L3033
7393  10c4               L071:
7394                     ; 1416 		b1Hz=0;
7396  10c4 72110005      	bres	_b1Hz
7397  10c8 ac240f24      	jpf	L3033
7892                     	xdef	f_main
7893                     .eeprom:	section	.data
7894  0000               _EE_PAGE_LEN:
7895  0000 0000          	ds.b	2
7896                     	xdef	_EE_PAGE_LEN
7897                     	switch	.bss
7898  0000               _UIB:
7899  0000 000000000000  	ds.b	80
7900                     	xdef	_UIB
7901  0050               _buff:
7902  0050 000000000000  	ds.b	300
7903                     	xdef	_buff
7904  017c               _dumm:
7905  017c 000000000000  	ds.b	100
7906                     	xdef	_dumm
7907                     .bit:	section	.data,bit
7908  0000               _bRELEASE:
7909  0000 00            	ds.b	1
7910                     	xdef	_bRELEASE
7911  0001               _rx_buffer_overflow:
7912  0001 00            	ds.b	1
7913                     	xdef	_rx_buffer_overflow
7914  0002               _bRXIN:
7915  0002 00            	ds.b	1
7916                     	xdef	_bRXIN
7917  0003               _bOUT_FREE:
7918  0003 00            	ds.b	1
7919                     	xdef	_bOUT_FREE
7920  0004               _play:
7921  0004 00            	ds.b	1
7922                     	xdef	_play
7923  0005               _b1Hz:
7924  0005 00            	ds.b	1
7925                     	xdef	_b1Hz
7926  0006               _b5Hz:
7927  0006 00            	ds.b	1
7928                     	xdef	_b5Hz
7929  0007               _b10Hz:
7930  0007 00            	ds.b	1
7931                     	xdef	_b10Hz
7932  0008               _b100Hz:
7933  0008 00            	ds.b	1
7934                     	xdef	_b100Hz
7935  0009               _bBUFF_READ_L:
7936  0009 00            	ds.b	1
7937                     	xdef	_bBUFF_READ_L
7938  000a               _bBUFF_READ_H:
7939  000a 00            	ds.b	1
7940                     	xdef	_bBUFF_READ_H
7941  000b               _bBUFF_LOAD:
7942  000b 00            	ds.b	1
7943                     	xdef	_bBUFF_LOAD
7944  000c               _bSTART:
7945  000c 00            	ds.b	1
7946                     	xdef	_bSTART
7947                     	switch	.ubsct
7948  0000               _but_block_cnt:
7949  0000 0000          	ds.b	2
7950                     	xdef	_but_block_cnt
7951                     	xdef	_memory_manufacturer
7952                     	xdef	_rele_cnt_const
7953                     	xdef	_rele_cnt_index
7954                     	xdef	_pwm_fade_in
7955  0002               _rx_offset:
7956  0002 00            	ds.b	1
7957                     	xdef	_rx_offset
7958  0003               _rele_cnt:
7959  0003 0000          	ds.b	2
7960                     	xdef	_rele_cnt
7961  0005               _rx_data:
7962  0005 00            	ds.b	1
7963                     	xdef	_rx_data
7964  0006               _rx_status:
7965  0006 00            	ds.b	1
7966                     	xdef	_rx_status
7967  0007               _file_lengt:
7968  0007 00000000      	ds.b	4
7969                     	xdef	_file_lengt
7970  000b               _current_byte_in_buffer:
7971  000b 0000          	ds.b	2
7972                     	xdef	_current_byte_in_buffer
7973  000d               _last_page:
7974  000d 0000          	ds.b	2
7975                     	xdef	_last_page
7976  000f               _current_page:
7977  000f 0000          	ds.b	2
7978                     	xdef	_current_page
7979  0011               _file_lengt_in_pages:
7980  0011 0000          	ds.b	2
7981                     	xdef	_file_lengt_in_pages
7982  0013               _mdr3:
7983  0013 00            	ds.b	1
7984                     	xdef	_mdr3
7985  0014               _mdr2:
7986  0014 00            	ds.b	1
7987                     	xdef	_mdr2
7988  0015               _mdr1:
7989  0015 00            	ds.b	1
7990                     	xdef	_mdr1
7991  0016               _mdr0:
7992  0016 00            	ds.b	1
7993                     	xdef	_mdr0
7994                     	xdef	_but_on_drv_cnt
7995                     	xdef	_but_drv_cnt
7996  0017               _sample:
7997  0017 00            	ds.b	1
7998                     	xdef	_sample
7999  0018               _rx_rd_index:
8000  0018 0000          	ds.b	2
8001                     	xdef	_rx_rd_index
8002  001a               _rx_wr_index:
8003  001a 0000          	ds.b	2
8004                     	xdef	_rx_wr_index
8005  001c               _rx_counter:
8006  001c 0000          	ds.b	2
8007                     	xdef	_rx_counter
8008                     	xdef	_rx_buffer
8009  001e               _tx_rd_index:
8010  001e 00            	ds.b	1
8011                     	xdef	_tx_rd_index
8012  001f               _tx_wr_index:
8013  001f 00            	ds.b	1
8014                     	xdef	_tx_wr_index
8015  0020               _tx_counter:
8016  0020 00            	ds.b	1
8017                     	xdef	_tx_counter
8018                     	xdef	_tx_buffer
8019  0021               _sample_cnt:
8020  0021 0000          	ds.b	2
8021                     	xdef	_sample_cnt
8022                     	xdef	_t0_cnt3
8023                     	xdef	_t0_cnt2
8024                     	xdef	_t0_cnt1
8025                     	xdef	_t0_cnt0
8026                     	xdef	f_ST_bulk_erase
8027                     	xdef	f_ST_READ
8028                     	xdef	f_ST_WRITE
8029                     	xdef	f_ST_WREN
8030                     	xdef	f_ST_status_read
8031                     	xdef	f_ST_RDID_read
8032                     	xdef	f_uart_in_an
8033                     	xdef	f_control_check
8034                     	xdef	f_index_offset
8035                     	xdef	f_uart_in
8036                     	xdef	f_gpio_init
8037                     	xdef	f_spi_init
8038                     	xdef	f_spi
8039                     	xdef	f_DF_buffer_to_page_er
8040                     	xdef	f_DF_page_to_buffer
8041                     	xdef	f_DF_buffer_write
8042                     	xdef	f_DF_buffer_read
8043                     	xdef	f_DF_status_read
8044                     	xdef	f_DF_memo_to_256
8045                     	xdef	f_DF_mf_dev_read
8046                     	xdef	f_uart_init
8047                     	xdef	f_UARTRxInterrupt
8048                     	xdef	f_UARTTxInterrupt
8049                     	xdef	f_putchar
8050                     	xdef	f_uart_out_adr_block
8051                     	xdef	f_uart_out
8052                     	xdef	f_TIM4_UPD_Interrupt
8053                     	xdef	f_delay_ms
8054                     	xdef	f_rele_drv
8055                     	xdef	f_t4_init
8056                     	xdef	f_t2_init
8057                     	xref.b	c_lreg
8058                     	xref.b	c_x
8059                     	xref.b	c_y
8079                     	xref	d_ladc
8080                     	xref	d_itolx
8081                     	xref	d_umul
8082                     	xref	d_eewrw
8083                     	xref	d_lglsh
8084                     	xref	d_uitolx
8085                     	xref	d_lgursh
8086                     	xref	d_lcmp
8087                     	xref	d_ltor
8088                     	xref	d_lgadc
8089                     	xref	d_rtol
8090                     	xref	d_vmul
8091                     	end
