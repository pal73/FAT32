   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32.1 - 30 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
2173                     	switch	.data
2174  0000               _b100Hz:
2175  0000 00            	dc.b	0
2176  0001               _b10Hz:
2177  0001 00            	dc.b	0
2178  0002               _b5Hz:
2179  0002 00            	dc.b	0
2180  0003               _b1Hz:
2181  0003 00            	dc.b	0
2182  0004               _t0_cnt0:
2183  0004 00            	dc.b	0
2184  0005               _t0_cnt1:
2185  0005 00            	dc.b	0
2186  0006               _t0_cnt2:
2187  0006 00            	dc.b	0
2188  0007               _t0_cnt3:
2189  0007 00            	dc.b	0
2256                     ; 30 long delay_ms(short in)
2256                     ; 31 {
2258                     	switch	.text
2259  0000               _delay_ms:
2261  0000 520c          	subw	sp,#12
2262       0000000c      OFST:	set	12
2265                     ; 34 i=((long)in)*100UL;
2267  0002 90ae0064      	ldw	y,#100
2268  0006 cd0000        	call	c_vmul
2270  0009 96            	ldw	x,sp
2271  000a 1c0005        	addw	x,#OFST-7
2272  000d cd0000        	call	c_rtol
2274                     ; 36 for(ii=0;ii<i;ii++)
2276  0010 ae0000        	ldw	x,#0
2277  0013 1f0b          	ldw	(OFST-1,sp),x
2278  0015 ae0000        	ldw	x,#0
2279  0018 1f09          	ldw	(OFST-3,sp),x
2281  001a 2012          	jra	L7641
2282  001c               L3641:
2283                     ; 38 		iii++;
2285  001c 96            	ldw	x,sp
2286  001d 1c0001        	addw	x,#OFST-11
2287  0020 a601          	ld	a,#1
2288  0022 cd0000        	call	c_lgadc
2290                     ; 36 for(ii=0;ii<i;ii++)
2292  0025 96            	ldw	x,sp
2293  0026 1c0009        	addw	x,#OFST-3
2294  0029 a601          	ld	a,#1
2295  002b cd0000        	call	c_lgadc
2297  002e               L7641:
2300  002e 9c            	rvf
2301  002f 96            	ldw	x,sp
2302  0030 1c0009        	addw	x,#OFST-3
2303  0033 cd0000        	call	c_ltor
2305  0036 96            	ldw	x,sp
2306  0037 1c0005        	addw	x,#OFST-7
2307  003a cd0000        	call	c_lcmp
2309  003d 2fdd          	jrslt	L3641
2310                     ; 41 }
2313  003f 5b0c          	addw	sp,#12
2314  0041 81            	ret
2361                     ; 44 void uart_in_an(void)
2361                     ; 45 {
2362                     	switch	.text
2363  0042               _uart_in_an:
2365  0042 5204          	subw	sp,#4
2366       00000004      OFST:	set	4
2369                     ; 51 if(UIB[0]==CMND)
2371  0044 b600          	ld	a,_UIB
2372  0046 a116          	cp	a,#22
2373  0048 2632          	jrne	L5151
2374                     ; 53 	if(UIB[1]==1)
2376  004a b601          	ld	a,_UIB+1
2377  004c a101          	cp	a,#1
2378  004e 2654          	jrne	L1251
2379                     ; 56 		GPIOD->ODR^=(1<<4);
2381  0050 c6500f        	ld	a,20495
2382  0053 a810          	xor	a,	#16
2383  0055 c7500f        	ld	20495,a
2384                     ; 57 		temp_L=DF_mf_dev_read();
2386  0058 ad4d          	call	_DF_mf_dev_read
2388  005a 96            	ldw	x,sp
2389  005b 1c0001        	addw	x,#OFST-3
2390  005e cd0000        	call	c_rtol
2392                     ; 58 		uart_out (6,CMND,1,*((char*)&temp_L),*(((char*)&temp_L)+1),*(((char*)&temp_L)+2),*(((char*)&temp_L)+3));
2394  0061 7b04          	ld	a,(OFST+0,sp)
2395  0063 88            	push	a
2396  0064 7b04          	ld	a,(OFST+0,sp)
2397  0066 88            	push	a
2398  0067 7b04          	ld	a,(OFST+0,sp)
2399  0069 88            	push	a
2400  006a 7b04          	ld	a,(OFST+0,sp)
2401  006c 88            	push	a
2402  006d 4b01          	push	#1
2403  006f ae0016        	ldw	x,#22
2404  0072 a606          	ld	a,#6
2405  0074 95            	ld	xh,a
2406  0075 cd0000        	call	_uart_out
2408  0078 5b05          	addw	sp,#5
2409  007a 2028          	jra	L1251
2410  007c               L5151:
2411                     ; 62 	else if(UIB[1]==2)
2413  007c b601          	ld	a,_UIB+1
2414  007e a102          	cp	a,#2
2415  0080 2622          	jrne	L1251
2416                     ; 65 		GPIOD->ODR^=(1<<4);
2418  0082 c6500f        	ld	a,20495
2419  0085 a810          	xor	a,	#16
2420  0087 c7500f        	ld	20495,a
2421                     ; 66 		temp=DF_status_read();
2423  008a ad67          	call	_DF_status_read
2425  008c 6b04          	ld	(OFST+0,sp),a
2426                     ; 67 		uart_out (3,CMND,2,temp,0,0,0);    
2428  008e 4b00          	push	#0
2429  0090 4b00          	push	#0
2430  0092 4b00          	push	#0
2431  0094 7b07          	ld	a,(OFST+3,sp)
2432  0096 88            	push	a
2433  0097 4b02          	push	#2
2434  0099 ae0016        	ldw	x,#22
2435  009c a603          	ld	a,#3
2436  009e 95            	ld	xh,a
2437  009f cd0000        	call	_uart_out
2439  00a2 5b05          	addw	sp,#5
2440  00a4               L1251:
2441                     ; 297 }
2444  00a4 5b04          	addw	sp,#4
2445  00a6 81            	ret
2507                     ; 300 long DF_mf_dev_read(void)
2507                     ; 301 {
2508                     	switch	.text
2509  00a7               _DF_mf_dev_read:
2511  00a7 5204          	subw	sp,#4
2512       00000004      OFST:	set	4
2515                     ; 305 CS_ON
2517  00a9 721b5005      	bres	20485,#5
2518                     ; 306 spi(0x9f);
2520  00ad a69f          	ld	a,#159
2521  00af cd02f0        	call	_spi
2523                     ; 307 d0=spi(0xff);
2525  00b2 a6ff          	ld	a,#255
2526  00b4 cd02f0        	call	_spi
2528  00b7 6b04          	ld	(OFST+0,sp),a
2529                     ; 308 d1=spi(0xff);
2531  00b9 a6ff          	ld	a,#255
2532  00bb cd02f0        	call	_spi
2534                     ; 309 d2=spi(0xff);
2536  00be a6ff          	ld	a,#255
2537  00c0 cd02f0        	call	_spi
2539                     ; 310 d3=spi(0xff);  
2541  00c3 a6ff          	ld	a,#255
2542  00c5 cd02f0        	call	_spi
2544                     ; 312 CS_OFF
2546  00c8 721a5005      	bset	20485,#5
2547                     ; 313 return  *((long*)&d0);
2549  00cc 96            	ldw	x,sp
2550  00cd 1c0004        	addw	x,#OFST+0
2551  00d0 cd0000        	call	c_ltor
2555  00d3 5b04          	addw	sp,#4
2556  00d5 81            	ret
2580                     ; 317 void DF_memo_to_256(void)
2580                     ; 318 {
2581                     	switch	.text
2582  00d6               _DF_memo_to_256:
2586                     ; 320 CS_ON
2588  00d6 721b5005      	bres	20485,#5
2589                     ; 321 spi(0x3d);
2591  00da a63d          	ld	a,#61
2592  00dc cd02f0        	call	_spi
2594                     ; 322 spi(0x2a); 
2596  00df a62a          	ld	a,#42
2597  00e1 cd02f0        	call	_spi
2599                     ; 323 spi(0x80);
2601  00e4 a680          	ld	a,#128
2602  00e6 cd02f0        	call	_spi
2604                     ; 324 spi(0xa6);
2606  00e9 a6a6          	ld	a,#166
2607  00eb cd02f0        	call	_spi
2609                     ; 326 CS_OFF
2611  00ee 721a5005      	bset	20485,#5
2612                     ; 327 }  
2615  00f2 81            	ret
2650                     ; 330 char DF_status_read(void)
2650                     ; 331 {
2651                     	switch	.text
2652  00f3               _DF_status_read:
2654  00f3 88            	push	a
2655       00000001      OFST:	set	1
2658                     ; 335 CS_ON
2660  00f4 721b5005      	bres	20485,#5
2661                     ; 336 spi(0xd7);
2663  00f8 a6d7          	ld	a,#215
2664  00fa cd02f0        	call	_spi
2666                     ; 337 d0=spi(0xff);
2668  00fd a6ff          	ld	a,#255
2669  00ff cd02f0        	call	_spi
2671  0102 6b01          	ld	(OFST+0,sp),a
2672                     ; 339 CS_OFF
2674  0104 721a5005      	bset	20485,#5
2675                     ; 340 return d0;
2677  0108 7b01          	ld	a,(OFST+0,sp)
2680  010a 5b01          	addw	sp,#1
2681  010c 81            	ret
2725                     ; 344 void DF_page_to_buffer(unsigned page_addr)
2725                     ; 345 {
2726                     	switch	.text
2727  010d               _DF_page_to_buffer:
2729  010d 89            	pushw	x
2730  010e 88            	push	a
2731       00000001      OFST:	set	1
2734                     ; 348 d0=0x53; 
2736                     ; 350 page_addr<<=1;
2738  010f 0803          	sll	(OFST+2,sp)
2739  0111 0902          	rlc	(OFST+1,sp)
2740                     ; 352 CS_ON
2742  0113 721b5005      	bres	20485,#5
2743                     ; 353 spi(d0);
2745  0117 a653          	ld	a,#83
2746  0119 cd02f0        	call	_spi
2748                     ; 354 spi(*(((char*)&page_addr)+1));
2750  011c 7b03          	ld	a,(OFST+2,sp)
2751  011e cd02f0        	call	_spi
2753                     ; 355 spi(*((char*)&page_addr));
2755  0121 7b02          	ld	a,(OFST+1,sp)
2756  0123 cd02f0        	call	_spi
2758                     ; 356 spi(0xff);
2760  0126 a6ff          	ld	a,#255
2761  0128 cd02f0        	call	_spi
2763                     ; 358 CS_OFF
2765  012b 721a5005      	bset	20485,#5
2766                     ; 359 }
2769  012f 5b03          	addw	sp,#3
2770  0131 81            	ret
2815                     ; 362 void DF_buffer_to_page_er(/*char buff,*/unsigned page_addr)
2815                     ; 363 {
2816                     	switch	.text
2817  0132               _DF_buffer_to_page_er:
2819  0132 89            	pushw	x
2820  0133 88            	push	a
2821       00000001      OFST:	set	1
2824                     ; 366 d0=0x83; 
2826                     ; 367 page_addr<<=1;
2828  0134 0803          	sll	(OFST+2,sp)
2829  0136 0902          	rlc	(OFST+1,sp)
2830                     ; 369 CS_ON
2832  0138 721b5005      	bres	20485,#5
2833                     ; 370 spi(d0);
2835  013c a683          	ld	a,#131
2836  013e cd02f0        	call	_spi
2838                     ; 371 spi(*(((char*)&page_addr)+1));
2840  0141 7b03          	ld	a,(OFST+2,sp)
2841  0143 cd02f0        	call	_spi
2843                     ; 372 spi(*((char*)&page_addr));
2845  0146 7b02          	ld	a,(OFST+1,sp)
2846  0148 cd02f0        	call	_spi
2848                     ; 373 spi(0xff);
2850  014b a6ff          	ld	a,#255
2851  014d cd02f0        	call	_spi
2853                     ; 375 CS_OFF
2855  0150 721a5005      	bset	20485,#5
2856                     ; 376 }
2859  0154 5b03          	addw	sp,#3
2860  0156 81            	ret
2932                     ; 379 void DF_buffer_read(unsigned buff_addr,unsigned len, char* adr)
2932                     ; 380 {
2933                     	switch	.text
2934  0157               _DF_buffer_read:
2936  0157 89            	pushw	x
2937  0158 5203          	subw	sp,#3
2938       00000003      OFST:	set	3
2941                     ; 384 d0=0x54; 
2943                     ; 386 CS_ON
2945  015a 721b5005      	bres	20485,#5
2946                     ; 387 spi(d0);
2948  015e a654          	ld	a,#84
2949  0160 cd02f0        	call	_spi
2951                     ; 388 spi(0xff);
2953  0163 a6ff          	ld	a,#255
2954  0165 cd02f0        	call	_spi
2956                     ; 389 spi(*(((char*)&buff_addr)+1));
2958  0168 7b05          	ld	a,(OFST+2,sp)
2959  016a cd02f0        	call	_spi
2961                     ; 390 spi(*((char*)&buff_addr));
2963  016d 7b04          	ld	a,(OFST+1,sp)
2964  016f cd02f0        	call	_spi
2966                     ; 391 spi(0xff);
2968  0172 a6ff          	ld	a,#255
2969  0174 cd02f0        	call	_spi
2971                     ; 392 for(i=0;i<len;i++)
2973  0177 5f            	clrw	x
2974  0178 1f02          	ldw	(OFST-1,sp),x
2976  017a 2012          	jra	L3171
2977  017c               L7071:
2978                     ; 394 	adr[i]=spi(0xff);
2980  017c a6ff          	ld	a,#255
2981  017e cd02f0        	call	_spi
2983  0181 1e0a          	ldw	x,(OFST+7,sp)
2984  0183 72fb02        	addw	x,(OFST-1,sp)
2985  0186 f7            	ld	(x),a
2986                     ; 392 for(i=0;i<len;i++)
2988  0187 1e02          	ldw	x,(OFST-1,sp)
2989  0189 1c0001        	addw	x,#1
2990  018c 1f02          	ldw	(OFST-1,sp),x
2991  018e               L3171:
2994  018e 1e02          	ldw	x,(OFST-1,sp)
2995  0190 1308          	cpw	x,(OFST+5,sp)
2996  0192 25e8          	jrult	L7071
2997                     ; 397 CS_OFF
2999  0194 721a5005      	bset	20485,#5
3000                     ; 398 }
3003  0198 5b05          	addw	sp,#5
3004  019a 81            	ret
3076                     ; 401 void DF_buffer_write(/*char buff,*/unsigned buff_addr,unsigned len, char* adr)
3076                     ; 402 {
3077                     	switch	.text
3078  019b               _DF_buffer_write:
3080  019b 89            	pushw	x
3081  019c 5203          	subw	sp,#3
3082       00000003      OFST:	set	3
3085                     ; 406 d0=0x84; 
3087                     ; 408 CS_ON
3089  019e 721b5005      	bres	20485,#5
3090                     ; 409 spi(d0);
3092  01a2 a684          	ld	a,#132
3093  01a4 cd02f0        	call	_spi
3095                     ; 410 spi(0xff);
3097  01a7 a6ff          	ld	a,#255
3098  01a9 cd02f0        	call	_spi
3100                     ; 411 spi(*(((char*)&buff_addr)+1));
3102  01ac 7b05          	ld	a,(OFST+2,sp)
3103  01ae cd02f0        	call	_spi
3105                     ; 412 spi(*((char*)&buff_addr));
3107  01b1 7b04          	ld	a,(OFST+1,sp)
3108  01b3 cd02f0        	call	_spi
3110                     ; 414 for(i=0;i<len;i++)
3112  01b6 5f            	clrw	x
3113  01b7 1f02          	ldw	(OFST-1,sp),x
3115  01b9 2010          	jra	L1671
3116  01bb               L5571:
3117                     ; 416 	spi(adr[i]);
3119  01bb 1e0a          	ldw	x,(OFST+7,sp)
3120  01bd 72fb02        	addw	x,(OFST-1,sp)
3121  01c0 f6            	ld	a,(x)
3122  01c1 cd02f0        	call	_spi
3124                     ; 414 for(i=0;i<len;i++)
3126  01c4 1e02          	ldw	x,(OFST-1,sp)
3127  01c6 1c0001        	addw	x,#1
3128  01c9 1f02          	ldw	(OFST-1,sp),x
3129  01cb               L1671:
3132  01cb 1e02          	ldw	x,(OFST-1,sp)
3133  01cd 1308          	cpw	x,(OFST+5,sp)
3134  01cf 25ea          	jrult	L5571
3135                     ; 419 CS_OFF
3137  01d1 721a5005      	bset	20485,#5
3138                     ; 420 }
3141  01d5 5b05          	addw	sp,#5
3142  01d7 81            	ret
3186                     ; 423 void DF_buffer_to_page(/*char buff,*/unsigned page_addr)
3186                     ; 424 {
3187                     	switch	.text
3188  01d8               _DF_buffer_to_page:
3190  01d8 89            	pushw	x
3191  01d9 88            	push	a
3192       00000001      OFST:	set	1
3195                     ; 427 d0=0x88; 
3197                     ; 428 page_addr<<=1;
3199  01da 0803          	sll	(OFST+2,sp)
3200  01dc 0902          	rlc	(OFST+1,sp)
3201                     ; 430 CS_ON
3203  01de 721b5005      	bres	20485,#5
3204                     ; 431 spi(d0);
3206  01e2 a688          	ld	a,#136
3207  01e4 cd02f0        	call	_spi
3209                     ; 432 spi(*(((char*)&page_addr)+1));
3211  01e7 7b03          	ld	a,(OFST+2,sp)
3212  01e9 cd02f0        	call	_spi
3214                     ; 433 spi(*((char*)&page_addr));
3216  01ec 7b02          	ld	a,(OFST+1,sp)
3217  01ee cd02f0        	call	_spi
3219                     ; 434 spi(0xff);
3221  01f1 a6ff          	ld	a,#255
3222  01f3 cd02f0        	call	_spi
3224                     ; 436 CS_OFF
3226  01f6 721a5005      	bset	20485,#5
3227                     ; 437 }
3230  01fa 5b03          	addw	sp,#3
3231  01fc 81            	ret
3274                     ; 440 char index_offset (signed char index,signed char offset)
3274                     ; 441 {
3275                     	switch	.text
3276  01fd               _index_offset:
3278  01fd 89            	pushw	x
3279       00000000      OFST:	set	0
3282                     ; 442 index=index+offset;
3284  01fe 7b01          	ld	a,(OFST+1,sp)
3285  0200 1b02          	add	a,(OFST+2,sp)
3286  0202 6b01          	ld	(OFST+1,sp),a
3287                     ; 443 if(index>=RX_BUFFER_SIZE) index-=RX_BUFFER_SIZE; 
3289  0204 9c            	rvf
3290  0205 7b01          	ld	a,(OFST+1,sp)
3291  0207 a150          	cp	a,#80
3292  0209 2f06          	jrslt	L1302
3295  020b 7b01          	ld	a,(OFST+1,sp)
3296  020d a050          	sub	a,#80
3297  020f 6b01          	ld	(OFST+1,sp),a
3298  0211               L1302:
3299                     ; 444 if(index<0) index+=RX_BUFFER_SIZE;
3301  0211 9c            	rvf
3302  0212 7b01          	ld	a,(OFST+1,sp)
3303  0214 a100          	cp	a,#0
3304  0216 2e06          	jrsge	L3302
3307  0218 7b01          	ld	a,(OFST+1,sp)
3308  021a ab50          	add	a,#80
3309  021c 6b01          	ld	(OFST+1,sp),a
3310  021e               L3302:
3311                     ; 445 return index;
3313  021e 7b01          	ld	a,(OFST+1,sp)
3316  0220 85            	popw	x
3317  0221 81            	ret
3380                     ; 449 char control_check(char index)
3380                     ; 450 {
3381                     	switch	.text
3382  0222               _control_check:
3384  0222 88            	push	a
3385  0223 5203          	subw	sp,#3
3386       00000003      OFST:	set	3
3389                     ; 451 char i=0,ii=0,iii;
3393                     ; 453 if(rx_buffer[index]!=END) goto error_cc;
3395  0225 5f            	clrw	x
3396  0226 97            	ld	xl,a
3397  0227 e600          	ld	a,(_rx_buffer,x)
3398  0229 a10a          	cp	a,#10
3399  022b 2703          	jreq	L5702
3401  022d               L7302:
3402                     ; 467 error_cc:
3402                     ; 468 return 0;
3405  022d 4f            	clr	a
3407  022e 2042          	jra	L43
3408  0230               L5702:
3409                     ; 455 ii=rx_buffer[index_offset(index,-2)];
3411  0230 aefffe        	ldw	x,#65534
3412  0233 7b04          	ld	a,(OFST+1,sp)
3413  0235 95            	ld	xh,a
3414  0236 adc5          	call	_index_offset
3416  0238 5f            	clrw	x
3417  0239 97            	ld	xl,a
3418  023a e600          	ld	a,(_rx_buffer,x)
3419  023c 6b02          	ld	(OFST-1,sp),a
3420                     ; 456 iii=0;
3422  023e 0f01          	clr	(OFST-2,sp)
3423                     ; 457 for(i=0;i<=ii;i++)
3425  0240 0f03          	clr	(OFST+0,sp)
3427  0242 2016          	jra	L3012
3428  0244               L7702:
3429                     ; 459 	iii^=rx_buffer[index_offset(index,-2-ii+i)];
3431  0244 a6fe          	ld	a,#254
3432  0246 1002          	sub	a,(OFST-1,sp)
3433  0248 1b03          	add	a,(OFST+0,sp)
3434  024a 97            	ld	xl,a
3435  024b 7b04          	ld	a,(OFST+1,sp)
3436  024d 95            	ld	xh,a
3437  024e adad          	call	_index_offset
3439  0250 5f            	clrw	x
3440  0251 97            	ld	xl,a
3441  0252 7b01          	ld	a,(OFST-2,sp)
3442  0254 e800          	xor	a,	(_rx_buffer,x)
3443  0256 6b01          	ld	(OFST-2,sp),a
3444                     ; 457 for(i=0;i<=ii;i++)
3446  0258 0c03          	inc	(OFST+0,sp)
3447  025a               L3012:
3450  025a 7b03          	ld	a,(OFST+0,sp)
3451  025c 1102          	cp	a,(OFST-1,sp)
3452  025e 23e4          	jrule	L7702
3453                     ; 461 if (iii!=rx_buffer[index_offset(index,-1)]) goto error_cc;	
3455  0260 aeffff        	ldw	x,#65535
3456  0263 7b04          	ld	a,(OFST+1,sp)
3457  0265 95            	ld	xh,a
3458  0266 ad95          	call	_index_offset
3460  0268 5f            	clrw	x
3461  0269 97            	ld	xl,a
3462  026a e600          	ld	a,(_rx_buffer,x)
3463  026c 1101          	cp	a,(OFST-2,sp)
3464  026e 26bd          	jrne	L7302
3467  0270               L5302:
3468                     ; 464 success_cc:
3468                     ; 465 return 1;
3470  0270 a601          	ld	a,#1
3472  0272               L43:
3474  0272 5b04          	addw	sp,#4
3475  0274 81            	ret
3498                     ; 476 void gpio_init(void){
3499                     	switch	.text
3500  0275               _gpio_init:
3504                     ; 482 	GPIOD->DDR|=(1<<2);
3506  0275 72145011      	bset	20497,#2
3507                     ; 483 	GPIOD->CR1|=(1<<2);
3509  0279 72145012      	bset	20498,#2
3510                     ; 484 	GPIOD->CR2&=~(1<<2);
3512  027d 72155013      	bres	20499,#2
3513                     ; 485 	GPIOD->ODR&=~(1<<2);
3515  0281 7215500f      	bres	20495,#2
3516                     ; 488 	GPIOD->DDR|=(1<<4);
3518  0285 72185011      	bset	20497,#4
3519                     ; 489 	GPIOD->CR1|=(1<<4);
3521  0289 72185012      	bset	20498,#4
3522                     ; 490 	GPIOD->CR2&=~(1<<4);
3524  028d 72195013      	bres	20499,#4
3525                     ; 492 	GPIOC->DDR|=(1<<5);
3527  0291 721a500c      	bset	20492,#5
3528                     ; 493 	GPIOC->CR1|=(1<<5);
3530  0295 721a500d      	bset	20493,#5
3531                     ; 494 	GPIOC->CR2&=~(1<<5);
3533  0299 721b500e      	bres	20494,#5
3534                     ; 497 	GPIOB->DDR|=(1<<5);
3536  029d 721a5007      	bset	20487,#5
3537                     ; 498 	GPIOB->CR1|=(1<<5);
3539  02a1 721a5008      	bset	20488,#5
3540                     ; 499 	GPIOB->CR2&=~(1<<5);	
3542  02a5 721b5009      	bres	20489,#5
3543                     ; 500 }
3546  02a9 81            	ret
3569                     ; 503 void t2_init(void){
3570                     	switch	.text
3571  02aa               _t2_init:
3575                     ; 504 	TIM2->PSCR = 0;
3577  02aa 725f530e      	clr	21262
3578                     ; 505 	TIM2->ARRH= 0x00;
3580  02ae 725f530f      	clr	21263
3581                     ; 506 	TIM2->ARRL= 0xff;
3583  02b2 35ff5310      	mov	21264,#255
3584                     ; 507 	TIM2->CCR1H= 0x00;	
3586  02b6 725f5311      	clr	21265
3587                     ; 508 	TIM2->CCR1L= 200;
3589  02ba 35c85312      	mov	21266,#200
3590                     ; 509 	TIM2->CCR2H= 0x00;	
3592  02be 725f5313      	clr	21267
3593                     ; 510 	TIM2->CCR2L= 200;
3595  02c2 35c85314      	mov	21268,#200
3596                     ; 511 	TIM2->CCR3H= 0x00;	
3598  02c6 725f5315      	clr	21269
3599                     ; 512 	TIM2->CCR3L= 200;
3601  02ca 35c85316      	mov	21270,#200
3602                     ; 515 	TIM2->CCMR2= ((6<<4) & TIM2_CCMR_OCM) | TIM2_CCMR_OCxPE; //OC2 toggle mode, prelouded
3604  02ce 35685308      	mov	21256,#104
3605                     ; 516 	TIM2->CCMR3= ((6<<4) & TIM2_CCMR_OCM) | TIM2_CCMR_OCxPE; //OC2 toggle mode, prelouded
3607  02d2 35685309      	mov	21257,#104
3608                     ; 517 	TIM2->CCER1= /*TIM2_CCER1_CC1E | TIM2_CCER1_CC1P |*/ TIM2_CCER1_CC2E | TIM2_CCER1_CC2P; //OC1, OC2 output pins enabled
3610  02d6 3530530a      	mov	21258,#48
3611                     ; 519 	TIM2->CCER2= TIM2_CCER2_CC3E | TIM2_CCER2_CC3P; //OC1, OC2 output pins enabled
3613  02da 3503530b      	mov	21259,#3
3614                     ; 521 	TIM2->CR1=(TIM2_CR1_CEN | TIM2_CR1_ARPE);	
3616  02de 35815300      	mov	21248,#129
3617                     ; 523 }
3620  02e2 81            	ret
3643                     ; 526 void spi_init(void){
3644                     	switch	.text
3645  02e3               _spi_init:
3649                     ; 527 	SPI->CR1= /*SPI_CR1_LSBFIRST |*/
3649                     ; 528 			SPI_CR1_SPE | 
3649                     ; 529 			( (3<< 2) & SPI_CR1_BR ) |
3649                     ; 530 			SPI_CR1_MSTR |
3649                     ; 531 			SPI_CR1_CPOL |
3649                     ; 532 			SPI_CR1_CPHA; 
3651  02e3 354f5200      	mov	20992,#79
3652                     ; 534 	SPI->CR2= SPI_CR2_SSM | SPI_CR2_SSI;
3654  02e7 35035201      	mov	20993,#3
3655                     ; 535 	SPI->ICR= 0;	
3657  02eb 725f5202      	clr	20994
3658                     ; 536 }
3661  02ef 81            	ret
3704                     ; 538 char spi(char in){
3705                     	switch	.text
3706  02f0               _spi:
3708  02f0 88            	push	a
3709  02f1 88            	push	a
3710       00000001      OFST:	set	1
3713  02f2               L5612:
3714                     ; 540 	while(!((SPI->SR)&SPI_SR_TXE));
3716  02f2 c65203        	ld	a,20995
3717  02f5 a502          	bcp	a,#2
3718  02f7 27f9          	jreq	L5612
3719                     ; 541 	SPI->DR=in;
3721  02f9 7b02          	ld	a,(OFST+1,sp)
3722  02fb c75204        	ld	20996,a
3724  02fe               L5712:
3725                     ; 542 	while(!((SPI->SR)&SPI_SR_RXNE));
3727  02fe c65203        	ld	a,20995
3728  0301 a501          	bcp	a,#1
3729  0303 27f9          	jreq	L5712
3730                     ; 543 	c=SPI->DR;	
3732  0305 c65204        	ld	a,20996
3733  0308 6b01          	ld	(OFST+0,sp),a
3734                     ; 544 	return c;
3736  030a 7b01          	ld	a,(OFST+0,sp)
3739  030c 85            	popw	x
3740  030d 81            	ret
3763                     ; 548 void t4_init(void){
3764                     	switch	.text
3765  030e               _t4_init:
3769                     ; 549 	TIM4->PSCR = 3;
3771  030e 35035347      	mov	21319,#3
3772                     ; 550 	TIM4->ARR= 158;
3774  0312 359e5348      	mov	21320,#158
3775                     ; 551 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
3777  0316 72105343      	bset	21315,#0
3778                     ; 553 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
3780  031a 35855340      	mov	21312,#133
3781                     ; 555 }
3784  031e 81            	ret
3825                     ; 563 @far @interrupt void TIM4_UPD_Interrupt (void) {
3827                     	switch	.text
3828  031f               f_TIM4_UPD_Interrupt:
3832                     ; 572 	if(play) {
3834  031f 725d0008      	tnz	_play
3835  0323 2755          	jreq	L1222
3836                     ; 573 		TIM2->CCR3H= 0x00;	
3838  0325 725f5315      	clr	21269
3839                     ; 574 		TIM2->CCR3L= sample;
3841  0329 5500055316    	mov	21270,_sample
3842                     ; 575 		sample_cnt++;
3844  032e ce0006        	ldw	x,_sample_cnt
3845  0331 1c0001        	addw	x,#1
3846  0334 cf0006        	ldw	_sample_cnt,x
3847                     ; 576 		if(sample_cnt>=256) {
3849  0337 ce0006        	ldw	x,_sample_cnt
3850  033a a30100        	cpw	x,#256
3851  033d 2504          	jrult	L3222
3852                     ; 577 			sample_cnt=0;
3854  033f 5f            	clrw	x
3855  0340 cf0006        	ldw	_sample_cnt,x
3856  0343               L3222:
3857                     ; 580 		sample=buff[sample_cnt];
3859  0343 ce0006        	ldw	x,_sample_cnt
3860  0346 d6000a        	ld	a,(_buff,x)
3861  0349 c70005        	ld	_sample,a
3862                     ; 582 		if(sample_cnt==132)	{
3864  034c ce0006        	ldw	x,_sample_cnt
3865  034f a30084        	cpw	x,#132
3866  0352 2604          	jrne	L5222
3867                     ; 583 			bBUFF_LOAD=1;
3869  0354 35010002      	mov	_bBUFF_LOAD,#1
3870  0358               L5222:
3871                     ; 586 		if(sample_cnt==54) {
3873  0358 ce0006        	ldw	x,_sample_cnt
3874  035b a30036        	cpw	x,#54
3875  035e 2604          	jrne	L7222
3876                     ; 587 			bBUFF_READ_H=1;
3878  0360 35010001      	mov	_bBUFF_READ_H,#1
3879  0364               L7222:
3880                     ; 590 		if(sample_cnt==182) {
3882  0364 ce0006        	ldw	x,_sample_cnt
3883  0367 a300b6        	cpw	x,#182
3884  036a 2604          	jrne	L1322
3885                     ; 591 			bBUFF_READ_L=1;
3887  036c 35010000      	mov	_bBUFF_READ_L,#1
3888  0370               L1322:
3889                     ; 594 		but_drv_cnt=0;
3891  0370 725f0004      	clr	_but_drv_cnt
3892                     ; 595 		but_on_drv_cnt=0;
3894  0374 725f0003      	clr	_but_on_drv_cnt
3896  0378 200e          	jra	L3322
3897  037a               L1222:
3898                     ; 598 	else if(!bSTART) {
3900  037a 725d010a      	tnz	_bSTART
3901  037e 2608          	jrne	L3322
3902                     ; 599 		TIM2->CCR3H= 0x00;	
3904  0380 725f5315      	clr	21269
3905                     ; 600 		TIM2->CCR3L= 0x80;
3907  0384 35805316      	mov	21270,#128
3908  0388               L3322:
3909                     ; 617 	if(++t0_cnt0>=125){
3911  0388 725c0004      	inc	_t0_cnt0
3912  038c c60004        	ld	a,_t0_cnt0
3913  038f a17d          	cp	a,#125
3914  0391 2541          	jrult	L7322
3915                     ; 618     		t0_cnt0=0;
3917  0393 725f0004      	clr	_t0_cnt0
3918                     ; 619     		b100Hz=1;
3920  0397 35010000      	mov	_b100Hz,#1
3921                     ; 621 		if(++t0_cnt1>=10){
3923  039b 725c0005      	inc	_t0_cnt1
3924  039f c60005        	ld	a,_t0_cnt1
3925  03a2 a10a          	cp	a,#10
3926  03a4 2508          	jrult	L1422
3927                     ; 622 			t0_cnt1=0;
3929  03a6 725f0005      	clr	_t0_cnt1
3930                     ; 623 			b10Hz=1;
3932  03aa 35010001      	mov	_b10Hz,#1
3933  03ae               L1422:
3934                     ; 627 		if(++t0_cnt2>=20){
3936  03ae 725c0006      	inc	_t0_cnt2
3937  03b2 c60006        	ld	a,_t0_cnt2
3938  03b5 a114          	cp	a,#20
3939  03b7 2508          	jrult	L3422
3940                     ; 628 			t0_cnt2=0;
3942  03b9 725f0006      	clr	_t0_cnt2
3943                     ; 629 			b5Hz=1;
3945  03bd 35010002      	mov	_b5Hz,#1
3946  03c1               L3422:
3947                     ; 632 		if(++t0_cnt3>=100){
3949  03c1 725c0007      	inc	_t0_cnt3
3950  03c5 c60007        	ld	a,_t0_cnt3
3951  03c8 a164          	cp	a,#100
3952  03ca 2508          	jrult	L7322
3953                     ; 633 			t0_cnt3=0;
3955  03cc 725f0007      	clr	_t0_cnt3
3956                     ; 634 			b1Hz=1;
3958  03d0 35010003      	mov	_b1Hz,#1
3959  03d4               L7322:
3960                     ; 653 		TIM4->SR1&=~TIM4_SR1_UIF;			// disable break interrupt
3962  03d4 72115344      	bres	21316,#0
3963                     ; 654 	return;
3966  03d8 80            	iret
4001                     ; 661 main(){
4003                     	switch	.text
4004  03d9               _main:
4008                     ; 662 	CLK->CKDIVR=0;
4010  03d9 725f50c6      	clr	20678
4011                     ; 663 	t4_init();
4013  03dd cd030e        	call	_t4_init
4015                     ; 664 	gpio_init();
4017  03e0 cd0275        	call	_gpio_init
4019                     ; 665 	t2_init();
4021  03e3 cd02aa        	call	_t2_init
4023                     ; 666 	spi_init();
4025  03e6 cd02e3        	call	_spi_init
4027                     ; 675 	uart_init();
4029  03e9 cd0000        	call	_uart_init
4031                     ; 676 	enableInterrupts();	
4034  03ec 9a            rim
4036  03ed               L7522:
4037                     ; 689 		if(bRXIN)	{
4039  03ed 725d0000      	tnz	_bRXIN
4040  03f1 2707          	jreq	L3622
4041                     ; 690 			bRXIN=0;
4043  03f3 725f0000      	clr	_bRXIN
4044                     ; 692 			uart_in();
4046  03f7 cd0000        	call	_uart_in
4048  03fa               L3622:
4049                     ; 695 		if(b100Hz){
4051  03fa 725d0000      	tnz	_b100Hz
4052  03fe 2704          	jreq	L5622
4053                     ; 696 			b100Hz=0;
4055  0400 725f0000      	clr	_b100Hz
4056  0404               L5622:
4057                     ; 700 		if(b10Hz){
4059  0404 725d0001      	tnz	_b10Hz
4060  0408 2704          	jreq	L7622
4061                     ; 701 			b10Hz=0;
4063  040a 725f0001      	clr	_b10Hz
4064  040e               L7622:
4065                     ; 705 		if(b5Hz){
4067  040e 725d0002      	tnz	_b5Hz
4068  0412 2704          	jreq	L1722
4069                     ; 706 			b5Hz=0;
4071  0414 725f0002      	clr	_b5Hz
4072  0418               L1722:
4073                     ; 710 		if(b1Hz){
4075  0418 725d0003      	tnz	_b1Hz
4076  041c 27cf          	jreq	L7522
4077                     ; 711 			b1Hz=0;
4079  041e 725f0003      	clr	_b1Hz
4080                     ; 712 			buff[0]++;
4082  0422 725c000a      	inc	_buff
4083  0426 20c5          	jra	L7522
4351                     	xdef	_main
4352                     	switch	.bss
4353  0000               _bBUFF_READ_L:
4354  0000 00            	ds.b	1
4355                     	xdef	_bBUFF_READ_L
4356  0001               _bBUFF_READ_H:
4357  0001 00            	ds.b	1
4358                     	xdef	_bBUFF_READ_H
4359  0002               _bBUFF_LOAD:
4360  0002 00            	ds.b	1
4361                     	xdef	_bBUFF_LOAD
4362  0003               _but_on_drv_cnt:
4363  0003 00            	ds.b	1
4364                     	xdef	_but_on_drv_cnt
4365  0004               _but_drv_cnt:
4366  0004 00            	ds.b	1
4367                     	xdef	_but_drv_cnt
4368  0005               _sample:
4369  0005 00            	ds.b	1
4370                     	xdef	_sample
4371  0006               _sample_cnt:
4372  0006 0000          	ds.b	2
4373                     	xdef	_sample_cnt
4374  0008               _play:
4375  0008 00            	ds.b	1
4376                     	xdef	_play
4377                     	xdef	f_TIM4_UPD_Interrupt
4378                     	xdef	_control_check
4379                     	xdef	_index_offset
4380                     	xdef	_t4_init
4381                     	xdef	_spi_init
4382                     	xdef	_t2_init
4383                     	xdef	_gpio_init
4384                     	xdef	_DF_buffer_to_page
4385                     	xdef	_DF_buffer_write
4386                     	xdef	_DF_buffer_read
4387                     	xdef	_DF_buffer_to_page_er
4388                     	xdef	_DF_page_to_buffer
4389                     	xdef	_DF_status_read
4390                     	xdef	_DF_memo_to_256
4391                     	xdef	_DF_mf_dev_read
4392                     	xdef	_delay_ms
4393                     	xdef	_spi
4394                     .eeprom:	section	.data
4395  0000               _aaa:
4396  0000 00            	ds.b	1
4397                     	xdef	_aaa
4398                     	switch	.bss
4399  0009               _rx_plazma:
4400  0009 00            	ds.b	1
4401                     	xdef	_rx_plazma
4402  000a               _buff:
4403  000a 000000000000  	ds.b	256
4404                     	xdef	_buff
4405  010a               _bSTART:
4406  010a 00            	ds.b	1
4407                     	xdef	_bSTART
4408  010b               _current_byte_in_buffer:
4409  010b 0000          	ds.b	2
4410                     	xdef	_current_byte_in_buffer
4411  010d               _last_page:
4412  010d 0000          	ds.b	2
4413                     	xdef	_last_page
4414  010f               _current_page:
4415  010f 0000          	ds.b	2
4416                     	xdef	_current_page
4417  0111               _file_lengt_in_pages:
4418  0111 0000          	ds.b	2
4419                     	xdef	_file_lengt_in_pages
4420  0113               _file_lengt:
4421  0113 00000000      	ds.b	4
4422                     	xdef	_file_lengt
4423                     	xdef	_t0_cnt3
4424                     	xdef	_t0_cnt2
4425                     	xdef	_t0_cnt1
4426                     	xdef	_t0_cnt0
4427                     	xdef	_b1Hz
4428                     	xdef	_b5Hz
4429                     	xdef	_b10Hz
4430                     	xdef	_b100Hz
4431                     	xdef	_uart_in_an
4432                     	xref	_uart_in
4433                     	xref	_uart_out
4434                     	xref	_uart_init
4435                     	xref.b	_UIB
4436                     	xref.b	_rx_buffer
4437                     	xref	_bRXIN
4438                     	xref.b	c_x
4439                     	xref.b	c_y
4459                     	xref	c_lcmp
4460                     	xref	c_ltor
4461                     	xref	c_lgadc
4462                     	xref	c_rtol
4463                     	xref	c_vmul
4464                     	end
