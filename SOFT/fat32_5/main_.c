#include "stm8s.h"
#include "cmd.c"
#include "uart1.h"
#include "main.h"
#include <iostm8s103.h>

#define CS_ON	GPIOB->ODR&=~(1<<5);
#define CS_OFF	GPIOB->ODR|=(1<<5);

#ifdef _wrk_
@near bool b100Hz=0,b10Hz=0,b5Hz=0,b1Hz=0;
#endif
#ifdef _wrk_
@near char t0_cnt0=0,t0_cnt1=0,t0_cnt2=0,t0_cnt3=0;
#endif
#ifdef _wrk_
@near long file_lengt;
#endif
#ifdef _wrk_
@near unsigned short file_lengt_in_pages,current_page,last_page,current_byte_in_buffer;
@near bool bSTART;
@near char rx_plazma;
//char tx_buffer[30]={1,2,3,4,5,6,7,8};
#endif
char spi(char in);

#ifdef _wrk_
@near char play;
@near unsigned short sample_cnt;
@near char sample;
#endif
#ifdef _wrk_
@near char buff[256];
#endif
#ifdef _wrk_
@near signed char but_drv_cnt,but_on_drv_cnt;
@near char bBUFF_LOAD, bBUFF_READ_H, bBUFF_READ_L;

@eeprom char aaa;
#endif

#ifdef _wrk_
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
#endif

#ifdef _wrk_

#endif

#ifdef _wrk_
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
#endif

#ifdef _wrk_
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
#endif

#ifdef _wrk_
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
#endif

#ifdef _wrk_
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
#endif

#ifdef _wrk_
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
#endif

#ifdef _wrk_
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
#endif

#ifdef _wrk_
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
#endif 

#ifdef _wrk_
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
#endif

#ifdef _wrk_
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
#endif

#ifdef _wrk_
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
#endif 

#ifdef _wrk_
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
#endif

#ifdef _wrk_
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
#endif

#ifdef _wrk_
//-----------------------------------------------
char spi(char in){
	char c;
	while(!((SPI->SR)&SPI_SR_TXE));
	SPI->DR=in;
	while(!((SPI->SR)&SPI_SR_RXNE));
	c=SPI->DR;	
	return c;
}
#endif

#ifdef _wrk_
//-----------------------------------------------
void t4_init(void){
	TIM4->PSCR = 3;
	TIM4->ARR= 158;
	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
	
	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
	
}
#endif

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
#ifdef _wrk_	
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
#endif
	



	
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
	#ifdef _wrk_
	t4_init();
	#endif
	#ifdef _wrk_
	gpio_init();
	#endif
	#ifdef _wrk_
	t2_init();
	#endif
	#ifdef _wrk_
	spi_init();
	#endif
	//FLASH_DUKR=0xae;
	//FLASH_DUKR=0x56;
	
	//GPIOD->DDR|=(1<<5);
	//GPIOD->CR1=0xff;
	//GPIOD->CR2=0;
	
	#ifdef _wrk_
	uart_init();
	#endif
	enableInterrupts();	
	//rx_plazma=aaa;
	//aaa=3;
	
/*	for(;;) {
			
	}*/
	
	while (1){
		
		//GPIOB->ODR^=(1<<5);
		
		//	
		#ifdef _wrk_		
		if(bRXIN)	{
			bRXIN=0;
			//GPIOD->ODR^=(1<<4);
			
		uart_in();

		} 	
		#endif
		
		#ifdef _wrk_
		if(b100Hz){
			b100Hz=0;
			
      	}  
      	#endif
		#ifdef _wrk_
		if(b10Hz){
			b10Hz=0;
			//DF_status_read();
      	}
      	#endif
		#ifdef _wrk_		
		if(b5Hz){
			b5Hz=0;
			
		}
      	#endif
		#ifdef _wrk_      	
		if(b1Hz){
			b1Hz=0;
			//buff[0]++;
			//uart_out (3,0x11,0x22,0x33/*rx_plazma,DF_status_read()*/,0,0,0);
			//uart_out_adr (&t0_cnt0, 65);
			//aaa++;
			
		//DF_mf_dev_read();
      	}
		#endif
	}
}