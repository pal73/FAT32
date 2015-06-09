#include "stm8s.h"
#include "cmd.c"
#include "uart1.h"
#include "main.h"
#include <iostm8s103.h>

#define CS_ON	GPIOB->ODR&=~(1<<5);
#define CS_OFF	GPIOB->ODR|=(1<<5);

@near bool b100Hz=0,b10Hz=0,b5Hz=0,b1Hz=0;
@near char t0_cnt0=0,t0_cnt1=0,t0_cnt2=0,t0_cnt3=0;
@near long file_lengt;
@near unsigned short file_lengt_in_pages,current_page,last_page,current_byte_in_buffer;
@near bool bSTART;
@near char rx_plazma;
//char tx_buffer[30]={1,2,3,4,5,6,7,8};
char spi(char in);


@near char play;
@near unsigned short sample_cnt;
@near char sample;
@near char buff[256];
@near signed char but_drv_cnt,but_on_drv_cnt;
@near char bBUFF_LOAD, bBUFF_READ_H, bBUFF_READ_L;

@eeprom char aaa;

//-----------------------------------------------
long delay_ms(short in)
{
long i,ii,iii;

i=((long)in)*100UL;

for(ii=0;ii<i;ii++)
	{
		iii++;
	}

}

//-----------------------------------------------
void uart_in_an(void)
{
char temp_char,r1;




if(UIB[0]==CMND)
	{
	if(UIB[1]==1)
		{
		long temp_L;
		GPIOD->ODR^=(1<<4);
		temp_L=DF_mf_dev_read();
		uart_out (6,CMND,1,*((char*)&temp_L),*(((char*)&temp_L)+1),*(((char*)&temp_L)+2),*(((char*)&temp_L)+3));
		} 
}
		
	else if(UIB[1]==2)
		{
		char temp;
		GPIOD->ODR^=(1<<4);
		temp=DF_status_read();
		uart_out (3,CMND,2,temp,0,0,0);    
		} 
#ifdef _abcd_		
	else if(UIB[1]==3)
		{
		char temp;
		DF_memo_to_256();
		uart_out (2,CMND,3,temp,0,0,0);    
		}				
		
	else if(UIB[1]==4)
		{
		char temp;
		DF_memo_to_256();
		uart_out (2,CMND,3,temp,0,0,0);    
		}				

	else if(UIB[1]==10)
		{
		char temp;
//		DF_page_to_buffer(2,0);
		
		if(UIB[2]==1)DF_buffer_read(/*1,*/0,256, buff);
	    /*	else if(UIB[2]==2)DF_buffer_read(2,0,256, buff);*/
		
	    //	buff[0]=0x55;
		
		uart_out_adr_block (0,buff,64);
		delay_ms(100);    
		uart_out_adr_block (64,&buff[64],64);
		delay_ms(100);    
		uart_out_adr_block (128,&buff[128],64);
		delay_ms(100);    
		uart_out_adr_block (192,&buff[192],64);
		delay_ms(100);    
		}				

	else if(UIB[1]==11)
		{
		char temp;
		unsigned i;
//		DF_page_to_buffer(2,0);
		
		for(i=0;i<256;i++)buff[i]=0;

		if(UIB[2]==1)DF_buffer_write(/*1,*/0,256, buff);
	    /*	else if(UIB[2]==2)DF_buffer_write(2,0,256, buff);*/
		}	
		
	else if(UIB[1]==12)
		{
		char temp;
		unsigned i;

		
		for(i=0;i<256;i++)buff[i]=0;
		
		if(UIB[3]==1)
			{
			buff[0]=0x00;
			buff[1]=0x11;
			buff[2]=0x22;
			buff[3]=0x33;
			buff[4]=0x44;
			buff[5]=0x55;
			buff[6]=0x66;
			buff[7]=0x77;
			buff[8]=0x88;
			buff[9]=0x99;
			buff[10]=0;
			buff[11]=0;
			}

		else if(UIB[3]==2)
			{
			buff[0]=0x00;
			buff[1]=0x10;
			buff[2]=0x20;
			buff[3]=0x30;
			buff[4]=0x40;
			buff[5]=0x50;
			buff[6]=0x60;
			buff[7]=0x70;
			buff[8]=0x80;
			buff[9]=0x90;
			buff[10]=0;
			buff[11]=0;
			}

		else if(UIB[3]==3)
			{
			buff[0]=0x98;
			buff[1]=0x87;
			buff[2]=0x76;
			buff[3]=0x65;
			buff[4]=0x54;
			buff[5]=0x43;
			buff[6]=0x32;
			buff[7]=0x21;
			buff[8]=0x10;
			buff[9]=0x00;
			buff[10]=0;
			buff[11]=0;
			}
		if(UIB[2]==1)DF_buffer_write(/*1,*/0,256, buff);
	    /*	else if(UIB[2]==2)DF_buffer_write(2,0,256, buff);*/
		}
		
	else if(UIB[1]==13)
		{
		char temp;
		unsigned i;
          		
		DF_page_to_buffer(/*UIB[2],*/UIB[3]);
			
		}					

	else if(UIB[1]==20)
		{
		char temp;
		unsigned i;
          		
		file_lengt=*((long*)&UIB[2]);
		file_lengt_in_pages=(unsigned)(file_lengt/256);
		current_page=0;
		current_byte_in_buffer=0;
///		current_buffer=1;
		
		uart_out (4,CMND,21,*((char*)&current_page),*(((char*)&current_page)+1),0,0);
			
		}
	else if(UIB[1]==21)
		{
		char temp;
		unsigned i;
          
          for(i=0;i<64;i++)
          	{
          	buff[current_byte_in_buffer+i]=UIB[2+i];
          	}                                       
          current_byte_in_buffer+=64;
          if(current_byte_in_buffer>=256)
          	{
          	
      /*    	for(i=0;i<256;i++)
          	{
          	buff[i]=(char)i;
          	}  */ 
          	
          	DF_buffer_write(/*//current_buffer*//*1,*/0,256,buff);
          	DF_buffer_to_page_er(/*///current_buffer*//*1,*/current_page);
			current_page++;
			if(current_page<file_lengt_in_pages)
				{ 
				delay_ms(50);
				uart_out (4,CMND,21,*((char*)&current_page),*(((char*)&current_page)+1),0,0);
				current_byte_in_buffer=0;
			    ///	if(current_buffer==1)current_buffer=2;
			    ///	else current_buffer=1;
				}
			else 
				{
				//-//EE_PAGE_LEN=current_page;
				}
          	}	
          		

			
		}
		
	else if(UIB[1]==30)
		{
		char temp;
		unsigned i;
          
     //     for(i=0;i<256;i++) buff[i]=20/*(char)i*/; 
/*          
          current_page=0;
          last_page=EE_PAGE_LEN-5;
          
          current_buffer_H=2;
          current_buffer_L=2;
          
          DF_page_to_buffer(current_buffer_H,current_page);
          delay_ms(10);
 		DF_buffer_read(current_buffer_L,0,128,buff);
 		delay_ms(10);
		DF_buffer_read(current_buffer_L,128,128,&buff[128]);         
          
          //for(i=0;i<100;i++) buff[i]=240; 
          
          play=1; */ 
          bSTART=1;
          		
/*		file_lengt=*((long*)&UIB[2]);
		file_lengt_in_pages=(unsigned)(file_lengt/256);
		
		current_byte_in_buffer=0;
		current_buffer=1;
		
		usart_out (4,CMND,21,*((char*)&current_page),*(((char*)&current_page)+1),0,0); */
			
		}								
	
	else if(UIB[1]==40)
		{
		char temp;
		unsigned i;
          
/*      
          DF_page_to_buffer(1,*((unsigned*)&UIB[2]));
          delay_ms(10);
 		DF_buffer_read(1,0,128,buff);
 		delay_ms(10);
		DF_buffer_read(1,128,128,&buff[128]);         
          
		usart_out_adr_block (0,buff,64);
		delay_ms(100);    
		usart_out_adr_block (64,&buff[64],64);
		delay_ms(100);    
		usart_out_adr_block (128,&buff[128],64);
		delay_ms(100);    
		usart_out_adr_block (192,&buff[192],64);
		delay_ms(100);    
          
          play=1;*/
		bSTART=1;	
		}								
	}
