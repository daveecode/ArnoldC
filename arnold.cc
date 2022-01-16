#include <iostream>
#include <fstream>
#include <string>
#include <FlexLexer.h>
#include <cstdlib>

using namespace std;

int main( int argc, char* argv[] )
{
    ifstream in;
    in.open(argv[1]);
    yyFlexLexer fl(&in, &cout);
    fl.yylex();
    return 0;
}