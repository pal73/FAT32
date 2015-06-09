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
2816  0156 cd083d        	call	_putchar
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
2945  0184 cd083d        	call	_putchar
2947                     ; 181 temp11=10;
2949                     ; 182 t^=temp11;
2951  0187 7b02          	ld	a,(OFST-1,sp)
2952  0189 a80a          	xor	a,	#10
2953  018b 6b02          	ld	(OFST-1,sp),a
2954                     ; 183 putchar(temp11);
2956  018d a60a          	ld	a,#10
2957  018f cd083d        	call	_putchar
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
2972  01a0 cd083d        	call	_putchar
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
2994  01ba cd083d        	call	_putchar
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
3016  01d4 cd083d        	call	_putchar
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
3038  01ee cd083d        	call	_putchar
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
3066  020b cd083d        	call	_putchar
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
3090  0224 cd083d        	call	_putchar
3092                     ; 213 putchar(t);
3094  0227 7b02          	ld	a,(OFST-1,sp)
3095  0229 cd083d        	call	_putchar
3097                     ; 215 putchar(0x0a);
3099  022c a60a          	ld	a,#10
3100  022e cd083d        	call	_putchar
3102                     ; 217 bOUT_FREE=0;	   
3104  0231 72110003      	bres	_bOUT_FREE
3105                     ; 218 }
3108  0235 5b03          	addw	sp,#3
3109  0237 81            	ret
3243                     ; 220 void uart_in_an(void) {
3244                     	switch	.text
3245  0238               _uart_in_an:
3247  0238 5204          	subw	sp,#4
3248       00000004      OFST:	set	4
3251                     ; 223 	if(UIB[0]==CMND) {
3253  023a c60000        	ld	a,_UIB
3254  023d a116          	cp	a,#22
3255  023f 2703          	jreq	L24
3256  0241 cc083a        	jp	L1771
3257  0244               L24:
3258                     ; 224 		if(UIB[1]==1) {
3260  0244 c60001        	ld	a,_UIB+1
3261  0247 a101          	cp	a,#1
3262  0249 262f          	jrne	L3771
3263                     ; 228 			if(memory_manufacturer=='A') {
3265  024b b6bc          	ld	a,_memory_manufacturer
3266  024d a141          	cp	a,#65
3267  024f 2603          	jrne	L5771
3268                     ; 229 				temp_L=DF_mf_dev_read();
3270  0251 cd09e9        	call	_DF_mf_dev_read
3272  0254               L5771:
3273                     ; 231 			if(memory_manufacturer=='S') {
3275  0254 b6bc          	ld	a,_memory_manufacturer
3276  0256 a153          	cp	a,#83
3277  0258 2603          	jrne	L7771
3278                     ; 232 				temp_L=ST_RDID_read();
3280  025a cd08fe        	call	_ST_RDID_read
3282  025d               L7771:
3283                     ; 234 			uart_out (6,CMND,1,mdr0/**((char*)&temp_L)*/,mdr1/**(((char*)&temp_L)+1)*/,mdr2/**(((char*)&temp_L)+2)*/,mdr3/**(((char*)&temp_L)+3)*/);
3285  025d 3b0013        	push	_mdr3
3286  0260 3b0014        	push	_mdr2
3287  0263 3b0015        	push	_mdr1
3288  0266 3b0016        	push	_mdr0
3289  0269 4b01          	push	#1
3290  026b ae0016        	ldw	x,#22
3291  026e a606          	ld	a,#6
3292  0270 95            	ld	xh,a
3293  0271 cd00ce        	call	_uart_out
3295  0274 5b05          	addw	sp,#5
3297  0276 ac3a083a      	jpf	L1771
3298  027a               L3771:
3299                     ; 241 	else if(UIB[1]==2) {
3301  027a c60001        	ld	a,_UIB+1
3302  027d a102          	cp	a,#2
3303  027f 2630          	jrne	L3002
3304                     ; 244 		if(memory_manufacturer=='A') {
3306  0281 b6bc          	ld	a,_memory_manufacturer
3307  0283 a141          	cp	a,#65
3308  0285 2605          	jrne	L5002
3309                     ; 245 			temp=DF_status_read();
3311  0287 cd0a3d        	call	_DF_status_read
3313  028a 6b04          	ld	(OFST+0,sp),a
3314  028c               L5002:
3315                     ; 247 		if(memory_manufacturer=='S') {
3317  028c b6bc          	ld	a,_memory_manufacturer
3318  028e a153          	cp	a,#83
3319  0290 2605          	jrne	L7002
3320                     ; 248 			temp=ST_status_read();
3322  0292 cd092a        	call	_ST_status_read
3324  0295 6b04          	ld	(OFST+0,sp),a
3325  0297               L7002:
3326                     ; 250 		uart_out (3,CMND,2,temp,0,0,0);    
3328  0297 4b00          	push	#0
3329  0299 4b00          	push	#0
3330  029b 4b00          	push	#0
3331  029d 7b07          	ld	a,(OFST+3,sp)
3332  029f 88            	push	a
3333  02a0 4b02          	push	#2
3334  02a2 ae0016        	ldw	x,#22
3335  02a5 a603          	ld	a,#3
3336  02a7 95            	ld	xh,a
3337  02a8 cd00ce        	call	_uart_out
3339  02ab 5b05          	addw	sp,#5
3341  02ad ac3a083a      	jpf	L1771
3342  02b1               L3002:
3343                     ; 254 	else if(UIB[1]==3)
3345  02b1 c60001        	ld	a,_UIB+1
3346  02b4 a103          	cp	a,#3
3347  02b6 2623          	jrne	L3102
3348                     ; 257 		if(memory_manufacturer=='A') {
3350  02b8 b6bc          	ld	a,_memory_manufacturer
3351  02ba a141          	cp	a,#65
3352  02bc 2603          	jrne	L5102
3353                     ; 258 			DF_memo_to_256();
3355  02be cd0a20        	call	_DF_memo_to_256
3357  02c1               L5102:
3358                     ; 260 		uart_out (2,CMND,3,temp,0,0,0);    
3360  02c1 4b00          	push	#0
3361  02c3 4b00          	push	#0
3362  02c5 4b00          	push	#0
3363  02c7 7b07          	ld	a,(OFST+3,sp)
3364  02c9 88            	push	a
3365  02ca 4b03          	push	#3
3366  02cc ae0016        	ldw	x,#22
3367  02cf a602          	ld	a,#2
3368  02d1 95            	ld	xh,a
3369  02d2 cd00ce        	call	_uart_out
3371  02d5 5b05          	addw	sp,#5
3373  02d7 ac3a083a      	jpf	L1771
3374  02db               L3102:
3375                     ; 263 	else if(UIB[1]==4)
3377  02db c60001        	ld	a,_UIB+1
3378  02de a104          	cp	a,#4
3379  02e0 2623          	jrne	L1202
3380                     ; 266 		if(memory_manufacturer=='A') {
3382  02e2 b6bc          	ld	a,_memory_manufacturer
3383  02e4 a141          	cp	a,#65
3384  02e6 2603          	jrne	L3202
3385                     ; 267 			DF_memo_to_256();
3387  02e8 cd0a20        	call	_DF_memo_to_256
3389  02eb               L3202:
3390                     ; 269 		uart_out (2,CMND,3,temp,0,0,0);    
3392  02eb 4b00          	push	#0
3393  02ed 4b00          	push	#0
3394  02ef 4b00          	push	#0
3395  02f1 7b07          	ld	a,(OFST+3,sp)
3396  02f3 88            	push	a
3397  02f4 4b03          	push	#3
3398  02f6 ae0016        	ldw	x,#22
3399  02f9 a602          	ld	a,#2
3400  02fb 95            	ld	xh,a
3401  02fc cd00ce        	call	_uart_out
3403  02ff 5b05          	addw	sp,#5
3405  0301 ac3a083a      	jpf	L1771
3406  0305               L1202:
3407                     ; 272 	else if(UIB[1]==10)
3409  0305 c60001        	ld	a,_UIB+1
3410  0308 a10a          	cp	a,#10
3411  030a 2703cc0392    	jrne	L7202
3412                     ; 276 		if(memory_manufacturer=='A') {
3414  030f b6bc          	ld	a,_memory_manufacturer
3415  0311 a141          	cp	a,#65
3416  0313 2615          	jrne	L1302
3417                     ; 277 			if(UIB[2]==1)DF_buffer_read(/*1,*/0,256, buff);
3419  0315 c60002        	ld	a,_UIB+2
3420  0318 a101          	cp	a,#1
3421  031a 260e          	jrne	L1302
3424  031c ae0050        	ldw	x,#_buff
3425  031f 89            	pushw	x
3426  0320 ae0100        	ldw	x,#256
3427  0323 89            	pushw	x
3428  0324 5f            	clrw	x
3429  0325 cd0a9d        	call	_DF_buffer_read
3431  0328 5b04          	addw	sp,#4
3432  032a               L1302:
3433                     ; 282 		uart_out_adr_block (0,buff,64);
3435  032a 4b40          	push	#64
3436  032c ae0050        	ldw	x,#_buff
3437  032f 89            	pushw	x
3438  0330 ae0000        	ldw	x,#0
3439  0333 89            	pushw	x
3440  0334 ae0000        	ldw	x,#0
3441  0337 89            	pushw	x
3442  0338 cd0178        	call	_uart_out_adr_block
3444  033b 5b07          	addw	sp,#7
3445                     ; 283 		delay_ms(100);    
3447  033d ae0064        	ldw	x,#100
3448  0340 cd005c        	call	_delay_ms
3450                     ; 284 		uart_out_adr_block (64,&buff[64],64);
3452  0343 4b40          	push	#64
3453  0345 ae0090        	ldw	x,#_buff+64
3454  0348 89            	pushw	x
3455  0349 ae0040        	ldw	x,#64
3456  034c 89            	pushw	x
3457  034d ae0000        	ldw	x,#0
3458  0350 89            	pushw	x
3459  0351 cd0178        	call	_uart_out_adr_block
3461  0354 5b07          	addw	sp,#7
3462                     ; 285 		delay_ms(100);    
3464  0356 ae0064        	ldw	x,#100
3465  0359 cd005c        	call	_delay_ms
3467                     ; 286 		uart_out_adr_block (128,&buff[128],64);
3469  035c 4b40          	push	#64
3470  035e ae00d0        	ldw	x,#_buff+128
3471  0361 89            	pushw	x
3472  0362 ae0080        	ldw	x,#128
3473  0365 89            	pushw	x
3474  0366 ae0000        	ldw	x,#0
3475  0369 89            	pushw	x
3476  036a cd0178        	call	_uart_out_adr_block
3478  036d 5b07          	addw	sp,#7
3479                     ; 287 		delay_ms(100);    
3481  036f ae0064        	ldw	x,#100
3482  0372 cd005c        	call	_delay_ms
3484                     ; 288 		uart_out_adr_block (192,&buff[192],64);
3486  0375 4b40          	push	#64
3487  0377 ae0110        	ldw	x,#_buff+192
3488  037a 89            	pushw	x
3489  037b ae00c0        	ldw	x,#192
3490  037e 89            	pushw	x
3491  037f ae0000        	ldw	x,#0
3492  0382 89            	pushw	x
3493  0383 cd0178        	call	_uart_out_adr_block
3495  0386 5b07          	addw	sp,#7
3496                     ; 289 		delay_ms(100);    
3498  0388 ae0064        	ldw	x,#100
3499  038b cd005c        	call	_delay_ms
3502  038e ac3a083a      	jpf	L1771
3503  0392               L7202:
3504                     ; 292 	else if(UIB[1]==11)
3506  0392 c60001        	ld	a,_UIB+1
3507  0395 a10b          	cp	a,#11
3508  0397 2633          	jrne	L7302
3509                     ; 298 		for(i=0;i<256;i++)buff[i]=0;
3511  0399 5f            	clrw	x
3512  039a 1f03          	ldw	(OFST-1,sp),x
3513  039c               L1402:
3516  039c 1e03          	ldw	x,(OFST-1,sp)
3517  039e 724f0050      	clr	(_buff,x)
3520  03a2 1e03          	ldw	x,(OFST-1,sp)
3521  03a4 1c0001        	addw	x,#1
3522  03a7 1f03          	ldw	(OFST-1,sp),x
3525  03a9 1e03          	ldw	x,(OFST-1,sp)
3526  03ab a30100        	cpw	x,#256
3527  03ae 25ec          	jrult	L1402
3528                     ; 300 		if(UIB[2]==1)DF_buffer_write(/*1,*/0,256, buff);
3530  03b0 c60002        	ld	a,_UIB+2
3531  03b3 a101          	cp	a,#1
3532  03b5 2703          	jreq	L44
3533  03b7 cc083a        	jp	L1771
3534  03ba               L44:
3537  03ba ae0050        	ldw	x,#_buff
3538  03bd 89            	pushw	x
3539  03be ae0100        	ldw	x,#256
3540  03c1 89            	pushw	x
3541  03c2 5f            	clrw	x
3542  03c3 cd0ae3        	call	_DF_buffer_write
3544  03c6 5b04          	addw	sp,#4
3545  03c8 ac3a083a      	jpf	L1771
3546  03cc               L7302:
3547                     ; 304 	else if(UIB[1]==12)
3549  03cc c60001        	ld	a,_UIB+1
3550  03cf a10c          	cp	a,#12
3551  03d1 2703          	jreq	L64
3552  03d3 cc04b2        	jp	L3502
3553  03d6               L64:
3554                     ; 310 		for(i=0;i<256;i++)buff[i]=0;
3556  03d6 5f            	clrw	x
3557  03d7 1f03          	ldw	(OFST-1,sp),x
3558  03d9               L5502:
3561  03d9 1e03          	ldw	x,(OFST-1,sp)
3562  03db 724f0050      	clr	(_buff,x)
3565  03df 1e03          	ldw	x,(OFST-1,sp)
3566  03e1 1c0001        	addw	x,#1
3567  03e4 1f03          	ldw	(OFST-1,sp),x
3570  03e6 1e03          	ldw	x,(OFST-1,sp)
3571  03e8 a30100        	cpw	x,#256
3572  03eb 25ec          	jrult	L5502
3573                     ; 312 		if(UIB[3]==1)
3575  03ed c60003        	ld	a,_UIB+3
3576  03f0 a101          	cp	a,#1
3577  03f2 2632          	jrne	L3602
3578                     ; 314 			buff[0]=0x00;
3580  03f4 725f0050      	clr	_buff
3581                     ; 315 			buff[1]=0x11;
3583  03f8 35110051      	mov	_buff+1,#17
3584                     ; 316 			buff[2]=0x22;
3586  03fc 35220052      	mov	_buff+2,#34
3587                     ; 317 			buff[3]=0x33;
3589  0400 35330053      	mov	_buff+3,#51
3590                     ; 318 			buff[4]=0x44;
3592  0404 35440054      	mov	_buff+4,#68
3593                     ; 319 			buff[5]=0x55;
3595  0408 35550055      	mov	_buff+5,#85
3596                     ; 320 			buff[6]=0x66;
3598  040c 35660056      	mov	_buff+6,#102
3599                     ; 321 			buff[7]=0x77;
3601  0410 35770057      	mov	_buff+7,#119
3602                     ; 322 			buff[8]=0x88;
3604  0414 35880058      	mov	_buff+8,#136
3605                     ; 323 			buff[9]=0x99;
3607  0418 35990059      	mov	_buff+9,#153
3608                     ; 324 			buff[10]=0;
3610  041c 725f005a      	clr	_buff+10
3611                     ; 325 			buff[11]=0;
3613  0420 725f005b      	clr	_buff+11
3615  0424 2070          	jra	L5602
3616  0426               L3602:
3617                     ; 328 		else if(UIB[3]==2)
3619  0426 c60003        	ld	a,_UIB+3
3620  0429 a102          	cp	a,#2
3621  042b 2632          	jrne	L7602
3622                     ; 330 			buff[0]=0x00;
3624  042d 725f0050      	clr	_buff
3625                     ; 331 			buff[1]=0x10;
3627  0431 35100051      	mov	_buff+1,#16
3628                     ; 332 			buff[2]=0x20;
3630  0435 35200052      	mov	_buff+2,#32
3631                     ; 333 			buff[3]=0x30;
3633  0439 35300053      	mov	_buff+3,#48
3634                     ; 334 			buff[4]=0x40;
3636  043d 35400054      	mov	_buff+4,#64
3637                     ; 335 			buff[5]=0x50;
3639  0441 35500055      	mov	_buff+5,#80
3640                     ; 336 			buff[6]=0x60;
3642  0445 35600056      	mov	_buff+6,#96
3643                     ; 337 			buff[7]=0x70;
3645  0449 35700057      	mov	_buff+7,#112
3646                     ; 338 			buff[8]=0x80;
3648  044d 35800058      	mov	_buff+8,#128
3649                     ; 339 			buff[9]=0x90;
3651  0451 35900059      	mov	_buff+9,#144
3652                     ; 340 			buff[10]=0;
3654  0455 725f005a      	clr	_buff+10
3655                     ; 341 			buff[11]=0;
3657  0459 725f005b      	clr	_buff+11
3659  045d 2037          	jra	L5602
3660  045f               L7602:
3661                     ; 344 		else if(UIB[3]==3)
3663  045f c60003        	ld	a,_UIB+3
3664  0462 a103          	cp	a,#3
3665  0464 2630          	jrne	L5602
3666                     ; 346 			buff[0]=0x98;
3668  0466 35980050      	mov	_buff,#152
3669                     ; 347 			buff[1]=0x87;
3671  046a 35870051      	mov	_buff+1,#135
3672                     ; 348 			buff[2]=0x76;
3674  046e 35760052      	mov	_buff+2,#118
3675                     ; 349 			buff[3]=0x65;
3677  0472 35650053      	mov	_buff+3,#101
3678                     ; 350 			buff[4]=0x54;
3680  0476 35540054      	mov	_buff+4,#84
3681                     ; 351 			buff[5]=0x43;
3683  047a 35430055      	mov	_buff+5,#67
3684                     ; 352 			buff[6]=0x32;
3686  047e 35320056      	mov	_buff+6,#50
3687                     ; 353 			buff[7]=0x21;
3689  0482 35210057      	mov	_buff+7,#33
3690                     ; 354 			buff[8]=0x10;
3692  0486 35100058      	mov	_buff+8,#16
3693                     ; 355 			buff[9]=0x00;
3695  048a 725f0059      	clr	_buff+9
3696                     ; 356 			buff[10]=0;
3698  048e 725f005a      	clr	_buff+10
3699                     ; 357 			buff[11]=0;
3701  0492 725f005b      	clr	_buff+11
3702  0496               L5602:
3703                     ; 359 		if(UIB[2]==1)DF_buffer_write(/*1,*/0,256, buff);
3705  0496 c60002        	ld	a,_UIB+2
3706  0499 a101          	cp	a,#1
3707  049b 2703          	jreq	L05
3708  049d cc083a        	jp	L1771
3709  04a0               L05:
3712  04a0 ae0050        	ldw	x,#_buff
3713  04a3 89            	pushw	x
3714  04a4 ae0100        	ldw	x,#256
3715  04a7 89            	pushw	x
3716  04a8 5f            	clrw	x
3717  04a9 cd0ae3        	call	_DF_buffer_write
3719  04ac 5b04          	addw	sp,#4
3720  04ae ac3a083a      	jpf	L1771
3721  04b2               L3502:
3722                     ; 363 	else if(UIB[1]==13)
3724  04b2 c60001        	ld	a,_UIB+1
3725  04b5 a10d          	cp	a,#13
3726  04b7 2703cc0555    	jrne	L1012
3727                     ; 368 		if(memory_manufacturer=='A') {	
3729  04bc b6bc          	ld	a,_memory_manufacturer
3730  04be a141          	cp	a,#65
3731  04c0 2608          	jrne	L3012
3732                     ; 369 			DF_page_to_buffer(/*UIB[2],*/UIB[3]);
3734  04c2 c60003        	ld	a,_UIB+3
3735  04c5 5f            	clrw	x
3736  04c6 97            	ld	xl,a
3737  04c7 cd0a57        	call	_DF_page_to_buffer
3739  04ca               L3012:
3740                     ; 371 		if(memory_manufacturer=='S') {
3742  04ca b6bc          	ld	a,_memory_manufacturer
3743  04cc a153          	cp	a,#83
3744  04ce 2703          	jreq	L25
3745  04d0 cc083a        	jp	L1771
3746  04d3               L25:
3747                     ; 372 			current_page=11;
3749  04d3 ae000b        	ldw	x,#11
3750  04d6 bf0f          	ldw	_current_page,x
3751                     ; 373 			ST_READ((long)(current_page*256),256, buff);
3753  04d8 ae0050        	ldw	x,#_buff
3754  04db 89            	pushw	x
3755  04dc ae0100        	ldw	x,#256
3756  04df 89            	pushw	x
3757  04e0 ae0b00        	ldw	x,#2816
3758  04e3 89            	pushw	x
3759  04e4 ae0000        	ldw	x,#0
3760  04e7 89            	pushw	x
3761  04e8 cd099b        	call	_ST_READ
3763  04eb 5b08          	addw	sp,#8
3764                     ; 375 			uart_out_adr_block (0,buff,64);
3766  04ed 4b40          	push	#64
3767  04ef ae0050        	ldw	x,#_buff
3768  04f2 89            	pushw	x
3769  04f3 ae0000        	ldw	x,#0
3770  04f6 89            	pushw	x
3771  04f7 ae0000        	ldw	x,#0
3772  04fa 89            	pushw	x
3773  04fb cd0178        	call	_uart_out_adr_block
3775  04fe 5b07          	addw	sp,#7
3776                     ; 376 			delay_ms(100);    
3778  0500 ae0064        	ldw	x,#100
3779  0503 cd005c        	call	_delay_ms
3781                     ; 377 			uart_out_adr_block (64,&buff[64],64);
3783  0506 4b40          	push	#64
3784  0508 ae0090        	ldw	x,#_buff+64
3785  050b 89            	pushw	x
3786  050c ae0040        	ldw	x,#64
3787  050f 89            	pushw	x
3788  0510 ae0000        	ldw	x,#0
3789  0513 89            	pushw	x
3790  0514 cd0178        	call	_uart_out_adr_block
3792  0517 5b07          	addw	sp,#7
3793                     ; 378 			delay_ms(100);    
3795  0519 ae0064        	ldw	x,#100
3796  051c cd005c        	call	_delay_ms
3798                     ; 379 			uart_out_adr_block (128,&buff[128],64);
3800  051f 4b40          	push	#64
3801  0521 ae00d0        	ldw	x,#_buff+128
3802  0524 89            	pushw	x
3803  0525 ae0080        	ldw	x,#128
3804  0528 89            	pushw	x
3805  0529 ae0000        	ldw	x,#0
3806  052c 89            	pushw	x
3807  052d cd0178        	call	_uart_out_adr_block
3809  0530 5b07          	addw	sp,#7
3810                     ; 380 			delay_ms(100);    
3812  0532 ae0064        	ldw	x,#100
3813  0535 cd005c        	call	_delay_ms
3815                     ; 381 			uart_out_adr_block (192,&buff[192],64);
3817  0538 4b40          	push	#64
3818  053a ae0110        	ldw	x,#_buff+192
3819  053d 89            	pushw	x
3820  053e ae00c0        	ldw	x,#192
3821  0541 89            	pushw	x
3822  0542 ae0000        	ldw	x,#0
3823  0545 89            	pushw	x
3824  0546 cd0178        	call	_uart_out_adr_block
3826  0549 5b07          	addw	sp,#7
3827                     ; 382 			delay_ms(100); 
3829  054b ae0064        	ldw	x,#100
3830  054e cd005c        	call	_delay_ms
3832  0551 ac3a083a      	jpf	L1771
3833  0555               L1012:
3834                     ; 385 	else if(UIB[1]==14)
3836  0555 c60001        	ld	a,_UIB+1
3837  0558 a10e          	cp	a,#14
3838  055a 265b          	jrne	L1112
3839                     ; 390 		if(memory_manufacturer=='A') {	
3841  055c b6bc          	ld	a,_memory_manufacturer
3842  055e a141          	cp	a,#65
3843  0560 2608          	jrne	L3112
3844                     ; 391 			DF_buffer_to_page_er(/*UIB[2],*/UIB[3]);
3846  0562 c60003        	ld	a,_UIB+3
3847  0565 5f            	clrw	x
3848  0566 97            	ld	xl,a
3849  0567 cd0a7a        	call	_DF_buffer_to_page_er
3851  056a               L3112:
3852                     ; 393 		if(memory_manufacturer=='S') {
3854  056a b6bc          	ld	a,_memory_manufacturer
3855  056c a153          	cp	a,#83
3856  056e 2703          	jreq	L45
3857  0570 cc083a        	jp	L1771
3858  0573               L45:
3859                     ; 394 			for(i=0;i<256;i++) {
3861  0573 5f            	clrw	x
3862  0574 1f03          	ldw	(OFST-1,sp),x
3863  0576               L7112:
3864                     ; 395 				buff[i]=(char)i;
3866  0576 7b04          	ld	a,(OFST+0,sp)
3867  0578 1e03          	ldw	x,(OFST-1,sp)
3868  057a d70050        	ld	(_buff,x),a
3869                     ; 394 			for(i=0;i<256;i++) {
3871  057d 1e03          	ldw	x,(OFST-1,sp)
3872  057f 1c0001        	addw	x,#1
3873  0582 1f03          	ldw	(OFST-1,sp),x
3876  0584 1e03          	ldw	x,(OFST-1,sp)
3877  0586 a30100        	cpw	x,#256
3878  0589 25eb          	jrult	L7112
3879                     ; 397 			current_page=11;
3881  058b ae000b        	ldw	x,#11
3882  058e bf0f          	ldw	_current_page,x
3883                     ; 398 			ST_WREN();
3885  0590 cd0942        	call	_ST_WREN
3887                     ; 399 			delay_ms(100);
3889  0593 ae0064        	ldw	x,#100
3890  0596 cd005c        	call	_delay_ms
3892                     ; 400 			ST_WRITE((long)(current_page*256),256,buff);		
3894  0599 ae0050        	ldw	x,#_buff
3895  059c 89            	pushw	x
3896  059d ae0100        	ldw	x,#256
3897  05a0 89            	pushw	x
3898  05a1 be0f          	ldw	x,_current_page
3899  05a3 4f            	clr	a
3900  05a4 02            	rlwa	x,a
3901  05a5 cd0000        	call	c_uitolx
3903  05a8 be02          	ldw	x,c_lreg+2
3904  05aa 89            	pushw	x
3905  05ab be00          	ldw	x,c_lreg
3906  05ad 89            	pushw	x
3907  05ae cd094f        	call	_ST_WRITE
3909  05b1 5b08          	addw	sp,#8
3910  05b3 ac3a083a      	jpf	L1771
3911  05b7               L1112:
3912                     ; 405 	else if(UIB[1]==20)
3914  05b7 c60001        	ld	a,_UIB+1
3915  05ba a114          	cp	a,#20
3916  05bc 2703cc063f    	jrne	L7212
3917                     ; 410 		file_lengt=0;
3919  05c1 ae0000        	ldw	x,#0
3920  05c4 bf09          	ldw	_file_lengt+2,x
3921  05c6 ae0000        	ldw	x,#0
3922  05c9 bf07          	ldw	_file_lengt,x
3923                     ; 411 		file_lengt+=UIB[5];
3925  05cb c60005        	ld	a,_UIB+5
3926  05ce ae0007        	ldw	x,#_file_lengt
3927  05d1 88            	push	a
3928  05d2 cd0000        	call	c_lgadc
3930  05d5 84            	pop	a
3931                     ; 412 		file_lengt<<=8;
3933  05d6 ae0007        	ldw	x,#_file_lengt
3934  05d9 a608          	ld	a,#8
3935  05db cd0000        	call	c_lglsh
3937                     ; 413 		file_lengt+=UIB[4];
3939  05de c60004        	ld	a,_UIB+4
3940  05e1 ae0007        	ldw	x,#_file_lengt
3941  05e4 88            	push	a
3942  05e5 cd0000        	call	c_lgadc
3944  05e8 84            	pop	a
3945                     ; 414 		file_lengt<<=8;
3947  05e9 ae0007        	ldw	x,#_file_lengt
3948  05ec a608          	ld	a,#8
3949  05ee cd0000        	call	c_lglsh
3951                     ; 415 		file_lengt+=UIB[3];
3953  05f1 c60003        	ld	a,_UIB+3
3954  05f4 ae0007        	ldw	x,#_file_lengt
3955  05f7 88            	push	a
3956  05f8 cd0000        	call	c_lgadc
3958  05fb 84            	pop	a
3959                     ; 416 		file_lengt_in_pages=file_lengt;
3961  05fc be09          	ldw	x,_file_lengt+2
3962  05fe bf11          	ldw	_file_lengt_in_pages,x
3963                     ; 417 		file_lengt<<=8;
3965  0600 ae0007        	ldw	x,#_file_lengt
3966  0603 a608          	ld	a,#8
3967  0605 cd0000        	call	c_lglsh
3969                     ; 418 		file_lengt+=UIB[2];
3971  0608 c60002        	ld	a,_UIB+2
3972  060b ae0007        	ldw	x,#_file_lengt
3973  060e 88            	push	a
3974  060f cd0000        	call	c_lgadc
3976  0612 84            	pop	a
3977                     ; 423 		current_page=0;
3979  0613 5f            	clrw	x
3980  0614 bf0f          	ldw	_current_page,x
3981                     ; 424 		current_byte_in_buffer=0;
3983  0616 5f            	clrw	x
3984  0617 bf0b          	ldw	_current_byte_in_buffer,x
3985                     ; 426 		if(memory_manufacturer=='S') {
3987  0619 b6bc          	ld	a,_memory_manufacturer
3988  061b a153          	cp	a,#83
3989  061d 2603          	jrne	L1312
3990                     ; 427 			ST_WREN();
3992  061f cd0942        	call	_ST_WREN
3994  0622               L1312:
3995                     ; 429 		uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
3997  0622 4b00          	push	#0
3998  0624 4b00          	push	#0
3999  0626 3b000f        	push	_current_page
4000  0629 b610          	ld	a,_current_page+1
4001  062b a4ff          	and	a,#255
4002  062d 88            	push	a
4003  062e 4b15          	push	#21
4004  0630 ae0016        	ldw	x,#22
4005  0633 a604          	ld	a,#4
4006  0635 95            	ld	xh,a
4007  0636 cd00ce        	call	_uart_out
4009  0639 5b05          	addw	sp,#5
4011  063b ac3a083a      	jpf	L1771
4012  063f               L7212:
4013                     ; 432 	else if(UIB[1]==21)
4015  063f c60001        	ld	a,_UIB+1
4016  0642 a115          	cp	a,#21
4017  0644 2703          	jreq	L65
4018  0646 cc073b        	jp	L5312
4019  0649               L65:
4020                     ; 437           for(i=0;i<64;i++)
4022  0649 5f            	clrw	x
4023  064a 1f03          	ldw	(OFST-1,sp),x
4024  064c               L7312:
4025                     ; 439           	buff[current_byte_in_buffer+i]=UIB[2+i];
4027  064c 1e03          	ldw	x,(OFST-1,sp)
4028  064e d60002        	ld	a,(_UIB+2,x)
4029  0651 be0b          	ldw	x,_current_byte_in_buffer
4030  0653 72fb03        	addw	x,(OFST-1,sp)
4031  0656 d70050        	ld	(_buff,x),a
4032                     ; 437           for(i=0;i<64;i++)
4034  0659 1e03          	ldw	x,(OFST-1,sp)
4035  065b 1c0001        	addw	x,#1
4036  065e 1f03          	ldw	(OFST-1,sp),x
4039  0660 1e03          	ldw	x,(OFST-1,sp)
4040  0662 a30040        	cpw	x,#64
4041  0665 25e5          	jrult	L7312
4042                     ; 441           current_byte_in_buffer+=64;
4044  0667 be0b          	ldw	x,_current_byte_in_buffer
4045  0669 1c0040        	addw	x,#64
4046  066c bf0b          	ldw	_current_byte_in_buffer,x
4047                     ; 442           if(current_byte_in_buffer>=256)
4049  066e be0b          	ldw	x,_current_byte_in_buffer
4050  0670 a30100        	cpw	x,#256
4051  0673 2403          	jruge	L06
4052  0675 cc083a        	jp	L1771
4053  0678               L06:
4054                     ; 450 			if(memory_manufacturer=='A') {
4056  0678 b6bc          	ld	a,_memory_manufacturer
4057  067a a141          	cp	a,#65
4058  067c 264e          	jrne	L7412
4059                     ; 451 				DF_buffer_write(/*//current_buffer*//*1,*/0,256,buff);
4061  067e ae0050        	ldw	x,#_buff
4062  0681 89            	pushw	x
4063  0682 ae0100        	ldw	x,#256
4064  0685 89            	pushw	x
4065  0686 5f            	clrw	x
4066  0687 cd0ae3        	call	_DF_buffer_write
4068  068a 5b04          	addw	sp,#4
4069                     ; 452 				DF_buffer_to_page_er(/*///current_buffer*//*1,*/current_page);
4071  068c be0f          	ldw	x,_current_page
4072  068e cd0a7a        	call	_DF_buffer_to_page_er
4074                     ; 453 				current_page++;
4076  0691 be0f          	ldw	x,_current_page
4077  0693 1c0001        	addw	x,#1
4078  0696 bf0f          	ldw	_current_page,x
4079                     ; 454 				if(current_page<file_lengt_in_pages)
4081  0698 be0f          	ldw	x,_current_page
4082  069a b311          	cpw	x,_file_lengt_in_pages
4083  069c 2424          	jruge	L1512
4084                     ; 456 					delay_ms(100);
4086  069e ae0064        	ldw	x,#100
4087  06a1 cd005c        	call	_delay_ms
4089                     ; 457 					uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
4091  06a4 4b00          	push	#0
4092  06a6 4b00          	push	#0
4093  06a8 3b000f        	push	_current_page
4094  06ab b610          	ld	a,_current_page+1
4095  06ad a4ff          	and	a,#255
4096  06af 88            	push	a
4097  06b0 4b15          	push	#21
4098  06b2 ae0016        	ldw	x,#22
4099  06b5 a604          	ld	a,#4
4100  06b7 95            	ld	xh,a
4101  06b8 cd00ce        	call	_uart_out
4103  06bb 5b05          	addw	sp,#5
4104                     ; 458 					current_byte_in_buffer=0;
4106  06bd 5f            	clrw	x
4107  06be bf0b          	ldw	_current_byte_in_buffer,x
4109  06c0 200a          	jra	L7412
4110  06c2               L1512:
4111                     ; 462 					EE_PAGE_LEN=current_page;
4113  06c2 be0f          	ldw	x,_current_page
4114  06c4 89            	pushw	x
4115  06c5 ae0000        	ldw	x,#_EE_PAGE_LEN
4116  06c8 cd0000        	call	c_eewrw
4118  06cb 85            	popw	x
4119  06cc               L7412:
4120                     ; 465 			if(memory_manufacturer=='S') {
4122  06cc b6bc          	ld	a,_memory_manufacturer
4123  06ce a153          	cp	a,#83
4124  06d0 2703          	jreq	L26
4125  06d2 cc083a        	jp	L1771
4126  06d5               L26:
4127                     ; 466 				ST_WREN();
4129  06d5 cd0942        	call	_ST_WREN
4131                     ; 467 				delay_ms(100);
4133  06d8 ae0064        	ldw	x,#100
4134  06db cd005c        	call	_delay_ms
4136                     ; 468 				ST_WRITE((unsigned long)(current_page*256UL),256,buff);
4138  06de ae0050        	ldw	x,#_buff
4139  06e1 89            	pushw	x
4140  06e2 ae0100        	ldw	x,#256
4141  06e5 89            	pushw	x
4142  06e6 be0f          	ldw	x,_current_page
4143  06e8 90ae0100      	ldw	y,#256
4144  06ec cd0000        	call	c_umul
4146  06ef be02          	ldw	x,c_lreg+2
4147  06f1 89            	pushw	x
4148  06f2 be00          	ldw	x,c_lreg
4149  06f4 89            	pushw	x
4150  06f5 cd094f        	call	_ST_WRITE
4152  06f8 5b08          	addw	sp,#8
4153                     ; 469 				current_page++;
4155  06fa be0f          	ldw	x,_current_page
4156  06fc 1c0001        	addw	x,#1
4157  06ff bf0f          	ldw	_current_page,x
4158                     ; 470 				if(current_page<file_lengt_in_pages)
4160  0701 be0f          	ldw	x,_current_page
4161  0703 b311          	cpw	x,_file_lengt_in_pages
4162  0705 2426          	jruge	L7512
4163                     ; 472 					delay_ms(100);
4165  0707 ae0064        	ldw	x,#100
4166  070a cd005c        	call	_delay_ms
4168                     ; 473 					uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
4170  070d 4b00          	push	#0
4171  070f 4b00          	push	#0
4172  0711 3b000f        	push	_current_page
4173  0714 b610          	ld	a,_current_page+1
4174  0716 a4ff          	and	a,#255
4175  0718 88            	push	a
4176  0719 4b15          	push	#21
4177  071b ae0016        	ldw	x,#22
4178  071e a604          	ld	a,#4
4179  0720 95            	ld	xh,a
4180  0721 cd00ce        	call	_uart_out
4182  0724 5b05          	addw	sp,#5
4183                     ; 474 					current_byte_in_buffer=0;
4185  0726 5f            	clrw	x
4186  0727 bf0b          	ldw	_current_byte_in_buffer,x
4188  0729 ac3a083a      	jpf	L1771
4189  072d               L7512:
4190                     ; 478 					EE_PAGE_LEN=current_page;
4192  072d be0f          	ldw	x,_current_page
4193  072f 89            	pushw	x
4194  0730 ae0000        	ldw	x,#_EE_PAGE_LEN
4195  0733 cd0000        	call	c_eewrw
4197  0736 85            	popw	x
4198  0737 ac3a083a      	jpf	L1771
4199  073b               L5312:
4200                     ; 490 	else if(UIB[1]==25)
4202  073b c60001        	ld	a,_UIB+1
4203  073e a119          	cp	a,#25
4204  0740 2703          	jreq	L46
4205  0742 cc0822        	jp	L5612
4206  0745               L46:
4207                     ; 494 		current_page=0;
4209  0745 5f            	clrw	x
4210  0746 bf0f          	ldw	_current_page,x
4211                     ; 496 		for(i__=0;i__<EE_PAGE_LEN;i__++)
4213  0748 5f            	clrw	x
4214  0749 1f03          	ldw	(OFST-1,sp),x
4216  074b ac160816      	jpf	L3712
4217  074f               L7612:
4218                     ; 498 			if(memory_manufacturer=='S') {	
4220  074f b6bc          	ld	a,_memory_manufacturer
4221  0751 a153          	cp	a,#83
4222  0753 2619          	jrne	L7712
4223                     ; 499 				DF_page_to_buffer(i__);
4225  0755 1e03          	ldw	x,(OFST-1,sp)
4226  0757 cd0a57        	call	_DF_page_to_buffer
4228                     ; 500 				delay_ms(100);			
4230  075a ae0064        	ldw	x,#100
4231  075d cd005c        	call	_delay_ms
4233                     ; 501 				DF_buffer_read(0,256, buff);
4235  0760 ae0050        	ldw	x,#_buff
4236  0763 89            	pushw	x
4237  0764 ae0100        	ldw	x,#256
4238  0767 89            	pushw	x
4239  0768 5f            	clrw	x
4240  0769 cd0a9d        	call	_DF_buffer_read
4242  076c 5b04          	addw	sp,#4
4243  076e               L7712:
4244                     ; 504 			if(memory_manufacturer=='S') {	
4246  076e b6bc          	ld	a,_memory_manufacturer
4247  0770 a153          	cp	a,#83
4248  0772 261a          	jrne	L1022
4249                     ; 505 				ST_READ((long)(i__*256),256, buff);
4251  0774 ae0050        	ldw	x,#_buff
4252  0777 89            	pushw	x
4253  0778 ae0100        	ldw	x,#256
4254  077b 89            	pushw	x
4255  077c 1e07          	ldw	x,(OFST+3,sp)
4256  077e 4f            	clr	a
4257  077f 02            	rlwa	x,a
4258  0780 cd0000        	call	c_itolx
4260  0783 be02          	ldw	x,c_lreg+2
4261  0785 89            	pushw	x
4262  0786 be00          	ldw	x,c_lreg
4263  0788 89            	pushw	x
4264  0789 cd099b        	call	_ST_READ
4266  078c 5b08          	addw	sp,#8
4267  078e               L1022:
4268                     ; 508 			uart_out_adr_block ((256*i__)+0,buff,64);
4270  078e 4b40          	push	#64
4271  0790 ae0050        	ldw	x,#_buff
4272  0793 89            	pushw	x
4273  0794 1e06          	ldw	x,(OFST+2,sp)
4274  0796 4f            	clr	a
4275  0797 02            	rlwa	x,a
4276  0798 cd0000        	call	c_itolx
4278  079b be02          	ldw	x,c_lreg+2
4279  079d 89            	pushw	x
4280  079e be00          	ldw	x,c_lreg
4281  07a0 89            	pushw	x
4282  07a1 cd0178        	call	_uart_out_adr_block
4284  07a4 5b07          	addw	sp,#7
4285                     ; 509 			delay_ms(100);    
4287  07a6 ae0064        	ldw	x,#100
4288  07a9 cd005c        	call	_delay_ms
4290                     ; 510 			uart_out_adr_block ((256*i__)+64,&buff[64],64);
4292  07ac 4b40          	push	#64
4293  07ae ae0090        	ldw	x,#_buff+64
4294  07b1 89            	pushw	x
4295  07b2 1e06          	ldw	x,(OFST+2,sp)
4296  07b4 4f            	clr	a
4297  07b5 02            	rlwa	x,a
4298  07b6 1c0040        	addw	x,#64
4299  07b9 cd0000        	call	c_itolx
4301  07bc be02          	ldw	x,c_lreg+2
4302  07be 89            	pushw	x
4303  07bf be00          	ldw	x,c_lreg
4304  07c1 89            	pushw	x
4305  07c2 cd0178        	call	_uart_out_adr_block
4307  07c5 5b07          	addw	sp,#7
4308                     ; 511 			delay_ms(100);    
4310  07c7 ae0064        	ldw	x,#100
4311  07ca cd005c        	call	_delay_ms
4313                     ; 512 			uart_out_adr_block ((256*i__)+128,&buff[128],64);
4315  07cd 4b40          	push	#64
4316  07cf ae00d0        	ldw	x,#_buff+128
4317  07d2 89            	pushw	x
4318  07d3 1e06          	ldw	x,(OFST+2,sp)
4319  07d5 4f            	clr	a
4320  07d6 02            	rlwa	x,a
4321  07d7 1c0080        	addw	x,#128
4322  07da cd0000        	call	c_itolx
4324  07dd be02          	ldw	x,c_lreg+2
4325  07df 89            	pushw	x
4326  07e0 be00          	ldw	x,c_lreg
4327  07e2 89            	pushw	x
4328  07e3 cd0178        	call	_uart_out_adr_block
4330  07e6 5b07          	addw	sp,#7
4331                     ; 513 			delay_ms(100);    
4333  07e8 ae0064        	ldw	x,#100
4334  07eb cd005c        	call	_delay_ms
4336                     ; 514 			uart_out_adr_block ((256*i__)+192,&buff[192],64);
4338  07ee 4b40          	push	#64
4339  07f0 ae0110        	ldw	x,#_buff+192
4340  07f3 89            	pushw	x
4341  07f4 1e06          	ldw	x,(OFST+2,sp)
4342  07f6 4f            	clr	a
4343  07f7 02            	rlwa	x,a
4344  07f8 1c00c0        	addw	x,#192
4345  07fb cd0000        	call	c_itolx
4347  07fe be02          	ldw	x,c_lreg+2
4348  0800 89            	pushw	x
4349  0801 be00          	ldw	x,c_lreg
4350  0803 89            	pushw	x
4351  0804 cd0178        	call	_uart_out_adr_block
4353  0807 5b07          	addw	sp,#7
4354                     ; 515 			delay_ms(100);   
4356  0809 ae0064        	ldw	x,#100
4357  080c cd005c        	call	_delay_ms
4359                     ; 496 		for(i__=0;i__<EE_PAGE_LEN;i__++)
4361  080f 1e03          	ldw	x,(OFST-1,sp)
4362  0811 1c0001        	addw	x,#1
4363  0814 1f03          	ldw	(OFST-1,sp),x
4364  0816               L3712:
4367  0816 1e03          	ldw	x,(OFST-1,sp)
4368  0818 c30000        	cpw	x,_EE_PAGE_LEN
4369  081b 2403          	jruge	L66
4370  081d cc074f        	jp	L7612
4371  0820               L66:
4373  0820 2018          	jra	L1771
4374  0822               L5612:
4375                     ; 525 	else if(UIB[1]==30)
4377  0822 c60001        	ld	a,_UIB+1
4378  0825 a11e          	cp	a,#30
4379  0827 2606          	jrne	L5022
4380                     ; 547           bSTART=1;
4382  0829 7210000c      	bset	_bSTART
4384  082d 200b          	jra	L1771
4385  082f               L5022:
4386                     ; 559 	else if(UIB[1]==40)
4388  082f c60001        	ld	a,_UIB+1
4389  0832 a128          	cp	a,#40
4390  0834 2604          	jrne	L1771
4391                     ; 581 		bSTART=1;	
4393  0836 7210000c      	bset	_bSTART
4394  083a               L1771:
4395                     ; 585 }
4398  083a 5b04          	addw	sp,#4
4399  083c 81            	ret
4436                     ; 588 void putchar(char c)
4436                     ; 589 {
4437                     	switch	.text
4438  083d               _putchar:
4440  083d 88            	push	a
4441       00000000      OFST:	set	0
4444  083e               L3322:
4445                     ; 590 while (tx_counter == TX_BUFFER_SIZE);
4447  083e b620          	ld	a,_tx_counter
4448  0840 a150          	cp	a,#80
4449  0842 27fa          	jreq	L3322
4450                     ; 592 if (tx_counter || ((UART1->SR & UART1_SR_TXE)==0))
4452  0844 3d20          	tnz	_tx_counter
4453  0846 2607          	jrne	L1422
4455  0848 c65230        	ld	a,21040
4456  084b a580          	bcp	a,#128
4457  084d 261d          	jrne	L7322
4458  084f               L1422:
4459                     ; 594    tx_buffer[tx_wr_index]=c;
4461  084f 5f            	clrw	x
4462  0850 b61f          	ld	a,_tx_wr_index
4463  0852 2a01          	jrpl	L27
4464  0854 53            	cplw	x
4465  0855               L27:
4466  0855 97            	ld	xl,a
4467  0856 7b01          	ld	a,(OFST+1,sp)
4468  0858 e704          	ld	(_tx_buffer,x),a
4469                     ; 595    if (++tx_wr_index == TX_BUFFER_SIZE) tx_wr_index=0;
4471  085a 3c1f          	inc	_tx_wr_index
4472  085c b61f          	ld	a,_tx_wr_index
4473  085e a150          	cp	a,#80
4474  0860 2602          	jrne	L3422
4477  0862 3f1f          	clr	_tx_wr_index
4478  0864               L3422:
4479                     ; 596    ++tx_counter;
4481  0864 3c20          	inc	_tx_counter
4483  0866               L5422:
4484                     ; 600 UART1->CR2|= UART1_CR2_TIEN;
4486  0866 721e5235      	bset	21045,#7
4487                     ; 602 }
4490  086a 84            	pop	a
4491  086b 81            	ret
4492  086c               L7322:
4493                     ; 598 else UART1->DR=c;
4495  086c 7b01          	ld	a,(OFST+1,sp)
4496  086e c75231        	ld	21041,a
4497  0871 20f3          	jra	L5422
4520                     ; 605 void spi_init(void){
4521                     	switch	.text
4522  0873               _spi_init:
4526                     ; 607 	GPIOA->DDR|=(1<<3);
4528  0873 72165002      	bset	20482,#3
4529                     ; 608 	GPIOA->CR1|=(1<<3);
4531  0877 72165003      	bset	20483,#3
4532                     ; 609 	GPIOA->CR2&=~(1<<3);
4534  087b 72175004      	bres	20484,#3
4535                     ; 610 	GPIOA->ODR|=(1<<3);	
4537  087f 72165000      	bset	20480,#3
4538                     ; 613 	GPIOB->DDR|=(1<<5);
4540  0883 721a5007      	bset	20487,#5
4541                     ; 614 	GPIOB->CR1|=(1<<5);
4543  0887 721a5008      	bset	20488,#5
4544                     ; 615 	GPIOB->CR2&=~(1<<5);
4546  088b 721b5009      	bres	20489,#5
4547                     ; 616 	GPIOB->ODR|=(1<<5);	
4549  088f 721a5005      	bset	20485,#5
4550                     ; 618 	GPIOC->DDR|=(1<<3);
4552  0893 7216500c      	bset	20492,#3
4553                     ; 619 	GPIOC->CR1|=(1<<3);
4555  0897 7216500d      	bset	20493,#3
4556                     ; 620 	GPIOC->CR2&=~(1<<3);
4558  089b 7217500e      	bres	20494,#3
4559                     ; 621 	GPIOC->ODR|=(1<<3);	
4561  089f 7216500a      	bset	20490,#3
4562                     ; 623 	GPIOC->DDR|=(1<<5);
4564  08a3 721a500c      	bset	20492,#5
4565                     ; 624 	GPIOC->CR1|=(1<<5);
4567  08a7 721a500d      	bset	20493,#5
4568                     ; 625 	GPIOC->CR2|=(1<<5);
4570  08ab 721a500e      	bset	20494,#5
4571                     ; 626 	GPIOC->ODR|=(1<<5);	
4573  08af 721a500a      	bset	20490,#5
4574                     ; 628 	GPIOC->DDR|=(1<<6);
4576  08b3 721c500c      	bset	20492,#6
4577                     ; 629 	GPIOC->CR1|=(1<<6);
4579  08b7 721c500d      	bset	20493,#6
4580                     ; 630 	GPIOC->CR2|=(1<<6);
4582  08bb 721c500e      	bset	20494,#6
4583                     ; 631 	GPIOC->ODR|=(1<<6);	
4585  08bf 721c500a      	bset	20490,#6
4586                     ; 633 	GPIOC->DDR&=~(1<<7);
4588  08c3 721f500c      	bres	20492,#7
4589                     ; 634 	GPIOC->CR1&=~(1<<7);
4591  08c7 721f500d      	bres	20493,#7
4592                     ; 635 	GPIOC->CR2&=~(1<<7);
4594  08cb 721f500e      	bres	20494,#7
4595                     ; 636 	GPIOC->ODR|=(1<<7);	
4597  08cf 721e500a      	bset	20490,#7
4598                     ; 638 	SPI->CR1= /*SPI_CR1_LSBFIRST |*/
4598                     ; 639 			SPI_CR1_SPE | 
4598                     ; 640 			( (4<< 3) & SPI_CR1_BR ) |
4598                     ; 641 			SPI_CR1_MSTR |
4598                     ; 642 			SPI_CR1_CPOL |
4598                     ; 643 			SPI_CR1_CPHA; 
4600  08d3 35675200      	mov	20992,#103
4601                     ; 645 	SPI->CR2= SPI_CR2_SSM | SPI_CR2_SSI;
4603  08d7 35035201      	mov	20993,#3
4604                     ; 646 	SPI->ICR= 0;	
4606  08db 725f5202      	clr	20994
4607                     ; 647 }
4610  08df 81            	ret
4653                     ; 650 char spi(char in){
4654                     	switch	.text
4655  08e0               _spi:
4657  08e0 88            	push	a
4658  08e1 88            	push	a
4659       00000001      OFST:	set	1
4662  08e2               L3032:
4663                     ; 652 	while(!((SPI->SR)&SPI_SR_TXE));
4665  08e2 c65203        	ld	a,20995
4666  08e5 a502          	bcp	a,#2
4667  08e7 27f9          	jreq	L3032
4668                     ; 653 	SPI->DR=in;
4670  08e9 7b02          	ld	a,(OFST+1,sp)
4671  08eb c75204        	ld	20996,a
4673  08ee               L3132:
4674                     ; 654 	while(!((SPI->SR)&SPI_SR_RXNE));
4676  08ee c65203        	ld	a,20995
4677  08f1 a501          	bcp	a,#1
4678  08f3 27f9          	jreq	L3132
4679                     ; 655 	c=SPI->DR;	
4681  08f5 c65204        	ld	a,20996
4682  08f8 6b01          	ld	(OFST+0,sp),a
4683                     ; 656 	return c;
4685  08fa 7b01          	ld	a,(OFST+0,sp)
4688  08fc 85            	popw	x
4689  08fd 81            	ret
4754                     ; 660 long ST_RDID_read(void)
4754                     ; 661 {
4755                     	switch	.text
4756  08fe               _ST_RDID_read:
4758  08fe 5204          	subw	sp,#4
4759       00000004      OFST:	set	4
4762                     ; 664 d0=0;
4764  0900 0f04          	clr	(OFST+0,sp)
4765                     ; 665 d1=0;
4767                     ; 666 d2=0;
4769                     ; 667 d3=0;
4771                     ; 669 ST_CS_ON
4773  0902 721b5005      	bres	20485,#5
4774                     ; 670 spi(0x9f);
4776  0906 a69f          	ld	a,#159
4777  0908 add6          	call	_spi
4779                     ; 671 mdr0=spi(0xff);
4781  090a a6ff          	ld	a,#255
4782  090c add2          	call	_spi
4784  090e b716          	ld	_mdr0,a
4785                     ; 672 mdr1=spi(0xff);
4787  0910 a6ff          	ld	a,#255
4788  0912 adcc          	call	_spi
4790  0914 b715          	ld	_mdr1,a
4791                     ; 673 mdr2=spi(0xff);
4793  0916 a6ff          	ld	a,#255
4794  0918 adc6          	call	_spi
4796  091a b714          	ld	_mdr2,a
4797                     ; 676 ST_CS_OFF
4799  091c 721a5005      	bset	20485,#5
4800                     ; 677 return  *((long*)&d0);
4802  0920 96            	ldw	x,sp
4803  0921 1c0004        	addw	x,#OFST+0
4804  0924 cd0000        	call	c_ltor
4808  0927 5b04          	addw	sp,#4
4809  0929 81            	ret
4844                     ; 681 char ST_status_read(void)
4844                     ; 682 {
4845                     	switch	.text
4846  092a               _ST_status_read:
4848  092a 88            	push	a
4849       00000001      OFST:	set	1
4852                     ; 686 ST_CS_ON
4854  092b 721b5005      	bres	20485,#5
4855                     ; 687 spi(0x05);
4857  092f a605          	ld	a,#5
4858  0931 adad          	call	_spi
4860                     ; 688 d0=spi(0xff);
4862  0933 a6ff          	ld	a,#255
4863  0935 ada9          	call	_spi
4865  0937 6b01          	ld	(OFST+0,sp),a
4866                     ; 690 ST_CS_OFF
4868  0939 721a5005      	bset	20485,#5
4869                     ; 691 return d0;
4871  093d 7b01          	ld	a,(OFST+0,sp)
4874  093f 5b01          	addw	sp,#1
4875  0941 81            	ret
4899                     ; 695 void ST_WREN(void)
4899                     ; 696 {
4900                     	switch	.text
4901  0942               _ST_WREN:
4905                     ; 698 ST_CS_ON
4907  0942 721b5005      	bres	20485,#5
4908                     ; 699 spi(0x06);
4910  0946 a606          	ld	a,#6
4911  0948 ad96          	call	_spi
4913                     ; 701 ST_CS_OFF
4915  094a 721a5005      	bset	20485,#5
4916                     ; 702 }  
4919  094e 81            	ret
5009                     ; 705 void ST_WRITE(unsigned long memo_addr,unsigned short len, char* adr)
5009                     ; 706 {
5010                     	switch	.text
5011  094f               _ST_WRITE:
5013  094f 5205          	subw	sp,#5
5014       00000005      OFST:	set	5
5017                     ; 710 adr2=(char)(memo_addr>>16);
5019  0951 7b09          	ld	a,(OFST+4,sp)
5020  0953 6b03          	ld	(OFST-2,sp),a
5021                     ; 711 adr1=(char)((memo_addr>>8)&0x00ff);
5023  0955 7b0a          	ld	a,(OFST+5,sp)
5024  0957 a4ff          	and	a,#255
5025  0959 6b02          	ld	(OFST-3,sp),a
5026                     ; 712 adr0=(char)((memo_addr)&0x00ff);
5028  095b 7b0b          	ld	a,(OFST+6,sp)
5029  095d a4ff          	and	a,#255
5030  095f 6b01          	ld	(OFST-4,sp),a
5031                     ; 713 ST_CS_ON
5033  0961 721b5005      	bres	20485,#5
5034                     ; 714 spi(0x0a);
5036  0965 a60a          	ld	a,#10
5037  0967 cd08e0        	call	_spi
5039                     ; 715 spi(adr2);
5041  096a 7b03          	ld	a,(OFST-2,sp)
5042  096c cd08e0        	call	_spi
5044                     ; 716 spi(adr1);
5046  096f 7b02          	ld	a,(OFST-3,sp)
5047  0971 cd08e0        	call	_spi
5049                     ; 717 spi(adr0);
5051  0974 7b01          	ld	a,(OFST-4,sp)
5052  0976 cd08e0        	call	_spi
5054                     ; 719 for(i=0;i<len;i++)
5056  0979 5f            	clrw	x
5057  097a 1f04          	ldw	(OFST-1,sp),x
5059  097c 2010          	jra	L1542
5060  097e               L5442:
5061                     ; 721 	spi(adr[i]);
5063  097e 1e0e          	ldw	x,(OFST+9,sp)
5064  0980 72fb04        	addw	x,(OFST-1,sp)
5065  0983 f6            	ld	a,(x)
5066  0984 cd08e0        	call	_spi
5068                     ; 719 for(i=0;i<len;i++)
5070  0987 1e04          	ldw	x,(OFST-1,sp)
5071  0989 1c0001        	addw	x,#1
5072  098c 1f04          	ldw	(OFST-1,sp),x
5073  098e               L1542:
5076  098e 1e04          	ldw	x,(OFST-1,sp)
5077  0990 130c          	cpw	x,(OFST+7,sp)
5078  0992 25ea          	jrult	L5442
5079                     ; 724 ST_CS_OFF
5081  0994 721a5005      	bset	20485,#5
5082                     ; 725 }
5085  0998 5b05          	addw	sp,#5
5086  099a 81            	ret
5176                     ; 728 void ST_READ(unsigned long memo_addr,unsigned short len, char* adr)
5176                     ; 729 {
5177                     	switch	.text
5178  099b               _ST_READ:
5180  099b 5205          	subw	sp,#5
5181       00000005      OFST:	set	5
5184                     ; 735 adr2=(char)(memo_addr>>16);
5186  099d 7b09          	ld	a,(OFST+4,sp)
5187  099f 6b03          	ld	(OFST-2,sp),a
5188                     ; 736 adr1=(char)((memo_addr>>8)&0x00ff);
5190  09a1 7b0a          	ld	a,(OFST+5,sp)
5191  09a3 a4ff          	and	a,#255
5192  09a5 6b02          	ld	(OFST-3,sp),a
5193                     ; 737 adr0=(char)((memo_addr)&0x00ff);
5195  09a7 7b0b          	ld	a,(OFST+6,sp)
5196  09a9 a4ff          	and	a,#255
5197  09ab 6b01          	ld	(OFST-4,sp),a
5198                     ; 738 ST_CS_ON
5200  09ad 721b5005      	bres	20485,#5
5201                     ; 739 spi(0x03);
5203  09b1 a603          	ld	a,#3
5204  09b3 cd08e0        	call	_spi
5206                     ; 740 spi(adr2);
5208  09b6 7b03          	ld	a,(OFST-2,sp)
5209  09b8 cd08e0        	call	_spi
5211                     ; 741 spi(adr1);
5213  09bb 7b02          	ld	a,(OFST-3,sp)
5214  09bd cd08e0        	call	_spi
5216                     ; 742 spi(adr0);
5218  09c0 7b01          	ld	a,(OFST-4,sp)
5219  09c2 cd08e0        	call	_spi
5221                     ; 744 for(i=0;i<len;i++)
5223  09c5 5f            	clrw	x
5224  09c6 1f04          	ldw	(OFST-1,sp),x
5226  09c8 2012          	jra	L7252
5227  09ca               L3252:
5228                     ; 746 	adr[i]=spi(0xff);
5230  09ca a6ff          	ld	a,#255
5231  09cc cd08e0        	call	_spi
5233  09cf 1e0e          	ldw	x,(OFST+9,sp)
5234  09d1 72fb04        	addw	x,(OFST-1,sp)
5235  09d4 f7            	ld	(x),a
5236                     ; 744 for(i=0;i<len;i++)
5238  09d5 1e04          	ldw	x,(OFST-1,sp)
5239  09d7 1c0001        	addw	x,#1
5240  09da 1f04          	ldw	(OFST-1,sp),x
5241  09dc               L7252:
5244  09dc 1e04          	ldw	x,(OFST-1,sp)
5245  09de 130c          	cpw	x,(OFST+7,sp)
5246  09e0 25e8          	jrult	L3252
5247                     ; 749 ST_CS_OFF
5249  09e2 721a5005      	bset	20485,#5
5250                     ; 750 }
5253  09e6 5b05          	addw	sp,#5
5254  09e8 81            	ret
5320                     ; 754 long DF_mf_dev_read(void)
5320                     ; 755 {
5321                     	switch	.text
5322  09e9               _DF_mf_dev_read:
5324  09e9 5204          	subw	sp,#4
5325       00000004      OFST:	set	4
5328                     ; 758 d0=0;
5330  09eb 0f04          	clr	(OFST+0,sp)
5331                     ; 759 d1=0;
5333                     ; 760 d2=0;
5335                     ; 761 d3=0;
5337                     ; 763 CS_ON
5339  09ed 7217500a      	bres	20490,#3
5340                     ; 764 spi(0x9f);
5342  09f1 a69f          	ld	a,#159
5343  09f3 cd08e0        	call	_spi
5345                     ; 765 mdr0=spi(0xff);
5347  09f6 a6ff          	ld	a,#255
5348  09f8 cd08e0        	call	_spi
5350  09fb b716          	ld	_mdr0,a
5351                     ; 766 mdr1=spi(0xff);
5353  09fd a6ff          	ld	a,#255
5354  09ff cd08e0        	call	_spi
5356  0a02 b715          	ld	_mdr1,a
5357                     ; 767 mdr2=spi(0xff);
5359  0a04 a6ff          	ld	a,#255
5360  0a06 cd08e0        	call	_spi
5362  0a09 b714          	ld	_mdr2,a
5363                     ; 768 mdr3=spi(0xff);  
5365  0a0b a6ff          	ld	a,#255
5366  0a0d cd08e0        	call	_spi
5368  0a10 b713          	ld	_mdr3,a
5369                     ; 770 CS_OFF
5371  0a12 7216500a      	bset	20490,#3
5372                     ; 771 return  *((long*)&d0);
5374  0a16 96            	ldw	x,sp
5375  0a17 1c0004        	addw	x,#OFST+0
5376  0a1a cd0000        	call	c_ltor
5380  0a1d 5b04          	addw	sp,#4
5381  0a1f 81            	ret
5405                     ; 775 void DF_memo_to_256(void)
5405                     ; 776 {
5406                     	switch	.text
5407  0a20               _DF_memo_to_256:
5411                     ; 778 CS_ON
5413  0a20 7217500a      	bres	20490,#3
5414                     ; 779 spi(0x3d);
5416  0a24 a63d          	ld	a,#61
5417  0a26 cd08e0        	call	_spi
5419                     ; 780 spi(0x2a); 
5421  0a29 a62a          	ld	a,#42
5422  0a2b cd08e0        	call	_spi
5424                     ; 781 spi(0x80);
5426  0a2e a680          	ld	a,#128
5427  0a30 cd08e0        	call	_spi
5429                     ; 782 spi(0xa6);
5431  0a33 a6a6          	ld	a,#166
5432  0a35 cd08e0        	call	_spi
5434                     ; 784 CS_OFF
5436  0a38 7216500a      	bset	20490,#3
5437                     ; 785 }  
5440  0a3c 81            	ret
5475                     ; 790 char DF_status_read(void)
5475                     ; 791 {
5476                     	switch	.text
5477  0a3d               _DF_status_read:
5479  0a3d 88            	push	a
5480       00000001      OFST:	set	1
5483                     ; 795 CS_ON
5485  0a3e 7217500a      	bres	20490,#3
5486                     ; 796 spi(0xd7);
5488  0a42 a6d7          	ld	a,#215
5489  0a44 cd08e0        	call	_spi
5491                     ; 797 d0=spi(0xff);
5493  0a47 a6ff          	ld	a,#255
5494  0a49 cd08e0        	call	_spi
5496  0a4c 6b01          	ld	(OFST+0,sp),a
5497                     ; 799 CS_OFF
5499  0a4e 7216500a      	bset	20490,#3
5500                     ; 800 return d0;
5502  0a52 7b01          	ld	a,(OFST+0,sp)
5505  0a54 5b01          	addw	sp,#1
5506  0a56 81            	ret
5550                     ; 804 void DF_page_to_buffer(unsigned page_addr)
5550                     ; 805 {
5551                     	switch	.text
5552  0a57               _DF_page_to_buffer:
5554  0a57 89            	pushw	x
5555  0a58 88            	push	a
5556       00000001      OFST:	set	1
5559                     ; 808 d0=0x53; 
5561                     ; 812 CS_ON
5563  0a59 7217500a      	bres	20490,#3
5564                     ; 813 spi(d0);
5566  0a5d a653          	ld	a,#83
5567  0a5f cd08e0        	call	_spi
5569                     ; 814 spi(page_addr/256/**(((char*)&page_addr)+1)*/);
5571  0a62 7b02          	ld	a,(OFST+1,sp)
5572  0a64 cd08e0        	call	_spi
5574                     ; 815 spi(page_addr%256/**((char*)&page_addr)*/);
5576  0a67 7b03          	ld	a,(OFST+2,sp)
5577  0a69 a4ff          	and	a,#255
5578  0a6b cd08e0        	call	_spi
5580                     ; 816 spi(0xff);
5582  0a6e a6ff          	ld	a,#255
5583  0a70 cd08e0        	call	_spi
5585                     ; 818 CS_OFF
5587  0a73 7216500a      	bset	20490,#3
5588                     ; 819 }
5591  0a77 5b03          	addw	sp,#3
5592  0a79 81            	ret
5637                     ; 822 void DF_buffer_to_page_er(/*char buff,*/unsigned page_addr)
5637                     ; 823 {
5638                     	switch	.text
5639  0a7a               _DF_buffer_to_page_er:
5641  0a7a 89            	pushw	x
5642  0a7b 88            	push	a
5643       00000001      OFST:	set	1
5646                     ; 826 d0=0x83; 
5648                     ; 829 CS_ON
5650  0a7c 7217500a      	bres	20490,#3
5651                     ; 830 spi(d0);
5653  0a80 a683          	ld	a,#131
5654  0a82 cd08e0        	call	_spi
5656                     ; 831 spi(page_addr/256/**(((char*)&page_addr)+1)*/);
5658  0a85 7b02          	ld	a,(OFST+1,sp)
5659  0a87 cd08e0        	call	_spi
5661                     ; 832 spi(page_addr%256/**((char*)&page_addr)*/);
5663  0a8a 7b03          	ld	a,(OFST+2,sp)
5664  0a8c a4ff          	and	a,#255
5665  0a8e cd08e0        	call	_spi
5667                     ; 833 spi(0xff);
5669  0a91 a6ff          	ld	a,#255
5670  0a93 cd08e0        	call	_spi
5672                     ; 835 CS_OFF
5674  0a96 7216500a      	bset	20490,#3
5675                     ; 836 }
5678  0a9a 5b03          	addw	sp,#3
5679  0a9c 81            	ret
5751                     ; 839 void DF_buffer_read(unsigned buff_addr,unsigned len, char* adr)
5751                     ; 840 {
5752                     	switch	.text
5753  0a9d               _DF_buffer_read:
5755  0a9d 89            	pushw	x
5756  0a9e 5203          	subw	sp,#3
5757       00000003      OFST:	set	3
5760                     ; 844 d0=0x54; 
5762                     ; 846 CS_ON
5764  0aa0 7217500a      	bres	20490,#3
5765                     ; 847 spi(d0);
5767  0aa4 a654          	ld	a,#84
5768  0aa6 cd08e0        	call	_spi
5770                     ; 848 spi(0xff);
5772  0aa9 a6ff          	ld	a,#255
5773  0aab cd08e0        	call	_spi
5775                     ; 849 spi(buff_addr/256/**(((char*)&buff_addr)+1)*/);
5777  0aae 7b04          	ld	a,(OFST+1,sp)
5778  0ab0 cd08e0        	call	_spi
5780                     ; 850 spi(buff_addr%256/**((char*)&buff_addr)*/);
5782  0ab3 7b05          	ld	a,(OFST+2,sp)
5783  0ab5 a4ff          	and	a,#255
5784  0ab7 cd08e0        	call	_spi
5786                     ; 851 spi(0xff);
5788  0aba a6ff          	ld	a,#255
5789  0abc cd08e0        	call	_spi
5791                     ; 852 for(i=0;i<len;i++)
5793  0abf 5f            	clrw	x
5794  0ac0 1f02          	ldw	(OFST-1,sp),x
5796  0ac2 2012          	jra	L1272
5797  0ac4               L5172:
5798                     ; 854 	adr[i]=spi(0xff);
5800  0ac4 a6ff          	ld	a,#255
5801  0ac6 cd08e0        	call	_spi
5803  0ac9 1e0a          	ldw	x,(OFST+7,sp)
5804  0acb 72fb02        	addw	x,(OFST-1,sp)
5805  0ace f7            	ld	(x),a
5806                     ; 852 for(i=0;i<len;i++)
5808  0acf 1e02          	ldw	x,(OFST-1,sp)
5809  0ad1 1c0001        	addw	x,#1
5810  0ad4 1f02          	ldw	(OFST-1,sp),x
5811  0ad6               L1272:
5814  0ad6 1e02          	ldw	x,(OFST-1,sp)
5815  0ad8 1308          	cpw	x,(OFST+5,sp)
5816  0ada 25e8          	jrult	L5172
5817                     ; 857 CS_OFF
5819  0adc 7216500a      	bset	20490,#3
5820                     ; 858 }
5823  0ae0 5b05          	addw	sp,#5
5824  0ae2 81            	ret
5896                     ; 861 void DF_buffer_write(/*char buff,*/unsigned buff_addr,unsigned len, char* adr)
5896                     ; 862 {
5897                     	switch	.text
5898  0ae3               _DF_buffer_write:
5900  0ae3 89            	pushw	x
5901  0ae4 5203          	subw	sp,#3
5902       00000003      OFST:	set	3
5905                     ; 866 d0=0x84; 
5907                     ; 868 CS_ON
5909  0ae6 7217500a      	bres	20490,#3
5910                     ; 869 spi(d0);
5912  0aea a684          	ld	a,#132
5913  0aec cd08e0        	call	_spi
5915                     ; 870 spi(0xff);
5917  0aef a6ff          	ld	a,#255
5918  0af1 cd08e0        	call	_spi
5920                     ; 871 spi(buff_addr/256/**(((char*)&buff_addr)+1)*/);
5922  0af4 7b04          	ld	a,(OFST+1,sp)
5923  0af6 cd08e0        	call	_spi
5925                     ; 872 spi(buff_addr%256/**((char*)&buff_addr)*/);
5927  0af9 7b05          	ld	a,(OFST+2,sp)
5928  0afb a4ff          	and	a,#255
5929  0afd cd08e0        	call	_spi
5931                     ; 874 for(i=0;i<len;i++)
5933  0b00 5f            	clrw	x
5934  0b01 1f02          	ldw	(OFST-1,sp),x
5936  0b03 2010          	jra	L7672
5937  0b05               L3672:
5938                     ; 876 	spi(adr[i]);
5940  0b05 1e0a          	ldw	x,(OFST+7,sp)
5941  0b07 72fb02        	addw	x,(OFST-1,sp)
5942  0b0a f6            	ld	a,(x)
5943  0b0b cd08e0        	call	_spi
5945                     ; 874 for(i=0;i<len;i++)
5947  0b0e 1e02          	ldw	x,(OFST-1,sp)
5948  0b10 1c0001        	addw	x,#1
5949  0b13 1f02          	ldw	(OFST-1,sp),x
5950  0b15               L7672:
5953  0b15 1e02          	ldw	x,(OFST-1,sp)
5954  0b17 1308          	cpw	x,(OFST+5,sp)
5955  0b19 25ea          	jrult	L3672
5956                     ; 879 CS_OFF
5958  0b1b 7216500a      	bset	20490,#3
5959                     ; 880 }
5962  0b1f 5b05          	addw	sp,#5
5963  0b21 81            	ret
5986                     ; 902 void gpio_init(void){
5987                     	switch	.text
5988  0b22               _gpio_init:
5992                     ; 912 	GPIOD->DDR|=(1<<2);
5994  0b22 72145011      	bset	20497,#2
5995                     ; 913 	GPIOD->CR1|=(1<<2);
5997  0b26 72145012      	bset	20498,#2
5998                     ; 914 	GPIOD->CR2|=(1<<2);
6000  0b2a 72145013      	bset	20499,#2
6001                     ; 915 	GPIOD->ODR&=~(1<<2);
6003  0b2e 7215500f      	bres	20495,#2
6004                     ; 917 	GPIOD->DDR|=(1<<4);
6006  0b32 72185011      	bset	20497,#4
6007                     ; 918 	GPIOD->CR1|=(1<<4);
6009  0b36 72185012      	bset	20498,#4
6010                     ; 919 	GPIOD->CR2&=~(1<<4);
6012  0b3a 72195013      	bres	20499,#4
6013                     ; 921 	GPIOC->DDR&=~(1<<4);
6015  0b3e 7219500c      	bres	20492,#4
6016                     ; 922 	GPIOC->CR1&=~(1<<4);
6018  0b42 7219500d      	bres	20493,#4
6019                     ; 923 	GPIOC->CR2&=~(1<<4);
6021  0b46 7219500e      	bres	20494,#4
6022                     ; 927 }
6025  0b4a 81            	ret
6077                     ; 930 void uart_in(void)
6077                     ; 931 {
6078                     	switch	.text
6079  0b4b               _uart_in:
6081  0b4b 89            	pushw	x
6082       00000002      OFST:	set	2
6085                     ; 935 if(rx_buffer_overflow)
6087                     	btst	_rx_buffer_overflow
6088  0b51 240d          	jruge	L5203
6089                     ; 937 	rx_wr_index=0;
6091  0b53 5f            	clrw	x
6092  0b54 bf1a          	ldw	_rx_wr_index,x
6093                     ; 938 	rx_rd_index=0;
6095  0b56 5f            	clrw	x
6096  0b57 bf18          	ldw	_rx_rd_index,x
6097                     ; 939 	rx_counter=0;
6099  0b59 5f            	clrw	x
6100  0b5a bf1c          	ldw	_rx_counter,x
6101                     ; 940 	rx_buffer_overflow=0;
6103  0b5c 72110001      	bres	_rx_buffer_overflow
6104  0b60               L5203:
6105                     ; 943 if(rx_counter&&(rx_buffer[index_offset(rx_wr_index,-1)])==END)
6107  0b60 be1c          	ldw	x,_rx_counter
6108  0b62 2775          	jreq	L7203
6110  0b64 aeffff        	ldw	x,#65535
6111  0b67 89            	pushw	x
6112  0b68 be1a          	ldw	x,_rx_wr_index
6113  0b6a ad6f          	call	_index_offset
6115  0b6c 5b02          	addw	sp,#2
6116  0b6e e654          	ld	a,(_rx_buffer,x)
6117  0b70 a10a          	cp	a,#10
6118  0b72 2665          	jrne	L7203
6119                     ; 948 	temp=rx_buffer[index_offset(rx_wr_index,-3)];
6121  0b74 aefffd        	ldw	x,#65533
6122  0b77 89            	pushw	x
6123  0b78 be1a          	ldw	x,_rx_wr_index
6124  0b7a ad5f          	call	_index_offset
6126  0b7c 5b02          	addw	sp,#2
6127  0b7e e654          	ld	a,(_rx_buffer,x)
6128  0b80 6b01          	ld	(OFST-1,sp),a
6129                     ; 949     	if(temp<100) 
6131  0b82 7b01          	ld	a,(OFST-1,sp)
6132  0b84 a164          	cp	a,#100
6133  0b86 2451          	jruge	L7203
6134                     ; 952     		if(control_check(index_offset(rx_wr_index,-1)))
6136  0b88 aeffff        	ldw	x,#65535
6137  0b8b 89            	pushw	x
6138  0b8c be1a          	ldw	x,_rx_wr_index
6139  0b8e ad4b          	call	_index_offset
6141  0b90 5b02          	addw	sp,#2
6142  0b92 9f            	ld	a,xl
6143  0b93 ad6e          	call	_control_check
6145  0b95 4d            	tnz	a
6146  0b96 2741          	jreq	L7203
6147                     ; 955     			rx_rd_index=index_offset(rx_wr_index,-3-temp);
6149  0b98 a6ff          	ld	a,#255
6150  0b9a 97            	ld	xl,a
6151  0b9b a6fd          	ld	a,#253
6152  0b9d 1001          	sub	a,(OFST-1,sp)
6153  0b9f 2401          	jrnc	L431
6154  0ba1 5a            	decw	x
6155  0ba2               L431:
6156  0ba2 02            	rlwa	x,a
6157  0ba3 89            	pushw	x
6158  0ba4 01            	rrwa	x,a
6159  0ba5 be1a          	ldw	x,_rx_wr_index
6160  0ba7 ad32          	call	_index_offset
6162  0ba9 5b02          	addw	sp,#2
6163  0bab bf18          	ldw	_rx_rd_index,x
6164                     ; 956     			for(i=0;i<temp;i++)
6166  0bad 0f02          	clr	(OFST+0,sp)
6168  0baf 2018          	jra	L1403
6169  0bb1               L5303:
6170                     ; 958 				UIB[i]=rx_buffer[index_offset(rx_rd_index,i)];
6172  0bb1 7b02          	ld	a,(OFST+0,sp)
6173  0bb3 5f            	clrw	x
6174  0bb4 97            	ld	xl,a
6175  0bb5 89            	pushw	x
6176  0bb6 7b04          	ld	a,(OFST+2,sp)
6177  0bb8 5f            	clrw	x
6178  0bb9 97            	ld	xl,a
6179  0bba 89            	pushw	x
6180  0bbb be18          	ldw	x,_rx_rd_index
6181  0bbd ad1c          	call	_index_offset
6183  0bbf 5b02          	addw	sp,#2
6184  0bc1 e654          	ld	a,(_rx_buffer,x)
6185  0bc3 85            	popw	x
6186  0bc4 d70000        	ld	(_UIB,x),a
6187                     ; 956     			for(i=0;i<temp;i++)
6189  0bc7 0c02          	inc	(OFST+0,sp)
6190  0bc9               L1403:
6193  0bc9 7b02          	ld	a,(OFST+0,sp)
6194  0bcb 1101          	cp	a,(OFST-1,sp)
6195  0bcd 25e2          	jrult	L5303
6196                     ; 960 			rx_rd_index=rx_wr_index;
6198  0bcf be1a          	ldw	x,_rx_wr_index
6199  0bd1 bf18          	ldw	_rx_rd_index,x
6200                     ; 961 			rx_counter=0;
6202  0bd3 5f            	clrw	x
6203  0bd4 bf1c          	ldw	_rx_counter,x
6204                     ; 971 			uart_in_an();
6206  0bd6 cd0238        	call	_uart_in_an
6208  0bd9               L7203:
6209                     ; 980 }
6212  0bd9 85            	popw	x
6213  0bda 81            	ret
6256                     ; 983 signed short index_offset (signed short index,signed short offset)
6256                     ; 984 {
6257                     	switch	.text
6258  0bdb               _index_offset:
6260  0bdb 89            	pushw	x
6261       00000000      OFST:	set	0
6264                     ; 985 index=index+offset;
6266  0bdc 1e01          	ldw	x,(OFST+1,sp)
6267  0bde 72fb05        	addw	x,(OFST+5,sp)
6268  0be1 1f01          	ldw	(OFST+1,sp),x
6269                     ; 986 if(index>=RX_BUFFER_SIZE) index-=RX_BUFFER_SIZE; 
6271  0be3 9c            	rvf
6272  0be4 1e01          	ldw	x,(OFST+1,sp)
6273  0be6 a30064        	cpw	x,#100
6274  0be9 2f07          	jrslt	L7603
6277  0beb 1e01          	ldw	x,(OFST+1,sp)
6278  0bed 1d0064        	subw	x,#100
6279  0bf0 1f01          	ldw	(OFST+1,sp),x
6280  0bf2               L7603:
6281                     ; 987 if(index<0) index+=RX_BUFFER_SIZE;
6283  0bf2 9c            	rvf
6284  0bf3 1e01          	ldw	x,(OFST+1,sp)
6285  0bf5 2e07          	jrsge	L1703
6288  0bf7 1e01          	ldw	x,(OFST+1,sp)
6289  0bf9 1c0064        	addw	x,#100
6290  0bfc 1f01          	ldw	(OFST+1,sp),x
6291  0bfe               L1703:
6292                     ; 988 return index;
6294  0bfe 1e01          	ldw	x,(OFST+1,sp)
6297  0c00 5b02          	addw	sp,#2
6298  0c02 81            	ret
6361                     ; 992 char control_check(char index)
6361                     ; 993 {
6362                     	switch	.text
6363  0c03               _control_check:
6365  0c03 88            	push	a
6366  0c04 5203          	subw	sp,#3
6367       00000003      OFST:	set	3
6370                     ; 994 char i=0,ii=0,iii;
6374                     ; 996 if(rx_buffer[index]!=END) return 0;
6376  0c06 5f            	clrw	x
6377  0c07 97            	ld	xl,a
6378  0c08 e654          	ld	a,(_rx_buffer,x)
6379  0c0a a10a          	cp	a,#10
6380  0c0c 2703          	jreq	L5213
6383  0c0e 4f            	clr	a
6385  0c0f 2051          	jra	L641
6386  0c11               L5213:
6387                     ; 998 ii=rx_buffer[index_offset(index,-2)];
6389  0c11 aefffe        	ldw	x,#65534
6390  0c14 89            	pushw	x
6391  0c15 7b06          	ld	a,(OFST+3,sp)
6392  0c17 5f            	clrw	x
6393  0c18 97            	ld	xl,a
6394  0c19 adc0          	call	_index_offset
6396  0c1b 5b02          	addw	sp,#2
6397  0c1d e654          	ld	a,(_rx_buffer,x)
6398  0c1f 6b02          	ld	(OFST-1,sp),a
6399                     ; 999 iii=0;
6401  0c21 0f01          	clr	(OFST-2,sp)
6402                     ; 1000 for(i=0;i<=ii;i++)
6404  0c23 0f03          	clr	(OFST+0,sp)
6406  0c25 2022          	jra	L3313
6407  0c27               L7213:
6408                     ; 1002 	iii^=rx_buffer[index_offset(index,-2-ii+i)];
6410  0c27 a6ff          	ld	a,#255
6411  0c29 97            	ld	xl,a
6412  0c2a a6fe          	ld	a,#254
6413  0c2c 1002          	sub	a,(OFST-1,sp)
6414  0c2e 2401          	jrnc	L241
6415  0c30 5a            	decw	x
6416  0c31               L241:
6417  0c31 1b03          	add	a,(OFST+0,sp)
6418  0c33 2401          	jrnc	L441
6419  0c35 5c            	incw	x
6420  0c36               L441:
6421  0c36 02            	rlwa	x,a
6422  0c37 89            	pushw	x
6423  0c38 01            	rrwa	x,a
6424  0c39 7b06          	ld	a,(OFST+3,sp)
6425  0c3b 5f            	clrw	x
6426  0c3c 97            	ld	xl,a
6427  0c3d ad9c          	call	_index_offset
6429  0c3f 5b02          	addw	sp,#2
6430  0c41 7b01          	ld	a,(OFST-2,sp)
6431  0c43 e854          	xor	a,	(_rx_buffer,x)
6432  0c45 6b01          	ld	(OFST-2,sp),a
6433                     ; 1000 for(i=0;i<=ii;i++)
6435  0c47 0c03          	inc	(OFST+0,sp)
6436  0c49               L3313:
6439  0c49 7b03          	ld	a,(OFST+0,sp)
6440  0c4b 1102          	cp	a,(OFST-1,sp)
6441  0c4d 23d8          	jrule	L7213
6442                     ; 1004 if (iii!=rx_buffer[index_offset(index,-1)]) return 0;	
6444  0c4f aeffff        	ldw	x,#65535
6445  0c52 89            	pushw	x
6446  0c53 7b06          	ld	a,(OFST+3,sp)
6447  0c55 5f            	clrw	x
6448  0c56 97            	ld	xl,a
6449  0c57 ad82          	call	_index_offset
6451  0c59 5b02          	addw	sp,#2
6452  0c5b e654          	ld	a,(_rx_buffer,x)
6453  0c5d 1101          	cp	a,(OFST-2,sp)
6454  0c5f 2704          	jreq	L7313
6457  0c61 4f            	clr	a
6459  0c62               L641:
6461  0c62 5b04          	addw	sp,#4
6462  0c64 81            	ret
6463  0c65               L7313:
6464                     ; 1006 return 1;
6466  0c65 a601          	ld	a,#1
6468  0c67 20f9          	jra	L641
6510                     ; 1015 @far @interrupt void TIM4_UPD_Interrupt (void) {
6512                     	switch	.text
6513  0c69               f_TIM4_UPD_Interrupt:
6517                     ; 1017 	if(play) {
6519                     	btst	_play
6520  0c6e 2445          	jruge	L1513
6521                     ; 1018 		TIM2->CCR3H= 0x00;	
6523  0c70 725f5315      	clr	21269
6524                     ; 1019 		TIM2->CCR3L= sample;
6526  0c74 5500175316    	mov	21270,_sample
6527                     ; 1020 		sample_cnt++;
6529  0c79 be21          	ldw	x,_sample_cnt
6530  0c7b 1c0001        	addw	x,#1
6531  0c7e bf21          	ldw	_sample_cnt,x
6532                     ; 1021 		if(sample_cnt>=256) {
6534  0c80 9c            	rvf
6535  0c81 be21          	ldw	x,_sample_cnt
6536  0c83 a30100        	cpw	x,#256
6537  0c86 2f03          	jrslt	L3513
6538                     ; 1022 			sample_cnt=0;
6540  0c88 5f            	clrw	x
6541  0c89 bf21          	ldw	_sample_cnt,x
6542  0c8b               L3513:
6543                     ; 1026 		sample=buff[sample_cnt];
6545  0c8b be21          	ldw	x,_sample_cnt
6546  0c8d d60050        	ld	a,(_buff,x)
6547  0c90 b717          	ld	_sample,a
6548                     ; 1028 		if(sample_cnt==132)	{
6550  0c92 be21          	ldw	x,_sample_cnt
6551  0c94 a30084        	cpw	x,#132
6552  0c97 2604          	jrne	L5513
6553                     ; 1029 			bBUFF_LOAD=1;
6555  0c99 7210000b      	bset	_bBUFF_LOAD
6556  0c9d               L5513:
6557                     ; 1033 		if(sample_cnt==5) {
6559  0c9d be21          	ldw	x,_sample_cnt
6560  0c9f a30005        	cpw	x,#5
6561  0ca2 2604          	jrne	L7513
6562                     ; 1034 			bBUFF_READ_H=1;
6564  0ca4 7210000a      	bset	_bBUFF_READ_H
6565  0ca8               L7513:
6566                     ; 1037 		if(sample_cnt==150) {
6568  0ca8 be21          	ldw	x,_sample_cnt
6569  0caa a30096        	cpw	x,#150
6570  0cad 2615          	jrne	L3613
6571                     ; 1038 			bBUFF_READ_L=1;
6573  0caf 72100009      	bset	_bBUFF_READ_L
6574  0cb3 200f          	jra	L3613
6575  0cb5               L1513:
6576                     ; 1045 	else if(!bSTART) {
6578                     	btst	_bSTART
6579  0cba 2508          	jrult	L3613
6580                     ; 1046 		TIM2->CCR3H= 0x00;	
6582  0cbc 725f5315      	clr	21269
6583                     ; 1047 		TIM2->CCR3L= 0x7f;//pwm_fade_in;
6585  0cc0 357f5316      	mov	21270,#127
6586  0cc4               L3613:
6587                     ; 1102 		if(but_block_cnt)but_on_drv_cnt=0;
6589  0cc4 be00          	ldw	x,_but_block_cnt
6590  0cc6 2702          	jreq	L7613
6593  0cc8 3fb9          	clr	_but_on_drv_cnt
6594  0cca               L7613:
6595                     ; 1103 		if((((GPIOC->IDR)&(1<<4))) && (but_on_drv_cnt<100)) {
6597  0cca c6500b        	ld	a,20491
6598  0ccd a510          	bcp	a,#16
6599  0ccf 271f          	jreq	L1713
6601  0cd1 b6b9          	ld	a,_but_on_drv_cnt
6602  0cd3 a164          	cp	a,#100
6603  0cd5 2419          	jruge	L1713
6604                     ; 1104 			but_on_drv_cnt++;
6606  0cd7 3cb9          	inc	_but_on_drv_cnt
6607                     ; 1105 			if((but_on_drv_cnt>2)&&(bRELEASE))
6609  0cd9 b6b9          	ld	a,_but_on_drv_cnt
6610  0cdb a103          	cp	a,#3
6611  0cdd 2517          	jrult	L5713
6613                     	btst	_bRELEASE
6614  0ce4 2410          	jruge	L5713
6615                     ; 1107 				bRELEASE=0;
6617  0ce6 72110000      	bres	_bRELEASE
6618                     ; 1108 				bSTART=1;
6620  0cea 7210000c      	bset	_bSTART
6621  0cee 2006          	jra	L5713
6622  0cf0               L1713:
6623                     ; 1112 			but_on_drv_cnt=0;
6625  0cf0 3fb9          	clr	_but_on_drv_cnt
6626                     ; 1113 			bRELEASE=1;
6628  0cf2 72100000      	bset	_bRELEASE
6629  0cf6               L5713:
6630                     ; 1118 	if(++t0_cnt0>=125){
6632  0cf6 3c00          	inc	_t0_cnt0
6633  0cf8 b600          	ld	a,_t0_cnt0
6634  0cfa a17d          	cp	a,#125
6635  0cfc 2530          	jrult	L7713
6636                     ; 1119     		t0_cnt0=0;
6638  0cfe 3f00          	clr	_t0_cnt0
6639                     ; 1120     		b100Hz=1;
6641  0d00 72100008      	bset	_b100Hz
6642                     ; 1130 		if(++t0_cnt1>=10){
6644  0d04 3c01          	inc	_t0_cnt1
6645  0d06 b601          	ld	a,_t0_cnt1
6646  0d08 a10a          	cp	a,#10
6647  0d0a 2506          	jrult	L1023
6648                     ; 1131 			t0_cnt1=0;
6650  0d0c 3f01          	clr	_t0_cnt1
6651                     ; 1132 			b10Hz=1;
6653  0d0e 72100007      	bset	_b10Hz
6654  0d12               L1023:
6655                     ; 1135 		if(++t0_cnt2>=20){
6657  0d12 3c02          	inc	_t0_cnt2
6658  0d14 b602          	ld	a,_t0_cnt2
6659  0d16 a114          	cp	a,#20
6660  0d18 2506          	jrult	L3023
6661                     ; 1136 			t0_cnt2=0;
6663  0d1a 3f02          	clr	_t0_cnt2
6664                     ; 1137 			b5Hz=1;
6666  0d1c 72100006      	bset	_b5Hz
6667  0d20               L3023:
6668                     ; 1140 		if(++t0_cnt3>=100){
6670  0d20 3c03          	inc	_t0_cnt3
6671  0d22 b603          	ld	a,_t0_cnt3
6672  0d24 a164          	cp	a,#100
6673  0d26 2506          	jrult	L7713
6674                     ; 1141 			t0_cnt3=0;
6676  0d28 3f03          	clr	_t0_cnt3
6677                     ; 1142 			b1Hz=1;
6679  0d2a 72100005      	bset	_b1Hz
6680  0d2e               L7713:
6681                     ; 1146 	TIM4->SR1&=~TIM4_SR1_UIF;			// disable break interrupt
6683  0d2e 72115344      	bres	21316,#0
6684                     ; 1147 	return;
6687  0d32 80            	iret
6713                     ; 1151 @far @interrupt void UARTTxInterrupt (void) {
6714                     	switch	.text
6715  0d33               f_UARTTxInterrupt:
6719                     ; 1153 	if (tx_counter){
6721  0d33 3d20          	tnz	_tx_counter
6722  0d35 271a          	jreq	L7123
6723                     ; 1154 		--tx_counter;
6725  0d37 3a20          	dec	_tx_counter
6726                     ; 1155 		UART1->DR=tx_buffer[tx_rd_index];
6728  0d39 5f            	clrw	x
6729  0d3a b61e          	ld	a,_tx_rd_index
6730  0d3c 2a01          	jrpl	L451
6731  0d3e 53            	cplw	x
6732  0d3f               L451:
6733  0d3f 97            	ld	xl,a
6734  0d40 e604          	ld	a,(_tx_buffer,x)
6735  0d42 c75231        	ld	21041,a
6736                     ; 1156 		if (++tx_rd_index == TX_BUFFER_SIZE) tx_rd_index=0;
6738  0d45 3c1e          	inc	_tx_rd_index
6739  0d47 b61e          	ld	a,_tx_rd_index
6740  0d49 a150          	cp	a,#80
6741  0d4b 260c          	jrne	L3223
6744  0d4d 3f1e          	clr	_tx_rd_index
6745  0d4f 2008          	jra	L3223
6746  0d51               L7123:
6747                     ; 1159 		bOUT_FREE=1;
6749  0d51 72100003      	bset	_bOUT_FREE
6750                     ; 1160 		UART1->CR2&= ~UART1_CR2_TIEN;
6752  0d55 721f5235      	bres	21045,#7
6753  0d59               L3223:
6754                     ; 1162 }
6757  0d59 80            	iret
6786                     ; 1165 @far @interrupt void UARTRxInterrupt (void) {
6787                     	switch	.text
6788  0d5a               f_UARTRxInterrupt:
6792                     ; 1170 	rx_status=UART1->SR;
6794  0d5a 5552300006    	mov	_rx_status,21040
6795                     ; 1171 	rx_data=UART1->DR;
6797  0d5f 5552310005    	mov	_rx_data,21041
6798                     ; 1173 	if (rx_status & (UART1_SR_RXNE)){
6800  0d64 b606          	ld	a,_rx_status
6801  0d66 a520          	bcp	a,#32
6802  0d68 272c          	jreq	L5323
6803                     ; 1174 		rx_buffer[rx_wr_index]=rx_data;
6805  0d6a be1a          	ldw	x,_rx_wr_index
6806  0d6c b605          	ld	a,_rx_data
6807  0d6e e754          	ld	(_rx_buffer,x),a
6808                     ; 1175 		bRXIN=1;
6810  0d70 72100002      	bset	_bRXIN
6811                     ; 1176 		if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
6813  0d74 be1a          	ldw	x,_rx_wr_index
6814  0d76 1c0001        	addw	x,#1
6815  0d79 bf1a          	ldw	_rx_wr_index,x
6816  0d7b a30064        	cpw	x,#100
6817  0d7e 2603          	jrne	L7323
6820  0d80 5f            	clrw	x
6821  0d81 bf1a          	ldw	_rx_wr_index,x
6822  0d83               L7323:
6823                     ; 1177 		if (++rx_counter == RX_BUFFER_SIZE){
6825  0d83 be1c          	ldw	x,_rx_counter
6826  0d85 1c0001        	addw	x,#1
6827  0d88 bf1c          	ldw	_rx_counter,x
6828  0d8a a30064        	cpw	x,#100
6829  0d8d 2607          	jrne	L5323
6830                     ; 1178 			rx_counter=0;
6832  0d8f 5f            	clrw	x
6833  0d90 bf1c          	ldw	_rx_counter,x
6834                     ; 1179 			rx_buffer_overflow=1;
6836  0d92 72100001      	bset	_rx_buffer_overflow
6837  0d96               L5323:
6838                     ; 1182 }
6841  0d96 80            	iret
6899                     ; 1188 main(){
6901                     	switch	.text
6902  0d97               _main:
6906                     ; 1189 	CLK->CKDIVR=0;
6908  0d97 725f50c6      	clr	20678
6909                     ; 1191 	rele_cnt_index=0;
6911  0d9b 3fbb          	clr	_rele_cnt_index
6912                     ; 1192 	GPIOD->DDR&=~(1<<6);
6914  0d9d 721d5011      	bres	20497,#6
6915                     ; 1193 	GPIOD->CR1|=(1<<6);
6917  0da1 721c5012      	bset	20498,#6
6918                     ; 1194 	GPIOD->CR2|=(1<<6);
6920  0da5 721c5013      	bset	20499,#6
6921                     ; 1196 	GPIOD->DDR|=(1<<5);
6923  0da9 721a5011      	bset	20497,#5
6924                     ; 1197 	GPIOD->CR1|=(1<<5);
6926  0dad 721a5012      	bset	20498,#5
6927                     ; 1198 	GPIOD->CR2|=(1<<5);	
6929  0db1 721a5013      	bset	20499,#5
6930                     ; 1199 	GPIOD->ODR|=(1<<5);
6932  0db5 721a500f      	bset	20495,#5
6933                     ; 1201 	delay_ms(10);
6935  0db9 ae000a        	ldw	x,#10
6936  0dbc cd005c        	call	_delay_ms
6938                     ; 1203 	if(!(GPIOD->IDR&=(1<<6))) {
6940  0dbf c65010        	ld	a,20496
6941  0dc2 a440          	and	a,#64
6942  0dc4 c75010        	ld	20496,a
6943  0dc7 2606          	jrne	L3523
6944                     ; 1204 		rele_cnt_index=1;
6946  0dc9 350100bb      	mov	_rele_cnt_index,#1
6948  0dcd 2018          	jra	L5523
6949  0dcf               L3523:
6950                     ; 1207 		GPIOD->ODR&=~(1<<5);
6952  0dcf 721b500f      	bres	20495,#5
6953                     ; 1208 		delay_ms(10);
6955  0dd3 ae000a        	ldw	x,#10
6956  0dd6 cd005c        	call	_delay_ms
6958                     ; 1209 		if(!(GPIOD->IDR&=(1<<6))) {
6960  0dd9 c65010        	ld	a,20496
6961  0ddc a440          	and	a,#64
6962  0dde c75010        	ld	20496,a
6963  0de1 2604          	jrne	L5523
6964                     ; 1210 			rele_cnt_index=2;
6966  0de3 350200bb      	mov	_rele_cnt_index,#2
6967  0de7               L5523:
6968                     ; 1215 	gpio_init();
6970  0de7 cd0b22        	call	_gpio_init
6972                     ; 1222 	spi_init();
6974  0dea cd0873        	call	_spi_init
6976                     ; 1224 		t4_init();
6978  0ded cd0039        	call	_t4_init
6980                     ; 1228 	FLASH_DUKR=0xae;
6982  0df0 35ae5064      	mov	_FLASH_DUKR,#174
6983                     ; 1229 	FLASH_DUKR=0x56;
6985  0df4 35565064      	mov	_FLASH_DUKR,#86
6986                     ; 1234 	dumm[1]++;
6988  0df8 725c017d      	inc	_dumm+1
6989                     ; 1236 	uart_init();
6991  0dfc cd009e        	call	_uart_init
6993                     ; 1238 	ST_RDID_read();
6995  0dff cd08fe        	call	_ST_RDID_read
6997                     ; 1239 	if(mdr0==0x20) memory_manufacturer='S';	
6999  0e02 b616          	ld	a,_mdr0
7000  0e04 a120          	cp	a,#32
7001  0e06 2606          	jrne	L1623
7004  0e08 355300bc      	mov	_memory_manufacturer,#83
7006  0e0c 200d          	jra	L3623
7007  0e0e               L1623:
7008                     ; 1245 	DF_mf_dev_read();
7010  0e0e cd09e9        	call	_DF_mf_dev_read
7012                     ; 1246 	if(mdr0==0x1F) memory_manufacturer='A';
7014  0e11 b616          	ld	a,_mdr0
7015  0e13 a11f          	cp	a,#31
7016  0e15 2604          	jrne	L3623
7019  0e17 354100bc      	mov	_memory_manufacturer,#65
7020  0e1b               L3623:
7021                     ; 1249 t2_init();
7023  0e1b cd0000        	call	_t2_init
7025                     ; 1251 	enableInterrupts();	
7028  0e1e 9a            rim
7030  0e1f               L7623:
7031                     ; 1255 		if(bBUFF_LOAD) {
7033                     	btst	_bBUFF_LOAD
7034  0e24 2425          	jruge	L3723
7035                     ; 1256 			bBUFF_LOAD=0;
7037  0e26 7211000b      	bres	_bBUFF_LOAD
7038                     ; 1258 			if(current_page<last_page) {
7040  0e2a be0f          	ldw	x,_current_page
7041  0e2c b30d          	cpw	x,_last_page
7042  0e2e 2409          	jruge	L5723
7043                     ; 1259 				current_page++;
7045  0e30 be0f          	ldw	x,_current_page
7046  0e32 1c0001        	addw	x,#1
7047  0e35 bf0f          	ldw	_current_page,x
7049  0e37 2007          	jra	L7723
7050  0e39               L5723:
7051                     ; 1263 				current_page=0;
7053  0e39 5f            	clrw	x
7054  0e3a bf0f          	ldw	_current_page,x
7055                     ; 1264 				play=0;
7057  0e3c 72110004      	bres	_play
7058  0e40               L7723:
7059                     ; 1266 			if(memory_manufacturer=='A') {
7061  0e40 b6bc          	ld	a,_memory_manufacturer
7062  0e42 a141          	cp	a,#65
7063  0e44 2605          	jrne	L3723
7064                     ; 1267 				DF_page_to_buffer(/*///current_buffer_H*//*1,*/current_page);
7066  0e46 be0f          	ldw	x,_current_page
7067  0e48 cd0a57        	call	_DF_page_to_buffer
7069  0e4b               L3723:
7070                     ; 1271 		if(bBUFF_READ_L) {
7072                     	btst	_bBUFF_READ_L
7073  0e50 243a          	jruge	L3033
7074                     ; 1272 			bBUFF_READ_L=0;
7076  0e52 72110009      	bres	_bBUFF_READ_L
7077                     ; 1273 			if(memory_manufacturer=='A') {
7079  0e56 b6bc          	ld	a,_memory_manufacturer
7080  0e58 a141          	cp	a,#65
7081  0e5a 260e          	jrne	L5033
7082                     ; 1274 				DF_buffer_read(/*///current_buffer_L*//*1,*/0,128,buff);
7084  0e5c ae0050        	ldw	x,#_buff
7085  0e5f 89            	pushw	x
7086  0e60 ae0080        	ldw	x,#128
7087  0e63 89            	pushw	x
7088  0e64 5f            	clrw	x
7089  0e65 cd0a9d        	call	_DF_buffer_read
7091  0e68 5b04          	addw	sp,#4
7092  0e6a               L5033:
7093                     ; 1276 			if(memory_manufacturer=='S') {
7095  0e6a b6bc          	ld	a,_memory_manufacturer
7096  0e6c a153          	cp	a,#83
7097  0e6e 261c          	jrne	L3033
7098                     ; 1277 				ST_READ((unsigned long)((unsigned long)(current_page*256UL)),128,buff);
7100  0e70 ae0050        	ldw	x,#_buff
7101  0e73 89            	pushw	x
7102  0e74 ae0080        	ldw	x,#128
7103  0e77 89            	pushw	x
7104  0e78 be0f          	ldw	x,_current_page
7105  0e7a 90ae0100      	ldw	y,#256
7106  0e7e cd0000        	call	c_umul
7108  0e81 be02          	ldw	x,c_lreg+2
7109  0e83 89            	pushw	x
7110  0e84 be00          	ldw	x,c_lreg
7111  0e86 89            	pushw	x
7112  0e87 cd099b        	call	_ST_READ
7114  0e8a 5b08          	addw	sp,#8
7115  0e8c               L3033:
7116                     ; 1281 		if(bBUFF_READ_H) {
7118                     	btst	_bBUFF_READ_H
7119  0e91 2441          	jruge	L1133
7120                     ; 1282 			bBUFF_READ_H=0;
7122  0e93 7211000a      	bres	_bBUFF_READ_H
7123                     ; 1283 			if(memory_manufacturer=='A') {
7125  0e97 b6bc          	ld	a,_memory_manufacturer
7126  0e99 a141          	cp	a,#65
7127  0e9b 2610          	jrne	L3133
7128                     ; 1284 				DF_buffer_read(/*///current_buffer_L*//*1,*/128,128,&buff[128]);
7130  0e9d ae00d0        	ldw	x,#_buff+128
7131  0ea0 89            	pushw	x
7132  0ea1 ae0080        	ldw	x,#128
7133  0ea4 89            	pushw	x
7134  0ea5 ae0080        	ldw	x,#128
7135  0ea8 cd0a9d        	call	_DF_buffer_read
7137  0eab 5b04          	addw	sp,#4
7138  0ead               L3133:
7139                     ; 1286 			if(memory_manufacturer=='S') {
7141  0ead b6bc          	ld	a,_memory_manufacturer
7142  0eaf a153          	cp	a,#83
7143  0eb1 2621          	jrne	L1133
7144                     ; 1287 				ST_READ((unsigned long)((unsigned long)(current_page*256UL)+128UL),128,&buff[128]);
7146  0eb3 ae00d0        	ldw	x,#_buff+128
7147  0eb6 89            	pushw	x
7148  0eb7 ae0080        	ldw	x,#128
7149  0eba 89            	pushw	x
7150  0ebb be0f          	ldw	x,_current_page
7151  0ebd 90ae0100      	ldw	y,#256
7152  0ec1 cd0000        	call	c_umul
7154  0ec4 a680          	ld	a,#128
7155  0ec6 cd0000        	call	c_ladc
7157  0ec9 be02          	ldw	x,c_lreg+2
7158  0ecb 89            	pushw	x
7159  0ecc be00          	ldw	x,c_lreg
7160  0ece 89            	pushw	x
7161  0ecf cd099b        	call	_ST_READ
7163  0ed2 5b08          	addw	sp,#8
7164  0ed4               L1133:
7165                     ; 1291 		if(bRXIN)	{
7167                     	btst	_bRXIN
7168  0ed9 2407          	jruge	L7133
7169                     ; 1292 			bRXIN=0;
7171  0edb 72110002      	bres	_bRXIN
7172                     ; 1294 			uart_in();
7174  0edf cd0b4b        	call	_uart_in
7176  0ee2               L7133:
7177                     ; 1298 		if(b100Hz){
7179                     	btst	_b100Hz
7180  0ee7 2503          	jrult	L261
7181  0ee9 cc0f97        	jp	L1233
7182  0eec               L261:
7183                     ; 1299 			b100Hz=0;
7185  0eec 72110008      	bres	_b100Hz
7186                     ; 1301 			if(but_block_cnt)but_block_cnt--;
7188  0ef0 be00          	ldw	x,_but_block_cnt
7189  0ef2 2707          	jreq	L3233
7192  0ef4 be00          	ldw	x,_but_block_cnt
7193  0ef6 1d0001        	subw	x,#1
7194  0ef9 bf00          	ldw	_but_block_cnt,x
7195  0efb               L3233:
7196                     ; 1303 			if(bSTART==1) {
7198                     	btst	_bSTART
7199  0f00 24e7          	jruge	L1233
7200                     ; 1304 				if(play) {
7202                     	btst	_play
7203  0f07 2417          	jruge	L7233
7204                     ; 1306 				if(!but_block_cnt){
7206  0f09 be00          	ldw	x,_but_block_cnt
7207  0f0b 260d          	jrne	L1333
7208                     ; 1307 					play=0;
7210  0f0d 72110004      	bres	_play
7211                     ; 1308 					bSTART=0;
7213  0f11 7211000c      	bres	_bSTART
7214                     ; 1309 					but_block_cnt=50;
7216  0f15 ae0032        	ldw	x,#50
7217  0f18 bf00          	ldw	_but_block_cnt,x
7218  0f1a               L1333:
7219                     ; 1312 				bSTART=0;
7221  0f1a 7211000c      	bres	_bSTART
7223  0f1e 2077          	jra	L1233
7224  0f20               L7233:
7225                     ; 1316 				if(!but_block_cnt)
7227  0f20 be00          	ldw	x,_but_block_cnt
7228  0f22 2673          	jrne	L1233
7229                     ; 1319 					current_page=1;
7231  0f24 ae0001        	ldw	x,#1
7232  0f27 bf0f          	ldw	_current_page,x
7233                     ; 1321 					last_page=6000;
7235  0f29 ae1770        	ldw	x,#6000
7236  0f2c bf0d          	ldw	_last_page,x
7237                     ; 1326 					if(memory_manufacturer=='A') {
7239  0f2e b6bc          	ld	a,_memory_manufacturer
7240  0f30 a141          	cp	a,#65
7241  0f32 2630          	jrne	L7333
7242                     ; 1327 						DF_page_to_buffer(/*///current_buffer_H*//*1,*/current_page);
7244  0f34 ae0001        	ldw	x,#1
7245  0f37 cd0a57        	call	_DF_page_to_buffer
7247                     ; 1328 						delay_ms(10);
7249  0f3a ae000a        	ldw	x,#10
7250  0f3d cd005c        	call	_delay_ms
7252                     ; 1329 						DF_buffer_read(/*///current_buffer_L*//*1,*/0,128,buff);
7254  0f40 ae0050        	ldw	x,#_buff
7255  0f43 89            	pushw	x
7256  0f44 ae0080        	ldw	x,#128
7257  0f47 89            	pushw	x
7258  0f48 5f            	clrw	x
7259  0f49 cd0a9d        	call	_DF_buffer_read
7261  0f4c 5b04          	addw	sp,#4
7262                     ; 1330 						delay_ms(10);
7264  0f4e ae000a        	ldw	x,#10
7265  0f51 cd005c        	call	_delay_ms
7267                     ; 1331 						DF_buffer_read(/*///current_buffer_L*//*1,*/128,128,&buff[128]);         
7269  0f54 ae00d0        	ldw	x,#_buff+128
7270  0f57 89            	pushw	x
7271  0f58 ae0080        	ldw	x,#128
7272  0f5b 89            	pushw	x
7273  0f5c ae0080        	ldw	x,#128
7274  0f5f cd0a9d        	call	_DF_buffer_read
7276  0f62 5b04          	addw	sp,#4
7277  0f64               L7333:
7278                     ; 1333 					if(memory_manufacturer=='S') {
7280  0f64 b6bc          	ld	a,_memory_manufacturer
7281  0f66 a153          	cp	a,#83
7282  0f68 2615          	jrne	L1433
7283                     ; 1334 						ST_READ(0,256,buff);
7285  0f6a ae0050        	ldw	x,#_buff
7286  0f6d 89            	pushw	x
7287  0f6e ae0100        	ldw	x,#256
7288  0f71 89            	pushw	x
7289  0f72 ae0000        	ldw	x,#0
7290  0f75 89            	pushw	x
7291  0f76 ae0000        	ldw	x,#0
7292  0f79 89            	pushw	x
7293  0f7a cd099b        	call	_ST_READ
7295  0f7d 5b08          	addw	sp,#8
7296  0f7f               L1433:
7297                     ; 1336 					play=1;
7299  0f7f 72100004      	bset	_play
7300                     ; 1337 					bSTART=0;
7302  0f83 7211000c      	bres	_bSTART
7303                     ; 1339 					rele_cnt=rele_cnt_const[rele_cnt_index];
7305  0f87 b6bb          	ld	a,_rele_cnt_index
7306  0f89 5f            	clrw	x
7307  0f8a 97            	ld	xl,a
7308  0f8b d60000        	ld	a,(_rele_cnt_const,x)
7309  0f8e 5f            	clrw	x
7310  0f8f 97            	ld	xl,a
7311  0f90 bf03          	ldw	_rele_cnt,x
7312                     ; 1341 					but_block_cnt=50;
7314  0f92 ae0032        	ldw	x,#50
7315  0f95 bf00          	ldw	_but_block_cnt,x
7316  0f97               L1233:
7317                     ; 1349 		if(b10Hz){
7319                     	btst	_b10Hz
7320  0f9c 2413          	jruge	L3433
7321                     ; 1350 			b10Hz=0;
7323  0f9e 72110007      	bres	_b10Hz
7324                     ; 1352 			rele_drv();
7326  0fa2 cd004a        	call	_rele_drv
7328                     ; 1353 			pwm_fade_in++;
7330  0fa5 3cba          	inc	_pwm_fade_in
7331                     ; 1354 			if(pwm_fade_in>128)pwm_fade_in=128;			
7333  0fa7 b6ba          	ld	a,_pwm_fade_in
7334  0fa9 a181          	cp	a,#129
7335  0fab 2504          	jrult	L3433
7338  0fad 358000ba      	mov	_pwm_fade_in,#128
7339  0fb1               L3433:
7340                     ; 1357 		if(b5Hz){
7342                     	btst	_b5Hz
7343  0fb6 2404          	jruge	L7433
7344                     ; 1358 			b5Hz=0;
7346  0fb8 72110006      	bres	_b5Hz
7347  0fbc               L7433:
7348                     ; 1363 		if(b1Hz){
7350                     	btst	_b1Hz
7351  0fc1 2503          	jrult	L461
7352  0fc3 cc0e1f        	jp	L7623
7353  0fc6               L461:
7354                     ; 1365 			b1Hz=0;
7356  0fc6 72110005      	bres	_b1Hz
7357  0fca ac1f0e1f      	jpf	L7623
7853                     	xdef	_main
7854                     .eeprom:	section	.data
7855  0000               _EE_PAGE_LEN:
7856  0000 0000          	ds.b	2
7857                     	xdef	_EE_PAGE_LEN
7858                     	switch	.bss
7859  0000               _UIB:
7860  0000 000000000000  	ds.b	80
7861                     	xdef	_UIB
7862  0050               _buff:
7863  0050 000000000000  	ds.b	300
7864                     	xdef	_buff
7865  017c               _dumm:
7866  017c 000000000000  	ds.b	100
7867                     	xdef	_dumm
7868                     .bit:	section	.data,bit
7869  0000               _bRELEASE:
7870  0000 00            	ds.b	1
7871                     	xdef	_bRELEASE
7872  0001               _rx_buffer_overflow:
7873  0001 00            	ds.b	1
7874                     	xdef	_rx_buffer_overflow
7875  0002               _bRXIN:
7876  0002 00            	ds.b	1
7877                     	xdef	_bRXIN
7878  0003               _bOUT_FREE:
7879  0003 00            	ds.b	1
7880                     	xdef	_bOUT_FREE
7881  0004               _play:
7882  0004 00            	ds.b	1
7883                     	xdef	_play
7884  0005               _b1Hz:
7885  0005 00            	ds.b	1
7886                     	xdef	_b1Hz
7887  0006               _b5Hz:
7888  0006 00            	ds.b	1
7889                     	xdef	_b5Hz
7890  0007               _b10Hz:
7891  0007 00            	ds.b	1
7892                     	xdef	_b10Hz
7893  0008               _b100Hz:
7894  0008 00            	ds.b	1
7895                     	xdef	_b100Hz
7896  0009               _bBUFF_READ_L:
7897  0009 00            	ds.b	1
7898                     	xdef	_bBUFF_READ_L
7899  000a               _bBUFF_READ_H:
7900  000a 00            	ds.b	1
7901                     	xdef	_bBUFF_READ_H
7902  000b               _bBUFF_LOAD:
7903  000b 00            	ds.b	1
7904                     	xdef	_bBUFF_LOAD
7905  000c               _bSTART:
7906  000c 00            	ds.b	1
7907                     	xdef	_bSTART
7908                     	switch	.ubsct
7909  0000               _but_block_cnt:
7910  0000 0000          	ds.b	2
7911                     	xdef	_but_block_cnt
7912                     	xdef	_memory_manufacturer
7913                     	xdef	_rele_cnt_const
7914                     	xdef	_rele_cnt_index
7915                     	xdef	_pwm_fade_in
7916  0002               _rx_offset:
7917  0002 00            	ds.b	1
7918                     	xdef	_rx_offset
7919  0003               _rele_cnt:
7920  0003 0000          	ds.b	2
7921                     	xdef	_rele_cnt
7922  0005               _rx_data:
7923  0005 00            	ds.b	1
7924                     	xdef	_rx_data
7925  0006               _rx_status:
7926  0006 00            	ds.b	1
7927                     	xdef	_rx_status
7928  0007               _file_lengt:
7929  0007 00000000      	ds.b	4
7930                     	xdef	_file_lengt
7931  000b               _current_byte_in_buffer:
7932  000b 0000          	ds.b	2
7933                     	xdef	_current_byte_in_buffer
7934  000d               _last_page:
7935  000d 0000          	ds.b	2
7936                     	xdef	_last_page
7937  000f               _current_page:
7938  000f 0000          	ds.b	2
7939                     	xdef	_current_page
7940  0011               _file_lengt_in_pages:
7941  0011 0000          	ds.b	2
7942                     	xdef	_file_lengt_in_pages
7943  0013               _mdr3:
7944  0013 00            	ds.b	1
7945                     	xdef	_mdr3
7946  0014               _mdr2:
7947  0014 00            	ds.b	1
7948                     	xdef	_mdr2
7949  0015               _mdr1:
7950  0015 00            	ds.b	1
7951                     	xdef	_mdr1
7952  0016               _mdr0:
7953  0016 00            	ds.b	1
7954                     	xdef	_mdr0
7955                     	xdef	_but_on_drv_cnt
7956                     	xdef	_but_drv_cnt
7957  0017               _sample:
7958  0017 00            	ds.b	1
7959                     	xdef	_sample
7960  0018               _rx_rd_index:
7961  0018 0000          	ds.b	2
7962                     	xdef	_rx_rd_index
7963  001a               _rx_wr_index:
7964  001a 0000          	ds.b	2
7965                     	xdef	_rx_wr_index
7966  001c               _rx_counter:
7967  001c 0000          	ds.b	2
7968                     	xdef	_rx_counter
7969                     	xdef	_rx_buffer
7970  001e               _tx_rd_index:
7971  001e 00            	ds.b	1
7972                     	xdef	_tx_rd_index
7973  001f               _tx_wr_index:
7974  001f 00            	ds.b	1
7975                     	xdef	_tx_wr_index
7976  0020               _tx_counter:
7977  0020 00            	ds.b	1
7978                     	xdef	_tx_counter
7979                     	xdef	_tx_buffer
7980  0021               _sample_cnt:
7981  0021 0000          	ds.b	2
7982                     	xdef	_sample_cnt
7983                     	xdef	_t0_cnt3
7984                     	xdef	_t0_cnt2
7985                     	xdef	_t0_cnt1
7986                     	xdef	_t0_cnt0
7987                     	xdef	_ST_READ
7988                     	xdef	_ST_WRITE
7989                     	xdef	_ST_WREN
7990                     	xdef	_ST_status_read
7991                     	xdef	_ST_RDID_read
7992                     	xdef	_uart_in_an
7993                     	xdef	_control_check
7994                     	xdef	_index_offset
7995                     	xdef	_uart_in
7996                     	xdef	_gpio_init
7997                     	xdef	_spi_init
7998                     	xdef	_spi
7999                     	xdef	_DF_buffer_to_page_er
8000                     	xdef	_DF_page_to_buffer
8001                     	xdef	_DF_buffer_write
8002                     	xdef	_DF_buffer_read
8003                     	xdef	_DF_status_read
8004                     	xdef	_DF_memo_to_256
8005                     	xdef	_DF_mf_dev_read
8006                     	xdef	_uart_init
8007                     	xdef	f_UARTRxInterrupt
8008                     	xdef	f_UARTTxInterrupt
8009                     	xdef	_putchar
8010                     	xdef	_uart_out_adr_block
8011                     	xdef	_uart_out
8012                     	xdef	f_TIM4_UPD_Interrupt
8013                     	xdef	_delay_ms
8014                     	xdef	_rele_drv
8015                     	xdef	_t4_init
8016                     	xdef	_t2_init
8017                     	xref.b	c_lreg
8018                     	xref.b	c_x
8019                     	xref.b	c_y
8039                     	xref	c_ladc
8040                     	xref	c_itolx
8041                     	xref	c_umul
8042                     	xref	c_eewrw
8043                     	xref	c_lglsh
8044                     	xref	c_uitolx
8045                     	xref	c_lgursh
8046                     	xref	c_lcmp
8047                     	xref	c_ltor
8048                     	xref	c_lgadc
8049                     	xref	c_rtol
8050                     	xref	c_vmul
8051                     	end
