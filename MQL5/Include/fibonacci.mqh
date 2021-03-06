//+------------------------------------------------------------------+
//|                                                    fibonacci.mqh |
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
//| Criar Retração Fibonacci pelas coordenadas fornecidas            |
//+------------------------------------------------------------------+
bool FiboLevelsCreate(const long            chart_ID=0,        // ID de gráfico
                      const string          name="FiboLevels", // nome do objeto
                      const int             sub_window=0,      // índice da sub-janela
                      datetime              time1=0,           // primeiro ponto de tempo 
                      double                price1=0,          // primeiro ponto de preço
                      datetime              time2=0,           // segundo ponto de tempo
                      double                price2=0,          // segundo ponto de preço
                      const color           clr=clrRed,        // cor do objeto
                      const ENUM_LINE_STYLE style=STYLE_SOLID, // estilo de linha do objeto
                      const int             width=1,           // largura da linha do objeto
                      const bool            back=false,        // no fundo
                      const bool            selection=true,    // destaque para mover
                      const bool            ray_left=false,    // continuação do objeto para a esquerda
                      const bool            ray_right=false,   // continuação do objeto para a direita
                      const bool            hidden=true,       // ocultar na lista de objetos
                      const long            z_order=0)         // prioridade para clique do mouse
  {
//--- definir coordenadas de pontos de ancoragem, se eles não estão definidos
   ChangeFiboLevelsEmptyPoints(time1,price1,time2,price2);
//--- redefine o valor de erro
   ResetLastError();
//--- Criar Retração Fibonacci pelas coordenadas fornecidas
   if(!ObjectCreate(chart_ID,name,OBJ_FIBO,sub_window,time1,price1,time2,price2))
     {
      Print(__FUNCTION__,
            ": falha para criar \"Retração Fibonacci\"! Código de erro = ",GetLastError());
      return(false);
     }
//--- definir cor
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- definir estilo de linha
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
//--- definir a largura da linha
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width);
//--- exibir em primeiro plano (false) ou fundo (true)
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- habilitar (true) ou desabilitar (false) o modo de preenchimento do canal
//--- ao criar um objeto gráfico usando a função ObjectCreate, o objeto não pode ser
//--- destacado e movimentado por padrão. Dentro deste método, o parâmetro de seleção
//--- é verdade por padrão, tornando possível destacar e mover o objeto
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- habilitar (true) ou desabilitar (false) o modo de continuação da exibição do objeto à esquerda
   ObjectSetInteger(chart_ID,name,OBJPROP_RAY_LEFT,ray_left);
//--- habilitar (true) ou desabilitar (false) o modo de continuação da exibição do objeto à direita
   ObjectSetInteger(chart_ID,name,OBJPROP_RAY_RIGHT,ray_right);
//--- ocultar (true) ou exibir (false) o nome do objeto gráfico na lista de objeto 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- definir a prioridade para receber o evento com um clique do mouse no gráfico
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- sucesso na execução
   return(true);
  }
//+------------------------------------------------------------------+
//| Definir o número de níveis e seus parâmetros                     |
//+------------------------------------------------------------------+
bool FiboLevelsSet(int             levels,            // número de linhas dos níveis
                   double          &values[],         // valores de linhas dos níveis
                   color           &colors[],         // cor das linhas dos níveis
                   ENUM_LINE_STYLE &styles[],         // estilo das linhas dos níveis
                   int             &widths[],         // largura das linhas dos níveis
                   const long      chart_ID=0,        // ID do gráfico
                   const string    name="FiboLevels") // nome do objeto
  {
//--- verificar tamanhos do array
   if(levels!=ArraySize(colors) || levels!=ArraySize(styles) ||
      levels!=ArraySize(widths) || levels!=ArraySize(widths))
     {
      Print(__FUNCTION__,": comprimento do array não corresponder ao número de níveis, erro!");
      return(false);
     }
//--- definir o número de níveis
   ObjectSetInteger(chart_ID,name,OBJPROP_LEVELS,levels);
//--- definir as propriedades de níveis no loop
   for(int i=0;i<levels;i++)
     {
      //--- valor do nível
      ObjectSetDouble(chart_ID,name,OBJPROP_LEVELVALUE,i,values[i]);
      //--- cor do nível
      ObjectSetInteger(chart_ID,name,OBJPROP_LEVELCOLOR,i,colors[i]);
      //--- estilo de nível
      ObjectSetInteger(chart_ID,name,OBJPROP_LEVELSTYLE,i,styles[i]);
      //--- largura de nível
      ObjectSetInteger(chart_ID,name,OBJPROP_LEVELWIDTH,i,widths[i]);
      //--- descrição de nível
      ObjectSetString(chart_ID,name,OBJPROP_LEVELTEXT,i,DoubleToString(100*values[i],1));
     }
//--- sucesso na execução
   return(true);
  }
