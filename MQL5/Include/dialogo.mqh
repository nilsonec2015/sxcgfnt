//+------------------------------------------------------------------+
//|                                                ControlsLabel.mq5 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property description "Control Panels and Dialogs. Demonstration class CLabel"
#include <Controls\Dialog.mqh>
#include <Controls\Label.mqh>
#include <Controls\Edit.mqh>
#include <Controls\Button.mqh>
#include <Trade\Trade.mqh>
#include <Controls\Picture.mqh>
#include "../include/principais_marcadores.mqh"
#include "../include/auxiliares.mqh"

//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
//--- indents and gaps
#define INDENT_LEFT                         (11)      // indent from left (with allowance for border width)
#define INDENT_TOP                          (11)      // indent from top (with allowance for border width)
#define INDENT_RIGHT                        (11)      // indent from right (with allowance for border width)
#define INDENT_BOTTOM                       (11)      // indent from bottom (with allowance for border width)
#define CONTROLS_GAP_X                      (5)       // gap by X coordinate
#define CONTROLS_GAP_Y                      (5)       // gap by Y coordinate
//--- for buttons
#define BUTTON_WIDTH                        (100)     // size by X coordinate
#define BUTTON_HEIGHT                       (20)      // size by Y coordinate
//--- for the indication area
#define EDIT_HEIGHT                         (20)      // size by Y coordinate
//--- for group controls
#define GROUP_WIDTH                         (150)     // size by X coordinate
#define LIST_HEIGHT                         (179)     // size by Y coordinate
#define RADIO_HEIGHT                        (56)      // size by Y coordinate
#define CHECK_HEIGHT                        (93)      // size by Y coordinate

const int ni = 5;
//+------------------------------------------------------------------+
//| Class CControlsDialog                                            |
//| Usage: main dialog of the Controls application                   |
//+------------------------------------------------------------------+
class CControlsDialog : public CAppDialog
  {
private:
   CLabel            m_label;                         // CLabel object
   
   CButton           m_button1;                       // the button object
   CButton           m_button2;                       // the button object
   
public:

   int indice_oportunidade;
   int indice_posicao;

   CBmpButton        m_bmpbutton1;                    // CBmpButton object
   CPicture          m_picture_compra;                       // CPicture object
   CPicture          m_picture_vende;                       // CPicture object

   CButton           m_autostop;                       // the fixed button object   
   CButton           m_button3;                       // the fixed button object   
   CButton           m_button3a;                       // the fixed button object   
   CButton           m_reduzir;                       // the button object
   CButton           m_compra_manual;                       // the button object
   CButton           m_venda_manual;                       // the button object

   CButton           m_compra_manual_2p1;                       // the button object
   CButton           m_venda_manual_2p1;                       // the button object
   
   CButton           m_offline;                       // the button object
   CButton           m_lstopscompra;                       // the button object
   CButton           m_lstopsvenda;                       // the button object


   CLabel            m_label1;                         // CLabel object
   CLabel            m_labelbb1;                         // CLabel object
   CLabel            m_label2;                         // CLabel object
   CLabel            m_label3;                         // CLabel object
   
   CLabel            m_preco1;                         // CLabel object
   CLabel            m_stop1;                         // CLabel object
   CLabel            m_tp1;                         // CLabel object
   
   CLabel            m_preco2;                         // CLabel object
   CLabel            m_stop2;                         // CLabel object
   CLabel            m_tp2;                         // CLabel object

   CLabel            comentarios;                         // CLabel object
   CLabel            comentarios2;                         // CLabel object
   CLabel            m_indicador1;                         // CLabel object
   CLabel            m_indicador1a;                         // CLabel object
   CLabel            m_indicador2;                         // CLabel object
   CLabel            m_indicador3;                         // CLabel object
   
   CLabel            m_indicadorv[5][4];                    // CLabel object
   CLabel            m_indicador_colunas[4];                    // CLabel object
   CLabel            m_indicador_linhas[5];                    // CLabel object
   int cv[5][4];
   
   CEdit             m_edit;

   CTrade trade;
   CPositionInfo position;
   
   int volume;
   int reducao0;
   int reducao1;
   
   double bs;
   double bs_sl;
   double bs_tp1;
   double bs_tp0;
   double bs_sl_rompimento;
   
   double ss;
   double ss_sl;
   double ss_tp1;
   double ss_tp0;
   double ss_sl_rompimento;
   
   double retracao_50;
   double retracao_bs_382;
   double retracao_bs_236;
   double retracao_bs_618;
   double retracao_ss_382;
   double retracao_ss_236;
   double retracao_ss_618;
   
   double tpc0_auto;   
   double tpc161_8_auto;
   double tpc261_8_auto; 
     
   double tpv0_auto;   
   double tpv161_8_auto;
   double tpv261_8_auto;
   
   
                     CControlsDialog(void);
                    ~CControlsDialog(void);
   //--- create
   virtual bool      Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2);
   //--- chart event handler
   virtual bool      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   
   void setup_operacao_manual(void);
   

   
