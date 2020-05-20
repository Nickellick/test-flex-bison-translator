%{
#include <stdio.h>
#ifndef YYSTYPE
#define YYSTYPE char*
#endif //YYSTYPE
extern FILE* yyin; 

int yylex(void);
%}

%%
["0"|"1"]+ 					        printf("Константа ");
("Var"|"Begin"|"End"|"Boolean") 	printf("Ключевое_слово ");	
([a-zA-Z])+		 		            printf("Идентификатор ");
(".AND."|".OR."|".XOR."){1}         printf("Операция ");
(\=){1} 				            printf("Операция_присваивания ");
(\(|\)|\,|\.){1} 			        printf("Разделительный_символ ");
\n					                printf("\n");
[ \t]+					            printf("\t");
%%

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

	yylex();
	fclose(yyin);
	return 0; 
}