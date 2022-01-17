#include <iostream>
#include <fstream>
#include <cstdlib>
#include <list>
#include "FlexLexer.h"
#include "implementation.hh"
#include "arnold.tab.hh"

yyFlexLexer *lexer;

int yylex(yy::parser::semantic_type* yylval, yy::parser::location_type* yylloc) {
    yylloc->begin.line = lexer->lineno();
    int token = lexer->yylex();
    if(token == yy::parser::token::VAR || token == yy::parser::token::NUM) {
        yylval->build(std::string(lexer->YYText()));
    }
    return token;
}

void yy::parser::error(const location_type& loc, const std::string& msg) {
    std::cerr << "Line " << loc.begin.line << ": " << msg << std::endl;
    exit(1);
}

int main( int argc, char* argv[] )
{
    std::ifstream input(argv[1]);
    lexer = new yyFlexLexer(&input);
    yy::parser parser;
    parser.parse();
    delete lexer;
    return 0;
}