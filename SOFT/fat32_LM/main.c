//#define ATMEL
//#define ST
#define LAMPA_MAGNITOFON
//#define LAMPA15
//#define SIMPLE_PROGRAM
#include "stm8s.h"
#include "main.h"
#include "cmd.c"
#include <iostm8s103.h>

#define CS_ON	GPIOC->ODR&=~(1<<3);
#define CS_OFF	GPIOC->ODR|=(1<<3);
#define ST_CS_ON	GPIOB->ODR&=~(1<<5);
#define ST_CS_OFF	GPIOB->ODR|=(1<<5);
#define TX_BUFFER_SIZE	80
#define RX_BUFFER_SIZE	100

char t0_cnt0=0,t0_cnt1=0,t0_cnt2=0,t0_cnt3=0;
signed short sample_cnt;
char tx_buffer[TX_BUFFER_SIZE]={0};
signed char tx_counter;
signed char tx_wr_index,tx_rd_index;
char rx_buffer[RX_BUFFER_SIZE]={0};
signed short rx_counter;
signed short rx_wr_index,rx_rd_index;
char sample;
char but_drv_cnt=0;
char but_on_drv_cnt=0;
char mdr0,mdr1,mdr2,mdr3;
unsigned int file_lengt_in_pages,current_page,last_page,current_byte_in_buffer;
unsigned long file_lengt;
char rx_status;
char rx_data;
signed short rele_cnt;
char rx_offset;
unsigned char pwm_fade_in=0;
unsigned char rele_cnt_index=0;
const char rele_cnt_const[]={30,50,70};
char memory_manufacturer='S';
short but_block_cnt;
_Bool bSTART;
_Bool bBUFF_LOAD;
_Bool bBUFF_READ_H;
_Bool bBUFF_READ_L;
_Bool b100Hz, b10Hz, b5Hz, b1Hz;
_Bool play;
_Bool bOUT_FREE;
_Bool bRXIN;
_Bool rx_buffer_overflow;
_Bool bRELEASE;
@near char dumm[100];
@near char buff[300];
@near char UIB[80];

