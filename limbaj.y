%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <iostream>
#include <vector>
#include <math.h>
#include "IdList.h"
extern FILE* yyin;
extern char* yytext;
extern int yylineno;
extern int yylex();
void yyerror(const char * s);

string I="int";
string F="float";
string C="char";
string B="bool";
class IdList ids;

union value {
     int intVal;
     float floatVal;
     char strVal[101];
     char charVal;
	 int boolVal;
};

struct node {
	int type;
    int nr;
	union value var;
	struct node *left;
	struct node *right;
};

class ASTree {
    struct node * AST;
    public:
        
    struct node* buildAST(union value root,struct node* left,struct node* right,int nr, int type){
      	struct node*  AST = (struct node *)malloc(sizeof(struct node));
	    AST->var = root;
      	AST->type = type;
      	AST->nr = nr;
      	AST->left = left;
     	AST->right = right;
     	return AST;
    }

    int evalASTInt(struct node* AST){
        
	    int leftval = 0;
	    int rightval = 0;
	    if(AST->left != NULL)
		    leftval = evalASTInt(AST->left);
	    if(AST->right != NULL)
		    rightval = evalASTInt(AST->right);
	    switch(AST->type)
	    {
		    case 1:
			    return leftval + rightval;
		    break;
		    case 2:
			    return leftval - rightval;
		    break;
		    case 3:
			    return leftval * rightval;
		    break;
		    case 4:
			    return leftval / rightval;
		    break;
		    case 5:
			    return AST->var.intVal;
		    break;
            case 6:
                return ids.returnValInt(AST->var.strVal);
			break;
            case 7:
			    return ids.returnValIntAr(AST->var.strVal, AST->nr);
		    break;
            
		    default ://fct
			    return 0;
	    }
     };
     float evalASTFloat(struct node* AST){
        
	    float leftval = 0;
	    float rightval = 0;
	    if(AST->left != NULL)
		    leftval = evalASTFloat(AST->left);
	    if(AST->right != NULL)
		    rightval = evalASTFloat(AST->right);
	    switch(AST->type)
	    {
		    case 1:
			    return leftval + rightval;
		    break;
		    case 2:
			    return leftval - rightval;
		    break;
		    case 3:
			    return leftval * rightval;
		    break;
		    case 4:
			    return leftval / rightval;
		    break;
		    case 5:
			    return AST->var.floatVal;
		    break;
            case 6:
                return ids.returnValFloat(AST->var.strVal);
			break;
            case 7:
			    return ids.returnValFloatAr(AST->var.strVal, AST->nr);
		    break;
		    default :
			    return 0;
	    }
     };
     float evalAST(struct node* AST){
        
	    float leftval = 0;
	    float rightval = 0;
	    if(AST->left != NULL)
		    leftval = evalAST(AST->left);
	    if(AST->right != NULL)
		    rightval = evalAST(AST->right);
	    switch(AST->type)
	    {
		    case 1:
			    return leftval + rightval;
		    break;
		    case 2:
			    return leftval - rightval;
		    break;
		    case 3:
			    return leftval * rightval;
		    break;
		    case 4:
			    return leftval / rightval;
		    break;
		    case 5:
			    return AST->var.intVal;
		    break;
            case 6:
                return ids.returnValInt(AST->var.strVal);
			break;
            case 7:
			    return ids.returnValIntAr(AST->var.strVal, AST->nr);
		    break;
            case 8:
                 return leftval < rightval;
		    break;
            case 9:
                 return leftval > rightval;
		    break;
            case 10:
                 return leftval >= rightval;
		    break;
            case 11:
                 return leftval <= rightval;
		    break;
            case 12:
                 return leftval == rightval;
		    break;
            case 13:
                 return leftval != rightval;
		    break;
            case 14:
                 return 1 - leftval ;
		    break;
            case 15:
                 return leftval && rightval;
		    break;
            case 16:
                 return leftval || rightval;
		    break;
            
		    default :
			    return 0;
	    }
     };
}a;



int ct = 0;
//class IdList ids;

//class ASTree * abs;
string S="string";
string Tr ="true";
string Fl="false";
string locatie ="global";
string locatie2 ="global";
string nume;
string aux;
string calltype;
string returntype;
string tip = "";
int privat = 0;
int eroare = 0;
char numar[10];
void itoa(int nr)
{
  int n = 0, aux;
  if(nr == 0)
  { numar[0] = '0', numar[1] = '\0'; return;} 

  while(nr != 0)
  {
    numar[n++] = nr % 10 + '0';
    nr/=10;
  }
  numar[n] = '\0';

  for(int i = 0; i < n/2; ++ i)
  {
    aux = numar[i];
    numar[i] = numar[n - i - 1];
    numar[n - i - 1] = aux;
  }
}

%}
%union {
     char* string;
     int intval;
     float fltval;
     char charval;
     bool boolval;
     struct node * ast;
     //class ASTree *ast;// = (class ASTree *)malloc(sizeof(class ASTree *));
}

%token  BGIN1 END1 BGIN2 END2 BGIN3 END3 BGIN4 END4 PUBLIC PRIVAT INCEPFCT TERMINFCT INCEPCLASA TERMINCLASA RETUR ELSE
%token  OPB AND OR NOT TYPEOF EVALAST
%token<fltval> NR_FLOAT 
%token<intval> NR
%token<charval> NR_CHAR
%token<string> ID ARRAY TYPE CLASA DECL IF FOR WHILE STRING CONST ASSIGN FUNCTIE BOOLVAL VOID 
%type<intval> eI
%type<fltval> eF
%type<charval> eC
%type<boolval> eB
%type<string> NUME NUME2 expresie
%type<ast> expr eI2 eF2 eB2

%left '<' '>' GE LE EQ NEQ
%left '+' '-'
%left '*' '/'

%start progr
%%
progr: bgin1 clase END1 bgin2 declarations END2 BGIN3 functii END3 bgin4 block END4 {printf("The programme is correct!\n");}
     ;

bgin1: BGIN1 {locatie = locatie2 = "clasa";};
bgin2: BGIN2 {locatie = locatie2 = "global";};
bgin4: BGIN4 {locatie = locatie2 = "main";};

eval : EVALAST'(' expr ')' ;

expr: '{' eI2 '}' {if(eroare == 0) printf("Expresia trimisa la linia %d are valoarea: %d\n\n",yylineno, a.evalASTInt($2));
                            else yyerror("Tipurile expresiei nu se potrivesc!"); 
                            eroare = 0;}
    | '[' eF2 ']' {if(eroare == 0) printf("Expresia trimisa la linia %d are valoarea: %f\n\n",yylineno, a.evalASTFloat($2));
                            else yyerror("Tipurile expresiei nu se potrivesc!"); 
                            eroare = 0;}
    | '(' eB2 ')' {if(eroare == 0){if(a.evalAST($2) == 0) printf("Expresia trimisa la linia %d are valoarea: true\n\n",yylineno);
                                    else printf("Expresia trimisa la linia %d are valoarea: false\n\n",yylineno); }
                            else yyerror("Tipurile expresiei nu se potrivesc!\n\n"); 
                            eroare = 0;};
    ;


