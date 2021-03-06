//+------------------------------------------------------------------+
//|                                                        lable.mqh |
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
//| Criar um a etiqueta de texto                                     |
//+------------------------------------------------------------------+
bool LabelCreate(const long              chart_ID=0,               // ID do gráfico
                 const string            name="Label",             // nome da etiqueta
                 const int               sub_window=0,             // índice da sub-janela
                 const int               x=0,                      // coordenada X
                 const int               y=0,                      // coordenada Y
                 const ENUM_BASE_CORNER  corner=CORNER_LEFT_UPPER, // canto do gráfico para ancoragem
                 const string            text="Label",             // texto
                 const string            font="Arial",             // fonte
                 const int               font_size=10,             // tamanho da fonte
                 const color             clr=clrRed,               // cor
                 const double            angle=0.0,                // inclinação do texto
                 const ENUM_ANCHOR_POINT anchor=ANCHOR_LEFT_UPPER, // tipo de ancoragem
                 const bool              back=false,               // no fundo
                 const bool              selection=false,          // destaque para mover
                 const bool              hidden=true,              // ocultar na lista de objetos
                 const long              z_order=0)                // prioridade para clicar no mouse
  {
//--- redefine o valor de erro
   ResetLastError();
//--- criar um a etiqueta de texto
   if(!ObjectCreate(chart_ID,name,OBJ_LABEL,sub_window,0,0))
     {
      Print(__FUNCTION__,
            ": falha ao criar uma etiqueta de texto! Código de erro = ",GetLastError());
      return(false);
     }
//--- definir coordenadas da etiqueta
   ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
   ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
//--- determinar o canto do gráfico onde as coordenadas do ponto são definidas
   ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
//--- definir o texto
   ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
//--- definir o texto fonte
   ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
//--- definir tamanho da fonte
   ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
//--- definir o ângulo de inclinação do texto
   ObjectSetDouble(chart_ID,name,OBJPROP_ANGLE,angle);
//--- tipo de definição de ancoragem
   ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor);
//--- definir cor
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- exibir em primeiro plano (false) ou fundo (true)
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- Habilitar (true) ou desabilitar (false) o modo de movimento da etiqueta pelo mouse
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
//| Mover a etiqueta de texto                                        |
//+------------------------------------------------------------------+
bool LabelMove(const long   chart_ID=0,   // ID do gráfico
               const string name="Label", // nome da etiqueta
               const int    x=0,          // coordenada X
               const int    y=0)          // coordenada Y
  {
//--- redefine o valor de erro
   ResetLastError();
//--- mover a etiqueta de texto
   if(!ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x))
     {
      Print(__FUNCTION__,
            ": falha para mover coordenada X do objeto! Código de erro = ",GetLastError());
      return(false);
     }
   if(!ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y))
     {
      Print(__FUNCTION__,
            ": falha para mover coordenada X do objeto! Código de erro = ",GetLastError());
      return(false);
     }
//--- sucesso na execução
   return(true);
  }
//+------------------------------------------------------------------+
//| Alterar canto do gráfico para vinculação da etiqueta             |
//+------------------------------------------------------------------+
bool LabelChangeCorner(const long             chart_ID=0,               // ID do gráfico
                       const string           name="Label",             // nome da etiqueta
                       const ENUM_BASE_CORNER corner=CORNER_LEFT_UPPER) // canto do gráfico para ancoragem
  {
//--- redefine o valor de erro
   ResetLastError();
//--- alterar canto de ancoragem
   if(!ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner))
     {
      Print(__FUNCTION__,
            ": falha ao alterar canto de ancoragem! Código de erro = ",GetLastError());
      return(false);
     }
//--- sucesso na execução
   return(true);
  }
//+------------------------------------------------------------------+
//| Alterar o texto do objeto                                        |
//+------------------------------------------------------------------+
bool LabelTextChange(const long   chart_ID=0,   // ID do gráfico
                     const string name="Label", // nome do objeto
                     const string text="Text")  // texto
  {
//--- redefine o valor de erro
   ResetLastError();
//--- alterar texto do objeto
   if(!ObjectSetString(chart_ID,name,OBJPROP_TEXT,text))
     {
      Print(__FUNCTION__,
            ": falha ao alterar texto! Código de erro = ",GetLastError());
      return(false);
     }
//--- sucesso na execução
   return(true);
  }
//+------------------------------------------------------------------+
//| Apagar uma etiqueta de texto                                     |
//+------------------------------------------------------------------+
bool LabelDelete(const long   chart_ID=0,   // ID do gráfico
                 const string name="Label") // nome da etiqueta
  {
//--- redefine o valor de erro
   ResetLastError();
//--- excluir a etiqueta
   if(!ObjectDelete(chart_ID,name))
     {
      Print(__FUNCTION__,
            ": falha ao excluir a etiqueta de texto! Código de erro = ",GetLastError());
      return(false);
     }
//--- sucesso na execução
   return(true);
  }