#include "stm8s.h"
#include "main.h"
#include "cmd.c"
#include <iostm8s103.h>

#define CS_ON	GPIOB->ODR&=~(1<<5);
#define CS_OFF	GPIOB->ODR|=(1<<5);
#define TX_BUFFER_SIZE	80
#define RX_BUFFER_SIZE	80

char t0_cnt0=0,t0_cnt1=0,t0_cnt2=0,t0_cnt3=0;
signed short sample_cnt;
char tx_buffer[TX_BUFFER_SIZE]={0};
signed char tx_counter;
signed char tx_wr_index,tx_rd_index;
char rx_buffer[RX_BUFFER_SIZE]={0};
signed char rx_counter;
signed char rx_wr_index,rx_rd_index;
char sample;
char but_drv_cnt=0;
char but_on_drv_cnt=0;
char mdr0,mdr1,mdr2,mdr3;
unsigned int file_lengt_in_pages,current_page,last_page,current_byte_in_buffer;
unsigned long file_lengt;
char rx_status;
char rx_data;
signed short rele_cnt;

_Bool bSTART;
_Bool bBUFF_LOAD;
_Bool bBUFF_READ_H;
_Bool bBUFF_READ_L;
_Bool b100Hz, b10Hz, b5Hz, b1Hz;
_Bool play;
_Bool bOUT_FREE;
_Bool bRXIN;
_Bool rx_buffer_overflow;
@near char buff[256];
@near char UIB[80];

@eeprom unsigned short EE_PAGE_LEN;

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
	TIM2->CCER2= TIM2_CCER2_CC3E /*| TIM2_CCER2_CC3P*/; //OC1, OC2 output pins enabled
	
	TIM2->CR1=(TIM2_CR1_CEN | TIM2_CR1_ARPE);	
	
}

//-----------------------------------------------
void t4_init(void){
	TIM4->PSCR = 3;
	TIM4->ARR= 158;
	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
	
	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
	
}

//-----------------------------------------------
void rele_drv(void) {

	/*if(rele_cnt) {
		rele_cnt--;
		GPIOD->ODR|=(1<<4);
	}
	else GPIOD->ODR&=~(1<<4);*/ 
	
	if(play) {
		//rele_cnt--;
		GPIOD->ODR|=(1<<4);
	}
	else GPIOD->ODR&=~(1<<4);	
}

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
void uart_init (void){
	UART1->CR1&=~UART1_CR1_M;					
	UART1->CR3|= (0<<4) & UART1_CR3_STOP;	
	UART1->BRR2= 0x01;//0x03;
	UART1->BRR1= 0x1a;//0x68;
	UART1->CR2|= UART1_CR2_TEN | UART3_CR2_REN | UART3_CR2_RIEN;	
}

//-----------------------------------------------
void uart_out (char num,char data0,char data1,char data2,char data3,char data4,char data5){
	char i=0,t=0,UOB[10];
	
	
	UOB[0]=data0;
	UOB[1]=data1;
	UOB[2]=data2;
	UOB[3]=data3;
	UOB[4]=data4;
	UOB[5]=data5;
	for (i=0;i<num;i++)
		{
		t^=UOB[i];
		}    
	UOB[num]=num;
	t^=UOB[num];
	UOB[num+1]=t;
	UOB[num+2]=END;
	
	
	
	for (i=0;i<num+3;i++)
		{
		putchar(UOB[i]);
		} 

	bOUT_FREE=0;	  	
}