eI2 :  eI2 '+' eI2  {union value x; x.intVal = $<charval>2; $$ = a.buildAST(x,$1,$3, 0, 1); printf("adaugat nodul interior: +\n");}
  |  eI2 '-' eI2  {union value x; x.intVal = $<charval>2; $$ = a.buildAST(x,$1,$3, 0, 2); printf("adaugat nodul interior: -\n");}
  |  eI2 '*' eI2  {union value x; x.intVal = $<charval>2; $$ = a.buildAST(x,$1,$3, 0, 3); printf("adaugat nodul interior: *\n");}
  |  eI2 '/' eI2  {union value x; x.intVal = $<charval>2; $$ = a.buildAST(x,$1,$3, 0, 4); printf("adaugat nodul interior: /\n");}
  |  '{' eI2 '}' {$$ = $2; }
  |  NR {union value x; x.intVal = $1; $$ = a.buildAST(x,NULL,NULL,0,5); printf("am inserat frunza %d\n", $1);}
  |  NR_FLOAT {eroare = 1;}
  |  BOOLVAL {eroare = 1;}
  |  NR_CHAR {eroare = 1;}
  |  ID { if(!ids.existsVar($1)) yyerror("Nu exista variabila!"), eroare = 1;
          else if(ids.varType($1) != I) yyerror("Ai gresit type-ul: eI"), eroare = 1;
          else {union value x; strcpy(x.strVal, $1); $$ = a.buildAST(x,NULL,NULL, 0, 6);printf("am inserat frunza %s\n", $1);}
            } 
  | ID '[' NR ']' {if(!ids.existsVar($1) || !ids.existsVarArray($1, $3)) yyerror("Nu exista variabila!"), eroare = 1;
                   else if(ids.varType($1) != I) yyerror("Ai gresit type-ul: statement"), eroare = 1;
                   else {union value x; strcpy(x.strVal, $1); $$ = a.buildAST(x,NULL,NULL,$3,7);printf("am inserat frunza %s\n", $1);}                  
                }
  | ID '(' call_list ')' {if(!ids.existsVarFct($1)) yyerror("Nu exista funcia!"), eroare = 1;
                        else if(ids.varType($1) != I) yyerror("Difera tipurile!"), eroare = 1;
                        else  if(calltype != ids.paramFct($1))  yyerror("Parametrii functiei sunt gresiti!"), eroare = 1;
                        else if(ids.isPriv($1)) yyerror("Functia este privata si nu poate fi modificata"), eroare = 1;
                        else {union value x; strcpy(x.strVal, $1); $$ = a.buildAST(x,NULL,NULL, 0, 17);printf("am inserat frunza %s\n", $1);} 
                    }
  | ID '(' ')'{if(!ids.existsVarFct($1)) yyerror("Nu exista funcia!"), eroare = 1;
                        else if(ids.varType($1) != I) yyerror("Difera tipurile!"), eroare = 1;
                        else if(ids.isPriv($1)) yyerror("Functia este privata si nu poate fi modificata"), eroare = 1;
                   else {union value x; strcpy(x.strVal, $1); $$ = a.buildAST(x,NULL,NULL, 0, 17);printf("am inserat frunza %s\n", $1);} 
                }
  ;

eF2 :  eF2 '+' eF2   {union value x; x.floatVal = $<charval>2; $$ = a.buildAST(x,$1,$3, 0, 1); printf("adaugat nodul interior: +\n");}
  |  eF2 '-' eF2  {union value x; x.floatVal = $<charval>2; $$ = a.buildAST(x,$1,$3, 0, 2); printf("adaugat nodul interior: -\n");}
  |  eF2 '*' eF2   {union value x; x.floatVal = $<charval>2; $$ = a.buildAST(x,$1,$3, 0, 3); printf("adaugat nodul interior: *\n");}
  |  eF2 '/' eF2   {union value x; x.floatVal = $<charval>2; $$ = a.buildAST(x,$1,$3, 0, 4); printf("adaugat nodul interior: /\n");}
  |  '[' eF2 ']' {$$ = $2; }
  |  NR_FLOAT  {union value x; x.floatVal = $1; $$ = a.buildAST(x,NULL,NULL,0,5); printf("am inserat frunza %f\n", $1);}
  |  NR {eroare = 1;}
  |  BOOLVAL {eroare = 1;}
  |  NR_CHAR {eroare = 1;}
  |  ID  { if(!ids.existsVar($1)) yyerror("Nu exista variabila!"), eroare = 1;
           else if(ids.varType($1)!= F) yyerror("Ai gresit type-ul: eF"), eroare = 1;
           else {union value x; strcpy(x.strVal, $1); $$ = a.buildAST(x,NULL,NULL, 0, 6);printf("am inserat frunza %s\n", $1);}  } 
  | ID '[' NR ']' {if(!ids.existsVar($1) || !ids.existsVarArray($1, $3)) yyerror("Nu exista variabila!"), eroare = 1;
                   else if(ids.varType($1) != F) yyerror("Ai gresit type-ul: statement"), eroare = 1;
                   else {union value x; strcpy(x.strVal, $1); $$ = a.buildAST(x,NULL,NULL,$3,7);printf("am inserat frunza %s\n", $1);}                      
                }
  | ID '(' call_list ')' {if(!ids.existsVarFct($1)) yyerror("Nu exista funcia!"), eroare = 1;
                        else if(ids.varType($1) != F) yyerror("Difera tipurile!"), eroare = 1;
                        else if(ids.isPriv($1)) yyerror("Functia este privata si nu poate fi modificata"), eroare = 1;
                        else  if(calltype != ids.paramFct($1))  yyerror("Parametrii functiei sunt gresiti!"), eroare = 1;
                   else {union value x; strcpy(x.strVal, $1); $$ = a.buildAST(x,NULL,NULL, 0, 17);printf("am inserat frunza %s\n", $1);} 
                    }
  | ID '(' ')'{if(!ids.existsVarFct($1)) yyerror("Nu exista funcia!"), eroare = 1;
                        else if(ids.varType($1) != F) yyerror("Difera tipurile!"), eroare = 1;
                        else if(ids.isPriv($1)) yyerror("Functia este privata si nu poate fi modificata"), eroare = 1;
                   else {union value x; strcpy(x.strVal, $1); $$ = a.buildAST(x,NULL,NULL, 0, 17);printf("am inserat frunza %s\n", $1);} 
                    }
  ;