#endif	
}

//-----------------------------------------------
long DF_mf_dev_read(void)
{
char d0,d1,d2,d3;

//GPIOD->ODR&=~(1<<2);
CS_ON
spi(0x9f);
d0=spi(0xff);
d1=spi(0xff);
d2=spi(0xff);
d3=spi(0xff);  
//GPIOD->ODR|=(1<<2); 
CS_OFF
return  *((long*)&d0);
}

//-----------------------------------------------
void DF_memo_to_256(void)
{
//GPIOD->ODR&=~(1<<2);
CS_ON
spi(0x3d);
spi(0x2a); 
spi(0x80);
spi(0xa6);
//GPIOD->ODR|=(1<<2);
CS_OFF
}  

//-----------------------------------------------
char DF_status_read(void)
{
char d0;

//GPIOD->ODR&=~(1<<2);
CS_ON
spi(0xd7);
d0=spi(0xff);
//GPIOD->ODR|=(1<<2);
CS_OFF
return d0;
}

//-----------------------------------------------
void DF_page_to_buffer(unsigned page_addr)
{
char d0;

d0=0x53; 

page_addr<<=1;
//GPIOD->ODR&=~(1<<2);
CS_ON
spi(d0);
spi(*(((char*)&page_addr)+1));
spi(*((char*)&page_addr));
spi(0xff);
//GPIOD->ODR|=(1<<2);
CS_OFF
}

