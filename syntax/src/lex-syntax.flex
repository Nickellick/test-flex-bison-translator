%{
#include <stdio.h>
#include "y.tab.h"
%}

%%
["0"|"1"]+ 					        return CONSTANT;
("Var")                             return KEY_VAR;
("Begin")                           return KEY_BEGIN;
("End")                             return KEY_END;
("Boolean")                         return KEY_BOOLEAN;
([a-zA-Z])+                         return IDENTIFIER;
(".AND.")                           return BINARY_OPERATOR_AND;
(".OR.")                            return BINARY_OPERATOR_OR;
(".XOR.")                           return BINARY_OPERATOR_XOR;
(".NOT.")                           return UNARY_OPERATOR;
(\.){1}                             return POINT;
(\,){1}                             return COMMA;
(\=){1}                             return SIGN;
(\(){1}                             return OPBRACKET;
(\)){1}                             return CBRACKET;
(\:){1}                             return COLON;
(\;){1}                             return SEMICOLON;
\n;
[ \t]+;
%%