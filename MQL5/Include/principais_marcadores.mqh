//+------------------------------------------------------------------+
//|                                        principais_marcadores.mqh |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#include "../include/etiqpreco.mqh"
#include "../include/hline.mqh"
#include "../include/vline.mqh"
#include "../include/obj_text.mqh"


#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
// #define MacrosHello   "Hello, world!"
// #define MacrosYear    2010
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
void etiqueta1(string name, double price){

    ArrowLeftPriceCreate(            
                                    0,        // ID do gráfico
                                    name,  // nome da etiqueta de preço
                                    0,      // índice da sub-janela
                                    0,            // ponto de ancoragem do tempo
                                    price,           // ponto de ancoragem do preço
                                    StringToColor("255,255,255"),        // cor da etiqueta de preço
                                    STYLE_SOLID, // estilo de linha da borda
                                    1,           // tamanho da etiqueta de preço
                          false,        // no fundo
                          false,    // destaque para mover
                          true,       // ocultar na lista de objetos
                          0);         // prioridade para clicar no mouse



}

void etiqueta_colorida(string name, double price, string cor){

    ArrowLeftPriceCreate(            
                                    0,        // ID do gráfico
                                    name,  // nome da etiqueta de preço
                                    0,      // índice da sub-janela
                                    0,            // ponto de ancoragem do tempo
                                    price,           // ponto de ancoragem do preço
                                    StringToColor(cor),        // cor da etiqueta de preço
                                    STYLE_SOLID, // estilo de linha da borda
                                    1,           // tamanho da etiqueta de preço
                          false,        // no fundo
                          false,    // destaque para mover
                          true,       // ocultar na lista de objetos
                          0);         // prioridade para clicar no mouse



}

void linha1(string name, double price){

            //colocar linhas horizontais nas reduções
            HLineCreate(
                    0,        // chart's ID
                    name,      // line name
                    0,      // subwindow index
                    price,           // line price
                    StringToColor("255, 255, 255"),        // line color
                    STYLE_DOT, // line style
                    1,           // line width
                    true,        // in the background
                    false,    // highlight to move
                    true,       // hidden in the object list
                    0         // priority for mouse click
            ); 



}
void linha2(string name, double price){

            //colocar linhas horizontais nas reduções
            HLineCreate(
                    0,        // chart's ID
                    name,      // line name
                    0,      // subwindow index
                    price,           // line price
                    StringToColor("255, 255, 255"),        // line color
                    STYLE_DOT, // line style
                    1,           // line width
                    true,        // in the background
                    false,    // highlight to move
                    true,       // hidden in the object list
                    0         // priority for mouse click
            ); 



}
void linha3(string name, double price){

            //colocar linhas horizontais nas reduções
            HLineCreate(
                    0,        // chart's ID
                    name,      // line name
                    0,      // subwindow index
                    price,           // line price
                    StringToColor("100, 100, 100"),        // line color
                    STYLE_DOT, // line style
                    3,           // line width
                    true,        // in the background
                    false,    // highlight to move
                    true,       // hidden in the object list
                    0         // priority for mouse click
            ); 



}


void linha_sl(string name, double price){

            //colocar linhas horizontais nas reduções
            HLineCreate(
                    0,        // chart's ID
                    name,      // line name
                    0,      // subwindow index
                    price,           // line price
                    StringToColor("255, 0, 0"),        // line color
                    STYLE_SOLID, // line style
                    3,           // line width
                    false,        // in the background
                    true,    // highlight to move
                    false,       // hidden in the object list
                    0         // priority for mouse click
            ); 



}
void linha_tp(string name, double price){

            //colocar linhas horizontais nas reduções
            HLineCreate(
                    0,        // chart's ID
                    name,      // line name
                    0,      // subwindow index
                    price,           // line price
                    StringToColor("0, 0, 255"),        // line color
                    STYLE_SOLID, // line style
                    3,           // line width
                    false,        // in the background
                    true,    // highlight to move
                    false,       // hidden in the object list
                    0         // priority for mouse click
            ); 



}
void linha_preco(string name, double price){

            //colocar linhas horizontais nas reduções
            HLineCreate(
                    0,        // chart's ID
                    name,      // line name
                    0,      // subwindow index
                    price,           // line price
                    StringToColor("0, 180, 0"),        // line color
                    STYLE_SOLID, // line style
                    3,           // line width
                    false,        // in the background
                    true,    // highlight to move
                    false,       // hidden in the object list
                    0         // priority for mouse click
            ); 



}