eB2:  NOT eB2 {union value x; x.charVal = $<charval>2; $$ = a.buildAST(x,$2,NULL, 0, 14); printf("adaugat nodul interior: !\n");}
  | eI2 '<' eI2 {union value x; x.charVal = $<charval>2; $$ = a.buildAST(x,$1,$3, 0, 8); printf("adaugat nodul interior: <\n");}
  | eF2 '<' eF2 {union value x; x.charVal = $<charval>2; $$ = a.buildAST(x,$1,$3, 0, 8); printf("adaugat nodul interior: <\n");}
  | eI2 '>' eI2 {union value x; x.charVal = $<charval>2; $$ = a.buildAST(x,$1,$3, 0, 9); printf("adaugat nodul interior: >\n");}
  | eF2 '>' eF2 {union value x; x.charVal = $<charval>2; $$ = a.buildAST(x,$1,$3, 0, 9); printf("adaugat nodul interior: >\n");}
  | eI2 EQ eI2{union value x; x.charVal = $<charval>2; $$ = a.buildAST(x,$1,$3, 0, 12); printf("adaugat nodul interior: ==\n");}
  | eF2 EQ eF2 {union value x; x.charVal = $<charval>2; $$ = a.buildAST(x,$1,$3, 0, 12); printf("adaugat nodul interior: ==\n");}
  | eI2 NEQ eI2 {union value x; x.charVal = $<charval>2; $$ = a.buildAST(x,$1,$3, 0, 13); printf("adaugat nodul interior: !=\n");}
  | eF2 NEQ eF2 {union value x; x.charVal = $<charval>2; $$ = a.buildAST(x,$1,$3, 0, 13); printf("adaugat nodul interior: !=\n");}
  | eI2 GE eI2 {union value x; x.charVal = $<charval>2; $$ = a.buildAST(x,$1,$3, 0, 10); printf("adaugat nodul interior: >=\n");}
  | eF2 GE eF2 {union value x; x.charVal = $<charval>2; $$ = a.buildAST(x,$1,$3, 0, 10); printf("adaugat nodul interior: >=\n");}
  | eI2 LE eI2 {union value x; x.charVal = $<charval>2; $$ = a.buildAST(x,$1,$3, 0, 11); printf("adaugat nodul interior: <=\n");}
  | eF2 LE eF2 {union value x; x.charVal = $<charval>2; $$ = a.buildAST(x,$1,$3, 0, 11); printf("adaugat nodul interior: <=\n");}
  | eB2 AND eB2 {union value x; x.charVal = $<charval>2; $$ = a.buildAST(x,$1,$3, 0, 15); printf("adaugat nodul interior: &&\n");}
  | eB2 OR eB2  {union value x; x.charVal = $<charval>2; $$ = a.buildAST(x,$1,$3, 0, 16); printf("adaugat nodul interior: ||\n");}
  | BOOLVAL {union value x; if($1 == Tr) x.boolVal = 1; else x.boolVal = 0; $$ = a.buildAST(x,NULL,NULL, 0, 5); printf("am inserat frunza %s\n", $1);}
  |  NR_FLOAT {eroare = 1; }
  |  NR {eroare = 1;}
  |  NR_CHAR {eroare = 1;}
  | ID { if(!ids.existsVar($1)) yyerror("Nu exista variabila!"), eroare = 1;
         else if(ids.varType($1) != B) yyerror("Ai gresit type-ul: eB"), eroare = 1;
           else {union value x; strcpy(x.strVal, $1); $$ = a.buildAST(x,NULL,NULL, 0, 6);printf("am inserat frunza %s\n", $1);}  
        }
  | ID '[' NR ']' {if(!ids.existsVar($1) || !ids.existsVarArray($1, $3)) yyerror("Nu exista variabila!"), eroare = 1;
                   else if(ids.varType($1) != B) yyerror("Ai gresit type-ul: statement"), eroare = 1;
           else {union value x; strcpy(x.strVal, $1); $$ = a.buildAST(x,NULL,NULL,$3, 7);printf("am inserat frunza %s\n", $1);}                     
                }
  |  '(' eB2 ')' {$$ = $2; }
  | ID '(' call_list ')' {if(!ids.existsVarFct($1)) yyerror("Nu exista funcia!"), eroare = 1;
                        else if(ids.varType($1) != B) yyerror("Difera tipurile!"), eroare = 1;
                        else if(ids.isPriv($1)) yyerror("Functia este privata si nu poate fi modificata"), eroare = 1;
                        else  if(calltype != ids.paramFct($1))  yyerror("Parametrii functiei sunt gresiti!"), eroare = 1;
                        else {union value x; strcpy(x.strVal, $1); $$ = a.buildAST(x,NULL,NULL, 0, 17);printf("am inserat frunza %s\n", $1);}  
                        }
  | ID '(' ')'{if(!ids.existsVarFct($1)) yyerror("Nu exista funcia!"), eroare = 1;
                        else if(ids.varType($1) != B) yyerror("Difera tipurile!"), eroare = 1;
                        else if(ids.isPriv($1)) yyerror("Functia este privata si nu poate fi modificata"), eroare = 1;
                         else {union value x; strcpy(x.strVal, $1); $$ = a.buildAST(x,NULL,NULL, 0, 17);printf("am inserat frunza %s\n", $1);}  
                }
  ; 


declarations :  decl ';'          
	      |  declarations decl ';'   
	      ;

decl       :  TYPE ID { if(!ids.existsVar($2)) {
                          ids.addVar($1,$2, 0, 0, '0',0, locatie);
                        if(privat == 1) ids.addVarPriv($2);
                     }
                        else yyerror("exista id-ul");
                    }
           | TYPE ID '=' NR{  if($1 != I) yyerror("Ai gresit type-ul");
                            else if(!ids.existsVar($2)) {
                          ids.addVar($1,$2, $4, -1, '0', 0, locatie);
                        if(privat == 1) ids.addVarPriv($2);
                     }
                        else yyerror("exista id-ul");
                            eroare = 0;
                    }
           | TYPE ID '=' NR_CHAR {  if($1 != C) yyerror("Ai gresit type-ul");
                            if(!ids.existsVar($2)) {
                          ids.addVar($1,$2, -1, -1, $4, 0, locatie);
                        if(privat == 1) ids.addVarPriv($2);
                     }
                        else yyerror("exista id-ul");
                            eroare = 0;
                    }
           | TYPE ID '=' NR_FLOAT{  if( $1 != F) yyerror("Ai gresit type-ul");
                            if(!ids.existsVar($2)) {
                          ids.addVar($1,$2, -1, $4, '0', 0, locatie);
                        if(privat == 1) ids.addVarPriv($2);
                     }
                        else yyerror("exista id-ul");
                            eroare = 0;
                     } 
           | TYPE ID '='  BOOLVAL {  if( $1 != B) yyerror("Ai gresit type-ul");
                            if(!ids.existsVar($2)) {
                        if(privat == 1) ids.addVarPriv($2);
                            if($4 == Tr)
                                    ids.addVar($1,$2, -1, -1, '0', 1, locatie);
                            else 
                                    ids.addVar($1,$2, -1, -1, '0', 0, locatie);
                     }
                        else yyerror("exista id-ul");
                            eroare = 0;
                        } 
           | CONST TYPE ID '=' NR {  if($2 != I && $2 != F) yyerror("Ai gresit type-ul");
                            if(!ids.existsVar($3)) {
                          ids.addVar($2,$3, $5, -1, '0', 0, locatie);
                          ids.addVarConst($3);
                        if(privat == 1) ids.addVarPriv($3);
                     }
                        else yyerror("exista id-ul");
                            eroare = 0;
                    }
           | CONST TYPE ID '=' NR_CHAR { if($2 != C) yyerror("Ai gresit type-ul");
                             if(!ids.existsVar($3)) {
                          ids.addVar($2,$3, -1, -1, $5, 0, locatie);
                          ids.addVarConst($3);
                        if(privat == 1) ids.addVarPriv($3);
                     }
                        else yyerror("exista id-ul");
                            eroare = 0;
                    }
           | CONST TYPE ID '=' NR_FLOAT{  if($2 != F) yyerror("Ai gresit type-ul");
                            if(!ids.existsVar($3)) {
                          ids.addVar($2,$3, -1, $5, -1, 0, locatie);
                          ids.addVarConst($3);
                        if(privat == 1) ids.addVarPriv($3);
                     }
                        else yyerror("exista id-ul");
                    }
            | CONST TYPE ID '=' BOOLVAL {  if( $2 != B) yyerror("Ai gresit type-ul");
                            if(!ids.existsVar($3)) {
                            if($5 == Tr)
                                    ids.addVar($2,$3, -1, -1, -1, 1, locatie);
                            else 
                                    ids.addVar($2,$3, -1, -1, -1, 0, locatie);
                          ids.addVarConst($3);
                        if(privat == 1) ids.addVarPriv($3);
                     }
                        else yyerror("exista id-ul");
                            eroare = 0;
                        } 
           | ARRAY TYPE ID '[' NR ']' {
                        if(!ids.existsVar($3)){
                            ids.addVarArray($2, $3, $5, locatie);
                            for(int i = 0; i <= $5; ++ i)
                                ids.updateVarArray($3, 0, 0, '0', 0, i);
                        if(privat == 1) ids.addVarPriv($3);
                        }
                        else yyerror("exista id-ul");
                            eroare = 0;
    
                    }
           | STRING ID '[' NR ']' {
                        if(!ids.existsVar($2)){
                            ids.addVarArray($1, $2, $4, locatie);
                            for(int i = 0; i <= $4; ++ i)
                                ids.updateVarArray($2, '0', '0', '0', '0', i);
                        if(privat == 1) ids.addVarPriv($2);
    
                        }
                        else yyerror("exista id-ul");
                    }
           | CLASA ID ID {
                        std::string loc = $2;
                        if(!ids.existsVarCls($2)) yyerror("Clasa nu exista!");
                        if(!ids.existsVar($3)) {
                            ids.addVar($1, $3, 0, 0, '0', 0, $2);
                        if(privat == 1) ids.addVarPriv($3);
                        }
                        else yyerror("exista id-ul");
                    }
           ;


