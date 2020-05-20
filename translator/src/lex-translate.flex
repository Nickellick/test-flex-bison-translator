%{
#include <stdio.h>
#ifndef YYSTYPE
#define YYSTYPE char*
#endif //YYSTYPE
#include "y.tab.h"
extern YYSTYPE yylval;
%}

%%
["0"|"1"]+ 					        yylval = strdup(yytext); return CONSTANT;
("Var")                             yylval = strdup(yytext); return KEY_VAR;
("Begin")                           yylval = strdup(yytext); return KEY_BEGIN;
("End")                             yylval = strdup(yytext); return KEY_END;
("Boolean")                         yylval = strdup(yytext); return KEY_BOOLEAN;
([a-zA-Z])+                         yylval = strdup(yytext); return IDENTIFIER;
(".AND.")                           yylval = strdup(yytext); return BINARY_OPERATOR_AND;
(".OR.")                            yylval = strdup(yytext); return BINARY_OPERATOR_OR;
(".XOR.")                           yylval = strdup(yytext); return BINARY_OPERATOR_XOR;
(".NOT.")                           yylval = strdup(yytext); return UNARY_OPERATOR_NOT;
(\.){1}                             yylval = strdup(yytext); return POINT;
(\,){1}                             yylval = strdup(yytext); return COMMA;
(\=){1}                             yylval = strdup(yytext); return SIGN;
(\(){1}                             yylval = strdup(yytext); return OPBRACKET;
(\)){1}                             yylval = strdup(yytext); return CBRACKET;
(\:){1}                             yylval = strdup(yytext); return COLON;
(\;){1}                             yylval = strdup(yytext); return SEMICOLON;
\n
[ \t]+;
%%