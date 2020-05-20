all:
	yacc -d yacc-syntax.y && lex lex-syntax.flex && gcc lex.yy.c y.tab.c -lfl -g -o ../check-syntax