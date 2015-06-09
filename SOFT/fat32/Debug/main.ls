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
2372                     ; 112 }
2375  005b 81            	ret
2436                     ; 115 long delay_ms(short in)
2436                     ; 116 {
2437                     	switch	.text
2438  005c               _delay_ms:
2440  005c 520c          	subw	sp,#12
2441       0000000c      OFST:	set	12
2444                     ; 119 i=((long)in)*100UL;
2446  005e 90ae0064      	ldw	y,#100
2447  0062 cd0000        	call	c_vmul
2449  0065 96            	ldw	x,sp
2450  0066 1c0005        	addw	x,#OFST-7
2451  0069 cd0000        	call	c_rtol
2453                     ; 121 for(ii=0;ii<i;ii++)
2455  006c ae0000        	ldw	x,#0
2456  006f 1f0b          	ldw	(OFST-1,sp),x
2457  0071 ae0000        	ldw	x,#0
2458  0074 1f09          	ldw	(OFST-3,sp),x
2460  0076 2012          	jra	L3251
2461  0078               L7151:
2462                     ; 123 		iii++;
2464  0078 96            	ldw	x,sp
2465  0079 1c0001        	addw	x,#OFST-11
2466  007c a601          	ld	a,#1
2467  007e cd0000        	call	c_lgadc
2469                     ; 121 for(ii=0;ii<i;ii++)
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
2489                     ; 126 }
2492  009b 5b0c          	addw	sp,#12
2493  009d 81            	ret
2516                     ; 129 void uart_init (void){
2517                     	switch	.text
2518  009e               _uart_init:
2522                     ; 130 	GPIOD->DDR|=(1<<5);
2524  009e 721a5011      	bset	20497,#5
2525                     ; 131 	GPIOD->CR1|=(1<<5);
2527  00a2 721a5012      	bset	20498,#5
2528                     ; 132 	GPIOD->CR2|=(1<<5);
2530  00a6 721a5013      	bset	20499,#5
2531                     ; 135 	GPIOD->DDR&=~(1<<6);
2533  00aa 721d5011      	bres	20497,#6
2534                     ; 136 	GPIOD->CR1&=~(1<<6);
2536  00ae 721d5012      	bres	20498,#6
2537                     ; 137 	GPIOD->CR2&=~(1<<6);
2539  00b2 721d5013      	bres	20499,#6
2540                     ; 140 	UART1->CR1&=~UART1_CR1_M;					
2542  00b6 72195234      	bres	21044,#4
2543                     ; 141 	UART1->CR3|= (0<<4) & UART1_CR3_STOP;	
2545  00ba c65236        	ld	a,21046
2546                     ; 142 	UART1->BRR2= 0x01;//0x03;
2548  00bd 35015233      	mov	21043,#1
2549                     ; 143 	UART1->BRR1= 0x1a;//0x68;
2551  00c1 351a5232      	mov	21042,#26
2552                     ; 144 	UART1->CR2|= UART1_CR2_TEN | UART3_CR2_REN | UART3_CR2_RIEN;	
2554  00c5 c65235        	ld	a,21045
2555  00c8 aa2c          	or	a,#44
2556  00ca c75235        	ld	21045,a
2557                     ; 145 }
2560  00cd 81            	ret
2678                     ; 148 void uart_out (char num,char data0,char data1,char data2,char data3,char data4,char data5){
2679                     	switch	.text
2680  00ce               _uart_out:
2682  00ce 89            	pushw	x
2683  00cf 520c          	subw	sp,#12
2684       0000000c      OFST:	set	12
2687                     ; 149 	char i=0,t=0,UOB[10];
2691  00d1 0f01          	clr	(OFST-11,sp)
2692                     ; 152 	UOB[0]=data0;
2694  00d3 9f            	ld	a,xl
2695  00d4 6b02          	ld	(OFST-10,sp),a
2696                     ; 153 	UOB[1]=data1;
2698  00d6 7b11          	ld	a,(OFST+5,sp)
2699  00d8 6b03          	ld	(OFST-9,sp),a
2700                     ; 154 	UOB[2]=data2;
2702  00da 7b12          	ld	a,(OFST+6,sp)
2703  00dc 6b04          	ld	(OFST-8,sp),a
2704                     ; 155 	UOB[3]=data3;
2706  00de 7b13          	ld	a,(OFST+7,sp)
2707  00e0 6b05          	ld	(OFST-7,sp),a
2708                     ; 156 	UOB[4]=data4;
2710  00e2 7b14          	ld	a,(OFST+8,sp)
2711  00e4 6b06          	ld	(OFST-6,sp),a
2712                     ; 157 	UOB[5]=data5;
2714  00e6 7b15          	ld	a,(OFST+9,sp)
2715  00e8 6b07          	ld	(OFST-5,sp),a
2716                     ; 158 	for (i=0;i<num;i++)
2718  00ea 0f0c          	clr	(OFST+0,sp)
2720  00ec 2013          	jra	L5261
2721  00ee               L1261:
2722                     ; 160 		t^=UOB[i];
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
2736                     ; 158 	for (i=0;i<num;i++)
2738  00ff 0c0c          	inc	(OFST+0,sp)
2739  0101               L5261:
2742  0101 7b0c          	ld	a,(OFST+0,sp)
2743  0103 110d          	cp	a,(OFST+1,sp)
2744  0105 25e7          	jrult	L1261
2745                     ; 162 	UOB[num]=num;
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
2758                     ; 163 	t^=UOB[num];
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
2772                     ; 164 	UOB[num+1]=t;
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
2785                     ; 165 	UOB[num+2]=END;
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
2798                     ; 169 	for (i=0;i<num+3;i++)
2800  0145 0f0c          	clr	(OFST+0,sp)
2802  0147 2012          	jra	L5361
2803  0149               L1361:
2804                     ; 171 		putchar(UOB[i]);
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
2816  0156 cd0862        	call	_putchar
2818                     ; 169 	for (i=0;i<num+3;i++)
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
2835                     ; 174 	bOUT_FREE=0;	  	
2837  0171 72110003      	bres	_bOUT_FREE
2838                     ; 175 }
2841  0175 5b0e          	addw	sp,#14
2842  0177 81            	ret
2924                     ; 178 void uart_out_adr_block (unsigned long adress,char *ptr, char len)
2924                     ; 179 {
2925                     	switch	.text
2926  0178               _uart_out_adr_block:
2928  0178 5203          	subw	sp,#3
2929       00000003      OFST:	set	3
2932                     ; 183 t=0;
2934  017a 0f02          	clr	(OFST-1,sp)
2935                     ; 184 temp11=CMND;
2937                     ; 185 t^=temp11;
2939  017c 7b02          	ld	a,(OFST-1,sp)
2940  017e a816          	xor	a,	#22
2941  0180 6b02          	ld	(OFST-1,sp),a
2942                     ; 186 putchar(temp11);
2944  0182 a616          	ld	a,#22
2945  0184 cd0862        	call	_putchar
2947                     ; 188 temp11=10;
2949                     ; 189 t^=temp11;
2951  0187 7b02          	ld	a,(OFST-1,sp)
2952  0189 a80a          	xor	a,	#10
2953  018b 6b02          	ld	(OFST-1,sp),a
2954                     ; 190 putchar(temp11);
2956  018d a60a          	ld	a,#10
2957  018f cd0862        	call	_putchar
2959                     ; 192 temp11=adress%256;//(*((char*)&adress));
2961  0192 7b09          	ld	a,(OFST+6,sp)
2962  0194 a4ff          	and	a,#255
2963  0196 6b03          	ld	(OFST+0,sp),a
2964                     ; 193 t^=temp11;
2966  0198 7b02          	ld	a,(OFST-1,sp)
2967  019a 1803          	xor	a,	(OFST+0,sp)
2968  019c 6b02          	ld	(OFST-1,sp),a
2969                     ; 194 putchar(temp11);
2971  019e 7b03          	ld	a,(OFST+0,sp)
2972  01a0 cd0862        	call	_putchar
2974                     ; 195 adress>>=8;
2976  01a3 96            	ldw	x,sp
2977  01a4 1c0006        	addw	x,#OFST+3
2978  01a7 a608          	ld	a,#8
2979  01a9 cd0000        	call	c_lgursh
2981                     ; 196 temp11=adress%256;//(*(((char*)&adress)+1));
2983  01ac 7b09          	ld	a,(OFST+6,sp)
2984  01ae a4ff          	and	a,#255
2985  01b0 6b03          	ld	(OFST+0,sp),a
2986                     ; 197 t^=temp11;
2988  01b2 7b02          	ld	a,(OFST-1,sp)
2989  01b4 1803          	xor	a,	(OFST+0,sp)
2990  01b6 6b02          	ld	(OFST-1,sp),a
2991                     ; 198 putchar(temp11);
2993  01b8 7b03          	ld	a,(OFST+0,sp)
2994  01ba cd0862        	call	_putchar
2996                     ; 199 adress>>=8;
2998  01bd 96            	ldw	x,sp
2999  01be 1c0006        	addw	x,#OFST+3
3000  01c1 a608          	ld	a,#8
3001  01c3 cd0000        	call	c_lgursh
3003                     ; 200 temp11=adress%256;//(*(((char*)&adress)+2));
3005  01c6 7b09          	ld	a,(OFST+6,sp)
3006  01c8 a4ff          	and	a,#255
3007  01ca 6b03          	ld	(OFST+0,sp),a
3008                     ; 201 t^=temp11;
3010  01cc 7b02          	ld	a,(OFST-1,sp)
3011  01ce 1803          	xor	a,	(OFST+0,sp)
3012  01d0 6b02          	ld	(OFST-1,sp),a
3013                     ; 202 putchar(temp11);
3015  01d2 7b03          	ld	a,(OFST+0,sp)
3016  01d4 cd0862        	call	_putchar
3018                     ; 203 adress>>=8;
3020  01d7 96            	ldw	x,sp
3021  01d8 1c0006        	addw	x,#OFST+3
3022  01db a608          	ld	a,#8
3023  01dd cd0000        	call	c_lgursh
3025                     ; 204 temp11=adress%256;//(*(((char*)&adress)+3));
3027  01e0 7b09          	ld	a,(OFST+6,sp)
3028  01e2 a4ff          	and	a,#255
3029  01e4 6b03          	ld	(OFST+0,sp),a
3030                     ; 205 t^=temp11;
3032  01e6 7b02          	ld	a,(OFST-1,sp)
3033  01e8 1803          	xor	a,	(OFST+0,sp)
3034  01ea 6b02          	ld	(OFST-1,sp),a
3035                     ; 206 putchar(temp11);
3037  01ec 7b03          	ld	a,(OFST+0,sp)
3038  01ee cd0862        	call	_putchar
3040                     ; 209 for(i11=0;i11<len;i11++)
3042  01f1 0f01          	clr	(OFST-2,sp)
3044  01f3 201b          	jra	L7071
3045  01f5               L3071:
3046                     ; 211 	temp11=ptr[i11];
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
3058                     ; 212 	t^=temp11;
3060  0203 7b02          	ld	a,(OFST-1,sp)
3061  0205 1803          	xor	a,	(OFST+0,sp)
3062  0207 6b02          	ld	(OFST-1,sp),a
3063                     ; 213 	putchar(temp11);
3065  0209 7b03          	ld	a,(OFST+0,sp)
3066  020b cd0862        	call	_putchar
3068                     ; 209 for(i11=0;i11<len;i11++)
3070  020e 0c01          	inc	(OFST-2,sp)
3071  0210               L7071:
3074  0210 7b01          	ld	a,(OFST-2,sp)
3075  0212 110c          	cp	a,(OFST+9,sp)
3076  0214 25df          	jrult	L3071
3077                     ; 216 temp11=(len+6);
3079  0216 7b0c          	ld	a,(OFST+9,sp)
3080  0218 ab06          	add	a,#6
3081  021a 6b03          	ld	(OFST+0,sp),a
3082                     ; 217 t^=temp11;
3084  021c 7b02          	ld	a,(OFST-1,sp)
3085  021e 1803          	xor	a,	(OFST+0,sp)
3086  0220 6b02          	ld	(OFST-1,sp),a
3087                     ; 218 putchar(temp11);
3089  0222 7b03          	ld	a,(OFST+0,sp)
3090  0224 cd0862        	call	_putchar
3092                     ; 220 putchar(t);
3094  0227 7b02          	ld	a,(OFST-1,sp)
3095  0229 cd0862        	call	_putchar
3097                     ; 222 putchar(0x0a);
3099  022c a60a          	ld	a,#10
3100  022e cd0862        	call	_putchar
3102                     ; 224 bOUT_FREE=0;	   
3104  0231 72110003      	bres	_bOUT_FREE
3105                     ; 225 }
3108  0235 5b03          	addw	sp,#3
3109  0237 81            	ret
3245                     ; 227 void uart_in_an(void) {
3246                     	switch	.text
3247  0238               _uart_in_an:
3249  0238 5204          	subw	sp,#4
3250       00000004      OFST:	set	4
3253                     ; 230 	if(UIB[0]==CMND) {
3255  023a c60000        	ld	a,_UIB
3256  023d a116          	cp	a,#22
3257  023f 2703          	jreq	L24
3258  0241 cc085f        	jp	L1771
3259  0244               L24:
3260                     ; 231 		if(UIB[1]==1) {
3262  0244 c60001        	ld	a,_UIB+1
3263  0247 a101          	cp	a,#1
3264  0249 262f          	jrne	L3771
3265                     ; 235 			if(memory_manufacturer=='A') {
3267  024b b6bc          	ld	a,_memory_manufacturer
3268  024d a141          	cp	a,#65
3269  024f 2603          	jrne	L5771
3270                     ; 236 				temp_L=DF_mf_dev_read();
3272  0251 cd0a1b        	call	_DF_mf_dev_read
3274  0254               L5771:
3275                     ; 238 			if(memory_manufacturer=='S') {
3277  0254 b6bc          	ld	a,_memory_manufacturer
3278  0256 a153          	cp	a,#83
3279  0258 2603          	jrne	L7771
3280                     ; 239 				temp_L=ST_RDID_read();
3282  025a cd0923        	call	_ST_RDID_read
3284  025d               L7771:
3285                     ; 241 			uart_out (6,CMND,1,mdr0/**((char*)&temp_L)*/,mdr1/**(((char*)&temp_L)+1)*/,mdr2/**(((char*)&temp_L)+2)*/,mdr3/**(((char*)&temp_L)+3)*/);
3287  025d 3b0013        	push	_mdr3
3288  0260 3b0014        	push	_mdr2
3289  0263 3b0015        	push	_mdr1
3290  0266 3b0016        	push	_mdr0
3291  0269 4b01          	push	#1
3292  026b ae0016        	ldw	x,#22
3293  026e a606          	ld	a,#6
3294  0270 95            	ld	xh,a
3295  0271 cd00ce        	call	_uart_out
3297  0274 5b05          	addw	sp,#5
3299  0276 ac5f085f      	jpf	L1771
3300  027a               L3771:
3301                     ; 249 	else if(UIB[1]==2) {
3303  027a c60001        	ld	a,_UIB+1
3304  027d a102          	cp	a,#2
3305  027f 2630          	jrne	L3002
3306                     ; 252 		if(memory_manufacturer=='A') {
3308  0281 b6bc          	ld	a,_memory_manufacturer
3309  0283 a141          	cp	a,#65
3310  0285 2605          	jrne	L5002
3311                     ; 253 			temp=DF_status_read();
3313  0287 cd0a6f        	call	_DF_status_read
3315  028a 6b04          	ld	(OFST+0,sp),a
3316  028c               L5002:
3317                     ; 255 		if(memory_manufacturer=='S') {
3319  028c b6bc          	ld	a,_memory_manufacturer
3320  028e a153          	cp	a,#83
3321  0290 2605          	jrne	L7002
3322                     ; 256 			temp=ST_status_read();
3324  0292 cd094f        	call	_ST_status_read
3326  0295 6b04          	ld	(OFST+0,sp),a
3327  0297               L7002:
3328                     ; 258 		uart_out (3,CMND,2,temp,0,0,0);    
3330  0297 4b00          	push	#0
3331  0299 4b00          	push	#0
3332  029b 4b00          	push	#0
3333  029d 7b07          	ld	a,(OFST+3,sp)
3334  029f 88            	push	a
3335  02a0 4b02          	push	#2
3336  02a2 ae0016        	ldw	x,#22
3337  02a5 a603          	ld	a,#3
3338  02a7 95            	ld	xh,a
3339  02a8 cd00ce        	call	_uart_out
3341  02ab 5b05          	addw	sp,#5
3343  02ad ac5f085f      	jpf	L1771
3344  02b1               L3002:
3345                     ; 262 	else if(UIB[1]==3)
3347  02b1 c60001        	ld	a,_UIB+1
3348  02b4 a103          	cp	a,#3
3349  02b6 2623          	jrne	L3102
3350                     ; 265 		if(memory_manufacturer=='A') {
3352  02b8 b6bc          	ld	a,_memory_manufacturer
3353  02ba a141          	cp	a,#65
3354  02bc 2603          	jrne	L5102
3355                     ; 266 			DF_memo_to_256();
3357  02be cd0a52        	call	_DF_memo_to_256
3359  02c1               L5102:
3360                     ; 268 		uart_out (2,CMND,3,temp,0,0,0);    
3362  02c1 4b00          	push	#0
3363  02c3 4b00          	push	#0
3364  02c5 4b00          	push	#0
3365  02c7 7b07          	ld	a,(OFST+3,sp)
3366  02c9 88            	push	a
3367  02ca 4b03          	push	#3
3368  02cc ae0016        	ldw	x,#22
3369  02cf a602          	ld	a,#2
3370  02d1 95            	ld	xh,a
3371  02d2 cd00ce        	call	_uart_out
3373  02d5 5b05          	addw	sp,#5
3375  02d7 ac5f085f      	jpf	L1771
3376  02db               L3102:
3377                     ; 271 	else if(UIB[1]==4)
3379  02db c60001        	ld	a,_UIB+1
3380  02de a104          	cp	a,#4
3381  02e0 2623          	jrne	L1202
3382                     ; 274 		if(memory_manufacturer=='A') {
3384  02e2 b6bc          	ld	a,_memory_manufacturer
3385  02e4 a141          	cp	a,#65
3386  02e6 2603          	jrne	L3202
3387                     ; 275 			DF_memo_to_256();
3389  02e8 cd0a52        	call	_DF_memo_to_256
3391  02eb               L3202:
3392                     ; 277 		uart_out (2,CMND,3,temp,0,0,0);    
3394  02eb 4b00          	push	#0
3395  02ed 4b00          	push	#0
3396  02ef 4b00          	push	#0
3397  02f1 7b07          	ld	a,(OFST+3,sp)
3398  02f3 88            	push	a
3399  02f4 4b03          	push	#3
3400  02f6 ae0016        	ldw	x,#22
3401  02f9 a602          	ld	a,#2
3402  02fb 95            	ld	xh,a
3403  02fc cd00ce        	call	_uart_out
3405  02ff 5b05          	addw	sp,#5
3407  0301 ac5f085f      	jpf	L1771
3408  0305               L1202:
3409                     ; 280 	else if(UIB[1]==10)
3411  0305 c60001        	ld	a,_UIB+1
3412  0308 a10a          	cp	a,#10
3413  030a 2703cc0392    	jrne	L7202
3414                     ; 284 		if(memory_manufacturer=='A') {
3416  030f b6bc          	ld	a,_memory_manufacturer
3417  0311 a141          	cp	a,#65
3418  0313 2615          	jrne	L1302
3419                     ; 285 			if(UIB[2]==1)DF_buffer_read(/*1,*/0,256, buff);
3421  0315 c60002        	ld	a,_UIB+2
3422  0318 a101          	cp	a,#1
3423  031a 260e          	jrne	L1302
3426  031c ae0050        	ldw	x,#_buff
3427  031f 89            	pushw	x
3428  0320 ae0100        	ldw	x,#256
3429  0323 89            	pushw	x
3430  0324 5f            	clrw	x
3431  0325 cd0acf        	call	_DF_buffer_read
3433  0328 5b04          	addw	sp,#4
3434  032a               L1302:
3435                     ; 290 		uart_out_adr_block (0,buff,64);
3437  032a 4b40          	push	#64
3438  032c ae0050        	ldw	x,#_buff
3439  032f 89            	pushw	x
3440  0330 ae0000        	ldw	x,#0
3441  0333 89            	pushw	x
3442  0334 ae0000        	ldw	x,#0
3443  0337 89            	pushw	x
3444  0338 cd0178        	call	_uart_out_adr_block
3446  033b 5b07          	addw	sp,#7
3447                     ; 291 		delay_ms(100);    
3449  033d ae0064        	ldw	x,#100
3450  0340 cd005c        	call	_delay_ms
3452                     ; 292 		uart_out_adr_block (64,&buff[64],64);
3454  0343 4b40          	push	#64
3455  0345 ae0090        	ldw	x,#_buff+64
3456  0348 89            	pushw	x
3457  0349 ae0040        	ldw	x,#64
3458  034c 89            	pushw	x
3459  034d ae0000        	ldw	x,#0
3460  0350 89            	pushw	x
3461  0351 cd0178        	call	_uart_out_adr_block
3463  0354 5b07          	addw	sp,#7
3464                     ; 293 		delay_ms(100);    
3466  0356 ae0064        	ldw	x,#100
3467  0359 cd005c        	call	_delay_ms
3469                     ; 294 		uart_out_adr_block (128,&buff[128],64);
3471  035c 4b40          	push	#64
3472  035e ae00d0        	ldw	x,#_buff+128
3473  0361 89            	pushw	x
3474  0362 ae0080        	ldw	x,#128
3475  0365 89            	pushw	x
3476  0366 ae0000        	ldw	x,#0
3477  0369 89            	pushw	x
3478  036a cd0178        	call	_uart_out_adr_block
3480  036d 5b07          	addw	sp,#7
3481                     ; 295 		delay_ms(100);    
3483  036f ae0064        	ldw	x,#100
3484  0372 cd005c        	call	_delay_ms
3486                     ; 296 		uart_out_adr_block (192,&buff[192],64);
3488  0375 4b40          	push	#64
3489  0377 ae0110        	ldw	x,#_buff+192
3490  037a 89            	pushw	x
3491  037b ae00c0        	ldw	x,#192
3492  037e 89            	pushw	x
3493  037f ae0000        	ldw	x,#0
3494  0382 89            	pushw	x
3495  0383 cd0178        	call	_uart_out_adr_block
3497  0386 5b07          	addw	sp,#7
3498                     ; 297 		delay_ms(100);    
3500  0388 ae0064        	ldw	x,#100
3501  038b cd005c        	call	_delay_ms
3504  038e ac5f085f      	jpf	L1771
3505  0392               L7202:
3506                     ; 300 	else if(UIB[1]==11)
3508  0392 c60001        	ld	a,_UIB+1
3509  0395 a10b          	cp	a,#11
3510  0397 2633          	jrne	L7302
3511                     ; 306 		for(i=0;i<256;i++)buff[i]=0;
3513  0399 5f            	clrw	x
3514  039a 1f03          	ldw	(OFST-1,sp),x
3515  039c               L1402:
3518  039c 1e03          	ldw	x,(OFST-1,sp)
3519  039e 724f0050      	clr	(_buff,x)
3522  03a2 1e03          	ldw	x,(OFST-1,sp)
3523  03a4 1c0001        	addw	x,#1
3524  03a7 1f03          	ldw	(OFST-1,sp),x
3527  03a9 1e03          	ldw	x,(OFST-1,sp)
3528  03ab a30100        	cpw	x,#256
3529  03ae 25ec          	jrult	L1402
3530                     ; 308 		if(UIB[2]==1)DF_buffer_write(/*1,*/0,256, buff);
3532  03b0 c60002        	ld	a,_UIB+2
3533  03b3 a101          	cp	a,#1
3534  03b5 2703          	jreq	L44
3535  03b7 cc085f        	jp	L1771
3536  03ba               L44:
3539  03ba ae0050        	ldw	x,#_buff
3540  03bd 89            	pushw	x
3541  03be ae0100        	ldw	x,#256
3542  03c1 89            	pushw	x
3543  03c2 5f            	clrw	x
3544  03c3 cd0b15        	call	_DF_buffer_write
3546  03c6 5b04          	addw	sp,#4
3547  03c8 ac5f085f      	jpf	L1771
3548  03cc               L7302:
3549                     ; 312 	else if(UIB[1]==12)
3551  03cc c60001        	ld	a,_UIB+1
3552  03cf a10c          	cp	a,#12
3553  03d1 2703          	jreq	L64
3554  03d3 cc04b2        	jp	L3502
3555  03d6               L64:
3556                     ; 318 		for(i=0;i<256;i++)buff[i]=0;
3558  03d6 5f            	clrw	x
3559  03d7 1f03          	ldw	(OFST-1,sp),x
3560  03d9               L5502:
3563  03d9 1e03          	ldw	x,(OFST-1,sp)
3564  03db 724f0050      	clr	(_buff,x)
3567  03df 1e03          	ldw	x,(OFST-1,sp)
3568  03e1 1c0001        	addw	x,#1
3569  03e4 1f03          	ldw	(OFST-1,sp),x
3572  03e6 1e03          	ldw	x,(OFST-1,sp)
3573  03e8 a30100        	cpw	x,#256
3574  03eb 25ec          	jrult	L5502
3575                     ; 320 		if(UIB[3]==1)
3577  03ed c60003        	ld	a,_UIB+3
3578  03f0 a101          	cp	a,#1
3579  03f2 2632          	jrne	L3602
3580                     ; 322 			buff[0]=0x00;
3582  03f4 725f0050      	clr	_buff
3583                     ; 323 			buff[1]=0x11;
3585  03f8 35110051      	mov	_buff+1,#17
3586                     ; 324 			buff[2]=0x22;
3588  03fc 35220052      	mov	_buff+2,#34
3589                     ; 325 			buff[3]=0x33;
3591  0400 35330053      	mov	_buff+3,#51
3592                     ; 326 			buff[4]=0x44;
3594  0404 35440054      	mov	_buff+4,#68
3595                     ; 327 			buff[5]=0x55;
3597  0408 35550055      	mov	_buff+5,#85
3598                     ; 328 			buff[6]=0x66;
3600  040c 35660056      	mov	_buff+6,#102
3601                     ; 329 			buff[7]=0x77;
3603  0410 35770057      	mov	_buff+7,#119
3604                     ; 330 			buff[8]=0x88;
3606  0414 35880058      	mov	_buff+8,#136
3607                     ; 331 			buff[9]=0x99;
3609  0418 35990059      	mov	_buff+9,#153
3610                     ; 332 			buff[10]=0;
3612  041c 725f005a      	clr	_buff+10
3613                     ; 333 			buff[11]=0;
3615  0420 725f005b      	clr	_buff+11
3617  0424 2070          	jra	L5602
3618  0426               L3602:
3619                     ; 336 		else if(UIB[3]==2)
3621  0426 c60003        	ld	a,_UIB+3
3622  0429 a102          	cp	a,#2
3623  042b 2632          	jrne	L7602
3624                     ; 338 			buff[0]=0x00;
3626  042d 725f0050      	clr	_buff
3627                     ; 339 			buff[1]=0x10;
3629  0431 35100051      	mov	_buff+1,#16
3630                     ; 340 			buff[2]=0x20;
3632  0435 35200052      	mov	_buff+2,#32
3633                     ; 341 			buff[3]=0x30;
3635  0439 35300053      	mov	_buff+3,#48
3636                     ; 342 			buff[4]=0x40;
3638  043d 35400054      	mov	_buff+4,#64
3639                     ; 343 			buff[5]=0x50;
3641  0441 35500055      	mov	_buff+5,#80
3642                     ; 344 			buff[6]=0x60;
3644  0445 35600056      	mov	_buff+6,#96
3645                     ; 345 			buff[7]=0x70;
3647  0449 35700057      	mov	_buff+7,#112
3648                     ; 346 			buff[8]=0x80;
3650  044d 35800058      	mov	_buff+8,#128
3651                     ; 347 			buff[9]=0x90;
3653  0451 35900059      	mov	_buff+9,#144
3654                     ; 348 			buff[10]=0;
3656  0455 725f005a      	clr	_buff+10
3657                     ; 349 			buff[11]=0;
3659  0459 725f005b      	clr	_buff+11
3661  045d 2037          	jra	L5602
3662  045f               L7602:
3663                     ; 352 		else if(UIB[3]==3)
3665  045f c60003        	ld	a,_UIB+3
3666  0462 a103          	cp	a,#3
3667  0464 2630          	jrne	L5602
3668                     ; 354 			buff[0]=0x98;
3670  0466 35980050      	mov	_buff,#152
3671                     ; 355 			buff[1]=0x87;
3673  046a 35870051      	mov	_buff+1,#135
3674                     ; 356 			buff[2]=0x76;
3676  046e 35760052      	mov	_buff+2,#118
3677                     ; 357 			buff[3]=0x65;
3679  0472 35650053      	mov	_buff+3,#101
3680                     ; 358 			buff[4]=0x54;
3682  0476 35540054      	mov	_buff+4,#84
3683                     ; 359 			buff[5]=0x43;
3685  047a 35430055      	mov	_buff+5,#67
3686                     ; 360 			buff[6]=0x32;
3688  047e 35320056      	mov	_buff+6,#50
3689                     ; 361 			buff[7]=0x21;
3691  0482 35210057      	mov	_buff+7,#33
3692                     ; 362 			buff[8]=0x10;
3694  0486 35100058      	mov	_buff+8,#16
3695                     ; 363 			buff[9]=0x00;
3697  048a 725f0059      	clr	_buff+9
3698                     ; 364 			buff[10]=0;
3700  048e 725f005a      	clr	_buff+10
3701                     ; 365 			buff[11]=0;
3703  0492 725f005b      	clr	_buff+11
3704  0496               L5602:
3705                     ; 367 		if(UIB[2]==1)DF_buffer_write(/*1,*/0,256, buff);
3707  0496 c60002        	ld	a,_UIB+2
3708  0499 a101          	cp	a,#1
3709  049b 2703          	jreq	L05
3710  049d cc085f        	jp	L1771
3711  04a0               L05:
3714  04a0 ae0050        	ldw	x,#_buff
3715  04a3 89            	pushw	x
3716  04a4 ae0100        	ldw	x,#256
3717  04a7 89            	pushw	x
3718  04a8 5f            	clrw	x
3719  04a9 cd0b15        	call	_DF_buffer_write
3721  04ac 5b04          	addw	sp,#4
3722  04ae ac5f085f      	jpf	L1771
3723  04b2               L3502:
3724                     ; 371 	else if(UIB[1]==13)
3726  04b2 c60001        	ld	a,_UIB+1
3727  04b5 a10d          	cp	a,#13
3728  04b7 2703cc0555    	jrne	L1012
3729                     ; 376 		if(memory_manufacturer=='A') {	
3731  04bc b6bc          	ld	a,_memory_manufacturer
3732  04be a141          	cp	a,#65
3733  04c0 2608          	jrne	L3012
3734                     ; 377 			DF_page_to_buffer(/*UIB[2],*/UIB[3]);
3736  04c2 c60003        	ld	a,_UIB+3
3737  04c5 5f            	clrw	x
3738  04c6 97            	ld	xl,a
3739  04c7 cd0a89        	call	_DF_page_to_buffer
3741  04ca               L3012:
3742                     ; 379 		if(memory_manufacturer=='S') {
3744  04ca b6bc          	ld	a,_memory_manufacturer
3745  04cc a153          	cp	a,#83
3746  04ce 2703          	jreq	L25
3747  04d0 cc085f        	jp	L1771
3748  04d3               L25:
3749                     ; 380 			current_page=11;
3751  04d3 ae000b        	ldw	x,#11
3752  04d6 bf0f          	ldw	_current_page,x
3753                     ; 381 			ST_READ((long)(current_page*256),256, buff);
3755  04d8 ae0050        	ldw	x,#_buff
3756  04db 89            	pushw	x
3757  04dc ae0100        	ldw	x,#256
3758  04df 89            	pushw	x
3759  04e0 ae0b00        	ldw	x,#2816
3760  04e3 89            	pushw	x
3761  04e4 ae0000        	ldw	x,#0
3762  04e7 89            	pushw	x
3763  04e8 cd09cd        	call	_ST_READ
3765  04eb 5b08          	addw	sp,#8
3766                     ; 383 			uart_out_adr_block (0,buff,64);
3768  04ed 4b40          	push	#64
3769  04ef ae0050        	ldw	x,#_buff
3770  04f2 89            	pushw	x
3771  04f3 ae0000        	ldw	x,#0
3772  04f6 89            	pushw	x
3773  04f7 ae0000        	ldw	x,#0
3774  04fa 89            	pushw	x
3775  04fb cd0178        	call	_uart_out_adr_block
3777  04fe 5b07          	addw	sp,#7
3778                     ; 384 			delay_ms(100);    
3780  0500 ae0064        	ldw	x,#100
3781  0503 cd005c        	call	_delay_ms
3783                     ; 385 			uart_out_adr_block (64,&buff[64],64);
3785  0506 4b40          	push	#64
3786  0508 ae0090        	ldw	x,#_buff+64
3787  050b 89            	pushw	x
3788  050c ae0040        	ldw	x,#64
3789  050f 89            	pushw	x
3790  0510 ae0000        	ldw	x,#0
3791  0513 89            	pushw	x
3792  0514 cd0178        	call	_uart_out_adr_block
3794  0517 5b07          	addw	sp,#7
3795                     ; 386 			delay_ms(100);    
3797  0519 ae0064        	ldw	x,#100
3798  051c cd005c        	call	_delay_ms
3800                     ; 387 			uart_out_adr_block (128,&buff[128],64);
3802  051f 4b40          	push	#64
3803  0521 ae00d0        	ldw	x,#_buff+128
3804  0524 89            	pushw	x
3805  0525 ae0080        	ldw	x,#128
3806  0528 89            	pushw	x
3807  0529 ae0000        	ldw	x,#0
3808  052c 89            	pushw	x
3809  052d cd0178        	call	_uart_out_adr_block
3811  0530 5b07          	addw	sp,#7
3812                     ; 388 			delay_ms(100);    
3814  0532 ae0064        	ldw	x,#100
3815  0535 cd005c        	call	_delay_ms
3817                     ; 389 			uart_out_adr_block (192,&buff[192],64);
3819  0538 4b40          	push	#64
3820  053a ae0110        	ldw	x,#_buff+192
3821  053d 89            	pushw	x
3822  053e ae00c0        	ldw	x,#192
3823  0541 89            	pushw	x
3824  0542 ae0000        	ldw	x,#0
3825  0545 89            	pushw	x
3826  0546 cd0178        	call	_uart_out_adr_block
3828  0549 5b07          	addw	sp,#7
3829                     ; 390 			delay_ms(100); 
3831  054b ae0064        	ldw	x,#100
3832  054e cd005c        	call	_delay_ms
3834  0551 ac5f085f      	jpf	L1771
3835  0555               L1012:
3836                     ; 393 	else if(UIB[1]==14)
3838  0555 c60001        	ld	a,_UIB+1
3839  0558 a10e          	cp	a,#14
3840  055a 265b          	jrne	L1112
3841                     ; 398 		if(memory_manufacturer=='A') {	
3843  055c b6bc          	ld	a,_memory_manufacturer
3844  055e a141          	cp	a,#65
3845  0560 2608          	jrne	L3112
3846                     ; 399 			DF_buffer_to_page_er(/*UIB[2],*/UIB[3]);
3848  0562 c60003        	ld	a,_UIB+3
3849  0565 5f            	clrw	x
3850  0566 97            	ld	xl,a
3851  0567 cd0aac        	call	_DF_buffer_to_page_er
3853  056a               L3112:
3854                     ; 401 		if(memory_manufacturer=='S') {
3856  056a b6bc          	ld	a,_memory_manufacturer
3857  056c a153          	cp	a,#83
3858  056e 2703          	jreq	L45
3859  0570 cc085f        	jp	L1771
3860  0573               L45:
3861                     ; 402 			for(i=0;i<256;i++) {
3863  0573 5f            	clrw	x
3864  0574 1f03          	ldw	(OFST-1,sp),x
3865  0576               L7112:
3866                     ; 403 				buff[i]=(char)i;
3868  0576 7b04          	ld	a,(OFST+0,sp)
3869  0578 1e03          	ldw	x,(OFST-1,sp)
3870  057a d70050        	ld	(_buff,x),a
3871                     ; 402 			for(i=0;i<256;i++) {
3873  057d 1e03          	ldw	x,(OFST-1,sp)
3874  057f 1c0001        	addw	x,#1
3875  0582 1f03          	ldw	(OFST-1,sp),x
3878  0584 1e03          	ldw	x,(OFST-1,sp)
3879  0586 a30100        	cpw	x,#256
3880  0589 25eb          	jrult	L7112
3881                     ; 405 			current_page=11;
3883  058b ae000b        	ldw	x,#11
3884  058e bf0f          	ldw	_current_page,x
3885                     ; 406 			ST_WREN();
3887  0590 cd0974        	call	_ST_WREN
3889                     ; 407 			delay_ms(100);
3891  0593 ae0064        	ldw	x,#100
3892  0596 cd005c        	call	_delay_ms
3894                     ; 408 			ST_WRITE((long)(current_page*256),256,buff);		
3896  0599 ae0050        	ldw	x,#_buff
3897  059c 89            	pushw	x
3898  059d ae0100        	ldw	x,#256
3899  05a0 89            	pushw	x
3900  05a1 be0f          	ldw	x,_current_page
3901  05a3 4f            	clr	a
3902  05a4 02            	rlwa	x,a
3903  05a5 cd0000        	call	c_uitolx
3905  05a8 be02          	ldw	x,c_lreg+2
3906  05aa 89            	pushw	x
3907  05ab be00          	ldw	x,c_lreg
3908  05ad 89            	pushw	x
3909  05ae cd0981        	call	_ST_WRITE
3911  05b1 5b08          	addw	sp,#8
3912  05b3 ac5f085f      	jpf	L1771
3913  05b7               L1112:
3914                     ; 413 	else if(UIB[1]==20)
3916  05b7 c60001        	ld	a,_UIB+1
3917  05ba a114          	cp	a,#20
3918  05bc 2703cc0648    	jrne	L7212
3919                     ; 418 		file_lengt=0;
3921  05c1 ae0000        	ldw	x,#0
3922  05c4 bf09          	ldw	_file_lengt+2,x
3923  05c6 ae0000        	ldw	x,#0
3924  05c9 bf07          	ldw	_file_lengt,x
3925                     ; 419 		file_lengt+=UIB[5];
3927  05cb c60005        	ld	a,_UIB+5
3928  05ce ae0007        	ldw	x,#_file_lengt
3929  05d1 88            	push	a
3930  05d2 cd0000        	call	c_lgadc
3932  05d5 84            	pop	a
3933                     ; 420 		file_lengt<<=8;
3935  05d6 ae0007        	ldw	x,#_file_lengt
3936  05d9 a608          	ld	a,#8
3937  05db cd0000        	call	c_lglsh
3939                     ; 421 		file_lengt+=UIB[4];
3941  05de c60004        	ld	a,_UIB+4
3942  05e1 ae0007        	ldw	x,#_file_lengt
3943  05e4 88            	push	a
3944  05e5 cd0000        	call	c_lgadc
3946  05e8 84            	pop	a
3947                     ; 422 		file_lengt<<=8;
3949  05e9 ae0007        	ldw	x,#_file_lengt
3950  05ec a608          	ld	a,#8
3951  05ee cd0000        	call	c_lglsh
3953                     ; 423 		file_lengt+=UIB[3];
3955  05f1 c60003        	ld	a,_UIB+3
3956  05f4 ae0007        	ldw	x,#_file_lengt
3957  05f7 88            	push	a
3958  05f8 cd0000        	call	c_lgadc
3960  05fb 84            	pop	a
3961                     ; 424 		file_lengt_in_pages=file_lengt;
3963  05fc be09          	ldw	x,_file_lengt+2
3964  05fe bf11          	ldw	_file_lengt_in_pages,x
3965                     ; 425 		file_lengt<<=8;
3967  0600 ae0007        	ldw	x,#_file_lengt
3968  0603 a608          	ld	a,#8
3969  0605 cd0000        	call	c_lglsh
3971                     ; 426 		file_lengt+=UIB[2];
3973  0608 c60002        	ld	a,_UIB+2
3974  060b ae0007        	ldw	x,#_file_lengt
3975  060e 88            	push	a
3976  060f cd0000        	call	c_lgadc
3978  0612 84            	pop	a
3979                     ; 431 		current_page=0;
3981  0613 5f            	clrw	x
3982  0614 bf0f          	ldw	_current_page,x
3983                     ; 432 		current_byte_in_buffer=0;
3985  0616 5f            	clrw	x
3986  0617 bf0b          	ldw	_current_byte_in_buffer,x
3987                     ; 434 		if(memory_manufacturer=='S') {
3989  0619 b6bc          	ld	a,_memory_manufacturer
3990  061b a153          	cp	a,#83
3991  061d 260c          	jrne	L1312
3992                     ; 435 			ST_WREN();
3994  061f cd0974        	call	_ST_WREN
3996                     ; 436 					delay_ms(100);
3998  0622 ae0064        	ldw	x,#100
3999  0625 cd005c        	call	_delay_ms
4001                     ; 437 		ST_bulk_erase();
4003  0628 cd0967        	call	_ST_bulk_erase
4005  062b               L1312:
4006                     ; 439 		uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
4008  062b 4b00          	push	#0
4009  062d 4b00          	push	#0
4010  062f 3b000f        	push	_current_page
4011  0632 b610          	ld	a,_current_page+1
4012  0634 a4ff          	and	a,#255
4013  0636 88            	push	a
4014  0637 4b15          	push	#21
4015  0639 ae0016        	ldw	x,#22
4016  063c a604          	ld	a,#4
4017  063e 95            	ld	xh,a
4018  063f cd00ce        	call	_uart_out
4020  0642 5b05          	addw	sp,#5
4022  0644 ac5f085f      	jpf	L1771
4023  0648               L7212:
4024                     ; 442 	else if(UIB[1]==21)
4026  0648 c60001        	ld	a,_UIB+1
4027  064b a115          	cp	a,#21
4028  064d 2703          	jreq	L65
4029  064f cc0744        	jp	L5312
4030  0652               L65:
4031                     ; 447           for(i=0;i<64;i++)
4033  0652 5f            	clrw	x
4034  0653 1f03          	ldw	(OFST-1,sp),x
4035  0655               L7312:
4036                     ; 449           	buff[current_byte_in_buffer+i]=UIB[2+i];
4038  0655 1e03          	ldw	x,(OFST-1,sp)
4039  0657 d60002        	ld	a,(_UIB+2,x)
4040  065a be0b          	ldw	x,_current_byte_in_buffer
4041  065c 72fb03        	addw	x,(OFST-1,sp)
4042  065f d70050        	ld	(_buff,x),a
4043                     ; 447           for(i=0;i<64;i++)
4045  0662 1e03          	ldw	x,(OFST-1,sp)
4046  0664 1c0001        	addw	x,#1
4047  0667 1f03          	ldw	(OFST-1,sp),x
4050  0669 1e03          	ldw	x,(OFST-1,sp)
4051  066b a30040        	cpw	x,#64
4052  066e 25e5          	jrult	L7312
4053                     ; 451           current_byte_in_buffer+=64;
4055  0670 be0b          	ldw	x,_current_byte_in_buffer
4056  0672 1c0040        	addw	x,#64
4057  0675 bf0b          	ldw	_current_byte_in_buffer,x
4058                     ; 452           if(current_byte_in_buffer>=256)
4060  0677 be0b          	ldw	x,_current_byte_in_buffer
4061  0679 a30100        	cpw	x,#256
4062  067c 2403          	jruge	L06
4063  067e cc085f        	jp	L1771
4064  0681               L06:
4065                     ; 460 			if(memory_manufacturer=='A') {
4067  0681 b6bc          	ld	a,_memory_manufacturer
4068  0683 a141          	cp	a,#65
4069  0685 264e          	jrne	L7412
4070                     ; 461 				DF_buffer_write(/*//current_buffer*//*1,*/0,256,buff);
4072  0687 ae0050        	ldw	x,#_buff
4073  068a 89            	pushw	x
4074  068b ae0100        	ldw	x,#256
4075  068e 89            	pushw	x
4076  068f 5f            	clrw	x
4077  0690 cd0b15        	call	_DF_buffer_write
4079  0693 5b04          	addw	sp,#4
4080                     ; 462 				DF_buffer_to_page_er(/*///current_buffer*//*1,*/current_page);
4082  0695 be0f          	ldw	x,_current_page
4083  0697 cd0aac        	call	_DF_buffer_to_page_er
4085                     ; 463 				current_page++;
4087  069a be0f          	ldw	x,_current_page
4088  069c 1c0001        	addw	x,#1
4089  069f bf0f          	ldw	_current_page,x
4090                     ; 464 				if(current_page<file_lengt_in_pages)
4092  06a1 be0f          	ldw	x,_current_page
4093  06a3 b311          	cpw	x,_file_lengt_in_pages
4094  06a5 2424          	jruge	L1512
4095                     ; 466 					delay_ms(100);
4097  06a7 ae0064        	ldw	x,#100
4098  06aa cd005c        	call	_delay_ms
4100                     ; 467 					uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
4102  06ad 4b00          	push	#0
4103  06af 4b00          	push	#0
4104  06b1 3b000f        	push	_current_page
4105  06b4 b610          	ld	a,_current_page+1
4106  06b6 a4ff          	and	a,#255
4107  06b8 88            	push	a
4108  06b9 4b15          	push	#21
4109  06bb ae0016        	ldw	x,#22
4110  06be a604          	ld	a,#4
4111  06c0 95            	ld	xh,a
4112  06c1 cd00ce        	call	_uart_out
4114  06c4 5b05          	addw	sp,#5
4115                     ; 468 					current_byte_in_buffer=0;
4117  06c6 5f            	clrw	x
4118  06c7 bf0b          	ldw	_current_byte_in_buffer,x
4120  06c9 200a          	jra	L7412
4121  06cb               L1512:
4122                     ; 472 					EE_PAGE_LEN=current_page;
4124  06cb be0f          	ldw	x,_current_page
4125  06cd 89            	pushw	x
4126  06ce ae0000        	ldw	x,#_EE_PAGE_LEN
4127  06d1 cd0000        	call	c_eewrw
4129  06d4 85            	popw	x
4130  06d5               L7412:
4131                     ; 475 			if(memory_manufacturer=='S') {
4133  06d5 b6bc          	ld	a,_memory_manufacturer
4134  06d7 a153          	cp	a,#83
4135  06d9 2703          	jreq	L26
4136  06db cc085f        	jp	L1771
4137  06de               L26:
4138                     ; 476 				ST_WREN();
4140  06de cd0974        	call	_ST_WREN
4142                     ; 477 				delay_ms(100);
4144  06e1 ae0064        	ldw	x,#100
4145  06e4 cd005c        	call	_delay_ms
4147                     ; 478 				ST_WRITE((unsigned long)(current_page*256UL),256,buff);
4149  06e7 ae0050        	ldw	x,#_buff
4150  06ea 89            	pushw	x
4151  06eb ae0100        	ldw	x,#256
4152  06ee 89            	pushw	x
4153  06ef be0f          	ldw	x,_current_page
4154  06f1 90ae0100      	ldw	y,#256
4155  06f5 cd0000        	call	c_umul
4157  06f8 be02          	ldw	x,c_lreg+2
4158  06fa 89            	pushw	x
4159  06fb be00          	ldw	x,c_lreg
4160  06fd 89            	pushw	x
4161  06fe cd0981        	call	_ST_WRITE
4163  0701 5b08          	addw	sp,#8
4164                     ; 479 				current_page++;
4166  0703 be0f          	ldw	x,_current_page
4167  0705 1c0001        	addw	x,#1
4168  0708 bf0f          	ldw	_current_page,x
4169                     ; 480 				if(current_page<file_lengt_in_pages)
4171  070a be0f          	ldw	x,_current_page
4172  070c b311          	cpw	x,_file_lengt_in_pages
4173  070e 2426          	jruge	L7512
4174                     ; 482 					delay_ms(100);
4176  0710 ae0064        	ldw	x,#100
4177  0713 cd005c        	call	_delay_ms
4179                     ; 483 					uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
4181  0716 4b00          	push	#0
4182  0718 4b00          	push	#0
4183  071a 3b000f        	push	_current_page
4184  071d b610          	ld	a,_current_page+1
4185  071f a4ff          	and	a,#255
4186  0721 88            	push	a
4187  0722 4b15          	push	#21
4188  0724 ae0016        	ldw	x,#22
4189  0727 a604          	ld	a,#4
4190  0729 95            	ld	xh,a
4191  072a cd00ce        	call	_uart_out
4193  072d 5b05          	addw	sp,#5
4194                     ; 484 					current_byte_in_buffer=0;
4196  072f 5f            	clrw	x
4197  0730 bf0b          	ldw	_current_byte_in_buffer,x
4199  0732 ac5f085f      	jpf	L1771
4200  0736               L7512:
4201                     ; 488 					EE_PAGE_LEN=current_page;
4203  0736 be0f          	ldw	x,_current_page
4204  0738 89            	pushw	x
4205  0739 ae0000        	ldw	x,#_EE_PAGE_LEN
4206  073c cd0000        	call	c_eewrw
4208  073f 85            	popw	x
4209  0740 ac5f085f      	jpf	L1771
4210  0744               L5312:
4211                     ; 499 	else if(UIB[1]==24) {
4213  0744 c60001        	ld	a,_UIB+1
4214  0747 a118          	cp	a,#24
4215  0749 2615          	jrne	L5612
4216                     ; 502 		rele_cnt=10;
4218  074b ae000a        	ldw	x,#10
4219  074e bf03          	ldw	_rele_cnt,x
4220                     ; 503 		ST_WREN();
4222  0750 cd0974        	call	_ST_WREN
4224                     ; 504 		delay_ms(100);
4226  0753 ae0064        	ldw	x,#100
4227  0756 cd005c        	call	_delay_ms
4229                     ; 505 		ST_bulk_erase();
4231  0759 cd0967        	call	_ST_bulk_erase
4234  075c ac5f085f      	jpf	L1771
4235  0760               L5612:
4236                     ; 510 	else if(UIB[1]==25)
4238  0760 c60001        	ld	a,_UIB+1
4239  0763 a119          	cp	a,#25
4240  0765 2703          	jreq	L46
4241  0767 cc0847        	jp	L1712
4242  076a               L46:
4243                     ; 514 		current_page=0;
4245  076a 5f            	clrw	x
4246  076b bf0f          	ldw	_current_page,x
4247                     ; 516 		for(i__=0;i__<EE_PAGE_LEN;i__++)
4249  076d 5f            	clrw	x
4250  076e 1f03          	ldw	(OFST-1,sp),x
4252  0770 ac3b083b      	jpf	L7712
4253  0774               L3712:
4254                     ; 518 			if(memory_manufacturer=='S') {	
4256  0774 b6bc          	ld	a,_memory_manufacturer
4257  0776 a153          	cp	a,#83
4258  0778 2619          	jrne	L3022
4259                     ; 519 				DF_page_to_buffer(i__);
4261  077a 1e03          	ldw	x,(OFST-1,sp)
4262  077c cd0a89        	call	_DF_page_to_buffer
4264                     ; 520 				delay_ms(100);			
4266  077f ae0064        	ldw	x,#100
4267  0782 cd005c        	call	_delay_ms
4269                     ; 521 				DF_buffer_read(0,256, buff);
4271  0785 ae0050        	ldw	x,#_buff
4272  0788 89            	pushw	x
4273  0789 ae0100        	ldw	x,#256
4274  078c 89            	pushw	x
4275  078d 5f            	clrw	x
4276  078e cd0acf        	call	_DF_buffer_read
4278  0791 5b04          	addw	sp,#4
4279  0793               L3022:
4280                     ; 524 			if(memory_manufacturer=='S') {	
4282  0793 b6bc          	ld	a,_memory_manufacturer
4283  0795 a153          	cp	a,#83
4284  0797 261a          	jrne	L5022
4285                     ; 525 				ST_READ((long)(i__*256),256, buff);
4287  0799 ae0050        	ldw	x,#_buff
4288  079c 89            	pushw	x
4289  079d ae0100        	ldw	x,#256
4290  07a0 89            	pushw	x
4291  07a1 1e07          	ldw	x,(OFST+3,sp)
4292  07a3 4f            	clr	a
4293  07a4 02            	rlwa	x,a
4294  07a5 cd0000        	call	c_itolx
4296  07a8 be02          	ldw	x,c_lreg+2
4297  07aa 89            	pushw	x
4298  07ab be00          	ldw	x,c_lreg
4299  07ad 89            	pushw	x
4300  07ae cd09cd        	call	_ST_READ
4302  07b1 5b08          	addw	sp,#8
4303  07b3               L5022:
4304                     ; 528 			uart_out_adr_block ((256*i__)+0,buff,64);
4306  07b3 4b40          	push	#64
4307  07b5 ae0050        	ldw	x,#_buff
4308  07b8 89            	pushw	x
4309  07b9 1e06          	ldw	x,(OFST+2,sp)
4310  07bb 4f            	clr	a
4311  07bc 02            	rlwa	x,a
4312  07bd cd0000        	call	c_itolx
4314  07c0 be02          	ldw	x,c_lreg+2
4315  07c2 89            	pushw	x
4316  07c3 be00          	ldw	x,c_lreg
4317  07c5 89            	pushw	x
4318  07c6 cd0178        	call	_uart_out_adr_block
4320  07c9 5b07          	addw	sp,#7
4321                     ; 529 			delay_ms(100);    
4323  07cb ae0064        	ldw	x,#100
4324  07ce cd005c        	call	_delay_ms
4326                     ; 530 			uart_out_adr_block ((256*i__)+64,&buff[64],64);
4328  07d1 4b40          	push	#64
4329  07d3 ae0090        	ldw	x,#_buff+64
4330  07d6 89            	pushw	x
4331  07d7 1e06          	ldw	x,(OFST+2,sp)
4332  07d9 4f            	clr	a
4333  07da 02            	rlwa	x,a
4334  07db 1c0040        	addw	x,#64
4335  07de cd0000        	call	c_itolx
4337  07e1 be02          	ldw	x,c_lreg+2
4338  07e3 89            	pushw	x
4339  07e4 be00          	ldw	x,c_lreg
4340  07e6 89            	pushw	x
4341  07e7 cd0178        	call	_uart_out_adr_block
4343  07ea 5b07          	addw	sp,#7
4344                     ; 531 			delay_ms(100);    
4346  07ec ae0064        	ldw	x,#100
4347  07ef cd005c        	call	_delay_ms
4349                     ; 532 			uart_out_adr_block ((256*i__)+128,&buff[128],64);
4351  07f2 4b40          	push	#64
4352  07f4 ae00d0        	ldw	x,#_buff+128
4353  07f7 89            	pushw	x
4354  07f8 1e06          	ldw	x,(OFST+2,sp)
4355  07fa 4f            	clr	a
4356  07fb 02            	rlwa	x,a
4357  07fc 1c0080        	addw	x,#128
4358  07ff cd0000        	call	c_itolx
4360  0802 be02          	ldw	x,c_lreg+2
4361  0804 89            	pushw	x
4362  0805 be00          	ldw	x,c_lreg
4363  0807 89            	pushw	x
4364  0808 cd0178        	call	_uart_out_adr_block
4366  080b 5b07          	addw	sp,#7
4367                     ; 533 			delay_ms(100);    
4369  080d ae0064        	ldw	x,#100
4370  0810 cd005c        	call	_delay_ms
4372                     ; 534 			uart_out_adr_block ((256*i__)+192,&buff[192],64);
4374  0813 4b40          	push	#64
4375  0815 ae0110        	ldw	x,#_buff+192
4376  0818 89            	pushw	x
4377  0819 1e06          	ldw	x,(OFST+2,sp)
4378  081b 4f            	clr	a
4379  081c 02            	rlwa	x,a
4380  081d 1c00c0        	addw	x,#192
4381  0820 cd0000        	call	c_itolx
4383  0823 be02          	ldw	x,c_lreg+2
4384  0825 89            	pushw	x
4385  0826 be00          	ldw	x,c_lreg
4386  0828 89            	pushw	x
4387  0829 cd0178        	call	_uart_out_adr_block
4389  082c 5b07          	addw	sp,#7
4390                     ; 535 			delay_ms(100);   
4392  082e ae0064        	ldw	x,#100
4393  0831 cd005c        	call	_delay_ms
4395                     ; 516 		for(i__=0;i__<EE_PAGE_LEN;i__++)
4397  0834 1e03          	ldw	x,(OFST-1,sp)
4398  0836 1c0001        	addw	x,#1
4399  0839 1f03          	ldw	(OFST-1,sp),x
4400  083b               L7712:
4403  083b 1e03          	ldw	x,(OFST-1,sp)
4404  083d c30000        	cpw	x,_EE_PAGE_LEN
4405  0840 2403          	jruge	L66
4406  0842 cc0774        	jp	L3712
4407  0845               L66:
4409  0845 2018          	jra	L1771
4410  0847               L1712:
4411                     ; 545 	else if(UIB[1]==30)
4413  0847 c60001        	ld	a,_UIB+1
4414  084a a11e          	cp	a,#30
4415  084c 2606          	jrne	L1122
4416                     ; 567           bSTART=1;
4418  084e 7210000c      	bset	_bSTART
4420  0852 200b          	jra	L1771
4421  0854               L1122:
4422                     ; 579 	else if(UIB[1]==40)
4424  0854 c60001        	ld	a,_UIB+1
4425  0857 a128          	cp	a,#40
4426  0859 2604          	jrne	L1771
4427                     ; 601 		bSTART=1;	
4429  085b 7210000c      	bset	_bSTART
4430  085f               L1771:
4431                     ; 606 }
4434  085f 5b04          	addw	sp,#4
4435  0861 81            	ret
4472                     ; 609 void putchar(char c)
4472                     ; 610 {
4473                     	switch	.text
4474  0862               _putchar:
4476  0862 88            	push	a
4477       00000000      OFST:	set	0
4480  0863               L7322:
4481                     ; 611 while (tx_counter == TX_BUFFER_SIZE);
4483  0863 b620          	ld	a,_tx_counter
4484  0865 a150          	cp	a,#80
4485  0867 27fa          	jreq	L7322
4486                     ; 613 if (tx_counter || ((UART1->SR & UART1_SR_TXE)==0))
4488  0869 3d20          	tnz	_tx_counter
4489  086b 2607          	jrne	L5422
4491  086d c65230        	ld	a,21040
4492  0870 a580          	bcp	a,#128
4493  0872 261d          	jrne	L3422
4494  0874               L5422:
4495                     ; 615    tx_buffer[tx_wr_index]=c;
4497  0874 5f            	clrw	x
4498  0875 b61f          	ld	a,_tx_wr_index
4499  0877 2a01          	jrpl	L27
4500  0879 53            	cplw	x
4501  087a               L27:
4502  087a 97            	ld	xl,a
4503  087b 7b01          	ld	a,(OFST+1,sp)
4504  087d e704          	ld	(_tx_buffer,x),a
4505                     ; 616    if (++tx_wr_index == TX_BUFFER_SIZE) tx_wr_index=0;
4507  087f 3c1f          	inc	_tx_wr_index
4508  0881 b61f          	ld	a,_tx_wr_index
4509  0883 a150          	cp	a,#80
4510  0885 2602          	jrne	L7422
4513  0887 3f1f          	clr	_tx_wr_index
4514  0889               L7422:
4515                     ; 617    ++tx_counter;
4517  0889 3c20          	inc	_tx_counter
4519  088b               L1522:
4520                     ; 621 UART1->CR2|= UART1_CR2_TIEN;
4522  088b 721e5235      	bset	21045,#7
4523                     ; 623 }
4526  088f 84            	pop	a
4527  0890 81            	ret
4528  0891               L3422:
4529                     ; 619 else UART1->DR=c;
4531  0891 7b01          	ld	a,(OFST+1,sp)
4532  0893 c75231        	ld	21041,a
4533  0896 20f3          	jra	L1522
4556                     ; 626 void spi_init(void){
4557                     	switch	.text
4558  0898               _spi_init:
4562                     ; 628 	GPIOA->DDR|=(1<<3);
4564  0898 72165002      	bset	20482,#3
4565                     ; 629 	GPIOA->CR1|=(1<<3);
4567  089c 72165003      	bset	20483,#3
4568                     ; 630 	GPIOA->CR2&=~(1<<3);
4570  08a0 72175004      	bres	20484,#3
4571                     ; 631 	GPIOA->ODR|=(1<<3);	
4573  08a4 72165000      	bset	20480,#3
4574                     ; 634 	GPIOB->DDR|=(1<<5);
4576  08a8 721a5007      	bset	20487,#5
4577                     ; 635 	GPIOB->CR1|=(1<<5);
4579  08ac 721a5008      	bset	20488,#5
4580                     ; 636 	GPIOB->CR2&=~(1<<5);
4582  08b0 721b5009      	bres	20489,#5
4583                     ; 637 	GPIOB->ODR|=(1<<5);	
4585  08b4 721a5005      	bset	20485,#5
4586                     ; 639 	GPIOC->DDR|=(1<<3);
4588  08b8 7216500c      	bset	20492,#3
4589                     ; 640 	GPIOC->CR1|=(1<<3);
4591  08bc 7216500d      	bset	20493,#3
4592                     ; 641 	GPIOC->CR2&=~(1<<3);
4594  08c0 7217500e      	bres	20494,#3
4595                     ; 642 	GPIOC->ODR|=(1<<3);	
4597  08c4 7216500a      	bset	20490,#3
4598                     ; 644 	GPIOC->DDR|=(1<<5);
4600  08c8 721a500c      	bset	20492,#5
4601                     ; 645 	GPIOC->CR1|=(1<<5);
4603  08cc 721a500d      	bset	20493,#5
4604                     ; 646 	GPIOC->CR2|=(1<<5);
4606  08d0 721a500e      	bset	20494,#5
4607                     ; 647 	GPIOC->ODR|=(1<<5);	
4609  08d4 721a500a      	bset	20490,#5
4610                     ; 649 	GPIOC->DDR|=(1<<6);
4612  08d8 721c500c      	bset	20492,#6
4613                     ; 650 	GPIOC->CR1|=(1<<6);
4615  08dc 721c500d      	bset	20493,#6
4616                     ; 651 	GPIOC->CR2|=(1<<6);
4618  08e0 721c500e      	bset	20494,#6
4619                     ; 652 	GPIOC->ODR|=(1<<6);	
4621  08e4 721c500a      	bset	20490,#6
4622                     ; 654 	GPIOC->DDR&=~(1<<7);
4624  08e8 721f500c      	bres	20492,#7
4625                     ; 655 	GPIOC->CR1&=~(1<<7);
4627  08ec 721f500d      	bres	20493,#7
4628                     ; 656 	GPIOC->CR2&=~(1<<7);
4630  08f0 721f500e      	bres	20494,#7
4631                     ; 657 	GPIOC->ODR|=(1<<7);	
4633  08f4 721e500a      	bset	20490,#7
4634                     ; 659 	SPI->CR1= /*SPI_CR1_LSBFIRST |*/
4634                     ; 660 			SPI_CR1_SPE | 
4634                     ; 661 			( (4<< 3) & SPI_CR1_BR ) |
4634                     ; 662 			SPI_CR1_MSTR |
4634                     ; 663 			SPI_CR1_CPOL |
4634                     ; 664 			SPI_CR1_CPHA; 
4636  08f8 35675200      	mov	20992,#103
4637                     ; 666 	SPI->CR2= SPI_CR2_SSM | SPI_CR2_SSI;
4639  08fc 35035201      	mov	20993,#3
4640                     ; 667 	SPI->ICR= 0;	
4642  0900 725f5202      	clr	20994
4643                     ; 668 }
4646  0904 81            	ret
4689                     ; 671 char spi(char in){
4690                     	switch	.text
4691  0905               _spi:
4693  0905 88            	push	a
4694  0906 88            	push	a
4695       00000001      OFST:	set	1
4698  0907               L7032:
4699                     ; 673 	while(!((SPI->SR)&SPI_SR_TXE));
4701  0907 c65203        	ld	a,20995
4702  090a a502          	bcp	a,#2
4703  090c 27f9          	jreq	L7032
4704                     ; 674 	SPI->DR=in;
4706  090e 7b02          	ld	a,(OFST+1,sp)
4707  0910 c75204        	ld	20996,a
4709  0913               L7132:
4710                     ; 675 	while(!((SPI->SR)&SPI_SR_RXNE));
4712  0913 c65203        	ld	a,20995
4713  0916 a501          	bcp	a,#1
4714  0918 27f9          	jreq	L7132
4715                     ; 676 	c=SPI->DR;	
4717  091a c65204        	ld	a,20996
4718  091d 6b01          	ld	(OFST+0,sp),a
4719                     ; 677 	return c;
4721  091f 7b01          	ld	a,(OFST+0,sp)
4724  0921 85            	popw	x
4725  0922 81            	ret
4790                     ; 681 long ST_RDID_read(void)
4790                     ; 682 {
4791                     	switch	.text
4792  0923               _ST_RDID_read:
4794  0923 5204          	subw	sp,#4
4795       00000004      OFST:	set	4
4798                     ; 685 d0=0;
4800  0925 0f04          	clr	(OFST+0,sp)
4801                     ; 686 d1=0;
4803                     ; 687 d2=0;
4805                     ; 688 d3=0;
4807                     ; 690 ST_CS_ON
4809  0927 721b5005      	bres	20485,#5
4810                     ; 691 spi(0x9f);
4812  092b a69f          	ld	a,#159
4813  092d add6          	call	_spi
4815                     ; 692 mdr0=spi(0xff);
4817  092f a6ff          	ld	a,#255
4818  0931 add2          	call	_spi
4820  0933 b716          	ld	_mdr0,a
4821                     ; 693 mdr1=spi(0xff);
4823  0935 a6ff          	ld	a,#255
4824  0937 adcc          	call	_spi
4826  0939 b715          	ld	_mdr1,a
4827                     ; 694 mdr2=spi(0xff);
4829  093b a6ff          	ld	a,#255
4830  093d adc6          	call	_spi
4832  093f b714          	ld	_mdr2,a
4833                     ; 697 ST_CS_OFF
4835  0941 721a5005      	bset	20485,#5
4836                     ; 698 return  *((long*)&d0);
4838  0945 96            	ldw	x,sp
4839  0946 1c0004        	addw	x,#OFST+0
4840  0949 cd0000        	call	c_ltor
4844  094c 5b04          	addw	sp,#4
4845  094e 81            	ret
4880                     ; 702 char ST_status_read(void)
4880                     ; 703 {
4881                     	switch	.text
4882  094f               _ST_status_read:
4884  094f 88            	push	a
4885       00000001      OFST:	set	1
4888                     ; 707 ST_CS_ON
4890  0950 721b5005      	bres	20485,#5
4891                     ; 708 spi(0x05);
4893  0954 a605          	ld	a,#5
4894  0956 adad          	call	_spi
4896                     ; 709 d0=spi(0xff);
4898  0958 a6ff          	ld	a,#255
4899  095a ada9          	call	_spi
4901  095c 6b01          	ld	(OFST+0,sp),a
4902                     ; 711 ST_CS_OFF
4904  095e 721a5005      	bset	20485,#5
4905                     ; 712 return d0;
4907  0962 7b01          	ld	a,(OFST+0,sp)
4910  0964 5b01          	addw	sp,#1
4911  0966 81            	ret
4935                     ; 716 void ST_bulk_erase(void)
4935                     ; 717 {
4936                     	switch	.text
4937  0967               _ST_bulk_erase:
4941                     ; 718 ST_CS_ON
4943  0967 721b5005      	bres	20485,#5
4944                     ; 719 spi(0xC7);
4946  096b a6c7          	ld	a,#199
4947  096d ad96          	call	_spi
4949                     ; 722 ST_CS_OFF
4951  096f 721a5005      	bset	20485,#5
4952                     ; 723 }
4955  0973 81            	ret
4979                     ; 725 void ST_WREN(void)
4979                     ; 726 {
4980                     	switch	.text
4981  0974               _ST_WREN:
4985                     ; 728 ST_CS_ON
4987  0974 721b5005      	bres	20485,#5
4988                     ; 729 spi(0x06);
4990  0978 a606          	ld	a,#6
4991  097a ad89          	call	_spi
4993                     ; 731 ST_CS_OFF
4995  097c 721a5005      	bset	20485,#5
4996                     ; 732 }  
4999  0980 81            	ret
5089                     ; 735 void ST_WRITE(unsigned long memo_addr,unsigned short len, char* adr)
5089                     ; 736 {
5090                     	switch	.text
5091  0981               _ST_WRITE:
5093  0981 5205          	subw	sp,#5
5094       00000005      OFST:	set	5
5097                     ; 740 adr2=(char)(memo_addr>>16);
5099  0983 7b09          	ld	a,(OFST+4,sp)
5100  0985 6b03          	ld	(OFST-2,sp),a
5101                     ; 741 adr1=(char)((memo_addr>>8)&0x00ff);
5103  0987 7b0a          	ld	a,(OFST+5,sp)
5104  0989 a4ff          	and	a,#255
5105  098b 6b02          	ld	(OFST-3,sp),a
5106                     ; 742 adr0=(char)((memo_addr)&0x00ff);
5108  098d 7b0b          	ld	a,(OFST+6,sp)
5109  098f a4ff          	and	a,#255
5110  0991 6b01          	ld	(OFST-4,sp),a
5111                     ; 743 ST_CS_ON
5113  0993 721b5005      	bres	20485,#5
5114                     ; 745 spi(0x02);
5116  0997 a602          	ld	a,#2
5117  0999 cd0905        	call	_spi
5119                     ; 746 spi(adr2);
5121  099c 7b03          	ld	a,(OFST-2,sp)
5122  099e cd0905        	call	_spi
5124                     ; 747 spi(adr1);
5126  09a1 7b02          	ld	a,(OFST-3,sp)
5127  09a3 cd0905        	call	_spi
5129                     ; 748 spi(adr0);
5131  09a6 7b01          	ld	a,(OFST-4,sp)
5132  09a8 cd0905        	call	_spi
5134                     ; 750 for(i=0;i<len;i++)
5136  09ab 5f            	clrw	x
5137  09ac 1f04          	ldw	(OFST-1,sp),x
5139  09ae 2010          	jra	L5642
5140  09b0               L1642:
5141                     ; 752 	spi(adr[i]);
5143  09b0 1e0e          	ldw	x,(OFST+9,sp)
5144  09b2 72fb04        	addw	x,(OFST-1,sp)
5145  09b5 f6            	ld	a,(x)
5146  09b6 cd0905        	call	_spi
5148                     ; 750 for(i=0;i<len;i++)
5150  09b9 1e04          	ldw	x,(OFST-1,sp)
5151  09bb 1c0001        	addw	x,#1
5152  09be 1f04          	ldw	(OFST-1,sp),x
5153  09c0               L5642:
5156  09c0 1e04          	ldw	x,(OFST-1,sp)
5157  09c2 130c          	cpw	x,(OFST+7,sp)
5158  09c4 25ea          	jrult	L1642
5159                     ; 755 ST_CS_OFF
5161  09c6 721a5005      	bset	20485,#5
5162                     ; 756 }
5165  09ca 5b05          	addw	sp,#5
5166  09cc 81            	ret
5256                     ; 759 void ST_READ(unsigned long memo_addr,unsigned short len, char* adr)
5256                     ; 760 {
5257                     	switch	.text
5258  09cd               _ST_READ:
5260  09cd 5205          	subw	sp,#5
5261       00000005      OFST:	set	5
5264                     ; 766 adr2=(char)(memo_addr>>16);
5266  09cf 7b09          	ld	a,(OFST+4,sp)
5267  09d1 6b03          	ld	(OFST-2,sp),a
5268                     ; 767 adr1=(char)((memo_addr>>8)&0x00ff);
5270  09d3 7b0a          	ld	a,(OFST+5,sp)
5271  09d5 a4ff          	and	a,#255
5272  09d7 6b02          	ld	(OFST-3,sp),a
5273                     ; 768 adr0=(char)((memo_addr)&0x00ff);
5275  09d9 7b0b          	ld	a,(OFST+6,sp)
5276  09db a4ff          	and	a,#255
5277  09dd 6b01          	ld	(OFST-4,sp),a
5278                     ; 769 ST_CS_ON
5280  09df 721b5005      	bres	20485,#5
5281                     ; 770 spi(0x03);
5283  09e3 a603          	ld	a,#3
5284  09e5 cd0905        	call	_spi
5286                     ; 771 spi(adr2);
5288  09e8 7b03          	ld	a,(OFST-2,sp)
5289  09ea cd0905        	call	_spi
5291                     ; 772 spi(adr1);
5293  09ed 7b02          	ld	a,(OFST-3,sp)
5294  09ef cd0905        	call	_spi
5296                     ; 773 spi(adr0);
5298  09f2 7b01          	ld	a,(OFST-4,sp)
5299  09f4 cd0905        	call	_spi
5301                     ; 775 for(i=0;i<len;i++)
5303  09f7 5f            	clrw	x
5304  09f8 1f04          	ldw	(OFST-1,sp),x
5306  09fa 2012          	jra	L3452
5307  09fc               L7352:
5308                     ; 777 	adr[i]=spi(0xff);
5310  09fc a6ff          	ld	a,#255
5311  09fe cd0905        	call	_spi
5313  0a01 1e0e          	ldw	x,(OFST+9,sp)
5314  0a03 72fb04        	addw	x,(OFST-1,sp)
5315  0a06 f7            	ld	(x),a
5316                     ; 775 for(i=0;i<len;i++)
5318  0a07 1e04          	ldw	x,(OFST-1,sp)
5319  0a09 1c0001        	addw	x,#1
5320  0a0c 1f04          	ldw	(OFST-1,sp),x
5321  0a0e               L3452:
5324  0a0e 1e04          	ldw	x,(OFST-1,sp)
5325  0a10 130c          	cpw	x,(OFST+7,sp)
5326  0a12 25e8          	jrult	L7352
5327                     ; 780 ST_CS_OFF
5329  0a14 721a5005      	bset	20485,#5
5330                     ; 781 }
5333  0a18 5b05          	addw	sp,#5
5334  0a1a 81            	ret
5400                     ; 785 long DF_mf_dev_read(void)
5400                     ; 786 {
5401                     	switch	.text
5402  0a1b               _DF_mf_dev_read:
5404  0a1b 5204          	subw	sp,#4
5405       00000004      OFST:	set	4
5408                     ; 789 d0=0;
5410  0a1d 0f04          	clr	(OFST+0,sp)
5411                     ; 790 d1=0;
5413                     ; 791 d2=0;
5415                     ; 792 d3=0;
5417                     ; 794 CS_ON
5419  0a1f 7217500a      	bres	20490,#3
5420                     ; 795 spi(0x9f);
5422  0a23 a69f          	ld	a,#159
5423  0a25 cd0905        	call	_spi
5425                     ; 796 mdr0=spi(0xff);
5427  0a28 a6ff          	ld	a,#255
5428  0a2a cd0905        	call	_spi
5430  0a2d b716          	ld	_mdr0,a
5431                     ; 797 mdr1=spi(0xff);
5433  0a2f a6ff          	ld	a,#255
5434  0a31 cd0905        	call	_spi
5436  0a34 b715          	ld	_mdr1,a
5437                     ; 798 mdr2=spi(0xff);
5439  0a36 a6ff          	ld	a,#255
5440  0a38 cd0905        	call	_spi
5442  0a3b b714          	ld	_mdr2,a
5443                     ; 799 mdr3=spi(0xff);  
5445  0a3d a6ff          	ld	a,#255
5446  0a3f cd0905        	call	_spi
5448  0a42 b713          	ld	_mdr3,a
5449                     ; 801 CS_OFF
5451  0a44 7216500a      	bset	20490,#3
5452                     ; 802 return  *((long*)&d0);
5454  0a48 96            	ldw	x,sp
5455  0a49 1c0004        	addw	x,#OFST+0
5456  0a4c cd0000        	call	c_ltor
5460  0a4f 5b04          	addw	sp,#4
5461  0a51 81            	ret
5485                     ; 806 void DF_memo_to_256(void)
5485                     ; 807 {
5486                     	switch	.text
5487  0a52               _DF_memo_to_256:
5491                     ; 809 CS_ON
5493  0a52 7217500a      	bres	20490,#3
5494                     ; 810 spi(0x3d);
5496  0a56 a63d          	ld	a,#61
5497  0a58 cd0905        	call	_spi
5499                     ; 811 spi(0x2a); 
5501  0a5b a62a          	ld	a,#42
5502  0a5d cd0905        	call	_spi
5504                     ; 812 spi(0x80);
5506  0a60 a680          	ld	a,#128
5507  0a62 cd0905        	call	_spi
5509                     ; 813 spi(0xa6);
5511  0a65 a6a6          	ld	a,#166
5512  0a67 cd0905        	call	_spi
5514                     ; 815 CS_OFF
5516  0a6a 7216500a      	bset	20490,#3
5517                     ; 816 }  
5520  0a6e 81            	ret
5555                     ; 821 char DF_status_read(void)
5555                     ; 822 {
5556                     	switch	.text
5557  0a6f               _DF_status_read:
5559  0a6f 88            	push	a
5560       00000001      OFST:	set	1
5563                     ; 826 CS_ON
5565  0a70 7217500a      	bres	20490,#3
5566                     ; 827 spi(0xd7);
5568  0a74 a6d7          	ld	a,#215
5569  0a76 cd0905        	call	_spi
5571                     ; 828 d0=spi(0xff);
5573  0a79 a6ff          	ld	a,#255
5574  0a7b cd0905        	call	_spi
5576  0a7e 6b01          	ld	(OFST+0,sp),a
5577                     ; 830 CS_OFF
5579  0a80 7216500a      	bset	20490,#3
5580                     ; 831 return d0;
5582  0a84 7b01          	ld	a,(OFST+0,sp)
5585  0a86 5b01          	addw	sp,#1
5586  0a88 81            	ret
5630                     ; 835 void DF_page_to_buffer(unsigned page_addr)
5630                     ; 836 {
5631                     	switch	.text
5632  0a89               _DF_page_to_buffer:
5634  0a89 89            	pushw	x
5635  0a8a 88            	push	a
5636       00000001      OFST:	set	1
5639                     ; 839 d0=0x53; 
5641                     ; 843 CS_ON
5643  0a8b 7217500a      	bres	20490,#3
5644                     ; 844 spi(d0);
5646  0a8f a653          	ld	a,#83
5647  0a91 cd0905        	call	_spi
5649                     ; 845 spi(page_addr/256/**(((char*)&page_addr)+1)*/);
5651  0a94 7b02          	ld	a,(OFST+1,sp)
5652  0a96 cd0905        	call	_spi
5654                     ; 846 spi(page_addr%256/**((char*)&page_addr)*/);
5656  0a99 7b03          	ld	a,(OFST+2,sp)
5657  0a9b a4ff          	and	a,#255
5658  0a9d cd0905        	call	_spi
5660                     ; 847 spi(0xff);
5662  0aa0 a6ff          	ld	a,#255
5663  0aa2 cd0905        	call	_spi
5665                     ; 849 CS_OFF
5667  0aa5 7216500a      	bset	20490,#3
5668                     ; 850 }
5671  0aa9 5b03          	addw	sp,#3
5672  0aab 81            	ret
5717                     ; 853 void DF_buffer_to_page_er(/*char buff,*/unsigned page_addr)
5717                     ; 854 {
5718                     	switch	.text
5719  0aac               _DF_buffer_to_page_er:
5721  0aac 89            	pushw	x
5722  0aad 88            	push	a
5723       00000001      OFST:	set	1
5726                     ; 857 d0=0x83; 
5728                     ; 860 CS_ON
5730  0aae 7217500a      	bres	20490,#3
5731                     ; 861 spi(d0);
5733  0ab2 a683          	ld	a,#131
5734  0ab4 cd0905        	call	_spi
5736                     ; 862 spi(page_addr/256/**(((char*)&page_addr)+1)*/);
5738  0ab7 7b02          	ld	a,(OFST+1,sp)
5739  0ab9 cd0905        	call	_spi
5741                     ; 863 spi(page_addr%256/**((char*)&page_addr)*/);
5743  0abc 7b03          	ld	a,(OFST+2,sp)
5744  0abe a4ff          	and	a,#255
5745  0ac0 cd0905        	call	_spi
5747                     ; 864 spi(0xff);
5749  0ac3 a6ff          	ld	a,#255
5750  0ac5 cd0905        	call	_spi
5752                     ; 866 CS_OFF
5754  0ac8 7216500a      	bset	20490,#3
5755                     ; 867 }
5758  0acc 5b03          	addw	sp,#3
5759  0ace 81            	ret
5831                     ; 870 void DF_buffer_read(unsigned buff_addr,unsigned len, char* adr)
5831                     ; 871 {
5832                     	switch	.text
5833  0acf               _DF_buffer_read:
5835  0acf 89            	pushw	x
5836  0ad0 5203          	subw	sp,#3
5837       00000003      OFST:	set	3
5840                     ; 875 d0=0x54; 
5842                     ; 877 CS_ON
5844  0ad2 7217500a      	bres	20490,#3
5845                     ; 878 spi(d0);
5847  0ad6 a654          	ld	a,#84
5848  0ad8 cd0905        	call	_spi
5850                     ; 879 spi(0xff);
5852  0adb a6ff          	ld	a,#255
5853  0add cd0905        	call	_spi
5855                     ; 880 spi(buff_addr/256/**(((char*)&buff_addr)+1)*/);
5857  0ae0 7b04          	ld	a,(OFST+1,sp)
5858  0ae2 cd0905        	call	_spi
5860                     ; 881 spi(buff_addr%256/**((char*)&buff_addr)*/);
5862  0ae5 7b05          	ld	a,(OFST+2,sp)
5863  0ae7 a4ff          	and	a,#255
5864  0ae9 cd0905        	call	_spi
5866                     ; 882 spi(0xff);
5868  0aec a6ff          	ld	a,#255
5869  0aee cd0905        	call	_spi
5871                     ; 883 for(i=0;i<len;i++)
5873  0af1 5f            	clrw	x
5874  0af2 1f02          	ldw	(OFST-1,sp),x
5876  0af4 2012          	jra	L5372
5877  0af6               L1372:
5878                     ; 885 	adr[i]=spi(0xff);
5880  0af6 a6ff          	ld	a,#255
5881  0af8 cd0905        	call	_spi
5883  0afb 1e0a          	ldw	x,(OFST+7,sp)
5884  0afd 72fb02        	addw	x,(OFST-1,sp)
5885  0b00 f7            	ld	(x),a
5886                     ; 883 for(i=0;i<len;i++)
5888  0b01 1e02          	ldw	x,(OFST-1,sp)
5889  0b03 1c0001        	addw	x,#1
5890  0b06 1f02          	ldw	(OFST-1,sp),x
5891  0b08               L5372:
5894  0b08 1e02          	ldw	x,(OFST-1,sp)
5895  0b0a 1308          	cpw	x,(OFST+5,sp)
5896  0b0c 25e8          	jrult	L1372
5897                     ; 888 CS_OFF
5899  0b0e 7216500a      	bset	20490,#3
5900                     ; 889 }
5903  0b12 5b05          	addw	sp,#5
5904  0b14 81            	ret
5976                     ; 892 void DF_buffer_write(/*char buff,*/unsigned buff_addr,unsigned len, char* adr)
5976                     ; 893 {
5977                     	switch	.text
5978  0b15               _DF_buffer_write:
5980  0b15 89            	pushw	x
5981  0b16 5203          	subw	sp,#3
5982       00000003      OFST:	set	3
5985                     ; 897 d0=0x84; 
5987                     ; 899 CS_ON
5989  0b18 7217500a      	bres	20490,#3
5990                     ; 900 spi(d0);
5992  0b1c a684          	ld	a,#132
5993  0b1e cd0905        	call	_spi
5995                     ; 901 spi(0xff);
5997  0b21 a6ff          	ld	a,#255
5998  0b23 cd0905        	call	_spi
6000                     ; 902 spi(buff_addr/256/**(((char*)&buff_addr)+1)*/);
6002  0b26 7b04          	ld	a,(OFST+1,sp)
6003  0b28 cd0905        	call	_spi
6005                     ; 903 spi(buff_addr%256/**((char*)&buff_addr)*/);
6007  0b2b 7b05          	ld	a,(OFST+2,sp)
6008  0b2d a4ff          	and	a,#255
6009  0b2f cd0905        	call	_spi
6011                     ; 905 for(i=0;i<len;i++)
6013  0b32 5f            	clrw	x
6014  0b33 1f02          	ldw	(OFST-1,sp),x
6016  0b35 2010          	jra	L3003
6017  0b37               L7772:
6018                     ; 907 	spi(adr[i]);
6020  0b37 1e0a          	ldw	x,(OFST+7,sp)
6021  0b39 72fb02        	addw	x,(OFST-1,sp)
6022  0b3c f6            	ld	a,(x)
6023  0b3d cd0905        	call	_spi
6025                     ; 905 for(i=0;i<len;i++)
6027  0b40 1e02          	ldw	x,(OFST-1,sp)
6028  0b42 1c0001        	addw	x,#1
6029  0b45 1f02          	ldw	(OFST-1,sp),x
6030  0b47               L3003:
6033  0b47 1e02          	ldw	x,(OFST-1,sp)
6034  0b49 1308          	cpw	x,(OFST+5,sp)
6035  0b4b 25ea          	jrult	L7772
6036                     ; 910 CS_OFF
6038  0b4d 7216500a      	bset	20490,#3
6039                     ; 911 }
6042  0b51 5b05          	addw	sp,#5
6043  0b53 81            	ret
6066                     ; 933 void gpio_init(void){
6067                     	switch	.text
6068  0b54               _gpio_init:
6072                     ; 943 	GPIOD->DDR|=(1<<2);
6074  0b54 72145011      	bset	20497,#2
6075                     ; 944 	GPIOD->CR1|=(1<<2);
6077  0b58 72145012      	bset	20498,#2
6078                     ; 945 	GPIOD->CR2|=(1<<2);
6080  0b5c 72145013      	bset	20499,#2
6081                     ; 946 	GPIOD->ODR&=~(1<<2);
6083  0b60 7215500f      	bres	20495,#2
6084                     ; 948 	GPIOD->DDR|=(1<<4);
6086  0b64 72185011      	bset	20497,#4
6087                     ; 949 	GPIOD->CR1|=(1<<4);
6089  0b68 72185012      	bset	20498,#4
6090                     ; 950 	GPIOD->CR2&=~(1<<4);
6092  0b6c 72195013      	bres	20499,#4
6093                     ; 952 	GPIOC->DDR&=~(1<<4);
6095  0b70 7219500c      	bres	20492,#4
6096                     ; 953 	GPIOC->CR1&=~(1<<4);
6098  0b74 7219500d      	bres	20493,#4
6099                     ; 954 	GPIOC->CR2&=~(1<<4);
6101  0b78 7219500e      	bres	20494,#4
6102                     ; 958 }
6105  0b7c 81            	ret
6157                     ; 961 void uart_in(void)
6157                     ; 962 {
6158                     	switch	.text
6159  0b7d               _uart_in:
6161  0b7d 89            	pushw	x
6162       00000002      OFST:	set	2
6165                     ; 966 if(rx_buffer_overflow)
6167                     	btst	_rx_buffer_overflow
6168  0b83 240d          	jruge	L1403
6169                     ; 968 	rx_wr_index=0;
6171  0b85 5f            	clrw	x
6172  0b86 bf1a          	ldw	_rx_wr_index,x
6173                     ; 969 	rx_rd_index=0;
6175  0b88 5f            	clrw	x
6176  0b89 bf18          	ldw	_rx_rd_index,x
6177                     ; 970 	rx_counter=0;
6179  0b8b 5f            	clrw	x
6180  0b8c bf1c          	ldw	_rx_counter,x
6181                     ; 971 	rx_buffer_overflow=0;
6183  0b8e 72110001      	bres	_rx_buffer_overflow
6184  0b92               L1403:
6185                     ; 974 if(rx_counter&&(rx_buffer[index_offset(rx_wr_index,-1)])==END)
6187  0b92 be1c          	ldw	x,_rx_counter
6188  0b94 2775          	jreq	L3403
6190  0b96 aeffff        	ldw	x,#65535
6191  0b99 89            	pushw	x
6192  0b9a be1a          	ldw	x,_rx_wr_index
6193  0b9c ad6f          	call	_index_offset
6195  0b9e 5b02          	addw	sp,#2
6196  0ba0 e654          	ld	a,(_rx_buffer,x)
6197  0ba2 a10a          	cp	a,#10
6198  0ba4 2665          	jrne	L3403
6199                     ; 979 	temp=rx_buffer[index_offset(rx_wr_index,-3)];
6201  0ba6 aefffd        	ldw	x,#65533
6202  0ba9 89            	pushw	x
6203  0baa be1a          	ldw	x,_rx_wr_index
6204  0bac ad5f          	call	_index_offset
6206  0bae 5b02          	addw	sp,#2
6207  0bb0 e654          	ld	a,(_rx_buffer,x)
6208  0bb2 6b01          	ld	(OFST-1,sp),a
6209                     ; 980     	if(temp<100) 
6211  0bb4 7b01          	ld	a,(OFST-1,sp)
6212  0bb6 a164          	cp	a,#100
6213  0bb8 2451          	jruge	L3403
6214                     ; 983     		if(control_check(index_offset(rx_wr_index,-1)))
6216  0bba aeffff        	ldw	x,#65535
6217  0bbd 89            	pushw	x
6218  0bbe be1a          	ldw	x,_rx_wr_index
6219  0bc0 ad4b          	call	_index_offset
6221  0bc2 5b02          	addw	sp,#2
6222  0bc4 9f            	ld	a,xl
6223  0bc5 ad6e          	call	_control_check
6225  0bc7 4d            	tnz	a
6226  0bc8 2741          	jreq	L3403
6227                     ; 986     			rx_rd_index=index_offset(rx_wr_index,-3-temp);
6229  0bca a6ff          	ld	a,#255
6230  0bcc 97            	ld	xl,a
6231  0bcd a6fd          	ld	a,#253
6232  0bcf 1001          	sub	a,(OFST-1,sp)
6233  0bd1 2401          	jrnc	L631
6234  0bd3 5a            	decw	x
6235  0bd4               L631:
6236  0bd4 02            	rlwa	x,a
6237  0bd5 89            	pushw	x
6238  0bd6 01            	rrwa	x,a
6239  0bd7 be1a          	ldw	x,_rx_wr_index
6240  0bd9 ad32          	call	_index_offset
6242  0bdb 5b02          	addw	sp,#2
6243  0bdd bf18          	ldw	_rx_rd_index,x
6244                     ; 987     			for(i=0;i<temp;i++)
6246  0bdf 0f02          	clr	(OFST+0,sp)
6248  0be1 2018          	jra	L5503
6249  0be3               L1503:
6250                     ; 989 				UIB[i]=rx_buffer[index_offset(rx_rd_index,i)];
6252  0be3 7b02          	ld	a,(OFST+0,sp)
6253  0be5 5f            	clrw	x
6254  0be6 97            	ld	xl,a
6255  0be7 89            	pushw	x
6256  0be8 7b04          	ld	a,(OFST+2,sp)
6257  0bea 5f            	clrw	x
6258  0beb 97            	ld	xl,a
6259  0bec 89            	pushw	x
6260  0bed be18          	ldw	x,_rx_rd_index
6261  0bef ad1c          	call	_index_offset
6263  0bf1 5b02          	addw	sp,#2
6264  0bf3 e654          	ld	a,(_rx_buffer,x)
6265  0bf5 85            	popw	x
6266  0bf6 d70000        	ld	(_UIB,x),a
6267                     ; 987     			for(i=0;i<temp;i++)
6269  0bf9 0c02          	inc	(OFST+0,sp)
6270  0bfb               L5503:
6273  0bfb 7b02          	ld	a,(OFST+0,sp)
6274  0bfd 1101          	cp	a,(OFST-1,sp)
6275  0bff 25e2          	jrult	L1503
6276                     ; 991 			rx_rd_index=rx_wr_index;
6278  0c01 be1a          	ldw	x,_rx_wr_index
6279  0c03 bf18          	ldw	_rx_rd_index,x
6280                     ; 992 			rx_counter=0;
6282  0c05 5f            	clrw	x
6283  0c06 bf1c          	ldw	_rx_counter,x
6284                     ; 1002 			uart_in_an();
6286  0c08 cd0238        	call	_uart_in_an
6288  0c0b               L3403:
6289                     ; 1011 }
6292  0c0b 85            	popw	x
6293  0c0c 81            	ret
6336                     ; 1014 signed short index_offset (signed short index,signed short offset)
6336                     ; 1015 {
6337                     	switch	.text
6338  0c0d               _index_offset:
6340  0c0d 89            	pushw	x
6341       00000000      OFST:	set	0
6344                     ; 1016 index=index+offset;
6346  0c0e 1e01          	ldw	x,(OFST+1,sp)
6347  0c10 72fb05        	addw	x,(OFST+5,sp)
6348  0c13 1f01          	ldw	(OFST+1,sp),x
6349                     ; 1017 if(index>=RX_BUFFER_SIZE) index-=RX_BUFFER_SIZE; 
6351  0c15 9c            	rvf
6352  0c16 1e01          	ldw	x,(OFST+1,sp)
6353  0c18 a30064        	cpw	x,#100
6354  0c1b 2f07          	jrslt	L3013
6357  0c1d 1e01          	ldw	x,(OFST+1,sp)
6358  0c1f 1d0064        	subw	x,#100
6359  0c22 1f01          	ldw	(OFST+1,sp),x
6360  0c24               L3013:
6361                     ; 1018 if(index<0) index+=RX_BUFFER_SIZE;
6363  0c24 9c            	rvf
6364  0c25 1e01          	ldw	x,(OFST+1,sp)
6365  0c27 2e07          	jrsge	L5013
6368  0c29 1e01          	ldw	x,(OFST+1,sp)
6369  0c2b 1c0064        	addw	x,#100
6370  0c2e 1f01          	ldw	(OFST+1,sp),x
6371  0c30               L5013:
6372                     ; 1019 return index;
6374  0c30 1e01          	ldw	x,(OFST+1,sp)
6377  0c32 5b02          	addw	sp,#2
6378  0c34 81            	ret
6441                     ; 1023 char control_check(char index)
6441                     ; 1024 {
6442                     	switch	.text
6443  0c35               _control_check:
6445  0c35 88            	push	a
6446  0c36 5203          	subw	sp,#3
6447       00000003      OFST:	set	3
6450                     ; 1025 char i=0,ii=0,iii;
6454                     ; 1027 if(rx_buffer[index]!=END) return 0;
6456  0c38 5f            	clrw	x
6457  0c39 97            	ld	xl,a
6458  0c3a e654          	ld	a,(_rx_buffer,x)
6459  0c3c a10a          	cp	a,#10
6460  0c3e 2703          	jreq	L1413
6463  0c40 4f            	clr	a
6465  0c41 2051          	jra	L051
6466  0c43               L1413:
6467                     ; 1029 ii=rx_buffer[index_offset(index,-2)];
6469  0c43 aefffe        	ldw	x,#65534
6470  0c46 89            	pushw	x
6471  0c47 7b06          	ld	a,(OFST+3,sp)
6472  0c49 5f            	clrw	x
6473  0c4a 97            	ld	xl,a
6474  0c4b adc0          	call	_index_offset
6476  0c4d 5b02          	addw	sp,#2
6477  0c4f e654          	ld	a,(_rx_buffer,x)
6478  0c51 6b02          	ld	(OFST-1,sp),a
6479                     ; 1030 iii=0;
6481  0c53 0f01          	clr	(OFST-2,sp)
6482                     ; 1031 for(i=0;i<=ii;i++)
6484  0c55 0f03          	clr	(OFST+0,sp)
6486  0c57 2022          	jra	L7413
6487  0c59               L3413:
6488                     ; 1033 	iii^=rx_buffer[index_offset(index,-2-ii+i)];
6490  0c59 a6ff          	ld	a,#255
6491  0c5b 97            	ld	xl,a
6492  0c5c a6fe          	ld	a,#254
6493  0c5e 1002          	sub	a,(OFST-1,sp)
6494  0c60 2401          	jrnc	L441
6495  0c62 5a            	decw	x
6496  0c63               L441:
6497  0c63 1b03          	add	a,(OFST+0,sp)
6498  0c65 2401          	jrnc	L641
6499  0c67 5c            	incw	x
6500  0c68               L641:
6501  0c68 02            	rlwa	x,a
6502  0c69 89            	pushw	x
6503  0c6a 01            	rrwa	x,a
6504  0c6b 7b06          	ld	a,(OFST+3,sp)
6505  0c6d 5f            	clrw	x
6506  0c6e 97            	ld	xl,a
6507  0c6f ad9c          	call	_index_offset
6509  0c71 5b02          	addw	sp,#2
6510  0c73 7b01          	ld	a,(OFST-2,sp)
6511  0c75 e854          	xor	a,	(_rx_buffer,x)
6512  0c77 6b01          	ld	(OFST-2,sp),a
6513                     ; 1031 for(i=0;i<=ii;i++)
6515  0c79 0c03          	inc	(OFST+0,sp)
6516  0c7b               L7413:
6519  0c7b 7b03          	ld	a,(OFST+0,sp)
6520  0c7d 1102          	cp	a,(OFST-1,sp)
6521  0c7f 23d8          	jrule	L3413
6522                     ; 1035 if (iii!=rx_buffer[index_offset(index,-1)]) return 0;	
6524  0c81 aeffff        	ldw	x,#65535
6525  0c84 89            	pushw	x
6526  0c85 7b06          	ld	a,(OFST+3,sp)
6527  0c87 5f            	clrw	x
6528  0c88 97            	ld	xl,a
6529  0c89 ad82          	call	_index_offset
6531  0c8b 5b02          	addw	sp,#2
6532  0c8d e654          	ld	a,(_rx_buffer,x)
6533  0c8f 1101          	cp	a,(OFST-2,sp)
6534  0c91 2704          	jreq	L3513
6537  0c93 4f            	clr	a
6539  0c94               L051:
6541  0c94 5b04          	addw	sp,#4
6542  0c96 81            	ret
6543  0c97               L3513:
6544                     ; 1037 return 1;
6546  0c97 a601          	ld	a,#1
6548  0c99 20f9          	jra	L051
6590                     ; 1046 @far @interrupt void TIM4_UPD_Interrupt (void) {
6592                     	switch	.text
6593  0c9b               f_TIM4_UPD_Interrupt:
6597                     ; 1048 	if(play) {
6599                     	btst	_play
6600  0ca0 2445          	jruge	L5613
6601                     ; 1049 		TIM2->CCR3H= 0x00;	
6603  0ca2 725f5315      	clr	21269
6604                     ; 1050 		TIM2->CCR3L= sample;
6606  0ca6 5500175316    	mov	21270,_sample
6607                     ; 1051 		sample_cnt++;
6609  0cab be21          	ldw	x,_sample_cnt
6610  0cad 1c0001        	addw	x,#1
6611  0cb0 bf21          	ldw	_sample_cnt,x
6612                     ; 1052 		if(sample_cnt>=256) {
6614  0cb2 9c            	rvf
6615  0cb3 be21          	ldw	x,_sample_cnt
6616  0cb5 a30100        	cpw	x,#256
6617  0cb8 2f03          	jrslt	L7613
6618                     ; 1053 			sample_cnt=0;
6620  0cba 5f            	clrw	x
6621  0cbb bf21          	ldw	_sample_cnt,x
6622  0cbd               L7613:
6623                     ; 1057 		sample=buff[sample_cnt];
6625  0cbd be21          	ldw	x,_sample_cnt
6626  0cbf d60050        	ld	a,(_buff,x)
6627  0cc2 b717          	ld	_sample,a
6628                     ; 1059 		if(sample_cnt==132)	{
6630  0cc4 be21          	ldw	x,_sample_cnt
6631  0cc6 a30084        	cpw	x,#132
6632  0cc9 2604          	jrne	L1713
6633                     ; 1060 			bBUFF_LOAD=1;
6635  0ccb 7210000b      	bset	_bBUFF_LOAD
6636  0ccf               L1713:
6637                     ; 1064 		if(sample_cnt==5) {
6639  0ccf be21          	ldw	x,_sample_cnt
6640  0cd1 a30005        	cpw	x,#5
6641  0cd4 2604          	jrne	L3713
6642                     ; 1065 			bBUFF_READ_H=1;
6644  0cd6 7210000a      	bset	_bBUFF_READ_H
6645  0cda               L3713:
6646                     ; 1068 		if(sample_cnt==150) {
6648  0cda be21          	ldw	x,_sample_cnt
6649  0cdc a30096        	cpw	x,#150
6650  0cdf 2615          	jrne	L7713
6651                     ; 1069 			bBUFF_READ_L=1;
6653  0ce1 72100009      	bset	_bBUFF_READ_L
6654  0ce5 200f          	jra	L7713
6655  0ce7               L5613:
6656                     ; 1076 	else if(!bSTART) {
6658                     	btst	_bSTART
6659  0cec 2508          	jrult	L7713
6660                     ; 1077 		TIM2->CCR3H= 0x00;	
6662  0cee 725f5315      	clr	21269
6663                     ; 1078 		TIM2->CCR3L= 0x7f;//pwm_fade_in;
6665  0cf2 357f5316      	mov	21270,#127
6666  0cf6               L7713:
6667                     ; 1133 		if(but_block_cnt)but_on_drv_cnt=0;
6669  0cf6 be00          	ldw	x,_but_block_cnt
6670  0cf8 2702          	jreq	L3023
6673  0cfa 3fb9          	clr	_but_on_drv_cnt
6674  0cfc               L3023:
6675                     ; 1134 		if((((GPIOC->IDR)&(1<<4))) && (but_on_drv_cnt<100)) {
6677  0cfc c6500b        	ld	a,20491
6678  0cff a510          	bcp	a,#16
6679  0d01 271f          	jreq	L5023
6681  0d03 b6b9          	ld	a,_but_on_drv_cnt
6682  0d05 a164          	cp	a,#100
6683  0d07 2419          	jruge	L5023
6684                     ; 1135 			but_on_drv_cnt++;
6686  0d09 3cb9          	inc	_but_on_drv_cnt
6687                     ; 1136 			if((but_on_drv_cnt>2)&&(bRELEASE))
6689  0d0b b6b9          	ld	a,_but_on_drv_cnt
6690  0d0d a103          	cp	a,#3
6691  0d0f 2517          	jrult	L1123
6693                     	btst	_bRELEASE
6694  0d16 2410          	jruge	L1123
6695                     ; 1138 				bRELEASE=0;
6697  0d18 72110000      	bres	_bRELEASE
6698                     ; 1139 				bSTART=1;
6700  0d1c 7210000c      	bset	_bSTART
6701  0d20 2006          	jra	L1123
6702  0d22               L5023:
6703                     ; 1143 			but_on_drv_cnt=0;
6705  0d22 3fb9          	clr	_but_on_drv_cnt
6706                     ; 1144 			bRELEASE=1;
6708  0d24 72100000      	bset	_bRELEASE
6709  0d28               L1123:
6710                     ; 1149 	if(++t0_cnt0>=125){
6712  0d28 3c00          	inc	_t0_cnt0
6713  0d2a b600          	ld	a,_t0_cnt0
6714  0d2c a17d          	cp	a,#125
6715  0d2e 2530          	jrult	L3123
6716                     ; 1150     		t0_cnt0=0;
6718  0d30 3f00          	clr	_t0_cnt0
6719                     ; 1151     		b100Hz=1;
6721  0d32 72100008      	bset	_b100Hz
6722                     ; 1161 		if(++t0_cnt1>=10){
6724  0d36 3c01          	inc	_t0_cnt1
6725  0d38 b601          	ld	a,_t0_cnt1
6726  0d3a a10a          	cp	a,#10
6727  0d3c 2506          	jrult	L5123
6728                     ; 1162 			t0_cnt1=0;
6730  0d3e 3f01          	clr	_t0_cnt1
6731                     ; 1163 			b10Hz=1;
6733  0d40 72100007      	bset	_b10Hz
6734  0d44               L5123:
6735                     ; 1166 		if(++t0_cnt2>=20){
6737  0d44 3c02          	inc	_t0_cnt2
6738  0d46 b602          	ld	a,_t0_cnt2
6739  0d48 a114          	cp	a,#20
6740  0d4a 2506          	jrult	L7123
6741                     ; 1167 			t0_cnt2=0;
6743  0d4c 3f02          	clr	_t0_cnt2
6744                     ; 1168 			b5Hz=1;
6746  0d4e 72100006      	bset	_b5Hz
6747  0d52               L7123:
6748                     ; 1171 		if(++t0_cnt3>=100){
6750  0d52 3c03          	inc	_t0_cnt3
6751  0d54 b603          	ld	a,_t0_cnt3
6752  0d56 a164          	cp	a,#100
6753  0d58 2506          	jrult	L3123
6754                     ; 1172 			t0_cnt3=0;
6756  0d5a 3f03          	clr	_t0_cnt3
6757                     ; 1173 			b1Hz=1;
6759  0d5c 72100005      	bset	_b1Hz
6760  0d60               L3123:
6761                     ; 1177 	TIM4->SR1&=~TIM4_SR1_UIF;			// disable break interrupt
6763  0d60 72115344      	bres	21316,#0
6764                     ; 1178 	return;
6767  0d64 80            	iret
6793                     ; 1182 @far @interrupt void UARTTxInterrupt (void) {
6794                     	switch	.text
6795  0d65               f_UARTTxInterrupt:
6799                     ; 1184 	if (tx_counter){
6801  0d65 3d20          	tnz	_tx_counter
6802  0d67 271a          	jreq	L3323
6803                     ; 1185 		--tx_counter;
6805  0d69 3a20          	dec	_tx_counter
6806                     ; 1186 		UART1->DR=tx_buffer[tx_rd_index];
6808  0d6b 5f            	clrw	x
6809  0d6c b61e          	ld	a,_tx_rd_index
6810  0d6e 2a01          	jrpl	L651
6811  0d70 53            	cplw	x
6812  0d71               L651:
6813  0d71 97            	ld	xl,a
6814  0d72 e604          	ld	a,(_tx_buffer,x)
6815  0d74 c75231        	ld	21041,a
6816                     ; 1187 		if (++tx_rd_index == TX_BUFFER_SIZE) tx_rd_index=0;
6818  0d77 3c1e          	inc	_tx_rd_index
6819  0d79 b61e          	ld	a,_tx_rd_index
6820  0d7b a150          	cp	a,#80
6821  0d7d 260c          	jrne	L7323
6824  0d7f 3f1e          	clr	_tx_rd_index
6825  0d81 2008          	jra	L7323
6826  0d83               L3323:
6827                     ; 1190 		bOUT_FREE=1;
6829  0d83 72100003      	bset	_bOUT_FREE
6830                     ; 1191 		UART1->CR2&= ~UART1_CR2_TIEN;
6832  0d87 721f5235      	bres	21045,#7
6833  0d8b               L7323:
6834                     ; 1193 }
6837  0d8b 80            	iret
6866                     ; 1196 @far @interrupt void UARTRxInterrupt (void) {
6867                     	switch	.text
6868  0d8c               f_UARTRxInterrupt:
6872                     ; 1201 	rx_status=UART1->SR;
6874  0d8c 5552300006    	mov	_rx_status,21040
6875                     ; 1202 	rx_data=UART1->DR;
6877  0d91 5552310005    	mov	_rx_data,21041
6878                     ; 1204 	if (rx_status & (UART1_SR_RXNE)){
6880  0d96 b606          	ld	a,_rx_status
6881  0d98 a520          	bcp	a,#32
6882  0d9a 272c          	jreq	L1523
6883                     ; 1205 		rx_buffer[rx_wr_index]=rx_data;
6885  0d9c be1a          	ldw	x,_rx_wr_index
6886  0d9e b605          	ld	a,_rx_data
6887  0da0 e754          	ld	(_rx_buffer,x),a
6888                     ; 1206 		bRXIN=1;
6890  0da2 72100002      	bset	_bRXIN
6891                     ; 1207 		if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
6893  0da6 be1a          	ldw	x,_rx_wr_index
6894  0da8 1c0001        	addw	x,#1
6895  0dab bf1a          	ldw	_rx_wr_index,x
6896  0dad a30064        	cpw	x,#100
6897  0db0 2603          	jrne	L3523
6900  0db2 5f            	clrw	x
6901  0db3 bf1a          	ldw	_rx_wr_index,x
6902  0db5               L3523:
6903                     ; 1208 		if (++rx_counter == RX_BUFFER_SIZE){
6905  0db5 be1c          	ldw	x,_rx_counter
6906  0db7 1c0001        	addw	x,#1
6907  0dba bf1c          	ldw	_rx_counter,x
6908  0dbc a30064        	cpw	x,#100
6909  0dbf 2607          	jrne	L1523
6910                     ; 1209 			rx_counter=0;
6912  0dc1 5f            	clrw	x
6913  0dc2 bf1c          	ldw	_rx_counter,x
6914                     ; 1210 			rx_buffer_overflow=1;
6916  0dc4 72100001      	bset	_rx_buffer_overflow
6917  0dc8               L1523:
6918                     ; 1213 }
6921  0dc8 80            	iret
6980                     ; 1219 main()
6980                     ; 1220 {
6982                     	switch	.text
6983  0dc9               _main:
6987                     ; 1221 CLK->CKDIVR=0;
6989  0dc9 725f50c6      	clr	20678
6990                     ; 1223 rele_cnt_index=0;
6992  0dcd 3fbb          	clr	_rele_cnt_index
6993                     ; 1225 GPIOD->DDR&=~(1<<6);
6995  0dcf 721d5011      	bres	20497,#6
6996                     ; 1226 GPIOD->CR1|=(1<<6);
6998  0dd3 721c5012      	bset	20498,#6
6999                     ; 1227 GPIOD->CR2|=(1<<6);
7001  0dd7 721c5013      	bset	20499,#6
7002                     ; 1229 GPIOD->DDR|=(1<<5);
7004  0ddb 721a5011      	bset	20497,#5
7005                     ; 1230 GPIOD->CR1|=(1<<5);
7007  0ddf 721a5012      	bset	20498,#5
7008                     ; 1231 GPIOD->CR2|=(1<<5);	
7010  0de3 721a5013      	bset	20499,#5
7011                     ; 1232 GPIOD->ODR|=(1<<5);
7013  0de7 721a500f      	bset	20495,#5
7014                     ; 1234 delay_ms(10);
7016  0deb ae000a        	ldw	x,#10
7017  0dee cd005c        	call	_delay_ms
7019                     ; 1236 if(!(GPIOD->IDR&=(1<<6))) 
7021  0df1 c65010        	ld	a,20496
7022  0df4 a440          	and	a,#64
7023  0df6 c75010        	ld	20496,a
7024  0df9 2606          	jrne	L7623
7025                     ; 1238 	rele_cnt_index=1;
7027  0dfb 350100bb      	mov	_rele_cnt_index,#1
7029  0dff 2018          	jra	L1723
7030  0e01               L7623:
7031                     ; 1242 	GPIOD->ODR&=~(1<<5);
7033  0e01 721b500f      	bres	20495,#5
7034                     ; 1243 	delay_ms(10);
7036  0e05 ae000a        	ldw	x,#10
7037  0e08 cd005c        	call	_delay_ms
7039                     ; 1244 	if(!(GPIOD->IDR&=(1<<6))) 
7041  0e0b c65010        	ld	a,20496
7042  0e0e a440          	and	a,#64
7043  0e10 c75010        	ld	20496,a
7044  0e13 2604          	jrne	L1723
7045                     ; 1246 		rele_cnt_index=2;
7047  0e15 350200bb      	mov	_rele_cnt_index,#2
7048  0e19               L1723:
7049                     ; 1250 gpio_init();
7051  0e19 cd0b54        	call	_gpio_init
7053                     ; 1257 spi_init();
7055  0e1c cd0898        	call	_spi_init
7057                     ; 1259 t4_init();
7059  0e1f cd0039        	call	_t4_init
7061                     ; 1261 FLASH_DUKR=0xae;
7063  0e22 35ae5064      	mov	_FLASH_DUKR,#174
7064                     ; 1262 FLASH_DUKR=0x56;
7066  0e26 35565064      	mov	_FLASH_DUKR,#86
7067                     ; 1267 dumm[1]++;
7069  0e2a 725c017d      	inc	_dumm+1
7070                     ; 1269 uart_init();
7072  0e2e cd009e        	call	_uart_init
7074                     ; 1271 ST_RDID_read();
7076  0e31 cd0923        	call	_ST_RDID_read
7078                     ; 1272 if(mdr0==0x20) memory_manufacturer='S';	
7080  0e34 b616          	ld	a,_mdr0
7081  0e36 a120          	cp	a,#32
7082  0e38 2606          	jrne	L5723
7085  0e3a 355300bc      	mov	_memory_manufacturer,#83
7087  0e3e 200d          	jra	L7723
7088  0e40               L5723:
7089                     ; 1275 	DF_mf_dev_read();
7091  0e40 cd0a1b        	call	_DF_mf_dev_read
7093                     ; 1276 	if(mdr0==0x1F) memory_manufacturer='A';
7095  0e43 b616          	ld	a,_mdr0
7096  0e45 a11f          	cp	a,#31
7097  0e47 2604          	jrne	L7723
7100  0e49 354100bc      	mov	_memory_manufacturer,#65
7101  0e4d               L7723:
7102                     ; 1279 t2_init();
7104  0e4d cd0000        	call	_t2_init
7106                     ; 1281 ST_WREN();
7108  0e50 cd0974        	call	_ST_WREN
7110                     ; 1283 enableInterrupts();	
7113  0e53 9a            rim
7115  0e54               L3033:
7116                     ; 1288 	if(bBUFF_LOAD)
7118                     	btst	_bBUFF_LOAD
7119  0e59 2425          	jruge	L7033
7120                     ; 1290 		bBUFF_LOAD=0;
7122  0e5b 7211000b      	bres	_bBUFF_LOAD
7123                     ; 1292 		if(current_page<last_page)
7125  0e5f be0f          	ldw	x,_current_page
7126  0e61 b30d          	cpw	x,_last_page
7127  0e63 2409          	jruge	L1133
7128                     ; 1294 			current_page++;
7130  0e65 be0f          	ldw	x,_current_page
7131  0e67 1c0001        	addw	x,#1
7132  0e6a bf0f          	ldw	_current_page,x
7134  0e6c 2007          	jra	L3133
7135  0e6e               L1133:
7136                     ; 1298 			current_page=0;
7138  0e6e 5f            	clrw	x
7139  0e6f bf0f          	ldw	_current_page,x
7140                     ; 1299 			play=0;
7142  0e71 72110004      	bres	_play
7143  0e75               L3133:
7144                     ; 1301 		if(memory_manufacturer=='A')
7146  0e75 b6bc          	ld	a,_memory_manufacturer
7147  0e77 a141          	cp	a,#65
7148  0e79 2605          	jrne	L7033
7149                     ; 1303 			DF_page_to_buffer(/*///current_buffer_H*//*1,*/current_page);
7151  0e7b be0f          	ldw	x,_current_page
7152  0e7d cd0a89        	call	_DF_page_to_buffer
7154  0e80               L7033:
7155                     ; 1307 	if(bBUFF_READ_L)
7157                     	btst	_bBUFF_READ_L
7158  0e85 243a          	jruge	L7133
7159                     ; 1309 		bBUFF_READ_L=0;
7161  0e87 72110009      	bres	_bBUFF_READ_L
7162                     ; 1310 		if(memory_manufacturer=='A')
7164  0e8b b6bc          	ld	a,_memory_manufacturer
7165  0e8d a141          	cp	a,#65
7166  0e8f 260e          	jrne	L1233
7167                     ; 1312 			DF_buffer_read(/*///current_buffer_L*//*1,*/0,128,buff);
7169  0e91 ae0050        	ldw	x,#_buff
7170  0e94 89            	pushw	x
7171  0e95 ae0080        	ldw	x,#128
7172  0e98 89            	pushw	x
7173  0e99 5f            	clrw	x
7174  0e9a cd0acf        	call	_DF_buffer_read
7176  0e9d 5b04          	addw	sp,#4
7177  0e9f               L1233:
7178                     ; 1314 		if(memory_manufacturer=='S')
7180  0e9f b6bc          	ld	a,_memory_manufacturer
7181  0ea1 a153          	cp	a,#83
7182  0ea3 261c          	jrne	L7133
7183                     ; 1316 			ST_READ((unsigned long)((unsigned long)(current_page*256UL)),128,buff);
7185  0ea5 ae0050        	ldw	x,#_buff
7186  0ea8 89            	pushw	x
7187  0ea9 ae0080        	ldw	x,#128
7188  0eac 89            	pushw	x
7189  0ead be0f          	ldw	x,_current_page
7190  0eaf 90ae0100      	ldw	y,#256
7191  0eb3 cd0000        	call	c_umul
7193  0eb6 be02          	ldw	x,c_lreg+2
7194  0eb8 89            	pushw	x
7195  0eb9 be00          	ldw	x,c_lreg
7196  0ebb 89            	pushw	x
7197  0ebc cd09cd        	call	_ST_READ
7199  0ebf 5b08          	addw	sp,#8
7200  0ec1               L7133:
7201                     ; 1320 	if(bBUFF_READ_H) 
7203                     	btst	_bBUFF_READ_H
7204  0ec6 2441          	jruge	L5233
7205                     ; 1322 		bBUFF_READ_H=0;
7207  0ec8 7211000a      	bres	_bBUFF_READ_H
7208                     ; 1323 		if(memory_manufacturer=='A') 
7210  0ecc b6bc          	ld	a,_memory_manufacturer
7211  0ece a141          	cp	a,#65
7212  0ed0 2610          	jrne	L7233
7213                     ; 1325 			DF_buffer_read(/*///current_buffer_L*//*1,*/128,128,&buff[128]);
7215  0ed2 ae00d0        	ldw	x,#_buff+128
7216  0ed5 89            	pushw	x
7217  0ed6 ae0080        	ldw	x,#128
7218  0ed9 89            	pushw	x
7219  0eda ae0080        	ldw	x,#128
7220  0edd cd0acf        	call	_DF_buffer_read
7222  0ee0 5b04          	addw	sp,#4
7223  0ee2               L7233:
7224                     ; 1327 		if(memory_manufacturer=='S') 
7226  0ee2 b6bc          	ld	a,_memory_manufacturer
7227  0ee4 a153          	cp	a,#83
7228  0ee6 2621          	jrne	L5233
7229                     ; 1329 			ST_READ((unsigned long)((unsigned long)(current_page*256UL)+128UL),128,&buff[128]);
7231  0ee8 ae00d0        	ldw	x,#_buff+128
7232  0eeb 89            	pushw	x
7233  0eec ae0080        	ldw	x,#128
7234  0eef 89            	pushw	x
7235  0ef0 be0f          	ldw	x,_current_page
7236  0ef2 90ae0100      	ldw	y,#256
7237  0ef6 cd0000        	call	c_umul
7239  0ef9 a680          	ld	a,#128
7240  0efb cd0000        	call	c_ladc
7242  0efe be02          	ldw	x,c_lreg+2
7243  0f00 89            	pushw	x
7244  0f01 be00          	ldw	x,c_lreg
7245  0f03 89            	pushw	x
7246  0f04 cd09cd        	call	_ST_READ
7248  0f07 5b08          	addw	sp,#8
7249  0f09               L5233:
7250                     ; 1333 	if(bRXIN)
7252                     	btst	_bRXIN
7253  0f0e 2407          	jruge	L3333
7254                     ; 1335 		bRXIN=0;
7256  0f10 72110002      	bres	_bRXIN
7257                     ; 1337 		uart_in();
7259  0f14 cd0b7d        	call	_uart_in
7261  0f17               L3333:
7262                     ; 1341 	if(b100Hz)
7264                     	btst	_b100Hz
7265  0f1c 2503          	jrult	L461
7266  0f1e cc0fcc        	jp	L5333
7267  0f21               L461:
7268                     ; 1343 		b100Hz=0;
7270  0f21 72110008      	bres	_b100Hz
7271                     ; 1345 		if(but_block_cnt)but_block_cnt--;
7273  0f25 be00          	ldw	x,_but_block_cnt
7274  0f27 2707          	jreq	L7333
7277  0f29 be00          	ldw	x,_but_block_cnt
7278  0f2b 1d0001        	subw	x,#1
7279  0f2e bf00          	ldw	_but_block_cnt,x
7280  0f30               L7333:
7281                     ; 1347 		if(bSTART==1) 
7283                     	btst	_bSTART
7284  0f35 24e7          	jruge	L5333
7285                     ; 1349 			if(play) 
7287                     	btst	_play
7288  0f3c 2417          	jruge	L3433
7289                     ; 1352 				if(!but_block_cnt)
7291  0f3e be00          	ldw	x,_but_block_cnt
7292  0f40 260d          	jrne	L5433
7293                     ; 1354 					play=0;
7295  0f42 72110004      	bres	_play
7296                     ; 1355 					bSTART=0;
7298  0f46 7211000c      	bres	_bSTART
7299                     ; 1356 					but_block_cnt=50;
7301  0f4a ae0032        	ldw	x,#50
7302  0f4d bf00          	ldw	_but_block_cnt,x
7303  0f4f               L5433:
7304                     ; 1359 				bSTART=0;
7306  0f4f 7211000c      	bres	_bSTART
7308  0f53 2077          	jra	L5333
7309  0f55               L3433:
7310                     ; 1363 			if(!but_block_cnt)
7312  0f55 be00          	ldw	x,_but_block_cnt
7313  0f57 2673          	jrne	L5333
7314                     ; 1366 				current_page=1;
7316  0f59 ae0001        	ldw	x,#1
7317  0f5c bf0f          	ldw	_current_page,x
7318                     ; 1368 				last_page=6000;
7320  0f5e ae1770        	ldw	x,#6000
7321  0f61 bf0d          	ldw	_last_page,x
7322                     ; 1373 				if(memory_manufacturer=='A')
7324  0f63 b6bc          	ld	a,_memory_manufacturer
7325  0f65 a141          	cp	a,#65
7326  0f67 2630          	jrne	L3533
7327                     ; 1375 					DF_page_to_buffer(/*///current_buffer_H*//*1,*/current_page);
7329  0f69 ae0001        	ldw	x,#1
7330  0f6c cd0a89        	call	_DF_page_to_buffer
7332                     ; 1376 					delay_ms(10);
7334  0f6f ae000a        	ldw	x,#10
7335  0f72 cd005c        	call	_delay_ms
7337                     ; 1377 					DF_buffer_read(/*///current_buffer_L*//*1,*/0,128,buff);
7339  0f75 ae0050        	ldw	x,#_buff
7340  0f78 89            	pushw	x
7341  0f79 ae0080        	ldw	x,#128
7342  0f7c 89            	pushw	x
7343  0f7d 5f            	clrw	x
7344  0f7e cd0acf        	call	_DF_buffer_read
7346  0f81 5b04          	addw	sp,#4
7347                     ; 1378 					delay_ms(10);
7349  0f83 ae000a        	ldw	x,#10
7350  0f86 cd005c        	call	_delay_ms
7352                     ; 1379 					DF_buffer_read(/*///current_buffer_L*//*1,*/128,128,&buff[128]);         
7354  0f89 ae00d0        	ldw	x,#_buff+128
7355  0f8c 89            	pushw	x
7356  0f8d ae0080        	ldw	x,#128
7357  0f90 89            	pushw	x
7358  0f91 ae0080        	ldw	x,#128
7359  0f94 cd0acf        	call	_DF_buffer_read
7361  0f97 5b04          	addw	sp,#4
7362  0f99               L3533:
7363                     ; 1381 				if(memory_manufacturer=='S') 
7365  0f99 b6bc          	ld	a,_memory_manufacturer
7366  0f9b a153          	cp	a,#83
7367  0f9d 2615          	jrne	L5533
7368                     ; 1383 					ST_READ(0,256,buff);
7370  0f9f ae0050        	ldw	x,#_buff
7371  0fa2 89            	pushw	x
7372  0fa3 ae0100        	ldw	x,#256
7373  0fa6 89            	pushw	x
7374  0fa7 ae0000        	ldw	x,#0
7375  0faa 89            	pushw	x
7376  0fab ae0000        	ldw	x,#0
7377  0fae 89            	pushw	x
7378  0faf cd09cd        	call	_ST_READ
7380  0fb2 5b08          	addw	sp,#8
7381  0fb4               L5533:
7382                     ; 1385 				play=1;
7384  0fb4 72100004      	bset	_play
7385                     ; 1386 				bSTART=0;
7387  0fb8 7211000c      	bres	_bSTART
7388                     ; 1388 				rele_cnt=rele_cnt_const[rele_cnt_index];
7390  0fbc b6bb          	ld	a,_rele_cnt_index
7391  0fbe 5f            	clrw	x
7392  0fbf 97            	ld	xl,a
7393  0fc0 d60000        	ld	a,(_rele_cnt_const,x)
7394  0fc3 5f            	clrw	x
7395  0fc4 97            	ld	xl,a
7396  0fc5 bf03          	ldw	_rele_cnt,x
7397                     ; 1390 				but_block_cnt=50;
7399  0fc7 ae0032        	ldw	x,#50
7400  0fca bf00          	ldw	_but_block_cnt,x
7401  0fcc               L5333:
7402                     ; 1396 	if(b10Hz)
7404                     	btst	_b10Hz
7405  0fd1 2413          	jruge	L7533
7406                     ; 1398 		b10Hz=0;
7408  0fd3 72110007      	bres	_b10Hz
7409                     ; 1400 		rele_drv();
7411  0fd7 cd004a        	call	_rele_drv
7413                     ; 1401 		pwm_fade_in++;
7415  0fda 3cba          	inc	_pwm_fade_in
7416                     ; 1402 		if(pwm_fade_in>128)pwm_fade_in=128;			
7418  0fdc b6ba          	ld	a,_pwm_fade_in
7419  0fde a181          	cp	a,#129
7420  0fe0 2504          	jrult	L7533
7423  0fe2 358000ba      	mov	_pwm_fade_in,#128
7424  0fe6               L7533:
7425                     ; 1405 	if(b5Hz)
7427                     	btst	_b5Hz
7428  0feb 2404          	jruge	L3633
7429                     ; 1407 		b5Hz=0;
7431  0fed 72110006      	bres	_b5Hz
7432  0ff1               L3633:
7433                     ; 1413 	if(b1Hz)
7435                     	btst	_b1Hz
7436  0ff6 2503          	jrult	L661
7437  0ff8 cc0e54        	jp	L3033
7438  0ffb               L661:
7439                     ; 1416 		b1Hz=0;
7441  0ffb 72110005      	bres	_b1Hz
7442  0fff ac540e54      	jpf	L3033
7938                     	xdef	_main
7939                     .eeprom:	section	.data
7940  0000               _EE_PAGE_LEN:
7941  0000 0000          	ds.b	2
7942                     	xdef	_EE_PAGE_LEN
7943                     	switch	.bss
7944  0000               _UIB:
7945  0000 000000000000  	ds.b	80
7946                     	xdef	_UIB
7947  0050               _buff:
7948  0050 000000000000  	ds.b	300
7949                     	xdef	_buff
7950  017c               _dumm:
7951  017c 000000000000  	ds.b	100
7952                     	xdef	_dumm
7953                     .bit:	section	.data,bit
7954  0000               _bRELEASE:
7955  0000 00            	ds.b	1
7956                     	xdef	_bRELEASE
7957  0001               _rx_buffer_overflow:
7958  0001 00            	ds.b	1
7959                     	xdef	_rx_buffer_overflow
7960  0002               _bRXIN:
7961  0002 00            	ds.b	1
7962                     	xdef	_bRXIN
7963  0003               _bOUT_FREE:
7964  0003 00            	ds.b	1
7965                     	xdef	_bOUT_FREE
7966  0004               _play:
7967  0004 00            	ds.b	1
7968                     	xdef	_play
7969  0005               _b1Hz:
7970  0005 00            	ds.b	1
7971                     	xdef	_b1Hz
7972  0006               _b5Hz:
7973  0006 00            	ds.b	1
7974                     	xdef	_b5Hz
7975  0007               _b10Hz:
7976  0007 00            	ds.b	1
7977                     	xdef	_b10Hz
7978  0008               _b100Hz:
7979  0008 00            	ds.b	1
7980                     	xdef	_b100Hz
7981  0009               _bBUFF_READ_L:
7982  0009 00            	ds.b	1
7983                     	xdef	_bBUFF_READ_L
7984  000a               _bBUFF_READ_H:
7985  000a 00            	ds.b	1
7986                     	xdef	_bBUFF_READ_H
7987  000b               _bBUFF_LOAD:
7988  000b 00            	ds.b	1
7989                     	xdef	_bBUFF_LOAD
7990  000c               _bSTART:
7991  000c 00            	ds.b	1
7992                     	xdef	_bSTART
7993                     	switch	.ubsct
7994  0000               _but_block_cnt:
7995  0000 0000          	ds.b	2
7996                     	xdef	_but_block_cnt
7997                     	xdef	_memory_manufacturer
7998                     	xdef	_rele_cnt_const
7999                     	xdef	_rele_cnt_index
8000                     	xdef	_pwm_fade_in
8001  0002               _rx_offset:
8002  0002 00            	ds.b	1
8003                     	xdef	_rx_offset
8004  0003               _rele_cnt:
8005  0003 0000          	ds.b	2
8006                     	xdef	_rele_cnt
8007  0005               _rx_data:
8008  0005 00            	ds.b	1
8009                     	xdef	_rx_data
8010  0006               _rx_status:
8011  0006 00            	ds.b	1
8012                     	xdef	_rx_status
8013  0007               _file_lengt:
8014  0007 00000000      	ds.b	4
8015                     	xdef	_file_lengt
8016  000b               _current_byte_in_buffer:
8017  000b 0000          	ds.b	2
8018                     	xdef	_current_byte_in_buffer
8019  000d               _last_page:
8020  000d 0000          	ds.b	2
8021                     	xdef	_last_page
8022  000f               _current_page:
8023  000f 0000          	ds.b	2
8024                     	xdef	_current_page
8025  0011               _file_lengt_in_pages:
8026  0011 0000          	ds.b	2
8027                     	xdef	_file_lengt_in_pages
8028  0013               _mdr3:
8029  0013 00            	ds.b	1
8030                     	xdef	_mdr3
8031  0014               _mdr2:
8032  0014 00            	ds.b	1
8033                     	xdef	_mdr2
8034  0015               _mdr1:
8035  0015 00            	ds.b	1
8036                     	xdef	_mdr1
8037  0016               _mdr0:
8038  0016 00            	ds.b	1
8039                     	xdef	_mdr0
8040                     	xdef	_but_on_drv_cnt
8041                     	xdef	_but_drv_cnt
8042  0017               _sample:
8043  0017 00            	ds.b	1
8044                     	xdef	_sample
8045  0018               _rx_rd_index:
8046  0018 0000          	ds.b	2
8047                     	xdef	_rx_rd_index
8048  001a               _rx_wr_index:
8049  001a 0000          	ds.b	2
8050                     	xdef	_rx_wr_index
8051  001c               _rx_counter:
8052  001c 0000          	ds.b	2
8053                     	xdef	_rx_counter
8054                     	xdef	_rx_buffer
8055  001e               _tx_rd_index:
8056  001e 00            	ds.b	1
8057                     	xdef	_tx_rd_index
8058  001f               _tx_wr_index:
8059  001f 00            	ds.b	1
8060                     	xdef	_tx_wr_index
8061  0020               _tx_counter:
8062  0020 00            	ds.b	1
8063                     	xdef	_tx_counter
8064                     	xdef	_tx_buffer
8065  0021               _sample_cnt:
8066  0021 0000          	ds.b	2
8067                     	xdef	_sample_cnt
8068                     	xdef	_t0_cnt3
8069                     	xdef	_t0_cnt2
8070                     	xdef	_t0_cnt1
8071                     	xdef	_t0_cnt0
8072                     	xdef	_ST_bulk_erase
8073                     	xdef	_ST_READ
8074                     	xdef	_ST_WRITE
8075                     	xdef	_ST_WREN
8076                     	xdef	_ST_status_read
8077                     	xdef	_ST_RDID_read
8078                     	xdef	_uart_in_an
8079                     	xdef	_control_check
8080                     	xdef	_index_offset
8081                     	xdef	_uart_in
8082                     	xdef	_gpio_init
8083                     	xdef	_spi_init
8084                     	xdef	_spi
8085                     	xdef	_DF_buffer_to_page_er
8086                     	xdef	_DF_page_to_buffer
8087                     	xdef	_DF_buffer_write
8088                     	xdef	_DF_buffer_read
8089                     	xdef	_DF_status_read
8090                     	xdef	_DF_memo_to_256
8091                     	xdef	_DF_mf_dev_read
8092                     	xdef	_uart_init
8093                     	xdef	f_UARTRxInterrupt
8094                     	xdef	f_UARTTxInterrupt
8095                     	xdef	_putchar
8096                     	xdef	_uart_out_adr_block
8097                     	xdef	_uart_out
8098                     	xdef	f_TIM4_UPD_Interrupt
8099                     	xdef	_delay_ms
8100                     	xdef	_rele_drv
8101                     	xdef	_t4_init
8102                     	xdef	_t2_init
8103                     	xref.b	c_lreg
8104                     	xref.b	c_x
8105                     	xref.b	c_y
8125                     	xref	c_ladc
8126                     	xref	c_itolx
8127                     	xref	c_umul
8128                     	xref	c_eewrw
8129                     	xref	c_lglsh
8130                     	xref	c_uitolx
8131                     	xref	c_lgursh
8132                     	xref	c_lcmp
8133                     	xref	c_ltor
8134                     	xref	c_lgadc
8135                     	xref	c_rtol
8136                     	xref	c_vmul
8137                     	end
