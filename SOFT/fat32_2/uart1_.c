#include "stm8s.h"
#include "uart1.h"
#include "main.h"
#include "cmd.c"

//char UIB[10]={0,0,0,0,0,0,0,0,0,0};
//@near char UOB[40]={0};
#ifdef _wrk_
char bOUT_FREE=0;
#endif
/*@near*/ 
#ifdef _wrk_
char UIB[80]={0,0,0,0,0,0,0,0,0,0};
#endif

#ifdef _wrk_
@near unsigned char tx_wr_index=0,tx_rd_index=0,tx_counter=0;
@near unsigned char rx_wr_index=0,rx_rd_index=0,rx_counter=0;
#endif
//char tx_buffer[TX_BUFFER_SIZE]={0};
//char bRXIN=0;
//char flag=0;
#ifdef _wrk_
char rx_buffer[RX_BUFFER_SIZE]={0};
#endif
#ifdef _wrk_
@near char rx_buffer_overflow=0;
#endif
#ifdef _wrk_
//-----------------------------------------------
void uart_init (void){
	UART1->CR1&=~UART1_CR1_M;					
	UART1->CR3|= (0<<4) & UART1_CR3_STOP;	
	UART1->BRR2= 0x01;//0x03;
	UART1->BRR1= 0x1a;//0x68;
	UART1->CR2|= UART1_CR2_TEN | UART3_CR2_REN | UART3_CR2_RIEN;	
}
#endif

#ifdef _wrk_
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
#endif
/*
//-----------------------------------------------
void uart_out_adr (char *ptr, char len)
{
char i11=0,temp11=0,t=0;
t=0;
temp11=0;


for(i11=0;i11<len;i11++)
	{
	temp11=ptr[i11];
	t^=temp11;
	putchar(temp11);
	}
	
putchar(len);
t^=len;
putchar(t);

putchar(0x0a);
	
bOUT_FREE=0;
	   
}
*/

#ifdef _wrk_
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

temp11=(*((char*)&adress));
t^=temp11;
putchar(temp11);

temp11=(*(((char*)&adress)+1));
t^=temp11;
putchar(temp11);

temp11=(*(((char*)&adress)+2));
t^=temp11;
putchar(temp11);

temp11=(*(((char*)&adress)+3));
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
#endif 

#ifdef _wrk_
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
#endif 

//-----------------------------------------------
#ifdef _COSMIC_
@far @interrupt void UARTTxInterrupt (void) {
#else
void UARTTxInterrupt (void) interrupt 17 {
#endif

#ifdef _wrk_	
	
	if (tx_counter){
		--tx_counter;
		UART1->DR=tx_buffer[tx_rd_index];
		if (++tx_rd_index == TX_BUFFER_SIZE) tx_rd_index=0;
	}
	else {
		bOUT_FREE=1;
		UART1->CR2&= ~UART1_CR2_TIEN;
	}
#endif	
}
/*
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
//goto end_cc;
error_cc:
return 0;
//goto end_cc;

//end_cc:
//return 0;
}

//-----------------------------------------------
char index_offset (signed char index,signed char offset)
{
index=index+offset;
if(index>=RX_BUFFER_SIZE) index-=RX_BUFFER_SIZE; 
if(index<0) index+=RX_BUFFER_SIZE;
return index;
}
*/
#ifdef _wrk_
//-----------------------------------------------
void uart_in(void)
{
char temp,i,count;
//#asm("cli")
disableInterrupts();
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
    temp=rx_buffer[index_offset(rx_wr_index,-3)];
    	if(temp<100) 
    		{
    		if(control_check(index_offset(rx_wr_index,-1)))
    			{
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
enableInterrupts();
} 
#endif

//-----------------------------------------------
#ifdef _COSMIC_
@far @interrupt void UARTRxInterrupt (void) {
#else
void UARTRxInterrupt (void) interrupt 18 {
#endif
	char status=0,data=0;
#ifdef _wrk_	
	
	//GPIOD->ODR^=(1<<4);
	status=UART1->SR;
	data=UART1->DR;
	
	if (status & (UART1_SR_RXNE)){
		rx_buffer[rx_wr_index]=data;
		bRXIN=1;
		if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
		if (++rx_counter == RX_BUFFER_SIZE){
			rx_counter=0;
			rx_buffer_overflow=1;
		}
	}
#endif
}