list_param : param
            | list_param ','  param 
            ;


            
param : TYPE ID {
                if(ids.existsVar($2)) yyerror("Variabila exista deja!");
                else ids.addVar($1, $2, 0, 0, 0, 0, locatie);   
                calltype += $1[0];

                }
                  ; 
      

block : list
     ;
     

list :  statement ';' 
     | list declarations
     | list statement ';'
     | list if
     | list while
     | list for
     | list typeof ';'
     | typeof ';' 
     | declarations
     | list eval ';'
     ;

typeof : TYPEOF '(' expresie ')'  {if (eroare != 0) yyerror("Eroare la typeOf()! Type-urile nu se potrivesc");
                                   else std::cout << "Tipul expresiei este: " << $3 <<"\n";
                                    eroare = 0;};

expresie: '{' eI '}' { $$ = (char *) "int"; }
        | '[' eF ']'{ $$ = (char *) "float"; }
        | '(' eB ')'{ $$ = (char *)"bool";}
        | eC { $$ = (char *) "char";}
        ;


while: WHILE '(' eB ')' '{' blockF '}';

for:FOR '(' ID '=' el ';' eB  ';' '-''-' ID ')' '{' blockF '}' { if(!ids.existsVar($3)) yyerror("Variabila nu exista!");}
    |FOR '(' ID '=' el ';' eB  ';' '+''+' ID ')' '{' blockF '}'{ if(!ids.existsVar($3)) yyerror("Variabila nu exista!");}
    ;

if: IF '(' eB  ')' '{' blockF '}'
   |  IF '(' eB  ')' '{' blockF '}' ELSE '{' blockF '}'
   ;

blockF: listF;

listF: statementF ';' 
     | listF statementF ';'
     | listF if
     | listF while
     | listF for
     | decl ';'
     | listF decl ';'
     ;

statementF: 
         | ID ASSIGN ID '(' call_list ')' { if(!ids.existsVar($1)) yyerror("Variabila nu exista!");
                        else if(ids.isConst($1)) yyerror("Nu poti modifica valoarea variabilei!");
                                            else if(ids.varType($1) != ids.varType($3)) yyerror("Difera tipurile!");
                         else if(eroare == 1) yyerror("A fost produsa o eroare");
                         eroare = 0;}
         | ID ASSIGN ID '(' ')' { if(!ids.existsVar($1)) yyerror("Variabila nu exista!");
                        else if(ids.isConst($1)) yyerror("Nu poti modifica valoarea variabilei!");
                                  else if(ids.varType($1) != ids.varType($3)) yyerror("Difera tipurile!");
                         else if(eroare == 1) yyerror("A fost produsa o eroare");
                         eroare = 0;}
         | ID ASSIGN '{' eI '}' { if(!ids.existsVar($1)) yyerror("Variabila nu exista!");
                        else if(ids.isConst($1)) yyerror("Nu poti modifica valoarea variabilei!");
                                  else if(ids.varType($1) != "int") yyerror("Difera tipurile!");
                         else if(eroare == 1) yyerror("A fost produsa o eroare");
                         eroare = 0;}
         | ID ASSIGN '[' eF ']' { if(!ids.existsVar($1)) yyerror("Variabila nu exista!");
                        else if(ids.isConst($1)) yyerror("Nu poti modifica valoarea variabilei!");
                                  else if(ids.varType($1) != "float") yyerror("Difera tipurile!");
                         else if(eroare == 1) yyerror("A fost produsa o eroare");
                         eroare = 0;}
         | ID ASSIGN eC  { if(!ids.existsVar($1)) yyerror("Variabila nu exista!");
                        else if(ids.isConst($1)) yyerror("Nu poti modifica valoarea variabilei!");
                                 else if(ids.varType($1) != "char" || ids.varType($1) != S) yyerror("Difera tipurile!");
                         else if(eroare == 1) yyerror("A fost produsa o eroare");
                         eroare = 0;}
         | ID ASSIGN '(' eB ')' { if(!ids.existsVar($1)) yyerror("Variabila nu exista!");
                        else if(ids.isConst($1)) yyerror("Nu poti modifica valoarea variabilei!");
                                 else if(ids.varType($1) != "bool") yyerror("Difera tipurile!");
                         else if(eroare == 1) yyerror("A fost produsa o eroare");
                         eroare = 0;}
         | ID '[' NR ']' ASSIGN '{' eI '}'  { if(!ids.existsVar($1) || !ids.existsVarArray($1, $3) ) yyerror("Variabila nu exista!");
                         else if(eroare == 1) yyerror("A fost produsa o eroare");
                         eroare = 0;}
         | ID '[' NR ']' ASSIGN '[' eF ']'  { if(!ids.existsVar($1) || !ids.existsVarArray($1, $3) ) yyerror("Variabila nu exista!");
                         else if(eroare == 1) yyerror("A fost produsa o eroare");
                         eroare = 0;}
         | ID '[' NR ']' ASSIGN  eC   { if(!ids.existsVar($1) || !ids.existsVarArray($1, $3) ) yyerror("Variabila nu exista!");
                         else if(eroare == 1) yyerror("A fost produsa o eroare");
                         eroare = 0;}
         | ID '[' NR ']' ASSIGN '(' eB ')'  { if(!ids.existsVar($1) || !ids.existsVarArray($1, $3) ) yyerror("Variabila nu exista!");
                         else if(eroare == 1) yyerror("A fost produsa o eroare");
                         eroare = 0;}
         | ID '[' NR ']'  ASSIGN ID '(' call_list ')' { if(!ids.existsVar($1)|| !ids.existsVarArray($1, $3) ) yyerror("Variabila nu exista!");
                                                        else if(!ids.existsVarFct($6)) yyerror("Functia nu exista!");
                         else if(eroare == 1) yyerror("A fost produsa o eroare");
                         eroare = 0;
                    }
         | ID '[' NR ']' ASSIGN ID '(' ')' { if(!ids.existsVar($1)|| !ids.existsVarArray($1, $3) ) yyerror("Variabila nu exista!");
                                             else if(!ids.existsVarFct($6)) yyerror("Functia nu exista!");
                         else if(eroare == 1) yyerror("A fost produsa o eroare");
                         eroare = 0;
                    }
         | ID '(' call_list ')' { if(!ids.existsVarFct($1)) yyerror("Functia nu exista!");
                         else if(eroare == 1) yyerror("A fost produsa o eroare");
                         eroare = 0;} /// trebuie facut ceva cu parametrii aia
         ;

