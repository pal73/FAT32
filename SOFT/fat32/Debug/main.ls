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
2232                     ; 58 void t2_init(void){
2234                     	switch	.text
2235  0000               _t2_init:
2239                     ; 59 	TIM2->PSCR = 0;
2241  0000 725f530e      	clr	21262
2242                     ; 60 	TIM2->ARRH= 0x00;
2244  0004 725f530f      	clr	21263
2245                     ; 61 	TIM2->ARRL= 0xff;
2247  0008 35ff5310      	mov	21264,#255
2248                     ; 62 	TIM2->CCR1H= 0x00;	
2250  000c 725f5311      	clr	21265
2251                     ; 63 	TIM2->CCR1L= 200;
2253  0010 35c85312      	mov	21266,#200
2254                     ; 64 	TIM2->CCR2H= 0x00;	
2256  0014 725f5313      	clr	21267
2257                     ; 65 	TIM2->CCR2L= 200;
2259  0018 35c85314      	mov	21268,#200
2260                     ; 66 	TIM2->CCR3H= 0x00;	
2262  001c 725f5315      	clr	21269
2263                     ; 67 	TIM2->CCR3L= 50;
2265  0020 35325316      	mov	21270,#50
2266                     ; 70 	TIM2->CCMR2= ((6<<4) & TIM2_CCMR_OCM) | TIM2_CCMR_OCxPE; //OC2 toggle mode, prelouded
2268  0024 35685308      	mov	21256,#104
2269                     ; 71 	TIM2->CCMR3= ((6<<4) & TIM2_CCMR_OCM) | TIM2_CCMR_OCxPE; //OC2 toggle mode, prelouded
2271  0028 35685309      	mov	21257,#104
2272                     ; 72 	TIM2->CCER1= /*TIM2_CCER1_CC1E | TIM2_CCER1_CC1P |*/ TIM2_CCER1_CC2E | TIM2_CCER1_CC2P; //OC1, OC2 output pins enabled
2274  002c 3530530a      	mov	21258,#48
2275                     ; 74 	TIM2->CCER2= TIM2_CCER2_CC3E /*| TIM2_CCER2_CC3P*/; //OC1, OC2 output pins enabled
2277  0030 3501530b      	mov	21259,#1
2278                     ; 76 	TIM2->CR1=(TIM2_CR1_CEN | TIM2_CR1_ARPE);	
2280  0034 35815300      	mov	21248,#129
2281                     ; 78 }
2284  0038 81            	ret
2307                     ; 81 void t4_init(void){
2308                     	switch	.text
2309  0039               _t4_init:
2313                     ; 82 	TIM4->PSCR = 3;
2315  0039 35035347      	mov	21319,#3
2316                     ; 83 	TIM4->ARR= 158;
2318  003d 359e5348      	mov	21320,#158
2319                     ; 84 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
2321  0041 72105343      	bset	21315,#0
2322                     ; 86 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
2324  0045 35855340      	mov	21312,#133
2325                     ; 88 }
2328  0049 81            	ret
2352                     ; 91 void rele_drv(void) {
2353                     	switch	.text
2354  004a               _rele_drv:
2358                     ; 101 	if(play) {
2360                     	btst	_play
2361  004f 2406          	jruge	L1641
2362                     ; 102 		GPIOD->ODR|=(1<<4);
2364  0051 7218500f      	bset	20495,#4
2366  0055 2004          	jra	L3641
2367  0057               L1641:
2368                     ; 104 	else GPIOD->ODR&=~(1<<4);
2370  0057 7219500f      	bres	20495,#4
2371  005b               L3641:
2372                     ; 113 }
2375  005b 81            	ret
2436                     ; 116 long delay_ms(short in)
2436                     ; 117 {
2437                     	switch	.text
2438  005c               _delay_ms:
2440  005c 520c          	subw	sp,#12
2441       0000000c      OFST:	set	12
2444                     ; 120 i=((long)in)*100UL;
2446  005e 90ae0064      	ldw	y,#100
2447  0062 cd0000        	call	c_vmul
2449  0065 96            	ldw	x,sp
2450  0066 1c0005        	addw	x,#OFST-7
2451  0069 cd0000        	call	c_rtol
2453                     ; 122 for(ii=0;ii<i;ii++)
2455  006c ae0000        	ldw	x,#0
2456  006f 1f0b          	ldw	(OFST-1,sp),x
2457  0071 ae0000        	ldw	x,#0
2458  0074 1f09          	ldw	(OFST-3,sp),x
2460  0076 2012          	jra	L3251
2461  0078               L7151:
2462                     ; 124 		iii++;
2464  0078 96            	ldw	x,sp
2465  0079 1c0001        	addw	x,#OFST-11
2466  007c a601          	ld	a,#1
2467  007e cd0000        	call	c_lgadc
2469                     ; 122 for(ii=0;ii<i;ii++)
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
2489                     ; 127 }
2492  009b 5b0c          	addw	sp,#12
2493  009d 81            	ret
2516                     ; 130 void uart_init (void){
2517                     	switch	.text
2518  009e               _uart_init:
2522                     ; 131 	GPIOD->DDR|=(1<<5);
2524  009e 721a5011      	bset	20497,#5
2525                     ; 132 	GPIOD->CR1|=(1<<5);
2527  00a2 721a5012      	bset	20498,#5
2528                     ; 133 	GPIOD->CR2|=(1<<5);
2530  00a6 721a5013      	bset	20499,#5
2531                     ; 136 	GPIOD->DDR&=~(1<<6);
2533  00aa 721d5011      	bres	20497,#6
2534                     ; 137 	GPIOD->CR1&=~(1<<6);
2536  00ae 721d5012      	bres	20498,#6
2537                     ; 138 	GPIOD->CR2&=~(1<<6);
2539  00b2 721d5013      	bres	20499,#6
2540                     ; 141 	UART1->CR1&=~UART1_CR1_M;					
2542  00b6 72195234      	bres	21044,#4
2543                     ; 142 	UART1->CR3|= (0<<4) & UART1_CR3_STOP;	
2545  00ba c65236        	ld	a,21046
2546                     ; 143 	UART1->BRR2= 0x01;//0x03;
2548  00bd 35015233      	mov	21043,#1
2549                     ; 144 	UART1->BRR1= 0x1a;//0x68;
2551  00c1 351a5232      	mov	21042,#26
2552                     ; 145 	UART1->CR2|= UART1_CR2_TEN | UART3_CR2_REN | UART3_CR2_RIEN;	
2554  00c5 c65235        	ld	a,21045
2555  00c8 aa2c          	or	a,#44
2556  00ca c75235        	ld	21045,a
2557                     ; 146 }
2560  00cd 81            	ret
2678                     ; 149 void uart_out (char num,char data0,char data1,char data2,char data3,char data4,char data5){
2679                     	switch	.text
2680  00ce               _uart_out:
2682  00ce 89            	pushw	x
2683  00cf 520c          	subw	sp,#12
2684       0000000c      OFST:	set	12
2687                     ; 150 	char i=0,t=0,UOB[10];
2691  00d1 0f01          	clr	(OFST-11,sp)
2692                     ; 153 	UOB[0]=data0;
2694  00d3 9f            	ld	a,xl
2695  00d4 6b02          	ld	(OFST-10,sp),a
2696                     ; 154 	UOB[1]=data1;
2698  00d6 7b11          	ld	a,(OFST+5,sp)
2699  00d8 6b03          	ld	(OFST-9,sp),a
2700                     ; 155 	UOB[2]=data2;
2702  00da 7b12          	ld	a,(OFST+6,sp)
2703  00dc 6b04          	ld	(OFST-8,sp),a
2704                     ; 156 	UOB[3]=data3;
2706  00de 7b13          	ld	a,(OFST+7,sp)
2707  00e0 6b05          	ld	(OFST-7,sp),a
2708                     ; 157 	UOB[4]=data4;
2710  00e2 7b14          	ld	a,(OFST+8,sp)
2711  00e4 6b06          	ld	(OFST-6,sp),a
2712                     ; 158 	UOB[5]=data5;
2714  00e6 7b15          	ld	a,(OFST+9,sp)
2715  00e8 6b07          	ld	(OFST-5,sp),a
2716                     ; 159 	for (i=0;i<num;i++)
2718  00ea 0f0c          	clr	(OFST+0,sp)
2720  00ec 2013          	jra	L5261
2721  00ee               L1261:
2722                     ; 161 		t^=UOB[i];
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
2736                     ; 159 	for (i=0;i<num;i++)
2738  00ff 0c0c          	inc	(OFST+0,sp)
2739  0101               L5261:
2742  0101 7b0c          	ld	a,(OFST+0,sp)
2743  0103 110d          	cp	a,(OFST+1,sp)
2744  0105 25e7          	jrult	L1261
2745                     ; 163 	UOB[num]=num;
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
2758                     ; 164 	t^=UOB[num];
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
2772                     ; 165 	UOB[num+1]=t;
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
2785                     ; 166 	UOB[num+2]=END;
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
2798                     ; 170 	for (i=0;i<num+3;i++)
2800  0145 0f0c          	clr	(OFST+0,sp)
2802  0147 2012          	jra	L5361
2803  0149               L1361:
2804                     ; 172 		putchar(UOB[i]);
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
2816  0156 cd086a        	call	_putchar
2818                     ; 170 	for (i=0;i<num+3;i++)
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
2835                     ; 175 	bOUT_FREE=0;	  	
2837  0171 72110003      	bres	_bOUT_FREE
2838                     ; 176 }
2841  0175 5b0e          	addw	sp,#14
2842  0177 81            	ret
2924                     ; 179 void uart_out_adr_block (unsigned long adress,char *ptr, char len)
2924                     ; 180 {
2925                     	switch	.text
2926  0178               _uart_out_adr_block:
2928  0178 5203          	subw	sp,#3
2929       00000003      OFST:	set	3
2932                     ; 184 t=0;
2934  017a 0f02          	clr	(OFST-1,sp)
2935                     ; 185 temp11=CMND;
2937                     ; 186 t^=temp11;
2939  017c 7b02          	ld	a,(OFST-1,sp)
2940  017e a816          	xor	a,	#22
2941  0180 6b02          	ld	(OFST-1,sp),a
2942                     ; 187 putchar(temp11);
2944  0182 a616          	ld	a,#22
2945  0184 cd086a        	call	_putchar
2947                     ; 189 temp11=10;
2949                     ; 190 t^=temp11;
2951  0187 7b02          	ld	a,(OFST-1,sp)
2952  0189 a80a          	xor	a,	#10
2953  018b 6b02          	ld	(OFST-1,sp),a
2954                     ; 191 putchar(temp11);
2956  018d a60a          	ld	a,#10
2957  018f cd086a        	call	_putchar
2959                     ; 193 temp11=adress%256;//(*((char*)&adress));
2961  0192 7b09          	ld	a,(OFST+6,sp)
2962  0194 a4ff          	and	a,#255
2963  0196 6b03          	ld	(OFST+0,sp),a
2964                     ; 194 t^=temp11;
2966  0198 7b02          	ld	a,(OFST-1,sp)
2967  019a 1803          	xor	a,	(OFST+0,sp)
2968  019c 6b02          	ld	(OFST-1,sp),a
2969                     ; 195 putchar(temp11);
2971  019e 7b03          	ld	a,(OFST+0,sp)
2972  01a0 cd086a        	call	_putchar
2974                     ; 196 adress>>=8;
2976  01a3 96            	ldw	x,sp
2977  01a4 1c0006        	addw	x,#OFST+3
2978  01a7 a608          	ld	a,#8
2979  01a9 cd0000        	call	c_lgursh
2981                     ; 197 temp11=adress%256;//(*(((char*)&adress)+1));
2983  01ac 7b09          	ld	a,(OFST+6,sp)
2984  01ae a4ff          	and	a,#255
2985  01b0 6b03          	ld	(OFST+0,sp),a
2986                     ; 198 t^=temp11;
2988  01b2 7b02          	ld	a,(OFST-1,sp)
2989  01b4 1803          	xor	a,	(OFST+0,sp)
2990  01b6 6b02          	ld	(OFST-1,sp),a
2991                     ; 199 putchar(temp11);
2993  01b8 7b03          	ld	a,(OFST+0,sp)
2994  01ba cd086a        	call	_putchar
2996                     ; 200 adress>>=8;
2998  01bd 96            	ldw	x,sp
2999  01be 1c0006        	addw	x,#OFST+3
3000  01c1 a608          	ld	a,#8
3001  01c3 cd0000        	call	c_lgursh
3003                     ; 201 temp11=adress%256;//(*(((char*)&adress)+2));
3005  01c6 7b09          	ld	a,(OFST+6,sp)
3006  01c8 a4ff          	and	a,#255
3007  01ca 6b03          	ld	(OFST+0,sp),a
3008                     ; 202 t^=temp11;
3010  01cc 7b02          	ld	a,(OFST-1,sp)
3011  01ce 1803          	xor	a,	(OFST+0,sp)
3012  01d0 6b02          	ld	(OFST-1,sp),a
3013                     ; 203 putchar(temp11);
3015  01d2 7b03          	ld	a,(OFST+0,sp)
3016  01d4 cd086a        	call	_putchar
3018                     ; 204 adress>>=8;
3020  01d7 96            	ldw	x,sp
3021  01d8 1c0006        	addw	x,#OFST+3
3022  01db a608          	ld	a,#8
3023  01dd cd0000        	call	c_lgursh
3025                     ; 205 temp11=adress%256;//(*(((char*)&adress)+3));
3027  01e0 7b09          	ld	a,(OFST+6,sp)
3028  01e2 a4ff          	and	a,#255
3029  01e4 6b03          	ld	(OFST+0,sp),a
3030                     ; 206 t^=temp11;
3032  01e6 7b02          	ld	a,(OFST-1,sp)
3033  01e8 1803          	xor	a,	(OFST+0,sp)
3034  01ea 6b02          	ld	(OFST-1,sp),a
3035                     ; 207 putchar(temp11);
3037  01ec 7b03          	ld	a,(OFST+0,sp)
3038  01ee cd086a        	call	_putchar
3040                     ; 210 for(i11=0;i11<len;i11++)
3042  01f1 0f01          	clr	(OFST-2,sp)
3044  01f3 201b          	jra	L7071
3045  01f5               L3071:
3046                     ; 212 	temp11=ptr[i11];
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
3058                     ; 213 	t^=temp11;
3060  0203 7b02          	ld	a,(OFST-1,sp)
3061  0205 1803          	xor	a,	(OFST+0,sp)
3062  0207 6b02          	ld	(OFST-1,sp),a
3063                     ; 214 	putchar(temp11);
3065  0209 7b03          	ld	a,(OFST+0,sp)
3066  020b cd086a        	call	_putchar
3068                     ; 210 for(i11=0;i11<len;i11++)
3070  020e 0c01          	inc	(OFST-2,sp)
3071  0210               L7071:
3074  0210 7b01          	ld	a,(OFST-2,sp)
3075  0212 110c          	cp	a,(OFST+9,sp)
3076  0214 25df          	jrult	L3071
3077                     ; 217 temp11=(len+6);
3079  0216 7b0c          	ld	a,(OFST+9,sp)
3080  0218 ab06          	add	a,#6
3081  021a 6b03          	ld	(OFST+0,sp),a
3082                     ; 218 t^=temp11;
3084  021c 7b02          	ld	a,(OFST-1,sp)
3085  021e 1803          	xor	a,	(OFST+0,sp)
3086  0220 6b02          	ld	(OFST-1,sp),a
3087                     ; 219 putchar(temp11);
3089  0222 7b03          	ld	a,(OFST+0,sp)
3090  0224 cd086a        	call	_putchar
3092                     ; 221 putchar(t);
3094  0227 7b02          	ld	a,(OFST-1,sp)
3095  0229 cd086a        	call	_putchar
3097                     ; 223 putchar(0x0a);
3099  022c a60a          	ld	a,#10
3100  022e cd086a        	call	_putchar
3102                     ; 225 bOUT_FREE=0;	   
3104  0231 72110003      	bres	_bOUT_FREE
3105                     ; 226 }
3108  0235 5b03          	addw	sp,#3
3109  0237 81            	ret
3245                     ; 228 void uart_in_an(void) {
3246                     	switch	.text
3247  0238               _uart_in_an:
3249  0238 5204          	subw	sp,#4
3250       00000004      OFST:	set	4
3253                     ; 231 	if(UIB[0]==CMND) {
3255  023a c60000        	ld	a,_UIB
3256  023d a116          	cp	a,#22
3257  023f 2703          	jreq	L24
3258  0241 cc0867        	jp	L1771
3259  0244               L24:
3260                     ; 232 		if(UIB[1]==1) {
3262  0244 c60001        	ld	a,_UIB+1
3263  0247 a101          	cp	a,#1
3264  0249 262f          	jrne	L3771
3265                     ; 236 			if(memory_manufacturer=='A') {
3267  024b b6bc          	ld	a,_memory_manufacturer
3268  024d a141          	cp	a,#65
3269  024f 2603          	jrne	L5771
3270                     ; 237 				temp_L=DF_mf_dev_read();
3272  0251 cd0a23        	call	_DF_mf_dev_read
3274  0254               L5771:
3275                     ; 239 			if(memory_manufacturer=='S') {
3277  0254 b6bc          	ld	a,_memory_manufacturer
3278  0256 a153          	cp	a,#83
3279  0258 2603          	jrne	L7771
3280                     ; 240 				temp_L=ST_RDID_read();
3282  025a cd092b        	call	_ST_RDID_read
3284  025d               L7771:
3285                     ; 242 			uart_out (6,CMND,1,mdr0/**((char*)&temp_L)*/,mdr1/**(((char*)&temp_L)+1)*/,mdr2/**(((char*)&temp_L)+2)*/,mdr3/**(((char*)&temp_L)+3)*/);
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
3299  0276 ac670867      	jpf	L1771
3300  027a               L3771:
3301                     ; 250 	else if(UIB[1]==2) {
3303  027a c60001        	ld	a,_UIB+1
3304  027d a102          	cp	a,#2
3305  027f 2630          	jrne	L3002
3306                     ; 253 		if(memory_manufacturer=='A') {
3308  0281 b6bc          	ld	a,_memory_manufacturer
3309  0283 a141          	cp	a,#65
3310  0285 2605          	jrne	L5002
3311                     ; 254 			temp=DF_status_read();
3313  0287 cd0a77        	call	_DF_status_read
3315  028a 6b04          	ld	(OFST+0,sp),a
3316  028c               L5002:
3317                     ; 256 		if(memory_manufacturer=='S') {
3319  028c b6bc          	ld	a,_memory_manufacturer
3320  028e a153          	cp	a,#83
3321  0290 2605          	jrne	L7002
3322                     ; 257 			temp=ST_status_read();
3324  0292 cd0957        	call	_ST_status_read
3326  0295 6b04          	ld	(OFST+0,sp),a
3327  0297               L7002:
3328                     ; 259 		uart_out (3,CMND,2,temp,0,0,0);    
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
3343  02ad ac670867      	jpf	L1771
3344  02b1               L3002:
3345                     ; 263 	else if(UIB[1]==3)
3347  02b1 c60001        	ld	a,_UIB+1
3348  02b4 a103          	cp	a,#3
3349  02b6 2623          	jrne	L3102
3350                     ; 266 		if(memory_manufacturer=='A') {
3352  02b8 b6bc          	ld	a,_memory_manufacturer
3353  02ba a141          	cp	a,#65
3354  02bc 2603          	jrne	L5102
3355                     ; 267 			DF_memo_to_256();
3357  02be cd0a5a        	call	_DF_memo_to_256
3359  02c1               L5102:
3360                     ; 269 		uart_out (2,CMND,3,temp,0,0,0);    
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
3375  02d7 ac670867      	jpf	L1771
3376  02db               L3102:
3377                     ; 272 	else if(UIB[1]==4)
3379  02db c60001        	ld	a,_UIB+1
3380  02de a104          	cp	a,#4
3381  02e0 2623          	jrne	L1202
3382                     ; 275 		if(memory_manufacturer=='A') {
3384  02e2 b6bc          	ld	a,_memory_manufacturer
3385  02e4 a141          	cp	a,#65
3386  02e6 2603          	jrne	L3202
3387                     ; 276 			DF_memo_to_256();
3389  02e8 cd0a5a        	call	_DF_memo_to_256
3391  02eb               L3202:
3392                     ; 278 		uart_out (2,CMND,3,temp,0,0,0);    
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
3407  0301 ac670867      	jpf	L1771
3408  0305               L1202:
3409                     ; 281 	else if(UIB[1]==10)
3411  0305 c60001        	ld	a,_UIB+1
3412  0308 a10a          	cp	a,#10
3413  030a 2703cc0392    	jrne	L7202
3414                     ; 285 		if(memory_manufacturer=='A') {
3416  030f b6bc          	ld	a,_memory_manufacturer
3417  0311 a141          	cp	a,#65
3418  0313 2615          	jrne	L1302
3419                     ; 286 			if(UIB[2]==1)DF_buffer_read(/*1,*/0,256, buff);
3421  0315 c60002        	ld	a,_UIB+2
3422  0318 a101          	cp	a,#1
3423  031a 260e          	jrne	L1302
3426  031c ae0050        	ldw	x,#_buff
3427  031f 89            	pushw	x
3428  0320 ae0100        	ldw	x,#256
3429  0323 89            	pushw	x
3430  0324 5f            	clrw	x
3431  0325 cd0ad7        	call	_DF_buffer_read
3433  0328 5b04          	addw	sp,#4
3434  032a               L1302:
3435                     ; 291 		uart_out_adr_block (0,buff,64);
3437  032a 4b40          	push	#64
3438  032c ae0050        	ldw	x,#_buff
3439  032f 89            	pushw	x
3440  0330 ae0000        	ldw	x,#0
3441  0333 89            	pushw	x
3442  0334 ae0000        	ldw	x,#0
3443  0337 89            	pushw	x
3444  0338 cd0178        	call	_uart_out_adr_block
3446  033b 5b07          	addw	sp,#7
3447                     ; 292 		delay_ms(100);    
3449  033d ae0064        	ldw	x,#100
3450  0340 cd005c        	call	_delay_ms
3452                     ; 293 		uart_out_adr_block (64,&buff[64],64);
3454  0343 4b40          	push	#64
3455  0345 ae0090        	ldw	x,#_buff+64
3456  0348 89            	pushw	x
3457  0349 ae0040        	ldw	x,#64
3458  034c 89            	pushw	x
3459  034d ae0000        	ldw	x,#0
3460  0350 89            	pushw	x
3461  0351 cd0178        	call	_uart_out_adr_block
3463  0354 5b07          	addw	sp,#7
3464                     ; 294 		delay_ms(100);    
3466  0356 ae0064        	ldw	x,#100
3467  0359 cd005c        	call	_delay_ms
3469                     ; 295 		uart_out_adr_block (128,&buff[128],64);
3471  035c 4b40          	push	#64
3472  035e ae00d0        	ldw	x,#_buff+128
3473  0361 89            	pushw	x
3474  0362 ae0080        	ldw	x,#128
3475  0365 89            	pushw	x
3476  0366 ae0000        	ldw	x,#0
3477  0369 89            	pushw	x
3478  036a cd0178        	call	_uart_out_adr_block
3480  036d 5b07          	addw	sp,#7
3481                     ; 296 		delay_ms(100);    
3483  036f ae0064        	ldw	x,#100
3484  0372 cd005c        	call	_delay_ms
3486                     ; 297 		uart_out_adr_block (192,&buff[192],64);
3488  0375 4b40          	push	#64
3489  0377 ae0110        	ldw	x,#_buff+192
3490  037a 89            	pushw	x
3491  037b ae00c0        	ldw	x,#192
3492  037e 89            	pushw	x
3493  037f ae0000        	ldw	x,#0
3494  0382 89            	pushw	x
3495  0383 cd0178        	call	_uart_out_adr_block
3497  0386 5b07          	addw	sp,#7
3498                     ; 298 		delay_ms(100);    
3500  0388 ae0064        	ldw	x,#100
3501  038b cd005c        	call	_delay_ms
3504  038e ac670867      	jpf	L1771
3505  0392               L7202:
3506                     ; 301 	else if(UIB[1]==11)
3508  0392 c60001        	ld	a,_UIB+1
3509  0395 a10b          	cp	a,#11
3510  0397 2633          	jrne	L7302
3511                     ; 307 		for(i=0;i<256;i++)buff[i]=0;
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
3530                     ; 309 		if(UIB[2]==1)DF_buffer_write(/*1,*/0,256, buff);
3532  03b0 c60002        	ld	a,_UIB+2
3533  03b3 a101          	cp	a,#1
3534  03b5 2703          	jreq	L44
3535  03b7 cc0867        	jp	L1771
3536  03ba               L44:
3539  03ba ae0050        	ldw	x,#_buff
3540  03bd 89            	pushw	x
3541  03be ae0100        	ldw	x,#256
3542  03c1 89            	pushw	x
3543  03c2 5f            	clrw	x
3544  03c3 cd0b1d        	call	_DF_buffer_write
3546  03c6 5b04          	addw	sp,#4
3547  03c8 ac670867      	jpf	L1771
3548  03cc               L7302:
3549                     ; 313 	else if(UIB[1]==12)
3551  03cc c60001        	ld	a,_UIB+1
3552  03cf a10c          	cp	a,#12
3553  03d1 2703          	jreq	L64
3554  03d3 cc04b2        	jp	L3502
3555  03d6               L64:
3556                     ; 319 		for(i=0;i<256;i++)buff[i]=0;
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
3575                     ; 321 		if(UIB[3]==1)
3577  03ed c60003        	ld	a,_UIB+3
3578  03f0 a101          	cp	a,#1
3579  03f2 2632          	jrne	L3602
3580                     ; 323 			buff[0]=0x00;
3582  03f4 725f0050      	clr	_buff
3583                     ; 324 			buff[1]=0x11;
3585  03f8 35110051      	mov	_buff+1,#17
3586                     ; 325 			buff[2]=0x22;
3588  03fc 35220052      	mov	_buff+2,#34
3589                     ; 326 			buff[3]=0x33;
3591  0400 35330053      	mov	_buff+3,#51
3592                     ; 327 			buff[4]=0x44;
3594  0404 35440054      	mov	_buff+4,#68
3595                     ; 328 			buff[5]=0x55;
3597  0408 35550055      	mov	_buff+5,#85
3598                     ; 329 			buff[6]=0x66;
3600  040c 35660056      	mov	_buff+6,#102
3601                     ; 330 			buff[7]=0x77;
3603  0410 35770057      	mov	_buff+7,#119
3604                     ; 331 			buff[8]=0x88;
3606  0414 35880058      	mov	_buff+8,#136
3607                     ; 332 			buff[9]=0x99;
3609  0418 35990059      	mov	_buff+9,#153
3610                     ; 333 			buff[10]=0;
3612  041c 725f005a      	clr	_buff+10
3613                     ; 334 			buff[11]=0;
3615  0420 725f005b      	clr	_buff+11
3617  0424 2070          	jra	L5602
3618  0426               L3602:
3619                     ; 337 		else if(UIB[3]==2)
3621  0426 c60003        	ld	a,_UIB+3
3622  0429 a102          	cp	a,#2
3623  042b 2632          	jrne	L7602
3624                     ; 339 			buff[0]=0x00;
3626  042d 725f0050      	clr	_buff
3627                     ; 340 			buff[1]=0x10;
3629  0431 35100051      	mov	_buff+1,#16
3630                     ; 341 			buff[2]=0x20;
3632  0435 35200052      	mov	_buff+2,#32
3633                     ; 342 			buff[3]=0x30;
3635  0439 35300053      	mov	_buff+3,#48
3636                     ; 343 			buff[4]=0x40;
3638  043d 35400054      	mov	_buff+4,#64
3639                     ; 344 			buff[5]=0x50;
3641  0441 35500055      	mov	_buff+5,#80
3642                     ; 345 			buff[6]=0x60;
3644  0445 35600056      	mov	_buff+6,#96
3645                     ; 346 			buff[7]=0x70;
3647  0449 35700057      	mov	_buff+7,#112
3648                     ; 347 			buff[8]=0x80;
3650  044d 35800058      	mov	_buff+8,#128
3651                     ; 348 			buff[9]=0x90;
3653  0451 35900059      	mov	_buff+9,#144
3654                     ; 349 			buff[10]=0;
3656  0455 725f005a      	clr	_buff+10
3657                     ; 350 			buff[11]=0;
3659  0459 725f005b      	clr	_buff+11
3661  045d 2037          	jra	L5602
3662  045f               L7602:
3663                     ; 353 		else if(UIB[3]==3)
3665  045f c60003        	ld	a,_UIB+3
3666  0462 a103          	cp	a,#3
3667  0464 2630          	jrne	L5602
3668                     ; 355 			buff[0]=0x98;
3670  0466 35980050      	mov	_buff,#152
3671                     ; 356 			buff[1]=0x87;
3673  046a 35870051      	mov	_buff+1,#135
3674                     ; 357 			buff[2]=0x76;
3676  046e 35760052      	mov	_buff+2,#118
3677                     ; 358 			buff[3]=0x65;
3679  0472 35650053      	mov	_buff+3,#101
3680                     ; 359 			buff[4]=0x54;
3682  0476 35540054      	mov	_buff+4,#84
3683                     ; 360 			buff[5]=0x43;
3685  047a 35430055      	mov	_buff+5,#67
3686                     ; 361 			buff[6]=0x32;
3688  047e 35320056      	mov	_buff+6,#50
3689                     ; 362 			buff[7]=0x21;
3691  0482 35210057      	mov	_buff+7,#33
3692                     ; 363 			buff[8]=0x10;
3694  0486 35100058      	mov	_buff+8,#16
3695                     ; 364 			buff[9]=0x00;
3697  048a 725f0059      	clr	_buff+9
3698                     ; 365 			buff[10]=0;
3700  048e 725f005a      	clr	_buff+10
3701                     ; 366 			buff[11]=0;
3703  0492 725f005b      	clr	_buff+11
3704  0496               L5602:
3705                     ; 368 		if(UIB[2]==1)DF_buffer_write(/*1,*/0,256, buff);
3707  0496 c60002        	ld	a,_UIB+2
3708  0499 a101          	cp	a,#1
3709  049b 2703          	jreq	L05
3710  049d cc0867        	jp	L1771
3711  04a0               L05:
3714  04a0 ae0050        	ldw	x,#_buff
3715  04a3 89            	pushw	x
3716  04a4 ae0100        	ldw	x,#256
3717  04a7 89            	pushw	x
3718  04a8 5f            	clrw	x
3719  04a9 cd0b1d        	call	_DF_buffer_write
3721  04ac 5b04          	addw	sp,#4
3722  04ae ac670867      	jpf	L1771
3723  04b2               L3502:
3724                     ; 372 	else if(UIB[1]==13)
3726  04b2 c60001        	ld	a,_UIB+1
3727  04b5 a10d          	cp	a,#13
3728  04b7 2703cc0555    	jrne	L1012
3729                     ; 377 		if(memory_manufacturer=='A') {	
3731  04bc b6bc          	ld	a,_memory_manufacturer
3732  04be a141          	cp	a,#65
3733  04c0 2608          	jrne	L3012
3734                     ; 378 			DF_page_to_buffer(/*UIB[2],*/UIB[3]);
3736  04c2 c60003        	ld	a,_UIB+3
3737  04c5 5f            	clrw	x
3738  04c6 97            	ld	xl,a
3739  04c7 cd0a91        	call	_DF_page_to_buffer
3741  04ca               L3012:
3742                     ; 380 		if(memory_manufacturer=='S') {
3744  04ca b6bc          	ld	a,_memory_manufacturer
3745  04cc a153          	cp	a,#83
3746  04ce 2703          	jreq	L25
3747  04d0 cc0867        	jp	L1771
3748  04d3               L25:
3749                     ; 381 			current_page=11;
3751  04d3 ae000b        	ldw	x,#11
3752  04d6 bf0f          	ldw	_current_page,x
3753                     ; 382 			ST_READ((long)(current_page*256),256, buff);
3755  04d8 ae0050        	ldw	x,#_buff
3756  04db 89            	pushw	x
3757  04dc ae0100        	ldw	x,#256
3758  04df 89            	pushw	x
3759  04e0 ae0b00        	ldw	x,#2816
3760  04e3 89            	pushw	x
3761  04e4 ae0000        	ldw	x,#0
3762  04e7 89            	pushw	x
3763  04e8 cd09d5        	call	_ST_READ
3765  04eb 5b08          	addw	sp,#8
3766                     ; 384 			uart_out_adr_block (0,buff,64);
3768  04ed 4b40          	push	#64
3769  04ef ae0050        	ldw	x,#_buff
3770  04f2 89            	pushw	x
3771  04f3 ae0000        	ldw	x,#0
3772  04f6 89            	pushw	x
3773  04f7 ae0000        	ldw	x,#0
3774  04fa 89            	pushw	x
3775  04fb cd0178        	call	_uart_out_adr_block
3777  04fe 5b07          	addw	sp,#7
3778                     ; 385 			delay_ms(100);    
3780  0500 ae0064        	ldw	x,#100
3781  0503 cd005c        	call	_delay_ms
3783                     ; 386 			uart_out_adr_block (64,&buff[64],64);
3785  0506 4b40          	push	#64
3786  0508 ae0090        	ldw	x,#_buff+64
3787  050b 89            	pushw	x
3788  050c ae0040        	ldw	x,#64
3789  050f 89            	pushw	x
3790  0510 ae0000        	ldw	x,#0
3791  0513 89            	pushw	x
3792  0514 cd0178        	call	_uart_out_adr_block
3794  0517 5b07          	addw	sp,#7
3795                     ; 387 			delay_ms(100);    
3797  0519 ae0064        	ldw	x,#100
3798  051c cd005c        	call	_delay_ms
3800                     ; 388 			uart_out_adr_block (128,&buff[128],64);
3802  051f 4b40          	push	#64
3803  0521 ae00d0        	ldw	x,#_buff+128
3804  0524 89            	pushw	x
3805  0525 ae0080        	ldw	x,#128
3806  0528 89            	pushw	x
3807  0529 ae0000        	ldw	x,#0
3808  052c 89            	pushw	x
3809  052d cd0178        	call	_uart_out_adr_block
3811  0530 5b07          	addw	sp,#7
3812                     ; 389 			delay_ms(100);    
3814  0532 ae0064        	ldw	x,#100
3815  0535 cd005c        	call	_delay_ms
3817                     ; 390 			uart_out_adr_block (192,&buff[192],64);
3819  0538 4b40          	push	#64
3820  053a ae0110        	ldw	x,#_buff+192
3821  053d 89            	pushw	x
3822  053e ae00c0        	ldw	x,#192
3823  0541 89            	pushw	x
3824  0542 ae0000        	ldw	x,#0
3825  0545 89            	pushw	x
3826  0546 cd0178        	call	_uart_out_adr_block
3828  0549 5b07          	addw	sp,#7
3829                     ; 391 			delay_ms(100); 
3831  054b ae0064        	ldw	x,#100
3832  054e cd005c        	call	_delay_ms
3834  0551 ac670867      	jpf	L1771
3835  0555               L1012:
3836                     ; 394 	else if(UIB[1]==14)
3838  0555 c60001        	ld	a,_UIB+1
3839  0558 a10e          	cp	a,#14
3840  055a 265b          	jrne	L1112
3841                     ; 399 		if(memory_manufacturer=='A') {	
3843  055c b6bc          	ld	a,_memory_manufacturer
3844  055e a141          	cp	a,#65
3845  0560 2608          	jrne	L3112
3846                     ; 400 			DF_buffer_to_page_er(/*UIB[2],*/UIB[3]);
3848  0562 c60003        	ld	a,_UIB+3
3849  0565 5f            	clrw	x
3850  0566 97            	ld	xl,a
3851  0567 cd0ab4        	call	_DF_buffer_to_page_er
3853  056a               L3112:
3854                     ; 402 		if(memory_manufacturer=='S') {
3856  056a b6bc          	ld	a,_memory_manufacturer
3857  056c a153          	cp	a,#83
3858  056e 2703          	jreq	L45
3859  0570 cc0867        	jp	L1771
3860  0573               L45:
3861                     ; 403 			for(i=0;i<256;i++) {
3863  0573 5f            	clrw	x
3864  0574 1f03          	ldw	(OFST-1,sp),x
3865  0576               L7112:
3866                     ; 404 				buff[i]=(char)i;
3868  0576 7b04          	ld	a,(OFST+0,sp)
3869  0578 1e03          	ldw	x,(OFST-1,sp)
3870  057a d70050        	ld	(_buff,x),a
3871                     ; 403 			for(i=0;i<256;i++) {
3873  057d 1e03          	ldw	x,(OFST-1,sp)
3874  057f 1c0001        	addw	x,#1
3875  0582 1f03          	ldw	(OFST-1,sp),x
3878  0584 1e03          	ldw	x,(OFST-1,sp)
3879  0586 a30100        	cpw	x,#256
3880  0589 25eb          	jrult	L7112
3881                     ; 406 			current_page=11;
3883  058b ae000b        	ldw	x,#11
3884  058e bf0f          	ldw	_current_page,x
3885                     ; 407 			ST_WREN();
3887  0590 cd097c        	call	_ST_WREN
3889                     ; 408 			delay_ms(100);
3891  0593 ae0064        	ldw	x,#100
3892  0596 cd005c        	call	_delay_ms
3894                     ; 409 			ST_WRITE((long)(current_page*256),256,buff);		
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
3909  05ae cd0989        	call	_ST_WRITE
3911  05b1 5b08          	addw	sp,#8
3912  05b3 ac670867      	jpf	L1771
3913  05b7               L1112:
3914                     ; 414 	else if(UIB[1]==20)
3916  05b7 c60001        	ld	a,_UIB+1
3917  05ba a114          	cp	a,#20
3918  05bc 2703cc0648    	jrne	L7212
3919                     ; 419 		file_lengt=0;
3921  05c1 ae0000        	ldw	x,#0
3922  05c4 bf09          	ldw	_file_lengt+2,x
3923  05c6 ae0000        	ldw	x,#0
3924  05c9 bf07          	ldw	_file_lengt,x
3925                     ; 420 		file_lengt+=UIB[5];
3927  05cb c60005        	ld	a,_UIB+5
3928  05ce ae0007        	ldw	x,#_file_lengt
3929  05d1 88            	push	a
3930  05d2 cd0000        	call	c_lgadc
3932  05d5 84            	pop	a
3933                     ; 421 		file_lengt<<=8;
3935  05d6 ae0007        	ldw	x,#_file_lengt
3936  05d9 a608          	ld	a,#8
3937  05db cd0000        	call	c_lglsh
3939                     ; 422 		file_lengt+=UIB[4];
3941  05de c60004        	ld	a,_UIB+4
3942  05e1 ae0007        	ldw	x,#_file_lengt
3943  05e4 88            	push	a
3944  05e5 cd0000        	call	c_lgadc
3946  05e8 84            	pop	a
3947                     ; 423 		file_lengt<<=8;
3949  05e9 ae0007        	ldw	x,#_file_lengt
3950  05ec a608          	ld	a,#8
3951  05ee cd0000        	call	c_lglsh
3953                     ; 424 		file_lengt+=UIB[3];
3955  05f1 c60003        	ld	a,_UIB+3
3956  05f4 ae0007        	ldw	x,#_file_lengt
3957  05f7 88            	push	a
3958  05f8 cd0000        	call	c_lgadc
3960  05fb 84            	pop	a
3961                     ; 425 		file_lengt_in_pages=file_lengt;
3963  05fc be09          	ldw	x,_file_lengt+2
3964  05fe bf11          	ldw	_file_lengt_in_pages,x
3965                     ; 426 		file_lengt<<=8;
3967  0600 ae0007        	ldw	x,#_file_lengt
3968  0603 a608          	ld	a,#8
3969  0605 cd0000        	call	c_lglsh
3971                     ; 427 		file_lengt+=UIB[2];
3973  0608 c60002        	ld	a,_UIB+2
3974  060b ae0007        	ldw	x,#_file_lengt
3975  060e 88            	push	a
3976  060f cd0000        	call	c_lgadc
3978  0612 84            	pop	a
3979                     ; 432 		current_page=0;
3981  0613 5f            	clrw	x
3982  0614 bf0f          	ldw	_current_page,x
3983                     ; 433 		current_byte_in_buffer=0;
3985  0616 5f            	clrw	x
3986  0617 bf0b          	ldw	_current_byte_in_buffer,x
3987                     ; 435 		if(memory_manufacturer=='S') {
3989  0619 b6bc          	ld	a,_memory_manufacturer
3990  061b a153          	cp	a,#83
3991  061d 260c          	jrne	L1312
3992                     ; 436 			ST_WREN();
3994  061f cd097c        	call	_ST_WREN
3996                     ; 437 					delay_ms(100);
3998  0622 ae0064        	ldw	x,#100
3999  0625 cd005c        	call	_delay_ms
4001                     ; 438 		ST_bulk_erase();
4003  0628 cd096f        	call	_ST_bulk_erase
4005  062b               L1312:
4006                     ; 440 		uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
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
4022  0644 ac670867      	jpf	L1771
4023  0648               L7212:
4024                     ; 443 	else if(UIB[1]==21)
4026  0648 c60001        	ld	a,_UIB+1
4027  064b a115          	cp	a,#21
4028  064d 2703          	jreq	L65
4029  064f cc074c        	jp	L5312
4030  0652               L65:
4031                     ; 448 		CS_FLASH;
4033  0652 c6500a        	ld	a,20490
4034  0655 a808          	xor	a,	#8
4035  0657 c7500a        	ld	20490,a
4036                     ; 450           for(i=0;i<64;i++)
4039  065a 5f            	clrw	x
4040  065b 1f03          	ldw	(OFST-1,sp),x
4041  065d               L7312:
4042                     ; 452           	buff[current_byte_in_buffer+i]=UIB[2+i];
4044  065d 1e03          	ldw	x,(OFST-1,sp)
4045  065f d60002        	ld	a,(_UIB+2,x)
4046  0662 be0b          	ldw	x,_current_byte_in_buffer
4047  0664 72fb03        	addw	x,(OFST-1,sp)
4048  0667 d70050        	ld	(_buff,x),a
4049                     ; 450           for(i=0;i<64;i++)
4051  066a 1e03          	ldw	x,(OFST-1,sp)
4052  066c 1c0001        	addw	x,#1
4053  066f 1f03          	ldw	(OFST-1,sp),x
4056  0671 1e03          	ldw	x,(OFST-1,sp)
4057  0673 a30040        	cpw	x,#64
4058  0676 25e5          	jrult	L7312
4059                     ; 454           current_byte_in_buffer+=64;
4061  0678 be0b          	ldw	x,_current_byte_in_buffer
4062  067a 1c0040        	addw	x,#64
4063  067d bf0b          	ldw	_current_byte_in_buffer,x
4064                     ; 455           if(current_byte_in_buffer>=256)
4066  067f be0b          	ldw	x,_current_byte_in_buffer
4067  0681 a30100        	cpw	x,#256
4068  0684 2403          	jruge	L06
4069  0686 cc0867        	jp	L1771
4070  0689               L06:
4071                     ; 463 			if(memory_manufacturer=='A') {
4073  0689 b6bc          	ld	a,_memory_manufacturer
4074  068b a141          	cp	a,#65
4075  068d 264e          	jrne	L7412
4076                     ; 464 				DF_buffer_write(/*//current_buffer*//*1,*/0,256,buff);
4078  068f ae0050        	ldw	x,#_buff
4079  0692 89            	pushw	x
4080  0693 ae0100        	ldw	x,#256
4081  0696 89            	pushw	x
4082  0697 5f            	clrw	x
4083  0698 cd0b1d        	call	_DF_buffer_write
4085  069b 5b04          	addw	sp,#4
4086                     ; 465 				DF_buffer_to_page_er(/*///current_buffer*//*1,*/current_page);
4088  069d be0f          	ldw	x,_current_page
4089  069f cd0ab4        	call	_DF_buffer_to_page_er
4091                     ; 466 				current_page++;
4093  06a2 be0f          	ldw	x,_current_page
4094  06a4 1c0001        	addw	x,#1
4095  06a7 bf0f          	ldw	_current_page,x
4096                     ; 467 				if(current_page<file_lengt_in_pages)
4098  06a9 be0f          	ldw	x,_current_page
4099  06ab b311          	cpw	x,_file_lengt_in_pages
4100  06ad 2424          	jruge	L1512
4101                     ; 469 					delay_ms(100);
4103  06af ae0064        	ldw	x,#100
4104  06b2 cd005c        	call	_delay_ms
4106                     ; 470 					uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
4108  06b5 4b00          	push	#0
4109  06b7 4b00          	push	#0
4110  06b9 3b000f        	push	_current_page
4111  06bc b610          	ld	a,_current_page+1
4112  06be a4ff          	and	a,#255
4113  06c0 88            	push	a
4114  06c1 4b15          	push	#21
4115  06c3 ae0016        	ldw	x,#22
4116  06c6 a604          	ld	a,#4
4117  06c8 95            	ld	xh,a
4118  06c9 cd00ce        	call	_uart_out
4120  06cc 5b05          	addw	sp,#5
4121                     ; 471 					current_byte_in_buffer=0;
4123  06ce 5f            	clrw	x
4124  06cf bf0b          	ldw	_current_byte_in_buffer,x
4126  06d1 200a          	jra	L7412
4127  06d3               L1512:
4128                     ; 475 					EE_PAGE_LEN=current_page;
4130  06d3 be0f          	ldw	x,_current_page
4131  06d5 89            	pushw	x
4132  06d6 ae0000        	ldw	x,#_EE_PAGE_LEN
4133  06d9 cd0000        	call	c_eewrw
4135  06dc 85            	popw	x
4136  06dd               L7412:
4137                     ; 478 			if(memory_manufacturer=='S') {
4139  06dd b6bc          	ld	a,_memory_manufacturer
4140  06df a153          	cp	a,#83
4141  06e1 2703          	jreq	L26
4142  06e3 cc0867        	jp	L1771
4143  06e6               L26:
4144                     ; 479 				ST_WREN();
4146  06e6 cd097c        	call	_ST_WREN
4148                     ; 480 				delay_ms(100);
4150  06e9 ae0064        	ldw	x,#100
4151  06ec cd005c        	call	_delay_ms
4153                     ; 481 				ST_WRITE((unsigned long)(current_page*256UL),256,buff);
4155  06ef ae0050        	ldw	x,#_buff
4156  06f2 89            	pushw	x
4157  06f3 ae0100        	ldw	x,#256
4158  06f6 89            	pushw	x
4159  06f7 be0f          	ldw	x,_current_page
4160  06f9 90ae0100      	ldw	y,#256
4161  06fd cd0000        	call	c_umul
4163  0700 be02          	ldw	x,c_lreg+2
4164  0702 89            	pushw	x
4165  0703 be00          	ldw	x,c_lreg
4166  0705 89            	pushw	x
4167  0706 cd0989        	call	_ST_WRITE
4169  0709 5b08          	addw	sp,#8
4170                     ; 482 				current_page++;
4172  070b be0f          	ldw	x,_current_page
4173  070d 1c0001        	addw	x,#1
4174  0710 bf0f          	ldw	_current_page,x
4175                     ; 483 				if(current_page<file_lengt_in_pages)
4177  0712 be0f          	ldw	x,_current_page
4178  0714 b311          	cpw	x,_file_lengt_in_pages
4179  0716 2426          	jruge	L7512
4180                     ; 485 					delay_ms(100);
4182  0718 ae0064        	ldw	x,#100
4183  071b cd005c        	call	_delay_ms
4185                     ; 486 					uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
4187  071e 4b00          	push	#0
4188  0720 4b00          	push	#0
4189  0722 3b000f        	push	_current_page
4190  0725 b610          	ld	a,_current_page+1
4191  0727 a4ff          	and	a,#255
4192  0729 88            	push	a
4193  072a 4b15          	push	#21
4194  072c ae0016        	ldw	x,#22
4195  072f a604          	ld	a,#4
4196  0731 95            	ld	xh,a
4197  0732 cd00ce        	call	_uart_out
4199  0735 5b05          	addw	sp,#5
4200                     ; 487 					current_byte_in_buffer=0;
4202  0737 5f            	clrw	x
4203  0738 bf0b          	ldw	_current_byte_in_buffer,x
4205  073a ac670867      	jpf	L1771
4206  073e               L7512:
4207                     ; 491 					EE_PAGE_LEN=current_page;
4209  073e be0f          	ldw	x,_current_page
4210  0740 89            	pushw	x
4211  0741 ae0000        	ldw	x,#_EE_PAGE_LEN
4212  0744 cd0000        	call	c_eewrw
4214  0747 85            	popw	x
4215  0748 ac670867      	jpf	L1771
4216  074c               L5312:
4217                     ; 502 	else if(UIB[1]==24) {
4219  074c c60001        	ld	a,_UIB+1
4220  074f a118          	cp	a,#24
4221  0751 2615          	jrne	L5612
4222                     ; 505 		rele_cnt=10;
4224  0753 ae000a        	ldw	x,#10
4225  0756 bf03          	ldw	_rele_cnt,x
4226                     ; 506 		ST_WREN();
4228  0758 cd097c        	call	_ST_WREN
4230                     ; 507 		delay_ms(100);
4232  075b ae0064        	ldw	x,#100
4233  075e cd005c        	call	_delay_ms
4235                     ; 508 		ST_bulk_erase();
4237  0761 cd096f        	call	_ST_bulk_erase
4240  0764 ac670867      	jpf	L1771
4241  0768               L5612:
4242                     ; 513 	else if(UIB[1]==25)
4244  0768 c60001        	ld	a,_UIB+1
4245  076b a119          	cp	a,#25
4246  076d 2703          	jreq	L46
4247  076f cc084f        	jp	L1712
4248  0772               L46:
4249                     ; 517 		current_page=0;
4251  0772 5f            	clrw	x
4252  0773 bf0f          	ldw	_current_page,x
4253                     ; 519 		for(i__=0;i__<EE_PAGE_LEN;i__++)
4255  0775 5f            	clrw	x
4256  0776 1f03          	ldw	(OFST-1,sp),x
4258  0778 ac430843      	jpf	L7712
4259  077c               L3712:
4260                     ; 521 			if(memory_manufacturer=='S') {	
4262  077c b6bc          	ld	a,_memory_manufacturer
4263  077e a153          	cp	a,#83
4264  0780 2619          	jrne	L3022
4265                     ; 522 				DF_page_to_buffer(i__);
4267  0782 1e03          	ldw	x,(OFST-1,sp)
4268  0784 cd0a91        	call	_DF_page_to_buffer
4270                     ; 523 				delay_ms(100);			
4272  0787 ae0064        	ldw	x,#100
4273  078a cd005c        	call	_delay_ms
4275                     ; 524 				DF_buffer_read(0,256, buff);
4277  078d ae0050        	ldw	x,#_buff
4278  0790 89            	pushw	x
4279  0791 ae0100        	ldw	x,#256
4280  0794 89            	pushw	x
4281  0795 5f            	clrw	x
4282  0796 cd0ad7        	call	_DF_buffer_read
4284  0799 5b04          	addw	sp,#4
4285  079b               L3022:
4286                     ; 527 			if(memory_manufacturer=='S') {	
4288  079b b6bc          	ld	a,_memory_manufacturer
4289  079d a153          	cp	a,#83
4290  079f 261a          	jrne	L5022
4291                     ; 528 				ST_READ((long)(i__*256),256, buff);
4293  07a1 ae0050        	ldw	x,#_buff
4294  07a4 89            	pushw	x
4295  07a5 ae0100        	ldw	x,#256
4296  07a8 89            	pushw	x
4297  07a9 1e07          	ldw	x,(OFST+3,sp)
4298  07ab 4f            	clr	a
4299  07ac 02            	rlwa	x,a
4300  07ad cd0000        	call	c_itolx
4302  07b0 be02          	ldw	x,c_lreg+2
4303  07b2 89            	pushw	x
4304  07b3 be00          	ldw	x,c_lreg
4305  07b5 89            	pushw	x
4306  07b6 cd09d5        	call	_ST_READ
4308  07b9 5b08          	addw	sp,#8
4309  07bb               L5022:
4310                     ; 531 			uart_out_adr_block ((256*i__)+0,buff,64);
4312  07bb 4b40          	push	#64
4313  07bd ae0050        	ldw	x,#_buff
4314  07c0 89            	pushw	x
4315  07c1 1e06          	ldw	x,(OFST+2,sp)
4316  07c3 4f            	clr	a
4317  07c4 02            	rlwa	x,a
4318  07c5 cd0000        	call	c_itolx
4320  07c8 be02          	ldw	x,c_lreg+2
4321  07ca 89            	pushw	x
4322  07cb be00          	ldw	x,c_lreg
4323  07cd 89            	pushw	x
4324  07ce cd0178        	call	_uart_out_adr_block
4326  07d1 5b07          	addw	sp,#7
4327                     ; 532 			delay_ms(100);    
4329  07d3 ae0064        	ldw	x,#100
4330  07d6 cd005c        	call	_delay_ms
4332                     ; 533 			uart_out_adr_block ((256*i__)+64,&buff[64],64);
4334  07d9 4b40          	push	#64
4335  07db ae0090        	ldw	x,#_buff+64
4336  07de 89            	pushw	x
4337  07df 1e06          	ldw	x,(OFST+2,sp)
4338  07e1 4f            	clr	a
4339  07e2 02            	rlwa	x,a
4340  07e3 1c0040        	addw	x,#64
4341  07e6 cd0000        	call	c_itolx
4343  07e9 be02          	ldw	x,c_lreg+2
4344  07eb 89            	pushw	x
4345  07ec be00          	ldw	x,c_lreg
4346  07ee 89            	pushw	x
4347  07ef cd0178        	call	_uart_out_adr_block
4349  07f2 5b07          	addw	sp,#7
4350                     ; 534 			delay_ms(100);    
4352  07f4 ae0064        	ldw	x,#100
4353  07f7 cd005c        	call	_delay_ms
4355                     ; 535 			uart_out_adr_block ((256*i__)+128,&buff[128],64);
4357  07fa 4b40          	push	#64
4358  07fc ae00d0        	ldw	x,#_buff+128
4359  07ff 89            	pushw	x
4360  0800 1e06          	ldw	x,(OFST+2,sp)
4361  0802 4f            	clr	a
4362  0803 02            	rlwa	x,a
4363  0804 1c0080        	addw	x,#128
4364  0807 cd0000        	call	c_itolx
4366  080a be02          	ldw	x,c_lreg+2
4367  080c 89            	pushw	x
4368  080d be00          	ldw	x,c_lreg
4369  080f 89            	pushw	x
4370  0810 cd0178        	call	_uart_out_adr_block
4372  0813 5b07          	addw	sp,#7
4373                     ; 536 			delay_ms(100);    
4375  0815 ae0064        	ldw	x,#100
4376  0818 cd005c        	call	_delay_ms
4378                     ; 537 			uart_out_adr_block ((256*i__)+192,&buff[192],64);
4380  081b 4b40          	push	#64
4381  081d ae0110        	ldw	x,#_buff+192
4382  0820 89            	pushw	x
4383  0821 1e06          	ldw	x,(OFST+2,sp)
4384  0823 4f            	clr	a
4385  0824 02            	rlwa	x,a
4386  0825 1c00c0        	addw	x,#192
4387  0828 cd0000        	call	c_itolx
4389  082b be02          	ldw	x,c_lreg+2
4390  082d 89            	pushw	x
4391  082e be00          	ldw	x,c_lreg
4392  0830 89            	pushw	x
4393  0831 cd0178        	call	_uart_out_adr_block
4395  0834 5b07          	addw	sp,#7
4396                     ; 538 			delay_ms(100);   
4398  0836 ae0064        	ldw	x,#100
4399  0839 cd005c        	call	_delay_ms
4401                     ; 519 		for(i__=0;i__<EE_PAGE_LEN;i__++)
4403  083c 1e03          	ldw	x,(OFST-1,sp)
4404  083e 1c0001        	addw	x,#1
4405  0841 1f03          	ldw	(OFST-1,sp),x
4406  0843               L7712:
4409  0843 1e03          	ldw	x,(OFST-1,sp)
4410  0845 c30000        	cpw	x,_EE_PAGE_LEN
4411  0848 2403          	jruge	L66
4412  084a cc077c        	jp	L3712
4413  084d               L66:
4415  084d 2018          	jra	L1771
4416  084f               L1712:
4417                     ; 548 	else if(UIB[1]==30)
4419  084f c60001        	ld	a,_UIB+1
4420  0852 a11e          	cp	a,#30
4421  0854 2606          	jrne	L1122
4422                     ; 570           bSTART=1;
4424  0856 7210000c      	bset	_bSTART
4426  085a 200b          	jra	L1771
4427  085c               L1122:
4428                     ; 582 	else if(UIB[1]==40)
4430  085c c60001        	ld	a,_UIB+1
4431  085f a128          	cp	a,#40
4432  0861 2604          	jrne	L1771
4433                     ; 604 		bSTART=1;	
4435  0863 7210000c      	bset	_bSTART
4436  0867               L1771:
4437                     ; 609 }
4440  0867 5b04          	addw	sp,#4
4441  0869 81            	ret
4478                     ; 612 void putchar(char c)
4478                     ; 613 {
4479                     	switch	.text
4480  086a               _putchar:
4482  086a 88            	push	a
4483       00000000      OFST:	set	0
4486  086b               L7322:
4487                     ; 614 while (tx_counter == TX_BUFFER_SIZE);
4489  086b b620          	ld	a,_tx_counter
4490  086d a150          	cp	a,#80
4491  086f 27fa          	jreq	L7322
4492                     ; 616 if (tx_counter || ((UART1->SR & UART1_SR_TXE)==0))
4494  0871 3d20          	tnz	_tx_counter
4495  0873 2607          	jrne	L5422
4497  0875 c65230        	ld	a,21040
4498  0878 a580          	bcp	a,#128
4499  087a 261d          	jrne	L3422
4500  087c               L5422:
4501                     ; 618    tx_buffer[tx_wr_index]=c;
4503  087c 5f            	clrw	x
4504  087d b61f          	ld	a,_tx_wr_index
4505  087f 2a01          	jrpl	L27
4506  0881 53            	cplw	x
4507  0882               L27:
4508  0882 97            	ld	xl,a
4509  0883 7b01          	ld	a,(OFST+1,sp)
4510  0885 e704          	ld	(_tx_buffer,x),a
4511                     ; 619    if (++tx_wr_index == TX_BUFFER_SIZE) tx_wr_index=0;
4513  0887 3c1f          	inc	_tx_wr_index
4514  0889 b61f          	ld	a,_tx_wr_index
4515  088b a150          	cp	a,#80
4516  088d 2602          	jrne	L7422
4519  088f 3f1f          	clr	_tx_wr_index
4520  0891               L7422:
4521                     ; 620    ++tx_counter;
4523  0891 3c20          	inc	_tx_counter
4525  0893               L1522:
4526                     ; 624 UART1->CR2|= UART1_CR2_TIEN;
4528  0893 721e5235      	bset	21045,#7
4529                     ; 626 }
4532  0897 84            	pop	a
4533  0898 81            	ret
4534  0899               L3422:
4535                     ; 622 else UART1->DR=c;
4537  0899 7b01          	ld	a,(OFST+1,sp)
4538  089b c75231        	ld	21041,a
4539  089e 20f3          	jra	L1522
4562                     ; 629 void spi_init(void){
4563                     	switch	.text
4564  08a0               _spi_init:
4568                     ; 631 	GPIOA->DDR|=(1<<3);
4570  08a0 72165002      	bset	20482,#3
4571                     ; 632 	GPIOA->CR1|=(1<<3);
4573  08a4 72165003      	bset	20483,#3
4574                     ; 633 	GPIOA->CR2&=~(1<<3);
4576  08a8 72175004      	bres	20484,#3
4577                     ; 634 	GPIOA->ODR|=(1<<3);	
4579  08ac 72165000      	bset	20480,#3
4580                     ; 637 	GPIOB->DDR|=(1<<5);
4582  08b0 721a5007      	bset	20487,#5
4583                     ; 638 	GPIOB->CR1|=(1<<5);
4585  08b4 721a5008      	bset	20488,#5
4586                     ; 639 	GPIOB->CR2&=~(1<<5);
4588  08b8 721b5009      	bres	20489,#5
4589                     ; 640 	GPIOB->ODR|=(1<<5);	
4591  08bc 721a5005      	bset	20485,#5
4592                     ; 642 	GPIOC->DDR|=(1<<3);
4594  08c0 7216500c      	bset	20492,#3
4595                     ; 643 	GPIOC->CR1|=(1<<3);
4597  08c4 7216500d      	bset	20493,#3
4598                     ; 644 	GPIOC->CR2&=~(1<<3);
4600  08c8 7217500e      	bres	20494,#3
4601                     ; 645 	GPIOC->ODR|=(1<<3);	
4603  08cc 7216500a      	bset	20490,#3
4604                     ; 647 	GPIOC->DDR|=(1<<5);
4606  08d0 721a500c      	bset	20492,#5
4607                     ; 648 	GPIOC->CR1|=(1<<5);
4609  08d4 721a500d      	bset	20493,#5
4610                     ; 649 	GPIOC->CR2|=(1<<5);
4612  08d8 721a500e      	bset	20494,#5
4613                     ; 650 	GPIOC->ODR|=(1<<5);	
4615  08dc 721a500a      	bset	20490,#5
4616                     ; 652 	GPIOC->DDR|=(1<<6);
4618  08e0 721c500c      	bset	20492,#6
4619                     ; 653 	GPIOC->CR1|=(1<<6);
4621  08e4 721c500d      	bset	20493,#6
4622                     ; 654 	GPIOC->CR2|=(1<<6);
4624  08e8 721c500e      	bset	20494,#6
4625                     ; 655 	GPIOC->ODR|=(1<<6);	
4627  08ec 721c500a      	bset	20490,#6
4628                     ; 657 	GPIOC->DDR&=~(1<<7);
4630  08f0 721f500c      	bres	20492,#7
4631                     ; 658 	GPIOC->CR1&=~(1<<7);
4633  08f4 721f500d      	bres	20493,#7
4634                     ; 659 	GPIOC->CR2&=~(1<<7);
4636  08f8 721f500e      	bres	20494,#7
4637                     ; 660 	GPIOC->ODR|=(1<<7);	
4639  08fc 721e500a      	bset	20490,#7
4640                     ; 662 	SPI->CR1= /*SPI_CR1_LSBFIRST |*/
4640                     ; 663 			SPI_CR1_SPE | 
4640                     ; 664 			( (4<< 3) & SPI_CR1_BR ) |
4640                     ; 665 			SPI_CR1_MSTR |
4640                     ; 666 			SPI_CR1_CPOL |
4640                     ; 667 			SPI_CR1_CPHA; 
4642  0900 35675200      	mov	20992,#103
4643                     ; 669 	SPI->CR2= SPI_CR2_SSM | SPI_CR2_SSI;
4645  0904 35035201      	mov	20993,#3
4646                     ; 670 	SPI->ICR= 0;	
4648  0908 725f5202      	clr	20994
4649                     ; 671 }
4652  090c 81            	ret
4695                     ; 674 char spi(char in){
4696                     	switch	.text
4697  090d               _spi:
4699  090d 88            	push	a
4700  090e 88            	push	a
4701       00000001      OFST:	set	1
4704  090f               L7032:
4705                     ; 676 	while(!((SPI->SR)&SPI_SR_TXE));
4707  090f c65203        	ld	a,20995
4708  0912 a502          	bcp	a,#2
4709  0914 27f9          	jreq	L7032
4710                     ; 677 	SPI->DR=in;
4712  0916 7b02          	ld	a,(OFST+1,sp)
4713  0918 c75204        	ld	20996,a
4715  091b               L7132:
4716                     ; 678 	while(!((SPI->SR)&SPI_SR_RXNE));
4718  091b c65203        	ld	a,20995
4719  091e a501          	bcp	a,#1
4720  0920 27f9          	jreq	L7132
4721                     ; 679 	c=SPI->DR;	
4723  0922 c65204        	ld	a,20996
4724  0925 6b01          	ld	(OFST+0,sp),a
4725                     ; 680 	return c;
4727  0927 7b01          	ld	a,(OFST+0,sp)
4730  0929 85            	popw	x
4731  092a 81            	ret
4796                     ; 684 long ST_RDID_read(void)
4796                     ; 685 {
4797                     	switch	.text
4798  092b               _ST_RDID_read:
4800  092b 5204          	subw	sp,#4
4801       00000004      OFST:	set	4
4804                     ; 688 d0=0;
4806  092d 0f04          	clr	(OFST+0,sp)
4807                     ; 689 d1=0;
4809                     ; 690 d2=0;
4811                     ; 691 d3=0;
4813                     ; 693 ST_CS_ON
4815  092f 721b5005      	bres	20485,#5
4816                     ; 694 spi(0x9f);
4818  0933 a69f          	ld	a,#159
4819  0935 add6          	call	_spi
4821                     ; 695 mdr0=spi(0xff);
4823  0937 a6ff          	ld	a,#255
4824  0939 add2          	call	_spi
4826  093b b716          	ld	_mdr0,a
4827                     ; 696 mdr1=spi(0xff);
4829  093d a6ff          	ld	a,#255
4830  093f adcc          	call	_spi
4832  0941 b715          	ld	_mdr1,a
4833                     ; 697 mdr2=spi(0xff);
4835  0943 a6ff          	ld	a,#255
4836  0945 adc6          	call	_spi
4838  0947 b714          	ld	_mdr2,a
4839                     ; 700 ST_CS_OFF
4841  0949 721a5005      	bset	20485,#5
4842                     ; 701 return  *((long*)&d0);
4844  094d 96            	ldw	x,sp
4845  094e 1c0004        	addw	x,#OFST+0
4846  0951 cd0000        	call	c_ltor
4850  0954 5b04          	addw	sp,#4
4851  0956 81            	ret
4886                     ; 705 char ST_status_read(void)
4886                     ; 706 {
4887                     	switch	.text
4888  0957               _ST_status_read:
4890  0957 88            	push	a
4891       00000001      OFST:	set	1
4894                     ; 710 ST_CS_ON
4896  0958 721b5005      	bres	20485,#5
4897                     ; 711 spi(0x05);
4899  095c a605          	ld	a,#5
4900  095e adad          	call	_spi
4902                     ; 712 d0=spi(0xff);
4904  0960 a6ff          	ld	a,#255
4905  0962 ada9          	call	_spi
4907  0964 6b01          	ld	(OFST+0,sp),a
4908                     ; 714 ST_CS_OFF
4910  0966 721a5005      	bset	20485,#5
4911                     ; 715 return d0;
4913  096a 7b01          	ld	a,(OFST+0,sp)
4916  096c 5b01          	addw	sp,#1
4917  096e 81            	ret
4941                     ; 719 void ST_bulk_erase(void)
4941                     ; 720 {
4942                     	switch	.text
4943  096f               _ST_bulk_erase:
4947                     ; 721 ST_CS_ON
4949  096f 721b5005      	bres	20485,#5
4950                     ; 722 spi(0xC7);
4952  0973 a6c7          	ld	a,#199
4953  0975 ad96          	call	_spi
4955                     ; 725 ST_CS_OFF
4957  0977 721a5005      	bset	20485,#5
4958                     ; 726 }
4961  097b 81            	ret
4985                     ; 728 void ST_WREN(void)
4985                     ; 729 {
4986                     	switch	.text
4987  097c               _ST_WREN:
4991                     ; 731 ST_CS_ON
4993  097c 721b5005      	bres	20485,#5
4994                     ; 732 spi(0x06);
4996  0980 a606          	ld	a,#6
4997  0982 ad89          	call	_spi
4999                     ; 734 ST_CS_OFF
5001  0984 721a5005      	bset	20485,#5
5002                     ; 735 }  
5005  0988 81            	ret
5095                     ; 738 void ST_WRITE(unsigned long memo_addr,unsigned short len, char* adr)
5095                     ; 739 {
5096                     	switch	.text
5097  0989               _ST_WRITE:
5099  0989 5205          	subw	sp,#5
5100       00000005      OFST:	set	5
5103                     ; 743 adr2=(char)(memo_addr>>16);
5105  098b 7b09          	ld	a,(OFST+4,sp)
5106  098d 6b03          	ld	(OFST-2,sp),a
5107                     ; 744 adr1=(char)((memo_addr>>8)&0x00ff);
5109  098f 7b0a          	ld	a,(OFST+5,sp)
5110  0991 a4ff          	and	a,#255
5111  0993 6b02          	ld	(OFST-3,sp),a
5112                     ; 745 adr0=(char)((memo_addr)&0x00ff);
5114  0995 7b0b          	ld	a,(OFST+6,sp)
5115  0997 a4ff          	and	a,#255
5116  0999 6b01          	ld	(OFST-4,sp),a
5117                     ; 746 ST_CS_ON
5119  099b 721b5005      	bres	20485,#5
5120                     ; 748 spi(0x02);
5122  099f a602          	ld	a,#2
5123  09a1 cd090d        	call	_spi
5125                     ; 749 spi(adr2);
5127  09a4 7b03          	ld	a,(OFST-2,sp)
5128  09a6 cd090d        	call	_spi
5130                     ; 750 spi(adr1);
5132  09a9 7b02          	ld	a,(OFST-3,sp)
5133  09ab cd090d        	call	_spi
5135                     ; 751 spi(adr0);
5137  09ae 7b01          	ld	a,(OFST-4,sp)
5138  09b0 cd090d        	call	_spi
5140                     ; 753 for(i=0;i<len;i++)
5142  09b3 5f            	clrw	x
5143  09b4 1f04          	ldw	(OFST-1,sp),x
5145  09b6 2010          	jra	L5642
5146  09b8               L1642:
5147                     ; 755 	spi(adr[i]);
5149  09b8 1e0e          	ldw	x,(OFST+9,sp)
5150  09ba 72fb04        	addw	x,(OFST-1,sp)
5151  09bd f6            	ld	a,(x)
5152  09be cd090d        	call	_spi
5154                     ; 753 for(i=0;i<len;i++)
5156  09c1 1e04          	ldw	x,(OFST-1,sp)
5157  09c3 1c0001        	addw	x,#1
5158  09c6 1f04          	ldw	(OFST-1,sp),x
5159  09c8               L5642:
5162  09c8 1e04          	ldw	x,(OFST-1,sp)
5163  09ca 130c          	cpw	x,(OFST+7,sp)
5164  09cc 25ea          	jrult	L1642
5165                     ; 758 ST_CS_OFF
5167  09ce 721a5005      	bset	20485,#5
5168                     ; 759 }
5171  09d2 5b05          	addw	sp,#5
5172  09d4 81            	ret
5262                     ; 762 void ST_READ(unsigned long memo_addr,unsigned short len, char* adr)
5262                     ; 763 {
5263                     	switch	.text
5264  09d5               _ST_READ:
5266  09d5 5205          	subw	sp,#5
5267       00000005      OFST:	set	5
5270                     ; 769 adr2=(char)(memo_addr>>16);
5272  09d7 7b09          	ld	a,(OFST+4,sp)
5273  09d9 6b03          	ld	(OFST-2,sp),a
5274                     ; 770 adr1=(char)((memo_addr>>8)&0x00ff);
5276  09db 7b0a          	ld	a,(OFST+5,sp)
5277  09dd a4ff          	and	a,#255
5278  09df 6b02          	ld	(OFST-3,sp),a
5279                     ; 771 adr0=(char)((memo_addr)&0x00ff);
5281  09e1 7b0b          	ld	a,(OFST+6,sp)
5282  09e3 a4ff          	and	a,#255
5283  09e5 6b01          	ld	(OFST-4,sp),a
5284                     ; 772 ST_CS_ON
5286  09e7 721b5005      	bres	20485,#5
5287                     ; 773 spi(0x03);
5289  09eb a603          	ld	a,#3
5290  09ed cd090d        	call	_spi
5292                     ; 774 spi(adr2);
5294  09f0 7b03          	ld	a,(OFST-2,sp)
5295  09f2 cd090d        	call	_spi
5297                     ; 775 spi(adr1);
5299  09f5 7b02          	ld	a,(OFST-3,sp)
5300  09f7 cd090d        	call	_spi
5302                     ; 776 spi(adr0);
5304  09fa 7b01          	ld	a,(OFST-4,sp)
5305  09fc cd090d        	call	_spi
5307                     ; 778 for(i=0;i<len;i++)
5309  09ff 5f            	clrw	x
5310  0a00 1f04          	ldw	(OFST-1,sp),x
5312  0a02 2012          	jra	L3452
5313  0a04               L7352:
5314                     ; 780 	adr[i]=spi(0xff);
5316  0a04 a6ff          	ld	a,#255
5317  0a06 cd090d        	call	_spi
5319  0a09 1e0e          	ldw	x,(OFST+9,sp)
5320  0a0b 72fb04        	addw	x,(OFST-1,sp)
5321  0a0e f7            	ld	(x),a
5322                     ; 778 for(i=0;i<len;i++)
5324  0a0f 1e04          	ldw	x,(OFST-1,sp)
5325  0a11 1c0001        	addw	x,#1
5326  0a14 1f04          	ldw	(OFST-1,sp),x
5327  0a16               L3452:
5330  0a16 1e04          	ldw	x,(OFST-1,sp)
5331  0a18 130c          	cpw	x,(OFST+7,sp)
5332  0a1a 25e8          	jrult	L7352
5333                     ; 783 ST_CS_OFF
5335  0a1c 721a5005      	bset	20485,#5
5336                     ; 784 }
5339  0a20 5b05          	addw	sp,#5
5340  0a22 81            	ret
5406                     ; 788 long DF_mf_dev_read(void)
5406                     ; 789 {
5407                     	switch	.text
5408  0a23               _DF_mf_dev_read:
5410  0a23 5204          	subw	sp,#4
5411       00000004      OFST:	set	4
5414                     ; 792 d0=0;
5416  0a25 0f04          	clr	(OFST+0,sp)
5417                     ; 793 d1=0;
5419                     ; 794 d2=0;
5421                     ; 795 d3=0;
5423                     ; 797 CS_ON
5425  0a27 7217500a      	bres	20490,#3
5426                     ; 798 spi(0x9f);
5428  0a2b a69f          	ld	a,#159
5429  0a2d cd090d        	call	_spi
5431                     ; 799 mdr0=spi(0xff);
5433  0a30 a6ff          	ld	a,#255
5434  0a32 cd090d        	call	_spi
5436  0a35 b716          	ld	_mdr0,a
5437                     ; 800 mdr1=spi(0xff);
5439  0a37 a6ff          	ld	a,#255
5440  0a39 cd090d        	call	_spi
5442  0a3c b715          	ld	_mdr1,a
5443                     ; 801 mdr2=spi(0xff);
5445  0a3e a6ff          	ld	a,#255
5446  0a40 cd090d        	call	_spi
5448  0a43 b714          	ld	_mdr2,a
5449                     ; 802 mdr3=spi(0xff);  
5451  0a45 a6ff          	ld	a,#255
5452  0a47 cd090d        	call	_spi
5454  0a4a b713          	ld	_mdr3,a
5455                     ; 804 CS_OFF
5457  0a4c 7216500a      	bset	20490,#3
5458                     ; 805 return  *((long*)&d0);
5460  0a50 96            	ldw	x,sp
5461  0a51 1c0004        	addw	x,#OFST+0
5462  0a54 cd0000        	call	c_ltor
5466  0a57 5b04          	addw	sp,#4
5467  0a59 81            	ret
5491                     ; 809 void DF_memo_to_256(void)
5491                     ; 810 {
5492                     	switch	.text
5493  0a5a               _DF_memo_to_256:
5497                     ; 812 CS_ON
5499  0a5a 7217500a      	bres	20490,#3
5500                     ; 813 spi(0x3d);
5502  0a5e a63d          	ld	a,#61
5503  0a60 cd090d        	call	_spi
5505                     ; 814 spi(0x2a); 
5507  0a63 a62a          	ld	a,#42
5508  0a65 cd090d        	call	_spi
5510                     ; 815 spi(0x80);
5512  0a68 a680          	ld	a,#128
5513  0a6a cd090d        	call	_spi
5515                     ; 816 spi(0xa6);
5517  0a6d a6a6          	ld	a,#166
5518  0a6f cd090d        	call	_spi
5520                     ; 818 CS_OFF
5522  0a72 7216500a      	bset	20490,#3
5523                     ; 819 }  
5526  0a76 81            	ret
5561                     ; 824 char DF_status_read(void)
5561                     ; 825 {
5562                     	switch	.text
5563  0a77               _DF_status_read:
5565  0a77 88            	push	a
5566       00000001      OFST:	set	1
5569                     ; 829 CS_ON
5571  0a78 7217500a      	bres	20490,#3
5572                     ; 830 spi(0xd7);
5574  0a7c a6d7          	ld	a,#215
5575  0a7e cd090d        	call	_spi
5577                     ; 831 d0=spi(0xff);
5579  0a81 a6ff          	ld	a,#255
5580  0a83 cd090d        	call	_spi
5582  0a86 6b01          	ld	(OFST+0,sp),a
5583                     ; 833 CS_OFF
5585  0a88 7216500a      	bset	20490,#3
5586                     ; 834 return d0;
5588  0a8c 7b01          	ld	a,(OFST+0,sp)
5591  0a8e 5b01          	addw	sp,#1
5592  0a90 81            	ret
5636                     ; 838 void DF_page_to_buffer(unsigned page_addr)
5636                     ; 839 {
5637                     	switch	.text
5638  0a91               _DF_page_to_buffer:
5640  0a91 89            	pushw	x
5641  0a92 88            	push	a
5642       00000001      OFST:	set	1
5645                     ; 842 d0=0x53; 
5647                     ; 846 CS_ON
5649  0a93 7217500a      	bres	20490,#3
5650                     ; 847 spi(d0);
5652  0a97 a653          	ld	a,#83
5653  0a99 cd090d        	call	_spi
5655                     ; 848 spi(page_addr/256/**(((char*)&page_addr)+1)*/);
5657  0a9c 7b02          	ld	a,(OFST+1,sp)
5658  0a9e cd090d        	call	_spi
5660                     ; 849 spi(page_addr%256/**((char*)&page_addr)*/);
5662  0aa1 7b03          	ld	a,(OFST+2,sp)
5663  0aa3 a4ff          	and	a,#255
5664  0aa5 cd090d        	call	_spi
5666                     ; 850 spi(0xff);
5668  0aa8 a6ff          	ld	a,#255
5669  0aaa cd090d        	call	_spi
5671                     ; 852 CS_OFF
5673  0aad 7216500a      	bset	20490,#3
5674                     ; 853 }
5677  0ab1 5b03          	addw	sp,#3
5678  0ab3 81            	ret
5723                     ; 856 void DF_buffer_to_page_er(/*char buff,*/unsigned page_addr)
5723                     ; 857 {
5724                     	switch	.text
5725  0ab4               _DF_buffer_to_page_er:
5727  0ab4 89            	pushw	x
5728  0ab5 88            	push	a
5729       00000001      OFST:	set	1
5732                     ; 860 d0=0x83; 
5734                     ; 863 CS_ON
5736  0ab6 7217500a      	bres	20490,#3
5737                     ; 864 spi(d0);
5739  0aba a683          	ld	a,#131
5740  0abc cd090d        	call	_spi
5742                     ; 865 spi(page_addr/256/**(((char*)&page_addr)+1)*/);
5744  0abf 7b02          	ld	a,(OFST+1,sp)
5745  0ac1 cd090d        	call	_spi
5747                     ; 866 spi(page_addr%256/**((char*)&page_addr)*/);
5749  0ac4 7b03          	ld	a,(OFST+2,sp)
5750  0ac6 a4ff          	and	a,#255
5751  0ac8 cd090d        	call	_spi
5753                     ; 867 spi(0xff);
5755  0acb a6ff          	ld	a,#255
5756  0acd cd090d        	call	_spi
5758                     ; 869 CS_OFF
5760  0ad0 7216500a      	bset	20490,#3
5761                     ; 870 }
5764  0ad4 5b03          	addw	sp,#3
5765  0ad6 81            	ret
5837                     ; 873 void DF_buffer_read(unsigned buff_addr,unsigned len, char* adr)
5837                     ; 874 {
5838                     	switch	.text
5839  0ad7               _DF_buffer_read:
5841  0ad7 89            	pushw	x
5842  0ad8 5203          	subw	sp,#3
5843       00000003      OFST:	set	3
5846                     ; 878 d0=0x54; 
5848                     ; 880 CS_ON
5850  0ada 7217500a      	bres	20490,#3
5851                     ; 881 spi(d0);
5853  0ade a654          	ld	a,#84
5854  0ae0 cd090d        	call	_spi
5856                     ; 882 spi(0xff);
5858  0ae3 a6ff          	ld	a,#255
5859  0ae5 cd090d        	call	_spi
5861                     ; 883 spi(buff_addr/256/**(((char*)&buff_addr)+1)*/);
5863  0ae8 7b04          	ld	a,(OFST+1,sp)
5864  0aea cd090d        	call	_spi
5866                     ; 884 spi(buff_addr%256/**((char*)&buff_addr)*/);
5868  0aed 7b05          	ld	a,(OFST+2,sp)
5869  0aef a4ff          	and	a,#255
5870  0af1 cd090d        	call	_spi
5872                     ; 885 spi(0xff);
5874  0af4 a6ff          	ld	a,#255
5875  0af6 cd090d        	call	_spi
5877                     ; 886 for(i=0;i<len;i++)
5879  0af9 5f            	clrw	x
5880  0afa 1f02          	ldw	(OFST-1,sp),x
5882  0afc 2012          	jra	L5372
5883  0afe               L1372:
5884                     ; 888 	adr[i]=spi(0xff);
5886  0afe a6ff          	ld	a,#255
5887  0b00 cd090d        	call	_spi
5889  0b03 1e0a          	ldw	x,(OFST+7,sp)
5890  0b05 72fb02        	addw	x,(OFST-1,sp)
5891  0b08 f7            	ld	(x),a
5892                     ; 886 for(i=0;i<len;i++)
5894  0b09 1e02          	ldw	x,(OFST-1,sp)
5895  0b0b 1c0001        	addw	x,#1
5896  0b0e 1f02          	ldw	(OFST-1,sp),x
5897  0b10               L5372:
5900  0b10 1e02          	ldw	x,(OFST-1,sp)
5901  0b12 1308          	cpw	x,(OFST+5,sp)
5902  0b14 25e8          	jrult	L1372
5903                     ; 891 CS_OFF
5905  0b16 7216500a      	bset	20490,#3
5906                     ; 892 }
5909  0b1a 5b05          	addw	sp,#5
5910  0b1c 81            	ret
5982                     ; 895 void DF_buffer_write(/*char buff,*/unsigned buff_addr,unsigned len, char* adr)
5982                     ; 896 {
5983                     	switch	.text
5984  0b1d               _DF_buffer_write:
5986  0b1d 89            	pushw	x
5987  0b1e 5203          	subw	sp,#3
5988       00000003      OFST:	set	3
5991                     ; 900 d0=0x84; 
5993                     ; 902 CS_ON
5995  0b20 7217500a      	bres	20490,#3
5996                     ; 903 spi(d0);
5998  0b24 a684          	ld	a,#132
5999  0b26 cd090d        	call	_spi
6001                     ; 904 spi(0xff);
6003  0b29 a6ff          	ld	a,#255
6004  0b2b cd090d        	call	_spi
6006                     ; 905 spi(buff_addr/256/**(((char*)&buff_addr)+1)*/);
6008  0b2e 7b04          	ld	a,(OFST+1,sp)
6009  0b30 cd090d        	call	_spi
6011                     ; 906 spi(buff_addr%256/**((char*)&buff_addr)*/);
6013  0b33 7b05          	ld	a,(OFST+2,sp)
6014  0b35 a4ff          	and	a,#255
6015  0b37 cd090d        	call	_spi
6017                     ; 908 for(i=0;i<len;i++)
6019  0b3a 5f            	clrw	x
6020  0b3b 1f02          	ldw	(OFST-1,sp),x
6022  0b3d 2010          	jra	L3003
6023  0b3f               L7772:
6024                     ; 910 	spi(adr[i]);
6026  0b3f 1e0a          	ldw	x,(OFST+7,sp)
6027  0b41 72fb02        	addw	x,(OFST-1,sp)
6028  0b44 f6            	ld	a,(x)
6029  0b45 cd090d        	call	_spi
6031                     ; 908 for(i=0;i<len;i++)
6033  0b48 1e02          	ldw	x,(OFST-1,sp)
6034  0b4a 1c0001        	addw	x,#1
6035  0b4d 1f02          	ldw	(OFST-1,sp),x
6036  0b4f               L3003:
6039  0b4f 1e02          	ldw	x,(OFST-1,sp)
6040  0b51 1308          	cpw	x,(OFST+5,sp)
6041  0b53 25ea          	jrult	L7772
6042                     ; 913 CS_OFF
6044  0b55 7216500a      	bset	20490,#3
6045                     ; 914 }
6048  0b59 5b05          	addw	sp,#5
6049  0b5b 81            	ret
6072                     ; 936 void gpio_init(void){
6073                     	switch	.text
6074  0b5c               _gpio_init:
6078                     ; 946 	GPIOD->DDR|=(1<<2);
6080  0b5c 72145011      	bset	20497,#2
6081                     ; 947 	GPIOD->CR1|=(1<<2);
6083  0b60 72145012      	bset	20498,#2
6084                     ; 948 	GPIOD->CR2|=(1<<2);
6086  0b64 72145013      	bset	20499,#2
6087                     ; 949 	GPIOD->ODR&=~(1<<2);
6089  0b68 7215500f      	bres	20495,#2
6090                     ; 951 	GPIOD->DDR|=(1<<4);
6092  0b6c 72185011      	bset	20497,#4
6093                     ; 952 	GPIOD->CR1|=(1<<4);
6095  0b70 72185012      	bset	20498,#4
6096                     ; 953 	GPIOD->CR2&=~(1<<4);
6098  0b74 72195013      	bres	20499,#4
6099                     ; 955 	GPIOC->DDR&=~(1<<4);
6101  0b78 7219500c      	bres	20492,#4
6102                     ; 956 	GPIOC->CR1&=~(1<<4);
6104  0b7c 7219500d      	bres	20493,#4
6105                     ; 957 	GPIOC->CR2&=~(1<<4);
6107  0b80 7219500e      	bres	20494,#4
6108                     ; 961 }
6111  0b84 81            	ret
6163                     ; 964 void uart_in(void)
6163                     ; 965 {
6164                     	switch	.text
6165  0b85               _uart_in:
6167  0b85 89            	pushw	x
6168       00000002      OFST:	set	2
6171                     ; 969 if(rx_buffer_overflow)
6173                     	btst	_rx_buffer_overflow
6174  0b8b 240d          	jruge	L1403
6175                     ; 971 	rx_wr_index=0;
6177  0b8d 5f            	clrw	x
6178  0b8e bf1a          	ldw	_rx_wr_index,x
6179                     ; 972 	rx_rd_index=0;
6181  0b90 5f            	clrw	x
6182  0b91 bf18          	ldw	_rx_rd_index,x
6183                     ; 973 	rx_counter=0;
6185  0b93 5f            	clrw	x
6186  0b94 bf1c          	ldw	_rx_counter,x
6187                     ; 974 	rx_buffer_overflow=0;
6189  0b96 72110001      	bres	_rx_buffer_overflow
6190  0b9a               L1403:
6191                     ; 977 if(rx_counter&&(rx_buffer[index_offset(rx_wr_index,-1)])==END)
6193  0b9a be1c          	ldw	x,_rx_counter
6194  0b9c 2775          	jreq	L3403
6196  0b9e aeffff        	ldw	x,#65535
6197  0ba1 89            	pushw	x
6198  0ba2 be1a          	ldw	x,_rx_wr_index
6199  0ba4 ad6f          	call	_index_offset
6201  0ba6 5b02          	addw	sp,#2
6202  0ba8 e654          	ld	a,(_rx_buffer,x)
6203  0baa a10a          	cp	a,#10
6204  0bac 2665          	jrne	L3403
6205                     ; 982 	temp=rx_buffer[index_offset(rx_wr_index,-3)];
6207  0bae aefffd        	ldw	x,#65533
6208  0bb1 89            	pushw	x
6209  0bb2 be1a          	ldw	x,_rx_wr_index
6210  0bb4 ad5f          	call	_index_offset
6212  0bb6 5b02          	addw	sp,#2
6213  0bb8 e654          	ld	a,(_rx_buffer,x)
6214  0bba 6b01          	ld	(OFST-1,sp),a
6215                     ; 983     	if(temp<100) 
6217  0bbc 7b01          	ld	a,(OFST-1,sp)
6218  0bbe a164          	cp	a,#100
6219  0bc0 2451          	jruge	L3403
6220                     ; 986     		if(control_check(index_offset(rx_wr_index,-1)))
6222  0bc2 aeffff        	ldw	x,#65535
6223  0bc5 89            	pushw	x
6224  0bc6 be1a          	ldw	x,_rx_wr_index
6225  0bc8 ad4b          	call	_index_offset
6227  0bca 5b02          	addw	sp,#2
6228  0bcc 9f            	ld	a,xl
6229  0bcd ad6e          	call	_control_check
6231  0bcf 4d            	tnz	a
6232  0bd0 2741          	jreq	L3403
6233                     ; 989     			rx_rd_index=index_offset(rx_wr_index,-3-temp);
6235  0bd2 a6ff          	ld	a,#255
6236  0bd4 97            	ld	xl,a
6237  0bd5 a6fd          	ld	a,#253
6238  0bd7 1001          	sub	a,(OFST-1,sp)
6239  0bd9 2401          	jrnc	L631
6240  0bdb 5a            	decw	x
6241  0bdc               L631:
6242  0bdc 02            	rlwa	x,a
6243  0bdd 89            	pushw	x
6244  0bde 01            	rrwa	x,a
6245  0bdf be1a          	ldw	x,_rx_wr_index
6246  0be1 ad32          	call	_index_offset
6248  0be3 5b02          	addw	sp,#2
6249  0be5 bf18          	ldw	_rx_rd_index,x
6250                     ; 990     			for(i=0;i<temp;i++)
6252  0be7 0f02          	clr	(OFST+0,sp)
6254  0be9 2018          	jra	L5503
6255  0beb               L1503:
6256                     ; 992 				UIB[i]=rx_buffer[index_offset(rx_rd_index,i)];
6258  0beb 7b02          	ld	a,(OFST+0,sp)
6259  0bed 5f            	clrw	x
6260  0bee 97            	ld	xl,a
6261  0bef 89            	pushw	x
6262  0bf0 7b04          	ld	a,(OFST+2,sp)
6263  0bf2 5f            	clrw	x
6264  0bf3 97            	ld	xl,a
6265  0bf4 89            	pushw	x
6266  0bf5 be18          	ldw	x,_rx_rd_index
6267  0bf7 ad1c          	call	_index_offset
6269  0bf9 5b02          	addw	sp,#2
6270  0bfb e654          	ld	a,(_rx_buffer,x)
6271  0bfd 85            	popw	x
6272  0bfe d70000        	ld	(_UIB,x),a
6273                     ; 990     			for(i=0;i<temp;i++)
6275  0c01 0c02          	inc	(OFST+0,sp)
6276  0c03               L5503:
6279  0c03 7b02          	ld	a,(OFST+0,sp)
6280  0c05 1101          	cp	a,(OFST-1,sp)
6281  0c07 25e2          	jrult	L1503
6282                     ; 994 			rx_rd_index=rx_wr_index;
6284  0c09 be1a          	ldw	x,_rx_wr_index
6285  0c0b bf18          	ldw	_rx_rd_index,x
6286                     ; 995 			rx_counter=0;
6288  0c0d 5f            	clrw	x
6289  0c0e bf1c          	ldw	_rx_counter,x
6290                     ; 996 			uart_in_an();
6292  0c10 cd0238        	call	_uart_in_an
6294  0c13               L3403:
6295                     ; 1004 }
6298  0c13 85            	popw	x
6299  0c14 81            	ret
6342                     ; 1007 signed short index_offset (signed short index,signed short offset)
6342                     ; 1008 {
6343                     	switch	.text
6344  0c15               _index_offset:
6346  0c15 89            	pushw	x
6347       00000000      OFST:	set	0
6350                     ; 1009 index=index+offset;
6352  0c16 1e01          	ldw	x,(OFST+1,sp)
6353  0c18 72fb05        	addw	x,(OFST+5,sp)
6354  0c1b 1f01          	ldw	(OFST+1,sp),x
6355                     ; 1010 if(index>=RX_BUFFER_SIZE) index-=RX_BUFFER_SIZE; 
6357  0c1d 9c            	rvf
6358  0c1e 1e01          	ldw	x,(OFST+1,sp)
6359  0c20 a30064        	cpw	x,#100
6360  0c23 2f07          	jrslt	L3013
6363  0c25 1e01          	ldw	x,(OFST+1,sp)
6364  0c27 1d0064        	subw	x,#100
6365  0c2a 1f01          	ldw	(OFST+1,sp),x
6366  0c2c               L3013:
6367                     ; 1011 if(index<0) index+=RX_BUFFER_SIZE;
6369  0c2c 9c            	rvf
6370  0c2d 1e01          	ldw	x,(OFST+1,sp)
6371  0c2f 2e07          	jrsge	L5013
6374  0c31 1e01          	ldw	x,(OFST+1,sp)
6375  0c33 1c0064        	addw	x,#100
6376  0c36 1f01          	ldw	(OFST+1,sp),x
6377  0c38               L5013:
6378                     ; 1012 return index;
6380  0c38 1e01          	ldw	x,(OFST+1,sp)
6383  0c3a 5b02          	addw	sp,#2
6384  0c3c 81            	ret
6447                     ; 1016 char control_check(char index)
6447                     ; 1017 {
6448                     	switch	.text
6449  0c3d               _control_check:
6451  0c3d 88            	push	a
6452  0c3e 5203          	subw	sp,#3
6453       00000003      OFST:	set	3
6456                     ; 1018 char i=0,ii=0,iii;
6460                     ; 1020 if(rx_buffer[index]!=END) return 0;
6462  0c40 5f            	clrw	x
6463  0c41 97            	ld	xl,a
6464  0c42 e654          	ld	a,(_rx_buffer,x)
6465  0c44 a10a          	cp	a,#10
6466  0c46 2703          	jreq	L1413
6469  0c48 4f            	clr	a
6471  0c49 2051          	jra	L051
6472  0c4b               L1413:
6473                     ; 1022 ii=rx_buffer[index_offset(index,-2)];
6475  0c4b aefffe        	ldw	x,#65534
6476  0c4e 89            	pushw	x
6477  0c4f 7b06          	ld	a,(OFST+3,sp)
6478  0c51 5f            	clrw	x
6479  0c52 97            	ld	xl,a
6480  0c53 adc0          	call	_index_offset
6482  0c55 5b02          	addw	sp,#2
6483  0c57 e654          	ld	a,(_rx_buffer,x)
6484  0c59 6b02          	ld	(OFST-1,sp),a
6485                     ; 1023 iii=0;
6487  0c5b 0f01          	clr	(OFST-2,sp)
6488                     ; 1024 for(i=0;i<=ii;i++)
6490  0c5d 0f03          	clr	(OFST+0,sp)
6492  0c5f 2022          	jra	L7413
6493  0c61               L3413:
6494                     ; 1026 	iii^=rx_buffer[index_offset(index,-2-ii+i)];
6496  0c61 a6ff          	ld	a,#255
6497  0c63 97            	ld	xl,a
6498  0c64 a6fe          	ld	a,#254
6499  0c66 1002          	sub	a,(OFST-1,sp)
6500  0c68 2401          	jrnc	L441
6501  0c6a 5a            	decw	x
6502  0c6b               L441:
6503  0c6b 1b03          	add	a,(OFST+0,sp)
6504  0c6d 2401          	jrnc	L641
6505  0c6f 5c            	incw	x
6506  0c70               L641:
6507  0c70 02            	rlwa	x,a
6508  0c71 89            	pushw	x
6509  0c72 01            	rrwa	x,a
6510  0c73 7b06          	ld	a,(OFST+3,sp)
6511  0c75 5f            	clrw	x
6512  0c76 97            	ld	xl,a
6513  0c77 ad9c          	call	_index_offset
6515  0c79 5b02          	addw	sp,#2
6516  0c7b 7b01          	ld	a,(OFST-2,sp)
6517  0c7d e854          	xor	a,	(_rx_buffer,x)
6518  0c7f 6b01          	ld	(OFST-2,sp),a
6519                     ; 1024 for(i=0;i<=ii;i++)
6521  0c81 0c03          	inc	(OFST+0,sp)
6522  0c83               L7413:
6525  0c83 7b03          	ld	a,(OFST+0,sp)
6526  0c85 1102          	cp	a,(OFST-1,sp)
6527  0c87 23d8          	jrule	L3413
6528                     ; 1028 if (iii!=rx_buffer[index_offset(index,-1)]) return 0;	
6530  0c89 aeffff        	ldw	x,#65535
6531  0c8c 89            	pushw	x
6532  0c8d 7b06          	ld	a,(OFST+3,sp)
6533  0c8f 5f            	clrw	x
6534  0c90 97            	ld	xl,a
6535  0c91 ad82          	call	_index_offset
6537  0c93 5b02          	addw	sp,#2
6538  0c95 e654          	ld	a,(_rx_buffer,x)
6539  0c97 1101          	cp	a,(OFST-2,sp)
6540  0c99 2704          	jreq	L3513
6543  0c9b 4f            	clr	a
6545  0c9c               L051:
6547  0c9c 5b04          	addw	sp,#4
6548  0c9e 81            	ret
6549  0c9f               L3513:
6550                     ; 1030 return 1;
6552  0c9f a601          	ld	a,#1
6554  0ca1 20f9          	jra	L051
6596                     ; 1039 @far @interrupt void TIM4_UPD_Interrupt (void) {
6598                     	switch	.text
6599  0ca3               f_TIM4_UPD_Interrupt:
6603                     ; 1041 	if(play) {
6605                     	btst	_play
6606  0ca8 2445          	jruge	L5613
6607                     ; 1042 		TIM2->CCR3H= 0x00;	
6609  0caa 725f5315      	clr	21269
6610                     ; 1043 		TIM2->CCR3L= sample;
6612  0cae 5500175316    	mov	21270,_sample
6613                     ; 1044 		sample_cnt++;
6615  0cb3 be21          	ldw	x,_sample_cnt
6616  0cb5 1c0001        	addw	x,#1
6617  0cb8 bf21          	ldw	_sample_cnt,x
6618                     ; 1045 		if(sample_cnt>=256) {
6620  0cba 9c            	rvf
6621  0cbb be21          	ldw	x,_sample_cnt
6622  0cbd a30100        	cpw	x,#256
6623  0cc0 2f03          	jrslt	L7613
6624                     ; 1046 			sample_cnt=0;
6626  0cc2 5f            	clrw	x
6627  0cc3 bf21          	ldw	_sample_cnt,x
6628  0cc5               L7613:
6629                     ; 1050 		sample=buff[sample_cnt];
6631  0cc5 be21          	ldw	x,_sample_cnt
6632  0cc7 d60050        	ld	a,(_buff,x)
6633  0cca b717          	ld	_sample,a
6634                     ; 1052 		if(sample_cnt==132)	{
6636  0ccc be21          	ldw	x,_sample_cnt
6637  0cce a30084        	cpw	x,#132
6638  0cd1 2604          	jrne	L1713
6639                     ; 1053 			bBUFF_LOAD=1;
6641  0cd3 7210000b      	bset	_bBUFF_LOAD
6642  0cd7               L1713:
6643                     ; 1057 		if(sample_cnt==5) {
6645  0cd7 be21          	ldw	x,_sample_cnt
6646  0cd9 a30005        	cpw	x,#5
6647  0cdc 2604          	jrne	L3713
6648                     ; 1058 			bBUFF_READ_H=1;
6650  0cde 7210000a      	bset	_bBUFF_READ_H
6651  0ce2               L3713:
6652                     ; 1061 		if(sample_cnt==150) {
6654  0ce2 be21          	ldw	x,_sample_cnt
6655  0ce4 a30096        	cpw	x,#150
6656  0ce7 2615          	jrne	L7713
6657                     ; 1062 			bBUFF_READ_L=1;
6659  0ce9 72100009      	bset	_bBUFF_READ_L
6660  0ced 200f          	jra	L7713
6661  0cef               L5613:
6662                     ; 1069 	else if(!bSTART) {
6664                     	btst	_bSTART
6665  0cf4 2508          	jrult	L7713
6666                     ; 1070 		TIM2->CCR3H= 0x00;	
6668  0cf6 725f5315      	clr	21269
6669                     ; 1071 		TIM2->CCR3L= 0x7f;//pwm_fade_in;
6671  0cfa 357f5316      	mov	21270,#127
6672  0cfe               L7713:
6673                     ; 1126 		if(but_block_cnt)but_on_drv_cnt=0;
6675  0cfe be00          	ldw	x,_but_block_cnt
6676  0d00 2702          	jreq	L3023
6679  0d02 3fb9          	clr	_but_on_drv_cnt
6680  0d04               L3023:
6681                     ; 1127 		if((((GPIOC->IDR)&(1<<4))) && (but_on_drv_cnt<100)) {
6683  0d04 c6500b        	ld	a,20491
6684  0d07 a510          	bcp	a,#16
6685  0d09 271f          	jreq	L5023
6687  0d0b b6b9          	ld	a,_but_on_drv_cnt
6688  0d0d a164          	cp	a,#100
6689  0d0f 2419          	jruge	L5023
6690                     ; 1128 			but_on_drv_cnt++;
6692  0d11 3cb9          	inc	_but_on_drv_cnt
6693                     ; 1129 			if((but_on_drv_cnt>2)&&(bRELEASE))
6695  0d13 b6b9          	ld	a,_but_on_drv_cnt
6696  0d15 a103          	cp	a,#3
6697  0d17 2517          	jrult	L1123
6699                     	btst	_bRELEASE
6700  0d1e 2410          	jruge	L1123
6701                     ; 1131 				bRELEASE=0;
6703  0d20 72110000      	bres	_bRELEASE
6704                     ; 1132 				bSTART=1;
6706  0d24 7210000c      	bset	_bSTART
6707  0d28 2006          	jra	L1123
6708  0d2a               L5023:
6709                     ; 1136 			but_on_drv_cnt=0;
6711  0d2a 3fb9          	clr	_but_on_drv_cnt
6712                     ; 1137 			bRELEASE=1;
6714  0d2c 72100000      	bset	_bRELEASE
6715  0d30               L1123:
6716                     ; 1142 	if(++t0_cnt0>=125){
6718  0d30 3c00          	inc	_t0_cnt0
6719  0d32 b600          	ld	a,_t0_cnt0
6720  0d34 a17d          	cp	a,#125
6721  0d36 2530          	jrult	L3123
6722                     ; 1143     		t0_cnt0=0;
6724  0d38 3f00          	clr	_t0_cnt0
6725                     ; 1144     		b100Hz=1;
6727  0d3a 72100008      	bset	_b100Hz
6728                     ; 1154 		if(++t0_cnt1>=10){
6730  0d3e 3c01          	inc	_t0_cnt1
6731  0d40 b601          	ld	a,_t0_cnt1
6732  0d42 a10a          	cp	a,#10
6733  0d44 2506          	jrult	L5123
6734                     ; 1155 			t0_cnt1=0;
6736  0d46 3f01          	clr	_t0_cnt1
6737                     ; 1156 			b10Hz=1;
6739  0d48 72100007      	bset	_b10Hz
6740  0d4c               L5123:
6741                     ; 1159 		if(++t0_cnt2>=20){
6743  0d4c 3c02          	inc	_t0_cnt2
6744  0d4e b602          	ld	a,_t0_cnt2
6745  0d50 a114          	cp	a,#20
6746  0d52 2506          	jrult	L7123
6747                     ; 1160 			t0_cnt2=0;
6749  0d54 3f02          	clr	_t0_cnt2
6750                     ; 1161 			b5Hz=1;
6752  0d56 72100006      	bset	_b5Hz
6753  0d5a               L7123:
6754                     ; 1164 		if(++t0_cnt3>=100){
6756  0d5a 3c03          	inc	_t0_cnt3
6757  0d5c b603          	ld	a,_t0_cnt3
6758  0d5e a164          	cp	a,#100
6759  0d60 2506          	jrult	L3123
6760                     ; 1165 			t0_cnt3=0;
6762  0d62 3f03          	clr	_t0_cnt3
6763                     ; 1166 			b1Hz=1;
6765  0d64 72100005      	bset	_b1Hz
6766  0d68               L3123:
6767                     ; 1170 	TIM4->SR1&=~TIM4_SR1_UIF;			// disable break interrupt
6769  0d68 72115344      	bres	21316,#0
6770                     ; 1171 	return;
6773  0d6c 80            	iret
6799                     ; 1175 @far @interrupt void UARTTxInterrupt (void) {
6800                     	switch	.text
6801  0d6d               f_UARTTxInterrupt:
6805                     ; 1177 	if (tx_counter){
6807  0d6d 3d20          	tnz	_tx_counter
6808  0d6f 271a          	jreq	L3323
6809                     ; 1178 		--tx_counter;
6811  0d71 3a20          	dec	_tx_counter
6812                     ; 1179 		UART1->DR=tx_buffer[tx_rd_index];
6814  0d73 5f            	clrw	x
6815  0d74 b61e          	ld	a,_tx_rd_index
6816  0d76 2a01          	jrpl	L651
6817  0d78 53            	cplw	x
6818  0d79               L651:
6819  0d79 97            	ld	xl,a
6820  0d7a e604          	ld	a,(_tx_buffer,x)
6821  0d7c c75231        	ld	21041,a
6822                     ; 1180 		if (++tx_rd_index == TX_BUFFER_SIZE) tx_rd_index=0;
6824  0d7f 3c1e          	inc	_tx_rd_index
6825  0d81 b61e          	ld	a,_tx_rd_index
6826  0d83 a150          	cp	a,#80
6827  0d85 260c          	jrne	L7323
6830  0d87 3f1e          	clr	_tx_rd_index
6831  0d89 2008          	jra	L7323
6832  0d8b               L3323:
6833                     ; 1183 		bOUT_FREE=1;
6835  0d8b 72100003      	bset	_bOUT_FREE
6836                     ; 1184 		UART1->CR2&= ~UART1_CR2_TIEN;
6838  0d8f 721f5235      	bres	21045,#7
6839  0d93               L7323:
6840                     ; 1186 }
6843  0d93 80            	iret
6872                     ; 1189 @far @interrupt void UARTRxInterrupt (void) {
6873                     	switch	.text
6874  0d94               f_UARTRxInterrupt:
6878                     ; 1194 	rx_status=UART1->SR;
6880  0d94 5552300006    	mov	_rx_status,21040
6881                     ; 1195 	rx_data=UART1->DR;
6883  0d99 5552310005    	mov	_rx_data,21041
6884                     ; 1197 	if (rx_status & (UART1_SR_RXNE)){
6886  0d9e b606          	ld	a,_rx_status
6887  0da0 a520          	bcp	a,#32
6888  0da2 272c          	jreq	L1523
6889                     ; 1198 		rx_buffer[rx_wr_index]=rx_data;
6891  0da4 be1a          	ldw	x,_rx_wr_index
6892  0da6 b605          	ld	a,_rx_data
6893  0da8 e754          	ld	(_rx_buffer,x),a
6894                     ; 1199 		bRXIN=1;
6896  0daa 72100002      	bset	_bRXIN
6897                     ; 1200 		if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
6899  0dae be1a          	ldw	x,_rx_wr_index
6900  0db0 1c0001        	addw	x,#1
6901  0db3 bf1a          	ldw	_rx_wr_index,x
6902  0db5 a30064        	cpw	x,#100
6903  0db8 2603          	jrne	L3523
6906  0dba 5f            	clrw	x
6907  0dbb bf1a          	ldw	_rx_wr_index,x
6908  0dbd               L3523:
6909                     ; 1201 		if (++rx_counter == RX_BUFFER_SIZE){
6911  0dbd be1c          	ldw	x,_rx_counter
6912  0dbf 1c0001        	addw	x,#1
6913  0dc2 bf1c          	ldw	_rx_counter,x
6914  0dc4 a30064        	cpw	x,#100
6915  0dc7 2607          	jrne	L1523
6916                     ; 1202 			rx_counter=0;
6918  0dc9 5f            	clrw	x
6919  0dca bf1c          	ldw	_rx_counter,x
6920                     ; 1203 			rx_buffer_overflow=1;
6922  0dcc 72100001      	bset	_rx_buffer_overflow
6923  0dd0               L1523:
6924                     ; 1206 }
6927  0dd0 80            	iret
6986                     ; 1212 main()
6986                     ; 1213 {
6988                     	switch	.text
6989  0dd1               _main:
6993                     ; 1214 CLK->CKDIVR=0;
6995  0dd1 725f50c6      	clr	20678
6996                     ; 1216 rele_cnt_index=0;
6998  0dd5 3fbb          	clr	_rele_cnt_index
6999                     ; 1218 GPIOD->DDR&=~(1<<6);
7001  0dd7 721d5011      	bres	20497,#6
7002                     ; 1219 GPIOD->CR1|=(1<<6);
7004  0ddb 721c5012      	bset	20498,#6
7005                     ; 1220 GPIOD->CR2|=(1<<6);
7007  0ddf 721c5013      	bset	20499,#6
7008                     ; 1222 GPIOD->DDR|=(1<<5);
7010  0de3 721a5011      	bset	20497,#5
7011                     ; 1223 GPIOD->CR1|=(1<<5);
7013  0de7 721a5012      	bset	20498,#5
7014                     ; 1224 GPIOD->CR2|=(1<<5);	
7016  0deb 721a5013      	bset	20499,#5
7017                     ; 1225 GPIOD->ODR|=(1<<5);
7019  0def 721a500f      	bset	20495,#5
7020                     ; 1227 delay_ms(10);
7022  0df3 ae000a        	ldw	x,#10
7023  0df6 cd005c        	call	_delay_ms
7025                     ; 1229 if(!(GPIOD->IDR&=(1<<6))) 
7027  0df9 c65010        	ld	a,20496
7028  0dfc a440          	and	a,#64
7029  0dfe c75010        	ld	20496,a
7030  0e01 2606          	jrne	L7623
7031                     ; 1231 	rele_cnt_index=1;
7033  0e03 350100bb      	mov	_rele_cnt_index,#1
7035  0e07 2018          	jra	L1723
7036  0e09               L7623:
7037                     ; 1235 	GPIOD->ODR&=~(1<<5);
7039  0e09 721b500f      	bres	20495,#5
7040                     ; 1236 	delay_ms(10);
7042  0e0d ae000a        	ldw	x,#10
7043  0e10 cd005c        	call	_delay_ms
7045                     ; 1237 	if(!(GPIOD->IDR&=(1<<6))) 
7047  0e13 c65010        	ld	a,20496
7048  0e16 a440          	and	a,#64
7049  0e18 c75010        	ld	20496,a
7050  0e1b 2604          	jrne	L1723
7051                     ; 1239 		rele_cnt_index=2;
7053  0e1d 350200bb      	mov	_rele_cnt_index,#2
7054  0e21               L1723:
7055                     ; 1243 gpio_init();
7057  0e21 cd0b5c        	call	_gpio_init
7059                     ; 1250 spi_init();
7061  0e24 cd08a0        	call	_spi_init
7063                     ; 1252 t4_init();
7065  0e27 cd0039        	call	_t4_init
7067                     ; 1254 FLASH_DUKR=0xae;
7069  0e2a 35ae5064      	mov	_FLASH_DUKR,#174
7070                     ; 1255 FLASH_DUKR=0x56;
7072  0e2e 35565064      	mov	_FLASH_DUKR,#86
7073                     ; 1260 dumm[1]++;
7075  0e32 725c017d      	inc	_dumm+1
7076                     ; 1262 uart_init();
7078  0e36 cd009e        	call	_uart_init
7080                     ; 1264 ST_RDID_read();
7082  0e39 cd092b        	call	_ST_RDID_read
7084                     ; 1265 if(mdr0==0x20) memory_manufacturer='S';	
7086  0e3c b616          	ld	a,_mdr0
7087  0e3e a120          	cp	a,#32
7088  0e40 2606          	jrne	L5723
7091  0e42 355300bc      	mov	_memory_manufacturer,#83
7093  0e46 200d          	jra	L7723
7094  0e48               L5723:
7095                     ; 1268 	DF_mf_dev_read();
7097  0e48 cd0a23        	call	_DF_mf_dev_read
7099                     ; 1269 	if(mdr0==0x1F) memory_manufacturer='A';
7101  0e4b b616          	ld	a,_mdr0
7102  0e4d a11f          	cp	a,#31
7103  0e4f 2604          	jrne	L7723
7106  0e51 354100bc      	mov	_memory_manufacturer,#65
7107  0e55               L7723:
7108                     ; 1272 t2_init();
7110  0e55 cd0000        	call	_t2_init
7112                     ; 1274 ST_WREN();
7114  0e58 cd097c        	call	_ST_WREN
7116                     ; 1276 enableInterrupts();	
7119  0e5b 9a            rim
7121  0e5c               L3033:
7122                     ; 1281 	if(bBUFF_LOAD)
7124                     	btst	_bBUFF_LOAD
7125  0e61 2425          	jruge	L7033
7126                     ; 1283 		bBUFF_LOAD=0;
7128  0e63 7211000b      	bres	_bBUFF_LOAD
7129                     ; 1285 		if(current_page<last_page)
7131  0e67 be0f          	ldw	x,_current_page
7132  0e69 b30d          	cpw	x,_last_page
7133  0e6b 2409          	jruge	L1133
7134                     ; 1287 			current_page++;
7136  0e6d be0f          	ldw	x,_current_page
7137  0e6f 1c0001        	addw	x,#1
7138  0e72 bf0f          	ldw	_current_page,x
7140  0e74 2007          	jra	L3133
7141  0e76               L1133:
7142                     ; 1291 			current_page=0;
7144  0e76 5f            	clrw	x
7145  0e77 bf0f          	ldw	_current_page,x
7146                     ; 1292 			play=0;
7148  0e79 72110004      	bres	_play
7149  0e7d               L3133:
7150                     ; 1294 		if(memory_manufacturer=='A')
7152  0e7d b6bc          	ld	a,_memory_manufacturer
7153  0e7f a141          	cp	a,#65
7154  0e81 2605          	jrne	L7033
7155                     ; 1296 			DF_page_to_buffer(/*///current_buffer_H*//*1,*/current_page);
7157  0e83 be0f          	ldw	x,_current_page
7158  0e85 cd0a91        	call	_DF_page_to_buffer
7160  0e88               L7033:
7161                     ; 1300 	if(bBUFF_READ_L)
7163                     	btst	_bBUFF_READ_L
7164  0e8d 243a          	jruge	L7133
7165                     ; 1302 		bBUFF_READ_L=0;
7167  0e8f 72110009      	bres	_bBUFF_READ_L
7168                     ; 1303 		if(memory_manufacturer=='A')
7170  0e93 b6bc          	ld	a,_memory_manufacturer
7171  0e95 a141          	cp	a,#65
7172  0e97 260e          	jrne	L1233
7173                     ; 1305 			DF_buffer_read(/*///current_buffer_L*//*1,*/0,128,buff);
7175  0e99 ae0050        	ldw	x,#_buff
7176  0e9c 89            	pushw	x
7177  0e9d ae0080        	ldw	x,#128
7178  0ea0 89            	pushw	x
7179  0ea1 5f            	clrw	x
7180  0ea2 cd0ad7        	call	_DF_buffer_read
7182  0ea5 5b04          	addw	sp,#4
7183  0ea7               L1233:
7184                     ; 1307 		if(memory_manufacturer=='S')
7186  0ea7 b6bc          	ld	a,_memory_manufacturer
7187  0ea9 a153          	cp	a,#83
7188  0eab 261c          	jrne	L7133
7189                     ; 1309 			ST_READ((unsigned long)((unsigned long)(current_page*256UL)),128,buff);
7191  0ead ae0050        	ldw	x,#_buff
7192  0eb0 89            	pushw	x
7193  0eb1 ae0080        	ldw	x,#128
7194  0eb4 89            	pushw	x
7195  0eb5 be0f          	ldw	x,_current_page
7196  0eb7 90ae0100      	ldw	y,#256
7197  0ebb cd0000        	call	c_umul
7199  0ebe be02          	ldw	x,c_lreg+2
7200  0ec0 89            	pushw	x
7201  0ec1 be00          	ldw	x,c_lreg
7202  0ec3 89            	pushw	x
7203  0ec4 cd09d5        	call	_ST_READ
7205  0ec7 5b08          	addw	sp,#8
7206  0ec9               L7133:
7207                     ; 1313 	if(bBUFF_READ_H) 
7209                     	btst	_bBUFF_READ_H
7210  0ece 2441          	jruge	L5233
7211                     ; 1315 		bBUFF_READ_H=0;
7213  0ed0 7211000a      	bres	_bBUFF_READ_H
7214                     ; 1316 		if(memory_manufacturer=='A') 
7216  0ed4 b6bc          	ld	a,_memory_manufacturer
7217  0ed6 a141          	cp	a,#65
7218  0ed8 2610          	jrne	L7233
7219                     ; 1318 			DF_buffer_read(/*///current_buffer_L*//*1,*/128,128,&buff[128]);
7221  0eda ae00d0        	ldw	x,#_buff+128
7222  0edd 89            	pushw	x
7223  0ede ae0080        	ldw	x,#128
7224  0ee1 89            	pushw	x
7225  0ee2 ae0080        	ldw	x,#128
7226  0ee5 cd0ad7        	call	_DF_buffer_read
7228  0ee8 5b04          	addw	sp,#4
7229  0eea               L7233:
7230                     ; 1320 		if(memory_manufacturer=='S') 
7232  0eea b6bc          	ld	a,_memory_manufacturer
7233  0eec a153          	cp	a,#83
7234  0eee 2621          	jrne	L5233
7235                     ; 1322 			ST_READ((unsigned long)((unsigned long)(current_page*256UL)+128UL),128,&buff[128]);
7237  0ef0 ae00d0        	ldw	x,#_buff+128
7238  0ef3 89            	pushw	x
7239  0ef4 ae0080        	ldw	x,#128
7240  0ef7 89            	pushw	x
7241  0ef8 be0f          	ldw	x,_current_page
7242  0efa 90ae0100      	ldw	y,#256
7243  0efe cd0000        	call	c_umul
7245  0f01 a680          	ld	a,#128
7246  0f03 cd0000        	call	c_ladc
7248  0f06 be02          	ldw	x,c_lreg+2
7249  0f08 89            	pushw	x
7250  0f09 be00          	ldw	x,c_lreg
7251  0f0b 89            	pushw	x
7252  0f0c cd09d5        	call	_ST_READ
7254  0f0f 5b08          	addw	sp,#8
7255  0f11               L5233:
7256                     ; 1326 	if(bRXIN)
7258                     	btst	_bRXIN
7259  0f16 2407          	jruge	L3333
7260                     ; 1328 		bRXIN=0;
7262  0f18 72110002      	bres	_bRXIN
7263                     ; 1330 		uart_in();
7265  0f1c cd0b85        	call	_uart_in
7267  0f1f               L3333:
7268                     ; 1334 	if(b100Hz)
7270                     	btst	_b100Hz
7271  0f24 2503          	jrult	L461
7272  0f26 cc0fd4        	jp	L5333
7273  0f29               L461:
7274                     ; 1336 		b100Hz=0;
7276  0f29 72110008      	bres	_b100Hz
7277                     ; 1338 		if(but_block_cnt)but_block_cnt--;
7279  0f2d be00          	ldw	x,_but_block_cnt
7280  0f2f 2707          	jreq	L7333
7283  0f31 be00          	ldw	x,_but_block_cnt
7284  0f33 1d0001        	subw	x,#1
7285  0f36 bf00          	ldw	_but_block_cnt,x
7286  0f38               L7333:
7287                     ; 1340 		if(bSTART==1) 
7289                     	btst	_bSTART
7290  0f3d 24e7          	jruge	L5333
7291                     ; 1342 			if(play) 
7293                     	btst	_play
7294  0f44 2417          	jruge	L3433
7295                     ; 1345 				if(!but_block_cnt)
7297  0f46 be00          	ldw	x,_but_block_cnt
7298  0f48 260d          	jrne	L5433
7299                     ; 1347 					play=0;
7301  0f4a 72110004      	bres	_play
7302                     ; 1348 					bSTART=0;
7304  0f4e 7211000c      	bres	_bSTART
7305                     ; 1349 					but_block_cnt=50;
7307  0f52 ae0032        	ldw	x,#50
7308  0f55 bf00          	ldw	_but_block_cnt,x
7309  0f57               L5433:
7310                     ; 1352 				bSTART=0;
7312  0f57 7211000c      	bres	_bSTART
7314  0f5b 2077          	jra	L5333
7315  0f5d               L3433:
7316                     ; 1356 			if(!but_block_cnt)
7318  0f5d be00          	ldw	x,_but_block_cnt
7319  0f5f 2673          	jrne	L5333
7320                     ; 1359 				current_page=1;
7322  0f61 ae0001        	ldw	x,#1
7323  0f64 bf0f          	ldw	_current_page,x
7324                     ; 1361 				last_page=6000;
7326  0f66 ae1770        	ldw	x,#6000
7327  0f69 bf0d          	ldw	_last_page,x
7328                     ; 1366 				if(memory_manufacturer=='A')
7330  0f6b b6bc          	ld	a,_memory_manufacturer
7331  0f6d a141          	cp	a,#65
7332  0f6f 2630          	jrne	L3533
7333                     ; 1368 					DF_page_to_buffer(/*///current_buffer_H*//*1,*/current_page);
7335  0f71 ae0001        	ldw	x,#1
7336  0f74 cd0a91        	call	_DF_page_to_buffer
7338                     ; 1369 					delay_ms(10);
7340  0f77 ae000a        	ldw	x,#10
7341  0f7a cd005c        	call	_delay_ms
7343                     ; 1370 					DF_buffer_read(/*///current_buffer_L*//*1,*/0,128,buff);
7345  0f7d ae0050        	ldw	x,#_buff
7346  0f80 89            	pushw	x
7347  0f81 ae0080        	ldw	x,#128
7348  0f84 89            	pushw	x
7349  0f85 5f            	clrw	x
7350  0f86 cd0ad7        	call	_DF_buffer_read
7352  0f89 5b04          	addw	sp,#4
7353                     ; 1371 					delay_ms(10);
7355  0f8b ae000a        	ldw	x,#10
7356  0f8e cd005c        	call	_delay_ms
7358                     ; 1372 					DF_buffer_read(/*///current_buffer_L*//*1,*/128,128,&buff[128]);         
7360  0f91 ae00d0        	ldw	x,#_buff+128
7361  0f94 89            	pushw	x
7362  0f95 ae0080        	ldw	x,#128
7363  0f98 89            	pushw	x
7364  0f99 ae0080        	ldw	x,#128
7365  0f9c cd0ad7        	call	_DF_buffer_read
7367  0f9f 5b04          	addw	sp,#4
7368  0fa1               L3533:
7369                     ; 1374 				if(memory_manufacturer=='S') 
7371  0fa1 b6bc          	ld	a,_memory_manufacturer
7372  0fa3 a153          	cp	a,#83
7373  0fa5 2615          	jrne	L5533
7374                     ; 1376 					ST_READ(0,256,buff);
7376  0fa7 ae0050        	ldw	x,#_buff
7377  0faa 89            	pushw	x
7378  0fab ae0100        	ldw	x,#256
7379  0fae 89            	pushw	x
7380  0faf ae0000        	ldw	x,#0
7381  0fb2 89            	pushw	x
7382  0fb3 ae0000        	ldw	x,#0
7383  0fb6 89            	pushw	x
7384  0fb7 cd09d5        	call	_ST_READ
7386  0fba 5b08          	addw	sp,#8
7387  0fbc               L5533:
7388                     ; 1378 				play=1;
7390  0fbc 72100004      	bset	_play
7391                     ; 1379 				bSTART=0;
7393  0fc0 7211000c      	bres	_bSTART
7394                     ; 1381 				rele_cnt=rele_cnt_const[rele_cnt_index];
7396  0fc4 b6bb          	ld	a,_rele_cnt_index
7397  0fc6 5f            	clrw	x
7398  0fc7 97            	ld	xl,a
7399  0fc8 d60000        	ld	a,(_rele_cnt_const,x)
7400  0fcb 5f            	clrw	x
7401  0fcc 97            	ld	xl,a
7402  0fcd bf03          	ldw	_rele_cnt,x
7403                     ; 1383 				but_block_cnt=50;
7405  0fcf ae0032        	ldw	x,#50
7406  0fd2 bf00          	ldw	_but_block_cnt,x
7407  0fd4               L5333:
7408                     ; 1389 	if(b10Hz)
7410                     	btst	_b10Hz
7411  0fd9 2413          	jruge	L7533
7412                     ; 1391 		b10Hz=0;
7414  0fdb 72110007      	bres	_b10Hz
7415                     ; 1393 		rele_drv();
7417  0fdf cd004a        	call	_rele_drv
7419                     ; 1394 		pwm_fade_in++;
7421  0fe2 3cba          	inc	_pwm_fade_in
7422                     ; 1395 		if(pwm_fade_in>128)pwm_fade_in=128;			
7424  0fe4 b6ba          	ld	a,_pwm_fade_in
7425  0fe6 a181          	cp	a,#129
7426  0fe8 2504          	jrult	L7533
7429  0fea 358000ba      	mov	_pwm_fade_in,#128
7430  0fee               L7533:
7431                     ; 1398 	if(b5Hz)
7433                     	btst	_b5Hz
7434  0ff3 2404          	jruge	L3633
7435                     ; 1400 		b5Hz=0;
7437  0ff5 72110006      	bres	_b5Hz
7438  0ff9               L3633:
7439                     ; 1408 	if(b1Hz)
7441                     	btst	_b1Hz
7442  0ffe 2503          	jrult	L661
7443  1000 cc0e5c        	jp	L3033
7444  1003               L661:
7445                     ; 1411 		b1Hz=0;
7447  1003 72110005      	bres	_b1Hz
7448  1007 ac5c0e5c      	jpf	L3033
7944                     	xdef	_main
7945                     .eeprom:	section	.data
7946  0000               _EE_PAGE_LEN:
7947  0000 0000          	ds.b	2
7948                     	xdef	_EE_PAGE_LEN
7949                     	switch	.bss
7950  0000               _UIB:
7951  0000 000000000000  	ds.b	80
7952                     	xdef	_UIB
7953  0050               _buff:
7954  0050 000000000000  	ds.b	300
7955                     	xdef	_buff
7956  017c               _dumm:
7957  017c 000000000000  	ds.b	100
7958                     	xdef	_dumm
7959                     .bit:	section	.data,bit
7960  0000               _bRELEASE:
7961  0000 00            	ds.b	1
7962                     	xdef	_bRELEASE
7963  0001               _rx_buffer_overflow:
7964  0001 00            	ds.b	1
7965                     	xdef	_rx_buffer_overflow
7966  0002               _bRXIN:
7967  0002 00            	ds.b	1
7968                     	xdef	_bRXIN
7969  0003               _bOUT_FREE:
7970  0003 00            	ds.b	1
7971                     	xdef	_bOUT_FREE
7972  0004               _play:
7973  0004 00            	ds.b	1
7974                     	xdef	_play
7975  0005               _b1Hz:
7976  0005 00            	ds.b	1
7977                     	xdef	_b1Hz
7978  0006               _b5Hz:
7979  0006 00            	ds.b	1
7980                     	xdef	_b5Hz
7981  0007               _b10Hz:
7982  0007 00            	ds.b	1
7983                     	xdef	_b10Hz
7984  0008               _b100Hz:
7985  0008 00            	ds.b	1
7986                     	xdef	_b100Hz
7987  0009               _bBUFF_READ_L:
7988  0009 00            	ds.b	1
7989                     	xdef	_bBUFF_READ_L
7990  000a               _bBUFF_READ_H:
7991  000a 00            	ds.b	1
7992                     	xdef	_bBUFF_READ_H
7993  000b               _bBUFF_LOAD:
7994  000b 00            	ds.b	1
7995                     	xdef	_bBUFF_LOAD
7996  000c               _bSTART:
7997  000c 00            	ds.b	1
7998                     	xdef	_bSTART
7999                     	switch	.ubsct
8000  0000               _but_block_cnt:
8001  0000 0000          	ds.b	2
8002                     	xdef	_but_block_cnt
8003                     	xdef	_memory_manufacturer
8004                     	xdef	_rele_cnt_const
8005                     	xdef	_rele_cnt_index
8006                     	xdef	_pwm_fade_in
8007  0002               _rx_offset:
8008  0002 00            	ds.b	1
8009                     	xdef	_rx_offset
8010  0003               _rele_cnt:
8011  0003 0000          	ds.b	2
8012                     	xdef	_rele_cnt
8013  0005               _rx_data:
8014  0005 00            	ds.b	1
8015                     	xdef	_rx_data
8016  0006               _rx_status:
8017  0006 00            	ds.b	1
8018                     	xdef	_rx_status
8019  0007               _file_lengt:
8020  0007 00000000      	ds.b	4
8021                     	xdef	_file_lengt
8022  000b               _current_byte_in_buffer:
8023  000b 0000          	ds.b	2
8024                     	xdef	_current_byte_in_buffer
8025  000d               _last_page:
8026  000d 0000          	ds.b	2
8027                     	xdef	_last_page
8028  000f               _current_page:
8029  000f 0000          	ds.b	2
8030                     	xdef	_current_page
8031  0011               _file_lengt_in_pages:
8032  0011 0000          	ds.b	2
8033                     	xdef	_file_lengt_in_pages
8034  0013               _mdr3:
8035  0013 00            	ds.b	1
8036                     	xdef	_mdr3
8037  0014               _mdr2:
8038  0014 00            	ds.b	1
8039                     	xdef	_mdr2
8040  0015               _mdr1:
8041  0015 00            	ds.b	1
8042                     	xdef	_mdr1
8043  0016               _mdr0:
8044  0016 00            	ds.b	1
8045                     	xdef	_mdr0
8046                     	xdef	_but_on_drv_cnt
8047                     	xdef	_but_drv_cnt
8048  0017               _sample:
8049  0017 00            	ds.b	1
8050                     	xdef	_sample
8051  0018               _rx_rd_index:
8052  0018 0000          	ds.b	2
8053                     	xdef	_rx_rd_index
8054  001a               _rx_wr_index:
8055  001a 0000          	ds.b	2
8056                     	xdef	_rx_wr_index
8057  001c               _rx_counter:
8058  001c 0000          	ds.b	2
8059                     	xdef	_rx_counter
8060                     	xdef	_rx_buffer
8061  001e               _tx_rd_index:
8062  001e 00            	ds.b	1
8063                     	xdef	_tx_rd_index
8064  001f               _tx_wr_index:
8065  001f 00            	ds.b	1
8066                     	xdef	_tx_wr_index
8067  0020               _tx_counter:
8068  0020 00            	ds.b	1
8069                     	xdef	_tx_counter
8070                     	xdef	_tx_buffer
8071  0021               _sample_cnt:
8072  0021 0000          	ds.b	2
8073                     	xdef	_sample_cnt
8074                     	xdef	_t0_cnt3
8075                     	xdef	_t0_cnt2
8076                     	xdef	_t0_cnt1
8077                     	xdef	_t0_cnt0
8078                     	xdef	_ST_bulk_erase
8079                     	xdef	_ST_READ
8080                     	xdef	_ST_WRITE
8081                     	xdef	_ST_WREN
8082                     	xdef	_ST_status_read
8083                     	xdef	_ST_RDID_read
8084                     	xdef	_uart_in_an
8085                     	xdef	_control_check
8086                     	xdef	_index_offset
8087                     	xdef	_uart_in
8088                     	xdef	_gpio_init
8089                     	xdef	_spi_init
8090                     	xdef	_spi
8091                     	xdef	_DF_buffer_to_page_er
8092                     	xdef	_DF_page_to_buffer
8093                     	xdef	_DF_buffer_write
8094                     	xdef	_DF_buffer_read
8095                     	xdef	_DF_status_read
8096                     	xdef	_DF_memo_to_256
8097                     	xdef	_DF_mf_dev_read
8098                     	xdef	_uart_init
8099                     	xdef	f_UARTRxInterrupt
8100                     	xdef	f_UARTTxInterrupt
8101                     	xdef	_putchar
8102                     	xdef	_uart_out_adr_block
8103                     	xdef	_uart_out
8104                     	xdef	f_TIM4_UPD_Interrupt
8105                     	xdef	_delay_ms
8106                     	xdef	_rele_drv
8107                     	xdef	_t4_init
8108                     	xdef	_t2_init
8109                     	xref.b	c_lreg
8110                     	xref.b	c_x
8111                     	xref.b	c_y
8131                     	xref	c_ladc
8132                     	xref	c_itolx
8133                     	xref	c_umul
8134                     	xref	c_eewrw
8135                     	xref	c_lglsh
8136                     	xref	c_uitolx
8137                     	xref	c_lgursh
8138                     	xref	c_lcmp
8139                     	xref	c_ltor
8140                     	xref	c_lgadc
8141                     	xref	c_rtol
8142                     	xref	c_vmul
8143                     	end
