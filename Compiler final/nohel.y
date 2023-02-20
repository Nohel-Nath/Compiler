%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<math.h>
	int data[60];
%}



%token NUM VAR IF ELSE  MAIN INT FLOAT CHAR START END FOR WHILE inc dec not
%nonassoc IFX
%nonassoc ELSE
%left '<' '>'
%left '+' '-'
%left '*' '/'



%%

program: MAIN  START line END {printf("Main function END\n");}
	 ;

line: 

	| line statement
	;

statement: ';'			
	| declaration ';'		{  }

	| expression ';' 			{   printf("value of expression: %d\n", $1); $$=$1;
		
		}
	
	| VAR '=' expression ';' { 
							printf("\nValue of the variable: %d\n",$3);
							data[$1]=$3;
							$$=$3;
							
						} 
   
	| WHILE '(' NUM '<' NUM ')' START statement END {
	                                int i;
	                                printf("WHILE Loop execution");
	                                for(i=$3 ; i<$5 ; i++) {printf("\nvalue of the loop: %d expression value: %d\n", i,$8);}
	                               									
				               }
	

	| IF '(' expression ')' START expression ';' END %prec IFX {
								if($3){
									printf("\nvalue of expression in IF: %d\n",$6);
								}
								else{
									printf("\ncondition value zero in IF block\n");
								}
								
							}

	| IF '(' expression ')' START expression ';' END ELSE START expression ';' END {
								if($3){
									printf("value of expression in IF: %d\n",$6);
								}
								else{
									printf("value of expression in ELSE: %d\n",$11);
								}
	
		}
	
	;




	| FOR '(' NUM ',' NUM ',' NUM ')' START statement END {
	                                int i;
	                                printf("FOR Loop execution");
	                                for(i=$3 ; i<$5 ; i=i+$7 ) 
	                                {printf("\nvalue of the  i: %d expression value : %d\n", i,$10);}
	                                
				               }

	
	;


	

	
declaration : TYPE ID1   { }
            ;


TYPE : INT   {printf("interger declaration\n");}
     | FLOAT  {printf("float declaration\n");}
     | CHAR   {printf("char declaration\n");}
     ;



ID1 : ID1 ',' VAR  
    |VAR  
    ;

 


expression: NUM					{  $$ = $1;  }

	| VAR						{ $$ = data[$1]; }
	
	| expression '+' expression	{printf("\nAddition :%d+%d = %d \n",$1,$3,$1+$3 );  $$ = $1 + $3;}

	| expression '-' expression	{printf("\nSubtraction :%d-%d=%d \n ",$1,$3,$1-$3); $$ = $1 - $3; }

	| expression '*' expression	{printf("\nMultiplication :%d*%d \n ",$1,$3,$1*$3); $$ = $1 * $3; }

	| expression '/' expression	{ if($3){
				     					printf("\nDivision :%d/%d \n ",$1,$3,$1/$3);
				     					$$ = $1 / $3;
				     					
				  					}
				  					else{
										$$ = 0;
										printf("\ndivision by zero\n\t");
				  					} 	
				    			}
	
	
	| expression '<' expression	{printf("\nLess Than :%d < %d \n",$1,$3,$1 < $3); $$ = $1 < $3 ; }
	
	| expression '>' expression	{printf("\nGreater than :%d > %d \n ",$1,$3,$1 > $3); $$ = $1 > $3; }

	
	|inc expression inc         { $$=$2+1; printf("inc: %d\n",$$);}

	|dec expression dec         { $$=$2-1; printf("dec: %d\n",$$);}

	|not expression not {
						if($2 != 0)
						{
							$$ = 0; printf("not: %d\n",$$);
						}
						else{
							$$ = 1 ; printf("yes: %d\n",$$);
						}
					}
	
	;
%%


int  yyerror(char *s){
	printf( "%s\n", s);
}
int yywrap()
{
	return 1;
}

int main()
{
	freopen("input.txt","r",stdin);
	freopen("output.txt","w",stdout);
	yyparse();

    
	return 0;
}