//-----------------------------------------------
void uart_out_adr_block (unsigned long adress,char *ptr, char len)
{
//char UOB[100]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
char temp11,t,i11;

t=0;
temp11=CMND;
t^=temp11;
putchar(temp11);

temp11=10;
t^=temp11;
putchar(temp11);

temp11=adress%256;//(*((char*)&adress));
t^=temp11;
putchar(temp11);
adress>>=8;
temp11=adress%256;//(*(((char*)&adress)+1));
t^=temp11;
putchar(temp11);
adress>>=8;
temp11=adress%256;//(*(((char*)&adress)+2));
t^=temp11;
putchar(temp11);
adress>>=8;
temp11=adress%256;//(*(((char*)&adress)+3));
t^=temp11;
putchar(temp11);


for(i11=0;i11<len;i11++)
	{
	temp11=ptr[i11];
	t^=temp11;
	putchar(temp11);
	}
	
temp11=(len+6);
t^=temp11;
putchar(temp11);

putchar(t);

putchar(0x0a);
	
bOUT_FREE=0;	   
}
//-----------------------------------------------
void uart_in_an(void) {
	char temp_char,r1;

	if(UIB[0]==CMND) {
		if(UIB[1]==1) {
			long temp_L;
		//GPIOD->ODR^=(1<<4);
		//GPIOD->ODR^=(1<<4);	
			temp_L=DF_mf_dev_read();
			uart_out (6,CMND,1,mdr0/**((char*)&temp_L)*/,mdr1/**(((char*)&temp_L)+1)*/,mdr2/**(((char*)&temp_L)+2)*/,mdr3/**(((char*)&temp_L)+3)*/);
			//delay_ms(100);
			//putchar(0x19);
			//delay_ms(100);
		} 

		
	else if(UIB[1]==2) {
		char temp;
		//GPIOD->ODR^=(1<<4);
		temp=DF_status_read();
		uart_out (3,CMND,2,temp,0,0,0);    
		} 
	
		
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
	else if(UIB[1]==14)
		{
		char temp;
		unsigned i;
          		
		DF_buffer_to_page_er(/*UIB[2],*/UIB[3]);
			
		}					

	else if(UIB[1]==20)
		{
		char temp;
		unsigned i;
          
		file_lengt=0;
		file_lengt+=UIB[5];
		file_lengt<<=8;
		file_lengt+=UIB[4];
		file_lengt<<=8;
		file_lengt+=UIB[3];
		file_lengt_in_pages=file_lengt;
		file_lengt<<=8;
		file_lengt+=UIB[2];
		
		//file_lengt=UIB[2];
		//+(UIB[3]*256)+(UIB[4]*65536)+(UIB[5]*65536*256);
		//file_lengt_in_pages=file_lengt/256U;
		current_page=0;
		current_byte_in_buffer=0;
///		current_buffer=1;
		
		uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
			
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
				uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
				current_byte_in_buffer=0;
				}
			else 
				{
				EE_PAGE_LEN=current_page;
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
	
}

//-----------------------------------------------
void putchar(char c)
{
while (tx_counter == TX_BUFFER_SIZE);
///#asm("cli")
if (tx_counter || ((UART1->SR & UART1_SR_TXE)==0))
   {
   tx_buffer[tx_wr_index]=c;
   if (++tx_wr_index == TX_BUFFER_SIZE) tx_wr_index=0;
   ++tx_counter;
   }
else UART1->DR=c;

UART1->CR2|= UART1_CR2_TIEN;
///#asm("sei")
}

//-----------------------------------------------
void spi_init(void){
	
	GPIOB->DDR|=(1<<5);
	GPIOB->CR1|=(1<<5);
	GPIOB->CR2&=~(1<<5);	
	
	SPI->CR1= /*SPI_CR1_LSBFIRST |*/
			SPI_CR1_SPE | 
			( (4<< 2) & SPI_CR1_BR ) |
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
long DF_mf_dev_read(void)
{
char d0,d1,d2,d3;

d0=0;
d1=0;
d2=0;
d3=0;
//GPIOD->ODR&=~(1<<2);
CS_ON
spi(0x9f);
mdr0=spi(0xff);
mdr1=spi(0xff);
mdr2=spi(0xff);
mdr3=spi(0xff);  
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

//page_addr<<=1;
//GPIOD->ODR&=~(1<<2);
CS_ON
spi(d0);
spi(page_addr/256/**(((char*)&page_addr)+1)*/);
spi(page_addr%256/**((char*)&page_addr)*/);
spi(0xff);
//GPIOD->ODR|=(1<<2);
CS_OFF
}

//-----------------------------------------------
void DF_buffer_to_page_er(/*char buff,*/unsigned page_addr)
{
char d0;

d0=0x83; 
//page_addr<<=1;
//GPIOD->ODR&=~(1<<2);
CS_ON
spi(d0);
spi(page_addr/256/**(((char*)&page_addr)+1)*/);
spi(page_addr%256/**((char*)&page_addr)*/);
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
spi(buff_addr/256/**(((char*)&buff_addr)+1)*/);
spi(buff_addr%256/**((char*)&buff_addr)*/);
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
spi(buff_addr/256/**(((char*)&buff_addr)+1)*/);
spi(buff_addr%256/**((char*)&buff_addr)*/);

for(i=0;i<len;i++)
	{
	spi(adr[i]);
	}
//GPIOD->ODR|=(1<<2);
CS_OFF
}

#ifdef _wrk_
//-----------------------------------------------
void DF_buffer_to_page(/*char buff,*/unsigned page_addr)
{
char d0;

d0=0x88; 
//page_addr<<=1;
//GPIOD->ODR&=~(1<<2);
CS_ON
spi(d0);
spi(page_addr/256/**(((char*)&page_addr)+1)*/);
spi(page_addr%256/**((char*)&page_addr)*/);
spi(0xff);
//GPIOD->ODR|=(1<<2);
CS_OFF
}
#endif

//-----------------------------------------------
void gpio_init(void){
/*	GPIOB->DDR=0xff;
	GPIOB->CR1=0xff;
	GPIOB->CR2=0;
	GPIOB->ODR=0;
	*/
	///GPIOD->DDR|=(1<<2);
	///GPIOD->CR1|=(1<<2);
	///GPIOD->CR2&=~(1<<2);
	///GPIOD->ODR&=~(1<<2);


	GPIOD->DDR|=(1<<4);
	GPIOD->CR1|=(1<<4);
	GPIOD->CR2&=~(1<<4);

	///GPIOC->DDR|=(1<<5);
	///GPIOC->CR1|=(1<<5);
	///GPIOC->CR2&=~(1<<5);
	
	

}

//-----------------------------------------------
void uart_in(void)
{
char temp,i,count;
//#asm("cli")
//disableInterrupts();
if(rx_buffer_overflow)
	{
	rx_wr_index=0;
	rx_rd_index=0;
	rx_counter=0;
	rx_buffer_overflow=0;
	}    
	
if(rx_counter&&(rx_buffer[index_offset(rx_wr_index,-1)])==END)
	{
	//GPIOD->ODR^=(1<<4);
	//uart_out (3,CMND,1,33,mdr1/**(((char*)&temp_L)+1)*/,mdr2/**(((char*)&temp_L)+2)*/,mdr3/**(((char*)&temp_L)+3)*/);
    temp=rx_buffer[index_offset(rx_wr_index,-3)];
    	if(temp<100) 
    		{
		
    		if(control_check(index_offset(rx_wr_index,-1)))
    			{///uart_out (3,CMND,1,33,mdr1/**(((char*)&temp_L)+1)*/,mdr2/**(((char*)&temp_L)+2)*/,mdr3/**(((char*)&temp_L)+3)*/);
			//GPIOD->ODR^=(1<<4);
    			rx_rd_index=index_offset(rx_wr_index,-3-temp);
    			for(i=0;i<temp;i++)
				{
				UIB[i]=rx_buffer[index_offset(rx_rd_index,i)];
				} 
			rx_rd_index=rx_wr_index;
			rx_counter=0;
			
			uart_in_an();
/**/
    			}
 	
    		} 
    	}	

//#asm("sei") 
//enableInterrupts();
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

if(rx_buffer[index]!=END) return 0;

ii=rx_buffer[index_offset(index,-2)];
iii=0;
for(i=0;i<=ii;i++)
	{
	iii^=rx_buffer[index_offset(index,-2-ii+i)];
	}
if (iii!=rx_buffer[index_offset(index,-1)]) return 0;	

return 1;

}


//***********************************************
//***********************************************
//***********************************************
//***********************************************
@far @interrupt void TIM4_UPD_Interrupt (void) {

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
	
	}


	if(++t0_cnt0>=125){
    		t0_cnt0=0;
    		b100Hz=1;

		if(++t0_cnt1>=10){
			t0_cnt1=0;
			b10Hz=1;
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

	TIM4->SR1&=~TIM4_SR1_UIF;			// disable break interrupt
	return;
}

//***********************************************
@far @interrupt void UARTTxInterrupt (void) {

	if (tx_counter){
		--tx_counter;
		UART1->DR=tx_buffer[tx_rd_index];
		if (++tx_rd_index == TX_BUFFER_SIZE) tx_rd_index=0;
	}
	else {
		bOUT_FREE=1;
		UART1->CR2&= ~UART1_CR2_TIEN;
	}
}

//***********************************************
@far @interrupt void UARTRxInterrupt (void) {

	//char status=0,data=0;
	
	//GPIOD->ODR^=(1<<4);
	rx_status=UART1->SR;
	rx_data=UART1->DR;
	
	if (rx_status & (UART1_SR_RXNE)){
		rx_buffer[rx_wr_index]=rx_data;
		bRXIN=1;
		if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
		if (++rx_counter == RX_BUFFER_SIZE){
			rx_counter=0;
			rx_buffer_overflow=1;
		}
	}
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
	
	FLASH_DUKR=0xae;
	FLASH_DUKR=0x56;
	
	//GPIOD->DDR|=(1<<5);
	//GPIOD->CR1=0xff;
	//GPIOD->CR2=0;
	
	
	uart_init();
	
	enableInterrupts();	
	
	while (1){
		
		if(bBUFF_LOAD) {
			bBUFF_LOAD=0;
		//GPIOD->ODR^=(1<<4);
			if(current_page<last_page) {
				current_page++;
				
			}
			else {
				current_page=0;
				play=0;
			}	
			
			DF_page_to_buffer(/*///current_buffer_H*//*1,*/current_page);
		}
	
		if(bBUFF_READ_L) {
			bBUFF_READ_L=0;

			DF_buffer_read(/*///current_buffer_L*//*1,*/0,128,buff);
		}	

		if(bBUFF_READ_H) {
			bBUFF_READ_H=0;
			DF_buffer_read(/*///current_buffer_L*//*1,*/128,128,&buff[128]);
		}			
				
		if(bRXIN)	{
			bRXIN=0;
			
			uart_in();
		} 	
		
		
		if(b100Hz){
			b100Hz=0;

			if(bSTART==1) {
				if(play) {
					play=0;
					bSTART=0;
				}
				else {
					current_page=0;
					last_page=EE_PAGE_LEN-5;
          
					DF_page_to_buffer(/*///current_buffer_H*//*1,*/current_page);
					delay_ms(10);
					DF_buffer_read(/*///current_buffer_L*//*1,*/0,128,buff);
					delay_ms(10);
					DF_buffer_read(/*///current_buffer_L*//*1,*/128,128,&buff[128]);         
          
					play=1;
					bSTART=0;
          	
					rele_cnt=10;//rele_cnt_const[rele_cnt_index];
				}
			}
      	}  
      	
		if(b10Hz){
			b10Hz=0;
			
			rele_drv();
      	}
      	
		if(b5Hz){
			b5Hz=0;
		//GPIOD->ODR^=(1<<4);
		}
      	
		if(b1Hz){
			long temp_L;
			b1Hz=0;
			//temp_L=DF_mf_dev_read();
			//buff[0]++;
			//uart_out (6,0x11,*((char*)&temp_L),*(((char*)&temp_L)+1),*(((char*)&temp_L)+2),*(((char*)&temp_L)+3),DF_status_read());
			//uart_out_adr (&t0_cnt0, 65);
			//aaa++;
			
		
      	}
	}
}