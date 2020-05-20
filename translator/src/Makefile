all:
	yacc -d yacc-translate.y && lex lex-translate.flex && gcc lex.yy.c y.tab.c -lfl -g -o ../translate