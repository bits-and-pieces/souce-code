
//+------------------------------------------------------------------+
// Building IT Systems
// BITS and Pieces assignment                                      |
// 

//+------------------------------------------------------------------+


extern double lots = 0.01; // max lots per position
extern double profit=3; // take profit at $3
extern double EMA=300; // moving average time period



double movingaverage; //this is the moving average variable that we will use to determine when to trade
double lasttrade=0; //need a flag to determine if it will buy or sell next

int ticket;



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int start()
{    

{
Comment("Copyright © BITS and Pieces");
}

 // add comments to the chart
   Comment(
    "\n Account total ", AccountBalance(), " Equity ", AccountEquity(), " Moving Ave: ", movingaverage


   );
    

// set the moving average. iMA is the API and the parameters are:
// symbol - we want the symbol to be our chart AUD USD to set this to Null
// time shift = 0
// time period - we created a parameter for this so it can be changed, paramter is set to 300
// moving average shift, you can offest the average, best to set to 0
// mode - we are using simple moving average calcualtion
// price - we are calculating the moving average from the close price
// index - not sure of its use

// this is a standard API supplied by Metatrader

  movingaverage=iMA(NULL,0,EMA,0,MODE_SMA,PRICE_CLOSE,0); 


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////// Buying Conditions////////////////////////////////
    

   if(lasttrade==0 && Bid>movingaverage) //make sure the current price has crossed above the moving average
   {   
      ticket=OrderSend(Symbol(),OP_BUY,lots,Ask,3, 0,Bid+(profit/1000),"Buy trade",0,0,Green); //this is a standard API
      lasttrade=1;

   }  


   if(lasttrade==1 && Ask<movingaverage) //make sure the current price has crossed above the moving average
   { 
     ticket=OrderSend(Symbol(),OP_SELL,lots,Bid,3, 0,Ask-(profit/1000),"Sell trade",0,0,Red);
     lasttrade=0;
   } 




   
   return(0); // exit
}

