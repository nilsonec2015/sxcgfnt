//+------------------------------------------------------------------+
//|                                                    seta_cima.mqh |
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
//+------------------------------------------------------------------+
//| Criar sinal Arrow Up                                             |
//+------------------------------------------------------------------+
bool ArrowUpCreate(const long              chart_ID=0,           // ID do gráfico
                   const string            name="ArrowUp",       // nome do sinal
                   const int               sub_window=0,         // índice da sub-janela
                   datetime                time=0,               // ponto de ancoragem do tempo
                   double                  price=0,              // ponto de ancoragem do preço
                   const ENUM_ARROW_ANCHOR anchor=ANCHOR_BOTTOM, // tipo de ancoragem
                   const color             clr=clrRed,           // cor do sinal
                   const ENUM_LINE_STYLE   style=STYLE_SOLID,    // estilo de linha da borda
                   const int               width=3,              // tamanho do sinal
                   const bool              back=false,           // no fundo
                   const bool              selection=true,       // destaque para mover
                   const bool              hidden=true,          // ocultar na lista de objetos
                   const long              z_order=0)            // prioridade para clicar no mouse
  {
//--- definir as coordenadas de pontos de ancoragem, se eles não estão definidos
   ChangeArrowEmptyPoint(time,price);
//--- redefine o valor de erro
   ResetLastError();
//--- criar o sinal
   if(!ObjectCreate(chart_ID,name,OBJ_ARROW_UP,sub_window,time,price))
     {
      Print(__FUNCTION__,
            ": falha ao criar o sinal \"Arrow Up\"! Código de erro = ",GetLastError());
      return(false);
     }
//--- tipo de definição de ancoragem
   ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor);
//--- definir uma cor de sinal
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- definir o estilo da linha da borda
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
//--- tamanho da definição do sinal
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width);
//--- exibir em primeiro plano (false) ou fundo (true)
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- permitir (true) ou desabilitar (false) o modo de movimento do sinal com o mouse
//--- ao criar um objeto gráfico usando a função ObjectCreate, o objeto não pode ser
//--- destacado e movimentado por padrão. Dentro deste método, o parâmetro de seleção
//--- é verdade por padrão, tornando possível destacar e mover o objeto
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- ocultar (true) ou exibir (false) o nome do objeto gráfico na lista de objeto 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- definir a prioridade para receber o evento com um clique do mouse no gráfico
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- sucesso na execução
   return(true);
  }
//+------------------------------------------------------------------+
//| Mover ponto de ancoragem                                         |
//+------------------------------------------------------------------+
bool ArrowUpMove(const long   chart_ID=0,     // ID do gráfico
                 const string name="ArrowUp", // nome do objeto
                 datetime     time=0,         // coordenada do ponto de ancoragem de tempo
                 double       price=0)        // coordenada do ponto de ancoragem de preço
  {
//--- se a posição do ponto não está definida, mover para a barra atual tendo o preço Bid
   if(!time)
      time=TimeCurrent();
   if(!price)
      price=SymbolInfoDouble(Symbol(),SYMBOL_BID);
//--- redefine o valor de erro
   ResetLastError();
//--- mover o ponto de ancoragem
   if(!ObjectMove(chart_ID,name,0,time,price))
     {
      Print(__FUNCTION__,
            ": falha ao mover o ponto de ancoragem! Código de erro = ",GetLastError());
      return(false);
     }
//--- sucesso na execução
   return(true);
  }
//+------------------------------------------------------------------+
//| Alterar o tipo de ancoragem do sinal Arrow Down                  |
//+------------------------------------------------------------------+
bool ArrowUpAnchorChange(const long              chart_ID=0,        // ID do gráfico
                         const string            name="ArrowUp",    // nome do objeto
                         const ENUM_ARROW_ANCHOR anchor=ANCHOR_TOP) // tipo de ancoragem
  {
//--- redefine o valor de erro
   ResetLastError();
//--- alterar a ancoragem do ponto de locação
   if(!ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor))
     {
      Print(__FUNCTION__,
            ": falha para alterar o tipo de ancoragem! Código de erro = ",GetLastError());
      return(false);
     }
//--- sucesso na execução
   return(true);
  }
//+------------------------------------------------------------------+
//| Excluir sinal Arrow Up                                           |
//+------------------------------------------------------------------+
bool ArrowUpDelete(const long   chart_ID=0,     // ID do gráfico
                   const string name="ArrowUp") // nome sinal
  {
//--- redefine o valor de erro
   ResetLastError();
//--- excluir o sinal
   if(!ObjectDelete(chart_ID,name))
     {
      Print(__FUNCTION__,
            ": falha ao excluir o sinal \"Arrow Up\"! Código de erro = ",GetLastError());
      return(false);
     }
//--- sucesso na execução
   return(true);
  }
//+------------------------------------------------------------------+
//| Verificar valores de ponto de ancoragem e definir valores padrão |
//| para aqueles vazios                                              |
//+------------------------------------------------------------------+
void ChangeArrowEmptyPoint(datetime &time,double &price)
  {
//--- se o tempo do ponto não está definido, será na barra atual
   if(!time)
      time=TimeCurrent();
//--- se o preço do ponto não está definido, ele terá valor Bid
   if(!price)
      price=SymbolInfoDouble(Symbol(),SYMBOL_BID);
  }