flex nohel.l
bison -d nohel.y
gcc lex.yy.c nohel.tab.c -o app
app