//+------------------------------------------------------------------+
//|                                                     scalper1.mq5 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"

#include "../include/vline.mqh"

#include "../include/lable.mqh"
#include "../include/seta_cima.mqh"
#include "../include/linha_tendencia.mqh"
#include "../include/fibonacci.mqh"
#include "../include/dialogo.mqh"
#include <Controls\Dialog.mqh>
#include <Controls\Label.mqh>
#include "../include/trade/AccountInfo.mqh"
#include <Trade\PositionInfo.mqh>
#include "../include/principais_marcadores.mqh"




int mc = 500;

//CAppDialog AppWindow;
CControlsDialog janela;

CTrade  trade;

CPositionInfo position;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

MqlRates candle[];
MqlRates candle_1min[];
MqlRates candle_5min[];
MqlRates candle_15min[];
MqlRates candle_30min[];

int fundo[80];
int topo[80];

CLabel nlab;

//medias moveis
int hma1;
int hma2;
int hma3;

int hma1_1min;
int hma2_1min;
int hma3_1min;

int hma1_5min;
int hma2_5min;
int hma3_5min;

int hma1_15min;
int hma2_15min;
int hma3_15min;

int hma1_30min;
int hma2_30min;
int hma3_30min;

double ma1[];
double ma2[];
double ma3[];

double ma1_1min[];
double ma2_1min[];
double ma3_1min[];

double ma1_5min[];
double ma2_5min[];
double ma3_5min[];

double ma1_15min[];
double ma2_15min[];
double ma3_15min[];

double ma1_30min[];
double ma2_30min[];
double ma3_30min[];

//estocastico
int hstc_1min;
double stc_MAIN_LINE_1min[];//0 - MAIN_LINE, 1 - SIGNAL_LINE.
double stc_SIGNAL_LINE_1min[];//0 - MAIN_LINE, 1 - SIGNAL_LINE.

int hstc_5min;
double stc_MAIN_LINE_5min[];//0 - MAIN_LINE, 1 - SIGNAL_LINE.
double stc_SIGNAL_LINE_5min[];//0 - MAIN_LINE, 1 - SIGNAL_LINE.

int hstc_15min;
double stc_MAIN_LINE_15min[];//0 - MAIN_LINE, 1 - SIGNAL_LINE.
double stc_SIGNAL_LINE_15min[];//0 - MAIN_LINE, 1 - SIGNAL_LINE.

int hstc_30min;
double stc_MAIN_LINE_30min[];//0 - MAIN_LINE, 1 - SIGNAL_LINE.
double stc_SIGNAL_LINE_30min[];//0 - MAIN_LINE, 1 - SIGNAL_LINE.

//indice de força relativo iRSI
int hifr_1min;
int hifr_5min;
int hifr_15min;
int hifr_30min;

double ifr_1min[];
double ifr_5min[];
double ifr_15min[];
double ifr_30min[];

//Commodity Channel Index cci
int hcci_1min;
int hcci_5min;
int hcci_15min;
int hcci_30min;

double cci_1min[];
double cci_5min[];
double cci_15min[];
double cci_30min[];

//macd 0 - MAIN_LINE, 1 - SIGNAL_LINE.
int hmacd_1min;
double macd_MAIN_LINE_1min[];//0 - MAIN_LINE, 1 - SIGNAL_LINE.
double macd_SIGNAL_LINE_1min[];//0 - MAIN_LINE, 1 - SIGNAL_LINE.

int hmacd_5min;
double macd_MAIN_LINE_5min[];//0 - MAIN_LINE, 1 - SIGNAL_LINE.
double macd_SIGNAL_LINE_5min[];//0 - MAIN_LINE, 1 - SIGNAL_LINE.

int hmacd_15min;
double macd_MAIN_LINE_15min[];//0 - MAIN_LINE, 1 - SIGNAL_LINE.
double macd_SIGNAL_LINE_15min[];//0 - MAIN_LINE, 1 - SIGNAL_LINE.

int hmacd_30min;
double macd_MAIN_LINE_30min[];//0 - MAIN_LINE, 1 - SIGNAL_LINE.
double macd_SIGNAL_LINE_30min[];//0 - MAIN_LINE, 1 - SIGNAL_LINE.


int indice_oportunidade = 0;
int indice_posicao = -1;
double comprar_anterior=0;
double vender_anterior=0;


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   EventSetTimer(3);
   
   //apagar todos os bjetos
   ObjectsDeleteAll(0, 0);

//---Cria o diálogo do aplicativo
// if(!AppWindow.Create(0,"AppWindow",0,20,20,360,324))
//     return(INIT_FAILED);
//---Execução da aplicação
//AppWindow.Run();

//medias moveis
hma1=iMA(_Symbol,0,9,0,MODE_EMA,PRICE_CLOSE);
hma2=iMA(_Symbol,0,21,0,MODE_SMA,PRICE_CLOSE);
hma3=iMA(_Symbol,0,200,0,MODE_SMA,PRICE_CLOSE);

hma1_1min=iMA(_Symbol,PERIOD_M1,9,0,MODE_EMA,PRICE_CLOSE);
hma2_1min=iMA(_Symbol,PERIOD_M1,21,0,MODE_SMA,PRICE_CLOSE);
hma3_1min=iMA(_Symbol,PERIOD_M1,200,0,MODE_SMA,PRICE_CLOSE);

hma1_5min=iMA(_Symbol,PERIOD_M5,9,0,MODE_EMA,PRICE_CLOSE);
hma2_5min=iMA(_Symbol,PERIOD_M5,21,0,MODE_SMA,PRICE_CLOSE);
hma3_5min=iMA(_Symbol,PERIOD_M5,200,0,MODE_SMA,PRICE_CLOSE);

hma1_15min=iMA(_Symbol,PERIOD_M15,9,0,MODE_EMA,PRICE_CLOSE);
hma2_15min=iMA(_Symbol,PERIOD_M15,21,0,MODE_SMA,PRICE_CLOSE);
hma3_15min=iMA(_Symbol,PERIOD_M15,200,0,MODE_SMA,PRICE_CLOSE);

hma1_30min=iMA(_Symbol,PERIOD_M30,9,0,MODE_EMA,PRICE_CLOSE);
hma2_30min=iMA(_Symbol,PERIOD_M30,21,0,MODE_SMA,PRICE_CLOSE);
hma3_30min=iMA(_Symbol,PERIOD_M30,200,0,MODE_SMA,PRICE_CLOSE);

//estocasticos

hstc_1min=iStochastic(_Symbol, PERIOD_M1, 5, 3, 3, MODE_SMA, STO_LOWHIGH);
hstc_5min=iStochastic(_Symbol, PERIOD_M5, 5, 3, 3, MODE_SMA, STO_LOWHIGH);
hstc_15min=iStochastic(_Symbol, PERIOD_M15, 5, 3, 3, MODE_SMA, STO_LOWHIGH);
hstc_30min=iStochastic(_Symbol, PERIOD_M30, 5, 3, 3, MODE_SMA, STO_LOWHIGH);

//indice de força relativo
hifr_1min = iRSI(_Symbol, PERIOD_M1, 14, PRICE_CLOSE);
hifr_5min = iRSI(_Symbol, PERIOD_M5, 14, PRICE_CLOSE);
hifr_15min = iRSI(_Symbol, PERIOD_M15, 14, PRICE_CLOSE);
hifr_30min = iRSI(_Symbol, PERIOD_M30, 14, PRICE_CLOSE);

//indice de canal de commedities CCI
hcci_1min = iCCI(_Symbol, PERIOD_M1, 9, PRICE_CLOSE);
hcci_5min = iCCI(_Symbol, PERIOD_M5, 9, PRICE_CLOSE);
hcci_15min = iCCI(_Symbol, PERIOD_M15, 9, PRICE_CLOSE);
hcci_30min = iCCI(_Symbol, PERIOD_M30, 9, PRICE_CLOSE);

//indice de canal de commedities CCI
hmacd_1min = iMACD(_Symbol, PERIOD_M1, 12, 26, 9, PRICE_CLOSE);
hmacd_5min = iMACD(_Symbol, PERIOD_M5, 12, 26, 9, PRICE_CLOSE);
hmacd_15min = iMACD(_Symbol, PERIOD_M15, 12, 26, 9, PRICE_CLOSE);
hmacd_30min = iMACD(_Symbol, PERIOD_M30, 12, 26, 9, PRICE_CLOSE);



//--- create application dialog
   if(!janela.Create(0,"Operações Propostas",0,40,40,500,600))
      return(INIT_FAILED);
//--- run application
   janela.Run();



   ArraySetAsSeries(candle,true);
   ArraySetAsSeries(candle_1min,true);
   ArraySetAsSeries(candle_5min,true);
   ArraySetAsSeries(candle_15min,true);
   ArraySetAsSeries(candle_30min,true);

//--- número de barras visíveis na janela do gráfico
   int bars=(int)ChartGetInteger(0,CHART_VISIBLE_BARS);

//--- array para armazenar a data de valores a serem utilizados
//--- para definir e alterar as coordenadas de pontos de ancoragem
   datetime date[];
//--- alocação de memória
   ArrayResize(date,bars);
//--- preencher o array das datas
   ResetLastError();
   if(CopyTime(Symbol(),Period(),0,bars,date)==-1)
     {
      Print("Falha ao copiar valores de tempo! Código de erro = ",GetLastError());
      return 0;
     }
   ArraySetAsSeries(date,true);



//--- criar uma linha vertical

   if(!VLineCreate(
         0,// ID do gráfico
         "Preco",// nome da linha
         0,// índice da sub-janela
         date[2],// tempo da linha
         StringToColor("0,0,255"),// cor da linha
         0,// estilo da linha
         1,// largura da linha
         false,// no fundo
         true,// destaque para mover
         true, // continuação da linha para baixo
         false,//ocultar na lista de objetos
         0     // prioridade para clique do mouse

      ))
      return 0;