el:  NR
   | NR_FLOAT 
   | BOOLVAL
   | NR_CHAR
   ;

statement: ID ASSIGN ID '(' call_list ')'{
                        if(!ids.existsVar($1)) yyerror("Nu exista variabila!");
                        else   if(!ids.existsVarFct($3)) yyerror("Nu exista functia!");
                        else if(ids.varType($1) != ids.varType($3)) yyerror("Difera tipurile!");
                        else  if(calltype != ids.paramFct($3))  yyerror("Parametrii functiei sunt gresiti!");
                        else if(ids.isConst($1)) yyerror("Nu poti modifica valoarea variabilei!");
                        calltype = "";
                       }
         | ID ASSIGN ID '(' ')'{
                        if(!ids.existsVar($1)) yyerror("Nu exista variabila!");
                          else  if(!ids.existsVarFct($3)) yyerror("Nu exista functia!");
                        else if(ids.varType($1) != ids.varType($3)) yyerror("Difera tipurile!");
                        else if(ids.isConst($1)) yyerror("Nu poti modifica valoarea variabilei!");
                        calltype = "";
                       }
         | ID ASSIGN '{' eI '}' {
                        if(!ids.existsVar($1)) yyerror("Nu exista variabila!");
                        else if(ids.varType($1) != I) yyerror("Ai gresit type-ul: statement");
                        else if(ids.isConst($1)) yyerror("Nu poti modifica valoarea variabilei!");
                         else if(eroare == 0) ids.updateVar($1, $4, $4, $4, $4);
                        else yyerror("A fost produsa o eroare!");
                        eroare = 0;}
         | ID ASSIGN '[' eF ']' { 
                        if(!ids.existsVar($1)) yyerror("Nu exista variabila!");
                        else    if(ids.varType($1) != F) yyerror("Ai gresit type-ul: statement");
                        else if(ids.isConst($1)) yyerror("Nu poti modifica valoarea variabilei!");
                        else if(eroare == 0) ids.updateVar($1, $4, $4, $4, $4);
                        else yyerror("A fost produsa o eroare!");
                        eroare = 0;}
         | ID ASSIGN  eC  {
                        if(!ids.existsVar($1)) yyerror("Nu exista variabila!");
                        else    if(ids.varType($1) != C) yyerror("Ai gresit type-ul: statement");
                        else if(ids.isConst($1)) yyerror("Nu poti modifica valoarea variabilei!");
                        else if(eroare == 0) ids.updateVar($1, $3, $3, $3, $3);
                        else yyerror("A fost produsa o eroare!");
                        eroare = 0; }
         | ID ASSIGN '(' eB ')' { 
                        if(!ids.existsVar($1)) yyerror("Nu exista variabila!");
                        else    if(ids.varType($1) != B) yyerror("Ai gresit type-ul: statement");
                        else if(ids.isConst($1)) yyerror("Nu poti modifica valoarea variabilei!");
                        else if(eroare == 0)ids.updateVar($1, $4, $4, $4, $4); 
                        else yyerror("A fost produsa o eroare!");
                        eroare = 0;}
         | ID '[' NR ']' ASSIGN '{' eI '}' { 
                        if(!ids.existsVar($1) || !ids.existsVarArray($1, $3)) yyerror("Nu exista variabila!");
                        else if(ids.isConst($1)) yyerror("Nu poti modifica valoarea variabilei!");
                        else if(ids.varType($1) != I) yyerror("Ai gresit type-ul: statement");
                        else if(eroare == 0) ids.updateVarArray($1, $7, $7, $7, $7, $3);
                        else yyerror("A fost produsa o eroare!");
                        eroare = 0;}
         | ID '[' NR ']' ASSIGN '[' eF ']'{ 
                        if(!ids.existsVar($1) || !ids.existsVarArray($1, $3)) yyerror("Nu exista variabila!");
                        else if(ids.isConst($1)) yyerror("Nu poti modifica valoarea variabilei!");
                        else if(ids.varType($1) != F) yyerror("Ai gresit type-ul: statement");
                        else if(eroare == 0) ids.updateVarArray($1, $7, $7, $7, $7, $3);
                        else yyerror("A fost produsa o eroare!");
                        eroare = 0;}
         | ID '[' NR ']' ASSIGN  eC { 
                        if(!ids.existsVar($1) || !ids.existsVarArray($1, $3)) yyerror("Nu exista variabila!");
                        else if(ids.varType($1) != C && ids.varType($1) != S) yyerror("Ai gresit type-ul: statement");
                        else if(ids.isConst($1)) yyerror("Nu poti modifica valoarea variabilei!");
                        else if(eroare == 0) ids.updateVarArray($1, $6, $6, $6, $6, $3);
                        else yyerror("A fost produsa o eroare!");
                        eroare = 0;
                        }
         | ID '[' NR ']' ASSIGN '(' eB ')'{ 
                        if(!ids.existsVar($1) || !ids.existsVarArray($1, $3)) yyerror("Nu exista variabila!");
                        else if(ids.isConst($1)) yyerror("Nu poti modifica valoarea variabilei!");
                        else if(ids.varType($1) != B) yyerror("Ai gresit type-ul: statement");
                        else if(eroare == 0) ids.updateVarArray($1, $7, $7, $7, $7, $3);
                        else yyerror("A fost produsa o eroare!");
                        eroare = 0;
                        }
         | ID '[' NR ']'  ASSIGN ID '(' call_list ')'{
                        if(!ids.existsVar($1) || !ids.existsVarArray($1, $3)) yyerror("Nu exista variabila!");
                        else if(ids.isConst($1)) yyerror("Nu poti modifica valoarea variabilei!");
                        else   if(!ids.existsVarFct($6)) yyerror("Nu exista functia!");
                        else if(ids.varType($1) != ids.varType($6)) yyerror("Difera tipurile!");
                        else  if(calltype != ids.paramFct($6))  yyerror("Parametrii functiei sunt gresiti!");
                        calltype = "";
                        eroare = 0;
                       }
         | ID '[' NR ']' ASSIGN ID '(' ')'{
                        if(!ids.existsVar($1) || !ids.existsVarArray($1, $3)) yyerror("Nu exista variabila!");
                        else if(ids.isConst($1)) yyerror("Nu poti modifica valoarea variabilei!");
                        else   if(!ids.existsVarFct($6)) yyerror("Nu exista functia!");
                        else if(ids.varType($1) != ids.varType($6)) yyerror("Difera tipurile!");
                        else  if(calltype != ids.paramFct($6))  yyerror("Parametrii functiei sunt gresiti!");
                        calltype = "";
                        eroare = 0;
                       }
         | ID '(' call_list ')'{
                            if(!ids.existsVarFct($1)) yyerror("Nu exista functia!");
                        else if(ids.isConst($1)) yyerror("Nu poti modifica valoarea variabilei!");
                            else if(ids.varType($1) != "void") yyerror("Functia apelata gresit!");
                            else  if(calltype != ids.paramFct($1))  yyerror("Parametrii functiei sunt gresiti!");
                            calltype = "";
                            eroare = 0;
                        }
         | ID '(' ')'{
                            if(!ids.existsVarFct($1)) yyerror("Nu exista functia!");
                        else if(ids.isConst($1)) yyerror("Nu poti modifica valoarea variabilei!");
                            else if(ids.varType($1) != "void") yyerror("Functia apelata gresit!");
                            else  if(calltype != ids.paramFct($1))  yyerror("Parametrii functiei sunt gresiti!");
                            calltype = "";
                            eroare = 0;
                        }