protected:
   //--- create dependent controls
   bool              CreateLabel(void);
   bool              CreateEdit(void);
   //--- handlers of the dependent controls events
   void              OnClickLabel(void);
   
   
   //--- create dependent controls
   bool              CreateButton1(void);
   bool              CreateButton2(void);
   bool              Createreduzir(void);
   bool              Createcompramanual(void);
   bool              Createvendamanual(void);
   bool              Createcompramanual2p1(void);
   bool              Createvendamanual2p1(void);
   bool              CreateButton3(void);
   bool              CreateButton3a(void);
   bool              CreateAutostop(void);
   bool              CreateBmpButton1(void);
   bool              CreatePicture_compra(void);
   bool              CreatePicture_vende(void);
   bool              Createlstopscompra(void);
   bool              Createlstopsvenda(void);
   bool              Createoffline(void);
   //--- handlers of the dependent controls events
   void              OnClickButton1(void);
   void              OnClickButton2(void);
   void              OnClickreduzir(void);
   void              OnClickcompramanual(void);
   void              OnClickvendamanual(void);
   void              OnClickcompramanual2p1(void);
   void              OnClickvendamanual2p1(void);
   void              OnClickButton3(void);  
   void              OnClickButton3a(void); 
   void              OnClickAutostop(void);   
   void              OnClickBmpButton1(void);
   void              OnClickPicture_compra(void);
   void              OnClickPicture_vende(void);
   void              OnClicklstopscompra(void);
   void              OnClicklstopsvenda(void);
   void              OnClickofline(void);
 
   
   
  };
//+------------------------------------------------------------------+
//| Event Handling                                                   |
//+------------------------------------------------------------------+
EVENT_MAP_BEGIN(CControlsDialog)

ON_EVENT(ON_CLICK,m_button1,OnClickButton1)
ON_EVENT(ON_CLICK,m_button2,OnClickButton2)
ON_EVENT(ON_CLICK,m_reduzir,OnClickreduzir)
ON_EVENT(ON_CLICK,m_compra_manual,OnClickcompramanual)
ON_EVENT(ON_CLICK,m_venda_manual,OnClickvendamanual)
ON_EVENT(ON_CLICK,m_compra_manual_2p1,OnClickcompramanual2p1)
ON_EVENT(ON_CLICK,m_venda_manual_2p1,OnClickvendamanual2p1)
ON_EVENT(ON_CLICK,m_lstopscompra,OnClicklstopscompra)
ON_EVENT(ON_CLICK,m_lstopsvenda,OnClicklstopsvenda)
ON_EVENT(ON_CLICK,m_offline,OnClickofline)
ON_EVENT(ON_CLICK,m_button3,OnClickButton3)
ON_EVENT(ON_CLICK,m_button3a,OnClickButton3a)
ON_EVENT(ON_CLICK,m_autostop,OnClickAutostop)
ON_EVENT(ON_CLICK,m_bmpbutton1,OnClickBmpButton1)
ON_EVENT(ON_CLICK,m_picture_compra,OnClickPicture_compra)
ON_EVENT(ON_CLICK,m_picture_vende,OnClickPicture_vende)
 
EVENT_MAP_END(CAppDialog)


//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CControlsDialog::CControlsDialog(void)
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CControlsDialog::~CControlsDialog(void)
  {
  }
//+------------------------------------------------------------------+
//| Create                                                           |
//+------------------------------------------------------------------+
bool CControlsDialog::Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2)
  {
  
   indice_oportunidade = 0;
   indice_posicao = -1;  
  
  
   if(!CAppDialog::Create(chart,name,subwin,x1,y1,x2,y2))
      return(false);
//--- create dependent controls
   if(!CreateLabel())
      return(false);
      
   if(!CreateEdit())
      return(false);      
      
      
//--- create dependent controls
   if(!CreateButton1())
      return(false);
   if(!CreateButton2())
      return(false);
   if(!Createreduzir())
      return(false);
   if(!Createcompramanual())
      return(false);
   if(!Createvendamanual())
      return(false);
   if(!Createcompramanual2p1())
      return(false);
   if(!Createvendamanual2p1())
      return(false);
   if(!CreateButton3())
      return(false);  
   if(!CreateButton3a())
      return(false);  
   if(!CreateAutostop())
      return(false);  
      

   if(!CreateBmpButton1())
      return(false);
      
   if(!CreatePicture_compra())
      return(false);   
   if(!CreatePicture_vende())
      return(false);

   if(!Createlstopscompra())
      return(false);   
   if(!Createlstopsvenda())
      return(false);   
   if(!Createoffline())
      return(false);


      
      
      
      
//--- set MagicNumber for your orders identification
   int MagicNumber=123456;
   trade.SetExpertMagicNumber(MagicNumber);
//--- set available slippage in points when buying/selling
   int deviation=10;
   trade.SetDeviationInPoints(deviation);
//--- order filling mode, the mode allowed by the server should be used
   trade.SetTypeFilling(ORDER_FILLING_RETURN);
//--- logging mode: it would be better not to declare this method at all, the class will set the best mode on its own
   trade.LogLevel(1); 
//--- what function is to be used for trading: true - OrderSendAsync(), false - OrderSend()
   trade.SetAsyncMode(true);
//---      
      
      
      
   volume = 3;
   reducao0 = 1;
   reducao1 = 1;
      
          
      
      
      
//--- succeed
   return(true);
  }
  
  
