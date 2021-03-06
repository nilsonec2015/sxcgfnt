//+------------------------------------------------------------------+
//|                                              linha_tendencia.mqh |
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

void trend1(string nome, datetime t1, double p1, datetime t2, double p2){

      TrendCreate(
         0,        // ID do gráfico
         nome,  // nome da linha
         0,      // índice da sub-janela
         t1,           // primeiro ponto de tempo
         p1,          // primeiro ponto de preço
         t2,           // segundo ponto de tempo
         p2,          // segundo ponto de preço
         StringToColor("255,0,255"),        // cor da linha
         STYLE_SOLID, // estilo da linha
         1,           // largura da linha
         false,        // no fundo
         false,    // destaque para mover
         false,    // continuação da linha para a esquerda
         false,   // continuação da linha para a direita
         true,       //ocultar na lista de objetos
         0); 


}



//+------------------------------------------------------------------+
//| Criar uma linha de tendência pelas coordenadas fornecidas        |
//+------------------------------------------------------------------+
bool TrendCreate(const long            chart_ID=0,        // ID do gráfico
                 const string          name="TrendLine",  // nome da linha
                 const int             sub_window=0,      // índice da sub-janela
                 datetime              time1=0,           // primeiro ponto de tempo
                 double                price1=0,          // primeiro ponto de preço
                 datetime              time2=0,           // segundo ponto de tempo
                 double                price2=0,          // segundo ponto de preço
                 const color           clr=clrRed,        // cor da linha
                 const ENUM_LINE_STYLE style=STYLE_SOLID, // estilo da linha
                 const int             width=1,           // largura da linha
                 const bool            back=false,        // no fundo
                 const bool            selection=true,    // destaque para mover
                 const bool            ray_left=false,    // continuação da linha para a esquerda
                 const bool            ray_right=false,   // continuação da linha para a direita
                 const bool            hidden=true,       //ocultar na lista de objetos
                 const long            z_order=0)         // prioridade para clique do mouse
  {
  
//se a linha ja existir executar a função move
   if (!ObjectFind(0, name)){
      movelinha(0, name, time1, price1, time2, price2);
      return true;
      
      Print("criando", name);
   
   
   
   }  
  
//--- definir coordenadas de pontos de ancoragem, se eles não estão definidos
   ChangeTrendEmptyPoints(time1,price1,time2,price2);
//--- redefine o valor de erro
   ResetLastError();
//--- criar uma linha de tendência pelas coordenadas fornecidas
   if(!ObjectCreate(chart_ID,name,OBJ_TREND,sub_window,time1,price1,time2,price2))
     {
      Print(__FUNCTION__,
            ": falha ao criar uma linha de tendência! Código de erro = ",GetLastError());
      return(false);
     }
//--- definir cor da linha
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- definir o estilo de exibição da linha
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
//--- definir a largura da linha
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width);
//--- exibir em primeiro plano (false) ou fundo (true)
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- habilitar (true) ou desabilitar (false) o modo do movimento da seta com o mouse
//--- ao criar um objeto gráfico usando a função ObjectCreate, o objeto não pode ser
//--- destacado e movimentado por padrão. Dentro deste método, o parâmetro de seleção
//--- é verdade por padrão, tornando possível destacar e mover o objeto
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- habilitar (true) ou desabilitar (false) o modo de continuação da exibição da linha à esquerda
   ObjectSetInteger(chart_ID,name,OBJPROP_RAY_LEFT,ray_left);
//--- habilitar (true) ou desabilitar (false) o modo de continuação da exibição da linha à direita
   ObjectSetInteger(chart_ID,name,OBJPROP_RAY_RIGHT,ray_right);
//--- ocultar (true) ou exibir (false) o nome do objeto gráfico na lista de objeto 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- definir a prioridade para receber o evento com um clique do mouse no gráfico
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- sucesso na execução
   return(true);
  }