void texto1(string nome, double preco, string texto){

   TextCreate(
                0,               // ID do gráfico
                nome,              // nome do objeto
                0,             // índice da sub-janela
                0,                   // ponto de ancoragem do tempo
                preco,                  // ponto de ancoragem do preço
                texto,              // o próprio texto
                "Arial",             // fonte
                10,             // tamanho da fonte
                StringToColor("255, 255, 255"),               // cor
                0.0,                // inclinação do texto
                ANCHOR_RIGHT_UPPER, // tipo de ancoragem
                false,               // no fundo
                false,          // destaque para mover
                true,              // ocultar na lista de objetos
                0                // prioridade para clicar no mouse
                
                );

}

void texto2(string nome, datetime tempo, double preco, string texto, string cor){

   TextCreate(
                0,               // ID do gráfico
                nome,              // nome do objeto
                0,             // índice da sub-janela
                tempo,                   // ponto de ancoragem do tempo
                preco,                  // ponto de ancoragem do preço
                texto,              // o próprio texto
                "Arial",             // fonte
                10,             // tamanho da fonte
                StringToColor(cor),               // cor
                90.0,                // inclinação do texto
                ANCHOR_CENTER, // tipo de ancoragem
                false,               // no fundo
                false,          // destaque para mover
                true,              // ocultar na lista de objetos
                0                // prioridade para clicar no mouse
                
                );

}






void marcadores(void){
   MqlRates candle_diario[];
   int hma200;
   double ma200[];
   
   ArraySetAsSeries(candle_diario,true);
   
   int copied=CopyRates(Symbol(),PERIOD_D1,0,2,candle_diario);
   
   if (copied>0){
      
      linha1("Maxima de Ontem", candle_diario[1].high);
      etiqueta1("Maxima de Ontem.", candle_diario[1].high);
      texto1("Max Ontem", candle_diario[1].high, "Maxima de Ontem");
      
      linha1("Minima de Ontem", candle_diario[1].low);
      etiqueta1("Minima de Ontem.", candle_diario[1].low);
      texto1("Min Ontem", candle_diario[1].low, "Minima de Ontem");
      
      linha1("Fechamanto de Ontem", candle_diario[1].close);
      etiqueta1("Fechamanto de Ontem.", candle_diario[1].close);
      texto1("Fec Ontem", candle_diario[1].close, "Fechamanto de Ontem");
      
      linha1("Maxima de Hoje", candle_diario[0].high);
      etiqueta1("Maxima de Hoje.", candle_diario[0].high);
      texto1("Max Hoje", candle_diario[0].high, "Maxima de Hoje");
      
      linha1("Minima de Hoje", candle_diario[0].low);
      etiqueta1("Minima de Hoje.", candle_diario[0].low);
      texto1("Min Hoje", candle_diario[0].low, "Minima de Hoje");
      
      linha1("Abertura de Hoje", candle_diario[0].open);
      etiqueta1("Abertura de Hoje.", candle_diario[0].open);
      texto1("Abert Hoje", candle_diario[0].open, "Abertura de Hoje");
      
      //media de 200
      
      hma200=iMA(_Symbol,0,200,0,MODE_SMA,PRICE_CLOSE);
      CopyBuffer(hma200,0,0,1,ma200);
      ArraySetAsSeries(ma200,true);
      linha3("Média 200", ma200[0]);
      etiqueta1("Média 200.", ma200[0]);
      
   
   }
   
/*   
   //colocando abertura do mercado de ações
   MqlDateTime horma;
   TimeToStruct(TimeCurrent(), horma);
   horma.hour = 10;
   horma.day = 2;
   horma.min = 0;
   horma.sec = 0;
   
   VLineCreate(
         0,// ID do gráfico
         "Abertura do Mercado de Ações",// nome da linha
         0,// índice da sub-janela
         StructToTime(horma),// tempo da linha
         StringToColor("255,255,255"),// cor da linha
         0,// estilo da linha
         1,// largura da linha
         false,// no fundo
         false,// destaque para mover
         true, // continuação da linha para baixo
         true,//ocultar na lista de objetos
         0     // prioridade para clique do mouse
      );
*/  



}