void CControlsDialog::setup_operacao_manual(void){


   double preco = (ObjectFind(0, "linha_preco")>=0)?ObjectGetDouble(0, "linha_preco", OBJPROP_PRICE):0;
   double sl = (ObjectFind(0, "linha_sl")>=0)?ObjectGetDouble(0, "linha_sl", OBJPROP_PRICE):0;
   double tp = (ObjectFind(0, "linha_tp")>=0)?ObjectGetDouble(0, "linha_tp", OBJPROP_PRICE):0;
   
 
   preco = acerta_preco(preco);
   sl = acerta_preco(sl);
   tp = acerta_preco(tp);



   if((preco==0)||(tp==0)||(sl==0)){
      m_edit.Text("Betina Beta");
   }else{
   
       m_edit.Text("Lucro="+MathAbs(tp-preco)*conversao()+" Risco="+MathAbs(preco-sl)*conversao()+"");
   
   }

}  
  
//+------------------------------------------------------------------+
//| Create the "CLabel"                                              |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateLabel(void)
  {
//--- coordinates
   int x1=INDENT_RIGHT;
   int y1=INDENT_TOP+CONTROLS_GAP_Y;
   int x2=x1+100;
   int y2=y1+200;
//--- create
   if(!m_label1.Create(m_chart_id,m_name+"lable1",m_subwin,x1,y1+0,x2,y2))
      return(false);
   if(!m_label1.Text("Posição Zero"))
      return(false);
   if(!Add(m_label1))
      return(false);

   if(!m_labelbb1.Create(m_chart_id,m_name+"lablebb1",m_subwin,x1,y1+20,x2,y2))
      return(false);
   if(!m_labelbb1.Text("bb1"))
      return(false);
   if(!Add(m_labelbb1))
      return(false);

//--- create
   if(!m_label2.Create(m_chart_id,m_name+"lable2",m_subwin,x1,y1+50,x2,y2))
      return(false);
   if(!m_label2.Text("Buy Stop"))
      return(false);
   if(!Add(m_label2))
      return(false);
      
   if(!m_preco1.Create(m_chart_id,m_name+"m_preco1",m_subwin,x1,y1+70,x2,y2))
      return(false);
   if(!m_preco1.Text("Preço="))
      return(false);
   if(!Add(m_preco1))
      return(false);
      
   if(!m_stop1.Create(m_chart_id,m_name+"m_stop1",m_subwin,x1,y1+90,x2,y2))
      return(false);
   if(!m_stop1.Text("Perda Máxima="))
      return(false);
   if(!Add(m_stop1))
      return(false);
      
   if(!m_tp1.Create(m_chart_id,m_name+"m_tp1",m_subwin,x1,y1+110,x2,y2))
      return(false);
   if(!m_tp1.Text("Lucro Máximo="))
      return(false);
   if(!Add(m_tp1))
      return(false);
           
   if(!comentarios.Create(m_chart_id,m_name+"comentarios",m_subwin,x1,y1+430,x2,y2))
      return(false);
   if(!comentarios.Text("Posicao:"))
      return(false);
   if(!Add(comentarios))
      return(false);
      
   if(!comentarios2.Create(m_chart_id,m_name+"comentarios2",m_subwin,x1,y1+450,x2,y2))
      return(false);
   if(!comentarios2.Text("Posicaox:"))
      return(false);
   if(!Add(comentarios2))
      return(false);
      
      
      
   if(!m_indicador1.Create(m_chart_id,m_name+"indicador1",m_subwin,x1,y1+240,x2,y2))
      return(false);
   if(!m_indicador1.Text("Pvf insira MA200, MA21, ME9, BB21"))
      return(false);
   if(!Add(m_indicador1))
      return(false);
      
   if(!m_indicador1a.Create(m_chart_id,m_name+"indicador1a",m_subwin,x1,y1+260,x2,y2))
      return(false);
   if(!m_indicador1a.Text("Pvf insira MA200, MA21, ME9, BB21"))
      return(false);
   if(!Add(m_indicador1a))
      return(false);
      
   if(!m_indicador2.Create(m_chart_id,m_name+"indicador2",m_subwin,x1,y1+280,x2,y2))
      return(false);
   if(!m_indicador2.Text("Pvf insira MA200, MA21, ME9, BB21"))
      return(false);
   if(!Add(m_indicador2))
      return(false);
   /*   
   if(!m_indicador3.Create(m_chart_id,m_name+"indicador3",m_subwin,x1,y1+300,x2,y2))
      return(false);
   if(!m_indicador3.Text("Pvf insira MA200, MA21, ME9, BB21"))
      return(false);
   if(!Add(m_indicador3))
      return(false);
    */  

   int i;
   int j;
   
   for(i=0; i<4; i++){

      if(!m_indicador_colunas[i].Create(m_chart_id,m_name+"indicadorc_"+IntegerToString(i),m_subwin,x1+80+90*i,y1+305,x2,y2))
         return(false);
      if(!m_indicador_colunas[i].Text("coluna["+IntegerToString(i)+"]"))
         return(false);
      if(!Add(m_indicador_colunas[i]))
         return(false);
         
   
   
   }
   
   for(i=0; i<ni; i++){


      if(!m_indicador_linhas[i].Create(m_chart_id,m_name+"indicadorl_"+IntegerToString(i),m_subwin,x1,y1+325+20*i,x2,y2))
         return(false);
      if(!m_indicador_linhas[i].Text("linha["+IntegerToString(i)+"]"))
         return(false);
      if(!Add(m_indicador_linhas[i]))
         return(false);
        
   
   
   }
   
   
   
   
   for(i=0; i<ni; i++){
   
           
      for(j=0; j<4; j++){
         if(!m_indicadorv[i][j].Create(m_chart_id,m_name+"indicadorv_"+IntegerToString(i)+"_"+IntegerToString(j),m_subwin,x1+80+90*j,y1+325+20*i,x2,y2))
            return(false);
         if(!m_indicadorv[i][j].Text("iv["+IntegerToString(i)+", "+IntegerToString(j)+"]"))
            return(false);
         if(!Add(m_indicadorv[i][j]))
            return(false);
      }
   }
      

      
//--- create
   if(!m_label3.Create(m_chart_id,m_name+"lable3",m_subwin,x1,y1+150,x2,y2))
      return(false);
   if(!m_label3.Text("Sell Stop"))
      return(false);
   if(!Add(m_label3))
      return(false);
      
   if(!m_preco2.Create(m_chart_id,m_name+"m_preco2",m_subwin,x1,y1+170,x2,y2))
      return(false);
   if(!m_preco2.Text("Preço="))
      return(false);
   if(!Add(m_preco2))
      return(false);
      
   if(!m_stop2.Create(m_chart_id,m_name+"m_stop2",m_subwin,x1,y1+190,x2,y2))
      return(false);
   if(!m_stop2.Text("Perda Máxima="))
      return(false);
   if(!Add(m_stop2))
      return(false);
      
   if(!m_tp2.Create(m_chart_id,m_name+"m_tp2",m_subwin,x1,y1+210,x2,y2))
      return(false);
   if(!m_tp2.Text("Lucro Máximo="))
      return(false);
   if(!Add(m_tp2))
      return(false);



//--- succeed
   return(true);
  }
  
  
