%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>		
#include <math.h>

int _lineno = 1;
int token_index = 0;
char tokens[10000];
char errs[100000];
%}

DIGITO		[0-9]
LETRA		[a-zA-Z]
ALFA		{LETRA}|{DIGITO}
NUMERO		{DIGITO}+
EXPONENTE	[eE][+-]{NUMERO}
REAL		{NUMERO}.{NUMERO}{EXPONENTE}?
PALABRA		{LETRA}+
CADENA		["']([ ]?({ALFA}|%|,|;|:|_|-)+[ ]?)*["']
ID		{LETRA}{ALFA}*
%%
"Main"|"main"	{ printf("MAIN "); }
"("		{ printf("parent-a= ( "); }
"void"		{ printf(" VOID "); }
")"		{ printf(" parent-c= ) "); }
"{"		{ printf("inicio= { "); }
"}"		{ printf("fin= } "); ++_lineno; }
"["		{ printf(" corch-a= [ "); }
"]"		{ printf(" corch-c= ] "); }
"int"		{ printf(" ENTERO "); }
"float"		{ printf(" REAL "); }
"char"		{ printf(" CARACTER "); }
"printf"	{ printf(" ESCRIBIR "); }
"scanf"		{ printf(" LEER "); }
"<--"		{ printf(" op-asign= <--"); }
"+" 		{ printf(" op-sum= + "); }
"-" 		{ printf(" op-sust= - "); }
"*" 		{ printf(" op-mult= * "); }
"/" 		{ printf(" op-div= / "); }
"^" 		{ printf(" op-exp= ^ "); }
"="		{ printf(" op-igual= ="); }
"<="		{ printf(" op-men-ig= <= "); }
">="		{ printf(" op-may-ig= >= "); }
"<>"		{ printf(" op-difer= <> "); }
">"		{ printf(" op-mayor= > "); }
"<"		{ printf(" op-menor= < "); } 
"=="		{ printf(" op-comp= == "); }
"y"		{ printf(" op-y= y "); }
"o"		{ printf(" op-o= o"); }
"~"		{ printf(" op-no= ~"); }
"true"		{ printf(" op-ver= true"); }
"false" 	{ printf(" op-fal= false"); }
"if"		{ printf(" SI "); }
"else"		{ printf(" SINO "); }
"for"		{ printf(" PARA "); }
"while"		{ printf(" MIENTRAS QUE "); }
"switch"	{ printf(" DEPENDIENDO DE "); }
{CADENA}	{ printf(" cte-cadena= %s ", yytext); }
{ID}		{ 
			printf(" ID: %s ", yytext);			
			char *result = malloc(strlen("ID: ") +strlen(yytext) +strlen("\t") +1);
			strcpy(result, "ID: ");
			strcat(result, yytext);
			strcat(result, "\t");
			if(!strstr(tokens, result)){
				strcat(tokens, result);			
			}
		}
{REAL}		{ printf(" cte-real= %s ", yytext); }
{NUMERO}	{ printf(" cte-entero= %s ", yytext); }
";"		{ printf(" punto-coma= ; "); }
","		{ printf(" coma= , "); }
"\."		{ printf(" punto= ."); }
[ ]		;
"\n"		{ printf("\n"); ++_lineno; }
.		{ 
			printf("\nERROR EN LINEA %d, EN %s\n", _lineno, yytext); 
			char str[12];
			sprintf(str, "%d", _lineno);
			char* result = malloc(strlen("\tERROR EN LINEA ") +strlen(str) +strlen(", EN ") +strlen(yytext) +strlen("\n") +1);
			strcpy(result, "\tERROR EN LINEA ");
			strcat(result, str);
			strcat(result, ", EN ");
			strcat(result, yytext);
			strcat(result, "\n");
			strcat(errs, result);		
			++_lineno; 
		}
%%
int main(int argc, char *argv[]){
	if(tokens != NULL){
		printf("Memory allocated!");
	}
	++argv, --argc;
	if(argc > 0){
		yyin = fopen(argv[0], "r");
	}else{
		yyin = stdin;	
	}
	yylex();
	printf("\n\nIDENTIFICADORES\n%s", tokens);
	printf("\n\nERRORES:\n%s", errs);
	return 0;
}