//-----------------------------------------------
void DF_buffer_to_page_er(/*char buff,*/unsigned page_addr)
{
char d0;

d0=0x83; 
page_addr<<=1;
//GPIOD->ODR&=~(1<<2);
CS_ON
spi(d0);
spi(*(((char*)&page_addr)+1));
spi(*((char*)&page_addr));
spi(0xff);
//GPIOD->ODR|=(1<<2);
CS_OFF
}

//-----------------------------------------------
void DF_buffer_read(unsigned buff_addr,unsigned len, char* adr)
{
unsigned i;
char d0;

d0=0x54; 
//GPIOD->ODR&=~(1<<2);
CS_ON
spi(d0);
spi(0xff);
spi(*(((char*)&buff_addr)+1));
spi(*((char*)&buff_addr));
spi(0xff);
for(i=0;i<len;i++)
	{
	adr[i]=spi(0xff);
	}
//GPIOD->ODR|=(1<<2);
CS_OFF
}

//-----------------------------------------------
void DF_buffer_write(/*char buff,*/unsigned buff_addr,unsigned len, char* adr)
{
unsigned i;
char d0;

d0=0x84; 
//GPIOD->ODR&=~(1<<2);
CS_ON
spi(d0);
spi(0xff);
spi(*(((char*)&buff_addr)+1));
spi(*((char*)&buff_addr));

for(i=0;i<len;i++)
	{
	spi(adr[i]);
	}
//GPIOD->ODR|=(1<<2);
CS_OFF
}

//-----------------------------------------------
void DF_buffer_to_page(/*char buff,*/unsigned page_addr)
{
char d0;

d0=0x88; 
page_addr<<=1;
//GPIOD->ODR&=~(1<<2);
CS_ON
spi(d0);
spi(*(((char*)&page_addr)+1));
spi(*((char*)&page_addr));
spi(0xff);
//GPIOD->ODR|=(1<<2);
CS_OFF
}

