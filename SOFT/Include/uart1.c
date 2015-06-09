#include "stm8s.h"
#include "uart1.h"
#include "cmd.c"

char UIB[10]={0,0,0,0,0,0,0,0,0,0};
char UOB[40]={0};
char bOUT_FREE=0;

unsigned char tx_wr_index=0,tx_rd_index=0,tx_counter=0;
char tx_buffer[TX_BUFFER_SIZE]={0};
char bRXIN=0;
char flag=0;
char rx_buffer[RX_BUFFER_SIZE]={0};
unsigned char rx_wr_index=0,rx_rd_index=0,rx_counter=0;
char rx_buffer_overflow=0;

//-----------------------------------------------
void uart_init (void){
	UART1->CR1&=~UART1_CR1_M;					
	UART1->CR3|= (0<<4) & UART1_CR3_STOP;	
	UART1->BRR2= 0x03;
	UART1->BRR1= 0x68;
	UART1->CR2|= UART1_CR2_TEN;	
}

//-----------------------------------------------
void uart_out (char num,char data0,char data1,char data2,char data3,char data4,char data5){
	char i=0,t=0;
 
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

//-----------------------------------------------
void putchar(char c)
{
while (tx_counter == TX_BUFFER_SIZE);
///#asm("cli")
if (tx_counter || ((UART1->SR & UART1_SR_TXE)==0))
   {
//   tx_buffer[tx_wr_index]=c;
   if (++tx_wr_index == TX_BUFFER_SIZE) tx_wr_index=0;
   ++tx_counter;
   }
else UART1->DR=c;

UART1->CR2|= UART1_CR2_TIEN;
///#asm("sei")
}

//-----------------------------------------------
#ifdef _COSMIC_
@far @interrupt void UARTTxInterrupt (void) {
#else
void UARTTxInterrupt (void) interrupt 20 {
#endif
	if (tx_counter){
		--tx_counter;
//		UART1->DR=tx_buffer[tx_rd_index];
		if (++tx_rd_index == TX_BUFFER_SIZE) tx_rd_index=0;
	}
	else {
		bOUT_FREE=1;
		UART1->CR2&= ~UART1_CR2_TIEN;
	}	
}

//-----------------------------------------------
#ifdef _COSMIC_
@far @interrupt void UARTRxInterrupt (void) {
#else
void UARTRxInterrupt (void) interrupt 21 {
#endif

	char status=0,data=0;
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
}

