
#ifdef _wrk_
@near extern bool b100Hz,b10Hz,b5Hz,b1Hz;
@near extern char t0_cnt0,t0_cnt1,t0_cnt2,t0_cnt3;
#endif
#ifdef _wrk_
@near extern long file_lengt;
@near extern unsigned short file_lengt_in_pages,current_page,last_page,current_byte_in_buffer;
@near extern bool bSTART;
#endif
#ifdef _wrk_
@near extern char buff[256];
#endif
#ifdef _wrk_
@near extern char rx_plazma;


@eeprom extern char aaa;
#endif
///extern @eeprom char tyu;

char spi(char in);
long delay_ms(short in);
long DF_mf_dev_read(void);
void DF_memo_to_256(void);
char DF_status_read(void);
void DF_page_to_buffer(unsigned page_addr);
void DF_buffer_to_page_er(unsigned page_addr);
void DF_buffer_read(unsigned buff_addr,unsigned len, char* adr);
void DF_buffer_write(unsigned buff_addr,unsigned len, char* adr);
void DF_buffer_to_page(unsigned page_addr);
void gpio_init(void);
void t2_init(void);
void spi_init(void);
char spi(char in);
void t4_init(void);
char index_offset (signed char index,signed char offset);
char control_check(char index);

#ifdef _COSMIC_
@far @interrupt void TIM4_UPD_Interrupt (void);
#else
void TIM4_UPD_Interrupt (void) interrupt 23 ;
#endif