@eeprom unsigned short EE_PAGE_LEN;
_Bool bERASE_IN_PROGRESS;
_Bool bSTART_DOWNLOAD;
char current_page_cnt;
char current_page_cnt_;

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
	TIM2->CCR3L= 50;
	
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
void rele_drv(void)
{
if(play) 
	{
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
	GPIOD->DDR|=(1<<5);
	GPIOD->CR1|=(1<<5);
	GPIOD->CR2|=(1<<5);
	//GPIOD->ODR|=(1<<5);	

	GPIOD->DDR&=~(1<<6);
	GPIOD->CR1&=~(1<<6);
	GPIOD->CR2&=~(1<<6);
	//GPIOD->ODR|=(1<<6);	
	
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
void uart_in_an(void) 
{
char temp_char,r1;

if(UIB[0]==CMND) 
	{
	if(UIB[1]==1) 
		{
		long temp_L;
		//GPIOD->ODR^=(1<<4);
		//GPIOD->ODR^=(1<<4);
		if(memory_manufacturer=='A') 
			{
			temp_L=DF_mf_dev_read();
			}
		if(memory_manufacturer=='S') 
			{
			temp_L=ST_RDID_read();
			}
		uart_out (6,CMND,1,mdr0/**((char*)&temp_L)*/,mdr1/**(((char*)&temp_L)+1)*/,mdr2/**(((char*)&temp_L)+2)*/,mdr3/**(((char*)&temp_L)+3)*/);
			//delay_ms(100);
			//putchar(0x19);
			//delay_ms(100);
			//rele_cnt=10;
		} 

		
	else if(UIB[1]==2) {
		char temp;
		//GPIOD->ODR^=(1<<4);
		if(memory_manufacturer=='A') {
			temp=DF_status_read();
		}
		if(memory_manufacturer=='S') {
			temp=ST_status_read();
		}
		//if(bERASE_IN_PROGRESS)temp|=0x80;
		uart_out (3,CMND,2,temp,0,0,0);    
		} 
	
		
	else if(UIB[1]==3)
		{
		char temp;
		if(memory_manufacturer=='A') {
			DF_memo_to_256();
		}
		uart_out (2,CMND,3,temp,0,0,0);    
		}				
		
	else if(UIB[1]==4)
		{
		char temp;
		if(memory_manufacturer=='A') {
			DF_memo_to_256();
		}
		uart_out (2,CMND,3,temp,0,0,0);    
		}				

	else if(UIB[1]==10)
		{
		char temp;
//		DF_page_to_buffer(2,0);
		if(memory_manufacturer=='A') {
			if(UIB[2]==1)DF_buffer_read(/*1,*/0,256, buff);
	    /*	else if(UIB[2]==2)DF_buffer_read(2,0,256, buff);*/
		}
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
          
		if(memory_manufacturer=='A') {	
			DF_page_to_buffer(/*UIB[2],*/UIB[3]);
		}
		if(memory_manufacturer=='S') {
			current_page=11;
			ST_READ((long)(current_page*256),256, buff);
					
			uart_out_adr_block (0,buff,64);
			delay_ms(100);    
			uart_out_adr_block (64,&buff[64],64);
			delay_ms(100);    
			uart_out_adr_block (128,&buff[128],64);
			delay_ms(100);    
			uart_out_adr_block (192,&buff[192],64);
			delay_ms(100); 
		}
		}					
	else if(UIB[1]==14)
		{
		char temp;
		unsigned i;
          
		if(memory_manufacturer=='A') {	
			DF_buffer_to_page_er(/*UIB[2],*/UIB[3]);
		}
		if(memory_manufacturer=='S') {
			for(i=0;i<256;i++) {
				buff[i]=(char)i;
			}
			current_page=11;
			ST_WREN();
			delay_ms(100);
			ST_WRITE((long)(current_page*256),256,buff);		
		}
	
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
		if(memory_manufacturer=='S') 
			{
			ST_WREN();
			delay_ms(100);
			ST_bulk_erase();
			bSTART_DOWNLOAD=1;
			}
			
		//uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
			
		}
	else if(UIB[1]==21)
		{
		char temp;
		unsigned i;
        		
		if(current_page_cnt_)
			{
			current_page_cnt_--;
			if(current_page_cnt_==0)
				{
				current_page_cnt=0;	
				}
			}
		else 
			{
			current_page_cnt=0;
			}
						
		for(i=0;i<64;i++)
          	{
          	buff[current_byte_in_buffer+i]=UIB[2+i];
          	}                                       
          current_byte_in_buffer+=64;
          if(current_byte_in_buffer>=256)
          	{
          	
   /*      	for(i=0;i<256;i++)
          	{
          	buff[i]=(char)i;
          	} */  
          	
			if(memory_manufacturer=='A') {
				DF_buffer_write(/*//current_buffer*//*1,*/0,256,buff);
				DF_buffer_to_page_er(/*///current_buffer*//*1,*/current_page);
				current_page++;
				if(current_page<file_lengt_in_pages)
					{ 
					delay_ms(100);
					uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
					current_byte_in_buffer=0;
					}
				else 
					{
					EE_PAGE_LEN=current_page;
					}
			}
			if(memory_manufacturer=='S') {
				ST_WREN();
				delay_ms(100);
				ST_WRITE((unsigned long)(current_page*256UL),256,buff);
				current_page++;
				if(current_page<file_lengt_in_pages)
					{ 
					delay_ms(100);
					uart_out (5,CMND,21,current_page%256,current_page/256,0,0);
					current_page_cnt=10;
					current_page_cnt_=4;
					current_byte_in_buffer=0;
					}
				else 
					{
					EE_PAGE_LEN=current_page;
					}
			
			}
          	}	
          		

			
		}


	else if(UIB[1]==24) {
		char temp;
		
		rele_cnt=10;
		ST_WREN();
		delay_ms(100);
		ST_bulk_erase();

		//uart_out (3,CMND,2,temp,0,0,0);    
		} 

	else if(UIB[1]==25)
		{

		short i__;
		current_page=0;
		
		for(i__=0;i__<EE_PAGE_LEN;i__++)
			{
			if(memory_manufacturer=='S') {	
				DF_page_to_buffer(i__);
				delay_ms(100);			
				DF_buffer_read(0,256, buff);
			}

			if(memory_manufacturer=='S') {	
				ST_READ((long)(i__*256),256, buff);
			}
			
			uart_out_adr_block ((256*i__)+0,buff,64);
			delay_ms(100);    
			uart_out_adr_block ((256*i__)+64,&buff[64],64);
			delay_ms(100);    
			uart_out_adr_block ((256*i__)+128,&buff[128],64);
			delay_ms(100);    
			uart_out_adr_block ((256*i__)+192,&buff[192],64);
			delay_ms(100);   
			}


			
		}

	else if(UIB[1]==26)		//Запрос телеметрии
		{
		char temp;
		uart_out (4,CMND,26,current_page_cnt,current_page_cnt_,0,0);    
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
	else if(UIB[1]==81)
		{
		char temp;
		unsigned i;
		unsigned long adress;
          
		if(memory_manufacturer=='A') 
			{	
			DF_page_to_buffer(/*UIB[2],*/UIB[3]);
			}
			
		/*if(memory_manufacturer=='S') 
			{*/
			
			adress=UIB[5];
			adress<<=8;
			adress+=UIB[4];
			adress<<=8;
			adress+=UIB[3];
			adress<<=8;
			adress+=UIB[2];
			
			ST_READ(adress,256, buff);
			
		/*for(i=0;i<256;i++)
			{
			buff[i]=i;
			}*/	
		
		/*buff[0]=UIB[2];
		buff[1]=UIB[3];
		buff[2]=UIB[4];
		buff[3]=UIB[5];*/
		
		uart_out_adr_block (0,buff,64);
		delay_ms(100);    
		uart_out_adr_block (64,&buff[64],64);
		delay_ms(100);    
		uart_out_adr_block (128,&buff[128],64);
		delay_ms(100);    
		uart_out_adr_block (192,&buff[192],64);
		delay_ms(100);


			
		}	
		
	else if(UIB[1]==91)
		{
		char temp;
		unsigned i;
          unsigned long adress;
		
		if(memory_manufacturer=='A') 
			{	
			DF_buffer_to_page_er(/*UIB[2],*/UIB[3]);
			}
		if(memory_manufacturer=='S') 
			{
			for(i=0;i<256;i++) 
				{
				buff[i]=(char)i;
				}
			adress=UIB[5];
			adress<<=8;
			adress+=UIB[4];
			adress<<=8;
			adress+=UIB[3];
			adress<<=8;
			adress+=UIB[2];
			
			ST_WREN();
			delay_ms(100);
			ST_WRITE(adress,256,buff);		
			}
	
		}

	else if(UIB[1]==92)
		{
		char temp;
		unsigned i;
          unsigned long adress;
		
		if(memory_manufacturer=='A') 
			{	
			DF_buffer_to_page_er(/*UIB[2],*/UIB[3]);
			}
		if(memory_manufacturer=='S') 
			{
			for(i=0;i<128;i++) 
				{
				buff[i]=(char)(i*2);
				}
			for(i=0;i<128;i++) 
				{
				buff[i+128]=(char)(255-(i*2));
				}				
			adress=UIB[5];
			adress<<=8;
			adress+=UIB[4];
			adress<<=8;
			adress+=UIB[3];
			adress<<=8;
			adress+=UIB[2];
			
			ST_WREN();
			delay_ms(100);
			ST_WRITE(adress,256,buff);		
			}
	
		}
		
	else if(UIB[1]==93)
		{
		char temp;
		unsigned i;
          unsigned long adress;
		
		if(memory_manufacturer=='A') 
			{	
			DF_buffer_to_page_er(/*UIB[2],*/UIB[3]);
			}
		if(memory_manufacturer=='S') 
			{
			for(i=0;i<256;i++) 
				{
				buff[i]=(char)(255-i);
				}
			adress=UIB[5];
			adress<<=8;
			adress+=UIB[4];
			adress<<=8;
			adress+=UIB[3];
			adress<<=8;
			adress+=UIB[2];
			
			ST_WREN();
			delay_ms(100);
			ST_WRITE(adress,256,buff);		
			}
	
		}		

	else if(UIB[1]==100) 
		{
		char temp;
		
		rele_cnt=10;
		ST_WREN();
		delay_ms(100);
		ST_bulk_erase();

		//uart_out (3,CMND,2,temp,0,0,0);    
		} 
		
	else if(UIB[1]==101) 
		{
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

	GPIOA->DDR|=(1<<3);
	GPIOA->CR1|=(1<<3);
	GPIOA->CR2&=~(1<<3);
	GPIOA->ODR|=(1<<3);	


	GPIOB->DDR|=(1<<5);
	GPIOB->CR1|=(1<<5);
	GPIOB->CR2&=~(1<<5);
	GPIOB->ODR|=(1<<5);	

	GPIOC->DDR|=(1<<3);
	GPIOC->CR1|=(1<<3);
	GPIOC->CR2&=~(1<<3);
	GPIOC->ODR|=(1<<3);	
	
	GPIOC->DDR|=(1<<5);
	GPIOC->CR1|=(1<<5);
	GPIOC->CR2|=(1<<5);
	GPIOC->ODR|=(1<<5);	
	
	GPIOC->DDR|=(1<<6);
	GPIOC->CR1|=(1<<6);
	GPIOC->CR2|=(1<<6);
	GPIOC->ODR|=(1<<6);	

	GPIOC->DDR&=~(1<<7);
	GPIOC->CR1&=~(1<<7);
	GPIOC->CR2&=~(1<<7);
	GPIOC->ODR|=(1<<7);	
	
	SPI->CR1= /*SPI_CR1_LSBFIRST |*/
			SPI_CR1_SPE | 
			( (4<< 3) & SPI_CR1_BR ) |
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
long ST_RDID_read(void)
{
char d0,d1,d2,d3;

d0=0;
d1=0;
d2=0;
d3=0;
//GPIOD->ODR&=~(1<<2);
ST_CS_ON
spi(0x9f);
mdr0=spi(0xff);
mdr1=spi(0xff);
mdr2=spi(0xff);
mdr3=spi(0xff);
 
//GPIOD->ODR|=(1<<2); 
ST_CS_OFF
return  *((long*)&d0);
}

//-----------------------------------------------
char ST_status_read(void)
{
char d0;

//GPIOD->ODR&=~(1<<2);
ST_CS_ON
spi(0x05);
d0=spi(0xff);
//GPIOD->ODR|=(1<<2);
ST_CS_OFF
return d0;
}

//-----------------------------------------------
void ST_bulk_erase(void)
{
ST_CS_ON
spi(0xC7);

//GPIOD->ODR|=(1<<2);
bERASE_IN_PROGRESS=1;
uart_out (3,CMND,44,33,0,0,0);
ST_CS_OFF
}
//-----------------------------------------------
void ST_WREN(void)
{
//GPIOD->ODR&=~(1<<2);
ST_CS_ON
spi(0x06);
//GPIOD->ODR|=(1<<2);
ST_CS_OFF
}  

//-----------------------------------------------
void ST_WRITE(unsigned long memo_addr,unsigned short len, char* adr)
{
unsigned short i;
char adr0,adr1,adr2;

adr2=(char)(memo_addr>>16);
adr1=(char)((memo_addr>>8)&0x00ff);
adr0=(char)((memo_addr)&0x00ff);
ST_CS_ON
//spi(0x0a);
spi(0x02);
spi(adr2);
spi(adr1);
spi(adr0);

for(i=0;i<len;i++)
	{
	spi(adr[i]);
	}
//GPIOD->ODR|=(1<<2);
ST_CS_OFF
}

//-----------------------------------------------
void ST_READ(unsigned long memo_addr,unsigned short len, char* adr)
{
unsigned short i;
char adr0,adr1,adr2;



adr2=(char)(memo_addr>>16);
adr1=(char)((memo_addr>>8)&0x00ff);
adr0=(char)((memo_addr)&0x00ff);
ST_CS_ON
spi(0x03);
spi(adr2);
spi(adr1);
spi(adr0);

for(i=0;i<len;i++)
	{
	adr[i]=spi(0xff);
	}
//GPIOD->ODR|=(1<<2);
ST_CS_OFF
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
	GPIOD->DDR|=(1<<2);
	GPIOD->CR1|=(1<<2);
	GPIOD->CR2|=(1<<2);
	GPIOD->ODR&=~(1<<2);

	GPIOD->DDR|=(1<<4);
	GPIOD->CR1|=(1<<4);
	GPIOD->CR2&=~(1<<4);

	GPIOC->DDR&=~(1<<4);
	GPIOC->CR1&=~(1<<4);
	GPIOC->CR2&=~(1<<4);
	
	

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
	//rx_offset++;
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
			
			/*if(UIB[1]==21)
				{
					char i;
				for(i=0;i<64;i++)
					{
						UIB[2+i]=rx_offset;
					}
				}*/
			uart_in_an();
/**/
    			}
 	
    		} 
    	}	

//#asm("sei") 
//enableInterrupts();
}

//-----------------------------------------------
signed short index_offset (signed short index,signed short offset)
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
@far @interrupt void TIM4_UPD_Interrupt (void) 
{
if(play) 
	{
	TIM2->CCR3H= 0x00;	
	TIM2->CCR3L= sample;
	sample_cnt++;
	if(sample_cnt>=256) 
		{
		sample_cnt=0;
		}
	
	sample=buff[sample_cnt];
		
	if(sample_cnt==132)	
		{
		bBUFF_LOAD=1;
		}

	if(sample_cnt==5) 
		{
		bBUFF_READ_H=1;
    }
    	
	if(sample_cnt==150) 
		{
		bBUFF_READ_L=1;
    } 
	}

else if(!bSTART) 
	{
	TIM2->CCR3H= 0x00;	
	TIM2->CCR3L= 0x7f;//pwm_fade_in;
	}

	
	
	
#ifdef OLD_BUT	
if(((GPIOC->IDR)&(1<<4))) 
	{
	but_on_drv_cnt++;
	}
else	
	{
	bRELEASE=1;
	}
	
but_drv_cnt++;
if(but_drv_cnt>20)
	{
	but_drv_cnt=0;
	if(but_on_drv_cnt>12) 
		{
		#ifdef LAMPA_MAGNITOFON
		if(!but_block_cnt)
			{
			bSTART=1;
				but_on_drv_cnt=0;
			}
		#endif
		}
	}
#endif	


if(but_block_cnt)but_on_drv_cnt=0;
if((((GPIOC->IDR)&(1<<4))) && (but_on_drv_cnt<100)) 
	{
	but_on_drv_cnt++;
	if((but_on_drv_cnt>2)&&(bRELEASE))
		{
		bRELEASE=0;
		bSTART=1;
		}
	}
else 
	{
	but_on_drv_cnt=0;
	bRELEASE=1;
	}

if(++t0_cnt0>=125)
	{
  t0_cnt0=0;
  b100Hz=1;

	if(++t0_cnt1>=10)
		{
		t0_cnt1=0;
		b10Hz=1;
		}
		
	if(++t0_cnt2>=20)
		{
		t0_cnt2=0;
		b5Hz=1;
		}
		
	if(++t0_cnt3>=100)
		{
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
main()
{
CLK->CKDIVR=0;

rele_cnt_index=0;

GPIOD->DDR&=~(1<<6);
GPIOD->CR1|=(1<<6);
GPIOD->CR2|=(1<<6);
//GPIOD->ODR&=~(1<<6);
GPIOD->DDR|=(1<<5);
GPIOD->CR1|=(1<<5);
GPIOD->CR2|=(1<<5);	
GPIOD->ODR|=(1<<5);
	
delay_ms(10);
	
if(!(GPIOD->IDR&=(1<<6))) 
	{
	rele_cnt_index=1;
	}
else	
	{
	GPIOD->ODR&=~(1<<5);
	delay_ms(10);
	if(!(GPIOD->IDR&=(1<<6))) 
		{
		rele_cnt_index=2;
		}
	}
		
gpio_init();
//delay_ms(100);
//delay_ms(100);
//delay_ms(100);
//delay_ms(100);
//delay_ms(100);
	
spi_init();
	
t4_init();
	
FLASH_DUKR=0xae;
FLASH_DUKR=0x56;
	
//GPIOD->DDR|=(1<<5);
//GPIOD->CR1=0xff;
//GPIOD->CR2=0;
dumm[1]++;

uart_init();

ST_RDID_read();
if(mdr0==0x20) memory_manufacturer='S';	
else 
	{
	DF_mf_dev_read();
	if(mdr0==0x1F) memory_manufacturer='A';
	}
		
t2_init();

ST_WREN();

enableInterrupts();	
	
while (1)
	{
			
	if(bBUFF_LOAD)
		{
		bBUFF_LOAD=0;
		//GPIOD->ODR^=(1<<4);
		if(current_page<last_page)
			{
			current_page++;
			}
		else 
			{
			current_page=0;
			play=0;
			}	
		if(memory_manufacturer=='A')
			{
			DF_page_to_buffer(/*///current_buffer_H*//*1,*/current_page);
			}
		}
		
	if(bBUFF_READ_L)
		{
		bBUFF_READ_L=0;
		if(memory_manufacturer=='A')
			{
			DF_buffer_read(/*///current_buffer_L*//*1,*/0,128,buff);
			}
		if(memory_manufacturer=='S')
			{
			ST_READ((unsigned long)((unsigned long)(current_page*256UL)),128,buff);
			}
		}	
	
	if(bBUFF_READ_H) 
		{
		bBUFF_READ_H=0;
		if(memory_manufacturer=='A') 
			{
			DF_buffer_read(/*///current_buffer_L*//*1,*/128,128,&buff[128]);
			}
		if(memory_manufacturer=='S') 
			{
			ST_READ((unsigned long)((unsigned long)(current_page*256UL)+128UL),128,&buff[128]);
			}
		}			
					
	if(bRXIN)
		{
		bRXIN=0;
		
		uart_in();
		} 	
			
			
	if(b100Hz)
		{
		b100Hz=0;
				
		if(but_block_cnt)but_block_cnt--;
				
		if(bSTART==1) 
			{
			if(play) 
				{
				#ifdef LAMPA_MAGNITOFON
				if(!but_block_cnt)
					{
					play=0;
					bSTART=0;
					but_block_cnt=50;
					}
				#endif
				bSTART=0;
				}
			else 
			#ifdef LAMPA_MAGNITOFON
			if(!but_block_cnt)
			#endif
				{
				current_page=1;
				#ifdef LAMPA_MAGNITOFON
				last_page=6000;
				#ifdef LAMPA15
				last_page=933;
				#endif
				#endif
		
				if(memory_manufacturer=='A')
					{
					DF_page_to_buffer(/*///current_buffer_H*//*1,*/current_page);
					delay_ms(10);
					DF_buffer_read(/*///current_buffer_L*//*1,*/0,128,buff);
					delay_ms(10);
					DF_buffer_read(/*///current_buffer_L*//*1,*/128,128,&buff[128]);         
					}
				if(memory_manufacturer=='S') 
					{
					ST_READ(0,256,buff);
					}
				play=1;
				bSTART=0;
				
				rele_cnt=rele_cnt_const[rele_cnt_index];
				#ifdef LAMPA_MAGNITOFON
				but_block_cnt=50;
				#endif					
				}
			}
		}  
			
	if(b10Hz)
		{
		b10Hz=0;
		
		rele_drv();
		pwm_fade_in++;
		if(pwm_fade_in>128)pwm_fade_in=128;

		if(current_page_cnt)
			{
			current_page_cnt--;
			if(!current_page_cnt)
				{
				uart_out (5,CMND,21,current_page%256,current_page/256,1,0);
				current_page_cnt=10;
				current_page_cnt_=4;
				current_byte_in_buffer=0;
				}
			}	

		}
			
	if(b5Hz)
		{
		b5Hz=0;
		
		//GPIOD->ODR^=(1<<4);
		//GPIOD->ODR^=(1<<4);
		}
			
	if(b1Hz)
		{
		long temp_L;
		b1Hz=0;
		
		//GPIOD->ODR^=(1<<4);
		//temp_L=DF_mf_dev_read();
		//buff[0]++;
		//uart_out (6,0x11,*((char*)&temp_L),*(((char*)&temp_L)+1),*(((char*)&temp_L)+2),*(((char*)&temp_L)+3),DF_status_read());
		//uart_out_adr (&t0_cnt0, 65);
		//aaa++;
		
		if((!bERASE_IN_PROGRESS)&&(bSTART_DOWNLOAD))
			{
			bSTART_DOWNLOAD=0;
			uart_out (4,CMND,21,current_page%256,current_page/256,0,0);
			current_page_cnt=10;
			current_page_cnt_=4;
			current_byte_in_buffer=0;
			}
		if(bERASE_IN_PROGRESS)
			{
			char temp;
			temp=ST_status_read();
			if((temp&0x01)==0)	
				{
				bERASE_IN_PROGRESS=0;
				//uart_out (3,CMND,33,0,0,0,0);
				//uart_out (3,CMND,2,temp,0,0,0);
				uart_out (3,CMND,33,33,0,0,0);
				}
			//uart_out (3,CMND,2,temp,0,0,0);	
			}
		//if(bERASE_IN_PROGRESS)uart_out (3,CMND,2,66,0,0,0);
		//else uart_out (3,CMND,2,55,0,0,0);
		}
	}
}