//+------------------------------------------------------------------+
//| Create the "BmpButton1" button                                   |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateBmpButton1(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+341;
   int y1=INDENT_TOP+(EDIT_HEIGHT+CONTROLS_GAP_Y)+95;
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!m_bmpbutton1.Create(m_chart_id,m_name+"BmpButton1",m_subwin,x1,y1,x2,y2))
      return(false);
//--- sets the name of bmp files of the control CBmpButton
   m_bmpbutton1.BmpNames("\\Images\\dollar.bmp", "\\Images\\euro.bmp");
   if(!Add(m_bmpbutton1))
      return(false);
//--- succeed
   return(true);
  }
  
  
void CControlsDialog::OnClickBmpButton1(void)
  {
      indice_oportunidade ++;
  }
  
bool CControlsDialog::CreatePicture_compra(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+370;
   int y1=INDENT_TOP+(EDIT_HEIGHT+CONTROLS_GAP_Y)+220;
   int x2=x1+32;
   int y2=y1+32;
//--- create
   if(!m_picture_compra.Create(m_chart_id,m_name+"Picture_compra",m_subwin,x1,y1,x2,y2))
      return(false);
//--- definimos o nome dos arquivos bmp para exibir os controles CPicture
   m_picture_compra.BmpName("\\Images\\seta_compra.bmp");
 
   if(!Add(m_picture_compra))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CControlsDialog::OnClickPicture_compra(void)
  {
   Comment(__FUNCTION__);
  }
   
bool CControlsDialog::CreatePicture_vende(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+370;
   int y1=INDENT_TOP+(EDIT_HEIGHT+CONTROLS_GAP_Y)+220;
   int x2=x1+32;
   int y2=y1+32;
//--- create
   if(!m_picture_vende.Create(m_chart_id,m_name+"Picture_vende",m_subwin,x1,y1,x2,y2))
      return(false);
//--- definimos o nome dos arquivos bmp para exibir os controles CPicture
   m_picture_vende.BmpName("\\Images\\seta_vende.bmp");
 
   if(!Add(m_picture_vende))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CControlsDialog::OnClickPicture_vende(void)
  {
   Comment(__FUNCTION__);
  }
  
  //+------------------------------------------------------------------+
//| Create the display field                                         |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateEdit(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+250;
   int y1=INDENT_TOP;
   int x2=ClientAreaWidth()-INDENT_RIGHT;
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_edit.Create(m_chart_id,m_name+"Edit",m_subwin,x1,y1,x2,y2))
      return(false);
//--- permitimos modificar o conteúdo
   if(!m_edit.ReadOnly(false))
      return(false);
   if(!Add(m_edit))
      return(false);
   m_edit.Text("Betina");
//--- succeed
   return(true);
  }
  
  
