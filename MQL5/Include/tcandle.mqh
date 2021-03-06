//+------------------------------------------------------------------+
//|                                                      tzigzag.mqh |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
// #define MacrosHello   "Hello, world!"
// #define MacrosYear    2010
#define QTD_1_DIA                      (720)            
#define QTD_1_MINUTO                      (1036800)       
#define QTD_5_MINUTO                      (207360)       
#define QTD_15_MINUTO                      (69120)       
#define QTD_30_MINUTO                      (34560)     
//+------------------------------------------------------------------+
//| DLL imports                                                      |
//+------------------------------------------------------------------+
// #import "user32.dll"
//   int      SendMessageA(int hWnd,int Msg,int wParam,int lParam);
// #import "my_expert.dll"
//   int      ExpertRecalculate(int wParam,int lParam);
// #import
//+------------------------------------------------------------------+
//| EX5 imports                                                      |
//+------------------------------------------------------------------+
// #import "stdlib.ex5"
//   string ErrorDescription(int error_code);
// #import
//+------------------------------------------------------------------+



struct Scandle
{
   long indice;
   MqlRates candle;
};


class Ccandle 
{
private:
   
Scandle candle_1_minuto[QTD_1_MINUTO];
Scandle candle_5_minuto[QTD_5_MINUTO];
Scandle candle_15_minuto[QTD_15_MINUTO];
Scandle candle_30_minuto[QTD_30_MINUTO];
Scandle candle_1_dia[QTD_1_DIA];


   

   
   
 
   
   void get_candles(void);

   
public:

   MqlRates candle_temp_1[];
   MqlRates candle_temp_2[];

 
   void inicializa_vetores(void);
 
 
   //--- create
   virtual bool      Create(void);
   void put_cria_arquivo_principal(void);
   void put_mantem_arquivo(void);
   void get_carrega_candle_server(MqlRates &x[], int qtd, ENUM_TIMEFRAMES tf);
   void get_carrega_candle_arquivo(MqlRates &x[], string arquivo);
   void put_salva_candle_arquivo(MqlRates &x[], string arquivo);

   

   

   
protected:
   //--- create dependent controls
  
   
   
};

Ccandle candle;
  

  
  
bool Ccandle::Create(void){

   inicializa_vetores();
   return true;

}

void Ccandle::get_candles(void){


}


void Ccandle::put_cria_arquivo_principal(void){
   //carregando vetores

   MqlRates candle_1min[];
   MqlRates candle_5min[];
   MqlRates candle_15min[];
   MqlRates candle_30min[];
   MqlRates candle_1d[];
   

   ArraySetAsSeries(candle_1min,true);
   ArraySetAsSeries(candle_5min,true);
   ArraySetAsSeries(candle_15min,true);
   ArraySetAsSeries(candle_30min,true);
   ArraySetAsSeries(candle_1d,true);
   
   int qtd_1min = 360*8*60;
   int qtd_5min = 360*8*60/5;
   int qtd_15min = 360*8*60/15;
   int qtd_30min = 360*8*60/30;
   int qtd_1d = 360;   
   
   int copied_1min=CopyRates(Symbol(),PERIOD_M1,0,qtd_1min,candle_1min);//360dias*8*60=172800
   int copied_5min=CopyRates(Symbol(),PERIOD_M5,0,qtd_5min,candle_5min);//360dias*8*60/5=34560
   int copied_15min=CopyRates(Symbol(),PERIOD_M15,0,qtd_15min,candle_15min);//360dias*8*60/15=11520
   int copied_30min=CopyRates(Symbol(),PERIOD_M30,0,qtd_30min,candle_30min);//360dias*8*60/30=5760
   int copied_1d=CopyRates(Symbol(),PERIOD_D1,0,qtd_1d,candle_1d);//360dias=360
   
   //salvar 1 minuto  
   string arquivo_1min =  "C:/candle_1_minuto.txt";
   arquivo_1min = "candle_1_minuto.txt";
   put_salva_candle_arquivo(candle_1min, arquivo_1min);
   
   //salvar 5 minuto
   string arquivo_5min =  "C:/candle_5_minuto.txt";
   arquivo_5min = "candle_5_minuto.txt";
   put_salva_candle_arquivo(candle_1min, arquivo_5min);

   //salvar 15 minuto
   string arquivo_15min =  "C:/candle_15_minuto.txt";
   arquivo_15min = "candle_15_minuto.txt";
   put_salva_candle_arquivo(candle_1min, arquivo_15min);

   //salvar 30 minutos
   string arquivo_30min =  "C:/candle_30_minuto.txt";
   arquivo_30min = "candle_30_minuto.txt";
   put_salva_candle_arquivo(candle_1min, arquivo_30min);

   //salvar 1 dia
   string arquivo_1dia =  "C:/candle_1_dia.txt";
   arquivo_1dia = "candle_1_dia.txt";
   put_salva_candle_arquivo(candle_1min, arquivo_1dia);

}


