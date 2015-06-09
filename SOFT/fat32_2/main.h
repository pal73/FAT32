

void t2_init(void);
void t4_init(void);
void rele_drv(void);
long delay_ms(short in);
@far @interrupt void TIM4_UPD_Interrupt (void);
void uart_out (char num,char data0,char data1,char data2,char data3,char data4,char data5);
void uart_out_adr_block (unsigned long adress,char *ptr, char len);
void putchar(char c);
@far @interrupt void UARTTxInterrupt (void);
@far @interrupt void UARTRxInterrupt (void);
void uart_init (void);
long DF_mf_dev_read(void);
void DF_memo_to_256(void);
char DF_status_read(void);
void DF_buffer_read(unsigned buff_addr,unsigned len, char* adr);
void DF_buffer_write(/*char buff,*/unsigned buff_addr,unsigned len, char* adr);
void DF_page_to_buffer(unsigned page_addr);
void DF_buffer_to_page_er(/*char buff,*/unsigned page_addr);
char spi(char in);
void spi_init(void);
void gpio_init(void);
void uart_in(void);
char index_offset (signed char index,signed char offset);
char control_check(char index);
void uart_in_an(void);

