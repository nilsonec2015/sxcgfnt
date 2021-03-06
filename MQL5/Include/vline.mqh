//+------------------------------------------------------------------+
//|                                                        vline.mqh |
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
//| Criar a linha vertical                                           |
//+------------------------------------------------------------------+
bool VLineCreate(const long            chart_ID=0,        // ID do gráfico
                 const string          name="VLine",      // nome da linha
                 const int             sub_window=0,      // índice da sub-janela
                 datetime              time=0,            // tempo da linha
                 const color           clr=clrRed,        // cor da linha
                 const ENUM_LINE_STYLE style=STYLE_SOLID, // estilo da linha
                 const int             width=1,           // largura da linha
                 const bool            back=false,        // no fundo
                 const bool            selection=true,    // destaque para mover
                 const bool            ray=true,          // continuação da linha para baixo
                 const bool            hidden=true,       //ocultar na lista de objetos
                 const long            z_order=0)         // prioridade para clique do mouse
  {
//--- se o tempo de linha não está definido, desenhá-lo através da última barra
   if(!time)
      time=TimeCurrent();
//--- redefine o valor de erro
   ResetLastError();
   
   /*
   if (ObjectFind(chart_ID,name)){
      VLineMove(chart_ID,name,time);
      return(false);
   }
   */
//--- criar uma linha vertical
   if(!ObjectCreate(chart_ID,name,OBJ_VLINE,sub_window,time,0))
     {
      Print(__FUNCTION__,
            ": falha ao criar uma linha vertical! Código de erro = ",GetLastError());
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
//--- habilitar (verdadeiro) ou desabilitar (falso) o modo de exibição da linha no gráfico sub-janelas
   ObjectSetInteger(chart_ID,name,OBJPROP_RAY,ray);
//--- ocultar (true) ou exibir (false) o nome do objeto gráfico na lista de objeto 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- definir a prioridade para receber o evento com um clique do mouse no gráfico
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- sucesso na execução
   return(true);
  }
//+------------------------------------------------------------------+
//| Mover a linha vertical                                           |
//+------------------------------------------------------------------+
bool VLineMove(const long   chart_ID=0,   // ID do gráfico
               const string name="VLine", // nome da linha
               datetime     time=0)       // tempo da linha
  {
   
  
  
  
//--- se o tempo de linha não está definido, mover a linha para a última barra
   if(!time)
      time=TimeCurrent();
//--- redefine o valor de erro
   ResetLastError();
   
 /*
   if (!ObjectFind(chart_ID,name)){
      VLineCreate(chart_ID,name,0,time);
      return(false);
   }
   */
   
//--- mover a linha vertical
   if(!ObjectMove(chart_ID,name,0,time,0))
     {
      Print(__FUNCTION__,
            ": falhou ao mover a linha vertical! Código de erro = ",GetLastError());
      return(false);
     }
//--- sucesso na execução
   return(true);
  }
//+------------------------------------------------------------------+
//| Excluir a linha vertical                                         |
//+------------------------------------------------------------------+
bool VLineDelete(const long   chart_ID=0,   // ID do gráfico
                 const string name="VLine") // nome da linha
  {
//--- redefine o valor de erro
   ResetLastError();
//--- excluir a linha vertical
   if(!ObjectDelete(chart_ID,name))
     {
      Print(__FUNCTION__,
            ": falha ao deletar a linha vertical! Código de erro = ",GetLastError());
      return(false);
     }
//--- sucesso na execução
   return(true);
  }