//cria seta no fundo0
   ArrowUpCreate(
      0,           // ID do gráfico
      "fundo0",       // nome do sinal
      0,         // índice da sub-janela
      0,               // ponto de ancoragem do tempo
      0,              // ponto de ancoragem do preço
      ANCHOR_TOP, // tipo de ancoragem
      StringToColor("255,0,255"),           // cor do sinal
      STYLE_DOT,    // estilo de linha da borda
      1,              // tamanho do sinal
      false,           // no fundo
      false,       // destaque para mover
      true,          // ocultar na lista de objetos
      0            // prioridade para clicar no mouse
   );
//cria seta no fundo1
   ArrowUpCreate(
      0,           // ID do gráfico
      "fundo1",       // nome do sinal
      0,         // índice da sub-janela
      0,               // ponto de ancoragem do tempo
      0,              // ponto de ancoragem do preço
      ANCHOR_TOP, // tipo de ancoragem
      StringToColor("255,0,255"),           // cor do sinal
      STYLE_DOT,    // estilo de linha da borda
      1,              // tamanho do sinal
      false,           // no fundo
      false,       // destaque para mover
      true,          // ocultar na lista de objetos
      0            // prioridade para clicar no mouse
   );
//cria seta no fundo2
   ArrowUpCreate(
      0,           // ID do gráfico
      "fundo2",       // nome do sinal
      0,         // índice da sub-janela
      0,               // ponto de ancoragem do tempo
      0,              // ponto de ancoragem do preço
      ANCHOR_TOP, // tipo de ancoragem
      StringToColor("255,0,255"),           // cor do sinal
      STYLE_DOT,    // estilo de linha da borda
      1,              // tamanho do sinal
      false,           // no fundo
      false,       // destaque para mover
      true,          // ocultar na lista de objetos
      0            // prioridade para clicar no mouse
   );
//cria seta no fundo3
   ArrowUpCreate(
      0,           // ID do gráfico
      "fundo3",       // nome do sinal
      0,         // índice da sub-janela
      0,               // ponto de ancoragem do tempo
      0,              // ponto de ancoragem do preço
      ANCHOR_TOP, // tipo de ancoragem
      StringToColor("255,0,255"),           // cor do sinal
      STYLE_DOT,    // estilo de linha da borda
      1,              // tamanho do sinal
      false,           // no fundo
      false,       // destaque para mover
      true,          // ocultar na lista de objetos
      0            // prioridade para clicar no mouse
   );


//cria seta no topo0
   ArrowUpCreate(
      0,           // ID do gráfico
      "topo0",       // nome do sinal
      0,         // índice da sub-janela
      0,               // ponto de ancoragem do tempo
      0,              // ponto de ancoragem do preço
      ANCHOR_TOP, // tipo de ancoragem
      StringToColor("255,255,0"),           // cor do sinal
      STYLE_DOT,    // estilo de linha da borda
      1,              // tamanho do sinal
      false,           // no fundo
      false,       // destaque para mover
      true,          // ocultar na lista de objetos
      0            // prioridade para clicar no mouse
   );
//cria seta no topo1
   ArrowUpCreate(
      0,           // ID do gráfico
      "topo1",       // nome do sinal
      0,         // índice da sub-janela
      0,               // ponto de ancoragem do tempo
      0,              // ponto de ancoragem do preço
      ANCHOR_TOP, // tipo de ancoragem
      StringToColor("255,255,0"),           // cor do sinal
      STYLE_DOT,    // estilo de linha da borda
      1,              // tamanho do sinal
      false,           // no fundo
      false,       // destaque para mover
      true,          // ocultar na lista de objetos
      0            // prioridade para clicar no mouse
   );
//cria seta no topo2
   ArrowUpCreate(
      0,           // ID do gráfico
      "topo2",       // nome do sinal
      0,         // índice da sub-janela
      0,               // ponto de ancoragem do tempo
      0,              // ponto de ancoragem do preço
      ANCHOR_TOP, // tipo de ancoragem
      StringToColor("255,255,0"),           // cor do sinal
      STYLE_DOT,    // estilo de linha da borda
      1,              // tamanho do sinal
      false,           // no fundo
      false,       // destaque para mover
      true,          // ocultar na lista de objetos
      0            // prioridade para clicar no mouse
   );
//cria seta no topo3
   ArrowUpCreate(
      0,           // ID do gráfico
      "topo3",       // nome do sinal
      0,         // índice da sub-janela
      0,               // ponto de ancoragem do tempo
      0,              // ponto de ancoragem do preço
      ANCHOR_TOP, // tipo de ancoragem
      StringToColor("255,255,0"),           // cor do sinal
      STYLE_DOT,    // estilo de linha da borda
      1,              // tamanho do sinal
      false,           // no fundo
      false,       // destaque para mover
      true,          // ocultar na lista de objetos
      0            // prioridade para clicar no mouse
   );








//--- redesenhar o gráfico e esperar por um segundo
   ChartRedraw();

//---
   int maxcand = mc;

   int copied=CopyRates(Symbol(),0,0,maxcand,candle);
   //MessageBox(copied);
   if(copied>0)
     {
      Print("Barres copiados: "+IntegerToString(copied));
      string format="open = %G, high = %G, low = %G, close = %G, volume = %d";
      string out;
      int size=fmin(copied,10);
      for(int i=0; i<size; i++)
        {
         out=IntegerToString(i)+":"+TimeToString(candle[i].time);
         out=out+" "+StringFormat(format,
                                  candle[i].open,
                                  candle[i].high,
                                  candle[i].low,
                                  candle[i].close,
                                  candle[i].tick_volume);
         Print(out);
        }
     }
   else
      Print("Falha ao receber dados históricos para o símbolo ",Symbol());


   
   
//--- object for working with the account
   CAccountInfo account;
//--- receiving the account number, the Expert Advisor is launched at
   long login=account.Login();
   Print("Login=",login);
//--- clarifying account type
   ENUM_ACCOUNT_TRADE_MODE account_type=account.TradeMode();
//--- if the account is real, the Expert Advisor is stopped immediately!
   if(account_type==ACCOUNT_TRADE_MODE_REAL)
     {
      //
      MessageBox("Trading on a real account is forbidden, disabling","The Expert Advisor has been launched on a real account!");
      //return(-1);
     }
//--- displaying the account type    
   Print("Account type: ",EnumToString(account_type));
//--- clarifying if we can trade on this account
   if(account.TradeAllowed())
      Print("Trading on this account is allowed");
   else
      Print("Trading on this account is forbidden: you may have entered using the Investor password");
//--- clarifying if we can use an Expert Advisor on this account
   if(account.TradeExpert())
      Print("Automated trading on this account is allowed");
   else
      Print("Automated trading using Expert Advisors and scripts on this account is forbidden");
//--- clarifying if the permissible number of orders has been set
   int orders_limit=account.LimitOrders();
   if(orders_limit!=0)Print("Maximum permissible amount of active pending orders: ",orders_limit);
//--- displaying company and server names
   Print(account.Company(),": server ",account.Server());
//--- displaying balance and current profit on the account in the end
   Print("Balance=",account.Balance(),"  Profit=",account.Profit(),"   Equity=",account.Equity());
   Print(__FUNCTION__,"  completed"); //---  
   
   
   
 
//--- object for receiving symbol settings
   CSymbolInfo symbol_info;
//--- set the name for the appropriate symbol
   symbol_info.Name(_Symbol);
//--- receive current rates and display
   symbol_info.RefreshRates();
   Print(symbol_info.Name()," (",symbol_info.Description(),")",
         "  Bid=",symbol_info.Bid(),"   Ask=",symbol_info.Ask());
//--- receive minimum freeze levels for trade operations
   Print("StopsLevel=",symbol_info.StopsLevel()," pips, FreezeLevel=",
         symbol_info.FreezeLevel()," pips");
//--- receive the number of decimal places and point size
   Print("Digits=",symbol_info.Digits(),
         ", Point=",DoubleToString(symbol_info.Point(),symbol_info.Digits()));
//--- spread info
   Print("SpreadFloat=",symbol_info.SpreadFloat(),", Spread(current)=",
         symbol_info.Spread()," pips");
//--- request order execution type for limitations
   Print("Limitations for trade operations: ",EnumToString(symbol_info.TradeMode()),
         " (",symbol_info.TradeModeDescription(),")");
//--- clarifying trades execution mode
   Print("Trades execution mode: ",EnumToString(symbol_info.TradeExecution()),
         " (",symbol_info.TradeExecutionDescription(),")");
//--- clarifying contracts price calculation method
   Print("Contract price calculation: ",EnumToString(symbol_info.TradeCalcMode()),
         " (",symbol_info.TradeCalcModeDescription(),")");
//--- sizes of contracts
   Print("Standard contract size: ",symbol_info.ContractSize(),
         " (",symbol_info.CurrencyBase(),")");
//--- minimum and maximum volumes in trade operations
   Print("Volume info: LotsMin=",symbol_info.LotsMin(),"  LotsMax=",symbol_info.LotsMax(),
         "  LotsStep=",symbol_info.LotsStep());
//--- 
   Print(__FUNCTION__,"  completed");    
   
   
   
   marcadores();
   
   
   

//---
   return(INIT_SUCCEEDED);
  }
  
  
//PEGA UM NUMERO E ACRESCENTA ZEROS à ESQUERDA E RETORNA UMA STRING DE TAMANHO DESEJADO
string numero_i_str(int x, int n){
   string valor = IntegerToString(x);
   while (StringLen(valor)<n){
      valor = "0"+valor;
   }
   return valor;
}

