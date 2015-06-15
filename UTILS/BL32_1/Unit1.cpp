//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include "cmd.c"
#include "Unit1.h"
#include <stdio.h>
//---------------------------------------------------------------------------
#pragma package(smart_init)
//#pragma link "CPort"
//#pragma resource "*.dfm"
char UOB[1000];
TForm1 *Form1;
#define RX_BUFFER_SIZE 1000U
char rx_buffer[RX_BUFFER_SIZE];
signed int rx_wr_index,rx_rd_index,rx_counter;
BOOL bRXIN;
BOOL rx_buffer_overflow;
char UIB[150]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
unsigned char damp[10000000];
unsigned short damp_[128];

FILE *F;
AnsiString SName = "Неизвестен";
unsigned file_lengt;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TForm1::B1Click(TObject *Sender)
{

if(!(ComPort1->Connected))
{
try
    	{
     ComPort1->Port=ComboBox1->Text;

     ComPort1->BaudRate=br38400;
     ComPort1->DataBits=dbEight;
     ComPort1->Open();
	}
catch (...)
	{
     ShowMessage("Невозможно открыть порт");
     }
if(ComPort1->Connected)
    	{
     B1->Caption="Закрыть";
     }
}
else if(ComPort1->Connected)
{
try
    	{
     ComPort1->Close();
	}
catch (...)
	{
     ShowMessage("Невозможно закрыть порт");
     }
if(!(ComPort1->Connected))
    	{
     B1->Caption="Открыть";
     }
}	}
//---------------------------------------------------------------------------
void __fastcall TForm1::Button1Click(TObject *Sender)
{
Memo1->Clear();	
}
//---------------------------------------------------------------------------
void __fastcall TForm1::FormCreate(TObject *Sender)
{
ComboBox1->ItemIndex=2;
Memo1->Clear();
//ComboBox4->ItemIndex=0;
//ComboBox2->ItemIndex=0;
//ComboBox3->ItemIndex=0;
//mboBox6->ItemIndex=1;	
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Button2Click(TObject *Sender)
{
uart_out_out(3,CMND,1,0,0,0,0,0,0);
Memo1->Lines->Add("Проверка связи");
}
//---------------------------------------------------------------------------
//-----------------------------------------------
int index_offset (signed int index,signed int offset)
{
index=index+offset;
if(index>=RX_BUFFER_SIZE) index-=RX_BUFFER_SIZE;
if(index<0) index+=RX_BUFFER_SIZE;
return index;
}

//-----------------------------------------------
char control_check(int index)
{
int i=0,ii=0,iii;

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
}

//---------------------------------------------------------------------------

AnsiString long2str_h(unsigned long in)
{
const char DIGISYM[16]={'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
AnsiString outA;
char out[9];
char i;
//out="        ";

for(i=0;i<8;i++)
	{
     out[7-i]=DIGISYM[in%16];
     in/=16;
     }
out[8]=0;
outA=AnsiString(out);
//out[0]='a';
return outA;


}

//---------------------------------------------------------------------------

AnsiString char2str_h(unsigned char in)
{
const char DIGISYM[16]={'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
AnsiString outA;
char out[2];
char i;
//out="        ";

for(i=0;i<2;i++)
	{
     out[1-i]=DIGISYM[in%16];
     in/=16;
     }
out[2]=0;
outA=AnsiString(out);
//out[0]='a';
return outA;


}

//---------------------------------------------------------------------------
void __fastcall TForm1::out_adr_blok_to_page_err(char* ptr)
{
char i,t=0;
UOB[0]=CMND;
UOB[1]=21;
t= UOB[0]^UOB[1];
for (i=0;i<64;i++)
	{
     UOB[i+2]=ptr[i];
	t^=UOB[i+2];
	}
UOB[66]=66;
t^=UOB[66];
UOB[67]=~t;
UOB[68]=0x0a;

ComPort1->Write(UOB,69);
}

//---------------------------------------------------------------------------
void __fastcall TForm1::out_adr_blok_to_page(char* ptr)
{
char i,t=0;
UOB[0]=CMND;
UOB[1]=21;
t= UOB[0]^UOB[1];
for (i=0;i<64;i++)
	{
     UOB[i+2]=ptr[i];
	t^=UOB[i+2];
	}
UOB[66]=66;
t^=UOB[66];
UOB[67]=t;
UOB[68]=0x0a;

ComPort1->Write(UOB,69);
}

//---------------------------------------------------------------------------
void __fastcall TForm1::uart_out_out(unsigned short len, char data0, char data1, char data2, char data3, char data4, char data5, char data6, char data7)
{
char i,t=0;

UOB[0]=data0;
UOB[1]=data1;
UOB[2]=data2;
UOB[3]=data3;
UOB[4]=data4;
UOB[5]=data5;
UOB[6]=data6;
UOB[7]=data7;

for (i=0;i<len;i++)
	{
	t^=UOB[i];
	}

UOB[len]=len;
t^=UOB[len];
UOB[len+1]=t;
UOB[len+2]=END;

if(ComPort1->Connected)ComPort1->Write(UOB,len+3);



}

//-----------------------------------------------
void __fastcall TForm1::uart_in_an(void)
{
unsigned i;
i=0;

//plazma++;
if((UIB[0]==0x11))
	{
    	Memo1->Lines->Add(char2str_h(UIB[0])+"  "+char2str_h(UIB[1])+"  "+char2str_h(UIB[2])+"  "+char2str_h(UIB[3])+"  "+char2str_h(UIB[4])+"  "+char2str_h(UIB[5])+"  "+char2str_h(UIB[6]));

     }

else if((UIB[0]==CMND)&&(UIB[1]==1))    //проверка связи
        {
        //Memo1->Lines->Add("Ответ:");
    	Memo1->Lines->Add(char2str_h(UIB[2])+"  "+char2str_h(UIB[3])+"  "+char2str_h(UIB[4])+"  "+char2str_h(UIB[5])/*+"  "+char2str_h(UIB[6])*/);
        }

else if((UIB[0]==CMND)&&(UIB[1]==2))
	{
    	Memo1->Lines->Add(char2str_h(UIB[2]));

     }
else if((UIB[0]==CMND)&&(UIB[1]==3))
	{
    	Memo1->Lines->Add(char2str_h(UIB[2]));

     }
else if((UIB[0]==CMND)&&(UIB[1]==10))
	{
	unsigned int adress;
     adress=*((unsigned int*)&UIB[2]);
     if((adress&0x000001ff)==0) Memo1->Lines->Add("Сектор №"+IntToStr(adress>>9));
     Memo1->Lines->Add(long2str_h(adress)+"    "+char2str_h(UIB[6])+"  "+char2str_h(UIB[7])+"  "+char2str_h(UIB[8])+"  "+char2str_h(UIB[9])+"  "
     								   +char2str_h(UIB[10])+"  "+char2str_h(UIB[11])+"  "+char2str_h(UIB[12])+"  "+char2str_h(UIB[13])+"  "
                                                +char2str_h(UIB[14])+"  "+char2str_h(UIB[15])+"  "+char2str_h(UIB[16])+"  "+char2str_h(UIB[17])+"  "
                                                +char2str_h(UIB[18])+"  "+char2str_h(UIB[19])+"  "+char2str_h(UIB[20])+"  "+char2str_h(UIB[21])+"  "
                                                +UIB[6]+UIB[7]+UIB[8]+UIB[9]+UIB[10]+UIB[11]+UIB[12]+UIB[13]+UIB[14]+UIB[15]+UIB[16]+UIB[17]+UIB[18]+UIB[19]+UIB[20]+UIB[21]);

     Memo1->Lines->Add(long2str_h(adress+16)+"    "+char2str_h(UIB[22])+"  "+char2str_h(UIB[23])+"  "+char2str_h(UIB[24])+"  "+char2str_h(UIB[25])+"  "
     								   +char2str_h(UIB[26])+"  "+char2str_h(UIB[27])+"  "+char2str_h(UIB[28])+"  "+char2str_h(UIB[29])+"  "
                                                +char2str_h(UIB[30])+"  "+char2str_h(UIB[31])+"  "+char2str_h(UIB[32])+"  "+char2str_h(UIB[33])+"  "
                                                +char2str_h(UIB[34])+"  "+char2str_h(UIB[35])+"  "+char2str_h(UIB[36])+"  "+char2str_h(UIB[37])+"  "
                                                +UIB[22]+UIB[23]+UIB[24]+UIB[25]+UIB[26]+UIB[27]+UIB[28]+UIB[29]+UIB[30]+UIB[31]+UIB[32]+UIB[33]+UIB[34]+UIB[35]+UIB[36]+UIB[37]);

     Memo1->Lines->Add(long2str_h(adress+32)+"    "+char2str_h(UIB[38])+"  "+char2str_h(UIB[39])+"  "+char2str_h(UIB[40])+"  "+char2str_h(UIB[41])+"  "
     								   +char2str_h(UIB[42])+"  "+char2str_h(UIB[43])+"  "+char2str_h(UIB[44])+"  "+char2str_h(UIB[45])+"  "
                                                +char2str_h(UIB[46])+"  "+char2str_h(UIB[47])+"  "+char2str_h(UIB[48])+"  "+char2str_h(UIB[49])+"  "
                                                +char2str_h(UIB[50])+"  "+char2str_h(UIB[51])+"  "+char2str_h(UIB[52])+"  "+char2str_h(UIB[53])+"  "
                                                +UIB[38]+UIB[39]+UIB[40]+UIB[41]+UIB[42]+UIB[43]+UIB[44]+UIB[45]+UIB[46]+UIB[47]+UIB[48]+UIB[49]+UIB[50]+UIB[51]+UIB[52]+UIB[37]);

     Memo1->Lines->Add(long2str_h(adress+48)+"    "+char2str_h(UIB[54])+"  "+char2str_h(UIB[55])+"  "+char2str_h(UIB[56])+"  "+char2str_h(UIB[57])+"  "
     								   +char2str_h(UIB[58])+"  "+char2str_h(UIB[59])+"  "+char2str_h(UIB[60])+"  "+char2str_h(UIB[61])+"  "
                                                +char2str_h(UIB[62])+"  "+char2str_h(UIB[63])+"  "+char2str_h(UIB[64])+"  "+char2str_h(UIB[65])+"  "
                                                +char2str_h(UIB[66])+"  "+char2str_h(UIB[67])+"  "+char2str_h(UIB[68])+"  "+char2str_h(UIB[69])+"  "
                                                +UIB[54]+UIB[55]+UIB[56]+UIB[57]+UIB[58]+UIB[59]+UIB[60]+UIB[61]+UIB[62]+UIB[63]+UIB[64]+UIB[65]+UIB[66]+UIB[67]+UIB[68]+UIB[69]);

     }



if((UIB[0]==CMND)&&(UIB[1]==21))
	{
     short i;

  /*   for(i=0;i<128;i++)
     	{
          damp_[i]=i<<3;
          }

	Memo1->Lines->Add("Запрос страницы " + IntToStr(*((short*)&UIB[2])));
     out_adr_blok_to_page((char*)&damp_[ 0 ] );
     Sleep(100);
     out_adr_blok_to_page( (char*)&damp_[ 32 ]);
     Sleep(100);
     out_adr_blok_to_page( (char*)&damp_[ 64 ]);
     Sleep(100);
     out_adr_blok_to_page( (char*)&damp_[ 96 ]);   */



     Memo1->Lines->Add("Запрос страницы " + IntToStr(*((short*)&UIB[2])));
     out_adr_blok_to_page( &damp[ (*((short*)&UIB[2]))*256 ] );
     Sleep(20);
     out_adr_blok_to_page( &damp[ ((*((short*)&UIB[2]))*256)+64 ]);
     Sleep(20);
     out_adr_blok_to_page( &damp[ ((*((short*)&UIB[2]))*256)+128 ]);
     Sleep(20);
     out_adr_blok_to_page( &damp[ ((*((short*)&UIB[2]))*256)+192 ]); 
     }

if((UIB[0]==CMND)&&(UIB[1]==11))
	{
     if(UIB[2]==1)
          {
     	if(UIB[6]==0x0a)Memo1->Lines->Add("Поиск файла \"" + AnsiString(UIB[3]) + ".wav\"");
          else if(UIB[7]==0x0a)Memo1->Lines->Add("Поиск файла \"" + AnsiString(UIB[3]) + AnsiString(UIB[4]) + ".wav\"");
          }
	}

if((UIB[0]==CMND)&&(UIB[1]==33))
        {
        Memo1->Lines->Add("Стирание микросхемы завершено");
 	}
if((UIB[0]==CMND)&&(UIB[1]==44))
        {
        Memo1->Lines->Add("Стирание микросхемы инициализировано");
 	}
}


void __fastcall TForm1::ComPort1RxChar(TObject *Sender, int Count)
{

int data,i;
unsigned char temp;
char cnt;


 for(i=0;i<Count;i++)
 	{
     ComPort1->Read(&data,1);
   	rx_buffer[rx_wr_index]=data;
   	bRXIN=1;
   	if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
   	if (++rx_counter == RX_BUFFER_SIZE)
      	{
      	rx_counter=0;
      	rx_buffer_overflow=1;
      	}
     }





if(rx_buffer_overflow)
	{
	rx_wr_index=0;
	rx_rd_index=0;
	rx_counter=0;
	rx_buffer_overflow=0;
	}

if(rx_counter&&(rx_buffer[index_offset(rx_wr_index,-1)])==END)
	{

     temp=rx_buffer[index_offset(rx_wr_index,-3)];
    	if(temp<150)
    		{

    		if(control_check(index_offset(rx_wr_index,-1)))
    			{

    			rx_rd_index=index_offset(rx_wr_index,-3-temp);
    			for(i=0;i<(temp+3);i++)
				{
				UIB[i]=rx_buffer[index_offset(rx_rd_index,i)];
				} 
			rx_rd_index=rx_wr_index;
			rx_counter=0;
			uart_in_an();

    			}

    		}
    	}

}
//---------------------------------------------------------------------------
void __fastcall TForm1::Button3Click(TObject *Sender)
{
uart_out_out(3,CMND,2,0,0,0,0,0,0);
Memo1->Lines->Add("Чтение статус-регистра");	
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button4Click(TObject *Sender)
{
uart_out_out(3,CMND,3,0,0,0,0,0,0);
Memo1->Lines->Add("Программирование линейного пространства");	
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button14Click(TObject *Sender)
{
unsigned i,ii;
i=0;
if (OpenDialog1->Execute())
     {
     SName = OpenDialog1->FileName;
     if ((F = fopen(SName.c_str(), "rb")) == NULL)
          {
          ShowMessage("Файл не удается открыть");
          return;
          }

     while (!feof(F))
     	{
          damp[i]=fgetc(F);
          i++;
          }
     fclose(F);
     file_lengt=i--;


 /*    if((ComboBox6->ItemIndex)==1)
     	{
          for(i=0;i<(file_lengt/2);i++)
          	{
               *((short*)&damp[i*2])=((*((short*)&damp[i*2]))+0x0200)&0x03ff;
               }
          } */

     //fread(damp,sizeof(char),8192,F);           // запись i
     
     Memo1->Lines->Clear();
     Memo1->Lines->Add(IntToStr(file_lengt));





    // for(ii=0;ii<=(file_lengt/16);ii++)
          {
         /* Memo1->Lines->Add(IntToHex((__int64)(ii*16),4)
          							+"	"+IntToHex(damp[ii*16],2)
                                             +"	"+IntToHex(damp[(ii*16)+1],2)
                                             +"	"+IntToHex(damp[(ii*16)+2],2)
                                         	+"	"+IntToHex(damp[(ii*16)+3],2)
                                         	+"	"+IntToHex(damp[(ii*16)+4],2)
                                         	+"	"+IntToHex(damp[(ii*16)+5],2)
                                         	+"	"+IntToHex(damp[(ii*16)+6],2)
                                         	+"	"+IntToHex(damp[(ii*16)+7],2)
                                             +"	"+IntToHex(damp[(ii*16)+8],2)
                                             +"	"+IntToHex(damp[(ii*16)+9],2)
                                             +"	"+IntToHex(damp[(ii*16)+10],2)
                                         	+"	"+IntToHex(damp[(ii*16)+11],2)
                                         	+"	"+IntToHex(damp[(ii*16)+12],2)
                                         	+"	"+IntToHex(damp[(ii*16)+13],2)
                                         	+"	"+IntToHex(damp[(ii*16)+14],2)
                                         	+"	"+IntToHex(damp[(ii*16)+15],2));*/
          }
     }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button5Click(TObject *Sender)
{
uart_out_out(3,CMND,10,1,0,0,0,0,0);
Memo1->Lines->Add("Чтение буфера 1");	
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button7Click(TObject *Sender)
{
uart_out_out(3,CMND,11,1,0,0,0,0,0);
Memo1->Lines->Add("Очистка буфера 1");
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button18Click(TObject *Sender)
{
#define STR	2

uart_out_out(4,CMND,40,STR%256,STR/256,0,0,0,0);
Memo1->Lines->Add("Страница №"+IntToStr(STR));	
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button11Click(TObject *Sender)
{
int temp_adress;
char adr[4];
temp_adress= StrToInt(Edit1->Text);
Memo1->Lines->Add("Запись последовательности 0x00, 0x01, 0x02, .... 0xff по адресу " + IntToStr(temp_adress));
adr[0]=temp_adress%256;
temp_adress/=256;
adr[1]=temp_adress%256;
temp_adress/=256;
adr[2]=temp_adress%256;
temp_adress/=256;
adr[3]=temp_adress%256;

uart_out_out(6,CMND,91,adr[0],adr[1],adr[2],adr[3],0,0);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button12Click(TObject *Sender)
{
int temp_adress;
char adr[4];
temp_adress= StrToInt(Edit1->Text);
Memo1->Lines->Add("Запись последовательности 0x00, 0x02, 0x04, .... 0x03, 0x01 по адресу " + IntToStr(temp_adress));
adr[0]=temp_adress%256;
temp_adress/=256;
adr[1]=temp_adress%256;
temp_adress/=256;
adr[2]=temp_adress%256;
temp_adress/=256;
adr[3]=temp_adress%256;

uart_out_out(6,CMND,92,adr[0],adr[1],adr[2],adr[3],0,0);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button13Click(TObject *Sender)
{
int temp_adress;
char adr[4];
temp_adress= StrToInt(Edit1->Text);
Memo1->Lines->Add("Запись последовательности 0xff, 0xfe, 0xfd, .... 0x00 по адресу " + IntToStr(temp_adress));
adr[0]=temp_adress%256;
temp_adress/=256;
adr[1]=temp_adress%256;
temp_adress/=256;
adr[2]=temp_adress%256;
temp_adress/=256;
adr[3]=temp_adress%256;

uart_out_out(6,CMND,93,adr[0],adr[1],adr[2],adr[3],0,0);}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button10Click(TObject *Sender)
{
uart_out_out(4,CMND,13,0,0,0,0,0,0);
Memo1->Lines->Add("Чтение страниц "+IntToStr(0)+ " в буфер "+IntToStr((0)+1));
	
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button9Click(TObject *Sender)
{
int temp_adress;
char adr[4];
temp_adress= StrToInt(Edit2->Text);
Memo1->Lines->Add("Чтение 256 байт по адресу " + IntToStr(temp_adress));
adr[0]=temp_adress%256;
temp_adress/=256;
adr[1]=temp_adress%256;
temp_adress/=256;
adr[2]=temp_adress%256;
temp_adress/=256;
adr[3]=temp_adress%256; 

uart_out_out(6,CMND,81,adr[0],adr[1],adr[2],adr[3],0,0);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button16Click(TObject *Sender)
{
uart_out_out(8,CMND,20,*((char*)&file_lengt),*(((char*)&file_lengt)+1),*(((char*)&file_lengt)+2),*(((char*)&file_lengt)+3),0,0);
Memo1->Lines->Add("Инициализация записи "+IntToStr(file_lengt)+" байт со страницы 0"/*+IntToStr(ComboBox3->ItemIndex)+ " в буфер "+IntToStr((ComboBox2->ItemIndex)+1)*/);
	
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button19Click(TObject *Sender)
{
uart_out_out(3,CMND,100,1,0,0,0,0,0);
//Memo1->Lines->Add("Стирание микросхемы");
}
//---------------------------------------------------------------------------





void __fastcall TForm1::Button17Click(TObject *Sender)
{
uart_out_out(3,CMND,101,1,0,0,0,0,0);
}
//---------------------------------------------------------------------------

