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
2232                     ; 62 void t2_init(void){
2234                     	switch	.text
2235  0000               _t2_init:
2239                     ; 63 	TIM2->PSCR = 0;
2241  0000 725f530e      	clr	21262
2242                     ; 64 	TIM2->ARRH= 0x00;
2244  0004 725f530f      	clr	21263
2245                     ; 65 	TIM2->ARRL= 0xff;
2247  0008 35ff5310      	mov	21264,#255
2248                     ; 66 	TIM2->CCR1H= 0x00;	
2250  000c 725f5311      	clr	21265
2251                     ; 67 	TIM2->CCR1L= 200;
2253  0010 35c85312      	mov	21266,#200
2254                     ; 68 	TIM2->CCR2H= 0x00;	
2256  0014 725f5313      	clr	21267
2257                     ; 69 	TIM2->CCR2L= 200;
2259  0018 35c85314      	mov	21268,#200
2260                     ; 70 	TIM2->CCR3H= 0x00;	
2262  001c 725f5315      	clr	21269
2263                     ; 71 	TIM2->CCR3L= 50;
2265  0020 35325316      	mov	21270,#50
2266                     ; 74 	TIM2->CCMR2= ((6<<4) & TIM2_CCMR_OCM) | TIM2_CCMR_OCxPE; //OC2 toggle mode, prelouded
2268  0024 35685308      	mov	21256,#104
2269                     ; 75 	TIM2->CCMR3= ((6<<4) & TIM2_CCMR_OCM) | TIM2_CCMR_OCxPE; //OC2 toggle mode, prelouded
2271  0028 35685309      	mov	21257,#104
2272                     ; 76 	TIM2->CCER1= /*TIM2_CCER1_CC1E | TIM2_CCER1_CC1P |*/ TIM2_CCER1_CC2E | TIM2_CCER1_CC2P; //OC1, OC2 output pins enabled
2274  002c 3530530a      	mov	21258,#48
2275                     ; 78 	TIM2->CCER2= TIM2_CCER2_CC3E /*| TIM2_CCER2_CC3P*/; //OC1, OC2 output pins enabled
2277  0030 3501530b      	mov	21259,#1
2278                     ; 80 	TIM2->CR1=(TIM2_CR1_CEN | TIM2_CR1_ARPE);	
2280  0034 35815300      	mov	21248,#129
2281                     ; 82 }
2284  0038 81            	ret
2307                     ; 85 void t4_init(void){
2308                     	switch	.text
2309  0039               _t4_init:
2313                     ; 86 	TIM4->PSCR = 3;
2315  0039 35035347      	mov	21319,#3
2316                     ; 87 	TIM4->ARR= 158;
2318  003d 359e5348      	mov	21320,#158
2319                     ; 88 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
2321  0041 72105343      	bset	21315,#0
2322                     ; 90 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
2324  0045 35855340      	mov	21312,#133
2325                     ; 92 }
2328  0049 81            	ret
2352                     ; 95 void rele_drv(void)
2352                     ; 96 {
2353                     	switch	.text
2354  004a               _rele_drv:
2358                     ; 97 if(play) 
2360                     	btst	_play
2361  004f 2406          	jruge	L1641
2362                     ; 99 	GPIOD->ODR|=(1<<4);
2364  0051 7218500f      	bset	20495,#4
2366  0055 2004          	jra	L3641
2367  0057               L1641:
2368                     ; 101 else GPIOD->ODR&=~(1<<4);
2370  0057 7219500f      	bres	20495,#4
2371  005b               L3641:
2372                     ; 104 }
2375  005b 81            	ret
2436                     ; 107 long delay_ms(short in)
2436                     ; 108 {
2437                     	switch	.text
2438  005c               _delay_ms:
2440  005c 520c          	subw	sp,#12
2441       0000000c      OFST:	set	12
2444                     ; 111 i=((long)in)*100UL;
2446  005e 90ae0064      	ldw	y,#100
2447  0062 cd0000        	call	c_vmul
2449  0065 96            	ldw	x,sp
2450  0066 1c0005        	addw	x,#OFST-7
2451  0069 cd0000        	call	c_rtol
2453                     ; 113 for(ii=0;ii<i;ii++)
2455  006c ae0000        	ldw	x,#0
2456  006f 1f0b          	ldw	(OFST-1,sp),x
2457  0071 ae0000        	ldw	x,#0
2458  0074 1f09          	ldw	(OFST-3,sp),x
2460  0076 2012          	jra	L3251
2461  0078               L7151:
2462                     ; 115 		iii++;
2464  0078 96            	ldw	x,sp
2465  0079 1c0001        	addw	x,#OFST-11
2466  007c a601          	ld	a,#1
2467  007e cd0000        	call	c_lgadc
2469                     ; 113 for(ii=0;ii<i;ii++)
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
2489                     ; 118 }
2492  009b 5b0c          	addw	sp,#12
2493  009d 81            	ret
2516                     ; 121 void uart_init (void){
2517                     	switch	.text
2518  009e               _uart_init:
2522                     ; 122 	GPIOD->DDR|=(1<<5);
2524  009e 721a5011      	bset	20497,#5
2525                     ; 123 	GPIOD->CR1|=(1<<5);
2527  00a2 721a5012      	bset	20498,#5
2528                     ; 124 	GPIOD->CR2|=(1<<5);
2530  00a6 721a5013      	bset	20499,#5
2531                     ; 127 	GPIOD->DDR&=~(1<<6);
2533  00aa 721d5011      	bres	20497,#6
2534                     ; 128 	GPIOD->CR1&=~(1<<6);
2536  00ae 721d5012      	bres	20498,#6
2537                     ; 129 	GPIOD->CR2&=~(1<<6);
2539  00b2 721d5013      	bres	20499,#6
2540                     ; 132 	UART1->CR1&=~UART1_CR1_M;					
2542  00b6 72195234      	bres	21044,#4
2543                     ; 133 	UART1->CR3|= (0<<4) & UART1_CR3_STOP;	
2545  00ba c65236        	ld	a,21046
2546                     ; 134 	UART1->BRR2= 0x01;//0x03;
2548  00bd 35015233      	mov	21043,#1
2549                     ; 135 	UART1->BRR1= 0x1a;//0x68;
2551  00c1 351a5232      	mov	21042,#26
2552                     ; 136 	UART1->CR2|= UART1_CR2_TEN | UART3_CR2_REN | UART3_CR2_RIEN;	
2554  00c5 c65235        	ld	a,21045
2555  00c8 aa2c          	or	a,#44
2556  00ca c75235        	ld	21045,a
2557                     ; 137 }
2560  00cd 81            	ret
2678                     ; 140 void uart_out (char num,char data0,char data1,char data2,char data3,char data4,char data5){
2679                     	switch	.text
2680  00ce               _uart_out:
2682  00ce 89            	pushw	x
2683  00cf 520c          	subw	sp,#12
2684       0000000c      OFST:	set	12
2687                     ; 141 	char i=0,t=0,UOB[10];
2691  00d1 0f01          	clr	(OFST-11,sp)
2692                     ; 144 	UOB[0]=data0;
2694  00d3 9f            	ld	a,xl
2695  00d4 6b02          	ld	(OFST-10,sp),a
2696                     ; 145 	UOB[1]=data1;
2698  00d6 7b11          	ld	a,(OFST+5,sp)
2699  00d8 6b03          	ld	(OFST-9,sp),a
2700                     ; 146 	UOB[2]=data2;
2702  00da 7b12          	ld	a,(OFST+6,sp)
2703  00dc 6b04          	ld	(OFST-8,sp),a
2704                     ; 147 	UOB[3]=data3;
2706  00de 7b13          	ld	a,(OFST+7,sp)
2707  00e0 6b05          	ld	(OFST-7,sp),a
2708                     ; 148 	UOB[4]=data4;
2710  00e2 7b14          	ld	a,(OFST+8,sp)
2711  00e4 6b06          	ld	(OFST-6,sp),a
2712                     ; 149 	UOB[5]=data5;
2714  00e6 7b15          	ld	a,(OFST+9,sp)
2715  00e8 6b07          	ld	(OFST-5,sp),a
2716                     ; 150 	for (i=0;i<num;i++)
2718  00ea 0f0c          	clr	(OFST+0,sp)
2720  00ec 2013          	jra	L5261
2721  00ee               L1261:
2722                     ; 152 		t^=UOB[i];
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
2736                     ; 150 	for (i=0;i<num;i++)
2738  00ff 0c0c          	inc	(OFST+0,sp)
2739  0101               L5261:
2742  0101 7b0c          	ld	a,(OFST+0,sp)
2743  0103 110d          	cp	a,(OFST+1,sp)
2744  0105 25e7          	jrult	L1261
2745                     ; 154 	UOB[num]=num;
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
2758                     ; 155 	t^=UOB[num];
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
2772                     ; 156 	UOB[num+1]=t;
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
2785                     ; 157 	UOB[num+2]=END;
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
2798                     ; 161 	for (i=0;i<num+3;i++)
2800  0145 0f0c          	clr	(OFST+0,sp)
2802  0147 2012          	jra	L5361
2803  0149               L1361:
2804                     ; 163 		putchar(UOB[i]);
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
2816  0156 cd0b9b        	call	_putchar
2818                     ; 161 	for (i=0;i<num+3;i++)
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
2835                     ; 166 	bOUT_FREE=0;	  	
2837  0171 72110005      	bres	_bOUT_FREE
2838                     ; 167 }
2841  0175 5b0e          	addw	sp,#14
2842  0177 81            	ret
2924                     ; 170 void uart_out_adr_block (unsigned long adress,char *ptr, char len)
2924                     ; 171 {
2925                     	switch	.text
2926  0178               _uart_out_adr_block:
2928  0178 5203          	subw	sp,#3
2929       00000003      OFST:	set	3
2932                     ; 175 t=0;
2934  017a 0f02          	clr	(OFST-1,sp)
2935                     ; 176 temp11=CMND;
2937                     ; 177 t^=temp11;
2939  017c 7b02          	ld	a,(OFST-1,sp)
2940  017e a816          	xor	a,	#22
2941  0180 6b02          	ld	(OFST-1,sp),a
2942                     ; 178 putchar(temp11);
2944  0182 a616          	ld	a,#22
2945  0184 cd0b9b        	call	_putchar
2947                     ; 180 temp11=10;
2949                     ; 181 t^=temp11;
2951  0187 7b02          	ld	a,(OFST-1,sp)
2952  0189 a80a          	xor	a,	#10
2953  018b 6b02          	ld	(OFST-1,sp),a
2954                     ; 182 putchar(temp11);
2956  018d a60a          	ld	a,#10
2957  018f cd0b9b        	call	_putchar
2959                     ; 184 temp11=adress%256;//(*((char*)&adress));
2961  0192 7b09          	ld	a,(OFST+6,sp)
2962  0194 a4ff          	and	a,#255
2963  0196 6b03          	ld	(OFST+0,sp),a
2964                     ; 185 t^=temp11;
2966  0198 7b02          	ld	a,(OFST-1,sp)
2967  019a 1803          	xor	a,	(OFST+0,sp)
2968  019c 6b02          	ld	(OFST-1,sp),a
2969                     ; 186 putchar(temp11);
2971  019e 7b03          	ld	a,(OFST+0,sp)
2972  01a0 cd0b9b        	call	_putchar
2974                     ; 187 adress>>=8;
2976  01a3 96            	ldw	x,sp
2977  01a4 1c0006        	addw	x,#OFST+3
2978  01a7 a608          	ld	a,#8
2979  01a9 cd0000        	call	c_lgursh
2981                     ; 188 temp11=adress%256;//(*(((char*)&adress)+1));
2983  01ac 7b09          	ld	a,(OFST+6,sp)
2984  01ae a4ff          	and	a,#255
2985  01b0 6b03          	ld	(OFST+0,sp),a
2986                     ; 189 t^=temp11;
2988  01b2 7b02          	ld	a,(OFST-1,sp)
2989  01b4 1803          	xor	a,	(OFST+0,sp)
2990  01b6 6b02          	ld	(OFST-1,sp),a
2991                     ; 190 putchar(temp11);
2993  01b8 7b03          	ld	a,(OFST+0,sp)
2994  01ba cd0b9b        	call	_putchar
2996                     ; 191 adress>>=8;
2998  01bd 96            	ldw	x,sp
2999  01be 1c0006        	addw	x,#OFST+3
3000  01c1 a608          	ld	a,#8
3001  01c3 cd0000        	call	c_lgursh
3003                     ; 192 temp11=adress%256;//(*(((char*)&adress)+2));
3005  01c6 7b09          	ld	a,(OFST+6,sp)
3006  01c8 a4ff          	and	a,#255
3007  01ca 6b03          	ld	(OFST+0,sp),a
3008                     ; 193 t^=temp11;
3010  01cc 7b02          	ld	a,(OFST-1,sp)
3011  01ce 1803          	xor	a,	(OFST+0,sp)
3012  01d0 6b02          	ld	(OFST-1,sp),a
3013                     ; 194 putchar(temp11);
3015  01d2 7b03          	ld	a,(OFST+0,sp)
3016  01d4 cd0b9b        	call	_putchar
3018                     ; 195 adress>>=8;
3020  01d7 96            	ldw	x,sp
3021  01d8 1c0006        	addw	x,#OFST+3
3022  01db a608          	ld	a,#8
3023  01dd cd0000        	call	c_lgursh
3025                     ; 196 temp11=adress%256;//(*(((char*)&adress)+3));
3027  01e0 7b09          	ld	a,(OFST+6,sp)
3028  01e2 a4ff          	and	a,#255
3029  01e4 6b03          	ld	(OFST+0,sp),a
3030                     ; 197 t^=temp11;
3032  01e6 7b02          	ld	a,(OFST-1,sp)
3033  01e8 1803          	xor	a,	(OFST+0,sp)
3034  01ea 6b02          	ld	(OFST-1,sp),a
3035                     ; 198 putchar(temp11);
3037  01ec 7b03          	ld	a,(OFST+0,sp)
3038  01ee cd0b9b        	call	_putchar
3040                     ; 201 for(i11=0;i11<len;i11++)
3042  01f1 0f01          	clr	(OFST-2,sp)
3044  01f3 201b          	jra	L7071
3045  01f5               L3071:
3046                     ; 203 	temp11=ptr[i11];
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
3058                     ; 204 	t^=temp11;
3060  0203 7b02          	ld	a,(OFST-1,sp)
3061  0205 1803          	xor	a,	(OFST+0,sp)
3062  0207 6b02          	ld	(OFST-1,sp),a
3063                     ; 205 	putchar(temp11);
3065  0209 7b03          	ld	a,(OFST+0,sp)
3066  020b cd0b9b        	call	_putchar
3068                     ; 201 for(i11=0;i11<len;i11++)
3070  020e 0c01          	inc	(OFST-2,sp)
3071  0210               L7071:
3074  0210 7b01          	ld	a,(OFST-2,sp)
3075  0212 110c          	cp	a,(OFST+9,sp)
3076  0214 25df          	jrult	L3071
3077                     ; 208 temp11=(len+6);
3079  0216 7b0c          	ld	a,(OFST+9,sp)
3080  0218 ab06          	add	a,#6
3081  021a 6b03          	ld	(OFST+0,sp),a
3082                     ; 209 t^=temp11;
3084  021c 7b02          	ld	a,(OFST-1,sp)
3085  021e 1803          	xor	a,	(OFST+0,sp)
3086  0220 6b02          	ld	(OFST-1,sp),a
3087                     ; 210 putchar(temp11);
3089  0222 7b03          	ld	a,(OFST+0,sp)
3090  0224 cd0b9b        	call	_putchar
3092                     ; 212 putchar(t);
3094  0227 7b02          	ld	a,(OFST-1,sp)
3095  0229 cd0b9b        	call	_putchar
3097                     ; 214 putchar(0x0a);
3099  022c a60a          	ld	a,#10
3100  022e cd0b9b        	call	_putchar
3102                     ; 216 bOUT_FREE=0;	   
3104  0231 72110005      	bres	_bOUT_FREE
3105                     ; 217 }
3108  0235 5b03          	addw	sp,#3
3109  0237 81            	ret
3311                     ; 219 void uart_in_an(void) 
3311                     ; 220 {
3312                     	switch	.text
3313  0238               _uart_in_an:
3315  0238 5206          	subw	sp,#6
3316       00000006      OFST:	set	6
3319                     ; 223 if(UIB[0]==CMND) 
3321  023a c60000        	ld	a,_UIB
3322  023d a116          	cp	a,#22
3323  023f 2703          	jreq	L24
3324  0241 cc0b98        	jp	L5202
3325  0244               L24:
3326                     ; 225 	if(UIB[1]==1) 
3328  0244 c60001        	ld	a,_UIB+1
3329  0247 a101          	cp	a,#1
3330  0249 262f          	jrne	L7202
3331                     ; 230 		if(memory_manufacturer=='A') 
3333  024b b6bc          	ld	a,_memory_manufacturer
3334  024d a141          	cp	a,#65
3335  024f 2603          	jrne	L1302
3336                     ; 232 			temp_L=DF_mf_dev_read();
3338  0251 cd0d74        	call	_DF_mf_dev_read
3340  0254               L1302:
3341                     ; 234 		if(memory_manufacturer=='S') 
3343  0254 b6bc          	ld	a,_memory_manufacturer
3344  0256 a153          	cp	a,#83
3345  0258 2603          	jrne	L3302
3346                     ; 236 			temp_L=ST_RDID_read();
3348  025a cd0c5c        	call	_ST_RDID_read
3350  025d               L3302:
3351                     ; 238 		uart_out (6,CMND,1,mdr0/**((char*)&temp_L)*/,mdr1/**(((char*)&temp_L)+1)*/,mdr2/**(((char*)&temp_L)+2)*/,mdr3/**(((char*)&temp_L)+3)*/);
3353  025d 3b0015        	push	_mdr3
3354  0260 3b0016        	push	_mdr2
3355  0263 3b0017        	push	_mdr1
3356  0266 3b0018        	push	_mdr0
3357  0269 4b01          	push	#1
3358  026b ae0016        	ldw	x,#22
3359  026e a606          	ld	a,#6
3360  0270 95            	ld	xh,a
3361  0271 cd00ce        	call	_uart_out
3363  0274 5b05          	addw	sp,#5
3365  0276 ac980b98      	jpf	L5202
3366  027a               L7202:
3367                     ; 246 	else if(UIB[1]==2) {
3369  027a c60001        	ld	a,_UIB+1
3370  027d a102          	cp	a,#2
3371  027f 2630          	jrne	L7302
3372                     ; 249 		if(memory_manufacturer=='A') {
3374  0281 b6bc          	ld	a,_memory_manufacturer
3375  0283 a141          	cp	a,#65
3376  0285 2605          	jrne	L1402
3377                     ; 250 			temp=DF_status_read();
3379  0287 cd0dc8        	call	_DF_status_read
3381  028a 6b06          	ld	(OFST+0,sp),a
3382  028c               L1402:
3383                     ; 252 		if(memory_manufacturer=='S') {
3385  028c b6bc          	ld	a,_memory_manufacturer
3386  028e a153          	cp	a,#83
3387  0290 2605          	jrne	L3402
3388                     ; 253 			temp=ST_status_read();
3390  0292 cd0c8e        	call	_ST_status_read
3392  0295 6b06          	ld	(OFST+0,sp),a
3393  0297               L3402:
3394                     ; 256 		uart_out (3,CMND,2,temp,0,0,0);    
3396  0297 4b00          	push	#0
3397  0299 4b00          	push	#0
3398  029b 4b00          	push	#0
3399  029d 7b09          	ld	a,(OFST+3,sp)
3400  029f 88            	push	a
3401  02a0 4b02          	push	#2
3402  02a2 ae0016        	ldw	x,#22
3403  02a5 a603          	ld	a,#3
3404  02a7 95            	ld	xh,a
3405  02a8 cd00ce        	call	_uart_out
3407  02ab 5b05          	addw	sp,#5
3409  02ad ac980b98      	jpf	L5202
3410  02b1               L7302:
3411                     ; 260 	else if(UIB[1]==3)
3413  02b1 c60001        	ld	a,_UIB+1
3414  02b4 a103          	cp	a,#3
3415  02b6 2623          	jrne	L7402
3416                     ; 263 		if(memory_manufacturer=='A') {
3418  02b8 b6bc          	ld	a,_memory_manufacturer
3419  02ba a141          	cp	a,#65
3420  02bc 2603          	jrne	L1502
3421                     ; 264 			DF_memo_to_256();
3423  02be cd0dab        	call	_DF_memo_to_256
3425  02c1               L1502:
3426                     ; 266 		uart_out (2,CMND,3,temp,0,0,0);    
3428  02c1 4b00          	push	#0
3429  02c3 4b00          	push	#0
3430  02c5 4b00          	push	#0
3431  02c7 7b09          	ld	a,(OFST+3,sp)
3432  02c9 88            	push	a
3433  02ca 4b03          	push	#3
3434  02cc ae0016        	ldw	x,#22
3435  02cf a602          	ld	a,#2
3436  02d1 95            	ld	xh,a
3437  02d2 cd00ce        	call	_uart_out
3439  02d5 5b05          	addw	sp,#5
3441  02d7 ac980b98      	jpf	L5202
3442  02db               L7402:
3443                     ; 269 	else if(UIB[1]==4)
3445  02db c60001        	ld	a,_UIB+1
3446  02de a104          	cp	a,#4
3447  02e0 2623          	jrne	L5502
3448                     ; 272 		if(memory_manufacturer=='A') {
3450  02e2 b6bc          	ld	a,_memory_manufacturer
3451  02e4 a141          	cp	a,#65
3452  02e6 2603          	jrne	L7502
3453                     ; 273 			DF_memo_to_256();
3455  02e8 cd0dab        	call	_DF_memo_to_256
3457  02eb               L7502:
3458                     ; 275 		uart_out (2,CMND,3,temp,0,0,0);    
3460  02eb 4b00          	push	#0
3461  02ed 4b00          	push	#0
3462  02ef 4b00          	push	#0
3463  02f1 7b09          	ld	a,(OFST+3,sp)
3464  02f3 88            	push	a
3465  02f4 4b03          	push	#3
3466  02f6 ae0016        	ldw	x,#22
3467  02f9 a602          	ld	a,#2
3468  02fb 95            	ld	xh,a
3469  02fc cd00ce        	call	_uart_out
3471  02ff 5b05          	addw	sp,#5
3473  0301 ac980b98      	jpf	L5202
3474  0305               L5502:
3475                     ; 278 	else if(UIB[1]==10)
3477  0305 c60001        	ld	a,_UIB+1
3478  0308 a10a          	cp	a,#10
3479  030a 2703cc0392    	jrne	L3602
3480                     ; 282 		if(memory_manufacturer=='A') {
3482  030f b6bc          	ld	a,_memory_manufacturer
3483  0311 a141          	cp	a,#65
3484  0313 2615          	jrne	L5602
3485                     ; 283 			if(UIB[2]==1)DF_buffer_read(/*1,*/0,256, buff);
3487  0315 c60002        	ld	a,_UIB+2
3488  0318 a101          	cp	a,#1
3489  031a 260e          	jrne	L5602
3492  031c ae0050        	ldw	x,#_buff
3493  031f 89            	pushw	x
3494  0320 ae0100        	ldw	x,#256
3495  0323 89            	pushw	x
3496  0324 5f            	clrw	x
3497  0325 cd0e28        	call	_DF_buffer_read
3499  0328 5b04          	addw	sp,#4
3500  032a               L5602:
3501                     ; 288 		uart_out_adr_block (0,buff,64);
3503  032a 4b40          	push	#64
3504  032c ae0050        	ldw	x,#_buff
3505  032f 89            	pushw	x
3506  0330 ae0000        	ldw	x,#0
3507  0333 89            	pushw	x
3508  0334 ae0000        	ldw	x,#0
3509  0337 89            	pushw	x
3510  0338 cd0178        	call	_uart_out_adr_block
3512  033b 5b07          	addw	sp,#7
3513                     ; 289 		delay_ms(100);    
3515  033d ae0064        	ldw	x,#100
3516  0340 cd005c        	call	_delay_ms
3518                     ; 290 		uart_out_adr_block (64,&buff[64],64);
3520  0343 4b40          	push	#64
3521  0345 ae0090        	ldw	x,#_buff+64
3522  0348 89            	pushw	x
3523  0349 ae0040        	ldw	x,#64
3524  034c 89            	pushw	x
3525  034d ae0000        	ldw	x,#0
3526  0350 89            	pushw	x
3527  0351 cd0178        	call	_uart_out_adr_block
3529  0354 5b07          	addw	sp,#7
3530                     ; 291 		delay_ms(100);    
3532  0356 ae0064        	ldw	x,#100
3533  0359 cd005c        	call	_delay_ms
3535                     ; 292 		uart_out_adr_block (128,&buff[128],64);
3537  035c 4b40          	push	#64
3538  035e ae00d0        	ldw	x,#_buff+128
3539  0361 89            	pushw	x
3540  0362 ae0080        	ldw	x,#128
3541  0365 89            	pushw	x
3542  0366 ae0000        	ldw	x,#0
3543  0369 89            	pushw	x
3544  036a cd0178        	call	_uart_out_adr_block
3546  036d 5b07          	addw	sp,#7
3547                     ; 293 		delay_ms(100);    
3549  036f ae0064        	ldw	x,#100
3550  0372 cd005c        	call	_delay_ms
3552                     ; 294 		uart_out_adr_block (192,&buff[192],64);
3554  0375 4b40          	push	#64
3555  0377 ae0110        	ldw	x,#_buff+192
3556  037a 89            	pushw	x
3557  037b ae00c0        	ldw	x,#192
3558  037e 89            	pushw	x
3559  037f ae0000        	ldw	x,#0
3560  0382 89            	pushw	x
3561  0383 cd0178        	call	_uart_out_adr_block
3563  0386 5b07          	addw	sp,#7
3564                     ; 295 		delay_ms(100);    
3566  0388 ae0064        	ldw	x,#100
3567  038b cd005c        	call	_delay_ms
3570  038e ac980b98      	jpf	L5202
3571  0392               L3602:
3572                     ; 298 	else if(UIB[1]==11)
3574  0392 c60001        	ld	a,_UIB+1
3575  0395 a10b          	cp	a,#11
3576  0397 2633          	jrne	L3702
3577                     ; 304 		for(i=0;i<256;i++)buff[i]=0;
3579  0399 5f            	clrw	x
3580  039a 1f05          	ldw	(OFST-1,sp),x
3581  039c               L5702:
3584  039c 1e05          	ldw	x,(OFST-1,sp)
3585  039e 724f0050      	clr	(_buff,x)
3588  03a2 1e05          	ldw	x,(OFST-1,sp)
3589  03a4 1c0001        	addw	x,#1
3590  03a7 1f05          	ldw	(OFST-1,sp),x
3593  03a9 1e05          	ldw	x,(OFST-1,sp)
3594  03ab a30100        	cpw	x,#256
3595  03ae 25ec          	jrult	L5702
3596                     ; 306 		if(UIB[2]==1)DF_buffer_write(/*1,*/0,256, buff);
3598  03b0 c60002        	ld	a,_UIB+2
3599  03b3 a101          	cp	a,#1
3600  03b5 2703          	jreq	L44
3601  03b7 cc0b98        	jp	L5202
3602  03ba               L44:
3605  03ba ae0050        	ldw	x,#_buff
3606  03bd 89            	pushw	x
3607  03be ae0100        	ldw	x,#256
3608  03c1 89            	pushw	x
3609  03c2 5f            	clrw	x
3610  03c3 cd0e6e        	call	_DF_buffer_write
3612  03c6 5b04          	addw	sp,#4
3613  03c8 ac980b98      	jpf	L5202
3614  03cc               L3702:
3615                     ; 310 	else if(UIB[1]==12)
3617  03cc c60001        	ld	a,_UIB+1
3618  03cf a10c          	cp	a,#12
3619  03d1 2703          	jreq	L64
3620  03d3 cc04b2        	jp	L7012
3621  03d6               L64:
3622                     ; 316 		for(i=0;i<256;i++)buff[i]=0;
3624  03d6 5f            	clrw	x
3625  03d7 1f05          	ldw	(OFST-1,sp),x
3626  03d9               L1112:
3629  03d9 1e05          	ldw	x,(OFST-1,sp)
3630  03db 724f0050      	clr	(_buff,x)
3633  03df 1e05          	ldw	x,(OFST-1,sp)
3634  03e1 1c0001        	addw	x,#1
3635  03e4 1f05          	ldw	(OFST-1,sp),x
3638  03e6 1e05          	ldw	x,(OFST-1,sp)
3639  03e8 a30100        	cpw	x,#256
3640  03eb 25ec          	jrult	L1112
3641                     ; 318 		if(UIB[3]==1)
3643  03ed c60003        	ld	a,_UIB+3
3644  03f0 a101          	cp	a,#1
3645  03f2 2632          	jrne	L7112
3646                     ; 320 			buff[0]=0x00;
3648  03f4 725f0050      	clr	_buff
3649                     ; 321 			buff[1]=0x11;
3651  03f8 35110051      	mov	_buff+1,#17
3652                     ; 322 			buff[2]=0x22;
3654  03fc 35220052      	mov	_buff+2,#34
3655                     ; 323 			buff[3]=0x33;
3657  0400 35330053      	mov	_buff+3,#51
3658                     ; 324 			buff[4]=0x44;
3660  0404 35440054      	mov	_buff+4,#68
3661                     ; 325 			buff[5]=0x55;
3663  0408 35550055      	mov	_buff+5,#85
3664                     ; 326 			buff[6]=0x66;
3666  040c 35660056      	mov	_buff+6,#102
3667                     ; 327 			buff[7]=0x77;
3669  0410 35770057      	mov	_buff+7,#119
3670                     ; 328 			buff[8]=0x88;
3672  0414 35880058      	mov	_buff+8,#136
3673                     ; 329 			buff[9]=0x99;
3675  0418 35990059      	mov	_buff+9,#153
3676                     ; 330 			buff[10]=0;
3678  041c 725f005a      	clr	_buff+10
3679                     ; 331 			buff[11]=0;
3681  0420 725f005b      	clr	_buff+11
3683  0424 2070          	jra	L1212
3684  0426               L7112:
3685                     ; 334 		else if(UIB[3]==2)
3687  0426 c60003        	ld	a,_UIB+3
3688  0429 a102          	cp	a,#2
3689  042b 2632          	jrne	L3212
3690                     ; 336 			buff[0]=0x00;
3692  042d 725f0050      	clr	_buff
3693                     ; 337 			buff[1]=0x10;
3695  0431 35100051      	mov	_buff+1,#16
3696                     ; 338 			buff[2]=0x20;
3698  0435 35200052      	mov	_buff+2,#32
3699                     ; 339 			buff[3]=0x30;
3701  0439 35300053      	mov	_buff+3,#48
3702                     ; 340 			buff[4]=0x40;
3704  043d 35400054      	mov	_buff+4,#64
3705                     ; 341 			buff[5]=0x50;
3707  0441 35500055      	mov	_buff+5,#80
3708                     ; 342 			buff[6]=0x60;
3710  0445 35600056      	mov	_buff+6,#96
3711                     ; 343 			buff[7]=0x70;
3713  0449 35700057      	mov	_buff+7,#112
3714                     ; 344 			buff[8]=0x80;
3716  044d 35800058      	mov	_buff+8,#128
3717                     ; 345 			buff[9]=0x90;
3719  0451 35900059      	mov	_buff+9,#144
3720                     ; 346 			buff[10]=0;
3722  0455 725f005a      	clr	_buff+10
3723                     ; 347 			buff[11]=0;
3725  0459 725f005b      	clr	_buff+11
3727  045d 2037          	jra	L1212
3728  045f               L3212:
3729                     ; 350 		else if(UIB[3]==3)
3731  045f c60003        	ld	a,_UIB+3
3732  0462 a103          	cp	a,#3
3733  0464 2630          	jrne	L1212
3734                     ; 352 			buff[0]=0x98;
3736  0466 35980050      	mov	_buff,#152
3737                     ; 353 			buff[1]=0x87;
3739  046a 35870051      	mov	_buff+1,#135
3740                     ; 354 			buff[2]=0x76;
3742  046e 35760052      	mov	_buff+2,#118
3743                     ; 355 			buff[3]=0x65;
3745  0472 35650053      	mov	_buff+3,#101
3746                     ; 356 			buff[4]=0x54;
3748  0476 35540054      	mov	_buff+4,#84
3749                     ; 357 			buff[5]=0x43;
3751  047a 35430055      	mov	_buff+5,#67
3752                     ; 358 			buff[6]=0x32;
3754  047e 35320056      	mov	_buff+6,#50
3755                     ; 359 			buff[7]=0x21;
3757  0482 35210057      	mov	_buff+7,#33
3758                     ; 360 			buff[8]=0x10;
3760  0486 35100058      	mov	_buff+8,#16
3761                     ; 361 			buff[9]=0x00;
3763  048a 725f0059      	clr	_buff+9
3764                     ; 362 			buff[10]=0;
3766  048e 725f005a      	clr	_buff+10
3767                     ; 363 			buff[11]=0;
3769  0492 725f005b      	clr	_buff+11
3770  0496               L1212:
3771                     ; 365 		if(UIB[2]==1)DF_buffer_write(/*1,*/0,256, buff);
3773  0496 c60002        	ld	a,_UIB+2
3774  0499 a101          	cp	a,#1
3775  049b 2703          	jreq	L05
3776  049d cc0b98        	jp	L5202
3777  04a0               L05:
3780  04a0 ae0050        	ldw	x,#_buff
3781  04a3 89            	pushw	x
3782  04a4 ae0100        	ldw	x,#256
3783  04a7 89            	pushw	x
3784  04a8 5f            	clrw	x
3785  04a9 cd0e6e        	call	_DF_buffer_write
3787  04ac 5b04          	addw	sp,#4
3788  04ae ac980b98      	jpf	L5202
3789  04b2               L7012:
3790                     ; 369 	else if(UIB[1]==13)
3792  04b2 c60001        	ld	a,_UIB+1
3793  04b5 a10d          	cp	a,#13
3794  04b7 2703cc0555    	jrne	L5312
3795                     ; 374 		if(memory_manufacturer=='A') {	
3797  04bc b6bc          	ld	a,_memory_manufacturer
3798  04be a141          	cp	a,#65
3799  04c0 2608          	jrne	L7312
3800                     ; 375 			DF_page_to_buffer(/*UIB[2],*/UIB[3]);
3802  04c2 c60003        	ld	a,_UIB+3
3803  04c5 5f            	clrw	x
3804  04c6 97            	ld	xl,a
3805  04c7 cd0de2        	call	_DF_page_to_buffer
3807  04ca               L7312:
3808                     ; 377 		if(memory_manufacturer=='S') {
3810  04ca b6bc          	ld	a,_memory_manufacturer
3811  04cc a153          	cp	a,#83
3812  04ce 2703          	jreq	L25
3813  04d0 cc0b98        	jp	L5202
3814  04d3               L25:
3815                     ; 378 			current_page=11;
3817  04d3 ae000b        	ldw	x,#11
3818  04d6 bf11          	ldw	_current_page,x
3819                     ; 379 			ST_READ((long)(current_page*256),256, buff);
3821  04d8 ae0050        	ldw	x,#_buff
3822  04db 89            	pushw	x
3823  04dc ae0100        	ldw	x,#256
3824  04df 89            	pushw	x
3825  04e0 ae0b00        	ldw	x,#2816
3826  04e3 89            	pushw	x
3827  04e4 ae0000        	ldw	x,#0
3828  04e7 89            	pushw	x
3829  04e8 cd0d26        	call	_ST_READ
3831  04eb 5b08          	addw	sp,#8
3832                     ; 381 			uart_out_adr_block (0,buff,64);
3834  04ed 4b40          	push	#64
3835  04ef ae0050        	ldw	x,#_buff
3836  04f2 89            	pushw	x
3837  04f3 ae0000        	ldw	x,#0
3838  04f6 89            	pushw	x
3839  04f7 ae0000        	ldw	x,#0
3840  04fa 89            	pushw	x
3841  04fb cd0178        	call	_uart_out_adr_block
3843  04fe 5b07          	addw	sp,#7
3844                     ; 382 			delay_ms(100);    
3846  0500 ae0064        	ldw	x,#100
3847  0503 cd005c        	call	_delay_ms
3849                     ; 383 			uart_out_adr_block (64,&buff[64],64);
3851  0506 4b40          	push	#64
3852  0508 ae0090        	ldw	x,#_buff+64
3853  050b 89            	pushw	x
3854  050c ae0040        	ldw	x,#64
3855  050f 89            	pushw	x
3856  0510 ae0000        	ldw	x,#0
3857  0513 89            	pushw	x
3858  0514 cd0178        	call	_uart_out_adr_block
3860  0517 5b07          	addw	sp,#7
3861                     ; 384 			delay_ms(100);    
3863  0519 ae0064        	ldw	x,#100
3864  051c cd005c        	call	_delay_ms
3866                     ; 385 			uart_out_adr_block (128,&buff[128],64);
3868  051f 4b40          	push	#64
3869  0521 ae00d0        	ldw	x,#_buff+128
3870  0524 89            	pushw	x
3871  0525 ae0080        	ldw	x,#128
3872  0528 89            	pushw	x
3873  0529 ae0000        	ldw	x,#0
3874  052c 89            	pushw	x
3875  052d cd0178        	call	_uart_out_adr_block
3877  0530 5b07          	addw	sp,#7
3878                     ; 386 			delay_ms(100);    
3880  0532 ae0064        	ldw	x,#100
3881  0535 cd005c        	call	_delay_ms
3883                     ; 387 			uart_out_adr_block (192,&buff[192],64);
3885  0538 4b40          	push	#64
3886  053a ae0110        	ldw	x,#_buff+192
3887  053d 89            	pushw	x
3888  053e ae00c0        	ldw	x,#192
3889  0541 89            	pushw	x
3890  0542 ae0000        	ldw	x,#0
3891  0545 89            	pushw	x
3892  0546 cd0178        	call	_uart_out_adr_block
3894  0549 5b07          	addw	sp,#7
3895                     ; 388 			delay_ms(100); 
3897  054b ae0064        	ldw	x,#100
3898  054e cd005c        	call	_delay_ms
3900  0551 ac980b98      	jpf	L5202
3901  0555               L5312:
3902                     ; 391 	else if(UIB[1]==14)
3904  0555 c60001        	ld	a,_UIB+1
3905  0558 a10e          	cp	a,#14
3906  055a 265b          	jrne	L5412
3907                     ; 396 		if(memory_manufacturer=='A') {	
3909  055c b6bc          	ld	a,_memory_manufacturer
3910  055e a141          	cp	a,#65
3911  0560 2608          	jrne	L7412
3912                     ; 397 			DF_buffer_to_page_er(/*UIB[2],*/UIB[3]);
3914  0562 c60003        	ld	a,_UIB+3
3915  0565 5f            	clrw	x
3916  0566 97            	ld	xl,a
3917  0567 cd0e05        	call	_DF_buffer_to_page_er
3919  056a               L7412:
3920                     ; 399 		if(memory_manufacturer=='S') {
3922  056a b6bc          	ld	a,_memory_manufacturer
3923  056c a153          	cp	a,#83
3924  056e 2703          	jreq	L45
3925  0570 cc0b98        	jp	L5202
3926  0573               L45:
3927                     ; 400 			for(i=0;i<256;i++) {
3929  0573 5f            	clrw	x
3930  0574 1f05          	ldw	(OFST-1,sp),x
3931  0576               L3512:
3932                     ; 401 				buff[i]=(char)i;
3934  0576 7b06          	ld	a,(OFST+0,sp)
3935  0578 1e05          	ldw	x,(OFST-1,sp)
3936  057a d70050        	ld	(_buff,x),a
3937                     ; 400 			for(i=0;i<256;i++) {
3939  057d 1e05          	ldw	x,(OFST-1,sp)
3940  057f 1c0001        	addw	x,#1
3941  0582 1f05          	ldw	(OFST-1,sp),x
3944  0584 1e05          	ldw	x,(OFST-1,sp)
3945  0586 a30100        	cpw	x,#256
3946  0589 25eb          	jrult	L3512
3947                     ; 403 			current_page=11;
3949  058b ae000b        	ldw	x,#11
3950  058e bf11          	ldw	_current_page,x
3951                     ; 404 			ST_WREN();
3953  0590 cd0ccc        	call	_ST_WREN
3955                     ; 405 			delay_ms(100);
3957  0593 ae0064        	ldw	x,#100
3958  0596 cd005c        	call	_delay_ms
3960                     ; 406 			ST_WRITE((long)(current_page*256),256,buff);		
3962  0599 ae0050        	ldw	x,#_buff
3963  059c 89            	pushw	x
3964  059d ae0100        	ldw	x,#256
3965  05a0 89            	pushw	x
3966  05a1 be11          	ldw	x,_current_page
3967  05a3 4f            	clr	a
3968  05a4 02            	rlwa	x,a
3969  05a5 cd0000        	call	c_uitolx
3971  05a8 be02          	ldw	x,c_lreg+2
3972  05aa 89            	pushw	x
3973  05ab be00          	ldw	x,c_lreg
3974  05ad 89            	pushw	x
3975  05ae cd0cda        	call	_ST_WRITE
3977  05b1 5b08          	addw	sp,#8
3978  05b3 ac980b98      	jpf	L5202
3979  05b7               L5412:
3980                     ; 411 	else if(UIB[1]==20)
3982  05b7 c60001        	ld	a,_UIB+1
3983  05ba a114          	cp	a,#20
3984  05bc 2675          	jrne	L3612
3985                     ; 416 		file_lengt=0;
3987  05be ae0000        	ldw	x,#0
3988  05c1 bf0b          	ldw	_file_lengt+2,x
3989  05c3 ae0000        	ldw	x,#0
3990  05c6 bf09          	ldw	_file_lengt,x
3991                     ; 417 		file_lengt+=UIB[5];
3993  05c8 c60005        	ld	a,_UIB+5
3994  05cb ae0009        	ldw	x,#_file_lengt
3995  05ce 88            	push	a
3996  05cf cd0000        	call	c_lgadc
3998  05d2 84            	pop	a
3999                     ; 418 		file_lengt<<=8;
4001  05d3 ae0009        	ldw	x,#_file_lengt
4002  05d6 a608          	ld	a,#8
4003  05d8 cd0000        	call	c_lglsh
4005                     ; 419 		file_lengt+=UIB[4];
4007  05db c60004        	ld	a,_UIB+4
4008  05de ae0009        	ldw	x,#_file_lengt
4009  05e1 88            	push	a
4010  05e2 cd0000        	call	c_lgadc
4012  05e5 84            	pop	a
4013                     ; 420 		file_lengt<<=8;
4015  05e6 ae0009        	ldw	x,#_file_lengt
4016  05e9 a608          	ld	a,#8
4017  05eb cd0000        	call	c_lglsh
4019                     ; 421 		file_lengt+=UIB[3];
4021  05ee c60003        	ld	a,_UIB+3
4022  05f1 ae0009        	ldw	x,#_file_lengt
4023  05f4 88            	push	a
4024  05f5 cd0000        	call	c_lgadc
4026  05f8 84            	pop	a
4027                     ; 422 		file_lengt_in_pages=file_lengt;
4029  05f9 be0b          	ldw	x,_file_lengt+2
4030  05fb bf13          	ldw	_file_lengt_in_pages,x
4031                     ; 423 		file_lengt<<=8;
4033  05fd ae0009        	ldw	x,#_file_lengt
4034  0600 a608          	ld	a,#8
4035  0602 cd0000        	call	c_lglsh
4037                     ; 424 		file_lengt+=UIB[2];
4039  0605 c60002        	ld	a,_UIB+2
4040  0608 ae0009        	ldw	x,#_file_lengt
4041  060b 88            	push	a
4042  060c cd0000        	call	c_lgadc
4044  060f 84            	pop	a
4045                     ; 429 		current_page=0;
4047  0610 5f            	clrw	x
4048  0611 bf11          	ldw	_current_page,x
4049                     ; 430 		current_byte_in_buffer=0;
4051  0613 5f            	clrw	x
4052  0614 bf0d          	ldw	_current_byte_in_buffer,x
4053                     ; 432 		if(memory_manufacturer=='S') 
4055  0616 b6bc          	ld	a,_memory_manufacturer
4056  0618 a153          	cp	a,#83
4057  061a 2703          	jreq	L65
4058  061c cc0b98        	jp	L5202
4059  061f               L65:
4060                     ; 434 			ST_WREN();
4062  061f cd0ccc        	call	_ST_WREN
4064                     ; 435 			delay_ms(100);
4066  0622 ae0064        	ldw	x,#100
4067  0625 cd005c        	call	_delay_ms
4069                     ; 436 			ST_bulk_erase();
4071  0628 cd0ca6        	call	_ST_bulk_erase
4073                     ; 437 			bSTART_DOWNLOAD=1;
4075  062b 72100000      	bset	_bSTART_DOWNLOAD
4076  062f ac980b98      	jpf	L5202
4077  0633               L3612:
4078                     ; 443 	else if(UIB[1]==21)
4080  0633 c60001        	ld	a,_UIB+1
4081  0636 a115          	cp	a,#21
4082  0638 2703          	jreq	L06
4083  063a cc0747        	jp	L1712
4084  063d               L06:
4085                     ; 448 		if(current_page_cnt_)
4087  063d 3d00          	tnz	_current_page_cnt_
4088  063f 270a          	jreq	L3712
4089                     ; 450 			current_page_cnt_--;
4091  0641 3a00          	dec	_current_page_cnt_
4092                     ; 451 			if(current_page_cnt_==0)
4094  0643 3d00          	tnz	_current_page_cnt_
4095  0645 2606          	jrne	L7712
4096                     ; 453 				current_page_cnt=0;	
4098  0647 3f01          	clr	_current_page_cnt
4099  0649 2002          	jra	L7712
4100  064b               L3712:
4101                     ; 458 			current_page_cnt=0;
4103  064b 3f01          	clr	_current_page_cnt
4104  064d               L7712:
4105                     ; 461 		for(i=0;i<64;i++)
4107  064d 5f            	clrw	x
4108  064e 1f05          	ldw	(OFST-1,sp),x
4109  0650               L1022:
4110                     ; 463           	buff[current_byte_in_buffer+i]=UIB[2+i];
4112  0650 1e05          	ldw	x,(OFST-1,sp)
4113  0652 d60002        	ld	a,(_UIB+2,x)
4114  0655 be0d          	ldw	x,_current_byte_in_buffer
4115  0657 72fb05        	addw	x,(OFST-1,sp)
4116  065a d70050        	ld	(_buff,x),a
4117                     ; 461 		for(i=0;i<64;i++)
4119  065d 1e05          	ldw	x,(OFST-1,sp)
4120  065f 1c0001        	addw	x,#1
4121  0662 1f05          	ldw	(OFST-1,sp),x
4124  0664 1e05          	ldw	x,(OFST-1,sp)
4125  0666 a30040        	cpw	x,#64
4126  0669 25e5          	jrult	L1022
4127                     ; 465           current_byte_in_buffer+=64;
4129  066b be0d          	ldw	x,_current_byte_in_buffer
4130  066d 1c0040        	addw	x,#64
4131  0670 bf0d          	ldw	_current_byte_in_buffer,x
4132                     ; 466           if(current_byte_in_buffer>=256)
4134  0672 be0d          	ldw	x,_current_byte_in_buffer
4135  0674 a30100        	cpw	x,#256
4136  0677 2403          	jruge	L26
4137  0679 cc0b98        	jp	L5202
4138  067c               L26:
4139                     ; 474 			if(memory_manufacturer=='A') {
4141  067c b6bc          	ld	a,_memory_manufacturer
4142  067e a141          	cp	a,#65
4143  0680 264e          	jrne	L1122
4144                     ; 475 				DF_buffer_write(/*//current_buffer*//*1,*/0,256,buff);
4146  0682 ae0050        	ldw	x,#_buff
4147  0685 89            	pushw	x
4148  0686 ae0100        	ldw	x,#256
4149  0689 89            	pushw	x
4150  068a 5f            	clrw	x
4151  068b cd0e6e        	call	_DF_buffer_write
4153  068e 5b04          	addw	sp,#4
4154                     ; 476 				DF_buffer_to_page_er(/*///current_buffer*//*1,*/current_page);
4156  0690 be11          	ldw	x,_current_page
4157  0692 cd0e05        	call	_DF_buffer_to_page_er
4159                     ; 477 				current_page++;
4161  0695 be11          	ldw	x,_current_page
4162  0697 1c0001        	addw	x,#1
4163  069a bf11          	ldw	_current_page,x
4164                     ; 478 				if(current_page<file_lengt_in_pages)
4166  069c be11          	ldw	x,_current_page
4167  069e b313          	cpw	x,_file_lengt_in_pages
4168  06a0 2424          	jruge	L3122
4169                     ; 480 					delay_ms(100);
4171  06a2 ae0064        	ldw	x,#100
4172  06a5 cd005c        	call	_delay_ms
4174                     ; 481 					uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
4176  06a8 4b00          	push	#0
4177  06aa 4b00          	push	#0
4178  06ac 3b0011        	push	_current_page
4179  06af b612          	ld	a,_current_page+1
4180  06b1 a4ff          	and	a,#255
4181  06b3 88            	push	a
4182  06b4 4b15          	push	#21
4183  06b6 ae0016        	ldw	x,#22
4184  06b9 a604          	ld	a,#4
4185  06bb 95            	ld	xh,a
4186  06bc cd00ce        	call	_uart_out
4188  06bf 5b05          	addw	sp,#5
4189                     ; 482 					current_byte_in_buffer=0;
4191  06c1 5f            	clrw	x
4192  06c2 bf0d          	ldw	_current_byte_in_buffer,x
4194  06c4 200a          	jra	L1122
4195  06c6               L3122:
4196                     ; 486 					EE_PAGE_LEN=current_page;
4198  06c6 be11          	ldw	x,_current_page
4199  06c8 89            	pushw	x
4200  06c9 ae0000        	ldw	x,#_EE_PAGE_LEN
4201  06cc cd0000        	call	c_eewrw
4203  06cf 85            	popw	x
4204  06d0               L1122:
4205                     ; 489 			if(memory_manufacturer=='S') {
4207  06d0 b6bc          	ld	a,_memory_manufacturer
4208  06d2 a153          	cp	a,#83
4209  06d4 2703          	jreq	L46
4210  06d6 cc0b98        	jp	L5202
4211  06d9               L46:
4212                     ; 490 				ST_WREN();
4214  06d9 cd0ccc        	call	_ST_WREN
4216                     ; 491 				delay_ms(100);
4218  06dc ae0064        	ldw	x,#100
4219  06df cd005c        	call	_delay_ms
4221                     ; 492 				ST_WRITE((unsigned long)(current_page*256UL),256,buff);
4223  06e2 ae0050        	ldw	x,#_buff
4224  06e5 89            	pushw	x
4225  06e6 ae0100        	ldw	x,#256
4226  06e9 89            	pushw	x
4227  06ea be11          	ldw	x,_current_page
4228  06ec 90ae0100      	ldw	y,#256
4229  06f0 cd0000        	call	c_umul
4231  06f3 be02          	ldw	x,c_lreg+2
4232  06f5 89            	pushw	x
4233  06f6 be00          	ldw	x,c_lreg
4234  06f8 89            	pushw	x
4235  06f9 cd0cda        	call	_ST_WRITE
4237  06fc 5b08          	addw	sp,#8
4238                     ; 493 				current_page++;
4240  06fe be11          	ldw	x,_current_page
4241  0700 1c0001        	addw	x,#1
4242  0703 bf11          	ldw	_current_page,x
4243                     ; 494 				if(current_page<file_lengt_in_pages)
4245  0705 be11          	ldw	x,_current_page
4246  0707 b313          	cpw	x,_file_lengt_in_pages
4247  0709 242e          	jruge	L1222
4248                     ; 496 					delay_ms(100);
4250  070b ae0064        	ldw	x,#100
4251  070e cd005c        	call	_delay_ms
4253                     ; 497 					uart_out (5,CMND,21,current_page%256,current_page/256,0,0);
4255  0711 4b00          	push	#0
4256  0713 4b00          	push	#0
4257  0715 3b0011        	push	_current_page
4258  0718 b612          	ld	a,_current_page+1
4259  071a a4ff          	and	a,#255
4260  071c 88            	push	a
4261  071d 4b15          	push	#21
4262  071f ae0016        	ldw	x,#22
4263  0722 a605          	ld	a,#5
4264  0724 95            	ld	xh,a
4265  0725 cd00ce        	call	_uart_out
4267  0728 5b05          	addw	sp,#5
4268                     ; 498 					current_page_cnt=10;
4270  072a 350a0001      	mov	_current_page_cnt,#10
4271                     ; 499 					current_page_cnt_=4;
4273  072e 35040000      	mov	_current_page_cnt_,#4
4274                     ; 500 					current_byte_in_buffer=0;
4276  0732 5f            	clrw	x
4277  0733 bf0d          	ldw	_current_byte_in_buffer,x
4279  0735 ac980b98      	jpf	L5202
4280  0739               L1222:
4281                     ; 504 					EE_PAGE_LEN=current_page;
4283  0739 be11          	ldw	x,_current_page
4284  073b 89            	pushw	x
4285  073c ae0000        	ldw	x,#_EE_PAGE_LEN
4286  073f cd0000        	call	c_eewrw
4288  0742 85            	popw	x
4289  0743 ac980b98      	jpf	L5202
4290  0747               L1712:
4291                     ; 515 	else if(UIB[1]==24) {
4293  0747 c60001        	ld	a,_UIB+1
4294  074a a118          	cp	a,#24
4295  074c 2615          	jrne	L7222
4296                     ; 518 		rele_cnt=10;
4298  074e ae000a        	ldw	x,#10
4299  0751 bf05          	ldw	_rele_cnt,x
4300                     ; 519 		ST_WREN();
4302  0753 cd0ccc        	call	_ST_WREN
4304                     ; 520 		delay_ms(100);
4306  0756 ae0064        	ldw	x,#100
4307  0759 cd005c        	call	_delay_ms
4309                     ; 521 		ST_bulk_erase();
4311  075c cd0ca6        	call	_ST_bulk_erase
4314  075f ac980b98      	jpf	L5202
4315  0763               L7222:
4316                     ; 526 	else if(UIB[1]==25)
4318  0763 c60001        	ld	a,_UIB+1
4319  0766 a119          	cp	a,#25
4320  0768 2703          	jreq	L66
4321  076a cc084c        	jp	L3322
4322  076d               L66:
4323                     ; 530 		current_page=0;
4325  076d 5f            	clrw	x
4326  076e bf11          	ldw	_current_page,x
4327                     ; 532 		for(i__=0;i__<EE_PAGE_LEN;i__++)
4329  0770 5f            	clrw	x
4330  0771 1f05          	ldw	(OFST-1,sp),x
4332  0773 ac3e083e      	jpf	L1422
4333  0777               L5322:
4334                     ; 534 			if(memory_manufacturer=='S') {	
4336  0777 b6bc          	ld	a,_memory_manufacturer
4337  0779 a153          	cp	a,#83
4338  077b 2619          	jrne	L5422
4339                     ; 535 				DF_page_to_buffer(i__);
4341  077d 1e05          	ldw	x,(OFST-1,sp)
4342  077f cd0de2        	call	_DF_page_to_buffer
4344                     ; 536 				delay_ms(100);			
4346  0782 ae0064        	ldw	x,#100
4347  0785 cd005c        	call	_delay_ms
4349                     ; 537 				DF_buffer_read(0,256, buff);
4351  0788 ae0050        	ldw	x,#_buff
4352  078b 89            	pushw	x
4353  078c ae0100        	ldw	x,#256
4354  078f 89            	pushw	x
4355  0790 5f            	clrw	x
4356  0791 cd0e28        	call	_DF_buffer_read
4358  0794 5b04          	addw	sp,#4
4359  0796               L5422:
4360                     ; 540 			if(memory_manufacturer=='S') {	
4362  0796 b6bc          	ld	a,_memory_manufacturer
4363  0798 a153          	cp	a,#83
4364  079a 261a          	jrne	L7422
4365                     ; 541 				ST_READ((long)(i__*256),256, buff);
4367  079c ae0050        	ldw	x,#_buff
4368  079f 89            	pushw	x
4369  07a0 ae0100        	ldw	x,#256
4370  07a3 89            	pushw	x
4371  07a4 1e09          	ldw	x,(OFST+3,sp)
4372  07a6 4f            	clr	a
4373  07a7 02            	rlwa	x,a
4374  07a8 cd0000        	call	c_itolx
4376  07ab be02          	ldw	x,c_lreg+2
4377  07ad 89            	pushw	x
4378  07ae be00          	ldw	x,c_lreg
4379  07b0 89            	pushw	x
4380  07b1 cd0d26        	call	_ST_READ
4382  07b4 5b08          	addw	sp,#8
4383  07b6               L7422:
4384                     ; 544 			uart_out_adr_block ((256*i__)+0,buff,64);
4386  07b6 4b40          	push	#64
4387  07b8 ae0050        	ldw	x,#_buff
4388  07bb 89            	pushw	x
4389  07bc 1e08          	ldw	x,(OFST+2,sp)
4390  07be 4f            	clr	a
4391  07bf 02            	rlwa	x,a
4392  07c0 cd0000        	call	c_itolx
4394  07c3 be02          	ldw	x,c_lreg+2
4395  07c5 89            	pushw	x
4396  07c6 be00          	ldw	x,c_lreg
4397  07c8 89            	pushw	x
4398  07c9 cd0178        	call	_uart_out_adr_block
4400  07cc 5b07          	addw	sp,#7
4401                     ; 545 			delay_ms(100);    
4403  07ce ae0064        	ldw	x,#100
4404  07d1 cd005c        	call	_delay_ms
4406                     ; 546 			uart_out_adr_block ((256*i__)+64,&buff[64],64);
4408  07d4 4b40          	push	#64
4409  07d6 ae0090        	ldw	x,#_buff+64
4410  07d9 89            	pushw	x
4411  07da 1e08          	ldw	x,(OFST+2,sp)
4412  07dc 4f            	clr	a
4413  07dd 02            	rlwa	x,a
4414  07de 1c0040        	addw	x,#64
4415  07e1 cd0000        	call	c_itolx
4417  07e4 be02          	ldw	x,c_lreg+2
4418  07e6 89            	pushw	x
4419  07e7 be00          	ldw	x,c_lreg
4420  07e9 89            	pushw	x
4421  07ea cd0178        	call	_uart_out_adr_block
4423  07ed 5b07          	addw	sp,#7
4424                     ; 547 			delay_ms(100);    
4426  07ef ae0064        	ldw	x,#100
4427  07f2 cd005c        	call	_delay_ms
4429                     ; 548 			uart_out_adr_block ((256*i__)+128,&buff[128],64);
4431  07f5 4b40          	push	#64
4432  07f7 ae00d0        	ldw	x,#_buff+128
4433  07fa 89            	pushw	x
4434  07fb 1e08          	ldw	x,(OFST+2,sp)
4435  07fd 4f            	clr	a
4436  07fe 02            	rlwa	x,a
4437  07ff 1c0080        	addw	x,#128
4438  0802 cd0000        	call	c_itolx
4440  0805 be02          	ldw	x,c_lreg+2
4441  0807 89            	pushw	x
4442  0808 be00          	ldw	x,c_lreg
4443  080a 89            	pushw	x
4444  080b cd0178        	call	_uart_out_adr_block
4446  080e 5b07          	addw	sp,#7
4447                     ; 549 			delay_ms(100);    
4449  0810 ae0064        	ldw	x,#100
4450  0813 cd005c        	call	_delay_ms
4452                     ; 550 			uart_out_adr_block ((256*i__)+192,&buff[192],64);
4454  0816 4b40          	push	#64
4455  0818 ae0110        	ldw	x,#_buff+192
4456  081b 89            	pushw	x
4457  081c 1e08          	ldw	x,(OFST+2,sp)
4458  081e 4f            	clr	a
4459  081f 02            	rlwa	x,a
4460  0820 1c00c0        	addw	x,#192
4461  0823 cd0000        	call	c_itolx
4463  0826 be02          	ldw	x,c_lreg+2
4464  0828 89            	pushw	x
4465  0829 be00          	ldw	x,c_lreg
4466  082b 89            	pushw	x
4467  082c cd0178        	call	_uart_out_adr_block
4469  082f 5b07          	addw	sp,#7
4470                     ; 551 			delay_ms(100);   
4472  0831 ae0064        	ldw	x,#100
4473  0834 cd005c        	call	_delay_ms
4475                     ; 532 		for(i__=0;i__<EE_PAGE_LEN;i__++)
4477  0837 1e05          	ldw	x,(OFST-1,sp)
4478  0839 1c0001        	addw	x,#1
4479  083c 1f05          	ldw	(OFST-1,sp),x
4480  083e               L1422:
4483  083e 1e05          	ldw	x,(OFST-1,sp)
4484  0840 c30000        	cpw	x,_EE_PAGE_LEN
4485  0843 2403          	jruge	L07
4486  0845 cc0777        	jp	L5322
4487  0848               L07:
4489  0848 ac980b98      	jpf	L5202
4490  084c               L3322:
4491                     ; 558 	else if(UIB[1]==26)		//Запрос телеметрии
4493  084c c60001        	ld	a,_UIB+1
4494  084f a11a          	cp	a,#26
4495  0851 261b          	jrne	L3522
4496                     ; 561 		uart_out (4,CMND,26,current_page_cnt,current_page_cnt_,0,0);    
4498  0853 4b00          	push	#0
4499  0855 4b00          	push	#0
4500  0857 3b0000        	push	_current_page_cnt_
4501  085a 3b0001        	push	_current_page_cnt
4502  085d 4b1a          	push	#26
4503  085f ae0016        	ldw	x,#22
4504  0862 a604          	ld	a,#4
4505  0864 95            	ld	xh,a
4506  0865 cd00ce        	call	_uart_out
4508  0868 5b05          	addw	sp,#5
4510  086a ac980b98      	jpf	L5202
4511  086e               L3522:
4512                     ; 565 	else if(UIB[1]==30)
4514  086e c60001        	ld	a,_UIB+1
4515  0871 a11e          	cp	a,#30
4516  0873 2608          	jrne	L7522
4517                     ; 587           bSTART=1;
4519  0875 7210000e      	bset	_bSTART
4521  0879 ac980b98      	jpf	L5202
4522  087d               L7522:
4523                     ; 599 	else if(UIB[1]==40)
4525  087d c60001        	ld	a,_UIB+1
4526  0880 a128          	cp	a,#40
4527  0882 2608          	jrne	L3622
4528                     ; 621 		bSTART=1;	
4530  0884 7210000e      	bset	_bSTART
4532  0888 ac980b98      	jpf	L5202
4533  088c               L3622:
4534                     ; 623 	else if(UIB[1]==81)
4536  088c c60001        	ld	a,_UIB+1
4537  088f a151          	cp	a,#81
4538  0891 2703          	jreq	L27
4539  0893 cc096a        	jp	L7622
4540  0896               L27:
4541                     ; 629 		if(memory_manufacturer=='A') 
4543  0896 b6bc          	ld	a,_memory_manufacturer
4544  0898 a141          	cp	a,#65
4545  089a 2608          	jrne	L1722
4546                     ; 631 			DF_page_to_buffer(/*UIB[2],*/UIB[3]);
4548  089c c60003        	ld	a,_UIB+3
4549  089f 5f            	clrw	x
4550  08a0 97            	ld	xl,a
4551  08a1 cd0de2        	call	_DF_page_to_buffer
4553  08a4               L1722:
4554                     ; 637 			adress=UIB[5];
4556  08a4 c60005        	ld	a,_UIB+5
4557  08a7 6b06          	ld	(OFST+0,sp),a
4558  08a9 4f            	clr	a
4559  08aa 6b05          	ld	(OFST-1,sp),a
4560  08ac 6b04          	ld	(OFST-2,sp),a
4561  08ae 6b03          	ld	(OFST-3,sp),a
4562                     ; 638 			adress<<=8;
4564  08b0 96            	ldw	x,sp
4565  08b1 1c0003        	addw	x,#OFST-3
4566  08b4 a608          	ld	a,#8
4567  08b6 cd0000        	call	c_lglsh
4569                     ; 639 			adress+=UIB[4];
4571  08b9 c60004        	ld	a,_UIB+4
4572  08bc 96            	ldw	x,sp
4573  08bd 1c0003        	addw	x,#OFST-3
4574  08c0 88            	push	a
4575  08c1 cd0000        	call	c_lgadc
4577  08c4 84            	pop	a
4578                     ; 640 			adress<<=8;
4580  08c5 96            	ldw	x,sp
4581  08c6 1c0003        	addw	x,#OFST-3
4582  08c9 a608          	ld	a,#8
4583  08cb cd0000        	call	c_lglsh
4585                     ; 641 			adress+=UIB[3];
4587  08ce c60003        	ld	a,_UIB+3
4588  08d1 96            	ldw	x,sp
4589  08d2 1c0003        	addw	x,#OFST-3
4590  08d5 88            	push	a
4591  08d6 cd0000        	call	c_lgadc
4593  08d9 84            	pop	a
4594                     ; 642 			adress<<=8;
4596  08da 96            	ldw	x,sp
4597  08db 1c0003        	addw	x,#OFST-3
4598  08de a608          	ld	a,#8
4599  08e0 cd0000        	call	c_lglsh
4601                     ; 643 			adress+=UIB[2];
4603  08e3 c60002        	ld	a,_UIB+2
4604  08e6 96            	ldw	x,sp
4605  08e7 1c0003        	addw	x,#OFST-3
4606  08ea 88            	push	a
4607  08eb cd0000        	call	c_lgadc
4609  08ee 84            	pop	a
4610                     ; 645 			ST_READ(adress,256, buff);
4612  08ef ae0050        	ldw	x,#_buff
4613  08f2 89            	pushw	x
4614  08f3 ae0100        	ldw	x,#256
4615  08f6 89            	pushw	x
4616  08f7 1e09          	ldw	x,(OFST+3,sp)
4617  08f9 89            	pushw	x
4618  08fa 1e09          	ldw	x,(OFST+3,sp)
4619  08fc 89            	pushw	x
4620  08fd cd0d26        	call	_ST_READ
4622  0900 5b08          	addw	sp,#8
4623                     ; 657 		uart_out_adr_block (0,buff,64);
4625  0902 4b40          	push	#64
4626  0904 ae0050        	ldw	x,#_buff
4627  0907 89            	pushw	x
4628  0908 ae0000        	ldw	x,#0
4629  090b 89            	pushw	x
4630  090c ae0000        	ldw	x,#0
4631  090f 89            	pushw	x
4632  0910 cd0178        	call	_uart_out_adr_block
4634  0913 5b07          	addw	sp,#7
4635                     ; 658 		delay_ms(100);    
4637  0915 ae0064        	ldw	x,#100
4638  0918 cd005c        	call	_delay_ms
4640                     ; 659 		uart_out_adr_block (64,&buff[64],64);
4642  091b 4b40          	push	#64
4643  091d ae0090        	ldw	x,#_buff+64
4644  0920 89            	pushw	x
4645  0921 ae0040        	ldw	x,#64
4646  0924 89            	pushw	x
4647  0925 ae0000        	ldw	x,#0
4648  0928 89            	pushw	x
4649  0929 cd0178        	call	_uart_out_adr_block
4651  092c 5b07          	addw	sp,#7
4652                     ; 660 		delay_ms(100);    
4654  092e ae0064        	ldw	x,#100
4655  0931 cd005c        	call	_delay_ms
4657                     ; 661 		uart_out_adr_block (128,&buff[128],64);
4659  0934 4b40          	push	#64
4660  0936 ae00d0        	ldw	x,#_buff+128
4661  0939 89            	pushw	x
4662  093a ae0080        	ldw	x,#128
4663  093d 89            	pushw	x
4664  093e ae0000        	ldw	x,#0
4665  0941 89            	pushw	x
4666  0942 cd0178        	call	_uart_out_adr_block
4668  0945 5b07          	addw	sp,#7
4669                     ; 662 		delay_ms(100);    
4671  0947 ae0064        	ldw	x,#100
4672  094a cd005c        	call	_delay_ms
4674                     ; 663 		uart_out_adr_block (192,&buff[192],64);
4676  094d 4b40          	push	#64
4677  094f ae0110        	ldw	x,#_buff+192
4678  0952 89            	pushw	x
4679  0953 ae00c0        	ldw	x,#192
4680  0956 89            	pushw	x
4681  0957 ae0000        	ldw	x,#0
4682  095a 89            	pushw	x
4683  095b cd0178        	call	_uart_out_adr_block
4685  095e 5b07          	addw	sp,#7
4686                     ; 664 		delay_ms(100);
4688  0960 ae0064        	ldw	x,#100
4689  0963 cd005c        	call	_delay_ms
4692  0966 ac980b98      	jpf	L5202
4693  096a               L7622:
4694                     ; 670 	else if(UIB[1]==91)
4696  096a c60001        	ld	a,_UIB+1
4697  096d a15b          	cp	a,#91
4698  096f 2703          	jreq	L47
4699  0971 cc0a0e        	jp	L5722
4700  0974               L47:
4701                     ; 676 		if(memory_manufacturer=='A') 
4703  0974 b6bc          	ld	a,_memory_manufacturer
4704  0976 a141          	cp	a,#65
4705  0978 2608          	jrne	L7722
4706                     ; 678 			DF_buffer_to_page_er(/*UIB[2],*/UIB[3]);
4708  097a c60003        	ld	a,_UIB+3
4709  097d 5f            	clrw	x
4710  097e 97            	ld	xl,a
4711  097f cd0e05        	call	_DF_buffer_to_page_er
4713  0982               L7722:
4714                     ; 680 		if(memory_manufacturer=='S') 
4716  0982 b6bc          	ld	a,_memory_manufacturer
4717  0984 a153          	cp	a,#83
4718  0986 2703          	jreq	L67
4719  0988 cc0b98        	jp	L5202
4720  098b               L67:
4721                     ; 682 			for(i=0;i<256;i++) 
4723  098b 5f            	clrw	x
4724  098c 1f05          	ldw	(OFST-1,sp),x
4725  098e               L3032:
4726                     ; 684 				buff[i]=(char)i;
4728  098e 7b06          	ld	a,(OFST+0,sp)
4729  0990 1e05          	ldw	x,(OFST-1,sp)
4730  0992 d70050        	ld	(_buff,x),a
4731                     ; 682 			for(i=0;i<256;i++) 
4733  0995 1e05          	ldw	x,(OFST-1,sp)
4734  0997 1c0001        	addw	x,#1
4735  099a 1f05          	ldw	(OFST-1,sp),x
4738  099c 1e05          	ldw	x,(OFST-1,sp)
4739  099e a30100        	cpw	x,#256
4740  09a1 25eb          	jrult	L3032
4741                     ; 686 			adress=UIB[5];
4743  09a3 c60005        	ld	a,_UIB+5
4744  09a6 6b04          	ld	(OFST-2,sp),a
4745  09a8 4f            	clr	a
4746  09a9 6b03          	ld	(OFST-3,sp),a
4747  09ab 6b02          	ld	(OFST-4,sp),a
4748  09ad 6b01          	ld	(OFST-5,sp),a
4749                     ; 687 			adress<<=8;
4751  09af 96            	ldw	x,sp
4752  09b0 1c0001        	addw	x,#OFST-5
4753  09b3 a608          	ld	a,#8
4754  09b5 cd0000        	call	c_lglsh
4756                     ; 688 			adress+=UIB[4];
4758  09b8 c60004        	ld	a,_UIB+4
4759  09bb 96            	ldw	x,sp
4760  09bc 1c0001        	addw	x,#OFST-5
4761  09bf 88            	push	a
4762  09c0 cd0000        	call	c_lgadc
4764  09c3 84            	pop	a
4765                     ; 689 			adress<<=8;
4767  09c4 96            	ldw	x,sp
4768  09c5 1c0001        	addw	x,#OFST-5
4769  09c8 a608          	ld	a,#8
4770  09ca cd0000        	call	c_lglsh
4772                     ; 690 			adress+=UIB[3];
4774  09cd c60003        	ld	a,_UIB+3
4775  09d0 96            	ldw	x,sp
4776  09d1 1c0001        	addw	x,#OFST-5
4777  09d4 88            	push	a
4778  09d5 cd0000        	call	c_lgadc
4780  09d8 84            	pop	a
4781                     ; 691 			adress<<=8;
4783  09d9 96            	ldw	x,sp
4784  09da 1c0001        	addw	x,#OFST-5
4785  09dd a608          	ld	a,#8
4786  09df cd0000        	call	c_lglsh
4788                     ; 692 			adress+=UIB[2];
4790  09e2 c60002        	ld	a,_UIB+2
4791  09e5 96            	ldw	x,sp
4792  09e6 1c0001        	addw	x,#OFST-5
4793  09e9 88            	push	a
4794  09ea cd0000        	call	c_lgadc
4796  09ed 84            	pop	a
4797                     ; 694 			ST_WREN();
4799  09ee cd0ccc        	call	_ST_WREN
4801                     ; 695 			delay_ms(100);
4803  09f1 ae0064        	ldw	x,#100
4804  09f4 cd005c        	call	_delay_ms
4806                     ; 696 			ST_WRITE(adress,256,buff);		
4808  09f7 ae0050        	ldw	x,#_buff
4809  09fa 89            	pushw	x
4810  09fb ae0100        	ldw	x,#256
4811  09fe 89            	pushw	x
4812  09ff 1e07          	ldw	x,(OFST+1,sp)
4813  0a01 89            	pushw	x
4814  0a02 1e07          	ldw	x,(OFST+1,sp)
4815  0a04 89            	pushw	x
4816  0a05 cd0cda        	call	_ST_WRITE
4818  0a08 5b08          	addw	sp,#8
4819  0a0a ac980b98      	jpf	L5202
4820  0a0e               L5722:
4821                     ; 701 	else if(UIB[1]==92)
4823  0a0e c60001        	ld	a,_UIB+1
4824  0a11 a15c          	cp	a,#92
4825  0a13 2703          	jreq	L001
4826  0a15 cc0acf        	jp	L3132
4827  0a18               L001:
4828                     ; 707 		if(memory_manufacturer=='A') 
4830  0a18 b6bc          	ld	a,_memory_manufacturer
4831  0a1a a141          	cp	a,#65
4832  0a1c 2608          	jrne	L5132
4833                     ; 709 			DF_buffer_to_page_er(/*UIB[2],*/UIB[3]);
4835  0a1e c60003        	ld	a,_UIB+3
4836  0a21 5f            	clrw	x
4837  0a22 97            	ld	xl,a
4838  0a23 cd0e05        	call	_DF_buffer_to_page_er
4840  0a26               L5132:
4841                     ; 711 		if(memory_manufacturer=='S') 
4843  0a26 b6bc          	ld	a,_memory_manufacturer
4844  0a28 a153          	cp	a,#83
4845  0a2a 2703          	jreq	L201
4846  0a2c cc0b98        	jp	L5202
4847  0a2f               L201:
4848                     ; 713 			for(i=0;i<128;i++) 
4850  0a2f 5f            	clrw	x
4851  0a30 1f05          	ldw	(OFST-1,sp),x
4852  0a32               L1232:
4853                     ; 715 				buff[i]=(char)(i*2);
4855  0a32 7b06          	ld	a,(OFST+0,sp)
4856  0a34 48            	sll	a
4857  0a35 1e05          	ldw	x,(OFST-1,sp)
4858  0a37 d70050        	ld	(_buff,x),a
4859                     ; 713 			for(i=0;i<128;i++) 
4861  0a3a 1e05          	ldw	x,(OFST-1,sp)
4862  0a3c 1c0001        	addw	x,#1
4863  0a3f 1f05          	ldw	(OFST-1,sp),x
4866  0a41 1e05          	ldw	x,(OFST-1,sp)
4867  0a43 a30080        	cpw	x,#128
4868  0a46 25ea          	jrult	L1232
4869                     ; 717 			for(i=0;i<128;i++) 
4871  0a48 5f            	clrw	x
4872  0a49 1f05          	ldw	(OFST-1,sp),x
4873  0a4b               L7232:
4874                     ; 719 				buff[i+128]=(char)(255-(i*2));
4876  0a4b 7b06          	ld	a,(OFST+0,sp)
4877  0a4d 48            	sll	a
4878  0a4e a0ff          	sub	a,#255
4879  0a50 40            	neg	a
4880  0a51 1e05          	ldw	x,(OFST-1,sp)
4881  0a53 d700d0        	ld	(_buff+128,x),a
4882                     ; 717 			for(i=0;i<128;i++) 
4884  0a56 1e05          	ldw	x,(OFST-1,sp)
4885  0a58 1c0001        	addw	x,#1
4886  0a5b 1f05          	ldw	(OFST-1,sp),x
4889  0a5d 1e05          	ldw	x,(OFST-1,sp)
4890  0a5f a30080        	cpw	x,#128
4891  0a62 25e7          	jrult	L7232
4892                     ; 721 			adress=UIB[5];
4894  0a64 c60005        	ld	a,_UIB+5
4895  0a67 6b04          	ld	(OFST-2,sp),a
4896  0a69 4f            	clr	a
4897  0a6a 6b03          	ld	(OFST-3,sp),a
4898  0a6c 6b02          	ld	(OFST-4,sp),a
4899  0a6e 6b01          	ld	(OFST-5,sp),a
4900                     ; 722 			adress<<=8;
4902  0a70 96            	ldw	x,sp
4903  0a71 1c0001        	addw	x,#OFST-5
4904  0a74 a608          	ld	a,#8
4905  0a76 cd0000        	call	c_lglsh
4907                     ; 723 			adress+=UIB[4];
4909  0a79 c60004        	ld	a,_UIB+4
4910  0a7c 96            	ldw	x,sp
4911  0a7d 1c0001        	addw	x,#OFST-5
4912  0a80 88            	push	a
4913  0a81 cd0000        	call	c_lgadc
4915  0a84 84            	pop	a
4916                     ; 724 			adress<<=8;
4918  0a85 96            	ldw	x,sp
4919  0a86 1c0001        	addw	x,#OFST-5
4920  0a89 a608          	ld	a,#8
4921  0a8b cd0000        	call	c_lglsh
4923                     ; 725 			adress+=UIB[3];
4925  0a8e c60003        	ld	a,_UIB+3
4926  0a91 96            	ldw	x,sp
4927  0a92 1c0001        	addw	x,#OFST-5
4928  0a95 88            	push	a
4929  0a96 cd0000        	call	c_lgadc
4931  0a99 84            	pop	a
4932                     ; 726 			adress<<=8;
4934  0a9a 96            	ldw	x,sp
4935  0a9b 1c0001        	addw	x,#OFST-5
4936  0a9e a608          	ld	a,#8
4937  0aa0 cd0000        	call	c_lglsh
4939                     ; 727 			adress+=UIB[2];
4941  0aa3 c60002        	ld	a,_UIB+2
4942  0aa6 96            	ldw	x,sp
4943  0aa7 1c0001        	addw	x,#OFST-5
4944  0aaa 88            	push	a
4945  0aab cd0000        	call	c_lgadc
4947  0aae 84            	pop	a
4948                     ; 729 			ST_WREN();
4950  0aaf cd0ccc        	call	_ST_WREN
4952                     ; 730 			delay_ms(100);
4954  0ab2 ae0064        	ldw	x,#100
4955  0ab5 cd005c        	call	_delay_ms
4957                     ; 731 			ST_WRITE(adress,256,buff);		
4959  0ab8 ae0050        	ldw	x,#_buff
4960  0abb 89            	pushw	x
4961  0abc ae0100        	ldw	x,#256
4962  0abf 89            	pushw	x
4963  0ac0 1e07          	ldw	x,(OFST+1,sp)
4964  0ac2 89            	pushw	x
4965  0ac3 1e07          	ldw	x,(OFST+1,sp)
4966  0ac5 89            	pushw	x
4967  0ac6 cd0cda        	call	_ST_WRITE
4969  0ac9 5b08          	addw	sp,#8
4970  0acb ac980b98      	jpf	L5202
4971  0acf               L3132:
4972                     ; 736 	else if(UIB[1]==93)
4974  0acf c60001        	ld	a,_UIB+1
4975  0ad2 a15d          	cp	a,#93
4976  0ad4 2703          	jreq	L401
4977  0ad6 cc0b73        	jp	L7332
4978  0ad9               L401:
4979                     ; 742 		if(memory_manufacturer=='A') 
4981  0ad9 b6bc          	ld	a,_memory_manufacturer
4982  0adb a141          	cp	a,#65
4983  0add 2608          	jrne	L1432
4984                     ; 744 			DF_buffer_to_page_er(/*UIB[2],*/UIB[3]);
4986  0adf c60003        	ld	a,_UIB+3
4987  0ae2 5f            	clrw	x
4988  0ae3 97            	ld	xl,a
4989  0ae4 cd0e05        	call	_DF_buffer_to_page_er
4991  0ae7               L1432:
4992                     ; 746 		if(memory_manufacturer=='S') 
4994  0ae7 b6bc          	ld	a,_memory_manufacturer
4995  0ae9 a153          	cp	a,#83
4996  0aeb 2703          	jreq	L601
4997  0aed cc0b98        	jp	L5202
4998  0af0               L601:
4999                     ; 748 			for(i=0;i<256;i++) 
5001  0af0 5f            	clrw	x
5002  0af1 1f05          	ldw	(OFST-1,sp),x
5003  0af3               L5432:
5004                     ; 750 				buff[i]=(char)(255-i);
5006  0af3 a6ff          	ld	a,#255
5007  0af5 1006          	sub	a,(OFST+0,sp)
5008  0af7 1e05          	ldw	x,(OFST-1,sp)
5009  0af9 d70050        	ld	(_buff,x),a
5010                     ; 748 			for(i=0;i<256;i++) 
5012  0afc 1e05          	ldw	x,(OFST-1,sp)
5013  0afe 1c0001        	addw	x,#1
5014  0b01 1f05          	ldw	(OFST-1,sp),x
5017  0b03 1e05          	ldw	x,(OFST-1,sp)
5018  0b05 a30100        	cpw	x,#256
5019  0b08 25e9          	jrult	L5432
5020                     ; 752 			adress=UIB[5];
5022  0b0a c60005        	ld	a,_UIB+5
5023  0b0d 6b04          	ld	(OFST-2,sp),a
5024  0b0f 4f            	clr	a
5025  0b10 6b03          	ld	(OFST-3,sp),a
5026  0b12 6b02          	ld	(OFST-4,sp),a
5027  0b14 6b01          	ld	(OFST-5,sp),a
5028                     ; 753 			adress<<=8;
5030  0b16 96            	ldw	x,sp
5031  0b17 1c0001        	addw	x,#OFST-5
5032  0b1a a608          	ld	a,#8
5033  0b1c cd0000        	call	c_lglsh
5035                     ; 754 			adress+=UIB[4];
5037  0b1f c60004        	ld	a,_UIB+4
5038  0b22 96            	ldw	x,sp
5039  0b23 1c0001        	addw	x,#OFST-5
5040  0b26 88            	push	a
5041  0b27 cd0000        	call	c_lgadc
5043  0b2a 84            	pop	a
5044                     ; 755 			adress<<=8;
5046  0b2b 96            	ldw	x,sp
5047  0b2c 1c0001        	addw	x,#OFST-5
5048  0b2f a608          	ld	a,#8
5049  0b31 cd0000        	call	c_lglsh
5051                     ; 756 			adress+=UIB[3];
5053  0b34 c60003        	ld	a,_UIB+3
5054  0b37 96            	ldw	x,sp
5055  0b38 1c0001        	addw	x,#OFST-5
5056  0b3b 88            	push	a
5057  0b3c cd0000        	call	c_lgadc
5059  0b3f 84            	pop	a
5060                     ; 757 			adress<<=8;
5062  0b40 96            	ldw	x,sp
5063  0b41 1c0001        	addw	x,#OFST-5
5064  0b44 a608          	ld	a,#8
5065  0b46 cd0000        	call	c_lglsh
5067                     ; 758 			adress+=UIB[2];
5069  0b49 c60002        	ld	a,_UIB+2
5070  0b4c 96            	ldw	x,sp
5071  0b4d 1c0001        	addw	x,#OFST-5
5072  0b50 88            	push	a
5073  0b51 cd0000        	call	c_lgadc
5075  0b54 84            	pop	a
5076                     ; 760 			ST_WREN();
5078  0b55 cd0ccc        	call	_ST_WREN
5080                     ; 761 			delay_ms(100);
5082  0b58 ae0064        	ldw	x,#100
5083  0b5b cd005c        	call	_delay_ms
5085                     ; 762 			ST_WRITE(adress,256,buff);		
5087  0b5e ae0050        	ldw	x,#_buff
5088  0b61 89            	pushw	x
5089  0b62 ae0100        	ldw	x,#256
5090  0b65 89            	pushw	x
5091  0b66 1e07          	ldw	x,(OFST+1,sp)
5092  0b68 89            	pushw	x
5093  0b69 1e07          	ldw	x,(OFST+1,sp)
5094  0b6b 89            	pushw	x
5095  0b6c cd0cda        	call	_ST_WRITE
5097  0b6f 5b08          	addw	sp,#8
5098  0b71 2025          	jra	L5202
5099  0b73               L7332:
5100                     ; 767 	else if(UIB[1]==100) 
5102  0b73 c60001        	ld	a,_UIB+1
5103  0b76 a164          	cp	a,#100
5104  0b78 2613          	jrne	L5532
5105                     ; 771 		rele_cnt=10;
5107  0b7a ae000a        	ldw	x,#10
5108  0b7d bf05          	ldw	_rele_cnt,x
5109                     ; 772 		ST_WREN();
5111  0b7f cd0ccc        	call	_ST_WREN
5113                     ; 773 		delay_ms(100);
5115  0b82 ae0064        	ldw	x,#100
5116  0b85 cd005c        	call	_delay_ms
5118                     ; 774 		ST_bulk_erase();
5120  0b88 cd0ca6        	call	_ST_bulk_erase
5123  0b8b 200b          	jra	L5202
5124  0b8d               L5532:
5125                     ; 779 	else if(UIB[1]==101) 
5127  0b8d c60001        	ld	a,_UIB+1
5128  0b90 a165          	cp	a,#101
5129  0b92 2604          	jrne	L5202
5130                     ; 781 		bSTART=1;    
5132  0b94 7210000e      	bset	_bSTART
5133  0b98               L5202:
5134                     ; 785 }
5137  0b98 5b06          	addw	sp,#6
5138  0b9a 81            	ret
5175                     ; 788 void putchar(char c)
5175                     ; 789 {
5176                     	switch	.text
5177  0b9b               _putchar:
5179  0b9b 88            	push	a
5180       00000000      OFST:	set	0
5183  0b9c               L3042:
5184                     ; 790 while (tx_counter == TX_BUFFER_SIZE);
5186  0b9c b622          	ld	a,_tx_counter
5187  0b9e a150          	cp	a,#80
5188  0ba0 27fa          	jreq	L3042
5189                     ; 792 if (tx_counter || ((UART1->SR & UART1_SR_TXE)==0))
5191  0ba2 3d22          	tnz	_tx_counter
5192  0ba4 2607          	jrne	L1142
5194  0ba6 c65230        	ld	a,21040
5195  0ba9 a580          	bcp	a,#128
5196  0bab 261d          	jrne	L7042
5197  0bad               L1142:
5198                     ; 794    tx_buffer[tx_wr_index]=c;
5200  0bad 5f            	clrw	x
5201  0bae b621          	ld	a,_tx_wr_index
5202  0bb0 2a01          	jrpl	L211
5203  0bb2 53            	cplw	x
5204  0bb3               L211:
5205  0bb3 97            	ld	xl,a
5206  0bb4 7b01          	ld	a,(OFST+1,sp)
5207  0bb6 e704          	ld	(_tx_buffer,x),a
5208                     ; 795    if (++tx_wr_index == TX_BUFFER_SIZE) tx_wr_index=0;
5210  0bb8 3c21          	inc	_tx_wr_index
5211  0bba b621          	ld	a,_tx_wr_index
5212  0bbc a150          	cp	a,#80
5213  0bbe 2602          	jrne	L3142
5216  0bc0 3f21          	clr	_tx_wr_index
5217  0bc2               L3142:
5218                     ; 796    ++tx_counter;
5220  0bc2 3c22          	inc	_tx_counter
5222  0bc4               L5142:
5223                     ; 800 UART1->CR2|= UART1_CR2_TIEN;
5225  0bc4 721e5235      	bset	21045,#7
5226                     ; 802 }
5229  0bc8 84            	pop	a
5230  0bc9 81            	ret
5231  0bca               L7042:
5232                     ; 798 else UART1->DR=c;
5234  0bca 7b01          	ld	a,(OFST+1,sp)
5235  0bcc c75231        	ld	21041,a
5236  0bcf 20f3          	jra	L5142
5259                     ; 805 void spi_init(void){
5260                     	switch	.text
5261  0bd1               _spi_init:
5265                     ; 807 	GPIOA->DDR|=(1<<3);
5267  0bd1 72165002      	bset	20482,#3
5268                     ; 808 	GPIOA->CR1|=(1<<3);
5270  0bd5 72165003      	bset	20483,#3
5271                     ; 809 	GPIOA->CR2&=~(1<<3);
5273  0bd9 72175004      	bres	20484,#3
5274                     ; 810 	GPIOA->ODR|=(1<<3);	
5276  0bdd 72165000      	bset	20480,#3
5277                     ; 813 	GPIOB->DDR|=(1<<5);
5279  0be1 721a5007      	bset	20487,#5
5280                     ; 814 	GPIOB->CR1|=(1<<5);
5282  0be5 721a5008      	bset	20488,#5
5283                     ; 815 	GPIOB->CR2&=~(1<<5);
5285  0be9 721b5009      	bres	20489,#5
5286                     ; 816 	GPIOB->ODR|=(1<<5);	
5288  0bed 721a5005      	bset	20485,#5
5289                     ; 818 	GPIOC->DDR|=(1<<3);
5291  0bf1 7216500c      	bset	20492,#3
5292                     ; 819 	GPIOC->CR1|=(1<<3);
5294  0bf5 7216500d      	bset	20493,#3
5295                     ; 820 	GPIOC->CR2&=~(1<<3);
5297  0bf9 7217500e      	bres	20494,#3
5298                     ; 821 	GPIOC->ODR|=(1<<3);	
5300  0bfd 7216500a      	bset	20490,#3
5301                     ; 823 	GPIOC->DDR|=(1<<5);
5303  0c01 721a500c      	bset	20492,#5
5304                     ; 824 	GPIOC->CR1|=(1<<5);
5306  0c05 721a500d      	bset	20493,#5
5307                     ; 825 	GPIOC->CR2|=(1<<5);
5309  0c09 721a500e      	bset	20494,#5
5310                     ; 826 	GPIOC->ODR|=(1<<5);	
5312  0c0d 721a500a      	bset	20490,#5
5313                     ; 828 	GPIOC->DDR|=(1<<6);
5315  0c11 721c500c      	bset	20492,#6
5316                     ; 829 	GPIOC->CR1|=(1<<6);
5318  0c15 721c500d      	bset	20493,#6
5319                     ; 830 	GPIOC->CR2|=(1<<6);
5321  0c19 721c500e      	bset	20494,#6
5322                     ; 831 	GPIOC->ODR|=(1<<6);	
5324  0c1d 721c500a      	bset	20490,#6
5325                     ; 833 	GPIOC->DDR&=~(1<<7);
5327  0c21 721f500c      	bres	20492,#7
5328                     ; 834 	GPIOC->CR1&=~(1<<7);
5330  0c25 721f500d      	bres	20493,#7
5331                     ; 835 	GPIOC->CR2&=~(1<<7);
5333  0c29 721f500e      	bres	20494,#7
5334                     ; 836 	GPIOC->ODR|=(1<<7);	
5336  0c2d 721e500a      	bset	20490,#7
5337                     ; 838 	SPI->CR1= /*SPI_CR1_LSBFIRST |*/
5337                     ; 839 			SPI_CR1_SPE | 
5337                     ; 840 			( (4<< 3) & SPI_CR1_BR ) |
5337                     ; 841 			SPI_CR1_MSTR |
5337                     ; 842 			SPI_CR1_CPOL |
5337                     ; 843 			SPI_CR1_CPHA; 
5339  0c31 35675200      	mov	20992,#103
5340                     ; 845 	SPI->CR2= SPI_CR2_SSM | SPI_CR2_SSI;
5342  0c35 35035201      	mov	20993,#3
5343                     ; 846 	SPI->ICR= 0;	
5345  0c39 725f5202      	clr	20994
5346                     ; 847 }
5349  0c3d 81            	ret
5392                     ; 850 char spi(char in){
5393                     	switch	.text
5394  0c3e               _spi:
5396  0c3e 88            	push	a
5397  0c3f 88            	push	a
5398       00000001      OFST:	set	1
5401  0c40               L3542:
5402                     ; 852 	while(!((SPI->SR)&SPI_SR_TXE));
5404  0c40 c65203        	ld	a,20995
5405  0c43 a502          	bcp	a,#2
5406  0c45 27f9          	jreq	L3542
5407                     ; 853 	SPI->DR=in;
5409  0c47 7b02          	ld	a,(OFST+1,sp)
5410  0c49 c75204        	ld	20996,a
5412  0c4c               L3642:
5413                     ; 854 	while(!((SPI->SR)&SPI_SR_RXNE));
5415  0c4c c65203        	ld	a,20995
5416  0c4f a501          	bcp	a,#1
5417  0c51 27f9          	jreq	L3642
5418                     ; 855 	c=SPI->DR;	
5420  0c53 c65204        	ld	a,20996
5421  0c56 6b01          	ld	(OFST+0,sp),a
5422                     ; 856 	return c;
5424  0c58 7b01          	ld	a,(OFST+0,sp)
5427  0c5a 85            	popw	x
5428  0c5b 81            	ret
5494                     ; 860 long ST_RDID_read(void)
5494                     ; 861 {
5495                     	switch	.text
5496  0c5c               _ST_RDID_read:
5498  0c5c 5204          	subw	sp,#4
5499       00000004      OFST:	set	4
5502                     ; 864 d0=0;
5504  0c5e 0f04          	clr	(OFST+0,sp)
5505                     ; 865 d1=0;
5507                     ; 866 d2=0;
5509                     ; 867 d3=0;
5511                     ; 869 ST_CS_ON
5513  0c60 721b5005      	bres	20485,#5
5514                     ; 870 spi(0x9f);
5516  0c64 a69f          	ld	a,#159
5517  0c66 add6          	call	_spi
5519                     ; 871 mdr0=spi(0xff);
5521  0c68 a6ff          	ld	a,#255
5522  0c6a add2          	call	_spi
5524  0c6c b718          	ld	_mdr0,a
5525                     ; 872 mdr1=spi(0xff);
5527  0c6e a6ff          	ld	a,#255
5528  0c70 adcc          	call	_spi
5530  0c72 b717          	ld	_mdr1,a
5531                     ; 873 mdr2=spi(0xff);
5533  0c74 a6ff          	ld	a,#255
5534  0c76 adc6          	call	_spi
5536  0c78 b716          	ld	_mdr2,a
5537                     ; 874 mdr3=spi(0xff);
5539  0c7a a6ff          	ld	a,#255
5540  0c7c adc0          	call	_spi
5542  0c7e b715          	ld	_mdr3,a
5543                     ; 877 ST_CS_OFF
5545  0c80 721a5005      	bset	20485,#5
5546                     ; 878 return  *((long*)&d0);
5548  0c84 96            	ldw	x,sp
5549  0c85 1c0004        	addw	x,#OFST+0
5550  0c88 cd0000        	call	c_ltor
5554  0c8b 5b04          	addw	sp,#4
5555  0c8d 81            	ret
5590                     ; 882 char ST_status_read(void)
5590                     ; 883 {
5591                     	switch	.text
5592  0c8e               _ST_status_read:
5594  0c8e 88            	push	a
5595       00000001      OFST:	set	1
5598                     ; 887 ST_CS_ON
5600  0c8f 721b5005      	bres	20485,#5
5601                     ; 888 spi(0x05);
5603  0c93 a605          	ld	a,#5
5604  0c95 ada7          	call	_spi
5606                     ; 889 d0=spi(0xff);
5608  0c97 a6ff          	ld	a,#255
5609  0c99 ada3          	call	_spi
5611  0c9b 6b01          	ld	(OFST+0,sp),a
5612                     ; 891 ST_CS_OFF
5614  0c9d 721a5005      	bset	20485,#5
5615                     ; 892 return d0;
5617  0ca1 7b01          	ld	a,(OFST+0,sp)
5620  0ca3 5b01          	addw	sp,#1
5621  0ca5 81            	ret
5647                     ; 896 void ST_bulk_erase(void)
5647                     ; 897 {
5648                     	switch	.text
5649  0ca6               _ST_bulk_erase:
5653                     ; 898 ST_CS_ON
5655  0ca6 721b5005      	bres	20485,#5
5656                     ; 899 spi(0xC7);
5658  0caa a6c7          	ld	a,#199
5659  0cac ad90          	call	_spi
5661                     ; 902 bERASE_IN_PROGRESS=1;
5663  0cae 72100001      	bset	_bERASE_IN_PROGRESS
5664                     ; 903 uart_out (3,CMND,44,33,0,0,0);
5666  0cb2 4b00          	push	#0
5667  0cb4 4b00          	push	#0
5668  0cb6 4b00          	push	#0
5669  0cb8 4b21          	push	#33
5670  0cba 4b2c          	push	#44
5671  0cbc ae0016        	ldw	x,#22
5672  0cbf a603          	ld	a,#3
5673  0cc1 95            	ld	xh,a
5674  0cc2 cd00ce        	call	_uart_out
5676  0cc5 5b05          	addw	sp,#5
5677                     ; 904 ST_CS_OFF
5679  0cc7 721a5005      	bset	20485,#5
5680                     ; 905 }
5683  0ccb 81            	ret
5707                     ; 907 void ST_WREN(void)
5707                     ; 908 {
5708                     	switch	.text
5709  0ccc               _ST_WREN:
5713                     ; 910 ST_CS_ON
5715  0ccc 721b5005      	bres	20485,#5
5716                     ; 911 spi(0x06);
5718  0cd0 a606          	ld	a,#6
5719  0cd2 cd0c3e        	call	_spi
5721                     ; 913 ST_CS_OFF
5723  0cd5 721a5005      	bset	20485,#5
5724                     ; 914 }  
5727  0cd9 81            	ret
5817                     ; 917 void ST_WRITE(unsigned long memo_addr,unsigned short len, char* adr)
5817                     ; 918 {
5818                     	switch	.text
5819  0cda               _ST_WRITE:
5821  0cda 5205          	subw	sp,#5
5822       00000005      OFST:	set	5
5825                     ; 922 adr2=(char)(memo_addr>>16);
5827  0cdc 7b09          	ld	a,(OFST+4,sp)
5828  0cde 6b03          	ld	(OFST-2,sp),a
5829                     ; 923 adr1=(char)((memo_addr>>8)&0x00ff);
5831  0ce0 7b0a          	ld	a,(OFST+5,sp)
5832  0ce2 a4ff          	and	a,#255
5833  0ce4 6b02          	ld	(OFST-3,sp),a
5834                     ; 924 adr0=(char)((memo_addr)&0x00ff);
5836  0ce6 7b0b          	ld	a,(OFST+6,sp)
5837  0ce8 a4ff          	and	a,#255
5838  0cea 6b01          	ld	(OFST-4,sp),a
5839                     ; 925 ST_CS_ON
5841  0cec 721b5005      	bres	20485,#5
5842                     ; 927 spi(0x02);
5844  0cf0 a602          	ld	a,#2
5845  0cf2 cd0c3e        	call	_spi
5847                     ; 928 spi(adr2);
5849  0cf5 7b03          	ld	a,(OFST-2,sp)
5850  0cf7 cd0c3e        	call	_spi
5852                     ; 929 spi(adr1);
5854  0cfa 7b02          	ld	a,(OFST-3,sp)
5855  0cfc cd0c3e        	call	_spi
5857                     ; 930 spi(adr0);
5859  0cff 7b01          	ld	a,(OFST-4,sp)
5860  0d01 cd0c3e        	call	_spi
5862                     ; 932 for(i=0;i<len;i++)
5864  0d04 5f            	clrw	x
5865  0d05 1f04          	ldw	(OFST-1,sp),x
5867  0d07 2010          	jra	L1362
5868  0d09               L5262:
5869                     ; 934 	spi(adr[i]);
5871  0d09 1e0e          	ldw	x,(OFST+9,sp)
5872  0d0b 72fb04        	addw	x,(OFST-1,sp)
5873  0d0e f6            	ld	a,(x)
5874  0d0f cd0c3e        	call	_spi
5876                     ; 932 for(i=0;i<len;i++)
5878  0d12 1e04          	ldw	x,(OFST-1,sp)
5879  0d14 1c0001        	addw	x,#1
5880  0d17 1f04          	ldw	(OFST-1,sp),x
5881  0d19               L1362:
5884  0d19 1e04          	ldw	x,(OFST-1,sp)
5885  0d1b 130c          	cpw	x,(OFST+7,sp)
5886  0d1d 25ea          	jrult	L5262
5887                     ; 937 ST_CS_OFF
5889  0d1f 721a5005      	bset	20485,#5
5890                     ; 938 }
5893  0d23 5b05          	addw	sp,#5
5894  0d25 81            	ret
5984                     ; 941 void ST_READ(unsigned long memo_addr,unsigned short len, char* adr)
5984                     ; 942 {
5985                     	switch	.text
5986  0d26               _ST_READ:
5988  0d26 5205          	subw	sp,#5
5989       00000005      OFST:	set	5
5992                     ; 948 adr2=(char)(memo_addr>>16);
5994  0d28 7b09          	ld	a,(OFST+4,sp)
5995  0d2a 6b03          	ld	(OFST-2,sp),a
5996                     ; 949 adr1=(char)((memo_addr>>8)&0x00ff);
5998  0d2c 7b0a          	ld	a,(OFST+5,sp)
5999  0d2e a4ff          	and	a,#255
6000  0d30 6b02          	ld	(OFST-3,sp),a
6001                     ; 950 adr0=(char)((memo_addr)&0x00ff);
6003  0d32 7b0b          	ld	a,(OFST+6,sp)
6004  0d34 a4ff          	and	a,#255
6005  0d36 6b01          	ld	(OFST-4,sp),a
6006                     ; 951 ST_CS_ON
6008  0d38 721b5005      	bres	20485,#5
6009                     ; 952 spi(0x03);
6011  0d3c a603          	ld	a,#3
6012  0d3e cd0c3e        	call	_spi
6014                     ; 953 spi(adr2);
6016  0d41 7b03          	ld	a,(OFST-2,sp)
6017  0d43 cd0c3e        	call	_spi
6019                     ; 954 spi(adr1);
6021  0d46 7b02          	ld	a,(OFST-3,sp)
6022  0d48 cd0c3e        	call	_spi
6024                     ; 955 spi(adr0);
6026  0d4b 7b01          	ld	a,(OFST-4,sp)
6027  0d4d cd0c3e        	call	_spi
6029                     ; 957 for(i=0;i<len;i++)
6031  0d50 5f            	clrw	x
6032  0d51 1f04          	ldw	(OFST-1,sp),x
6034  0d53 2012          	jra	L7072
6035  0d55               L3072:
6036                     ; 959 	adr[i]=spi(0xff);
6038  0d55 a6ff          	ld	a,#255
6039  0d57 cd0c3e        	call	_spi
6041  0d5a 1e0e          	ldw	x,(OFST+9,sp)
6042  0d5c 72fb04        	addw	x,(OFST-1,sp)
6043  0d5f f7            	ld	(x),a
6044                     ; 957 for(i=0;i<len;i++)
6046  0d60 1e04          	ldw	x,(OFST-1,sp)
6047  0d62 1c0001        	addw	x,#1
6048  0d65 1f04          	ldw	(OFST-1,sp),x
6049  0d67               L7072:
6052  0d67 1e04          	ldw	x,(OFST-1,sp)
6053  0d69 130c          	cpw	x,(OFST+7,sp)
6054  0d6b 25e8          	jrult	L3072
6055                     ; 962 ST_CS_OFF
6057  0d6d 721a5005      	bset	20485,#5
6058                     ; 963 }
6061  0d71 5b05          	addw	sp,#5
6062  0d73 81            	ret
6128                     ; 967 long DF_mf_dev_read(void)
6128                     ; 968 {
6129                     	switch	.text
6130  0d74               _DF_mf_dev_read:
6132  0d74 5204          	subw	sp,#4
6133       00000004      OFST:	set	4
6136                     ; 971 d0=0;
6138  0d76 0f04          	clr	(OFST+0,sp)
6139                     ; 972 d1=0;
6141                     ; 973 d2=0;
6143                     ; 974 d3=0;
6145                     ; 976 CS_ON
6147  0d78 7217500a      	bres	20490,#3
6148                     ; 977 spi(0x9f);
6150  0d7c a69f          	ld	a,#159
6151  0d7e cd0c3e        	call	_spi
6153                     ; 978 mdr0=spi(0xff);
6155  0d81 a6ff          	ld	a,#255
6156  0d83 cd0c3e        	call	_spi
6158  0d86 b718          	ld	_mdr0,a
6159                     ; 979 mdr1=spi(0xff);
6161  0d88 a6ff          	ld	a,#255
6162  0d8a cd0c3e        	call	_spi
6164  0d8d b717          	ld	_mdr1,a
6165                     ; 980 mdr2=spi(0xff);
6167  0d8f a6ff          	ld	a,#255
6168  0d91 cd0c3e        	call	_spi
6170  0d94 b716          	ld	_mdr2,a
6171                     ; 981 mdr3=spi(0xff);  
6173  0d96 a6ff          	ld	a,#255
6174  0d98 cd0c3e        	call	_spi
6176  0d9b b715          	ld	_mdr3,a
6177                     ; 983 CS_OFF
6179  0d9d 7216500a      	bset	20490,#3
6180                     ; 984 return  *((long*)&d0);
6182  0da1 96            	ldw	x,sp
6183  0da2 1c0004        	addw	x,#OFST+0
6184  0da5 cd0000        	call	c_ltor
6188  0da8 5b04          	addw	sp,#4
6189  0daa 81            	ret
6213                     ; 988 void DF_memo_to_256(void)
6213                     ; 989 {
6214                     	switch	.text
6215  0dab               _DF_memo_to_256:
6219                     ; 991 CS_ON
6221  0dab 7217500a      	bres	20490,#3
6222                     ; 992 spi(0x3d);
6224  0daf a63d          	ld	a,#61
6225  0db1 cd0c3e        	call	_spi
6227                     ; 993 spi(0x2a); 
6229  0db4 a62a          	ld	a,#42
6230  0db6 cd0c3e        	call	_spi
6232                     ; 994 spi(0x80);
6234  0db9 a680          	ld	a,#128
6235  0dbb cd0c3e        	call	_spi
6237                     ; 995 spi(0xa6);
6239  0dbe a6a6          	ld	a,#166
6240  0dc0 cd0c3e        	call	_spi
6242                     ; 997 CS_OFF
6244  0dc3 7216500a      	bset	20490,#3
6245                     ; 998 }  
6248  0dc7 81            	ret
6283                     ; 1003 char DF_status_read(void)
6283                     ; 1004 {
6284                     	switch	.text
6285  0dc8               _DF_status_read:
6287  0dc8 88            	push	a
6288       00000001      OFST:	set	1
6291                     ; 1008 CS_ON
6293  0dc9 7217500a      	bres	20490,#3
6294                     ; 1009 spi(0xd7);
6296  0dcd a6d7          	ld	a,#215
6297  0dcf cd0c3e        	call	_spi
6299                     ; 1010 d0=spi(0xff);
6301  0dd2 a6ff          	ld	a,#255
6302  0dd4 cd0c3e        	call	_spi
6304  0dd7 6b01          	ld	(OFST+0,sp),a
6305                     ; 1012 CS_OFF
6307  0dd9 7216500a      	bset	20490,#3
6308                     ; 1013 return d0;
6310  0ddd 7b01          	ld	a,(OFST+0,sp)
6313  0ddf 5b01          	addw	sp,#1
6314  0de1 81            	ret
6358                     ; 1017 void DF_page_to_buffer(unsigned page_addr)
6358                     ; 1018 {
6359                     	switch	.text
6360  0de2               _DF_page_to_buffer:
6362  0de2 89            	pushw	x
6363  0de3 88            	push	a
6364       00000001      OFST:	set	1
6367                     ; 1021 d0=0x53; 
6369                     ; 1025 CS_ON
6371  0de4 7217500a      	bres	20490,#3
6372                     ; 1026 spi(d0);
6374  0de8 a653          	ld	a,#83
6375  0dea cd0c3e        	call	_spi
6377                     ; 1027 spi(page_addr/256/**(((char*)&page_addr)+1)*/);
6379  0ded 7b02          	ld	a,(OFST+1,sp)
6380  0def cd0c3e        	call	_spi
6382                     ; 1028 spi(page_addr%256/**((char*)&page_addr)*/);
6384  0df2 7b03          	ld	a,(OFST+2,sp)
6385  0df4 a4ff          	and	a,#255
6386  0df6 cd0c3e        	call	_spi
6388                     ; 1029 spi(0xff);
6390  0df9 a6ff          	ld	a,#255
6391  0dfb cd0c3e        	call	_spi
6393                     ; 1031 CS_OFF
6395  0dfe 7216500a      	bset	20490,#3
6396                     ; 1032 }
6399  0e02 5b03          	addw	sp,#3
6400  0e04 81            	ret
6445                     ; 1035 void DF_buffer_to_page_er(/*char buff,*/unsigned page_addr)
6445                     ; 1036 {
6446                     	switch	.text
6447  0e05               _DF_buffer_to_page_er:
6449  0e05 89            	pushw	x
6450  0e06 88            	push	a
6451       00000001      OFST:	set	1
6454                     ; 1039 d0=0x83; 
6456                     ; 1042 CS_ON
6458  0e07 7217500a      	bres	20490,#3
6459                     ; 1043 spi(d0);
6461  0e0b a683          	ld	a,#131
6462  0e0d cd0c3e        	call	_spi
6464                     ; 1044 spi(page_addr/256/**(((char*)&page_addr)+1)*/);
6466  0e10 7b02          	ld	a,(OFST+1,sp)
6467  0e12 cd0c3e        	call	_spi
6469                     ; 1045 spi(page_addr%256/**((char*)&page_addr)*/);
6471  0e15 7b03          	ld	a,(OFST+2,sp)
6472  0e17 a4ff          	and	a,#255
6473  0e19 cd0c3e        	call	_spi
6475                     ; 1046 spi(0xff);
6477  0e1c a6ff          	ld	a,#255
6478  0e1e cd0c3e        	call	_spi
6480                     ; 1048 CS_OFF
6482  0e21 7216500a      	bset	20490,#3
6483                     ; 1049 }
6486  0e25 5b03          	addw	sp,#3
6487  0e27 81            	ret
6559                     ; 1052 void DF_buffer_read(unsigned buff_addr,unsigned len, char* adr)
6559                     ; 1053 {
6560                     	switch	.text
6561  0e28               _DF_buffer_read:
6563  0e28 89            	pushw	x
6564  0e29 5203          	subw	sp,#3
6565       00000003      OFST:	set	3
6568                     ; 1057 d0=0x54; 
6570                     ; 1059 CS_ON
6572  0e2b 7217500a      	bres	20490,#3
6573                     ; 1060 spi(d0);
6575  0e2f a654          	ld	a,#84
6576  0e31 cd0c3e        	call	_spi
6578                     ; 1061 spi(0xff);
6580  0e34 a6ff          	ld	a,#255
6581  0e36 cd0c3e        	call	_spi
6583                     ; 1062 spi(buff_addr/256/**(((char*)&buff_addr)+1)*/);
6585  0e39 7b04          	ld	a,(OFST+1,sp)
6586  0e3b cd0c3e        	call	_spi
6588                     ; 1063 spi(buff_addr%256/**((char*)&buff_addr)*/);
6590  0e3e 7b05          	ld	a,(OFST+2,sp)
6591  0e40 a4ff          	and	a,#255
6592  0e42 cd0c3e        	call	_spi
6594                     ; 1064 spi(0xff);
6596  0e45 a6ff          	ld	a,#255
6597  0e47 cd0c3e        	call	_spi
6599                     ; 1065 for(i=0;i<len;i++)
6601  0e4a 5f            	clrw	x
6602  0e4b 1f02          	ldw	(OFST-1,sp),x
6604  0e4d 2012          	jra	L1013
6605  0e4f               L5703:
6606                     ; 1067 	adr[i]=spi(0xff);
6608  0e4f a6ff          	ld	a,#255
6609  0e51 cd0c3e        	call	_spi
6611  0e54 1e0a          	ldw	x,(OFST+7,sp)
6612  0e56 72fb02        	addw	x,(OFST-1,sp)
6613  0e59 f7            	ld	(x),a
6614                     ; 1065 for(i=0;i<len;i++)
6616  0e5a 1e02          	ldw	x,(OFST-1,sp)
6617  0e5c 1c0001        	addw	x,#1
6618  0e5f 1f02          	ldw	(OFST-1,sp),x
6619  0e61               L1013:
6622  0e61 1e02          	ldw	x,(OFST-1,sp)
6623  0e63 1308          	cpw	x,(OFST+5,sp)
6624  0e65 25e8          	jrult	L5703
6625                     ; 1070 CS_OFF
6627  0e67 7216500a      	bset	20490,#3
6628                     ; 1071 }
6631  0e6b 5b05          	addw	sp,#5
6632  0e6d 81            	ret
6704                     ; 1074 void DF_buffer_write(/*char buff,*/unsigned buff_addr,unsigned len, char* adr)
6704                     ; 1075 {
6705                     	switch	.text
6706  0e6e               _DF_buffer_write:
6708  0e6e 89            	pushw	x
6709  0e6f 5203          	subw	sp,#3
6710       00000003      OFST:	set	3
6713                     ; 1079 d0=0x84; 
6715                     ; 1081 CS_ON
6717  0e71 7217500a      	bres	20490,#3
6718                     ; 1082 spi(d0);
6720  0e75 a684          	ld	a,#132
6721  0e77 cd0c3e        	call	_spi
6723                     ; 1083 spi(0xff);
6725  0e7a a6ff          	ld	a,#255
6726  0e7c cd0c3e        	call	_spi
6728                     ; 1084 spi(buff_addr/256/**(((char*)&buff_addr)+1)*/);
6730  0e7f 7b04          	ld	a,(OFST+1,sp)
6731  0e81 cd0c3e        	call	_spi
6733                     ; 1085 spi(buff_addr%256/**((char*)&buff_addr)*/);
6735  0e84 7b05          	ld	a,(OFST+2,sp)
6736  0e86 a4ff          	and	a,#255
6737  0e88 cd0c3e        	call	_spi
6739                     ; 1087 for(i=0;i<len;i++)
6741  0e8b 5f            	clrw	x
6742  0e8c 1f02          	ldw	(OFST-1,sp),x
6744  0e8e 2010          	jra	L7413
6745  0e90               L3413:
6746                     ; 1089 	spi(adr[i]);
6748  0e90 1e0a          	ldw	x,(OFST+7,sp)
6749  0e92 72fb02        	addw	x,(OFST-1,sp)
6750  0e95 f6            	ld	a,(x)
6751  0e96 cd0c3e        	call	_spi
6753                     ; 1087 for(i=0;i<len;i++)
6755  0e99 1e02          	ldw	x,(OFST-1,sp)
6756  0e9b 1c0001        	addw	x,#1
6757  0e9e 1f02          	ldw	(OFST-1,sp),x
6758  0ea0               L7413:
6761  0ea0 1e02          	ldw	x,(OFST-1,sp)
6762  0ea2 1308          	cpw	x,(OFST+5,sp)
6763  0ea4 25ea          	jrult	L3413
6764                     ; 1092 CS_OFF
6766  0ea6 7216500a      	bset	20490,#3
6767                     ; 1093 }
6770  0eaa 5b05          	addw	sp,#5
6771  0eac 81            	ret
6794                     ; 1115 void gpio_init(void){
6795                     	switch	.text
6796  0ead               _gpio_init:
6800                     ; 1125 	GPIOD->DDR|=(1<<2);
6802  0ead 72145011      	bset	20497,#2
6803                     ; 1126 	GPIOD->CR1|=(1<<2);
6805  0eb1 72145012      	bset	20498,#2
6806                     ; 1127 	GPIOD->CR2|=(1<<2);
6808  0eb5 72145013      	bset	20499,#2
6809                     ; 1128 	GPIOD->ODR&=~(1<<2);
6811  0eb9 7215500f      	bres	20495,#2
6812                     ; 1130 	GPIOD->DDR|=(1<<4);
6814  0ebd 72185011      	bset	20497,#4
6815                     ; 1131 	GPIOD->CR1|=(1<<4);
6817  0ec1 72185012      	bset	20498,#4
6818                     ; 1132 	GPIOD->CR2&=~(1<<4);
6820  0ec5 72195013      	bres	20499,#4
6821                     ; 1134 	GPIOC->DDR&=~(1<<4);
6823  0ec9 7219500c      	bres	20492,#4
6824                     ; 1135 	GPIOC->CR1&=~(1<<4);
6826  0ecd 7219500d      	bres	20493,#4
6827                     ; 1136 	GPIOC->CR2&=~(1<<4);
6829  0ed1 7219500e      	bres	20494,#4
6830                     ; 1140 }
6833  0ed5 81            	ret
6885                     ; 1143 void uart_in(void)
6885                     ; 1144 {
6886                     	switch	.text
6887  0ed6               _uart_in:
6889  0ed6 89            	pushw	x
6890       00000002      OFST:	set	2
6893                     ; 1148 if(rx_buffer_overflow)
6895                     	btst	_rx_buffer_overflow
6896  0edc 240d          	jruge	L5023
6897                     ; 1150 	rx_wr_index=0;
6899  0ede 5f            	clrw	x
6900  0edf bf1c          	ldw	_rx_wr_index,x
6901                     ; 1151 	rx_rd_index=0;
6903  0ee1 5f            	clrw	x
6904  0ee2 bf1a          	ldw	_rx_rd_index,x
6905                     ; 1152 	rx_counter=0;
6907  0ee4 5f            	clrw	x
6908  0ee5 bf1e          	ldw	_rx_counter,x
6909                     ; 1153 	rx_buffer_overflow=0;
6911  0ee7 72110003      	bres	_rx_buffer_overflow
6912  0eeb               L5023:
6913                     ; 1156 if(rx_counter&&(rx_buffer[index_offset(rx_wr_index,-1)])==END)
6915  0eeb be1e          	ldw	x,_rx_counter
6916  0eed 2775          	jreq	L7023
6918  0eef aeffff        	ldw	x,#65535
6919  0ef2 89            	pushw	x
6920  0ef3 be1c          	ldw	x,_rx_wr_index
6921  0ef5 ad6f          	call	_index_offset
6923  0ef7 5b02          	addw	sp,#2
6924  0ef9 e654          	ld	a,(_rx_buffer,x)
6925  0efb a10a          	cp	a,#10
6926  0efd 2665          	jrne	L7023
6927                     ; 1161 	temp=rx_buffer[index_offset(rx_wr_index,-3)];
6929  0eff aefffd        	ldw	x,#65533
6930  0f02 89            	pushw	x
6931  0f03 be1c          	ldw	x,_rx_wr_index
6932  0f05 ad5f          	call	_index_offset
6934  0f07 5b02          	addw	sp,#2
6935  0f09 e654          	ld	a,(_rx_buffer,x)
6936  0f0b 6b01          	ld	(OFST-1,sp),a
6937                     ; 1162     	if(temp<100) 
6939  0f0d 7b01          	ld	a,(OFST-1,sp)
6940  0f0f a164          	cp	a,#100
6941  0f11 2451          	jruge	L7023
6942                     ; 1165     		if(control_check(index_offset(rx_wr_index,-1)))
6944  0f13 aeffff        	ldw	x,#65535
6945  0f16 89            	pushw	x
6946  0f17 be1c          	ldw	x,_rx_wr_index
6947  0f19 ad4b          	call	_index_offset
6949  0f1b 5b02          	addw	sp,#2
6950  0f1d 9f            	ld	a,xl
6951  0f1e ad6e          	call	_control_check
6953  0f20 4d            	tnz	a
6954  0f21 2741          	jreq	L7023
6955                     ; 1168     			rx_rd_index=index_offset(rx_wr_index,-3-temp);
6957  0f23 a6ff          	ld	a,#255
6958  0f25 97            	ld	xl,a
6959  0f26 a6fd          	ld	a,#253
6960  0f28 1001          	sub	a,(OFST-1,sp)
6961  0f2a 2401          	jrnc	L651
6962  0f2c 5a            	decw	x
6963  0f2d               L651:
6964  0f2d 02            	rlwa	x,a
6965  0f2e 89            	pushw	x
6966  0f2f 01            	rrwa	x,a
6967  0f30 be1c          	ldw	x,_rx_wr_index
6968  0f32 ad32          	call	_index_offset
6970  0f34 5b02          	addw	sp,#2
6971  0f36 bf1a          	ldw	_rx_rd_index,x
6972                     ; 1169     			for(i=0;i<temp;i++)
6974  0f38 0f02          	clr	(OFST+0,sp)
6976  0f3a 2018          	jra	L1223
6977  0f3c               L5123:
6978                     ; 1171 				UIB[i]=rx_buffer[index_offset(rx_rd_index,i)];
6980  0f3c 7b02          	ld	a,(OFST+0,sp)
6981  0f3e 5f            	clrw	x
6982  0f3f 97            	ld	xl,a
6983  0f40 89            	pushw	x
6984  0f41 7b04          	ld	a,(OFST+2,sp)
6985  0f43 5f            	clrw	x
6986  0f44 97            	ld	xl,a
6987  0f45 89            	pushw	x
6988  0f46 be1a          	ldw	x,_rx_rd_index
6989  0f48 ad1c          	call	_index_offset
6991  0f4a 5b02          	addw	sp,#2
6992  0f4c e654          	ld	a,(_rx_buffer,x)
6993  0f4e 85            	popw	x
6994  0f4f d70000        	ld	(_UIB,x),a
6995                     ; 1169     			for(i=0;i<temp;i++)
6997  0f52 0c02          	inc	(OFST+0,sp)
6998  0f54               L1223:
7001  0f54 7b02          	ld	a,(OFST+0,sp)
7002  0f56 1101          	cp	a,(OFST-1,sp)
7003  0f58 25e2          	jrult	L5123
7004                     ; 1173 			rx_rd_index=rx_wr_index;
7006  0f5a be1c          	ldw	x,_rx_wr_index
7007  0f5c bf1a          	ldw	_rx_rd_index,x
7008                     ; 1174 			rx_counter=0;
7010  0f5e 5f            	clrw	x
7011  0f5f bf1e          	ldw	_rx_counter,x
7012                     ; 1184 			uart_in_an();
7014  0f61 cd0238        	call	_uart_in_an
7016  0f64               L7023:
7017                     ; 1193 }
7020  0f64 85            	popw	x
7021  0f65 81            	ret
7064                     ; 1196 signed short index_offset (signed short index,signed short offset)
7064                     ; 1197 {
7065                     	switch	.text
7066  0f66               _index_offset:
7068  0f66 89            	pushw	x
7069       00000000      OFST:	set	0
7072                     ; 1198 index=index+offset;
7074  0f67 1e01          	ldw	x,(OFST+1,sp)
7075  0f69 72fb05        	addw	x,(OFST+5,sp)
7076  0f6c 1f01          	ldw	(OFST+1,sp),x
7077                     ; 1199 if(index>=RX_BUFFER_SIZE) index-=RX_BUFFER_SIZE; 
7079  0f6e 9c            	rvf
7080  0f6f 1e01          	ldw	x,(OFST+1,sp)
7081  0f71 a30064        	cpw	x,#100
7082  0f74 2f07          	jrslt	L7423
7085  0f76 1e01          	ldw	x,(OFST+1,sp)
7086  0f78 1d0064        	subw	x,#100
7087  0f7b 1f01          	ldw	(OFST+1,sp),x
7088  0f7d               L7423:
7089                     ; 1200 if(index<0) index+=RX_BUFFER_SIZE;
7091  0f7d 9c            	rvf
7092  0f7e 1e01          	ldw	x,(OFST+1,sp)
7093  0f80 2e07          	jrsge	L1523
7096  0f82 1e01          	ldw	x,(OFST+1,sp)
7097  0f84 1c0064        	addw	x,#100
7098  0f87 1f01          	ldw	(OFST+1,sp),x
7099  0f89               L1523:
7100                     ; 1201 return index;
7102  0f89 1e01          	ldw	x,(OFST+1,sp)
7105  0f8b 5b02          	addw	sp,#2
7106  0f8d 81            	ret
7169                     ; 1205 char control_check(char index)
7169                     ; 1206 {
7170                     	switch	.text
7171  0f8e               _control_check:
7173  0f8e 88            	push	a
7174  0f8f 5203          	subw	sp,#3
7175       00000003      OFST:	set	3
7178                     ; 1207 char i=0,ii=0,iii;
7182                     ; 1209 if(rx_buffer[index]!=END) return 0;
7184  0f91 5f            	clrw	x
7185  0f92 97            	ld	xl,a
7186  0f93 e654          	ld	a,(_rx_buffer,x)
7187  0f95 a10a          	cp	a,#10
7188  0f97 2703          	jreq	L5033
7191  0f99 4f            	clr	a
7193  0f9a 2051          	jra	L071
7194  0f9c               L5033:
7195                     ; 1211 ii=rx_buffer[index_offset(index,-2)];
7197  0f9c aefffe        	ldw	x,#65534
7198  0f9f 89            	pushw	x
7199  0fa0 7b06          	ld	a,(OFST+3,sp)
7200  0fa2 5f            	clrw	x
7201  0fa3 97            	ld	xl,a
7202  0fa4 adc0          	call	_index_offset
7204  0fa6 5b02          	addw	sp,#2
7205  0fa8 e654          	ld	a,(_rx_buffer,x)
7206  0faa 6b02          	ld	(OFST-1,sp),a
7207                     ; 1212 iii=0;
7209  0fac 0f01          	clr	(OFST-2,sp)
7210                     ; 1213 for(i=0;i<=ii;i++)
7212  0fae 0f03          	clr	(OFST+0,sp)
7214  0fb0 2022          	jra	L3133
7215  0fb2               L7033:
7216                     ; 1215 	iii^=rx_buffer[index_offset(index,-2-ii+i)];
7218  0fb2 a6ff          	ld	a,#255
7219  0fb4 97            	ld	xl,a
7220  0fb5 a6fe          	ld	a,#254
7221  0fb7 1002          	sub	a,(OFST-1,sp)
7222  0fb9 2401          	jrnc	L461
7223  0fbb 5a            	decw	x
7224  0fbc               L461:
7225  0fbc 1b03          	add	a,(OFST+0,sp)
7226  0fbe 2401          	jrnc	L661
7227  0fc0 5c            	incw	x
7228  0fc1               L661:
7229  0fc1 02            	rlwa	x,a
7230  0fc2 89            	pushw	x
7231  0fc3 01            	rrwa	x,a
7232  0fc4 7b06          	ld	a,(OFST+3,sp)
7233  0fc6 5f            	clrw	x
7234  0fc7 97            	ld	xl,a
7235  0fc8 ad9c          	call	_index_offset
7237  0fca 5b02          	addw	sp,#2
7238  0fcc 7b01          	ld	a,(OFST-2,sp)
7239  0fce e854          	xor	a,	(_rx_buffer,x)
7240  0fd0 6b01          	ld	(OFST-2,sp),a
7241                     ; 1213 for(i=0;i<=ii;i++)
7243  0fd2 0c03          	inc	(OFST+0,sp)
7244  0fd4               L3133:
7247  0fd4 7b03          	ld	a,(OFST+0,sp)
7248  0fd6 1102          	cp	a,(OFST-1,sp)
7249  0fd8 23d8          	jrule	L7033
7250                     ; 1217 if (iii!=rx_buffer[index_offset(index,-1)]) return 0;	
7252  0fda aeffff        	ldw	x,#65535
7253  0fdd 89            	pushw	x
7254  0fde 7b06          	ld	a,(OFST+3,sp)
7255  0fe0 5f            	clrw	x
7256  0fe1 97            	ld	xl,a
7257  0fe2 ad82          	call	_index_offset
7259  0fe4 5b02          	addw	sp,#2
7260  0fe6 e654          	ld	a,(_rx_buffer,x)
7261  0fe8 1101          	cp	a,(OFST-2,sp)
7262  0fea 2704          	jreq	L7133
7265  0fec 4f            	clr	a
7267  0fed               L071:
7269  0fed 5b04          	addw	sp,#4
7270  0fef 81            	ret
7271  0ff0               L7133:
7272                     ; 1219 return 1;
7274  0ff0 a601          	ld	a,#1
7276  0ff2 20f9          	jra	L071
7318                     ; 1228 @far @interrupt void TIM4_UPD_Interrupt (void) 
7318                     ; 1229 {
7320                     	switch	.text
7321  0ff4               f_TIM4_UPD_Interrupt:
7325                     ; 1230 if(play) 
7327                     	btst	_play
7328  0ff9 2445          	jruge	L1333
7329                     ; 1232 	TIM2->CCR3H= 0x00;	
7331  0ffb 725f5315      	clr	21269
7332                     ; 1233 	TIM2->CCR3L= sample;
7334  0fff 5500195316    	mov	21270,_sample
7335                     ; 1234 	sample_cnt++;
7337  1004 be23          	ldw	x,_sample_cnt
7338  1006 1c0001        	addw	x,#1
7339  1009 bf23          	ldw	_sample_cnt,x
7340                     ; 1235 	if(sample_cnt>=256) 
7342  100b 9c            	rvf
7343  100c be23          	ldw	x,_sample_cnt
7344  100e a30100        	cpw	x,#256
7345  1011 2f03          	jrslt	L3333
7346                     ; 1237 		sample_cnt=0;
7348  1013 5f            	clrw	x
7349  1014 bf23          	ldw	_sample_cnt,x
7350  1016               L3333:
7351                     ; 1240 	sample=buff[sample_cnt];
7353  1016 be23          	ldw	x,_sample_cnt
7354  1018 d60050        	ld	a,(_buff,x)
7355  101b b719          	ld	_sample,a
7356                     ; 1242 	if(sample_cnt==132)	
7358  101d be23          	ldw	x,_sample_cnt
7359  101f a30084        	cpw	x,#132
7360  1022 2604          	jrne	L5333
7361                     ; 1244 		bBUFF_LOAD=1;
7363  1024 7210000d      	bset	_bBUFF_LOAD
7364  1028               L5333:
7365                     ; 1247 	if(sample_cnt==5) 
7367  1028 be23          	ldw	x,_sample_cnt
7368  102a a30005        	cpw	x,#5
7369  102d 2604          	jrne	L7333
7370                     ; 1249 		bBUFF_READ_H=1;
7372  102f 7210000c      	bset	_bBUFF_READ_H
7373  1033               L7333:
7374                     ; 1252 	if(sample_cnt==150) 
7376  1033 be23          	ldw	x,_sample_cnt
7377  1035 a30096        	cpw	x,#150
7378  1038 2615          	jrne	L3433
7379                     ; 1254 		bBUFF_READ_L=1;
7381  103a 7210000b      	bset	_bBUFF_READ_L
7382  103e 200f          	jra	L3433
7383  1040               L1333:
7384                     ; 1258 else if(!bSTART) 
7386                     	btst	_bSTART
7387  1045 2508          	jrult	L3433
7388                     ; 1260 	TIM2->CCR3H= 0x00;	
7390  1047 725f5315      	clr	21269
7391                     ; 1261 	TIM2->CCR3L= 0x7f;//pwm_fade_in;
7393  104b 357f5316      	mov	21270,#127
7394  104f               L3433:
7395                     ; 1295 if(but_block_cnt)but_on_drv_cnt=0;
7397  104f be02          	ldw	x,_but_block_cnt
7398  1051 2702          	jreq	L7433
7401  1053 3fb9          	clr	_but_on_drv_cnt
7402  1055               L7433:
7403                     ; 1296 if((((GPIOC->IDR)&(1<<4))) && (but_on_drv_cnt<100)) 
7405  1055 c6500b        	ld	a,20491
7406  1058 a510          	bcp	a,#16
7407  105a 271f          	jreq	L1533
7409  105c b6b9          	ld	a,_but_on_drv_cnt
7410  105e a164          	cp	a,#100
7411  1060 2419          	jruge	L1533
7412                     ; 1298 	but_on_drv_cnt++;
7414  1062 3cb9          	inc	_but_on_drv_cnt
7415                     ; 1299 	if((but_on_drv_cnt>2)&&(bRELEASE))
7417  1064 b6b9          	ld	a,_but_on_drv_cnt
7418  1066 a103          	cp	a,#3
7419  1068 2517          	jrult	L5533
7421                     	btst	_bRELEASE
7422  106f 2410          	jruge	L5533
7423                     ; 1301 		bRELEASE=0;
7425  1071 72110002      	bres	_bRELEASE
7426                     ; 1302 		bSTART=1;
7428  1075 7210000e      	bset	_bSTART
7429  1079 2006          	jra	L5533
7430  107b               L1533:
7431                     ; 1307 	but_on_drv_cnt=0;
7433  107b 3fb9          	clr	_but_on_drv_cnt
7434                     ; 1308 	bRELEASE=1;
7436  107d 72100002      	bset	_bRELEASE
7437  1081               L5533:
7438                     ; 1311 if(++t0_cnt0>=125)
7440  1081 3c00          	inc	_t0_cnt0
7441  1083 b600          	ld	a,_t0_cnt0
7442  1085 a17d          	cp	a,#125
7443  1087 2530          	jrult	L7533
7444                     ; 1313   t0_cnt0=0;
7446  1089 3f00          	clr	_t0_cnt0
7447                     ; 1314   b100Hz=1;
7449  108b 7210000a      	bset	_b100Hz
7450                     ; 1316 	if(++t0_cnt1>=10)
7452  108f 3c01          	inc	_t0_cnt1
7453  1091 b601          	ld	a,_t0_cnt1
7454  1093 a10a          	cp	a,#10
7455  1095 2506          	jrult	L1633
7456                     ; 1318 		t0_cnt1=0;
7458  1097 3f01          	clr	_t0_cnt1
7459                     ; 1319 		b10Hz=1;
7461  1099 72100009      	bset	_b10Hz
7462  109d               L1633:
7463                     ; 1322 	if(++t0_cnt2>=20)
7465  109d 3c02          	inc	_t0_cnt2
7466  109f b602          	ld	a,_t0_cnt2
7467  10a1 a114          	cp	a,#20
7468  10a3 2506          	jrult	L3633
7469                     ; 1324 		t0_cnt2=0;
7471  10a5 3f02          	clr	_t0_cnt2
7472                     ; 1325 		b5Hz=1;
7474  10a7 72100008      	bset	_b5Hz
7475  10ab               L3633:
7476                     ; 1328 	if(++t0_cnt3>=100)
7478  10ab 3c03          	inc	_t0_cnt3
7479  10ad b603          	ld	a,_t0_cnt3
7480  10af a164          	cp	a,#100
7481  10b1 2506          	jrult	L7533
7482                     ; 1330 		t0_cnt3=0;
7484  10b3 3f03          	clr	_t0_cnt3
7485                     ; 1331 		b1Hz=1;
7487  10b5 72100007      	bset	_b1Hz
7488  10b9               L7533:
7489                     ; 1335 TIM4->SR1&=~TIM4_SR1_UIF;			// disable break interrupt
7491  10b9 72115344      	bres	21316,#0
7492                     ; 1336 return;
7495  10bd 80            	iret
7521                     ; 1340 @far @interrupt void UARTTxInterrupt (void) {
7522                     	switch	.text
7523  10be               f_UARTTxInterrupt:
7527                     ; 1342 	if (tx_counter){
7529  10be 3d22          	tnz	_tx_counter
7530  10c0 271a          	jreq	L7733
7531                     ; 1343 		--tx_counter;
7533  10c2 3a22          	dec	_tx_counter
7534                     ; 1344 		UART1->DR=tx_buffer[tx_rd_index];
7536  10c4 5f            	clrw	x
7537  10c5 b620          	ld	a,_tx_rd_index
7538  10c7 2a01          	jrpl	L671
7539  10c9 53            	cplw	x
7540  10ca               L671:
7541  10ca 97            	ld	xl,a
7542  10cb e604          	ld	a,(_tx_buffer,x)
7543  10cd c75231        	ld	21041,a
7544                     ; 1345 		if (++tx_rd_index == TX_BUFFER_SIZE) tx_rd_index=0;
7546  10d0 3c20          	inc	_tx_rd_index
7547  10d2 b620          	ld	a,_tx_rd_index
7548  10d4 a150          	cp	a,#80
7549  10d6 260c          	jrne	L3043
7552  10d8 3f20          	clr	_tx_rd_index
7553  10da 2008          	jra	L3043
7554  10dc               L7733:
7555                     ; 1348 		bOUT_FREE=1;
7557  10dc 72100005      	bset	_bOUT_FREE
7558                     ; 1349 		UART1->CR2&= ~UART1_CR2_TIEN;
7560  10e0 721f5235      	bres	21045,#7
7561  10e4               L3043:
7562                     ; 1351 }
7565  10e4 80            	iret
7594                     ; 1354 @far @interrupt void UARTRxInterrupt (void) {
7595                     	switch	.text
7596  10e5               f_UARTRxInterrupt:
7600                     ; 1359 	rx_status=UART1->SR;
7602  10e5 5552300008    	mov	_rx_status,21040
7603                     ; 1360 	rx_data=UART1->DR;
7605  10ea 5552310007    	mov	_rx_data,21041
7606                     ; 1362 	if (rx_status & (UART1_SR_RXNE)){
7608  10ef b608          	ld	a,_rx_status
7609  10f1 a520          	bcp	a,#32
7610  10f3 272c          	jreq	L5143
7611                     ; 1363 		rx_buffer[rx_wr_index]=rx_data;
7613  10f5 be1c          	ldw	x,_rx_wr_index
7614  10f7 b607          	ld	a,_rx_data
7615  10f9 e754          	ld	(_rx_buffer,x),a
7616                     ; 1364 		bRXIN=1;
7618  10fb 72100004      	bset	_bRXIN
7619                     ; 1365 		if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
7621  10ff be1c          	ldw	x,_rx_wr_index
7622  1101 1c0001        	addw	x,#1
7623  1104 bf1c          	ldw	_rx_wr_index,x
7624  1106 a30064        	cpw	x,#100
7625  1109 2603          	jrne	L7143
7628  110b 5f            	clrw	x
7629  110c bf1c          	ldw	_rx_wr_index,x
7630  110e               L7143:
7631                     ; 1366 		if (++rx_counter == RX_BUFFER_SIZE){
7633  110e be1e          	ldw	x,_rx_counter
7634  1110 1c0001        	addw	x,#1
7635  1113 bf1e          	ldw	_rx_counter,x
7636  1115 a30064        	cpw	x,#100
7637  1118 2607          	jrne	L5143
7638                     ; 1367 			rx_counter=0;
7640  111a 5f            	clrw	x
7641  111b bf1e          	ldw	_rx_counter,x
7642                     ; 1368 			rx_buffer_overflow=1;
7644  111d 72100003      	bset	_rx_buffer_overflow
7645  1121               L5143:
7646                     ; 1371 }
7649  1121 80            	iret
7726                     ; 1377 main()
7726                     ; 1378 {
7728                     	switch	.text
7729  1122               _main:
7731  1122 88            	push	a
7732       00000001      OFST:	set	1
7735                     ; 1379 CLK->CKDIVR=0;
7737  1123 725f50c6      	clr	20678
7738                     ; 1381 rele_cnt_index=0;
7740  1127 3fbb          	clr	_rele_cnt_index
7741                     ; 1383 GPIOD->DDR&=~(1<<6);
7743  1129 721d5011      	bres	20497,#6
7744                     ; 1384 GPIOD->CR1|=(1<<6);
7746  112d 721c5012      	bset	20498,#6
7747                     ; 1385 GPIOD->CR2|=(1<<6);
7749  1131 721c5013      	bset	20499,#6
7750                     ; 1387 GPIOD->DDR|=(1<<5);
7752  1135 721a5011      	bset	20497,#5
7753                     ; 1388 GPIOD->CR1|=(1<<5);
7755  1139 721a5012      	bset	20498,#5
7756                     ; 1389 GPIOD->CR2|=(1<<5);	
7758  113d 721a5013      	bset	20499,#5
7759                     ; 1390 GPIOD->ODR|=(1<<5);
7761  1141 721a500f      	bset	20495,#5
7762                     ; 1392 delay_ms(10);
7764  1145 ae000a        	ldw	x,#10
7765  1148 cd005c        	call	_delay_ms
7767                     ; 1394 if(!(GPIOD->IDR&=(1<<6))) 
7769  114b c65010        	ld	a,20496
7770  114e a440          	and	a,#64
7771  1150 c75010        	ld	20496,a
7772  1153 2606          	jrne	L1443
7773                     ; 1396 	rele_cnt_index=1;
7775  1155 350100bb      	mov	_rele_cnt_index,#1
7777  1159 2018          	jra	L3443
7778  115b               L1443:
7779                     ; 1400 	GPIOD->ODR&=~(1<<5);
7781  115b 721b500f      	bres	20495,#5
7782                     ; 1401 	delay_ms(10);
7784  115f ae000a        	ldw	x,#10
7785  1162 cd005c        	call	_delay_ms
7787                     ; 1402 	if(!(GPIOD->IDR&=(1<<6))) 
7789  1165 c65010        	ld	a,20496
7790  1168 a440          	and	a,#64
7791  116a c75010        	ld	20496,a
7792  116d 2604          	jrne	L3443
7793                     ; 1404 		rele_cnt_index=2;
7795  116f 350200bb      	mov	_rele_cnt_index,#2
7796  1173               L3443:
7797                     ; 1408 gpio_init();
7799  1173 cd0ead        	call	_gpio_init
7801                     ; 1415 spi_init();
7803  1176 cd0bd1        	call	_spi_init
7805                     ; 1417 t4_init();
7807  1179 cd0039        	call	_t4_init
7809                     ; 1419 FLASH_DUKR=0xae;
7811  117c 35ae5064      	mov	_FLASH_DUKR,#174
7812                     ; 1420 FLASH_DUKR=0x56;
7814  1180 35565064      	mov	_FLASH_DUKR,#86
7815                     ; 1425 dumm[1]++;
7817  1184 725c017d      	inc	_dumm+1
7818                     ; 1427 uart_init();
7820  1188 cd009e        	call	_uart_init
7822                     ; 1429 ST_RDID_read();
7824  118b cd0c5c        	call	_ST_RDID_read
7826                     ; 1430 if(mdr0==0x20) memory_manufacturer='S';	
7828  118e b618          	ld	a,_mdr0
7829  1190 a120          	cp	a,#32
7830  1192 2606          	jrne	L7443
7833  1194 355300bc      	mov	_memory_manufacturer,#83
7835  1198 200d          	jra	L1543
7836  119a               L7443:
7837                     ; 1433 	DF_mf_dev_read();
7839  119a cd0d74        	call	_DF_mf_dev_read
7841                     ; 1434 	if(mdr0==0x1F) memory_manufacturer='A';
7843  119d b618          	ld	a,_mdr0
7844  119f a11f          	cp	a,#31
7845  11a1 2604          	jrne	L1543
7848  11a3 354100bc      	mov	_memory_manufacturer,#65
7849  11a7               L1543:
7850                     ; 1437 t2_init();
7852  11a7 cd0000        	call	_t2_init
7854                     ; 1439 ST_WREN();
7856  11aa cd0ccc        	call	_ST_WREN
7858                     ; 1441 enableInterrupts();	
7861  11ad 9a            rim
7863  11ae               L5543:
7864                     ; 1446 	if(bBUFF_LOAD)
7866                     	btst	_bBUFF_LOAD
7867  11b3 2425          	jruge	L1643
7868                     ; 1448 		bBUFF_LOAD=0;
7870  11b5 7211000d      	bres	_bBUFF_LOAD
7871                     ; 1450 		if(current_page<last_page)
7873  11b9 be11          	ldw	x,_current_page
7874  11bb b30f          	cpw	x,_last_page
7875  11bd 2409          	jruge	L3643
7876                     ; 1452 			current_page++;
7878  11bf be11          	ldw	x,_current_page
7879  11c1 1c0001        	addw	x,#1
7880  11c4 bf11          	ldw	_current_page,x
7882  11c6 2007          	jra	L5643
7883  11c8               L3643:
7884                     ; 1456 			current_page=0;
7886  11c8 5f            	clrw	x
7887  11c9 bf11          	ldw	_current_page,x
7888                     ; 1457 			play=0;
7890  11cb 72110006      	bres	_play
7891  11cf               L5643:
7892                     ; 1459 		if(memory_manufacturer=='A')
7894  11cf b6bc          	ld	a,_memory_manufacturer
7895  11d1 a141          	cp	a,#65
7896  11d3 2605          	jrne	L1643
7897                     ; 1461 			DF_page_to_buffer(/*///current_buffer_H*//*1,*/current_page);
7899  11d5 be11          	ldw	x,_current_page
7900  11d7 cd0de2        	call	_DF_page_to_buffer
7902  11da               L1643:
7903                     ; 1465 	if(bBUFF_READ_L)
7905                     	btst	_bBUFF_READ_L
7906  11df 243a          	jruge	L1743
7907                     ; 1467 		bBUFF_READ_L=0;
7909  11e1 7211000b      	bres	_bBUFF_READ_L
7910                     ; 1468 		if(memory_manufacturer=='A')
7912  11e5 b6bc          	ld	a,_memory_manufacturer
7913  11e7 a141          	cp	a,#65
7914  11e9 260e          	jrne	L3743
7915                     ; 1470 			DF_buffer_read(/*///current_buffer_L*//*1,*/0,128,buff);
7917  11eb ae0050        	ldw	x,#_buff
7918  11ee 89            	pushw	x
7919  11ef ae0080        	ldw	x,#128
7920  11f2 89            	pushw	x
7921  11f3 5f            	clrw	x
7922  11f4 cd0e28        	call	_DF_buffer_read
7924  11f7 5b04          	addw	sp,#4
7925  11f9               L3743:
7926                     ; 1472 		if(memory_manufacturer=='S')
7928  11f9 b6bc          	ld	a,_memory_manufacturer
7929  11fb a153          	cp	a,#83
7930  11fd 261c          	jrne	L1743
7931                     ; 1474 			ST_READ((unsigned long)((unsigned long)(current_page*256UL)),128,buff);
7933  11ff ae0050        	ldw	x,#_buff
7934  1202 89            	pushw	x
7935  1203 ae0080        	ldw	x,#128
7936  1206 89            	pushw	x
7937  1207 be11          	ldw	x,_current_page
7938  1209 90ae0100      	ldw	y,#256
7939  120d cd0000        	call	c_umul
7941  1210 be02          	ldw	x,c_lreg+2
7942  1212 89            	pushw	x
7943  1213 be00          	ldw	x,c_lreg
7944  1215 89            	pushw	x
7945  1216 cd0d26        	call	_ST_READ
7947  1219 5b08          	addw	sp,#8
7948  121b               L1743:
7949                     ; 1478 	if(bBUFF_READ_H) 
7951                     	btst	_bBUFF_READ_H
7952  1220 2441          	jruge	L7743
7953                     ; 1480 		bBUFF_READ_H=0;
7955  1222 7211000c      	bres	_bBUFF_READ_H
7956                     ; 1481 		if(memory_manufacturer=='A') 
7958  1226 b6bc          	ld	a,_memory_manufacturer
7959  1228 a141          	cp	a,#65
7960  122a 2610          	jrne	L1053
7961                     ; 1483 			DF_buffer_read(/*///current_buffer_L*//*1,*/128,128,&buff[128]);
7963  122c ae00d0        	ldw	x,#_buff+128
7964  122f 89            	pushw	x
7965  1230 ae0080        	ldw	x,#128
7966  1233 89            	pushw	x
7967  1234 ae0080        	ldw	x,#128
7968  1237 cd0e28        	call	_DF_buffer_read
7970  123a 5b04          	addw	sp,#4
7971  123c               L1053:
7972                     ; 1485 		if(memory_manufacturer=='S') 
7974  123c b6bc          	ld	a,_memory_manufacturer
7975  123e a153          	cp	a,#83
7976  1240 2621          	jrne	L7743
7977                     ; 1487 			ST_READ((unsigned long)((unsigned long)(current_page*256UL)+128UL),128,&buff[128]);
7979  1242 ae00d0        	ldw	x,#_buff+128
7980  1245 89            	pushw	x
7981  1246 ae0080        	ldw	x,#128
7982  1249 89            	pushw	x
7983  124a be11          	ldw	x,_current_page
7984  124c 90ae0100      	ldw	y,#256
7985  1250 cd0000        	call	c_umul
7987  1253 a680          	ld	a,#128
7988  1255 cd0000        	call	c_ladc
7990  1258 be02          	ldw	x,c_lreg+2
7991  125a 89            	pushw	x
7992  125b be00          	ldw	x,c_lreg
7993  125d 89            	pushw	x
7994  125e cd0d26        	call	_ST_READ
7996  1261 5b08          	addw	sp,#8
7997  1263               L7743:
7998                     ; 1491 	if(bRXIN)
8000                     	btst	_bRXIN
8001  1268 2407          	jruge	L5053
8002                     ; 1493 		bRXIN=0;
8004  126a 72110004      	bres	_bRXIN
8005                     ; 1495 		uart_in();
8007  126e cd0ed6        	call	_uart_in
8009  1271               L5053:
8010                     ; 1499 	if(b100Hz)
8012                     	btst	_b100Hz
8013  1276 2503          	jrult	L402
8014  1278 cc1326        	jp	L7053
8015  127b               L402:
8016                     ; 1501 		b100Hz=0;
8018  127b 7211000a      	bres	_b100Hz
8019                     ; 1503 		if(but_block_cnt)but_block_cnt--;
8021  127f be02          	ldw	x,_but_block_cnt
8022  1281 2707          	jreq	L1153
8025  1283 be02          	ldw	x,_but_block_cnt
8026  1285 1d0001        	subw	x,#1
8027  1288 bf02          	ldw	_but_block_cnt,x
8028  128a               L1153:
8029                     ; 1505 		if(bSTART==1) 
8031                     	btst	_bSTART
8032  128f 24e7          	jruge	L7053
8033                     ; 1507 			if(play) 
8035                     	btst	_play
8036  1296 2417          	jruge	L5153
8037                     ; 1510 				if(!but_block_cnt)
8039  1298 be02          	ldw	x,_but_block_cnt
8040  129a 260d          	jrne	L7153
8041                     ; 1512 					play=0;
8043  129c 72110006      	bres	_play
8044                     ; 1513 					bSTART=0;
8046  12a0 7211000e      	bres	_bSTART
8047                     ; 1514 					but_block_cnt=50;
8049  12a4 ae0032        	ldw	x,#50
8050  12a7 bf02          	ldw	_but_block_cnt,x
8051  12a9               L7153:
8052                     ; 1517 				bSTART=0;
8054  12a9 7211000e      	bres	_bSTART
8056  12ad 2077          	jra	L7053
8057  12af               L5153:
8058                     ; 1521 			if(!but_block_cnt)
8060  12af be02          	ldw	x,_but_block_cnt
8061  12b1 2673          	jrne	L7053
8062                     ; 1524 				current_page=1;
8064  12b3 ae0001        	ldw	x,#1
8065  12b6 bf11          	ldw	_current_page,x
8066                     ; 1526 				last_page=6000;
8068  12b8 ae1770        	ldw	x,#6000
8069  12bb bf0f          	ldw	_last_page,x
8070                     ; 1532 				if(memory_manufacturer=='A')
8072  12bd b6bc          	ld	a,_memory_manufacturer
8073  12bf a141          	cp	a,#65
8074  12c1 2630          	jrne	L5253
8075                     ; 1534 					DF_page_to_buffer(/*///current_buffer_H*//*1,*/current_page);
8077  12c3 ae0001        	ldw	x,#1
8078  12c6 cd0de2        	call	_DF_page_to_buffer
8080                     ; 1535 					delay_ms(10);
8082  12c9 ae000a        	ldw	x,#10
8083  12cc cd005c        	call	_delay_ms
8085                     ; 1536 					DF_buffer_read(/*///current_buffer_L*//*1,*/0,128,buff);
8087  12cf ae0050        	ldw	x,#_buff
8088  12d2 89            	pushw	x
8089  12d3 ae0080        	ldw	x,#128
8090  12d6 89            	pushw	x
8091  12d7 5f            	clrw	x
8092  12d8 cd0e28        	call	_DF_buffer_read
8094  12db 5b04          	addw	sp,#4
8095                     ; 1537 					delay_ms(10);
8097  12dd ae000a        	ldw	x,#10
8098  12e0 cd005c        	call	_delay_ms
8100                     ; 1538 					DF_buffer_read(/*///current_buffer_L*//*1,*/128,128,&buff[128]);         
8102  12e3 ae00d0        	ldw	x,#_buff+128
8103  12e6 89            	pushw	x
8104  12e7 ae0080        	ldw	x,#128
8105  12ea 89            	pushw	x
8106  12eb ae0080        	ldw	x,#128
8107  12ee cd0e28        	call	_DF_buffer_read
8109  12f1 5b04          	addw	sp,#4
8110  12f3               L5253:
8111                     ; 1540 				if(memory_manufacturer=='S') 
8113  12f3 b6bc          	ld	a,_memory_manufacturer
8114  12f5 a153          	cp	a,#83
8115  12f7 2615          	jrne	L7253
8116                     ; 1542 					ST_READ(0,256,buff);
8118  12f9 ae0050        	ldw	x,#_buff
8119  12fc 89            	pushw	x
8120  12fd ae0100        	ldw	x,#256
8121  1300 89            	pushw	x
8122  1301 ae0000        	ldw	x,#0
8123  1304 89            	pushw	x
8124  1305 ae0000        	ldw	x,#0
8125  1308 89            	pushw	x
8126  1309 cd0d26        	call	_ST_READ
8128  130c 5b08          	addw	sp,#8
8129  130e               L7253:
8130                     ; 1544 				play=1;
8132  130e 72100006      	bset	_play
8133                     ; 1545 				bSTART=0;
8135  1312 7211000e      	bres	_bSTART
8136                     ; 1547 				rele_cnt=rele_cnt_const[rele_cnt_index];
8138  1316 b6bb          	ld	a,_rele_cnt_index
8139  1318 5f            	clrw	x
8140  1319 97            	ld	xl,a
8141  131a d60000        	ld	a,(_rele_cnt_const,x)
8142  131d 5f            	clrw	x
8143  131e 97            	ld	xl,a
8144  131f bf05          	ldw	_rele_cnt,x
8145                     ; 1549 				but_block_cnt=50;
8147  1321 ae0032        	ldw	x,#50
8148  1324 bf02          	ldw	_but_block_cnt,x
8149  1326               L7053:
8150                     ; 1555 	if(b10Hz)
8152                     	btst	_b10Hz
8153  132b 2441          	jruge	L1353
8154                     ; 1557 		b10Hz=0;
8156  132d 72110009      	bres	_b10Hz
8157                     ; 1559 		rele_drv();
8159  1331 cd004a        	call	_rele_drv
8161                     ; 1560 		pwm_fade_in++;
8163  1334 3cba          	inc	_pwm_fade_in
8164                     ; 1561 		if(pwm_fade_in>128)pwm_fade_in=128;
8166  1336 b6ba          	ld	a,_pwm_fade_in
8167  1338 a181          	cp	a,#129
8168  133a 2504          	jrult	L3353
8171  133c 358000ba      	mov	_pwm_fade_in,#128
8172  1340               L3353:
8173                     ; 1563 		if(current_page_cnt)
8175  1340 3d01          	tnz	_current_page_cnt
8176  1342 272a          	jreq	L1353
8177                     ; 1565 			current_page_cnt--;
8179  1344 3a01          	dec	_current_page_cnt
8180                     ; 1566 			if(!current_page_cnt)
8182  1346 3d01          	tnz	_current_page_cnt
8183  1348 2624          	jrne	L1353
8184                     ; 1568 				uart_out (5,CMND,21,current_page%256,current_page/256,1,0);
8186  134a 4b00          	push	#0
8187  134c 4b01          	push	#1
8188  134e 3b0011        	push	_current_page
8189  1351 b612          	ld	a,_current_page+1
8190  1353 a4ff          	and	a,#255
8191  1355 88            	push	a
8192  1356 4b15          	push	#21
8193  1358 ae0016        	ldw	x,#22
8194  135b a605          	ld	a,#5
8195  135d 95            	ld	xh,a
8196  135e cd00ce        	call	_uart_out
8198  1361 5b05          	addw	sp,#5
8199                     ; 1569 				current_page_cnt=10;
8201  1363 350a0001      	mov	_current_page_cnt,#10
8202                     ; 1570 				current_page_cnt_=4;
8204  1367 35040000      	mov	_current_page_cnt_,#4
8205                     ; 1571 				current_byte_in_buffer=0;
8207  136b 5f            	clrw	x
8208  136c bf0d          	ldw	_current_byte_in_buffer,x
8209  136e               L1353:
8210                     ; 1577 	if(b5Hz)
8212                     	btst	_b5Hz
8213  1373 2404          	jruge	L1453
8214                     ; 1579 		b5Hz=0;
8216  1375 72110008      	bres	_b5Hz
8217  1379               L1453:
8218                     ; 1585 	if(b1Hz)
8220                     	btst	_b1Hz
8221  137e 2503          	jrult	L602
8222  1380 cc11ae        	jp	L5543
8223  1383               L602:
8224                     ; 1588 		b1Hz=0;
8226  1383 72110007      	bres	_b1Hz
8227                     ; 1597 		if((!bERASE_IN_PROGRESS)&&(bSTART_DOWNLOAD))
8229                     	btst	_bERASE_IN_PROGRESS
8230  138c 252f          	jrult	L5453
8232                     	btst	_bSTART_DOWNLOAD
8233  1393 2428          	jruge	L5453
8234                     ; 1599 			bSTART_DOWNLOAD=0;
8236  1395 72110000      	bres	_bSTART_DOWNLOAD
8237                     ; 1600 			uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
8239  1399 4b00          	push	#0
8240  139b 4b00          	push	#0
8241  139d 3b0011        	push	_current_page
8242  13a0 b612          	ld	a,_current_page+1
8243  13a2 a4ff          	and	a,#255
8244  13a4 88            	push	a
8245  13a5 4b15          	push	#21
8246  13a7 ae0016        	ldw	x,#22
8247  13aa a604          	ld	a,#4
8248  13ac 95            	ld	xh,a
8249  13ad cd00ce        	call	_uart_out
8251  13b0 5b05          	addw	sp,#5
8252                     ; 1601 			current_page_cnt=10;
8254  13b2 350a0001      	mov	_current_page_cnt,#10
8255                     ; 1602 			current_page_cnt_=4;
8257  13b6 35040000      	mov	_current_page_cnt_,#4
8258                     ; 1603 			current_byte_in_buffer=0;
8260  13ba 5f            	clrw	x
8261  13bb bf0d          	ldw	_current_byte_in_buffer,x
8262  13bd               L5453:
8263                     ; 1605 		if(bERASE_IN_PROGRESS)
8265                     	btst	_bERASE_IN_PROGRESS
8266  13c2 2503          	jrult	L012
8267  13c4 cc11ae        	jp	L5543
8268  13c7               L012:
8269                     ; 1608 			temp=ST_status_read();
8271  13c7 cd0c8e        	call	_ST_status_read
8273  13ca 6b01          	ld	(OFST+0,sp),a
8274                     ; 1609 			if((temp&0x01)==0)	
8276  13cc 7b01          	ld	a,(OFST+0,sp)
8277  13ce a501          	bcp	a,#1
8278  13d0 2703          	jreq	L212
8279  13d2 cc11ae        	jp	L5543
8280  13d5               L212:
8281                     ; 1611 				bERASE_IN_PROGRESS=0;
8283  13d5 72110001      	bres	_bERASE_IN_PROGRESS
8284                     ; 1614 				uart_out (3,CMND,33,33,0,0,0);
8286  13d9 4b00          	push	#0
8287  13db 4b00          	push	#0
8288  13dd 4b00          	push	#0
8289  13df 4b21          	push	#33
8290  13e1 4b21          	push	#33
8291  13e3 ae0016        	ldw	x,#22
8292  13e6 a603          	ld	a,#3
8293  13e8 95            	ld	xh,a
8294  13e9 cd00ce        	call	_uart_out
8296  13ec 5b05          	addw	sp,#5
8297  13ee acae11ae      	jpf	L5543
8831                     	xdef	_main
8832                     	switch	.ubsct
8833  0000               _current_page_cnt_:
8834  0000 00            	ds.b	1
8835                     	xdef	_current_page_cnt_
8836  0001               _current_page_cnt:
8837  0001 00            	ds.b	1
8838                     	xdef	_current_page_cnt
8839                     .bit:	section	.data,bit
8840  0000               _bSTART_DOWNLOAD:
8841  0000 00            	ds.b	1
8842                     	xdef	_bSTART_DOWNLOAD
8843  0001               _bERASE_IN_PROGRESS:
8844  0001 00            	ds.b	1
8845                     	xdef	_bERASE_IN_PROGRESS
8846                     .eeprom:	section	.data
8847  0000               _EE_PAGE_LEN:
8848  0000 0000          	ds.b	2
8849                     	xdef	_EE_PAGE_LEN
8850                     	switch	.bss
8851  0000               _UIB:
8852  0000 000000000000  	ds.b	80
8853                     	xdef	_UIB
8854  0050               _buff:
8855  0050 000000000000  	ds.b	300
8856                     	xdef	_buff
8857  017c               _dumm:
8858  017c 000000000000  	ds.b	100
8859                     	xdef	_dumm
8860                     	switch	.bit
8861  0002               _bRELEASE:
8862  0002 00            	ds.b	1
8863                     	xdef	_bRELEASE
8864  0003               _rx_buffer_overflow:
8865  0003 00            	ds.b	1
8866                     	xdef	_rx_buffer_overflow
8867  0004               _bRXIN:
8868  0004 00            	ds.b	1
8869                     	xdef	_bRXIN
8870  0005               _bOUT_FREE:
8871  0005 00            	ds.b	1
8872                     	xdef	_bOUT_FREE
8873  0006               _play:
8874  0006 00            	ds.b	1
8875                     	xdef	_play
8876  0007               _b1Hz:
8877  0007 00            	ds.b	1
8878                     	xdef	_b1Hz
8879  0008               _b5Hz:
8880  0008 00            	ds.b	1
8881                     	xdef	_b5Hz
8882  0009               _b10Hz:
8883  0009 00            	ds.b	1
8884                     	xdef	_b10Hz
8885  000a               _b100Hz:
8886  000a 00            	ds.b	1
8887                     	xdef	_b100Hz
8888  000b               _bBUFF_READ_L:
8889  000b 00            	ds.b	1
8890                     	xdef	_bBUFF_READ_L
8891  000c               _bBUFF_READ_H:
8892  000c 00            	ds.b	1
8893                     	xdef	_bBUFF_READ_H
8894  000d               _bBUFF_LOAD:
8895  000d 00            	ds.b	1
8896                     	xdef	_bBUFF_LOAD
8897  000e               _bSTART:
8898  000e 00            	ds.b	1
8899                     	xdef	_bSTART
8900                     	switch	.ubsct
8901  0002               _but_block_cnt:
8902  0002 0000          	ds.b	2
8903                     	xdef	_but_block_cnt
8904                     	xdef	_memory_manufacturer
8905                     	xdef	_rele_cnt_const
8906                     	xdef	_rele_cnt_index
8907                     	xdef	_pwm_fade_in
8908  0004               _rx_offset:
8909  0004 00            	ds.b	1
8910                     	xdef	_rx_offset
8911  0005               _rele_cnt:
8912  0005 0000          	ds.b	2
8913                     	xdef	_rele_cnt
8914  0007               _rx_data:
8915  0007 00            	ds.b	1
8916                     	xdef	_rx_data
8917  0008               _rx_status:
8918  0008 00            	ds.b	1
8919                     	xdef	_rx_status
8920  0009               _file_lengt:
8921  0009 00000000      	ds.b	4
8922                     	xdef	_file_lengt
8923  000d               _current_byte_in_buffer:
8924  000d 0000          	ds.b	2
8925                     	xdef	_current_byte_in_buffer
8926  000f               _last_page:
8927  000f 0000          	ds.b	2
8928                     	xdef	_last_page
8929  0011               _current_page:
8930  0011 0000          	ds.b	2
8931                     	xdef	_current_page
8932  0013               _file_lengt_in_pages:
8933  0013 0000          	ds.b	2
8934                     	xdef	_file_lengt_in_pages
8935  0015               _mdr3:
8936  0015 00            	ds.b	1
8937                     	xdef	_mdr3
8938  0016               _mdr2:
8939  0016 00            	ds.b	1
8940                     	xdef	_mdr2
8941  0017               _mdr1:
8942  0017 00            	ds.b	1
8943                     	xdef	_mdr1
8944  0018               _mdr0:
8945  0018 00            	ds.b	1
8946                     	xdef	_mdr0
8947                     	xdef	_but_on_drv_cnt
8948                     	xdef	_but_drv_cnt
8949  0019               _sample:
8950  0019 00            	ds.b	1
8951                     	xdef	_sample
8952  001a               _rx_rd_index:
8953  001a 0000          	ds.b	2
8954                     	xdef	_rx_rd_index
8955  001c               _rx_wr_index:
8956  001c 0000          	ds.b	2
8957                     	xdef	_rx_wr_index
8958  001e               _rx_counter:
8959  001e 0000          	ds.b	2
8960                     	xdef	_rx_counter
8961                     	xdef	_rx_buffer
8962  0020               _tx_rd_index:
8963  0020 00            	ds.b	1
8964                     	xdef	_tx_rd_index
8965  0021               _tx_wr_index:
8966  0021 00            	ds.b	1
8967                     	xdef	_tx_wr_index
8968  0022               _tx_counter:
8969  0022 00            	ds.b	1
8970                     	xdef	_tx_counter
8971                     	xdef	_tx_buffer
8972  0023               _sample_cnt:
8973  0023 0000          	ds.b	2
8974                     	xdef	_sample_cnt
8975                     	xdef	_t0_cnt3
8976                     	xdef	_t0_cnt2
8977                     	xdef	_t0_cnt1
8978                     	xdef	_t0_cnt0
8979                     	xdef	_ST_bulk_erase
8980                     	xdef	_ST_READ
8981                     	xdef	_ST_WRITE
8982                     	xdef	_ST_WREN
8983                     	xdef	_ST_status_read
8984                     	xdef	_ST_RDID_read
8985                     	xdef	_uart_in_an
8986                     	xdef	_control_check
8987                     	xdef	_index_offset
8988                     	xdef	_uart_in
8989                     	xdef	_gpio_init
8990                     	xdef	_spi_init
8991                     	xdef	_spi
8992                     	xdef	_DF_buffer_to_page_er
8993                     	xdef	_DF_page_to_buffer
8994                     	xdef	_DF_buffer_write
8995                     	xdef	_DF_buffer_read
8996                     	xdef	_DF_status_read
8997                     	xdef	_DF_memo_to_256
8998                     	xdef	_DF_mf_dev_read
8999                     	xdef	_uart_init
9000                     	xdef	f_UARTRxInterrupt
9001                     	xdef	f_UARTTxInterrupt
9002                     	xdef	_putchar
9003                     	xdef	_uart_out_adr_block
9004                     	xdef	_uart_out
9005                     	xdef	f_TIM4_UPD_Interrupt
9006                     	xdef	_delay_ms
9007                     	xdef	_rele_drv
9008                     	xdef	_t4_init
9009                     	xdef	_t2_init
9010                     	xref.b	c_lreg
9011                     	xref.b	c_x
9012                     	xref.b	c_y
9032                     	xref	c_ladc
9033                     	xref	c_itolx
9034                     	xref	c_umul
9035                     	xref	c_eewrw
9036                     	xref	c_lglsh
9037                     	xref	c_uitolx
9038                     	xref	c_lgursh
9039                     	xref	c_lcmp
9040                     	xref	c_ltor
9041                     	xref	c_lgadc
9042                     	xref	c_rtol
9043                     	xref	c_vmul
9044                     	end