string numero_r_str(double x, int n){
   string valor = DoubleToString(x, 2);
   while (StringLen(valor)<n){
      valor = "0"+valor;
   }
   return valor;
}
  
  
  
  

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int poslinha()
  {


   
   if(ObjectFind(0,"Preco"))
     {
      Print("Linha de preco zero nao encontrada");

      if(!VLineCreate(
            0,// ID do gráfico
            "Preco",// nome da linha
            0,// índice da sub-janela
            candle[1].time,// tempo da linha
            StringToColor("0,0,255"),// cor da linha
            0,// estilo da linha
            1,// largura da linha
            false,// no fundo
            true,// destaque para mover
            true, // continuação da linha para baixo
            false,//ocultar na lista de objetos
            0     // prioridade para clique do mouse
         ))
         return 1;
     }
     
     
  if (janela.m_button3.Pressed()){
  
   if (!VLineMove(0, "Preco", candle[1].time)){
   }      

  }else{
     
  }
     
     
   int maxcand = mc; 
   
   int copied=CopyRates(Symbol(),0,0,maxcand,candle);

   int tempo;
   tempo = ObjectGetInteger(0, "Preco", OBJPROP_TIME);
   int ii=0;
   while(ii<maxcand)
     {
      if(candle[ii].time == tempo)
        {
         return ii;
        }
      ii++;
     }
   return 1;
  }
  
void atualizaposicoes (double tp, double sl){

   //deixa valores divisiveis por 5
   double sloss = 5*MathRound(sl/5);
   double tprof = 5*MathRound(tp/5);
   
   //seleciona o ativo
   if(position.Select(_Symbol)){
   
   }else{
      return;//se nao tiver posições sai
   }
   
   if ((position.StopLoss()==sloss)&&(position.TakeProfit()==tprof)){
      return;//se os novos stops forem iguais aos da posição sai
   
   }

   if(!trade.PositionModify(_Symbol, sloss, tprof))
     {
      //--- failure message
      Print("Метод PositionModify() method failed. Return code=",trade.ResultRetcode(),
            ". Descrição do código: ",trade.ResultRetcodeDescription());
     }
   else
     {
      Print("PositionModify() method executed successfully. Return code=",trade.ResultRetcode(),
            " (",trade.ResultRetcodeDescription(),")");
     }

}

//EXIBIR CLANDLE COM MENOS COMANDOS
double ct(int x){//topo
   return candle[x].high;
}
double cf(int x){//topo
   return candle[x].low;
}


