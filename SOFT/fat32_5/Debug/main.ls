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
2352                     ; 90 void rele_drv(void) {
2353                     	switch	.text
2354  004a               _rele_drv:
2358                     ; 100 	if(play) {
2360                     	btst	_play
2361  004f 2406          	jruge	L1641
2362                     ; 101 		GPIOD->ODR|=(1<<4);
2364  0051 7218500f      	bset	20495,#4
2366  0055 2004          	jra	L3641
2367  0057               L1641:
2368                     ; 103 	else GPIOD->ODR&=~(1<<4);
2370  0057 7219500f      	bres	20495,#4
2371  005b               L3641:
2372                     ; 105 }
2375  005b 81            	ret
2436                     ; 108 long delay_ms(short in)
2436                     ; 109 {
2437                     	switch	.text
2438  005c               _delay_ms:
2440  005c 520c          	subw	sp,#12
2441       0000000c      OFST:	set	12
2444                     ; 112 i=((long)in)*100UL;
2446  005e 90ae0064      	ldw	y,#100
2447  0062 cd0000        	call	c_vmul
2449  0065 96            	ldw	x,sp
2450  0066 1c0005        	addw	x,#OFST-7
2451  0069 cd0000        	call	c_rtol
2453                     ; 114 for(ii=0;ii<i;ii++)
2455  006c ae0000        	ldw	x,#0
2456  006f 1f0b          	ldw	(OFST-1,sp),x
2457  0071 ae0000        	ldw	x,#0
2458  0074 1f09          	ldw	(OFST-3,sp),x
2460  0076 2012          	jra	L3251
2461  0078               L7151:
2462                     ; 116 		iii++;
2464  0078 96            	ldw	x,sp
2465  0079 1c0001        	addw	x,#OFST-11
2466  007c a601          	ld	a,#1
2467  007e cd0000        	call	c_lgadc
2469                     ; 114 for(ii=0;ii<i;ii++)
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
2489                     ; 119 }
2492  009b 5b0c          	addw	sp,#12
2493  009d 81            	ret
2516                     ; 122 void uart_init (void){
2517                     	switch	.text
2518  009e               _uart_init:
2522                     ; 123 	GPIOD->DDR|=(1<<5);
2524  009e 721a5011      	bset	20497,#5
2525                     ; 124 	GPIOD->CR1|=(1<<5);
2527  00a2 721a5012      	bset	20498,#5
2528                     ; 125 	GPIOD->CR2|=(1<<5);
2530  00a6 721a5013      	bset	20499,#5
2531                     ; 128 	GPIOD->DDR&=~(1<<6);
2533  00aa 721d5011      	bres	20497,#6
2534                     ; 129 	GPIOD->CR1&=~(1<<6);
2536  00ae 721d5012      	bres	20498,#6
2537                     ; 130 	GPIOD->CR2&=~(1<<6);
2539  00b2 721d5013      	bres	20499,#6
2540                     ; 133 	UART1->CR1&=~UART1_CR1_M;					
2542  00b6 72195234      	bres	21044,#4
2543                     ; 134 	UART1->CR3|= (0<<4) & UART1_CR3_STOP;	
2545  00ba c65236        	ld	a,21046
2546                     ; 135 	UART1->BRR2= 0x01;//0x03;
2548  00bd 35015233      	mov	21043,#1
2549                     ; 136 	UART1->BRR1= 0x1a;//0x68;
2551  00c1 351a5232      	mov	21042,#26
2552                     ; 137 	UART1->CR2|= UART1_CR2_TEN | UART3_CR2_REN | UART3_CR2_RIEN;	
2554  00c5 c65235        	ld	a,21045
2555  00c8 aa2c          	or	a,#44
2556  00ca c75235        	ld	21045,a
2557                     ; 138 }
2560  00cd 81            	ret
2678                     ; 141 void uart_out (char num,char data0,char data1,char data2,char data3,char data4,char data5){
2679                     	switch	.text
2680  00ce               _uart_out:
2682  00ce 89            	pushw	x
2683  00cf 520c          	subw	sp,#12
2684       0000000c      OFST:	set	12
2687                     ; 142 	char i=0,t=0,UOB[10];
2691  00d1 0f01          	clr	(OFST-11,sp)
2692                     ; 145 	UOB[0]=data0;
2694  00d3 9f            	ld	a,xl
2695  00d4 6b02          	ld	(OFST-10,sp),a
2696                     ; 146 	UOB[1]=data1;
2698  00d6 7b11          	ld	a,(OFST+5,sp)
2699  00d8 6b03          	ld	(OFST-9,sp),a
2700                     ; 147 	UOB[2]=data2;
2702  00da 7b12          	ld	a,(OFST+6,sp)
2703  00dc 6b04          	ld	(OFST-8,sp),a
2704                     ; 148 	UOB[3]=data3;
2706  00de 7b13          	ld	a,(OFST+7,sp)
2707  00e0 6b05          	ld	(OFST-7,sp),a
2708                     ; 149 	UOB[4]=data4;
2710  00e2 7b14          	ld	a,(OFST+8,sp)
2711  00e4 6b06          	ld	(OFST-6,sp),a
2712                     ; 150 	UOB[5]=data5;
2714  00e6 7b15          	ld	a,(OFST+9,sp)
2715  00e8 6b07          	ld	(OFST-5,sp),a
2716                     ; 151 	for (i=0;i<num;i++)
2718  00ea 0f0c          	clr	(OFST+0,sp)
2720  00ec 2013          	jra	L5261
2721  00ee               L1261:
2722                     ; 153 		t^=UOB[i];
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
2736                     ; 151 	for (i=0;i<num;i++)
2738  00ff 0c0c          	inc	(OFST+0,sp)
2739  0101               L5261:
2742  0101 7b0c          	ld	a,(OFST+0,sp)
2743  0103 110d          	cp	a,(OFST+1,sp)
2744  0105 25e7          	jrult	L1261
2745                     ; 155 	UOB[num]=num;
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
2758                     ; 156 	t^=UOB[num];
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
2772                     ; 157 	UOB[num+1]=t;
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
2785                     ; 158 	UOB[num+2]=END;
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
2798                     ; 162 	for (i=0;i<num+3;i++)
2800  0145 0f0c          	clr	(OFST+0,sp)
2802  0147 2012          	jra	L5361
2803  0149               L1361:
2804                     ; 164 		putchar(UOB[i]);
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
2816  0156 cd0861        	call	_putchar
2818                     ; 162 	for (i=0;i<num+3;i++)
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
2835                     ; 167 	bOUT_FREE=0;	  	
2837  0171 72110003      	bres	_bOUT_FREE
2838                     ; 168 }
2841  0175 5b0e          	addw	sp,#14
2842  0177 81            	ret
2924                     ; 171 void uart_out_adr_block (unsigned long adress,char *ptr, char len)
2924                     ; 172 {
2925                     	switch	.text
2926  0178               _uart_out_adr_block:
2928  0178 5203          	subw	sp,#3
2929       00000003      OFST:	set	3
2932                     ; 176 t=0;
2934  017a 0f02          	clr	(OFST-1,sp)
2935                     ; 177 temp11=CMND;
2937                     ; 178 t^=temp11;
2939  017c 7b02          	ld	a,(OFST-1,sp)
2940  017e a816          	xor	a,	#22
2941  0180 6b02          	ld	(OFST-1,sp),a
2942                     ; 179 putchar(temp11);
2944  0182 a616          	ld	a,#22
2945  0184 cd0861        	call	_putchar
2947                     ; 181 temp11=10;
2949                     ; 182 t^=temp11;
2951  0187 7b02          	ld	a,(OFST-1,sp)
2952  0189 a80a          	xor	a,	#10
2953  018b 6b02          	ld	(OFST-1,sp),a
2954                     ; 183 putchar(temp11);
2956  018d a60a          	ld	a,#10
2957  018f cd0861        	call	_putchar
2959                     ; 185 temp11=adress%256;//(*((char*)&adress));
2961  0192 7b09          	ld	a,(OFST+6,sp)
2962  0194 a4ff          	and	a,#255
2963  0196 6b03          	ld	(OFST+0,sp),a
2964                     ; 186 t^=temp11;
2966  0198 7b02          	ld	a,(OFST-1,sp)
2967  019a 1803          	xor	a,	(OFST+0,sp)
2968  019c 6b02          	ld	(OFST-1,sp),a
2969                     ; 187 putchar(temp11);
2971  019e 7b03          	ld	a,(OFST+0,sp)
2972  01a0 cd0861        	call	_putchar
2974                     ; 188 adress>>=8;
2976  01a3 96            	ldw	x,sp
2977  01a4 1c0006        	addw	x,#OFST+3
2978  01a7 a608          	ld	a,#8
2979  01a9 cd0000        	call	c_lgursh
2981                     ; 189 temp11=adress%256;//(*(((char*)&adress)+1));
2983  01ac 7b09          	ld	a,(OFST+6,sp)
2984  01ae a4ff          	and	a,#255
2985  01b0 6b03          	ld	(OFST+0,sp),a
2986                     ; 190 t^=temp11;
2988  01b2 7b02          	ld	a,(OFST-1,sp)
2989  01b4 1803          	xor	a,	(OFST+0,sp)
2990  01b6 6b02          	ld	(OFST-1,sp),a
2991                     ; 191 putchar(temp11);
2993  01b8 7b03          	ld	a,(OFST+0,sp)
2994  01ba cd0861        	call	_putchar
2996                     ; 192 adress>>=8;
2998  01bd 96            	ldw	x,sp
2999  01be 1c0006        	addw	x,#OFST+3
3000  01c1 a608          	ld	a,#8
3001  01c3 cd0000        	call	c_lgursh
3003                     ; 193 temp11=adress%256;//(*(((char*)&adress)+2));
3005  01c6 7b09          	ld	a,(OFST+6,sp)
3006  01c8 a4ff          	and	a,#255
3007  01ca 6b03          	ld	(OFST+0,sp),a
3008                     ; 194 t^=temp11;
3010  01cc 7b02          	ld	a,(OFST-1,sp)
3011  01ce 1803          	xor	a,	(OFST+0,sp)
3012  01d0 6b02          	ld	(OFST-1,sp),a
3013                     ; 195 putchar(temp11);
3015  01d2 7b03          	ld	a,(OFST+0,sp)
3016  01d4 cd0861        	call	_putchar
3018                     ; 196 adress>>=8;
3020  01d7 96            	ldw	x,sp
3021  01d8 1c0006        	addw	x,#OFST+3
3022  01db a608          	ld	a,#8
3023  01dd cd0000        	call	c_lgursh
3025                     ; 197 temp11=adress%256;//(*(((char*)&adress)+3));
3027  01e0 7b09          	ld	a,(OFST+6,sp)
3028  01e2 a4ff          	and	a,#255
3029  01e4 6b03          	ld	(OFST+0,sp),a
3030                     ; 198 t^=temp11;
3032  01e6 7b02          	ld	a,(OFST-1,sp)
3033  01e8 1803          	xor	a,	(OFST+0,sp)
3034  01ea 6b02          	ld	(OFST-1,sp),a
3035                     ; 199 putchar(temp11);
3037  01ec 7b03          	ld	a,(OFST+0,sp)
3038  01ee cd0861        	call	_putchar
3040                     ; 202 for(i11=0;i11<len;i11++)
3042  01f1 0f01          	clr	(OFST-2,sp)
3044  01f3 201b          	jra	L7071
3045  01f5               L3071:
3046                     ; 204 	temp11=ptr[i11];
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
3058                     ; 205 	t^=temp11;
3060  0203 7b02          	ld	a,(OFST-1,sp)
3061  0205 1803          	xor	a,	(OFST+0,sp)
3062  0207 6b02          	ld	(OFST-1,sp),a
3063                     ; 206 	putchar(temp11);
3065  0209 7b03          	ld	a,(OFST+0,sp)
3066  020b cd0861        	call	_putchar
3068                     ; 202 for(i11=0;i11<len;i11++)
3070  020e 0c01          	inc	(OFST-2,sp)
3071  0210               L7071:
3074  0210 7b01          	ld	a,(OFST-2,sp)
3075  0212 110c          	cp	a,(OFST+9,sp)
3076  0214 25df          	jrult	L3071
3077                     ; 209 temp11=(len+6);
3079  0216 7b0c          	ld	a,(OFST+9,sp)
3080  0218 ab06          	add	a,#6
3081  021a 6b03          	ld	(OFST+0,sp),a
3082                     ; 210 t^=temp11;
3084  021c 7b02          	ld	a,(OFST-1,sp)
3085  021e 1803          	xor	a,	(OFST+0,sp)
3086  0220 6b02          	ld	(OFST-1,sp),a
3087                     ; 211 putchar(temp11);
3089  0222 7b03          	ld	a,(OFST+0,sp)
3090  0224 cd0861        	call	_putchar
3092                     ; 213 putchar(t);
3094  0227 7b02          	ld	a,(OFST-1,sp)
3095  0229 cd0861        	call	_putchar
3097                     ; 215 putchar(0x0a);
3099  022c a60a          	ld	a,#10
3100  022e cd0861        	call	_putchar
3102                     ; 217 bOUT_FREE=0;	   
3104  0231 72110003      	bres	_bOUT_FREE
3105                     ; 218 }
3108  0235 5b03          	addw	sp,#3
3109  0237 81            	ret
3244                     ; 220 void uart_in_an(void) {
3245                     	switch	.text
3246  0238               _uart_in_an:
3248  0238 5204          	subw	sp,#4
3249       00000004      OFST:	set	4
3252                     ; 223 	if(UIB[0]==CMND) {
3254  023a c60000        	ld	a,_UIB
3255  023d a116          	cp	a,#22
3256  023f 2703          	jreq	L24
3257  0241 cc085e        	jp	L1771
3258  0244               L24:
3259                     ; 224 		if(UIB[1]==1) {
3261  0244 c60001        	ld	a,_UIB+1
3262  0247 a101          	cp	a,#1
3263  0249 262f          	jrne	L3771
3264                     ; 228 			if(memory_manufacturer=='A') {
3266  024b b6bc          	ld	a,_memory_manufacturer
3267  024d a141          	cp	a,#65
3268  024f 2603          	jrne	L5771
3269                     ; 229 				temp_L=DF_mf_dev_read();
3271  0251 cd0a46        	call	_DF_mf_dev_read
3273  0254               L5771:
3274                     ; 231 			if(memory_manufacturer=='S') {
3276  0254 b6bc          	ld	a,_memory_manufacturer
3277  0256 a153          	cp	a,#83
3278  0258 2603          	jrne	L7771
3279                     ; 232 				temp_L=ST_RDID_read();
3281  025a cd0922        	call	_ST_RDID_read
3283  025d               L7771:
3284                     ; 234 			uart_out (6,CMND,1,mdr0/**((char*)&temp_L)*/,mdr1/**(((char*)&temp_L)+1)*/,mdr2/**(((char*)&temp_L)+2)*/,mdr3/**(((char*)&temp_L)+3)*/);
3286  025d 3b0013        	push	_mdr3
3287  0260 3b0014        	push	_mdr2
3288  0263 3b0015        	push	_mdr1
3289  0266 3b0016        	push	_mdr0
3290  0269 4b01          	push	#1
3291  026b ae0016        	ldw	x,#22
3292  026e a606          	ld	a,#6
3293  0270 95            	ld	xh,a
3294  0271 cd00ce        	call	_uart_out
3296  0274 5b05          	addw	sp,#5
3298  0276 ac5e085e      	jpf	L1771
3299  027a               L3771:
3300                     ; 241 	else if(UIB[1]==2) {
3302  027a c60001        	ld	a,_UIB+1
3303  027d a102          	cp	a,#2
3304  027f 2630          	jrne	L3002
3305                     ; 244 		if(memory_manufacturer=='A') {
3307  0281 b6bc          	ld	a,_memory_manufacturer
3308  0283 a141          	cp	a,#65
3309  0285 2605          	jrne	L5002
3310                     ; 245 			temp=DF_status_read();
3312  0287 cd0a9a        	call	_DF_status_read
3314  028a 6b04          	ld	(OFST+0,sp),a
3315  028c               L5002:
3316                     ; 247 		if(memory_manufacturer=='S') {
3318  028c b6bc          	ld	a,_memory_manufacturer
3319  028e a153          	cp	a,#83
3320  0290 2605          	jrne	L7002
3321                     ; 248 			temp=ST_status_read();
3323  0292 cd094e        	call	_ST_status_read
3325  0295 6b04          	ld	(OFST+0,sp),a
3326  0297               L7002:
3327                     ; 250 		uart_out (3,CMND,2,temp,0,0,0);    
3329  0297 4b00          	push	#0
3330  0299 4b00          	push	#0
3331  029b 4b00          	push	#0
3332  029d 7b07          	ld	a,(OFST+3,sp)
3333  029f 88            	push	a
3334  02a0 4b02          	push	#2
3335  02a2 ae0016        	ldw	x,#22
3336  02a5 a603          	ld	a,#3
3337  02a7 95            	ld	xh,a
3338  02a8 cd00ce        	call	_uart_out
3340  02ab 5b05          	addw	sp,#5
3342  02ad ac5e085e      	jpf	L1771
3343  02b1               L3002:
3344                     ; 254 	else if(UIB[1]==3)
3346  02b1 c60001        	ld	a,_UIB+1
3347  02b4 a103          	cp	a,#3
3348  02b6 2623          	jrne	L3102
3349                     ; 257 		if(memory_manufacturer=='A') {
3351  02b8 b6bc          	ld	a,_memory_manufacturer
3352  02ba a141          	cp	a,#65
3353  02bc 2603          	jrne	L5102
3354                     ; 258 			DF_memo_to_256();
3356  02be cd0a7d        	call	_DF_memo_to_256
3358  02c1               L5102:
3359                     ; 260 		uart_out (2,CMND,3,temp,0,0,0);    
3361  02c1 4b00          	push	#0
3362  02c3 4b00          	push	#0
3363  02c5 4b00          	push	#0
3364  02c7 7b07          	ld	a,(OFST+3,sp)
3365  02c9 88            	push	a
3366  02ca 4b03          	push	#3
3367  02cc ae0016        	ldw	x,#22
3368  02cf a602          	ld	a,#2
3369  02d1 95            	ld	xh,a
3370  02d2 cd00ce        	call	_uart_out
3372  02d5 5b05          	addw	sp,#5
3374  02d7 ac5e085e      	jpf	L1771
3375  02db               L3102:
3376                     ; 263 	else if(UIB[1]==4)
3378  02db c60001        	ld	a,_UIB+1
3379  02de a104          	cp	a,#4
3380  02e0 2623          	jrne	L1202
3381                     ; 266 		if(memory_manufacturer=='A') {
3383  02e2 b6bc          	ld	a,_memory_manufacturer
3384  02e4 a141          	cp	a,#65
3385  02e6 2603          	jrne	L3202
3386                     ; 267 			DF_memo_to_256();
3388  02e8 cd0a7d        	call	_DF_memo_to_256
3390  02eb               L3202:
3391                     ; 269 		uart_out (2,CMND,3,temp,0,0,0);    
3393  02eb 4b00          	push	#0
3394  02ed 4b00          	push	#0
3395  02ef 4b00          	push	#0
3396  02f1 7b07          	ld	a,(OFST+3,sp)
3397  02f3 88            	push	a
3398  02f4 4b03          	push	#3
3399  02f6 ae0016        	ldw	x,#22
3400  02f9 a602          	ld	a,#2
3401  02fb 95            	ld	xh,a
3402  02fc cd00ce        	call	_uart_out
3404  02ff 5b05          	addw	sp,#5
3406  0301 ac5e085e      	jpf	L1771
3407  0305               L1202:
3408                     ; 272 	else if(UIB[1]==10)
3410  0305 c60001        	ld	a,_UIB+1
3411  0308 a10a          	cp	a,#10
3412  030a 2703cc0392    	jrne	L7202
3413                     ; 276 		if(memory_manufacturer=='A') {
3415  030f b6bc          	ld	a,_memory_manufacturer
3416  0311 a141          	cp	a,#65
3417  0313 2615          	jrne	L1302
3418                     ; 277 			if(UIB[2]==1)DF_buffer_read(/*1,*/0,256, buff);
3420  0315 c60002        	ld	a,_UIB+2
3421  0318 a101          	cp	a,#1
3422  031a 260e          	jrne	L1302
3425  031c ae0050        	ldw	x,#_buff
3426  031f 89            	pushw	x
3427  0320 ae0100        	ldw	x,#256
3428  0323 89            	pushw	x
3429  0324 5f            	clrw	x
3430  0325 cd0afa        	call	_DF_buffer_read
3432  0328 5b04          	addw	sp,#4
3433  032a               L1302:
3434                     ; 282 		uart_out_adr_block (0,buff,64);
3436  032a 4b40          	push	#64
3437  032c ae0050        	ldw	x,#_buff
3438  032f 89            	pushw	x
3439  0330 ae0000        	ldw	x,#0
3440  0333 89            	pushw	x
3441  0334 ae0000        	ldw	x,#0
3442  0337 89            	pushw	x
3443  0338 cd0178        	call	_uart_out_adr_block
3445  033b 5b07          	addw	sp,#7
3446                     ; 283 		delay_ms(100);    
3448  033d ae0064        	ldw	x,#100
3449  0340 cd005c        	call	_delay_ms
3451                     ; 284 		uart_out_adr_block (64,&buff[64],64);
3453  0343 4b40          	push	#64
3454  0345 ae0090        	ldw	x,#_buff+64
3455  0348 89            	pushw	x
3456  0349 ae0040        	ldw	x,#64
3457  034c 89            	pushw	x
3458  034d ae0000        	ldw	x,#0
3459  0350 89            	pushw	x
3460  0351 cd0178        	call	_uart_out_adr_block
3462  0354 5b07          	addw	sp,#7
3463                     ; 285 		delay_ms(100);    
3465  0356 ae0064        	ldw	x,#100
3466  0359 cd005c        	call	_delay_ms
3468                     ; 286 		uart_out_adr_block (128,&buff[128],64);
3470  035c 4b40          	push	#64
3471  035e ae00d0        	ldw	x,#_buff+128
3472  0361 89            	pushw	x
3473  0362 ae0080        	ldw	x,#128
3474  0365 89            	pushw	x
3475  0366 ae0000        	ldw	x,#0
3476  0369 89            	pushw	x
3477  036a cd0178        	call	_uart_out_adr_block
3479  036d 5b07          	addw	sp,#7
3480                     ; 287 		delay_ms(100);    
3482  036f ae0064        	ldw	x,#100
3483  0372 cd005c        	call	_delay_ms
3485                     ; 288 		uart_out_adr_block (192,&buff[192],64);
3487  0375 4b40          	push	#64
3488  0377 ae0110        	ldw	x,#_buff+192
3489  037a 89            	pushw	x
3490  037b ae00c0        	ldw	x,#192
3491  037e 89            	pushw	x
3492  037f ae0000        	ldw	x,#0
3493  0382 89            	pushw	x
3494  0383 cd0178        	call	_uart_out_adr_block
3496  0386 5b07          	addw	sp,#7
3497                     ; 289 		delay_ms(100);    
3499  0388 ae0064        	ldw	x,#100
3500  038b cd005c        	call	_delay_ms
3503  038e ac5e085e      	jpf	L1771
3504  0392               L7202:
3505                     ; 292 	else if(UIB[1]==11)
3507  0392 c60001        	ld	a,_UIB+1
3508  0395 a10b          	cp	a,#11
3509  0397 2633          	jrne	L7302
3510                     ; 298 		for(i=0;i<256;i++)buff[i]=0;
3512  0399 5f            	clrw	x
3513  039a 1f03          	ldw	(OFST-1,sp),x
3514  039c               L1402:
3517  039c 1e03          	ldw	x,(OFST-1,sp)
3518  039e 724f0050      	clr	(_buff,x)
3521  03a2 1e03          	ldw	x,(OFST-1,sp)
3522  03a4 1c0001        	addw	x,#1
3523  03a7 1f03          	ldw	(OFST-1,sp),x
3526  03a9 1e03          	ldw	x,(OFST-1,sp)
3527  03ab a30100        	cpw	x,#256
3528  03ae 25ec          	jrult	L1402
3529                     ; 300 		if(UIB[2]==1)DF_buffer_write(/*1,*/0,256, buff);
3531  03b0 c60002        	ld	a,_UIB+2
3532  03b3 a101          	cp	a,#1
3533  03b5 2703          	jreq	L44
3534  03b7 cc085e        	jp	L1771
3535  03ba               L44:
3538  03ba ae0050        	ldw	x,#_buff
3539  03bd 89            	pushw	x
3540  03be ae0100        	ldw	x,#256
3541  03c1 89            	pushw	x
3542  03c2 5f            	clrw	x
3543  03c3 cd0b40        	call	_DF_buffer_write
3545  03c6 5b04          	addw	sp,#4
3546  03c8 ac5e085e      	jpf	L1771
3547  03cc               L7302:
3548                     ; 304 	else if(UIB[1]==12)
3550  03cc c60001        	ld	a,_UIB+1
3551  03cf a10c          	cp	a,#12
3552  03d1 2703          	jreq	L64
3553  03d3 cc04b2        	jp	L3502
3554  03d6               L64:
3555                     ; 310 		for(i=0;i<256;i++)buff[i]=0;
3557  03d6 5f            	clrw	x
3558  03d7 1f03          	ldw	(OFST-1,sp),x
3559  03d9               L5502:
3562  03d9 1e03          	ldw	x,(OFST-1,sp)
3563  03db 724f0050      	clr	(_buff,x)
3566  03df 1e03          	ldw	x,(OFST-1,sp)
3567  03e1 1c0001        	addw	x,#1
3568  03e4 1f03          	ldw	(OFST-1,sp),x
3571  03e6 1e03          	ldw	x,(OFST-1,sp)
3572  03e8 a30100        	cpw	x,#256
3573  03eb 25ec          	jrult	L5502
3574                     ; 312 		if(UIB[3]==1)
3576  03ed c60003        	ld	a,_UIB+3
3577  03f0 a101          	cp	a,#1
3578  03f2 2632          	jrne	L3602
3579                     ; 314 			buff[0]=0x00;
3581  03f4 725f0050      	clr	_buff
3582                     ; 315 			buff[1]=0x11;
3584  03f8 35110051      	mov	_buff+1,#17
3585                     ; 316 			buff[2]=0x22;
3587  03fc 35220052      	mov	_buff+2,#34
3588                     ; 317 			buff[3]=0x33;
3590  0400 35330053      	mov	_buff+3,#51
3591                     ; 318 			buff[4]=0x44;
3593  0404 35440054      	mov	_buff+4,#68
3594                     ; 319 			buff[5]=0x55;
3596  0408 35550055      	mov	_buff+5,#85
3597                     ; 320 			buff[6]=0x66;
3599  040c 35660056      	mov	_buff+6,#102
3600                     ; 321 			buff[7]=0x77;
3602  0410 35770057      	mov	_buff+7,#119
3603                     ; 322 			buff[8]=0x88;
3605  0414 35880058      	mov	_buff+8,#136
3606                     ; 323 			buff[9]=0x99;
3608  0418 35990059      	mov	_buff+9,#153
3609                     ; 324 			buff[10]=0;
3611  041c 725f005a      	clr	_buff+10
3612                     ; 325 			buff[11]=0;
3614  0420 725f005b      	clr	_buff+11
3616  0424 2070          	jra	L5602
3617  0426               L3602:
3618                     ; 328 		else if(UIB[3]==2)
3620  0426 c60003        	ld	a,_UIB+3
3621  0429 a102          	cp	a,#2
3622  042b 2632          	jrne	L7602
3623                     ; 330 			buff[0]=0x00;
3625  042d 725f0050      	clr	_buff
3626                     ; 331 			buff[1]=0x10;
3628  0431 35100051      	mov	_buff+1,#16
3629                     ; 332 			buff[2]=0x20;
3631  0435 35200052      	mov	_buff+2,#32
3632                     ; 333 			buff[3]=0x30;
3634  0439 35300053      	mov	_buff+3,#48
3635                     ; 334 			buff[4]=0x40;
3637  043d 35400054      	mov	_buff+4,#64
3638                     ; 335 			buff[5]=0x50;
3640  0441 35500055      	mov	_buff+5,#80
3641                     ; 336 			buff[6]=0x60;
3643  0445 35600056      	mov	_buff+6,#96
3644                     ; 337 			buff[7]=0x70;
3646  0449 35700057      	mov	_buff+7,#112
3647                     ; 338 			buff[8]=0x80;
3649  044d 35800058      	mov	_buff+8,#128
3650                     ; 339 			buff[9]=0x90;
3652  0451 35900059      	mov	_buff+9,#144
3653                     ; 340 			buff[10]=0;
3655  0455 725f005a      	clr	_buff+10
3656                     ; 341 			buff[11]=0;
3658  0459 725f005b      	clr	_buff+11
3660  045d 2037          	jra	L5602
3661  045f               L7602:
3662                     ; 344 		else if(UIB[3]==3)
3664  045f c60003        	ld	a,_UIB+3
3665  0462 a103          	cp	a,#3
3666  0464 2630          	jrne	L5602
3667                     ; 346 			buff[0]=0x98;
3669  0466 35980050      	mov	_buff,#152
3670                     ; 347 			buff[1]=0x87;
3672  046a 35870051      	mov	_buff+1,#135
3673                     ; 348 			buff[2]=0x76;
3675  046e 35760052      	mov	_buff+2,#118
3676                     ; 349 			buff[3]=0x65;
3678  0472 35650053      	mov	_buff+3,#101
3679                     ; 350 			buff[4]=0x54;
3681  0476 35540054      	mov	_buff+4,#84
3682                     ; 351 			buff[5]=0x43;
3684  047a 35430055      	mov	_buff+5,#67
3685                     ; 352 			buff[6]=0x32;
3687  047e 35320056      	mov	_buff+6,#50
3688                     ; 353 			buff[7]=0x21;
3690  0482 35210057      	mov	_buff+7,#33
3691                     ; 354 			buff[8]=0x10;
3693  0486 35100058      	mov	_buff+8,#16
3694                     ; 355 			buff[9]=0x00;
3696  048a 725f0059      	clr	_buff+9
3697                     ; 356 			buff[10]=0;
3699  048e 725f005a      	clr	_buff+10
3700                     ; 357 			buff[11]=0;
3702  0492 725f005b      	clr	_buff+11
3703  0496               L5602:
3704                     ; 359 		if(UIB[2]==1)DF_buffer_write(/*1,*/0,256, buff);
3706  0496 c60002        	ld	a,_UIB+2
3707  0499 a101          	cp	a,#1
3708  049b 2703          	jreq	L05
3709  049d cc085e        	jp	L1771
3710  04a0               L05:
3713  04a0 ae0050        	ldw	x,#_buff
3714  04a3 89            	pushw	x
3715  04a4 ae0100        	ldw	x,#256
3716  04a7 89            	pushw	x
3717  04a8 5f            	clrw	x
3718  04a9 cd0b40        	call	_DF_buffer_write
3720  04ac 5b04          	addw	sp,#4
3721  04ae ac5e085e      	jpf	L1771
3722  04b2               L3502:
3723                     ; 363 	else if(UIB[1]==13)
3725  04b2 c60001        	ld	a,_UIB+1
3726  04b5 a10d          	cp	a,#13
3727  04b7 2703cc0555    	jrne	L1012
3728                     ; 368 		if(memory_manufacturer=='A') {	
3730  04bc b6bc          	ld	a,_memory_manufacturer
3731  04be a141          	cp	a,#65
3732  04c0 2608          	jrne	L3012
3733                     ; 369 			DF_page_to_buffer(/*UIB[2],*/UIB[3]);
3735  04c2 c60003        	ld	a,_UIB+3
3736  04c5 5f            	clrw	x
3737  04c6 97            	ld	xl,a
3738  04c7 cd0ab4        	call	_DF_page_to_buffer
3740  04ca               L3012:
3741                     ; 371 		if(memory_manufacturer=='S') {
3743  04ca b6bc          	ld	a,_memory_manufacturer
3744  04cc a153          	cp	a,#83
3745  04ce 2703          	jreq	L25
3746  04d0 cc085e        	jp	L1771
3747  04d3               L25:
3748                     ; 372 			current_page=11;
3750  04d3 ae000b        	ldw	x,#11
3751  04d6 bf0f          	ldw	_current_page,x
3752                     ; 373 			ST_READ((long)(current_page*256),256, buff);
3754  04d8 ae0050        	ldw	x,#_buff
3755  04db 89            	pushw	x
3756  04dc ae0100        	ldw	x,#256
3757  04df 89            	pushw	x
3758  04e0 ae0b00        	ldw	x,#2816
3759  04e3 89            	pushw	x
3760  04e4 ae0000        	ldw	x,#0
3761  04e7 89            	pushw	x
3762  04e8 cd09f8        	call	_ST_READ
3764  04eb 5b08          	addw	sp,#8
3765                     ; 375 			uart_out_adr_block (0,buff,64);
3767  04ed 4b40          	push	#64
3768  04ef ae0050        	ldw	x,#_buff
3769  04f2 89            	pushw	x
3770  04f3 ae0000        	ldw	x,#0
3771  04f6 89            	pushw	x
3772  04f7 ae0000        	ldw	x,#0
3773  04fa 89            	pushw	x
3774  04fb cd0178        	call	_uart_out_adr_block
3776  04fe 5b07          	addw	sp,#7
3777                     ; 376 			delay_ms(100);    
3779  0500 ae0064        	ldw	x,#100
3780  0503 cd005c        	call	_delay_ms
3782                     ; 377 			uart_out_adr_block (64,&buff[64],64);
3784  0506 4b40          	push	#64
3785  0508 ae0090        	ldw	x,#_buff+64
3786  050b 89            	pushw	x
3787  050c ae0040        	ldw	x,#64
3788  050f 89            	pushw	x
3789  0510 ae0000        	ldw	x,#0
3790  0513 89            	pushw	x
3791  0514 cd0178        	call	_uart_out_adr_block
3793  0517 5b07          	addw	sp,#7
3794                     ; 378 			delay_ms(100);    
3796  0519 ae0064        	ldw	x,#100
3797  051c cd005c        	call	_delay_ms
3799                     ; 379 			uart_out_adr_block (128,&buff[128],64);
3801  051f 4b40          	push	#64
3802  0521 ae00d0        	ldw	x,#_buff+128
3803  0524 89            	pushw	x
3804  0525 ae0080        	ldw	x,#128
3805  0528 89            	pushw	x
3806  0529 ae0000        	ldw	x,#0
3807  052c 89            	pushw	x
3808  052d cd0178        	call	_uart_out_adr_block
3810  0530 5b07          	addw	sp,#7
3811                     ; 380 			delay_ms(100);    
3813  0532 ae0064        	ldw	x,#100
3814  0535 cd005c        	call	_delay_ms
3816                     ; 381 			uart_out_adr_block (192,&buff[192],64);
3818  0538 4b40          	push	#64
3819  053a ae0110        	ldw	x,#_buff+192
3820  053d 89            	pushw	x
3821  053e ae00c0        	ldw	x,#192
3822  0541 89            	pushw	x
3823  0542 ae0000        	ldw	x,#0
3824  0545 89            	pushw	x
3825  0546 cd0178        	call	_uart_out_adr_block
3827  0549 5b07          	addw	sp,#7
3828                     ; 382 			delay_ms(100); 
3830  054b ae0064        	ldw	x,#100
3831  054e cd005c        	call	_delay_ms
3833  0551 ac5e085e      	jpf	L1771
3834  0555               L1012:
3835                     ; 385 	else if(UIB[1]==14)
3837  0555 c60001        	ld	a,_UIB+1
3838  0558 a10e          	cp	a,#14
3839  055a 265b          	jrne	L1112
3840                     ; 390 		if(memory_manufacturer=='A') {	
3842  055c b6bc          	ld	a,_memory_manufacturer
3843  055e a141          	cp	a,#65
3844  0560 2608          	jrne	L3112
3845                     ; 391 			DF_buffer_to_page_er(/*UIB[2],*/UIB[3]);
3847  0562 c60003        	ld	a,_UIB+3
3848  0565 5f            	clrw	x
3849  0566 97            	ld	xl,a
3850  0567 cd0ad7        	call	_DF_buffer_to_page_er
3852  056a               L3112:
3853                     ; 393 		if(memory_manufacturer=='S') {
3855  056a b6bc          	ld	a,_memory_manufacturer
3856  056c a153          	cp	a,#83
3857  056e 2703          	jreq	L45
3858  0570 cc085e        	jp	L1771
3859  0573               L45:
3860                     ; 394 			for(i=0;i<256;i++) {
3862  0573 5f            	clrw	x
3863  0574 1f03          	ldw	(OFST-1,sp),x
3864  0576               L7112:
3865                     ; 395 				buff[i]=(char)i;
3867  0576 7b04          	ld	a,(OFST+0,sp)
3868  0578 1e03          	ldw	x,(OFST-1,sp)
3869  057a d70050        	ld	(_buff,x),a
3870                     ; 394 			for(i=0;i<256;i++) {
3872  057d 1e03          	ldw	x,(OFST-1,sp)
3873  057f 1c0001        	addw	x,#1
3874  0582 1f03          	ldw	(OFST-1,sp),x
3877  0584 1e03          	ldw	x,(OFST-1,sp)
3878  0586 a30100        	cpw	x,#256
3879  0589 25eb          	jrult	L7112
3880                     ; 397 			current_page=11;
3882  058b ae000b        	ldw	x,#11
3883  058e bf0f          	ldw	_current_page,x
3884                     ; 398 			ST_WREN();
3886  0590 cd0966        	call	_ST_WREN
3888                     ; 399 			delay_ms(100);
3890  0593 ae0064        	ldw	x,#100
3891  0596 cd005c        	call	_delay_ms
3893                     ; 400 			ST_WRITE((long)(current_page*256),256,buff);		
3895  0599 ae0050        	ldw	x,#_buff
3896  059c 89            	pushw	x
3897  059d ae0100        	ldw	x,#256
3898  05a0 89            	pushw	x
3899  05a1 be0f          	ldw	x,_current_page
3900  05a3 4f            	clr	a
3901  05a4 02            	rlwa	x,a
3902  05a5 cd0000        	call	c_uitolx
3904  05a8 be02          	ldw	x,c_lreg+2
3905  05aa 89            	pushw	x
3906  05ab be00          	ldw	x,c_lreg
3907  05ad 89            	pushw	x
3908  05ae cd09ac        	call	_ST_WRITE
3910  05b1 5b08          	addw	sp,#8
3911  05b3 ac5e085e      	jpf	L1771
3912  05b7               L1112:
3913                     ; 405 	else if(UIB[1]==20)
3915  05b7 c60001        	ld	a,_UIB+1
3916  05ba a114          	cp	a,#20
3917  05bc 2703cc0645    	jrne	L7212
3918                     ; 410 		file_lengt=0;
3920  05c1 ae0000        	ldw	x,#0
3921  05c4 bf09          	ldw	_file_lengt+2,x
3922  05c6 ae0000        	ldw	x,#0
3923  05c9 bf07          	ldw	_file_lengt,x
3924                     ; 411 		file_lengt+=UIB[5];
3926  05cb c60005        	ld	a,_UIB+5
3927  05ce ae0007        	ldw	x,#_file_lengt
3928  05d1 88            	push	a
3929  05d2 cd0000        	call	c_lgadc
3931  05d5 84            	pop	a
3932                     ; 412 		file_lengt<<=8;
3934  05d6 ae0007        	ldw	x,#_file_lengt
3935  05d9 a608          	ld	a,#8
3936  05db cd0000        	call	c_lglsh
3938                     ; 413 		file_lengt+=UIB[4];
3940  05de c60004        	ld	a,_UIB+4
3941  05e1 ae0007        	ldw	x,#_file_lengt
3942  05e4 88            	push	a
3943  05e5 cd0000        	call	c_lgadc
3945  05e8 84            	pop	a
3946                     ; 414 		file_lengt<<=8;
3948  05e9 ae0007        	ldw	x,#_file_lengt
3949  05ec a608          	ld	a,#8
3950  05ee cd0000        	call	c_lglsh
3952                     ; 415 		file_lengt+=UIB[3];
3954  05f1 c60003        	ld	a,_UIB+3
3955  05f4 ae0007        	ldw	x,#_file_lengt
3956  05f7 88            	push	a
3957  05f8 cd0000        	call	c_lgadc
3959  05fb 84            	pop	a
3960                     ; 416 		file_lengt_in_pages=file_lengt;
3962  05fc be09          	ldw	x,_file_lengt+2
3963  05fe bf11          	ldw	_file_lengt_in_pages,x
3964                     ; 417 		file_lengt<<=8;
3966  0600 ae0007        	ldw	x,#_file_lengt
3967  0603 a608          	ld	a,#8
3968  0605 cd0000        	call	c_lglsh
3970                     ; 418 		file_lengt+=UIB[2];
3972  0608 c60002        	ld	a,_UIB+2
3973  060b ae0007        	ldw	x,#_file_lengt
3974  060e 88            	push	a
3975  060f cd0000        	call	c_lgadc
3977  0612 84            	pop	a
3978                     ; 423 		current_page=0;
3980  0613 5f            	clrw	x
3981  0614 bf0f          	ldw	_current_page,x
3982                     ; 424 		current_byte_in_buffer=0;
3984  0616 5f            	clrw	x
3985  0617 bf0b          	ldw	_current_byte_in_buffer,x
3986                     ; 426 		if(memory_manufacturer=='S') {
3988  0619 b6bc          	ld	a,_memory_manufacturer
3989  061b a153          	cp	a,#83
3990  061d 2609          	jrne	L1312
3991                     ; 427 			ST_WREN();
3993  061f cd0966        	call	_ST_WREN
3995                     ; 445 			delay_ms(100);
3997  0622 ae0064        	ldw	x,#100
3998  0625 cd005c        	call	_delay_ms
4000  0628               L1312:
4001                     ; 449 		uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
4003  0628 4b00          	push	#0
4004  062a 4b00          	push	#0
4005  062c 3b000f        	push	_current_page
4006  062f b610          	ld	a,_current_page+1
4007  0631 a4ff          	and	a,#255
4008  0633 88            	push	a
4009  0634 4b15          	push	#21
4010  0636 ae0016        	ldw	x,#22
4011  0639 a604          	ld	a,#4
4012  063b 95            	ld	xh,a
4013  063c cd00ce        	call	_uart_out
4015  063f 5b05          	addw	sp,#5
4017  0641 ac5e085e      	jpf	L1771
4018  0645               L7212:
4019                     ; 452 	else if(UIB[1]==21)
4021  0645 c60001        	ld	a,_UIB+1
4022  0648 a115          	cp	a,#21
4023  064a 2703          	jreq	L65
4024  064c cc0741        	jp	L5312
4025  064f               L65:
4026                     ; 457           for(i=0;i<64;i++)
4028  064f 5f            	clrw	x
4029  0650 1f03          	ldw	(OFST-1,sp),x
4030  0652               L7312:
4031                     ; 459           	buff[current_byte_in_buffer+i]=UIB[2+i];
4033  0652 1e03          	ldw	x,(OFST-1,sp)
4034  0654 d60002        	ld	a,(_UIB+2,x)
4035  0657 be0b          	ldw	x,_current_byte_in_buffer
4036  0659 72fb03        	addw	x,(OFST-1,sp)
4037  065c d70050        	ld	(_buff,x),a
4038                     ; 457           for(i=0;i<64;i++)
4040  065f 1e03          	ldw	x,(OFST-1,sp)
4041  0661 1c0001        	addw	x,#1
4042  0664 1f03          	ldw	(OFST-1,sp),x
4045  0666 1e03          	ldw	x,(OFST-1,sp)
4046  0668 a30040        	cpw	x,#64
4047  066b 25e5          	jrult	L7312
4048                     ; 461           current_byte_in_buffer+=64;
4050  066d be0b          	ldw	x,_current_byte_in_buffer
4051  066f 1c0040        	addw	x,#64
4052  0672 bf0b          	ldw	_current_byte_in_buffer,x
4053                     ; 462           if(current_byte_in_buffer>=256)
4055  0674 be0b          	ldw	x,_current_byte_in_buffer
4056  0676 a30100        	cpw	x,#256
4057  0679 2403          	jruge	L06
4058  067b cc085e        	jp	L1771
4059  067e               L06:
4060                     ; 470 			if(memory_manufacturer=='A') {
4062  067e b6bc          	ld	a,_memory_manufacturer
4063  0680 a141          	cp	a,#65
4064  0682 264e          	jrne	L7412
4065                     ; 471 				DF_buffer_write(/*//current_buffer*//*1,*/0,256,buff);
4067  0684 ae0050        	ldw	x,#_buff
4068  0687 89            	pushw	x
4069  0688 ae0100        	ldw	x,#256
4070  068b 89            	pushw	x
4071  068c 5f            	clrw	x
4072  068d cd0b40        	call	_DF_buffer_write
4074  0690 5b04          	addw	sp,#4
4075                     ; 472 				DF_buffer_to_page_er(/*///current_buffer*//*1,*/current_page);
4077  0692 be0f          	ldw	x,_current_page
4078  0694 cd0ad7        	call	_DF_buffer_to_page_er
4080                     ; 473 				current_page++;
4082  0697 be0f          	ldw	x,_current_page
4083  0699 1c0001        	addw	x,#1
4084  069c bf0f          	ldw	_current_page,x
4085                     ; 474 				if(current_page<file_lengt_in_pages)
4087  069e be0f          	ldw	x,_current_page
4088  06a0 b311          	cpw	x,_file_lengt_in_pages
4089  06a2 2424          	jruge	L1512
4090                     ; 476 					delay_ms(100);
4092  06a4 ae0064        	ldw	x,#100
4093  06a7 cd005c        	call	_delay_ms
4095                     ; 477 					uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
4097  06aa 4b00          	push	#0
4098  06ac 4b00          	push	#0
4099  06ae 3b000f        	push	_current_page
4100  06b1 b610          	ld	a,_current_page+1
4101  06b3 a4ff          	and	a,#255
4102  06b5 88            	push	a
4103  06b6 4b15          	push	#21
4104  06b8 ae0016        	ldw	x,#22
4105  06bb a604          	ld	a,#4
4106  06bd 95            	ld	xh,a
4107  06be cd00ce        	call	_uart_out
4109  06c1 5b05          	addw	sp,#5
4110                     ; 478 					current_byte_in_buffer=0;
4112  06c3 5f            	clrw	x
4113  06c4 bf0b          	ldw	_current_byte_in_buffer,x
4115  06c6 200a          	jra	L7412
4116  06c8               L1512:
4117                     ; 482 					EE_PAGE_LEN=current_page;
4119  06c8 be0f          	ldw	x,_current_page
4120  06ca 89            	pushw	x
4121  06cb ae0000        	ldw	x,#_EE_PAGE_LEN
4122  06ce cd0000        	call	c_eewrw
4124  06d1 85            	popw	x
4125  06d2               L7412:
4126                     ; 485 			if(memory_manufacturer=='S') {
4128  06d2 b6bc          	ld	a,_memory_manufacturer
4129  06d4 a153          	cp	a,#83
4130  06d6 2703          	jreq	L26
4131  06d8 cc085e        	jp	L1771
4132  06db               L26:
4133                     ; 486 				ST_WREN();
4135  06db cd0966        	call	_ST_WREN
4137                     ; 487 				delay_ms(100);
4139  06de ae0064        	ldw	x,#100
4140  06e1 cd005c        	call	_delay_ms
4142                     ; 490 				ST_WRITE((unsigned long)(current_page*256UL),256,buff);
4144  06e4 ae0050        	ldw	x,#_buff
4145  06e7 89            	pushw	x
4146  06e8 ae0100        	ldw	x,#256
4147  06eb 89            	pushw	x
4148  06ec be0f          	ldw	x,_current_page
4149  06ee 90ae0100      	ldw	y,#256
4150  06f2 cd0000        	call	c_umul
4152  06f5 be02          	ldw	x,c_lreg+2
4153  06f7 89            	pushw	x
4154  06f8 be00          	ldw	x,c_lreg
4155  06fa 89            	pushw	x
4156  06fb cd09ac        	call	_ST_WRITE
4158  06fe 5b08          	addw	sp,#8
4159                     ; 491 				current_page++;
4161  0700 be0f          	ldw	x,_current_page
4162  0702 1c0001        	addw	x,#1
4163  0705 bf0f          	ldw	_current_page,x
4164                     ; 492 				if(current_page<file_lengt_in_pages)
4166  0707 be0f          	ldw	x,_current_page
4167  0709 b311          	cpw	x,_file_lengt_in_pages
4168  070b 2426          	jruge	L7512
4169                     ; 494 					delay_ms(100);
4171  070d ae0064        	ldw	x,#100
4172  0710 cd005c        	call	_delay_ms
4174                     ; 495 					uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
4176  0713 4b00          	push	#0
4177  0715 4b00          	push	#0
4178  0717 3b000f        	push	_current_page
4179  071a b610          	ld	a,_current_page+1
4180  071c a4ff          	and	a,#255
4181  071e 88            	push	a
4182  071f 4b15          	push	#21
4183  0721 ae0016        	ldw	x,#22
4184  0724 a604          	ld	a,#4
4185  0726 95            	ld	xh,a
4186  0727 cd00ce        	call	_uart_out
4188  072a 5b05          	addw	sp,#5
4189                     ; 496 					current_byte_in_buffer=0;
4191  072c 5f            	clrw	x
4192  072d bf0b          	ldw	_current_byte_in_buffer,x
4194  072f ac5e085e      	jpf	L1771
4195  0733               L7512:
4196                     ; 500 					EE_PAGE_LEN=current_page;
4198  0733 be0f          	ldw	x,_current_page
4199  0735 89            	pushw	x
4200  0736 ae0000        	ldw	x,#_EE_PAGE_LEN
4201  0739 cd0000        	call	c_eewrw
4203  073c 85            	popw	x
4204  073d ac5e085e      	jpf	L1771
4205  0741               L5312:
4206                     ; 512 	else if(UIB[1]==25)
4208  0741 c60001        	ld	a,_UIB+1
4209  0744 a119          	cp	a,#25
4210  0746 2703          	jreq	L46
4211  0748 cc0828        	jp	L5612
4212  074b               L46:
4213                     ; 516 		current_page=0;
4215  074b 5f            	clrw	x
4216  074c bf0f          	ldw	_current_page,x
4217                     ; 518 		for(i__=0;i__<EE_PAGE_LEN;i__++)
4219  074e 5f            	clrw	x
4220  074f 1f03          	ldw	(OFST-1,sp),x
4222  0751 ac1c081c      	jpf	L3712
4223  0755               L7612:
4224                     ; 520 			if(memory_manufacturer=='S') {	
4226  0755 b6bc          	ld	a,_memory_manufacturer
4227  0757 a153          	cp	a,#83
4228  0759 2619          	jrne	L7712
4229                     ; 521 				DF_page_to_buffer(i__);
4231  075b 1e03          	ldw	x,(OFST-1,sp)
4232  075d cd0ab4        	call	_DF_page_to_buffer
4234                     ; 522 				delay_ms(100);			
4236  0760 ae0064        	ldw	x,#100
4237  0763 cd005c        	call	_delay_ms
4239                     ; 523 				DF_buffer_read(0,256, buff);
4241  0766 ae0050        	ldw	x,#_buff
4242  0769 89            	pushw	x
4243  076a ae0100        	ldw	x,#256
4244  076d 89            	pushw	x
4245  076e 5f            	clrw	x
4246  076f cd0afa        	call	_DF_buffer_read
4248  0772 5b04          	addw	sp,#4
4249  0774               L7712:
4250                     ; 526 			if(memory_manufacturer=='S') {	
4252  0774 b6bc          	ld	a,_memory_manufacturer
4253  0776 a153          	cp	a,#83
4254  0778 261a          	jrne	L1022
4255                     ; 527 				ST_READ((long)(i__*256),256, buff);
4257  077a ae0050        	ldw	x,#_buff
4258  077d 89            	pushw	x
4259  077e ae0100        	ldw	x,#256
4260  0781 89            	pushw	x
4261  0782 1e07          	ldw	x,(OFST+3,sp)
4262  0784 4f            	clr	a
4263  0785 02            	rlwa	x,a
4264  0786 cd0000        	call	c_itolx
4266  0789 be02          	ldw	x,c_lreg+2
4267  078b 89            	pushw	x
4268  078c be00          	ldw	x,c_lreg
4269  078e 89            	pushw	x
4270  078f cd09f8        	call	_ST_READ
4272  0792 5b08          	addw	sp,#8
4273  0794               L1022:
4274                     ; 530 			uart_out_adr_block ((256*i__)+0,buff,64);
4276  0794 4b40          	push	#64
4277  0796 ae0050        	ldw	x,#_buff
4278  0799 89            	pushw	x
4279  079a 1e06          	ldw	x,(OFST+2,sp)
4280  079c 4f            	clr	a
4281  079d 02            	rlwa	x,a
4282  079e cd0000        	call	c_itolx
4284  07a1 be02          	ldw	x,c_lreg+2
4285  07a3 89            	pushw	x
4286  07a4 be00          	ldw	x,c_lreg
4287  07a6 89            	pushw	x
4288  07a7 cd0178        	call	_uart_out_adr_block
4290  07aa 5b07          	addw	sp,#7
4291                     ; 531 			delay_ms(100);    
4293  07ac ae0064        	ldw	x,#100
4294  07af cd005c        	call	_delay_ms
4296                     ; 532 			uart_out_adr_block ((256*i__)+64,&buff[64],64);
4298  07b2 4b40          	push	#64
4299  07b4 ae0090        	ldw	x,#_buff+64
4300  07b7 89            	pushw	x
4301  07b8 1e06          	ldw	x,(OFST+2,sp)
4302  07ba 4f            	clr	a
4303  07bb 02            	rlwa	x,a
4304  07bc 1c0040        	addw	x,#64
4305  07bf cd0000        	call	c_itolx
4307  07c2 be02          	ldw	x,c_lreg+2
4308  07c4 89            	pushw	x
4309  07c5 be00          	ldw	x,c_lreg
4310  07c7 89            	pushw	x
4311  07c8 cd0178        	call	_uart_out_adr_block
4313  07cb 5b07          	addw	sp,#7
4314                     ; 533 			delay_ms(100);    
4316  07cd ae0064        	ldw	x,#100
4317  07d0 cd005c        	call	_delay_ms
4319                     ; 534 			uart_out_adr_block ((256*i__)+128,&buff[128],64);
4321  07d3 4b40          	push	#64
4322  07d5 ae00d0        	ldw	x,#_buff+128
4323  07d8 89            	pushw	x
4324  07d9 1e06          	ldw	x,(OFST+2,sp)
4325  07db 4f            	clr	a
4326  07dc 02            	rlwa	x,a
4327  07dd 1c0080        	addw	x,#128
4328  07e0 cd0000        	call	c_itolx
4330  07e3 be02          	ldw	x,c_lreg+2
4331  07e5 89            	pushw	x
4332  07e6 be00          	ldw	x,c_lreg
4333  07e8 89            	pushw	x
4334  07e9 cd0178        	call	_uart_out_adr_block
4336  07ec 5b07          	addw	sp,#7
4337                     ; 535 			delay_ms(100);    
4339  07ee ae0064        	ldw	x,#100
4340  07f1 cd005c        	call	_delay_ms
4342                     ; 536 			uart_out_adr_block ((256*i__)+192,&buff[192],64);
4344  07f4 4b40          	push	#64
4345  07f6 ae0110        	ldw	x,#_buff+192
4346  07f9 89            	pushw	x
4347  07fa 1e06          	ldw	x,(OFST+2,sp)
4348  07fc 4f            	clr	a
4349  07fd 02            	rlwa	x,a
4350  07fe 1c00c0        	addw	x,#192
4351  0801 cd0000        	call	c_itolx
4353  0804 be02          	ldw	x,c_lreg+2
4354  0806 89            	pushw	x
4355  0807 be00          	ldw	x,c_lreg
4356  0809 89            	pushw	x
4357  080a cd0178        	call	_uart_out_adr_block
4359  080d 5b07          	addw	sp,#7
4360                     ; 537 			delay_ms(100);   
4362  080f ae0064        	ldw	x,#100
4363  0812 cd005c        	call	_delay_ms
4365                     ; 518 		for(i__=0;i__<EE_PAGE_LEN;i__++)
4367  0815 1e03          	ldw	x,(OFST-1,sp)
4368  0817 1c0001        	addw	x,#1
4369  081a 1f03          	ldw	(OFST-1,sp),x
4370  081c               L3712:
4373  081c 1e03          	ldw	x,(OFST-1,sp)
4374  081e c30000        	cpw	x,_EE_PAGE_LEN
4375  0821 2403          	jruge	L66
4376  0823 cc0755        	jp	L7612
4377  0826               L66:
4379  0826 2036          	jra	L1771
4380  0828               L5612:
4381                     ; 544 	else if(UIB[1]==55)
4383  0828 c60001        	ld	a,_UIB+1
4384  082b a137          	cp	a,#55
4385  082d 2617          	jrne	L5022
4386                     ; 548 		current_page=0;
4388  082f 5f            	clrw	x
4389  0830 bf0f          	ldw	_current_page,x
4390                     ; 550 		if(memory_manufacturer=='S') {
4392  0832 b6bc          	ld	a,_memory_manufacturer
4393  0834 a153          	cp	a,#83
4394  0836 2626          	jrne	L1771
4395                     ; 551 			ST_WREN();
4397  0838 cd0966        	call	_ST_WREN
4399                     ; 552 			delay_ms(100);		
4401  083b ae0064        	ldw	x,#100
4402  083e cd005c        	call	_delay_ms
4404                     ; 553 			ST_BULK_ERASE();
4406  0841 cd0973        	call	_ST_BULK_ERASE
4408  0844 2018          	jra	L1771
4409  0846               L5022:
4410                     ; 562 	else if(UIB[1]==30)
4412  0846 c60001        	ld	a,_UIB+1
4413  0849 a11e          	cp	a,#30
4414  084b 2606          	jrne	L3122
4415                     ; 584           bSTART=1;
4417  084d 7210000c      	bset	_bSTART
4419  0851 200b          	jra	L1771
4420  0853               L3122:
4421                     ; 596 	else if(UIB[1]==40)
4423  0853 c60001        	ld	a,_UIB+1
4424  0856 a128          	cp	a,#40
4425  0858 2604          	jrne	L1771
4426                     ; 618 		bSTART=1;	
4428  085a 7210000c      	bset	_bSTART
4429  085e               L1771:
4430                     ; 622 }
4433  085e 5b04          	addw	sp,#4
4434  0860 81            	ret
4471                     ; 625 void putchar(char c)
4471                     ; 626 {
4472                     	switch	.text
4473  0861               _putchar:
4475  0861 88            	push	a
4476       00000000      OFST:	set	0
4479  0862               L1422:
4480                     ; 627 while (tx_counter == TX_BUFFER_SIZE);
4482  0862 b620          	ld	a,_tx_counter
4483  0864 a150          	cp	a,#80
4484  0866 27fa          	jreq	L1422
4485                     ; 629 if (tx_counter || ((UART1->SR & UART1_SR_TXE)==0))
4487  0868 3d20          	tnz	_tx_counter
4488  086a 2607          	jrne	L7422
4490  086c c65230        	ld	a,21040
4491  086f a580          	bcp	a,#128
4492  0871 261d          	jrne	L5422
4493  0873               L7422:
4494                     ; 631    tx_buffer[tx_wr_index]=c;
4496  0873 5f            	clrw	x
4497  0874 b61f          	ld	a,_tx_wr_index
4498  0876 2a01          	jrpl	L27
4499  0878 53            	cplw	x
4500  0879               L27:
4501  0879 97            	ld	xl,a
4502  087a 7b01          	ld	a,(OFST+1,sp)
4503  087c e704          	ld	(_tx_buffer,x),a
4504                     ; 632    if (++tx_wr_index == TX_BUFFER_SIZE) tx_wr_index=0;
4506  087e 3c1f          	inc	_tx_wr_index
4507  0880 b61f          	ld	a,_tx_wr_index
4508  0882 a150          	cp	a,#80
4509  0884 2602          	jrne	L1522
4512  0886 3f1f          	clr	_tx_wr_index
4513  0888               L1522:
4514                     ; 633    ++tx_counter;
4516  0888 3c20          	inc	_tx_counter
4518  088a               L3522:
4519                     ; 637 UART1->CR2|= UART1_CR2_TIEN;
4521  088a 721e5235      	bset	21045,#7
4522                     ; 639 }
4525  088e 84            	pop	a
4526  088f 81            	ret
4527  0890               L5422:
4528                     ; 635 else UART1->DR=c;
4530  0890 7b01          	ld	a,(OFST+1,sp)
4531  0892 c75231        	ld	21041,a
4532  0895 20f3          	jra	L3522
4555                     ; 642 void spi_init(void){
4556                     	switch	.text
4557  0897               _spi_init:
4561                     ; 643 	GPIOA->DDR|=(1<<3);
4563  0897 72165002      	bset	20482,#3
4564                     ; 644 	GPIOA->CR1|=(1<<3);
4566  089b 72165003      	bset	20483,#3
4567                     ; 645 	GPIOA->CR2&=~(1<<3);
4569  089f 72175004      	bres	20484,#3
4570                     ; 646 	GPIOA->ODR|=(1<<3);	
4572  08a3 72165000      	bset	20480,#3
4573                     ; 648 	GPIOB->DDR|=(1<<5);
4575  08a7 721a5007      	bset	20487,#5
4576                     ; 649 	GPIOB->CR1|=(1<<5);
4578  08ab 721a5008      	bset	20488,#5
4579                     ; 650 	GPIOB->CR2&=~(1<<5);
4581  08af 721b5009      	bres	20489,#5
4582                     ; 651 	GPIOB->ODR|=(1<<5);	
4584  08b3 721a5005      	bset	20485,#5
4585                     ; 653 	GPIOC->DDR|=(1<<3);
4587  08b7 7216500c      	bset	20492,#3
4588                     ; 654 	GPIOC->CR1|=(1<<3);
4590  08bb 7216500d      	bset	20493,#3
4591                     ; 655 	GPIOC->CR2&=~(1<<3);
4593  08bf 7217500e      	bres	20494,#3
4594                     ; 656 	GPIOC->ODR|=(1<<3);	
4596  08c3 7216500a      	bset	20490,#3
4597                     ; 658 	GPIOC->DDR|=(1<<5);
4599  08c7 721a500c      	bset	20492,#5
4600                     ; 659 	GPIOC->CR1|=(1<<5);
4602  08cb 721a500d      	bset	20493,#5
4603                     ; 660 	GPIOC->CR2|=(1<<5);
4605  08cf 721a500e      	bset	20494,#5
4606                     ; 661 	GPIOC->ODR|=(1<<5);	
4608  08d3 721a500a      	bset	20490,#5
4609                     ; 663 	GPIOC->DDR|=(1<<6);
4611  08d7 721c500c      	bset	20492,#6
4612                     ; 664 	GPIOC->CR1|=(1<<6);
4614  08db 721c500d      	bset	20493,#6
4615                     ; 665 	GPIOC->CR2|=(1<<6);
4617  08df 721c500e      	bset	20494,#6
4618                     ; 666 	GPIOC->ODR|=(1<<6);	
4620  08e3 721c500a      	bset	20490,#6
4621                     ; 668 	GPIOC->DDR&=~(1<<7);
4623  08e7 721f500c      	bres	20492,#7
4624                     ; 669 	GPIOC->CR1&=~(1<<7);
4626  08eb 721f500d      	bres	20493,#7
4627                     ; 670 	GPIOC->CR2&=~(1<<7);
4629  08ef 721f500e      	bres	20494,#7
4630                     ; 671 	GPIOC->ODR|=(1<<7);	
4632  08f3 721e500a      	bset	20490,#7
4633                     ; 673 	SPI->CR1= /*SPI_CR1_LSBFIRST |*/
4633                     ; 674 			SPI_CR1_SPE | 
4633                     ; 675 			( (4<< 3) & SPI_CR1_BR ) |
4633                     ; 676 			SPI_CR1_MSTR |
4633                     ; 677 			SPI_CR1_CPOL |
4633                     ; 678 			SPI_CR1_CPHA; 
4635  08f7 35675200      	mov	20992,#103
4636                     ; 680 	SPI->CR2= SPI_CR2_SSM | SPI_CR2_SSI;
4638  08fb 35035201      	mov	20993,#3
4639                     ; 681 	SPI->ICR= 0;	
4641  08ff 725f5202      	clr	20994
4642                     ; 682 }
4645  0903 81            	ret
4688                     ; 685 char spi(char in){
4689                     	switch	.text
4690  0904               _spi:
4692  0904 88            	push	a
4693  0905 88            	push	a
4694       00000001      OFST:	set	1
4697  0906               L1132:
4698                     ; 687 	while(!((SPI->SR)&SPI_SR_TXE));
4700  0906 c65203        	ld	a,20995
4701  0909 a502          	bcp	a,#2
4702  090b 27f9          	jreq	L1132
4703                     ; 688 	SPI->DR=in;
4705  090d 7b02          	ld	a,(OFST+1,sp)
4706  090f c75204        	ld	20996,a
4708  0912               L1232:
4709                     ; 689 	while(!((SPI->SR)&SPI_SR_RXNE));
4711  0912 c65203        	ld	a,20995
4712  0915 a501          	bcp	a,#1
4713  0917 27f9          	jreq	L1232
4714                     ; 690 	c=SPI->DR;	
4716  0919 c65204        	ld	a,20996
4717  091c 6b01          	ld	(OFST+0,sp),a
4718                     ; 691 	return c;
4720  091e 7b01          	ld	a,(OFST+0,sp)
4723  0920 85            	popw	x
4724  0921 81            	ret
4789                     ; 695 long ST_RDID_read(void)
4789                     ; 696 {
4790                     	switch	.text
4791  0922               _ST_RDID_read:
4793  0922 5204          	subw	sp,#4
4794       00000004      OFST:	set	4
4797                     ; 699 d0=0;
4799  0924 0f04          	clr	(OFST+0,sp)
4800                     ; 700 d1=0;
4802                     ; 701 d2=0;
4804                     ; 702 d3=0;
4806                     ; 704 ST_CS_ON
4808  0926 721b5005      	bres	20485,#5
4809                     ; 705 spi(0x9f);
4811  092a a69f          	ld	a,#159
4812  092c add6          	call	_spi
4814                     ; 706 mdr0=spi(0xff);
4816  092e a6ff          	ld	a,#255
4817  0930 add2          	call	_spi
4819  0932 b716          	ld	_mdr0,a
4820                     ; 707 mdr1=spi(0xff);
4822  0934 a6ff          	ld	a,#255
4823  0936 adcc          	call	_spi
4825  0938 b715          	ld	_mdr1,a
4826                     ; 708 mdr2=spi(0xff);
4828  093a a6ff          	ld	a,#255
4829  093c adc6          	call	_spi
4831  093e b714          	ld	_mdr2,a
4832                     ; 711 ST_CS_OFF
4834  0940 721a5005      	bset	20485,#5
4835                     ; 712 return  *((long*)&d0);
4837  0944 96            	ldw	x,sp
4838  0945 1c0004        	addw	x,#OFST+0
4839  0948 cd0000        	call	c_ltor
4843  094b 5b04          	addw	sp,#4
4844  094d 81            	ret
4879                     ; 716 char ST_status_read(void)
4879                     ; 717 {
4880                     	switch	.text
4881  094e               _ST_status_read:
4883  094e 88            	push	a
4884       00000001      OFST:	set	1
4887                     ; 721 ST_CS_ON
4889  094f 721b5005      	bres	20485,#5
4890                     ; 722 spi(0x05);
4892  0953 a605          	ld	a,#5
4893  0955 adad          	call	_spi
4895                     ; 723 d0=spi(0xff);
4897  0957 a6ff          	ld	a,#255
4898  0959 ada9          	call	_spi
4900  095b 6b01          	ld	(OFST+0,sp),a
4901                     ; 725 ST_CS_OFF
4903  095d 721a5005      	bset	20485,#5
4904                     ; 726 return d0;
4906  0961 7b01          	ld	a,(OFST+0,sp)
4909  0963 5b01          	addw	sp,#1
4910  0965 81            	ret
4934                     ; 730 void ST_WREN(void)
4934                     ; 731 {
4935                     	switch	.text
4936  0966               _ST_WREN:
4940                     ; 733 ST_CS_ON
4942  0966 721b5005      	bres	20485,#5
4943                     ; 734 spi(0x06);
4945  096a a606          	ld	a,#6
4946  096c ad96          	call	_spi
4948                     ; 736 ST_CS_OFF
4950  096e 721a5005      	bset	20485,#5
4951                     ; 737 }  
4954  0972 81            	ret
4978                     ; 740 void ST_BULK_ERASE(void)
4978                     ; 741 {
4979                     	switch	.text
4980  0973               _ST_BULK_ERASE:
4984                     ; 743 ST_CS_ON
4986  0973 721b5005      	bres	20485,#5
4987                     ; 744 spi(0xc7);
4989  0977 a6c7          	ld	a,#199
4990  0979 ad89          	call	_spi
4992                     ; 746 ST_CS_OFF
4994  097b 721a5005      	bset	20485,#5
4995                     ; 747 }  
4998  097f 81            	ret
5060                     ; 750 void ST_PAGE_ERASE(unsigned short page)
5060                     ; 751 {
5061                     	switch	.text
5062  0980               _ST_PAGE_ERASE:
5064  0980 89            	pushw	x
5065  0981 5203          	subw	sp,#3
5066       00000003      OFST:	set	3
5069                     ; 754 ST_CS_ON
5071  0983 721b5005      	bres	20485,#5
5072                     ; 755 spi(0xDB);
5074  0987 a6db          	ld	a,#219
5075  0989 cd0904        	call	_spi
5077                     ; 756 adr2=(char)(page>>8);
5079  098c 7b04          	ld	a,(OFST+1,sp)
5080  098e 6b03          	ld	(OFST+0,sp),a
5081                     ; 757 adr1=(char)(page);
5083  0990 7b05          	ld	a,(OFST+2,sp)
5084  0992 6b02          	ld	(OFST-1,sp),a
5085                     ; 758 adr0=(char)(0);
5087  0994 0f01          	clr	(OFST-2,sp)
5088                     ; 759 spi(adr2);
5090  0996 7b03          	ld	a,(OFST+0,sp)
5091  0998 cd0904        	call	_spi
5093                     ; 760 spi(adr1);
5095  099b 7b02          	ld	a,(OFST-1,sp)
5096  099d cd0904        	call	_spi
5098                     ; 761 spi(adr0);
5100  09a0 7b01          	ld	a,(OFST-2,sp)
5101  09a2 cd0904        	call	_spi
5103                     ; 762 ST_CS_OFF
5105  09a5 721a5005      	bset	20485,#5
5106                     ; 763 }  
5109  09a9 5b05          	addw	sp,#5
5110  09ab 81            	ret
5200                     ; 766 void ST_WRITE(unsigned long memo_addr,unsigned short len, char* adr)
5200                     ; 767 {
5201                     	switch	.text
5202  09ac               _ST_WRITE:
5204  09ac 5205          	subw	sp,#5
5205       00000005      OFST:	set	5
5208                     ; 771 adr2=(char)(memo_addr>>16);
5210  09ae 7b09          	ld	a,(OFST+4,sp)
5211  09b0 6b03          	ld	(OFST-2,sp),a
5212                     ; 772 adr1=(char)((memo_addr>>8)&0x00ff);
5214  09b2 7b0a          	ld	a,(OFST+5,sp)
5215  09b4 a4ff          	and	a,#255
5216  09b6 6b02          	ld	(OFST-3,sp),a
5217                     ; 773 adr0=(char)((memo_addr)&0x00ff);
5219  09b8 7b0b          	ld	a,(OFST+6,sp)
5220  09ba a4ff          	and	a,#255
5221  09bc 6b01          	ld	(OFST-4,sp),a
5222                     ; 774 ST_CS_ON
5224  09be 721b5005      	bres	20485,#5
5225                     ; 775 spi(0x02);
5227  09c2 a602          	ld	a,#2
5228  09c4 cd0904        	call	_spi
5230                     ; 776 spi(adr2);
5232  09c7 7b03          	ld	a,(OFST-2,sp)
5233  09c9 cd0904        	call	_spi
5235                     ; 777 spi(adr1);
5237  09cc 7b02          	ld	a,(OFST-3,sp)
5238  09ce cd0904        	call	_spi
5240                     ; 778 spi(adr0);
5242  09d1 7b01          	ld	a,(OFST-4,sp)
5243  09d3 cd0904        	call	_spi
5245                     ; 780 for(i=0;i<len;i++)
5247  09d6 5f            	clrw	x
5248  09d7 1f04          	ldw	(OFST-1,sp),x
5250  09d9 2010          	jra	L1252
5251  09db               L5152:
5252                     ; 782 	spi(adr[i]);
5254  09db 1e0e          	ldw	x,(OFST+9,sp)
5255  09dd 72fb04        	addw	x,(OFST-1,sp)
5256  09e0 f6            	ld	a,(x)
5257  09e1 cd0904        	call	_spi
5259                     ; 780 for(i=0;i<len;i++)
5261  09e4 1e04          	ldw	x,(OFST-1,sp)
5262  09e6 1c0001        	addw	x,#1
5263  09e9 1f04          	ldw	(OFST-1,sp),x
5264  09eb               L1252:
5267  09eb 1e04          	ldw	x,(OFST-1,sp)
5268  09ed 130c          	cpw	x,(OFST+7,sp)
5269  09ef 25ea          	jrult	L5152
5270                     ; 785 ST_CS_OFF
5272  09f1 721a5005      	bset	20485,#5
5273                     ; 786 }
5276  09f5 5b05          	addw	sp,#5
5277  09f7 81            	ret
5367                     ; 789 void ST_READ(unsigned long memo_addr,unsigned short len, char* adr)
5367                     ; 790 {
5368                     	switch	.text
5369  09f8               _ST_READ:
5371  09f8 5205          	subw	sp,#5
5372       00000005      OFST:	set	5
5375                     ; 796 adr2=(char)(memo_addr>>16);
5377  09fa 7b09          	ld	a,(OFST+4,sp)
5378  09fc 6b03          	ld	(OFST-2,sp),a
5379                     ; 797 adr1=(char)((memo_addr>>8)&0x00ff);
5381  09fe 7b0a          	ld	a,(OFST+5,sp)
5382  0a00 a4ff          	and	a,#255
5383  0a02 6b02          	ld	(OFST-3,sp),a
5384                     ; 798 adr0=(char)((memo_addr)&0x00ff);
5386  0a04 7b0b          	ld	a,(OFST+6,sp)
5387  0a06 a4ff          	and	a,#255
5388  0a08 6b01          	ld	(OFST-4,sp),a
5389                     ; 799 ST_CS_ON
5391  0a0a 721b5005      	bres	20485,#5
5392                     ; 800 spi(0x03);
5394  0a0e a603          	ld	a,#3
5395  0a10 cd0904        	call	_spi
5397                     ; 801 spi(adr2);
5399  0a13 7b03          	ld	a,(OFST-2,sp)
5400  0a15 cd0904        	call	_spi
5402                     ; 802 spi(adr1);
5404  0a18 7b02          	ld	a,(OFST-3,sp)
5405  0a1a cd0904        	call	_spi
5407                     ; 803 spi(adr0);
5409  0a1d 7b01          	ld	a,(OFST-4,sp)
5410  0a1f cd0904        	call	_spi
5412                     ; 805 for(i=0;i<len;i++)
5414  0a22 5f            	clrw	x
5415  0a23 1f04          	ldw	(OFST-1,sp),x
5417  0a25 2012          	jra	L7752
5418  0a27               L3752:
5419                     ; 807 	adr[i]=spi(0xff);
5421  0a27 a6ff          	ld	a,#255
5422  0a29 cd0904        	call	_spi
5424  0a2c 1e0e          	ldw	x,(OFST+9,sp)
5425  0a2e 72fb04        	addw	x,(OFST-1,sp)
5426  0a31 f7            	ld	(x),a
5427                     ; 805 for(i=0;i<len;i++)
5429  0a32 1e04          	ldw	x,(OFST-1,sp)
5430  0a34 1c0001        	addw	x,#1
5431  0a37 1f04          	ldw	(OFST-1,sp),x
5432  0a39               L7752:
5435  0a39 1e04          	ldw	x,(OFST-1,sp)
5436  0a3b 130c          	cpw	x,(OFST+7,sp)
5437  0a3d 25e8          	jrult	L3752
5438                     ; 810 ST_CS_OFF
5440  0a3f 721a5005      	bset	20485,#5
5441                     ; 811 }
5444  0a43 5b05          	addw	sp,#5
5445  0a45 81            	ret
5511                     ; 815 long DF_mf_dev_read(void)
5511                     ; 816 {
5512                     	switch	.text
5513  0a46               _DF_mf_dev_read:
5515  0a46 5204          	subw	sp,#4
5516       00000004      OFST:	set	4
5519                     ; 819 d0=0;
5521  0a48 0f04          	clr	(OFST+0,sp)
5522                     ; 820 d1=0;
5524                     ; 821 d2=0;
5526                     ; 822 d3=0;
5528                     ; 824 CS_ON
5530  0a4a 7217500a      	bres	20490,#3
5531                     ; 825 spi(0x9f);
5533  0a4e a69f          	ld	a,#159
5534  0a50 cd0904        	call	_spi
5536                     ; 826 mdr0=spi(0xff);
5538  0a53 a6ff          	ld	a,#255
5539  0a55 cd0904        	call	_spi
5541  0a58 b716          	ld	_mdr0,a
5542                     ; 827 mdr1=spi(0xff);
5544  0a5a a6ff          	ld	a,#255
5545  0a5c cd0904        	call	_spi
5547  0a5f b715          	ld	_mdr1,a
5548                     ; 828 mdr2=spi(0xff);
5550  0a61 a6ff          	ld	a,#255
5551  0a63 cd0904        	call	_spi
5553  0a66 b714          	ld	_mdr2,a
5554                     ; 829 mdr3=spi(0xff);  
5556  0a68 a6ff          	ld	a,#255
5557  0a6a cd0904        	call	_spi
5559  0a6d b713          	ld	_mdr3,a
5560                     ; 831 CS_OFF
5562  0a6f 7216500a      	bset	20490,#3
5563                     ; 832 return  *((long*)&d0);
5565  0a73 96            	ldw	x,sp
5566  0a74 1c0004        	addw	x,#OFST+0
5567  0a77 cd0000        	call	c_ltor
5571  0a7a 5b04          	addw	sp,#4
5572  0a7c 81            	ret
5596                     ; 836 void DF_memo_to_256(void)
5596                     ; 837 {
5597                     	switch	.text
5598  0a7d               _DF_memo_to_256:
5602                     ; 839 CS_ON
5604  0a7d 7217500a      	bres	20490,#3
5605                     ; 840 spi(0x3d);
5607  0a81 a63d          	ld	a,#61
5608  0a83 cd0904        	call	_spi
5610                     ; 841 spi(0x2a); 
5612  0a86 a62a          	ld	a,#42
5613  0a88 cd0904        	call	_spi
5615                     ; 842 spi(0x80);
5617  0a8b a680          	ld	a,#128
5618  0a8d cd0904        	call	_spi
5620                     ; 843 spi(0xa6);
5622  0a90 a6a6          	ld	a,#166
5623  0a92 cd0904        	call	_spi
5625                     ; 845 CS_OFF
5627  0a95 7216500a      	bset	20490,#3
5628                     ; 846 }  
5631  0a99 81            	ret
5666                     ; 851 char DF_status_read(void)
5666                     ; 852 {
5667                     	switch	.text
5668  0a9a               _DF_status_read:
5670  0a9a 88            	push	a
5671       00000001      OFST:	set	1
5674                     ; 856 CS_ON
5676  0a9b 7217500a      	bres	20490,#3
5677                     ; 857 spi(0xd7);
5679  0a9f a6d7          	ld	a,#215
5680  0aa1 cd0904        	call	_spi
5682                     ; 858 d0=spi(0xff);
5684  0aa4 a6ff          	ld	a,#255
5685  0aa6 cd0904        	call	_spi
5687  0aa9 6b01          	ld	(OFST+0,sp),a
5688                     ; 860 CS_OFF
5690  0aab 7216500a      	bset	20490,#3
5691                     ; 861 return d0;
5693  0aaf 7b01          	ld	a,(OFST+0,sp)
5696  0ab1 5b01          	addw	sp,#1
5697  0ab3 81            	ret
5741                     ; 865 void DF_page_to_buffer(unsigned page_addr)
5741                     ; 866 {
5742                     	switch	.text
5743  0ab4               _DF_page_to_buffer:
5745  0ab4 89            	pushw	x
5746  0ab5 88            	push	a
5747       00000001      OFST:	set	1
5750                     ; 869 d0=0x53; 
5752                     ; 873 CS_ON
5754  0ab6 7217500a      	bres	20490,#3
5755                     ; 874 spi(d0);
5757  0aba a653          	ld	a,#83
5758  0abc cd0904        	call	_spi
5760                     ; 875 spi(page_addr/256/**(((char*)&page_addr)+1)*/);
5762  0abf 7b02          	ld	a,(OFST+1,sp)
5763  0ac1 cd0904        	call	_spi
5765                     ; 876 spi(page_addr%256/**((char*)&page_addr)*/);
5767  0ac4 7b03          	ld	a,(OFST+2,sp)
5768  0ac6 a4ff          	and	a,#255
5769  0ac8 cd0904        	call	_spi
5771                     ; 877 spi(0xff);
5773  0acb a6ff          	ld	a,#255
5774  0acd cd0904        	call	_spi
5776                     ; 879 CS_OFF
5778  0ad0 7216500a      	bset	20490,#3
5779                     ; 880 }
5782  0ad4 5b03          	addw	sp,#3
5783  0ad6 81            	ret
5828                     ; 883 void DF_buffer_to_page_er(/*char buff,*/unsigned page_addr)
5828                     ; 884 {
5829                     	switch	.text
5830  0ad7               _DF_buffer_to_page_er:
5832  0ad7 89            	pushw	x
5833  0ad8 88            	push	a
5834       00000001      OFST:	set	1
5837                     ; 887 d0=0x83; 
5839                     ; 890 CS_ON
5841  0ad9 7217500a      	bres	20490,#3
5842                     ; 891 spi(d0);
5844  0add a683          	ld	a,#131
5845  0adf cd0904        	call	_spi
5847                     ; 892 spi(page_addr/256/**(((char*)&page_addr)+1)*/);
5849  0ae2 7b02          	ld	a,(OFST+1,sp)
5850  0ae4 cd0904        	call	_spi
5852                     ; 893 spi(page_addr%256/**((char*)&page_addr)*/);
5854  0ae7 7b03          	ld	a,(OFST+2,sp)
5855  0ae9 a4ff          	and	a,#255
5856  0aeb cd0904        	call	_spi
5858                     ; 894 spi(0xff);
5860  0aee a6ff          	ld	a,#255
5861  0af0 cd0904        	call	_spi
5863                     ; 896 CS_OFF
5865  0af3 7216500a      	bset	20490,#3
5866                     ; 897 }
5869  0af7 5b03          	addw	sp,#3
5870  0af9 81            	ret
5942                     ; 900 void DF_buffer_read(unsigned buff_addr,unsigned len, char* adr)
5942                     ; 901 {
5943                     	switch	.text
5944  0afa               _DF_buffer_read:
5946  0afa 89            	pushw	x
5947  0afb 5203          	subw	sp,#3
5948       00000003      OFST:	set	3
5951                     ; 905 d0=0x54; 
5953                     ; 907 CS_ON
5955  0afd 7217500a      	bres	20490,#3
5956                     ; 908 spi(d0);
5958  0b01 a654          	ld	a,#84
5959  0b03 cd0904        	call	_spi
5961                     ; 909 spi(0xff);
5963  0b06 a6ff          	ld	a,#255
5964  0b08 cd0904        	call	_spi
5966                     ; 910 spi(buff_addr/256/**(((char*)&buff_addr)+1)*/);
5968  0b0b 7b04          	ld	a,(OFST+1,sp)
5969  0b0d cd0904        	call	_spi
5971                     ; 911 spi(buff_addr%256/**((char*)&buff_addr)*/);
5973  0b10 7b05          	ld	a,(OFST+2,sp)
5974  0b12 a4ff          	and	a,#255
5975  0b14 cd0904        	call	_spi
5977                     ; 912 spi(0xff);
5979  0b17 a6ff          	ld	a,#255
5980  0b19 cd0904        	call	_spi
5982                     ; 913 for(i=0;i<len;i++)
5984  0b1c 5f            	clrw	x
5985  0b1d 1f02          	ldw	(OFST-1,sp),x
5987  0b1f 2012          	jra	L1772
5988  0b21               L5672:
5989                     ; 915 	adr[i]=spi(0xff);
5991  0b21 a6ff          	ld	a,#255
5992  0b23 cd0904        	call	_spi
5994  0b26 1e0a          	ldw	x,(OFST+7,sp)
5995  0b28 72fb02        	addw	x,(OFST-1,sp)
5996  0b2b f7            	ld	(x),a
5997                     ; 913 for(i=0;i<len;i++)
5999  0b2c 1e02          	ldw	x,(OFST-1,sp)
6000  0b2e 1c0001        	addw	x,#1
6001  0b31 1f02          	ldw	(OFST-1,sp),x
6002  0b33               L1772:
6005  0b33 1e02          	ldw	x,(OFST-1,sp)
6006  0b35 1308          	cpw	x,(OFST+5,sp)
6007  0b37 25e8          	jrult	L5672
6008                     ; 918 CS_OFF
6010  0b39 7216500a      	bset	20490,#3
6011                     ; 919 }
6014  0b3d 5b05          	addw	sp,#5
6015  0b3f 81            	ret
6087                     ; 922 void DF_buffer_write(/*char buff,*/unsigned buff_addr,unsigned len, char* adr)
6087                     ; 923 {
6088                     	switch	.text
6089  0b40               _DF_buffer_write:
6091  0b40 89            	pushw	x
6092  0b41 5203          	subw	sp,#3
6093       00000003      OFST:	set	3
6096                     ; 927 d0=0x84; 
6098                     ; 929 CS_ON
6100  0b43 7217500a      	bres	20490,#3
6101                     ; 930 spi(d0);
6103  0b47 a684          	ld	a,#132
6104  0b49 cd0904        	call	_spi
6106                     ; 931 spi(0xff);
6108  0b4c a6ff          	ld	a,#255
6109  0b4e cd0904        	call	_spi
6111                     ; 932 spi(buff_addr/256/**(((char*)&buff_addr)+1)*/);
6113  0b51 7b04          	ld	a,(OFST+1,sp)
6114  0b53 cd0904        	call	_spi
6116                     ; 933 spi(buff_addr%256/**((char*)&buff_addr)*/);
6118  0b56 7b05          	ld	a,(OFST+2,sp)
6119  0b58 a4ff          	and	a,#255
6120  0b5a cd0904        	call	_spi
6122                     ; 935 for(i=0;i<len;i++)
6124  0b5d 5f            	clrw	x
6125  0b5e 1f02          	ldw	(OFST-1,sp),x
6127  0b60 2010          	jra	L7303
6128  0b62               L3303:
6129                     ; 937 	spi(adr[i]);
6131  0b62 1e0a          	ldw	x,(OFST+7,sp)
6132  0b64 72fb02        	addw	x,(OFST-1,sp)
6133  0b67 f6            	ld	a,(x)
6134  0b68 cd0904        	call	_spi
6136                     ; 935 for(i=0;i<len;i++)
6138  0b6b 1e02          	ldw	x,(OFST-1,sp)
6139  0b6d 1c0001        	addw	x,#1
6140  0b70 1f02          	ldw	(OFST-1,sp),x
6141  0b72               L7303:
6144  0b72 1e02          	ldw	x,(OFST-1,sp)
6145  0b74 1308          	cpw	x,(OFST+5,sp)
6146  0b76 25ea          	jrult	L3303
6147                     ; 940 CS_OFF
6149  0b78 7216500a      	bset	20490,#3
6150                     ; 941 }
6153  0b7c 5b05          	addw	sp,#5
6154  0b7e 81            	ret
6177                     ; 963 void gpio_init(void){
6178                     	switch	.text
6179  0b7f               _gpio_init:
6183                     ; 973 	GPIOD->DDR|=(1<<2);
6185  0b7f 72145011      	bset	20497,#2
6186                     ; 974 	GPIOD->CR1|=(1<<2);
6188  0b83 72145012      	bset	20498,#2
6189                     ; 975 	GPIOD->CR2|=(1<<2);
6191  0b87 72145013      	bset	20499,#2
6192                     ; 976 	GPIOD->ODR&=~(1<<2);
6194  0b8b 7215500f      	bres	20495,#2
6195                     ; 978 	GPIOD->DDR|=(1<<4);
6197  0b8f 72185011      	bset	20497,#4
6198                     ; 979 	GPIOD->CR1|=(1<<4);
6200  0b93 72185012      	bset	20498,#4
6201                     ; 980 	GPIOD->CR2&=~(1<<4);
6203  0b97 72195013      	bres	20499,#4
6204                     ; 982 	GPIOC->DDR&=~(1<<4);
6206  0b9b 7219500c      	bres	20492,#4
6207                     ; 983 	GPIOC->CR1&=~(1<<4);
6209  0b9f 7219500d      	bres	20493,#4
6210                     ; 984 	GPIOC->CR2&=~(1<<4);
6212  0ba3 7219500e      	bres	20494,#4
6213                     ; 988 }
6216  0ba7 81            	ret
6268                     ; 991 void uart_in(void)
6268                     ; 992 {
6269                     	switch	.text
6270  0ba8               _uart_in:
6272  0ba8 89            	pushw	x
6273       00000002      OFST:	set	2
6276                     ; 996 if(rx_buffer_overflow)
6278                     	btst	_rx_buffer_overflow
6279  0bae 240d          	jruge	L5703
6280                     ; 998 	rx_wr_index=0;
6282  0bb0 5f            	clrw	x
6283  0bb1 bf1a          	ldw	_rx_wr_index,x
6284                     ; 999 	rx_rd_index=0;
6286  0bb3 5f            	clrw	x
6287  0bb4 bf18          	ldw	_rx_rd_index,x
6288                     ; 1000 	rx_counter=0;
6290  0bb6 5f            	clrw	x
6291  0bb7 bf1c          	ldw	_rx_counter,x
6292                     ; 1001 	rx_buffer_overflow=0;
6294  0bb9 72110001      	bres	_rx_buffer_overflow
6295  0bbd               L5703:
6296                     ; 1004 if(rx_counter&&(rx_buffer[index_offset(rx_wr_index,-1)])==END)
6298  0bbd be1c          	ldw	x,_rx_counter
6299  0bbf 2775          	jreq	L7703
6301  0bc1 aeffff        	ldw	x,#65535
6302  0bc4 89            	pushw	x
6303  0bc5 be1a          	ldw	x,_rx_wr_index
6304  0bc7 ad6f          	call	_index_offset
6306  0bc9 5b02          	addw	sp,#2
6307  0bcb e654          	ld	a,(_rx_buffer,x)
6308  0bcd a10a          	cp	a,#10
6309  0bcf 2665          	jrne	L7703
6310                     ; 1009 	temp=rx_buffer[index_offset(rx_wr_index,-3)];
6312  0bd1 aefffd        	ldw	x,#65533
6313  0bd4 89            	pushw	x
6314  0bd5 be1a          	ldw	x,_rx_wr_index
6315  0bd7 ad5f          	call	_index_offset
6317  0bd9 5b02          	addw	sp,#2
6318  0bdb e654          	ld	a,(_rx_buffer,x)
6319  0bdd 6b01          	ld	(OFST-1,sp),a
6320                     ; 1010     	if(temp<100) 
6322  0bdf 7b01          	ld	a,(OFST-1,sp)
6323  0be1 a164          	cp	a,#100
6324  0be3 2451          	jruge	L7703
6325                     ; 1013     		if(control_check(index_offset(rx_wr_index,-1)))
6327  0be5 aeffff        	ldw	x,#65535
6328  0be8 89            	pushw	x
6329  0be9 be1a          	ldw	x,_rx_wr_index
6330  0beb ad4b          	call	_index_offset
6332  0bed 5b02          	addw	sp,#2
6333  0bef 9f            	ld	a,xl
6334  0bf0 ad6e          	call	_control_check
6336  0bf2 4d            	tnz	a
6337  0bf3 2741          	jreq	L7703
6338                     ; 1016     			rx_rd_index=index_offset(rx_wr_index,-3-temp);
6340  0bf5 a6ff          	ld	a,#255
6341  0bf7 97            	ld	xl,a
6342  0bf8 a6fd          	ld	a,#253
6343  0bfa 1001          	sub	a,(OFST-1,sp)
6344  0bfc 2401          	jrnc	L041
6345  0bfe 5a            	decw	x
6346  0bff               L041:
6347  0bff 02            	rlwa	x,a
6348  0c00 89            	pushw	x
6349  0c01 01            	rrwa	x,a
6350  0c02 be1a          	ldw	x,_rx_wr_index
6351  0c04 ad32          	call	_index_offset
6353  0c06 5b02          	addw	sp,#2
6354  0c08 bf18          	ldw	_rx_rd_index,x
6355                     ; 1017     			for(i=0;i<temp;i++)
6357  0c0a 0f02          	clr	(OFST+0,sp)
6359  0c0c 2018          	jra	L1113
6360  0c0e               L5013:
6361                     ; 1019 				UIB[i]=rx_buffer[index_offset(rx_rd_index,i)];
6363  0c0e 7b02          	ld	a,(OFST+0,sp)
6364  0c10 5f            	clrw	x
6365  0c11 97            	ld	xl,a
6366  0c12 89            	pushw	x
6367  0c13 7b04          	ld	a,(OFST+2,sp)
6368  0c15 5f            	clrw	x
6369  0c16 97            	ld	xl,a
6370  0c17 89            	pushw	x
6371  0c18 be18          	ldw	x,_rx_rd_index
6372  0c1a ad1c          	call	_index_offset
6374  0c1c 5b02          	addw	sp,#2
6375  0c1e e654          	ld	a,(_rx_buffer,x)
6376  0c20 85            	popw	x
6377  0c21 d70000        	ld	(_UIB,x),a
6378                     ; 1017     			for(i=0;i<temp;i++)
6380  0c24 0c02          	inc	(OFST+0,sp)
6381  0c26               L1113:
6384  0c26 7b02          	ld	a,(OFST+0,sp)
6385  0c28 1101          	cp	a,(OFST-1,sp)
6386  0c2a 25e2          	jrult	L5013
6387                     ; 1021 			rx_rd_index=rx_wr_index;
6389  0c2c be1a          	ldw	x,_rx_wr_index
6390  0c2e bf18          	ldw	_rx_rd_index,x
6391                     ; 1022 			rx_counter=0;
6393  0c30 5f            	clrw	x
6394  0c31 bf1c          	ldw	_rx_counter,x
6395                     ; 1032 			uart_in_an();
6397  0c33 cd0238        	call	_uart_in_an
6399  0c36               L7703:
6400                     ; 1041 }
6403  0c36 85            	popw	x
6404  0c37 81            	ret
6447                     ; 1044 signed short index_offset (signed short index,signed short offset)
6447                     ; 1045 {
6448                     	switch	.text
6449  0c38               _index_offset:
6451  0c38 89            	pushw	x
6452       00000000      OFST:	set	0
6455                     ; 1046 index=index+offset;
6457  0c39 1e01          	ldw	x,(OFST+1,sp)
6458  0c3b 72fb05        	addw	x,(OFST+5,sp)
6459  0c3e 1f01          	ldw	(OFST+1,sp),x
6460                     ; 1047 if(index>=RX_BUFFER_SIZE) index-=RX_BUFFER_SIZE; 
6462  0c40 9c            	rvf
6463  0c41 1e01          	ldw	x,(OFST+1,sp)
6464  0c43 a30064        	cpw	x,#100
6465  0c46 2f07          	jrslt	L7313
6468  0c48 1e01          	ldw	x,(OFST+1,sp)
6469  0c4a 1d0064        	subw	x,#100
6470  0c4d 1f01          	ldw	(OFST+1,sp),x
6471  0c4f               L7313:
6472                     ; 1048 if(index<0) index+=RX_BUFFER_SIZE;
6474  0c4f 9c            	rvf
6475  0c50 1e01          	ldw	x,(OFST+1,sp)
6476  0c52 2e07          	jrsge	L1413
6479  0c54 1e01          	ldw	x,(OFST+1,sp)
6480  0c56 1c0064        	addw	x,#100
6481  0c59 1f01          	ldw	(OFST+1,sp),x
6482  0c5b               L1413:
6483                     ; 1049 return index;
6485  0c5b 1e01          	ldw	x,(OFST+1,sp)
6488  0c5d 5b02          	addw	sp,#2
6489  0c5f 81            	ret
6552                     ; 1053 char control_check(char index)
6552                     ; 1054 {
6553                     	switch	.text
6554  0c60               _control_check:
6556  0c60 88            	push	a
6557  0c61 5203          	subw	sp,#3
6558       00000003      OFST:	set	3
6561                     ; 1055 char i=0,ii=0,iii;
6565                     ; 1057 if(rx_buffer[index]!=END) return 0;
6567  0c63 5f            	clrw	x
6568  0c64 97            	ld	xl,a
6569  0c65 e654          	ld	a,(_rx_buffer,x)
6570  0c67 a10a          	cp	a,#10
6571  0c69 2703          	jreq	L5713
6574  0c6b 4f            	clr	a
6576  0c6c 2051          	jra	L251
6577  0c6e               L5713:
6578                     ; 1059 ii=rx_buffer[index_offset(index,-2)];
6580  0c6e aefffe        	ldw	x,#65534
6581  0c71 89            	pushw	x
6582  0c72 7b06          	ld	a,(OFST+3,sp)
6583  0c74 5f            	clrw	x
6584  0c75 97            	ld	xl,a
6585  0c76 adc0          	call	_index_offset
6587  0c78 5b02          	addw	sp,#2
6588  0c7a e654          	ld	a,(_rx_buffer,x)
6589  0c7c 6b02          	ld	(OFST-1,sp),a
6590                     ; 1060 iii=0;
6592  0c7e 0f01          	clr	(OFST-2,sp)
6593                     ; 1061 for(i=0;i<=ii;i++)
6595  0c80 0f03          	clr	(OFST+0,sp)
6597  0c82 2022          	jra	L3023
6598  0c84               L7713:
6599                     ; 1063 	iii^=rx_buffer[index_offset(index,-2-ii+i)];
6601  0c84 a6ff          	ld	a,#255
6602  0c86 97            	ld	xl,a
6603  0c87 a6fe          	ld	a,#254
6604  0c89 1002          	sub	a,(OFST-1,sp)
6605  0c8b 2401          	jrnc	L641
6606  0c8d 5a            	decw	x
6607  0c8e               L641:
6608  0c8e 1b03          	add	a,(OFST+0,sp)
6609  0c90 2401          	jrnc	L051
6610  0c92 5c            	incw	x
6611  0c93               L051:
6612  0c93 02            	rlwa	x,a
6613  0c94 89            	pushw	x
6614  0c95 01            	rrwa	x,a
6615  0c96 7b06          	ld	a,(OFST+3,sp)
6616  0c98 5f            	clrw	x
6617  0c99 97            	ld	xl,a
6618  0c9a ad9c          	call	_index_offset
6620  0c9c 5b02          	addw	sp,#2
6621  0c9e 7b01          	ld	a,(OFST-2,sp)
6622  0ca0 e854          	xor	a,	(_rx_buffer,x)
6623  0ca2 6b01          	ld	(OFST-2,sp),a
6624                     ; 1061 for(i=0;i<=ii;i++)
6626  0ca4 0c03          	inc	(OFST+0,sp)
6627  0ca6               L3023:
6630  0ca6 7b03          	ld	a,(OFST+0,sp)
6631  0ca8 1102          	cp	a,(OFST-1,sp)
6632  0caa 23d8          	jrule	L7713
6633                     ; 1065 if (iii!=rx_buffer[index_offset(index,-1)]) return 0;	
6635  0cac aeffff        	ldw	x,#65535
6636  0caf 89            	pushw	x
6637  0cb0 7b06          	ld	a,(OFST+3,sp)
6638  0cb2 5f            	clrw	x
6639  0cb3 97            	ld	xl,a
6640  0cb4 ad82          	call	_index_offset
6642  0cb6 5b02          	addw	sp,#2
6643  0cb8 e654          	ld	a,(_rx_buffer,x)
6644  0cba 1101          	cp	a,(OFST-2,sp)
6645  0cbc 2704          	jreq	L7023
6648  0cbe 4f            	clr	a
6650  0cbf               L251:
6652  0cbf 5b04          	addw	sp,#4
6653  0cc1 81            	ret
6654  0cc2               L7023:
6655                     ; 1067 return 1;
6657  0cc2 a601          	ld	a,#1
6659  0cc4 20f9          	jra	L251
6701                     ; 1076 @far @interrupt void TIM4_UPD_Interrupt (void) {
6703                     	switch	.text
6704  0cc6               f_TIM4_UPD_Interrupt:
6708                     ; 1078 	if(play) {
6710                     	btst	_play
6711  0ccb 2445          	jruge	L1223
6712                     ; 1079 		TIM2->CCR3H= 0x00;	
6714  0ccd 725f5315      	clr	21269
6715                     ; 1080 		TIM2->CCR3L= sample;
6717  0cd1 5500175316    	mov	21270,_sample
6718                     ; 1081 		sample_cnt++;
6720  0cd6 be21          	ldw	x,_sample_cnt
6721  0cd8 1c0001        	addw	x,#1
6722  0cdb bf21          	ldw	_sample_cnt,x
6723                     ; 1082 		if(sample_cnt>=256) {
6725  0cdd 9c            	rvf
6726  0cde be21          	ldw	x,_sample_cnt
6727  0ce0 a30100        	cpw	x,#256
6728  0ce3 2f03          	jrslt	L3223
6729                     ; 1083 			sample_cnt=0;
6731  0ce5 5f            	clrw	x
6732  0ce6 bf21          	ldw	_sample_cnt,x
6733  0ce8               L3223:
6734                     ; 1087 		sample=buff[sample_cnt];
6736  0ce8 be21          	ldw	x,_sample_cnt
6737  0cea d60050        	ld	a,(_buff,x)
6738  0ced b717          	ld	_sample,a
6739                     ; 1089 		if(sample_cnt==132)	{
6741  0cef be21          	ldw	x,_sample_cnt
6742  0cf1 a30084        	cpw	x,#132
6743  0cf4 2604          	jrne	L5223
6744                     ; 1090 			bBUFF_LOAD=1;
6746  0cf6 7210000b      	bset	_bBUFF_LOAD
6747  0cfa               L5223:
6748                     ; 1094 		if(sample_cnt==5) {
6750  0cfa be21          	ldw	x,_sample_cnt
6751  0cfc a30005        	cpw	x,#5
6752  0cff 2604          	jrne	L7223
6753                     ; 1095 			bBUFF_READ_H=1;
6755  0d01 7210000a      	bset	_bBUFF_READ_H
6756  0d05               L7223:
6757                     ; 1098 		if(sample_cnt==150) {
6759  0d05 be21          	ldw	x,_sample_cnt
6760  0d07 a30096        	cpw	x,#150
6761  0d0a 2615          	jrne	L3323
6762                     ; 1099 			bBUFF_READ_L=1;
6764  0d0c 72100009      	bset	_bBUFF_READ_L
6765  0d10 200f          	jra	L3323
6766  0d12               L1223:
6767                     ; 1106 	else if(!bSTART) {
6769                     	btst	_bSTART
6770  0d17 2508          	jrult	L3323
6771                     ; 1107 		TIM2->CCR3H= 0x00;	
6773  0d19 725f5315      	clr	21269
6774                     ; 1108 		TIM2->CCR3L= 0x7f;//pwm_fade_in;
6776  0d1d 357f5316      	mov	21270,#127
6777  0d21               L3323:
6778                     ; 1165 		if(but_block_cnt)but_on_drv_cnt=0;
6780  0d21 be00          	ldw	x,_but_block_cnt
6781  0d23 2702          	jreq	L7323
6784  0d25 3fb9          	clr	_but_on_drv_cnt
6785  0d27               L7323:
6786                     ; 1166 		if((((GPIOC->IDR)&(1<<4))) && (but_on_drv_cnt<100)) {
6788  0d27 c6500b        	ld	a,20491
6789  0d2a a510          	bcp	a,#16
6790  0d2c 271f          	jreq	L1423
6792  0d2e b6b9          	ld	a,_but_on_drv_cnt
6793  0d30 a164          	cp	a,#100
6794  0d32 2419          	jruge	L1423
6795                     ; 1167 			but_on_drv_cnt++;
6797  0d34 3cb9          	inc	_but_on_drv_cnt
6798                     ; 1168 			if((but_on_drv_cnt>2)&&(bRELEASE))
6800  0d36 b6b9          	ld	a,_but_on_drv_cnt
6801  0d38 a103          	cp	a,#3
6802  0d3a 2517          	jrult	L5423
6804                     	btst	_bRELEASE
6805  0d41 2410          	jruge	L5423
6806                     ; 1170 				bRELEASE=0;
6808  0d43 72110000      	bres	_bRELEASE
6809                     ; 1171 				bSTART=1;
6811  0d47 7210000c      	bset	_bSTART
6812  0d4b 2006          	jra	L5423
6813  0d4d               L1423:
6814                     ; 1175 			but_on_drv_cnt=0;
6816  0d4d 3fb9          	clr	_but_on_drv_cnt
6817                     ; 1176 			bRELEASE=1;
6819  0d4f 72100000      	bset	_bRELEASE
6820  0d53               L5423:
6821                     ; 1181 	if(++t0_cnt0>=125){
6823  0d53 3c00          	inc	_t0_cnt0
6824  0d55 b600          	ld	a,_t0_cnt0
6825  0d57 a17d          	cp	a,#125
6826  0d59 2530          	jrult	L7423
6827                     ; 1182     		t0_cnt0=0;
6829  0d5b 3f00          	clr	_t0_cnt0
6830                     ; 1183     		b100Hz=1;
6832  0d5d 72100008      	bset	_b100Hz
6833                     ; 1189 		if(++t0_cnt1>=10){
6835  0d61 3c01          	inc	_t0_cnt1
6836  0d63 b601          	ld	a,_t0_cnt1
6837  0d65 a10a          	cp	a,#10
6838  0d67 2506          	jrult	L1523
6839                     ; 1190 			t0_cnt1=0;
6841  0d69 3f01          	clr	_t0_cnt1
6842                     ; 1191 			b10Hz=1;
6844  0d6b 72100007      	bset	_b10Hz
6845  0d6f               L1523:
6846                     ; 1194 		if(++t0_cnt2>=20){
6848  0d6f 3c02          	inc	_t0_cnt2
6849  0d71 b602          	ld	a,_t0_cnt2
6850  0d73 a114          	cp	a,#20
6851  0d75 2506          	jrult	L3523
6852                     ; 1195 			t0_cnt2=0;
6854  0d77 3f02          	clr	_t0_cnt2
6855                     ; 1196 			b5Hz=1;
6857  0d79 72100006      	bset	_b5Hz
6858  0d7d               L3523:
6859                     ; 1199 		if(++t0_cnt3>=100){
6861  0d7d 3c03          	inc	_t0_cnt3
6862  0d7f b603          	ld	a,_t0_cnt3
6863  0d81 a164          	cp	a,#100
6864  0d83 2506          	jrult	L7423
6865                     ; 1200 			t0_cnt3=0;
6867  0d85 3f03          	clr	_t0_cnt3
6868                     ; 1201 			b1Hz=1;
6870  0d87 72100005      	bset	_b1Hz
6871  0d8b               L7423:
6872                     ; 1205 	TIM4->SR1&=~TIM4_SR1_UIF;			// disable break interrupt
6874  0d8b 72115344      	bres	21316,#0
6875                     ; 1206 	return;
6878  0d8f 80            	iret
6904                     ; 1210 @far @interrupt void UARTTxInterrupt (void) {
6905                     	switch	.text
6906  0d90               f_UARTTxInterrupt:
6910                     ; 1212 	if (tx_counter){
6912  0d90 3d20          	tnz	_tx_counter
6913  0d92 271a          	jreq	L7623
6914                     ; 1213 		--tx_counter;
6916  0d94 3a20          	dec	_tx_counter
6917                     ; 1214 		UART1->DR=tx_buffer[tx_rd_index];
6919  0d96 5f            	clrw	x
6920  0d97 b61e          	ld	a,_tx_rd_index
6921  0d99 2a01          	jrpl	L061
6922  0d9b 53            	cplw	x
6923  0d9c               L061:
6924  0d9c 97            	ld	xl,a
6925  0d9d e604          	ld	a,(_tx_buffer,x)
6926  0d9f c75231        	ld	21041,a
6927                     ; 1215 		if (++tx_rd_index == TX_BUFFER_SIZE) tx_rd_index=0;
6929  0da2 3c1e          	inc	_tx_rd_index
6930  0da4 b61e          	ld	a,_tx_rd_index
6931  0da6 a150          	cp	a,#80
6932  0da8 260c          	jrne	L3723
6935  0daa 3f1e          	clr	_tx_rd_index
6936  0dac 2008          	jra	L3723
6937  0dae               L7623:
6938                     ; 1218 		bOUT_FREE=1;
6940  0dae 72100003      	bset	_bOUT_FREE
6941                     ; 1219 		UART1->CR2&= ~UART1_CR2_TIEN;
6943  0db2 721f5235      	bres	21045,#7
6944  0db6               L3723:
6945                     ; 1221 }
6948  0db6 80            	iret
6977                     ; 1224 @far @interrupt void UARTRxInterrupt (void) {
6978                     	switch	.text
6979  0db7               f_UARTRxInterrupt:
6983                     ; 1229 	rx_status=UART1->SR;
6985  0db7 5552300006    	mov	_rx_status,21040
6986                     ; 1230 	rx_data=UART1->DR;
6988  0dbc 5552310005    	mov	_rx_data,21041
6989                     ; 1232 	if (rx_status & (UART1_SR_RXNE)){
6991  0dc1 b606          	ld	a,_rx_status
6992  0dc3 a520          	bcp	a,#32
6993  0dc5 272c          	jreq	L5033
6994                     ; 1233 		rx_buffer[rx_wr_index]=rx_data;
6996  0dc7 be1a          	ldw	x,_rx_wr_index
6997  0dc9 b605          	ld	a,_rx_data
6998  0dcb e754          	ld	(_rx_buffer,x),a
6999                     ; 1234 		bRXIN=1;
7001  0dcd 72100002      	bset	_bRXIN
7002                     ; 1235 		if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
7004  0dd1 be1a          	ldw	x,_rx_wr_index
7005  0dd3 1c0001        	addw	x,#1
7006  0dd6 bf1a          	ldw	_rx_wr_index,x
7007  0dd8 a30064        	cpw	x,#100
7008  0ddb 2603          	jrne	L7033
7011  0ddd 5f            	clrw	x
7012  0dde bf1a          	ldw	_rx_wr_index,x
7013  0de0               L7033:
7014                     ; 1236 		if (++rx_counter == RX_BUFFER_SIZE){
7016  0de0 be1c          	ldw	x,_rx_counter
7017  0de2 1c0001        	addw	x,#1
7018  0de5 bf1c          	ldw	_rx_counter,x
7019  0de7 a30064        	cpw	x,#100
7020  0dea 2607          	jrne	L5033
7021                     ; 1237 			rx_counter=0;
7023  0dec 5f            	clrw	x
7024  0ded bf1c          	ldw	_rx_counter,x
7025                     ; 1238 			rx_buffer_overflow=1;
7027  0def 72100001      	bset	_rx_buffer_overflow
7028  0df3               L5033:
7029                     ; 1241 }
7032  0df3 80            	iret
7091                     ; 1247 main(){
7093                     	switch	.text
7094  0df4               _main:
7098                     ; 1248 	CLK->CKDIVR=0;
7100  0df4 725f50c6      	clr	20678
7101                     ; 1250 	rele_cnt_index=0;
7103  0df8 3fbb          	clr	_rele_cnt_index
7104                     ; 1251 	GPIOD->DDR&=~(1<<6);
7106  0dfa 721d5011      	bres	20497,#6
7107                     ; 1252 	GPIOD->CR1|=(1<<6);
7109  0dfe 721c5012      	bset	20498,#6
7110                     ; 1253 	GPIOD->CR2|=(1<<6);
7112  0e02 721c5013      	bset	20499,#6
7113                     ; 1255 	GPIOD->DDR|=(1<<5);
7115  0e06 721a5011      	bset	20497,#5
7116                     ; 1256 	GPIOD->CR1|=(1<<5);
7118  0e0a 721a5012      	bset	20498,#5
7119                     ; 1257 	GPIOD->CR2|=(1<<5);	
7121  0e0e 721a5013      	bset	20499,#5
7122                     ; 1258 	GPIOD->ODR|=(1<<5);
7124  0e12 721a500f      	bset	20495,#5
7125                     ; 1260 	delay_ms(10);
7127  0e16 ae000a        	ldw	x,#10
7128  0e19 cd005c        	call	_delay_ms
7130                     ; 1262 	if(!(GPIOD->IDR&=(1<<6))) {
7132  0e1c c65010        	ld	a,20496
7133  0e1f a440          	and	a,#64
7134  0e21 c75010        	ld	20496,a
7135  0e24 2606          	jrne	L3233
7136                     ; 1263 		rele_cnt_index=1;
7138  0e26 350100bb      	mov	_rele_cnt_index,#1
7140  0e2a 2018          	jra	L5233
7141  0e2c               L3233:
7142                     ; 1266 		GPIOD->ODR&=~(1<<5);
7144  0e2c 721b500f      	bres	20495,#5
7145                     ; 1267 		delay_ms(10);
7147  0e30 ae000a        	ldw	x,#10
7148  0e33 cd005c        	call	_delay_ms
7150                     ; 1268 		if(!(GPIOD->IDR&=(1<<6))) {
7152  0e36 c65010        	ld	a,20496
7153  0e39 a440          	and	a,#64
7154  0e3b c75010        	ld	20496,a
7155  0e3e 2604          	jrne	L5233
7156                     ; 1269 			rele_cnt_index=2;
7158  0e40 350200bb      	mov	_rele_cnt_index,#2
7159  0e44               L5233:
7160                     ; 1274 	gpio_init();
7162  0e44 cd0b7f        	call	_gpio_init
7164                     ; 1275 	delay_ms(100);
7166  0e47 ae0064        	ldw	x,#100
7167  0e4a cd005c        	call	_delay_ms
7169                     ; 1276 	delay_ms(100);
7171  0e4d ae0064        	ldw	x,#100
7172  0e50 cd005c        	call	_delay_ms
7174                     ; 1277 	delay_ms(100);
7176  0e53 ae0064        	ldw	x,#100
7177  0e56 cd005c        	call	_delay_ms
7179                     ; 1280 	t4_init();
7181  0e59 cd0039        	call	_t4_init
7183                     ; 1282 	t2_init();
7185  0e5c cd0000        	call	_t2_init
7187                     ; 1283 	spi_init();
7189  0e5f cd0897        	call	_spi_init
7191                     ; 1285 	FLASH_DUKR=0xae;
7193  0e62 35ae5064      	mov	_FLASH_DUKR,#174
7194                     ; 1286 	FLASH_DUKR=0x56;
7196  0e66 35565064      	mov	_FLASH_DUKR,#86
7197                     ; 1291 	dumm[1]++;
7199  0e6a 725c017d      	inc	_dumm+1
7200                     ; 1293 	uart_init();
7202  0e6e cd009e        	call	_uart_init
7204                     ; 1296 	DF_mf_dev_read();
7206  0e71 cd0a46        	call	_DF_mf_dev_read
7208                     ; 1297 	if(mdr0==0x1F) memory_manufacturer='A';
7210  0e74 b616          	ld	a,_mdr0
7211  0e76 a11f          	cp	a,#31
7212  0e78 2606          	jrne	L1333
7215  0e7a 354100bc      	mov	_memory_manufacturer,#65
7217  0e7e 200d          	jra	L3333
7218  0e80               L1333:
7219                     ; 1300 		ST_RDID_read();
7221  0e80 cd0922        	call	_ST_RDID_read
7223                     ; 1301 		if(mdr0==0x20) memory_manufacturer='S';
7225  0e83 b616          	ld	a,_mdr0
7226  0e85 a120          	cp	a,#32
7227  0e87 2604          	jrne	L3333
7230  0e89 355300bc      	mov	_memory_manufacturer,#83
7231  0e8d               L3333:
7232                     ; 1306 	enableInterrupts();	
7235  0e8d 9a            rim
7237  0e8e               L7333:
7238                     ; 1310 		if(bBUFF_LOAD) {
7240                     	btst	_bBUFF_LOAD
7241  0e93 2425          	jruge	L3433
7242                     ; 1311 			bBUFF_LOAD=0;
7244  0e95 7211000b      	bres	_bBUFF_LOAD
7245                     ; 1313 			if(current_page<last_page) {
7247  0e99 be0f          	ldw	x,_current_page
7248  0e9b b30d          	cpw	x,_last_page
7249  0e9d 2409          	jruge	L5433
7250                     ; 1314 				current_page++;
7252  0e9f be0f          	ldw	x,_current_page
7253  0ea1 1c0001        	addw	x,#1
7254  0ea4 bf0f          	ldw	_current_page,x
7256  0ea6 2007          	jra	L7433
7257  0ea8               L5433:
7258                     ; 1318 				current_page=0;
7260  0ea8 5f            	clrw	x
7261  0ea9 bf0f          	ldw	_current_page,x
7262                     ; 1319 				play=0;
7264  0eab 72110004      	bres	_play
7265  0eaf               L7433:
7266                     ; 1321 			if(memory_manufacturer=='A') {
7268  0eaf b6bc          	ld	a,_memory_manufacturer
7269  0eb1 a141          	cp	a,#65
7270  0eb3 2605          	jrne	L3433
7271                     ; 1322 				DF_page_to_buffer(/*///current_buffer_H*//*1,*/current_page);
7273  0eb5 be0f          	ldw	x,_current_page
7274  0eb7 cd0ab4        	call	_DF_page_to_buffer
7276  0eba               L3433:
7277                     ; 1326 		if(bBUFF_READ_L) {
7279                     	btst	_bBUFF_READ_L
7280  0ebf 243a          	jruge	L3533
7281                     ; 1327 			bBUFF_READ_L=0;
7283  0ec1 72110009      	bres	_bBUFF_READ_L
7284                     ; 1328 			if(memory_manufacturer=='A') {
7286  0ec5 b6bc          	ld	a,_memory_manufacturer
7287  0ec7 a141          	cp	a,#65
7288  0ec9 260e          	jrne	L5533
7289                     ; 1329 				DF_buffer_read(/*///current_buffer_L*//*1,*/0,128,buff);
7291  0ecb ae0050        	ldw	x,#_buff
7292  0ece 89            	pushw	x
7293  0ecf ae0080        	ldw	x,#128
7294  0ed2 89            	pushw	x
7295  0ed3 5f            	clrw	x
7296  0ed4 cd0afa        	call	_DF_buffer_read
7298  0ed7 5b04          	addw	sp,#4
7299  0ed9               L5533:
7300                     ; 1331 			if(memory_manufacturer=='S') {
7302  0ed9 b6bc          	ld	a,_memory_manufacturer
7303  0edb a153          	cp	a,#83
7304  0edd 261c          	jrne	L3533
7305                     ; 1332 				ST_READ((unsigned long)((unsigned long)(current_page*256UL)),128,buff);
7307  0edf ae0050        	ldw	x,#_buff
7308  0ee2 89            	pushw	x
7309  0ee3 ae0080        	ldw	x,#128
7310  0ee6 89            	pushw	x
7311  0ee7 be0f          	ldw	x,_current_page
7312  0ee9 90ae0100      	ldw	y,#256
7313  0eed cd0000        	call	c_umul
7315  0ef0 be02          	ldw	x,c_lreg+2
7316  0ef2 89            	pushw	x
7317  0ef3 be00          	ldw	x,c_lreg
7318  0ef5 89            	pushw	x
7319  0ef6 cd09f8        	call	_ST_READ
7321  0ef9 5b08          	addw	sp,#8
7322  0efb               L3533:
7323                     ; 1336 		if(bBUFF_READ_H) {
7325                     	btst	_bBUFF_READ_H
7326  0f00 2441          	jruge	L1633
7327                     ; 1337 			bBUFF_READ_H=0;
7329  0f02 7211000a      	bres	_bBUFF_READ_H
7330                     ; 1338 			if(memory_manufacturer=='A') {
7332  0f06 b6bc          	ld	a,_memory_manufacturer
7333  0f08 a141          	cp	a,#65
7334  0f0a 2610          	jrne	L3633
7335                     ; 1339 				DF_buffer_read(/*///current_buffer_L*//*1,*/128,128,&buff[128]);
7337  0f0c ae00d0        	ldw	x,#_buff+128
7338  0f0f 89            	pushw	x
7339  0f10 ae0080        	ldw	x,#128
7340  0f13 89            	pushw	x
7341  0f14 ae0080        	ldw	x,#128
7342  0f17 cd0afa        	call	_DF_buffer_read
7344  0f1a 5b04          	addw	sp,#4
7345  0f1c               L3633:
7346                     ; 1341 			if(memory_manufacturer=='S') {
7348  0f1c b6bc          	ld	a,_memory_manufacturer
7349  0f1e a153          	cp	a,#83
7350  0f20 2621          	jrne	L1633
7351                     ; 1342 				ST_READ((unsigned long)((unsigned long)(current_page*256UL)+128UL),128,&buff[128]);
7353  0f22 ae00d0        	ldw	x,#_buff+128
7354  0f25 89            	pushw	x
7355  0f26 ae0080        	ldw	x,#128
7356  0f29 89            	pushw	x
7357  0f2a be0f          	ldw	x,_current_page
7358  0f2c 90ae0100      	ldw	y,#256
7359  0f30 cd0000        	call	c_umul
7361  0f33 a680          	ld	a,#128
7362  0f35 cd0000        	call	c_ladc
7364  0f38 be02          	ldw	x,c_lreg+2
7365  0f3a 89            	pushw	x
7366  0f3b be00          	ldw	x,c_lreg
7367  0f3d 89            	pushw	x
7368  0f3e cd09f8        	call	_ST_READ
7370  0f41 5b08          	addw	sp,#8
7371  0f43               L1633:
7372                     ; 1346 		if(bRXIN)	{
7374                     	btst	_bRXIN
7375  0f48 2407          	jruge	L7633
7376                     ; 1347 			bRXIN=0;
7378  0f4a 72110002      	bres	_bRXIN
7379                     ; 1349 			uart_in();
7381  0f4e cd0ba8        	call	_uart_in
7383  0f51               L7633:
7384                     ; 1353 		if(b100Hz){
7386                     	btst	_b100Hz
7387  0f56 2503          	jrult	L661
7388  0f58 cc1007        	jp	L1733
7389  0f5b               L661:
7390                     ; 1354 			b100Hz=0;
7392  0f5b 72110008      	bres	_b100Hz
7393                     ; 1356 			if(but_block_cnt)but_block_cnt--;
7395  0f5f be00          	ldw	x,_but_block_cnt
7396  0f61 2707          	jreq	L3733
7399  0f63 be00          	ldw	x,_but_block_cnt
7400  0f65 1d0001        	subw	x,#1
7401  0f68 bf00          	ldw	_but_block_cnt,x
7402  0f6a               L3733:
7403                     ; 1358 			if(bSTART==1) {
7405                     	btst	_bSTART
7406  0f6f 24e7          	jruge	L1733
7407                     ; 1359 				if(play) {
7409                     	btst	_play
7410  0f76 2417          	jruge	L7733
7411                     ; 1361 				if(!but_block_cnt){
7413  0f78 be00          	ldw	x,_but_block_cnt
7414  0f7a 260d          	jrne	L1043
7415                     ; 1362 					play=0;
7417  0f7c 72110004      	bres	_play
7418                     ; 1363 					bSTART=0;
7420  0f80 7211000c      	bres	_bSTART
7421                     ; 1364 					but_block_cnt=50;
7423  0f84 ae0032        	ldw	x,#50
7424  0f87 bf00          	ldw	_but_block_cnt,x
7425  0f89               L1043:
7426                     ; 1367 				bSTART=0;
7428  0f89 7211000c      	bres	_bSTART
7430  0f8d 2078          	jra	L1733
7431  0f8f               L7733:
7432                     ; 1371 				if(!but_block_cnt)
7434  0f8f be00          	ldw	x,_but_block_cnt
7435  0f91 2674          	jrne	L1733
7436                     ; 1374 					current_page=1;
7438  0f93 ae0001        	ldw	x,#1
7439  0f96 bf0f          	ldw	_current_page,x
7440                     ; 1376 					last_page=EE_PAGE_LEN-1;//6000;
7442  0f98 ce0000        	ldw	x,_EE_PAGE_LEN
7443  0f9b 5a            	decw	x
7444  0f9c bf0d          	ldw	_last_page,x
7445                     ; 1381 					if(memory_manufacturer=='A') {
7447  0f9e b6bc          	ld	a,_memory_manufacturer
7448  0fa0 a141          	cp	a,#65
7449  0fa2 2630          	jrne	L7043
7450                     ; 1382 						DF_page_to_buffer(/*///current_buffer_H*//*1,*/current_page);
7452  0fa4 ae0001        	ldw	x,#1
7453  0fa7 cd0ab4        	call	_DF_page_to_buffer
7455                     ; 1383 						delay_ms(10);
7457  0faa ae000a        	ldw	x,#10
7458  0fad cd005c        	call	_delay_ms
7460                     ; 1384 						DF_buffer_read(/*///current_buffer_L*//*1,*/0,128,buff);
7462  0fb0 ae0050        	ldw	x,#_buff
7463  0fb3 89            	pushw	x
7464  0fb4 ae0080        	ldw	x,#128
7465  0fb7 89            	pushw	x
7466  0fb8 5f            	clrw	x
7467  0fb9 cd0afa        	call	_DF_buffer_read
7469  0fbc 5b04          	addw	sp,#4
7470                     ; 1385 						delay_ms(10);
7472  0fbe ae000a        	ldw	x,#10
7473  0fc1 cd005c        	call	_delay_ms
7475                     ; 1386 						DF_buffer_read(/*///current_buffer_L*//*1,*/128,128,&buff[128]);         
7477  0fc4 ae00d0        	ldw	x,#_buff+128
7478  0fc7 89            	pushw	x
7479  0fc8 ae0080        	ldw	x,#128
7480  0fcb 89            	pushw	x
7481  0fcc ae0080        	ldw	x,#128
7482  0fcf cd0afa        	call	_DF_buffer_read
7484  0fd2 5b04          	addw	sp,#4
7485  0fd4               L7043:
7486                     ; 1388 					if(memory_manufacturer=='S') {
7488  0fd4 b6bc          	ld	a,_memory_manufacturer
7489  0fd6 a153          	cp	a,#83
7490  0fd8 2615          	jrne	L1143
7491                     ; 1389 						ST_READ(0,256,buff);
7493  0fda ae0050        	ldw	x,#_buff
7494  0fdd 89            	pushw	x
7495  0fde ae0100        	ldw	x,#256
7496  0fe1 89            	pushw	x
7497  0fe2 ae0000        	ldw	x,#0
7498  0fe5 89            	pushw	x
7499  0fe6 ae0000        	ldw	x,#0
7500  0fe9 89            	pushw	x
7501  0fea cd09f8        	call	_ST_READ
7503  0fed 5b08          	addw	sp,#8
7504  0fef               L1143:
7505                     ; 1391 					play=1;
7507  0fef 72100004      	bset	_play
7508                     ; 1392 					bSTART=0;
7510  0ff3 7211000c      	bres	_bSTART
7511                     ; 1394 					rele_cnt=rele_cnt_const[rele_cnt_index];
7513  0ff7 b6bb          	ld	a,_rele_cnt_index
7514  0ff9 5f            	clrw	x
7515  0ffa 97            	ld	xl,a
7516  0ffb d60000        	ld	a,(_rele_cnt_const,x)
7517  0ffe 5f            	clrw	x
7518  0fff 97            	ld	xl,a
7519  1000 bf03          	ldw	_rele_cnt,x
7520                     ; 1396 					but_block_cnt=50;
7522  1002 ae0032        	ldw	x,#50
7523  1005 bf00          	ldw	_but_block_cnt,x
7524  1007               L1733:
7525                     ; 1404 		if(b10Hz){
7527                     	btst	_b10Hz
7528  100c 2413          	jruge	L3143
7529                     ; 1405 			b10Hz=0;
7531  100e 72110007      	bres	_b10Hz
7532                     ; 1407 			rele_drv();
7534  1012 cd004a        	call	_rele_drv
7536                     ; 1408 			pwm_fade_in++;
7538  1015 3cba          	inc	_pwm_fade_in
7539                     ; 1409 			if(pwm_fade_in>128)pwm_fade_in=128;			
7541  1017 b6ba          	ld	a,_pwm_fade_in
7542  1019 a181          	cp	a,#129
7543  101b 2504          	jrult	L3143
7546  101d 358000ba      	mov	_pwm_fade_in,#128
7547  1021               L3143:
7548                     ; 1412 		if(b5Hz){
7550                     	btst	_b5Hz
7551  1026 2404          	jruge	L7143
7552                     ; 1413 			b5Hz=0;
7554  1028 72110006      	bres	_b5Hz
7555  102c               L7143:
7556                     ; 1418 		if(b1Hz){
7558                     	btst	_b1Hz
7559  1031 2503          	jrult	L071
7560  1033 cc0e8e        	jp	L7333
7561  1036               L071:
7562                     ; 1420 			b1Hz=0;
7564  1036 72110005      	bres	_b1Hz
7565  103a ac8e0e8e      	jpf	L7333
8061                     	xdef	_main
8062                     .eeprom:	section	.data
8063  0000               _EE_PAGE_LEN:
8064  0000 0000          	ds.b	2
8065                     	xdef	_EE_PAGE_LEN
8066                     	switch	.bss
8067  0000               _UIB:
8068  0000 000000000000  	ds.b	80
8069                     	xdef	_UIB
8070  0050               _buff:
8071  0050 000000000000  	ds.b	300
8072                     	xdef	_buff
8073  017c               _dumm:
8074  017c 000000000000  	ds.b	100
8075                     	xdef	_dumm
8076                     .bit:	section	.data,bit
8077  0000               _bRELEASE:
8078  0000 00            	ds.b	1
8079                     	xdef	_bRELEASE
8080  0001               _rx_buffer_overflow:
8081  0001 00            	ds.b	1
8082                     	xdef	_rx_buffer_overflow
8083  0002               _bRXIN:
8084  0002 00            	ds.b	1
8085                     	xdef	_bRXIN
8086  0003               _bOUT_FREE:
8087  0003 00            	ds.b	1
8088                     	xdef	_bOUT_FREE
8089  0004               _play:
8090  0004 00            	ds.b	1
8091                     	xdef	_play
8092  0005               _b1Hz:
8093  0005 00            	ds.b	1
8094                     	xdef	_b1Hz
8095  0006               _b5Hz:
8096  0006 00            	ds.b	1
8097                     	xdef	_b5Hz
8098  0007               _b10Hz:
8099  0007 00            	ds.b	1
8100                     	xdef	_b10Hz
8101  0008               _b100Hz:
8102  0008 00            	ds.b	1
8103                     	xdef	_b100Hz
8104  0009               _bBUFF_READ_L:
8105  0009 00            	ds.b	1
8106                     	xdef	_bBUFF_READ_L
8107  000a               _bBUFF_READ_H:
8108  000a 00            	ds.b	1
8109                     	xdef	_bBUFF_READ_H
8110  000b               _bBUFF_LOAD:
8111  000b 00            	ds.b	1
8112                     	xdef	_bBUFF_LOAD
8113  000c               _bSTART:
8114  000c 00            	ds.b	1
8115                     	xdef	_bSTART
8116                     	switch	.ubsct
8117  0000               _but_block_cnt:
8118  0000 0000          	ds.b	2
8119                     	xdef	_but_block_cnt
8120                     	xdef	_memory_manufacturer
8121                     	xdef	_rele_cnt_const
8122                     	xdef	_rele_cnt_index
8123                     	xdef	_pwm_fade_in
8124  0002               _rx_offset:
8125  0002 00            	ds.b	1
8126                     	xdef	_rx_offset
8127  0003               _rele_cnt:
8128  0003 0000          	ds.b	2
8129                     	xdef	_rele_cnt
8130  0005               _rx_data:
8131  0005 00            	ds.b	1
8132                     	xdef	_rx_data
8133  0006               _rx_status:
8134  0006 00            	ds.b	1
8135                     	xdef	_rx_status
8136  0007               _file_lengt:
8137  0007 00000000      	ds.b	4
8138                     	xdef	_file_lengt
8139  000b               _current_byte_in_buffer:
8140  000b 0000          	ds.b	2
8141                     	xdef	_current_byte_in_buffer
8142  000d               _last_page:
8143  000d 0000          	ds.b	2
8144                     	xdef	_last_page
8145  000f               _current_page:
8146  000f 0000          	ds.b	2
8147                     	xdef	_current_page
8148  0011               _file_lengt_in_pages:
8149  0011 0000          	ds.b	2
8150                     	xdef	_file_lengt_in_pages
8151  0013               _mdr3:
8152  0013 00            	ds.b	1
8153                     	xdef	_mdr3
8154  0014               _mdr2:
8155  0014 00            	ds.b	1
8156                     	xdef	_mdr2
8157  0015               _mdr1:
8158  0015 00            	ds.b	1
8159                     	xdef	_mdr1
8160  0016               _mdr0:
8161  0016 00            	ds.b	1
8162                     	xdef	_mdr0
8163                     	xdef	_but_on_drv_cnt
8164                     	xdef	_but_drv_cnt
8165  0017               _sample:
8166  0017 00            	ds.b	1
8167                     	xdef	_sample
8168  0018               _rx_rd_index:
8169  0018 0000          	ds.b	2
8170                     	xdef	_rx_rd_index
8171  001a               _rx_wr_index:
8172  001a 0000          	ds.b	2
8173                     	xdef	_rx_wr_index
8174  001c               _rx_counter:
8175  001c 0000          	ds.b	2
8176                     	xdef	_rx_counter
8177                     	xdef	_rx_buffer
8178  001e               _tx_rd_index:
8179  001e 00            	ds.b	1
8180                     	xdef	_tx_rd_index
8181  001f               _tx_wr_index:
8182  001f 00            	ds.b	1
8183                     	xdef	_tx_wr_index
8184  0020               _tx_counter:
8185  0020 00            	ds.b	1
8186                     	xdef	_tx_counter
8187                     	xdef	_tx_buffer
8188  0021               _sample_cnt:
8189  0021 0000          	ds.b	2
8190                     	xdef	_sample_cnt
8191                     	xdef	_t0_cnt3
8192                     	xdef	_t0_cnt2
8193                     	xdef	_t0_cnt1
8194                     	xdef	_t0_cnt0
8195                     	xdef	_ST_PAGE_ERASE
8196                     	xdef	_ST_BULK_ERASE
8197                     	xdef	_ST_READ
8198                     	xdef	_ST_WRITE
8199                     	xdef	_ST_WREN
8200                     	xdef	_ST_status_read
8201                     	xdef	_ST_RDID_read
8202                     	xdef	_uart_in_an
8203                     	xdef	_control_check
8204                     	xdef	_index_offset
8205                     	xdef	_uart_in
8206                     	xdef	_gpio_init
8207                     	xdef	_spi_init
8208                     	xdef	_spi
8209                     	xdef	_DF_buffer_to_page_er
8210                     	xdef	_DF_page_to_buffer
8211                     	xdef	_DF_buffer_write
8212                     	xdef	_DF_buffer_read
8213                     	xdef	_DF_status_read
8214                     	xdef	_DF_memo_to_256
8215                     	xdef	_DF_mf_dev_read
8216                     	xdef	_uart_init
8217                     	xdef	f_UARTRxInterrupt
8218                     	xdef	f_UARTTxInterrupt
8219                     	xdef	_putchar
8220                     	xdef	_uart_out_adr_block
8221                     	xdef	_uart_out
8222                     	xdef	f_TIM4_UPD_Interrupt
8223                     	xdef	_delay_ms
8224                     	xdef	_rele_drv
8225                     	xdef	_t4_init
8226                     	xdef	_t2_init
8227                     	xref.b	c_lreg
8228                     	xref.b	c_x
8229                     	xref.b	c_y
8249                     	xref	c_ladc
8250                     	xref	c_itolx
8251                     	xref	c_umul
8252                     	xref	c_eewrw
8253                     	xref	c_lglsh
8254                     	xref	c_uitolx
8255                     	xref	c_lgursh
8256                     	xref	c_lcmp
8257                     	xref	c_ltor
8258                     	xref	c_lgadc
8259                     	xref	c_rtol
8260                     	xref	c_vmul
8261                     	end
