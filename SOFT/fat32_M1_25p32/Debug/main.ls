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
2352                     ; 93 void rele_drv(void)
2352                     ; 94 {
2353                     	switch	.text
2354  004a               _rele_drv:
2358                     ; 95 if(play) 
2360                     	btst	_play
2361  004f 2406          	jruge	L1641
2362                     ; 97 	GPIOD->ODR|=(1<<4);
2364  0051 7218500f      	bset	20495,#4
2366  0055 2004          	jra	L3641
2367  0057               L1641:
2368                     ; 99 else GPIOD->ODR&=~(1<<4);
2370  0057 7219500f      	bres	20495,#4
2371  005b               L3641:
2372                     ; 102 }
2375  005b 81            	ret
2436                     ; 105 long delay_ms(short in)
2436                     ; 106 {
2437                     	switch	.text
2438  005c               _delay_ms:
2440  005c 520c          	subw	sp,#12
2441       0000000c      OFST:	set	12
2444                     ; 109 i=((long)in)*100UL;
2446  005e 90ae0064      	ldw	y,#100
2447  0062 cd0000        	call	c_vmul
2449  0065 96            	ldw	x,sp
2450  0066 1c0005        	addw	x,#OFST-7
2451  0069 cd0000        	call	c_rtol
2453                     ; 111 for(ii=0;ii<i;ii++)
2455  006c ae0000        	ldw	x,#0
2456  006f 1f0b          	ldw	(OFST-1,sp),x
2457  0071 ae0000        	ldw	x,#0
2458  0074 1f09          	ldw	(OFST-3,sp),x
2460  0076 2012          	jra	L3251
2461  0078               L7151:
2462                     ; 113 		iii++;
2464  0078 96            	ldw	x,sp
2465  0079 1c0001        	addw	x,#OFST-11
2466  007c a601          	ld	a,#1
2467  007e cd0000        	call	c_lgadc
2469                     ; 111 for(ii=0;ii<i;ii++)
2471  0081 96            	ldw	x,sp
2472  0082 1c0009        	addw	x,#OFST-3
2473  0085 a601          	ld	a,#1
2474  0087 cd0000        	call	c_lgadc
2476  008a               L3251:
2479  008a 9c            	rvf
2480  008b 96            	ldw	x,sp
2481  008c 1c0009        	addw	x,#OFST-3
2482  008f cd0000        	call	c_ltor
2484  0092 96            	ldw	x,sp
2485  0093 1c0005        	addw	x,#OFST-7
2486  0096 cd0000        	call	c_lcmp
2488  0099 2fdd          	jrslt	L7151
2489                     ; 116 }
2492  009b 5b0c          	addw	sp,#12
2493  009d 81            	ret
2516                     ; 119 void uart_init (void){
2517                     	switch	.text
2518  009e               _uart_init:
2522                     ; 120 	GPIOD->DDR|=(1<<5);
2524  009e 721a5011      	bset	20497,#5
2525                     ; 121 	GPIOD->CR1|=(1<<5);
2527  00a2 721a5012      	bset	20498,#5
2528                     ; 122 	GPIOD->CR2|=(1<<5);
2530  00a6 721a5013      	bset	20499,#5
2531                     ; 125 	GPIOD->DDR&=~(1<<6);
2533  00aa 721d5011      	bres	20497,#6
2534                     ; 126 	GPIOD->CR1&=~(1<<6);
2536  00ae 721d5012      	bres	20498,#6
2537                     ; 127 	GPIOD->CR2&=~(1<<6);
2539  00b2 721d5013      	bres	20499,#6
2540                     ; 130 	UART1->CR1&=~UART1_CR1_M;					
2542  00b6 72195234      	bres	21044,#4
2543                     ; 131 	UART1->CR3|= (0<<4) & UART1_CR3_STOP;	
2545  00ba c65236        	ld	a,21046
2546                     ; 132 	UART1->BRR2= 0x01;//0x03;
2548  00bd 35015233      	mov	21043,#1
2549                     ; 133 	UART1->BRR1= 0x1a;//0x68;
2551  00c1 351a5232      	mov	21042,#26
2552                     ; 134 	UART1->CR2|= UART1_CR2_TEN | UART3_CR2_REN | UART3_CR2_RIEN;	
2554  00c5 c65235        	ld	a,21045
2555  00c8 aa2c          	or	a,#44
2556  00ca c75235        	ld	21045,a
2557                     ; 135 }
2560  00cd 81            	ret
2678                     ; 138 void uart_out (char num,char data0,char data1,char data2,char data3,char data4,char data5){
2679                     	switch	.text
2680  00ce               _uart_out:
2682  00ce 89            	pushw	x
2683  00cf 520c          	subw	sp,#12
2684       0000000c      OFST:	set	12
2687                     ; 139 	char i=0,t=0,UOB[10];
2691  00d1 0f01          	clr	(OFST-11,sp)
2692                     ; 142 	UOB[0]=data0;
2694  00d3 9f            	ld	a,xl
2695  00d4 6b02          	ld	(OFST-10,sp),a
2696                     ; 143 	UOB[1]=data1;
2698  00d6 7b11          	ld	a,(OFST+5,sp)
2699  00d8 6b03          	ld	(OFST-9,sp),a
2700                     ; 144 	UOB[2]=data2;
2702  00da 7b12          	ld	a,(OFST+6,sp)
2703  00dc 6b04          	ld	(OFST-8,sp),a
2704                     ; 145 	UOB[3]=data3;
2706  00de 7b13          	ld	a,(OFST+7,sp)
2707  00e0 6b05          	ld	(OFST-7,sp),a
2708                     ; 146 	UOB[4]=data4;
2710  00e2 7b14          	ld	a,(OFST+8,sp)
2711  00e4 6b06          	ld	(OFST-6,sp),a
2712                     ; 147 	UOB[5]=data5;
2714  00e6 7b15          	ld	a,(OFST+9,sp)
2715  00e8 6b07          	ld	(OFST-5,sp),a
2716                     ; 148 	for (i=0;i<num;i++)
2718  00ea 0f0c          	clr	(OFST+0,sp)
2720  00ec 2013          	jra	L5261
2721  00ee               L1261:
2722                     ; 150 		t^=UOB[i];
2724  00ee 96            	ldw	x,sp
2725  00ef 1c0002        	addw	x,#OFST-10
2726  00f2 9f            	ld	a,xl
2727  00f3 5e            	swapw	x
2728  00f4 1b0c          	add	a,(OFST+0,sp)
2729  00f6 2401          	jrnc	L02
2730  00f8 5c            	incw	x
2731  00f9               L02:
2732  00f9 02            	rlwa	x,a
2733  00fa 7b01          	ld	a,(OFST-11,sp)
2734  00fc f8            	xor	a,	(x)
2735  00fd 6b01          	ld	(OFST-11,sp),a
2736                     ; 148 	for (i=0;i<num;i++)
2738  00ff 0c0c          	inc	(OFST+0,sp)
2739  0101               L5261:
2742  0101 7b0c          	ld	a,(OFST+0,sp)
2743  0103 110d          	cp	a,(OFST+1,sp)
2744  0105 25e7          	jrult	L1261
2745                     ; 152 	UOB[num]=num;
2747  0107 96            	ldw	x,sp
2748  0108 1c0002        	addw	x,#OFST-10
2749  010b 9f            	ld	a,xl
2750  010c 5e            	swapw	x
2751  010d 1b0d          	add	a,(OFST+1,sp)
2752  010f 2401          	jrnc	L22
2753  0111 5c            	incw	x
2754  0112               L22:
2755  0112 02            	rlwa	x,a
2756  0113 7b0d          	ld	a,(OFST+1,sp)
2757  0115 f7            	ld	(x),a
2758                     ; 153 	t^=UOB[num];
2760  0116 96            	ldw	x,sp
2761  0117 1c0002        	addw	x,#OFST-10
2762  011a 9f            	ld	a,xl
2763  011b 5e            	swapw	x
2764  011c 1b0d          	add	a,(OFST+1,sp)
2765  011e 2401          	jrnc	L42
2766  0120 5c            	incw	x
2767  0121               L42:
2768  0121 02            	rlwa	x,a
2769  0122 7b01          	ld	a,(OFST-11,sp)
2770  0124 f8            	xor	a,	(x)
2771  0125 6b01          	ld	(OFST-11,sp),a
2772                     ; 154 	UOB[num+1]=t;
2774  0127 96            	ldw	x,sp
2775  0128 1c0003        	addw	x,#OFST-9
2776  012b 9f            	ld	a,xl
2777  012c 5e            	swapw	x
2778  012d 1b0d          	add	a,(OFST+1,sp)
2779  012f 2401          	jrnc	L62
2780  0131 5c            	incw	x
2781  0132               L62:
2782  0132 02            	rlwa	x,a
2783  0133 7b01          	ld	a,(OFST-11,sp)
2784  0135 f7            	ld	(x),a
2785                     ; 155 	UOB[num+2]=END;
2787  0136 96            	ldw	x,sp
2788  0137 1c0004        	addw	x,#OFST-8
2789  013a 9f            	ld	a,xl
2790  013b 5e            	swapw	x
2791  013c 1b0d          	add	a,(OFST+1,sp)
2792  013e 2401          	jrnc	L03
2793  0140 5c            	incw	x
2794  0141               L03:
2795  0141 02            	rlwa	x,a
2796  0142 a60a          	ld	a,#10
2797  0144 f7            	ld	(x),a
2798                     ; 159 	for (i=0;i<num+3;i++)
2800  0145 0f0c          	clr	(OFST+0,sp)
2802  0147 2012          	jra	L5361
2803  0149               L1361:
2804                     ; 161 		putchar(UOB[i]);
2806  0149 96            	ldw	x,sp
2807  014a 1c0002        	addw	x,#OFST-10
2808  014d 9f            	ld	a,xl
2809  014e 5e            	swapw	x
2810  014f 1b0c          	add	a,(OFST+0,sp)
2811  0151 2401          	jrnc	L23
2812  0153 5c            	incw	x
2813  0154               L23:
2814  0154 02            	rlwa	x,a
2815  0155 f6            	ld	a,(x)
2816  0156 cd0b61        	call	_putchar
2818                     ; 159 	for (i=0;i<num+3;i++)
2820  0159 0c0c          	inc	(OFST+0,sp)
2821  015b               L5361:
2824  015b 9c            	rvf
2825  015c 7b0c          	ld	a,(OFST+0,sp)
2826  015e 5f            	clrw	x
2827  015f 97            	ld	xl,a
2828  0160 7b0d          	ld	a,(OFST+1,sp)
2829  0162 905f          	clrw	y
2830  0164 9097          	ld	yl,a
2831  0166 72a90003      	addw	y,#3
2832  016a bf00          	ldw	c_x,x
2833  016c 90b300        	cpw	y,c_x
2834  016f 2cd8          	jrsgt	L1361
2835                     ; 164 	bOUT_FREE=0;	  	
2837  0171 72110005      	bres	_bOUT_FREE
2838                     ; 165 }
2841  0175 5b0e          	addw	sp,#14
2842  0177 81            	ret
2924                     ; 168 void uart_out_adr_block (unsigned long adress,char *ptr, char len)
2924                     ; 169 {
2925                     	switch	.text
2926  0178               _uart_out_adr_block:
2928  0178 5203          	subw	sp,#3
2929       00000003      OFST:	set	3
2932                     ; 173 t=0;
2934  017a 0f02          	clr	(OFST-1,sp)
2935                     ; 174 temp11=CMND;
2937                     ; 175 t^=temp11;
2939  017c 7b02          	ld	a,(OFST-1,sp)
2940  017e a816          	xor	a,	#22
2941  0180 6b02          	ld	(OFST-1,sp),a
2942                     ; 176 putchar(temp11);
2944  0182 a616          	ld	a,#22
2945  0184 cd0b61        	call	_putchar
2947                     ; 178 temp11=10;
2949                     ; 179 t^=temp11;
2951  0187 7b02          	ld	a,(OFST-1,sp)
2952  0189 a80a          	xor	a,	#10
2953  018b 6b02          	ld	(OFST-1,sp),a
2954                     ; 180 putchar(temp11);
2956  018d a60a          	ld	a,#10
2957  018f cd0b61        	call	_putchar
2959                     ; 182 temp11=adress%256;//(*((char*)&adress));
2961  0192 7b09          	ld	a,(OFST+6,sp)
2962  0194 a4ff          	and	a,#255
2963  0196 6b03          	ld	(OFST+0,sp),a
2964                     ; 183 t^=temp11;
2966  0198 7b02          	ld	a,(OFST-1,sp)
2967  019a 1803          	xor	a,	(OFST+0,sp)
2968  019c 6b02          	ld	(OFST-1,sp),a
2969                     ; 184 putchar(temp11);
2971  019e 7b03          	ld	a,(OFST+0,sp)
2972  01a0 cd0b61        	call	_putchar
2974                     ; 185 adress>>=8;
2976  01a3 96            	ldw	x,sp
2977  01a4 1c0006        	addw	x,#OFST+3
2978  01a7 a608          	ld	a,#8
2979  01a9 cd0000        	call	c_lgursh
2981                     ; 186 temp11=adress%256;//(*(((char*)&adress)+1));
2983  01ac 7b09          	ld	a,(OFST+6,sp)
2984  01ae a4ff          	and	a,#255
2985  01b0 6b03          	ld	(OFST+0,sp),a
2986                     ; 187 t^=temp11;
2988  01b2 7b02          	ld	a,(OFST-1,sp)
2989  01b4 1803          	xor	a,	(OFST+0,sp)
2990  01b6 6b02          	ld	(OFST-1,sp),a
2991                     ; 188 putchar(temp11);
2993  01b8 7b03          	ld	a,(OFST+0,sp)
2994  01ba cd0b61        	call	_putchar
2996                     ; 189 adress>>=8;
2998  01bd 96            	ldw	x,sp
2999  01be 1c0006        	addw	x,#OFST+3
3000  01c1 a608          	ld	a,#8
3001  01c3 cd0000        	call	c_lgursh
3003                     ; 190 temp11=adress%256;//(*(((char*)&adress)+2));
3005  01c6 7b09          	ld	a,(OFST+6,sp)
3006  01c8 a4ff          	and	a,#255
3007  01ca 6b03          	ld	(OFST+0,sp),a
3008                     ; 191 t^=temp11;
3010  01cc 7b02          	ld	a,(OFST-1,sp)
3011  01ce 1803          	xor	a,	(OFST+0,sp)
3012  01d0 6b02          	ld	(OFST-1,sp),a
3013                     ; 192 putchar(temp11);
3015  01d2 7b03          	ld	a,(OFST+0,sp)
3016  01d4 cd0b61        	call	_putchar
3018                     ; 193 adress>>=8;
3020  01d7 96            	ldw	x,sp
3021  01d8 1c0006        	addw	x,#OFST+3
3022  01db a608          	ld	a,#8
3023  01dd cd0000        	call	c_lgursh
3025                     ; 194 temp11=adress%256;//(*(((char*)&adress)+3));
3027  01e0 7b09          	ld	a,(OFST+6,sp)
3028  01e2 a4ff          	and	a,#255
3029  01e4 6b03          	ld	(OFST+0,sp),a
3030                     ; 195 t^=temp11;
3032  01e6 7b02          	ld	a,(OFST-1,sp)
3033  01e8 1803          	xor	a,	(OFST+0,sp)
3034  01ea 6b02          	ld	(OFST-1,sp),a
3035                     ; 196 putchar(temp11);
3037  01ec 7b03          	ld	a,(OFST+0,sp)
3038  01ee cd0b61        	call	_putchar
3040                     ; 199 for(i11=0;i11<len;i11++)
3042  01f1 0f01          	clr	(OFST-2,sp)
3044  01f3 201b          	jra	L7071
3045  01f5               L3071:
3046                     ; 201 	temp11=ptr[i11];
3048  01f5 7b0a          	ld	a,(OFST+7,sp)
3049  01f7 97            	ld	xl,a
3050  01f8 7b0b          	ld	a,(OFST+8,sp)
3051  01fa 1b01          	add	a,(OFST-2,sp)
3052  01fc 2401          	jrnc	L63
3053  01fe 5c            	incw	x
3054  01ff               L63:
3055  01ff 02            	rlwa	x,a
3056  0200 f6            	ld	a,(x)
3057  0201 6b03          	ld	(OFST+0,sp),a
3058                     ; 202 	t^=temp11;
3060  0203 7b02          	ld	a,(OFST-1,sp)
3061  0205 1803          	xor	a,	(OFST+0,sp)
3062  0207 6b02          	ld	(OFST-1,sp),a
3063                     ; 203 	putchar(temp11);
3065  0209 7b03          	ld	a,(OFST+0,sp)
3066  020b cd0b61        	call	_putchar
3068                     ; 199 for(i11=0;i11<len;i11++)
3070  020e 0c01          	inc	(OFST-2,sp)
3071  0210               L7071:
3074  0210 7b01          	ld	a,(OFST-2,sp)
3075  0212 110c          	cp	a,(OFST+9,sp)
3076  0214 25df          	jrult	L3071
3077                     ; 206 temp11=(len+6);
3079  0216 7b0c          	ld	a,(OFST+9,sp)
3080  0218 ab06          	add	a,#6
3081  021a 6b03          	ld	(OFST+0,sp),a
3082                     ; 207 t^=temp11;
3084  021c 7b02          	ld	a,(OFST-1,sp)
3085  021e 1803          	xor	a,	(OFST+0,sp)
3086  0220 6b02          	ld	(OFST-1,sp),a
3087                     ; 208 putchar(temp11);
3089  0222 7b03          	ld	a,(OFST+0,sp)
3090  0224 cd0b61        	call	_putchar
3092                     ; 210 putchar(t);
3094  0227 7b02          	ld	a,(OFST-1,sp)
3095  0229 cd0b61        	call	_putchar
3097                     ; 212 putchar(0x0a);
3099  022c a60a          	ld	a,#10
3100  022e cd0b61        	call	_putchar
3102                     ; 214 bOUT_FREE=0;	   
3104  0231 72110005      	bres	_bOUT_FREE
3105                     ; 215 }
3108  0235 5b03          	addw	sp,#3
3109  0237 81            	ret
3309                     ; 217 void uart_in_an(void) 
3309                     ; 218 {
3310                     	switch	.text
3311  0238               _uart_in_an:
3313  0238 5206          	subw	sp,#6
3314       00000006      OFST:	set	6
3317                     ; 221 if(UIB[0]==CMND) 
3319  023a c60000        	ld	a,_UIB
3320  023d a116          	cp	a,#22
3321  023f 2703          	jreq	L24
3322  0241 cc0b5e        	jp	L5202
3323  0244               L24:
3324                     ; 223 	if(UIB[1]==1) 
3326  0244 c60001        	ld	a,_UIB+1
3327  0247 a101          	cp	a,#1
3328  0249 262f          	jrne	L7202
3329                     ; 228 		if(memory_manufacturer=='A') 
3331  024b b6bc          	ld	a,_memory_manufacturer
3332  024d a141          	cp	a,#65
3333  024f 2603          	jrne	L1302
3334                     ; 230 			temp_L=DF_mf_dev_read();
3336  0251 cd0d3a        	call	_DF_mf_dev_read
3338  0254               L1302:
3339                     ; 232 		if(memory_manufacturer=='S') 
3341  0254 b6bc          	ld	a,_memory_manufacturer
3342  0256 a153          	cp	a,#83
3343  0258 2603          	jrne	L3302
3344                     ; 234 			temp_L=ST_RDID_read();
3346  025a cd0c22        	call	_ST_RDID_read
3348  025d               L3302:
3349                     ; 236 		uart_out (6,CMND,1,mdr0/**((char*)&temp_L)*/,mdr1/**(((char*)&temp_L)+1)*/,mdr2/**(((char*)&temp_L)+2)*/,mdr3/**(((char*)&temp_L)+3)*/);
3351  025d 3b0013        	push	_mdr3
3352  0260 3b0014        	push	_mdr2
3353  0263 3b0015        	push	_mdr1
3354  0266 3b0016        	push	_mdr0
3355  0269 4b01          	push	#1
3356  026b ae0016        	ldw	x,#22
3357  026e a606          	ld	a,#6
3358  0270 95            	ld	xh,a
3359  0271 cd00ce        	call	_uart_out
3361  0274 5b05          	addw	sp,#5
3363  0276 ac5e0b5e      	jpf	L5202
3364  027a               L7202:
3365                     ; 244 	else if(UIB[1]==2) {
3367  027a c60001        	ld	a,_UIB+1
3368  027d a102          	cp	a,#2
3369  027f 2630          	jrne	L7302
3370                     ; 247 		if(memory_manufacturer=='A') {
3372  0281 b6bc          	ld	a,_memory_manufacturer
3373  0283 a141          	cp	a,#65
3374  0285 2605          	jrne	L1402
3375                     ; 248 			temp=DF_status_read();
3377  0287 cd0d8e        	call	_DF_status_read
3379  028a 6b06          	ld	(OFST+0,sp),a
3380  028c               L1402:
3381                     ; 250 		if(memory_manufacturer=='S') {
3383  028c b6bc          	ld	a,_memory_manufacturer
3384  028e a153          	cp	a,#83
3385  0290 2605          	jrne	L3402
3386                     ; 251 			temp=ST_status_read();
3388  0292 cd0c54        	call	_ST_status_read
3390  0295 6b06          	ld	(OFST+0,sp),a
3391  0297               L3402:
3392                     ; 254 		uart_out (3,CMND,2,temp,0,0,0);    
3394  0297 4b00          	push	#0
3395  0299 4b00          	push	#0
3396  029b 4b00          	push	#0
3397  029d 7b09          	ld	a,(OFST+3,sp)
3398  029f 88            	push	a
3399  02a0 4b02          	push	#2
3400  02a2 ae0016        	ldw	x,#22
3401  02a5 a603          	ld	a,#3
3402  02a7 95            	ld	xh,a
3403  02a8 cd00ce        	call	_uart_out
3405  02ab 5b05          	addw	sp,#5
3407  02ad ac5e0b5e      	jpf	L5202
3408  02b1               L7302:
3409                     ; 258 	else if(UIB[1]==3)
3411  02b1 c60001        	ld	a,_UIB+1
3412  02b4 a103          	cp	a,#3
3413  02b6 2623          	jrne	L7402
3414                     ; 261 		if(memory_manufacturer=='A') {
3416  02b8 b6bc          	ld	a,_memory_manufacturer
3417  02ba a141          	cp	a,#65
3418  02bc 2603          	jrne	L1502
3419                     ; 262 			DF_memo_to_256();
3421  02be cd0d71        	call	_DF_memo_to_256
3423  02c1               L1502:
3424                     ; 264 		uart_out (2,CMND,3,temp,0,0,0);    
3426  02c1 4b00          	push	#0
3427  02c3 4b00          	push	#0
3428  02c5 4b00          	push	#0
3429  02c7 7b09          	ld	a,(OFST+3,sp)
3430  02c9 88            	push	a
3431  02ca 4b03          	push	#3
3432  02cc ae0016        	ldw	x,#22
3433  02cf a602          	ld	a,#2
3434  02d1 95            	ld	xh,a
3435  02d2 cd00ce        	call	_uart_out
3437  02d5 5b05          	addw	sp,#5
3439  02d7 ac5e0b5e      	jpf	L5202
3440  02db               L7402:
3441                     ; 267 	else if(UIB[1]==4)
3443  02db c60001        	ld	a,_UIB+1
3444  02de a104          	cp	a,#4
3445  02e0 2623          	jrne	L5502
3446                     ; 270 		if(memory_manufacturer=='A') {
3448  02e2 b6bc          	ld	a,_memory_manufacturer
3449  02e4 a141          	cp	a,#65
3450  02e6 2603          	jrne	L7502
3451                     ; 271 			DF_memo_to_256();
3453  02e8 cd0d71        	call	_DF_memo_to_256
3455  02eb               L7502:
3456                     ; 273 		uart_out (2,CMND,3,temp,0,0,0);    
3458  02eb 4b00          	push	#0
3459  02ed 4b00          	push	#0
3460  02ef 4b00          	push	#0
3461  02f1 7b09          	ld	a,(OFST+3,sp)
3462  02f3 88            	push	a
3463  02f4 4b03          	push	#3
3464  02f6 ae0016        	ldw	x,#22
3465  02f9 a602          	ld	a,#2
3466  02fb 95            	ld	xh,a
3467  02fc cd00ce        	call	_uart_out
3469  02ff 5b05          	addw	sp,#5
3471  0301 ac5e0b5e      	jpf	L5202
3472  0305               L5502:
3473                     ; 276 	else if(UIB[1]==10)
3475  0305 c60001        	ld	a,_UIB+1
3476  0308 a10a          	cp	a,#10
3477  030a 2703cc0392    	jrne	L3602
3478                     ; 280 		if(memory_manufacturer=='A') {
3480  030f b6bc          	ld	a,_memory_manufacturer
3481  0311 a141          	cp	a,#65
3482  0313 2615          	jrne	L5602
3483                     ; 281 			if(UIB[2]==1)DF_buffer_read(/*1,*/0,256, buff);
3485  0315 c60002        	ld	a,_UIB+2
3486  0318 a101          	cp	a,#1
3487  031a 260e          	jrne	L5602
3490  031c ae0050        	ldw	x,#_buff
3491  031f 89            	pushw	x
3492  0320 ae0100        	ldw	x,#256
3493  0323 89            	pushw	x
3494  0324 5f            	clrw	x
3495  0325 cd0dee        	call	_DF_buffer_read
3497  0328 5b04          	addw	sp,#4
3498  032a               L5602:
3499                     ; 286 		uart_out_adr_block (0,buff,64);
3501  032a 4b40          	push	#64
3502  032c ae0050        	ldw	x,#_buff
3503  032f 89            	pushw	x
3504  0330 ae0000        	ldw	x,#0
3505  0333 89            	pushw	x
3506  0334 ae0000        	ldw	x,#0
3507  0337 89            	pushw	x
3508  0338 cd0178        	call	_uart_out_adr_block
3510  033b 5b07          	addw	sp,#7
3511                     ; 287 		delay_ms(100);    
3513  033d ae0064        	ldw	x,#100
3514  0340 cd005c        	call	_delay_ms
3516                     ; 288 		uart_out_adr_block (64,&buff[64],64);
3518  0343 4b40          	push	#64
3519  0345 ae0090        	ldw	x,#_buff+64
3520  0348 89            	pushw	x
3521  0349 ae0040        	ldw	x,#64
3522  034c 89            	pushw	x
3523  034d ae0000        	ldw	x,#0
3524  0350 89            	pushw	x
3525  0351 cd0178        	call	_uart_out_adr_block
3527  0354 5b07          	addw	sp,#7
3528                     ; 289 		delay_ms(100);    
3530  0356 ae0064        	ldw	x,#100
3531  0359 cd005c        	call	_delay_ms
3533                     ; 290 		uart_out_adr_block (128,&buff[128],64);
3535  035c 4b40          	push	#64
3536  035e ae00d0        	ldw	x,#_buff+128
3537  0361 89            	pushw	x
3538  0362 ae0080        	ldw	x,#128
3539  0365 89            	pushw	x
3540  0366 ae0000        	ldw	x,#0
3541  0369 89            	pushw	x
3542  036a cd0178        	call	_uart_out_adr_block
3544  036d 5b07          	addw	sp,#7
3545                     ; 291 		delay_ms(100);    
3547  036f ae0064        	ldw	x,#100
3548  0372 cd005c        	call	_delay_ms
3550                     ; 292 		uart_out_adr_block (192,&buff[192],64);
3552  0375 4b40          	push	#64
3553  0377 ae0110        	ldw	x,#_buff+192
3554  037a 89            	pushw	x
3555  037b ae00c0        	ldw	x,#192
3556  037e 89            	pushw	x
3557  037f ae0000        	ldw	x,#0
3558  0382 89            	pushw	x
3559  0383 cd0178        	call	_uart_out_adr_block
3561  0386 5b07          	addw	sp,#7
3562                     ; 293 		delay_ms(100);    
3564  0388 ae0064        	ldw	x,#100
3565  038b cd005c        	call	_delay_ms
3568  038e ac5e0b5e      	jpf	L5202
3569  0392               L3602:
3570                     ; 296 	else if(UIB[1]==11)
3572  0392 c60001        	ld	a,_UIB+1
3573  0395 a10b          	cp	a,#11
3574  0397 2633          	jrne	L3702
3575                     ; 302 		for(i=0;i<256;i++)buff[i]=0;
3577  0399 5f            	clrw	x
3578  039a 1f05          	ldw	(OFST-1,sp),x
3579  039c               L5702:
3582  039c 1e05          	ldw	x,(OFST-1,sp)
3583  039e 724f0050      	clr	(_buff,x)
3586  03a2 1e05          	ldw	x,(OFST-1,sp)
3587  03a4 1c0001        	addw	x,#1
3588  03a7 1f05          	ldw	(OFST-1,sp),x
3591  03a9 1e05          	ldw	x,(OFST-1,sp)
3592  03ab a30100        	cpw	x,#256
3593  03ae 25ec          	jrult	L5702
3594                     ; 304 		if(UIB[2]==1)DF_buffer_write(/*1,*/0,256, buff);
3596  03b0 c60002        	ld	a,_UIB+2
3597  03b3 a101          	cp	a,#1
3598  03b5 2703          	jreq	L44
3599  03b7 cc0b5e        	jp	L5202
3600  03ba               L44:
3603  03ba ae0050        	ldw	x,#_buff
3604  03bd 89            	pushw	x
3605  03be ae0100        	ldw	x,#256
3606  03c1 89            	pushw	x
3607  03c2 5f            	clrw	x
3608  03c3 cd0e34        	call	_DF_buffer_write
3610  03c6 5b04          	addw	sp,#4
3611  03c8 ac5e0b5e      	jpf	L5202
3612  03cc               L3702:
3613                     ; 308 	else if(UIB[1]==12)
3615  03cc c60001        	ld	a,_UIB+1
3616  03cf a10c          	cp	a,#12
3617  03d1 2703          	jreq	L64
3618  03d3 cc04b2        	jp	L7012
3619  03d6               L64:
3620                     ; 314 		for(i=0;i<256;i++)buff[i]=0;
3622  03d6 5f            	clrw	x
3623  03d7 1f05          	ldw	(OFST-1,sp),x
3624  03d9               L1112:
3627  03d9 1e05          	ldw	x,(OFST-1,sp)
3628  03db 724f0050      	clr	(_buff,x)
3631  03df 1e05          	ldw	x,(OFST-1,sp)
3632  03e1 1c0001        	addw	x,#1
3633  03e4 1f05          	ldw	(OFST-1,sp),x
3636  03e6 1e05          	ldw	x,(OFST-1,sp)
3637  03e8 a30100        	cpw	x,#256
3638  03eb 25ec          	jrult	L1112
3639                     ; 316 		if(UIB[3]==1)
3641  03ed c60003        	ld	a,_UIB+3
3642  03f0 a101          	cp	a,#1
3643  03f2 2632          	jrne	L7112
3644                     ; 318 			buff[0]=0x00;
3646  03f4 725f0050      	clr	_buff
3647                     ; 319 			buff[1]=0x11;
3649  03f8 35110051      	mov	_buff+1,#17
3650                     ; 320 			buff[2]=0x22;
3652  03fc 35220052      	mov	_buff+2,#34
3653                     ; 321 			buff[3]=0x33;
3655  0400 35330053      	mov	_buff+3,#51
3656                     ; 322 			buff[4]=0x44;
3658  0404 35440054      	mov	_buff+4,#68
3659                     ; 323 			buff[5]=0x55;
3661  0408 35550055      	mov	_buff+5,#85
3662                     ; 324 			buff[6]=0x66;
3664  040c 35660056      	mov	_buff+6,#102
3665                     ; 325 			buff[7]=0x77;
3667  0410 35770057      	mov	_buff+7,#119
3668                     ; 326 			buff[8]=0x88;
3670  0414 35880058      	mov	_buff+8,#136
3671                     ; 327 			buff[9]=0x99;
3673  0418 35990059      	mov	_buff+9,#153
3674                     ; 328 			buff[10]=0;
3676  041c 725f005a      	clr	_buff+10
3677                     ; 329 			buff[11]=0;
3679  0420 725f005b      	clr	_buff+11
3681  0424 2070          	jra	L1212
3682  0426               L7112:
3683                     ; 332 		else if(UIB[3]==2)
3685  0426 c60003        	ld	a,_UIB+3
3686  0429 a102          	cp	a,#2
3687  042b 2632          	jrne	L3212
3688                     ; 334 			buff[0]=0x00;
3690  042d 725f0050      	clr	_buff
3691                     ; 335 			buff[1]=0x10;
3693  0431 35100051      	mov	_buff+1,#16
3694                     ; 336 			buff[2]=0x20;
3696  0435 35200052      	mov	_buff+2,#32
3697                     ; 337 			buff[3]=0x30;
3699  0439 35300053      	mov	_buff+3,#48
3700                     ; 338 			buff[4]=0x40;
3702  043d 35400054      	mov	_buff+4,#64
3703                     ; 339 			buff[5]=0x50;
3705  0441 35500055      	mov	_buff+5,#80
3706                     ; 340 			buff[6]=0x60;
3708  0445 35600056      	mov	_buff+6,#96
3709                     ; 341 			buff[7]=0x70;
3711  0449 35700057      	mov	_buff+7,#112
3712                     ; 342 			buff[8]=0x80;
3714  044d 35800058      	mov	_buff+8,#128
3715                     ; 343 			buff[9]=0x90;
3717  0451 35900059      	mov	_buff+9,#144
3718                     ; 344 			buff[10]=0;
3720  0455 725f005a      	clr	_buff+10
3721                     ; 345 			buff[11]=0;
3723  0459 725f005b      	clr	_buff+11
3725  045d 2037          	jra	L1212
3726  045f               L3212:
3727                     ; 348 		else if(UIB[3]==3)
3729  045f c60003        	ld	a,_UIB+3
3730  0462 a103          	cp	a,#3
3731  0464 2630          	jrne	L1212
3732                     ; 350 			buff[0]=0x98;
3734  0466 35980050      	mov	_buff,#152
3735                     ; 351 			buff[1]=0x87;
3737  046a 35870051      	mov	_buff+1,#135
3738                     ; 352 			buff[2]=0x76;
3740  046e 35760052      	mov	_buff+2,#118
3741                     ; 353 			buff[3]=0x65;
3743  0472 35650053      	mov	_buff+3,#101
3744                     ; 354 			buff[4]=0x54;
3746  0476 35540054      	mov	_buff+4,#84
3747                     ; 355 			buff[5]=0x43;
3749  047a 35430055      	mov	_buff+5,#67
3750                     ; 356 			buff[6]=0x32;
3752  047e 35320056      	mov	_buff+6,#50
3753                     ; 357 			buff[7]=0x21;
3755  0482 35210057      	mov	_buff+7,#33
3756                     ; 358 			buff[8]=0x10;
3758  0486 35100058      	mov	_buff+8,#16
3759                     ; 359 			buff[9]=0x00;
3761  048a 725f0059      	clr	_buff+9
3762                     ; 360 			buff[10]=0;
3764  048e 725f005a      	clr	_buff+10
3765                     ; 361 			buff[11]=0;
3767  0492 725f005b      	clr	_buff+11
3768  0496               L1212:
3769                     ; 363 		if(UIB[2]==1)DF_buffer_write(/*1,*/0,256, buff);
3771  0496 c60002        	ld	a,_UIB+2
3772  0499 a101          	cp	a,#1
3773  049b 2703          	jreq	L05
3774  049d cc0b5e        	jp	L5202
3775  04a0               L05:
3778  04a0 ae0050        	ldw	x,#_buff
3779  04a3 89            	pushw	x
3780  04a4 ae0100        	ldw	x,#256
3781  04a7 89            	pushw	x
3782  04a8 5f            	clrw	x
3783  04a9 cd0e34        	call	_DF_buffer_write
3785  04ac 5b04          	addw	sp,#4
3786  04ae ac5e0b5e      	jpf	L5202
3787  04b2               L7012:
3788                     ; 367 	else if(UIB[1]==13)
3790  04b2 c60001        	ld	a,_UIB+1
3791  04b5 a10d          	cp	a,#13
3792  04b7 2703cc0555    	jrne	L5312
3793                     ; 372 		if(memory_manufacturer=='A') {	
3795  04bc b6bc          	ld	a,_memory_manufacturer
3796  04be a141          	cp	a,#65
3797  04c0 2608          	jrne	L7312
3798                     ; 373 			DF_page_to_buffer(/*UIB[2],*/UIB[3]);
3800  04c2 c60003        	ld	a,_UIB+3
3801  04c5 5f            	clrw	x
3802  04c6 97            	ld	xl,a
3803  04c7 cd0da8        	call	_DF_page_to_buffer
3805  04ca               L7312:
3806                     ; 375 		if(memory_manufacturer=='S') {
3808  04ca b6bc          	ld	a,_memory_manufacturer
3809  04cc a153          	cp	a,#83
3810  04ce 2703          	jreq	L25
3811  04d0 cc0b5e        	jp	L5202
3812  04d3               L25:
3813                     ; 376 			current_page=11;
3815  04d3 ae000b        	ldw	x,#11
3816  04d6 bf0f          	ldw	_current_page,x
3817                     ; 377 			ST_READ((long)(current_page*256),256, buff);
3819  04d8 ae0050        	ldw	x,#_buff
3820  04db 89            	pushw	x
3821  04dc ae0100        	ldw	x,#256
3822  04df 89            	pushw	x
3823  04e0 ae0b00        	ldw	x,#2816
3824  04e3 89            	pushw	x
3825  04e4 ae0000        	ldw	x,#0
3826  04e7 89            	pushw	x
3827  04e8 cd0cec        	call	_ST_READ
3829  04eb 5b08          	addw	sp,#8
3830                     ; 379 			uart_out_adr_block (0,buff,64);
3832  04ed 4b40          	push	#64
3833  04ef ae0050        	ldw	x,#_buff
3834  04f2 89            	pushw	x
3835  04f3 ae0000        	ldw	x,#0
3836  04f6 89            	pushw	x
3837  04f7 ae0000        	ldw	x,#0
3838  04fa 89            	pushw	x
3839  04fb cd0178        	call	_uart_out_adr_block
3841  04fe 5b07          	addw	sp,#7
3842                     ; 380 			delay_ms(100);    
3844  0500 ae0064        	ldw	x,#100
3845  0503 cd005c        	call	_delay_ms
3847                     ; 381 			uart_out_adr_block (64,&buff[64],64);
3849  0506 4b40          	push	#64
3850  0508 ae0090        	ldw	x,#_buff+64
3851  050b 89            	pushw	x
3852  050c ae0040        	ldw	x,#64
3853  050f 89            	pushw	x
3854  0510 ae0000        	ldw	x,#0
3855  0513 89            	pushw	x
3856  0514 cd0178        	call	_uart_out_adr_block
3858  0517 5b07          	addw	sp,#7
3859                     ; 382 			delay_ms(100);    
3861  0519 ae0064        	ldw	x,#100
3862  051c cd005c        	call	_delay_ms
3864                     ; 383 			uart_out_adr_block (128,&buff[128],64);
3866  051f 4b40          	push	#64
3867  0521 ae00d0        	ldw	x,#_buff+128
3868  0524 89            	pushw	x
3869  0525 ae0080        	ldw	x,#128
3870  0528 89            	pushw	x
3871  0529 ae0000        	ldw	x,#0
3872  052c 89            	pushw	x
3873  052d cd0178        	call	_uart_out_adr_block
3875  0530 5b07          	addw	sp,#7
3876                     ; 384 			delay_ms(100);    
3878  0532 ae0064        	ldw	x,#100
3879  0535 cd005c        	call	_delay_ms
3881                     ; 385 			uart_out_adr_block (192,&buff[192],64);
3883  0538 4b40          	push	#64
3884  053a ae0110        	ldw	x,#_buff+192
3885  053d 89            	pushw	x
3886  053e ae00c0        	ldw	x,#192
3887  0541 89            	pushw	x
3888  0542 ae0000        	ldw	x,#0
3889  0545 89            	pushw	x
3890  0546 cd0178        	call	_uart_out_adr_block
3892  0549 5b07          	addw	sp,#7
3893                     ; 386 			delay_ms(100); 
3895  054b ae0064        	ldw	x,#100
3896  054e cd005c        	call	_delay_ms
3898  0551 ac5e0b5e      	jpf	L5202
3899  0555               L5312:
3900                     ; 389 	else if(UIB[1]==14)
3902  0555 c60001        	ld	a,_UIB+1
3903  0558 a10e          	cp	a,#14
3904  055a 265b          	jrne	L5412
3905                     ; 394 		if(memory_manufacturer=='A') {	
3907  055c b6bc          	ld	a,_memory_manufacturer
3908  055e a141          	cp	a,#65
3909  0560 2608          	jrne	L7412
3910                     ; 395 			DF_buffer_to_page_er(/*UIB[2],*/UIB[3]);
3912  0562 c60003        	ld	a,_UIB+3
3913  0565 5f            	clrw	x
3914  0566 97            	ld	xl,a
3915  0567 cd0dcb        	call	_DF_buffer_to_page_er
3917  056a               L7412:
3918                     ; 397 		if(memory_manufacturer=='S') {
3920  056a b6bc          	ld	a,_memory_manufacturer
3921  056c a153          	cp	a,#83
3922  056e 2703          	jreq	L45
3923  0570 cc0b5e        	jp	L5202
3924  0573               L45:
3925                     ; 398 			for(i=0;i<256;i++) {
3927  0573 5f            	clrw	x
3928  0574 1f05          	ldw	(OFST-1,sp),x
3929  0576               L3512:
3930                     ; 399 				buff[i]=(char)i;
3932  0576 7b06          	ld	a,(OFST+0,sp)
3933  0578 1e05          	ldw	x,(OFST-1,sp)
3934  057a d70050        	ld	(_buff,x),a
3935                     ; 398 			for(i=0;i<256;i++) {
3937  057d 1e05          	ldw	x,(OFST-1,sp)
3938  057f 1c0001        	addw	x,#1
3939  0582 1f05          	ldw	(OFST-1,sp),x
3942  0584 1e05          	ldw	x,(OFST-1,sp)
3943  0586 a30100        	cpw	x,#256
3944  0589 25eb          	jrult	L3512
3945                     ; 401 			current_page=11;
3947  058b ae000b        	ldw	x,#11
3948  058e bf0f          	ldw	_current_page,x
3949                     ; 402 			ST_WREN();
3951  0590 cd0c92        	call	_ST_WREN
3953                     ; 403 			delay_ms(100);
3955  0593 ae0064        	ldw	x,#100
3956  0596 cd005c        	call	_delay_ms
3958                     ; 404 			ST_WRITE((long)(current_page*256),256,buff);		
3960  0599 ae0050        	ldw	x,#_buff
3961  059c 89            	pushw	x
3962  059d ae0100        	ldw	x,#256
3963  05a0 89            	pushw	x
3964  05a1 be0f          	ldw	x,_current_page
3965  05a3 4f            	clr	a
3966  05a4 02            	rlwa	x,a
3967  05a5 cd0000        	call	c_uitolx
3969  05a8 be02          	ldw	x,c_lreg+2
3970  05aa 89            	pushw	x
3971  05ab be00          	ldw	x,c_lreg
3972  05ad 89            	pushw	x
3973  05ae cd0ca0        	call	_ST_WRITE
3975  05b1 5b08          	addw	sp,#8
3976  05b3 ac5e0b5e      	jpf	L5202
3977  05b7               L5412:
3978                     ; 409 	else if(UIB[1]==20)
3980  05b7 c60001        	ld	a,_UIB+1
3981  05ba a114          	cp	a,#20
3982  05bc 2675          	jrne	L3612
3983                     ; 414 		file_lengt=0;
3985  05be ae0000        	ldw	x,#0
3986  05c1 bf09          	ldw	_file_lengt+2,x
3987  05c3 ae0000        	ldw	x,#0
3988  05c6 bf07          	ldw	_file_lengt,x
3989                     ; 415 		file_lengt+=UIB[5];
3991  05c8 c60005        	ld	a,_UIB+5
3992  05cb ae0007        	ldw	x,#_file_lengt
3993  05ce 88            	push	a
3994  05cf cd0000        	call	c_lgadc
3996  05d2 84            	pop	a
3997                     ; 416 		file_lengt<<=8;
3999  05d3 ae0007        	ldw	x,#_file_lengt
4000  05d6 a608          	ld	a,#8
4001  05d8 cd0000        	call	c_lglsh
4003                     ; 417 		file_lengt+=UIB[4];
4005  05db c60004        	ld	a,_UIB+4
4006  05de ae0007        	ldw	x,#_file_lengt
4007  05e1 88            	push	a
4008  05e2 cd0000        	call	c_lgadc
4010  05e5 84            	pop	a
4011                     ; 418 		file_lengt<<=8;
4013  05e6 ae0007        	ldw	x,#_file_lengt
4014  05e9 a608          	ld	a,#8
4015  05eb cd0000        	call	c_lglsh
4017                     ; 419 		file_lengt+=UIB[3];
4019  05ee c60003        	ld	a,_UIB+3
4020  05f1 ae0007        	ldw	x,#_file_lengt
4021  05f4 88            	push	a
4022  05f5 cd0000        	call	c_lgadc
4024  05f8 84            	pop	a
4025                     ; 420 		file_lengt_in_pages=file_lengt;
4027  05f9 be09          	ldw	x,_file_lengt+2
4028  05fb bf11          	ldw	_file_lengt_in_pages,x
4029                     ; 421 		file_lengt<<=8;
4031  05fd ae0007        	ldw	x,#_file_lengt
4032  0600 a608          	ld	a,#8
4033  0602 cd0000        	call	c_lglsh
4035                     ; 422 		file_lengt+=UIB[2];
4037  0605 c60002        	ld	a,_UIB+2
4038  0608 ae0007        	ldw	x,#_file_lengt
4039  060b 88            	push	a
4040  060c cd0000        	call	c_lgadc
4042  060f 84            	pop	a
4043                     ; 427 		current_page=0;
4045  0610 5f            	clrw	x
4046  0611 bf0f          	ldw	_current_page,x
4047                     ; 428 		current_byte_in_buffer=0;
4049  0613 5f            	clrw	x
4050  0614 bf0b          	ldw	_current_byte_in_buffer,x
4051                     ; 430 		if(memory_manufacturer=='S') 
4053  0616 b6bc          	ld	a,_memory_manufacturer
4054  0618 a153          	cp	a,#83
4055  061a 2703          	jreq	L65
4056  061c cc0b5e        	jp	L5202
4057  061f               L65:
4058                     ; 432 			ST_WREN();
4060  061f cd0c92        	call	_ST_WREN
4062                     ; 433 			delay_ms(100);
4064  0622 ae0064        	ldw	x,#100
4065  0625 cd005c        	call	_delay_ms
4067                     ; 434 			ST_bulk_erase();
4069  0628 cd0c6c        	call	_ST_bulk_erase
4071                     ; 435 			bSTART_DOWNLOAD=1;
4073  062b 72100000      	bset	_bSTART_DOWNLOAD
4074  062f ac5e0b5e      	jpf	L5202
4075  0633               L3612:
4076                     ; 441 	else if(UIB[1]==21)
4078  0633 c60001        	ld	a,_UIB+1
4079  0636 a115          	cp	a,#21
4080  0638 2703          	jreq	L06
4081  063a cc072f        	jp	L1712
4082  063d               L06:
4083                     ; 446           for(i=0;i<64;i++)
4085  063d 5f            	clrw	x
4086  063e 1f05          	ldw	(OFST-1,sp),x
4087  0640               L3712:
4088                     ; 448           	buff[current_byte_in_buffer+i]=UIB[2+i];
4090  0640 1e05          	ldw	x,(OFST-1,sp)
4091  0642 d60002        	ld	a,(_UIB+2,x)
4092  0645 be0b          	ldw	x,_current_byte_in_buffer
4093  0647 72fb05        	addw	x,(OFST-1,sp)
4094  064a d70050        	ld	(_buff,x),a
4095                     ; 446           for(i=0;i<64;i++)
4097  064d 1e05          	ldw	x,(OFST-1,sp)
4098  064f 1c0001        	addw	x,#1
4099  0652 1f05          	ldw	(OFST-1,sp),x
4102  0654 1e05          	ldw	x,(OFST-1,sp)
4103  0656 a30040        	cpw	x,#64
4104  0659 25e5          	jrult	L3712
4105                     ; 450           current_byte_in_buffer+=64;
4107  065b be0b          	ldw	x,_current_byte_in_buffer
4108  065d 1c0040        	addw	x,#64
4109  0660 bf0b          	ldw	_current_byte_in_buffer,x
4110                     ; 451           if(current_byte_in_buffer>=256)
4112  0662 be0b          	ldw	x,_current_byte_in_buffer
4113  0664 a30100        	cpw	x,#256
4114  0667 2403          	jruge	L26
4115  0669 cc0b5e        	jp	L5202
4116  066c               L26:
4117                     ; 459 			if(memory_manufacturer=='A') {
4119  066c b6bc          	ld	a,_memory_manufacturer
4120  066e a141          	cp	a,#65
4121  0670 264e          	jrne	L3022
4122                     ; 460 				DF_buffer_write(/*//current_buffer*//*1,*/0,256,buff);
4124  0672 ae0050        	ldw	x,#_buff
4125  0675 89            	pushw	x
4126  0676 ae0100        	ldw	x,#256
4127  0679 89            	pushw	x
4128  067a 5f            	clrw	x
4129  067b cd0e34        	call	_DF_buffer_write
4131  067e 5b04          	addw	sp,#4
4132                     ; 461 				DF_buffer_to_page_er(/*///current_buffer*//*1,*/current_page);
4134  0680 be0f          	ldw	x,_current_page
4135  0682 cd0dcb        	call	_DF_buffer_to_page_er
4137                     ; 462 				current_page++;
4139  0685 be0f          	ldw	x,_current_page
4140  0687 1c0001        	addw	x,#1
4141  068a bf0f          	ldw	_current_page,x
4142                     ; 463 				if(current_page<file_lengt_in_pages)
4144  068c be0f          	ldw	x,_current_page
4145  068e b311          	cpw	x,_file_lengt_in_pages
4146  0690 2424          	jruge	L5022
4147                     ; 465 					delay_ms(100);
4149  0692 ae0064        	ldw	x,#100
4150  0695 cd005c        	call	_delay_ms
4152                     ; 466 					uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
4154  0698 4b00          	push	#0
4155  069a 4b00          	push	#0
4156  069c 3b000f        	push	_current_page
4157  069f b610          	ld	a,_current_page+1
4158  06a1 a4ff          	and	a,#255
4159  06a3 88            	push	a
4160  06a4 4b15          	push	#21
4161  06a6 ae0016        	ldw	x,#22
4162  06a9 a604          	ld	a,#4
4163  06ab 95            	ld	xh,a
4164  06ac cd00ce        	call	_uart_out
4166  06af 5b05          	addw	sp,#5
4167                     ; 467 					current_byte_in_buffer=0;
4169  06b1 5f            	clrw	x
4170  06b2 bf0b          	ldw	_current_byte_in_buffer,x
4172  06b4 200a          	jra	L3022
4173  06b6               L5022:
4174                     ; 471 					EE_PAGE_LEN=current_page;
4176  06b6 be0f          	ldw	x,_current_page
4177  06b8 89            	pushw	x
4178  06b9 ae0000        	ldw	x,#_EE_PAGE_LEN
4179  06bc cd0000        	call	c_eewrw
4181  06bf 85            	popw	x
4182  06c0               L3022:
4183                     ; 474 			if(memory_manufacturer=='S') {
4185  06c0 b6bc          	ld	a,_memory_manufacturer
4186  06c2 a153          	cp	a,#83
4187  06c4 2703          	jreq	L46
4188  06c6 cc0b5e        	jp	L5202
4189  06c9               L46:
4190                     ; 475 				ST_WREN();
4192  06c9 cd0c92        	call	_ST_WREN
4194                     ; 476 				delay_ms(100);
4196  06cc ae0064        	ldw	x,#100
4197  06cf cd005c        	call	_delay_ms
4199                     ; 477 				ST_WRITE((unsigned long)(current_page*256UL),256,buff);
4201  06d2 ae0050        	ldw	x,#_buff
4202  06d5 89            	pushw	x
4203  06d6 ae0100        	ldw	x,#256
4204  06d9 89            	pushw	x
4205  06da be0f          	ldw	x,_current_page
4206  06dc 90ae0100      	ldw	y,#256
4207  06e0 cd0000        	call	c_umul
4209  06e3 be02          	ldw	x,c_lreg+2
4210  06e5 89            	pushw	x
4211  06e6 be00          	ldw	x,c_lreg
4212  06e8 89            	pushw	x
4213  06e9 cd0ca0        	call	_ST_WRITE
4215  06ec 5b08          	addw	sp,#8
4216                     ; 478 				current_page++;
4218  06ee be0f          	ldw	x,_current_page
4219  06f0 1c0001        	addw	x,#1
4220  06f3 bf0f          	ldw	_current_page,x
4221                     ; 479 				if(current_page<file_lengt_in_pages)
4223  06f5 be0f          	ldw	x,_current_page
4224  06f7 b311          	cpw	x,_file_lengt_in_pages
4225  06f9 2426          	jruge	L3122
4226                     ; 481 					delay_ms(100);
4228  06fb ae0064        	ldw	x,#100
4229  06fe cd005c        	call	_delay_ms
4231                     ; 482 					uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
4233  0701 4b00          	push	#0
4234  0703 4b00          	push	#0
4235  0705 3b000f        	push	_current_page
4236  0708 b610          	ld	a,_current_page+1
4237  070a a4ff          	and	a,#255
4238  070c 88            	push	a
4239  070d 4b15          	push	#21
4240  070f ae0016        	ldw	x,#22
4241  0712 a604          	ld	a,#4
4242  0714 95            	ld	xh,a
4243  0715 cd00ce        	call	_uart_out
4245  0718 5b05          	addw	sp,#5
4246                     ; 483 					current_byte_in_buffer=0;
4248  071a 5f            	clrw	x
4249  071b bf0b          	ldw	_current_byte_in_buffer,x
4251  071d ac5e0b5e      	jpf	L5202
4252  0721               L3122:
4253                     ; 487 					EE_PAGE_LEN=current_page;
4255  0721 be0f          	ldw	x,_current_page
4256  0723 89            	pushw	x
4257  0724 ae0000        	ldw	x,#_EE_PAGE_LEN
4258  0727 cd0000        	call	c_eewrw
4260  072a 85            	popw	x
4261  072b ac5e0b5e      	jpf	L5202
4262  072f               L1712:
4263                     ; 498 	else if(UIB[1]==24) {
4265  072f c60001        	ld	a,_UIB+1
4266  0732 a118          	cp	a,#24
4267  0734 2615          	jrne	L1222
4268                     ; 501 		rele_cnt=10;
4270  0736 ae000a        	ldw	x,#10
4271  0739 bf03          	ldw	_rele_cnt,x
4272                     ; 502 		ST_WREN();
4274  073b cd0c92        	call	_ST_WREN
4276                     ; 503 		delay_ms(100);
4278  073e ae0064        	ldw	x,#100
4279  0741 cd005c        	call	_delay_ms
4281                     ; 504 		ST_bulk_erase();
4283  0744 cd0c6c        	call	_ST_bulk_erase
4286  0747 ac5e0b5e      	jpf	L5202
4287  074b               L1222:
4288                     ; 509 	else if(UIB[1]==25)
4290  074b c60001        	ld	a,_UIB+1
4291  074e a119          	cp	a,#25
4292  0750 2703          	jreq	L66
4293  0752 cc0834        	jp	L5222
4294  0755               L66:
4295                     ; 513 		current_page=0;
4297  0755 5f            	clrw	x
4298  0756 bf0f          	ldw	_current_page,x
4299                     ; 515 		for(i__=0;i__<EE_PAGE_LEN;i__++)
4301  0758 5f            	clrw	x
4302  0759 1f05          	ldw	(OFST-1,sp),x
4304  075b ac260826      	jpf	L3322
4305  075f               L7222:
4306                     ; 517 			if(memory_manufacturer=='S') {	
4308  075f b6bc          	ld	a,_memory_manufacturer
4309  0761 a153          	cp	a,#83
4310  0763 2619          	jrne	L7322
4311                     ; 518 				DF_page_to_buffer(i__);
4313  0765 1e05          	ldw	x,(OFST-1,sp)
4314  0767 cd0da8        	call	_DF_page_to_buffer
4316                     ; 519 				delay_ms(100);			
4318  076a ae0064        	ldw	x,#100
4319  076d cd005c        	call	_delay_ms
4321                     ; 520 				DF_buffer_read(0,256, buff);
4323  0770 ae0050        	ldw	x,#_buff
4324  0773 89            	pushw	x
4325  0774 ae0100        	ldw	x,#256
4326  0777 89            	pushw	x
4327  0778 5f            	clrw	x
4328  0779 cd0dee        	call	_DF_buffer_read
4330  077c 5b04          	addw	sp,#4
4331  077e               L7322:
4332                     ; 523 			if(memory_manufacturer=='S') {	
4334  077e b6bc          	ld	a,_memory_manufacturer
4335  0780 a153          	cp	a,#83
4336  0782 261a          	jrne	L1422
4337                     ; 524 				ST_READ((long)(i__*256),256, buff);
4339  0784 ae0050        	ldw	x,#_buff
4340  0787 89            	pushw	x
4341  0788 ae0100        	ldw	x,#256
4342  078b 89            	pushw	x
4343  078c 1e09          	ldw	x,(OFST+3,sp)
4344  078e 4f            	clr	a
4345  078f 02            	rlwa	x,a
4346  0790 cd0000        	call	c_itolx
4348  0793 be02          	ldw	x,c_lreg+2
4349  0795 89            	pushw	x
4350  0796 be00          	ldw	x,c_lreg
4351  0798 89            	pushw	x
4352  0799 cd0cec        	call	_ST_READ
4354  079c 5b08          	addw	sp,#8
4355  079e               L1422:
4356                     ; 527 			uart_out_adr_block ((256*i__)+0,buff,64);
4358  079e 4b40          	push	#64
4359  07a0 ae0050        	ldw	x,#_buff
4360  07a3 89            	pushw	x
4361  07a4 1e08          	ldw	x,(OFST+2,sp)
4362  07a6 4f            	clr	a
4363  07a7 02            	rlwa	x,a
4364  07a8 cd0000        	call	c_itolx
4366  07ab be02          	ldw	x,c_lreg+2
4367  07ad 89            	pushw	x
4368  07ae be00          	ldw	x,c_lreg
4369  07b0 89            	pushw	x
4370  07b1 cd0178        	call	_uart_out_adr_block
4372  07b4 5b07          	addw	sp,#7
4373                     ; 528 			delay_ms(100);    
4375  07b6 ae0064        	ldw	x,#100
4376  07b9 cd005c        	call	_delay_ms
4378                     ; 529 			uart_out_adr_block ((256*i__)+64,&buff[64],64);
4380  07bc 4b40          	push	#64
4381  07be ae0090        	ldw	x,#_buff+64
4382  07c1 89            	pushw	x
4383  07c2 1e08          	ldw	x,(OFST+2,sp)
4384  07c4 4f            	clr	a
4385  07c5 02            	rlwa	x,a
4386  07c6 1c0040        	addw	x,#64
4387  07c9 cd0000        	call	c_itolx
4389  07cc be02          	ldw	x,c_lreg+2
4390  07ce 89            	pushw	x
4391  07cf be00          	ldw	x,c_lreg
4392  07d1 89            	pushw	x
4393  07d2 cd0178        	call	_uart_out_adr_block
4395  07d5 5b07          	addw	sp,#7
4396                     ; 530 			delay_ms(100);    
4398  07d7 ae0064        	ldw	x,#100
4399  07da cd005c        	call	_delay_ms
4401                     ; 531 			uart_out_adr_block ((256*i__)+128,&buff[128],64);
4403  07dd 4b40          	push	#64
4404  07df ae00d0        	ldw	x,#_buff+128
4405  07e2 89            	pushw	x
4406  07e3 1e08          	ldw	x,(OFST+2,sp)
4407  07e5 4f            	clr	a
4408  07e6 02            	rlwa	x,a
4409  07e7 1c0080        	addw	x,#128
4410  07ea cd0000        	call	c_itolx
4412  07ed be02          	ldw	x,c_lreg+2
4413  07ef 89            	pushw	x
4414  07f0 be00          	ldw	x,c_lreg
4415  07f2 89            	pushw	x
4416  07f3 cd0178        	call	_uart_out_adr_block
4418  07f6 5b07          	addw	sp,#7
4419                     ; 532 			delay_ms(100);    
4421  07f8 ae0064        	ldw	x,#100
4422  07fb cd005c        	call	_delay_ms
4424                     ; 533 			uart_out_adr_block ((256*i__)+192,&buff[192],64);
4426  07fe 4b40          	push	#64
4427  0800 ae0110        	ldw	x,#_buff+192
4428  0803 89            	pushw	x
4429  0804 1e08          	ldw	x,(OFST+2,sp)
4430  0806 4f            	clr	a
4431  0807 02            	rlwa	x,a
4432  0808 1c00c0        	addw	x,#192
4433  080b cd0000        	call	c_itolx
4435  080e be02          	ldw	x,c_lreg+2
4436  0810 89            	pushw	x
4437  0811 be00          	ldw	x,c_lreg
4438  0813 89            	pushw	x
4439  0814 cd0178        	call	_uart_out_adr_block
4441  0817 5b07          	addw	sp,#7
4442                     ; 534 			delay_ms(100);   
4444  0819 ae0064        	ldw	x,#100
4445  081c cd005c        	call	_delay_ms
4447                     ; 515 		for(i__=0;i__<EE_PAGE_LEN;i__++)
4449  081f 1e05          	ldw	x,(OFST-1,sp)
4450  0821 1c0001        	addw	x,#1
4451  0824 1f05          	ldw	(OFST-1,sp),x
4452  0826               L3322:
4455  0826 1e05          	ldw	x,(OFST-1,sp)
4456  0828 c30000        	cpw	x,_EE_PAGE_LEN
4457  082b 2403          	jruge	L07
4458  082d cc075f        	jp	L7222
4459  0830               L07:
4461  0830 ac5e0b5e      	jpf	L5202
4462  0834               L5222:
4463                     ; 544 	else if(UIB[1]==30)
4465  0834 c60001        	ld	a,_UIB+1
4466  0837 a11e          	cp	a,#30
4467  0839 2608          	jrne	L5422
4468                     ; 566           bSTART=1;
4470  083b 7210000e      	bset	_bSTART
4472  083f ac5e0b5e      	jpf	L5202
4473  0843               L5422:
4474                     ; 578 	else if(UIB[1]==40)
4476  0843 c60001        	ld	a,_UIB+1
4477  0846 a128          	cp	a,#40
4478  0848 2608          	jrne	L1522
4479                     ; 600 		bSTART=1;	
4481  084a 7210000e      	bset	_bSTART
4483  084e ac5e0b5e      	jpf	L5202
4484  0852               L1522:
4485                     ; 602 	else if(UIB[1]==81)
4487  0852 c60001        	ld	a,_UIB+1
4488  0855 a151          	cp	a,#81
4489  0857 2703          	jreq	L27
4490  0859 cc0930        	jp	L5522
4491  085c               L27:
4492                     ; 608 		if(memory_manufacturer=='A') 
4494  085c b6bc          	ld	a,_memory_manufacturer
4495  085e a141          	cp	a,#65
4496  0860 2608          	jrne	L7522
4497                     ; 610 			DF_page_to_buffer(/*UIB[2],*/UIB[3]);
4499  0862 c60003        	ld	a,_UIB+3
4500  0865 5f            	clrw	x
4501  0866 97            	ld	xl,a
4502  0867 cd0da8        	call	_DF_page_to_buffer
4504  086a               L7522:
4505                     ; 616 			adress=UIB[5];
4507  086a c60005        	ld	a,_UIB+5
4508  086d 6b06          	ld	(OFST+0,sp),a
4509  086f 4f            	clr	a
4510  0870 6b05          	ld	(OFST-1,sp),a
4511  0872 6b04          	ld	(OFST-2,sp),a
4512  0874 6b03          	ld	(OFST-3,sp),a
4513                     ; 617 			adress<<=8;
4515  0876 96            	ldw	x,sp
4516  0877 1c0003        	addw	x,#OFST-3
4517  087a a608          	ld	a,#8
4518  087c cd0000        	call	c_lglsh
4520                     ; 618 			adress+=UIB[4];
4522  087f c60004        	ld	a,_UIB+4
4523  0882 96            	ldw	x,sp
4524  0883 1c0003        	addw	x,#OFST-3
4525  0886 88            	push	a
4526  0887 cd0000        	call	c_lgadc
4528  088a 84            	pop	a
4529                     ; 619 			adress<<=8;
4531  088b 96            	ldw	x,sp
4532  088c 1c0003        	addw	x,#OFST-3
4533  088f a608          	ld	a,#8
4534  0891 cd0000        	call	c_lglsh
4536                     ; 620 			adress+=UIB[3];
4538  0894 c60003        	ld	a,_UIB+3
4539  0897 96            	ldw	x,sp
4540  0898 1c0003        	addw	x,#OFST-3
4541  089b 88            	push	a
4542  089c cd0000        	call	c_lgadc
4544  089f 84            	pop	a
4545                     ; 621 			adress<<=8;
4547  08a0 96            	ldw	x,sp
4548  08a1 1c0003        	addw	x,#OFST-3
4549  08a4 a608          	ld	a,#8
4550  08a6 cd0000        	call	c_lglsh
4552                     ; 622 			adress+=UIB[2];
4554  08a9 c60002        	ld	a,_UIB+2
4555  08ac 96            	ldw	x,sp
4556  08ad 1c0003        	addw	x,#OFST-3
4557  08b0 88            	push	a
4558  08b1 cd0000        	call	c_lgadc
4560  08b4 84            	pop	a
4561                     ; 624 			ST_READ(adress,256, buff);
4563  08b5 ae0050        	ldw	x,#_buff
4564  08b8 89            	pushw	x
4565  08b9 ae0100        	ldw	x,#256
4566  08bc 89            	pushw	x
4567  08bd 1e09          	ldw	x,(OFST+3,sp)
4568  08bf 89            	pushw	x
4569  08c0 1e09          	ldw	x,(OFST+3,sp)
4570  08c2 89            	pushw	x
4571  08c3 cd0cec        	call	_ST_READ
4573  08c6 5b08          	addw	sp,#8
4574                     ; 636 		uart_out_adr_block (0,buff,64);
4576  08c8 4b40          	push	#64
4577  08ca ae0050        	ldw	x,#_buff
4578  08cd 89            	pushw	x
4579  08ce ae0000        	ldw	x,#0
4580  08d1 89            	pushw	x
4581  08d2 ae0000        	ldw	x,#0
4582  08d5 89            	pushw	x
4583  08d6 cd0178        	call	_uart_out_adr_block
4585  08d9 5b07          	addw	sp,#7
4586                     ; 637 		delay_ms(100);    
4588  08db ae0064        	ldw	x,#100
4589  08de cd005c        	call	_delay_ms
4591                     ; 638 		uart_out_adr_block (64,&buff[64],64);
4593  08e1 4b40          	push	#64
4594  08e3 ae0090        	ldw	x,#_buff+64
4595  08e6 89            	pushw	x
4596  08e7 ae0040        	ldw	x,#64
4597  08ea 89            	pushw	x
4598  08eb ae0000        	ldw	x,#0
4599  08ee 89            	pushw	x
4600  08ef cd0178        	call	_uart_out_adr_block
4602  08f2 5b07          	addw	sp,#7
4603                     ; 639 		delay_ms(100);    
4605  08f4 ae0064        	ldw	x,#100
4606  08f7 cd005c        	call	_delay_ms
4608                     ; 640 		uart_out_adr_block (128,&buff[128],64);
4610  08fa 4b40          	push	#64
4611  08fc ae00d0        	ldw	x,#_buff+128
4612  08ff 89            	pushw	x
4613  0900 ae0080        	ldw	x,#128
4614  0903 89            	pushw	x
4615  0904 ae0000        	ldw	x,#0
4616  0907 89            	pushw	x
4617  0908 cd0178        	call	_uart_out_adr_block
4619  090b 5b07          	addw	sp,#7
4620                     ; 641 		delay_ms(100);    
4622  090d ae0064        	ldw	x,#100
4623  0910 cd005c        	call	_delay_ms
4625                     ; 642 		uart_out_adr_block (192,&buff[192],64);
4627  0913 4b40          	push	#64
4628  0915 ae0110        	ldw	x,#_buff+192
4629  0918 89            	pushw	x
4630  0919 ae00c0        	ldw	x,#192
4631  091c 89            	pushw	x
4632  091d ae0000        	ldw	x,#0
4633  0920 89            	pushw	x
4634  0921 cd0178        	call	_uart_out_adr_block
4636  0924 5b07          	addw	sp,#7
4637                     ; 643 		delay_ms(100);
4639  0926 ae0064        	ldw	x,#100
4640  0929 cd005c        	call	_delay_ms
4643  092c ac5e0b5e      	jpf	L5202
4644  0930               L5522:
4645                     ; 649 	else if(UIB[1]==91)
4647  0930 c60001        	ld	a,_UIB+1
4648  0933 a15b          	cp	a,#91
4649  0935 2703          	jreq	L47
4650  0937 cc09d4        	jp	L3622
4651  093a               L47:
4652                     ; 655 		if(memory_manufacturer=='A') 
4654  093a b6bc          	ld	a,_memory_manufacturer
4655  093c a141          	cp	a,#65
4656  093e 2608          	jrne	L5622
4657                     ; 657 			DF_buffer_to_page_er(/*UIB[2],*/UIB[3]);
4659  0940 c60003        	ld	a,_UIB+3
4660  0943 5f            	clrw	x
4661  0944 97            	ld	xl,a
4662  0945 cd0dcb        	call	_DF_buffer_to_page_er
4664  0948               L5622:
4665                     ; 659 		if(memory_manufacturer=='S') 
4667  0948 b6bc          	ld	a,_memory_manufacturer
4668  094a a153          	cp	a,#83
4669  094c 2703          	jreq	L67
4670  094e cc0b5e        	jp	L5202
4671  0951               L67:
4672                     ; 661 			for(i=0;i<256;i++) 
4674  0951 5f            	clrw	x
4675  0952 1f05          	ldw	(OFST-1,sp),x
4676  0954               L1722:
4677                     ; 663 				buff[i]=(char)i;
4679  0954 7b06          	ld	a,(OFST+0,sp)
4680  0956 1e05          	ldw	x,(OFST-1,sp)
4681  0958 d70050        	ld	(_buff,x),a
4682                     ; 661 			for(i=0;i<256;i++) 
4684  095b 1e05          	ldw	x,(OFST-1,sp)
4685  095d 1c0001        	addw	x,#1
4686  0960 1f05          	ldw	(OFST-1,sp),x
4689  0962 1e05          	ldw	x,(OFST-1,sp)
4690  0964 a30100        	cpw	x,#256
4691  0967 25eb          	jrult	L1722
4692                     ; 665 			adress=UIB[5];
4694  0969 c60005        	ld	a,_UIB+5
4695  096c 6b04          	ld	(OFST-2,sp),a
4696  096e 4f            	clr	a
4697  096f 6b03          	ld	(OFST-3,sp),a
4698  0971 6b02          	ld	(OFST-4,sp),a
4699  0973 6b01          	ld	(OFST-5,sp),a
4700                     ; 666 			adress<<=8;
4702  0975 96            	ldw	x,sp
4703  0976 1c0001        	addw	x,#OFST-5
4704  0979 a608          	ld	a,#8
4705  097b cd0000        	call	c_lglsh
4707                     ; 667 			adress+=UIB[4];
4709  097e c60004        	ld	a,_UIB+4
4710  0981 96            	ldw	x,sp
4711  0982 1c0001        	addw	x,#OFST-5
4712  0985 88            	push	a
4713  0986 cd0000        	call	c_lgadc
4715  0989 84            	pop	a
4716                     ; 668 			adress<<=8;
4718  098a 96            	ldw	x,sp
4719  098b 1c0001        	addw	x,#OFST-5
4720  098e a608          	ld	a,#8
4721  0990 cd0000        	call	c_lglsh
4723                     ; 669 			adress+=UIB[3];
4725  0993 c60003        	ld	a,_UIB+3
4726  0996 96            	ldw	x,sp
4727  0997 1c0001        	addw	x,#OFST-5
4728  099a 88            	push	a
4729  099b cd0000        	call	c_lgadc
4731  099e 84            	pop	a
4732                     ; 670 			adress<<=8;
4734  099f 96            	ldw	x,sp
4735  09a0 1c0001        	addw	x,#OFST-5
4736  09a3 a608          	ld	a,#8
4737  09a5 cd0000        	call	c_lglsh
4739                     ; 671 			adress+=UIB[2];
4741  09a8 c60002        	ld	a,_UIB+2
4742  09ab 96            	ldw	x,sp
4743  09ac 1c0001        	addw	x,#OFST-5
4744  09af 88            	push	a
4745  09b0 cd0000        	call	c_lgadc
4747  09b3 84            	pop	a
4748                     ; 673 			ST_WREN();
4750  09b4 cd0c92        	call	_ST_WREN
4752                     ; 674 			delay_ms(100);
4754  09b7 ae0064        	ldw	x,#100
4755  09ba cd005c        	call	_delay_ms
4757                     ; 675 			ST_WRITE(adress,256,buff);		
4759  09bd ae0050        	ldw	x,#_buff
4760  09c0 89            	pushw	x
4761  09c1 ae0100        	ldw	x,#256
4762  09c4 89            	pushw	x
4763  09c5 1e07          	ldw	x,(OFST+1,sp)
4764  09c7 89            	pushw	x
4765  09c8 1e07          	ldw	x,(OFST+1,sp)
4766  09ca 89            	pushw	x
4767  09cb cd0ca0        	call	_ST_WRITE
4769  09ce 5b08          	addw	sp,#8
4770  09d0 ac5e0b5e      	jpf	L5202
4771  09d4               L3622:
4772                     ; 680 	else if(UIB[1]==92)
4774  09d4 c60001        	ld	a,_UIB+1
4775  09d7 a15c          	cp	a,#92
4776  09d9 2703          	jreq	L001
4777  09db cc0a95        	jp	L1032
4778  09de               L001:
4779                     ; 686 		if(memory_manufacturer=='A') 
4781  09de b6bc          	ld	a,_memory_manufacturer
4782  09e0 a141          	cp	a,#65
4783  09e2 2608          	jrne	L3032
4784                     ; 688 			DF_buffer_to_page_er(/*UIB[2],*/UIB[3]);
4786  09e4 c60003        	ld	a,_UIB+3
4787  09e7 5f            	clrw	x
4788  09e8 97            	ld	xl,a
4789  09e9 cd0dcb        	call	_DF_buffer_to_page_er
4791  09ec               L3032:
4792                     ; 690 		if(memory_manufacturer=='S') 
4794  09ec b6bc          	ld	a,_memory_manufacturer
4795  09ee a153          	cp	a,#83
4796  09f0 2703          	jreq	L201
4797  09f2 cc0b5e        	jp	L5202
4798  09f5               L201:
4799                     ; 692 			for(i=0;i<128;i++) 
4801  09f5 5f            	clrw	x
4802  09f6 1f05          	ldw	(OFST-1,sp),x
4803  09f8               L7032:
4804                     ; 694 				buff[i]=(char)(i*2);
4806  09f8 7b06          	ld	a,(OFST+0,sp)
4807  09fa 48            	sll	a
4808  09fb 1e05          	ldw	x,(OFST-1,sp)
4809  09fd d70050        	ld	(_buff,x),a
4810                     ; 692 			for(i=0;i<128;i++) 
4812  0a00 1e05          	ldw	x,(OFST-1,sp)
4813  0a02 1c0001        	addw	x,#1
4814  0a05 1f05          	ldw	(OFST-1,sp),x
4817  0a07 1e05          	ldw	x,(OFST-1,sp)
4818  0a09 a30080        	cpw	x,#128
4819  0a0c 25ea          	jrult	L7032
4820                     ; 696 			for(i=0;i<128;i++) 
4822  0a0e 5f            	clrw	x
4823  0a0f 1f05          	ldw	(OFST-1,sp),x
4824  0a11               L5132:
4825                     ; 698 				buff[i+128]=(char)(255-(i*2));
4827  0a11 7b06          	ld	a,(OFST+0,sp)
4828  0a13 48            	sll	a
4829  0a14 a0ff          	sub	a,#255
4830  0a16 40            	neg	a
4831  0a17 1e05          	ldw	x,(OFST-1,sp)
4832  0a19 d700d0        	ld	(_buff+128,x),a
4833                     ; 696 			for(i=0;i<128;i++) 
4835  0a1c 1e05          	ldw	x,(OFST-1,sp)
4836  0a1e 1c0001        	addw	x,#1
4837  0a21 1f05          	ldw	(OFST-1,sp),x
4840  0a23 1e05          	ldw	x,(OFST-1,sp)
4841  0a25 a30080        	cpw	x,#128
4842  0a28 25e7          	jrult	L5132
4843                     ; 700 			adress=UIB[5];
4845  0a2a c60005        	ld	a,_UIB+5
4846  0a2d 6b04          	ld	(OFST-2,sp),a
4847  0a2f 4f            	clr	a
4848  0a30 6b03          	ld	(OFST-3,sp),a
4849  0a32 6b02          	ld	(OFST-4,sp),a
4850  0a34 6b01          	ld	(OFST-5,sp),a
4851                     ; 701 			adress<<=8;
4853  0a36 96            	ldw	x,sp
4854  0a37 1c0001        	addw	x,#OFST-5
4855  0a3a a608          	ld	a,#8
4856  0a3c cd0000        	call	c_lglsh
4858                     ; 702 			adress+=UIB[4];
4860  0a3f c60004        	ld	a,_UIB+4
4861  0a42 96            	ldw	x,sp
4862  0a43 1c0001        	addw	x,#OFST-5
4863  0a46 88            	push	a
4864  0a47 cd0000        	call	c_lgadc
4866  0a4a 84            	pop	a
4867                     ; 703 			adress<<=8;
4869  0a4b 96            	ldw	x,sp
4870  0a4c 1c0001        	addw	x,#OFST-5
4871  0a4f a608          	ld	a,#8
4872  0a51 cd0000        	call	c_lglsh
4874                     ; 704 			adress+=UIB[3];
4876  0a54 c60003        	ld	a,_UIB+3
4877  0a57 96            	ldw	x,sp
4878  0a58 1c0001        	addw	x,#OFST-5
4879  0a5b 88            	push	a
4880  0a5c cd0000        	call	c_lgadc
4882  0a5f 84            	pop	a
4883                     ; 705 			adress<<=8;
4885  0a60 96            	ldw	x,sp
4886  0a61 1c0001        	addw	x,#OFST-5
4887  0a64 a608          	ld	a,#8
4888  0a66 cd0000        	call	c_lglsh
4890                     ; 706 			adress+=UIB[2];
4892  0a69 c60002        	ld	a,_UIB+2
4893  0a6c 96            	ldw	x,sp
4894  0a6d 1c0001        	addw	x,#OFST-5
4895  0a70 88            	push	a
4896  0a71 cd0000        	call	c_lgadc
4898  0a74 84            	pop	a
4899                     ; 708 			ST_WREN();
4901  0a75 cd0c92        	call	_ST_WREN
4903                     ; 709 			delay_ms(100);
4905  0a78 ae0064        	ldw	x,#100
4906  0a7b cd005c        	call	_delay_ms
4908                     ; 710 			ST_WRITE(adress,256,buff);		
4910  0a7e ae0050        	ldw	x,#_buff
4911  0a81 89            	pushw	x
4912  0a82 ae0100        	ldw	x,#256
4913  0a85 89            	pushw	x
4914  0a86 1e07          	ldw	x,(OFST+1,sp)
4915  0a88 89            	pushw	x
4916  0a89 1e07          	ldw	x,(OFST+1,sp)
4917  0a8b 89            	pushw	x
4918  0a8c cd0ca0        	call	_ST_WRITE
4920  0a8f 5b08          	addw	sp,#8
4921  0a91 ac5e0b5e      	jpf	L5202
4922  0a95               L1032:
4923                     ; 715 	else if(UIB[1]==93)
4925  0a95 c60001        	ld	a,_UIB+1
4926  0a98 a15d          	cp	a,#93
4927  0a9a 2703          	jreq	L401
4928  0a9c cc0b39        	jp	L5232
4929  0a9f               L401:
4930                     ; 721 		if(memory_manufacturer=='A') 
4932  0a9f b6bc          	ld	a,_memory_manufacturer
4933  0aa1 a141          	cp	a,#65
4934  0aa3 2608          	jrne	L7232
4935                     ; 723 			DF_buffer_to_page_er(/*UIB[2],*/UIB[3]);
4937  0aa5 c60003        	ld	a,_UIB+3
4938  0aa8 5f            	clrw	x
4939  0aa9 97            	ld	xl,a
4940  0aaa cd0dcb        	call	_DF_buffer_to_page_er
4942  0aad               L7232:
4943                     ; 725 		if(memory_manufacturer=='S') 
4945  0aad b6bc          	ld	a,_memory_manufacturer
4946  0aaf a153          	cp	a,#83
4947  0ab1 2703          	jreq	L601
4948  0ab3 cc0b5e        	jp	L5202
4949  0ab6               L601:
4950                     ; 727 			for(i=0;i<256;i++) 
4952  0ab6 5f            	clrw	x
4953  0ab7 1f05          	ldw	(OFST-1,sp),x
4954  0ab9               L3332:
4955                     ; 729 				buff[i]=(char)(255-i);
4957  0ab9 a6ff          	ld	a,#255
4958  0abb 1006          	sub	a,(OFST+0,sp)
4959  0abd 1e05          	ldw	x,(OFST-1,sp)
4960  0abf d70050        	ld	(_buff,x),a
4961                     ; 727 			for(i=0;i<256;i++) 
4963  0ac2 1e05          	ldw	x,(OFST-1,sp)
4964  0ac4 1c0001        	addw	x,#1
4965  0ac7 1f05          	ldw	(OFST-1,sp),x
4968  0ac9 1e05          	ldw	x,(OFST-1,sp)
4969  0acb a30100        	cpw	x,#256
4970  0ace 25e9          	jrult	L3332
4971                     ; 731 			adress=UIB[5];
4973  0ad0 c60005        	ld	a,_UIB+5
4974  0ad3 6b04          	ld	(OFST-2,sp),a
4975  0ad5 4f            	clr	a
4976  0ad6 6b03          	ld	(OFST-3,sp),a
4977  0ad8 6b02          	ld	(OFST-4,sp),a
4978  0ada 6b01          	ld	(OFST-5,sp),a
4979                     ; 732 			adress<<=8;
4981  0adc 96            	ldw	x,sp
4982  0add 1c0001        	addw	x,#OFST-5
4983  0ae0 a608          	ld	a,#8
4984  0ae2 cd0000        	call	c_lglsh
4986                     ; 733 			adress+=UIB[4];
4988  0ae5 c60004        	ld	a,_UIB+4
4989  0ae8 96            	ldw	x,sp
4990  0ae9 1c0001        	addw	x,#OFST-5
4991  0aec 88            	push	a
4992  0aed cd0000        	call	c_lgadc
4994  0af0 84            	pop	a
4995                     ; 734 			adress<<=8;
4997  0af1 96            	ldw	x,sp
4998  0af2 1c0001        	addw	x,#OFST-5
4999  0af5 a608          	ld	a,#8
5000  0af7 cd0000        	call	c_lglsh
5002                     ; 735 			adress+=UIB[3];
5004  0afa c60003        	ld	a,_UIB+3
5005  0afd 96            	ldw	x,sp
5006  0afe 1c0001        	addw	x,#OFST-5
5007  0b01 88            	push	a
5008  0b02 cd0000        	call	c_lgadc
5010  0b05 84            	pop	a
5011                     ; 736 			adress<<=8;
5013  0b06 96            	ldw	x,sp
5014  0b07 1c0001        	addw	x,#OFST-5
5015  0b0a a608          	ld	a,#8
5016  0b0c cd0000        	call	c_lglsh
5018                     ; 737 			adress+=UIB[2];
5020  0b0f c60002        	ld	a,_UIB+2
5021  0b12 96            	ldw	x,sp
5022  0b13 1c0001        	addw	x,#OFST-5
5023  0b16 88            	push	a
5024  0b17 cd0000        	call	c_lgadc
5026  0b1a 84            	pop	a
5027                     ; 739 			ST_WREN();
5029  0b1b cd0c92        	call	_ST_WREN
5031                     ; 740 			delay_ms(100);
5033  0b1e ae0064        	ldw	x,#100
5034  0b21 cd005c        	call	_delay_ms
5036                     ; 741 			ST_WRITE(adress,256,buff);		
5038  0b24 ae0050        	ldw	x,#_buff
5039  0b27 89            	pushw	x
5040  0b28 ae0100        	ldw	x,#256
5041  0b2b 89            	pushw	x
5042  0b2c 1e07          	ldw	x,(OFST+1,sp)
5043  0b2e 89            	pushw	x
5044  0b2f 1e07          	ldw	x,(OFST+1,sp)
5045  0b31 89            	pushw	x
5046  0b32 cd0ca0        	call	_ST_WRITE
5048  0b35 5b08          	addw	sp,#8
5049  0b37 2025          	jra	L5202
5050  0b39               L5232:
5051                     ; 746 	else if(UIB[1]==100) 
5053  0b39 c60001        	ld	a,_UIB+1
5054  0b3c a164          	cp	a,#100
5055  0b3e 2613          	jrne	L3432
5056                     ; 750 		rele_cnt=10;
5058  0b40 ae000a        	ldw	x,#10
5059  0b43 bf03          	ldw	_rele_cnt,x
5060                     ; 751 		ST_WREN();
5062  0b45 cd0c92        	call	_ST_WREN
5064                     ; 752 		delay_ms(100);
5066  0b48 ae0064        	ldw	x,#100
5067  0b4b cd005c        	call	_delay_ms
5069                     ; 753 		ST_bulk_erase();
5071  0b4e cd0c6c        	call	_ST_bulk_erase
5074  0b51 200b          	jra	L5202
5075  0b53               L3432:
5076                     ; 758 	else if(UIB[1]==101) 
5078  0b53 c60001        	ld	a,_UIB+1
5079  0b56 a165          	cp	a,#101
5080  0b58 2604          	jrne	L5202
5081                     ; 760 		bSTART=1;    
5083  0b5a 7210000e      	bset	_bSTART
5084  0b5e               L5202:
5085                     ; 764 }
5088  0b5e 5b06          	addw	sp,#6
5089  0b60 81            	ret
5126                     ; 767 void putchar(char c)
5126                     ; 768 {
5127                     	switch	.text
5128  0b61               _putchar:
5130  0b61 88            	push	a
5131       00000000      OFST:	set	0
5134  0b62               L1732:
5135                     ; 769 while (tx_counter == TX_BUFFER_SIZE);
5137  0b62 b620          	ld	a,_tx_counter
5138  0b64 a150          	cp	a,#80
5139  0b66 27fa          	jreq	L1732
5140                     ; 771 if (tx_counter || ((UART1->SR & UART1_SR_TXE)==0))
5142  0b68 3d20          	tnz	_tx_counter
5143  0b6a 2607          	jrne	L7732
5145  0b6c c65230        	ld	a,21040
5146  0b6f a580          	bcp	a,#128
5147  0b71 261d          	jrne	L5732
5148  0b73               L7732:
5149                     ; 773    tx_buffer[tx_wr_index]=c;
5151  0b73 5f            	clrw	x
5152  0b74 b61f          	ld	a,_tx_wr_index
5153  0b76 2a01          	jrpl	L211
5154  0b78 53            	cplw	x
5155  0b79               L211:
5156  0b79 97            	ld	xl,a
5157  0b7a 7b01          	ld	a,(OFST+1,sp)
5158  0b7c e704          	ld	(_tx_buffer,x),a
5159                     ; 774    if (++tx_wr_index == TX_BUFFER_SIZE) tx_wr_index=0;
5161  0b7e 3c1f          	inc	_tx_wr_index
5162  0b80 b61f          	ld	a,_tx_wr_index
5163  0b82 a150          	cp	a,#80
5164  0b84 2602          	jrne	L1042
5167  0b86 3f1f          	clr	_tx_wr_index
5168  0b88               L1042:
5169                     ; 775    ++tx_counter;
5171  0b88 3c20          	inc	_tx_counter
5173  0b8a               L3042:
5174                     ; 779 UART1->CR2|= UART1_CR2_TIEN;
5176  0b8a 721e5235      	bset	21045,#7
5177                     ; 781 }
5180  0b8e 84            	pop	a
5181  0b8f 81            	ret
5182  0b90               L5732:
5183                     ; 777 else UART1->DR=c;
5185  0b90 7b01          	ld	a,(OFST+1,sp)
5186  0b92 c75231        	ld	21041,a
5187  0b95 20f3          	jra	L3042
5210                     ; 784 void spi_init(void){
5211                     	switch	.text
5212  0b97               _spi_init:
5216                     ; 786 	GPIOA->DDR|=(1<<3);
5218  0b97 72165002      	bset	20482,#3
5219                     ; 787 	GPIOA->CR1|=(1<<3);
5221  0b9b 72165003      	bset	20483,#3
5222                     ; 788 	GPIOA->CR2&=~(1<<3);
5224  0b9f 72175004      	bres	20484,#3
5225                     ; 789 	GPIOA->ODR|=(1<<3);	
5227  0ba3 72165000      	bset	20480,#3
5228                     ; 792 	GPIOB->DDR|=(1<<5);
5230  0ba7 721a5007      	bset	20487,#5
5231                     ; 793 	GPIOB->CR1|=(1<<5);
5233  0bab 721a5008      	bset	20488,#5
5234                     ; 794 	GPIOB->CR2&=~(1<<5);
5236  0baf 721b5009      	bres	20489,#5
5237                     ; 795 	GPIOB->ODR|=(1<<5);	
5239  0bb3 721a5005      	bset	20485,#5
5240                     ; 797 	GPIOC->DDR|=(1<<3);
5242  0bb7 7216500c      	bset	20492,#3
5243                     ; 798 	GPIOC->CR1|=(1<<3);
5245  0bbb 7216500d      	bset	20493,#3
5246                     ; 799 	GPIOC->CR2&=~(1<<3);
5248  0bbf 7217500e      	bres	20494,#3
5249                     ; 800 	GPIOC->ODR|=(1<<3);	
5251  0bc3 7216500a      	bset	20490,#3
5252                     ; 802 	GPIOC->DDR|=(1<<5);
5254  0bc7 721a500c      	bset	20492,#5
5255                     ; 803 	GPIOC->CR1|=(1<<5);
5257  0bcb 721a500d      	bset	20493,#5
5258                     ; 804 	GPIOC->CR2|=(1<<5);
5260  0bcf 721a500e      	bset	20494,#5
5261                     ; 805 	GPIOC->ODR|=(1<<5);	
5263  0bd3 721a500a      	bset	20490,#5
5264                     ; 807 	GPIOC->DDR|=(1<<6);
5266  0bd7 721c500c      	bset	20492,#6
5267                     ; 808 	GPIOC->CR1|=(1<<6);
5269  0bdb 721c500d      	bset	20493,#6
5270                     ; 809 	GPIOC->CR2|=(1<<6);
5272  0bdf 721c500e      	bset	20494,#6
5273                     ; 810 	GPIOC->ODR|=(1<<6);	
5275  0be3 721c500a      	bset	20490,#6
5276                     ; 812 	GPIOC->DDR&=~(1<<7);
5278  0be7 721f500c      	bres	20492,#7
5279                     ; 813 	GPIOC->CR1&=~(1<<7);
5281  0beb 721f500d      	bres	20493,#7
5282                     ; 814 	GPIOC->CR2&=~(1<<7);
5284  0bef 721f500e      	bres	20494,#7
5285                     ; 815 	GPIOC->ODR|=(1<<7);	
5287  0bf3 721e500a      	bset	20490,#7
5288                     ; 817 	SPI->CR1= /*SPI_CR1_LSBFIRST |*/
5288                     ; 818 			SPI_CR1_SPE | 
5288                     ; 819 			( (4<< 3) & SPI_CR1_BR ) |
5288                     ; 820 			SPI_CR1_MSTR |
5288                     ; 821 			SPI_CR1_CPOL |
5288                     ; 822 			SPI_CR1_CPHA; 
5290  0bf7 35675200      	mov	20992,#103
5291                     ; 824 	SPI->CR2= SPI_CR2_SSM | SPI_CR2_SSI;
5293  0bfb 35035201      	mov	20993,#3
5294                     ; 825 	SPI->ICR= 0;	
5296  0bff 725f5202      	clr	20994
5297                     ; 826 }
5300  0c03 81            	ret
5343                     ; 829 char spi(char in){
5344                     	switch	.text
5345  0c04               _spi:
5347  0c04 88            	push	a
5348  0c05 88            	push	a
5349       00000001      OFST:	set	1
5352  0c06               L1442:
5353                     ; 831 	while(!((SPI->SR)&SPI_SR_TXE));
5355  0c06 c65203        	ld	a,20995
5356  0c09 a502          	bcp	a,#2
5357  0c0b 27f9          	jreq	L1442
5358                     ; 832 	SPI->DR=in;
5360  0c0d 7b02          	ld	a,(OFST+1,sp)
5361  0c0f c75204        	ld	20996,a
5363  0c12               L1542:
5364                     ; 833 	while(!((SPI->SR)&SPI_SR_RXNE));
5366  0c12 c65203        	ld	a,20995
5367  0c15 a501          	bcp	a,#1
5368  0c17 27f9          	jreq	L1542
5369                     ; 834 	c=SPI->DR;	
5371  0c19 c65204        	ld	a,20996
5372  0c1c 6b01          	ld	(OFST+0,sp),a
5373                     ; 835 	return c;
5375  0c1e 7b01          	ld	a,(OFST+0,sp)
5378  0c20 85            	popw	x
5379  0c21 81            	ret
5445                     ; 839 long ST_RDID_read(void)
5445                     ; 840 {
5446                     	switch	.text
5447  0c22               _ST_RDID_read:
5449  0c22 5204          	subw	sp,#4
5450       00000004      OFST:	set	4
5453                     ; 843 d0=0;
5455  0c24 0f04          	clr	(OFST+0,sp)
5456                     ; 844 d1=0;
5458                     ; 845 d2=0;
5460                     ; 846 d3=0;
5462                     ; 848 ST_CS_ON
5464  0c26 721b5005      	bres	20485,#5
5465                     ; 849 spi(0x9f);
5467  0c2a a69f          	ld	a,#159
5468  0c2c add6          	call	_spi
5470                     ; 850 mdr0=spi(0xff);
5472  0c2e a6ff          	ld	a,#255
5473  0c30 add2          	call	_spi
5475  0c32 b716          	ld	_mdr0,a
5476                     ; 851 mdr1=spi(0xff);
5478  0c34 a6ff          	ld	a,#255
5479  0c36 adcc          	call	_spi
5481  0c38 b715          	ld	_mdr1,a
5482                     ; 852 mdr2=spi(0xff);
5484  0c3a a6ff          	ld	a,#255
5485  0c3c adc6          	call	_spi
5487  0c3e b714          	ld	_mdr2,a
5488                     ; 853 mdr3=spi(0xff);
5490  0c40 a6ff          	ld	a,#255
5491  0c42 adc0          	call	_spi
5493  0c44 b713          	ld	_mdr3,a
5494                     ; 856 ST_CS_OFF
5496  0c46 721a5005      	bset	20485,#5
5497                     ; 857 return  *((long*)&d0);
5499  0c4a 96            	ldw	x,sp
5500  0c4b 1c0004        	addw	x,#OFST+0
5501  0c4e cd0000        	call	c_ltor
5505  0c51 5b04          	addw	sp,#4
5506  0c53 81            	ret
5541                     ; 861 char ST_status_read(void)
5541                     ; 862 {
5542                     	switch	.text
5543  0c54               _ST_status_read:
5545  0c54 88            	push	a
5546       00000001      OFST:	set	1
5549                     ; 866 ST_CS_ON
5551  0c55 721b5005      	bres	20485,#5
5552                     ; 867 spi(0x05);
5554  0c59 a605          	ld	a,#5
5555  0c5b ada7          	call	_spi
5557                     ; 868 d0=spi(0xff);
5559  0c5d a6ff          	ld	a,#255
5560  0c5f ada3          	call	_spi
5562  0c61 6b01          	ld	(OFST+0,sp),a
5563                     ; 870 ST_CS_OFF
5565  0c63 721a5005      	bset	20485,#5
5566                     ; 871 return d0;
5568  0c67 7b01          	ld	a,(OFST+0,sp)
5571  0c69 5b01          	addw	sp,#1
5572  0c6b 81            	ret
5598                     ; 875 void ST_bulk_erase(void)
5598                     ; 876 {
5599                     	switch	.text
5600  0c6c               _ST_bulk_erase:
5604                     ; 877 ST_CS_ON
5606  0c6c 721b5005      	bres	20485,#5
5607                     ; 878 spi(0xC7);
5609  0c70 a6c7          	ld	a,#199
5610  0c72 ad90          	call	_spi
5612                     ; 881 bERASE_IN_PROGRESS=1;
5614  0c74 72100001      	bset	_bERASE_IN_PROGRESS
5615                     ; 882 uart_out (3,CMND,44,33,0,0,0);
5617  0c78 4b00          	push	#0
5618  0c7a 4b00          	push	#0
5619  0c7c 4b00          	push	#0
5620  0c7e 4b21          	push	#33
5621  0c80 4b2c          	push	#44
5622  0c82 ae0016        	ldw	x,#22
5623  0c85 a603          	ld	a,#3
5624  0c87 95            	ld	xh,a
5625  0c88 cd00ce        	call	_uart_out
5627  0c8b 5b05          	addw	sp,#5
5628                     ; 883 ST_CS_OFF
5630  0c8d 721a5005      	bset	20485,#5
5631                     ; 884 }
5634  0c91 81            	ret
5658                     ; 886 void ST_WREN(void)
5658                     ; 887 {
5659                     	switch	.text
5660  0c92               _ST_WREN:
5664                     ; 889 ST_CS_ON
5666  0c92 721b5005      	bres	20485,#5
5667                     ; 890 spi(0x06);
5669  0c96 a606          	ld	a,#6
5670  0c98 cd0c04        	call	_spi
5672                     ; 892 ST_CS_OFF
5674  0c9b 721a5005      	bset	20485,#5
5675                     ; 893 }  
5678  0c9f 81            	ret
5768                     ; 896 void ST_WRITE(unsigned long memo_addr,unsigned short len, char* adr)
5768                     ; 897 {
5769                     	switch	.text
5770  0ca0               _ST_WRITE:
5772  0ca0 5205          	subw	sp,#5
5773       00000005      OFST:	set	5
5776                     ; 901 adr2=(char)(memo_addr>>16);
5778  0ca2 7b09          	ld	a,(OFST+4,sp)
5779  0ca4 6b03          	ld	(OFST-2,sp),a
5780                     ; 902 adr1=(char)((memo_addr>>8)&0x00ff);
5782  0ca6 7b0a          	ld	a,(OFST+5,sp)
5783  0ca8 a4ff          	and	a,#255
5784  0caa 6b02          	ld	(OFST-3,sp),a
5785                     ; 903 adr0=(char)((memo_addr)&0x00ff);
5787  0cac 7b0b          	ld	a,(OFST+6,sp)
5788  0cae a4ff          	and	a,#255
5789  0cb0 6b01          	ld	(OFST-4,sp),a
5790                     ; 904 ST_CS_ON
5792  0cb2 721b5005      	bres	20485,#5
5793                     ; 906 spi(0x02);
5795  0cb6 a602          	ld	a,#2
5796  0cb8 cd0c04        	call	_spi
5798                     ; 907 spi(adr2);
5800  0cbb 7b03          	ld	a,(OFST-2,sp)
5801  0cbd cd0c04        	call	_spi
5803                     ; 908 spi(adr1);
5805  0cc0 7b02          	ld	a,(OFST-3,sp)
5806  0cc2 cd0c04        	call	_spi
5808                     ; 909 spi(adr0);
5810  0cc5 7b01          	ld	a,(OFST-4,sp)
5811  0cc7 cd0c04        	call	_spi
5813                     ; 911 for(i=0;i<len;i++)
5815  0cca 5f            	clrw	x
5816  0ccb 1f04          	ldw	(OFST-1,sp),x
5818  0ccd 2010          	jra	L7162
5819  0ccf               L3162:
5820                     ; 913 	spi(adr[i]);
5822  0ccf 1e0e          	ldw	x,(OFST+9,sp)
5823  0cd1 72fb04        	addw	x,(OFST-1,sp)
5824  0cd4 f6            	ld	a,(x)
5825  0cd5 cd0c04        	call	_spi
5827                     ; 911 for(i=0;i<len;i++)
5829  0cd8 1e04          	ldw	x,(OFST-1,sp)
5830  0cda 1c0001        	addw	x,#1
5831  0cdd 1f04          	ldw	(OFST-1,sp),x
5832  0cdf               L7162:
5835  0cdf 1e04          	ldw	x,(OFST-1,sp)
5836  0ce1 130c          	cpw	x,(OFST+7,sp)
5837  0ce3 25ea          	jrult	L3162
5838                     ; 916 ST_CS_OFF
5840  0ce5 721a5005      	bset	20485,#5
5841                     ; 917 }
5844  0ce9 5b05          	addw	sp,#5
5845  0ceb 81            	ret
5935                     ; 920 void ST_READ(unsigned long memo_addr,unsigned short len, char* adr)
5935                     ; 921 {
5936                     	switch	.text
5937  0cec               _ST_READ:
5939  0cec 5205          	subw	sp,#5
5940       00000005      OFST:	set	5
5943                     ; 927 adr2=(char)(memo_addr>>16);
5945  0cee 7b09          	ld	a,(OFST+4,sp)
5946  0cf0 6b03          	ld	(OFST-2,sp),a
5947                     ; 928 adr1=(char)((memo_addr>>8)&0x00ff);
5949  0cf2 7b0a          	ld	a,(OFST+5,sp)
5950  0cf4 a4ff          	and	a,#255
5951  0cf6 6b02          	ld	(OFST-3,sp),a
5952                     ; 929 adr0=(char)((memo_addr)&0x00ff);
5954  0cf8 7b0b          	ld	a,(OFST+6,sp)
5955  0cfa a4ff          	and	a,#255
5956  0cfc 6b01          	ld	(OFST-4,sp),a
5957                     ; 930 ST_CS_ON
5959  0cfe 721b5005      	bres	20485,#5
5960                     ; 931 spi(0x03);
5962  0d02 a603          	ld	a,#3
5963  0d04 cd0c04        	call	_spi
5965                     ; 932 spi(adr2);
5967  0d07 7b03          	ld	a,(OFST-2,sp)
5968  0d09 cd0c04        	call	_spi
5970                     ; 933 spi(adr1);
5972  0d0c 7b02          	ld	a,(OFST-3,sp)
5973  0d0e cd0c04        	call	_spi
5975                     ; 934 spi(adr0);
5977  0d11 7b01          	ld	a,(OFST-4,sp)
5978  0d13 cd0c04        	call	_spi
5980                     ; 936 for(i=0;i<len;i++)
5982  0d16 5f            	clrw	x
5983  0d17 1f04          	ldw	(OFST-1,sp),x
5985  0d19 2012          	jra	L5762
5986  0d1b               L1762:
5987                     ; 938 	adr[i]=spi(0xff);
5989  0d1b a6ff          	ld	a,#255
5990  0d1d cd0c04        	call	_spi
5992  0d20 1e0e          	ldw	x,(OFST+9,sp)
5993  0d22 72fb04        	addw	x,(OFST-1,sp)
5994  0d25 f7            	ld	(x),a
5995                     ; 936 for(i=0;i<len;i++)
5997  0d26 1e04          	ldw	x,(OFST-1,sp)
5998  0d28 1c0001        	addw	x,#1
5999  0d2b 1f04          	ldw	(OFST-1,sp),x
6000  0d2d               L5762:
6003  0d2d 1e04          	ldw	x,(OFST-1,sp)
6004  0d2f 130c          	cpw	x,(OFST+7,sp)
6005  0d31 25e8          	jrult	L1762
6006                     ; 941 ST_CS_OFF
6008  0d33 721a5005      	bset	20485,#5
6009                     ; 942 }
6012  0d37 5b05          	addw	sp,#5
6013  0d39 81            	ret
6079                     ; 946 long DF_mf_dev_read(void)
6079                     ; 947 {
6080                     	switch	.text
6081  0d3a               _DF_mf_dev_read:
6083  0d3a 5204          	subw	sp,#4
6084       00000004      OFST:	set	4
6087                     ; 950 d0=0;
6089  0d3c 0f04          	clr	(OFST+0,sp)
6090                     ; 951 d1=0;
6092                     ; 952 d2=0;
6094                     ; 953 d3=0;
6096                     ; 955 CS_ON
6098  0d3e 7217500a      	bres	20490,#3
6099                     ; 956 spi(0x9f);
6101  0d42 a69f          	ld	a,#159
6102  0d44 cd0c04        	call	_spi
6104                     ; 957 mdr0=spi(0xff);
6106  0d47 a6ff          	ld	a,#255
6107  0d49 cd0c04        	call	_spi
6109  0d4c b716          	ld	_mdr0,a
6110                     ; 958 mdr1=spi(0xff);
6112  0d4e a6ff          	ld	a,#255
6113  0d50 cd0c04        	call	_spi
6115  0d53 b715          	ld	_mdr1,a
6116                     ; 959 mdr2=spi(0xff);
6118  0d55 a6ff          	ld	a,#255
6119  0d57 cd0c04        	call	_spi
6121  0d5a b714          	ld	_mdr2,a
6122                     ; 960 mdr3=spi(0xff);  
6124  0d5c a6ff          	ld	a,#255
6125  0d5e cd0c04        	call	_spi
6127  0d61 b713          	ld	_mdr3,a
6128                     ; 962 CS_OFF
6130  0d63 7216500a      	bset	20490,#3
6131                     ; 963 return  *((long*)&d0);
6133  0d67 96            	ldw	x,sp
6134  0d68 1c0004        	addw	x,#OFST+0
6135  0d6b cd0000        	call	c_ltor
6139  0d6e 5b04          	addw	sp,#4
6140  0d70 81            	ret
6164                     ; 967 void DF_memo_to_256(void)
6164                     ; 968 {
6165                     	switch	.text
6166  0d71               _DF_memo_to_256:
6170                     ; 970 CS_ON
6172  0d71 7217500a      	bres	20490,#3
6173                     ; 971 spi(0x3d);
6175  0d75 a63d          	ld	a,#61
6176  0d77 cd0c04        	call	_spi
6178                     ; 972 spi(0x2a); 
6180  0d7a a62a          	ld	a,#42
6181  0d7c cd0c04        	call	_spi
6183                     ; 973 spi(0x80);
6185  0d7f a680          	ld	a,#128
6186  0d81 cd0c04        	call	_spi
6188                     ; 974 spi(0xa6);
6190  0d84 a6a6          	ld	a,#166
6191  0d86 cd0c04        	call	_spi
6193                     ; 976 CS_OFF
6195  0d89 7216500a      	bset	20490,#3
6196                     ; 977 }  
6199  0d8d 81            	ret
6234                     ; 982 char DF_status_read(void)
6234                     ; 983 {
6235                     	switch	.text
6236  0d8e               _DF_status_read:
6238  0d8e 88            	push	a
6239       00000001      OFST:	set	1
6242                     ; 987 CS_ON
6244  0d8f 7217500a      	bres	20490,#3
6245                     ; 988 spi(0xd7);
6247  0d93 a6d7          	ld	a,#215
6248  0d95 cd0c04        	call	_spi
6250                     ; 989 d0=spi(0xff);
6252  0d98 a6ff          	ld	a,#255
6253  0d9a cd0c04        	call	_spi
6255  0d9d 6b01          	ld	(OFST+0,sp),a
6256                     ; 991 CS_OFF
6258  0d9f 7216500a      	bset	20490,#3
6259                     ; 992 return d0;
6261  0da3 7b01          	ld	a,(OFST+0,sp)
6264  0da5 5b01          	addw	sp,#1
6265  0da7 81            	ret
6309                     ; 996 void DF_page_to_buffer(unsigned page_addr)
6309                     ; 997 {
6310                     	switch	.text
6311  0da8               _DF_page_to_buffer:
6313  0da8 89            	pushw	x
6314  0da9 88            	push	a
6315       00000001      OFST:	set	1
6318                     ; 1000 d0=0x53; 
6320                     ; 1004 CS_ON
6322  0daa 7217500a      	bres	20490,#3
6323                     ; 1005 spi(d0);
6325  0dae a653          	ld	a,#83
6326  0db0 cd0c04        	call	_spi
6328                     ; 1006 spi(page_addr/256/**(((char*)&page_addr)+1)*/);
6330  0db3 7b02          	ld	a,(OFST+1,sp)
6331  0db5 cd0c04        	call	_spi
6333                     ; 1007 spi(page_addr%256/**((char*)&page_addr)*/);
6335  0db8 7b03          	ld	a,(OFST+2,sp)
6336  0dba a4ff          	and	a,#255
6337  0dbc cd0c04        	call	_spi
6339                     ; 1008 spi(0xff);
6341  0dbf a6ff          	ld	a,#255
6342  0dc1 cd0c04        	call	_spi
6344                     ; 1010 CS_OFF
6346  0dc4 7216500a      	bset	20490,#3
6347                     ; 1011 }
6350  0dc8 5b03          	addw	sp,#3
6351  0dca 81            	ret
6396                     ; 1014 void DF_buffer_to_page_er(/*char buff,*/unsigned page_addr)
6396                     ; 1015 {
6397                     	switch	.text
6398  0dcb               _DF_buffer_to_page_er:
6400  0dcb 89            	pushw	x
6401  0dcc 88            	push	a
6402       00000001      OFST:	set	1
6405                     ; 1018 d0=0x83; 
6407                     ; 1021 CS_ON
6409  0dcd 7217500a      	bres	20490,#3
6410                     ; 1022 spi(d0);
6412  0dd1 a683          	ld	a,#131
6413  0dd3 cd0c04        	call	_spi
6415                     ; 1023 spi(page_addr/256/**(((char*)&page_addr)+1)*/);
6417  0dd6 7b02          	ld	a,(OFST+1,sp)
6418  0dd8 cd0c04        	call	_spi
6420                     ; 1024 spi(page_addr%256/**((char*)&page_addr)*/);
6422  0ddb 7b03          	ld	a,(OFST+2,sp)
6423  0ddd a4ff          	and	a,#255
6424  0ddf cd0c04        	call	_spi
6426                     ; 1025 spi(0xff);
6428  0de2 a6ff          	ld	a,#255
6429  0de4 cd0c04        	call	_spi
6431                     ; 1027 CS_OFF
6433  0de7 7216500a      	bset	20490,#3
6434                     ; 1028 }
6437  0deb 5b03          	addw	sp,#3
6438  0ded 81            	ret
6510                     ; 1031 void DF_buffer_read(unsigned buff_addr,unsigned len, char* adr)
6510                     ; 1032 {
6511                     	switch	.text
6512  0dee               _DF_buffer_read:
6514  0dee 89            	pushw	x
6515  0def 5203          	subw	sp,#3
6516       00000003      OFST:	set	3
6519                     ; 1036 d0=0x54; 
6521                     ; 1038 CS_ON
6523  0df1 7217500a      	bres	20490,#3
6524                     ; 1039 spi(d0);
6526  0df5 a654          	ld	a,#84
6527  0df7 cd0c04        	call	_spi
6529                     ; 1040 spi(0xff);
6531  0dfa a6ff          	ld	a,#255
6532  0dfc cd0c04        	call	_spi
6534                     ; 1041 spi(buff_addr/256/**(((char*)&buff_addr)+1)*/);
6536  0dff 7b04          	ld	a,(OFST+1,sp)
6537  0e01 cd0c04        	call	_spi
6539                     ; 1042 spi(buff_addr%256/**((char*)&buff_addr)*/);
6541  0e04 7b05          	ld	a,(OFST+2,sp)
6542  0e06 a4ff          	and	a,#255
6543  0e08 cd0c04        	call	_spi
6545                     ; 1043 spi(0xff);
6547  0e0b a6ff          	ld	a,#255
6548  0e0d cd0c04        	call	_spi
6550                     ; 1044 for(i=0;i<len;i++)
6552  0e10 5f            	clrw	x
6553  0e11 1f02          	ldw	(OFST-1,sp),x
6555  0e13 2012          	jra	L7603
6556  0e15               L3603:
6557                     ; 1046 	adr[i]=spi(0xff);
6559  0e15 a6ff          	ld	a,#255
6560  0e17 cd0c04        	call	_spi
6562  0e1a 1e0a          	ldw	x,(OFST+7,sp)
6563  0e1c 72fb02        	addw	x,(OFST-1,sp)
6564  0e1f f7            	ld	(x),a
6565                     ; 1044 for(i=0;i<len;i++)
6567  0e20 1e02          	ldw	x,(OFST-1,sp)
6568  0e22 1c0001        	addw	x,#1
6569  0e25 1f02          	ldw	(OFST-1,sp),x
6570  0e27               L7603:
6573  0e27 1e02          	ldw	x,(OFST-1,sp)
6574  0e29 1308          	cpw	x,(OFST+5,sp)
6575  0e2b 25e8          	jrult	L3603
6576                     ; 1049 CS_OFF
6578  0e2d 7216500a      	bset	20490,#3
6579                     ; 1050 }
6582  0e31 5b05          	addw	sp,#5
6583  0e33 81            	ret
6655                     ; 1053 void DF_buffer_write(/*char buff,*/unsigned buff_addr,unsigned len, char* adr)
6655                     ; 1054 {
6656                     	switch	.text
6657  0e34               _DF_buffer_write:
6659  0e34 89            	pushw	x
6660  0e35 5203          	subw	sp,#3
6661       00000003      OFST:	set	3
6664                     ; 1058 d0=0x84; 
6666                     ; 1060 CS_ON
6668  0e37 7217500a      	bres	20490,#3
6669                     ; 1061 spi(d0);
6671  0e3b a684          	ld	a,#132
6672  0e3d cd0c04        	call	_spi
6674                     ; 1062 spi(0xff);
6676  0e40 a6ff          	ld	a,#255
6677  0e42 cd0c04        	call	_spi
6679                     ; 1063 spi(buff_addr/256/**(((char*)&buff_addr)+1)*/);
6681  0e45 7b04          	ld	a,(OFST+1,sp)
6682  0e47 cd0c04        	call	_spi
6684                     ; 1064 spi(buff_addr%256/**((char*)&buff_addr)*/);
6686  0e4a 7b05          	ld	a,(OFST+2,sp)
6687  0e4c a4ff          	and	a,#255
6688  0e4e cd0c04        	call	_spi
6690                     ; 1066 for(i=0;i<len;i++)
6692  0e51 5f            	clrw	x
6693  0e52 1f02          	ldw	(OFST-1,sp),x
6695  0e54 2010          	jra	L5313
6696  0e56               L1313:
6697                     ; 1068 	spi(adr[i]);
6699  0e56 1e0a          	ldw	x,(OFST+7,sp)
6700  0e58 72fb02        	addw	x,(OFST-1,sp)
6701  0e5b f6            	ld	a,(x)
6702  0e5c cd0c04        	call	_spi
6704                     ; 1066 for(i=0;i<len;i++)
6706  0e5f 1e02          	ldw	x,(OFST-1,sp)
6707  0e61 1c0001        	addw	x,#1
6708  0e64 1f02          	ldw	(OFST-1,sp),x
6709  0e66               L5313:
6712  0e66 1e02          	ldw	x,(OFST-1,sp)
6713  0e68 1308          	cpw	x,(OFST+5,sp)
6714  0e6a 25ea          	jrult	L1313
6715                     ; 1071 CS_OFF
6717  0e6c 7216500a      	bset	20490,#3
6718                     ; 1072 }
6721  0e70 5b05          	addw	sp,#5
6722  0e72 81            	ret
6745                     ; 1094 void gpio_init(void){
6746                     	switch	.text
6747  0e73               _gpio_init:
6751                     ; 1104 	GPIOD->DDR|=(1<<2);
6753  0e73 72145011      	bset	20497,#2
6754                     ; 1105 	GPIOD->CR1|=(1<<2);
6756  0e77 72145012      	bset	20498,#2
6757                     ; 1106 	GPIOD->CR2|=(1<<2);
6759  0e7b 72145013      	bset	20499,#2
6760                     ; 1107 	GPIOD->ODR&=~(1<<2);
6762  0e7f 7215500f      	bres	20495,#2
6763                     ; 1109 	GPIOD->DDR|=(1<<4);
6765  0e83 72185011      	bset	20497,#4
6766                     ; 1110 	GPIOD->CR1|=(1<<4);
6768  0e87 72185012      	bset	20498,#4
6769                     ; 1111 	GPIOD->CR2&=~(1<<4);
6771  0e8b 72195013      	bres	20499,#4
6772                     ; 1113 	GPIOC->DDR&=~(1<<4);
6774  0e8f 7219500c      	bres	20492,#4
6775                     ; 1114 	GPIOC->CR1&=~(1<<4);
6777  0e93 7219500d      	bres	20493,#4
6778                     ; 1115 	GPIOC->CR2&=~(1<<4);
6780  0e97 7219500e      	bres	20494,#4
6781                     ; 1119 }
6784  0e9b 81            	ret
6836                     ; 1122 void uart_in(void)
6836                     ; 1123 {
6837                     	switch	.text
6838  0e9c               _uart_in:
6840  0e9c 89            	pushw	x
6841       00000002      OFST:	set	2
6844                     ; 1127 if(rx_buffer_overflow)
6846                     	btst	_rx_buffer_overflow
6847  0ea2 240d          	jruge	L3713
6848                     ; 1129 	rx_wr_index=0;
6850  0ea4 5f            	clrw	x
6851  0ea5 bf1a          	ldw	_rx_wr_index,x
6852                     ; 1130 	rx_rd_index=0;
6854  0ea7 5f            	clrw	x
6855  0ea8 bf18          	ldw	_rx_rd_index,x
6856                     ; 1131 	rx_counter=0;
6858  0eaa 5f            	clrw	x
6859  0eab bf1c          	ldw	_rx_counter,x
6860                     ; 1132 	rx_buffer_overflow=0;
6862  0ead 72110003      	bres	_rx_buffer_overflow
6863  0eb1               L3713:
6864                     ; 1135 if(rx_counter&&(rx_buffer[index_offset(rx_wr_index,-1)])==END)
6866  0eb1 be1c          	ldw	x,_rx_counter
6867  0eb3 2775          	jreq	L5713
6869  0eb5 aeffff        	ldw	x,#65535
6870  0eb8 89            	pushw	x
6871  0eb9 be1a          	ldw	x,_rx_wr_index
6872  0ebb ad6f          	call	_index_offset
6874  0ebd 5b02          	addw	sp,#2
6875  0ebf e654          	ld	a,(_rx_buffer,x)
6876  0ec1 a10a          	cp	a,#10
6877  0ec3 2665          	jrne	L5713
6878                     ; 1140 	temp=rx_buffer[index_offset(rx_wr_index,-3)];
6880  0ec5 aefffd        	ldw	x,#65533
6881  0ec8 89            	pushw	x
6882  0ec9 be1a          	ldw	x,_rx_wr_index
6883  0ecb ad5f          	call	_index_offset
6885  0ecd 5b02          	addw	sp,#2
6886  0ecf e654          	ld	a,(_rx_buffer,x)
6887  0ed1 6b01          	ld	(OFST-1,sp),a
6888                     ; 1141     	if(temp<100) 
6890  0ed3 7b01          	ld	a,(OFST-1,sp)
6891  0ed5 a164          	cp	a,#100
6892  0ed7 2451          	jruge	L5713
6893                     ; 1144     		if(control_check(index_offset(rx_wr_index,-1)))
6895  0ed9 aeffff        	ldw	x,#65535
6896  0edc 89            	pushw	x
6897  0edd be1a          	ldw	x,_rx_wr_index
6898  0edf ad4b          	call	_index_offset
6900  0ee1 5b02          	addw	sp,#2
6901  0ee3 9f            	ld	a,xl
6902  0ee4 ad6e          	call	_control_check
6904  0ee6 4d            	tnz	a
6905  0ee7 2741          	jreq	L5713
6906                     ; 1147     			rx_rd_index=index_offset(rx_wr_index,-3-temp);
6908  0ee9 a6ff          	ld	a,#255
6909  0eeb 97            	ld	xl,a
6910  0eec a6fd          	ld	a,#253
6911  0eee 1001          	sub	a,(OFST-1,sp)
6912  0ef0 2401          	jrnc	L651
6913  0ef2 5a            	decw	x
6914  0ef3               L651:
6915  0ef3 02            	rlwa	x,a
6916  0ef4 89            	pushw	x
6917  0ef5 01            	rrwa	x,a
6918  0ef6 be1a          	ldw	x,_rx_wr_index
6919  0ef8 ad32          	call	_index_offset
6921  0efa 5b02          	addw	sp,#2
6922  0efc bf18          	ldw	_rx_rd_index,x
6923                     ; 1148     			for(i=0;i<temp;i++)
6925  0efe 0f02          	clr	(OFST+0,sp)
6927  0f00 2018          	jra	L7023
6928  0f02               L3023:
6929                     ; 1150 				UIB[i]=rx_buffer[index_offset(rx_rd_index,i)];
6931  0f02 7b02          	ld	a,(OFST+0,sp)
6932  0f04 5f            	clrw	x
6933  0f05 97            	ld	xl,a
6934  0f06 89            	pushw	x
6935  0f07 7b04          	ld	a,(OFST+2,sp)
6936  0f09 5f            	clrw	x
6937  0f0a 97            	ld	xl,a
6938  0f0b 89            	pushw	x
6939  0f0c be18          	ldw	x,_rx_rd_index
6940  0f0e ad1c          	call	_index_offset
6942  0f10 5b02          	addw	sp,#2
6943  0f12 e654          	ld	a,(_rx_buffer,x)
6944  0f14 85            	popw	x
6945  0f15 d70000        	ld	(_UIB,x),a
6946                     ; 1148     			for(i=0;i<temp;i++)
6948  0f18 0c02          	inc	(OFST+0,sp)
6949  0f1a               L7023:
6952  0f1a 7b02          	ld	a,(OFST+0,sp)
6953  0f1c 1101          	cp	a,(OFST-1,sp)
6954  0f1e 25e2          	jrult	L3023
6955                     ; 1152 			rx_rd_index=rx_wr_index;
6957  0f20 be1a          	ldw	x,_rx_wr_index
6958  0f22 bf18          	ldw	_rx_rd_index,x
6959                     ; 1153 			rx_counter=0;
6961  0f24 5f            	clrw	x
6962  0f25 bf1c          	ldw	_rx_counter,x
6963                     ; 1163 			uart_in_an();
6965  0f27 cd0238        	call	_uart_in_an
6967  0f2a               L5713:
6968                     ; 1172 }
6971  0f2a 85            	popw	x
6972  0f2b 81            	ret
7015                     ; 1175 signed short index_offset (signed short index,signed short offset)
7015                     ; 1176 {
7016                     	switch	.text
7017  0f2c               _index_offset:
7019  0f2c 89            	pushw	x
7020       00000000      OFST:	set	0
7023                     ; 1177 index=index+offset;
7025  0f2d 1e01          	ldw	x,(OFST+1,sp)
7026  0f2f 72fb05        	addw	x,(OFST+5,sp)
7027  0f32 1f01          	ldw	(OFST+1,sp),x
7028                     ; 1178 if(index>=RX_BUFFER_SIZE) index-=RX_BUFFER_SIZE; 
7030  0f34 9c            	rvf
7031  0f35 1e01          	ldw	x,(OFST+1,sp)
7032  0f37 a30064        	cpw	x,#100
7033  0f3a 2f07          	jrslt	L5323
7036  0f3c 1e01          	ldw	x,(OFST+1,sp)
7037  0f3e 1d0064        	subw	x,#100
7038  0f41 1f01          	ldw	(OFST+1,sp),x
7039  0f43               L5323:
7040                     ; 1179 if(index<0) index+=RX_BUFFER_SIZE;
7042  0f43 9c            	rvf
7043  0f44 1e01          	ldw	x,(OFST+1,sp)
7044  0f46 2e07          	jrsge	L7323
7047  0f48 1e01          	ldw	x,(OFST+1,sp)
7048  0f4a 1c0064        	addw	x,#100
7049  0f4d 1f01          	ldw	(OFST+1,sp),x
7050  0f4f               L7323:
7051                     ; 1180 return index;
7053  0f4f 1e01          	ldw	x,(OFST+1,sp)
7056  0f51 5b02          	addw	sp,#2
7057  0f53 81            	ret
7120                     ; 1184 char control_check(char index)
7120                     ; 1185 {
7121                     	switch	.text
7122  0f54               _control_check:
7124  0f54 88            	push	a
7125  0f55 5203          	subw	sp,#3
7126       00000003      OFST:	set	3
7129                     ; 1186 char i=0,ii=0,iii;
7133                     ; 1188 if(rx_buffer[index]!=END) return 0;
7135  0f57 5f            	clrw	x
7136  0f58 97            	ld	xl,a
7137  0f59 e654          	ld	a,(_rx_buffer,x)
7138  0f5b a10a          	cp	a,#10
7139  0f5d 2703          	jreq	L3723
7142  0f5f 4f            	clr	a
7144  0f60 2051          	jra	L071
7145  0f62               L3723:
7146                     ; 1190 ii=rx_buffer[index_offset(index,-2)];
7148  0f62 aefffe        	ldw	x,#65534
7149  0f65 89            	pushw	x
7150  0f66 7b06          	ld	a,(OFST+3,sp)
7151  0f68 5f            	clrw	x
7152  0f69 97            	ld	xl,a
7153  0f6a adc0          	call	_index_offset
7155  0f6c 5b02          	addw	sp,#2
7156  0f6e e654          	ld	a,(_rx_buffer,x)
7157  0f70 6b02          	ld	(OFST-1,sp),a
7158                     ; 1191 iii=0;
7160  0f72 0f01          	clr	(OFST-2,sp)
7161                     ; 1192 for(i=0;i<=ii;i++)
7163  0f74 0f03          	clr	(OFST+0,sp)
7165  0f76 2022          	jra	L1033
7166  0f78               L5723:
7167                     ; 1194 	iii^=rx_buffer[index_offset(index,-2-ii+i)];
7169  0f78 a6ff          	ld	a,#255
7170  0f7a 97            	ld	xl,a
7171  0f7b a6fe          	ld	a,#254
7172  0f7d 1002          	sub	a,(OFST-1,sp)
7173  0f7f 2401          	jrnc	L461
7174  0f81 5a            	decw	x
7175  0f82               L461:
7176  0f82 1b03          	add	a,(OFST+0,sp)
7177  0f84 2401          	jrnc	L661
7178  0f86 5c            	incw	x
7179  0f87               L661:
7180  0f87 02            	rlwa	x,a
7181  0f88 89            	pushw	x
7182  0f89 01            	rrwa	x,a
7183  0f8a 7b06          	ld	a,(OFST+3,sp)
7184  0f8c 5f            	clrw	x
7185  0f8d 97            	ld	xl,a
7186  0f8e ad9c          	call	_index_offset
7188  0f90 5b02          	addw	sp,#2
7189  0f92 7b01          	ld	a,(OFST-2,sp)
7190  0f94 e854          	xor	a,	(_rx_buffer,x)
7191  0f96 6b01          	ld	(OFST-2,sp),a
7192                     ; 1192 for(i=0;i<=ii;i++)
7194  0f98 0c03          	inc	(OFST+0,sp)
7195  0f9a               L1033:
7198  0f9a 7b03          	ld	a,(OFST+0,sp)
7199  0f9c 1102          	cp	a,(OFST-1,sp)
7200  0f9e 23d8          	jrule	L5723
7201                     ; 1196 if (iii!=rx_buffer[index_offset(index,-1)]) return 0;	
7203  0fa0 aeffff        	ldw	x,#65535
7204  0fa3 89            	pushw	x
7205  0fa4 7b06          	ld	a,(OFST+3,sp)
7206  0fa6 5f            	clrw	x
7207  0fa7 97            	ld	xl,a
7208  0fa8 ad82          	call	_index_offset
7210  0faa 5b02          	addw	sp,#2
7211  0fac e654          	ld	a,(_rx_buffer,x)
7212  0fae 1101          	cp	a,(OFST-2,sp)
7213  0fb0 2704          	jreq	L5033
7216  0fb2 4f            	clr	a
7218  0fb3               L071:
7220  0fb3 5b04          	addw	sp,#4
7221  0fb5 81            	ret
7222  0fb6               L5033:
7223                     ; 1198 return 1;
7225  0fb6 a601          	ld	a,#1
7227  0fb8 20f9          	jra	L071
7269                     ; 1207 @far @interrupt void TIM4_UPD_Interrupt (void) 
7269                     ; 1208 {
7271                     	switch	.text
7272  0fba               f_TIM4_UPD_Interrupt:
7276                     ; 1209 if(play) 
7278                     	btst	_play
7279  0fbf 2445          	jruge	L7133
7280                     ; 1211 	TIM2->CCR3H= 0x00;	
7282  0fc1 725f5315      	clr	21269
7283                     ; 1212 	TIM2->CCR3L= sample;
7285  0fc5 5500175316    	mov	21270,_sample
7286                     ; 1213 	sample_cnt++;
7288  0fca be21          	ldw	x,_sample_cnt
7289  0fcc 1c0001        	addw	x,#1
7290  0fcf bf21          	ldw	_sample_cnt,x
7291                     ; 1214 	if(sample_cnt>=256) 
7293  0fd1 9c            	rvf
7294  0fd2 be21          	ldw	x,_sample_cnt
7295  0fd4 a30100        	cpw	x,#256
7296  0fd7 2f03          	jrslt	L1233
7297                     ; 1216 		sample_cnt=0;
7299  0fd9 5f            	clrw	x
7300  0fda bf21          	ldw	_sample_cnt,x
7301  0fdc               L1233:
7302                     ; 1219 	sample=buff[sample_cnt];
7304  0fdc be21          	ldw	x,_sample_cnt
7305  0fde d60050        	ld	a,(_buff,x)
7306  0fe1 b717          	ld	_sample,a
7307                     ; 1221 	if(sample_cnt==132)	
7309  0fe3 be21          	ldw	x,_sample_cnt
7310  0fe5 a30084        	cpw	x,#132
7311  0fe8 2604          	jrne	L3233
7312                     ; 1223 		bBUFF_LOAD=1;
7314  0fea 7210000d      	bset	_bBUFF_LOAD
7315  0fee               L3233:
7316                     ; 1226 	if(sample_cnt==5) 
7318  0fee be21          	ldw	x,_sample_cnt
7319  0ff0 a30005        	cpw	x,#5
7320  0ff3 2604          	jrne	L5233
7321                     ; 1228 		bBUFF_READ_H=1;
7323  0ff5 7210000c      	bset	_bBUFF_READ_H
7324  0ff9               L5233:
7325                     ; 1231 	if(sample_cnt==150) 
7327  0ff9 be21          	ldw	x,_sample_cnt
7328  0ffb a30096        	cpw	x,#150
7329  0ffe 2615          	jrne	L1333
7330                     ; 1233 		bBUFF_READ_L=1;
7332  1000 7210000b      	bset	_bBUFF_READ_L
7333  1004 200f          	jra	L1333
7334  1006               L7133:
7335                     ; 1237 else if(!bSTART) 
7337                     	btst	_bSTART
7338  100b 2508          	jrult	L1333
7339                     ; 1239 	TIM2->CCR3H= 0x00;	
7341  100d 725f5315      	clr	21269
7342                     ; 1240 	TIM2->CCR3L= 0x7f;//pwm_fade_in;
7344  1011 357f5316      	mov	21270,#127
7345  1015               L1333:
7346                     ; 1274 if(but_block_cnt)but_on_drv_cnt=0;
7348  1015 be00          	ldw	x,_but_block_cnt
7349  1017 2702          	jreq	L5333
7352  1019 3fb9          	clr	_but_on_drv_cnt
7353  101b               L5333:
7354                     ; 1275 if((((GPIOC->IDR)&(1<<4))) && (but_on_drv_cnt<100)) 
7356  101b c6500b        	ld	a,20491
7357  101e a510          	bcp	a,#16
7358  1020 271f          	jreq	L7333
7360  1022 b6b9          	ld	a,_but_on_drv_cnt
7361  1024 a164          	cp	a,#100
7362  1026 2419          	jruge	L7333
7363                     ; 1277 	but_on_drv_cnt++;
7365  1028 3cb9          	inc	_but_on_drv_cnt
7366                     ; 1278 	if((but_on_drv_cnt>2)&&(bRELEASE))
7368  102a b6b9          	ld	a,_but_on_drv_cnt
7369  102c a103          	cp	a,#3
7370  102e 2517          	jrult	L3433
7372                     	btst	_bRELEASE
7373  1035 2410          	jruge	L3433
7374                     ; 1280 		bRELEASE=0;
7376  1037 72110002      	bres	_bRELEASE
7377                     ; 1281 		bSTART=1;
7379  103b 7210000e      	bset	_bSTART
7380  103f 2006          	jra	L3433
7381  1041               L7333:
7382                     ; 1286 	but_on_drv_cnt=0;
7384  1041 3fb9          	clr	_but_on_drv_cnt
7385                     ; 1287 	bRELEASE=1;
7387  1043 72100002      	bset	_bRELEASE
7388  1047               L3433:
7389                     ; 1290 if(++t0_cnt0>=125)
7391  1047 3c00          	inc	_t0_cnt0
7392  1049 b600          	ld	a,_t0_cnt0
7393  104b a17d          	cp	a,#125
7394  104d 2530          	jrult	L5433
7395                     ; 1292   t0_cnt0=0;
7397  104f 3f00          	clr	_t0_cnt0
7398                     ; 1293   b100Hz=1;
7400  1051 7210000a      	bset	_b100Hz
7401                     ; 1295 	if(++t0_cnt1>=10)
7403  1055 3c01          	inc	_t0_cnt1
7404  1057 b601          	ld	a,_t0_cnt1
7405  1059 a10a          	cp	a,#10
7406  105b 2506          	jrult	L7433
7407                     ; 1297 		t0_cnt1=0;
7409  105d 3f01          	clr	_t0_cnt1
7410                     ; 1298 		b10Hz=1;
7412  105f 72100009      	bset	_b10Hz
7413  1063               L7433:
7414                     ; 1301 	if(++t0_cnt2>=20)
7416  1063 3c02          	inc	_t0_cnt2
7417  1065 b602          	ld	a,_t0_cnt2
7418  1067 a114          	cp	a,#20
7419  1069 2506          	jrult	L1533
7420                     ; 1303 		t0_cnt2=0;
7422  106b 3f02          	clr	_t0_cnt2
7423                     ; 1304 		b5Hz=1;
7425  106d 72100008      	bset	_b5Hz
7426  1071               L1533:
7427                     ; 1307 	if(++t0_cnt3>=100)
7429  1071 3c03          	inc	_t0_cnt3
7430  1073 b603          	ld	a,_t0_cnt3
7431  1075 a164          	cp	a,#100
7432  1077 2506          	jrult	L5433
7433                     ; 1309 		t0_cnt3=0;
7435  1079 3f03          	clr	_t0_cnt3
7436                     ; 1310 		b1Hz=1;
7438  107b 72100007      	bset	_b1Hz
7439  107f               L5433:
7440                     ; 1314 TIM4->SR1&=~TIM4_SR1_UIF;			// disable break interrupt
7442  107f 72115344      	bres	21316,#0
7443                     ; 1315 return;
7446  1083 80            	iret
7472                     ; 1319 @far @interrupt void UARTTxInterrupt (void) {
7473                     	switch	.text
7474  1084               f_UARTTxInterrupt:
7478                     ; 1321 	if (tx_counter){
7480  1084 3d20          	tnz	_tx_counter
7481  1086 271a          	jreq	L5633
7482                     ; 1322 		--tx_counter;
7484  1088 3a20          	dec	_tx_counter
7485                     ; 1323 		UART1->DR=tx_buffer[tx_rd_index];
7487  108a 5f            	clrw	x
7488  108b b61e          	ld	a,_tx_rd_index
7489  108d 2a01          	jrpl	L671
7490  108f 53            	cplw	x
7491  1090               L671:
7492  1090 97            	ld	xl,a
7493  1091 e604          	ld	a,(_tx_buffer,x)
7494  1093 c75231        	ld	21041,a
7495                     ; 1324 		if (++tx_rd_index == TX_BUFFER_SIZE) tx_rd_index=0;
7497  1096 3c1e          	inc	_tx_rd_index
7498  1098 b61e          	ld	a,_tx_rd_index
7499  109a a150          	cp	a,#80
7500  109c 260c          	jrne	L1733
7503  109e 3f1e          	clr	_tx_rd_index
7504  10a0 2008          	jra	L1733
7505  10a2               L5633:
7506                     ; 1327 		bOUT_FREE=1;
7508  10a2 72100005      	bset	_bOUT_FREE
7509                     ; 1328 		UART1->CR2&= ~UART1_CR2_TIEN;
7511  10a6 721f5235      	bres	21045,#7
7512  10aa               L1733:
7513                     ; 1330 }
7516  10aa 80            	iret
7545                     ; 1333 @far @interrupt void UARTRxInterrupt (void) {
7546                     	switch	.text
7547  10ab               f_UARTRxInterrupt:
7551                     ; 1338 	rx_status=UART1->SR;
7553  10ab 5552300006    	mov	_rx_status,21040
7554                     ; 1339 	rx_data=UART1->DR;
7556  10b0 5552310005    	mov	_rx_data,21041
7557                     ; 1341 	if (rx_status & (UART1_SR_RXNE)){
7559  10b5 b606          	ld	a,_rx_status
7560  10b7 a520          	bcp	a,#32
7561  10b9 272c          	jreq	L3043
7562                     ; 1342 		rx_buffer[rx_wr_index]=rx_data;
7564  10bb be1a          	ldw	x,_rx_wr_index
7565  10bd b605          	ld	a,_rx_data
7566  10bf e754          	ld	(_rx_buffer,x),a
7567                     ; 1343 		bRXIN=1;
7569  10c1 72100004      	bset	_bRXIN
7570                     ; 1344 		if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
7572  10c5 be1a          	ldw	x,_rx_wr_index
7573  10c7 1c0001        	addw	x,#1
7574  10ca bf1a          	ldw	_rx_wr_index,x
7575  10cc a30064        	cpw	x,#100
7576  10cf 2603          	jrne	L5043
7579  10d1 5f            	clrw	x
7580  10d2 bf1a          	ldw	_rx_wr_index,x
7581  10d4               L5043:
7582                     ; 1345 		if (++rx_counter == RX_BUFFER_SIZE){
7584  10d4 be1c          	ldw	x,_rx_counter
7585  10d6 1c0001        	addw	x,#1
7586  10d9 bf1c          	ldw	_rx_counter,x
7587  10db a30064        	cpw	x,#100
7588  10de 2607          	jrne	L3043
7589                     ; 1346 			rx_counter=0;
7591  10e0 5f            	clrw	x
7592  10e1 bf1c          	ldw	_rx_counter,x
7593                     ; 1347 			rx_buffer_overflow=1;
7595  10e3 72100003      	bset	_rx_buffer_overflow
7596  10e7               L3043:
7597                     ; 1350 }
7600  10e7 80            	iret
7674                     ; 1356 main()
7674                     ; 1357 {
7676                     	switch	.text
7677  10e8               _main:
7679  10e8 88            	push	a
7680       00000001      OFST:	set	1
7683                     ; 1358 CLK->CKDIVR=0;
7685  10e9 725f50c6      	clr	20678
7686                     ; 1360 rele_cnt_index=0;
7688  10ed 3fbb          	clr	_rele_cnt_index
7689                     ; 1362 GPIOD->DDR&=~(1<<6);
7691  10ef 721d5011      	bres	20497,#6
7692                     ; 1363 GPIOD->CR1|=(1<<6);
7694  10f3 721c5012      	bset	20498,#6
7695                     ; 1364 GPIOD->CR2|=(1<<6);
7697  10f7 721c5013      	bset	20499,#6
7698                     ; 1366 GPIOD->DDR|=(1<<5);
7700  10fb 721a5011      	bset	20497,#5
7701                     ; 1367 GPIOD->CR1|=(1<<5);
7703  10ff 721a5012      	bset	20498,#5
7704                     ; 1368 GPIOD->CR2|=(1<<5);	
7706  1103 721a5013      	bset	20499,#5
7707                     ; 1369 GPIOD->ODR|=(1<<5);
7709  1107 721a500f      	bset	20495,#5
7710                     ; 1371 delay_ms(10);
7712  110b ae000a        	ldw	x,#10
7713  110e cd005c        	call	_delay_ms
7715                     ; 1373 if(!(GPIOD->IDR&=(1<<6))) 
7717  1111 c65010        	ld	a,20496
7718  1114 a440          	and	a,#64
7719  1116 c75010        	ld	20496,a
7720  1119 2606          	jrne	L7243
7721                     ; 1375 	rele_cnt_index=1;
7723  111b 350100bb      	mov	_rele_cnt_index,#1
7725  111f 2018          	jra	L1343
7726  1121               L7243:
7727                     ; 1379 	GPIOD->ODR&=~(1<<5);
7729  1121 721b500f      	bres	20495,#5
7730                     ; 1380 	delay_ms(10);
7732  1125 ae000a        	ldw	x,#10
7733  1128 cd005c        	call	_delay_ms
7735                     ; 1381 	if(!(GPIOD->IDR&=(1<<6))) 
7737  112b c65010        	ld	a,20496
7738  112e a440          	and	a,#64
7739  1130 c75010        	ld	20496,a
7740  1133 2604          	jrne	L1343
7741                     ; 1383 		rele_cnt_index=2;
7743  1135 350200bb      	mov	_rele_cnt_index,#2
7744  1139               L1343:
7745                     ; 1387 gpio_init();
7747  1139 cd0e73        	call	_gpio_init
7749                     ; 1394 spi_init();
7751  113c cd0b97        	call	_spi_init
7753                     ; 1396 t4_init();
7755  113f cd0039        	call	_t4_init
7757                     ; 1398 FLASH_DUKR=0xae;
7759  1142 35ae5064      	mov	_FLASH_DUKR,#174
7760                     ; 1399 FLASH_DUKR=0x56;
7762  1146 35565064      	mov	_FLASH_DUKR,#86
7763                     ; 1404 dumm[1]++;
7765  114a 725c017d      	inc	_dumm+1
7766                     ; 1406 uart_init();
7768  114e cd009e        	call	_uart_init
7770                     ; 1408 ST_RDID_read();
7772  1151 cd0c22        	call	_ST_RDID_read
7774                     ; 1409 if(mdr0==0x20) memory_manufacturer='S';	
7776  1154 b616          	ld	a,_mdr0
7777  1156 a120          	cp	a,#32
7778  1158 2606          	jrne	L5343
7781  115a 355300bc      	mov	_memory_manufacturer,#83
7783  115e 200d          	jra	L7343
7784  1160               L5343:
7785                     ; 1412 	DF_mf_dev_read();
7787  1160 cd0d3a        	call	_DF_mf_dev_read
7789                     ; 1413 	if(mdr0==0x1F) memory_manufacturer='A';
7791  1163 b616          	ld	a,_mdr0
7792  1165 a11f          	cp	a,#31
7793  1167 2604          	jrne	L7343
7796  1169 354100bc      	mov	_memory_manufacturer,#65
7797  116d               L7343:
7798                     ; 1416 t2_init();
7800  116d cd0000        	call	_t2_init
7802                     ; 1418 ST_WREN();
7804  1170 cd0c92        	call	_ST_WREN
7806                     ; 1420 enableInterrupts();	
7809  1173 9a            rim
7811  1174               L3443:
7812                     ; 1425 	if(bBUFF_LOAD)
7814                     	btst	_bBUFF_LOAD
7815  1179 2425          	jruge	L7443
7816                     ; 1427 		bBUFF_LOAD=0;
7818  117b 7211000d      	bres	_bBUFF_LOAD
7819                     ; 1429 		if(current_page<last_page)
7821  117f be0f          	ldw	x,_current_page
7822  1181 b30d          	cpw	x,_last_page
7823  1183 2409          	jruge	L1543
7824                     ; 1431 			current_page++;
7826  1185 be0f          	ldw	x,_current_page
7827  1187 1c0001        	addw	x,#1
7828  118a bf0f          	ldw	_current_page,x
7830  118c 2007          	jra	L3543
7831  118e               L1543:
7832                     ; 1435 			current_page=0;
7834  118e 5f            	clrw	x
7835  118f bf0f          	ldw	_current_page,x
7836                     ; 1436 			play=0;
7838  1191 72110006      	bres	_play
7839  1195               L3543:
7840                     ; 1438 		if(memory_manufacturer=='A')
7842  1195 b6bc          	ld	a,_memory_manufacturer
7843  1197 a141          	cp	a,#65
7844  1199 2605          	jrne	L7443
7845                     ; 1440 			DF_page_to_buffer(/*///current_buffer_H*//*1,*/current_page);
7847  119b be0f          	ldw	x,_current_page
7848  119d cd0da8        	call	_DF_page_to_buffer
7850  11a0               L7443:
7851                     ; 1444 	if(bBUFF_READ_L)
7853                     	btst	_bBUFF_READ_L
7854  11a5 243a          	jruge	L7543
7855                     ; 1446 		bBUFF_READ_L=0;
7857  11a7 7211000b      	bres	_bBUFF_READ_L
7858                     ; 1447 		if(memory_manufacturer=='A')
7860  11ab b6bc          	ld	a,_memory_manufacturer
7861  11ad a141          	cp	a,#65
7862  11af 260e          	jrne	L1643
7863                     ; 1449 			DF_buffer_read(/*///current_buffer_L*//*1,*/0,128,buff);
7865  11b1 ae0050        	ldw	x,#_buff
7866  11b4 89            	pushw	x
7867  11b5 ae0080        	ldw	x,#128
7868  11b8 89            	pushw	x
7869  11b9 5f            	clrw	x
7870  11ba cd0dee        	call	_DF_buffer_read
7872  11bd 5b04          	addw	sp,#4
7873  11bf               L1643:
7874                     ; 1451 		if(memory_manufacturer=='S')
7876  11bf b6bc          	ld	a,_memory_manufacturer
7877  11c1 a153          	cp	a,#83
7878  11c3 261c          	jrne	L7543
7879                     ; 1453 			ST_READ((unsigned long)((unsigned long)(current_page*256UL)),128,buff);
7881  11c5 ae0050        	ldw	x,#_buff
7882  11c8 89            	pushw	x
7883  11c9 ae0080        	ldw	x,#128
7884  11cc 89            	pushw	x
7885  11cd be0f          	ldw	x,_current_page
7886  11cf 90ae0100      	ldw	y,#256
7887  11d3 cd0000        	call	c_umul
7889  11d6 be02          	ldw	x,c_lreg+2
7890  11d8 89            	pushw	x
7891  11d9 be00          	ldw	x,c_lreg
7892  11db 89            	pushw	x
7893  11dc cd0cec        	call	_ST_READ
7895  11df 5b08          	addw	sp,#8
7896  11e1               L7543:
7897                     ; 1457 	if(bBUFF_READ_H) 
7899                     	btst	_bBUFF_READ_H
7900  11e6 2441          	jruge	L5643
7901                     ; 1459 		bBUFF_READ_H=0;
7903  11e8 7211000c      	bres	_bBUFF_READ_H
7904                     ; 1460 		if(memory_manufacturer=='A') 
7906  11ec b6bc          	ld	a,_memory_manufacturer
7907  11ee a141          	cp	a,#65
7908  11f0 2610          	jrne	L7643
7909                     ; 1462 			DF_buffer_read(/*///current_buffer_L*//*1,*/128,128,&buff[128]);
7911  11f2 ae00d0        	ldw	x,#_buff+128
7912  11f5 89            	pushw	x
7913  11f6 ae0080        	ldw	x,#128
7914  11f9 89            	pushw	x
7915  11fa ae0080        	ldw	x,#128
7916  11fd cd0dee        	call	_DF_buffer_read
7918  1200 5b04          	addw	sp,#4
7919  1202               L7643:
7920                     ; 1464 		if(memory_manufacturer=='S') 
7922  1202 b6bc          	ld	a,_memory_manufacturer
7923  1204 a153          	cp	a,#83
7924  1206 2621          	jrne	L5643
7925                     ; 1466 			ST_READ((unsigned long)((unsigned long)(current_page*256UL)+128UL),128,&buff[128]);
7927  1208 ae00d0        	ldw	x,#_buff+128
7928  120b 89            	pushw	x
7929  120c ae0080        	ldw	x,#128
7930  120f 89            	pushw	x
7931  1210 be0f          	ldw	x,_current_page
7932  1212 90ae0100      	ldw	y,#256
7933  1216 cd0000        	call	c_umul
7935  1219 a680          	ld	a,#128
7936  121b cd0000        	call	c_ladc
7938  121e be02          	ldw	x,c_lreg+2
7939  1220 89            	pushw	x
7940  1221 be00          	ldw	x,c_lreg
7941  1223 89            	pushw	x
7942  1224 cd0cec        	call	_ST_READ
7944  1227 5b08          	addw	sp,#8
7945  1229               L5643:
7946                     ; 1470 	if(bRXIN)
7948                     	btst	_bRXIN
7949  122e 2407          	jruge	L3743
7950                     ; 1472 		bRXIN=0;
7952  1230 72110004      	bres	_bRXIN
7953                     ; 1474 		uart_in();
7955  1234 cd0e9c        	call	_uart_in
7957  1237               L3743:
7958                     ; 1478 	if(b100Hz)
7960                     	btst	_b100Hz
7961  123c 2503          	jrult	L402
7962  123e cc12f1        	jp	L5743
7963  1241               L402:
7964                     ; 1480 		b100Hz=0;
7966  1241 7211000a      	bres	_b100Hz
7967                     ; 1482 		if(but_block_cnt)but_block_cnt--;
7969  1245 be00          	ldw	x,_but_block_cnt
7970  1247 2707          	jreq	L7743
7973  1249 be00          	ldw	x,_but_block_cnt
7974  124b 1d0001        	subw	x,#1
7975  124e bf00          	ldw	_but_block_cnt,x
7976  1250               L7743:
7977                     ; 1484 		if(bSTART==1) 
7979                     	btst	_bSTART
7980  1255 24e7          	jruge	L5743
7981                     ; 1486 			if(play) 
7983                     	btst	_play
7984  125c 2417          	jruge	L3053
7985                     ; 1489 				if(!but_block_cnt)
7987  125e be00          	ldw	x,_but_block_cnt
7988  1260 260d          	jrne	L5053
7989                     ; 1491 					play=0;
7991  1262 72110006      	bres	_play
7992                     ; 1492 					bSTART=0;
7994  1266 7211000e      	bres	_bSTART
7995                     ; 1493 					but_block_cnt=50;
7997  126a ae0032        	ldw	x,#50
7998  126d bf00          	ldw	_but_block_cnt,x
7999  126f               L5053:
8000                     ; 1496 				bSTART=0;
8002  126f 7211000e      	bres	_bSTART
8004  1273 207c          	jra	L5743
8005  1275               L3053:
8006                     ; 1500 			if(!but_block_cnt)
8008  1275 be00          	ldw	x,_but_block_cnt
8009  1277 2678          	jrne	L5743
8010                     ; 1503 				current_page=1;
8012  1279 ae0001        	ldw	x,#1
8013  127c bf0f          	ldw	_current_page,x
8014                     ; 1505 				last_page=6000;
8016  127e ae1770        	ldw	x,#6000
8017  1281 bf0d          	ldw	_last_page,x
8018                     ; 1507 				last_page=933;
8020  1283 ae03a5        	ldw	x,#933
8021  1286 bf0d          	ldw	_last_page,x
8022                     ; 1511 				if(memory_manufacturer=='A')
8024  1288 b6bc          	ld	a,_memory_manufacturer
8025  128a a141          	cp	a,#65
8026  128c 2630          	jrne	L3153
8027                     ; 1513 					DF_page_to_buffer(/*///current_buffer_H*//*1,*/current_page);
8029  128e ae0001        	ldw	x,#1
8030  1291 cd0da8        	call	_DF_page_to_buffer
8032                     ; 1514 					delay_ms(10);
8034  1294 ae000a        	ldw	x,#10
8035  1297 cd005c        	call	_delay_ms
8037                     ; 1515 					DF_buffer_read(/*///current_buffer_L*//*1,*/0,128,buff);
8039  129a ae0050        	ldw	x,#_buff
8040  129d 89            	pushw	x
8041  129e ae0080        	ldw	x,#128
8042  12a1 89            	pushw	x
8043  12a2 5f            	clrw	x
8044  12a3 cd0dee        	call	_DF_buffer_read
8046  12a6 5b04          	addw	sp,#4
8047                     ; 1516 					delay_ms(10);
8049  12a8 ae000a        	ldw	x,#10
8050  12ab cd005c        	call	_delay_ms
8052                     ; 1517 					DF_buffer_read(/*///current_buffer_L*//*1,*/128,128,&buff[128]);         
8054  12ae ae00d0        	ldw	x,#_buff+128
8055  12b1 89            	pushw	x
8056  12b2 ae0080        	ldw	x,#128
8057  12b5 89            	pushw	x
8058  12b6 ae0080        	ldw	x,#128
8059  12b9 cd0dee        	call	_DF_buffer_read
8061  12bc 5b04          	addw	sp,#4
8062  12be               L3153:
8063                     ; 1519 				if(memory_manufacturer=='S') 
8065  12be b6bc          	ld	a,_memory_manufacturer
8066  12c0 a153          	cp	a,#83
8067  12c2 2615          	jrne	L5153
8068                     ; 1521 					ST_READ(0,256,buff);
8070  12c4 ae0050        	ldw	x,#_buff
8071  12c7 89            	pushw	x
8072  12c8 ae0100        	ldw	x,#256
8073  12cb 89            	pushw	x
8074  12cc ae0000        	ldw	x,#0
8075  12cf 89            	pushw	x
8076  12d0 ae0000        	ldw	x,#0
8077  12d3 89            	pushw	x
8078  12d4 cd0cec        	call	_ST_READ
8080  12d7 5b08          	addw	sp,#8
8081  12d9               L5153:
8082                     ; 1523 				play=1;
8084  12d9 72100006      	bset	_play
8085                     ; 1524 				bSTART=0;
8087  12dd 7211000e      	bres	_bSTART
8088                     ; 1526 				rele_cnt=rele_cnt_const[rele_cnt_index];
8090  12e1 b6bb          	ld	a,_rele_cnt_index
8091  12e3 5f            	clrw	x
8092  12e4 97            	ld	xl,a
8093  12e5 d60000        	ld	a,(_rele_cnt_const,x)
8094  12e8 5f            	clrw	x
8095  12e9 97            	ld	xl,a
8096  12ea bf03          	ldw	_rele_cnt,x
8097                     ; 1528 				but_block_cnt=50;
8099  12ec ae0032        	ldw	x,#50
8100  12ef bf00          	ldw	_but_block_cnt,x
8101  12f1               L5743:
8102                     ; 1534 	if(b10Hz)
8104                     	btst	_b10Hz
8105  12f6 2413          	jruge	L7153
8106                     ; 1536 		b10Hz=0;
8108  12f8 72110009      	bres	_b10Hz
8109                     ; 1538 		rele_drv();
8111  12fc cd004a        	call	_rele_drv
8113                     ; 1539 		pwm_fade_in++;
8115  12ff 3cba          	inc	_pwm_fade_in
8116                     ; 1540 		if(pwm_fade_in>128)pwm_fade_in=128;			
8118  1301 b6ba          	ld	a,_pwm_fade_in
8119  1303 a181          	cp	a,#129
8120  1305 2504          	jrult	L7153
8123  1307 358000ba      	mov	_pwm_fade_in,#128
8124  130b               L7153:
8125                     ; 1543 	if(b5Hz)
8127                     	btst	_b5Hz
8128  1310 2404          	jruge	L3253
8129                     ; 1545 		b5Hz=0;
8131  1312 72110008      	bres	_b5Hz
8132  1316               L3253:
8133                     ; 1551 	if(b1Hz)
8135                     	btst	_b1Hz
8136  131b 2503          	jrult	L602
8137  131d cc1174        	jp	L3443
8138  1320               L602:
8139                     ; 1554 		b1Hz=0;
8141  1320 72110007      	bres	_b1Hz
8142                     ; 1563 		if((!bERASE_IN_PROGRESS)&&(bSTART_DOWNLOAD))
8144                     	btst	_bERASE_IN_PROGRESS
8145  1329 2524          	jrult	L7253
8147                     	btst	_bSTART_DOWNLOAD
8148  1330 241d          	jruge	L7253
8149                     ; 1565 			bSTART_DOWNLOAD=0;
8151  1332 72110000      	bres	_bSTART_DOWNLOAD
8152                     ; 1566 			uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
8154  1336 4b00          	push	#0
8155  1338 4b00          	push	#0
8156  133a 3b000f        	push	_current_page
8157  133d b610          	ld	a,_current_page+1
8158  133f a4ff          	and	a,#255
8159  1341 88            	push	a
8160  1342 4b15          	push	#21
8161  1344 ae0016        	ldw	x,#22
8162  1347 a604          	ld	a,#4
8163  1349 95            	ld	xh,a
8164  134a cd00ce        	call	_uart_out
8166  134d 5b05          	addw	sp,#5
8167  134f               L7253:
8168                     ; 1568 		if(bERASE_IN_PROGRESS)
8170                     	btst	_bERASE_IN_PROGRESS
8171  1354 2503          	jrult	L012
8172  1356 cc1174        	jp	L3443
8173  1359               L012:
8174                     ; 1571 			temp=ST_status_read();
8176  1359 cd0c54        	call	_ST_status_read
8178  135c 6b01          	ld	(OFST+0,sp),a
8179                     ; 1572 			if((temp&0x01)==0)	
8181  135e 7b01          	ld	a,(OFST+0,sp)
8182  1360 a501          	bcp	a,#1
8183  1362 2703          	jreq	L212
8184  1364 cc1174        	jp	L3443
8185  1367               L212:
8186                     ; 1574 				bERASE_IN_PROGRESS=0;
8188  1367 72110001      	bres	_bERASE_IN_PROGRESS
8189                     ; 1577 				uart_out (3,CMND,33,33,0,0,0);
8191  136b 4b00          	push	#0
8192  136d 4b00          	push	#0
8193  136f 4b00          	push	#0
8194  1371 4b21          	push	#33
8195  1373 4b21          	push	#33
8196  1375 ae0016        	ldw	x,#22
8197  1378 a603          	ld	a,#3
8198  137a 95            	ld	xh,a
8199  137b cd00ce        	call	_uart_out
8201  137e 5b05          	addw	sp,#5
8202  1380 ac741174      	jpf	L3443
8718                     	xdef	_main
8719                     .bit:	section	.data,bit
8720  0000               _bSTART_DOWNLOAD:
8721  0000 00            	ds.b	1
8722                     	xdef	_bSTART_DOWNLOAD
8723  0001               _bERASE_IN_PROGRESS:
8724  0001 00            	ds.b	1
8725                     	xdef	_bERASE_IN_PROGRESS
8726                     .eeprom:	section	.data
8727  0000               _EE_PAGE_LEN:
8728  0000 0000          	ds.b	2
8729                     	xdef	_EE_PAGE_LEN
8730                     	switch	.bss
8731  0000               _UIB:
8732  0000 000000000000  	ds.b	80
8733                     	xdef	_UIB
8734  0050               _buff:
8735  0050 000000000000  	ds.b	300
8736                     	xdef	_buff
8737  017c               _dumm:
8738  017c 000000000000  	ds.b	100
8739                     	xdef	_dumm
8740                     	switch	.bit
8741  0002               _bRELEASE:
8742  0002 00            	ds.b	1
8743                     	xdef	_bRELEASE
8744  0003               _rx_buffer_overflow:
8745  0003 00            	ds.b	1
8746                     	xdef	_rx_buffer_overflow
8747  0004               _bRXIN:
8748  0004 00            	ds.b	1
8749                     	xdef	_bRXIN
8750  0005               _bOUT_FREE:
8751  0005 00            	ds.b	1
8752                     	xdef	_bOUT_FREE
8753  0006               _play:
8754  0006 00            	ds.b	1
8755                     	xdef	_play
8756  0007               _b1Hz:
8757  0007 00            	ds.b	1
8758                     	xdef	_b1Hz
8759  0008               _b5Hz:
8760  0008 00            	ds.b	1
8761                     	xdef	_b5Hz
8762  0009               _b10Hz:
8763  0009 00            	ds.b	1
8764                     	xdef	_b10Hz
8765  000a               _b100Hz:
8766  000a 00            	ds.b	1
8767                     	xdef	_b100Hz
8768  000b               _bBUFF_READ_L:
8769  000b 00            	ds.b	1
8770                     	xdef	_bBUFF_READ_L
8771  000c               _bBUFF_READ_H:
8772  000c 00            	ds.b	1
8773                     	xdef	_bBUFF_READ_H
8774  000d               _bBUFF_LOAD:
8775  000d 00            	ds.b	1
8776                     	xdef	_bBUFF_LOAD
8777  000e               _bSTART:
8778  000e 00            	ds.b	1
8779                     	xdef	_bSTART
8780                     	switch	.ubsct
8781  0000               _but_block_cnt:
8782  0000 0000          	ds.b	2
8783                     	xdef	_but_block_cnt
8784                     	xdef	_memory_manufacturer
8785                     	xdef	_rele_cnt_const
8786                     	xdef	_rele_cnt_index
8787                     	xdef	_pwm_fade_in
8788  0002               _rx_offset:
8789  0002 00            	ds.b	1
8790                     	xdef	_rx_offset
8791  0003               _rele_cnt:
8792  0003 0000          	ds.b	2
8793                     	xdef	_rele_cnt
8794  0005               _rx_data:
8795  0005 00            	ds.b	1
8796                     	xdef	_rx_data
8797  0006               _rx_status:
8798  0006 00            	ds.b	1
8799                     	xdef	_rx_status
8800  0007               _file_lengt:
8801  0007 00000000      	ds.b	4
8802                     	xdef	_file_lengt
8803  000b               _current_byte_in_buffer:
8804  000b 0000          	ds.b	2
8805                     	xdef	_current_byte_in_buffer
8806  000d               _last_page:
8807  000d 0000          	ds.b	2
8808                     	xdef	_last_page
8809  000f               _current_page:
8810  000f 0000          	ds.b	2
8811                     	xdef	_current_page
8812  0011               _file_lengt_in_pages:
8813  0011 0000          	ds.b	2
8814                     	xdef	_file_lengt_in_pages
8815  0013               _mdr3:
8816  0013 00            	ds.b	1
8817                     	xdef	_mdr3
8818  0014               _mdr2:
8819  0014 00            	ds.b	1
8820                     	xdef	_mdr2
8821  0015               _mdr1:
8822  0015 00            	ds.b	1
8823                     	xdef	_mdr1
8824  0016               _mdr0:
8825  0016 00            	ds.b	1
8826                     	xdef	_mdr0
8827                     	xdef	_but_on_drv_cnt
8828                     	xdef	_but_drv_cnt
8829  0017               _sample:
8830  0017 00            	ds.b	1
8831                     	xdef	_sample
8832  0018               _rx_rd_index:
8833  0018 0000          	ds.b	2
8834                     	xdef	_rx_rd_index
8835  001a               _rx_wr_index:
8836  001a 0000          	ds.b	2
8837                     	xdef	_rx_wr_index
8838  001c               _rx_counter:
8839  001c 0000          	ds.b	2
8840                     	xdef	_rx_counter
8841                     	xdef	_rx_buffer
8842  001e               _tx_rd_index:
8843  001e 00            	ds.b	1
8844                     	xdef	_tx_rd_index
8845  001f               _tx_wr_index:
8846  001f 00            	ds.b	1
8847                     	xdef	_tx_wr_index
8848  0020               _tx_counter:
8849  0020 00            	ds.b	1
8850                     	xdef	_tx_counter
8851                     	xdef	_tx_buffer
8852  0021               _sample_cnt:
8853  0021 0000          	ds.b	2
8854                     	xdef	_sample_cnt
8855                     	xdef	_t0_cnt3
8856                     	xdef	_t0_cnt2
8857                     	xdef	_t0_cnt1
8858                     	xdef	_t0_cnt0
8859                     	xdef	_ST_bulk_erase
8860                     	xdef	_ST_READ
8861                     	xdef	_ST_WRITE
8862                     	xdef	_ST_WREN
8863                     	xdef	_ST_status_read
8864                     	xdef	_ST_RDID_read
8865                     	xdef	_uart_in_an
8866                     	xdef	_control_check
8867                     	xdef	_index_offset
8868                     	xdef	_uart_in
8869                     	xdef	_gpio_init
8870                     	xdef	_spi_init
8871                     	xdef	_spi
8872                     	xdef	_DF_buffer_to_page_er
8873                     	xdef	_DF_page_to_buffer
8874                     	xdef	_DF_buffer_write
8875                     	xdef	_DF_buffer_read
8876                     	xdef	_DF_status_read
8877                     	xdef	_DF_memo_to_256
8878                     	xdef	_DF_mf_dev_read
8879                     	xdef	_uart_init
8880                     	xdef	f_UARTRxInterrupt
8881                     	xdef	f_UARTTxInterrupt
8882                     	xdef	_putchar
8883                     	xdef	_uart_out_adr_block
8884                     	xdef	_uart_out
8885                     	xdef	f_TIM4_UPD_Interrupt
8886                     	xdef	_delay_ms
8887                     	xdef	_rele_drv
8888                     	xdef	_t4_init
8889                     	xdef	_t2_init
8890                     	xref.b	c_lreg
8891                     	xref.b	c_x
8892                     	xref.b	c_y
8912                     	xref	c_ladc
8913                     	xref	c_itolx
8914                     	xref	c_umul
8915                     	xref	c_eewrw
8916                     	xref	c_lglsh
8917                     	xref	c_uitolx
8918                     	xref	c_lgursh
8919                     	xref	c_lcmp
8920                     	xref	c_ltor
8921                     	xref	c_lgadc
8922                     	xref	c_rtol
8923                     	xref	c_vmul
8924                     	end
