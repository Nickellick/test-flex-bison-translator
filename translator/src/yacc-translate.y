%{
#include <stdio.h>
#include <string.h>
#ifndef YYSTYPE
#define YYSTYPE char*
#endif //YYSTYPE
extern YYSTYPE yylval;
extern FILE* yyin;

void yyerror(const char *str);
int yywrap(void);
%}


%token CONSTANT KEY_VAR KEY_BEGIN KEY_END KEY_BOOLEAN IDENTIFIER BINARY_OPERATOR_AND BINARY_OPERATOR_OR BINARY_OPERATOR_XOR UNARY_OPERATOR_NOT POINT COMMA SIGN OPBRACKET CBRACKET COLON SEMICOLON
%% 
PROGRAM: 
	VARS OPS
;

VARS: 
	VAR
    {
        printf("%s", $1);
    }
	|VARS VAR
    {
        printf("%s", $2);
    }
;

VAR: 
	KEY_VAR IDS COLON KEY_BOOLEAN SEMICOLON
    {
        $$ = strcat($1, " ");
        $$ = strcat($$, $2);
        $$ = strcat($$, $3);
        $$ = strcat($$, " ");
        $$ = strcat($$, "Logical");
        $$ = strcat($$, $5);
        $$ = strcat($$, "\n");
    }
;

IDS: 
	IDENTIFIER
    {
        $$ = $1;
    }
	|IDS COMMA IDENTIFIER
    {
        $$ = strcat($$, ", ");
        $$ = strcat($$, $3);
    }
;

OPS: 
	KEY_BEGIN LISTASSIGMENTS KEY_END
    {
        printf("%s\n%s%s\n", $1, $2, $3);
    }
;

LISTASSIGMENTS:
	ASSIGMENT
    {
        $$ = strcat($1, ";\n");
    }
	|LISTASSIGMENTS ASSIGMENT 
    {
        $$ = strcat($1, $2);
        $$ = strcat($$, ";\n");
    }
;

ASSIGMENT:
	IDENTIFIER SIGN EXPRESSION
    {
        $$ = strcat($1, " := ");
        $$ = strcat($$, $3);
    }
;

EXPRESSION:
	UNARY_OPERATOR_NOT SUB
    {
        $$ = strcpy($$, "");
        $$ = strcat($$, "!");
        $$ = strcat($$, $2);
    }
	|SUB
    {
        $$ = $1;
    }
;

SUB:	
	OPBRACKET EXPRESSION CBRACKET
    {
        $$ = strcat($1, $2);
        $$ = strcat($$, $3);
    }
	|OPERAND
    {
        $$ = $1;
    }
	|SUB BINARY_OPERATOR_AND SUB
    {
        $$ = strcat($1, " & ");
        $$ = strcat($$, $3);
    }
	|SUB BINARY_OPERATOR_OR SUB
    {
        $$ = strcat($1, " | ");
        $$ = strcat($$, $3);
    }
	|SUB BINARY_OPERATOR_XOR SUB
    {
        $$ = strcat($1, " ^ ");
        $$ = strcat($$, $3);
    }
;

OPERAND:
	IDENTIFIER
    {
        $$ = $1;
    }
    |CONSTANT
    {
        $$ = $1;
    }
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
	if (argc == 1) {
		printf("Wrong file path\n");
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





