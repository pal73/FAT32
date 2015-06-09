#define TX_BUFFER_SIZE 30
#define RX_BUFFER_SIZE 10

extern char UIB[10];
extern char UOB[40];
extern char bOUT_FREE;
extern char tx_buffer[TX_BUFFER_SIZE];
extern unsigned char tx_wr_index,tx_rd_index,tx_counter;
extern char bRXIN;
extern char flag;
extern char rx_buffer[RX_BUFFER_SIZE];
extern unsigned char rx_wr_index,rx_rd_index,rx_counter;
extern char rx_buffer_overflow;

//-----------------------------------------------
void uart_init (void);
//-----------------------------------------------
void uart_out (char num,char data0,char data1,char data2,char data3,char data4,char data5);
//-----------------------------------------------
void uart_out_adr (char *ptr, char len);
//-----------------------------------------------
void putchar(char c);
//-----------------------------------------------
#ifdef _COSMIC_
@far @interrupt void UARTTxInterrupt (void);
#else
void UARTTxInterrupt (void) interrupt 20 ;
#endif
//-----------------------------------------------
#ifdef _COSMIC_
@far @interrupt void UARTRxInterrupt (void);
#else
void UARTRxInterrupt (void) interrupt 21;
#endif