//+------------------------------------------------------------------+
//| Mover ponto de ancoragem da Retração Fibonacci                   |
//+------------------------------------------------------------------+
bool FiboLevelsPointChange(const long   chart_ID=0,        // ID do gráfico
                           const string name="FiboLevels", // nome do objeto
                           const int    point_index=0,     // índice do ponto de ancoragem
                           datetime     time=0,            // coordenada do ponto de ancoragem do tempo 
                           double       price=0)           // coordenada do ponto de ancoragem de preço
  {
//--- se a posição do ponto não está definida, mover para a barra atual tendo o preço Bid
   if(!time)
      time=TimeCurrent();
   if(!price)
      price=SymbolInfoDouble(Symbol(),SYMBOL_BID);
//--- redefine o valor de erro
   ResetLastError();
//--- mover o ponto de ancoragem
   if(!ObjectMove(chart_ID,name,point_index,time,price))
     {
      Print(__FUNCTION__,
            ": falha ao mover o ponto de ancoragem! Código de erro = ",GetLastError());
      return(false);
     }
//--- sucesso na execução
   return(true);
  }
//+------------------------------------------------------------------+
//| Excluir Retração Fibonacci                                       |
//+------------------------------------------------------------------+
bool FiboLevelsDelete(const long   chart_ID=0,        // ID do gráfico
                      const string name="FiboLevels") // nome do objeto
  {
//--- redefine o valor de erro
   ResetLastError();
//--- excluir o objeto
   if(!ObjectDelete(chart_ID,name))
     {
      Print(__FUNCTION__,
            ": falha ao excluir \"Retração Fibonacci\"! Código de erro = ",GetLastError());
      return(false);
     }
//--- sucesso na execução
   return(true);
  }
//+------------------------------------------------------------------+
//|Vê valores dos pontos de ancoragem da Retração Fibonacci e        |
//| definir os valores padrões estabelecidos para os pontos vazio    |
//+------------------------------------------------------------------+
void ChangeFiboLevelsEmptyPoints(datetime &time1,double &price1,
                                 datetime &time2,double &price2)
  {
//--- se o tempo do primeiro ponto não está definido, será na barra atual
   if(!time2)
      time2=TimeCurrent();
//--- se o preço do segundo ponto não está definido, ele terá valor Bid
   if(!price2)
      price2=SymbolInfoDouble(Symbol(),SYMBOL_BID);
//--- se o tempo do primeiro ponto não está definido, está localizado 9 barras a esquerda partir da segunda
   if(!time1)
     {
      //--- array para receber o tempo de abertura das últimos 10 barras
      datetime temp[10];
      CopyTime(Symbol(),Period(),time2,10,temp);
      //--- definir o primeiro ponto 9 barras a esquerda do segundo
      time1=temp[0];
     }
//--- se o preço do primeiro ponto não está definido, mover 200 pontos a mais do que o segundo
   if(!price1)
      price1=price2-200*SymbolInfoDouble(Symbol(),SYMBOL_POINT);
  }