//-----------------------------------------------
char index_offset (signed char index,signed char offset)
{
index=index+offset;
if(index>=RX_BUFFER_SIZE) index-=RX_BUFFER_SIZE; 
if(index<0) index+=RX_BUFFER_SIZE;
return index;
}

//-----------------------------------------------
char control_check(char index)
{
char i=0,ii=0,iii;

if(rx_buffer[index]!=END) goto error_cc;

ii=rx_buffer[index_offset(index,-2)];
iii=0;
for(i=0;i<=ii;i++)
	{
	iii^=rx_buffer[index_offset(index,-2-ii+i)];
	}
if (iii!=rx_buffer[index_offset(index,-1)]) goto error_cc;	


success_cc:
return 1;
goto end_cc;
error_cc:
return 0;
goto end_cc;

end_cc:
return;
}

//-----------------------------------------------
void gpio_init(void){
/*	GPIOB->DDR=0xff;
	GPIOB->CR1=0xff;
	GPIOB->CR2=0;
	GPIOB->ODR=0;
	*/
	GPIOD->DDR|=(1<<2);
	GPIOD->CR1|=(1<<2);
	GPIOD->CR2&=~(1<<2);
	GPIOD->ODR&=~(1<<2);


	GPIOD->DDR|=(1<<4);
	GPIOD->CR1|=(1<<4);
	GPIOD->CR2&=~(1<<4);

	GPIOC->DDR|=(1<<5);
	GPIOC->CR1|=(1<<5);
	GPIOC->CR2&=~(1<<5);
	
	
	GPIOB->DDR|=(1<<5);
	GPIOB->CR1|=(1<<5);
	GPIOB->CR2&=~(1<<5);	
}

//-----------------------------------------------
void t2_init(void){
	TIM2->PSCR = 0;
	TIM2->ARRH= 0x00;
	TIM2->ARRL= 0xff;
	TIM2->CCR1H= 0x00;	
	TIM2->CCR1L= 200;
	TIM2->CCR2H= 0x00;	
	TIM2->CCR2L= 200;
	TIM2->CCR3H= 0x00;	
	TIM2->CCR3L= 200;
	
	//TIM2->CCMR1= ((6<<4) & TIM2_CCMR_OCM) | TIM2_CCMR_OCxPE; //OC2 toggle mode, prelouded
	TIM2->CCMR2= ((6<<4) & TIM2_CCMR_OCM) | TIM2_CCMR_OCxPE; //OC2 toggle mode, prelouded
	TIM2->CCMR3= ((6<<4) & TIM2_CCMR_OCM) | TIM2_CCMR_OCxPE; //OC2 toggle mode, prelouded
	TIM2->CCER1= /*TIM2_CCER1_CC1E | TIM2_CCER1_CC1P |*/ TIM2_CCER1_CC2E | TIM2_CCER1_CC2P; //OC1, OC2 output pins enabled
	//TIM2->CCER2= TIM2_CCER2_CC3E | TIM2_CCER2_CC3P; //OC1, OC2 output pins enabled
	TIM2->CCER2= TIM2_CCER2_CC3E | TIM2_CCER2_CC3P; //OC1, OC2 output pins enabled
	
	TIM2->CR1=(TIM2_CR1_CEN | TIM2_CR1_ARPE);	
	
}

//-----------------------------------------------
void spi_init(void){
	SPI->CR1= /*SPI_CR1_LSBFIRST |*/
			SPI_CR1_SPE | 
			( (3<< 2) & SPI_CR1_BR ) |
			SPI_CR1_MSTR |
			SPI_CR1_CPOL |
			SPI_CR1_CPHA; 
			
	SPI->CR2= SPI_CR2_SSM | SPI_CR2_SSI;
	SPI->ICR= 0;	
}
//-----------------------------------------------
char spi(char in){
	char c;
	while(!((SPI->SR)&SPI_SR_TXE));
	SPI->DR=in;
	while(!((SPI->SR)&SPI_SR_RXNE));
	c=SPI->DR;	
	return c;
}