void Ccandle::get_carrega_candle_server(MqlRates &x[], int qtd, ENUM_TIMEFRAMES tf){
//carregar vetores com servidor

   ArraySetAsSeries(x,true);   
   int copied=CopyRates(Symbol(),tf,0,qtd,x);//360dias*8*60=172800

}

void Ccandle::get_carrega_candle_arquivo(MqlRates &x[], string arquivo){
//carregar vetores com servidor
   string sep=";";
   ushort u_sep;
   u_sep=StringGetCharacter(sep,0);

   int h=FileOpen(arquivo,FILE_READ|FILE_ANSI|FILE_TXT);
   if(h==INVALID_HANDLE){
      Alert("Error opening file");
      return;
   }   
   int i = 0;
   ArrayResize(x, 0);
   while(!FileIsEnding(h)){
      ArrayResize(x, i+1);
      string s[];
      StringSplit(FileReadString(h), u_sep,s);
      x[i].time =StringToTime(s[0]);
      x[i].open =StringToDouble(s[1]);
      x[i].close =StringToDouble(s[2]);
      x[i].high =StringToDouble(s[3]);
      x[i].low =StringToDouble(s[4]);
      x[i].real_volume =StringToDouble(s[5]);
      x[i].tick_volume =StringToDouble(s[6]);
      x[i].spread =StringToDouble(s[7]);
      i++;
   }
   FileClose(h);
   Print(arquivo + "carregado");

}

void Ccandle::put_salva_candle_arquivo(MqlRates &x[], string arquivo){

   string separador = ";";
   int h=FileOpen(arquivo ,FILE_WRITE|FILE_ANSI|FILE_TXT);
   if(h==INVALID_HANDLE){
      Alert("Error opening file "+arquivo);
      return;
   }  
   for(int i=1;i<ArraySize(x);i++){
      FileWrite(h, 
         TimeToString(x[i].time)+separador+
         DoubleToString(x[1].open)+separador+  
         DoubleToString(x[1].close)+separador+ 
         DoubleToString(x[1].high)+separador+  
         DoubleToString(x[1].low)+separador+  
         DoubleToString(x[1].real_volume)+separador+  
         DoubleToString(x[1].tick_volume)+separador+  
         DoubleToString(x[1].spread)  
      );

   }
   FileClose(h);
   Print(arquivo + "criado");

}



void Ccandle::inicializa_vetores(void){

   datetime minuto_1_inicial = StringToTime("01/01/2019 00:00");
   int divisor = 1;
   
   for(int i = 0; i<QTD_1_MINUTO; i ++){
   
      //1 minuto
      candle_1_minuto[i].candle.time = minuto_1_inicial + i*60;
      
      //5 minutos
      divisor = 5;
      if(MathMod(i, divisor)==0){
         candle_5_minuto[i/divisor].candle.time = minuto_1_inicial + i*60;      
      }

      //15 minutos
      divisor = 15;
      if(MathMod(i, divisor)==0){
         candle_15_minuto[i/divisor].candle.time = minuto_1_inicial + i*60;      
      }

      //30 minutos
      divisor = 30;
      if(MathMod(i, divisor)==0){
         candle_1_minuto[i/divisor].candle.time = minuto_1_inicial + i*60;      
      }

      //1 dia
      divisor = 24*60;
      if(MathMod(i, divisor)==0){
         candle_1_minuto[i/divisor].candle.time = minuto_1_inicial + i*60;      
      }

   
   }
   
   Print(candle_5_minuto[0].candle.time);
   
   


}