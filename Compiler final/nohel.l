%{
	#include<stdio.h>
	#include<string.h>
	#include<stdlib.h>
	#include<math.h>
	#include "nohel.tab.h"
%}

variable [a-zA-Z]
digit [0-9]
header		"header ".*

	

%%

{digit}+	{yylval = atoi(yytext); return NUM; }

"IF" 			   {return IF;   }
"ELSE" 		   {return ELSE; }
"{" 		   {return START;  }
"}"  		   {return END;	}
"FOR" 		   {return FOR;}
"WHILE"		   {return WHILE;}

"++"   {return inc;}

"--"   {return dec;}

"!"	{return not;}



"INTEGER"  		{return INT;}
"CHAR" 		     {return CHAR;}
"FLOAT"			 {return FLOAT;}

"main"	   {printf("main function start"); return MAIN; }

{header}  				{printf("Header file found ");}
[-+/*<>=,();%^]     {yylval = yytext[0];	return *yytext;	}
{variable}+	    { yylval = *yytext - 'a'; return	VAR; }





%%