//-----------------------------------------------
void t4_init(void){
	TIM4->PSCR = 3;
	TIM4->ARR= 158;
	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
	
	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
	
}


//***********************************************
//***********************************************
//***********************************************
//***********************************************
#ifdef _COSMIC_
@far @interrupt void TIM4_UPD_Interrupt (void) {
#else
void TIM4_UPD_Interrupt (void) interrupt 23 {
#endif


	
	//GPIOD->ODR^=(1<<2);
	
	if(play) {
		TIM2->CCR3H= 0x00;	
		TIM2->CCR3L= sample;
		sample_cnt++;
		if(sample_cnt>=256) {
			sample_cnt=0;
		}
	
		sample=buff[sample_cnt];
		
		if(sample_cnt==132)	{
			bBUFF_LOAD=1;
   		}

		if(sample_cnt==54) {
			bBUFF_READ_H=1;
    		}
    	
		if(sample_cnt==182) {
			bBUFF_READ_L=1;
    		} 
    	
		but_drv_cnt=0;
		but_on_drv_cnt=0;
	}

	else if(!bSTART) {
		TIM2->CCR3H= 0x00;	
		TIM2->CCR3L= 0x80;
	
		//-//if(!PINC.0)but_on_drv_cnt++;
	
		//-//but_drv_cnt++;
		//-//if(but_drv_cnt>20) {
			//-//but_drv_cnt=0;
			//-//if(but_on_drv_cnt>12) {
			//-//bSTART=1;
			//-//}
		//-//}
	
	
	//-//DDRC.0=0;
	//-//PORTC.0=1; 
	}

	if(++t0_cnt0>=125){
    		t0_cnt0=0;
    		b100Hz=1;

		if(++t0_cnt1>=10){
			t0_cnt1=0;
			b10Hz=1;
			//GPIOB->ODR^=0xff;
		}
		
		if(++t0_cnt2>=20){
			t0_cnt2=0;
			b5Hz=1;
		}
		
		if(++t0_cnt3>=100){
			t0_cnt3=0;
			b1Hz=1;
		}
	}

	



	
/*	if(bi)
		{
		bi=0;
		}
	else 
		{
		bi=1;
		}*/

		//switch_LED_on;					// NO - switch LEDs on
		TIM4->SR1&=~TIM4_SR1_UIF;			// disable break interrupt
	return;
}

//===============================================
//===============================================
//===============================================
//===============================================
main(){
	CLK->CKDIVR=0;
	t4_init();
	gpio_init();
	t2_init();
	spi_init();
	
	//FLASH_DUKR=0xae;
	//FLASH_DUKR=0x56;
	
	//GPIOD->DDR|=(1<<5);
	//GPIOD->CR1=0xff;
	//GPIOD->CR2=0;
	
	uart_init();
	enableInterrupts();	
	//rx_plazma=aaa;
	//aaa=3;
	
/*	for(;;) {
			
	}*/
	
	while (1){
		
		//GPIOB->ODR^=(1<<5);
		
		//	
		if(bRXIN)	{
			bRXIN=0;
			//GPIOD->ODR^=(1<<4);
			uart_in();
		} 	
		
		if(b100Hz){
			b100Hz=0;
			
      	}  
      	
		if(b10Hz){
			b10Hz=0;
			//DF_status_read();
      	}
      	 
		if(b5Hz){
			b5Hz=0;
			
		}
      	      	
		if(b1Hz){
			b1Hz=0;
			buff[0]++;
			//uart_out (3,0x11,0x22,0x33/*rx_plazma,DF_status_read()*/,0,0,0);
			//uart_out_adr (&t0_cnt0, 65);
			//aaa++;
			
		//DF_mf_dev_read();
      	}      	     	      
	}
}