// PENTRU ELEMENTE DIN CLASA
         | ID'.'ID ASSIGN ID '(' call_list ')'{
                        if(!ids.existsVar($1)) yyerror("Nu exista variabila!");
                        else if(ids.isConst($3)) yyerror("Nu poti modifica valoarea variabilei!");
                        else if(!ids.existsVar($3)) yyerror("Nu exista variabila!");
                        else if(ids.isPriv($3)) yyerror("Variabila este privata si nu poate fi modificata");
                        else   if(!ids.existsVarFct($3)) yyerror("Nu exista functia!");
                        else if(ids.varType($3) != ids.varType($5)) yyerror("Difera tipurile!");
                        else  if(calltype != ids.paramFct($5))  yyerror("Parametrii functiei sunt gresiti!");
                        else yyerror("A fost produsa o eroare!");
                        eroare = 0;
                                            }
         | ID'.'ID ASSIGN ID '(' ')'{
                        if(!ids.existsVar($1)) yyerror("Nu exista variabila!");
                        else if(ids.isConst($3)) yyerror("Nu poti modifica valoarea variabilei!");
                        else if(!ids.existsVar($3)) yyerror("Nu exista variabila!");
                        else if(ids.isPriv($3)) yyerror("Variabila este privata si nu poate fi modificata");
                        else  if(!ids.existsVarFct($3)) yyerror("Nu exista functia!");
                        else if(ids.varType($5) != ids.varType($5)) yyerror("Difera tipurile!");
                        else yyerror("A fost produsa o eroare!");
                        eroare = 0;
                                            }
         | ID'.'ID ASSIGN '{' eI '}' {
                        if(!ids.existsVar($1)) yyerror("Nu exista variabila!");
                        else if(ids.isConst($3)) yyerror("Nu poti modifica valoarea variabilei!");
                        else if(!ids.existsVar($3)) yyerror("Nu exista variabila!");
                        else if(ids.isPriv($3)) yyerror("Variabila este privata si nu poate fi modificata");
                        else if(ids.varType($3) != I) yyerror("Ai gresit type-ul: statement");
                         else if(eroare == 0) ids.updateVar($1, $6, $6, $6, $6);
                        else yyerror("A fost produsa o eroare!");
                        eroare = 0;}
         | ID'.'ID ASSIGN '[' eF ']' { 
                        if(!ids.existsVar($1)) yyerror("Nu exista variabila!");
                        else if(ids.isConst($3)) yyerror("Nu poti modifica valoarea variabilei!");
                        else if(!ids.existsVar($3)) yyerror("Nu exista variabila!");
                        else if(ids.isPriv($3)) yyerror("Variabila este privata si nu poate fi modificata");
                        else    if(ids.varType($3) != F) yyerror("Ai gresit type-ul: statement");
                        else if(eroare == 0) ids.updateVar($1, $6, $6, $6, $6);
                        else yyerror("A fost produsa o eroare!");
                        eroare = 0;}
         | ID'.'ID ASSIGN  eC  {
                        if(!ids.existsVar($1)) yyerror("Nu exista variabila!");
                        else if(ids.isConst($3)) yyerror("Nu poti modifica valoarea variabilei!");
                        else if(!ids.existsVar($3)) yyerror("Nu exista variabila!");
                        else if(ids.isPriv($3)) yyerror("Variabila este privata si nu poate fi modificata");
                        else    if(ids.varType($3) != C) yyerror("Ai gresit type-ul: statement");
                        else if(eroare == 0) ids.updateVar($1, $5, $5, $5, $5);
                        else yyerror("A fost produsa o eroare!");
                        eroare = 0; }
         | ID'.'ID ASSIGN '(' eB ')' { 
                        if(!ids.existsVar($1)) yyerror("Nu exista variabila!");
                        else if(ids.isConst($3)) yyerror("Nu poti modifica valoarea variabilei!");
                        else if(!ids.existsVar($3)) yyerror("Nu exista variabila!");
                        else if(ids.isPriv($3)) yyerror("Variabila este privata si nu poate fi modificata");
                        else    if(ids.varType($3) != B) yyerror("Ai gresit type-ul: statement");
                        else if(eroare == 0)ids.updateVar($1, $6, $6, $6, $6); 
                        else yyerror("A fost produsa o eroare!");
                        eroare = 0;}
         ;