void zigzag(string nome, datetime t1, double p1, datetime t2, double p2){

      

      TrendCreate(
         0,        // ID do gráfico
         nome,  // nome da linha
         0,      // índice da sub-janela
         t1,           // primeiro ponto de tempo
         p1,          // primeiro ponto de preço
         t2,           // segundo ponto de tempo
         p2,          // segundo ponto de preço
         StringToColor("255,255,255"),        // cor da linha
         STYLE_SOLID, // estilo da linha
         2,           // largura da linha
         false,        // no fundo
         false,    // destaque para mover
         false,    // continuação da linha para a esquerda
         false,   // continuação da linha para a direita
         true,       //ocultar na lista de objetos
         0); 



}


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void recorrente(int zero)
  {



   zero = poslinha();




//--- número de barras visíveis na janela do gráfico
   int bars=(int)ChartGetInteger(0,CHART_VISIBLE_BARS);

//--- array para armazenar a data de valores a serem utilizados
//--- para definir e alterar as coordenadas de pontos de ancoragem
   datetime date[];
//--- alocação de memória
   ArrayResize(date,bars);
//--- preencher o array das datas
   ResetLastError();
   if(CopyTime(Symbol(),Period(),0,bars,date)==-1)
     {
      Print("Falha ao copiar valores de tempo! Código de erro = ",GetLastError());
      return;
     }
   ArraySetAsSeries(date,true);



//--- verificar se o funcionamento do script foi desativado a força
   if(IsStopped())
      return;




      

//--- redesenhar o gráfico
   ChartRedraw();





   int maxcand = mc;

   int n_ft = 50;//numero de topos e fundos desejados
   
   int n_topos = 0;
   int n_fundos = 0;

   int copied=CopyRates(Symbol(),0,0,maxcand+zero,candle);
   if(copied>0)
     {

      //buscar 50 fundos
      int i=1+zero;//contador de candles
      int j=0;//contador de fundos

      int nc=3;//n candles pra frente
      int mc=3;//m candles pra tras
      int k;
      while((j<n_ft)&&((i+nc+mc+1)<copied))
        {
         int eh_fundo=1; //o candle[i] é fundo ate q se prove o contrario

         //Teste 1 - olhando n candles pra frente e m candles pra tras tem algum mais baixo?
         k = 0;//olhando pra frente
         while((k<nc)&&((i-k)>0))
         {
            if((candle[i].low > candle[i-k].low))
            {
               eh_fundo = 0;
            }
            k++;
         }

         k = 0;//olhando pra tras
         while((k<mc)&&((i+k)<copied))
         {
            if((candle[i].low > candle[i+k].low))
            {
               eh_fundo = 0;
            }
            k++;
         }

         //Teste 2 - O fundo anterior esta perto?
         if((j>0))//ja tem fundos
         {
            if((i-fundo[j-1])<(mc+nc)) //tem um fundo perto!
            {
               if(candle[fundo[j-1]].low<=candle[i].low) //esse fundo que esta proximo é mais baixo que candle i
               {
                  eh_fundo = 0;
               }
            }
         }


         //se o candle passou em todos os testes pra ser fundo
         if(eh_fundo)
         {
            fundo[j] = i;//o proximo fundo recebe o numero do candle
            j++;
         }
         
         i++;
        }



      n_fundos = j;

      //buscar 50 topos
      i=1+zero;//contador de candles
      j=0;//contador de topos

      nc=3;
      mc=3;
      while((j<n_ft)&&(i<copied))
        {
         int eh_topo=1; //o candle[i] é topo ate q se prove o contrario

         //Teste 1 - olhando n candles pra frente e m candles pra tras tem algum mais alto?
         k = 0;//olhando pra frente
         while((k<nc)&&((i-k)>0))
         {
            if((candle[i].high < candle[i-k].high))
            {
               eh_topo = 0;
            }
            k++;
         }

         k = 0;//olhando pra tras
         while((k<mc)&&((i+k)<copied))
         {
            if((candle[i].high < candle[i+k].high))
            {
               eh_topo = 0;
            }
            k++;
         }

         //Teste 2 - O topo anterior esta perto?
         if((j>0))//se ja temos topo
         {
            if((i-topo[j-1])<(mc+nc)) //tem um topo perto!
            {
               if(candle[topo[j-1]].high>=candle[i].high) //esse topo que esta proximo é mais alto que candle i!
               {
                  eh_topo = 0;
               }
            }
         }


         //se o candle passou pro todos os testes pra ser topo  
         if(eh_topo)
           {
            topo[j] = i;//o proximo topo recebe o valor desse candle
            j++;
           }
         i++;
        }

      n_topos = j;
      
      int tfmen = n_topos<n_fundos?n_topos:n_fundos;
      tfmen = tfmen<5?tfmen:5;

      //Quem nasceu primeiro o fundo ou o topo?
      if(fundo[0]<=topo[0])  //Se o fundo nasceu primeiro vamos refazer os topos como os maiores valores entre os fundos
        {

         for(k=0; (k+1)<tfmen; k++) //navegar entre os fundos
           {

            topo[k] = fundo[k]+1;//topo começa com o candle imadiatamente posterior ao fundo
            for(i=fundo[k]+1; i<fundo[k+1]; i++)
              {

               if(candle[i].high > candle[topo[k]].high)
                 {
                  topo[k] = i;//cada vez q um candle mais alte e encontrado ele vira o topo
                 }

              }

           }

        }
      else  //se o topo nassceu primeiro
        {


         for(k=0; k<tfmen; k++) //navegar entre os topos
           {

            fundo[k] = topo[k]+1;//topo começa com o candle imadiatamente posterior ao fundo
            for(i=topo[k]+1; i<topo[k+1]; i++)
              {

               if(candle[i].low < candle[fundo[k]].low)
                 {
                  fundo[k] = i;
                 }

              }

           }

        }








         
         



     }else{
     
        
     
        MessageBox("Não foi copiado numero correto de candles");
        return;
     
     }
     
     
     
    //DESENHANDO O ZIG ZAG

    int kk = 0;
    int tfmenor = n_topos<n_fundos?n_topos:n_fundos;
    tfmenor = tfmenor<4?tfmenor:4;


    //no caso de topo primeiro
    if (topo[0]<=fundo[0]){
       //começamos com a linha entre o candle 0 e o topo zero
       zigzag("zigzag0", candle[zero].time, candle[zero].close, candle[topo[0]].time, candle[topo[0]].high);
       for(kk=0; kk<tfmenor; kk++){
         zigzag("zigzag"+IntegerToString(kk+1), candle[topo[kk]].time, candle[topo[kk]].high, candle[fundo[kk]].time, candle[fundo[kk]].low);  
         zigzag("zigzag"+IntegerToString(kk+tfmenor+1), candle[topo[kk+1]].time, candle[topo[kk+1]].high, candle[fundo[kk]].time, candle[fundo[kk]].low);
       }

    }else if (fundo[0]<=topo[0]){
       zigzag("zigzag0", candle[zero].time, candle[zero].close, candle[fundo[0]].time, candle[fundo[0]].low);     
       for(kk=0; kk<tfmenor; kk++){
         zigzag("zigzag"+IntegerToString(kk+1), candle[topo[kk]].time, candle[topo[kk]].high, candle[fundo[kk+1]].time, candle[fundo[kk+1]].low);  
         zigzag("zigzag"+IntegerToString(kk+tfmenor+1), candle[topo[kk]].time, candle[topo[kk]].high, candle[fundo[kk]].time, candle[fundo[kk]].low);
       }
      
    }
     
     



   ArrowUpMove(
      0,     // ID do gráfico
      "fundo0", // nome do objeto
      candle[fundo[0]].time,         // coordenada do ponto de ancoragem de tempo
      candle[fundo[0]].low);        // coordenada do ponto de ancoragem de preço

   ArrowUpMove(
      0,     // ID do gráfico
      "fundo1", // nome do objeto
      candle[fundo[1]].time,         // coordenada do ponto de ancoragem de tempo
      candle[fundo[1]].low);        // coordenada do ponto de ancoragem de preço

   ArrowUpMove(
      0,     // ID do gráfico
      "fundo2", // nome do objeto
      candle[fundo[2]].time,         // coordenada do ponto de ancoragem de tempo
      candle[fundo[2]].low);        // coordenada do ponto de ancoragem de preço

   ArrowUpMove(
      0,     // ID do gráfico
      "fundo3", // nome do objeto
      candle[fundo[3]].time,         // coordenada do ponto de ancoragem de tempo
      candle[fundo[3]].low);        // coordenada do ponto de ancoragem de preço


  

   ArrowUpMove(
      0,     // ID do gráfico
      "topo0", // nome do objeto
      candle[topo[0]].time,         // coordenada do ponto de ancoragem de tempo
      candle[topo[0]].high);        // coordenada do ponto de ancoragem de preço

   ArrowUpMove(
      0,     // ID do gráfico
      "topo1", // nome do objeto
      candle[topo[1]].time,         // coordenada do ponto de ancoragem de tempo
      candle[topo[1]].high);        // coordenada do ponto de ancoragem de preço

   ArrowUpMove(
      0,     // ID do gráfico
      "topo2", // nome do objeto
      candle[topo[2]].time,         // coordenada do ponto de ancoragem de tempo
      candle[topo[2]].high);        // coordenada do ponto de ancoragem de preço
      
   ArrowUpMove(
      0,     // ID do gráfico
      "topo3", // nome do objeto
      candle[topo[3]].time,         // coordenada do ponto de ancoragem de tempo
      candle[topo[3]].high);        // coordenada do ponto de ancoragem de preço


   
  
   
   
   
   
// ********************************************************************************************************
// ************************ TOPOS E FUNDOS DEFINIDOS A PARTIR DAQUI ****************************************
// ********************************************************************************************************   
   
   
//IDENTIFICANDO FIBOACCI   
   double de0a100=-1;
   double de0a618=-1;
   double razao = -1;
   
   //FiboLevelsDelete(0, "FiboLevels");
   
  
   if (fundo[0]<topo[0]){//fundo primeiro
      if (candle[fundo[0]].low>candle[fundo[1]].low){//fundos ascendentes
         de0a100=candle[topo[0]].high-candle[fundo[1]].low;
         de0a618=candle[fundo[0]].low-candle[fundo[1]].low;
         razao = de0a618 / de0a100;
         Comment("Mov ascdente. Razao="+DoubleToString(razao));
      } else if (candle[fundo[0]].low<candle[fundo[1]].low){//fundos descendentes
         Comment("Razao=");
         
      } else {
         Comment("Razao=");
               
      }
   }else{//topo primeiro
      if (candle[topo[0]].high<candle[topo[1]].high){//topos descendentes
         de0a100=-(candle[fundo[0]].low-candle[topo[1]].high);
         de0a618=-(candle[topo[0]].high-candle[topo[1]].high);
         razao = de0a618 / de0a100;
         Comment("Mov descendente. Razao="+DoubleToString(razao));
      }else if (candle[topo[0]].high>candle[topo[1]].high){//topos ascendentes
      }else{
         Comment("Razao=");
      }
      
   
   }
      

  

  
  
  
  
//MONTANDO AS MEDIAS 

   //media tempo atual

   CopyBuffer(hma1,0,0,maxcand,ma1);
   ArraySetAsSeries(ma1,true);  
   
   CopyBuffer(hma2,0,0,maxcand,ma2);
   ArraySetAsSeries(ma2,true);  
   
   CopyBuffer(hma3,0,0,maxcand,ma3);
   ArraySetAsSeries(ma3,true);  
   

   
   
   
//copiar os candles de varios tempos
   int copied_1min=CopyRates(Symbol(),PERIOD_M1,0,200+zero,candle_1min);
   int copied_5min=CopyRates(Symbol(),PERIOD_M5,0,200+zero,candle_5min);
   int copied_15min=CopyRates(Symbol(),PERIOD_M15,0,200+zero,candle_15min);
   int copied_30min=CopyRates(Symbol(),PERIOD_M30,0,200+zero,candle_30min);
     
   ENUM_TIMEFRAMES tf=ChartPeriod();

   int zero2 = zero > 0 ? zero-1 : 0;  
   
   int zero_1min=zero2;
   
   if(tf==PERIOD_M5){ zero_1min = zero2*5;}else  
   if(tf==PERIOD_M15){ zero_1min = zero2*15;}else
   if(tf==PERIOD_M30){ zero_1min = zero2*30;}
   zero_1min++;
   
   int zero_5min=zero2;
   
   if(tf==PERIOD_M1){ zero_5min = MathRound(zero2/5);}else  
   if(tf==PERIOD_M15){ zero_5min = zero2*3;}else
   if(tf==PERIOD_M30){ zero_5min = zero2*6;}
   zero_5min++;
   
   int zero_15min=zero2;
   
   if(tf==PERIOD_M1){ zero_15min = MathRound(zero2/15);}else  
   if(tf==PERIOD_M5){ zero_15min = MathRound(zero2/3);}else
   if(tf==PERIOD_M30){ zero_15min = zero2*2;}
   zero_15min++;
   
   int zero_30min=zero2;
   
   if(tf==PERIOD_M1){ zero_30min = MathRound(zero2/30);}else  
   if(tf==PERIOD_M5){ zero_30min = MathRound(zero2/6);}else
   if(tf==PERIOD_M15){ zero_30min = MathRound(zero2/2);}
   zero_30min++;
   
   
   
 

 
   janela.m_indicador_colunas[0].Text("1 minuto");
   janela.m_indicador_colunas[1].Text("5 minutos");
   janela.m_indicador_colunas[2].Text("15 minutos");
   janela.m_indicador_colunas[3].Text("30 minutos");

   janela.m_indicador_linhas[0].Text("Cruz Med");
   janela.m_indicador_linhas[1].Text("Stocast");
   janela.m_indicador_linhas[2].Text("IFR");
   janela.m_indicador_linhas[3].Text("CCI fast");
   janela.m_indicador_linhas[4].Text("macd");
   
   

   int maxmed = zero_1min+1;

   
   //medias 1 minuto
   
   CopyBuffer(hma1_1min,0,0,maxmed,ma1_1min);
   ArraySetAsSeries(ma1_1min,true);  

   CopyBuffer(hma2_1min,0,0,maxmed,ma2_1min);
   ArraySetAsSeries(ma2_1min,true);  

   //CopyBuffer(hma3_1min,0,0,maxmed,ma3_1min);
   //ArraySetAsSeries(ma3_1min,true);  
   
   

   //medias 5 minuto
   
   CopyBuffer(hma1_5min,0,0,maxmed,ma1_5min);
   ArraySetAsSeries(ma1_5min,true);  

   CopyBuffer(hma2_5min,0,0,maxmed,ma2_5min);
   ArraySetAsSeries(ma2_5min,true);  

   //CopyBuffer(hma3_5min,0,0,maxmed,ma3_5min);
   //ArraySetAsSeries(ma3_5min,true);  
   
   
   
   //medias 15 minuto
   
   CopyBuffer(hma1_15min,0,0,maxmed,ma1_15min);
   ArraySetAsSeries(ma1_15min,true);  
   

   CopyBuffer(hma2_15min,0,0,maxmed,ma2_15min);
   ArraySetAsSeries(ma2_15min,true);  
   

   //CopyBuffer(hma3_15min,0,0,maxmed,ma3_15min);
   //ArraySetAsSeries(ma3_15min,true);  
   
   
   
   //medias 30 minuto
   
   CopyBuffer(hma1_30min,0,0,maxmed,ma1_30min);
   ArraySetAsSeries(ma1_30min,true);  

   CopyBuffer(hma2_30min,0,0,maxmed,ma2_30min);
   ArraySetAsSeries(ma2_30min,true);  

   //CopyBuffer(hma3_15min,0,0,maxcand,ma3_15min);
   //ArraySetAsSeries(ma3_30min,true); 
   

 
   
   
   //cruzamento de medias linha 0
   //coluna 1 minuto
   janela.cv[0][0] = ma1_1min[zero_1min]==ma2_1min[zero_1min]?0:(ma1_1min[zero_1min]>ma2_1min[zero_1min]?1:-1);
   //coluna 5 minuto
   janela.cv[0][1] = ma1_5min[zero_5min]==ma2_5min[zero_5min]?0:(ma1_5min[zero_5min]>ma2_5min[zero_5min]?1:-1);
   //coluna 15 minuto
   janela.cv[0][2] = ma1_15min[zero_15min]==ma2_15min[zero_15min]?0:(ma1_15min[zero_15min]>ma2_15min[zero_15min]?1:-1);
   //coluna 30 minuto
   janela.cv[0][3] = ma1_30min[zero_30min]==ma2_30min[zero_30min]?0:(ma1_30min[zero_30min]>ma2_30min[zero_30min]?1:-1);
 


   
//MONTANDO OS ESTOCASTICOS
   
   CopyBuffer(hstc_1min,0,0,maxcand,stc_MAIN_LINE_1min);
   CopyBuffer(hstc_1min,1,0,maxcand,stc_SIGNAL_LINE_1min);
   ArraySetAsSeries(stc_MAIN_LINE_1min,true); 
   ArraySetAsSeries(stc_SIGNAL_LINE_1min,true); 

   CopyBuffer(hstc_5min,0,0,maxcand,stc_MAIN_LINE_5min);
   CopyBuffer(hstc_5min,1,0,maxcand,stc_SIGNAL_LINE_5min);
   ArraySetAsSeries(stc_MAIN_LINE_5min,true); 
   ArraySetAsSeries(stc_SIGNAL_LINE_5min,true); 

   CopyBuffer(hstc_15min,0,0,maxcand,stc_MAIN_LINE_15min);
   CopyBuffer(hstc_15min,1,0,maxcand,stc_SIGNAL_LINE_15min);
   ArraySetAsSeries(stc_MAIN_LINE_15min,true); 
   ArraySetAsSeries(stc_SIGNAL_LINE_15min,true); 

   CopyBuffer(hstc_30min,0,0,maxcand,stc_MAIN_LINE_30min);
   CopyBuffer(hstc_30min,1,0,maxcand,stc_SIGNAL_LINE_30min);
   ArraySetAsSeries(stc_MAIN_LINE_30min,true); 
   ArraySetAsSeries(stc_SIGNAL_LINE_30min,true); 


   
   //stocastico 1 minuto
   if (ArraySize(stc_MAIN_LINE_1min)>zero_1min){
      janela.cv[1][0] = stc_MAIN_LINE_1min[zero_1min] > stc_SIGNAL_LINE_1min[zero_1min] ? 1  
         : stc_MAIN_LINE_1min[zero_1min] < stc_SIGNAL_LINE_1min[zero_1min] ? -1 : 0
      ;
   }else{
      janela.cv[1][0] = -2;
   
   }
   //stocastico 5 minutoS
   if (ArraySize(stc_MAIN_LINE_5min)>zero_5min){
      janela.cv[1][1] = stc_MAIN_LINE_5min[zero_5min] > stc_SIGNAL_LINE_5min[zero_5min] ? 1  
         : stc_MAIN_LINE_5min[zero_5min] < stc_SIGNAL_LINE_5min[zero_5min] ? -1 : 0
      ;
   }else{
      janela.cv[1][1] = -2;
   
   }
   //stocastico 15 minutoS
   if (ArraySize(stc_MAIN_LINE_15min)>zero_15min){
      janela.cv[1][2] = stc_MAIN_LINE_15min[zero_15min] > stc_SIGNAL_LINE_15min[zero_15min] ? 1  
         : stc_MAIN_LINE_15min[zero_15min] < stc_SIGNAL_LINE_15min[zero_15min] ? -1 : 0
      ;
   }else{
      janela.cv[1][2] = -2;
   
   }
   //stocastico 30 minuto
   if (ArraySize(stc_MAIN_LINE_30min)>zero_30min){
      janela.cv[1][3] = stc_MAIN_LINE_30min[zero_30min] > stc_SIGNAL_LINE_30min[zero_30min] ? 1  
         : stc_MAIN_LINE_30min[zero_30min] < stc_SIGNAL_LINE_30min[zero_30min] ? -1 : 0
      ;
   }else{
      janela.cv[1][3] = -2;
   
   }
   

   
   
//MONTANDO OS IFR INDICE DE FORÇA RELATIVO
   CopyBuffer(hifr_1min,0,0,maxcand,ifr_1min);
   ArraySetAsSeries(ifr_1min,true); 
 
   CopyBuffer(hifr_5min,0,0,maxcand,ifr_5min);
   ArraySetAsSeries(ifr_5min,true); 
 
   CopyBuffer(hifr_15min,0,0,maxcand,ifr_15min);
   ArraySetAsSeries(ifr_15min,true); 
 
   CopyBuffer(hifr_30min,0,0,maxcand,ifr_30min);
   ArraySetAsSeries(ifr_30min,true); 
   

  //1 minuto
   if (ArraySize(ifr_1min)>zero_1min){
      janela.cv[2][0] = (ifr_1min[zero_1min]>50)&&(ifr_1min[zero_1min]<70) ? 1 : (ifr_1min[zero_1min]<50)&&(ifr_1min[zero_1min]>30) ? -1 : 0;
   }else{
      janela.cv[2][0] = -2;
   
   }
   //5 minuto
   if (ArraySize(ifr_5min)>zero_5min){
      janela.cv[2][1] = (ifr_5min[zero_5min]>50)&&(ifr_5min[zero_5min]<70) ? 1 : (ifr_5min[zero_5min]<50)&&(ifr_1min[zero_1min]>30) ? -1 : 0;
   }else{
      janela.cv[2][1] = -2;
   
   }
   //15 minuto
   if (ArraySize(ifr_15min)>zero_15min){
      janela.cv[2][2] = (ifr_15min[zero_15min]>50)&&(ifr_5min[zero_5min]<70) ? 1 : (ifr_15min[zero_15min]<50)&&(ifr_1min[zero_1min]>30)? -1 : 0;
   }else{
      janela.cv[2][2] = -2;
   
   }
   //30 minuto
   if (ArraySize(ifr_30min)>zero_30min){
      janela.cv[2][3] = (ifr_30min[zero_30min]>50)&&(ifr_5min[zero_5min]<70) ? 1 : (ifr_30min[zero_30min]<50)&&(ifr_1min[zero_1min]>30) ? -1 : 0;
   }else{
      janela.cv[2][3] = -2;
   
   }
   

   
//MONTANDO OS CCI
   CopyBuffer(hcci_1min,0,0,maxcand,cci_1min);
   ArraySetAsSeries(cci_1min,true); 
 
   CopyBuffer(hcci_5min,0,0,maxcand,cci_5min);
   ArraySetAsSeries(cci_5min,true); 
 
   CopyBuffer(hcci_15min,0,0,maxcand,cci_15min);
   ArraySetAsSeries(cci_15min,true); 
 
   CopyBuffer(hcci_30min,0,0,maxcand,cci_30min);
   ArraySetAsSeries(cci_30min,true); 
   
   //cci linha 3

  //1 minuto
   if (ArraySize(cci_1min)>zero_1min){
      janela.cv[3][0] = cci_1min[zero_1min]>100 ? 1 : cci_1min[zero_1min]<-100 ? -1 : 0;
   }else{
      janela.cv[3][0] = -2;
   
   }
   //5 minuto
   if (ArraySize(cci_5min)>zero_5min){
      janela.cv[3][1] = cci_5min[zero_5min]>100 ? 1 : cci_5min[zero_5min]<-100 ? -1 : 0;
   }else{
      janela.cv[3][1] = -2;
   
   }
   //15 minuto
   if (ArraySize(cci_15min)>zero_15min){
      janela.cv[3][2] = cci_15min[zero_15min]>100 ? 1 : cci_15min[zero_15min]<-100? -1 : 0;
   }else{
      janela.cv[3][2] = -2;
   
   }
   //30 minuto
   if (ArraySize(cci_30min)>zero_30min){
      janela.cv[3][3] = cci_30min[zero_30min]>100 ? 1 : cci_30min[zero_30min]<-100 ? -1 : 0;
   }else{
      janela.cv[3][3] = -2;
   
   }
   
   

   
//MONTANDO MACD
   CopyBuffer(hmacd_1min,0,0,maxcand,macd_MAIN_LINE_1min);
   CopyBuffer(hmacd_1min,1,0,maxcand,macd_SIGNAL_LINE_1min);
   ArraySetAsSeries(macd_MAIN_LINE_1min,true); 
   ArraySetAsSeries(macd_SIGNAL_LINE_1min,true); 

   CopyBuffer(hmacd_5min,0,0,maxcand,macd_MAIN_LINE_5min);
   CopyBuffer(hmacd_5min,1,0,maxcand,macd_SIGNAL_LINE_5min);
   ArraySetAsSeries(macd_MAIN_LINE_5min,true); 
   ArraySetAsSeries(macd_SIGNAL_LINE_5min,true); 

   CopyBuffer(hmacd_15min,0,0,maxcand,macd_MAIN_LINE_15min);
   CopyBuffer(hmacd_15min,1,0,maxcand,macd_SIGNAL_LINE_15min);
   ArraySetAsSeries(macd_MAIN_LINE_15min,true); 
   ArraySetAsSeries(macd_SIGNAL_LINE_15min,true); 

   CopyBuffer(hmacd_30min,0,0,maxcand,macd_MAIN_LINE_30min);
   CopyBuffer(hmacd_30min,1,0,maxcand,macd_SIGNAL_LINE_30min);
   ArraySetAsSeries(macd_MAIN_LINE_30min,true); 
   ArraySetAsSeries(macd_SIGNAL_LINE_30min,true); 
   
   //macd linha 4
   
   if (ArraySize(macd_MAIN_LINE_1min)>zero_1min){
      janela.cv[4][0] = macd_MAIN_LINE_1min[zero_1min]>macd_SIGNAL_LINE_1min[zero_1min] ? 1 : (macd_MAIN_LINE_1min[zero_1min]<macd_SIGNAL_LINE_1min[zero_1min] ? -1 : 0);
   }else{
      janela.cv[4][0] = -2;
   
   }
   if (ArraySize(macd_MAIN_LINE_5min)>zero_5min){
      janela.cv[4][1] = macd_MAIN_LINE_5min[zero_5min]>macd_SIGNAL_LINE_5min[zero_5min] ? 1 : (macd_MAIN_LINE_5min[zero_5min]<macd_SIGNAL_LINE_5min[zero_5min] ? -1 : 0);
   }else{
      janela.cv[4][1] = -2;
   
   }
   if (ArraySize(macd_MAIN_LINE_15min)>zero_15min){
      janela.cv[4][2] = macd_MAIN_LINE_15min[zero_15min]>macd_SIGNAL_LINE_15min[zero_15min] ? 1 : (macd_MAIN_LINE_15min[zero_15min]<macd_SIGNAL_LINE_15min[zero_15min] ? -1 : 0);
   }else{
      janela.cv[4][2] = -2;
   
   }
   if (ArraySize(macd_MAIN_LINE_30min)>zero_30min){
      janela.cv[4][3] = macd_MAIN_LINE_30min[zero_30min]>macd_SIGNAL_LINE_30min[zero_30min] ? 1 : (macd_MAIN_LINE_30min[zero_30min]<macd_SIGNAL_LINE_30min[zero_30min] ? -1 : 0);
   }else{
      janela.cv[4][3] = -2;
   
   }
   


   
//MOSTRANDO INDICADORES   
   int resumo=0;
   int comprar=0;
   int vender=0;
   int vi, vj;
    for(vi=0; vi<ni; vi++){  
      for(vj=0; vj<4; vj++){
         janela.m_indicadorv[vi][vj].Color(janela.cv[vi][vj]==0?StringToColor("0,0,0"):(janela.cv[vi][vj]==1?StringToColor("0,255,0"):(janela.cv[vi][vj]==-1?StringToColor("255,0,0"):StringToColor("0,0,255"))));
         janela.m_indicadorv[vi][vj].Text(janela.cv[vi][vj]==0?"Neutro":(janela.cv[vi][vj]==1?"Compra":(janela.cv[vi][vj]==-1?"Venda":"Erro")));
         resumo += janela.cv[vi][vj]!=0?1:0;
         comprar += janela.cv[vi][vj]>0?janela.cv[vi][vj]:0;
         vender -= janela.cv[vi][vj]<0?janela.cv[vi][vj]:0;
      }
   }
   
   janela.m_indicador2.Text("Resumo: Comprar="+DoubleToString(100*comprar/resumo, 2) +"% Vender="+DoubleToString(100*vender/resumo, 2)+"%"
   );
   





//POSIÇÃO DO ZERO
   //janela.m_label1.Text("z="+IntegerToString(zero_1min) +", "+IntegerToString(zero_5min) +", "+IntegerToString(zero_15min) +", "+IntegerToString(zero_30min) +", "+ " tf=" + tf + " " + (fundo[0]<topo[0] ? "FP" : "TP")+" "+"P"+indice_posicao+"!O"+indice_oportunidade);





//Determinar a proxima resistencia
   int resistencia=0;
   while((resistencia<=50)&&(candle[topo[resistencia]].high<candle[zero].close))
   {
      resistencia++;
   }
//Determinar o proximo suporte
   int suporte=0;
   if (fundo[50]<ArraySize(candle))
   while((suporte<=50)&&(candle[fundo[suporte]].low>candle[zero].close))
   {
      suporte++;
   }
   






//Operação de compra
   int iop_valor = resistencia;
   double op_valor = candle[topo[iop_valor]].high;
   
   int iop_sl = suporte; //topo[0]<fundo[0] ? 0 : 0;
   double op_sl = candle[fundo[iop_sl]].low;
   
   double op_tp0 = (op_valor - op_sl)*0.618 + op_valor;
   double op_tp1 = (op_valor - op_sl)*1.618 + op_valor;


   janela.m_preco1.Text("Preço na resistencia ["+ iop_valor + "]="+DoubleToString(op_valor, 0));  
   janela.m_stop1.Text("Perda máxima no suporte ["+ iop_sl +"]="+DoubleToString(op_sl, 0));

   double tpc0 = op_tp0;
   tpc0 = 5*MathRound(tpc0/5);
   //janela.m_tp1.Text("Lucro Máximo="+DoubleToString(tpc0, 0));    //  +"->"+DoubleToString(candle[topo[0]].high,0) +"-"+DoubleToString( candle[fundo[1]].low, 0));

   double tpc1 = op_tp1;
   tpc1 = 5*MathRound(tpc1/5);
   janela.m_tp1.Text("Lucro Máximo="+DoubleToString(tpc1, 0));    //  +"->"+DoubleToString(candle[topo[0]].high,0) +"-"+DoubleToString( candle[fundo[1]].low, 0));

   double lucro = (tpc1-op_valor)*0.2;
   double risco = (op_valor-op_sl)*0.2;
   double p_lr = 100*lucro/risco;
   janela.m_label2.Text("Buy Stop Lucro: R$ "+DoubleToString(lucro, 2)+" Risco: R$ "+DoubleToString(risco, 2)+" L/R: "+DoubleToString(p_lr, 2)+"%");
   
   //determinar o tp para operações avulsas e automatizadas
   double tpc_comp_auto = 0;//comprimento ultimo topo fundo   
   tpc_comp_auto = candle[topo[0]].high - (fundo[0]<topo[0]?candle[fundo[0+1]].low:candle[fundo[0+1]].low);
   
   janela.tpc0_auto = 5*MathRound((candle[topo[0]].high + 0.5*tpc_comp_auto*0.618)/5);
   janela.tpc161_8_auto = 5*MathRound((candle[topo[0]].high + tpc_comp_auto*0.618)/5);
   janela.tpc261_8_auto = 5*MathRound((candle[topo[0]].high + tpc_comp_auto*1.618)/5);

   janela.bs = op_valor+5;
   janela.bs_sl = op_sl;
   janela.bs_tp0 = tpc0;
   janela.bs_tp1 = tpc1;
   
   //plotar niveis
   HLineCreate(
           0,        // chart's ID
           "bs",      // line name
           0,      // subwindow index
           janela.bs,           // line price
           StringToColor("255, 255, 0"),        // line color
           STYLE_DOT, // line style
           1,           // line width
           false,        // in the background
           false,    // highlight to move
           true,       // hidden in the object list
           0         // priority for mouse click
   ); 
   

   HLineCreate(
           0,        // chart's ID
           "bs_tp0",      // line name
           0,      // subwindow index
           janela.bs_tp0,           // line price
           StringToColor("255, 255, 0"),        // line color
           STYLE_DOT, // line style
           1,           // line width
           false,        // in the background
           false,    // highlight to move
           true,       // hidden in the object list
           0         // priority for mouse click
   ); 
   


   HLineCreate(
           0,        // chart's ID
           "bs_tp1",      // line name
           0,      // subwindow index
           janela.bs_tp1,           // line price
           StringToColor("255, 255, 0"),        // line color
           STYLE_DOT, // line style
           1,           // line width
           false,        // in the background
           false,    // highlight to move
           true,       // hidden in the object list
           0         // priority for mouse click
   ); 
   
    
   
   //plotar reduçoes
   etiqueta_colorida("Primeira Redução.", candle[zero].close+(janela.bs - candle[zero].close)*0.5, "255, 0, 255");
   
   HLineCreate(
           0,        // chart's ID
           "Primeira Redução",      // line name
           0,      // subwindow index
           candle[zero].close+(janela.bs - candle[zero].close)*0.5,           // line price
           StringToColor("255, 0, 255"),        // line color
           STYLE_DOT, // line style
           1,           // line width
           false,        // in the background
           false,    // highlight to move
           true,       // hidden in the object list
           0         // priority for mouse click
   ); 
   
   etiqueta_colorida("Segunda Redução.", candle[zero].close+(janela.bs_tp0 - candle[zero].close)*0.5, "255, 0, 255");
   HLineCreate(
           0,        // chart's ID
           "Segunda Redução",      // line name
           0,      // subwindow index
           candle[zero].close+(janela.bs_tp0 - candle[zero].close)*0.5,           // line price
           StringToColor("255, 0, 255"),        // line color
           STYLE_DOT, // line style
           1,           // line width
           false,        // in the background
           false,    // highlight to move
           true,       // hidden in the object list
           0         // priority for mouse click
   ); 
   
//plotar fechamento   

   HLineCreate(
           0,        // chart's ID
           "Fechamento",      // line name
           0,      // subwindow index
           candle[zero].close,           // line price
           StringToColor("0, 255, 0"),        // line color
           STYLE_DOT, // line style
           1,           // line width
           false,        // in the background
           false,    // highlight to move
           true,       // hidden in the object list
           0         // priority for mouse click
   ); 
   


   

//Operação de venda
   
   iop_valor = suporte;
   op_valor = candle[fundo[iop_valor]].low;
   
   iop_sl = resistencia; //suporte+(topo[0]<fundo[0] ? 0 : 0);
   op_sl = candle[topo[iop_sl]].high;
   
   op_tp0 = (op_valor - op_sl)*0.618 + op_valor;
   op_tp1 = (op_valor - op_sl)*1.618 + op_valor;

   janela.m_preco2.Text("Preço no supore ["+ suporte +"]="+DoubleToString(op_valor, 0));
   janela.m_stop2.Text("Perda máxima na resistencia ["+ iop_sl +"]="+DoubleToString(op_sl, 0));

   double tpv0 = op_tp0;
   tpv0 = 5*MathRound(tpv0/5);
   //janela.m_tp2.Text("Lucro Máximo="+DoubleToString(tpv0, 0));

   double tpv1 = op_tp1;
   tpv1 = 5*MathRound(tpv1/5);
   janela.m_tp2.Text("Lucro Máximo="+DoubleToString(tpv1, 0));

   lucro = -(tpv1-op_valor)*0.2;
   risco = (op_sl-op_valor)*0.2;
   p_lr = 100*lucro/risco;
   janela.m_label3.Text("Sell Stop Lucro: R$ "+DoubleToString(lucro, 2)+" Risco: R$ "+DoubleToString(risco, 2)+" L/R: "+DoubleToString(p_lr, 2)+"%");
   
   //determinar o tp para operações avulsas e automatizadas
   double tpv_comp_auto = 0;//comprimento ultimo topo fundo   

   tpv_comp_auto = fundo[0]<topo[0]?candle[topo[0]].high - candle[fundo[0]].low:candle[topo[0+1]].high - candle[fundo[0]].low;

   
   janela.tpv0_auto = 5*MathRound((candle[fundo[0]].low - 0.5*tpc_comp_auto*0.618)/5);
   janela.tpv161_8_auto = 5*MathRound((candle[fundo[0]].low - tpc_comp_auto*0.618)/5);
   janela.tpv261_8_auto = 5*MathRound((candle[fundo[0]].low - tpc_comp_auto*1.618)/5);

   janela.ss = op_valor-5;
   janela.ss_sl = op_sl;
   janela.ss_tp0 = tpv0;
   janela.ss_tp1 = tpv1;
   
 
 
   
   //plotar niveis
   HLineCreate(
           0,        // chart's ID
           "ss",      // line name
           0,      // subwindow index
           janela.ss,           // line price
           StringToColor("255, 255, 0"),        // line color
           STYLE_DOT, // line style
           1,           // line width
           false,        // in the background
           false,    // highlight to move
           true,       // hidden in the object list
           0         // priority for mouse click
   ); 

   

   HLineCreate(
           0,        // chart's ID
           "ss_tp0",      // line name
           0,      // subwindow index
           janela.ss_tp0,           // line price
           StringToColor("255, 255, 0"),        // line color
           STYLE_DOT, // line style
           1,           // line width
           false,        // in the background
           false,    // highlight to move
           true,       // hidden in the object list
           0         // priority for mouse click
   ); 
   

   HLineCreate(
           0,        // chart's ID
           "ss_tp1",      // line name
           0,      // subwindow index
           janela.ss_tp1,           // line price
           StringToColor("255, 255, 0"),        // line color
           STYLE_DOT, // line style
           1,           // line width
           false,        // in the background
           false,    // highlight to move
           true,       // hidden in the object list
           0         // priority for mouse click
   ); 

   
   //plotar stops
   etiqueta_colorida("Primrira Redução.", candle[zero].close + (janela.ss - candle[zero].close)*0.5, "255, 0, 255");
   HLineCreate(
           0,        // chart's ID
           "Primrira Redução",      // line name
           0,      // subwindow index
           candle[zero].close + (janela.ss - candle[zero].close)*0.5,           // line price
           StringToColor("255, 0, 255"),        // line color
           STYLE_DOT, // line style
           1,           // line width
           false,        // in the background
           false,    // highlight to move
           true,       // hidden in the object list
           0         // priority for mouse click
   ); 

   
   etiqueta_colorida("Segunda Redução.", candle[zero].close + (janela.ss_tp0 - candle[zero].close)*0.5, "255, 0, 255");
   HLineCreate(
           0,        // chart's ID
           "Segunda Redução",      // line name
           0,      // subwindow index
           candle[zero].close + (janela.ss_tp0 - candle[zero].close)*0.5,           // line price
           StringToColor("255, 0, 255"),        // line color
           STYLE_DOT, // line style
           1,           // line width
           false,        // in the background
           false,    // highlight to move
           true,       // hidden in the object list
           0         // priority for mouse click
   ); 
   


   
   
//TRADES AUTOMATIZADOS

//mostrar risco e lucro atual

   janela.m_indicador1.Text(
   
      "Buy: L=R$"+DoubleToString((janela.bs_tp0-candle[zero].close)*0.2, 2)+
      " / R="+DoubleToString((candle[zero].close-janela.bs_sl)*0.2, 2)
   
   );

   janela.m_indicador1a.Text(
   
      "Sell: L=R$"+DoubleToString((candle[zero].close-janela.ss_tp0)*0.2, 2)+
      " / R="+DoubleToString((janela.ss_sl-candle[zero].close)*0.2, 2)
   
   );




   comprar = 100*comprar/resumo;
   vender = 100*vender/resumo;
   
//atualizar indice do trade

   //pegando o indice da posição automatizada
   if( (position.Select(_Symbol)) ){
      indice_posicao = StringToInteger(StringSubstr(position.Comment(), 3, 4));//StringLen(position.Comment())-3));   
   }
   
   //Print("posicao="+indice_posicao+" oportunidade="+indice_oportunidade);
   
   int limite_trade=60;

   if(janela.m_button3.Pressed())//se esta no automatico
   if(comprar >= limite_trade){
      PlaySound("c:\compra.ogg");
   
      if (comprar_anterior<limite_trade){
         indice_oportunidade++; 
         
      }
      
      
      //verificar posições em aberto
      if( (position.Select(_Symbol))){
         if (position.PositionType() == POSITION_TYPE_BUY){//se a posição for de compra
            //verificar se ja tem 3 volumes
            if(position.Volume()>=3){
            }else{
               if(indice_oportunidade!=indice_posicao)//nos comentarios acerscentamos o indice da posição e a proxima resistencia apos a abertura
               trade.Buy(3-position.Volume(), _Symbol, 0, janela.bs_sl, janela.bs_tp0, "NsC"+numero_i_str(indice_oportunidade, 4)+numero_r_str(janela.bs, 10));
               
            }
         
         }else{//se a posição aberta for vendida ela deve ser stopada
            trade.PositionClose(_Symbol);
         }
      }else{//se não houver posição em aberto abrir 3 compradas
         if(indice_oportunidade!=indice_posicao)//nos comentarios acerscentamos o indice da posição e a proxima resistencia apos a abertura
         trade.Buy(3, _Symbol, 0, janela.bs_sl, janela.bs_tp0, "NsC"+numero_i_str(indice_oportunidade, 4)+numero_r_str(janela.bs, 10));
      
      }
     
   
   }else
   if(vender >= limite_trade){
      PlaySound("c:\vende.ogg");
   
      if(vender_anterior < limite_trade){indice_oportunidade++;}
      vender_anterior = vender;
 
      //verificar posições em aberto
      if( (position.Select(_Symbol))){
         if (position.PositionType() != POSITION_TYPE_BUY){//se a posição for de compra
            //verificar se ja tem 3 volumes
            if(position.Volume()>=3){
            }else{
               if(indice_oportunidade!=indice_posicao)//nos comentarios acerscentamos o indice da posição e a proxima resistencia apos a abertura
               trade.Sell(3-position.Volume(), _Symbol, 0, janela.ss_sl, janela.ss_tp0, "NsV"+numero_i_str(indice_oportunidade, 4)+numero_r_str(janela.ss, 10));
               
            }
         
         }else{//se a posição aberta for vendida ela deve ser stopada
            trade.PositionClose(_Symbol);
         }
      }else{//se não houver posição em aberto abrir 3 compradas
         if(indice_oportunidade!=indice_posicao)//nos comentarios acerscentamos o indice da posição e a proxima resistencia apos a abertura
         trade.Sell(3, _Symbol, 0, janela.ss_sl, janela.ss_tp0, "NsV"+numero_i_str(indice_oportunidade, 4)+numero_r_str(janela.ss, 10));
      
      }
   
   }
   
   comprar_anterior = comprar;
   vender_anterior = vender;
   
   
   janela.m_label1.Text("z="+IntegerToString(zero_1min) +", "+IntegerToString(zero_5min) +", "+IntegerToString(zero_15min) +", "+IntegerToString(zero_30min) +", "+ " tf=" + tf + " " + (fundo[0]<topo[0] ? "FP" : "TP")+" "+"P"+indice_posicao+"!O"+indice_oportunidade);

   
   

   
   
//mantendo o stop loss das posições na ultima resistencia / suporte e as reduções em tp0 e 1/2 tp0

   if( (position.Select(_Symbol))&&(janela.m_autostop.Pressed()) ){
   
   //position.Select(_Symbol);

   double novo_sl=0;
   double ordem_bs;
   ordem_bs = position.PriceOpen();
   
   double ordem_tp;
   ordem_tp = position.TakeProfit();
   
   double ordem_sl;
   ordem_sl = position.StopLoss();
   
   double ordem_tp0;
   //valor calculdo diferente pra compra ou venda
   
   if (position.PositionType() == POSITION_TYPE_BUY){
   
      
   
      if (novo_sl == 0){  
         novo_sl = candle[fundo[0]].low;
      }
      
      
      
   
      if ((position.TakeProfit()!=0)){//se o tp nao e zero
         double red0 = position.PriceOpen() + 0.5*(position.TakeProfit() - position.PriceOpen())*0.618;
         if ( (position.PriceCurrent()+5) >= red0 ){
            novo_sl = position.PriceOpen() + 5;     
         }
      
      }   
      
      if (novo_sl < candle[fundo[0]].low){  
         novo_sl = candle[fundo[0]].low;
      }
      
      
      //janela.comentarios.Text("novo="+novo_sl+ " - atual="+position.StopLoss() );
      
      
      if (novo_sl > position.StopLoss() || (position.StopLoss()==0)){
         atualizaposicoes(position.TakeProfit(), novo_sl);
      }
      
      
      // ********* REDUÇÕES ******
      //Agora uma vez posicionado vamos fazer as reduções

      
      //Primeiro verificamos se e uma estrategia nilex sossegado
      if(StringSubstr(position.Comment(), 0, 3)=="NsC"){
         //agora verificar se tem um tp definido 
         if (position.TakeProfit() > 0){


            //a primeira redução sera entre o preço de abertura e a proxima resistencia
            double pr = 5*MathRound((position.PriceOpen() + 0.5*(janela.bs-position.PriceOpen()))/5);//primeira redução
            pr = (pr-position.PriceOpen())<50?position.PriceOpen()+50:pr;
            //a segunda entre a abertura e o take profite
            double sr = 5*MathRound((position.PriceOpen() + 0.5*(position.TakeProfit()-position.PriceOpen()))/5);//segunda redução
      
            //colocar linhas horizontais nas reduções
            etiqueta_colorida("Primeira Redução.", pr, "255, 0, 255");
            HLineCreate(
                    0,        // chart's ID
                    "Primeira Redução",      // line name
                    0,      // subwindow index
                    pr,           // line price
                    StringToColor("255, 0, 255"),        // line color
                    STYLE_DOT, // line style
                    1,           // line width
                    true,        // in the background
                    false,    // highlight to move
                    true,       // hidden in the object list
                    0         // priority for mouse click
            ); 
                  
            etiqueta_colorida("Segunda Redução.", sr, "255, 0, 255");
            HLineCreate(
                    0,        // chart's ID
                    "Segunda Redução",      // line name
                    0,      // subwindow index
                    sr,           // line price
                    StringToColor("255, 0, 255"),        // line color
                    STYLE_DOT, // line style
                    1,           // line width
                    true,        // in the background
                    false,    // highlight to move
                    true,       // hidden in the object list
                    0         // priority for mouse click
            );       


            //se forem 3 ou mais contratos abertos
            if(position.Volume()>= 3){
               //com 3 posições fazemos a primeira redução
               if(position.PriceCurrent()>=(pr)) {
                  //trade.PositionClosePartial(_Symbol, 1);
                  Print("Quero reduzir de 3 pra 2");
                  trade.Sell(1, _Symbol, 0, position.StopLoss(), position.TakeProfit(), position.Comment());
               }
            }else if(position.Volume()> 1){//com o numero de volumes menor q 3 e maior que 1 (ou seja são dois) reduzimos mais um
                                             //deixando o ultimo atingir TP ou sl
               if(position.PriceCurrent()>=(sr)){
                  
                  //trade.PositionClosePartial(_Symbol, 1);
                  Print("Quero reduzir de 2 pra 1");
                  trade.Sell(1, _Symbol, 0, position.StopLoss(), position.TakeProfit(), position.Comment());
               }
               
            }
         }  
      }
      
      
      
   
   
   }else{// se for de venda
   

 
      if (novo_sl == 0){  
         novo_sl = candle[topo[resistencia]].high;
      }
      
      
   


      if ((position.TakeProfit()!=0)){//se o tp nao e zero
         double red0 = position.PriceOpen() + 0.5*(position.TakeProfit() - position.PriceOpen())*0.618;
         if ( (position.PriceCurrent()-5) <= (red0) ){
            novo_sl = position.PriceOpen() - 5;     
         }
      
      }   
      
      if (novo_sl > candle[topo[resistencia]].high){  
         novo_sl = candle[topo[resistencia]].high;
      }
      
      
      //janela.comentarios.Text("novo="+novo_sl+ " - atual="+position.StopLoss() );
      
      
      if (novo_sl < position.StopLoss() || (position.StopLoss()==0)){
         atualizaposicoes(position.TakeProfit(), novo_sl);
      }
      
      
   }
   
   
   
      // ********* REDUÇÕES ******
      //Agora uma vez posicionado vamos fazer as reduções
      //Primeiro verificamos se e uma estrategia nilex sossegado
      if(StringSubstr(position.Comment(), 0, 3)=="NsV"){
      
         //agora verificar se tem um tp definido 
         if (position.TakeProfit() > 0){

            

            //a primeira redução sera entre o preço de abertura e o proximo suporte
            double pr = 5*MathRound((position.PriceOpen() + 0.5*(janela.ss-position.PriceOpen()))/5);//primeira redução
            pr= (position.PriceOpen()-pr)<50?position.PriceOpen()-50:pr;
            //a segunda entre a abertura e o take profite
            double sr = 5*MathRound((position.PriceOpen() + 0.5*(position.TakeProfit()-position.PriceOpen()))/5);//segunda redução

      
            //colocar linhas horizontais nas reduções
            etiqueta_colorida("Segunda Redução.", pr, "255, 0, 255");
            HLineCreate(
                    0,        // chart's ID
                    "Primeira Redução",      // line name
                    0,      // subwindow index
                    pr,           // line price
                    StringToColor("255, 0, 255"),        // line color
                    STYLE_DOT, // line style
                    1,           // line width
                    true,        // in the background
                    false,    // highlight to move
                    true,       // hidden in the object list
                    0         // priority for mouse click
            );       
            
            etiqueta_colorida("Segunda Redução.", sr, "255, 0, 255");
            HLineCreate(
                    0,        // chart's ID
                    "Segunda Redução",      // line name
                    0,      // subwindow index
                    sr,           // line price
                    StringToColor("255, 0, 255"),        // line color
                    STYLE_DOT, // line style
                    1,           // line width
                    true,        // in the background
                    false,    // highlight to move
                    true,       // hidden in the object list
                    0         // priority for mouse click
            );       



            //se forem 3 ou mais contratos abertos
            if(position.Volume()>= 3){
               //com 3 posições fazemos a primeira redução
               if(position.PriceCurrent()<=(pr)) {
                  //trade.PositionClosePartial(_Symbol, 1);
                  Print("Quero reduzir de 3 pra 2");
                  trade.Buy(1, _Symbol, 0, position.StopLoss(), position.TakeProfit(), position.Comment());
               }
            }else if(position.Volume()> 1){//com o numero de volumes menor q 3 e maior que 1 (ou seja são dois) reduzimos mais um
                                             //deixando o ultimo atingir TP ou sl
               if(position.PriceCurrent()<=(sr)){
                  
                  //trade.PositionClosePartial(_Symbol, 1);
                  Print("Quero reduzir de 2 pra 1");
                  trade.Buy(1, _Symbol, 0, position.StopLoss(), position.TakeProfit(), position.Comment());
               }
               
            }
         }  
      }
      
      
      

    
   
   
   
   
   
   }
   
   

   
   
   
   //atualizando informações para analise
   if( (position.Select(_Symbol)) ){
  
   
      janela.m_reduzir.Text("Reduzir 1 de "+DoubleToString( position.Volume(), 2));
   
      janela.comentarios.Text("Temos "+ DoubleToString( position.Volume(), 2) + 
         (position.Volume() == 1 ? " posição " : " posições ") + 
         (position.PositionType() == 0 ? " Comprado " : " Vendido ") +
         " " 
            
         + 
            (position.StopLoss()==0?" com risco Indeterminado " :
               (position.PositionType() == POSITION_TYPE_BUY) && (position.StopLoss()>=position.PriceOpen())?" Sem risco ":
                  (position.PositionType() == POSITION_TYPE_SELL) && (position.StopLoss()<=position.PriceOpen())?" Sem risco ":
                     " com risco R$"+DoubleToString( (position.PriceOpen()- position.StopLoss())* 0.2* position.Volume(),2)) +
         ""
         
         );
   
      janela.comentarios2.Text("Lucro atual "+ DoubleToString( position.Profit(), 2) + 
         ""
         
         );
   }else{
   
      janela.comentarios.Text("Não estamos posicionados");
      janela.comentarios2.Text("Lucro atual "+ "");
      janela.m_reduzir.Text("Não Posicionado");
   
   }

 
 
 
   
   


   
   
   
   
   


//--- redesenhar o gráfico e esperar por um segundo
   ChartRedraw();


}