//+------------------------------------------------------------------+
//| Mover o ponto de ancoragem da linha de tendência                 |
//+------------------------------------------------------------------+
bool TrendPointChange(const long   chart_ID=0,       // ID do gráfico
                      const string name="TrendLine", // nome da linha
                      const int    point_index=0,    // índice do ponto de ancoragem
                      datetime     time=0,           // coordenada do ponto de ancoragem de tempo
                      double       price=0)          // coordenada do ponto de ancoragem de preço
  {
//--- se a posição do ponto não está definida, mover para a barra atual tendo o preço Bid
   if(!time)
      time=TimeCurrent();
   if(!price)
      price=SymbolInfoDouble(Symbol(),SYMBOL_BID);
//--- redefine o valor de erro
   ResetLastError();
//--- mover ponto de ancoragem da linha de tendência
   if(!ObjectMove(chart_ID,name,point_index,time,price))
     {
      Print(__FUNCTION__,
            ": falha ao mover o ponto de ancoragem! Código de erro = ",GetLastError());
      return(false);
     }
//--- sucesso na execução
   return(true);
  }
  
bool movelinha(const long   chart_ID=0,       // ID do gráfico
                      const string name="TrendLine", // nome da linha
                      datetime     time=0,           // coordenada do ponto de ancoragem de tempo
                      double       price=0,          // coordenada do ponto de ancoragem de preço
                      datetime     time2=0,           // coordenada do ponto de ancoragem de tempo
                      double       price2=0)          // coordenada do ponto de ancoragem de preço
  {
//--- se a posição do ponto não está definida, mover para a barra atual tendo o preço Bid
   if(!time)
      time=TimeCurrent();
   if(!price)
      price=SymbolInfoDouble(Symbol(),SYMBOL_BID);
//--- redefine o valor de erro
   ResetLastError();
//--- mover ponto de ancoragem da linha de tendência
   int    point_index=0;
   if(!ObjectMove(chart_ID,name,point_index,time,price))
     {
      Print(__FUNCTION__,
            ": falha ao mover o ponto de ancoragem! Código de erro = ",GetLastError());
      return(false);
     }
//--- mover ponto de ancoragem da linha de tendência
   point_index=1;
   if(!ObjectMove(chart_ID,name,point_index,time2,price2))
     {
      Print(__FUNCTION__,
            ": falha ao mover o ponto de ancoragem! Código de erro = ",GetLastError());
      return(false);
     }
//--- sucesso na execução
   return(true);
  }
  
//+------------------------------------------------------------------+
//| A função exclui a linha de tendência do gráfico.                 |
//+------------------------------------------------------------------+
bool TrendDelete(const long   chart_ID=0,       // ID do gráfico
                 const string name="TrendLine") // nome da linha
  {
//--- redefine o valor de erro
   ResetLastError();
//--- excluir uma linha de tendência
   if(!ObjectDelete(chart_ID,name))
     {
      Print(__FUNCTION__,
            ": falha ao excluir uma linha de tendência! Código de erro = ",GetLastError());
      return(false);
     }
//--- sucesso na execução
   return(true);
  }
//+------------------------------------------------------------------+
//| Verifique os valores de pontos de ancoragem da linha de tendência|
//| e definir padrões valores padrão para aqueles vazios             |
//+------------------------------------------------------------------+
void ChangeTrendEmptyPoints(datetime &time1,double &price1,
                            datetime &time2,double &price2)
  {
//--- se o tempo do primeiro ponto não está definido, será na barra atual
   if(!time1)
      time1=TimeCurrent();
//--- se o preço do primeiro ponto não está definido, ele terá valor Bid
   if(!price1)
      price1=SymbolInfoDouble(Symbol(),SYMBOL_BID);
//--- se o tempo do segundo ponto não está definido, está localizado a 9 barras deixadas a partir da segunda
   if(!time2)
     {
      //--- array para receber o tempo de abertura das últimos 10 barras
      datetime temp[10];
      CopyTime(Symbol(),Period(),time1,10,temp);
      //--- definir o segundo ponto 9 barras a esquerda do primeiro
      time2=temp[0];
     }
//--- se o preço do segundo ponto não está definido, é igual ao primeiro ponto
   if(!price2)
      price2=price1;
  }