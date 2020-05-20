%{
#include <stdio.h>
#include <string.h>
#ifndef YYSTYPE
#define YYSTYPE char*
#endif //YYSTYPE
// extern YYSTYPE yylval;
extern FILE* yyin;

%}


%token CONSTANT KEY_VAR KEY_BEGIN KEY_END KEY_BOOLEAN IDENTIFIER BINARY_OPERATOR_AND BINARY_OPERATOR_OR BINARY_OPERATOR_XOR UNARY_OPERATOR POINT COMMA SIGN OPBRACKET CBRACKET COLON SEMICOLON 
%%
PROGRAM: 
	VARS OPS
;

VARS: 
	VAR
	|VARS VAR
;

VAR: 
	KEY_VAR IDS COLON KEY_BOOLEAN SEMICOLON
;

IDS: 
	IDENTIFIER
	|IDENTIFIER COMMA IDS
;

OPS: 
	KEY_BEGIN LISTASSIGMENTS KEY_END
;

LISTASSIGMENTS:
	ASSIGMENT
	|ASSIGMENT LISTASSIGMENTS
;

ASSIGMENT:
	IDENTIFIER SIGN EXPRESSION
;

EXPRESSION:
	UNARY_OPERATOR SUB
	|SUB
;

SUB:	
	OPBRACKET EXPRESSION CBRACKET
	|OPERAND
	|SUB BINARY_OPERATOR_AND SUB
	|SUB BINARY_OPERATOR_OR SUB
	|SUB BINARY_OPERATOR_XOR SUB
;

OPERAND:
	IDENTIFIER | CONSTANT
;

%%

void yyerror (const char *str)
{
	fprintf(stderr,"error: %s\n",str);
}

int yywrap() {
	return 1;
}

int main(int argc, char* argv[])
{	
	if (argc != 2) {
		printf("File path not passed\n");
		return 1;
	}

	yyin = fopen(argv[1],"r");
	if (yyin == NULL) {
        printf("Can't read the file\n");
		return 1;
    }
	yyparse();
	fclose(yyin);
	return 0; 
}