eI :  eI '+' eI  {$$ = $1 + $3; }
  |  eI '-' eI  {$$ = $1 - $3;}
  |  eI '*' eI  {$$ = $1 * $3;}
  |  eI '/' eI  {$$ = $1 / $3;}
  |  '{' eI '}' {$$ = $2; }
  |  NR {$$ = $1;}
  |  NR_FLOAT {eroare = 1;}
  |  BOOLVAL {eroare = 1;}
  |  NR_CHAR {eroare = 1;}
  |  ID { if(!ids.existsVar($1)) yyerror("Nu exista variabila!"), eroare = 1;
          else if(ids.varType($1) != I) yyerror("Ai gresit type-ul: eI"), eroare = 1;
          else $$ = ids.returnValInt($1);} 
  | ID '[' NR ']' {if(!ids.existsVar($1) || !ids.existsVarArray($1, $3)) yyerror("Nu exista variabila!"), eroare = 1;
                   else if(ids.varType($1) != I) yyerror("Ai gresit type-ul: statement"), eroare = 1;
                   else $$ = ids.returnValIntAr($1, $3);                    
                }
  | ID '(' call_list ')' {if(!ids.existsVarFct($1)) yyerror("Nu exista functia!"), eroare = 1;
                        else if(ids.varType($1) != I) yyerror("Difera tipurile!"), eroare = 1;
                        else if(ids.isPriv($1)) yyerror("Functia este privata si nu poate fi modificata"), eroare = 1;
                        else  if(calltype != ids.paramFct($1))  yyerror("Parametrii functiei sunt gresiti!"), eroare = 1;}
  | ID '(' ')'{if(!ids.existsVarFct($1)) yyerror("Nu exista functia!"), eroare = 1;
                        else if(ids.isPriv($1)) yyerror("Functia este privata si nu poate fi modificata"), eroare = 1;
                        else if(ids.varType($1) != I) yyerror("Difera tipurile!"), eroare = 1;}
  | ID'.'ID {
                        if(!ids.existsVar($1)) yyerror("Nu exista variabila!"), eroare = 1;
                        else if(!ids.existsVar($3)) yyerror("Nu exista variabila!"), eroare = 1;
                        else if(ids.isPriv($3)) yyerror("Variabila este privata si nu poate fi modificata"), eroare = 1;
                        else    if(ids.varType($3) != I) yyerror("Ai gresit type-ul: statement"), eroare = 1;
                        else $$ = ids.returnValBool($3);                    
            }
  ;
   

eF :  eF '+' eF  {$$ = $1 + $3; }
  |  eF '-' eF  {$$ = $1 - $3;}
  |  eF '*' eF  {$$ = $1 * $3;}
  |  eF '/' eF  {$$ = $1 / $3;}
  |  '[' eF ']' {$$ = $2; }
  |  NR_FLOAT {$$ = $1;}
  |  NR {eroare = 1;}
  |  BOOLVAL {eroare = 1;}
  |  NR_CHAR {eroare = 1;}
  |  ID  { if(!ids.existsVar($1)) yyerror("Nu exista variabila!"), eroare = 1;
           else if(ids.varType($1)!= F) yyerror("Ai gresit type-ul: eF"), eroare = 1;
           else $$ = ids.returnValFloat($1);} 
  | ID '[' NR ']' {if(!ids.existsVar($1) || !ids.existsVarArray($1, $3)) yyerror("Nu exista variabila!"), eroare = 1;
                   else if(ids.varType($1) != F) yyerror("Ai gresit type-ul: statement"), eroare = 1;
                   else $$ = ids.returnValFloatAr($1, $3);                    
                }
  | ID '(' call_list ')' {if(!ids.existsVarFct($1)) yyerror("Nu exista functia!"), eroare = 1;
                        else if(ids.isPriv($1)) yyerror("Functia este privata si nu poate fi modificata"), eroare = 1;
                        else if(ids.varType($1) != F) yyerror("Difera tipurile!"), eroare = 1;
                        else  if(calltype != ids.paramFct($1))  yyerror("Parametrii functiei sunt gresiti!"), eroare = 1;}
  | ID '(' ')'{if(!ids.existsVarFct($1)) yyerror("Nu exista functia!"), eroare = 1;
                        else if(ids.isPriv($1)) yyerror("Functia este privata si nu poate fi modificata"), eroare = 1;
                        else if(ids.varType($1) != F) yyerror("Difera tipurile!"), eroare = 1;}
  | ID'.'ID {
                        if(!ids.existsVar($1)) yyerror("Nu exista variabila!"), eroare = 1;
                        else if(!ids.existsVar($3)) yyerror("Nu exista variabila!"), eroare = 1;
                        else if(ids.isPriv($3)) yyerror("Variabila este privata si nu poate fi modificata"), eroare = 1;
                        else    if(ids.varType($3) != F) yyerror("Ai gresit type-ul: statement"), eroare = 1;
                        else $$ = ids.returnValBool($3);                    

            }
  ;

eC : NR_CHAR {$$ = $1;}
  |  NR_FLOAT {eroare = 1;}
  |  BOOLVAL {eroare = 1;}
  |  NR {eroare = 1;}
  |  ID { if(!ids.existsVar($1)) yyerror("Nu exista variabila!"), eroare = 1;
          else if(ids.varType($1) != C) yyerror("Ai gresit type-ul: eC"), eroare = 1;
          else $$ = ids.returnValChar($1);} 
  | ID '[' NR ']' {if(!ids.existsVar($1) || !ids.existsVarArray($1, $3)) yyerror("Nu exista variabila!"), eroare = 1;
                   else if(ids.varType($1) != C && ids.varType($1) != S) yyerror("Ai gresit type-ul: statement"), eroare = 1;
                   else $$ = ids.returnValCharAr($1, $3);                    
                }
  | ID '(' call_list ')' {if(!ids.existsVarFct($1)) yyerror("Nu exista functia!"), eroare = 1;
                        else if(ids.varType($1) != C) yyerror("Difera tipurile!"), eroare = 1;
                        else if(ids.isPriv($1)) yyerror("Functia este privata si nu poate fi modificata"), eroare = 1;
                        else  if(calltype != ids.paramFct($1))  yyerror("Parametrii functiei sunt gresiti!"), eroare = 1;}
  | ID '(' ')'{if(!ids.existsVarFct($1)) yyerror("Nu exista functia!"), eroare = 1;
                        else if(ids.isPriv($1)) yyerror("Functia este privata si nu poate fi modificata"), eroare = 1;
                        else if(ids.varType($1) != C) yyerror("Difera tipurile!"), eroare = 1;}
  | ID'.'ID {
                        if(!ids.existsVar($1)) yyerror("Nu exista variabila!"), eroare = 1;
                        else if(!ids.existsVar($3)) yyerror("Nu exista variabila!"), eroare = 1;
                        else if(ids.isPriv($3)) yyerror("Variabila este privata si nu poate fi modificata"), eroare = 1;
                        else    if(ids.varType($3) != C) yyerror("Ai gresit type-ul: statement"), eroare = 1;
                        else $$ = ids.returnValBool($3);                    

            }
  ;

