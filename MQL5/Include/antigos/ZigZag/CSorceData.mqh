#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"

class CSorceData{
   private:
   public:
      virtual int Calculate(const int rates_total,
                      const int prev_calculated,
                      const datetime &time[],
                      const double &open[],
                      const double &high[],
                      const double &low[],
                      const double &close[],
                      const long &tick_volume[],
                      const long &volume[],
                      const int &spread[],
                      double &BufferHigh[],
                      double &BufferLow[]
      ){
         return(0);                
      }
                      
      virtual bool CheckHandle(){
         return(true);
      };                     
};

class CHighLow:public CSorceData{
   private:
   public:
      int Calculate(const int rates_total,
                      const int prev_calculated,
                      const datetime &time[],
                      const double &open[],
                      const double &high[],
                      const double &low[],
                      const double &close[],
                      const long &tick_volume[],
                      const long &volume[],
                      const int &spread[],
                      double &BufferHigh[],
                      double &BufferLow[] 
   ){
             
      int start=0;
    
      if(prev_calculated!=0){
         start=prev_calculated-1;
      }
   
      for(int i=start;i<rates_total;i++){
         BufferHigh[i]=high[i];
         BufferLow[i]=low[i];
      }                     

      return(rates_total);
   }      
};

class CClose:public CSorceData{
   private:
   public:  
      int Calculate(const int rates_total,
                      const int prev_calculated,
                      const datetime &time[],
                      const double &open[],
                      const double &high[],
                      const double &low[],
                      const double &close[],
                      const long &tick_volume[],
                      const long &volume[],
                      const int &spread[],
                      double &BufferHigh[],
                      double &BufferLow[] 
   ){
             
      int start=0;
    
      if(prev_calculated!=0){
         start=prev_calculated-1;
      }
   
      for(int i=start;i<rates_total;i++){
         BufferHigh[i]=close[i];
         BufferLow[i]=close[i];
      }                     

      return(rates_total);
   }      
}; 

class CRSI:public CSorceData{
   private:
      int m_handle;
   public:
      void CRSI(int period,ENUM_APPLIED_PRICE price){
         m_handle=iRSI(Symbol(),Period(),period,price);
      }
      bool CheckHandle(){
         return(m_handle!=INVALID_HANDLE);
      }
      int Calculate(const int rates_total,
                      const int prev_calculated,
                      const datetime &time[],
                      const double &open[],
                      const double &high[],
                      const double &low[],
                      const double &close[],
                      const long &tick_volume[],
                      const long &volume[],
                      const int &spread[],
                      double &BufferHigh[],
                      double &BufferLow[] 
   ){
          
      int to_copy; 
      if(prev_calculated==0){
         to_copy=rates_total; 
      }
      else{ 
         to_copy=rates_total-prev_calculated; 
         to_copy++; 
      } 

      if(CopyBuffer(m_handle,0,0,to_copy,BufferHigh)<=0){
         return(0); 
      }
      
      if(CopyBuffer(m_handle,0,0,to_copy,BufferLow)<=0){
         return(0); 
      }      

      return(rates_total);
   }      
};

class CMA:public CSorceData{
   private:
      int m_handle;
   public:
      void CMA(int period,int shift,ENUM_MA_METHOD method,ENUM_APPLIED_PRICE price){
         m_handle=iMA(Symbol(),Period(),period,shift,method,price);
      }
      bool CheckHandle(){
         return(m_handle!=INVALID_HANDLE);
      }
      int Calculate(const int rates_total,
                      const int prev_calculated,
                      const datetime &time[],
                      const double &open[],
                      const double &high[],
                      const double &low[],
                      const double &close[],
                      const long &tick_volume[],
                      const long &volume[],
                      const int &spread[],
                      double &BufferHigh[],
                      double &BufferLow[] 
   ){
          
      int to_copy; 
      if(prev_calculated==0){
         to_copy=rates_total; 
      }
      else{ 
         to_copy=rates_total-prev_calculated; 
         to_copy++; 
      } 

      if(CopyBuffer(m_handle,0,0,to_copy,BufferHigh)<=0){
         return(0); 
      }
      
      if(CopyBuffer(m_handle,0,0,to_copy,BufferLow)<=0){
         return(0); 
      }      

      return(rates_total);
   }      
};