//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();


//--- destrói o diálogo
//AppWindow.Destroy(reason);

//--- destroy dialog
   janela.Destroy(reason);


  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()

  {
//---
//Criar uma barra pra ser a zero

   int barra;
   barra = (MathRand()%9)+(MathRand()%9);
//barra = 3;
   //Print(IntegerToString(barra));
   marcadores();
   recorrente(barra);
   //Print("ontimer");

  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
  
  
//---
//Criar uma barra pra ser a zero

   int barra;
   barra = (MathRand()%9)+(MathRand()%9);
//barra = 3;
   //Print(IntegerToString(barra));
   recorrente(barra);
   //Print("ontimer");

  }
//+------------------------------------------------------------------+
//| Trade function                                                   |
//+------------------------------------------------------------------+
void OnTrade()
  {
//---

  }
//+------------------------------------------------------------------+
//| TradeTransaction function                                        |
//+------------------------------------------------------------------+
void OnTradeTransaction(const MqlTradeTransaction& trans,
                        const MqlTradeRequest& request,
                        const MqlTradeResult& result)
  {
//---

  }
//+------------------------------------------------------------------+
//| Tester function                                                  |
//+------------------------------------------------------------------+
double OnTester()
  {
//---
   double ret=0.0;
//---

//---
   return(ret);
  }
//+------------------------------------------------------------------+
//| TesterInit function                                              |
//+------------------------------------------------------------------+
void OnTesterInit()
  {
//---

  }
//+------------------------------------------------------------------+
//| TesterPass function                                              |
//+------------------------------------------------------------------+
void OnTesterPass()
  {
//---

  }
//+------------------------------------------------------------------+
//| TesterDeinit function                                            |
//+------------------------------------------------------------------+
void OnTesterDeinit()
  {
//---

  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---

//AppWindow.ChartEvent(id,lparam,dparam,sparam);

   janela.ChartEvent(id,lparam,dparam,sparam);



  }
//+------------------------------------------------------------------+
//| BookEvent function                                               |
//+------------------------------------------------------------------+
void OnBookEvent(const string &symbol)
  {
//---

  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