eB:  NOT eB { $$ = 1 - $2;}
  |eI '<' eI { if( $1 < $3) $$ = 1; else $$ = 0;}
  | eF '<' eF { if( $1 < $3) $$ = 1; else $$ = 0;}
  | eI '>' eI { if( $1 > $3) $$ = 1; else $$ = 0;}
  | eF '>' eF { if( $1 > $3) $$ = 1; else $$ = 0;}
  | eI EQ eI { if( $1 == $3) $$ = 1; else $$ = 0;}
  | eF EQ eF { if( $1 == $3) $$ = 1; else $$ = 0;}
  | eI NEQ eI { if( $1 != $3) $$ = 1; else $$ = 0;}
  | eF NEQ eF { if( $1 != $3) $$ = 1; else $$ = 0;}
  | eI GE eI { if( $1 >= $3) $$ = 1; else $$ = 0;}
  | eF GE eF { if( $1 >= $3) $$ = 1; else $$ = 0;}
  | eI LE eI { if( $1 <= $3) $$ = 1; else $$ = 0;}
  | eF LE eF { if( $1 <= $3) $$ = 1; else $$ = 0;}
  | eB AND eB { if( $1 && $3) $$ = 1; else $$ = 0;}
  | eB OR eB  { if( $1 || $3) $$ = 1; else $$ = 0;}
  | BOOLVAL { if( $1 == Tr) $$ = 1; else $$ = 0;}
  |  NR_FLOAT {eroare = 1;}
  |  NR {eroare = 1;}
  |  NR_CHAR {eroare = 1;}
  | ID { if(!ids.existsVar($1)) yyerror("Nu exista variabila!"), eroare = 1;
         else if(ids.varType($1) != B) yyerror("Ai gresit type-ul: eB"), eroare = 1;
         else $$ = ids.returnValBool($1);
        }
  | ID '[' NR ']' {if(!ids.existsVar($1) || !ids.existsVarArray($1, $3)) yyerror("Nu exista variabila!"), eroare = 1;
                   else if(ids.varType($1) != B) yyerror("Ai gresit type-ul: statement"), eroare = 1;
                   else $$ = ids.returnValBoolAr($1, $3);                    
                }
  |  '(' eB ')' {$$ = $2; }
  | ID '(' call_list ')' {if(!ids.existsVarFct($1)) yyerror("Nu exista functia!"), eroare = 1;
                        else if(ids.varType($1) != B) yyerror("Difera tipurile!"), eroare = 1;
                        else if(ids.isPriv($1)) yyerror("Functia este privata si nu poate fi modificata"), eroare = 1;
                        else  if(calltype != ids.paramFct($1))  yyerror("Parametrii functiei sunt gresiti!"), eroare = 1;}
  | ID '(' ')'{if(!ids.existsVarFct($1)) yyerror("Nu exista functia!"), eroare = 1;
                        else if(ids.isPriv($1)) yyerror("Functia este privata si nu poate fi modificata"), eroare = 1;
                        else if(ids.varType($1) != B) yyerror("Difera tipurile!"), eroare = 1;}
  | ID'.'ID {
                        if(!ids.existsVar($1)) yyerror("Nu exista variabila!"), eroare = 1;
                        else if(!ids.existsVar($3)) yyerror("Nu exista variabila!"), eroare = 1;
                        else if(ids.isPriv($3)) yyerror("Variabila este privata si nu poate fi modificata"), eroare = 1;
                        else    if(ids.varType($3) != B) yyerror("Ai gresit type-ul: statement"), eroare = 1;
                        else $$ = ids.returnValBool($3);                    

            }
  ; 
     
call_list : NR {calltype = calltype + "i";}
           | NR_FLOAT {calltype = calltype + "f";}
           | NR_CHAR {calltype = calltype + "c";}
           | BOOLVAL {calltype = calltype + "b";}
           | ID { if(ids.varType($1) == "int")  calltype = calltype + "i";
                  else if(ids.varType($1) == "float")  calltype = calltype + "f";
                  else if(ids.varType($1) == "bool")  calltype = calltype + "b";
                  else if(ids.varType($1) == "char")  calltype = calltype + "c";
                }
           | call_list ',' NR {calltype = calltype + "i";}
           | call_list ',' NR_FLOAT {calltype = calltype + "f";}
           | call_list ',' NR_CHAR {calltype = calltype + "c";}
           | call_list ',' BOOLVAL{calltype = calltype + "b";}
           | call_list ',' ID{ if(ids.varType($3) == "int")  calltype = calltype + "i";
                  else if(ids.varType($3) == "float")  calltype = calltype + "f";
                  else if(ids.varType($3) == "bool")  calltype = calltype + "b";
                  else if(ids.varType($3) == "char")  calltype = calltype + "c";
                }
           ;

clase : 
      | clasa ';'
      | clase clasa ';'
      ;

clasa: CLASA NUME2 '{' corpclasa '}' {
            if(ids.existsVar($2)) yyerror("Exista deja un id cu numele acesta!");
             else {// nu exista numele clase
                ids.addVarClasa($2);
            } 
        }
      ;

corpclasa: PUBLIC ':' declarations functii PRIVAT {privat = 1;} ':' declarations functii {privat = 0;};

functii: 
       | functie ';'
       | functii functie ';'
       ;

functie: | FUNCTIE TYPE NUME '(' list_param ')'  '{' blockF RETUR cv ';' '}' {
                        if(ids.existsVar($3)) yyerror("Exista deja un id cu numele acesta!");
                        else if(returntype != $2) yyerror("Tipul returnat de functie este gresit!");
                        else ids.addVarFunc($2, $3, calltype.size(), calltype, locatie2); 
                        calltype = ""; returntype = ""; locatie = "";
                        if(privat == 1) ids.addVarPriv($3);
                    }
         | FUNCTIE VOID NUME '(' list_param ')'  '{' blockF '}' {
                        if(ids.existsVar($3)) yyerror("Exista deja un id cu numele acesta!");
                        else ids.addVarFunc($2, $3, calltype.size(), calltype, locatie2); 
                        calltype = ""; returntype = ""; locatie = "";
                        if(privat == 1) ids.addVarPriv($3);
                    }
         | FUNCTIE TYPE NUME '(' ')'  '{' blockF RETUR cv ';' '}' {
                        if(ids.existsVar($3)) yyerror("Exista deja un id cu numele acesta!");
                        else if(returntype != $2) yyerror("Tipul returnat de functie este gresit!");
                        else ids.addVarFunc($2, $3, calltype.size(), calltype, locatie2); 
                        calltype = ""; returntype = ""; locatie = "";
                        if(privat == 1) ids.addVarPriv($3);
                    }
         | FUNCTIE VOID NUME '(' ')'  '{' blockF '}' {
                        if(ids.existsVar($3)) yyerror("Exista deja un id cu numele acesta!");
                        else ids.addVarFunc($2, $3, calltype.size(), calltype, locatie2); 
                        calltype = ""; returntype = ""; locatie = "";
                        if(privat == 1) ids.addVarPriv($3);
                    }
;

NUME: ID { locatie = $1; };
NUME2: ID { locatie2 = locatie = $1; };


cv:   NR {returntype = "int";}
    | NR_FLOAT {returntype = "float";}
    | BOOLVAL {returntype = "bool";}
    | ID {returntype = ids.varType($1);}
    | NR_CHAR {returntype = "char";}
    ;


 
%%
void yyerror(const char * s){
printf("error: %s at line:%d\n",s,yylineno);
}

int main(int argc, char** argv){
     yyin=fopen(argv[1],"r");
     yyparse();
     //cout << "Variables:" <<endl;
    //ids.printPriv();
    // ids.printVars();
   //  ids.printVarsArray();
     ids.clear_tablevar();
     ids.tabel_var ();
     ids.clear_tablefct();
     ids.tabel_fct ();
} 
