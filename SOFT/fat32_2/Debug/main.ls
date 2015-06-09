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
2187  0055 000000000000  	ds.b	79
2188  00a4               _but_drv_cnt:
2189  00a4 00            	dc.b	0
2190  00a5               _but_on_drv_cnt:
2191  00a5 00            	dc.b	0
2220                     ; 44 void t2_init(void){
2222                     	switch	.text
2223  0000               _t2_init:
2227                     ; 45 	TIM2->PSCR = 0;
2229  0000 725f530e      	clr	21262
2230                     ; 46 	TIM2->ARRH= 0x00;
2232  0004 725f530f      	clr	21263
2233                     ; 47 	TIM2->ARRL= 0xff;
2235  0008 35ff5310      	mov	21264,#255
2236                     ; 48 	TIM2->CCR1H= 0x00;	
2238  000c 725f5311      	clr	21265
2239                     ; 49 	TIM2->CCR1L= 200;
2241  0010 35c85312      	mov	21266,#200
2242                     ; 50 	TIM2->CCR2H= 0x00;	
2244  0014 725f5313      	clr	21267
2245                     ; 51 	TIM2->CCR2L= 200;
2247  0018 35c85314      	mov	21268,#200
2248                     ; 52 	TIM2->CCR3H= 0x00;	
2250  001c 725f5315      	clr	21269
2251                     ; 53 	TIM2->CCR3L= 200;
2253  0020 35c85316      	mov	21270,#200
2254                     ; 56 	TIM2->CCMR2= ((6<<4) & TIM2_CCMR_OCM) | TIM2_CCMR_OCxPE; //OC2 toggle mode, prelouded
2256  0024 35685308      	mov	21256,#104
2257                     ; 57 	TIM2->CCMR3= ((6<<4) & TIM2_CCMR_OCM) | TIM2_CCMR_OCxPE; //OC2 toggle mode, prelouded
2259  0028 35685309      	mov	21257,#104
2260                     ; 58 	TIM2->CCER1= /*TIM2_CCER1_CC1E | TIM2_CCER1_CC1P |*/ TIM2_CCER1_CC2E | TIM2_CCER1_CC2P; //OC1, OC2 output pins enabled
2262  002c 3530530a      	mov	21258,#48
2263                     ; 60 	TIM2->CCER2= TIM2_CCER2_CC3E /*| TIM2_CCER2_CC3P*/; //OC1, OC2 output pins enabled
2265  0030 3501530b      	mov	21259,#1
2266                     ; 62 	TIM2->CR1=(TIM2_CR1_CEN | TIM2_CR1_ARPE);	
2268  0034 35815300      	mov	21248,#129
2269                     ; 64 }
2272  0038 81            	ret
2295                     ; 67 void t4_init(void){
2296                     	switch	.text
2297  0039               _t4_init:
2301                     ; 68 	TIM4->PSCR = 3;
2303  0039 35035347      	mov	21319,#3
2304                     ; 69 	TIM4->ARR= 158;
2306  003d 359e5348      	mov	21320,#158
2307                     ; 70 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
2309  0041 72105343      	bset	21315,#0
2310                     ; 72 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
2312  0045 35855340      	mov	21312,#133
2313                     ; 74 }
2316  0049 81            	ret
2340                     ; 77 void rele_drv(void) {
2341                     	switch	.text
2342  004a               _rele_drv:
2346                     ; 85 	if(play) {
2348                     	btst	_play
2349  004f 2406          	jruge	L1641
2350                     ; 87 		GPIOD->ODR|=(1<<4);
2352  0051 7218500f      	bset	20495,#4
2354  0055 2004          	jra	L3641
2355  0057               L1641:
2356                     ; 89 	else GPIOD->ODR&=~(1<<4);	
2358  0057 7219500f      	bres	20495,#4
2359  005b               L3641:
2360                     ; 90 }
2363  005b 81            	ret
2424                     ; 93 long delay_ms(short in)
2424                     ; 94 {
2425                     	switch	.text
2426  005c               _delay_ms:
2428  005c 520c          	subw	sp,#12
2429       0000000c      OFST:	set	12
2432                     ; 97 i=((long)in)*100UL;
2434  005e 90ae0064      	ldw	y,#100
2435  0062 cd0000        	call	c_vmul
2437  0065 96            	ldw	x,sp
2438  0066 1c0005        	addw	x,#OFST-7
2439  0069 cd0000        	call	c_rtol
2441                     ; 99 for(ii=0;ii<i;ii++)
2443  006c ae0000        	ldw	x,#0
2444  006f 1f0b          	ldw	(OFST-1,sp),x
2445  0071 ae0000        	ldw	x,#0
2446  0074 1f09          	ldw	(OFST-3,sp),x
2448  0076 2012          	jra	L3251
2449  0078               L7151:
2450                     ; 101 		iii++;
2452  0078 96            	ldw	x,sp
2453  0079 1c0001        	addw	x,#OFST-11
2454  007c a601          	ld	a,#1
2455  007e cd0000        	call	c_lgadc
2457                     ; 99 for(ii=0;ii<i;ii++)
2459  0081 96            	ldw	x,sp
2460  0082 1c0009        	addw	x,#OFST-3
2461  0085 a601          	ld	a,#1
2462  0087 cd0000        	call	c_lgadc
2464  008a               L3251:
2467  008a 9c            	rvf
2468  008b 96            	ldw	x,sp
2469  008c 1c0009        	addw	x,#OFST-3
2470  008f cd0000        	call	c_ltor
2472  0092 96            	ldw	x,sp
2473  0093 1c0005        	addw	x,#OFST-7
2474  0096 cd0000        	call	c_lcmp
2476  0099 2fdd          	jrslt	L7151
2477                     ; 104 }
2480  009b 5b0c          	addw	sp,#12
2481  009d 81            	ret
2504                     ; 107 void uart_init (void){
2505                     	switch	.text
2506  009e               _uart_init:
2510                     ; 108 	UART1->CR1&=~UART1_CR1_M;					
2512  009e 72195234      	bres	21044,#4
2513                     ; 109 	UART1->CR3|= (0<<4) & UART1_CR3_STOP;	
2515  00a2 c65236        	ld	a,21046
2516                     ; 110 	UART1->BRR2= 0x01;//0x03;
2518  00a5 35015233      	mov	21043,#1
2519                     ; 111 	UART1->BRR1= 0x1a;//0x68;
2521  00a9 351a5232      	mov	21042,#26
2522                     ; 112 	UART1->CR2|= UART1_CR2_TEN | UART3_CR2_REN | UART3_CR2_RIEN;	
2524  00ad c65235        	ld	a,21045
2525  00b0 aa2c          	or	a,#44
2526  00b2 c75235        	ld	21045,a
2527                     ; 113 }
2530  00b5 81            	ret
2648                     ; 116 void uart_out (char num,char data0,char data1,char data2,char data3,char data4,char data5){
2649                     	switch	.text
2650  00b6               _uart_out:
2652  00b6 89            	pushw	x
2653  00b7 520c          	subw	sp,#12
2654       0000000c      OFST:	set	12
2657                     ; 117 	char i=0,t=0,UOB[10];
2661  00b9 0f01          	clr	(OFST-11,sp)
2662                     ; 120 	UOB[0]=data0;
2664  00bb 9f            	ld	a,xl
2665  00bc 6b02          	ld	(OFST-10,sp),a
2666                     ; 121 	UOB[1]=data1;
2668  00be 7b11          	ld	a,(OFST+5,sp)
2669  00c0 6b03          	ld	(OFST-9,sp),a
2670                     ; 122 	UOB[2]=data2;
2672  00c2 7b12          	ld	a,(OFST+6,sp)
2673  00c4 6b04          	ld	(OFST-8,sp),a
2674                     ; 123 	UOB[3]=data3;
2676  00c6 7b13          	ld	a,(OFST+7,sp)
2677  00c8 6b05          	ld	(OFST-7,sp),a
2678                     ; 124 	UOB[4]=data4;
2680  00ca 7b14          	ld	a,(OFST+8,sp)
2681  00cc 6b06          	ld	(OFST-6,sp),a
2682                     ; 125 	UOB[5]=data5;
2684  00ce 7b15          	ld	a,(OFST+9,sp)
2685  00d0 6b07          	ld	(OFST-5,sp),a
2686                     ; 126 	for (i=0;i<num;i++)
2688  00d2 0f0c          	clr	(OFST+0,sp)
2690  00d4 2013          	jra	L5261
2691  00d6               L1261:
2692                     ; 128 		t^=UOB[i];
2694  00d6 96            	ldw	x,sp
2695  00d7 1c0002        	addw	x,#OFST-10
2696  00da 9f            	ld	a,xl
2697  00db 5e            	swapw	x
2698  00dc 1b0c          	add	a,(OFST+0,sp)
2699  00de 2401          	jrnc	L02
2700  00e0 5c            	incw	x
2701  00e1               L02:
2702  00e1 02            	rlwa	x,a
2703  00e2 7b01          	ld	a,(OFST-11,sp)
2704  00e4 f8            	xor	a,	(x)
2705  00e5 6b01          	ld	(OFST-11,sp),a
2706                     ; 126 	for (i=0;i<num;i++)
2708  00e7 0c0c          	inc	(OFST+0,sp)
2709  00e9               L5261:
2712  00e9 7b0c          	ld	a,(OFST+0,sp)
2713  00eb 110d          	cp	a,(OFST+1,sp)
2714  00ed 25e7          	jrult	L1261
2715                     ; 130 	UOB[num]=num;
2717  00ef 96            	ldw	x,sp
2718  00f0 1c0002        	addw	x,#OFST-10
2719  00f3 9f            	ld	a,xl
2720  00f4 5e            	swapw	x
2721  00f5 1b0d          	add	a,(OFST+1,sp)
2722  00f7 2401          	jrnc	L22
2723  00f9 5c            	incw	x
2724  00fa               L22:
2725  00fa 02            	rlwa	x,a
2726  00fb 7b0d          	ld	a,(OFST+1,sp)
2727  00fd f7            	ld	(x),a
2728                     ; 131 	t^=UOB[num];
2730  00fe 96            	ldw	x,sp
2731  00ff 1c0002        	addw	x,#OFST-10
2732  0102 9f            	ld	a,xl
2733  0103 5e            	swapw	x
2734  0104 1b0d          	add	a,(OFST+1,sp)
2735  0106 2401          	jrnc	L42
2736  0108 5c            	incw	x
2737  0109               L42:
2738  0109 02            	rlwa	x,a
2739  010a 7b01          	ld	a,(OFST-11,sp)
2740  010c f8            	xor	a,	(x)
2741  010d 6b01          	ld	(OFST-11,sp),a
2742                     ; 132 	UOB[num+1]=t;
2744  010f 96            	ldw	x,sp
2745  0110 1c0003        	addw	x,#OFST-9
2746  0113 9f            	ld	a,xl
2747  0114 5e            	swapw	x
2748  0115 1b0d          	add	a,(OFST+1,sp)
2749  0117 2401          	jrnc	L62
2750  0119 5c            	incw	x
2751  011a               L62:
2752  011a 02            	rlwa	x,a
2753  011b 7b01          	ld	a,(OFST-11,sp)
2754  011d f7            	ld	(x),a
2755                     ; 133 	UOB[num+2]=END;
2757  011e 96            	ldw	x,sp
2758  011f 1c0004        	addw	x,#OFST-8
2759  0122 9f            	ld	a,xl
2760  0123 5e            	swapw	x
2761  0124 1b0d          	add	a,(OFST+1,sp)
2762  0126 2401          	jrnc	L03
2763  0128 5c            	incw	x
2764  0129               L03:
2765  0129 02            	rlwa	x,a
2766  012a a60a          	ld	a,#10
2767  012c f7            	ld	(x),a
2768                     ; 137 	for (i=0;i<num+3;i++)
2770  012d 0f0c          	clr	(OFST+0,sp)
2772  012f 2012          	jra	L5361
2773  0131               L1361:
2774                     ; 139 		putchar(UOB[i]);
2776  0131 96            	ldw	x,sp
2777  0132 1c0002        	addw	x,#OFST-10
2778  0135 9f            	ld	a,xl
2779  0136 5e            	swapw	x
2780  0137 1b0c          	add	a,(OFST+0,sp)
2781  0139 2401          	jrnc	L23
2782  013b 5c            	incw	x
2783  013c               L23:
2784  013c 02            	rlwa	x,a
2785  013d f6            	ld	a,(x)
2786  013e cd05a4        	call	_putchar
2788                     ; 137 	for (i=0;i<num+3;i++)
2790  0141 0c0c          	inc	(OFST+0,sp)
2791  0143               L5361:
2794  0143 9c            	rvf
2795  0144 7b0c          	ld	a,(OFST+0,sp)
2796  0146 5f            	clrw	x
2797  0147 97            	ld	xl,a
2798  0148 7b0d          	ld	a,(OFST+1,sp)
2799  014a 905f          	clrw	y
2800  014c 9097          	ld	yl,a
2801  014e 72a90003      	addw	y,#3
2802  0152 bf00          	ldw	c_x,x
2803  0154 90b300        	cpw	y,c_x
2804  0157 2cd8          	jrsgt	L1361
2805                     ; 142 	bOUT_FREE=0;	  	
2807  0159 72110002      	bres	_bOUT_FREE
2808                     ; 143 }
2811  015d 5b0e          	addw	sp,#14
2812  015f 81            	ret
2894                     ; 146 void uart_out_adr_block (unsigned long adress,char *ptr, char len)
2894                     ; 147 {
2895                     	switch	.text
2896  0160               _uart_out_adr_block:
2898  0160 5203          	subw	sp,#3
2899       00000003      OFST:	set	3
2902                     ; 151 t=0;
2904  0162 0f02          	clr	(OFST-1,sp)
2905                     ; 152 temp11=CMND;
2907                     ; 153 t^=temp11;
2909  0164 7b02          	ld	a,(OFST-1,sp)
2910  0166 a816          	xor	a,	#22
2911  0168 6b02          	ld	(OFST-1,sp),a
2912                     ; 154 putchar(temp11);
2914  016a a616          	ld	a,#22
2915  016c cd05a4        	call	_putchar
2917                     ; 156 temp11=10;
2919                     ; 157 t^=temp11;
2921  016f 7b02          	ld	a,(OFST-1,sp)
2922  0171 a80a          	xor	a,	#10
2923  0173 6b02          	ld	(OFST-1,sp),a
2924                     ; 158 putchar(temp11);
2926  0175 a60a          	ld	a,#10
2927  0177 cd05a4        	call	_putchar
2929                     ; 160 temp11=adress%256;//(*((char*)&adress));
2931  017a 7b09          	ld	a,(OFST+6,sp)
2932  017c a4ff          	and	a,#255
2933  017e 6b03          	ld	(OFST+0,sp),a
2934                     ; 161 t^=temp11;
2936  0180 7b02          	ld	a,(OFST-1,sp)
2937  0182 1803          	xor	a,	(OFST+0,sp)
2938  0184 6b02          	ld	(OFST-1,sp),a
2939                     ; 162 putchar(temp11);
2941  0186 7b03          	ld	a,(OFST+0,sp)
2942  0188 cd05a4        	call	_putchar
2944                     ; 163 adress>>=8;
2946  018b 96            	ldw	x,sp
2947  018c 1c0006        	addw	x,#OFST+3
2948  018f a608          	ld	a,#8
2949  0191 cd0000        	call	c_lgursh
2951                     ; 164 temp11=adress%256;//(*(((char*)&adress)+1));
2953  0194 7b09          	ld	a,(OFST+6,sp)
2954  0196 a4ff          	and	a,#255
2955  0198 6b03          	ld	(OFST+0,sp),a
2956                     ; 165 t^=temp11;
2958  019a 7b02          	ld	a,(OFST-1,sp)
2959  019c 1803          	xor	a,	(OFST+0,sp)
2960  019e 6b02          	ld	(OFST-1,sp),a
2961                     ; 166 putchar(temp11);
2963  01a0 7b03          	ld	a,(OFST+0,sp)
2964  01a2 cd05a4        	call	_putchar
2966                     ; 167 adress>>=8;
2968  01a5 96            	ldw	x,sp
2969  01a6 1c0006        	addw	x,#OFST+3
2970  01a9 a608          	ld	a,#8
2971  01ab cd0000        	call	c_lgursh
2973                     ; 168 temp11=adress%256;//(*(((char*)&adress)+2));
2975  01ae 7b09          	ld	a,(OFST+6,sp)
2976  01b0 a4ff          	and	a,#255
2977  01b2 6b03          	ld	(OFST+0,sp),a
2978                     ; 169 t^=temp11;
2980  01b4 7b02          	ld	a,(OFST-1,sp)
2981  01b6 1803          	xor	a,	(OFST+0,sp)
2982  01b8 6b02          	ld	(OFST-1,sp),a
2983                     ; 170 putchar(temp11);
2985  01ba 7b03          	ld	a,(OFST+0,sp)
2986  01bc cd05a4        	call	_putchar
2988                     ; 171 adress>>=8;
2990  01bf 96            	ldw	x,sp
2991  01c0 1c0006        	addw	x,#OFST+3
2992  01c3 a608          	ld	a,#8
2993  01c5 cd0000        	call	c_lgursh
2995                     ; 172 temp11=adress%256;//(*(((char*)&adress)+3));
2997  01c8 7b09          	ld	a,(OFST+6,sp)
2998  01ca a4ff          	and	a,#255
2999  01cc 6b03          	ld	(OFST+0,sp),a
3000                     ; 173 t^=temp11;
3002  01ce 7b02          	ld	a,(OFST-1,sp)
3003  01d0 1803          	xor	a,	(OFST+0,sp)
3004  01d2 6b02          	ld	(OFST-1,sp),a
3005                     ; 174 putchar(temp11);
3007  01d4 7b03          	ld	a,(OFST+0,sp)
3008  01d6 cd05a4        	call	_putchar
3010                     ; 177 for(i11=0;i11<len;i11++)
3012  01d9 0f01          	clr	(OFST-2,sp)
3014  01db 201b          	jra	L7071
3015  01dd               L3071:
3016                     ; 179 	temp11=ptr[i11];
3018  01dd 7b0a          	ld	a,(OFST+7,sp)
3019  01df 97            	ld	xl,a
3020  01e0 7b0b          	ld	a,(OFST+8,sp)
3021  01e2 1b01          	add	a,(OFST-2,sp)
3022  01e4 2401          	jrnc	L63
3023  01e6 5c            	incw	x
3024  01e7               L63:
3025  01e7 02            	rlwa	x,a
3026  01e8 f6            	ld	a,(x)
3027  01e9 6b03          	ld	(OFST+0,sp),a
3028                     ; 180 	t^=temp11;
3030  01eb 7b02          	ld	a,(OFST-1,sp)
3031  01ed 1803          	xor	a,	(OFST+0,sp)
3032  01ef 6b02          	ld	(OFST-1,sp),a
3033                     ; 181 	putchar(temp11);
3035  01f1 7b03          	ld	a,(OFST+0,sp)
3036  01f3 cd05a4        	call	_putchar
3038                     ; 177 for(i11=0;i11<len;i11++)
3040  01f6 0c01          	inc	(OFST-2,sp)
3041  01f8               L7071:
3044  01f8 7b01          	ld	a,(OFST-2,sp)
3045  01fa 110c          	cp	a,(OFST+9,sp)
3046  01fc 25df          	jrult	L3071
3047                     ; 184 temp11=(len+6);
3049  01fe 7b0c          	ld	a,(OFST+9,sp)
3050  0200 ab06          	add	a,#6
3051  0202 6b03          	ld	(OFST+0,sp),a
3052                     ; 185 t^=temp11;
3054  0204 7b02          	ld	a,(OFST-1,sp)
3055  0206 1803          	xor	a,	(OFST+0,sp)
3056  0208 6b02          	ld	(OFST-1,sp),a
3057                     ; 186 putchar(temp11);
3059  020a 7b03          	ld	a,(OFST+0,sp)
3060  020c cd05a4        	call	_putchar
3062                     ; 188 putchar(t);
3064  020f 7b02          	ld	a,(OFST-1,sp)
3065  0211 cd05a4        	call	_putchar
3067                     ; 190 putchar(0x0a);
3069  0214 a60a          	ld	a,#10
3070  0216 cd05a4        	call	_putchar
3072                     ; 192 bOUT_FREE=0;	   
3074  0219 72110002      	bres	_bOUT_FREE
3075                     ; 193 }
3078  021d 5b03          	addw	sp,#3
3079  021f 81            	ret
3189                     ; 195 void uart_in_an(void) {
3190                     	switch	.text
3191  0220               _uart_in_an:
3193  0220 5204          	subw	sp,#4
3194       00000004      OFST:	set	4
3197                     ; 198 	if(UIB[0]==CMND) {
3199  0222 c60000        	ld	a,_UIB
3200  0225 a116          	cp	a,#22
3201  0227 2703          	jreq	L24
3202  0229 cc05a1        	jp	L1671
3203  022c               L24:
3204                     ; 199 		if(UIB[1]==1) {
3206  022c c60001        	ld	a,_UIB+1
3207  022f a101          	cp	a,#1
3208  0231 2620          	jrne	L3671
3209                     ; 203 			temp_L=DF_mf_dev_read();
3211  0233 cd0611        	call	_DF_mf_dev_read
3213                     ; 204 			uart_out (6,CMND,1,mdr0/**((char*)&temp_L)*/,mdr1/**(((char*)&temp_L)+1)*/,mdr2/**(((char*)&temp_L)+2)*/,mdr3/**(((char*)&temp_L)+3)*/);
3215  0236 3b0010        	push	_mdr3
3216  0239 3b0011        	push	_mdr2
3217  023c 3b0012        	push	_mdr1
3218  023f 3b0013        	push	_mdr0
3219  0242 4b01          	push	#1
3220  0244 ae0016        	ldw	x,#22
3221  0247 a606          	ld	a,#6
3222  0249 95            	ld	xh,a
3223  024a cd00b6        	call	_uart_out
3225  024d 5b05          	addw	sp,#5
3227  024f aca105a1      	jpf	L1671
3228  0253               L3671:
3229                     ; 211 	else if(UIB[1]==2) {
3231  0253 c60001        	ld	a,_UIB+1
3232  0256 a102          	cp	a,#2
3233  0258 261f          	jrne	L7671
3234                     ; 214 		temp=DF_status_read();
3236  025a cd065c        	call	_DF_status_read
3238  025d 6b04          	ld	(OFST+0,sp),a
3239                     ; 215 		uart_out (3,CMND,2,temp,0,0,0);    
3241  025f 4b00          	push	#0
3242  0261 4b00          	push	#0
3243  0263 4b00          	push	#0
3244  0265 7b07          	ld	a,(OFST+3,sp)
3245  0267 88            	push	a
3246  0268 4b02          	push	#2
3247  026a ae0016        	ldw	x,#22
3248  026d a603          	ld	a,#3
3249  026f 95            	ld	xh,a
3250  0270 cd00b6        	call	_uart_out
3252  0273 5b05          	addw	sp,#5
3254  0275 aca105a1      	jpf	L1671
3255  0279               L7671:
3256                     ; 219 	else if(UIB[1]==3)
3258  0279 c60001        	ld	a,_UIB+1
3259  027c a103          	cp	a,#3
3260  027e 261d          	jrne	L3771
3261                     ; 222 		DF_memo_to_256();
3263  0280 cd0643        	call	_DF_memo_to_256
3265                     ; 223 		uart_out (2,CMND,3,temp,0,0,0);    
3267  0283 4b00          	push	#0
3268  0285 4b00          	push	#0
3269  0287 4b00          	push	#0
3270  0289 7b07          	ld	a,(OFST+3,sp)
3271  028b 88            	push	a
3272  028c 4b03          	push	#3
3273  028e ae0016        	ldw	x,#22
3274  0291 a602          	ld	a,#2
3275  0293 95            	ld	xh,a
3276  0294 cd00b6        	call	_uart_out
3278  0297 5b05          	addw	sp,#5
3280  0299 aca105a1      	jpf	L1671
3281  029d               L3771:
3282                     ; 226 	else if(UIB[1]==4)
3284  029d c60001        	ld	a,_UIB+1
3285  02a0 a104          	cp	a,#4
3286  02a2 261d          	jrne	L7771
3287                     ; 229 		DF_memo_to_256();
3289  02a4 cd0643        	call	_DF_memo_to_256
3291                     ; 230 		uart_out (2,CMND,3,temp,0,0,0);    
3293  02a7 4b00          	push	#0
3294  02a9 4b00          	push	#0
3295  02ab 4b00          	push	#0
3296  02ad 7b07          	ld	a,(OFST+3,sp)
3297  02af 88            	push	a
3298  02b0 4b03          	push	#3
3299  02b2 ae0016        	ldw	x,#22
3300  02b5 a602          	ld	a,#2
3301  02b7 95            	ld	xh,a
3302  02b8 cd00b6        	call	_uart_out
3304  02bb 5b05          	addw	sp,#5
3306  02bd aca105a1      	jpf	L1671
3307  02c1               L7771:
3308                     ; 233 	else if(UIB[1]==10)
3310  02c1 c60001        	ld	a,_UIB+1
3311  02c4 a10a          	cp	a,#10
3312  02c6 2703cc0348    	jrne	L3002
3313                     ; 238 		if(UIB[2]==1)DF_buffer_read(/*1,*/0,256, buff);
3315  02cb c60002        	ld	a,_UIB+2
3316  02ce a101          	cp	a,#1
3317  02d0 260e          	jrne	L5002
3320  02d2 ae0050        	ldw	x,#_buff
3321  02d5 89            	pushw	x
3322  02d6 ae0100        	ldw	x,#256
3323  02d9 89            	pushw	x
3324  02da 5f            	clrw	x
3325  02db cd06ba        	call	_DF_buffer_read
3327  02de 5b04          	addw	sp,#4
3328  02e0               L5002:
3329                     ; 243 		uart_out_adr_block (0,buff,64);
3331  02e0 4b40          	push	#64
3332  02e2 ae0050        	ldw	x,#_buff
3333  02e5 89            	pushw	x
3334  02e6 ae0000        	ldw	x,#0
3335  02e9 89            	pushw	x
3336  02ea ae0000        	ldw	x,#0
3337  02ed 89            	pushw	x
3338  02ee cd0160        	call	_uart_out_adr_block
3340  02f1 5b07          	addw	sp,#7
3341                     ; 244 		delay_ms(100);    
3343  02f3 ae0064        	ldw	x,#100
3344  02f6 cd005c        	call	_delay_ms
3346                     ; 245 		uart_out_adr_block (64,&buff[64],64);
3348  02f9 4b40          	push	#64
3349  02fb ae0090        	ldw	x,#_buff+64
3350  02fe 89            	pushw	x
3351  02ff ae0040        	ldw	x,#64
3352  0302 89            	pushw	x
3353  0303 ae0000        	ldw	x,#0
3354  0306 89            	pushw	x
3355  0307 cd0160        	call	_uart_out_adr_block
3357  030a 5b07          	addw	sp,#7
3358                     ; 246 		delay_ms(100);    
3360  030c ae0064        	ldw	x,#100
3361  030f cd005c        	call	_delay_ms
3363                     ; 247 		uart_out_adr_block (128,&buff[128],64);
3365  0312 4b40          	push	#64
3366  0314 ae00d0        	ldw	x,#_buff+128
3367  0317 89            	pushw	x
3368  0318 ae0080        	ldw	x,#128
3369  031b 89            	pushw	x
3370  031c ae0000        	ldw	x,#0
3371  031f 89            	pushw	x
3372  0320 cd0160        	call	_uart_out_adr_block
3374  0323 5b07          	addw	sp,#7
3375                     ; 248 		delay_ms(100);    
3377  0325 ae0064        	ldw	x,#100
3378  0328 cd005c        	call	_delay_ms
3380                     ; 249 		uart_out_adr_block (192,&buff[192],64);
3382  032b 4b40          	push	#64
3383  032d ae0110        	ldw	x,#_buff+192
3384  0330 89            	pushw	x
3385  0331 ae00c0        	ldw	x,#192
3386  0334 89            	pushw	x
3387  0335 ae0000        	ldw	x,#0
3388  0338 89            	pushw	x
3389  0339 cd0160        	call	_uart_out_adr_block
3391  033c 5b07          	addw	sp,#7
3392                     ; 250 		delay_ms(100);    
3394  033e ae0064        	ldw	x,#100
3395  0341 cd005c        	call	_delay_ms
3398  0344 aca105a1      	jpf	L1671
3399  0348               L3002:
3400                     ; 253 	else if(UIB[1]==11)
3402  0348 c60001        	ld	a,_UIB+1
3403  034b a10b          	cp	a,#11
3404  034d 2633          	jrne	L1102
3405                     ; 259 		for(i=0;i<256;i++)buff[i]=0;
3407  034f 5f            	clrw	x
3408  0350 1f03          	ldw	(OFST-1,sp),x
3409  0352               L3102:
3412  0352 1e03          	ldw	x,(OFST-1,sp)
3413  0354 724f0050      	clr	(_buff,x)
3416  0358 1e03          	ldw	x,(OFST-1,sp)
3417  035a 1c0001        	addw	x,#1
3418  035d 1f03          	ldw	(OFST-1,sp),x
3421  035f 1e03          	ldw	x,(OFST-1,sp)
3422  0361 a30100        	cpw	x,#256
3423  0364 25ec          	jrult	L3102
3424                     ; 261 		if(UIB[2]==1)DF_buffer_write(/*1,*/0,256, buff);
3426  0366 c60002        	ld	a,_UIB+2
3427  0369 a101          	cp	a,#1
3428  036b 2703          	jreq	L44
3429  036d cc05a1        	jp	L1671
3430  0370               L44:
3433  0370 ae0050        	ldw	x,#_buff
3434  0373 89            	pushw	x
3435  0374 ae0100        	ldw	x,#256
3436  0377 89            	pushw	x
3437  0378 5f            	clrw	x
3438  0379 cd0700        	call	_DF_buffer_write
3440  037c 5b04          	addw	sp,#4
3441  037e aca105a1      	jpf	L1671
3442  0382               L1102:
3443                     ; 265 	else if(UIB[1]==12)
3445  0382 c60001        	ld	a,_UIB+1
3446  0385 a10c          	cp	a,#12
3447  0387 2703          	jreq	L64
3448  0389 cc0468        	jp	L5202
3449  038c               L64:
3450                     ; 271 		for(i=0;i<256;i++)buff[i]=0;
3452  038c 5f            	clrw	x
3453  038d 1f03          	ldw	(OFST-1,sp),x
3454  038f               L7202:
3457  038f 1e03          	ldw	x,(OFST-1,sp)
3458  0391 724f0050      	clr	(_buff,x)
3461  0395 1e03          	ldw	x,(OFST-1,sp)
3462  0397 1c0001        	addw	x,#1
3463  039a 1f03          	ldw	(OFST-1,sp),x
3466  039c 1e03          	ldw	x,(OFST-1,sp)
3467  039e a30100        	cpw	x,#256
3468  03a1 25ec          	jrult	L7202
3469                     ; 273 		if(UIB[3]==1)
3471  03a3 c60003        	ld	a,_UIB+3
3472  03a6 a101          	cp	a,#1
3473  03a8 2632          	jrne	L5302
3474                     ; 275 			buff[0]=0x00;
3476  03aa 725f0050      	clr	_buff
3477                     ; 276 			buff[1]=0x11;
3479  03ae 35110051      	mov	_buff+1,#17
3480                     ; 277 			buff[2]=0x22;
3482  03b2 35220052      	mov	_buff+2,#34
3483                     ; 278 			buff[3]=0x33;
3485  03b6 35330053      	mov	_buff+3,#51
3486                     ; 279 			buff[4]=0x44;
3488  03ba 35440054      	mov	_buff+4,#68
3489                     ; 280 			buff[5]=0x55;
3491  03be 35550055      	mov	_buff+5,#85
3492                     ; 281 			buff[6]=0x66;
3494  03c2 35660056      	mov	_buff+6,#102
3495                     ; 282 			buff[7]=0x77;
3497  03c6 35770057      	mov	_buff+7,#119
3498                     ; 283 			buff[8]=0x88;
3500  03ca 35880058      	mov	_buff+8,#136
3501                     ; 284 			buff[9]=0x99;
3503  03ce 35990059      	mov	_buff+9,#153
3504                     ; 285 			buff[10]=0;
3506  03d2 725f005a      	clr	_buff+10
3507                     ; 286 			buff[11]=0;
3509  03d6 725f005b      	clr	_buff+11
3511  03da 2070          	jra	L7302
3512  03dc               L5302:
3513                     ; 289 		else if(UIB[3]==2)
3515  03dc c60003        	ld	a,_UIB+3
3516  03df a102          	cp	a,#2
3517  03e1 2632          	jrne	L1402
3518                     ; 291 			buff[0]=0x00;
3520  03e3 725f0050      	clr	_buff
3521                     ; 292 			buff[1]=0x10;
3523  03e7 35100051      	mov	_buff+1,#16
3524                     ; 293 			buff[2]=0x20;
3526  03eb 35200052      	mov	_buff+2,#32
3527                     ; 294 			buff[3]=0x30;
3529  03ef 35300053      	mov	_buff+3,#48
3530                     ; 295 			buff[4]=0x40;
3532  03f3 35400054      	mov	_buff+4,#64
3533                     ; 296 			buff[5]=0x50;
3535  03f7 35500055      	mov	_buff+5,#80
3536                     ; 297 			buff[6]=0x60;
3538  03fb 35600056      	mov	_buff+6,#96
3539                     ; 298 			buff[7]=0x70;
3541  03ff 35700057      	mov	_buff+7,#112
3542                     ; 299 			buff[8]=0x80;
3544  0403 35800058      	mov	_buff+8,#128
3545                     ; 300 			buff[9]=0x90;
3547  0407 35900059      	mov	_buff+9,#144
3548                     ; 301 			buff[10]=0;
3550  040b 725f005a      	clr	_buff+10
3551                     ; 302 			buff[11]=0;
3553  040f 725f005b      	clr	_buff+11
3555  0413 2037          	jra	L7302
3556  0415               L1402:
3557                     ; 305 		else if(UIB[3]==3)
3559  0415 c60003        	ld	a,_UIB+3
3560  0418 a103          	cp	a,#3
3561  041a 2630          	jrne	L7302
3562                     ; 307 			buff[0]=0x98;
3564  041c 35980050      	mov	_buff,#152
3565                     ; 308 			buff[1]=0x87;
3567  0420 35870051      	mov	_buff+1,#135
3568                     ; 309 			buff[2]=0x76;
3570  0424 35760052      	mov	_buff+2,#118
3571                     ; 310 			buff[3]=0x65;
3573  0428 35650053      	mov	_buff+3,#101
3574                     ; 311 			buff[4]=0x54;
3576  042c 35540054      	mov	_buff+4,#84
3577                     ; 312 			buff[5]=0x43;
3579  0430 35430055      	mov	_buff+5,#67
3580                     ; 313 			buff[6]=0x32;
3582  0434 35320056      	mov	_buff+6,#50
3583                     ; 314 			buff[7]=0x21;
3585  0438 35210057      	mov	_buff+7,#33
3586                     ; 315 			buff[8]=0x10;
3588  043c 35100058      	mov	_buff+8,#16
3589                     ; 316 			buff[9]=0x00;
3591  0440 725f0059      	clr	_buff+9
3592                     ; 317 			buff[10]=0;
3594  0444 725f005a      	clr	_buff+10
3595                     ; 318 			buff[11]=0;
3597  0448 725f005b      	clr	_buff+11
3598  044c               L7302:
3599                     ; 320 		if(UIB[2]==1)DF_buffer_write(/*1,*/0,256, buff);
3601  044c c60002        	ld	a,_UIB+2
3602  044f a101          	cp	a,#1
3603  0451 2703          	jreq	L05
3604  0453 cc05a1        	jp	L1671
3605  0456               L05:
3608  0456 ae0050        	ldw	x,#_buff
3609  0459 89            	pushw	x
3610  045a ae0100        	ldw	x,#256
3611  045d 89            	pushw	x
3612  045e 5f            	clrw	x
3613  045f cd0700        	call	_DF_buffer_write
3615  0462 5b04          	addw	sp,#4
3616  0464 aca105a1      	jpf	L1671
3617  0468               L5202:
3618                     ; 324 	else if(UIB[1]==13)
3620  0468 c60001        	ld	a,_UIB+1
3621  046b a10d          	cp	a,#13
3622  046d 260c          	jrne	L3502
3623                     ; 329 		DF_page_to_buffer(/*UIB[2],*/UIB[3]);
3625  046f c60003        	ld	a,_UIB+3
3626  0472 5f            	clrw	x
3627  0473 97            	ld	xl,a
3628  0474 cd0674        	call	_DF_page_to_buffer
3631  0477 aca105a1      	jpf	L1671
3632  047b               L3502:
3633                     ; 332 	else if(UIB[1]==14)
3635  047b c60001        	ld	a,_UIB+1
3636  047e a10e          	cp	a,#14
3637  0480 260c          	jrne	L7502
3638                     ; 337 		DF_buffer_to_page_er(/*UIB[2],*/UIB[3]);
3640  0482 c60003        	ld	a,_UIB+3
3641  0485 5f            	clrw	x
3642  0486 97            	ld	xl,a
3643  0487 cd0697        	call	_DF_buffer_to_page_er
3646  048a aca105a1      	jpf	L1671
3647  048e               L7502:
3648                     ; 341 	else if(UIB[1]==20)
3650  048e c60001        	ld	a,_UIB+1
3651  0491 a114          	cp	a,#20
3652  0493 2671          	jrne	L3602
3653                     ; 346 		file_lengt=0;
3655  0495 ae0000        	ldw	x,#0
3656  0498 bf06          	ldw	_file_lengt+2,x
3657  049a ae0000        	ldw	x,#0
3658  049d bf04          	ldw	_file_lengt,x
3659                     ; 347 		file_lengt+=UIB[5];
3661  049f c60005        	ld	a,_UIB+5
3662  04a2 ae0004        	ldw	x,#_file_lengt
3663  04a5 88            	push	a
3664  04a6 cd0000        	call	c_lgadc
3666  04a9 84            	pop	a
3667                     ; 348 		file_lengt<<=8;
3669  04aa ae0004        	ldw	x,#_file_lengt
3670  04ad a608          	ld	a,#8
3671  04af cd0000        	call	c_lglsh
3673                     ; 349 		file_lengt+=UIB[4];
3675  04b2 c60004        	ld	a,_UIB+4
3676  04b5 ae0004        	ldw	x,#_file_lengt
3677  04b8 88            	push	a
3678  04b9 cd0000        	call	c_lgadc
3680  04bc 84            	pop	a
3681                     ; 350 		file_lengt<<=8;
3683  04bd ae0004        	ldw	x,#_file_lengt
3684  04c0 a608          	ld	a,#8
3685  04c2 cd0000        	call	c_lglsh
3687                     ; 351 		file_lengt+=UIB[3];
3689  04c5 c60003        	ld	a,_UIB+3
3690  04c8 ae0004        	ldw	x,#_file_lengt
3691  04cb 88            	push	a
3692  04cc cd0000        	call	c_lgadc
3694  04cf 84            	pop	a
3695                     ; 352 		file_lengt_in_pages=file_lengt;
3697  04d0 be06          	ldw	x,_file_lengt+2
3698  04d2 bf0e          	ldw	_file_lengt_in_pages,x
3699                     ; 353 		file_lengt<<=8;
3701  04d4 ae0004        	ldw	x,#_file_lengt
3702  04d7 a608          	ld	a,#8
3703  04d9 cd0000        	call	c_lglsh
3705                     ; 354 		file_lengt+=UIB[2];
3707  04dc c60002        	ld	a,_UIB+2
3708  04df ae0004        	ldw	x,#_file_lengt
3709  04e2 88            	push	a
3710  04e3 cd0000        	call	c_lgadc
3712  04e6 84            	pop	a
3713                     ; 359 		current_page=0;
3715  04e7 5f            	clrw	x
3716  04e8 bf0c          	ldw	_current_page,x
3717                     ; 360 		current_byte_in_buffer=0;
3719  04ea 5f            	clrw	x
3720  04eb bf08          	ldw	_current_byte_in_buffer,x
3721                     ; 363 		uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
3723  04ed 4b00          	push	#0
3724  04ef 4b00          	push	#0
3725  04f1 4b00          	push	#0
3726  04f3 4b00          	push	#0
3727  04f5 4b15          	push	#21
3728  04f7 ae0016        	ldw	x,#22
3729  04fa a604          	ld	a,#4
3730  04fc 95            	ld	xh,a
3731  04fd cd00b6        	call	_uart_out
3733  0500 5b05          	addw	sp,#5
3735  0502 aca105a1      	jpf	L1671
3736  0506               L3602:
3737                     ; 366 	else if(UIB[1]==21)
3739  0506 c60001        	ld	a,_UIB+1
3740  0509 a115          	cp	a,#21
3741  050b 267c          	jrne	L7602
3742                     ; 371           for(i=0;i<64;i++)
3744  050d 5f            	clrw	x
3745  050e 1f03          	ldw	(OFST-1,sp),x
3746  0510               L1702:
3747                     ; 373           	buff[current_byte_in_buffer+i]=UIB[2+i];
3749  0510 1e03          	ldw	x,(OFST-1,sp)
3750  0512 d60002        	ld	a,(_UIB+2,x)
3751  0515 be08          	ldw	x,_current_byte_in_buffer
3752  0517 72fb03        	addw	x,(OFST-1,sp)
3753  051a d70050        	ld	(_buff,x),a
3754                     ; 371           for(i=0;i<64;i++)
3756  051d 1e03          	ldw	x,(OFST-1,sp)
3757  051f 1c0001        	addw	x,#1
3758  0522 1f03          	ldw	(OFST-1,sp),x
3761  0524 1e03          	ldw	x,(OFST-1,sp)
3762  0526 a30040        	cpw	x,#64
3763  0529 25e5          	jrult	L1702
3764                     ; 375           current_byte_in_buffer+=64;
3766  052b be08          	ldw	x,_current_byte_in_buffer
3767  052d 1c0040        	addw	x,#64
3768  0530 bf08          	ldw	_current_byte_in_buffer,x
3769                     ; 376           if(current_byte_in_buffer>=256)
3771  0532 be08          	ldw	x,_current_byte_in_buffer
3772  0534 a30100        	cpw	x,#256
3773  0537 2568          	jrult	L1671
3774                     ; 384           	DF_buffer_write(/*//current_buffer*//*1,*/0,256,buff);
3776  0539 ae0050        	ldw	x,#_buff
3777  053c 89            	pushw	x
3778  053d ae0100        	ldw	x,#256
3779  0540 89            	pushw	x
3780  0541 5f            	clrw	x
3781  0542 cd0700        	call	_DF_buffer_write
3783  0545 5b04          	addw	sp,#4
3784                     ; 385           	DF_buffer_to_page_er(/*///current_buffer*//*1,*/current_page);
3786  0547 be0c          	ldw	x,_current_page
3787  0549 cd0697        	call	_DF_buffer_to_page_er
3789                     ; 386 			current_page++;
3791  054c be0c          	ldw	x,_current_page
3792  054e 1c0001        	addw	x,#1
3793  0551 bf0c          	ldw	_current_page,x
3794                     ; 387 			if(current_page<file_lengt_in_pages)
3796  0553 be0c          	ldw	x,_current_page
3797  0555 b30e          	cpw	x,_file_lengt_in_pages
3798  0557 2424          	jruge	L1012
3799                     ; 389 				delay_ms(50);
3801  0559 ae0032        	ldw	x,#50
3802  055c cd005c        	call	_delay_ms
3804                     ; 390 				uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
3806  055f 4b00          	push	#0
3807  0561 4b00          	push	#0
3808  0563 3b000c        	push	_current_page
3809  0566 b60d          	ld	a,_current_page+1
3810  0568 a4ff          	and	a,#255
3811  056a 88            	push	a
3812  056b 4b15          	push	#21
3813  056d ae0016        	ldw	x,#22
3814  0570 a604          	ld	a,#4
3815  0572 95            	ld	xh,a
3816  0573 cd00b6        	call	_uart_out
3818  0576 5b05          	addw	sp,#5
3819                     ; 391 				current_byte_in_buffer=0;
3821  0578 5f            	clrw	x
3822  0579 bf08          	ldw	_current_byte_in_buffer,x
3824  057b 2024          	jra	L1671
3825  057d               L1012:
3826                     ; 395 				EE_PAGE_LEN=current_page;
3828  057d be0c          	ldw	x,_current_page
3829  057f 89            	pushw	x
3830  0580 ae0000        	ldw	x,#_EE_PAGE_LEN
3831  0583 cd0000        	call	c_eewrw
3833  0586 85            	popw	x
3834  0587 2018          	jra	L1671
3835  0589               L7602:
3836                     ; 403 	else if(UIB[1]==30)
3838  0589 c60001        	ld	a,_UIB+1
3839  058c a11e          	cp	a,#30
3840  058e 2606          	jrne	L7012
3841                     ; 425           bSTART=1;
3843  0590 7210000b      	bset	_bSTART
3845  0594 200b          	jra	L1671
3846  0596               L7012:
3847                     ; 437 	else if(UIB[1]==40)
3849  0596 c60001        	ld	a,_UIB+1
3850  0599 a128          	cp	a,#40
3851  059b 2604          	jrne	L1671
3852                     ; 459 		bSTART=1;	
3854  059d 7210000b      	bset	_bSTART
3855  05a1               L1671:
3856                     ; 463 }
3859  05a1 5b04          	addw	sp,#4
3860  05a3 81            	ret
3897                     ; 466 void putchar(char c)
3897                     ; 467 {
3898                     	switch	.text
3899  05a4               _putchar:
3901  05a4 88            	push	a
3902       00000000      OFST:	set	0
3905  05a5               L5312:
3906                     ; 468 while (tx_counter == TX_BUFFER_SIZE);
3908  05a5 b61a          	ld	a,_tx_counter
3909  05a7 a150          	cp	a,#80
3910  05a9 27fa          	jreq	L5312
3911                     ; 470 if (tx_counter || ((UART1->SR & UART1_SR_TXE)==0))
3913  05ab 3d1a          	tnz	_tx_counter
3914  05ad 2607          	jrne	L3412
3916  05af c65230        	ld	a,21040
3917  05b2 a580          	bcp	a,#128
3918  05b4 261d          	jrne	L1412
3919  05b6               L3412:
3920                     ; 472    tx_buffer[tx_wr_index]=c;
3922  05b6 5f            	clrw	x
3923  05b7 b619          	ld	a,_tx_wr_index
3924  05b9 2a01          	jrpl	L45
3925  05bb 53            	cplw	x
3926  05bc               L45:
3927  05bc 97            	ld	xl,a
3928  05bd 7b01          	ld	a,(OFST+1,sp)
3929  05bf e704          	ld	(_tx_buffer,x),a
3930                     ; 473    if (++tx_wr_index == TX_BUFFER_SIZE) tx_wr_index=0;
3932  05c1 3c19          	inc	_tx_wr_index
3933  05c3 b619          	ld	a,_tx_wr_index
3934  05c5 a150          	cp	a,#80
3935  05c7 2602          	jrne	L5412
3938  05c9 3f19          	clr	_tx_wr_index
3939  05cb               L5412:
3940                     ; 474    ++tx_counter;
3942  05cb 3c1a          	inc	_tx_counter
3944  05cd               L7412:
3945                     ; 478 UART1->CR2|= UART1_CR2_TIEN;
3947  05cd 721e5235      	bset	21045,#7
3948                     ; 480 }
3951  05d1 84            	pop	a
3952  05d2 81            	ret
3953  05d3               L1412:
3954                     ; 476 else UART1->DR=c;
3956  05d3 7b01          	ld	a,(OFST+1,sp)
3957  05d5 c75231        	ld	21041,a
3958  05d8 20f3          	jra	L7412
3981                     ; 483 void spi_init(void){
3982                     	switch	.text
3983  05da               _spi_init:
3987                     ; 485 	GPIOB->DDR|=(1<<5);
3989  05da 721a5007      	bset	20487,#5
3990                     ; 486 	GPIOB->CR1|=(1<<5);
3992  05de 721a5008      	bset	20488,#5
3993                     ; 487 	GPIOB->CR2&=~(1<<5);	
3995  05e2 721b5009      	bres	20489,#5
3996                     ; 489 	SPI->CR1= /*SPI_CR1_LSBFIRST |*/
3996                     ; 490 			SPI_CR1_SPE | 
3996                     ; 491 			( (4<< 2) & SPI_CR1_BR ) |
3996                     ; 492 			SPI_CR1_MSTR |
3996                     ; 493 			SPI_CR1_CPOL |
3996                     ; 494 			SPI_CR1_CPHA; 
3998  05e6 35575200      	mov	20992,#87
3999                     ; 496 	SPI->CR2= SPI_CR2_SSM | SPI_CR2_SSI;
4001  05ea 35035201      	mov	20993,#3
4002                     ; 497 	SPI->ICR= 0;	
4004  05ee 725f5202      	clr	20994
4005                     ; 498 }
4008  05f2 81            	ret
4051                     ; 501 char spi(char in){
4052                     	switch	.text
4053  05f3               _spi:
4055  05f3 88            	push	a
4056  05f4 88            	push	a
4057       00000001      OFST:	set	1
4060  05f5               L5022:
4061                     ; 503 	while(!((SPI->SR)&SPI_SR_TXE));
4063  05f5 c65203        	ld	a,20995
4064  05f8 a502          	bcp	a,#2
4065  05fa 27f9          	jreq	L5022
4066                     ; 504 	SPI->DR=in;
4068  05fc 7b02          	ld	a,(OFST+1,sp)
4069  05fe c75204        	ld	20996,a
4071  0601               L5122:
4072                     ; 505 	while(!((SPI->SR)&SPI_SR_RXNE));
4074  0601 c65203        	ld	a,20995
4075  0604 a501          	bcp	a,#1
4076  0606 27f9          	jreq	L5122
4077                     ; 506 	c=SPI->DR;	
4079  0608 c65204        	ld	a,20996
4080  060b 6b01          	ld	(OFST+0,sp),a
4081                     ; 507 	return c;
4083  060d 7b01          	ld	a,(OFST+0,sp)
4086  060f 85            	popw	x
4087  0610 81            	ret
4153                     ; 512 long DF_mf_dev_read(void)
4153                     ; 513 {
4154                     	switch	.text
4155  0611               _DF_mf_dev_read:
4157  0611 5204          	subw	sp,#4
4158       00000004      OFST:	set	4
4161                     ; 516 d0=0;
4163  0613 0f04          	clr	(OFST+0,sp)
4164                     ; 517 d1=0;
4166                     ; 518 d2=0;
4168                     ; 519 d3=0;
4170                     ; 521 CS_ON
4172  0615 721b5005      	bres	20485,#5
4173                     ; 522 spi(0x9f);
4175  0619 a69f          	ld	a,#159
4176  061b add6          	call	_spi
4178                     ; 523 mdr0=spi(0xff);
4180  061d a6ff          	ld	a,#255
4181  061f add2          	call	_spi
4183  0621 b713          	ld	_mdr0,a
4184                     ; 524 mdr1=spi(0xff);
4186  0623 a6ff          	ld	a,#255
4187  0625 adcc          	call	_spi
4189  0627 b712          	ld	_mdr1,a
4190                     ; 525 mdr2=spi(0xff);
4192  0629 a6ff          	ld	a,#255
4193  062b adc6          	call	_spi
4195  062d b711          	ld	_mdr2,a
4196                     ; 526 mdr3=spi(0xff);  
4198  062f a6ff          	ld	a,#255
4199  0631 adc0          	call	_spi
4201  0633 b710          	ld	_mdr3,a
4202                     ; 528 CS_OFF
4204  0635 721a5005      	bset	20485,#5
4205                     ; 529 return  *((long*)&d0);
4207  0639 96            	ldw	x,sp
4208  063a 1c0004        	addw	x,#OFST+0
4209  063d cd0000        	call	c_ltor
4213  0640 5b04          	addw	sp,#4
4214  0642 81            	ret
4238                     ; 533 void DF_memo_to_256(void)
4238                     ; 534 {
4239                     	switch	.text
4240  0643               _DF_memo_to_256:
4244                     ; 536 CS_ON
4246  0643 721b5005      	bres	20485,#5
4247                     ; 537 spi(0x3d);
4249  0647 a63d          	ld	a,#61
4250  0649 ada8          	call	_spi
4252                     ; 538 spi(0x2a); 
4254  064b a62a          	ld	a,#42
4255  064d ada4          	call	_spi
4257                     ; 539 spi(0x80);
4259  064f a680          	ld	a,#128
4260  0651 ada0          	call	_spi
4262                     ; 540 spi(0xa6);
4264  0653 a6a6          	ld	a,#166
4265  0655 ad9c          	call	_spi
4267                     ; 542 CS_OFF
4269  0657 721a5005      	bset	20485,#5
4270                     ; 543 }  
4273  065b 81            	ret
4308                     ; 548 char DF_status_read(void)
4308                     ; 549 {
4309                     	switch	.text
4310  065c               _DF_status_read:
4312  065c 88            	push	a
4313       00000001      OFST:	set	1
4316                     ; 553 CS_ON
4318  065d 721b5005      	bres	20485,#5
4319                     ; 554 spi(0xd7);
4321  0661 a6d7          	ld	a,#215
4322  0663 ad8e          	call	_spi
4324                     ; 555 d0=spi(0xff);
4326  0665 a6ff          	ld	a,#255
4327  0667 ad8a          	call	_spi
4329  0669 6b01          	ld	(OFST+0,sp),a
4330                     ; 557 CS_OFF
4332  066b 721a5005      	bset	20485,#5
4333                     ; 558 return d0;
4335  066f 7b01          	ld	a,(OFST+0,sp)
4338  0671 5b01          	addw	sp,#1
4339  0673 81            	ret
4383                     ; 562 void DF_page_to_buffer(unsigned page_addr)
4383                     ; 563 {
4384                     	switch	.text
4385  0674               _DF_page_to_buffer:
4387  0674 89            	pushw	x
4388  0675 88            	push	a
4389       00000001      OFST:	set	1
4392                     ; 566 d0=0x53; 
4394                     ; 570 CS_ON
4396  0676 721b5005      	bres	20485,#5
4397                     ; 571 spi(d0);
4399  067a a653          	ld	a,#83
4400  067c cd05f3        	call	_spi
4402                     ; 572 spi(page_addr/256/**(((char*)&page_addr)+1)*/);
4404  067f 7b02          	ld	a,(OFST+1,sp)
4405  0681 cd05f3        	call	_spi
4407                     ; 573 spi(page_addr%256/**((char*)&page_addr)*/);
4409  0684 7b03          	ld	a,(OFST+2,sp)
4410  0686 a4ff          	and	a,#255
4411  0688 cd05f3        	call	_spi
4413                     ; 574 spi(0xff);
4415  068b a6ff          	ld	a,#255
4416  068d cd05f3        	call	_spi
4418                     ; 576 CS_OFF
4420  0690 721a5005      	bset	20485,#5
4421                     ; 577 }
4424  0694 5b03          	addw	sp,#3
4425  0696 81            	ret
4470                     ; 580 void DF_buffer_to_page_er(/*char buff,*/unsigned page_addr)
4470                     ; 581 {
4471                     	switch	.text
4472  0697               _DF_buffer_to_page_er:
4474  0697 89            	pushw	x
4475  0698 88            	push	a
4476       00000001      OFST:	set	1
4479                     ; 584 d0=0x83; 
4481                     ; 587 CS_ON
4483  0699 721b5005      	bres	20485,#5
4484                     ; 588 spi(d0);
4486  069d a683          	ld	a,#131
4487  069f cd05f3        	call	_spi
4489                     ; 589 spi(page_addr/256/**(((char*)&page_addr)+1)*/);
4491  06a2 7b02          	ld	a,(OFST+1,sp)
4492  06a4 cd05f3        	call	_spi
4494                     ; 590 spi(page_addr%256/**((char*)&page_addr)*/);
4496  06a7 7b03          	ld	a,(OFST+2,sp)
4497  06a9 a4ff          	and	a,#255
4498  06ab cd05f3        	call	_spi
4500                     ; 591 spi(0xff);
4502  06ae a6ff          	ld	a,#255
4503  06b0 cd05f3        	call	_spi
4505                     ; 593 CS_OFF
4507  06b3 721a5005      	bset	20485,#5
4508                     ; 594 }
4511  06b7 5b03          	addw	sp,#3
4512  06b9 81            	ret
4584                     ; 597 void DF_buffer_read(unsigned buff_addr,unsigned len, char* adr)
4584                     ; 598 {
4585                     	switch	.text
4586  06ba               _DF_buffer_read:
4588  06ba 89            	pushw	x
4589  06bb 5203          	subw	sp,#3
4590       00000003      OFST:	set	3
4593                     ; 602 d0=0x54; 
4595                     ; 604 CS_ON
4597  06bd 721b5005      	bres	20485,#5
4598                     ; 605 spi(d0);
4600  06c1 a654          	ld	a,#84
4601  06c3 cd05f3        	call	_spi
4603                     ; 606 spi(0xff);
4605  06c6 a6ff          	ld	a,#255
4606  06c8 cd05f3        	call	_spi
4608                     ; 607 spi(buff_addr/256/**(((char*)&buff_addr)+1)*/);
4610  06cb 7b04          	ld	a,(OFST+1,sp)
4611  06cd cd05f3        	call	_spi
4613                     ; 608 spi(buff_addr%256/**((char*)&buff_addr)*/);
4615  06d0 7b05          	ld	a,(OFST+2,sp)
4616  06d2 a4ff          	and	a,#255
4617  06d4 cd05f3        	call	_spi
4619                     ; 609 spi(0xff);
4621  06d7 a6ff          	ld	a,#255
4622  06d9 cd05f3        	call	_spi
4624                     ; 610 for(i=0;i<len;i++)
4626  06dc 5f            	clrw	x
4627  06dd 1f02          	ldw	(OFST-1,sp),x
4629  06df 2012          	jra	L7042
4630  06e1               L3042:
4631                     ; 612 	adr[i]=spi(0xff);
4633  06e1 a6ff          	ld	a,#255
4634  06e3 cd05f3        	call	_spi
4636  06e6 1e0a          	ldw	x,(OFST+7,sp)
4637  06e8 72fb02        	addw	x,(OFST-1,sp)
4638  06eb f7            	ld	(x),a
4639                     ; 610 for(i=0;i<len;i++)
4641  06ec 1e02          	ldw	x,(OFST-1,sp)
4642  06ee 1c0001        	addw	x,#1
4643  06f1 1f02          	ldw	(OFST-1,sp),x
4644  06f3               L7042:
4647  06f3 1e02          	ldw	x,(OFST-1,sp)
4648  06f5 1308          	cpw	x,(OFST+5,sp)
4649  06f7 25e8          	jrult	L3042
4650                     ; 615 CS_OFF
4652  06f9 721a5005      	bset	20485,#5
4653                     ; 616 }
4656  06fd 5b05          	addw	sp,#5
4657  06ff 81            	ret
4729                     ; 619 void DF_buffer_write(/*char buff,*/unsigned buff_addr,unsigned len, char* adr)
4729                     ; 620 {
4730                     	switch	.text
4731  0700               _DF_buffer_write:
4733  0700 89            	pushw	x
4734  0701 5203          	subw	sp,#3
4735       00000003      OFST:	set	3
4738                     ; 624 d0=0x84; 
4740                     ; 626 CS_ON
4742  0703 721b5005      	bres	20485,#5
4743                     ; 627 spi(d0);
4745  0707 a684          	ld	a,#132
4746  0709 cd05f3        	call	_spi
4748                     ; 628 spi(0xff);
4750  070c a6ff          	ld	a,#255
4751  070e cd05f3        	call	_spi
4753                     ; 629 spi(buff_addr/256/**(((char*)&buff_addr)+1)*/);
4755  0711 7b04          	ld	a,(OFST+1,sp)
4756  0713 cd05f3        	call	_spi
4758                     ; 630 spi(buff_addr%256/**((char*)&buff_addr)*/);
4760  0716 7b05          	ld	a,(OFST+2,sp)
4761  0718 a4ff          	and	a,#255
4762  071a cd05f3        	call	_spi
4764                     ; 632 for(i=0;i<len;i++)
4766  071d 5f            	clrw	x
4767  071e 1f02          	ldw	(OFST-1,sp),x
4769  0720 2010          	jra	L5542
4770  0722               L1542:
4771                     ; 634 	spi(adr[i]);
4773  0722 1e0a          	ldw	x,(OFST+7,sp)
4774  0724 72fb02        	addw	x,(OFST-1,sp)
4775  0727 f6            	ld	a,(x)
4776  0728 cd05f3        	call	_spi
4778                     ; 632 for(i=0;i<len;i++)
4780  072b 1e02          	ldw	x,(OFST-1,sp)
4781  072d 1c0001        	addw	x,#1
4782  0730 1f02          	ldw	(OFST-1,sp),x
4783  0732               L5542:
4786  0732 1e02          	ldw	x,(OFST-1,sp)
4787  0734 1308          	cpw	x,(OFST+5,sp)
4788  0736 25ea          	jrult	L1542
4789                     ; 637 CS_OFF
4791  0738 721a5005      	bset	20485,#5
4792                     ; 638 }
4795  073c 5b05          	addw	sp,#5
4796  073e 81            	ret
4819                     ; 660 void gpio_init(void){
4820                     	switch	.text
4821  073f               _gpio_init:
4825                     ; 672 	GPIOD->DDR|=(1<<4);
4827  073f 72185011      	bset	20497,#4
4828                     ; 673 	GPIOD->CR1|=(1<<4);
4830  0743 72185012      	bset	20498,#4
4831                     ; 674 	GPIOD->CR2&=~(1<<4);
4833  0747 72195013      	bres	20499,#4
4834                     ; 682 }
4837  074b 81            	ret
4889                     ; 685 void uart_in(void)
4889                     ; 686 {
4890                     	switch	.text
4891  074c               _uart_in:
4893  074c 89            	pushw	x
4894       00000002      OFST:	set	2
4897                     ; 690 if(rx_buffer_overflow)
4899                     	btst	_rx_buffer_overflow
4900  0752 240a          	jruge	L3152
4901                     ; 692 	rx_wr_index=0;
4903  0754 3f16          	clr	_rx_wr_index
4904                     ; 693 	rx_rd_index=0;
4906  0756 3f15          	clr	_rx_rd_index
4907                     ; 694 	rx_counter=0;
4909  0758 3f17          	clr	_rx_counter
4910                     ; 695 	rx_buffer_overflow=0;
4912  075a 72110000      	bres	_rx_buffer_overflow
4913  075e               L3152:
4914                     ; 698 if(rx_counter&&(rx_buffer[index_offset(rx_wr_index,-1)])==END)
4916  075e 3d17          	tnz	_rx_counter
4917  0760 2766          	jreq	L5152
4919  0762 aeffff        	ldw	x,#65535
4920  0765 b616          	ld	a,_rx_wr_index
4921  0767 95            	ld	xh,a
4922  0768 ad60          	call	_index_offset
4924  076a 5f            	clrw	x
4925  076b 97            	ld	xl,a
4926  076c e654          	ld	a,(_rx_buffer,x)
4927  076e a10a          	cp	a,#10
4928  0770 2656          	jrne	L5152
4929                     ; 702     temp=rx_buffer[index_offset(rx_wr_index,-3)];
4931  0772 aefffd        	ldw	x,#65533
4932  0775 b616          	ld	a,_rx_wr_index
4933  0777 95            	ld	xh,a
4934  0778 ad50          	call	_index_offset
4936  077a 5f            	clrw	x
4937  077b 97            	ld	xl,a
4938  077c e654          	ld	a,(_rx_buffer,x)
4939  077e 6b01          	ld	(OFST-1,sp),a
4940                     ; 703     	if(temp<100) 
4942  0780 7b01          	ld	a,(OFST-1,sp)
4943  0782 a164          	cp	a,#100
4944  0784 2442          	jruge	L5152
4945                     ; 706     		if(control_check(index_offset(rx_wr_index,-1)))
4947  0786 aeffff        	ldw	x,#65535
4948  0789 b616          	ld	a,_rx_wr_index
4949  078b 95            	ld	xh,a
4950  078c ad3c          	call	_index_offset
4952  078e ad5f          	call	_control_check
4954  0790 4d            	tnz	a
4955  0791 2735          	jreq	L5152
4956                     ; 709     			rx_rd_index=index_offset(rx_wr_index,-3-temp);
4958  0793 a6fd          	ld	a,#253
4959  0795 1001          	sub	a,(OFST-1,sp)
4960  0797 97            	ld	xl,a
4961  0798 b616          	ld	a,_rx_wr_index
4962  079a 95            	ld	xh,a
4963  079b ad2d          	call	_index_offset
4965  079d b715          	ld	_rx_rd_index,a
4966                     ; 710     			for(i=0;i<temp;i++)
4968  079f 0f02          	clr	(OFST+0,sp)
4970  07a1 2017          	jra	L7252
4971  07a3               L3252:
4972                     ; 712 				UIB[i]=rx_buffer[index_offset(rx_rd_index,i)];
4974  07a3 7b02          	ld	a,(OFST+0,sp)
4975  07a5 5f            	clrw	x
4976  07a6 97            	ld	xl,a
4977  07a7 89            	pushw	x
4978  07a8 7b04          	ld	a,(OFST+2,sp)
4979  07aa 97            	ld	xl,a
4980  07ab b615          	ld	a,_rx_rd_index
4981  07ad 95            	ld	xh,a
4982  07ae ad1a          	call	_index_offset
4984  07b0 5f            	clrw	x
4985  07b1 97            	ld	xl,a
4986  07b2 e654          	ld	a,(_rx_buffer,x)
4987  07b4 85            	popw	x
4988  07b5 d70000        	ld	(_UIB,x),a
4989                     ; 710     			for(i=0;i<temp;i++)
4991  07b8 0c02          	inc	(OFST+0,sp)
4992  07ba               L7252:
4995  07ba 7b02          	ld	a,(OFST+0,sp)
4996  07bc 1101          	cp	a,(OFST-1,sp)
4997  07be 25e3          	jrult	L3252
4998                     ; 714 			rx_rd_index=rx_wr_index;
5000  07c0 451615        	mov	_rx_rd_index,_rx_wr_index
5001                     ; 715 			rx_counter=0;
5003  07c3 3f17          	clr	_rx_counter
5004                     ; 717 			uart_in_an();
5006  07c5 cd0220        	call	_uart_in_an
5008  07c8               L5152:
5009                     ; 726 }
5012  07c8 85            	popw	x
5013  07c9 81            	ret
5056                     ; 729 char index_offset (signed char index,signed char offset)
5056                     ; 730 {
5057                     	switch	.text
5058  07ca               _index_offset:
5060  07ca 89            	pushw	x
5061       00000000      OFST:	set	0
5064                     ; 731 index=index+offset;
5066  07cb 7b01          	ld	a,(OFST+1,sp)
5067  07cd 1b02          	add	a,(OFST+2,sp)
5068  07cf 6b01          	ld	(OFST+1,sp),a
5069                     ; 732 if(index>=RX_BUFFER_SIZE) index-=RX_BUFFER_SIZE; 
5071  07d1 9c            	rvf
5072  07d2 7b01          	ld	a,(OFST+1,sp)
5073  07d4 a150          	cp	a,#80
5074  07d6 2f06          	jrslt	L5552
5077  07d8 7b01          	ld	a,(OFST+1,sp)
5078  07da a050          	sub	a,#80
5079  07dc 6b01          	ld	(OFST+1,sp),a
5080  07de               L5552:
5081                     ; 733 if(index<0) index+=RX_BUFFER_SIZE;
5083  07de 9c            	rvf
5084  07df 7b01          	ld	a,(OFST+1,sp)
5085  07e1 a100          	cp	a,#0
5086  07e3 2e06          	jrsge	L7552
5089  07e5 7b01          	ld	a,(OFST+1,sp)
5090  07e7 ab50          	add	a,#80
5091  07e9 6b01          	ld	(OFST+1,sp),a
5092  07eb               L7552:
5093                     ; 734 return index;
5095  07eb 7b01          	ld	a,(OFST+1,sp)
5098  07ed 85            	popw	x
5099  07ee 81            	ret
5162                     ; 738 char control_check(char index)
5162                     ; 739 {
5163                     	switch	.text
5164  07ef               _control_check:
5166  07ef 88            	push	a
5167  07f0 5203          	subw	sp,#3
5168       00000003      OFST:	set	3
5171                     ; 740 char i=0,ii=0,iii;
5175                     ; 742 if(rx_buffer[index]!=END) return 0;
5177  07f2 5f            	clrw	x
5178  07f3 97            	ld	xl,a
5179  07f4 e654          	ld	a,(_rx_buffer,x)
5180  07f6 a10a          	cp	a,#10
5181  07f8 2703          	jreq	L3162
5184  07fa 4f            	clr	a
5186  07fb 2041          	jra	L011
5187  07fd               L3162:
5188                     ; 744 ii=rx_buffer[index_offset(index,-2)];
5190  07fd aefffe        	ldw	x,#65534
5191  0800 7b04          	ld	a,(OFST+1,sp)
5192  0802 95            	ld	xh,a
5193  0803 adc5          	call	_index_offset
5195  0805 5f            	clrw	x
5196  0806 97            	ld	xl,a
5197  0807 e654          	ld	a,(_rx_buffer,x)
5198  0809 6b02          	ld	(OFST-1,sp),a
5199                     ; 745 iii=0;
5201  080b 0f01          	clr	(OFST-2,sp)
5202                     ; 746 for(i=0;i<=ii;i++)
5204  080d 0f03          	clr	(OFST+0,sp)
5206  080f 2016          	jra	L1262
5207  0811               L5162:
5208                     ; 748 	iii^=rx_buffer[index_offset(index,-2-ii+i)];
5210  0811 a6fe          	ld	a,#254
5211  0813 1002          	sub	a,(OFST-1,sp)
5212  0815 1b03          	add	a,(OFST+0,sp)
5213  0817 97            	ld	xl,a
5214  0818 7b04          	ld	a,(OFST+1,sp)
5215  081a 95            	ld	xh,a
5216  081b adad          	call	_index_offset
5218  081d 5f            	clrw	x
5219  081e 97            	ld	xl,a
5220  081f 7b01          	ld	a,(OFST-2,sp)
5221  0821 e854          	xor	a,	(_rx_buffer,x)
5222  0823 6b01          	ld	(OFST-2,sp),a
5223                     ; 746 for(i=0;i<=ii;i++)
5225  0825 0c03          	inc	(OFST+0,sp)
5226  0827               L1262:
5229  0827 7b03          	ld	a,(OFST+0,sp)
5230  0829 1102          	cp	a,(OFST-1,sp)
5231  082b 23e4          	jrule	L5162
5232                     ; 750 if (iii!=rx_buffer[index_offset(index,-1)]) return 0;	
5234  082d aeffff        	ldw	x,#65535
5235  0830 7b04          	ld	a,(OFST+1,sp)
5236  0832 95            	ld	xh,a
5237  0833 ad95          	call	_index_offset
5239  0835 5f            	clrw	x
5240  0836 97            	ld	xl,a
5241  0837 e654          	ld	a,(_rx_buffer,x)
5242  0839 1101          	cp	a,(OFST-2,sp)
5243  083b 2704          	jreq	L5262
5246  083d 4f            	clr	a
5248  083e               L011:
5250  083e 5b04          	addw	sp,#4
5251  0840 81            	ret
5252  0841               L5262:
5253                     ; 752 return 1;
5255  0841 a601          	ld	a,#1
5257  0843 20f9          	jra	L011
5298                     ; 761 @far @interrupt void TIM4_UPD_Interrupt (void) {
5300                     	switch	.text
5301  0845               f_TIM4_UPD_Interrupt:
5305                     ; 763 	if(play) {
5307                     	btst	_play
5308  084a 2449          	jruge	L7362
5309                     ; 764 		TIM2->CCR3H= 0x00;	
5311  084c 725f5315      	clr	21269
5312                     ; 765 		TIM2->CCR3L= sample;
5314  0850 5500145316    	mov	21270,_sample
5315                     ; 766 		sample_cnt++;
5317  0855 be1b          	ldw	x,_sample_cnt
5318  0857 1c0001        	addw	x,#1
5319  085a bf1b          	ldw	_sample_cnt,x
5320                     ; 767 		if(sample_cnt>=256) {
5322  085c 9c            	rvf
5323  085d be1b          	ldw	x,_sample_cnt
5324  085f a30100        	cpw	x,#256
5325  0862 2f03          	jrslt	L1462
5326                     ; 768 			sample_cnt=0;
5328  0864 5f            	clrw	x
5329  0865 bf1b          	ldw	_sample_cnt,x
5330  0867               L1462:
5331                     ; 771 		sample=buff[sample_cnt];
5333  0867 be1b          	ldw	x,_sample_cnt
5334  0869 d60050        	ld	a,(_buff,x)
5335  086c b714          	ld	_sample,a
5336                     ; 773 		if(sample_cnt==132)	{
5338  086e be1b          	ldw	x,_sample_cnt
5339  0870 a30084        	cpw	x,#132
5340  0873 2604          	jrne	L3462
5341                     ; 774 			bBUFF_LOAD=1;
5343  0875 7210000a      	bset	_bBUFF_LOAD
5344  0879               L3462:
5345                     ; 777 		if(sample_cnt==54) {
5347  0879 be1b          	ldw	x,_sample_cnt
5348  087b a30036        	cpw	x,#54
5349  087e 2604          	jrne	L5462
5350                     ; 778 			bBUFF_READ_H=1;
5352  0880 72100009      	bset	_bBUFF_READ_H
5353  0884               L5462:
5354                     ; 781 		if(sample_cnt==182) {
5356  0884 be1b          	ldw	x,_sample_cnt
5357  0886 a300b6        	cpw	x,#182
5358  0889 2604          	jrne	L7462
5359                     ; 782 			bBUFF_READ_L=1;
5361  088b 72100008      	bset	_bBUFF_READ_L
5362  088f               L7462:
5363                     ; 785 		but_drv_cnt=0;
5365  088f 3fa4          	clr	_but_drv_cnt
5366                     ; 786 		but_on_drv_cnt=0;
5368  0891 3fa5          	clr	_but_on_drv_cnt
5370  0893 200f          	jra	L1562
5371  0895               L7362:
5372                     ; 789 	else if(!bSTART) {
5374                     	btst	_bSTART
5375  089a 2508          	jrult	L1562
5376                     ; 790 		TIM2->CCR3H= 0x00;	
5378  089c 725f5315      	clr	21269
5379                     ; 791 		TIM2->CCR3L= 0x80;
5381  08a0 35805316      	mov	21270,#128
5382  08a4               L1562:
5383                     ; 796 	if(++t0_cnt0>=125){
5385  08a4 3c00          	inc	_t0_cnt0
5386  08a6 b600          	ld	a,_t0_cnt0
5387  08a8 a17d          	cp	a,#125
5388  08aa 2530          	jrult	L5562
5389                     ; 797     		t0_cnt0=0;
5391  08ac 3f00          	clr	_t0_cnt0
5392                     ; 798     		b100Hz=1;
5394  08ae 72100007      	bset	_b100Hz
5395                     ; 800 		if(++t0_cnt1>=10){
5397  08b2 3c01          	inc	_t0_cnt1
5398  08b4 b601          	ld	a,_t0_cnt1
5399  08b6 a10a          	cp	a,#10
5400  08b8 2506          	jrult	L7562
5401                     ; 801 			t0_cnt1=0;
5403  08ba 3f01          	clr	_t0_cnt1
5404                     ; 802 			b10Hz=1;
5406  08bc 72100006      	bset	_b10Hz
5407  08c0               L7562:
5408                     ; 805 		if(++t0_cnt2>=20){
5410  08c0 3c02          	inc	_t0_cnt2
5411  08c2 b602          	ld	a,_t0_cnt2
5412  08c4 a114          	cp	a,#20
5413  08c6 2506          	jrult	L1662
5414                     ; 806 			t0_cnt2=0;
5416  08c8 3f02          	clr	_t0_cnt2
5417                     ; 807 			b5Hz=1;
5419  08ca 72100005      	bset	_b5Hz
5420  08ce               L1662:
5421                     ; 810 		if(++t0_cnt3>=100){
5423  08ce 3c03          	inc	_t0_cnt3
5424  08d0 b603          	ld	a,_t0_cnt3
5425  08d2 a164          	cp	a,#100
5426  08d4 2506          	jrult	L5562
5427                     ; 811 			t0_cnt3=0;
5429  08d6 3f03          	clr	_t0_cnt3
5430                     ; 812 			b1Hz=1;
5432  08d8 72100004      	bset	_b1Hz
5433  08dc               L5562:
5434                     ; 816 	TIM4->SR1&=~TIM4_SR1_UIF;			// disable break interrupt
5436  08dc 72115344      	bres	21316,#0
5437                     ; 817 	return;
5440  08e0 80            	iret
5466                     ; 821 @far @interrupt void UARTTxInterrupt (void) {
5467                     	switch	.text
5468  08e1               f_UARTTxInterrupt:
5472                     ; 823 	if (tx_counter){
5474  08e1 3d1a          	tnz	_tx_counter
5475  08e3 271a          	jreq	L5762
5476                     ; 824 		--tx_counter;
5478  08e5 3a1a          	dec	_tx_counter
5479                     ; 825 		UART1->DR=tx_buffer[tx_rd_index];
5481  08e7 5f            	clrw	x
5482  08e8 b618          	ld	a,_tx_rd_index
5483  08ea 2a01          	jrpl	L611
5484  08ec 53            	cplw	x
5485  08ed               L611:
5486  08ed 97            	ld	xl,a
5487  08ee e604          	ld	a,(_tx_buffer,x)
5488  08f0 c75231        	ld	21041,a
5489                     ; 826 		if (++tx_rd_index == TX_BUFFER_SIZE) tx_rd_index=0;
5491  08f3 3c18          	inc	_tx_rd_index
5492  08f5 b618          	ld	a,_tx_rd_index
5493  08f7 a150          	cp	a,#80
5494  08f9 260c          	jrne	L1072
5497  08fb 3f18          	clr	_tx_rd_index
5498  08fd 2008          	jra	L1072
5499  08ff               L5762:
5500                     ; 829 		bOUT_FREE=1;
5502  08ff 72100002      	bset	_bOUT_FREE
5503                     ; 830 		UART1->CR2&= ~UART1_CR2_TIEN;
5505  0903 721f5235      	bres	21045,#7
5506  0907               L1072:
5507                     ; 832 }
5510  0907 80            	iret
5539                     ; 835 @far @interrupt void UARTRxInterrupt (void) {
5540                     	switch	.text
5541  0908               f_UARTRxInterrupt:
5545                     ; 840 	rx_status=UART1->SR;
5547  0908 5552300003    	mov	_rx_status,21040
5548                     ; 841 	rx_data=UART1->DR;
5550  090d 5552310002    	mov	_rx_data,21041
5551                     ; 843 	if (rx_status & (UART1_SR_RXNE)){
5553  0912 b603          	ld	a,_rx_status
5554  0914 a520          	bcp	a,#32
5555  0916 2727          	jreq	L3172
5556                     ; 844 		rx_buffer[rx_wr_index]=rx_data;
5558  0918 5f            	clrw	x
5559  0919 b616          	ld	a,_rx_wr_index
5560  091b 2a01          	jrpl	L221
5561  091d 53            	cplw	x
5562  091e               L221:
5563  091e 97            	ld	xl,a
5564  091f b602          	ld	a,_rx_data
5565  0921 e754          	ld	(_rx_buffer,x),a
5566                     ; 845 		bRXIN=1;
5568  0923 72100001      	bset	_bRXIN
5569                     ; 846 		if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
5571  0927 3c16          	inc	_rx_wr_index
5572  0929 b616          	ld	a,_rx_wr_index
5573  092b a150          	cp	a,#80
5574  092d 2602          	jrne	L5172
5577  092f 3f16          	clr	_rx_wr_index
5578  0931               L5172:
5579                     ; 847 		if (++rx_counter == RX_BUFFER_SIZE){
5581  0931 3c17          	inc	_rx_counter
5582  0933 b617          	ld	a,_rx_counter
5583  0935 a150          	cp	a,#80
5584  0937 2606          	jrne	L3172
5585                     ; 848 			rx_counter=0;
5587  0939 3f17          	clr	_rx_counter
5588                     ; 849 			rx_buffer_overflow=1;
5590  093b 72100000      	bset	_rx_buffer_overflow
5591  093f               L3172:
5592                     ; 852 }
5595  093f 80            	iret
5644                     ; 858 main(){
5646                     	switch	.text
5647  0940               _main:
5651                     ; 859 	CLK->CKDIVR=0;
5653  0940 725f50c6      	clr	20678
5654                     ; 860 	t4_init();
5656  0944 cd0039        	call	_t4_init
5658                     ; 861 	gpio_init();
5660  0947 cd073f        	call	_gpio_init
5662                     ; 862 	t2_init();
5664  094a cd0000        	call	_t2_init
5666                     ; 863 	spi_init();
5668  094d cd05da        	call	_spi_init
5670                     ; 865 	FLASH_DUKR=0xae;
5672  0950 35ae5064      	mov	_FLASH_DUKR,#174
5673                     ; 866 	FLASH_DUKR=0x56;
5675  0954 35565064      	mov	_FLASH_DUKR,#86
5676                     ; 873 	uart_init();
5678  0958 cd009e        	call	_uart_init
5680                     ; 875 	enableInterrupts();	
5683  095b 9a            rim
5685  095c               L1372:
5686                     ; 879 		if(bBUFF_LOAD) {
5688                     	btst	_bBUFF_LOAD
5689  0961 241f          	jruge	L5372
5690                     ; 880 			bBUFF_LOAD=0;
5692  0963 7211000a      	bres	_bBUFF_LOAD
5693                     ; 882 			if(current_page<last_page) {
5695  0967 be0c          	ldw	x,_current_page
5696  0969 b30a          	cpw	x,_last_page
5697  096b 2409          	jruge	L7372
5698                     ; 883 				current_page++;
5700  096d be0c          	ldw	x,_current_page
5701  096f 1c0001        	addw	x,#1
5702  0972 bf0c          	ldw	_current_page,x
5704  0974 2007          	jra	L1472
5705  0976               L7372:
5706                     ; 887 				current_page=0;
5708  0976 5f            	clrw	x
5709  0977 bf0c          	ldw	_current_page,x
5710                     ; 888 				play=0;
5712  0979 72110003      	bres	_play
5713  097d               L1472:
5714                     ; 891 			DF_page_to_buffer(/*///current_buffer_H*//*1,*/current_page);
5716  097d be0c          	ldw	x,_current_page
5717  097f cd0674        	call	_DF_page_to_buffer
5719  0982               L5372:
5720                     ; 894 		if(bBUFF_READ_L) {
5722                     	btst	_bBUFF_READ_L
5723  0987 2412          	jruge	L3472
5724                     ; 895 			bBUFF_READ_L=0;
5726  0989 72110008      	bres	_bBUFF_READ_L
5727                     ; 897 			DF_buffer_read(/*///current_buffer_L*//*1,*/0,128,buff);
5729  098d ae0050        	ldw	x,#_buff
5730  0990 89            	pushw	x
5731  0991 ae0080        	ldw	x,#128
5732  0994 89            	pushw	x
5733  0995 5f            	clrw	x
5734  0996 cd06ba        	call	_DF_buffer_read
5736  0999 5b04          	addw	sp,#4
5737  099b               L3472:
5738                     ; 900 		if(bBUFF_READ_H) {
5740                     	btst	_bBUFF_READ_H
5741  09a0 2414          	jruge	L5472
5742                     ; 901 			bBUFF_READ_H=0;
5744  09a2 72110009      	bres	_bBUFF_READ_H
5745                     ; 902 			DF_buffer_read(/*///current_buffer_L*//*1,*/128,128,&buff[128]);
5747  09a6 ae00d0        	ldw	x,#_buff+128
5748  09a9 89            	pushw	x
5749  09aa ae0080        	ldw	x,#128
5750  09ad 89            	pushw	x
5751  09ae ae0080        	ldw	x,#128
5752  09b1 cd06ba        	call	_DF_buffer_read
5754  09b4 5b04          	addw	sp,#4
5755  09b6               L5472:
5756                     ; 905 		if(bRXIN)	{
5758                     	btst	_bRXIN
5759  09bb 2407          	jruge	L7472
5760                     ; 906 			bRXIN=0;
5762  09bd 72110001      	bres	_bRXIN
5763                     ; 908 			uart_in();
5765  09c1 cd074c        	call	_uart_in
5767  09c4               L7472:
5768                     ; 912 		if(b100Hz){
5770                     	btst	_b100Hz
5771  09c9 2462          	jruge	L1572
5772                     ; 913 			b100Hz=0;
5774  09cb 72110007      	bres	_b100Hz
5775                     ; 915 			if(bSTART==1) {
5777                     	btst	_bSTART
5778  09d4 2457          	jruge	L1572
5779                     ; 916 				if(play) {
5781                     	btst	_play
5782  09db 240a          	jruge	L5572
5783                     ; 917 					play=0;
5785  09dd 72110003      	bres	_play
5786                     ; 918 					bSTART=0;
5788  09e1 7211000b      	bres	_bSTART
5790  09e5 2046          	jra	L1572
5791  09e7               L5572:
5792                     ; 921 					current_page=0;
5794  09e7 5f            	clrw	x
5795  09e8 bf0c          	ldw	_current_page,x
5796                     ; 922 					last_page=EE_PAGE_LEN-5;
5798  09ea ce0000        	ldw	x,_EE_PAGE_LEN
5799  09ed 1d0005        	subw	x,#5
5800  09f0 bf0a          	ldw	_last_page,x
5801                     ; 924 					DF_page_to_buffer(/*///current_buffer_H*//*1,*/current_page);
5803  09f2 5f            	clrw	x
5804  09f3 cd0674        	call	_DF_page_to_buffer
5806                     ; 925 					delay_ms(10);
5808  09f6 ae000a        	ldw	x,#10
5809  09f9 cd005c        	call	_delay_ms
5811                     ; 926 					DF_buffer_read(/*///current_buffer_L*//*1,*/0,128,buff);
5813  09fc ae0050        	ldw	x,#_buff
5814  09ff 89            	pushw	x
5815  0a00 ae0080        	ldw	x,#128
5816  0a03 89            	pushw	x
5817  0a04 5f            	clrw	x
5818  0a05 cd06ba        	call	_DF_buffer_read
5820  0a08 5b04          	addw	sp,#4
5821                     ; 927 					delay_ms(10);
5823  0a0a ae000a        	ldw	x,#10
5824  0a0d cd005c        	call	_delay_ms
5826                     ; 928 					DF_buffer_read(/*///current_buffer_L*//*1,*/128,128,&buff[128]);         
5828  0a10 ae00d0        	ldw	x,#_buff+128
5829  0a13 89            	pushw	x
5830  0a14 ae0080        	ldw	x,#128
5831  0a17 89            	pushw	x
5832  0a18 ae0080        	ldw	x,#128
5833  0a1b cd06ba        	call	_DF_buffer_read
5835  0a1e 5b04          	addw	sp,#4
5836                     ; 930 					play=1;
5838  0a20 72100003      	bset	_play
5839                     ; 931 					bSTART=0;
5841  0a24 7211000b      	bres	_bSTART
5842                     ; 933 					rele_cnt=10;//rele_cnt_const[rele_cnt_index];
5844  0a28 ae000a        	ldw	x,#10
5845  0a2b bf00          	ldw	_rele_cnt,x
5846  0a2d               L1572:
5847                     ; 938 		if(b10Hz){
5849                     	btst	_b10Hz
5850  0a32 2407          	jruge	L1672
5851                     ; 939 			b10Hz=0;
5853  0a34 72110006      	bres	_b10Hz
5854                     ; 941 			rele_drv();
5856  0a38 cd004a        	call	_rele_drv
5858  0a3b               L1672:
5859                     ; 944 		if(b5Hz){
5861                     	btst	_b5Hz
5862  0a40 2404          	jruge	L3672
5863                     ; 945 			b5Hz=0;
5865  0a42 72110005      	bres	_b5Hz
5866  0a46               L3672:
5867                     ; 949 		if(b1Hz){
5869                     	btst	_b1Hz
5870  0a4b 2503          	jrult	L621
5871  0a4d cc095c        	jp	L1372
5872  0a50               L621:
5873                     ; 951 			b1Hz=0;
5875  0a50 72110004      	bres	_b1Hz
5876  0a54 ac5c095c      	jpf	L1372
6296                     	xdef	_main
6297                     .eeprom:	section	.data
6298  0000               _EE_PAGE_LEN:
6299  0000 0000          	ds.b	2
6300                     	xdef	_EE_PAGE_LEN
6301                     	switch	.bss
6302  0000               _UIB:
6303  0000 000000000000  	ds.b	80
6304                     	xdef	_UIB
6305  0050               _buff:
6306  0050 000000000000  	ds.b	256
6307                     	xdef	_buff
6308                     .bit:	section	.data,bit
6309  0000               _rx_buffer_overflow:
6310  0000 00            	ds.b	1
6311                     	xdef	_rx_buffer_overflow
6312  0001               _bRXIN:
6313  0001 00            	ds.b	1
6314                     	xdef	_bRXIN
6315  0002               _bOUT_FREE:
6316  0002 00            	ds.b	1
6317                     	xdef	_bOUT_FREE
6318  0003               _play:
6319  0003 00            	ds.b	1
6320                     	xdef	_play
6321  0004               _b1Hz:
6322  0004 00            	ds.b	1
6323                     	xdef	_b1Hz
6324  0005               _b5Hz:
6325  0005 00            	ds.b	1
6326                     	xdef	_b5Hz
6327  0006               _b10Hz:
6328  0006 00            	ds.b	1
6329                     	xdef	_b10Hz
6330  0007               _b100Hz:
6331  0007 00            	ds.b	1
6332                     	xdef	_b100Hz
6333  0008               _bBUFF_READ_L:
6334  0008 00            	ds.b	1
6335                     	xdef	_bBUFF_READ_L
6336  0009               _bBUFF_READ_H:
6337  0009 00            	ds.b	1
6338                     	xdef	_bBUFF_READ_H
6339  000a               _bBUFF_LOAD:
6340  000a 00            	ds.b	1
6341                     	xdef	_bBUFF_LOAD
6342  000b               _bSTART:
6343  000b 00            	ds.b	1
6344                     	xdef	_bSTART
6345                     	switch	.ubsct
6346  0000               _rele_cnt:
6347  0000 0000          	ds.b	2
6348                     	xdef	_rele_cnt
6349  0002               _rx_data:
6350  0002 00            	ds.b	1
6351                     	xdef	_rx_data
6352  0003               _rx_status:
6353  0003 00            	ds.b	1
6354                     	xdef	_rx_status
6355  0004               _file_lengt:
6356  0004 00000000      	ds.b	4
6357                     	xdef	_file_lengt
6358  0008               _current_byte_in_buffer:
6359  0008 0000          	ds.b	2
6360                     	xdef	_current_byte_in_buffer
6361  000a               _last_page:
6362  000a 0000          	ds.b	2
6363                     	xdef	_last_page
6364  000c               _current_page:
6365  000c 0000          	ds.b	2
6366                     	xdef	_current_page
6367  000e               _file_lengt_in_pages:
6368  000e 0000          	ds.b	2
6369                     	xdef	_file_lengt_in_pages
6370  0010               _mdr3:
6371  0010 00            	ds.b	1
6372                     	xdef	_mdr3
6373  0011               _mdr2:
6374  0011 00            	ds.b	1
6375                     	xdef	_mdr2
6376  0012               _mdr1:
6377  0012 00            	ds.b	1
6378                     	xdef	_mdr1
6379  0013               _mdr0:
6380  0013 00            	ds.b	1
6381                     	xdef	_mdr0
6382                     	xdef	_but_on_drv_cnt
6383                     	xdef	_but_drv_cnt
6384  0014               _sample:
6385  0014 00            	ds.b	1
6386                     	xdef	_sample
6387  0015               _rx_rd_index:
6388  0015 00            	ds.b	1
6389                     	xdef	_rx_rd_index
6390  0016               _rx_wr_index:
6391  0016 00            	ds.b	1
6392                     	xdef	_rx_wr_index
6393  0017               _rx_counter:
6394  0017 00            	ds.b	1
6395                     	xdef	_rx_counter
6396                     	xdef	_rx_buffer
6397  0018               _tx_rd_index:
6398  0018 00            	ds.b	1
6399                     	xdef	_tx_rd_index
6400  0019               _tx_wr_index:
6401  0019 00            	ds.b	1
6402                     	xdef	_tx_wr_index
6403  001a               _tx_counter:
6404  001a 00            	ds.b	1
6405                     	xdef	_tx_counter
6406                     	xdef	_tx_buffer
6407  001b               _sample_cnt:
6408  001b 0000          	ds.b	2
6409                     	xdef	_sample_cnt
6410                     	xdef	_t0_cnt3
6411                     	xdef	_t0_cnt2
6412                     	xdef	_t0_cnt1
6413                     	xdef	_t0_cnt0
6414                     	xdef	_uart_in_an
6415                     	xdef	_control_check
6416                     	xdef	_index_offset
6417                     	xdef	_uart_in
6418                     	xdef	_gpio_init
6419                     	xdef	_spi_init
6420                     	xdef	_spi
6421                     	xdef	_DF_buffer_to_page_er
6422                     	xdef	_DF_page_to_buffer
6423                     	xdef	_DF_buffer_write
6424                     	xdef	_DF_buffer_read
6425                     	xdef	_DF_status_read
6426                     	xdef	_DF_memo_to_256
6427                     	xdef	_DF_mf_dev_read
6428                     	xdef	_uart_init
6429                     	xdef	f_UARTRxInterrupt
6430                     	xdef	f_UARTTxInterrupt
6431                     	xdef	_putchar
6432                     	xdef	_uart_out_adr_block
6433                     	xdef	_uart_out
6434                     	xdef	f_TIM4_UPD_Interrupt
6435                     	xdef	_delay_ms
6436                     	xdef	_rele_drv
6437                     	xdef	_t4_init
6438                     	xdef	_t2_init
6439                     	xref.b	c_x
6440                     	xref.b	c_y
6460                     	xref	c_eewrw
6461                     	xref	c_lglsh
6462                     	xref	c_lgursh
6463                     	xref	c_lcmp
6464                     	xref	c_ltor
6465                     	xref	c_lgadc
6466                     	xref	c_rtol
6467                     	xref	c_vmul
6468                     	end
