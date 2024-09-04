%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
%}

%option noyywrap

%%

^[ \t]*([a-zA-Z_][a-zA-Z_0-9]*)[ \t]*=[ \t]*lambda[ \t]*\([a-zA-Z_][a-zA-Z_0-9]*\)[ \t]*:[ \t]*[a-zA-Z_][a-zA-Z_0-9]*[ \t]*\*\*[ \t]*2[ \t]*$ {
    // Correct lambda expression
    printf("ACEPTA\n");
}

.|\n {
    // Any line that does not match the lambda expression format is not accepted
    printf("NO ACEPTA\n");
}

%%

int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
        exit(1);
    }

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        perror("fopen");
        exit(1);
    }

    yyin = file;
    yylex();
    fclose(file);
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