//+------------------------------------------------------------------+
//| Create the "Button1" button                                      |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateButton1(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+300;
   int y1=INDENT_TOP+(EDIT_HEIGHT+CONTROLS_GAP_Y)+60;
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!m_button1.Create(m_chart_id,m_name+"Button1",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_button1.Text("Buy Stop"))
      return(false);
   if(!Add(m_button1))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Button2" button                                      |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateButton2(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+300;
   int y1=INDENT_TOP+(EDIT_HEIGHT+CONTROLS_GAP_Y)+160;
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!m_button2.Create(m_chart_id,m_name+"Button2",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_button2.Text("Sell Stop"))
      return(false);
   if(!Add(m_button2))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "reduzir" button                                      |
//+------------------------------------------------------------------+
bool CControlsDialog::Createreduzir(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+110;
   int y1=INDENT_TOP+(EDIT_HEIGHT+CONTROLS_GAP_Y)+470;
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!m_reduzir.Create(m_chart_id,m_name+"reduzir",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_reduzir.Text("Reduzir 1"))
      return(false);
   if(!Add(m_reduzir))
      return(false);
   if(!m_reduzir.Width(100))
      return(false);//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "m_compra_manual" button                                      |
//+------------------------------------------------------------------+
bool CControlsDialog::Createcompramanual(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+220;
   int y1=INDENT_TOP+(EDIT_HEIGHT+CONTROLS_GAP_Y)+470;
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!m_compra_manual.Create(m_chart_id,m_name+"m_compra_manual",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_compra_manual.Text("BUY"))
      return(false);
   if(!Add(m_compra_manual))
      return(false);
   if(!m_compra_manual.Width(100))
      return(false);//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "m_venda_manual" button                                      |
//+------------------------------------------------------------------+
bool CControlsDialog::Createvendamanual(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+330;
   int y1=INDENT_TOP+(EDIT_HEIGHT+CONTROLS_GAP_Y)+470;
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!m_venda_manual.Create(m_chart_id,m_name+"m_venda_manual",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_venda_manual.Text("SELL"))
      return(false);
   if(!Add(m_venda_manual))
      return(false);
   if(!m_venda_manual.Width(100))
      return(false);//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "m_compra_manual_2p1" button                                      |
//+------------------------------------------------------------------+
bool CControlsDialog::Createcompramanual2p1(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+430;
   int y1=INDENT_TOP+(EDIT_HEIGHT+CONTROLS_GAP_Y)+415;
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!m_compra_manual_2p1.Create(m_chart_id,m_name+"m_compra_manual_2p1",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_compra_manual_2p1.Text("BUY pend"))
      return(false);
   if(!Add(m_compra_manual_2p1))
      return(false);
   if(!m_compra_manual_2p1.Width(80))
      return(false);//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "m_venda_manual_2p1" button                                      |
//+------------------------------------------------------------------+
bool CControlsDialog::Createvendamanual2p1(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+430;
   int y1=INDENT_TOP+(EDIT_HEIGHT+CONTROLS_GAP_Y)+445;
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!m_venda_manual_2p1.Create(m_chart_id,m_name+"m_venda_manual_2p1",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_venda_manual_2p1.Text("SELL pend"))
      return(false);
   if(!Add(m_venda_manual_2p1))
      return(false);
   if(!m_venda_manual_2p1.Width(80))
      return(false);//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "m_lstopscompra" button                                      |
//+------------------------------------------------------------------+
bool CControlsDialog::Createlstopscompra(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+430;
   int y1=INDENT_TOP+(EDIT_HEIGHT+CONTROLS_GAP_Y)+350;
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!m_lstopscompra.Create(m_chart_id,m_name+"m_lstopscompra",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_lstopscompra.Text("L Buy"))
      return(false);
   if(!Add(m_lstopscompra))
      return(false);
   if(!m_lstopscompra.Width(80))
      return(false);//--- succeed
   m_lstopscompra.Locking(true);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "m_lstopsvenda" button                                      |
//+------------------------------------------------------------------+
bool CControlsDialog::Createlstopsvenda(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+430;
   int y1=INDENT_TOP+(EDIT_HEIGHT+CONTROLS_GAP_Y)+380;
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!m_lstopsvenda.Create(m_chart_id,m_name+"m_lstopsvenda",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_lstopsvenda.Text("L Sell"))
      return(false);
   if(!Add(m_lstopsvenda))
      return(false);
   if(!m_lstopsvenda.Width(80))
      return(false);//--- succeed
   m_lstopsvenda.Locking(true);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "m_offline" button                                      |
//+------------------------------------------------------------------+
bool CControlsDialog::Createoffline(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+430;
   int y1=INDENT_TOP+(EDIT_HEIGHT+CONTROLS_GAP_Y)+10;
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!m_offline.Create(m_chart_id,m_name+"m_offline",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_offline.Text("of"))
      return(false);
   if(!Add(m_offline))
      return(false);
   if(!m_offline.Width(70))
      return(false);//--- succeed
   m_offline.Locking(true);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Button3" fixed button                                |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateButton3(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+320;
   int y1=INDENT_TOP+(EDIT_HEIGHT+CONTROLS_GAP_Y);
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!m_button3.Create(m_chart_id,m_name+"Button3",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_button3.Text("Manual"))
      return(false);
   if(!Add(m_button3))
      return(false);
   m_button3.Locking(true);
//--- succeed
   return(true);
  }
  
bool CControlsDialog::CreateButton3a(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+210;
   int y1=INDENT_TOP+(EDIT_HEIGHT+CONTROLS_GAP_Y);
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!m_button3a.Create(m_chart_id,m_name+"Button3a",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_button3a.Text("Op. Manual"))
      return(false);
   if(!Add(m_button3a))
      return(false);
   m_button3a.Locking(true);
//--- succeed
   return(true);
  }
  
bool CControlsDialog::CreateAutostop(void)
  {
//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP+(EDIT_HEIGHT+CONTROLS_GAP_Y)+470;
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!m_autostop.Create(m_chart_id,m_name+"Autostop",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_autostop.Text("Stop Manual"))
      return(false);
   if(!Add(m_autostop))
      return(false);
   m_autostop.Locking(true);
//--- succeed
   return(true);
  }
  

  

//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CControlsDialog::OnClickButton1(void)
  {
   //Comment(__FUNCTION__);
   Comment("buy stop", " ", bs, " ", bs_sl, " ", bs_tp1);
   
   //colocar a ordem principal
   Print ("buy stop", " ", bs, " ", bs_sl, " ", bs_tp1);
   trade.BuyStop(
   
      volume,                       // order volume
      bs,                        // order price
      _Symbol,                  // symbol
      bs_sl,                       // stop loss price
      bs_tp1,                       // take profit price
      ORDER_TIME_GTC,     // order lifetime
      0,                 // order expiration time
      "bs"                    // comment      
   );
   
   //colocar a ordem de redução 0
   
   double red0 = bs + (bs_tp0-bs)/2;
   red0 = 5*MathRound(red0/5);
   
   trade.SellLimit (
   
      reducao0,                       // order volume
      red0,                        // order price
      _Symbol,                  // symbol
      0,                       // stop loss price
      0,                       // take profit price
      ORDER_TIME_GTC,     // order lifetime
      0,                 // order expiration time
      "bs_red_0"                    // comment      
   );
   
   
   
   //colocar a ordem de reduçao 1
   
   double red1 = 5*MathRound(bs_tp0/5);
   
   trade.SellLimit (
   
      reducao1,                       // order volume
      red1,                        // order price
      _Symbol,                  // symbol
      0,                       // stop loss price
      0,                       // take profit price
      ORDER_TIME_GTC,     // order lifetime
      0,                 // order expiration time
      "bs_red_1"                    // comment      
   );
   


  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CControlsDialog::OnClickreduzir(void)
  {
      Print("Redução Manual");
      if (position.Select(_Symbol)){
         if (position.PositionType() == POSITION_TYPE_BUY){
            trade.Sell(1, _Symbol, 0, position.StopLoss(), position.TakeProfit(), position.Comment());
         }else{
            trade.Buy(1, _Symbol, 0, position.StopLoss(), position.TakeProfit(), position.Comment());
         
         }
      }
  
  }
void CControlsDialog::OnClickcompramanual(void)
  {
      Print("Compra Manual");
      if (position.Select(_Symbol)){
         trade.Buy(1, _Symbol, 0, position.StopLoss(), position.TakeProfit(), position.Comment());
      }else{
         int vol = 1;
         double preco = 0;
         double sl = 0;
         double tp = 0;

         if((ObjectFind(0, "linha_preco")>=0)&&(ObjectFind(0, "linha_tp")>=0)&&(ObjectFind(0, "linha_sl")>=0)){
            preco = ObjectGetDouble(0, "linha_preco", OBJPROP_PRICE);
            sl = ObjectGetDouble(0, "linha_sl", OBJPROP_PRICE);
            tp = ObjectGetDouble(0, "linha_tp", OBJPROP_PRICE);


            string coment = "CMa";       
            preco = 5*MathRound(preco/5);
            sl = 5*MathRound(sl/5);
            tp = 5*MathRound(tp/5);               
            trade.Buy(vol, _Symbol, preco, sl, tp, coment);


         }else{

         }
      
      }
      Print("Compra Manual");
  
  }
void CControlsDialog::OnClickvendamanual(void)
  {
      Print("Venda Manual");
      if (position.Select(_Symbol)){
         trade.Sell(1, _Symbol, 0, position.StopLoss(), position.TakeProfit(), position.Comment());
      }else{
         int vol = 1;
         double preco = 0;
         double sl = 0;
         double tp = 0;
         

         if((ObjectFind(0, "linha_preco")>=0)&&(ObjectFind(0, "linha_tp")>=0)&&(ObjectFind(0, "linha_sl")>=0)){
            preco = ObjectGetDouble(0, "linha_preco", OBJPROP_PRICE);
            sl = ObjectGetDouble(0, "linha_sl", OBJPROP_PRICE);
            tp = ObjectGetDouble(0, "linha_tp", OBJPROP_PRICE);

            string coment = "VMa";         
            preco = 5*MathRound(preco/5);
            sl = 5*MathRound(sl/5);
            tp = 5*MathRound(tp/5);         
            trade.Sell(vol, _Symbol, preco, sl, tp, coment);


         }else{

         }
         
         

      
      }
      Print("Venda Manual");
  }

void CControlsDialog::OnClickcompramanual2p1(void)
  {

      double cotacao_atual = 0;
      SymbolInfoDouble(_Symbol, SYMBOL_ASK, cotacao_atual);
      
      if (position.Select(_Symbol)){

         int vol = 1;
         double preco = 0;
         double sl = position.StopLoss();
         double tp = position.TakeProfit();
         string coment = "NsC2p1";
      
         trade.Buy(vol, _Symbol, preco, sl, tp, coment);




      }else{
         int vol = 1;
         double preco = 0;
         double sl = cotacao_atual-100;
         double tp = cotacao_atual+200;
         
         if((ObjectFind(0, "linha_preco")>=0)&&(ObjectFind(0, "linha_tp")>=0)&&(ObjectFind(0, "linha_sl")>=0)){
            preco = ObjectGetDouble(0, "linha_preco", OBJPROP_PRICE);
            sl = ObjectGetDouble(0, "linha_sl", OBJPROP_PRICE);
            tp = ObjectGetDouble(0, "linha_tp", OBJPROP_PRICE);


         
            string coment = "CPn";         
            preco = 5*MathRound(preco/5);
            sl = 5*MathRound(sl/5);
            tp = 5*MathRound(tp/5);         
      
            if (cotacao_atual<preco){
            trade.BuyStop(vol, preco, _Symbol, sl, tp, ORDER_TIME_GTC, 0, coment);
            }else
            if (cotacao_atual>preco){
               trade.BuyLimit(vol, preco, _Symbol, sl, tp, ORDER_TIME_GTC, 0, coment);
            }else{
               trade.Buy(vol, _Symbol, preco, sl, tp, coment);

            }
      




         }else{

         }         
         

      }
      
      Print("Compra Manual pendente");
  
  }
void CControlsDialog::OnClickvendamanual2p1(void)
  {
  
      double cotacao_atual = 0;
      SymbolInfoDouble(_Symbol, SYMBOL_ASK, cotacao_atual);
      if ((position.Select(_Symbol))){

         int vol = 1;
         double preco = 0;
         double sl = position.StopLoss();
         double tp = position.TakeProfit();
         string coment = "NsV2p1";
         
         trade.Sell(vol, _Symbol, preco, sl, tp, coment);


      }else{
         int vol = 1;
         double preco = 0;
         double sl = cotacao_atual+100;
         double tp = cotacao_atual-200;
         
         if((ObjectFind(0, "linha_preco")>=0)&&(ObjectFind(0, "linha_tp")>=0)&&(ObjectFind(0, "linha_sl")>=0)){
            preco = ObjectGetDouble(0, "linha_preco", OBJPROP_PRICE);
            sl = ObjectGetDouble(0, "linha_sl", OBJPROP_PRICE);
            tp = ObjectGetDouble(0, "linha_tp", OBJPROP_PRICE);


         
            string coment = "VPn";
         
         
            preco = 5*MathRound(preco/5);
            sl = 5*MathRound(sl/5);
            tp = 5*MathRound(tp/5);         
         
         
            if (cotacao_atual>preco){
               trade.SellStop(vol, preco, _Symbol, sl, tp, ORDER_TIME_GTC, 0, coment);
            }else
            if (cotacao_atual<preco){
               trade.SellLimit(vol, preco, _Symbol, sl, tp, ORDER_TIME_GTC, 0, coment);
            }else{
               trade.Sell(vol, _Symbol, preco, sl, tp, coment);

            }
         
  






         }else{

         }         
         
       
         
      
      }
      
      Print("Venda Manual pendente");
  }
  
void CControlsDialog::OnClickofline(void)
  {
  
      if (m_offline.Pressed()){
         m_offline.Text("On");
      }else{
         m_offline.Text("Off");
      }
      
  }
  
void CControlsDialog::OnClicklstopscompra(void)
  {
  
   if(!ObjectFind(0, "linha_preco")){
      HLineDelete(0, "linha_preco");
   
   }else{
  
      linha_preco("linha_preco", SymbolInfoDouble(_Symbol, SYMBOL_ASK));
  }

   if(!ObjectFind(0, "linha_tp")){
      HLineDelete(0, "linha_tp");
   
   }else{
  
      linha_tp("linha_tp", SymbolInfoDouble(_Symbol, SYMBOL_ASK)+v2pra1tp());
  }

   if(!ObjectFind(0, "linha_sl")){
      HLineDelete(0, "linha_sl");
   
   }else{
  
      linha_sl("linha_sl", SymbolInfoDouble(_Symbol, SYMBOL_ASK)-v2pra1sl());
  }

  }
  
void CControlsDialog::OnClicklstopsvenda(void)
  {
  
  
   if(!ObjectFind(0, "linha_preco")){
      HLineDelete(0, "linha_preco");
   
   }else{
  
      linha_preco("linha_preco", SymbolInfoDouble(_Symbol, SYMBOL_BID));
  }

   if(!ObjectFind(0, "linha_tp")){
      HLineDelete(0, "linha_tp");
   
   }else{
  
      linha_tp("linha_tp", SymbolInfoDouble(_Symbol, SYMBOL_ASK)-v2pra1tp());
  }

   if(!ObjectFind(0, "linha_sl")){
      HLineDelete(0, "linha_sl");
   
   }else{
  
      linha_sl("linha_sl", SymbolInfoDouble(_Symbol, SYMBOL_ASK)+v2pra1sl());
  }

  }

void CControlsDialog::OnClickButton2(void)
  {
   //Comment(__FUNCTION__);
   Comment("buy stop", " ", bs, " ", bs_sl, " ", bs_tp1);

   //colocar a ordem principal
   Print ("buy stop", " ", bs, " ", bs_sl, " ", bs_tp1);
   trade.SellStop(
   
      volume,                       // order volume
      ss,                        // order price
      _Symbol,                  // symbol
      ss_sl,                       // stop loss price
      ss_tp1,                       // take profit price
      ORDER_TIME_GTC,     // order lifetime
      0,                 // order expiration time
      "ss"                    // comment   
   
   );   
   
   //colocar a ordem de redução 0
   
   double red0 = ss - (ss-ss_tp0)/2;
   red0 = 5*MathRound(red0/5);
   
   trade.BuyLimit (
   
      reducao0,                       // order volume
      red0,                        // order price
      _Symbol,                  // symbol
      0,                       // stop loss price
      0,                       // take profit price
      ORDER_TIME_GTC,     // order lifetime
      0,                 // order expiration time
      "ss_red_0"                    // comment      
   );
   
   
   
   //colocar a ordem de reduçao 1
   
   double red1 = 5*MathRound(ss_tp0/5);
   
   trade.BuyLimit (
   
      reducao1,                       // order volume
      red1,                        // order price
      _Symbol,                  // symbol
      0,                       // stop loss price
      0,                       // take profit price
      ORDER_TIME_GTC,     // order lifetime
      0,                 // order expiration time
      "ss_red_1"                    // comment      
   );
   

   
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CControlsDialog::OnClickButton3(void)
  {
   if(m_button3.Pressed()){
      Comment(__FUNCTION__+" Estado dos controles: On");
      m_button3.Text("Automatico");
   }else{
      Comment(__FUNCTION__+" Estado dos controles: Off");
      m_button3.Text("Manual");
   }
  }
  
void CControlsDialog::OnClickButton3a(void)
  {
   if(m_button3a.Pressed()){
      Comment(__FUNCTION__+" Estado dos controles: On");
      m_button3a.Text("OP.Auto");
   }else{
      Comment(__FUNCTION__+" Estado dos controles: Off");
      m_button3a.Text("OP.Manual");
   }
  }
  
  void CControlsDialog::OnClickAutostop(void)
  {
   if(m_autostop.Pressed()){
      Comment(__FUNCTION__+" Estado dos controles: On");
      m_autostop.Text("Stop Auto");
   }else{
      Comment(__FUNCTION__+" Estado dos controles: Off");
      m_autostop.Text("Stop Manual");
   }
  }

//+------------------------------------------------------------------+
//| Global Variables                                                 |
//+------------------------------------------------------------------+
CControlsDialog ExtDialog;
