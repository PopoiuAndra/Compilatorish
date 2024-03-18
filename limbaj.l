%{
#include <stdio.h>
#include <iostream>
#include "limbaj.tab.h"
using namespace std;

float atof(char* nr)
{
    int i = 0, numar = 0, p = 1;
    while(nr[i] != ',' && nr[i] != '\0')
    {
        numar *=10;
        numar += nr[i] - '0';
        i++;
    }
    if(nr[i] == '\0') return numar;

    i++;
    while(nr[i] != '\0')
    {   
        p *= 10;
        numar = numar*10 + nr[i] - '0';
        i++;
    }
    return (float)numar/p;
}
%}
%option noyywrap
%%

"Eval" {cout << "\nEval\n"; return EVALAST;}
"TypeOf" {cout <<"\nTypeOf\n"; return TYPEOF;}

"/com"(.|\n)+"com/" ; // Comentariu
"int"|"float"|"char"|"bool" {yylval.string = strdup(yytext);return TYPE;}
"string" {yylval.string = strdup(yytext); return STRING;}
"array" { yylval.string = strdup(yytext); return ARRAY;}
"const" {yylval.string = strdup(yytext);  return CONST;}
"true"|"false" {yylval.string = strdup(yytext);  return BOOLVAL;}

"clasuta" { yylval.string = strdup(yytext); return CLASA;} 
"privat" {return PRIVAT;}
"public" {return PUBLIC;}
"declar_dureri_de_cap" {yylval.string = strdup(yytext); return DECL;}
"incep_durerea_de_cap" {return INCEPCLASA;}
"termin_durerea_de_cap" {return TERMINCLASA;}
"functie" {return FUNCTIE;} // in.y -> fuction -> FUNCTIE TYPE NUNME_FUNCTIE
"void" {yylval.string = strdup(yytext); return VOID;}
"return" { return RETUR;}

"incep_functia" {return INCEPFCT;}
"termin_functia" {return TERMINFCT;}


"insta" { return  IF;}
"threads" {return ELSE;}
"tikTok" {return FOR;}
"whatsApp" { return WHILE;}

"==" { return EQ;}
"!=" { return NEQ;}
">=" {return GE;}
"<="  { return LE;}
"&&" {return AND;}
"||" {return OR;}
"!" { return NOT;}


"begin_define_data" {return BGIN1;}
"end_define_data" { return END1;}

"begin_global_var" {return BGIN2;}
"end_global_var" {return END2;}

"begin_global_funct" {return BGIN3;}
"end_global_funct" { return END3;}

"begin_progr" {return BGIN4;}
"end_progr" { return END4;}

[a-zA-Z][a-zA-Z0-9]* {yylval.string = strdup(yytext); return ID;}
":=" {yylval.string = strdup(yytext); return ASSIGN;}
0|-?[1-9][0-9]* {yylval.intval = atoi(yytext); return NR;}
-?[1-9][0-9]*","[0-9]*|0","[0-9]* {yylval.fltval = atof(yytext);  return NR_FLOAT;} 
"'"[^\n]"'" {yylval.charval = yytext[1]; return NR_CHAR;}

[ \t] ;
\n {yylineno++;}
. {return yytext[0];}

%% 

