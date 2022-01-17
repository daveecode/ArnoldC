%option c++ noyywrap yylineno

%{
#include <iostream>
#include <cstdlib>
#include <list>
#include "implementation.hh"
#include "arnold.tab.hh"

using namespace yy;
%}

WS [ \t\n]
COMMENT [--][^\n]*
VARIABLE [a-zA-Z_][a-zA-Z0-9_]*
STRING_LITERAL ["][ \t\n():+*/%<>=_#-?!.'a-zA-Z0-9]*["]
NUMBER_LITERAL [0-9]+

%%

"IT'S SHOWTIME"                 return parser::token::START;
"YOU HAVE BEEN TERMINATED"      return parser::token::END;
"TALK TO THE HAND"              return parser::token::PRINT;
"I WANT TO ASK YOU A BUNCH OF QUESTIONS AND I WANT TO HAVE THEM ANSWERED IMMEDIATELY"   return parser::token::IN;
"HEY CHRISTMAS TREE"   return parser::token::DECLARE;
"YOU SET US UP"   return parser::token::DEFAULT;
"@I LIED"    return parser::token::TRUE;
"@NO PROBLEMO"   return parser::token::FALSE;
"GET TO THE CHOPPER"   return parser::token::ASSIGN;
"HERE IS MY INVITATION"  return parser::token::OP;
"ENOUGH TALK"    return parser::token::ASSIGN_END;
"GET UP"    return parser::token::PLUS;
"GET DOWN"    return parser::token::MINUS;
"YOU'RE FIRED"  return parser::token::MUL;
"HE HAD TO SPLIT"   return parser::token::DIV;
"I LET HIM GO"   return parser::token::MOD;
"YOU ARE NOT YOU YOU ARE ME"   return parser::token::EQUAL;
"LET OFF SOME STEAM BENNET"    return parser::token::GREATER;
"CONSIDER THAT A DIVORCE"     return parser::token::OR;
"KNOCK KNOCK"    return parser::token::AND;
"BECAUSE I'M GOING TO SAY PLEASE"    return parser::token::IF;
"BULLSHIT"   return parser::token::ELSE;
"YOU HAVE NO RESPECT FOR LOGIC"   return parser::token::ENDIF;
"STICK AROUND"   return parser::token::WHILE;
"CHILL"   return parser::token::DONE;
"LISTEN TO ME VERY CAREFULLY"   return parser::token::FUNC;
"HASTA LA VISTA, BABY"   return parser::token::FUNC_END;
"I NEED YOUR CLOTHES YOUR BOOTS AND YOUR MOTORCYCLE"   return parser::token::ARG;
"GIVE THESE PEOPLE AIR"   return parser::token::NON_VOID;
"I'LL BE BACK"   return parser::token::RETURN;
"DO IT NOW"   return parser::token::CALL;
"GET YOUR ASS TO MARS"   return parser::token::CALL_TO_VAR;
"WHAT THE FUCK DID I DO WRONG"   return parser::token::ERROR;
{WS}    //skipped
{COMMENT} //skipped
{NUMBER_LITERAL}    return parser::token::NUM;
{STRING_LITERAL}    return parser::token::STRING;
{VARIABLE}   return parser::token::VAR;
.       {
            std::cerr << lineno() << ": Lexikalis hiba." << YYText() << std::endl;
            exit(1);
        }

%%